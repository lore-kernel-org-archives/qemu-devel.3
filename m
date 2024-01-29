Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A16C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 17:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUVs7-0004vK-2Z; Mon, 29 Jan 2024 12:56:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rUVs2-0004op-6e
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 12:56:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rUVs0-000306-BK
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 12:56:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706550991;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BwaOH5m5Z9rNRJ9ff4k7uVU79wAUgcNfRycVnyZgfHQ=;
 b=VJ4y0kqZ4lYjwn9YqZCz1srHo0E+Z9rSynvlt8egJrd5zFgWxJ3nP9kCEG2CiGiIoR83Wz
 JiLp/yeNzo5UO3eOP5sWHIg5bY6X4BAWEDPVyG8VRb3x64uLcED2iR/UpV84E3sOEUam1m
 Mf/r8rem3wAJPT4ew4QxiIwfZKbpWhQ=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-vxvrftRbMxqeJ7viekIFwA-1; Mon, 29 Jan 2024 12:56:29 -0500
X-MC-Unique: vxvrftRbMxqeJ7viekIFwA-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-5ff7eabfd94so47734567b3.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 09:56:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706550988; x=1707155788;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BwaOH5m5Z9rNRJ9ff4k7uVU79wAUgcNfRycVnyZgfHQ=;
 b=ewyXmNjmB3aFNeUUvdQmlinE+xvAyL/sq9cZiAKJq4ZJCa7j4VjVRzHLMmmF+i2fjc
 uASwOIAI6iA0/T4MwJIesabmUAa/XlU3PymM3nup0l8WCv0q2327bv6Syd1S2ItBMPWJ
 eBIj9K/sa2QKg0Jo8TOcz8IQddTRsYJtHKzfzDkexGibMSLT7s+UxabqHteM854lrpbr
 8dv/lCODgMz01l+o+5ZMTdYS3p3obG8mCckQQ6iwD5zSoiej2Mtwg0lC1zWdLDiqh8IU
 lpEdTZDBfS61JT0hnomFJsdYE92JXuoZ3yUMuHH225ELQUs1IyVlXCOY0JtLqzP05yeC
 VSMg==
X-Gm-Message-State: AOJu0YycgrEDSDG0vDesZsxZStdoAO5+n7zKyfL96YCGaHizxnQQ6DWi
 rjLOCZjVV4I8/LuOX0vdUl9TRinn3TAfqHKHfOdpLVZWKp12gM0MrkaH+3jfQKE3aR7L+kXMgVf
 0Jv6oQFjjY9fAAB2w1fQ9lFUbgK7PgjfN4R4RPW6ATX9AmhSOlIk3
X-Received: by 2002:a0d:d455:0:b0:5ff:7f44:5d94 with SMTP id
 w82-20020a0dd455000000b005ff7f445d94mr4067564ywd.80.1706550988696; 
 Mon, 29 Jan 2024 09:56:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZXW9/W7yHW9/lD6AhNOJM/xkT+1LMSdb3kcKAXF6t/wV86uuXV83AZgPXmsWtj7WzDTrgoQ==
X-Received: by 2002:a0d:d455:0:b0:5ff:7f44:5d94 with SMTP id
 w82-20020a0dd455000000b005ff7f445d94mr4067546ywd.80.1706550988403; 
 Mon, 29 Jan 2024 09:56:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 g23-20020ac84b77000000b0042a3358bf59sm1682108qts.79.2024.01.29.09.56.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 09:56:27 -0800 (PST)
Message-ID: <0555234a-66c8-44d9-898e-fe0c88086954@redhat.com>
Date: Mon, 29 Jan 2024 18:56:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] VIRTIO-IOMMU: Introduce an aw-bits option
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 alex.williamson@redhat.com, peter.maydell@linaro.org,
 zhenzhong.duan@intel.com, peterx@redhat.com, yanghliu@redhat.com,
 mst@redhat.com, clg@redhat.com, jasowang@redhat.com
