Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432E1C28B30
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 00:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvQet-00060T-68; Thu, 20 Mar 2025 20:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tvQei-0005yU-TM
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 20:54:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tvQeb-0004iz-Kz
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 20:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742518466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VQT7Cv9X8+5JYDEjXGi4lZ0jBIFbQ11MnX8/u1YxJyo=;
 b=CaJTfGEmUvtA+jvqbRZRglgRW0n3QGHoZagU/i4jOwYrligdx+NRc69onUK+k1Pf/BWNwv
 +LWhGDPJ/rWVUfcvikNPuhq0ln3ICdpvX9RnxixJMfLIWKN2cfw4ZP+JVcFWBSHxT0Pz2E
 zghcOaoKq7C9YRpUe+/8yuHbMBlm5CI=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-QK7PhihHOqymHpgADKtnpA-1; Thu, 20 Mar 2025 20:54:24 -0400
X-MC-Unique: QK7PhihHOqymHpgADKtnpA-1
X-Mimecast-MFC-AGG-ID: QK7PhihHOqymHpgADKtnpA_1742518464
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-3d458e61faaso13464395ab.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 17:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742518464; x=1743123264;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VQT7Cv9X8+5JYDEjXGi4lZ0jBIFbQ11MnX8/u1YxJyo=;
 b=GzUVjt2MSOrxO6ykgfpX1ZY2IDUVpHzca+AZXiw3zJxSiK1q/a3S53BHUKcWprIypv
 l+u3sZYxTRkWgFOQa34TBeMOkWwOzFQzddkW8P1oli+xfzJOJ5cv4x+pzV2UWpxAKJ4q
 /xUfTyXIcocnargGuKxVyoDbYs/dOo2V4Vajdt7Rb5OGJfwpRYXJfBU68nUK4G5cXMF+
 kmJZ7EovsW2cf1RHu0IL4iyPJTdwrjYzXfnRfyPxLS2+DgUhv5Tvlmt+/fgKIQ7UrNjw
 5uZgZRl8AT7bWWCKgJ66mzEwc+KeYFAVCYaN5aVJ6Caj6WPNg4Hc9ny+aloyEsm+VEHP
 rMbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoh47HqXGklBA8lzdfQ9yer9+n26x8eDCaezVcMSC04YGTpk0xmDmHvNHNM9sUZQEYl3/VkuyavLnG@nongnu.org
X-Gm-Message-State: AOJu0YzixnsPKiVlG4z2HRLhxw8ITIGT4zY5xm9i0mNl5GDQw3PGgzte
 lGLMpYp1WtjpHylX3dRSxkIo5tYu41ULZY9wMRXTlXN8kOKTQuOMWnRMLF2YxhWrUhoEjKvlqi7
 2JwvKDT5TYWxRP88oXBVglj3axxsVTOK5nwat6yCHFhhqZmam+UGt
X-Gm-Gg: ASbGncsbsBfByNWibyeCAIgf3NkA6P767Lttuy/xi8hAOybBZxhGQu+XS/dgoZZrILt
 AKV72aLyZeRLJOfgczIFjr0xM9ace7k7Cjt9kBuckpZdbwED7O/pPYokmntAmFaCcbU4+m6x/1P
 zesEX/9+tVSzUzjlc0G8t/A/ppD+q6oPFLk8A5w3Yb78/iiHyv5w2cLZ8FuOBCYS/MtozlKmlc6
 F+XLSVddaO8y2jImhNQXDLIF+MDdMDY4v7ohO/Ov+E18b+E5LksySTNY1y0ypPKeZ3WKGtAjftr
 bKTkoxhmEUYnbXCP
X-Received: by 2002:a05:6e02:2161:b0:3d3:f15e:8e23 with SMTP id
 e9e14a558f8ab-3d595fb0c44mr17733155ab.10.1742518463647; 
 Thu, 20 Mar 2025 17:54:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjexyd7lS6fDOqezF9KKljy5+l7RVEYd8tQBCiYir9YGBM2SrcFGxznCr68/FFpdd/VLRfgw==
