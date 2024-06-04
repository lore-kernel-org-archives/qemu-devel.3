Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6C4C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 23:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEdFP-0008SD-VS; Tue, 04 Jun 2024 19:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEdFK-0008QH-Cn; Tue, 04 Jun 2024 19:07:14 -0400
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEdFI-0002jE-6I; Tue, 04 Jun 2024 19:07:14 -0400
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-4eb2b6164b7so179842e0c.0; 
 Tue, 04 Jun 2024 16:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717542430; x=1718147230; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RvH5/6llr+X5v5vTZbg0Cr9R662R2uXq8xEHYJemWDE=;
 b=PGK1w4R4RwOeIdU5wxGbebBQxzWsRnYoiF9aeJ2SZN3p3hj5dU+yv3PuJe4eED8RhZ
 H5pK7NUJdT5644ys9ODLtTU2xmmU56zh10uxpHU8vJGv/Lr/dmz2WbQHAeytAK3R1l4r
 xzYpgqZmutM9f5whEXGtvNvyMBpHYJwq1ZxsI+rS5w4vBuGh2lp9UHyNDtBM7GgAiwDN
 PqJp1HbYeXLKVlJE0rigwSQGW5dEE1XytySbe1ri4EqibXf5GB8JciRdVF4TR+RVnSB1
 Vs5kTRRToJkfg4azKc2Z4wYbaqrnD0I0Q/MXehVvYgIbp6tQzZXEy8pWMSJhj46O7vAF
 2gBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717542430; x=1718147230;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RvH5/6llr+X5v5vTZbg0Cr9R662R2uXq8xEHYJemWDE=;
 b=dExHe+e3aKMvt3svfA41A5+v+fdFfmGUc28NtmesRR2dLI39kbifDS920xlmoJmccG
 QH+iId5X3Hv7ivsigzNmKetnZYNBKLv+Vf7DM1jObjTkPxiTh+9EGm1RdeAvg3u5I8cT
 mu4Glb+XaR0KHz+ry/dkBRY/i5lZsZ4KMYUUZ3DSGjhVsddD3Nn6wTlyDdzGoB5FMeJX
 +VvYIE//fjmUCy4b0CzGqeYvElvAFusCbt6UyRxyF8+KpFy2ZqbTCwzUeXuvKTRIdsJ5
 N5/N9Kp4N/t4h4z9NzMf1Q3JfAJy5AP7nFnciXDZ10RP1LngxJGd8zuWMB+RSpC4rCSO
 fVJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnocCdvdXz5oNkyFum/aAvzE4aosV/XQXke60hLEXJfplX4XRtuVSvCRtOPHdryUZNKKgqcuz+bhb6Fe6lLS31e+4Slqw=
X-Gm-Message-State: AOJu0YxmXvGAXv0BFlKh7oRE8Hzlk4WtBWHOSsjOcxXM2O0hCnDJZCRT
 55rfZez/CCiiRcMhLltOWHNPQDwh2BLNcC+XbYje4svDFJGQSBUFvjEHldAhWWyR3Li4yaxJQXH
 goAKL/FY/v4dUT8QheT+3GQMHdf8=
X-Google-Smtp-Source: AGHT+IH71IFji0Np55W0kPx0xufX58RWoWJUp0QbqUmje+SZ0c3sqvcGNL2Oaa2uc5yg4SW5FwzAjgPbHTtfT1Ombfw=
X-Received: by 2002:a05:6122:91e:b0:4e4:e749:32a2 with SMTP id
 71dfb90a1353d-4eb3a50053amr1561953e0c.7.1717542430009; Tue, 04 Jun 2024
 16:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240528073103.1075812-1-sunilvl@ventanamicro.com>
 <20240528073103.1075812-2-sunilvl@ventanamicro.com>
In-Reply-To: <20240528073103.1075812-2-sunilvl@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 5 Jun 2024 09:06:43 +1000
Message-ID: <CAKmqyKOzjB_p4-gQMA=YKnB29DpYOMFrMudYpRtyBKLCzeGw8g@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpex-acpi: Support PCI link devices outside the host
 bridge
To: Sunil V L <sunilvl@ventanamicro.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa34.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, May 28, 2024 at 5:32=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> Currently, PCI link devices (PNP0C0F) are always created within the
> scope of the PCI root complex. However, RISC-V needs PCI link devices to
> be outside the scope of the PCI host bridge to properly enable the probe
> order. This matches the example given in the ACPI specification section
> 6.2.13.1 as well.
>
> Enable creating link devices outside the scope of PCI root complex based
> on the flag which gets set currently only for RISC-V.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/pci-host/gpex-acpi.c    | 29 ++++++++++++++++++++++++-----
>  hw/riscv/virt-acpi-build.c |  8 +++++---
>  include/hw/pci-host/gpex.h |  5 ++++-
>  3 files changed, 33 insertions(+), 9 deletions(-)
>
> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> index f69413ea2c..cea89a3ed8 100644
> --- a/hw/pci-host/gpex-acpi.c
> +++ b/hw/pci-host/gpex-acpi.c
> @@ -7,7 +7,7 @@
>  #include "hw/pci/pcie_host.h"
>  #include "hw/acpi/cxl.h"
>
> -static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq)
> +static void acpi_dsdt_add_pci_route_table(Aml *scope, Aml *dev, uint32_t=
 irq)
