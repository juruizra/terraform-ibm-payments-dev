# payments-dev

Infraestructura de payments-dev en IBM Cloud, gestionada con HCP Terraform.

## Resumen

| | |
|---|---|
| Organización HCP Terraform | `comoquiera` |
| Workspace | `payments-dev` |
| Modo | remote · auto-apply desactivado |
| Región / Zona | `us-south` / `us-south-1` |
| Repo | `github.com/juruizra/terraform-ibm-payments-dev` (rama `main`) |

## Módulos y providers

- Módulo GitHub: [`github.com/juruizra/terraform-ibm-vpc-standard?ref=v1.0.0`](https://github.com/juruizra/terraform-ibm-vpc-standard) `v1.0.0` — red (VPC, subnet, security group, gateway)
- Provider: `IBM-Cloud/ibm` — SSH key, VSI, floating IP

## Recursos declarados directamente

| Recurso | Nombre lógico | Propósito |
|---|---|---|
| `ibm_is_ssh_key` | `payments` | Registra la clave RSA pública en IBM Cloud VPC |
| `ibm_is_instance` | `payments` | VSI Ubuntu 22.04 (`ibm-ubuntu-22-04-5-minimal-amd64-19`), perfil `cx2-2x4` |
| `ibm_is_floating_ip` | `payments` | IP pública asignada al NIC primario de la VSI |

## Variables

Variables de código (con default, versionadas en `variables.tf`):

| Variable | Default | Descripción |
|---|---|---|
| `name` | `payments-dev` | Prefijo base para todos los recursos |
| `region` | `us-south` | Región IBM Cloud |
| `zone` | `us-south-1` | Zona dentro de la región |
| `instance_profile` | `cx2-2x4` | Perfil (tamaño) de la VSI |
| `tags` | `["team:payments","env:dev"]` | Tags aplicados a todos los recursos |

Variables gestionadas como workspace variable en HCP Terraform (sin default en
código — HCP es la fuente de verdad):

| Variable | Tipo | Sensible | Descripción |
|---|---|---|---|
| `ssh_public_key` | terraform | sí | Clave RSA 4096 pública para acceso SSH a la VSI |

Credenciales de IBM Cloud inyectadas por el variable set `ibm-cloud-creds`
como `IC_API_KEY` — no se declaran como variable de Terraform.

## Uso

```bash
terraform init
terraform fmt -check -diff
```

El `plan` y el `apply` corren remotamente en HCP Terraform, nunca localmente.
Para lanzar un run:

```
Lanza un run plan_only en el workspace payments-dev de comoquiera
y muéstrame los logs del plan cuando termine.
```

## Outputs

| Output | Descripción |
|---|---|
| `floating_ip` | IP pública asignada a la VSI |
| `ssh_command` | Comando SSH completo para conectarse |
| `instance_id` | ID/CRN de la instancia VSI |

Para leer el output tras un apply:

```
Con tfctl, lee el state version actual de payments-dev
y extrae el output floating_ip.
```

---
Generado por el skill `provision-ibm-cloud` de Bob.
