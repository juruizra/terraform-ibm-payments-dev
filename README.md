# terraform-ibm-payments-dev

Infraestructura de terraform-ibm-payments-dev en IBM Cloud, gestionada con HCP Terraform.

## Resumen

| | |
|---|---|
| Organización HCP Terraform | `comoquiera` |
| Workspace | `terraform-ibm-payments-dev` |
| Modo | remote · auto-apply desactivado |
| Región / Zona | `us-south` / `us-south-1` |
| Repo | `juruizra/terraform-ibm-payments-dev` (rama `main`) |

## Módulos y providers

- Módulo privado: [`comoquiera/vpc-standard/IBM`](https://app.terraform.io/app/comoquiera/registry/modules/private/comoquiera/vpc-standard/IBM) `v1.0.0` — red (VPC, subnet, security group, gateway)
- Provider: `IBM-Cloud/ibm` — SSH key, VSI, floating IP

## Recursos declarados directamente

| Recurso | Descripción |
|---|---|
| `ibm_is_ssh_key.payments` | Carga la clave SSH pública del equipo de pagos |
| `data.ibm_is_image.ubuntu` | Lookup del ID de imagen `ibm-ubuntu-22-04-5-minimal-amd64-19` |
| `ibm_is_instance.payments` | VSI con perfil `bx2-2x8`, imagen Ubuntu 22.04 minimal |
| `ibm_is_floating_ip.payments` | IP pública asociada a la NIC primaria de la VSI |

## Variables

Variables de código (con default, versionadas en `variables.tf`):

| Variable | Default | Descripción |
|---|---|---|
| `region` | `us-south` | IBM Cloud region |
| `zone` | `us-south-1` | IBM Cloud zone |
| `name` | `payments` | Base name for all resources |
| `profile` | `bx2-2x8` | VSI instance profile |

Variables gestionadas como workspace variable en HCP Terraform (sin default en
código — HCP es la fuente de verdad):

| Variable | Tipo | Descripción |
|---|---|---|
| `ssh_public_key` | Terraform · sensitive | Contenido de la clave SSH pública |

Credenciales de IBM Cloud inyectadas por el variable set `credentials`
como `IC_API_KEY` — no se declaran como variable de Terraform.

## Uso

```bash
terraform init
terraform validate
```

El `plan` y el `apply` corren remotamente en HCP Terraform, nunca localmente.
Para lanzar un run:

```
Lanza un run plan_only en el workspace terraform-ibm-payments-dev de comoquiera
y muéstrame los logs del plan cuando termine.
```

## Outputs

| Output | Descripción |
|---|---|
| `public_ip` | IP pública asignada a la VSI |
| `ssh_command` | Comando SSH completo para conectarse |

Para leer el output tras un apply:

```
Con tfctl, lee el state version actual de terraform-ibm-payments-dev
y extrae el output public_ip.
```

---
Generado por el skill `provision-ibm-cloud` de Bob.
