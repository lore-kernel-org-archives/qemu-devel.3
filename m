Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC88C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 14:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJv31-0007wm-Gy; Tue, 27 May 2025 10:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJv2u-0007u7-VA
 for qemu-devel@nongnu.org; Tue, 27 May 2025 10:12:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJv2q-0007cW-2e
 for qemu-devel@nongnu.org; Tue, 27 May 2025 10:12:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748355160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xAlxIcXP/BPxHINkqh6XmD3LEC+ii4sHOM9gVyEVcs0=;
 b=ZJuVDK9EmrAkI4Dm8JwS4QsXeEdO2QsrZ7CavljRkxU0NmZJobw3izjyLB68s4yOtz0trL
 mQIP74zHH36SiSWeawCDG4AUoh/I/AGXyuDnejt3GqPiRsz+uNSHCZCZ1QSyGHFkViBV2s
 1NbFTeZxJj1SFNaVQAQcPCkt0R0eGIY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-2lE5HlYpPTOAV7BLfQonVQ-1; Tue, 27 May 2025 10:12:38 -0400
X-MC-Unique: 2lE5HlYpPTOAV7BLfQonVQ-1
X-Mimecast-MFC-AGG-ID: 2lE5HlYpPTOAV7BLfQonVQ_1748355158
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4c8a4963fso2086921f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 07:12:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748355157; x=1748959957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xAlxIcXP/BPxHINkqh6XmD3LEC+ii4sHOM9gVyEVcs0=;
 b=qatoB8IdRiQDTmUQVASfeJ1JFM+JFjxtI1O+jmRb0vdqNalfRyd3vTOjD8L/c+2giy
 7oW2LX5ULTv4nIYvDo3bTJSFKLD+575S8sdEBqSNQNhrL6sQoNKWW0fRIw1cyjuPlOoC
 30CR0XNzREGZC1PshmiSomLxTDuMbaPDqqC/QcrfBgynO0E0SXJJgjfP54oV2JpZFA8H
 ul4UgFn4K/M1KekEeFHHpDNm+cewC3LOWKSaIEhQbzl+lCy9GuVhjW9Lc+rEBB0lym1z
 A7DjJfWc4u1rvP3RhtwRnLUumqxviUnMOgVSY+blsz8u5jOg4/J70mNujhegFqCTG5mE
 Cq1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOJ65SqTJnZ7b1u5i02NZTdQR3QNFBToOI6puLQ1CmxmRH9UpreFha6s20ILxljuYeQMsAW4jrZ1Rx@nongnu.org
X-Gm-Message-State: AOJu0Yy0QLK+erSproJemnSqVFfN6rYsrcIpX24OAISP3z9ei24nPibK
 qRzJMG+p/ZAllOEpm4b3dh3wFupsnpGnwiaC+NE8LQyURPIwY+hEimV1aCK1zeJZEuW6r87DMd5
 GAR/OYedwthm223dAv7Gd8KEamcoC/thQS+AL57iKT0Hq/gjcwN4CTAV2
X-Gm-Gg: ASbGnctmKUS1uHG/n1jLH4CeIn3+HKy5/NIihfnOs0WOs3xlCchujLz9R/qAH9TX3cV
 1ZBaHotja5ZIOhiYBaMulXdrNYqzI0Oifc9k/zGwGcbiPg3zus1ShVRV5s5qOsf5Yea1WR2uQ6c
 jmc3zZ5vZcp983CtBB6gRHCHV5bbz6XfIW7G9zQD6H/8Tfv6B1MMFrPULM/xC4+UBfEsMp0+yCK
 8ZHlZszCdpDiuN52kimn8g63ewQQH/HkNwWfWNDCUwEfWCYo5tX6nISvjye6fL8Mp09knMA7K4T
 DtIZEhF0e46SHyzFOFqO8k/EoV7eV+tv
X-Received: by 2002:a05:6000:2911:b0:3a4:e65d:5d8c with SMTP id
 ffacd0b85a97d-3a4e65d5d9emr483372f8f.40.1748355157550; 
 Tue, 27 May 2025 07:12:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4m4TBG2zjdU5h1KdpPVbAYE9N1hwAvdo6VDe2ckMVU39KgjuBRquYNY+occvni+VJy1bsEQ==
X-Received: by 2002:a05:6000:2911:b0:3a4:e65d:5d8c with SMTP id
 ffacd0b85a97d-3a4e65d5d9emr483333f8f.40.1748355157167; 
 Tue, 27 May 2025 07:12:37 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4e425f25csm1200290f8f.70.2025.05.27.07.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 07:12:36 -0700 (PDT)
