Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BEFC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 06:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucIQH-0003kR-M6; Thu, 17 Jul 2025 02:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ucIQ8-0003OT-Dm
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 02:48:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ucIQ0-0002Tx-KS
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 02:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752734915;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HT6WUAOQ4JuVf6zBd7rvzQZtq5ioZAR+rSbftzCeQCE=;
 b=LR3YGoUjjMWkX/t4foRlX/h9D5kbrVAWnNjckvWYJJxeoK+xDmMOWdJrpVU+QUnOzKPVi8
 jczAjcop2ZlyoH1ZuUVZC/iyoP7H8XlI3aWCnEYxB52AdWdv3ZcljLWfyGLECH+kI+rlsa
 5KEzBqPK6LMYqmNccs5RYMzzg+KlUwk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-Dgy-fDdZOE-mizAjCdYy0A-1; Thu, 17 Jul 2025 02:48:33 -0400
X-MC-Unique: Dgy-fDdZOE-mizAjCdYy0A-1
X-Mimecast-MFC-AGG-ID: Dgy-fDdZOE-mizAjCdYy0A_1752734912
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4eee2398bso232595f8f.1
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 23:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752734912; x=1753339712;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HT6WUAOQ4JuVf6zBd7rvzQZtq5ioZAR+rSbftzCeQCE=;
 b=Nk4XqmXmmE76v9GpYTazOoxpnbn4drdp+sgpgeo0nUN7K1PcPOs2Qn4kFHjY8ie4OY
 MTrAR+D8HxGfTDQ/i/ZDJB/VqGc9eUnlMq2dxV5u4rZilfxfA7NmEspe9kGQ+RAmyXu4
 wGNWyrRGLmKS21miwARiUmG7PH1Z0/gmUt2PXbCOUyya1+kks3SIL9dRYxRuj6N+vzrT
 fg+R4w7+VMzHZ1fKZHb3hF8YBEhm76Q6JR2lqrWcBEzeMg/k7W7264dXm8Ldh28Ab23o
 4iGfRVxToas+0l42a2tLLqJgGLvI7e+ryY6pajFspj8qA5zu+TNAbSLefvuE37FMIfAQ
 33Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu2mNbVwGzGy0uI1kveaxPBCsjEdtuS+fHweFf7pGsNup88B/HqEqkMNkMJdQDyJ3Wl7+NAfoP/0D2@nongnu.org
X-Gm-Message-State: AOJu0YwataIVSOVZ8LvCcZMnJcgiQv2AxO9L/IwJsu+DQyJp85ma3Ecl
 YSE5FhNVKYcJ6NJPZED0G66XtflTcXh0F7ZDu/LbN6wnfBBU3PlkpAE021/7WPnJoG01Q11SqF3
 5T6RbIhDHcBLd6uWfYLmFU8ISUeL5tkg9MIHzDXm/Ppw/qmbRmZLxpIJ5
X-Gm-Gg: ASbGncs6UAeAWcUAKsb0xvnLd6QzYX2Cb6lSb0JSh2B/h2VT4z4jedjiMJ2MZGhidAi
 W+t/0Y7WNJ2sYAzDrA6C+UemFuKaSzuFrmf6QpJVczdBS8mWDs+wMPRcD7RNSokO0EDLqdfA7rI
 fvzy7cE/1BIJTHRaisH03SFU6dSAXC2dsxkIYbKZnD+upF2OunGSYGZ7YZ5qiBCpd3jiqQuWAHO
 iwo1R0KJLHE6mHbcIgmrx4f5T13BSzjYVqTHKYtzQzmr2ufVRrLKAVW0NJKSxZQjNmqKYSfw7ci
 /ye9IHn2Eajfuq8/qGGKNkpLApdhOPNdRYIeMQZ4Z+/mNDNYuhENv3WtgevcJLYu9PX6LMkEOVQ
 fKzj208Xub28=
X-Received: by 2002:a05:6000:4602:b0:3b5:e6f2:ab4d with SMTP id
 ffacd0b85a97d-3b60dd997cbmr4143355f8f.42.1752734912344; 
 Wed, 16 Jul 2025 23:48:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDWvMf7a4JhT4akbCWXX+idRqkHLugX1pm+Rhp9R0kH0H2MIFchuh/KCxmsYLONGHdTm344A==
X-Received: by 2002:a05:6000:4602:b0:3b5:e6f2:ab4d with SMTP id
 ffacd0b85a97d-3b60dd997cbmr4143331f8f.42.1752734911837; 
 Wed, 16 Jul 2025 23:48:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5f16a6016sm17938812f8f.69.2025.07.16.23.48.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 23:48:30 -0700 (PDT)
Message-ID: <ea639677-65e4-4eda-be7e-e65d13a22afc@redhat.com>
Date: Thu, 17 Jul 2025 08:48:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/20] intel_iommu: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
 <20250708110601.633308-8-zhenzhong.duan@intel.com>
 <342129d6-0b96-440c-83ac-e9b8bc5b18a0@redhat.com>
 <IA3PR11MB9136C85F0799CB91572121FB9256A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <081c3534-332f-454a-985b-4dc81a3dd2a7@redhat.com>
 <IA3PR11MB9136ABA0E88C04CB6E9E80BA9251A@IA3PR11MB9136.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <IA3PR11MB9136ABA0E88C04CB6E9E80BA9251A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/17/25 5:47 AM, Duan, Zhenzhong wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Wednesday, July 16, 2025 8:09 PM
