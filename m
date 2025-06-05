Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8F0C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 09:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN7MQ-0007xH-5n; Thu, 05 Jun 2025 05:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uN7M7-0007uB-3L
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:57:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uN7Lz-0003cn-4i
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749117461;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TieOlgHooLkokUg3x114IwTpM6FU/JsGy69Sghmnwqc=;
 b=iA+S/OJbt+MFT6FIYbKN2SKEhma+Jck5jN8ntARzQC+56AnlGb77+JXsizIo088VjQFYsO
 kwbwGBFVouChUjVeC5f6xPSnSFCBRufCsQ4m6DJ23+zALpdHYa7VUNYg5kvg3j8c0y046z
 R6v4qWgSnXbN4ExR71ToqWxQ3A3qzWQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-IcZ2OyuwOICYAg3aMNqbqQ-1; Thu, 05 Jun 2025 05:57:40 -0400
X-MC-Unique: IcZ2OyuwOICYAg3aMNqbqQ-1
X-Mimecast-MFC-AGG-ID: IcZ2OyuwOICYAg3aMNqbqQ_1749117459
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-451d7de4ae3so4324705e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 02:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749117459; x=1749722259;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TieOlgHooLkokUg3x114IwTpM6FU/JsGy69Sghmnwqc=;
 b=JrfqhsGLBhH/PWKXA9s9vHzldcGDsA7mm0o/2JrKXIpw9SvbSSCTph11Jn5Q87TPhn
 r9QvsYvgQbIrTRruAwfkxLi1PyE0uqT0utGEzSSSo9xQwJwG6NS1LhYVYwG+Whm770wa
 rK8+I9h/QRO0XU/SV5QPzErNHm96wk9PJjpP2XgSOvcD/YcsR07IUx0MRjSZJF14/Ddp
 5u70TikCNvhRvqOmFKMRirjbQMut8am2Og8/LcpJCoFIh2ib+qTaBKs7+Bl0aoT9B4Tw
 2RrJY4BJaYfkOyeyu0hfhzM7VDsDy1IMBa1APkPTzLHIbVuzj1VWgt7MpEnTqbdFtaDU
 Aumw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvOMAUzMiGAIQRrNcr/G9NicCfjpO/ljxE5ezNmSJoo4GKy0rzzuIn2i+DTuNeCHu7up3ohplZPYMN@nongnu.org
X-Gm-Message-State: AOJu0YzeFgxupkthTDjFPCicSRNOqOIZ6jift8nd+isrLKHyQW3vs+9L
 EtsCu6h2gOCpLytiI+epkZy+A5+2O7Rk46J/cT14rpLKag5F+hB04IT/AV23VFqF+lxbTfZsEiR
 GNDRRB6dSeN5hrPGx9AHJVInfetErK+U/LCfdnQ5RK1+uG7xsS+UK6STt
X-Gm-Gg: ASbGncu2MXUcogOSR+a6hQ42G+MyQIZsNW9toxA59Qg9knSIewRl5MwNa2yjJEVEMO4
 y129CaqQNr2PzURVx+vNQgQn4X5obGD6XDvBirkQJ3hjKN7cA9UVxTDeYO7ajw9sPFalaMuDRAw
 nOvGLx6Kcx8wzs6P+e5rzb6aOfAdLVl9rN+3W2fO+ZpCuTbQXwZy1KQ6wMlNBkIPwrxYiLBIK/z
 /+e9rg6Vimz4zWD9GltT7o7uHCtdojl8+OY5/5hdDvji7Sc+s044jmzDd/MS0oA2acxnMze2J29
 gfKlSUL2+JTlV8ORk7qrMNCt8iUmCw05BCCymyfl8Vy3UfFVEMMYxswpZCQ=
X-Received: by 2002:a05:600c:1c96:b0:450:d019:263 with SMTP id
 5b1f17b1804b1-451f0b0f5a1mr64250565e9.18.1749117458724; 
 Thu, 05 Jun 2025 02:57:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXeVpRX6zejrPlEeVkZZUi7Oo3xN3oMA8Hf1fUVSiuqFtK3UTxAN04rsZLryCq4iqfpdGLxw==
X-Received: by 2002:a05:600c:1c96:b0:450:d019:263 with SMTP id
 5b1f17b1804b1-451f0b0f5a1mr64250225e9.18.1749117458321; 
 Thu, 05 Jun 2025 02:57:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451fb220569sm13053125e9.29.2025.06.05.02.57.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 02:57:37 -0700 (PDT)
