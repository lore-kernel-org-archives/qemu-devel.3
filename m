Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C290C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 17:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf0uf-00060t-Sk; Tue, 27 Feb 2024 12:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rf0uc-00060N-77
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 12:06:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rf0uL-0006TZ-Ko
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 12:06:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709053580;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wu+rGk3AAH/rwt5UQxkciQXiytwWRnM9zpPv16Tg4HU=;
 b=Z3o68dilGa0sn97ba/Dpgzu+D/3I799VFmDzZVbIwif3oCb8PTwsCapWGVSxq5DOZ7/Urf
 d0mZpUuxD9rCZnq//DQq5x0NqmYtzpjHZsB51D6Rm8Ai/ATNb4VZii8avrMxwsAsFBLLX+
 1JEVLLmsp8HGwqw8D4Alw9H9/U9Vync=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131--TMGo0WCNe2nXJhRPl769Q-1; Tue, 27 Feb 2024 12:06:16 -0500
X-MC-Unique: -TMGo0WCNe2nXJhRPl769Q-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-68f447d1d6bso42398886d6.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 09:06:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709053575; x=1709658375;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wu+rGk3AAH/rwt5UQxkciQXiytwWRnM9zpPv16Tg4HU=;
 b=vs6CofSLT+HltU6NKP40hBBPCDfusgsU4AI91l5DztfsTENDu/rxOD+vSyOVwPw31I
 LbpSrMIfHjzb10bd8Z5yCQ8FfinRHp8Fn9R01hcAnmBOeVxafq4DtaKyB577zU94/3AI
 rtVyzBD/AE064irrG7I/n3MDamNkkhg4RLQtwsUFR6tamo+02AJA75z1pPGZnfZbe9c5
 tFF5CpjoZKOTNDoqYvYlFwJey3aPIJRYf1D82MOvin5HJvUwhwQHTe9kmHMpocscpn8/
 Ycl5BlXF3X3QpyAIK5w+rA4j9EnFbHTZD/79n7/qG4SMvlv/YHfoFq4Dkibzl8xMA6iZ
 bQVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOqAhsEZ5jAsRDKZW4BxT5ssI3Lbnp7yN/RmWk5xg78/Jd8QhqNb+4hRFr7jmcQtkxZmoMD8/oLy8Fdaa3JCqdZE/wTWI=
X-Gm-Message-State: AOJu0YzQCp6NJSESL4bzDDdlZ3Bo5LEnJspCTjJtYyQqqxoKspjVTadN
 EZvvobtIGTHKjnklHxOB+7eVhqF0UWCUo3Yk4wNAH+xUgkHhYmm8OQHYNMnW5KkiT4cSqHJJpDt
 bUK1oY1Ev+pKtNLa/TLltPNeJaRKev4DEZrDX9TpJXNLfIzijVzz+
X-Received: by 2002:a05:6214:cce:b0:68f:5738:3d45 with SMTP id
 14-20020a0562140cce00b0068f57383d45mr2943806qvx.40.1709053575506; 
 Tue, 27 Feb 2024 09:06:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF68M37MojDyEf4vgfyg1vQFmc8ObV+sSrQT9IwPF2pKu+9JV5oJ6JuXzKbdI4X5dsCfiKxkQ==
X-Received: by 2002:a05:6214:cce:b0:68f:5738:3d45 with SMTP id
 14-20020a0562140cce00b0068f57383d45mr2943765qvx.40.1709053575219; 
 Tue, 27 Feb 2024 09:06:15 -0800 (PST)
Received: from [192.168.2.121] (lfbn-cor-1-12-50.w86-211.abo.wanadoo.fr.
 [86.211.108.50]) by smtp.gmail.com with ESMTPSA id
 j3-20020a0cf303000000b0068fdc6f89cbsm4310043qvl.133.2024.02.27.09.06.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 09:06:14 -0800 (PST)
