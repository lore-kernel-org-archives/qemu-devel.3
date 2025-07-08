Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766E8C83F0F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFBb-0005mF-7H; Tue, 08 Jul 2025 16:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZDk3-00016v-9g
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:12:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZDju-0006Im-Rc
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752001929;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mRrWJXx5qrcS1aBI12Benqblc8NnA0a1RoEAr2HASco=;
 b=HrjssBpTweVGyGF8tWDmNSunVlTYzgCO8fuy0RsHFFxXFYax5/8cfgLEFI/PHMDXVbrpkx
 +bszdczGyhVbzG9qXbYtdlTyoFxl5DiuFg82UiK41aY3d6mlVUs+s/d4IfpiLvz4CjV5pt
 Gm3DCiP1+JbRfv4sU/HpE903OHEN2Xo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-DQOISW_HOcubMawPRpEg3A-1; Tue, 08 Jul 2025 05:47:28 -0400
X-MC-Unique: DQOISW_HOcubMawPRpEg3A-1
X-Mimecast-MFC-AGG-ID: DQOISW_HOcubMawPRpEg3A_1751968048
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4530c186394so16005985e9.0
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 02:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751968048; x=1752572848;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mRrWJXx5qrcS1aBI12Benqblc8NnA0a1RoEAr2HASco=;
 b=VbhJx8qNOPdCx2nvhrz1z/nXPVyU1SGkM53UwgD5Ku5z+RdqlK2eQ3yIdFAZna8eOZ
 U9T1OqUB8IXaquMROpcSnxsaegEMjeAkwHCiAqlQ/a4gEVchihzZh3NM6fV1YZkK80va
 3dx2xNbeUcCSrTloA1DDYOSwXbwd/CgfyRUZvhJAQ68cBobCb1HxSU/hFdm1FqHyZxgc
 Dy+rkG4kK4gmzoGNNcApejtbebvKhqZaKPJr/ZjaiBs0Zrgvf/4qSy/xr4KPVkRVydqc
 WoQhj1H5Ph5rHt5ydo+nA8SuVQO16MK+8memn0JFeAgrO1KrAogWfAUVnpOaDF5xDGO3
 wBtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQkD0dzM7rczUaCazooD3mgrKFoC4vcmxXUMAE0SOf3+9bHNHZIx8RG8g3WKjBvp3DC7Orhyib0nKm@nongnu.org
X-Gm-Message-State: AOJu0YzM1QEW2SZ1nMAofpiVnfpC5BibFDhoG+EK/pLtg+8Rumzbd0tm
 p1oWDa9OG+Y/09aQUm3jpTO9Obpz6crHStNSTvLdxaCkGuPrrAh4He+IsSeuf7RtsDQKeg3PXh/
 Riry+hOXfuvJhRHkjQihSg+9spCENc72g4cS9paEl2r4pnyfI+7fyYhfU
X-Gm-Gg: ASbGncsIf9/KbRVgEUnzd0w92t69imkRzgkCkd6GGHnUhCK3FXowigc+nIWvN/SLsgn
 eTWbKGehj4SJgy3GZXcvdn79YjUuaCXZwoS0ZmEauMAJMkULBr2I7N0uM5K7qXUJoxfA91yqhVn
 QRAm/pczymoXo/vQAmWIDqDEAuuHiSbfxwfjKokHo20LfTZRmPvdUxz4j2PgE8GnE6Tv2j/Hk0/
 aj7HwafrNXcxR5cSLkz6hRqliUHA3vBxXOFEvnFd9urn+O/96Zq2avRoZMEDTfSXP3pwFRwJMyz
 UxO/HYr0gfoLTE+32hqtYu0eREpiF3Qip2CuqFiDzhlIKHlqKSciIaNBCojwiUhTrRPMoQ==
