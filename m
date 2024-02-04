Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E3DC48286
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 14:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWdx3-0001aX-6l; Sun, 04 Feb 2024 09:58:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rWdx1-0001aO-UD
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 09:58:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rWdx0-0007fQ-Eb
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 09:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707058709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZXrY/cNbSwlyrBCnWZWTcSfUI8+V+orh8gZFtksz1XY=;
 b=eS1reT10r9QXSeG7U+ag5FlYNx3GNPZMYRRvLFrqLNUMeZf73/MDPrjBQDkLGeX8s+6tj+
 EzPTyW4X0E1iJ5WKFSf59ej3KBBcwkSPI3AuwskpVvapJ/+C0U3DpQh0k2/Msxd2bfo+SF
 DnU2WabfqgkyDFdow+VST5I/WAIEvHk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-j1qVuEvGOnaaquK8QNV9SQ-1; Sun, 04 Feb 2024 09:58:27 -0500
X-MC-Unique: j1qVuEvGOnaaquK8QNV9SQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40fcb6ea753so10635835e9.1
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 06:58:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707058706; x=1707663506;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZXrY/cNbSwlyrBCnWZWTcSfUI8+V+orh8gZFtksz1XY=;
 b=NvUk0TK5fPqlKCND42aoYK5ij/hDGKPVxLh/hxqn3ZtnKPlIBWubm9nTSqRh10bbV+
 k96zRDVesZsFYy8PiU3baGa3nbOyOnAG7Ff8LNyDC9WjDCbj9mcyrl4YxAv9WfnDnAHH
 8CRp1MrbdrY1zTE3MoLeDiZSZ03yHlnLPn4/WMcq2fJzbB7c7/LKD9G5tOPGlTyk37KM
 FWHZEAV+whfQ10bus1BaYmH1KxJVoqQiFj3ecYG2C2qG2V/shWW35GC/DFVL8HKBM3pA
 H4OjDKpRW8Np9FHeWAGHq0VkpWgxVjpbafIB3XuXIUK86TAwJDz5l7IVprcUywAMnCZq
 qgAw==
X-Gm-Message-State: AOJu0YwEb7HC8tqm0tFwrGMmczVS277kJWT6++r+FWuf3LNzjmbbJgx5
 vUA1oczV70r026x8aVpyOj4FtR29cxThZM60cLO01X9XHhNWtbXYtuBvQNoHbCyKPlkmWrveHoJ
 spBBkTj9EQN6AcUkM8xjPPP3NCVejQB7BJ0xLwlmSc+BN7CJ2yrPz
X-Received: by 2002:a05:600c:1e17:b0:40f:bad2:6f04 with SMTP id
 ay23-20020a05600c1e1700b0040fbad26f04mr2728213wmb.1.1707058706005; 
 Sun, 04 Feb 2024 06:58:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErO+CkCWasIJz9tfSCJYQfvxCgxijA3MdMYNye79BEDzaIpxFCF4FvZYE8J1F2PXB9FlO48g==
X-Received: by 2002:a05:600c:1e17:b0:40f:bad2:6f04 with SMTP id
 ay23-20020a05600c1e1700b0040fbad26f04mr2728204wmb.1.1707058705613; 
 Sun, 04 Feb 2024 06:58:25 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWT5sf8RYr29pB8rP9VGk8VJqEBUMePH8a1KuI53ZB9WOg1YBN5yDGEk/zGmizOniQuPx/yuys1TP4wPpW5j6cvcIVdY83mWtn2ftF+6FVVhrlE++LsrsqlBqx19dYoN9aJc0I6PI4BoW4N/1wdMJZNNGVrXJoAESNAwrl1S/rFoxVGLaAteGX3cz4BaIKJfmi8idA8c64aWyrn+VA6P5+P+fsJPwR7jcKozWRSdM4=