References: <20240123181753.413961-1-eric.auger@redhat.com>
 <20240129122332.GA909471@myrica>
 <670991f9-e483-4acb-9ae9-6bad47b962b1@redhat.com>
 <20240129174250.GA1306334@myrica>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240129174250.GA1306334@myrica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Jean,

On 1/29/24 18:42, Jean-Philippe Brucker wrote:
> On Mon, Jan 29, 2024 at 03:07:41PM +0100, Eric Auger wrote:
>> Hi Jean-Philippe,
>>
>> On 1/29/24 13:23, Jean-Philippe Brucker wrote:
>>> Hi Eric,
>>>
>>> On Tue, Jan 23, 2024 at 07:15:54PM +0100, Eric Auger wrote:
>>>> In [1] and [2] we attempted to fix a case where a VFIO-PCI device
>>>> protected with a virtio-iommu is assigned to an x86 guest. On x86
>>>> the physical IOMMU may have an address width (gaw) of 39 or 48 bits
>>>> whereas the virtio-iommu exposes a 64b input address space by default.
>>>> Hence the guest may try to use the full 64b space and DMA MAP
>>>> failures may be encountered. To work around this issue we endeavoured
>>>> to pass usable host IOVA regions (excluding the out of range space) from
>>>> VFIO to the virtio-iommu device so that the virtio-iommu driver can
>>>> query those latter during the probe request and let the guest iommu
>>>> kernel subsystem carve them out.
>>>>
>>>> However if there are several devices in the same iommu group,
>>>> only the reserved regions of the first one are taken into
>>>> account by the iommu subsystem of the guest. This generally
>>>> works on baremetal because devices are not going to
>>>> expose different reserved regions. However in our case, this
>>>> may prevent from taking into account the host iommu geometry.
>>>>
>>>> So the simplest solution to this problem looks to introduce an
>>>> input address width option, aw-bits, which matches what is
>>>> done on the intel-iommu. By default, from now on it is set
>>>> to 39 bits with pc_q35 and 64b with arm virt.
>>> Doesn't Arm have the same problem?  The TTB0 page tables limit what can be
>>> mapped to 48-bit, or 52-bit when SMMU_IDR5.VAX==1 and granule is 64kB.
>>> A Linux host driver could configure smaller VA sizes:
>>> * SMMUv2 limits the VA to SMMU_IDR2.UBS (upstream bus size) which
>>>   can go as low as 32-bit (I'm assuming we don't care about 32-bit hosts).
>> Yes I think we can ignore that use case.
>>> * SMMUv3 currently limits the VA to CONFIG_ARM64_VA_BITS, which
>>>   could be as low as 36 bits (but realistically 39, since 36 depends on
>>>   16kB pages and CONFIG_EXPERT).
>> Further reading "3.4.1 Input address size and Virtual Address size" ooks
>> indeed SMMU_IDR5.VAX gives info on the physical SMMU actual
>> implementation max (which matches intel iommu gaw). I missed that. Now I
>> am confused about should we limit VAS to 39 to accomodate of the worst
>> case host SW configuration or shall we use 48 instead?
> I don't know what's best either. 48 should be fine if hosts normally
> enable VA_BITS_48 (I see debian has it [1], not sure how to find the
> others).
>
> [1] https://salsa.debian.org/kernel-team/linux/-/blob/master/debian/config/arm64/config?ref_type=heads#L18
>
>> If we set such a low 39b value, won't it prevent some guests from
>> properly working?
> It's not that low, since it gives each endpoint a private 512GB address
> space, but yes there might be special cases that reach the limit. Maybe
> assign a multi-queue NIC to a 256-vCPU guest, and if you want per-vCPU DMA
> pools, then with a 39-bit address space you only get 2GB per vCPU. With
> 48-bit you get 1TB which should be plenty.
>
> 52-bit private IOVA space doesn't seem useful, I doubt we'll ever need to
> support that on the MAP/UNMAP interface.
>
> So I guess 48-bit can be the default, and users with special setups can
> override aw-bits.

Yes it looks safe also on my side. I will respin with 48b default then.

Thank you!

Eric
>
> Thanks,
> Jean
>


