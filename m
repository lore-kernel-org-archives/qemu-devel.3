Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3226FC5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 12:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN9yP-00030N-6U; Thu, 05 Jun 2025 08:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uN9yG-0002y2-Rp
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 08:45:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uN9yA-0002Zs-Py
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 08:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749127517;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wCkw4BoI1QVAwm6Z4o8j5v3Q/B10/HA0UwU8zz1Aer0=;
 b=D4IBiKZw2zyABTwPAdX5TIy9xF9v6g/eRWiXrrx/TG2ZmIlkJSMMbSxXBf6c+GoPb0AcBd
 j054uGkdMocjEr4IjvaC/ceiBTuWNyyziBPdzxIWsTR/0aR/fgqDz7qMV9x/zIdU9is1Pb
 pgKsx+a5Z47jBVYZ3pOdtMqxJHz8FSQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-8YPWNBwVPPSfIJo_yTeuXA-1; Thu, 05 Jun 2025 08:45:16 -0400
X-MC-Unique: 8YPWNBwVPPSfIJo_yTeuXA-1
X-Mimecast-MFC-AGG-ID: 8YPWNBwVPPSfIJo_yTeuXA_1749127516
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-451ac1b43c4so5396445e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 05:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749127515; x=1749732315;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wCkw4BoI1QVAwm6Z4o8j5v3Q/B10/HA0UwU8zz1Aer0=;
 b=kZOehkP75WBOKZMgaHfvoU62cT9NcINhbWtMVOUGprRr8XWUOYQa1woqG1ITjmQW9c
 1N7X1+dBrkBcHWT4ZM+xFLsuvM7S5xhdjDtOMTmmlSup/xapiISpGRxw8P2EmXve3zkt
 1Yf89oGP4Wjn+DGykDWadkct0brX3KowA1wG7IFd6WnBRbwOuWKGfvGNXEo4bfPPYp3n
 434d9QGJXfjOABWdjyNfYf2S2POFEyx0jF6H7m9MtAnQ4O8Y2d9p6a1f2zcllgsgP9EB
 QPAcz6vscQAhs9FIlb4sv4Gkdg6Qa96OkHnQ++exeH28NwPtiits2jipFA4m0fDJlf9U
 FeZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVuz+nYY6gILRsdJyc9HbkaJblHi4P5dDT2uZQGDWWD75GLqIkQDon8Fb9UrQwuyzZ3SS2775XUG6U@nongnu.org
X-Gm-Message-State: AOJu0YzYd/j2n2mNLWg3WXl0O5Tvv9lJUHnjw9DxYbDSnBGNh/VGb2WU
 nVAjkkMvXa0s8zCwMRBF8MC3th55rSjVH+G/o9PLqOFVrPm0XeAkh+S8LkhVdQ8H14vq9TqWQkz
 +0amVpAoulkOdtEOrRAJCmD6oolkO+idvYDZH4aUPuokVxZkZ5NGRPD9t
X-Gm-Gg: ASbGnctC1JVpzviCYx2Kst5O/DhNw6VCiONcMm3zXWgUINZuuJb471qgyvbK8SwUfNu
 EtQ3Hfi8BsO9u/fdp6ZlUS9wy2Zm1SdprkFSlH+6WtVb3q95ufQLN67TnLmVPFf4yzQadL66+0S
 4RNQpX7V+5ukHhBgPXwHpEodq0llmApmEcCzPxrWiywo8jAYOo76dsia0JwblsNF5toSgTKVLdr
 T4ySYTVz/j4jFvy3kUv7pIWJIRzcqauIcPlVcmo+q/lbQencwnfUWcmBstOQ7UsKCHYfwB7K7in
 N5n4IlZe1UWi94/zUTOCcC7UsMPhkreV1j2LyLZlzyROcOtigKYGVRpkbbw=
X-Received: by 2002:a05:600c:4691:b0:445:49e:796b with SMTP id
 5b1f17b1804b1-451f0b10a06mr71064275e9.17.1749127515389; 
 Thu, 05 Jun 2025 05:45:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7qFytxw23K4EHhcoHr1W2Pt2LAHUEROryO4xKT9IJ15ptNynGhxrd3xo75wPTBZ1dtGkHZQ==
X-Received: by 2002:a05:600c:4691:b0:445:49e:796b with SMTP id
 5b1f17b1804b1-451f0b10a06mr71063885e9.17.1749127514902; 
 Thu, 05 Jun 2025 05:45:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451fb208926sm18145825e9.23.2025.06.05.05.45.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 05:45:13 -0700 (PDT)
Message-ID: <f7231c75-b060-484d-a02a-51da624cb1a0@redhat.com>
Date: Thu, 5 Jun 2025 14:45:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] hw/arm/virt: Allow user-creatable SMMUv3 dev
 instantiation
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250602154110.48392-1-shameerali.kolothum.thodi@huawei.com>
 <20250602154110.48392-7-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250602154110.48392-7-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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



