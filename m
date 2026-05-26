Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533CDCD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 12:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRqlr-0005Op-9s; Tue, 26 May 2026 08:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wRqlp-0005OC-0g
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:20:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wRqlm-0000NB-UP
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779798025;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wBQdbQ2EkWg6Gl9nMhSWs8e8r1aCtELC/PJIuE9MupU=;
 b=HCETWUk6YS9Lu8OHA/y6wLQcOifpa/KvESocBy6Jq7QOuUbW28L/X+ChNqIwHzmwUvkGp9
 8dr2D0eUTp1qMw2aPoFfoV/156giRwb+P07F4iBSYQKE9ErkX/YGZk6QUEKIDAfyjXdOeF
 0R7bKe14vB1eKxMSs+LfA/EDRbhJO80=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-kbKU3bwdNoydI-hJnJSasg-1; Tue, 26 May 2026 08:20:24 -0400
X-MC-Unique: kbKU3bwdNoydI-hJnJSasg-1
X-Mimecast-MFC-AGG-ID: kbKU3bwdNoydI-hJnJSasg_1779798022
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45ed830a0eeso427461f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 05:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779798022; x=1780402822;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wBQdbQ2EkWg6Gl9nMhSWs8e8r1aCtELC/PJIuE9MupU=;
 b=iwYJwlmlUkBPDuMWy41g7n59SXcjgKoxkCm1mHV0kBKX5n3OvIjPfMnDVFbxA+8fLV
 Zf17NT66TUog9hk9LJH9cJmiibCqix9m7ineUApos5ogsg5o4uJAyBXlHPi9iICeqO4k
 ZyvnPKJKYDePC8wDaBAYKqJEi7xF1B1skWB9rVNYnB5T43aDe6UkzrFWWj/wtqFxHmM6
 aiU0tSKDNqA+SvpYI8VQZcS6iGD5Afu+fea/02URa0K4Q+TmfvAWlhgoK8IY/1Z8KDAg
 CK/UyHrvNYBMsbEzmIJXkHMnrM/AwCukNwjqyQ5das+q+vFlcouLFtiCO6xf56gTqbcw
 244w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9KpskVvaqw2Ez0yGr4mE0MjQmhVoCm7USRByYPH1kOE6PCLHxhpNV1wwb6bD3Ai4MKFdQZXQoPME9B@nongnu.org
X-Gm-Message-State: AOJu0YxC5MSYSpsdNbooMfkAmdrRSymQtHKMC6K6AP8enLMfwhyRAImp
 hjGzW7Y+ISJrncJn1nbHpopkaArAYK5TGEN2yhFKmY9ZwOqe0nGACHFaWfuVoGr0spCtVh5CGID
 JxY7uW4xxcAp7zuyfGU8g78ZzUZvz3HNlsGj1fW9nOaPceMZRIWv9bmhK9XYeDkEA
X-Gm-Gg: Acq92OEhO1NeelnHZHYnLj/TyQ9aVlMw11wpYLZDLuDDIIBaMWyYpae9ZeZ6l6EeCPB
 vFZLwJq6UIF7+8ZPvCMwvQNJqXBxhIMP8Rx5UEk6OS4DsAShelNMD7+zaXwCRh98kw/DnIKqFK+
 Nm9cb0lFVjW1ErGgIqkcZxDcXpKcNSjqU/pZEowf0zJcgMN6O8IEiqMkOwfxxhq2cgJgvsgM6Zr
 NELPXL6NCw925hb7bbtvdGxk6Jju3r7v9O1cdcJ9gbUV3eH66jGSkaxvuW3l0/OwYg3e1EXrkow
 QuwOPkKAUUlo8WGcnsdjKFtQlfMM2RW89OFgm/UgICkjcQZpSNXzFEm+LiWdSPKgIwRCJwqN4hf
 gRF/dSZ8MrVYTyW5MnfhCi3q0wncCaCQObiZrqzaRE/F+IKU0ImGH2VHJZM2bdYXs1HTfNw==
X-Received: by 2002:a05:6000:2384:b0:441:3144:efc5 with SMTP id
 ffacd0b85a97d-45eb38e4fd0mr31504978f8f.42.1779798021774; 
 Tue, 26 May 2026 05:20:21 -0700 (PDT)
X-Received: by 2002:a05:6000:2384:b0:441:3144:efc5 with SMTP id
 ffacd0b85a97d-45eb38e4fd0mr31504934f8f.42.1779798021364; 
 Tue, 26 May 2026 05:20:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d4741bsm36618511f8f.22.2026.05.26.05.20.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 05:20:20 -0700 (PDT)
Message-ID: <862edcac-d8b0-465a-bc58-11678ff15890@redhat.com>
Date: Tue, 26 May 2026 14:20:19 +0200
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
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB754807F1C34CCB89A73A219EAB0E2@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Shameer,

