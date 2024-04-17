Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3933DC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 08:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx0gb-0003wp-Ol; Wed, 17 Apr 2024 04:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rx0ga-0003wX-6A
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 04:30:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rx0gX-0000a5-Uk
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 04:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713342628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VbxSUXQhR3ody6mEnLm8wjPs7QsJj7p5SuhdZybj7J0=;
 b=Ml0vDVIhQcaVmnFLu5eMxU2T56H812py3XSF7V88BSOXnHJLPfpMgeVH6dgn1b2tkDVyPP
 xcApZjO0zp8g4vRSNULFSKvBH6cg51t37xG48PlqBuG7B3kDJvOUPBTQGD1SUv9aFa97m9
 iMcO4ycLiNcx/zHw5TtXhNY/azLIXt8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-LdlsXn3lN9mAG_xoYHPRQQ-1; Wed, 17 Apr 2024 04:30:26 -0400
X-MC-Unique: LdlsXn3lN9mAG_xoYHPRQQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4183b895ef1so12012275e9.2
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 01:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713342626; x=1713947426;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VbxSUXQhR3ody6mEnLm8wjPs7QsJj7p5SuhdZybj7J0=;
 b=aQfP2UwW/V2c8EbpcjDGV6KwgAgmBR0zrNgV4YbJPsrbVDdnuc2pogo9ehyuDB+QN3
 QqcCSEJ4Si7NZ5dAXpgjnb5cJVrSXWJWn6cydmGY/1EaAodBxEnFKEJtS6vWTkm/bhDW
 /PC3rlUen/BFdsZ+MuDg284s4UiVQWlslyAF7YrleJ488bTrZ9/SqaT6zORXw8rP0MCo
 wS2uUn1Jn/raKlM+5ZgQ+e3tolx1g+lzh5ObSmW4I8pwpfZkZfu8vdfx/lkvVdxvHUt7
 dBW63LhnONiOAiQT9gvQhKHI3qNpBSDFv5pyah5xD8uE/hyAIBJHSo2aB+KClelYskMc
 UaSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcm4jdrlyj4V4YCVpLoHvLbL1TIuT8JO/IgXw5ahkK2ZNf1lDqEWOIgaEUhh4+hnt3VbWl7oSsHjDhe8xWemNNtZl4VrA=
X-Gm-Message-State: AOJu0YyQnZmpCCE8DXmQvmvqZeYJ3VrVSZbeR2/uwgjvqYmxj8irwOob
 eAoFB5MOQOr9U4Cj1Ylj5SOYdNJbLze4SjcOYxXWm0ZYRIcQI0+6KskJmCdjU6HD8GUdjNiB7MN
 FABM3mgnBO1wW++8P1G5c/RYlcwbzxg6BJPqiflIZlaQak+q7O4p7
X-Received: by 2002:a05:600c:4f96:b0:418:5d6c:43ea with SMTP id
 n22-20020a05600c4f9600b004185d6c43eamr7468609wmq.4.1713342625892; 
 Wed, 17 Apr 2024 01:30:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqKpxrvZfFXD3Ci9TFi4rTW3wnq03tNTQ5XW4io1SnMee7IxJUzoCcEvcqUioqOxlLGrqdFg==
X-Received: by 2002:a05:600c:4f96:b0:418:5d6c:43ea with SMTP id
 n22-20020a05600c4f9600b004185d6c43eamr7468576wmq.4.1713342625452; 
 Wed, 17 Apr 2024 01:30:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae?
 ([2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a05600c468700b00418accde252sm1835797wmo.30.2024.04.17.01.30.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 01:30:24 -0700 (PDT)
Message-ID: <b67b6ba8-b506-4865-9ab0-e9107cd5b12a@redhat.com>
Date: Wed, 17 Apr 2024 10:30:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] intel_iommu: Add a framework to do compatibility
 check with host IOMMU cap/ecap
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240408084404.1111628-1-zhenzhong.duan@intel.com>
 <20240408084404.1111628-4-zhenzhong.duan@intel.com>
 <251715ae-5378-4dfb-bc14-47ba2e62f83a@redhat.com>
 <SJ0PR11MB67443BF6BC7CABCE28F482A392082@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <5eb6c665-df8f-4c5e-8426-4678d8433a0c@redhat.com>
 <SJ0PR11MB6744F7A99B9303C8A3699EE9920F2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB6744F7A99B9303C8A3699EE9920F2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 4/17/24 06:21, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH v2 3/5] intel_iommu: Add a framework to do