X-Received: by 2002:a05:600c:3f0f:b0:43d:4e9:27ff with SMTP id
 5b1f17b1804b1-454c81f53a7mr53171955e9.7.1751968047535; 
 Tue, 08 Jul 2025 02:47:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENoSXQ2UTf8DjWAuOH3p/YeR2S91YyiJFG62xpbTnNJ9KLyf50vPX6WemiYtAk4Ijshv4+3Q==
X-Received: by 2002:a05:600c:3f0f:b0:43d:4e9:27ff with SMTP id
 5b1f17b1804b1-454c81f53a7mr53171615e9.7.1751968047020; 
 Tue, 08 Jul 2025 02:47:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd3d806bsm16913555e9.33.2025.07.08.02.47.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 02:47:26 -0700 (PDT)
Message-ID: <785c5904-001b-4e1b-8fae-9b8539668e96@redhat.com>
Date: Tue, 8 Jul 2025 11:47:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/12] hw/arm/virt: Allow user-creatable SMMUv3 dev
 instantiation
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "gustavo.romero@linaro.org" <gustavo.romero@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20250703084643.85740-1-shameerali.kolothum.thodi@huawei.com>
 <20250703084643.85740-9-shameerali.kolothum.thodi@huawei.com>
 <b05cd1f5-db7a-45d3-a582-85c808adcd04@redhat.com>
 <e4cd2ccede7b46df9bbcf63dcf492fcf@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <e4cd2ccede7b46df9bbcf63dcf492fcf@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,

