Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00716C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 10:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBso9-0002hw-HU; Mon, 05 May 2025 06:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uBso8-0002hR-13
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:12:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uBso6-0007mB-7l
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746439937;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0R9usPeUA1xEusdU6KHmrPie0a1++LA2whaPmgq6w40=;
 b=EQYx5lx3CzH9EP9K+ntvKPkT04gfECIVOpAgVZkQHSGytrQ7bsN5L7hFnsB6ljmx+/UOII
 97wcvuIEqcATNQw1vtS/2GWnoMzPyivfGXszOfF+dBAw+gWHYE9RMxv0dE5+mN4/yTrLiJ
 MCMQ6ssRqj5Vi+YLqCoTw8g2aNnwlWE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-eqzA4RGkOwWwU-r5VjW8VA-1; Mon, 05 May 2025 06:12:16 -0400
X-MC-Unique: eqzA4RGkOwWwU-r5VjW8VA-1
X-Mimecast-MFC-AGG-ID: eqzA4RGkOwWwU-r5VjW8VA_1746439935
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39abdadb0f0so1114903f8f.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 03:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746439934; x=1747044734;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0R9usPeUA1xEusdU6KHmrPie0a1++LA2whaPmgq6w40=;
 b=I7N/IfAXA72MIbgALmBYBzxTFQKjJ6vLB0M474DdnJDq9KRq12XwbBtHB7effFHgfz
 278AmdP+ZmyNu1Kfhvsc0tYs9lkiEN2746al7HXDBwJNPsjI9okwLyPIa+3hrDUT1kKL
 /HewnEjwDjJDQHVSk4/9d1bTDnHRL7OuPIl8fAVUnYchnFEYpcDbNuSYKdKIWVQDodUM
 zulnSxz390RV9QLMzYkigkwVlx3ioor4KOrM2xnw1NpP3VvW0TF58TFuS55k/5WjHSIG
 MO0wVhddM7Rjjcizcg/IfJat/+LC1n9m6ZmEZevfezVJeeraLelk3xoCVtQ6lpUN0lBw
 aujg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBROZ1ccLfDmcn/TVC+UdjfQZ8gGLA6vOcO8RHl3POgO8+xmTsQLFZ1mXYv+Y594psOBuyndR6fCzL@nongnu.org
X-Gm-Message-State: AOJu0YxO1epsHFei8OOWwFCQrrRyeYun9HH86XcqguFmgy83tlAn056F
 oda6kSNDxObl5A/7TgyyqEqpb1yw0phqH3lR5801QR7ajpA8yrmechPwW4qNGnT0LVGn3a5Ss+4
 PYY9xd5eXCADIUqJHFKIAm7oBFG9z96DsbPQpDOFmFKQg+0td/ubMFW+oUB5Q
X-Gm-Gg: ASbGnctXnYlRvkM9ScEA6D4PEx4kJAR9KLJ1xPScnPC0/k8mOz+q3jWv/xeya0sGJNx
 b5l8Bl3H4iN478qfVUCjnEoui6S1NHZOzXrP6sicSvl6fYzh3oEz2U/vTDvoVoM+guP6D+eFXg+
 NdRHUm0rYwvyiMSVvE6vMLS5islx/Ag8MgdQ/LCCSbn7Rj+FUeYOotncEx5aD/6WnF3S1k5PH/q
 uAAukmR0cx3x7yFpeB68yt/W2A90jz+jvRxpYru3nM59cL1b+3E62uT1JsUmzRLzV3Gd6pwNnui
 fDSfcHl4V/y/TmirPPGvnCDMTiDAtbtZs7sFym6cBZx/Uj3ZFNjXCgrBHzM=
X-Received: by 2002:a5d:64e7:0:b0:39c:1257:c96c with SMTP id
 ffacd0b85a97d-3a09fdd7c7cmr5628071f8f.56.1746439934189; 
 Mon, 05 May 2025 03:12:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr2iLtnawm/a8K3IuazQ52VodzAXPwag3D5MrmPeXDpRsn9kgH80u2YNtbwG0BOzcExGqktw==
X-Received: by 2002:a5d:64e7:0:b0:39c:1257:c96c with SMTP id
 ffacd0b85a97d-3a09fdd7c7cmr5628055f8f.56.1746439933846; 
 Mon, 05 May 2025 03:12:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae3cfbsm9760085f8f.40.2025.05.05.03.12.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 03:12:13 -0700 (PDT)
