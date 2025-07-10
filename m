Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5879C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 17:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZvRa-0001lk-Sg; Thu, 10 Jul 2025 13:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uZujz-00004x-7P
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 13:07:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uZujw-0008PA-C7
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 13:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752167238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lU4HPD8WPFN7KeTTzQj3Ziu2aCNcYB/IdXI8/2Z6h3Y=;
 b=Q24U4IFduTe1aD0IL3DEgm4/w514u+/IHpF/EvBxMlgsLns6i/egNUKRCTO7fEmO5cYFbu
 zhETxWt1W6hKKFhNjoIcyMh3LlBu3jXIVxJxyeQOSbgUL7wetn34yy70Abs4Vx5DUOjZqk
 YAtQAPvYcBDTAz2/YEgyc+EgmYzVlBU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-VCE2BJGbM4SN4H7AMLiUfA-1; Thu, 10 Jul 2025 13:07:17 -0400
X-MC-Unique: VCE2BJGbM4SN4H7AMLiUfA-1
X-Mimecast-MFC-AGG-ID: VCE2BJGbM4SN4H7AMLiUfA_1752167236
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3132e7266d3so1293368a91.2
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 10:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752167236; x=1752772036;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lU4HPD8WPFN7KeTTzQj3Ziu2aCNcYB/IdXI8/2Z6h3Y=;
 b=Kcmh0e6I0pmZS9vPk5oUHlNrCfjXFLxRE/vybdoOXwsCQfZMRKPTmD+Sy4bikCQx7Z
 +Sdyw46baPFyqn3IQt0ysBERiV+iy0A47L/9b55n3YCuFDszPM7O4pK9TwAg/elMidte
 qNux/xFmFytKD8YKz2X8fJr+Qi2oKBclJRqxhi5dIPO0huaKjk3NK3iD1AAcJozJuX1/
 g9k4IACknBhcoEt6bhQ3ZGnuCaixfC+tytZkNozcozsIJ9srsQ0cIDV2PuG7Y353GAGW
 pwI1c6yap6/TrqwMcNQGlc1rNnHEG7EDqMqtL91nQZGcbZhViZlyI+LkYEScWtZjFeGA
 r9SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUT1hXvyr71DxnfzsEKJl9M2RjtwiMNmHkwYeQ6d72G+B8Jm6a97I+wOs9AZ6mG+EBONfQE5hH3PcP@nongnu.org
X-Gm-Message-State: AOJu0YwajhZRa6WuzUq1nh7N9P+vkRRes6ihFlS5Nax5JX2ceiaayY+s
 whYPMAYhMk2VuuNNkK9m3rIPJw0B8zNnTy52aLTeGO3xjYGuTwLTkEta74SLE8iwEncYKG84jQS
 3q5Y6UFer9n6jwhv99e0wScpwnO0gBxyfCOsLg6cCCvnq5ynutORDBf3G
X-Gm-Gg: ASbGncvud+yZ3yvQjVAatJrl2mqpbxx6cJyCBjSOsHkXNAKNP7DyFJoKRBwUlhidjEx
 /sIckWUcggEKp7YDR8LHKb45S6xRHtY2VqY0b4NFDIxDpRBnvlGTyz4QlQXPkqRWSDhu9poJNQh
 zX+ZJk87ij4bGtdO5igKQ0KPedivr6TIGrC0s3C5ZjliNiCxr/KDJHceAFUoOECW+X9cez81Lq3
 h9ll+gEwxpwGF0aYGUHVaXAnyO2/Tnl8uiEEdhC72kop0MOQDh6pUTdB841TUbh/bi9ECLmIWy8
 y4PUJfESOLrYM8glnbEDmak=
X-Received: by 2002:a17:90b:1dc2:b0:311:fc8b:31b5 with SMTP id
 98e67ed59e1d1-31c4cb85d2dmr462790a91.14.1752167236319; 
 Thu, 10 Jul 2025 10:07:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeoL/uN8FEUvl/TbDZCCkQZPIolroXIeGZAKOpWfqCMc2WogtFMXydeNnWK3tTXPuufZnXuw==
X-Received: by 2002:a17:90b:1dc2:b0:311:fc8b:31b5 with SMTP id
 98e67ed59e1d1-31c4cb85d2dmr462732a91.14.1752167235712; 
 Thu, 10 Jul 2025 10:07:15 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c3eb7e9ecsm2826856a91.42.2025.07.10.10.07.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 10:07:15 -0700 (PDT)
