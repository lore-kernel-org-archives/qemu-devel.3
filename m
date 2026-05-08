Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B96CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 14:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMIY-0007ts-Gs; Fri, 08 May 2026 10:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wLMIW-0007r2-AN
 for qemu-devel@nongnu.org; Fri, 08 May 2026 10:35:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wLMIU-0006p6-21
 for qemu-devel@nongnu.org; Fri, 08 May 2026 10:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778250920;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b9aWkoTsVfU36kTen9GYLthEt7/fGAO30KXkkbX41rw=;
 b=AWc7EckcK3FXKYkNYaVMlb6vujva82JpsFbNP/whn9t4kKq2ZNqJWGTtf4RixlGVtPjxgz
 qzrOGc6nt73rHRzGPe9kJnvtnfk6fRfas9k8P6GeJSYoXCA58KZEbIwzRvbQdh6TKuzhQ8
 N1WjaejSDKbHMLFXWdRN1PhJgkmF9EA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-IhsZg5r2OHSAm5vcCY6PsA-1; Fri, 08 May 2026 10:35:15 -0400
X-MC-Unique: IhsZg5r2OHSAm5vcCY6PsA-1
X-Mimecast-MFC-AGG-ID: IhsZg5r2OHSAm5vcCY6PsA_1778250914
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-44a3aee3813so1132666f8f.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 07:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778250914; x=1778855714;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b9aWkoTsVfU36kTen9GYLthEt7/fGAO30KXkkbX41rw=;
 b=Npbw3y8dR4fjEx/aReKpe1ylsT8a138G4mTjMBnHyVmbbUWQsBcDzi5Y3C8BW8UWzA
 lZ4pk2fziB5v7ZomdPs1zhI0aha+FTVOcNlzeen//sILbS1HelKXt3xRC7ImXijE6Rjg
 JktW5LfDpSMARtFd/xF4RIbXl7rKZScynT60wqXgTm/SzcApmla7Kv7FtyDCUbq0al9I
 cIg/DHcMrgpTJIdwRoxQJhvbERXFq7/JiqRoNNKVGX6ZMb/EpCnRguKZjB7dfZJKQitv
 67NGYrGJ/UTUzcvAXOnZtwNdiom6LhzQiWMqXvWVfnrNy0WUj+goG1Y3zQuTYNq4gAu4
 8gQw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+t/Mm3VhAmk6R1EzgbGs7CaQd74j61HSf/8Wn8iYOWYTfGfzKKx+h4z9vVZvEp7Plh1fMprTKRB4i0@nongnu.org
X-Gm-Message-State: AOJu0YyF9oe4s3+VTxd3Nvx5fIp8UMoEszea/bPWdveGU2UwAbb0otOU
 7a4FTar0I3vm5yUALIBk7x8Ju1zuq4XzZDwyO5A7WQpiHgjmHMNy3wcM8h7vu1InVyPMVcyRwIq
 J0pEMfSsL/KmvPlgY0NAEJKWY1pWrc0xpaWrB6VgsQyvsNIT6qgIpmuIb
X-Gm-Gg: AeBDieu3w64bv+NLqO+uMJRIk8u40di5i/RSEyVv97CFbDHHjEd/Ng8Bh6bsOdjKhzk
 HgDJbayKhFL93Fl/Qpa7Qp87zM06Bay8BjnjaiHimHW4DeFijF+y8n7Ck7wIRYPZO8EENljbzVq
 MAJ1IrDstkxpndzf71WxVabodC9qdyKyJ6VWgOtmKY15WOUddukqD/lc3WpqtxCGLEW0B3UasCv
 +blGZi3S7oVkpPNwhSCDvldGj9y+Qi4CMAftsNvAI6SycD03meV0vVVsutnOvR57+7hIVleQCIq
 QymPIdz04vmqQFWNrqEW41A/CbF06eWwXvXY+gfv4NIjHAhjE1GKTigsEvHdrnDMveN5ucERpsK
 nqiErM43UKAaKbK0rxlNa4o3GILF71IquyHYHqSYLQF+i0BcFTHzaffneL3+756whTkOctQ==
X-Received: by 2002:a05:600c:64c5:b0:488:b241:2c5f with SMTP id
 5b1f17b1804b1-48e51f4584fmr204665255e9.26.1778250913702; 
 Fri, 08 May 2026 07:35:13 -0700 (PDT)
X-Received: by 2002:a05:600c:64c5:b0:488:b241:2c5f with SMTP id
 5b1f17b1804b1-48e51f4584fmr204664655e9.26.1778250913220; 
 Fri, 08 May 2026 07:35:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6d8d69a0sm1269585e9.2.2026.05.08.07.35.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 07:35:12 -0700 (PDT)
Message-ID: <c5fa0f1c-70b5-4ba3-b141-f903f3e93c56@redhat.com>
Date: Fri, 8 May 2026 16:35:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/31] hw/arm/tegra241-cmdqv: Map VINTF page0 into
 guest MMIO space
Content-Language: en-US
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>, "phrdina@redhat.com"
 <phrdina@redhat.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-23-skolothumtho@nvidia.com>
 <4918654a-7c79-474b-9ede-5418460a5a76@redhat.com>
 <CH3PR12MB75486E45A43C6CD5A203D03BAB3F2@CH3PR12MB7548.namprd12.prod.outlook.com>
 <73730082-679d-4cee-afee-659684e420c2@redhat.com>
 <CH3PR12MB75488E10D03A85E9F0C0D622AB3D2@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB75488E10D03A85E9F0C0D622AB3D2@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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