Message-ID: <c50d9dda-5d4b-494d-86ed-74425a1fd315@redhat.com>
Date: Tue, 27 Feb 2024 18:06:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 14/18] intel_iommu: Add a framework to check and
 sync host IOMMU cap/ecap
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240201072818.327930-1-zhenzhong.duan@intel.com>
 <20240201072818.327930-15-zhenzhong.duan@intel.com>
 <750f1f96-5e6f-4ef0-9436-9b7947515e05@redhat.com>
 <SJ0PR11MB67441887EF4A8F6658DD86F5925A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB67441887EF4A8F6658DD86F5925A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Zhenzhong,

On 2/26/24 08:36, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: Re: [PATCH rfcv2 14/18] intel_iommu: Add a framework to check
>> and sync host IOMMU cap/ecap
>>
>>
>>
>> On 2/1/24 08:28, Zhenzhong Duan wrote:
>>> From: Yi Liu <yi.l.liu@intel.com>
>>>
>>> Add a framework to check and synchronize host IOMMU cap/ecap with
>>> vIOMMU cap/ecap.
>>>
>>> The sequence will be:
>>>
>>> vtd_cap_init() initializes iommu->cap/ecap.
>>> vtd_check_hdev() update iommu->cap/ecap based on host cap/ecap.
>>> iommu->cap_frozen set when machine create done, iommu->cap/ecap
>> become readonly.
>>> Implementation details for different backends will be in following patches.
>>>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>  include/hw/i386/intel_iommu.h |  1 +
>>>  hw/i386/intel_iommu.c         | 41
>> ++++++++++++++++++++++++++++++++++-
>>>  2 files changed, 41 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/hw/i386/intel_iommu.h
>> b/include/hw/i386/intel_iommu.h
>>> index bbc7b96add..c71a133820 100644
>>> --- a/include/hw/i386/intel_iommu.h
>>> +++ b/include/hw/i386/intel_iommu.h
>>> @@ -283,6 +283,7 @@ struct IntelIOMMUState {
>>>
>>>      uint64_t cap;                   /* The value of capability reg */
>>>      uint64_t ecap;                  /* The value of extended capability reg */
>>> +    bool cap_frozen;                /* cap/ecap become read-only after frozen */
>>>
>>>      uint32_t context_cache_gen;     /* Should be in [1,MAX] */
>>>      GHashTable *iotlb;              /* IOTLB */
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index ffa1ad6429..7ed2b79669 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -3819,6 +3819,31 @@ VTDAddressSpace
>> *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>>>      return vtd_dev_as;
>>>  }
>>>
>>> +static int vtd_check_legacy_hdev(IntelIOMMUState *s,
>>> +                                 IOMMULegacyDevice *ldev,
>>> +                                 Error **errp)
>>> +{
>>> +    return 0;
>>> +}
>>> +
>>> +static int vtd_check_iommufd_hdev(IntelIOMMUState *s,
>>> +                                  IOMMUFDDevice *idev,
>>> +                                  Error **errp)
>>> +{
>>> +    return 0;
>>> +}
>>> +
>>> +static int vtd_check_hdev(IntelIOMMUState *s, VTDHostIOMMUDevice
>> *vtd_hdev,
>>> +                          Error **errp)
>>> +{
>>> +    HostIOMMUDevice *base_dev = vtd_hdev->dev;
>>> +
>>> +    if (base_dev->type == HID_LEGACY) {
>>> +        return vtd_check_legacy_hdev(s, vtd_hdev->ldev, errp);
>>> +    }
>>> +    return vtd_check_iommufd_hdev(s, vtd_hdev->idev, errp);
>> Couldn't we have HostIOMMUDevice ops instead of having this check here?
> Hmm, not sure if this is deserved. If we define such ops, it has only one function
> check_hdev and we still need to check base_dev->type to assign different
> function to HostIOMMUDevice.ops.check_hdev in vtd_dev_set_iommu_device().
OK maybe this is over engineered. Drop that comment for now

Thanks

Eric
>
> Thanks
> Zhenzhong


