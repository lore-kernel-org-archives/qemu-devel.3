Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF0EC7115D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 12:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSaXO-0000XN-Us; Fri, 20 Jun 2025 08:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSaWy-0000Su-KJ
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 08:07:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSaWt-0004tB-7N
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 08:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750421252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g4O3UyyHl1VzMWPShkyqpFI04qzaqwWIDrRgkdHpFKk=;
 b=QMujZOuJwn2InY8LI4RKETJfzuflkl5jxDKAwGz+yaU8R1bW+r8M4Fp4GP1S9uCT/Asj4p
 UikUPUCY8noE5j3cP1QJTx8jpWSioVTKXCm0ggbxVCdA8dFcE5ywzdhscoI2n3+kWVKOnE
 HtJ5alifBSOGsfmO8SoWlBSTW44miZc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-Ag4rTaANNtipfVWqbXABIw-1; Fri, 20 Jun 2025 08:07:31 -0400
X-MC-Unique: Ag4rTaANNtipfVWqbXABIw-1
X-Mimecast-MFC-AGG-ID: Ag4rTaANNtipfVWqbXABIw_1750421250
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450de98b28eso13860515e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 05:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750421250; x=1751026050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g4O3UyyHl1VzMWPShkyqpFI04qzaqwWIDrRgkdHpFKk=;
 b=Nw39e2AReogsZjrnlxlqpP+ETp9ys7U6CK5amSXqzyvwmuTQZdFn1CMrH75XGmyxFp
 1U6yBRPfsPuYShxwdLqC+09OBdkqCmW1k9e5uZK4Npq0d7/GeN4lG6mCAfLBMQ+8cFsZ
 otzt+xUx4qth+xnI5ft+R3lUuZ6duImEg1k5f/+0nid+BVn1qjYmpUezzAy03oTli/Wo
 zSe9DvTMerKj74mq+CRlXTb0E5PS2TwhWOjhxnCSr5JJR//sDAwDdDM/YNuYhxmwKbA0
 oSBDG8lwOOzJSaxO+lFx5Z0OwmmMmycRq9bbP8C0JMaAjZjeVqKpIfYFF4vMNxR0uSxm
 lTUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVplpMETLXyIHjjl30O1fbCKQ+0Y6VuBZQk+6aijx/6rqXSxBVtvphx8PfBpuln4SMc+goQgUIN7CmV@nongnu.org
X-Gm-Message-State: AOJu0YyY53lC2C7JBDCu5gTvwlSL6rUa718bUz5PLcjm7bINaQ/YD8/S
 tzV5fsfDzoZsWyJXZIrQ0SirB9oB64gVseSWwSItuPyMhfE6jJFGwIvOX1B4S1+tt45tNoVrcjS
 F1oYXqcB85rsZXkPsHiSm9PesEyYA3Fu4Aqpep6WYA6xdL/1XjP/NIPX6
X-Gm-Gg: ASbGncsQubDDUzrD/E0AwTqP6uUFXaR3yfN+Z3ORn8dUpXEKuq+KpEdBU/BNti4gYag
 py1TpKK0m7dWLO+YELZNrUH8ortLgNt/m5k6i4Ej2AugbqsQnPN/BvUmEqLhg8Xx/SgQDj1WAev
 2c2uabR5616rgwnqjREFtsMZZBv/BcweEWDDYSbqxKaVkDHpnzrlGFVwpTA0UROnWFb7yH3qS0X
 o1+qxcIfBrzPMYVS/omiBFwnvshsdcSFkcR47i5cr3o3J6t3kLyvTsKJcYFcYxAYDm1mKBuinaW
 ucepLaRR0y32
X-Received: by 2002:a05:600c:458d:b0:43b:4829:8067 with SMTP id
 5b1f17b1804b1-45365e4f9e2mr20997945e9.6.1750421249756; 
 Fri, 20 Jun 2025 05:07:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDAjz03PGPpIXu7FVEjVqfFBB2m2xN2Han0dakPTLeJg5uhJcwpJNu4VafJVRm7cK76xOaAw==
X-Received: by 2002:a05:600c:458d:b0:43b:4829:8067 with SMTP id
 5b1f17b1804b1-45365e4f9e2mr20997385e9.6.1750421249262; 
 Fri, 20 Jun 2025 05:07:29 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535ebcecdcsm56254935e9.36.2025.06.20.05.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 05:07:28 -0700 (PDT)
Date: Fri, 20 Jun 2025 14:07:26 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v3 07/29] hw/pci-host/gpex-acpi: retrieve and use GED
 acpi_pcihp setting
Message-ID: <20250620140726.296971a3@fedora>
In-Reply-To: <20250616094903.885753-8-eric.auger@redhat.com>
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-8-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, 16 Jun 2025 11:46:36 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> retrieve the acpi_pcihp option value from the ged. In
> case acpi_pcihp is unset we configure pci native hotplug on
> pci0. For expander bridges we keep legacy pci native hotplug,

I guess it's remnants of from previous version
s/legacy//


> as done on x86 q35.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v2 -> v3:
> - don'use the virt arm machine option anymore.
> ---
>  include/hw/pci-host/gpex.h | 1 +
>  hw/arm/virt-acpi-build.c   | 5 +++++
>  hw/pci-host/gpex-acpi.c    | 3 ++-
>  3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
> index 84471533af..feaf827474 100644
> --- a/include/hw/pci-host/gpex.h
> +++ b/include/hw/pci-host/gpex.h
> @@ -45,6 +45,7 @@ struct GPEXConfig {
>      MemMapEntry pio;
>      int         irq;
>      PCIBus      *bus;
> +    bool        pci_native_hotplug;
>  };
>  
>  typedef struct GPEXIrq GPEXIrq;
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 7e8e0f0298..d7547c8d3b 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -123,12 +123,17 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
>                                uint32_t irq, VirtMachineState *vms)
>  {
>      int ecam_id = VIRT_ECAM_ID(vms->highmem_ecam);
> +    AcpiGedState *acpi_ged_state = ACPI_GED(vms->acpi_dev);
> +    AcpiPciHpState *pcihp_state = &acpi_ged_state->pcihp_state;

1)

> +
>      struct GPEXConfig cfg = {
>          .mmio32 = memmap[VIRT_PCIE_MMIO],
>          .pio    = memmap[VIRT_PCIE_PIO],
>          .ecam   = memmap[ecam_id],
>          .irq    = irq,
>          .bus    = vms->bus,
> +        .pci_native_hotplug = !pcihp_state->use_acpi_hotplug_bridge,

I'd use property accessor here instead of poking into device internals.
and get rind of [1]

>      };
>  
>      if (vms->highmem_mmio) {
> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> index 80fc2bf032..44737a8d81 100644
> --- a/hw/pci-host/gpex-acpi.c
> +++ b/hw/pci-host/gpex-acpi.c
> @@ -203,6 +203,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>              if (is_cxl) {
>                  build_cxl_osc_method(dev);
>              } else {
> +                /* pxb bridges do not have ACPI PCI Hot-plug enabled */
>                  acpi_dsdt_add_host_bridge_methods(dev, true);
>              }
>  
> @@ -278,7 +279,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>      }
>      aml_append(dev, aml_name_decl("_CRS", rbuf));
>  
> -    acpi_dsdt_add_host_bridge_methods(dev, true);
> +    acpi_dsdt_add_host_bridge_methods(dev, cfg->pci_native_hotplug);
>  
>      Aml *dev_res0 = aml_device("%s", "RES0");
>      aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));


