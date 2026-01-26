Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B060D13C34
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 15:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkOW2-0007zW-By; Mon, 26 Jan 2026 10:28:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vkOVz-0007z0-Qt
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 10:28:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vkOVx-00070q-Sd
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 10:28:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769441309;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HzDzvuPvW1G0bkBw/ciRlSexYLiJnj3YSr7fDaVt/Jc=;
 b=B9wBRP5aIRjVX4nEQPtDorP0PjlnGky368k/470oUWk66m4E4mzog1pWU2j6PQenj8V1HY
 gkZIv44OpQGA3IIc2iclACI7AMoKk0PWVfqN1qoUca6mg2gAt4JRiFTIxexg/IWJqCKxfC
 +qiL6A7yNIwpR/3wV1etobpnusZUQM4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-LFcHsfbBNAqWb5YO-W6NqA-1; Mon, 26 Jan 2026 10:28:27 -0500
X-MC-Unique: LFcHsfbBNAqWb5YO-W6NqA-1
X-Mimecast-MFC-AGG-ID: LFcHsfbBNAqWb5YO-W6NqA_1769441306
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-432db1a9589so3575837f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 07:28:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769441306; x=1770046106;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HzDzvuPvW1G0bkBw/ciRlSexYLiJnj3YSr7fDaVt/Jc=;
 b=E06od9k22Rur3PbtYSNHFn1h9rIknctvHcg+V6zPlIgpgj/IlOYEaPNRkwH6cgCyS0
 4xLoTBb9Q+f4Bt0bo7mBJaGJzLwIzKioR7ll5dyPVzFs8S3gV20j9wSJlr1r1JB+BNA0
 GWgRjycSH/NG7yEnWK4ioOV2vXj1axqCZcwtvKDWBB43rx71yCSMj83Pc92kOodpjcl3
 E/3hqQa1ycaLGVi8Lav2z+BsIuOkmpoem1jBjW3Bf+eVpPK+LMY+rDDkD4TMfAUKiNz8
 xE6byDYrrSrZo95yL1iNat42T65eh0CmcXoqLRXsICJfXZhhLr6r2VcXyV4lC93/ow86
 8tjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSVmP7SHly77b0q1/onetN0eI2sDbviN+QuWdj/xeecKPP4KsaACbcxO4YNzu5EbN847WzLJqBVar2@nongnu.org
X-Gm-Message-State: AOJu0YwDnkMZBvf+/R0f8a+ZNaKTbFdINHmOh3ADpxP+CjvXbksqWYUt
 MIYFGCF5YgrnJtbCIMmMmAA/+T1P8lw1AuE6kzCsglNtxmKGRflMdKzqExRi6E6CGLVSgQvuHVU
 rDgxhz+SPaY3mm43sPsZyJ4WcFAqEJwEqGQc+cXbxp4H5TEnnMyW7waid
X-Gm-Gg: AZuq6aKLYjQ60XzezvT/ghsqeLcHCRdikwLZt2N2ACNAJ1VHBZNboUwr9yf23Vaflb/
 Yic/7uIyuomb1IXZeVdcOoxGCEfWMxPjMGfWa8pLioBIIFMVs0GkfWRQfW3qOEVPPuElNnijBKn
 vgpg7INebbULiyhUoAgtj+gyLuHvOpy3UNnLushcmDkje4Q4rbgWDu7Dz338VkE2dT3Jw1xik+w
 63zhO580hlDvd3IDKSPR6odtnn8gnnHifPKLLxEZCciHIpfOAli4gKcNAyUt4oVYVJh1FPrRSat
 GFyBwuJTcuX6Eh1myXqIHHldFcJhSmpuyfSK+HbN0EPBOttGqlHlr31Dz4pTLEfNi4SokVe8SSy
 kkf6sunCRukw/CLBExaST9dClfH+hW9UEjPbDMnC/uneKqUra/GqBUep++g==
X-Received: by 2002:a5d:64c6:0:b0:431:3ba:1188 with SMTP id
 ffacd0b85a97d-435ca125affmr7952014f8f.3.1769441306346; 
 Mon, 26 Jan 2026 07:28:26 -0800 (PST)
X-Received: by 2002:a5d:64c6:0:b0:431:3ba:1188 with SMTP id
 ffacd0b85a97d-435ca125affmr7951962f8f.3.1769441305819; 
 Mon, 26 Jan 2026 07:28:25 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e7156dsm31701881f8f.20.2026.01.26.07.28.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jan 2026 07:28:25 -0800 (PST)
Message-ID: <053a0274-653e-43d3-8803-f9a97d70166c@redhat.com>
Date: Mon, 26 Jan 2026 16:28:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 15/16] hw/arm/virt-acpi: Advertise Tegra241 CMDQV
 nodes in DSDT
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nicolinc@nvidia.com, nathanc@nvidia.com,
 mochs@nvidia.com, jgg@nvidia.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, kjaju@nvidia.com
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-16-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251210133737.78257-16-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 12/10/25 2:37 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Add ACPI DSDT support for Tegra241 CMDQV when the SMMUv3 instance is
> created with tegra241-cmdqv=on.

