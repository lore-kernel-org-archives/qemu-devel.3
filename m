Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AD8C3ABD9
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 09:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF8TW-0001re-Eh; Wed, 14 May 2025 05:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uF8TR-0001r4-Uq
 for qemu-devel@nongnu.org; Wed, 14 May 2025 05:32:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uF8TO-0005IY-HS
 for qemu-devel@nongnu.org; Wed, 14 May 2025 05:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747215140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Xna6MN0yQj9CvuEb7jeW0hCcV+//3+tgIgBNbFxW5M8=;
 b=hQ2DMNgIpVrHcR8maGkdr2D9WPFGyEID/5R7knhMH7HoNptUlAjKSDxArIG0c/G21uvkpw
 iYMJPm5KHG1AFErIlAnW3IrvhzYmqBwaMsfkOWt4ycmV3Q7Ckfci4GPjT/gKAjOUmw+OPX
 Rf+a18HsvLPSNbq+myVgkjOPLX12UOU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-pgClzrs8MSibbMJAVO1kig-1; Wed, 14 May 2025 05:32:18 -0400
X-MC-Unique: pgClzrs8MSibbMJAVO1kig-1
X-Mimecast-MFC-AGG-ID: pgClzrs8MSibbMJAVO1kig_1747215138
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a23c51816dso1474031f8f.1
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 02:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747215138; x=1747819938;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xna6MN0yQj9CvuEb7jeW0hCcV+//3+tgIgBNbFxW5M8=;
 b=NVwTdZ3J9KU3T4SGGcWcBIlhE/kPTZNctkulNqXAe/ae3/nu6FvXRtsDFJFzCRQZN8
 YHRHZatsbLFli8tpETCeu4ZtwjjFWBC9rCwO/ystYCgHJgTYCtEL8Ea+vNCYi80Stlun
 qsvRGb1/Is8ALRevwNROXzC43TGVlcPvSNZVUQx3NXATQJ+P3zlwD+FNDus9vSUUsGxz
 vBnRQI0jaah2tesP28m7XElq5Sl4ETV3yV56HQTcvBlzVE75N7aGtxC9KfgVTXxAeP9m
 1AyhIQzj5/UmtUH3U6gVVek0EMm2cWmYVPuFf0xHrm426vfK8+luiHltr9NwBLHPCziZ
 GpYQ==
X-Gm-Message-State: AOJu0YyXIf4o4vjwwqJfhlRQtJOIIetuSorgLvi1f4dzLdyKEoIedjcF
 p/89TVwvd3uiQ6+DfiZNSqJyD2Z7TMsRLfFxcFOr3WTtg0oIXiAb9X55v5GAqEskRb5tA5oCMlP
 lxOINYTIHkkXz5zR2ZumgLyo0pk5jdt/cqtn9+R05rOHnO76sVpPm
X-Gm-Gg: ASbGncs1MRiy5yqphkZw3MKv9BtlBUvoAFw2/0vajS492PdpeWM4ORH4hOReVCI6fQ5
 /g8Jp0DF+0i4K6AF4zJ+3A+DuyaNmikgmEwwVvBRo6HMgcDakbjT5qf5kD+jcze+h0yNDRvHdoa
 VYxANT8aXdD8bVXXije+qNGFjEQKKZ457g0Mc2dH5QeN+/lbAij56+LUjcA6kEasn4WccR+WuO9
 bAgszv2rIsGiUyAOE3TlbBBdXWqIcPp0W6ueD5axqunVwKpkwSo3w3yfd1UPyGAkXs8TTjPszlk
 GxVoHiIfuj1ifaB7+pVyDlydZnVTgLSKap1b
X-Received: by 2002:a5d:5885:0:b0:3a2:6f0:50c9 with SMTP id
 ffacd0b85a97d-3a34991bff4mr2177589f8f.40.1747215137733; 
 Wed, 14 May 2025 02:32:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuxkLfxUS819wou389/6YxL64BNwvSLQzkw5yjo3VeGFhRwrA++daGlWSZ+hVkfKSiRr0Jzg==
X-Received: by 2002:a5d:5885:0:b0:3a2:6f0:50c9 with SMTP id
 ffacd0b85a97d-3a34991bff4mr2177553f8f.40.1747215137219; 
 Wed, 14 May 2025 02:32:17 -0700 (PDT)
Received: from [10.33.192.219] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2d2d3sm19372162f8f.63.2025.05.14.02.32.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 02:32:16 -0700 (PDT)
Message-ID: <b6e97526-4353-4b62-b992-bd7019d08c27@redhat.com>
Date: Wed, 14 May 2025 11:32:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390x: Clear RAM on diag308 subcode 3 reset
To: Matthew Rosato <mjrosato@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Nicholas Miehlbradt <nicholas@linux.ibm.com>, richard.henderson@linaro.org,
 iii@linux.ibm.com, pasic@linux.ibm.com, farman@linux.ibm.com,
 qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20250429052021.10789-1-nicholas@linux.ibm.com>
 <489d0473-579a-4850-a6d5-be38bf2954b9@redhat.com>
 <5863e80e-8296-4f63-bf7d-783b2a9aca0a@linux.ibm.com>
 <27d5d332-bc7c-4036-a3d9-d4666411bd4a@linux.ibm.com>
 <14b9b607-c88a-4691-9872-cc6a51834c95@linux.ibm.com>
 <1c983e1e-9610-4c53-8453-2db52ffa47e9@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <1c983e1e-9610-4c53-8453-2db52ffa47e9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 13/05/2025 15.42, Matthew Rosato wrote:
> On 5/13/25 2:50 AM, Christian Borntraeger wrote:
>> Am 29.04.25 um 16:09 schrieb Matthew Rosato:
>>> On 4/29/25 3:45 AM, Christian Borntraeger wrote:
>>>> Am 29.04.25 um 09:37 schrieb David Hildenbrand:
>>>> [...]
>>>>> The only problem I see is with vfio devices is the new "memory pinned" mode. [1]
>>>>>
>>>>> There, we'd have to check if any such device is around (discarding of ram is disabled?), and fallback to actual zeroing of memory.
>>>>
>>>> CC Matt to double check.
>>>
>>> When triggering the "relaxed translation" mode via iommu.passthrough in the guest, we now take the default (for other platforms) memory_region_is_ram() path in vfio_listener_region_add/del() which handles the pin/unpin from vfio common code.  As for ram discarding, we then also use the vfio common path and only uncoordinated discards are disabled via:
>>>
>>> vfio_ram_block_discard_disable() -> ram_block_uncoordinated_discard_disable()
>>
>> So this patch is good?
>>
> 
> Worked fine in my testing in combination with iommu.passthrough=1.  I traced to verify I was hitting the S390_RESET_REIPL_CLEAR path in s390_machine_reset() and observed the pinned memory of the guest shrink / grow.  Device worked fine afterwards.

What about David's concern here: 
https://lore.kernel.org/qemu-devel/489d0473-579a-4850-a6d5-be38bf2954b9@redhat.com/ 
?

  Thomas


