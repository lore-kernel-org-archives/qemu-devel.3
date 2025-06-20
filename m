Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C963DC7115D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 12:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSavr-0001M9-OB; Fri, 20 Jun 2025 08:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSavn-0001LS-8n
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 08:33:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSavk-0000RM-U1
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 08:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750422794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gNBsc44q89xHtPVhAxDbL3igZk3nFKrUg4BtPXbAfRM=;
 b=g3qHWOe1D+ORySZUYQ82+9RC2k1QQhKGbEX3XKISMWdRi57yAnhXicZMKr5QmgiLz6KUPS
 jwIEBPnyCbRm4xYSGE559/7Ftst/ml0+7WoxdGsyAVwSVrEjube9skSFBqq3sh/FT2ra5/
 VuDF75M4zlNbfpwsK1WI8aeQFSl5YFs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-ZpXK2yzVMAyZsQ1xqlM0Og-1; Fri, 20 Jun 2025 08:33:13 -0400
X-MC-Unique: ZpXK2yzVMAyZsQ1xqlM0Og-1
X-Mimecast-MFC-AGG-ID: ZpXK2yzVMAyZsQ1xqlM0Og_1750422792
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-452ff9e054eso8442075e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 05:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750422792; x=1751027592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gNBsc44q89xHtPVhAxDbL3igZk3nFKrUg4BtPXbAfRM=;
 b=t8x3YLNRQWb99SXIBqqcn9fnj1jjMUEjACQb5Zp6QubQFpxbArhSJ9iQm2VloBs+nL
 7QZLIZs9wBfH1Ui7+MIUcD0sB60D8qIPhwPIy9T1UHW6sxIE/qlZf+APXRQSp3EWIURc
 yjILkr3xuMxfh1WlSOAzxU027hT5bUu7BJqIAfDcG59RtSv09NA+ORpZoo15n2md+6Sz
 F9HPHUNuMGoKmiQcb9zhoKSepB+jtKsZ91Soyp+hwvxIizpVJgNKc13mL0SRLBN2HJfO
 nKrmzW2hN7BLkDSEEJmz7jXiSNWqu5MJeS0dTvfuA/wj87wFAJs18UroObClnj3FXBWK
 CF8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuy3FJ+PxvKIwM6Kyx/cKrSE1jXaRArPmohkBrydUS3ONpm10hRtJDsdXi+V7sLL3chm9Mmkd/mEdk@nongnu.org
X-Gm-Message-State: AOJu0YyaWPGbicGZldOFf7IuixEZhsb1Ycm1bYM06glf3XoglS2tW2F8
 P3cy+t2hn/JB0dPcbDBso+ZzpvFwWFWaHOiq2UiDuVwbFKMYF8I9yz74XQZONnhz64TxhpHCIxz
 1IxLyOu6DcuAq1cNgjJUVCXYlavGIPPfBEoRjp8/IfnMyielV8CmMeyB3
X-Gm-Gg: ASbGncsdpDyLwHYdyac5uEe9Fo4NdNv4WS21Qatf+nbDmMVkmfowGQmErScaJlXi335
 Jf/ZEuhO0qqgbF/35E8FudjJcTiN4VODIGfzxZxAijY60v36Y0NlsFIkePHIVZ2FYrYv9/yVH1s
 HKwNZ7TglpjWR8zFatjxQUWc3137Lqag1bufLuHEFpQKGmMsIQHhb5GffgYBaqsaYOgekSzDH22
 C/qQWKLICcubX6PNAKHdQgXyEhMzazZyd/27lKkr4lILsZxSEA1Om/OmxIvUz33OGJMg6ikv9/l
 62TC3C71pq6Y
X-Received: by 2002:a05:600c:c3db:b0:450:d3b9:a5fc with SMTP id
 5b1f17b1804b1-453655c2b88mr13201275e9.27.1750422792084; 
 Fri, 20 Jun 2025 05:33:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOGRu4Buo1INcdRfUxAhJs1FqiL4kZS0DReh3cLfJbqWsaY1c+4ypA4I/TgPl3skiHtHTb6w==