On 6/2/25 5:41 PM, Shameer Kolothum wrote:
> Allow cold-plug of smmuv3 device to virt if there is no machine
> wide legacy smmuv3 or a virtio-iommu is specified.
>
> Device tree support for new smmuv3 dev is limited to the case where
> it is associated with the default pcie.0 RC.
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/smmuv3.c      |  2 ++
>  hw/arm/virt.c        | 50 ++++++++++++++++++++++++++++++++++++++++++++
>  hw/core/sysbus-fdt.c |  3 +++
>  3 files changed, 55 insertions(+)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 7e934336c2..d1f66dcd8f 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -2004,6 +2004,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>      device_class_set_parent_realize(dc, smmu_realize,
>                                      &c->parent_realize);
>      device_class_set_props(dc, smmuv3_properties);
> +    dc->hotpluggable = false;
> +    dc->user_creatable = true;
>  }
>  
>  static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index eeace4754d..04bc940fc3 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -56,6 +56,7 @@
>  #include "qemu/cutils.h"
>  #include "qemu/error-report.h"
>  #include "qemu/module.h"
> +#include "hw/pci/pci_bus.h"
>  #include "hw/pci-host/gpex.h"
>  #include "hw/virtio/virtio-pci.h"
>  #include "hw/core/sysbus-fdt.h"
> @@ -1443,6 +1444,28 @@ static void create_smmuv3_dt_bindings(const VirtMachineState *vms, hwaddr base,
>      g_free(node);
>  }
>  
> +static void create_smmuv3_dev_dtb(VirtMachineState *vms,
> +                                  DeviceState *dev, PCIBus *bus)
> +{
> +    PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
> +    SysBusDevice *sbdev = SYS_BUS_DEVICE(dev);
> +    int irq = platform_bus_get_irqn(pbus, sbdev, 0);
> +    hwaddr base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
> +    MachineState *ms = MACHINE(vms);
> +
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
wondering whether you couldn't have put that code in hw/core/sysbus-fdt.c
just like add_calxeda_midway_xgmac_fdt_node(). vms can be retrieved from
the object hierarchy I guess.

Actually the original infra was made in that spirit. Now I know that
Peter is not a big fan of all those VFIO platform related stuff ;-) so I
have no strong opinion either.
> +
>  static void create_smmu(const VirtMachineState *vms,
>                          PCIBus *bus)
>  {
> @@ -2931,6 +2954,13 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>          qlist_append_str(reserved_regions, resv_prop_str);
>          qdev_prop_set_array(dev, "reserved-regions", reserved_regions);
>          g_free(resv_prop_str);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_ARM_SMMUV3)) {
> +        if (vms->legacy_smmuv3_present || vms->iommu == VIRT_IOMMU_VIRTIO) {
> +            error_setg(errp, "virt machine already has %s set. "
> +                       "Doesn't support incompatible iommus",
> +                       (vms->legacy_smmuv3_present) ?
> +                       "iommu=smmuv3" : "virtio-iommu");
> +        }
>      }
>  }
>  
> @@ -2954,6 +2984,25 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>          virtio_md_pci_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
>      }
>  
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_ARM_SMMUV3)) {
> +        if (!vms->legacy_smmuv3_present && vms->platform_bus_dev) {
> +            PCIBus *bus;
> +
> +            bus = PCI_BUS(object_property_get_link(OBJECT(dev), "primary-bus",
> +                                                   &error_abort));
> +            if (pci_bus_bypass_iommu(bus)) {
> +                error_setg(errp, "Bypass option cannot be set for SMMUv3 "
> +                           "associated PCIe RC");
> +                return;
> +            }
> +
> +            create_smmuv3_dev_dtb(vms, dev, bus);
> +            if (vms->iommu != VIRT_IOMMU_SMMUV3) {
is it worth to check given the check done in
virt_machine_device_pre_plug_cb()?
        if (vms->legacy_smmuv3_present || vms->iommu == VIRT_IOMMU_VIRTIO) {

Cheers

Eric
> +                vms->iommu = VIRT_IOMMU_SMMUV3;
> +            }
> +        }
> +    }
> +
>      if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
>          PCIDevice *pdev = PCI_DEVICE(dev);
>  
> @@ -3156,6 +3205,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_PLATFORM);
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ARM_SMMUV3);
>  #ifdef CONFIG_TPM
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
>  #endif
> diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
> index c339a27875..e80776080b 100644
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
> @@ -518,6 +519,8 @@ static const BindingEntry bindings[] = {
>  #ifdef CONFIG_TPM
>      TYPE_BINDING(TYPE_TPM_TIS_SYSBUS, add_tpm_tis_fdt_node),
>  #endif
> +    /* No generic DT support for smmuv3 dev. Support added for arm virt only */
> +    TYPE_BINDING(TYPE_ARM_SMMUV3, no_fdt_node),
>      TYPE_BINDING(TYPE_RAMFB_DEVICE, no_fdt_node),
>      TYPE_BINDING(TYPE_UEFI_VARS_SYSBUS, add_uefi_vars_node),
>      TYPE_BINDING("", NULL), /* last element */