Message-ID: <b0b447d4-ca5e-4462-8c02-958bd0c601de@redhat.com>
Date: Thu, 10 Jul 2025 13:07:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/20] hw/pci: Introduce pci_device_get_viommu_cap()
Content-Language: en-US
From: Donald Dutile <ddutile@redhat.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "chao.p.peng@intel.com" <chao.p.peng@intel.com>
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
 <20250708110601.633308-3-zhenzhong.duan@intel.com>
 <aG26VBqzOnLAWC5z@Asurada-Nvidia>
 <01584206-e2c0-4881-aaf5-d6c552a30873@redhat.com>
 <aG7A8hxd1R4iVhGT@Asurada-Nvidia>
 <b3787ed4219743e2a65edd13ff44d9b9@huawei.com>
 <5542e55f-5cd9-40f8-bb45-fe6d851140b1@redhat.com>
In-Reply-To: <5542e55f-5cd9-40f8-bb45-fe6d851140b1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

oops, inadvertently hit send before I could add reply... apologies... reply below...

On 7/10/25 1:01 PM, Donald Dutile wrote:
> 
> 
> On 7/10/25 4:11 AM, Shameerali Kolothum Thodi wrote:
>>
>>
>>> -----Original Message-----
>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>> Sent: Wednesday, July 9, 2025 8:20 PM
>>> To: Donald Dutile <ddutile@redhat.com>
>>> Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>; qemu-
>>> devel@nongnu.org; alex.williamson@redhat.com; clg@redhat.com;
>>> eric.auger@redhat.com; mst@redhat.com; jasowang@redhat.com;
>>> peterx@redhat.com; jgg@nvidia.com; Shameerali Kolothum Thodi
>>> <shameerali.kolothum.thodi@huawei.com>; joao.m.martins@oracle.com;
>>> clement.mathieu--drif@eviden.com; kevin.tian@intel.com;
>>> yi.l.liu@intel.com; chao.p.peng@intel.com
>>> Subject: Re: [PATCH v3 02/20] hw/pci: Introduce
>>> pci_device_get_viommu_cap()
>>>
>>> On Wed, Jul 09, 2025 at 01:55:46PM -0400, Donald Dutile wrote:
>>>>>> +enum {
>>>>>> +    VIOMMU_CAP_STAGE1 = BIT_ULL(0),  /* stage1 page table
>>> supported */
>>>>>> +};
>>>>>
>>>>> Thanks for this work. I am happy to see that we can share the
>>>>> common code that allocates a NESTING_PARENT in the core using
>>>>> this flag.
>>>>>
>>>>> Yet on ARM, a STAGE1 page table isn't always a nested S1, the
>>>>> hardware accelerated one. More often, it can be just a regular
>>>>> 1-stage translation table via emulated translation code and an
>>>>> emulated iotlb.
>>>>>
>>>> Because the user-created smmuv3 started as 'accelerated smmuv3',
>>>> and had been 'de-accelerated' to simply 'user created smmuv3',
>>>> I'm looking for some clarification in the above statement/request.
>>>>
>>>> Is the above suppose to reflect that a nested IOMMU has some hw-
>>> acceleration
>>>> in its Stage1 implementation?
>>>> If so, then call it that: STAGE1_ACCEL.
>>>> If it's suppose to represent that an IOMMU has nested/2-stage support,
>>>> then the above is a valid cap;  -but-, having a nested/2-stage support
>>> IOMMU
>>>> doesn't necessarily mean its accelerated.
>>>
>>> Well, there are an emulated "nested" mode and an hw-accelerated
>>> "nested" mode in the smmuv3 code, so we had to choose something
>>> like "accel" over "nested".
>>>
>>> Here, on the other hand, I think the core using this CAP would
>>> unlikely care about an emulated "nested" mode in the individual
>>> vIOMMU..
>>>
>>> So I suggested:
>>>       /* hardware-accelerated nested stage-1 page table support */
>>>      VIOMMU_CAP_NESTED_S1 = BIT_ULL(0),
>>>
>>> which it should be clear IMHO.
>>>
>>> If not, maybe go a bit further like "VIOMMU_CAP_HW_NESTED_S1"?
>>
>> I am not sure the _S1 part makes much sense in ARM case. It doesn't matter
>> whether the Guest SMMUv3 is configured in s1/s2 or nested for this CAP.
>> With the new SMMUv3 dev support, the user can pretty much specify,
>>
>> -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.1,accel=on,stage={stage1|stage2|nested}
>>
>> And I think it will work with a host SMMUv3 nested configuration in all the
>> above cases. Unless I am missing something and we need to restrict its
>> use with stage=stage1 only.
>>
>> Thanks,
>> Shameer
>>
Shameer,
I didn't think of these config options this way... so is this CAP always 0 for smmuv3's associated VIOMMU?

or ... should intel-iommu follow this same/smmuv3 config option(s) and avoid this VIOMMU CAP req. ?

- Don


