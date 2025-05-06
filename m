Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6C4C3ABC0
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 09:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCEi5-0001dW-Jp; Tue, 06 May 2025 05:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uCEi3-0001bf-Se
 for qemu-devel@nongnu.org; Tue, 06 May 2025 05:35:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uCEi1-00054m-Ol
 for qemu-devel@nongnu.org; Tue, 06 May 2025 05:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746524128;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m9Nj0TTI4/KXc+zG295t2eZu7dXoGbjXFPHXgCwgiT0=;
 b=R72NUBrGUUkXuyQJx1sb9+EFV4ZOMl4CEZMOePxoFY/pYq22XrEjvIp7ypSq18i63r3QEm
 n7Xibcrsk5e+mz3bn3GYPv/uuFrT4GGKjV3lhlHpWS85ev56Qrds4/wMQgLLuerKOPR1Gg
 86Tqagf8azmEN5uvQTGwMzt9la7ii/0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-qjF0Uy3cMW2Tr08HpA5LvA-1; Tue, 06 May 2025 05:35:27 -0400
X-MC-Unique: qjF0Uy3cMW2Tr08HpA5LvA-1
X-Mimecast-MFC-AGG-ID: qjF0Uy3cMW2Tr08HpA5LvA_1746524126
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d734da1a3so24817795e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 02:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746524126; x=1747128926;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m9Nj0TTI4/KXc+zG295t2eZu7dXoGbjXFPHXgCwgiT0=;
 b=wb7AL+KrACtMU0ZoDsAQ5JxOCtC1fMrmZpd7tw9k2N8UR6wooxXyRosoySPxvAtRrg
 UaoHQy/P2yh4EsQtzQQ2/T/fAvg1VhcZU/scYmCXHXLIcJpcJEq0k364OmUml2yeITAa
 6vzyTKW3sX+ut9cUN7Clu2elC9QozS0QcfGoW74/xfAX4l25aM+bYTW01TxEwz/H0EFw
 m4QdHIp5wkRjorgfGQtXl4vthHOPVzfLJ2pgJC7sGrtJDzwbcWvAoNGYFveIswYeJHqS
 DMn5JrIG2bbOr4Gm/gVUvdtAOvu1GkjtfGvTe4XqBe72SwPdCKchMlevH1wkBJRn9bbW
 VBCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT882cWbRuph7/DeLQw86lWCq/v3iUqfaFe+cuCsMga9w7Lg9OrW5V4iFGknItYaB3nDRsMaoufhAQ@nongnu.org
X-Gm-Message-State: AOJu0YyHPefF9RVXzCigFmloBxIpa5933CsROU2EgOzFt1aKoA8oR0IO
 I5bTETZbcf4AmOcFk5q7Sw6D9OR00hTtVnUVVq2qAuMn433a7VKDyDUpXkeJ5R0IhIqN4A/0A62
 H/Ia5OxzlEs7xX2HS329vyWiDpWJTDJil7nb6Omxa5+UvawbZiSDV
X-Gm-Gg: ASbGncuLKrfH59JhpiJc5qulKNOW5+sTCQcP2hLGK4Rkn+JL3rAng/73XppcprxJKbh
 ACuFvDqNQV3jrHkSL8GTpqHcDcA3PrVgg/YDg6LLaCz4JFNVrYebFkbj0pFTpUAsHeDqA8mXvn5
 A67UXv9UmXCKQ/Ez2rCqwpzulrYDH10FLU1YmrykQkKmODE8P2ZEjYxg3RtL5dXlrKaoymN7rvM
 EaofkfGv/NS4T/gRr+BItZ2xwKDAkBox1v/o2SkRfVCjiuFgLHqmuaqFCykjSsYDd6z6flPlc3H
 76UYGL3RhXQDc6MNQNUKrQvDDBGv/REQhxBo8UN/cvoCQA30UB0iLz5S5Rk=
X-Received: by 2002:a05:600c:4ed0:b0:43c:f332:703a with SMTP id
 5b1f17b1804b1-441d053bc13mr21103795e9.31.1746524125971; 
 Tue, 06 May 2025 02:35:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhMaMdE55AI9yri8Hvj5z4gFLnVSMQbz5MZGyp69PfBhVr8ld7vRM12ipe/sT6LLOxKIbk2w==
