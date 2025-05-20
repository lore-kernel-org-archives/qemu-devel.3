Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A95EC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 10:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKVP-000267-L6; Tue, 20 May 2025 06:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uHKVO-00025x-I3
 for qemu-devel@nongnu.org; Tue, 20 May 2025 06:47:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uHKVM-000859-G6
 for qemu-devel@nongnu.org; Tue, 20 May 2025 06:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747738046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cOTMari4/6D2f8OgSEEBl3l5eaUxBWZL2VdfVMUyieI=;
 b=PTDa73rIg3RlAHLGEk81WiYu0beqiQFXfgKcSGK4CMsUndzbWzCyLZCN2Dq4o83cynDarC
 joDq5mI7GvKmK8CNp8bu8DTBSFQ5rd3WKr5oDu2U3pD1Xhk4bGFqGtSKV+HHAIGgvD3aZ1
 OKBiIE+wwTfZ8wfg1vxOeQjCPmRImgQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-JRTkypSzMcyYkDZNoJiSGg-1; Tue, 20 May 2025 06:47:25 -0400
X-MC-Unique: JRTkypSzMcyYkDZNoJiSGg-1
X-Mimecast-MFC-AGG-ID: JRTkypSzMcyYkDZNoJiSGg_1747738044
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c5f3b8b1a1so906846885a.3
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 03:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747738044; x=1748342844;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cOTMari4/6D2f8OgSEEBl3l5eaUxBWZL2VdfVMUyieI=;
 b=WiA3CgfuepdBA7i2CKAJmZvvD6tBJKtnGvc2HlTlk/sek0f8aUBviPlNO2IF3LG7rw
 XEQNi+Gv9Vg2D8jkK273VFgXyX2g97cch8VPCP3hCW+GT1GTRDmWAWsqwSsvJaQ6Xah/
 IkgN1HGqu6NWpSTVz/JQxEq+4ajm02MGWnS/t7ZGucuSlf6JEvI7j7znAvwKB+OImzG1
 qBgaoE0iEiuNl7/b5YvN5qrz4cc1PpcxSlPCpCtH+UJ1iomomKfXQjCyjTo5u73w5c7u
 3GQygZxQtKTUwzZdHVvOfVPPSrzELmlGUsbb495VJTTCgNaFed6V96LVtqa6wDA3NX58
 KPDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqvGop9dVpnqhZz21rr/EmOM8lVozA3G1sy5wX+UPH+1IlNucDE8oiI0P0cH6dIzxM6Jn14T3PTgRH@nongnu.org
X-Gm-Message-State: AOJu0Yw6vtKa05PfVmOWihMEawXrxxVf9d0xQZRev0dlsDq3a6Q02Dph
 CRufyVYTZDr2YSLXNyVP77SGQHEJg35Pm7irgf2WOBqoq2OK7TVazoSsfa+7Sl/opMgX6nAjzHw
 En5m3cq5JiGCvM4V+LmKupMU3B1iaS8xQG4DK7m3g3XRRIA9rZIqFMMTY
X-Gm-Gg: ASbGnctjvKD3Hnl8AmoVr1v5oh70X1sOMwrF+b6Cdtcz1rnHxKDfo1Be70Q/S6z5kte
 iJwwjOEMpkh5WwrxvgSzZVt3p84TC1tMazI3w0zNZIawXDCSkff0794K9C0NUoZsvvDsnpoL1En
 3CtzkIQ2scbiyxt84sNmRVQHxfZwSRQLCZy/VLZC5uKYGkBAWa6FUcfB6bYcZQIzSmNMr2zLAEf
 YC1pmlG7GuxRzAQnGvoBbom7ZRm3CMOIGRbbfDyh64HrPRk6zr72CMm0cP7Se2SDt32yMk9y+LQ
 fmLAQCSD4ZoK
X-Received: by 2002:ad4:568f:0:b0:6f8:c284:45c5 with SMTP id
 6a1803df08f44-6f8c284460bmr150118626d6.4.1747738044429; 
 Tue, 20 May 2025 03:47:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWgFp/qejqmQJybqEwNG0a2biVg16SQOWYXZC6Wfq6SLUTY4USJKsf35tRcqFbGkAaxaIMjg==
X-Received: by 2002:ad4:568f:0:b0:6f8:c284:45c5 with SMTP id
 6a1803df08f44-6f8c284460bmr150118296d6.4.1747738043992; 
 Tue, 20 May 2025 03:47:23 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f8b097a782sm69410236d6.104.2025.05.20.03.47.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 03:47:23 -0700 (PDT)
Message-ID: <9eee8ee6-357c-4bd7-a1ce-c5785bf69fdb@redhat.com>
Date: Tue, 20 May 2025 06:47:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 00/20] intel_iommu: Enable stage-1 translation for
 passthrough device
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <eacfc52a-2dee-49a8-8994-67b738ece68d@redhat.com>
 <SJ0PR11MB6744472953C10F7858FF406F929CA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <6b9c1f0a-be56-451e-bb8d-833b402b78d8@redhat.com>
 <SJ0PR11MB6744D7EC0B34ED5D5DC679C2929FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <SJ0PR11MB6744D7EC0B34ED5D5DC679C2929FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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



