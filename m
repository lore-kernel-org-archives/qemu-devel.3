Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D62C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 08:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBr3M-0007rz-7L; Mon, 05 May 2025 04:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uBr2i-0007kr-Jx
 for qemu-devel@nongnu.org; Mon, 05 May 2025 04:19:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uBr2g-000405-Lb
 for qemu-devel@nongnu.org; Mon, 05 May 2025 04:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746433154;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZiiD4ub45n6wjGHUVcmoDtrZrSOwJUWD5UkM8L/cXm8=;
 b=InrQmx/8gUZ5oVGOm3nMi7Q3STm17598WmcZUMm1xTHMdw9sUd/IytL408u8l9kDENqM1K
 wgoRjg3l5MTwZOKvkgWPJPvQCfVEBMTymSb3QEgAYI+OmKq3eftW55TjUxUEXocz894ycd
 gTvmMcSx15Z3Cyyz/3M5E64EnY3Nbko=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-HGFUfGjhPtq0nkReu_GXPQ-1; Mon, 05 May 2025 04:19:12 -0400
X-MC-Unique: HGFUfGjhPtq0nkReu_GXPQ-1
X-Mimecast-MFC-AGG-ID: HGFUfGjhPtq0nkReu_GXPQ_1746433151
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39131851046so784896f8f.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 01:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746433151; x=1747037951;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZiiD4ub45n6wjGHUVcmoDtrZrSOwJUWD5UkM8L/cXm8=;
 b=jOezWJJDgRy0Ik/IAuN74m+guCiTCtlsb564S7nGMHRDfmQ+8XK2tkw3ynkuqlxu0f
 mOWLPLkonWPaypoxwPbwjYTlg7ryyG8ZiZSLyDpWIjOLFR+iCAFFZ/AUVGV8RoxZ92uA
 nKMybGo1itWeFt4uVR9purTECPwqRSm2gPsQI/SXIWY5UXs+9NPW81yUccKfvw9kQm1S
 ps8zXlH8FA8wZvQsRM626DLruUSAlALjZVbm3FQUqjbr2FygAkYhYqpvUz8znIv7xV95
 EkyX24TZPINeexY4N5C78JTfiv9GlII0UIUFwBThzsGxAbnM9BU2oDXSN2ggqFIoBJnA
 s64A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5vBzC1X5w9HyaHCjp8IoKrhz1lWrvrj0W2QMsmH9IyQox0omwY4Va/Dpdh2H4Aj7ECEJ/TX0ijMic@nongnu.org
X-Gm-Message-State: AOJu0Yw8KRPqb9/jqSwP8RFnVF9NriaDc6PjdVyVjERDC0uCfE06cFfa
 kezMLx3lbOMpDG3nTB1Ybpy0vEQsWFOJO2Hfl/zDVij6S8RC4x69zEDnwzRi/nk9dzdoakZM/0x
 DnQFuGLn6sga5z3YjWLPLi7779pNRqHo1Xk8JVxxDcoMukCFqTZc7
X-Gm-Gg: ASbGncs7x0LmzVx1iQYAIyvIdPCR41plysO9SMoMqm2sRFviaNCt/odqto+VWQ4sbbU
 YZVd//XVL5WXgtWLcnVl+7ObdjCtMyACno6Ap5VnBcHDGrxKt6B2OjbyXrsrxC4GsSJ8dqpTToW
 RaZDiLHZJQwv0MtitRE8f7LHQbMulULAyIk/cjFiLsIn2YZ2J3qhhNXeNIkqq/B5Gd6PacoMS+B
 h0eNugsQAcQQqoO3v6wUnUIwrynwALWXBmxW4tPvDW246GJ8qoDJvXdoKmuuYV5vLdJpjaX6OJq
 fh8BKpX6RBZOs2aFEvSBPG1N7HBeyOyYQPBK+vKVASegAYHGtcmHSvHGYhI=
X-Received: by 2002:a05:6000:2583:b0:391:4674:b136 with SMTP id
 ffacd0b85a97d-3a09fd7c676mr3826665f8f.29.1746433150713; 
 Mon, 05 May 2025 01:19:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH3pTWyySYBX5UcPrg1HDAvfjolIMiIAPBRXzpyofgMS8QrRsu4qFAng0ab5K3ioDwOwO/fQ==
X-Received: by 2002:a05:6000:2583:b0:391:4674:b136 with SMTP id
 ffacd0b85a97d-3a09fd7c676mr3826634f8f.29.1746433150199; 
 Mon, 05 May 2025 01:19:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae3d3bsm9765237f8f.33.2025.05.05.01.19.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 01:19:09 -0700 (PDT)
Message-ID: <fd3219d3-bab3-4991-afbe-fd80549bbca4@redhat.com>
Date: Mon, 5 May 2025 10:19:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a PCIe RC
Content-Language: en-US
To: Donald Dutile <ddutile@redhat.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: jgg@nvidia.com, nicolinc@nvidia.com, berrange@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 linuxarm@huawei.com, wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-2-shameerali.kolothum.thodi@huawei.com>
 <03c31d89-ad24-4470-99d0-a77e693e3ba2@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <03c31d89-ad24-4470-99d0-a77e693e3ba2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
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