X-Received: by 2002:a05:600c:4ed0:b0:43c:f332:703a with SMTP id
 5b1f17b1804b1-441d053bc13mr21103435e9.31.1746524125561; 
 Tue, 06 May 2025 02:35:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89cc469sm164379135e9.6.2025.05.06.02.35.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 02:35:24 -0700 (PDT)
Message-ID: <f1b91034-be2a-493e-9229-c164e0895825@redhat.com>
Date: Tue, 6 May 2025 11:35:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a PCIe RC
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Donald Dutile <ddutile@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-2-shameerali.kolothum.thodi@huawei.com>
 <03c31d89-ad24-4470-99d0-a77e693e3ba2@redhat.com>
 <fd3219d3-bab3-4991-afbe-fd80549bbca4@redhat.com>
 <aa895207758d4515986fd6cfe05b5917@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <aa895207758d4515986fd6cfe05b5917@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Shameer,

On 5/6/25 11:07 AM, Shameerali Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Monday, May 5, 2025 9:19 AM
>> To: Donald Dutile <ddutile@redhat.com>; Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
>> qemu-devel@nongnu.org; Markus Armbruster <armbru@redhat.com>;
>> Peter Maydell <peter.maydell@linaro.org>; Daniel P. Berrange
>> <berrange@redhat.com>; Alex Bennée <alex.bennee@linaro.org>
>> Cc: jgg@nvidia.com; nicolinc@nvidia.com; berrange@redhat.com;
>> nathanc@nvidia.com; mochs@nvidia.com; smostafa@google.com; Linuxarm
>> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
>> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
>> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
>> Subject: Re: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a
>> PCIe RC
>>
>> Hi,
>> On 5/2/25 8:16 PM, Donald Dutile wrote:
>>>
>>> On 5/2/25 6:27 AM, Shameer Kolothum wrote:
>>>> Although this change does not affect functionality at present, it lays
>>>> the groundwork for enabling user-created SMMUv3 devices in
>>>> future patches
>>>>
>>>> Signed-off-by: Shameer Kolothum
>> <shameerali.kolothum.thodi@huawei.com>
>>>> ---
>>>>   hw/arm/smmuv3.c | 26 ++++++++++++++++++++++++++
>>>>   hw/arm/virt.c   |  3 ++-
>>>>   2 files changed, 28 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>>> index ab67972353..605de9b721 100644
>>>> --- a/hw/arm/smmuv3.c
>>>> +++ b/hw/arm/smmuv3.c
>>>> @@ -24,6 +24,7 @@
>>>>   #include "hw/qdev-properties.h"
>>>>   #include "hw/qdev-core.h"
>>>>   #include "hw/pci/pci.h"
>>>> +#include "hw/pci/pci_bridge.h"
>>>>   #include "cpu.h"
>>>>   #include "exec/target_page.h"
>>>>   #include "trace.h"
>>>> @@ -1874,6 +1875,25 @@ static void smmu_reset_exit(Object *obj,
>>>> ResetType type)
>>>>       smmuv3_init_regs(s);
>>>>   }
>>>>   +static int smmuv3_pcie_bus(Object *obj, void *opaque)
>>>> +{
>>>> +    DeviceState *d = opaque;
>>>> +    PCIBus *bus;
>>>> +
>>>> +    if (!object_dynamic_cast(obj, TYPE_PCI_HOST_BRIDGE)) {
>>>> +        return 0;
>>>> +    }
>>>> +
>>>> +    bus = PCI_HOST_BRIDGE(obj)->bus;
>>>> +    if (d->parent_bus && !strcmp(bus->qbus.name,
>>>> d->parent_bus->name)) {
>>>> +        object_property_set_link(OBJECT(d), "primary-bus", OBJECT(bus),
>>>> +                                 &error_abort);
>>>> +        /* Return non-zero as we got the bus and don't need further
>>>> iteration.*/
>>>> +        return 1;
>>>> +    }
>>>> +    return 0;
>>>> +}
>>>> +
>>>>   static void smmu_realize(DeviceState *d, Error **errp)
>>>>   {
>>>>       SMMUState *sys = ARM_SMMU(d);
>>>> @@ -1882,6 +1902,10 @@ static void smmu_realize(DeviceState *d,
>> Error
>>>> **errp)
>>>>       SysBusDevice *dev = SYS_BUS_DEVICE(d);
>>>>       Error *local_err = NULL;
>>>>   +    if (!object_property_get_link(OBJECT(d), "primary-bus",
>>>> &error_abort)) {
>>>> +        object_child_foreach_recursive(object_get_root(),
>>>> smmuv3_pcie_bus, d);
>>>> +    }
>>>> +
>>>>       c->parent_realize(d, &local_err);
>>>>       if (local_err) {
>>>>           error_propagate(errp, local_err);
>>>> @@ -1996,6 +2020,8 @@ static void smmuv3_class_init(ObjectClass
>>>> *klass, const void *data)
>>>>       device_class_set_parent_realize(dc, smmu_realize,
>>>>                                       &c->parent_realize);
>>>>       device_class_set_props(dc, smmuv3_properties);
>>>> +    dc->hotpluggable = false;
>>>> +    dc->bus_type = TYPE_PCIE_BUS;
>>> Does this force legacy SMMUv3 to be tied to a PCIe bus now?
>>> if so, will that break some existing legacy smmuv3 configs?, i.e.,
>>> virtio-scsi attached to a legacy smmuv3.
>> Previously the SMMU was already always attached to a PCI primary-bus
>> (vms->bus ie. pci0). virtio-scsi-pci is the device being protected. The
>> SMMU is not able to protect platforms devices atm.
>>
>> My only concern is we are highjacking the "bus" prop to record the bus
>> hierarchy the SMMU is protecting. While the SMMU is a platform device
>> and does not inherit the PCI device base class its bus type becomes
>> "TYPE_PCIE_BUS". So in terms of qom hierachy is is seen as a PCI device
>> now? I don't know if it is a problem. An alternative could be to keep
>> the bus pointer and type as it was before and introduce a primary-bus
>> property. Adding Markus, Peter, Daniel and Alex in to.
> Yes. The SMMUV3 is a platform device and we are making the bus type
> here as PCIE which is a bit odd. As replied elsewhere in this thread,
> in the initial RFC we had a specific "pci-bus" property associated with 
> SMMUv3 device, 
> Eg:
> -device arm-smmuv3,pci-bus=pcie.0,...
>
> But then there were feedback that, it is more intuitive and easy for libvirt
> if we can just use the default "bus" property associated with a  Qemu device.
> Hence the change.
I also think that using the bus property was natural. It is only when
you look at the actual implementation and potential implications on
hierarchy introspections that it may be frown upon. That's why I call
for specialists feedback ;-)
>
>> At some point it was envisionned to support protected platform devices
>> (I think this was need for CCA). My fear is that if we turn the bus type
>> to PCIE it may be difficult to extend the support to non PCIe protected
>> devices. The SMMU shall remain a platform device being able to protect
>> either PCI devices and, in the future, platform devices.
> Ok. So in the case of platform device how do we envisage to specify the "bus"?
>
> -device arm-smmv3, primary-bus=sysbus
The problem is on a SOC not all platform devices are protected by an
SMMU. One needs to be more precise I think

>
> Or something like having a SMMUv3 dev without any bus and each platform
> device has to specify the SMMUv3?
> Eg:
>
> -device arm-smmv3,id=smmuv3.3
> -device xxxx,smmuv3= smmuv3.3
Yeah I think this would look that way instead.

The last attempt was
https://lore.kernel.org/all/20210902081429.140293-1-chunming_li1234@163.com/
if I remember correctly but it did not go further. It defined a
peri-sid-map[%d] prop array to define SIDs but I don't really get how it
defines which device is protected.



> If later, I think we can stick to current one. 
That's also my pov.

Cheers

Eric

>
> Thanks,
> Shameer


