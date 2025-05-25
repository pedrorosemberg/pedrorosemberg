import os
import re
from github import Github

# --- Configurações ---
GITHUB_USERNAME = "pedrorosemberg"
README_PATH = "README.md"

# --- Mapeamento de Linguagens para Badges (apenas para exemplo, pode expandir) ---
# Você pode encontrar mais aqui: https://shields.io/badges
LANGUAGE_BADGES = {
    'JavaScript': {'logo': 'javascript', 'color': 'F7DF1E'},
    'Python': {'logo': 'python', 'color': '3776AB'},
    'HTML': {'logo': 'html5', 'color': 'E34F26'},
    'CSS': {'logo': 'css3', 'color': '1572B6'},
    'TypeScript': {'logo': 'typescript', 'color': '3178C6'},
    'Java': {'logo': 'java', 'color': '007396'},
    'C#': {'logo': 'csharp', 'color': '239120'},
    'PHP': {'logo': 'php', 'color': '777BB4'},
    'Shell': {'logo': 'gnubash', 'color': '121011'},
    'Go': {'logo': 'go', 'color': '00ADD8'},
    'Ruby': {'logo': 'ruby', 'color': 'CC342D'},
    'C++': {'logo': 'cplusplus', 'color': '00599C'},
    'C': {'logo': 'c', 'color': 'A8B9CC'},
    'Vue': {'logo': 'vuedotjs', 'color': '4FC08D'},
    'React': {'logo': 'react', 'color': '61DAFB'},
    'Node.js': {'logo': 'nodedotjs', 'color': '339933'},
    'Docker': {'logo': 'docker', 'color': '2496ED'},
    'Git': {'logo': 'git', 'color': 'F05032'},
    'Markdown': {'logo': 'markdown', 'color': '000000'},
    'Jupyter Notebook': {'logo': 'jupyter', 'color': 'F37626'},
    # Adicione mais conforme necessário
}

def get_badge_url(language_name):
    """Retorna a URL do badge para uma dada linguagem."""
    info = LANGUAGE_BADGES.get(language_name)
    if info:
        return f"https://img.shields.io/badge/{language_name}-{info['color']}?style=for-the-badge&logo={info['logo']}&logoColor=white"
    return f"https://img.shields.io/badge/{language_name}-gray?style=for-the-badge" # Fallback para linguagens não mapeadas


# --- Funções de Coleta de Dados ---
def get_github_data(github_token):
    """Inicializa o cliente GitHub e retorna o objeto de usuário."""
    try:
        g = Github(github_token)
        return g.get_user(GITHUB_USERNAME)
    except Exception as e:
        print(f"Erro ao conectar ao GitHub ou obter usuário: {e}")
        exit(1)

def get_top_languages(user_obj, num_languages=8):
    """Coleta e ordena as linguagens mais usadas nos repositórios públicos."""
    languages = {}
    for repo in user_obj.get_repos():
        if not repo.fork and not repo.private:
            try:
                repo_languages = repo.get_languages()
                for lang, bytes_count in repo_languages.items():
                    languages[lang] = languages.get(lang, 0) + bytes_count
            except Exception as e:
                print(f"Aviso: Não foi possível obter linguagens para {repo.name}: {e}")

    sorted_languages = sorted(languages.items(), key=lambda item: item[1], reverse=True)
    return [lang for lang, _ in sorted_languages[:num_languages]]

def get_featured_projects(user_obj, num_projects=5):
    """Coleta os projetos de destaque (não-forks, públicos, ordenados por estrelas)."""
    projects = []
    for repo in user_obj.get_repos():
        if not repo.fork and not repo.private:
            projects.append(repo)

    sorted_projects = sorted(projects, key=lambda repo: repo.stargazers_count, reverse=True)
    return sorted_projects[:num_projects]

# --- Funções de Geração de Markdown ---
def generate_tech_stack_markdown(languages):
    """Gera o Markdown para a seção de tecnologias."""
    if not languages:
        return "Nenhuma linguagem principal encontrada ou repositórios públicos."

    markdown_content = "### Linguagens de Programação\n"
    for lang in languages:
        markdown_content += f"- ![Badge {lang}]({get_badge_url(lang)})\n"
    return markdown_content

def generate_featured_projects_markdown(projects):
    """Gera o Markdown para a seção de projetos de destaque."""
    if not projects:
        return "Nenhum projeto de destaque encontrado."

    markdown_content = ""
    for project in projects:
        markdown_content += f"### [{project.name}]({project.html_url})\n"
        # Badge de linguagem específica para o projeto
        project_lang_badge = f"[![Linguagem](https://img.shields.io/github/languages/top/{GITHUB_USERNAME}/{project.name}?style=flat-square)]({project.html_url})"
        # Badge de estrelas
        stars_badge = f"[![Estrelas](https://img.shields.io/github/stars/{GITHUB_USERNAME}/{project.name}?style=flat-square)]({project.html_url})"
        markdown_content += f"{project_lang_badge} {stars_badge}\n"
        markdown_content += f"_{project.description if project.description else 'Sem descrição.'}_\n\n"
    return markdown_content

# --- Função Principal de Atualização ---
def update_readme():
    """Lê o README.md, atualiza as seções dinâmicas e escreve o arquivo de volta."""
    github_token = os.environ.get("GITHUB_TOKEN")
    if not github_token:
        print("Erro: Variável de ambiente GITHUB_TOKEN não encontrada. Este script precisa de um token para acessar a API do GitHub.")
        print("Em GitHub Actions, o token é 'secrets.GITHUB_TOKEN'.")
        exit(1)

    user_obj = get_github_data(github_token)

    with open(README_PATH, "r", encoding="utf-8") as f:
        readme_content = f.read()

    # Atualiza a seção de tecnologias
    print("Atualizando seção de tecnologias...")
    top_languages = get_top_languages(user_obj)
    tech_stack_markdown = generate_tech_stack_markdown(top_languages)
    readme_content = re.sub(
        r"()(.*?)()",
        f"\\1\n{tech_stack_markdown}\n\\3", # \\1 e \\3 referem-se aos grupos capturados dos marcadores
        readme_content,
        flags=re.DOTALL
    )

    # Atualiza a seção de projetos de destaque
    print("Atualizando seção de projetos de destaque...")
    featured_projects = get_featured_projects(user_obj)
    featured_projects_markdown = generate_featured_projects_markdown(featured_projects)
    readme_content = re.sub(
        r"()(.*?)()",
        f"\\1\n{featured_projects_markdown}\\3",
        readme_content,
        flags=re.DOTALL
    )

    with open(README_PATH, "w", encoding="utf-8") as f:
        f.write(readme_content)
    print("README.md atualizado com sucesso!")

if __name__ == "__main__":
    update_readme()
