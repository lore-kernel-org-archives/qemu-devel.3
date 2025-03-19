Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B26C36001
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwBW-0001cY-GH; Wed, 19 Mar 2025 12:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tuwBF-0001Y5-A6
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:22:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tuwBC-0007hF-Qs
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742401325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=klWI4FDZ0/BmcVrf7/2IbSpvyCmh9Jh6HeZb9LoWjcY=;
 b=M2YlPoM+tzBuGgMpoIlvWpLNFDvC9N98NsimSlc23S3eTjllf/fcU8cBNqyHciOJgkKpG+
 b1M8YaS/z3aogaOxttP5TJQooknlcVWHW8PtpxtFG0hiF/9jdtM7cEdLIAMC1f1OpzcM46
 JzcgD86dEj9SR6gcwuwebkuoPAVn/+E=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-GK9Chmu_OMypWHLaWgC2Mw-1; Wed, 19 Mar 2025 12:22:03 -0400
X-MC-Unique: GK9Chmu_OMypWHLaWgC2Mw-1
X-Mimecast-MFC-AGG-ID: GK9Chmu_OMypWHLaWgC2Mw_1742401322
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-3d451ad5b2dso8967895ab.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 09:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742401322; x=1743006122;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=klWI4FDZ0/BmcVrf7/2IbSpvyCmh9Jh6HeZb9LoWjcY=;
 b=cNVNdqgQl72xw0BJEJ5LCkFKMmfHpNzK7iHUr+wGYHAbQg+5ok4795oFa2meWYZIis
 u6J2w8h+dpNnglacg8N/XV3E9UKoBijfbqAXziin726cqbxicMzhyeOLDViC2oW8NWs2
 o81/9T9E006ZowE/yde90fi7Z0k/xEC0pM/Z8JVP5OdQh8W3fctC/EhRv1Rqg2Oyv5cs
 zBuXt/qLtBxdnzbO6hl2FKVOo+//Db/lIc+AsUDVxKx4ZhyG4lX/GoI+zYHfMDDQzFtm
 DjzCkWsDilltN75WZj4BGUtybWcUdZsSBn+3jh9vAOkD8tZlaQlSdkLNLDrq8zv4Y70w
 OjRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgX91QrSYKpKGysui/evQFVTZIO86p976w0lPgfx72Lslbhf+/gjhpIZEFdnckSXKrYcjO1ZdcV5Zc@nongnu.org
X-Gm-Message-State: AOJu0Yy35xzQxESX/yTEfx1XmORKTf5tqN2MCH8MT7u5lI/rH1SxmjOO
 D5c7JAx2ysul8PG49+MoIvCepWP42k3cJ11GDDjCybBDkkNwL4xeN49qqK34NO8ZFiRK1yZUBTD
 Iux8ZW5K59m2Bo9uvZpZrcY3Q8u9mrwFacEOBmeYXT5dZjkx+Sv7R
X-Gm-Gg: ASbGncsMN1Rzn36B1IznsIY/385X7SOtxf4kWvK79wKZ9pSssOzeUZy/n2tB4puQvVW
 5dfUfyAuaq5UKG3+mG45f+eQ0K1q9xuGxE8HetmmQskZKsL6USGd85717dbRj1UJYqjMJjNGfQR
 68r+KEIrjEjPWN5jiqbOwApjXLbMONiiPCfAMbNeTYCTMyq1MCt2mas/yC2MOD/GVXsrW8SK/Bx
 wFP6WE44/aSEexyEh4JhlnOWDdmc9PxBCFdJcq2HnyJpe/cOXVpztKi4L1XtuomwLxVsxKw5e7i
 xDybpvlhulD6MOR1
X-Received: by 2002:a05:6e02:1848:b0:3d4:2306:fbb6 with SMTP id
 e9e14a558f8ab-3d58e8f5525mr1288405ab.10.1742401322303; 
 Wed, 19 Mar 2025 09:22:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNHATpxAxq2dc4Hc9XQoJkzsqWiItFiEu9m7W91AyASdlcOIx4mE/L0K7XXe2/mXrTRDqs2g==
X-Received: by 2002:a05:6e02:1848:b0:3d4:2306:fbb6 with SMTP id
 e9e14a558f8ab-3d58e8f5525mr1288115ab.10.1742401321933; 
 Wed, 19 Mar 2025 09:22:01 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f263703225sm3335455173.17.2025.03.19.09.22.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 09:22:01 -0700 (PDT)
Message-ID: <1c603ab2-4fbb-4838-a544-d88bc2608506@redhat.com>
Date: Wed, 19 Mar 2025 12:21:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-pcie bus
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-6-shameerali.kolothum.thodi@huawei.com>
 <b3a4ce7f-41a9-4da9-a8ca-54848b9e9cf1@redhat.com>
 <3d1312b411f04121a3be90879a915982@huawei.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <3d1312b411f04121a3be90879a915982@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/19/25 5:26 AM, Shameerali Kolothum Thodi wrote:
> Hi Don,
> 
Hey!

