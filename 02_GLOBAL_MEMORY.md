# 02 — Global Memory

**Purpose**: Store cross-project knowledge, reusable engineering standards, and shared conventions that every project in the workspace inherits.

---

**Table of Contents**
- Concept
- What Belongs in Global Memory
- What NOT to Store
- Memory Updating Strategy
- Writing Guidelines
- Structure
- Examples
- FAQ
- Summary

---

## Concept

Global Memory is the persistent knowledge layer shared across all projects in a workspace. It contains the standards, conventions, and reusable knowledge that every project should follow — without each project having to duplicate it.

Global Memory is the "standard library" of your workspace. It prevents fragmentation: without it, each project would independently evolve its own lint rules, naming conventions, and engineering standards. With it, every project inherits a consistent baseline.

## What Belongs in Global Memory

### Reusable Knowledge

- Language/framework conventions (TypeScript, Python, Go, etc.)
- Design patterns the team uses consistently
- Architecture decision records that apply workspace-wide
- Dependency management conventions

### Engineering Standards

- Linting and formatting configuration standards
- Testing conventions (framework choice, coverage expectations)
- CI/CD pipeline structure
- Code review checklist
- Documentation expectations

### Coding Standards

- Naming conventions (camelCase, snake_case, PascalCase)
- File organization patterns
- Error handling strategy
- Logging standards
- API design conventions

### Cross-project Dependencies

- Shared library usage guidelines
- Internal package registry conventions
- Version pinning strategy

## What NOT to Store

| Category | Example | Where it belongs |
|----------|---------|-----------------|
| Project-specific architecture | "The user service uses PostgreSQL" | PROJECT_MEMORY.md |
| Decisions unique to one project | "We chose Next.js over Remix" | DECISION_LOG.md |
| Ephemeral session state | "Currently working on auth flow" | HANDOFF.md |
| Personal preferences | "I prefer tabs over spaces" | Nowhere — refer to lint tool |
| Tool configuration | ESLint config, tsconfig, .env | Configuration files |

## Memory Updating Strategy

Global memory is updated intentionally, not incrementally. Every update follows this process:

\\\mermaid
flowchart LR
    A[Identify gap] --> B[Does it apply to all projects?]
    B -->|Yes| C[Write to Global Memory]
    B -->|No| D[Write to Project Memory]
    C --> E[Update reading order if needed]
    D --> E
\\\

### When to Update

- A new standard is adopted workspace-wide
- A recurring problem has a proven solution
- A convention is documented for the third time in separate projects

### When NOT to Update

- A single project makes a unique choice
- The knowledge is temporary
- The standard is still being evaluated

## Writing Guidelines

1. **Be prescriptive** — state the rule, then explain the rationale
2. **Include examples** — show correct and incorrect patterns
3. **Avoid ambiguity** — "Use tabs for indentation" is clear; "Prefer readable code" is not
4. **Reference tools** — "See .eslintrc.js for the exact configuration"
5. **Version with changelog** — note when a standard is added or changed

## Structure

\\\markdown
# Global Memory

## Language Standards

### TypeScript
- Use strict mode. No exceptions.
- Prefer interfaces over types for public APIs.
- Use explicit return types on function declarations.

### Python
- Follow PEP 8. Use Black at 88 characters.
- Type hints required on all public functions.
- Prefer dataclasses over plain dictionaries for structured data.

## Engineering Standards

### Testing
- Jest for TypeScript, pytest for Python.
- Every public function must have a unit test.
- Integration tests for database and API layers.

### Code Review
- Every PR requires at least one approval.
- No PR may merge with failing tests.
- Review for correctness first, style second.

## Tooling Standards

### Formatting
- Prettier for all frontend code.
- Black for Python.
- EditorConfig at workspace root.

### Linting
- ESLint with recommended ruleset.
- pylint for Python.

## Cross-Project Knowledge

### Auth Pattern
All services use JWT-based auth with a shared auth library.
See auth-lib/README.md for usage.

### Logging
Use structured JSON logging. Log level: INFO in production, DEBUG in development.
\\\

## Examples

### Accepted Global Memory Entry

\\\markdown
### Error Handling
All services must return structured error responses:

\\\json
{
  "error": {
    "code": "INVALID_INPUT",
    "message": "User-friendly description",
    "details": {}
  }
}
\\\

Rationale: Structured errors enable consistent client-side error handling without parsing error messages.
\\\

### Rejected Global Memory Entry (project-specific)

\\\markdown
### Database
The analytics service uses MongoDB.
\\\

Why: This belongs in \Project_XX_analytics/PROJECT_MEMORY.md\. Other projects do not use MongoDB.

## FAQ

**Q: How is Global Memory different from a style guide?**  
A style guide is a subset of Global Memory. Global Memory also includes reusable knowledge, cross-project dependencies, and engineering standards beyond style.

**Q: Can a project override Global Memory?**  
Yes — but the override must be documented in the project's PROJECT_MEMORY.md with a rationale explaining why the project deviates.

**Q: How often should Global Memory be reviewed?**  
Review every quarter, or when a new project exposes a gap in the existing standards.

**Q: Should Global Memory be version controlled?**  
Yes. Agree on the changes, commit them, and communicate the update to the team.

## Summary

Global Memory stores cross-project standards and reusable knowledge. It is the baseline every project inherits. Update it intentionally, store only workspace-wide knowledge, and reference it from the Workspace Manifest. Project-specific content goes in PROJECT_MEMORY.
