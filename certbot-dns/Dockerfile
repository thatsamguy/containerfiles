FROM python:latest

RUN pip3 install \
    certbot \
    certbot-dns-cloudflare \
    certbot-dns-cloudxns \
    certbot-dns-digitalocean \
    certbot-dns-dnsimple \
    certbot-dns-dnsmadeeasy \
    certbot-dns-google \
    certbot-dns-luadns \
    certbot-dns-nsone \
    certbot-dns-rfc2136 \
    certbot-dns-route53

CMD ["/usr/bin/certbot"]