>  {
>      Aml *method, *crs;
>      int i, slot_no;
> @@ -45,7 +45,17 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, ui=
nt32_t irq)
>          aml_append(dev_gsi, aml_name_decl("_CRS", crs));
>          method =3D aml_method("_SRS", 1, AML_NOTSERIALIZED);
>          aml_append(dev_gsi, method);
> -        aml_append(dev, dev_gsi);
> +
> +        /*
> +         * Some architectures like RISC-V need PCI link devices created
> +         * outside the scope of the PCI host bridge similar to the examp=
le
> +         * given in the section 6.2.13.1 of ACPI spec 6.5.
> +         */
> +         if (scope) {
> +            aml_append(scope, dev_gsi);
> +        } else {
> +            aml_append(dev, dev_gsi);
> +        }
>      }
>  }
>
> @@ -174,7 +184,11 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfi=
g *cfg)
>                  aml_append(dev, aml_name_decl("_PXM", aml_int(numa_node)=
));
>              }
>
> -            acpi_dsdt_add_pci_route_table(dev, cfg->irq);
> +            if (cfg->flags & GPEX_FLAGS_EXT_GSI_LINK) {
> +                acpi_dsdt_add_pci_route_table(scope, dev, cfg->irq);
> +            } else {
> +                acpi_dsdt_add_pci_route_table(NULL, dev, cfg->irq);
> +            }
>
>              /*
>               * Resources defined for PXBs are composed of the following =
parts:
> @@ -205,7 +219,11 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfi=
g *cfg)
>      aml_append(dev, aml_name_decl("_STR", aml_unicode("PCIe 0 Device")))=
;
>      aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
>
> -    acpi_dsdt_add_pci_route_table(dev, cfg->irq);
> +    if (cfg->flags & GPEX_FLAGS_EXT_GSI_LINK) {
> +        acpi_dsdt_add_pci_route_table(scope, dev, cfg->irq);
> +    } else {
> +        acpi_dsdt_add_pci_route_table(NULL, dev, cfg->irq);
> +    }
>
>      method =3D aml_method("_CBA", 0, AML_NOTSERIALIZED);
>      aml_append(method, aml_return(aml_int(cfg->ecam.base)));
> @@ -282,7 +300,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig=
 *cfg)
>      crs_range_set_free(&crs_range_set);
>  }
>
> -void acpi_dsdt_add_gpex_host(Aml *scope, uint32_t irq)
> +void acpi_dsdt_add_gpex_host(Aml *scope, uint32_t irq, uint32_t flags)
>  {
>      bool ambig;
>      Object *obj =3D object_resolve_path_type("", TYPE_GPEX_HOST, &ambig)=
;
> @@ -292,5 +310,6 @@ void acpi_dsdt_add_gpex_host(Aml *scope, uint32_t irq=
)
>      }
>
>      GPEX_HOST(obj)->gpex_cfg.irq =3D irq;
> +    GPEX_HOST(obj)->gpex_cfg.flags =3D flags;
>      acpi_dsdt_add_gpex(scope, &GPEX_HOST(obj)->gpex_cfg);
>  }
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 0925528160..832a3acb8d 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -417,19 +417,21 @@ static void build_dsdt(GArray *table_data,
>          virtio_acpi_dsdt_add(scope, memmap[VIRT_VIRTIO].base,
>                               memmap[VIRT_VIRTIO].size,
>                               VIRTIO_IRQ, 0, VIRTIO_COUNT);
> -        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ);
> +        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ, GPEX_FLAGS_EXT_GSI_LINK=
);
>      } else if (socket_count =3D=3D 2) {
>          virtio_acpi_dsdt_add(scope, memmap[VIRT_VIRTIO].base,
>                               memmap[VIRT_VIRTIO].size,
>                               VIRTIO_IRQ + VIRT_IRQCHIP_NUM_SOURCES, 0,
>                               VIRTIO_COUNT);
> -        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURC=
ES);
> +        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURC=
ES,
> +                                GPEX_FLAGS_EXT_GSI_LINK);
>      } else {
>          virtio_acpi_dsdt_add(scope, memmap[VIRT_VIRTIO].base,
>                               memmap[VIRT_VIRTIO].size,
>                               VIRTIO_IRQ + VIRT_IRQCHIP_NUM_SOURCES, 0,
>                               VIRTIO_COUNT);
> -        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURC=
ES * 2);
> +        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURC=
ES * 2,
> +                                GPEX_FLAGS_EXT_GSI_LINK);
>      }
>
>      aml_append(dsdt, scope);
> diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
> index dce883573b..bee17d62c5 100644
> --- a/include/hw/pci-host/gpex.h
> +++ b/include/hw/pci-host/gpex.h
> @@ -47,8 +47,11 @@ struct GPEXConfig {
>      MemMapEntry pio;
>      int         irq;
>      PCIBus      *bus;
> +    uint32_t    flags;
>  };
>
> +#define GPEX_FLAGS_EXT_GSI_LINK BIT(0)
> +
>  struct GPEXHost {
>      /*< private >*/
>      PCIExpressHost parent_obj;
> @@ -71,7 +74,7 @@ struct GPEXHost {
>  int gpex_set_irq_num(GPEXHost *s, int index, int gsi);
>
>  void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg);
> -void acpi_dsdt_add_gpex_host(Aml *scope, uint32_t irq);
> +void acpi_dsdt_add_gpex_host(Aml *scope, uint32_t irq, uint32_t flags);
>
>  #define PCI_HOST_PIO_BASE               "x-pio-base"
>  #define PCI_HOST_PIO_SIZE               "x-pio-size"
> --
> 2.40.1
>
>