Hi,
On 5/2/25 8:16 PM, Donald Dutile wrote:
>
>
> On 5/2/25 6:27 AM, Shameer Kolothum wrote:
>> Although this change does not affect functionality at present, it lays
>> the groundwork for enabling user-created SMMUv3 devices in
>> future patches
>>
>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>> ---
>>   hw/arm/smmuv3.c | 26 ++++++++++++++++++++++++++
>>   hw/arm/virt.c   |  3 ++-
>>   2 files changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index ab67972353..605de9b721 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -24,6 +24,7 @@
>>   #include "hw/qdev-properties.h"
>>   #include "hw/qdev-core.h"
>>   #include "hw/pci/pci.h"
>> +#include "hw/pci/pci_bridge.h"
>>   #include "cpu.h"
>>   #include "exec/target_page.h"
>>   #include "trace.h"
>> @@ -1874,6 +1875,25 @@ static void smmu_reset_exit(Object *obj,
>> ResetType type)
>>       smmuv3_init_regs(s);
>>   }
>>   +static int smmuv3_pcie_bus(Object *obj, void *opaque)
>> +{
>> +    DeviceState *d = opaque;
>> +    PCIBus *bus;
>> +
>> +    if (!object_dynamic_cast(obj, TYPE_PCI_HOST_BRIDGE)) {
>> +        return 0;
>> +    }
>> +
>> +    bus = PCI_HOST_BRIDGE(obj)->bus;
>> +    if (d->parent_bus && !strcmp(bus->qbus.name,
>> d->parent_bus->name)) {
>> +        object_property_set_link(OBJECT(d), "primary-bus", OBJECT(bus),
>> +                                 &error_abort);
>> +        /* Return non-zero as we got the bus and don't need further
>> iteration.*/
>> +        return 1;
>> +    }
>> +    return 0;
>> +}
>> +
>>   static void smmu_realize(DeviceState *d, Error **errp)
>>   {
>>       SMMUState *sys = ARM_SMMU(d);
>> @@ -1882,6 +1902,10 @@ static void smmu_realize(DeviceState *d, Error
>> **errp)
>>       SysBusDevice *dev = SYS_BUS_DEVICE(d);
>>       Error *local_err = NULL;
>>   +    if (!object_property_get_link(OBJECT(d), "primary-bus",
>> &error_abort)) {
>> +        object_child_foreach_recursive(object_get_root(),
>> smmuv3_pcie_bus, d);
>> +    }
>> +
>>       c->parent_realize(d, &local_err);
>>       if (local_err) {
>>           error_propagate(errp, local_err);
>> @@ -1996,6 +2020,8 @@ static void smmuv3_class_init(ObjectClass
>> *klass, const void *data)
>>       device_class_set_parent_realize(dc, smmu_realize,
>>                                       &c->parent_realize);
>>       device_class_set_props(dc, smmuv3_properties);
>> +    dc->hotpluggable = false;
>> +    dc->bus_type = TYPE_PCIE_BUS;
> Does this force legacy SMMUv3 to be tied to a PCIe bus now?
> if so, will that break some existing legacy smmuv3 configs?, i.e.,
> virtio-scsi attached to a legacy smmuv3.

Previously the SMMU was already always attached to a PCI primary-bus
(vms->bus ie. pci0). virtio-scsi-pci is the device being protected. The
SMMU is not able to protect platforms devices atm.

My only concern is we are highjacking the "bus" prop to record the bus
hierarchy the SMMU is protecting. While the SMMU is a platform device
and does not inherit the PCI device base class its bus type becomes
"TYPE_PCIE_BUS". So in terms of qom hierachy is is seen as a PCI device
now? I don't know if it is a problem. An alternative could be to keep
the bus pointer and type as it was before and introduce a primary-bus
property. Adding Markus, Peter, Daniel and Alex in to.

At some point it was envisionned to support protected platform devices
(I think this was need for CCA). My fear is that if we turn the bus type
to PCIE it may be difficult to extend the support to non PCIe protected
devices. The SMMU shall remain a platform device being able to protect
either PCI devices and, in the future, platform devices.

Thanks

Eric
>
>>   }
>>     static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 177f3dd22c..3bae4e374f 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -56,6 +56,7 @@
>>   #include "qemu/cutils.h"
>>   #include "qemu/error-report.h"
>>   #include "qemu/module.h"
>> +#include "hw/pci/pci_bus.h"
>>   #include "hw/pci-host/gpex.h"
>>   #include "hw/virtio/virtio-pci.h"
>>   #include "hw/core/sysbus-fdt.h"
>> @@ -1442,7 +1443,7 @@ static void create_smmu(const VirtMachineState
>> *vms,
>>       }
>>       object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
>>                                &error_abort);
>> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>> +    qdev_realize_and_unref(dev, &bus->qbus, &error_fatal);
>>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
>>       for (i = 0; i < NUM_SMMU_IRQS; i++) {
>>           sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
>


