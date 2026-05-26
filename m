Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A73CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 13:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsDF-0003MI-SZ; Tue, 26 May 2026 09:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wRsDD-0003Lg-Ln
 for qemu-devel@nongnu.org; Tue, 26 May 2026 09:52:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wRsDA-0003e4-S5
 for qemu-devel@nongnu.org; Tue, 26 May 2026 09:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779803567;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WXrULs/oSXmIN2UzJZ/abXzzQGkCIlcShXbpCnKwkKo=;
 b=PcgiKhNmvSopJNGJBLKpmL1Wml3t+nkBAwoZGW1DwXwXUVMtF9GN1yU6rZ/8Fd0WCOPNVH
 8LY8UbhzlAWvlMxCjRtx/n67SvnPgOcA4BGnkR+Rzmhc/e61TXkkUrQSA/C4qd6y2t98S5
 D09ao6g3C+TJ1B7tRX7FvUgFQBPllns=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-WvAJ1zJPPMaOsL2wnJ1kjA-1; Tue, 26 May 2026 09:52:44 -0400
X-MC-Unique: WvAJ1zJPPMaOsL2wnJ1kjA-1
X-Mimecast-MFC-AGG-ID: WvAJ1zJPPMaOsL2wnJ1kjA_1779803563
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48e89faa62eso62618175e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 06:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779803563; x=1780408363;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WXrULs/oSXmIN2UzJZ/abXzzQGkCIlcShXbpCnKwkKo=;
 b=kCEy8pYVedR6wN7vNDj6vwF0H5pWtzdrPwTf16Z30IE2TuJSDWBSvdE6MRqjO3d5yR
 vkrCs+ewEzQ95dAkp9aKZ9JMTcnxQ7h8pvFQLM97/Cu7uaiHjcFR/MeNd7sdHzrv6ct+
 1fV9xkBIIZAmGj/XZZeKEbJU5PPY7TYMkha+cGBwp8Y+GdrXye8uKdeKejziXpnQ2WBh
 BLPM/TJ0XebcCnC+0RY70YLYiCd9zPfBCIJIXUlvcBH5sF8FH9/zXbFnmxOt76e35oBA
 f/Z3SUjZBV0McYfYw9TE5LAXq8CoG+k7Pz2eyeajDjsEyJJbX34+gN7gslVcn6xKlSNv
 CJFg==
X-Forwarded-Encrypted: i=1;
 AFNElJ94J3x+iLQ0/fdLiqia5sJMGdCaWIRRdgpk+NDIpKX8NBNfo3m8UQg2U00q2Q68QKTXYC6TeCKXBFgb@nongnu.org
X-Gm-Message-State: AOJu0YxWQfvbtqEdWluJlpM0areTcnVwI27yfX8HhgplrmlOxri4CBIM
 oBZMdlpPUZPgMmhVPaqij8dGCkv5YwqzrfsomHLhmoa9ZNHink/yTdFaHZDqbkFCbjmiTd4g3SX
 EkrrODHPW+iXasbvEhUFHVUEi3hVWMOtu6mBm65AmfShkg/oYl0g6+DRT
X-Gm-Gg: Acq92OFgnN/+jb94rjc+ogfgUmwQDdeARxII70gHiCR8x/2kGEe6dHhNLI21WFCm/LM
 pb41/tqvIz2Q7HXspk5N2yebyQxSdjritTTyWPyD5h9n0Fjv9gdyTDjJ/5cOW6g2J/vn3Ia1lO6
 EAcjtGkwQH4JGXAKMUlg51eZJKO2CBPSJn8OvNPqS95JgGwr0SMExm/ef24Al+ZjL5zG0Offdha
 cB65ixf/TaBKKYggRHqKDbYh+0foLO7JVkB98zHbZ7ROCdJBSkZh4VIfsybTTphhZdkVfvPUpZk
 FhQntHODjzcZCTwVpGjPo4Xojoslr0j7ci4bK4AaUA4SJhYg04xrnooU/PTcxkR23kuXywxXZVd
 QNHntXPeLRI7Nz7aNfziEJUqIbJZCmixbBBPLWqi3mYSXJQh0XoCnVQb7tv2WZSSdBwEidWnYsx
 yw5Rzc
X-Received: by 2002:a05:600c:4ecc:b0:490:3c90:2cda with SMTP id
 5b1f17b1804b1-490426cef73mr297957505e9.20.1779803562911; 
 Tue, 26 May 2026 06:52:42 -0700 (PDT)
X-Received: by 2002:a05:600c:4ecc:b0:490:3c90:2cda with SMTP id
 5b1f17b1804b1-490426cef73mr297957165e9.20.1779803562500; 
 Tue, 26 May 2026 06:52:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d6ebf0sm36902751f8f.34.2026.05.26.06.52.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 06:52:41 -0700 (PDT)
