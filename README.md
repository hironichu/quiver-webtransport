# quiver-webtransport

WebTransport facade package for Quiver. This package exposes a WebTransport-focused package identity while re-exporting the WebTransport APIs implemented in `quiver-http3`.

## Product

| Product | Purpose |
| --- | --- |
| `WebTransport` | Re-exports HTTP/3 WebTransport client, server, session, stream, capsule, options, and error APIs. |

## Installation

Add the package to your `Package.swift`:

```swift
dependencies: [
	.package(url: "https://github.com/hironichu/quiver-webtransport.git", branch: "main")
]
```

Then depend on the facade product:

```swift
.target(
	name: "MyTarget",
	dependencies: [
		.product(name: "WebTransport", package: "quiver-webtransport"),
	]
)
```

## Local Development

Keep this package next to `quiver-http3` and `quiver-quic`:

```text
quiver-packages/
├── quiver-quic/
├── quiver-http3/
└── quiver-webtransport/
```

Set `QUIVER_PACKAGES_PATH=/path/to/quiver-packages` if your local Quiver package checkouts live somewhere else.

## Architecture Note

WebTransport session routing remains inside `quiver-http3` because HTTP/3 owns Extended CONNECT request handling, session registration, stream routing, and priority scheduling. This package intentionally stays thin so downstream users can depend on a dedicated WebTransport package without duplicating implementation.

## Development Commands

```bash
swift build
```