Message-ID: <af1f7082-dc4b-4f44-9b85-aa6ba9221e71@redhat.com>
Date: Thu, 5 Jun 2025 11:57:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] hw/arm/virt-acpi-build: Update IORT for multiple
 smmuv3 devices
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250602154110.48392-1-shameerali.kolothum.thodi@huawei.com>
 <20250602154110.48392-4-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250602154110.48392-4-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,
On 6/2/25 5:41 PM, Shameer Kolothum wrote:
> With the soon to be introduced user-creatable SMMUv3 devices for
> virt, it is possible to have multiple SMMUv3 devices associated
> with different PCIe root complexes.
>
> Update IORT nodes accordingly.
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/virt-acpi-build.c | 54 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index bd26853ef6..b4ff71b8b7 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -43,6 +43,7 @@
>  #include "hw/acpi/generic_event_device.h"
>  #include "hw/acpi/tpm.h"
>  #include "hw/acpi/hmat.h"
> +#include "hw/arm/smmuv3.h"
>  #include "hw/pci/pcie_host.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_bus.h"
> @@ -288,6 +289,54 @@ get_smmuv3_legacy_dev(VirtMachineState *vms, void *opaque)
>      g_array_append_val(sdev_blob, sdev);
>  }
>  
> +static int smmuv3_dev_idmap_compare(gconstpointer a, gconstpointer b)
> +{
> +    AcpiIortSMMUv3Dev *sdev_a = (AcpiIortSMMUv3Dev *)a;
> +    AcpiIortSMMUv3Dev *sdev_b = (AcpiIortSMMUv3Dev *)b;
> +    AcpiIortIdMapping *map_a = &g_array_index(sdev_a->idmaps,
> +                                              AcpiIortIdMapping, 0);
> +    AcpiIortIdMapping *map_b = &g_array_index(sdev_b->idmaps,
> +                                              AcpiIortIdMapping, 0);
> +    return map_a->input_base - map_b->input_base;
> +}
> +
> +static int get_smmuv3_devices(Object *obj, void *opaque)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
> +    GArray *sdev_blob = opaque;
> +    AcpiIortIdMapping idmap;
> +    PlatformBusDevice *pbus;
> +    AcpiIortSMMUv3Dev sdev;
> +    int min_bus, max_bus;
> +    SysBusDevice *sbdev;
> +    PCIBus *bus;
> +
> +    if (!object_dynamic_cast(obj, TYPE_ARM_SMMUV3)) {
> +        return 0;
> +    }
> +
> +    bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
> +    if (!bus) {
> +        return 0;
> +    }
can it happen after patch 1?
> +
> +    pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
> +    sbdev = SYS_BUS_DEVICE(obj);
> +    sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
> +    sdev.base += vms->memmap[VIRT_PLATFORM_BUS].base;
> +    sdev.irq = platform_bus_get_irqn(pbus, sbdev, 0);
> +    sdev.irq += vms->irqmap[VIRT_PLATFORM_BUS];
> +    sdev.irq += ARM_SPI_BASE;
> +
> +    pci_bus_range(bus, &min_bus, &max_bus);
> +    sdev.idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
> +    idmap.input_base = min_bus << 8,
> +    idmap.id_count = (max_bus - min_bus + 1) << 8,
> +    g_array_append_val(sdev.idmaps, idmap);
> +    g_array_append_val(sdev_blob, sdev);
> +    return 0;
> +}
> +
>  /*
>   * Input Output Remapping Table (IORT)
>   * Conforms to "IO Remapping Table System Software on ARM Platforms",
> @@ -319,6 +368,11 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>           */
>          sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, 0);
>          g_array_sort(sdev->idmaps, iort_idmap_compare);
> +    } else {
> +        object_child_foreach_recursive(object_get_root(),
> +                                       get_smmuv3_devices, smmuv3_devs);
> +        /* Sort the smmuv3 devices(if any) by smmu idmap input_base */
> +        g_array_sort(smmuv3_devs, smmuv3_dev_idmap_compare);
Given the gorwing complexity of the IDMAP computation computation I
would suggest to add some IDMAP examples either in comment or commit msg
to illustrate how the idmaps look like (similar to what can be found in
the IORT spec).

Thanks

Eric
>      }
>  
>      num_smmus = smmuv3_devs->len;


