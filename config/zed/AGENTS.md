# Git Commit Instructions

When generating git commit messages, always strictly follow the Conventional Commits specification:
- Format: `<type>(<scope>): <short summary>` or `<type>: <short summary>`
- Allowed types: feat, fix, refactor, docs, style, chore, test, perf
- Use lowercase for type and scope.
- Use imperative present tense in English (e.g., "add user auth" instead of "added user auth").
- Do not wrap the message in quotes, backticks, or markdown blocks.
- Return ONLY the commit message string without any explanation or extra text.
