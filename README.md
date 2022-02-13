# LBlock calculator

An open source calculator for LBlock royalties.

## Getting Started

This project is a starting point for a Flutter application that follows the
[simple app state management
tutorial](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple).

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## API

The `poocoin` API is used to fetch LBlock current price.

The `bscscan` API is used to fetch lottery & royalties pool data.

## Formula

Following algorithm is used:

`user_token` / `total_supply` * `royalties_pool`

`user_token` is filled by user on TextField, locally saved for better UX.
`total_supply` value is 100,000,000,000.
`royalties_pool` is fetched each time user open app or relead main view with `bscscan` API.

## Limitation

I used a free account on `bscscan` API, that is limited to 5 call each seconds.

## Data privacy

No data are send to any server. Only local storage (shared_pref) are used to store user LBlock.