Received: from ?IPV6:2003:cb:c725:700:519c:c741:25de:232f?
 (p200300cbc7250700519cc74125de232f.dip0.t-ipconnect.de.
 [2003:cb:c725:700:519c:c741:25de:232f])
 by smtp.gmail.com with ESMTPSA id
 je12-20020a05600c1f8c00b0040fcaec04b8sm5954238wmb.22.2024.02.04.06.58.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Feb 2024 06:58:25 -0800 (PST)
Message-ID: <d1d8b933-c1df-416a-8e0a-fdf97262e72d@redhat.com>
Date: Sun, 4 Feb 2024 15:58:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 14/15] libvhost-user: Dynamically remap rings after
 (temporarily?) removing memory regions
Content-Language: en-US
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
References: <20240202215332.118728-1-david@redhat.com>
 <20240202215332.118728-15-david@redhat.com>
 <CAFubqFt2GV17Vdrm3_sH1j9dkgj084QDdHv57wrJg395J-JrBA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAFubqFt2GV17Vdrm3_sH1j9dkgj084QDdHv57wrJg395J-JrBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 04.02.24 03:15, Raphael Norwitz wrote:
> Someone else with more knowledge of the VQ mapping code should also review.
> 
> On Fri, Feb 2, 2024 at 4:55 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> Currently, we try to remap all rings whenever we add a single new memory
>> region. That doesn't quite make sense, because we already map rings when
>> setting the ring address, and panic if that goes wrong. Likely, that
>> handling was simply copied from set_mem_table code, where we actually
>> have to remap all rings.
>>
>> Remapping all rings might require us to walk quite a lot of memory
>> regions to perform the address translations. Ideally, we'd simply remove
>> that remapping.
>>
>> However, let's be a bit careful. There might be some weird corner cases
>> where we might temporarily remove a single memory region (e.g., resize
>> it), that would have worked for now. Further, a ring might be located on
>> hotplugged memory, and as the VM reboots, we might unplug that memory, to
>> hotplug memory before resetting the ring addresses.
>>
>> So let's unmap affected rings as we remove a memory region, and try
>> dynamically mapping the ring again when required.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Acked-by: Raphael Norwitz <raphael@enfabrica.net>

Thanks!

> 
>> ---
>>   subprojects/libvhost-user/libvhost-user.c | 107 ++++++++++++++++------
>>   1 file changed, 78 insertions(+), 29 deletions(-)
>>
>> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
>> index febeb2eb89..738e84ab63 100644
>> --- a/subprojects/libvhost-user/libvhost-user.c
>> +++ b/subprojects/libvhost-user/libvhost-user.c
>> @@ -283,10 +283,75 @@ vu_remove_all_mem_regs(VuDev *dev)
>>       dev->nregions = 0;
>>   }
>>
>> +static bool
>> +map_ring(VuDev *dev, VuVirtq *vq)
>> +{
>> +    vq->vring.desc = qva_to_va(dev, vq->vra.desc_user_addr);
>> +    vq->vring.used = qva_to_va(dev, vq->vra.used_user_addr);
>> +    vq->vring.avail = qva_to_va(dev, vq->vra.avail_user_addr);
>> +
>> +    DPRINT("Setting virtq addresses:\n");
>> +    DPRINT("    vring_desc  at %p\n", vq->vring.desc);
>> +    DPRINT("    vring_used  at %p\n", vq->vring.used);
>> +    DPRINT("    vring_avail at %p\n", vq->vring.avail);
>> +
>> +    return !(vq->vring.desc && vq->vring.used && vq->vring.avail);
>> +}
>> +
>>   static bool
> 
> Consider changing the function name to indicate that it may actually map a vq?
> 
> Maybe vu_maybe_map_vq()?

I don't think that would be really better. It's an implementation detial 
that we try to recover in these corner cases by remapping the rings.

In the majority of all cases this function will simply check whether the 
device is broken and the vring was set up properly (which usually 
implies mapping the rings).

So I think in the caller:

if (!vu_is_vq_usable()) {
	return;
}

is easier to get than:

if (!vu_maybe_map_vq()) {
	return;
}


Thanks!

-- 
Cheers,

David / dhildenb


