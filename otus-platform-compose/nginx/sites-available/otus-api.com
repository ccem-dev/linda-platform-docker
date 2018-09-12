server {
                listen 80;
                large_client_header_buffers 10 16k;

                location ~ /otus-rest {
                        proxy_pass http://localhost:8080;
                        proxy_intercept_errors  off;
                        proxy_set_header Host localhost;
                        proxy_set_header X-Real-IP $remote_addr;
                        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                        proxy_set_header X-Forwarded-Proto $scheme;
                }

}
