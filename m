Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519F9CD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 18:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLQ7a-0001xZ-RW; Fri, 08 May 2026 14:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wLQ7Y-0001wQ-HE
 for qemu-devel@nongnu.org; Fri, 08 May 2026 14:40:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wLQ7W-0003gE-K9
 for qemu-devel@nongnu.org; Fri, 08 May 2026 14:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778265617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ifnBJFuVWN6f5JAPw0tnWlra13adtcSIs20bS3AoiKc=;
 b=Fqpuz1oo6op/ZQHKIgFXQZLCOPAPKc6ADHHK0VC93Nu8m/vDhYfc0vJxwev9cNnL3j+aee
 kYHjNq+4xgRUcev8ehDL9a8EgWFKgU+PwPG/sFsXD4X0LGnnJJ0xvG6Eb3dfY18R2yYeKW
 Qpz5dkCockS8hWSlPv809Z3gM4pg5pc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-3UmDpV1bOzGcLK2cvNjwHQ-1; Fri, 08 May 2026 14:40:15 -0400
X-MC-Unique: 3UmDpV1bOzGcLK2cvNjwHQ-1
X-Mimecast-MFC-AGG-ID: 3UmDpV1bOzGcLK2cvNjwHQ_1778265614
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43d7d0947aeso1407062f8f.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 11:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778265614; x=1778870414; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ifnBJFuVWN6f5JAPw0tnWlra13adtcSIs20bS3AoiKc=;
 b=KfV+rDHWWt1UkSexBvj8ndM/ucT7+Mv7S4FFGTBobHzgMq8QkU4ObGHYXpOtF/0IeR
 tkIdmCGppjhM/BZl4/1MnObONdWUB6VJu8vmV7m116vW62XxuqbGYO3KFw0r9ivVevgq
 8d2SBpMzJ77fR4IXtNJoTvMFWhfpK798ECD3bQIkkOFC2gtytO4OgZ2M2hvo62xO1OTD
 Dk/kE39aZqcLr838LVXhdMBydfC+L4/vRLjvNOO4qmwUDIhjScRJPTgpdJaOOOkbDS2T
 T5lf0cGaaFNN5FHwt4VRUFHlFvN7hVU0XlompRwkv2ehtGwK3qxBFOzhT6MoqowM3i08
 rD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778265614; x=1778870414;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ifnBJFuVWN6f5JAPw0tnWlra13adtcSIs20bS3AoiKc=;
 b=SynwZGjBrcAT04fuLUGHS+3K8npeb9WXLDtYECtN1kniW3hrSx+0IcbWZGiNWuop/L
 TYqdJD5ZitoTKsv2SVkOuwpPZAzQEMtUxnsXTT7b2vwOJbMWh2EtvXePjI73Am27S31J
 Z+HfNFEypoZr9v5G6/z8Q4DNAOa6p+RerSlXbgpoV3yBt9Mux7Zpj/Hv4xLYlowiDavM
 V2eBM9xK1ztr+5BhqtTHG6mFLUI9sHW9osIki5Nv/g6LDe1FPPjBcSkz4QRX607r8wjm
 Qsf/ilAL0iNjErpLZf8cEEjMD2DAjIk26yAQ/odJO2IAQFbpnOlO2XO8r5zGC97+5iSB
 RSrQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ97chU39OaY7lcd4TXjFzYLhTQ0ePKF50H5AnJKb7vF41xXy5NEQf4ImI2ZuzxnNsgYlSatn6eiGd4m@nongnu.org
X-Gm-Message-State: AOJu0YwEmUBfD5a2mEL7qXnh1hg4qN2dL1k5XOxvxgAAKZELwRJPupxB
 aBN07pj7CfwO4lFi4FoQwknnmxE1SkEISCm008O430STwejT+fXAELn9yFVQNuKXOEJvXDy5kTk
 LoL5Gz1h2OhXafsD4RjsKtHXmCR0wVrHOCtJ2E4lhUgcH92f8pI8k6HP4