>> To: Duan, Zhenzhong <zhenzhong.duan@intel.com>;
>> qemu-devel@nongnu.org
>> Cc: alex.williamson@redhat.com; clg@redhat.com; mst@redhat.com;
>> jasowang@redhat.com; peterx@redhat.com; ddutile@redhat.com;
>> jgg@nvidia.com; nicolinc@nvidia.com;
>> shameerali.kolothum.thodi@huawei.com; joao.m.martins@oracle.com;
>> clement.mathieu--drif@eviden.com; Tian, Kevin <kevin.tian@intel.com>; Liu,
>> Yi L <yi.l.liu@intel.com>; Peng, Chao P <chao.p.peng@intel.com>
>> Subject: Re: [PATCH v3 07/20] intel_iommu: Check for compatibility with
>> IOMMUFD backed device when x-flts=on
>>
>> Hi Zhenzhong,
>>
>> On 7/16/25 12:31 PM, Duan, Zhenzhong wrote:
>>> Hi Eric,
>>>
>>>> -----Original Message-----
>>>> From: Eric Auger <eric.auger@redhat.com>
>>>> Subject: Re: [PATCH v3 07/20] intel_iommu: Check for compatibility with
>>>> IOMMUFD backed device when x-flts=on
>>>>
>>>> Hi Zhenzhong,
>>>>
>>>> On 7/8/25 1:05 PM, Zhenzhong Duan wrote:
>>>>> When vIOMMU is configured x-flts=on in scalable mode, stage-1 page
>> table
>>>>> is passed to host to construct nested page table. We need to check
>>>>> compatibility of some critical IOMMU capabilities between vIOMMU and
>>>>> host IOMMU to ensure guest stage-1 page table could be used by host.
>>>>>
>>>>> For instance, vIOMMU supports stage-1 1GB huge page mapping, but
>> host
>>>>> does not, then this IOMMUFD backed device should fail.
>>>>>
>>>>> Even of the checks pass, for now we willingly reject the association
>>>>> because all the bits are not there yet.
>>>>>
>>>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>> ---
>>>>>  hw/i386/intel_iommu.c          | 30
>>>> +++++++++++++++++++++++++++++-
>>>>>  hw/i386/intel_iommu_internal.h |  1 +
>>>>>  2 files changed, 30 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>>>> index e90fd2f28f..c57ca02cdd 100644
>>>>> --- a/hw/i386/intel_iommu.c
>>>>> +++ b/hw/i386/intel_iommu.c
>>>>> @@ -40,6 +40,7 @@
>>>>>  #include "kvm/kvm_i386.h"
>>>>>  #include "migration/vmstate.h"
>>>>>  #include "trace.h"
>>>>> +#include "system/iommufd.h"
>>>>>
>>>>>  /* context entry operations */
>>>>>  #define VTD_CE_GET_RID2PASID(ce) \
>>>>> @@ -4355,7 +4356,34 @@ static bool vtd_check_hiod(IntelIOMMUState
>> *s,
>>>> HostIOMMUDevice *hiod,
>>>>>          return true;
>>>>>      }
>>>>>
>>>>> -    error_setg(errp, "host device is uncompatible with stage-1
>>>> translation");
>>>>> +#ifdef CONFIG_IOMMUFD
>>>>> +    struct HostIOMMUDeviceCaps *caps = &hiod->caps;
>>>>> +    struct iommu_hw_info_vtd *vtd = &caps->vendor_caps.vtd;
>>>> I am now confused about how this relates to vtd_get_viommu_cap().
>>>> PCIIOMMUOps.set_iommu_device = vtd_dev_set_iommu_device calls
>>>> vtd_check_hiod()
>>>> viommu might return HW_NESTED_CAP through
>>>> PCIIOMMUOps.get_viommu_cap
>>>> without making sure the underlying HW IOMMU does support it. Is that a
>>>> correct understanding? Maybe we should clarify the calling order between
>>>> set_iommu_device vs get_viommu_cap? Could we check HW IOMMU
>>>> prerequisites in vtd_get_viommu_cap() by enforcing this is called after
>>>> set_iommu_device. I think we should clarify the exact semantic of
>>>> get_viommu_cap().Thanks Eric
>>> My understanding get_viommu_cap() returns pure vIOMMU's capabilities
>>> with no host IOMMU's capabilities involved.
>>>
>>> For example, returned HW_NESTED_CAP means this vIOMMU has code
>>> to support creating nested hwpt and attaching, no matter if host IOMMU
>>> supports nesting or not.
>> Then I think you need to refine the description in 2/20 to make this clear.
>> stating explicitly get_viommu_cap returns theoretical capabilities which
>> are independent on the actual host capabilities they may depend on.
> Will do.
>
> For virtual vtd, we are unable to return capabilities depending on host capacities,
> Because different host IOMMU may have different capabilities, we want to return
> a consistent result only depending on user's cmdline config.
ok
>
>>> The compatibility check between host IOMMU vs vIOMMU is done in
>>> set_iommu_device(), see vtd_check_hiod().
>>>
>>> It's too late for VFIO to call get_viommu_cap() after set_iommu_device()
>>> because we need get_viommu_cap() to determine if creating nested parent
>>> hwpt or not at attaching stage.
>> isn't it possible to rework the call sequence?
> I think not. Current sequence:
>
> attach_device()
>     get_viommu_cap()
>     create hwpt
> ...
> create hiod
> set_iommu_device(hiod)
>
> Hiod realize needs iommufd,devid and hwpt_id which are ready after attach_device().
OK. I would add this explanation in the commit msg too.
>
> Thanks
> Zhenzhong
Thanks

Eric