Message-ID: <c2b6e502-0bd5-4b1f-b2c3-dcbc760ca733@redhat.com>
Date: Tue, 26 May 2026 15:52:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 20/32] hw/arm/tegra241-cmdqv: Use mmap'd VINTF page0 as
 VCMDQ backing
Content-Language: en-US
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>, "phrdina@redhat.com"
 <phrdina@redhat.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-21-skolothumtho@nvidia.com>
 <2a4edb3b-064b-4c46-8737-1bd74d5f22e9@redhat.com>
 <CH3PR12MB754807F1C34CCB89A73A219EAB0E2@CH3PR12MB7548.namprd12.prod.outlook.com>
 <862edcac-d8b0-465a-bc58-11678ff15890@redhat.com>
 <CH3PR12MB75481CAA2DD727BC68C88AA3AB0B2@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB75481CAA2DD727BC68C88AA3AB0B2@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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



On 5/26/26 3:00 PM, Shameer Kolothum Thodi wrote:
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 26 May 2026 13:20
>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; clg@redhat.com; alex@shazbot.org; Nicolin
>> Chen <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt
>> Ochs <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
>> <jgg@nvidia.com>; zhenzhong.duan@intel.com; Krishnakant Jaju
>> <kjaju@nvidia.com>; phrdina@redhat.com
>> Subject: Re: [PATCH v5 20/32] hw/arm/tegra241-cmdqv: Use mmap'd VINTF
>> page0 as VCMDQ backing
>>
>> External email: Use caution opening links or attachments
>>
>>
>> Hi Shameer,
>>
>> On 5/21/26 5:46 PM, Shameer Kolothum Thodi wrote:
>>> Hi Eric,
>>>
>>>> -----Original Message-----
>>>> From: Eric Auger <eric.auger@redhat.com>
>>>> Sent: 21 May 2026 14:41
>>>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
>>>> arm@nongnu.org; qemu-devel@nongnu.org
>>>> Cc: peter.maydell@linaro.org; clg@redhat.com; alex@shazbot.org; Nicolin
>>>> Chen <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt
>>>> Ochs <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
>>>> <jgg@nvidia.com>; zhenzhong.duan@intel.com; Krishnakant Jaju
>>>> <kjaju@nvidia.com>; phrdina@redhat.com
>>>> Subject: Re: [PATCH v5 20/32] hw/arm/tegra241-cmdqv: Use mmap'd
>> VINTF
>>>> page0 as VCMDQ backing
>>>>
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> Hi Shameer,
>>>>
>>>> On 5/19/26 12:36 PM, Shameer Kolothum wrote:
>>>>> Introduce tegra241_cmdqv_vintf_ptr() to route VCMDQ Page0 register
>>>>> accesses through the mmap'd VINTF page0 backing once a hardware
>>>>> queue has been allocated.
>>>>>
>>>>> There are two QEMU trapped MMIO apertures for VCMDQ Page0
>> registers:
>>>>>   - Direct VCMDQ Page0 aperture (offset 0x10000)
>>>>>   - VINTF Page0 (offset 0x30000)
>>>>>
>>>>> These are hardware aliases: they address the same underlying
>>>>> registers. A subsequent patch maps the VINTF aperture as a
>>>>> guest-direct RAM region; in this patch both remain QEMU-trapped.
>>>>>
>>>>> VCMDQ Page0 accesses operate in one of two mutually exclusive modes,
>>>>> depending on whether a hardware queue (IOMMU_HW_QUEUE_ALLOC)
>>>> has
>>>>> been allocated for the VCMDQ:
>>>>>
>>>>>   Pre-alloc:  vintf_ptr is NULL. Both apertures use QEMU's register
>>>> do you mean vintf_page0 instead of vintf_ptr.
>>>>
>>>> vintf_page0 is set on mmap, right? and not on hwqueue_alloc
>>> Yeah. I actually meant the ptr returned by tegra241_cmdqv_vintf_ptr()
>>>
>>>> Besides pre/post-alloc sounds a bit confusing to me since it can mean
>>>> queue_alloc or mmap.
>>>> If I understand correctly vintf_page0 can be set while hwqueue_alloc has
>>>> not been done yet and conversely, hence the double check below:
>>> The "alloc" is in reference to a vcmdq is "allocated" to a vintf. I think spec
>>> has that usage.
>>>
>>> Anyway, I will make it clear.
>>>
>>>> +    if (!cmdqv->vcmdq[index] || !cmdqv->vintf_page0) {
>>>>
>>>>
>>>>>               cache. Hardware is not yet engaged.
>>>>>
>>>>>   Post-alloc: vintf_ptr is valid. Both QEMU trapped apertures access
>>>>>               registers directly via the mmap'd vintf_page0 pointer,
>>>>>               bypassing the cache. Hardware is the single source of
>>>>>               truth.
>>>>>
>>>>> The pre-to-post-alloc transition is triggered by the IOMMUFD hardware
>>>> so here you mean alloc is hw queue alloc
>>>>> queue allocation. The tegra241_cmdqv_sync_vcmdq() copies any pre-
>> alloc
>>>>> cached writes (CONS_INDX, PROD_INDX, CONFIG, GERRORN) into the
>>>> mmap'd
>>>>> page so the guest's view survives the transition.
>>>>>
>>>>> CMDQV acceleration only becomes active once the guest enables VINTF
>>>>> and the corresponding HW QUEUE is allocated through IOMMUFD. Until
>>>>> then, all VCMDQ accesses are served from the emulated register cache
>>>>> with no real hardware command processing. This matches the CMDQV
>>>>> hardware specification: if the logical CMDQ index does not map to any
>>>>> allocated Virtual CMDQ, "the access is dropped with no Fault/Interrupt".
>>>> I still does not realy understand what would be the problem of directly
>>>> mapping the direct cmdqv page0 too - I understand that theoretically the
>>>> direct view is larger than the VINTF one though -. I still think a
>>>> proper explanation is missed in this patch of 22/32
>>>>
>>>> Assuming the guest tries to set up some unmapped vcmdqs in the direct
>>>> cmdqv page and this eventually ends up writing into the VINTF view, what
>>>> would happen and in which terms does it violate the spec?
>>> Ok. Let me try to explain my understanding.
>>>
>>> This is my rationale after reading Nicolin's explanation here on the
>>> RFC where we had both direct aperture and vintf page 0 mapped to Guest .
>>> https://lore.kernel.org/qemu-devel/aXkTzRM695oTWFaD@Asurada-
>> Nvidia/
>>> Consider the example:
>>>
>>> QEMU advertises 2 VCMDQs (CMDQV_NUM_CMDQ_LOG2=1).
>>> Guest allocates vcmdq0 only, leaves vcmdq1 unallocated, then on the
>>> direct aperture for vcmdq1:
>>>
>>>   write 0x10 ->  A_VCMDQ1_PROD_INDX
>>>   read     A_VCMDQ1_PROD_INDX
>>>
>>> If we aliased the direct aperture to the VINTF mmap, the write
>>> would physically hit VINTF Page 0 in HW at an unmapped logical
>>> slot. And the spec says(p.172):
>>>
>>> " If no Virtual CMDQ is mapped to the Guest, or if the logical CMDQ index in
>>> the Virtual Interface being accessed by the software does not map to any
>> Virtual
>>> CMDQ, the access is dropped with no Fault/Interrupt."
>> OK
>>> So even though guest is using the direct aperture, in turn it ends up
>>> accessing the corresponding vinf page0 and won't see whatever it wrote.
>>>
>>> I think this contradicts spec p.176 where it says:
>>>
>>> "While the software can program the Virtual CMDQ(s) directly using the
>>> direct VCMDQ aperture (and not through the Virtual Interface), it is
>>> required that the VCMDQ be allocated to a Virtual  Interface before it
>>> is used to send commands to the SMMU."
>>>
>>> So the spec allows register programming through the direct aperture
>>> without requiring the VCMDQ to be allocated first.
>> Hum. So it is said if the cmdqv is not mapped on the VI you cannot send
>> commands to it through the direct aperture. But it does not say what
>> does happen if you do so. Why wouldn't the VI behavior be wrong, ie. "
>>
>> the access is dropped with no Fault/Interrupt."
> "While the software can program the Virtual CMDQ(s) directly using the
>   direct VCMDQ aperture (and not through the Virtual Interface), it is
>   required that the VCMDQ be allocated to a Virtual Interface before it
>   is used to send commands to the SMMU."
>
> Assuming your question is regarding the above quote:
>
> The quote is about the direct aperture and says the software "can
> program the Virtual CMDQ(s) directly using the direct VCMDQ aperture",
> and only the "send commands to the SMMU" step is gated by VINTF
> allocation. If direct-aperture writes were also dropped for unallocated
> VCMDQs, the "can program directly" wording wouldn't be meaningful.
>
> "Can program" behaviour:
>
> write 0x10 ->  A_VCMDQ1_PROD_INDX
> read       A_VCMDQ1_PROD_INDX  // read returns 0x10
>
>
> "Drop" behaviour:
>
> write 0x10 ->  A_VCMDQ1_PROD_INDX
> read       A_VCMDQ1_PROD_INDX  // read returns 0 or undefined
>
> Hope this answers your question. let me know if not.

On my end, I read that the software can use either the direct view or
the VINTF view as long as the cmdqv is mapped. And if the vcmdq is not
mapped we are not really told what happens.
But anyway this use case of using the direct view looks pretty marginal,
doesn't it. So feel free to interpret it as you agree with Nicolin and
HW experts.

Thanks

Eric

>
> Thanks,
> Shameer
>
>
>
>
>