X-Received: by 2002:a05:600c:c3db:b0:450:d3b9:a5fc with SMTP id
 5b1f17b1804b1-453655c2b88mr13201145e9.27.1750422791652; 
 Fri, 20 Jun 2025 05:33:11 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d2236452sm1703913f8f.59.2025.06.20.05.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 05:33:11 -0700 (PDT)
Date: Fri, 20 Jun 2025 14:33:10 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v3 17/29] hw/arm/virt-acpi-build: Modify the DSDT ACPI
 table to enable ACPI PCI hotplug
Message-ID: <20250620143310.0eeb124c@fedora>
In-Reply-To: <20250616094903.885753-18-eric.auger@redhat.com>
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-18-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
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

On Mon, 16 Jun 2025 11:46:46 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Modify the DSDT ACPI table to enable ACPI PCI hotplug.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> v2 -> v3:
> - use ACPI_PCIHP_SIZE instead of 0x1000 (Igor)
> - use cihp_state->use_acpi_hotplug_bridge
> ---
>  include/hw/acpi/pcihp.h  |  2 ++
>  include/hw/arm/virt.h    |  1 +
>  hw/arm/virt-acpi-build.c | 22 ++++++++++++++++++++++
>  hw/arm/virt.c            |  2 ++
>  hw/arm/Kconfig           |  2 ++
>  5 files changed, 29 insertions(+)
> 
> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> index 5506a58862..9ff548650b 100644
> --- a/include/hw/acpi/pcihp.h
> +++ b/include/hw/acpi/pcihp.h
> @@ -38,6 +38,8 @@
>  #define ACPI_PCIHP_SEJ_BASE 0x8
>  #define ACPI_PCIHP_BNMR_BASE 0x10
>  
> +#define ACPI_PCIHP_SIZE 0x0018
> +
>  typedef struct AcpiPciHpPciStatus {
>      uint32_t up;
>      uint32_t down;
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 9a1b0f53d2..0ed2e6b732 100644
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
> index d7547c8d3b..a2e58288f8 100644
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
> @@ -809,6 +810,8 @@ static void
>  build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  {
>      VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
> +    AcpiGedState *acpi_ged_state = ACPI_GED(vms->acpi_dev);
> +    AcpiPciHpState *pcihp_state = &acpi_ged_state->pcihp_state;
>      Aml *scope, *dsdt;
>      MachineState *ms = MACHINE(vms);
>      const MemMapEntry *memmap = vms->memmap;
> @@ -868,6 +871,25 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  
>      aml_append(dsdt, scope);
>  
> +    if (pcihp_state->use_acpi_hotplug_bridge) {

ditto, use property accessor


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
> index 9a6cd085a3..08bd808499 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -75,6 +75,7 @@
>  #include "standard-headers/linux/input.h"
>  #include "hw/arm/smmuv3.h"
>  #include "hw/acpi/acpi.h"
> +#include "hw/acpi/pcihp.h"
>  #include "target/arm/cpu-qom.h"
>  #include "target/arm/internals.h"
>  #include "target/arm/multiprocessing.h"
> @@ -183,6 +184,7 @@ static const MemMapEntry base_memmap[] = {
>      [VIRT_NVDIMM_ACPI] =        { 0x09090000, NVDIMM_ACPI_IO_LEN},
>      [VIRT_PVTIME] =             { 0x090a0000, 0x00010000 },
>      [VIRT_SECURE_GPIO] =        { 0x090b0000, 0x00001000 },
> +    [VIRT_ACPI_PCIHP] =         { 0x090c0000, ACPI_PCIHP_SIZE },
>      [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
>      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
>      [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index f543d944c3..dee4d6dd25 100644
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


