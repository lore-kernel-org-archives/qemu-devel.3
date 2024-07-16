Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E794C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 10:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTfUe-00029B-LK; Tue, 16 Jul 2024 06:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTfUc-000264-0Z
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 06:33:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTfUa-00018O-5k
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 06:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721125986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oa5fi65WycZwAqSJWG1m+J7qWDGFkeGnvVUZmIZeBEw=;
 b=bgnbSUyadV1dUFDfJJlj5gRsvHQN+p4ijN2M9hLHN9GxRAUKamZAl55FJ3fZ/BzdIFx9VA
 R3jTTp7dHBki+I799TwrI3gecmWxqHdIHgryXmiDgkcEdiapv0945ay3VT+HZ3hR/TkE5w
 dz06PTfzjbG4nyT6bKA5zod+l9OI0pI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-sZBWTYbQOrKobHnn-qtg-w-1; Tue, 16 Jul 2024 06:33:04 -0400
X-MC-Unique: sZBWTYbQOrKobHnn-qtg-w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42668796626so38221475e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 03:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721125984; x=1721730784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oa5fi65WycZwAqSJWG1m+J7qWDGFkeGnvVUZmIZeBEw=;
 b=poneYFpCegpm7uBsRKsbxUwHR+/NbsQuCfggUigTZOc9P9ThbuLhthMxy7NV9MbOlk
 cZpgKNaHusyUbv9q0+5dz/8cS2u8jm0chYHlYuX2nN5dwQxF9sPrhBuB3J4kjj9BZULW
 klUo5hH6AjK/MXuBwxQiONJCuxxG0ab9/40qyCVE0T69LPxrtdXyjem4Qa28Fb0DnaYd
 +8hEwFb9KAeMI8M6FKKLtX+xaBFr56csQWjd1d+OmolkEdqyrUpDYDd/An1FIM8nDLRC
 RDBDVc3HGSAy+RFdl2512LA6f1mWt2N6H6r+uTM63eb3TJ19H42TRFetVle8e8jKjGvo
 SwCg==
X-Gm-Message-State: AOJu0Yw7WaFBMpl5S/dCpHf0Ikd/UcgpXcmCLOkwlnXsDotI6sw6LPJq
 0Tip4XmDMb14ZHsH20JJL4qxdeO5JQlJfw8b+qi/yB+2ABYbxKfhvp91FWIDMgpjQ2mLBZC5KF3
 2Bvy12V7qUJouhfFOncW/Xcv30s9azDOsFX/ocw2voXziJHgk/HxV
X-Received: by 2002:a05:600c:3589:b0:426:6f3e:feef with SMTP id
 5b1f17b1804b1-427ba69775cmr13440995e9.29.1721125983821; 
 Tue, 16 Jul 2024 03:33:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj/xOJC43KEA16TIO/zWZTTRwsIgxSGgyFOsmXekzLfYedmXrbimmrUPRG5TsnKyYXgVKOcw==
X-Received: by 2002:a05:600c:3589:b0:426:6f3e:feef with SMTP id
 5b1f17b1804b1-427ba69775cmr13440585e9.29.1721125983423; 
 Tue, 16 Jul 2024 03:33:03 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427b8609d54sm31479865e9.42.2024.07.16.03.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 03:33:03 -0700 (PDT)
Date: Tue, 16 Jul 2024 12:33:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, Bin Meng
 <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, Daniel Henrique
 Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, "Michael S . Tsirkin" <mst@redhat.com>, Ani
 Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 4/9] acpi/gpex: Create PCI link devices outside PCI
 root bridge
Message-ID: <20240716123302.01f6b93c@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240715171129.1168896-5-sunilvl@ventanamicro.com>
References: <20240715171129.1168896-1-sunilvl@ventanamicro.com>
 <20240715171129.1168896-5-sunilvl@ventanamicro.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 15 Jul 2024 22:41:24 +0530
Sunil V L <sunilvl@ventanamicro.com> wrote:

> Currently, PCI link devices (PNP0C0F) are always created within the
> scope of the PCI root bridge. However, RISC-V needs these link devices
> to be created outside to ensure the probing order in the OS. This
> matches the example given in the ACPI specification [1] as well. Hence,
> create these link devices directly under _SB instead of under the PCI
> root bridge.
> 
> To keep these link device names unique for multiple PCI bridges, change
> the device name from GSIx to LXXY format where XX is the PCI bus number
> and Y is the INTx.
> 
> GPEX is currently used by riscv, aarch64/virt and x86/microvm machines.
> So, this change will alter the DSDT for those systems.
> 
> [1] - ACPI 5.1: 6.2.13.1 Example: Using _PRT to Describe PCI IRQ Routing
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/pci-host/gpex-acpi.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> index f69413ea2c..391fabb8a8 100644
> --- a/hw/pci-host/gpex-acpi.c
> +++ b/hw/pci-host/gpex-acpi.c
> @@ -7,7 +7,8 @@
>  #include "hw/pci/pcie_host.h"
>  #include "hw/acpi/cxl.h"
>  
> -static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq)
> +static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
> +                                          Aml *scope, uint8_t bus_num)
>  {
>      Aml *method, *crs;
>      int i, slot_no;
> @@ -20,7 +21,7 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq)
>              Aml *pkg = aml_package(4);
>              aml_append(pkg, aml_int((slot_no << 16) | 0xFFFF));
>              aml_append(pkg, aml_int(i));
> -            aml_append(pkg, aml_name("GSI%d", gsi));
> +            aml_append(pkg, aml_name("L%.02X%X", bus_num, gsi));
>              aml_append(pkg, aml_int(0));
>              aml_append(rt_pkg, pkg);
>          }
> @@ -30,7 +31,7 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq)
>      /* Create GSI link device */
>      for (i = 0; i < PCI_NUM_PINS; i++) {
>          uint32_t irqs = irq + i;
> -        Aml *dev_gsi = aml_device("GSI%d", i);
> +        Aml *dev_gsi = aml_device("L%.02X%X", bus_num, i);
>          aml_append(dev_gsi, aml_name_decl("_HID", aml_string("PNP0C0F")));
>          aml_append(dev_gsi, aml_name_decl("_UID", aml_int(i)));
>          crs = aml_resource_template();
> @@ -45,7 +46,7 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq)
>          aml_append(dev_gsi, aml_name_decl("_CRS", crs));
>          method = aml_method("_SRS", 1, AML_NOTSERIALIZED);
>          aml_append(dev_gsi, method);
> -        aml_append(dev, dev_gsi);
> +        aml_append(scope, dev_gsi);
>      }
>  }
>  
> @@ -174,7 +175,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>                  aml_append(dev, aml_name_decl("_PXM", aml_int(numa_node)));
>              }
>  
> -            acpi_dsdt_add_pci_route_table(dev, cfg->irq);
> +            acpi_dsdt_add_pci_route_table(dev, cfg->irq, scope, bus_num);
>  
>              /*
>               * Resources defined for PXBs are composed of the following parts:
> @@ -205,7 +206,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>      aml_append(dev, aml_name_decl("_STR", aml_unicode("PCIe 0 Device")));
>      aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
>  
> -    acpi_dsdt_add_pci_route_table(dev, cfg->irq);
> +    acpi_dsdt_add_pci_route_table(dev, cfg->irq, scope, 0);
>  
>      method = aml_method("_CBA", 0, AML_NOTSERIALIZED);
>      aml_append(method, aml_return(aml_int(cfg->ecam.base)));


