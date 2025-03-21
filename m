Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA0CC28B30
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 01:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvR9u-0004qu-KV; Thu, 20 Mar 2025 21:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tvR9s-0004qN-E4
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 21:26:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tvR9q-0008Qz-IY
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 21:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742520405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DPzH+pbWEdmaE+tb6lEZgkQVsUFoZg4eoMTkUxT1Jx0=;
 b=bgmuvp4POD2atc5C2os1g/1v0rFikiUUj9uLqo+jVPSw/d4fmRYINIFMirJWPlPs7h41HF
 us53UFFttzF4VfZpw5f58noYewpFFXyVEpe5xUh/XptigXYa2YqT/kJZjs53sxey8PNuon
 35F6PU/QTY2RM8KiPkkrJZAm8dkYAeI=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-yc20PdhFNNm2P-K3Bo6LXQ-1; Thu, 20 Mar 2025 21:26:43 -0400
X-MC-Unique: yc20PdhFNNm2P-K3Bo6LXQ-1
X-Mimecast-MFC-AGG-ID: yc20PdhFNNm2P-K3Bo6LXQ_1742520402
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-3d4578fbaf4so29714545ab.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 18:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742520402; x=1743125202;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DPzH+pbWEdmaE+tb6lEZgkQVsUFoZg4eoMTkUxT1Jx0=;
 b=qnEKAciYarY6Bmiwew9uY3+tidLDcdCKQULfOx96okiDAcoDF1nCp4ZL6F0VlfUD0N
 cNidKkJa5/kvjfuO5cVqUabVirJe2S4gu2VX0cnammGYME4G/gMpAJ6ur6oBndlXXm5b
 e+QhPa3BDYxxm/bGy0xqBtoF2yneZ6akID1JKiP1NnVi4eDCoWlVlLoflDh7ZMaJZ43t
 0btNgJiWgnyNIkF8QfG4oiFdGq36XciOzJGwmMOD9Lu0L65zWsSowdTl9bFKmKd8mMmX
 guOXsriObmJw5AK10Gxm1oqheSRZ0xp8u9EywYglku8y0xrmYvOYc5XOop7M6fWtOls3
 Y2kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyEOy1S2D6DrfsGyCAYKXZCHp3LlpDRSJgWwCG0sVD2LkuqRTMpztlUl5hpi2rwtWW6NdYF2fTmZax@nongnu.org
X-Gm-Message-State: AOJu0Yz1M0D/I6dK1DWo4AZr18PM/XZO40mfrx/0YI/RWvnPw9O9Hr1Z
 WeONSYar7Pt+dNUMKF+gf6IO3wnXP4bR4R4d02/ScVL/ZgqL0WfbrgKRsNbzhexGyEp9KOyr42M
 AhpV8e9MUh73JPb7EQEO/55anqEGskAfrKc+14YOlzXHbiM3lqGGz
X-Gm-Gg: ASbGncs4b4lOV69YDtt1StOkoAnN5ERbpWX0UUAw6Q/Jj2hQmzaED1+/0/AtJYOd1Tu
 0GaACKS9hrcBz43vN2zeehGSG3d2dZcXXpnslCNTwGInJZahf9YKVaApz7e57sJ4r9DIX+l9JNY
 lT44iuDzZvjMGnECx9IoWFXgx2UPcWaxqdsdgklFDl+4Rd63j3eP1F9iRhjQdXJHm9YJ5lpWhuI
 aVo8FHVNCDV03hQNCV3QRbDVjuJBRieYzjGBPZB439SHpG0O+s7X9vcmgfaY8wMcYdYkWnicDEL
 b8sGEK/cvzWIlmao
X-Received: by 2002:a05:6e02:23c5:b0:3d3:d965:62c3 with SMTP id
 e9e14a558f8ab-3d5961775a9mr17939535ab.15.1742520402582; 
 Thu, 20 Mar 2025 18:26:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGq1QdE15BwW/yAM17biaFcumtQQL22+D6mYoYL9bBb7cw07m8W6TGnRsCuhdlT1SlpvJLSDw==
X-Received: by 2002:a05:6e02:23c5:b0:3d3:d965:62c3 with SMTP id
 e9e14a558f8ab-3d5961775a9mr17939265ab.15.1742520402258; 
 Thu, 20 Mar 2025 18:26:42 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d59607e92csm2063905ab.23.2025.03.20.18.26.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 18:26:41 -0700 (PDT)
Message-ID: <57e53ae1-3a34-4be1-94ab-f96b765c3bb5@redhat.com>
Date: Thu, 20 Mar 2025 21:26:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
 infrastructure for smmuv3-accel device
Content-Language: en-US
To: eric.auger@redhat.com, Nicolin Chen <nicolinc@nvidia.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 jgg@nvidia.com, berrange@redhat.com, nathanc@nvidia.com, mochs@nvidia.com,
 smostafa@google.com, linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com>
 <d75feb00-72d3-4d79-a7ac-2548eadb6a77@redhat.com>
 <Z9hh8MIAQNQcvNlG@Asurada-Nvidia>
 <71b73212-3d8f-4c9d-93a4-bf07c0f169e3@redhat.com>
 <Z9hzmzHfWw18OyGO@Asurada-Nvidia>
 <11895c78-d6ab-40c8-a500-4abed1565234@redhat.com>
 <Z9r7dT/5E+YToqc9@Asurada-Nvidia>
 <c70fdb0c-ef56-4a52-8591-31df51ff0eec@redhat.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <c70fdb0c-ef56-4a52-8591-31df51ff0eec@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 3/19/25 2:09 PM, Eric Auger wrote:
> Hi Nicolin,
> 
> 
> On 3/19/25 6:14 PM, Nicolin Chen wrote:
>> On Wed, Mar 19, 2025 at 05:45:51PM +0100, Eric Auger wrote:
>>>
>>>
>>> On 3/17/25 8:10 PM, Nicolin Chen wrote:
>>>> On Mon, Mar 17, 2025 at 07:07:52PM +0100, Eric Auger wrote:
>>>>> On 3/17/25 6:54 PM, Nicolin Chen wrote:
>>>>>> On Wed, Mar 12, 2025 at 04:15:10PM +0100, Eric Auger wrote:
>>>>>>> On 3/11/25 3:10 PM, Shameer Kolothum wrote:
>>>>>>>> Based on SMMUv3 as a parent device, add a user-creatable smmuv3-accel
>>>>>>>> device. In order to support vfio-pci dev assignment with a Guest
>>>>>>> guest
>>>>>>>> SMMUv3, the physical SMMUv3 has to be configured in nested(S1+s2)
>>>>>>> nested (s1+s2)
>>>>>>>> mode, with Guest owning the S1 page tables. Subsequent patches will
>>>>>>> the guest
>>>>>>>> add support for smmuv3-accel to provide this.
>>>>>>> Can't this -accel smmu also works with emulated devices? Do we want an
>>>>>>> exclusive usage?
>>>>>> Is there any benefit from emulated devices working in the HW-
>>>>>> accelerated nested translation mode?
>>>>> Not really but do we have any justification for using different device
>>>>> name in accel mode? I am not even sure that accel option is really
>>>>> needed. Ideally the qemu device should be able to detect it is
>>>>> protecting a VFIO device, in which case it shall check whether nested is
>>>>> supported by host SMMU and then automatically turn accel mode?
>>>>>
>>>>> I gave the example of the vfio device which has different class
>>>>> implementration depending on the iommufd option being set or not.
>>>> Do you mean that we should just create a regular smmuv3 device and
>>>> let a VFIO device to turn on this smmuv3's accel mode depending on
>>>> its LEGACY/IOMMUFD class?
>>> no this is not what I meant. I gave an example where depending on an
>>> option passed to thye VFIO device you choose one class implement or the
>>> other.
>> Option means something like this:
>> 	-device smmuv3,accel=on
>> instead of
>> 	-device "smmuv3-accel"
>> ?
>>
>> Yea, I think that's good.
> Yeah actually that's a big debate for not much. From an implementation
> pov that shall not change much. The only doubt I have is if we need to
> conditionnaly expose the MSI RESV regions it is easier to do if we
> detect we have a smmuv3-accel. what the option allows is the auto mode.
>>
>>>> Another question: how does an emulated device work with a vSMMUv3?
>>> I don't get your question. vSMMUv3 currently only works with emulated
>>> devices. Did you mean accelerated SMMUv3?
>> Yea. If "accel=on", how does an emulated device work with that?
>>
>>>> I could imagine that all the accel steps would be bypassed since
>>>> !sdev->idev. Yet, the emulated iotlb should cache its translation
>>>> so we will need to flush the iotlb, which will increase complexity
>>>> as the TLBI command dispatching function will need to be aware what
>>>> ASID is for emulated device and what is for vfio device..
>>> I don't get the issue. For emulated device you go through the usual
>>> translate path which indeed caches configs and translations. In case the
>>> guest invalidates something, you know the SID and you find the entries
>>> in the cache that are tagged by this SID.
>>>
>>> In case you have an accelerated device (indeed if sdev->idev) you don't
>>> exercise that path. On invalidation you detect the SID matches a VFIO
>>> devoce, propagate the invalidations to the host instead. on the
>>> invalidation you should be able to detect pretty easily if you need to
>>> flush the emulated caches or propagate the invalidations. Do I miss some
>>> extra problematic?
>>>
>>> I do not say we should support emulated devices and VFIO devices in the
>>> same guest iommu group. But I don't see why we couldn't easily plug the
>>> accelerated logic in the current logical for emulation/vhost and do not
>>> require a different qemu device.
>> Hmm, feels like I fundamentally misunderstood your point.
>>   a) We implement the device model with the same piece of code but
>>      only provide an option "accel=on/off" to switch mode. And both
>>      passthrough devices and emulated devices can attach to the same
>>      "accel=on" device.
> I think we all agree we don't want that use case in general. However
> effectively I was questioning why it couldn't work maybe at the expense
> of some perf degration.
>>   b) We implement the device model with the same piece of code but
>>      only provide an option "accel=on/off" to switch mode. Then, an
>>      passthrough device can attach to an "accel=on" device, but an
>>      emulated device can only attach to an "accel=off" SMMU device.
>>
>> I was thinking that you want case (a). But actually you were just
>> talking about case (b)? I think (b) is totally fine.
>>
>> We certainly can't do case (a): not all TLBI commands gives an "SID"
>> field (so would have to broadcast, i.e. underlying SMMU HW would run
>> commands that were supposed for emulated devices only); in case of
>> vCMDQ, commands for emulated devices would be issued to real HW and
> I am still confused about that. For instance if the guest sends an
> NH_ASID, NH_VA invalidation and it happens both the emulated device and
> VFIO-device share the same cd.asid (same guest iommu domain, which
> practically should not happen) why shouldn't we propagate the
it can't ... on ARM ... PCIe only, no shared iommu domain btwn devices.

Isn't this another reason (perf) why emulated devices & physical devices should
be on different vSMMU's ... so it can be distinguished on how deep (to hw)
or how wide(a broadcast) actions like TLBI is implemented, or impacts other devices ?


> invalidation to the host. Does the problem come from the usage of vCMDQ
> or would you foresee the same problem with a generic physical SMMU?
> 
> Thanks
> 
> Eric
>> trigger HW errors.
>>
>> Thanks
>> Nicolin
>>
> 