X-Gm-Gg: AeBDievSBYV7nVw8sniPfI2exbfGX4nHLLUXFOIYBr78QxIQ8cb3icp4WD6B94JXgfN
 EuccdXjx1+AYTdEXr4Pf44G3Pvnrf0dwp58CqBI4R4/C25wdaOr86ZOs5lazNR7XBGRKbyW0wtV
 3d8d0SFI0CjymHl4v8gFCzRHwr2zzLUN2ow5R2LN3APuEjOsmXZyTENJXDVDB076NEg4SdZ6a+L
 hsw0T3+r8TO0nT6V4u4/VOnsmMGsAkUA3euWCsKdnkxumVhHtQDAdBbD7qJy6/9F3fviYpw5he2
 IxuC690XnsioaGlryIyasZ4I/aCn822mqnDx0zpPKvqGwi/rxu1Mtj7nJ3r6REP5jddVWU822H5
 iywQyZ71yQnON2g0HGg==
X-Received: by 2002:a05:600c:3548:b0:48a:7aad:4425 with SMTP id
 5b1f17b1804b1-48e51e097fcmr209796365e9.3.1778265614318; 
 Fri, 08 May 2026 11:40:14 -0700 (PDT)
X-Received: by 2002:a05:600c:3548:b0:48a:7aad:4425 with SMTP id
 5b1f17b1804b1-48e51e097fcmr209796005e9.3.1778265613845; 
 Fri, 08 May 2026 11:40:13 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.85]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548e6a73c3sm6676812f8f.3.2026.05.08.11.40.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 11:40:13 -0700 (PDT)
Message-ID: <2d536b87-9d67-4e8e-88b2-c9c868514083@redhat.com>
Date: Fri, 8 May 2026 20:40:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/s390x: Fix memory leaks after removing elements with
 QTAILQ_REMOVE
To: Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali
 <alifm@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
References: <20260506174135.2630613-1-thuth@redhat.com>
 <946651d9-0cd5-4482-96e5-a4c59b4d5fcc@linux.ibm.com>
 <1400ae28-5bac-4c18-afa2-64fd11293c05@redhat.com>
 <070d2e8f-dcba-4846-9d0c-a733fb2b1448@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <070d2e8f-dcba-4846-9d0c-a733fb2b1448@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 08/05/2026 19.25, Matthew Rosato wrote:
> On 5/7/26 3:31 AM, Thomas Huth wrote:
>> On 06/05/2026 21.45, Matthew Rosato wrote:
>>> On 5/6/26 1:41 PM, Thomas Huth wrote:
>>>> From: Thomas Huth <thuth@redhat.com>
>>>>
>>>> The elements that get removed with QTAILQ_REMOVE are never referenced
>>>> afterwards anymore, so the corresponding memory should get freed.
...
>>> Thanks Thomas!  Code looks good and I did some regression testing with
>>> this patch applied:
>>>
>>> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>>> Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
>>>
>>> Should we also consider adding:
>>>
>>> Fixes: b354d5d804 ("s390x/pci: clean up s390 PCI groups")
>>> Fixes: 37fa32de70 ("s390x/pci: Honor DMA limits set by vfio")
>>
>> Yes, that makes sense.
>>
>> Actually, looking at the commit description of b354d5d804, I think this
>> code has been added with a wrong assumption: The unrealize method is not
>> called during system reset.
...
> So: I wonder if the proper thing to do is to refcount the groups during
> plug and remove them from the list during unplug when refcount hits 0
> (and of course, add the missing g_free here) -- with special handling
> for the default group that should never go away.
> 
> Which is probably more than you signed on for with this patch ;) If
> you'd like, I can instead sort this out and give you a reported-by?

Yes, sounds good!

> Meanwhile you could still split out the fix to s390_pci_end_dma_count()
> and send that one again by itself (w/ Fixes: 37fa32de70)

Sure, I'll send a v2 that contains only the other change.

  Thomas