>> compatibility check with host IOMMU cap/ecap
>>
>> Hello,
>>
>> On 4/16/24 09:09, Duan, Zhenzhong wrote:
>>> Hi Cédric,
>>>
>>>> -----Original Message-----
>>>> From: Cédric Le Goater <clg@redhat.com>
>>>> Subject: Re: [PATCH v2 3/5] intel_iommu: Add a framework to do
>>>> compatibility check with host IOMMU cap/ecap
>>>>
>>>> On 4/8/24 10:44, Zhenzhong Duan wrote:
>>>>> From: Yi Liu <yi.l.liu@intel.com>
>>>>>
>>>>> If check fails, the host side device(either vfio or vdpa device) should not
>>>>> be passed to guest.
>>>>>
>>>>> Implementation details for different backends will be in following
>> patches.
>>>>>
>>>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>>>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>> ---
>>>>>     hw/i386/intel_iommu.c | 35
>>>> +++++++++++++++++++++++++++++++++++
>>>>>     1 file changed, 35 insertions(+)
>>>>>
>>>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>>>> index 4f84e2e801..a49b587c73 100644
>>>>> --- a/hw/i386/intel_iommu.c
>>>>> +++ b/hw/i386/intel_iommu.c
>>>>> @@ -35,6 +35,7 @@
>>>>>     #include "sysemu/kvm.h"
>>>>>     #include "sysemu/dma.h"
>>>>>     #include "sysemu/sysemu.h"
>>>>> +#include "sysemu/iommufd.h"
>>>>>     #include "hw/i386/apic_internal.h"
>>>>>     #include "kvm/kvm_i386.h"
>>>>>     #include "migration/vmstate.h"
>>>>> @@ -3819,6 +3820,32 @@ VTDAddressSpace
>>>> *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>>>>>         return vtd_dev_as;
>>>>>     }
>>>>>
>>>>> +static int vtd_check_legacy_hdev(IntelIOMMUState *s,
>>>>> +                                 HostIOMMUDevice *hiod,
>>>>> +                                 Error **errp)
>>>>> +{
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static int vtd_check_iommufd_hdev(IntelIOMMUState *s,
>>>>> +                                  HostIOMMUDevice *hiod,
>>>>> +                                  Error **errp)
>>>>> +{
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static int vtd_check_hdev(IntelIOMMUState *s,
>> VTDHostIOMMUDevice
>>>> *vtd_hdev,
>>>>> +                          Error **errp)
>>>>> +{
>>>>> +    HostIOMMUDevice *hiod = vtd_hdev->dev;
>>>>> +
>>>>> +    if (object_dynamic_cast(OBJECT(hiod), TYPE_HIOD_IOMMUFD)) {
>>>>> +        return vtd_check_iommufd_hdev(s, hiod, errp);
>>>>> +    }
>>>>> +
>>>>> +    return vtd_check_legacy_hdev(s, hiod, errp);
>>>>> +}
>>>>
>>>>
>>>> I think we should be using the .get_host_iommu_info() class handler
>>>> instead. Can we refactor the code slightly to avoid this check on
>>>> the type ?
>>>
>>> There is some difficulty ini avoiding this check, the behavior of
>> vtd_check_legacy_hdev
>>> and vtd_check_iommufd_hdev are different especially after nesting
>> support introduced.
>>> vtd_check_iommufd_hdev() has much wider check over cap/ecap bits
>> besides aw_bits.
>>
>> I think it is important to fully separate the vIOMMU model from the
>> host IOMMU backing device. Could we introduce a new
>> HostIOMMUDeviceClass
>> handler .check_hdev() handler, which would call .get_host_iommu_info() ?
> 
> Understood, besides the new .check_hdev() handler, I think we also need a new interface
> class TYPE_IOMMU_CHECK_HDEV which has two handlers check_[legacy|iommufd]_hdev(),
> and different vIOMMUs have different implementation.

I am not sure to understand. Which class hierarchy would implement this
new "TYPE_IOMMU_CHECK_HDEV" interface ? vIOMMU or host iommu  ?

Could you please explain with an update of your diagram :

                         HostIOMMUDevice
                                | .get_host_iommu_info()
                                |
                                |
             .------------------------------------.
             |                  |                 |
       HIODLegacyVFIO    [HIODLegacyVDPA]    HIODIOMMUFD
             | .vdev            | [.vdev]         | .iommufd
                                                  | .devid
                                                  | [.ioas_id]
                                                  | [.attach_hwpt()]
                                                  | [.detach_hwpt()]
                                                  |
                                     .----------------------.
                                     |                      |
                            HIODIOMMUFDVFIO         [HIODIOMMUFDVDPA]
                                     | .vdev                | [.vdev]


Thanks,

C.


> Then legacy and iommufd host device have different implementation of .check_hdev()
> and calls into one of the two interface handlers.
> 
> Let me know if I misunderstand any of your point.
> 
> Thanks
> Zhenzhong
> 
>>
>>
>> Thanks,
>>
>> C.
>>
>>
>>> That the reason I have two functions to do different thing.
>>> See:
>>>
>> https://github.com/yiliu1765/qemu/blob/zhenzhong/iommufd_nesting_rfc
>> v2/hw/i386/intel_iommu.c#L5472
>>>
>>> Meanwhile in vtd_check_legacy_hdev(), when legacy VFIO device attaches
>> to modern vIOMMU,
>>> this is unsupported and error out early, it will not
>> call .get_host_iommu_info().
>>> I mean we don't need to unconditionally call .get_host_iommu_info() in
>> some cases.
>>>
>>> Thanks
>>> Zhenzhong
> 