Message-ID: <52d633c6-cd45-4f00-ac7b-fc91724818d1@redhat.com>
Date: Mon, 5 May 2025 12:12:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] hw/arm/virt: Add support for smmuv3 device
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-6-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250502102707.110516-6-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/2/25 12:27 PM, Shameer Kolothum wrote:
I would change the title into something like "Allow -device arm-smmuv3
instantiation"
> Allow cold-plug of smmuv3 device to virt if there is no machine
> wide legacy smmuv3 or a virtio-iommu is specified.
>
> Device tree support for new smmuv3 dev is limited to the case where
> it is associated with the default pcie.0 RC.
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/virt.c        | 48 ++++++++++++++++++++++++++++++++++++++++++++
>  hw/core/sysbus-fdt.c |  3 +++
>  2 files changed, 51 insertions(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index e178282d71..f6ff584bac 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1449,6 +1449,31 @@ static void create_smmuv3_dt_bindings(const VirtMachineState *vms, hwaddr base,
>      g_free(node);
>  }
>  
> +static void create_smmuv3_dev_dtb(VirtMachineState *vms,
> +                                  DeviceState *dev)
> +{
> +    PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
> +    SysBusDevice *sbdev = SYS_BUS_DEVICE(dev);
> +    int irq = platform_bus_get_irqn(pbus, sbdev, 0);
> +    hwaddr base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
> +    MachineState *ms = MACHINE(vms);
> +    PCIBus *bus;
> +
> +    bus = PCI_BUS(object_property_get_link(OBJECT(dev), "primary-bus",
> +                                           &error_abort));
> +    if (strcmp("pcie.0", bus->qbus.name)) {
> +        warn_report("SMMUv3 device only supported with pcie.0 for DT");
> +        return;
> +    }
> +    base += vms->memmap[VIRT_PLATFORM_BUS].base;
> +    irq += vms->irqmap[VIRT_PLATFORM_BUS];
> +
> +    vms->iommu_phandle = qemu_fdt_alloc_phandle(ms->fdt);
> +    create_smmuv3_dt_bindings(vms, base, SMMU_IO_LEN, irq);
> +    qemu_fdt_setprop_cells(ms->fdt, vms->pciehb_nodename, "iommu-map",
> +                           0x0, vms->iommu_phandle, 0x0, 0x10000);
> +}
> +
>  static void create_smmu(const VirtMachineState *vms,
>                          PCIBus *bus)
>  {
> @@ -2949,6 +2974,13 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>          qlist_append_str(reserved_regions, resv_prop_str);
>          qdev_prop_set_array(dev, "reserved-regions", reserved_regions);
>          g_free(resv_prop_str);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_ARM_SMMUV3)) {
> +        if (vms->legacy_smmuv3_present || vms->iommu == VIRT_IOMMU_VIRTIO) {
> +            error_setg(errp, "virt machine already has %s set. "
> +                       "Doesn't support incompatible iommus",
> +                       (vms->legacy_smmuv3_present) ?
> +                       "iommu=smmuv3" : "virtio-iommu");
what about bypass mode?
> +        }
>      }
>  }
>  
> @@ -2972,6 +3004,21 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>          virtio_md_pci_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
>      }
>  
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_ARM_SMMUV3)) {
> +        if (!vms->legacy_smmuv3_present && vms->platform_bus_dev) {
this answers my previous comment ;-)
> +            VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
> +
> +            create_smmuv3_dev_dtb(vms, dev);
> +            if (vms->iommu != VIRT_IOMMU_SMMUV3) {
> +                vms->iommu = VIRT_IOMMU_SMMUV3;
> +            }
> +            if (!vmc->no_nested_smmu) {
> +                object_property_set_str(OBJECT(dev), "stage", "nested",
> +                                        &error_fatal);
> +            }
> +        }
> +    }
> +
>      if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
>          PCIDevice *pdev = PCI_DEVICE(dev);
>  
> @@ -3174,6 +3221,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_PLATFORM);
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ARM_SMMUV3);
>  #ifdef CONFIG_TPM
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
>  #endif
> diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
> index c339a27875..d778c0f559 100644
> --- a/hw/core/sysbus-fdt.c
> +++ b/hw/core/sysbus-fdt.c
> @@ -31,6 +31,7 @@
>  #include "qemu/error-report.h"
>  #include "system/device_tree.h"
>  #include "system/tpm.h"
> +#include "hw/arm/smmuv3.h"
>  #include "hw/platform-bus.h"
>  #include "hw/vfio/vfio-platform.h"
>  #include "hw/vfio/vfio-calxeda-xgmac.h"
> @@ -513,6 +514,8 @@ static const BindingEntry bindings[] = {
>  #ifdef CONFIG_LINUX
>      TYPE_BINDING(TYPE_VFIO_CALXEDA_XGMAC, add_calxeda_midway_xgmac_fdt_node),
>      TYPE_BINDING(TYPE_VFIO_AMD_XGBE, add_amd_xgbe_fdt_node),
> +    /* No generic DT support for smmuv3 dev. Support added for arm virt only */
> +    TYPE_BINDING(TYPE_ARM_SMMUV3, no_fdt_node),
Can't it live outside the CONFIG_LINUX?


>      VFIO_PLATFORM_BINDING("amd,xgbe-seattle-v1a", add_amd_xgbe_fdt_node),
>  #endif
>  #ifdef CONFIG_TPM
Eric


