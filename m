Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DEFC83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 17:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZvGO-0005Lx-GU; Thu, 10 Jul 2025 13:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uZuej-0003lk-2f
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 13:01:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uZueg-000695-C8
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 13:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752166912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d986X0zt2tb5c9IGcVptDd3DACcaChrt6goFr/oFoUs=;
 b=En4gmx6FxmGwfxQsUf0a7BQ7y/20WSPQuV0eQLQErpewfTm8B48k8OMJCih0aiTtyaKsHo
 fo4WlDX+eL37anC5lUwSUjj6QRV+CPyyspBVt/Sh7uK2/AUvFYLoiPhTTW8eS9G8x4SI6k
 XsXBRFLzsQIFA/y7FOO5I9qtP/4B0Ac=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-2nL1IJLHMjimhedFruDEZA-1; Thu, 10 Jul 2025 13:01:51 -0400
X-MC-Unique: 2nL1IJLHMjimhedFruDEZA-1
X-Mimecast-MFC-AGG-ID: 2nL1IJLHMjimhedFruDEZA_1752166910
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3132c1942a1so1912639a91.2
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 10:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752166910; x=1752771710;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d986X0zt2tb5c9IGcVptDd3DACcaChrt6goFr/oFoUs=;
 b=sGfxgz3LIa8ToQlKGAFRhlhw8zHn5rfrk/y6Z8IVnZ6cy6rFXt3ADzGybBTAtg/2ie
 wGwBFj/vPU+MZh00ZdMe+XvzGLpXpWPwpoggQZItY0a3PRl0nOMcMCuVJNreKCWxVt2p
 300BPrgg5M16GdKUZzWMnsrrmivYbiRvIjQ1Q+y9vNqS2m318tNr+v8c6fq2QJ6oKXwY
 lbhllYKuehuEwAa/59Py2Kh13GX0hUyKvLvx76vA/FGexqIrxcGdFXf/b8ZeoTDw2aRn
 qhpT6fvODY2Wt8HMskvhEKB7sKqmlA7OCkNniI3e5/MUkdNx/jGEUmrAhwK/ILZ28de4
 e+qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBlrO7lyGk7dqB86lEfoXNTZolnFbM7KEG6aAjEAPPNOoyvL6NnBOjYpw2N8G1whVo2TzPFDitw22+@nongnu.org
X-Gm-Message-State: AOJu0YyXvh5OWQG7hxmp+JaiIykRClpOrenbMqo0+5JPPVhObB9YaD8X
 UTRMTOIt2GOuOjzi+JDX9wl6hXs5rzw5W4nVE/23t+71mdLYVlz6bcVG2MwOw6eXHGFCiTwnB77
 h3aw6kSKCnGQZGU6xj/dXVc93pWy8zulCjF6ERfzKlyLU0NLBu4ZVnveP
X-Gm-Gg: ASbGncvcU8lFnCVTXrKnmfTEyQRsxdgQDa2+YoMHfFoJvx3Rd0V1Tx9O8jnOV5vGqis
 BDnR9hzsuj0yv2GAr4qQUmf7a/dFJXFrHd3qh/Uc7kI1QZ4Bp4SvogPSfxEuIOu/2puhhMxU8Lr
 g0kSfDFy6gPUMOJWnWW6Ah3R1FozxseYL6Kw1mTICJRLpDcH28cZK9jgwXmxwjWVHui3kmegfHp
 Ny/9ThOCH8kZcDcT9MwNYvuam7dnJ4S0bNUnvCcSCqZNp3HJ7sO0QNUvr68nfrMb6d5ISZHPVEE
 VMeyRTMRwrUWNEVZf2MPUNY=
X-Received: by 2002:a17:90b:4b49:b0:315:cbe0:13b3 with SMTP id
 98e67ed59e1d1-31c4cce94d3mr362131a91.7.1752166909940; 
 Thu, 10 Jul 2025 10:01:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJyi3QOlY4NpK9V/pcw/i9QRMuECt12m6lK6KctxVNU6hFVwpRzj3hbORVLVUjll/4SpMRyA==