On 5/8/26 11:03 AM, Shameer Kolothum Thodi wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 07 May 2026 17:24
>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; clg@redhat.com; alex@shazbot.org; Nicolin
>> Chen <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt
>> Ochs <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
>> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
>> zhenzhong.duan@intel.com; Krishnakant Jaju <kjaju@nvidia.com>;
>> phrdina@redhat.com
>> Subject: Re: [PATCH v4 22/31] hw/arm/tegra241-cmdqv: Map VINTF page0
>> into guest MMIO space
>>
>> External email: Use caution opening links or attachments
>>
>>
>> On 5/6/26 4:24 PM, Shameer Kolothum Thodi wrote:
>>> Hi Eric,
>>>
>>>> -----Original Message-----
>>>> From: Eric Auger <eric.auger@redhat.com>
>>>> Sent: 06 May 2026 13:45
>>>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
>>>> arm@nongnu.org; qemu-devel@nongnu.org
>>>> Cc: peter.maydell@linaro.org; clg@redhat.com; alex@shazbot.org; Nicolin
>>>> Chen <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt
>>>> Ochs <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason
>> Gunthorpe
>>>> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
>>>> zhenzhong.duan@intel.com; Krishnakant Jaju <kjaju@nvidia.com>;
>>>> phrdina@redhat.com
>>>> Subject: Re: [PATCH v4 22/31] hw/arm/tegra241-cmdqv: Map VINTF page0
>>>> into guest MMIO space
>>>>
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> Hi Shameer,
>>>>
>>>> On 4/15/26 12:55 PM, Shameer Kolothum wrote:
>>>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>>>
>>>>> Once a VCMDQ is allocated, map the mmap'd vintf_page0 region directly
>>>>> into the guest-visible MMIO space at offset 0x30000 as a RAM-backed
>>>>> MemoryRegion. This eliminates QEMU trapping for hot-path CONS/PROD
>>>>> index updates.
>>>>>
>>>>> After this patch, the two VCMDQ apertures use different access paths:
>>>>> the direct aperture (0x10000) remains QEMU-trapped and writes via
>>>>> vintf_ptr, while the VI aperture (0x30000) is a direct guest RAM
>>>>> mapping. Both paths write to the same underlying vintf_page0 memory,
>>>>> so no synchronisation between the apertures is needed.
>>>> I fail to understand when the previous trapped path using ptr in
>>>> tegra241_cmdqv_read/write_vcmdq gets used versus that path. Is it
>>>> eventually used?
>>> The spec does not prevent a guest from using the 0x10000 path for
>> allocated
>>> VCMDQs, so the trap path remains valid and QEMU forwards those accesses
>> to
>>> the mmap'd vintf_page0 via vintf_ptr.
>>>
>>> We cannot map 0x10000 directly to the guest as RAM because the kernel
>>> mmap only backs VCMDQs actually allocated via HW_QUEUE ioctl. If the
>>> guest allocates only 1 of 2 VCMDQs, exposing the full direct aperture page0
>>> as RAM would give the guest access to unallocated VCMDQ slots. Hence, it
>>> remains trapped and QEMU only fwds to vintf page0 for allocated queues.
>> Actually my question rather was why don't we use a subregion_overlap for
>> global vcmdq page0, mapping to vintf_page0 once cmdqv->vintf_page0 is
>> set, just as we do for VINTF0 page0? I understand
>> tegra241_cmdqv_read/write_vcmdq would return the same content anyway.
> This is my understanding why we cannot map direct VCMDQ aperture(0x10000)
> to vintf_page0:
>
>  - Unallocated VCMDQs accessed via vintf_page0 get "access dropped with no
>     Fault/Interrupt" behaviour per spec((p.172)
>
>  - Mapping the direct VCMDQ aperture (0x10000) to vintf_page0 would replicate
>    this behaviour for unallocated VCMDQ accesses via the direct aperture too.
>
>  - However, per spec p.176, software can program VCMDQs via the direct
>    VCMDQ aperture without going through the VINTF. Mapping vintf_page0
>    at 0x10000 violates this. 
>
>   - Partial allocation case (VCMDQ0 allocated, VCMDQ1 not): the trap correctly
>     serves VCMDQ1 accesses from QEMU cache while forwarding VCMDQ0 accesses
>     to vintf_page0. A direct RAM mapping cannot make this distinction.

I agree that normally we shouldn't use VINTF view for the global view. 

When you say "the trap correctly serves VCMDQ1 accesses from QEMU cache
while forwarding VCMDQ0 accesses to vintf_page0", the filtering is done by
tegra241_cmdqv_vintf_ptr. Whatever the queue being enabled,
cmdqv->vintf_page0 is allocated. So only the test on cmdqv->vcmdq[index]
does the filtering in that case, correct?

If so I now share your pov

Eric
>
>> Besides, I would recommend that all over the code, page0 and page1 are
>> clearly differentiated in terms of accessors and comments and we use the
>> same terminology through the code for global vcmdq and vintf vcmdqs.
> Sure. I will address this.
>
> Thanks,
> Shameer
>