On 5/21/26 5:46 PM, Shameer Kolothum Thodi wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 21 May 2026 14:41
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
>> On 5/19/26 12:36 PM, Shameer Kolothum wrote:
>>> Introduce tegra241_cmdqv_vintf_ptr() to route VCMDQ Page0 register
>>> accesses through the mmap'd VINTF page0 backing once a hardware
>>> queue has been allocated.
>>>
>>> There are two QEMU trapped MMIO apertures for VCMDQ Page0 registers:
>>>
>>>   - Direct VCMDQ Page0 aperture (offset 0x10000)
>>>   - VINTF Page0 (offset 0x30000)
>>>
>>> These are hardware aliases: they address the same underlying
>>> registers. A subsequent patch maps the VINTF aperture as a
>>> guest-direct RAM region; in this patch both remain QEMU-trapped.
>>>
>>> VCMDQ Page0 accesses operate in one of two mutually exclusive modes,
>>> depending on whether a hardware queue (IOMMU_HW_QUEUE_ALLOC)
>> has
>>> been allocated for the VCMDQ:
>>>
>>>   Pre-alloc:  vintf_ptr is NULL. Both apertures use QEMU's register
>> do you mean vintf_page0 instead of vintf_ptr.
>>
>> vintf_page0 is set on mmap, right? and not on hwqueue_alloc
> Yeah. I actually meant the ptr returned by tegra241_cmdqv_vintf_ptr()
>
>> Besides pre/post-alloc sounds a bit confusing to me since it can mean
>> queue_alloc or mmap.
>> If I understand correctly vintf_page0 can be set while hwqueue_alloc has
>> not been done yet and conversely, hence the double check below:
> The "alloc" is in reference to a vcmdq is "allocated" to a vintf. I think spec
> has that usage.
>
> Anyway, I will make it clear.
>
>> +    if (!cmdqv->vcmdq[index] || !cmdqv->vintf_page0) {
>>
>>
>>>               cache. Hardware is not yet engaged.
>>>
>>>   Post-alloc: vintf_ptr is valid. Both QEMU trapped apertures access
>>>               registers directly via the mmap'd vintf_page0 pointer,
>>>               bypassing the cache. Hardware is the single source of
>>>               truth.
>>>
>>> The pre-to-post-alloc transition is triggered by the IOMMUFD hardware
>> so here you mean alloc is hw queue alloc
>>> queue allocation. The tegra241_cmdqv_sync_vcmdq() copies any pre-alloc
>>> cached writes (CONS_INDX, PROD_INDX, CONFIG, GERRORN) into the
>> mmap'd
>>> page so the guest's view survives the transition.
>>>
>>> CMDQV acceleration only becomes active once the guest enables VINTF
>>> and the corresponding HW QUEUE is allocated through IOMMUFD. Until
>>> then, all VCMDQ accesses are served from the emulated register cache
>>> with no real hardware command processing. This matches the CMDQV
>>> hardware specification: if the logical CMDQ index does not map to any
>>> allocated Virtual CMDQ, "the access is dropped with no Fault/Interrupt".
>> I still does not realy understand what would be the problem of directly
>> mapping the direct cmdqv page0 too - I understand that theoretically the
>> direct view is larger than the VINTF one though -. I still think a
>> proper explanation is missed in this patch of 22/32
>>
>> Assuming the guest tries to set up some unmapped vcmdqs in the direct
>> cmdqv page and this eventually ends up writing into the VINTF view, what
>> would happen and in which terms does it violate the spec?
> Ok. Let me try to explain my understanding.
>
> This is my rationale after reading Nicolin's explanation here on the
> RFC where we had both direct aperture and vintf page 0 mapped to Guest .
> https://lore.kernel.org/qemu-devel/aXkTzRM695oTWFaD@Asurada-Nvidia/
>
> Consider the example: 
>
> QEMU advertises 2 VCMDQs (CMDQV_NUM_CMDQ_LOG2=1).
> Guest allocates vcmdq0 only, leaves vcmdq1 unallocated, then on the
> direct aperture for vcmdq1:
>
>   write 0x10 ->  A_VCMDQ1_PROD_INDX
>   read     A_VCMDQ1_PROD_INDX
>
> If we aliased the direct aperture to the VINTF mmap, the write
> would physically hit VINTF Page 0 in HW at an unmapped logical
> slot. And the spec says(p.172):
>
> " If no Virtual CMDQ is mapped to the Guest, or if the logical CMDQ index in 
> the Virtual Interface being accessed by the software does not map to any Virtual
> CMDQ, the access is dropped with no Fault/Interrupt."
OK
>
> So even though guest is using the direct aperture, in turn it ends up
> accessing the corresponding vinf page0 and won't see whatever it wrote.
>
> I think this contradicts spec p.176 where it says:
>
> "While the software can program the Virtual CMDQ(s) directly using the
> direct VCMDQ aperture (and not through the Virtual Interface), it is
> required that the VCMDQ be allocated to a Virtual  Interface before it
> is used to send commands to the SMMU."
>
> So the spec allows register programming through the direct aperture
> without requiring the VCMDQ to be allocated first.
Hum. So it is said if the cmdqv is not mapped on the VI you cannot send
commands to it through the direct aperture. But it does not say what
does happen if you do so. Why wouldn't the VI behavior be wrong, ie. "

the access is dropped with no Fault/Interrupt."

Eric

>
> @Nicolin: did I understand your earlier reasoning correctly here?
>
> Thanks,
> Shameer


