# 03 — Engineering Principles

**Purpose**: Define the engineering philosophy that governs every decision made by the AI agent and the developer.

---

**Table of Contents**
- Concept
- Principles
- Anti-patterns
- Resolving Conflicts Between Principles
- Examples
- FAQ
- Summary

---

## Concept

Engineering Principles are the non-negotiable values that guide every technical decision. They are the compass that resolves ambiguity: when the AI faces a choice between two valid approaches, the principles determine which one to choose.

These principles are not aspirational — they are binding. Every code review, every architecture decision, every trade-off conversation is measured against them.

## Principles

### 1. Single Source of Truth (SSOT)

Every piece of knowledge has exactly one authoritative location.

- Project metadata lives in PROJECT_MANIFEST.md, not in comments or README
- Architecture decisions live in DECISION_LOG.md, not in commit messages or Slack
- Configuration lives in configuration files, not in documentation
- The same value is never duplicated across files

**Why**: Duplication creates drift. When truth is scattered, the AI cannot trust any single source.

### 2. DRY (Don't Repeat Yourself)

Every behavior, pattern, or convention is defined exactly once.

- Extract repeated logic into shared utilities
- Define conventions in Global Memory, not per-project
- Use the template system for project scaffolding

**Why**: Repetition increases maintenance surface area and creates inconsistency.

### 3. KISS (Keep It Simple, Stupid)

Simple solutions are preferred over clever ones.

- Fewer abstractions are better than more
- Flat structures are preferred over nested ones
- Direct solutions are preferred over generic frameworks

**Why**: AI agents reason more reliably over simple code. Complexity hides bugs.

### 4. Convention over Configuration

Standard approaches are chosen over ad-hoc decisions.

- Use the project template structure as-is before customizing
- Follow Global Memory conventions before inventing new ones
- Use the standard reading order before rearranging

**Why**: Conventions eliminate decision fatigue and make behavior predictable across sessions.

### 5. Explicit Decisions

Every non-trivial decision is recorded with rationale, alternatives, and trade-offs.

- If a choice has more than one valid option, it goes in DECISION_LOG.md
- If a decision has a significant trade-off, it goes in DECISION_LOG.md
- If a decision reverses a previous decision, it goes in DECISION_LOG.md

**Why**: Undocumented decisions become technical debt. The next AI session cannot recover the reasoning behind a choice.

### 6. Small Modules

Systems are composed of small, independently understandable modules.

- Each file has a single responsibility
- Each module has a clear boundary
- Cross-module dependencies are explicit

**Why**: Small modules fit in the AI's context window. Large modules exceed it.

### 7. Composable Systems

Systems are built by composing independent parts, not by monoliths.

- Prefer plug-in architectures over switch statements
- Prefer middleware patterns over deeply nested conditionals
- Prefer pipelines over monolithic functions

**Why**: Composable systems let the AI understand and modify individual pieces without understanding the whole.

### 8. Minimal Context

Only the context needed for the current task is loaded.

- Read Priority 1-2 documents by default; load Priority 3-4 on demand
- Exclude generated directories from the workspace view
- Compress or summarize verbose memory documents when the context window is tight

**Why**: Every token in the context window has an opportunity cost. Irrelevant context reduces the AI's effective capacity.

### 9. Deterministic Workflow

Given the same workspace state, the AI produces the same output.

- Reading order is fixed and documented
- Decision criteria are explicit
- Session recovery is scripted

**Why**: Non-deterministic workflows produce unpredictable results. Debugging is impossible when the process changes every time.

## Anti-patterns

| Anti-pattern | Principle violated | Why it fails |
|-------------|-------------------|-------------|
| Storing the same config in README and a config file | SSOT | They will diverge |
| Writing a generic "utility" that handles everything | KISS | Harder to understand and modify |
| Building a monorepo without project isolation | Small Modules | The AI cannot focus on one thing |
| Making architectural decisions in Slack | Explicit Decisions | Lost forever |
| Reading every file before starting work | Minimal Context | Context budget exhausted |
| Writing "we recommend" without explaining why | Deterministic Workflow | The next AI cannot replicate the judgment |

## Resolving Conflicts Between Principles

When principles conflict, use this priority order:

1. SSOT
2. Explicit Decisions
3. Deterministic Workflow
4. Minimal Context
5. KISS
6. Small Modules
7. Composable Systems
8. Convention over Configuration
9. DRY

**Example**: DRY says extract a shared utility. KISS says keep it inline. SSOT decides: if the logic is duplicated three times, extract it. Otherwise, keep it inline.

## Examples

### Applied: SSOT + Explicit Decisions

\\\
Scenario: Choosing a database for a new service.

Bad approach:
- Developer picks PostgreSQL
- Mentions it in a PR comment
- No record of alternatives considered

Good approach:
- Developer logs in DECISION_LOG.md:
  - Chosen: PostgreSQL
  - Alternatives: SQLite (not suitable for concurrent writes), MongoDB (team unfamiliar)
  - Trade-off: PostgreSQL requires schema migrations; the team has established tooling
  - Decision date: 2026-06-15
\\\

### Applied: Minimal Context + Deterministic Workflow

\\\
Scenario: Starting a new session to fix a bug.

Bad approach:
- AI reads the entire source tree
- Discovers unrelated features
- Context window fills with irrelevant information
- Bug fix takes 3x longer

Good approach:
- AI reads: manifest, project memory, handoff
- Reads only the module containing the bug
- Fixes the bug
- Writes: handoff, next session notes
\\\

## FAQ

**Q: Which principle is most important?**  
SSOT. Without a single source of truth, all other principles degrade. Every duplicated fact will eventually diverge.

**Q: Can I skip Explicit Decisions for trivial changes?**  
Yes. Use judgment: renaming a variable does not need a decision record. Changing the architecture of the auth system does.

**Q: What if DRY and KISS conflict?**  
See the priority order above. KISS generally wins for small-scope repetition; DRY wins when the duplication spans multiple modules.

**Q: How do I enforce these principles with the AI?**  
Include this document in the mandatory reading order. Reference specific principles in prompts: "Per SSOT, where should this configuration live?"

## Summary

Nine engineering principles guide every decision: SSOT, DRY, KISS, Convention over Configuration, Explicit Decisions, Small Modules, Composable Systems, Minimal Context, and Deterministic Workflow. They are ordered by priority when conflicts arise. They apply to both human and AI contributors.
