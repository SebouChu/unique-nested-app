# Unique Nested App

A WIP Rails application around nested forms and unique attributes.

- Nested forms are handled by [the `cocoon` Ruby gem](https://github.com/nathanvda/cocoon).
- Sort feature is handled by [the `Sortable` JS library](https://github.com/SortableJS/Sortable).

## Models

### Person

A `Person` has a `first_name`, a `last_name`, and can have many `Involvements`.

### Program

A `Program` has a `title`, a `description` as rich text and can have many direct `Involvements` and `Roles` (with `Involvements` associated to them).

### Role

A `Role` has a `description`, a `position`, an optional polymorphic `target` and can have many *sortable* `Involvements`.

They are ordered by position, based on the target they are associated with.

### Involvements

An `Involvement` creates a **unique** link between a `Person` with a polymorphic `target`. It also has:
  - a `kind` based on the `target_type`
    - `administrator` for `Role`
    - `teacher` for `Program`
  - a `description` (omitted when `target_type` is `Role`)
  - a `position`

They are ordered by position, based on the target they are associated with, like `Roles`.

## Currently

We can create `People` and `Programs`. We can create *target-less* `Roles` with `Involvements`, either in the `Role` form, or through nested controllers.

## In the future

- We should be able to add `Involvements` to `Programs`
- We should be able to add `Roles` to `Programs`, and `Involvements` to those `Roles`
- Nested `Involvement` fields inside `Role` form should have dynamic `Person` field based on the current selected `People`.