X-Received: by 2002:a05:6e02:2161:b0:3d3:f15e:8e23 with SMTP id
 e9e14a558f8ab-3d595fb0c44mr17732875ab.10.1742518463140; 
 Thu, 20 Mar 2025 17:54:23 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d59607ea1esm1954825ab.19.2025.03.20.17.54.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 17:54:22 -0700 (PDT)
Message-ID: <05e5aa5a-228e-4c76-9175-09126e56dd61@redhat.com>
Date: Thu, 20 Mar 2025 20:54:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
 infrastructure for smmuv3-accel device
Content-Language: en-US
To: eric.auger@redhat.com, Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 berrange@redhat.com, nathanc@nvidia.com, mochs@nvidia.com,
 smostafa@google.com, linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com>
 <d75feb00-72d3-4d79-a7ac-2548eadb6a77@redhat.com>
 <Z9hh8MIAQNQcvNlG@Asurada-Nvidia>
 <71b73212-3d8f-4c9d-93a4-bf07c0f169e3@redhat.com>
 <Z9hzmzHfWw18OyGO@Asurada-Nvidia> <20250317192453.GR9311@nvidia.com>
 <Z9iDxSvZVsgtasGj@Asurada-Nvidia>
 <6cb391a4-d150-4692-b62e-a509448a1034@redhat.com>
 <Z9nF6FaIU37BNg4B@Asurada-Nvidia>
 <3716d39d-3f88-4914-a9d6-440d379db3d7@redhat.com>
 <c0448b92-1e2a-4983-837f-504a1cfa0975@redhat.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <c0448b92-1e2a-4983-837f-504a1cfa0975@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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



