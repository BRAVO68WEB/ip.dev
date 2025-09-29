# IP.DEV

A fast, simple IP geolocation API service using DB-IP's City Lite database. Get city, country, and location data for any IP address.

## Features

- 🌍 IP Geolocation lookup with city/country data
- 🚀 Fast responses with in-memory DB
- 🔄 Cloudflare-aware client IP detection
- 🌐 CORS enabled for browser usage
- 🐳 Docker ready with multi-arch support

## API Usage

### Get Your IP Info
```bash
curl http://localhost:8080/
```

### Lookup Specific IP
```bash
curl http://localhost:8080/8.8.8.8
```

### Response Format
```json
{
  "ip": "8.8.8.8",
  "city": "Mountain View",
  "region": "California",
  "country": "US",
  "country_full": "United States",
  "continent": "NA",
  "continent_full": "North America",
  "loc": "37.4056,-122.0775",
  "postal": "94043"
}
```

## Self-Hosting Guide

### Prerequisites
- Docker and Docker Compose
- ~60MB disk space for the MMDB database

### Quick Start

1. Clone the repository:
   ```bash
   git clone https://github.com/bravo68web/ip.dev.git
   cd ip.dev
   ```

2. Download the MMDB database:
   ```bash
   bash fetch_mmdb.sh
   ```

3. Start with Docker Compose:
   ```bash
   docker compose up -d
   ```

4. Test the service:
   ```bash
   curl http://localhost:8080/self
   ```

### Environment Variables

- `PORT` - Server port (default: 8080)
- `MMDB_PATH` - Path to MMDB file (default: /app/data/GeoLite2-City.mmdb)

### Docker Compose Configuration

```yaml
version: "3.9"
services:
  ip_service:
    image: ghcr.io/bravo68web/ip.dev:latest  # or build: .
    ports:
      - "8080:8080"  # Change left side to customize port
    environment:
      - MMDB_PATH=/app/data/GeoLite2-City.mmdb
    volumes:
      - ./data:/app/data:rw  # Mount for database persistence
    restart: unless-stopped
```

### Manual Build

If you prefer to build the image yourself:

```bash
# Download MMDB
bash fetch_mmdb.sh

# Build and run
docker compose build
docker compose up -d
```

## License

MIT License - See [LICENSE](LICENSE) for details.

## Credits

- [DB-IP](https://db-ip.com/) for the IP geolocation database
- Database licensed under [Creative Commons Attribution 4.0](https://creativecommons.org/licenses/by/4.0/)