On 7/8/25 10:54 AM, Shameerali Kolothum Thodi wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Tuesday, July 8, 2025 8:41 AM
>> To: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
>> qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; jgg@nvidia.com; nicolinc@nvidia.com;
>> ddutile@redhat.com; berrange@redhat.com; imammedo@redhat.com;
>> nathanc@nvidia.com; mochs@nvidia.com; smostafa@google.com;
>> gustavo.romero@linaro.org; mst@redhat.com;
>> marcel.apfelbaum@gmail.com; Linuxarm <linuxarm@huawei.com>;
>> Wangzhou (B) <wangzhou1@hisilicon.com>; jiangkunkun
>> <jiangkunkun@huawei.com>; Jonathan Cameron
>> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
>> Subject: Re: [PATCH v6 08/12] hw/arm/virt: Allow user-creatable SMMUv3
>> dev instantiation
>>
>> Hi Shameer,
>>
>> On 7/3/25 10:46 AM, Shameer Kolothum wrote:
>>> Allow cold-plugging of an SMMUv3 device on the virt machine when no
>>> global (legacy) SMMUv3 is present or when a virtio-iommu is specified.
>>>
>>> This user-created SMMUv3 device is tied to a specific PCI bus provided
>>> by the user, so ensure the IOMMU ops are configured accordingly.
>>>
>>> Due to current limitations in QEMU’s device tree support, specifically
>>> its inability to properly present pxb-pcie based root complexes and
>>> their devices, the device tree support for the new SMMUv3 device is
>>> limited to cases where it is attached to the default pcie.0 root complex.
>>>
>>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>> Tested-by: Nathan Chen <nathanc@nvidia.com>
>>> Signed-off-by: Shameer Kolothum
>> <shameerali.kolothum.thodi@huawei.com>
>>> ---
>>>  hw/arm/smmu-common.c         |  8 +++++-
>>>  hw/arm/smmuv3.c              |  2 ++
>>>  hw/arm/virt.c                | 50 ++++++++++++++++++++++++++++++++++++
>>>  hw/core/sysbus-fdt.c         |  3 +++
>>>  include/hw/arm/smmu-common.h |  1 +
>>>  5 files changed, 63 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>>> index b15e7fd0e4..2ee4691299 100644
>>> --- a/hw/arm/smmu-common.c
>>> +++ b/hw/arm/smmu-common.c
>>> @@ -959,7 +959,12 @@ static void smmu_base_realize(DeviceState *dev,
>> Error **errp)
>>>                  goto out_err;
>>>              }
>>>          }
>>> -        pci_setup_iommu(pci_bus, &smmu_ops, s);
>>> +
>>> +        if (s->smmu_per_bus) {
>>> +            pci_setup_iommu_per_bus(pci_bus, &smmu_ops, s);
>>> +        } else {
>>> +            pci_setup_iommu(pci_bus, &smmu_ops, s);
>>> +        }
>>>          return;
>>>      }
>>>  out_err:
>>> @@ -984,6 +989,7 @@ static void smmu_base_reset_exit(Object *obj,
>> ResetType type)
>>>  static const Property smmu_dev_properties[] = {
>>>      DEFINE_PROP_UINT8("bus_num", SMMUState, bus_num, 0),
>>> +    DEFINE_PROP_BOOL("smmu_per_bus", SMMUState, smmu_per_bus,
>> false),
>>>      DEFINE_PROP_LINK("primary-bus", SMMUState, primary_bus,
>>>                       TYPE_PCI_BUS, PCIBus *),
>>>  };
>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>> index ab67972353..bcf8af8dc7 100644
>>> --- a/hw/arm/smmuv3.c
>>> +++ b/hw/arm/smmuv3.c
>>> @@ -1996,6 +1996,8 @@ static void smmuv3_class_init(ObjectClass
>> *klass, const void *data)
>>>      device_class_set_parent_realize(dc, smmu_realize,
>>>                                      &c->parent_realize);
>>>      device_class_set_props(dc, smmuv3_properties);
>>> +    dc->hotpluggable = false;
>>> +    dc->user_creatable = true;
>>>  }
>>>
>>>  static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>>> index 05a14881cf..8662173c43 100644
>>> --- a/hw/arm/virt.c
>>> +++ b/hw/arm/virt.c
>>> @@ -56,6 +56,7 @@
>>>  #include "qemu/cutils.h"
>>>  #include "qemu/error-report.h"
>>>  #include "qemu/module.h"
>>> +#include "hw/pci/pci_bus.h"
>>>  #include "hw/pci-host/gpex.h"
>>>  #include "hw/virtio/virtio-pci.h"
>>>  #include "hw/core/sysbus-fdt.h"
>>> @@ -1440,6 +1441,28 @@ static void create_smmuv3_dt_bindings(const
>> VirtMachineState *vms, hwaddr base,
>>>      g_free(node);
>>>  }
>>>
>>> +static void create_smmuv3_dev_dtb(VirtMachineState *vms,
>>> +                                  DeviceState *dev, PCIBus *bus)
>>> +{
>>> +    PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms-
>>> platform_bus_dev);
>>> +    SysBusDevice *sbdev = SYS_BUS_DEVICE(dev);
>>> +    int irq = platform_bus_get_irqn(pbus, sbdev, 0);
>>> +    hwaddr base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
>>> +    MachineState *ms = MACHINE(vms);
>>> +
>>> +    if (strcmp("pcie.0", bus->qbus.name)) {
>>> +        warn_report("SMMUv3 device only supported with pcie.0 for DT");
>> while testing the series I hit the warning with a rhel guest which boots
>> with ACPI.
>> I think we shall make the check smarter to avoid that.
>> maybe also check firmware_loaded and virt_is_acpi_enabled()?
> Thanks for giving it a spin. Yes, just confirmed that the warning appears.
> The above check will work, but can we make use of vms->acpi_dev for
> this check instead? It is essentially the same and I think that will work. 
>
>     if (!vms->acpi_dev && strcmp("pcie.0", bus->qbus.name))
the logical dependency on acpi_dev is maybe not that straightforward.
Also it has has_ged and aarch64 check
I thing I would simply check !(firmware_loaded &&
virt_is_acpi_enabled(vms)). about the aarch64 check I am not sure this
is needed.

Eric
>
> Please let me know.
>
> Thanks,
> Shameer