X-Received: by 2002:a17:90b:4b49:b0:315:cbe0:13b3 with SMTP id
 98e67ed59e1d1-31c4cce94d3mr362056a91.7.1752166909368; 
 Thu, 10 Jul 2025 10:01:49 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c3e972298sm2778486a91.11.2025.07.10.10.01.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 10:01:48 -0700 (PDT)
Message-ID: <5542e55f-5cd9-40f8-bb45-fe6d851140b1@redhat.com>
Date: Thu, 10 Jul 2025 13:01:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/20] hw/pci: Introduce pci_device_get_viommu_cap()
Content-Language: en-US
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
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <b3787ed4219743e2a65edd13ff44d9b9@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ddutile@redhat.com;
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



On 7/10/25 4:11 AM, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Nicolin Chen <nicolinc@nvidia.com>
>> Sent: Wednesday, July 9, 2025 8:20 PM
>> To: Donald Dutile <ddutile@redhat.com>
>> Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>; qemu-
>> devel@nongnu.org; alex.williamson@redhat.com; clg@redhat.com;
>> eric.auger@redhat.com; mst@redhat.com; jasowang@redhat.com;
>> peterx@redhat.com; jgg@nvidia.com; Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; joao.m.martins@oracle.com;
>> clement.mathieu--drif@eviden.com; kevin.tian@intel.com;
>> yi.l.liu@intel.com; chao.p.peng@intel.com
>> Subject: Re: [PATCH v3 02/20] hw/pci: Introduce
>> pci_device_get_viommu_cap()
>>
>> On Wed, Jul 09, 2025 at 01:55:46PM -0400, Donald Dutile wrote:
>>>>> +enum {
>>>>> +    VIOMMU_CAP_STAGE1 = BIT_ULL(0),  /* stage1 page table
>> supported */
>>>>> +};
>>>>
>>>> Thanks for this work. I am happy to see that we can share the
>>>> common code that allocates a NESTING_PARENT in the core using
>>>> this flag.
>>>>
>>>> Yet on ARM, a STAGE1 page table isn't always a nested S1, the
>>>> hardware accelerated one. More often, it can be just a regular
>>>> 1-stage translation table via emulated translation code and an
>>>> emulated iotlb.
>>>>
>>> Because the user-created smmuv3 started as 'accelerated smmuv3',
>>> and had been 'de-accelerated' to simply 'user created smmuv3',
>>> I'm looking for some clarification in the above statement/request.
>>>
>>> Is the above suppose to reflect that a nested IOMMU has some hw-
>> acceleration
>>> in its Stage1 implementation?
>>> If so, then call it that: STAGE1_ACCEL.
>>> If it's suppose to represent that an IOMMU has nested/2-stage support,
>>> then the above is a valid cap;  -but-, having a nested/2-stage support
>> IOMMU
>>> doesn't necessarily mean its accelerated.
>>
>> Well, there are an emulated "nested" mode and an hw-accelerated
>> "nested" mode in the smmuv3 code, so we had to choose something
>> like "accel" over "nested".
>>
>> Here, on the other hand, I think the core using this CAP would
>> unlikely care about an emulated "nested" mode in the individual
>> vIOMMU..
>>
>> So I suggested:
>>       /* hardware-accelerated nested stage-1 page table support */
>>      VIOMMU_CAP_NESTED_S1 = BIT_ULL(0),
>>
>> which it should be clear IMHO.
>>
>> If not, maybe go a bit further like "VIOMMU_CAP_HW_NESTED_S1"?
> 
> I am not sure the _S1 part makes much sense in ARM case. It doesn't matter
> whether the Guest SMMUv3 is configured in s1/s2 or nested for this CAP.
> With the new SMMUv3 dev support, the user can pretty much specify,
> 
> -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.1,accel=on,stage={stage1|stage2|nested}
> 
> And I think it will work with a host SMMUv3 nested configuration in all the
> above cases. Unless I am missing something and we need to restrict its
> use with stage=stage1 only.
> 
> Thanks,
> Shameer
> 