Pls can you give a point to the DSDT spec to understand why this is
needed and what needs to be added.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/trace-events      |  1 +
>  hw/arm/virt-acpi-build.c | 74 ++++++++++++++++++++++++++++++++++++++++
>  include/hw/arm/virt.h    |  2 ++
>  3 files changed, 77 insertions(+)
>
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index ef495c040c..e7e3ccfe9f 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -9,6 +9,7 @@ omap1_lpg_led(const char *onoff) "omap1 LPG: LED is %s"
>  
>  # virt-acpi-build.c
>  virt_acpi_setup(void) "No fw cfg or ACPI disabled. Bailing out."
> +virt_acpi_dsdt_tegra241_cmdqv(int smmu_id, uint64_t base, uint32_t irq) "DSDT: add cmdqv node for (id=%d), base=0x%" PRIx64 ", irq=%d"
>  
>  # smmu-common.c
>  smmu_add_mr(const char *name) "%s"
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 4f8d36dae0..11494b29ad 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -1115,6 +1115,78 @@ static void build_fadt_rev6(GArray *table_data, BIOSLinker *linker,
>      build_fadt(table_data, linker, &fadt, vms->oem_id, vms->oem_table_id);
>  }
>  
> +static int smmuv3_cmdqv_devices(Object *obj, void *opaque)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
> +    GArray *sdev_blob = opaque;
> +    PlatformBusDevice *pbus;
> +    AcpiSMMUv3Dev sdev;
> +    SysBusDevice *sbdev;
> +
> +    if (!object_dynamic_cast(obj, TYPE_ARM_SMMUV3)) {
> +        return 0;
> +    }
> +
> +    if (!object_property_get_bool(obj, "tegra241-cmdqv", NULL)) {
> +        return 0;
> +    }
> +
> +    pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
> +    sbdev = SYS_BUS_DEVICE(obj);
> +    sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 1);
> +    sdev.base += vms->memmap[VIRT_PLATFORM_BUS].base;
> +    sdev.irq = platform_bus_get_irqn(pbus, sbdev, NUM_SMMU_IRQS);
> +    sdev.irq += vms->irqmap[VIRT_PLATFORM_BUS];
> +    sdev.irq += ARM_SPI_BASE;
> +    g_array_append_val(sdev_blob, sdev);
> +    return 0;
> +}
> +
> +static void acpi_dsdt_add_tegra241_cmdqv(Aml *scope, VirtMachineState *vms)
> +{
> +    GArray *smmuv3_devs = g_array_new(false, true, sizeof(AcpiSMMUv3Dev));
> +    int i;
> +
> +    if (vms->legacy_smmuv3_present) {
> +        return;
> +    }
> +
> +    object_child_foreach_recursive(object_get_root(), smmuv3_cmdqv_devices,
> +                                   smmuv3_devs);
> +
> +    for (i = 0; i < smmuv3_devs->len; i++) {
> +        uint32_t identifier = i;
> +        AcpiSMMUv3Dev *sdev;
> +        Aml *dev, *crs, *addr;
> +
> +        sdev = &g_array_index(smmuv3_devs, AcpiSMMUv3Dev, i);
> +
> +        dev = aml_device("CV%.02u", identifier);
> +        aml_append(dev, aml_name_decl("_HID", aml_string("NVDA200C")));
> +        if (vms->its) {
> +            identifier++;
> +        }
> +        aml_append(dev, aml_name_decl("_UID", aml_int(identifier)));
> +        aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
> +
> +        crs = aml_resource_template();
> +        addr = aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
> +                                AML_CACHEABLE, AML_READ_WRITE, 0x0, sdev->base,
> +                                sdev->base + TEGRA241_CMDQV_IO_LEN - 0x1, 0x0,
> +                                TEGRA241_CMDQV_IO_LEN);
> +        aml_append(crs, addr);
> +        aml_append(crs, aml_interrupt(AML_CONSUMER, AML_EDGE,
> +                                      AML_ACTIVE_HIGH, AML_EXCLUSIVE,
> +                                      (uint32_t *)&sdev->irq, 1));
> +        aml_append(dev, aml_name_decl("_CRS", crs));
> +
> +        aml_append(scope, dev);
> +
> +        trace_virt_acpi_dsdt_tegra241_cmdqv(identifier, sdev->base, sdev->irq);
> +    }
> +    g_array_free(smmuv3_devs, true);
> +}
> +
>  /* DSDT */
>  static void
>  build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> @@ -1179,6 +1251,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      acpi_dsdt_add_tpm(scope, vms);
>  #endif
>  
> +    acpi_dsdt_add_tegra241_cmdqv(scope, vms);
> +
>      aml_append(dsdt, scope);
>  
>      pci0_scope = aml_scope("\\_SB.PCI0");
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index efbc1758c5..842143cc85 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -46,6 +46,8 @@
>  #define NUM_VIRTIO_TRANSPORTS 32
>  #define NUM_SMMU_IRQS          4
>  
> +#define TEGRA241_CMDQV_IO_LEN 0x50000
isn't it already defined elsewhere, use the corresponding include?

Eric
> +
>  /* See Linux kernel arch/arm64/include/asm/pvclock-abi.h */
>  #define PVTIME_SIZE_PER_CPU 64
>  