Date: Tue, 27 May 2025 16:12:35 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v2 17/25] hw/arm/virt-acpi-build: Modify the DSDT ACPI
 table to enable ACPI PCI hotplug
Message-ID: <20250527161235.068bf64b@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250527074224.1197793-18-eric.auger@redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-18-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 27 May 2025 09:40:19 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Modify the DSDT ACPI table to enable ACPI PCI hotplug.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  include/hw/arm/virt.h    |  1 +
>  hw/arm/virt-acpi-build.c | 21 +++++++++++++++++++++
>  hw/arm/virt.c            |  1 +
>  hw/arm/Kconfig           |  2 ++
>  4 files changed, 25 insertions(+)
> 
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 10ea581f06..1b2e2e1284 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -79,6 +79,7 @@ enum {
>      VIRT_ACPI_GED,
>      VIRT_NVDIMM_ACPI,
>      VIRT_PVTIME,
> +    VIRT_ACPI_PCIHP,
>      VIRT_LOWMEMMAP_LAST,
>  };
>  
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index be5e00a56e..9d88ffc318 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -34,6 +34,7 @@
>  #include "hw/core/cpu.h"
>  #include "hw/acpi/acpi-defs.h"
>  #include "hw/acpi/acpi.h"
> +#include "hw/acpi/pcihp.h"
>  #include "hw/nvram/fw_cfg_acpi.h"
>  #include "hw/acpi/bios-linker-loader.h"
>  #include "hw/acpi/aml-build.h"
> @@ -836,6 +837,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>                           (irqmap[VIRT_MMIO] + ARM_SPI_BASE),
>                           0, NUM_VIRTIO_TRANSPORTS);
>      acpi_dsdt_add_pci(scope, memmap, irqmap[VIRT_PCIE] + ARM_SPI_BASE, vms);
> +
>      if (vms->acpi_dev) {
>          build_ged_aml(scope, "\\_SB."GED_DEVICE,
>                        HOTPLUG_HANDLER(vms->acpi_dev),
> @@ -864,6 +866,25 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  
>      aml_append(dsdt, scope);
>  
> +    if (vms->acpi_pcihp) {
> +        Aml *pci0_scope = aml_scope("\\_SB.PCI0");
> +
> +        aml_append(pci0_scope, aml_pci_edsm());
> +        build_acpi_pci_hotplug(dsdt, AML_SYSTEM_MEMORY,
> +                               memmap[VIRT_ACPI_PCIHP].base);
> +        build_append_pcihp_resources(pci0_scope,
> +                                     memmap[VIRT_ACPI_PCIHP].base,
> +                                     memmap[VIRT_ACPI_PCIHP].size);
> +
> +        /* Scan all PCI buses. Generate tables to support hotplug. */
> +        build_append_pci_bus_devices(pci0_scope, vms->bus);
> +        if (object_property_find(OBJECT(vms->bus), ACPI_PCIHP_PROP_BSEL)) {
> +            build_append_pcihp_slots(pci0_scope, vms->bus);
> +        }
> +        build_append_notification_callback(pci0_scope, vms->bus);
> +        aml_append(dsdt, pci0_scope);
> +    }
> +
>      /* copy AML table into ACPI tables blob */
>      g_array_append_vals(table_data, dsdt->buf->data, dsdt->buf->len);
>  
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index a0deeaf2b3..4aa40c8e8b 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -183,6 +183,7 @@ static const MemMapEntry base_memmap[] = {
>      [VIRT_NVDIMM_ACPI] =        { 0x09090000, NVDIMM_ACPI_IO_LEN},
>      [VIRT_PVTIME] =             { 0x090a0000, 0x00010000 },
>      [VIRT_SECURE_GPIO] =        { 0x090b0000, 0x00001000 },
> +    [VIRT_ACPI_PCIHP] =         { 0x090c0000, 0x00001000 },
                                                  ^^^^^
why not use actual len define here?
                                             
>      [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
>      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
>      [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index a55b44d7bd..572b4dabd5 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -34,6 +34,8 @@ config ARM_VIRT
>      select ACPI_HW_REDUCED
>      select ACPI_APEI
>      select ACPI_VIOT
> +    select ACPI_PCIHP
> +    select ACPI_PCI_BRIDGE
>      select VIRTIO_MEM_SUPPORTED
>      select ACPI_CXL
>      select ACPI_HMAT


