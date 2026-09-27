# PROJECT_MEMORY

**Purpose**: This file stores the project's persistent memory — architecture, business logic,
constraints, and knowledge that must survive across sessions. Updated intentionally, never deleted.

---

## Current Architecture

### High-Level Design

Describe the system architecture in 3-5 sentences. Include the main components and how they interact.

### Architecture Diagram

```
graph TB
    Client --> API[API Gateway]
    API --> Service[Main Service]
    Service --> DB[(Database)]
```

### Key Components

#### Component Name
- **Responsibility**: What this component does
- **Interfaces**: How other components interact with it
- **State**: What state it manages

## Business Logic

### Core Domain Logic

Explain the primary business rules and domain model. Include:
- Entity relationships
- Validation rules
- Key algorithms or workflows

### Data Flow

Describe how data moves through the system for the main use cases.

## Constraints

- **Performance**: e.g., P99 latency < 200ms
- **Security**: e.g., OAuth 2.0 required
- **Compliance**: e.g., GDPR data handling
- **Operational**: e.g., Must run on Kubernetes

## Dependencies

### Runtime Dependencies

| Dependency | Version | Purpose | Notes |
|-----------|---------|---------|-------|
| express | ^4.18 | HTTP framework | |
| pg | ^8.11 | PostgreSQL client | |

### Development Dependencies

| Dependency | Version | Purpose |
|-----------|---------|---------|
| jest | ^29 | Testing |
| typescript | ^5.3 | Type checking |

## Open Questions

- Question 1 — why it matters, who needs to decide
- Question 2 — trade-offs involved

## Future Ideas

- Idea 1 — potential improvement, not yet prioritized
- Idea 2 — architectural change to consider

## AI Notes

This section is for the AI's observations that should persist across sessions.

- **2026-07-06**: Initial scaffolding complete. Project structure follows AgentOS conventions.

### Update Log

| Date | Change | Author |
|------|--------|--------|
| YYYY-MM-DD | Initial architecture defined | AI / Human |