On 5/20/25 5:13 AM, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Donald Dutile <ddutile@redhat.com>
>> Subject: Re: [PATCH rfcv2 00/20] intel_iommu: Enable stage-1 translation for
>> passthrough device
>>
>> Hey Zhenzhong,
>> Thanks for feedback. replies below.
>> - Don
>>
>> On 5/19/25 4:37 AM, Duan, Zhenzhong wrote:
>>> Hi Donald,
>>>
>>>> -----Original Message-----
>>>> From: Donald Dutile <ddutile@redhat.com>
>>>> Subject: Re: [PATCH rfcv2 00/20] intel_iommu: Enable stage-1 translation for
>>>> passthrough device
>>>>
>>>> Zhenzhong,
>>>>
>>>> Hi!
>>>> Eric asked me to review this series.
>>>> Since it's rather late since you posted will summarize review feedback
>>>> below/bottom.
>>>>
>>>> - Don
>>>>
>>>> On 2/19/25 3:22 AM, Zhenzhong Duan wrote:
> ...
> 
>>>>             Did you ever put some tracing in to capture avg hits in cache? ... if so,
>> add
>>>> as a comment.
>>>>             Otherwise, looks good.
>>>>
>>>> Patch 11: Apologies, I don't know what 'flts' stands for, and why it is relative
>> to 2-
>>>> stage mapping, or SIOV.  Could you add verbage to explain the use of it, as the
>>>> rest of this patch doesn't make any sense to me without the background.
>>>> The patch introduces hw-info-type (none or intel), and then goes on to add a
>>>> large set of checks; seems like the caps & this checking should go together
>> (split
>>>> for each cap; put all caps together & the check...).
>>>
>>> OK, will do. There are some explanations in cover-letter.
>>> For history reason, old vtd spec define stage-1 as first level then switch to first
>> stage.
>>>
>> So 'flts' is 'first level then switch' .
> 
> Sorry for confusion, it stands for 'first level translation support'.
> 
Thanks.

>>
>>>>
>>>> Patch 12: Why isn't HostIOMMUDevice extended to have another iommu-
>> specif
>>>> element, opaque in HostIOMMUDevice, but set to specific IOMMU in use?
>> e.g.
>>>> void *hostiommustate;
>>>
>>> Yes, that's possible, but we want to make a generic interface between
>> VFIO/VDPA and vIOMMU.
>>>
>> ok. I don't understand how VFIO & VPDA complicate that add.
> 
> IIUC, the hostiommustate provided by VFIO and VDPA may be different format.
> By using a general interface like .get_cap(), we hide the resolving under VFIO and
> VDPA backend. This is like the KVM extension checking between QEMU and KVM.
> 
> FYI, there was some discuss on the interface before,
> see https://lists.gnu.org/archive/html/qemu-devel/2024-04/msg02658.html
> 
Good analogy, thanks. I'll reach out to Cedric on the above discussion as well.

>>
>>>>
>>>> Patch 13: Isn't PASID just an extension/addition of BDF id? and doesn't each
>>>> PASID have its own address space?
>>>
>>> Yes, it is.
>>>
>>>> So, why isn't it handle via a uniqe AS cache like 'any other device'?  Maybe I'm
>>>> thinking too SMMU-StreamID, which can be varying length, depending on
>>>> subsystem support.  I see what appears to be sid+pasid calls to do the AS
>> lookups;
>>>> hmm, so maybe this is the generalized BDF+pasid AS lookup?  if so, maybe a
>>>> better description stating this transition to a wider stream-id would set the
>> code
>>>> context better.
>>>
>>> Not quite get..
>>>
>> I'm looking for a better description that states the AS cache lookup is broadened
>>from bdf
>> to bdf+pasid.
> 
> Guess you mean vtd_as_from_iommu_pasid(), it's a variant of vtd_find_add_as().
> We support AS cache lookup by bdf+pasid for a long time, see vtd_find_add_as().
> 
Thanks for clarification.

>>
>>>> As for the rest of the (400 intel-iommu) code, I'm not that in-depth in intel-
>> iommu
>>>> to determine if its all correct or not.
>>>>
>>>> Patch 14: Define PGTT; the second paragraph seem self-contradicting -- it says
>> it
>>>> uses a 2-stage page table in each case, but it implies it should be different.  At
>> 580
>>>> lines of code changes, you win! ;-)
>>>
>>> The host side's using nested or only stage-2 page table depends on PGTT's
>> setting in guest.
>>>
>> Thanks for clarification.
>>
>>>>
>>>> Patch 15: Read-only and Read/write areas have different IOMMUFDs?  is that
>> an
>>>> intel-iommu requriement?
>>>>             At least this intel-iommu-errata code is only in hw/i386/<> modules.
>>>
>>> No, if ERRATA_772415, read-only areas should not be mapped, so we allocate a
>> new VTDIOASContainer to hold only read/write areas mapping.
>>> We can use same IOMMUFDs for different VTDIOASContainer.
>>>
>> ah yes; I got hung-up on different mappings, and didn't back up to AS-container
>> split & same IOMMUFD.
>>
>>>>
>>>> Patch 16: Looks reasonable.  What does the 'SI' mean after "CACHE_DEV",
>>>> "CACHE_DOM" & "CACHE_PASID" ? -- stream-invalidation?
>>>
>>> VTD_PASID_CACHE_DEVSI stands for 'pasid cache device selective invalidation',
>>> VTD_PASID_CACHE_DOMSI means 'pasid cache domain selective invalidation'.
>>>
>> That explanation helps. :)  maybe put a short blurb in the commit log, or code,
>> so one doesn't have to be a ninja-VTD spec consumer to comprehend those
>> (important) diffs.
> 
> Good idea, will do.
> 
>>
>>> Thanks
>>> Zhenzhong
>>>
>> Again, thanks for the reply.
>> Looking fwd to the rfcv3 (on list) or move to v1-POST.
> 
> Thanks for your comments!
> 
> BRs,
> Zhenzhong
> 
Thanks for the added clarifications.
- Don