On 3/19/25 1:04 PM, Eric Auger wrote:
> 
> 
> 
> On 3/18/25 10:22 PM, Donald Dutile wrote:
>>
>>
>> On 3/18/25 3:13 PM, Nicolin Chen wrote:
>>> On Tue, Mar 18, 2025 at 07:31:36PM +0100, Eric Auger wrote:
>>>> On 3/17/25 9:19 PM, Nicolin Chen wrote:
>>>>> On Mon, Mar 17, 2025 at 04:24:53PM -0300, Jason Gunthorpe wrote:
>>>>>> On Mon, Mar 17, 2025 at 12:10:19PM -0700, Nicolin Chen wrote:
>>>>>>> Another question: how does an emulated device work with a vSMMUv3?
>>>>>>> I could imagine that all the accel steps would be bypassed since
>>>>>>> !sdev->idev. Yet, the emulated iotlb should cache its translation
>>>>>>> so we will need to flush the iotlb, which will increase complexity
>>>>>>> as the TLBI command dispatching function will need to be aware what
>>>>>>> ASID is for emulated device and what is for vfio device..
>>>>>> I think you should block it. We already expect different vSMMU's
>>>>>> depending on the physical SMMU under the PCI device, it makes sense
>>>>>> that a SW VFIO device would have it's own, non-accelerated, vSMMU
>>>>>> model in the guest.
>>>>> Yea, I agree and it'd be cleaner for an implementation separating
>>>>> them.
>>>>>
>>>>> In my mind, the general idea of "accel=on" is also to keep things
>>>>> in a more efficient way: passthrough devices go to HW-accelerated
>>>>> vSMMUs (separated PCIE buses), while emulated ones go to a vSMMU-
>>>>> bypassed (PCIE0).
>>>
>>>> Originally a specific SMMU device was needed to opt in for MSI reserved
>>>> region ACPI IORT description which are not needed if you don't rely on
>>>> S1+S2. However if we don't rely on this trick this was not even needed
>>>> with legacy integration
>>>> (https://patchwork.kernel.org/project/qemu-devel/cover/20180921081819.9203-1-eric.auger@redhat.com/).
>>>>
>>>>
>>>> Nevertheless I don't think anything prevents the acceleration granted
>>>> device from also working with virtio/vhost devices for instance unless
>>>> you unplug the existing infra. The translation and invalidation just
>>>> should use different control paths (explicit translation requests,
>>>> invalidation notifications towards vhost, ...).
>>>
>>> smmuv3_translate() is per sdev, so it's easy.
>>>
>>> Invalidation is done via commands, which could be tricky:
>>> a) Broadcast command
>>> b) ASID validation -- we'll need to keep track of a list of ASIDs
>>>      for vfio device to compare the ASID in each per-ASID command,
>>>      potentially by trapping all CFGI_CD(_ALL) commands? Note that
>>>      each vfio device may have multiple ASIDs (for multiple CDs).
>>> Either a or b above will have some validation efficiency impact.
>>>
>>>> Again, what does legitimate to have different qemu devices for the same
>>>> IP? I understand that it simplifies the implementation but I am not
>>>> sure
>>>> this is a good reason. Nevertheless it worth challenging. What is the
>>>> plan for intel iommu? Will we have 2 devices, the legacy device and one
>>>> for nested?
>>>
>>> Hmm, it seems that there are two different topics:
>>> 1. Use one SMMU device model (source code file; "iommu=" string)
>>>      for both an emulated vSMMU and an HW-accelerated vSMMU.
>>> 2. Allow one vSMMU instance to work with both an emulated device
>>>      and a passthrough device.
>>> And I get that you want both 1 and 2.
>>>
>>> I'm totally okay with 1, yet see no compelling benefit from 2 for
>>> the increased complexity in the invalidation routine.
>>>
>>> And another question about the mixed device attachment. Let's say
>>> we have in the host:
>>>     VFIO passthrough dev0 -> pSMMU0
>>>     VFIO passthrough dev1 -> pSMMU1
>>> Should we allow emulated devices to be flexibly plugged?
>>>     dev0 -> vSMMU0 /* Hard requirement */
>>>     dev1 -> vSMMU1 /* Hard requirement */
>>>     emu0 -> vSMMU0 /* Soft requirement; can be vSMMU1 also */
>>>     emu1 -> vSMMU1 /* Soft requirement; can be vSMMU0 also */
>>>
>>> Thanks
>>> Nicolin
>>>
>> I agree w/Jason & Nicolin: different vSMMUs for pass-through devices
>> than emulated, & vice-versa.
>> Not mixing... because... of the next agreement:
> you need to clarify what you mean by different vSMMUs: are you taking
> about different instances or different qemu device types?
Both. a device needed to use hw-accel feature has to use an smmu that has that feature;
an emulated device can use such an smmu, but as mentioned in other threads,
if you start with all emulated in one smmu, if you hot-plug a (assigned) device,
it needs another smmu that has hw-accel features.
Keeping them split makes it easier at config time, and it may enable the code to be simpler...
but the other half of my brain wants common code paths with accel/emulate branches but
a different smmu instance will like simplify the smmu-(accel-)specific lookups.

>>
>> I agree with Eric that 'accel' isn't needed -- this should be
>> ascertained from the pSMMU that a physical device is attached to.
> we can simply use an AUTO_ON_OFF property and by default choose AUTO
> value. That would close the debate ;-)
> 
Preaching to the choir... yes.

> Eric
>> Now... how does vfio(?; why not qemu?) layer determine that? -- where
>> are SMMUv3 'accel' features exposed either: a) in the device struct
>> (for the smmuv3) or (b) somewhere under sysfs? ... I couldn't find
>> anything under either on my g-h system, but would appreciate a ptr if
>> there is.
>> and like Eric, although 'accel' is better than the original 'nested',
>> it's non-obvious what accel feature(s) are being turned on, or not.
>> In fact, if broken accel hw occurs ('if' -> 'when'), how should it be
>> turned off? ... if info in the kernel, a kernel boot-param will be
>> needed;
>> if in sysfs, a write to 0 an enable(disable) it maybe an alternative
>> as well.
>> Bottom line: we need a way to (a) ascertain the accel feature (b) a
>> way to disable it when it is broken,
>> so qemu's smmuv3 spec will 'just work'.
>> [This may also help when migrating from a machine that has accel
>> working to one that does not.[
>>
>> ... and when an emulated device is assigned a vSMMU, there are no
>> accel features ... unless we have tunables like batch iotlb
>> invalidation for perf reasons, which can be viewed as an 'accel' option.
>>
> 