>> -----Original Message-----
>> From: Donald Dutile <ddutile@redhat.com>
>> Sent: Tuesday, March 18, 2025 10:12 PM
>> To: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
>> qemu-devel@nongnu.org
>> Cc: eric.auger@redhat.com; peter.maydell@linaro.org; jgg@nvidia.com;
>> nicolinc@nvidia.com; berrange@redhat.com; nathanc@nvidia.com;
>> mochs@nvidia.com; smostafa@google.com; Linuxarm
>> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
>> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
>> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
>> Subject: Re: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-
>> pcie bus
>>
>> Shameer,
>>
>> Hi!
>>
>> On 3/11/25 10:10 AM, Shameer Kolothum wrote:
>>> User must associate a pxb-pcie root bus to smmuv3-accel
>>> and that is set as the primary-bus for the smmu dev.
>>>
>>> Signed-off-by: Shameer Kolothum
>> <shameerali.kolothum.thodi@huawei.com>
>>> ---
>>>    hw/arm/smmuv3-accel.c | 19 +++++++++++++++++++
>>>    1 file changed, 19 insertions(+)
>>>
>>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>>> index c327661636..1471b65374 100644
>>> --- a/hw/arm/smmuv3-accel.c
>>> +++ b/hw/arm/smmuv3-accel.c
>>> @@ -9,6 +9,21 @@
>>>    #include "qemu/osdep.h"
>>>
>>>    #include "hw/arm/smmuv3-accel.h"
>>> +#include "hw/pci/pci_bridge.h"
>>> +
>>> +static int smmuv3_accel_pxb_pcie_bus(Object *obj, void *opaque)
>>> +{
>>> +    DeviceState *d = opaque;
>>> +
>>> +    if (object_dynamic_cast(obj, "pxb-pcie-bus")) {
>>> +        PCIBus *bus = PCI_HOST_BRIDGE(obj->parent)->bus;
>>> +        if (d->parent_bus && !strcmp(bus->qbus.name, d->parent_bus-
>>> name)) {
>>> +            object_property_set_link(OBJECT(d), "primary-bus", OBJECT(bus),
>>> +                                     &error_abort);
>>> +        }
>>> +    }
>>> +    return 0;
>>> +}
>>>
>>>    static void smmu_accel_realize(DeviceState *d, Error **errp)
>>>    {
>>> @@ -17,6 +32,9 @@ static void smmu_accel_realize(DeviceState *d, Error
>> **errp)
>>>        SysBusDevice *dev = SYS_BUS_DEVICE(d);
>>>        Error *local_err = NULL;
>>>
>>> +    object_child_foreach_recursive(object_get_root(),
>>> +                                   smmuv3_accel_pxb_pcie_bus, d);
>>> +
>>>        object_property_set_bool(OBJECT(dev), "accel", true, &error_abort);
>>>        c->parent_realize(d, &local_err);
>>>        if (local_err) {
>>> @@ -33,6 +51,7 @@ static void smmuv3_accel_class_init(ObjectClass
>> *klass, void *data)
>>>        device_class_set_parent_realize(dc, smmu_accel_realize,
>>>                                        &c->parent_realize);
>>>        dc->hotpluggable = false;
>>> +    dc->bus_type = TYPE_PCIE_BUS;
>>>    }
>>>
>>>    static const TypeInfo smmuv3_accel_type_info = {
>>
>> I am not seeing the need for a pxb-pcie bus(switch) introduced for each
>> 'accel'.
>> Isn't the IORT able to define different SMMUs for different RIDs?   if so,
>> itsn't that sufficient
>> to associate (define) an SMMU<->RID association without introducing a
>> pxb-pcie?
>> and again, I'm not sure how that improves/enables the device<->SMMU
>> associativity?
> 
> Thanks for taking a look at the series. As discussed elsewhere in this thread(with
> Eric), normally in physical world (or atleast in the most common cases) SMMUv3
> is attached to PCIe Root Complex and if you take a look at the IORT spec, it describes
> association of ID mappings between a RC node and SMMUV3 node.
> 
> And if my understanding is correct, in Qemu, only pxb-pcie allows you to add
> extra root complexes even though it is still plugged to parent(pcie.0). ie, for all
> devices downstream it acts as a root complex but still plugged into a parent pcie.0.
> This allows us to add/describe multiple "smmuv3-accel" each associated with a RC.
> 
I find the qemu statements a bit unclear here as well.
I looked at the hot plug statement(s) in docs/pcie.txt, as I figured that's where dynamic
IORT changes would be needed as well.  There, it says you can hot-add PCIe devices to RPs,
one has to define/add RP's to the machine model for that plug-in.

Using libvirt, it could auto-add the needed RPs to do dynmaic smmuv3 additions,
if I understand how libvirt does that today for pcie devices now (/me looks at danpb for feedback).

> Having said that,  current code only allows pxb-pcie root complexes avoiding
> the pcie.0. The idea behind this was, user can use pcie.0 with a non accel SMMUv3
> for any emulated devices avoiding the performance bottlenecks we are
> discussing for emulated dev+smmuv3-accel cases. But based on the feedback from
> Eric and Daniel I will relax that restriction and will allow association with pcie.0.
> 
So, I think this isn't a restriction that this smmuv3 feature should enforce;
lack of a proper RP or pxb-pcie will yield an invalid config issue/error, and
the machine definition will be modified to meet the needs for IORT.

> Thanks,
> Shameer
> 
> 
> 
> 
> 
> 
> 
> 
>   
> 
>>>> to root complexes.
>> Feel free to enlighten me where I may have mis-read/interpreted the IORT
>> & SMMUv3 specs.
>>
>> Thanks,
>> - Don
>>
> 


