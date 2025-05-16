Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947CBC3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 20:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uG21I-0000Y4-Ao; Fri, 16 May 2025 16:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uG21E-0000XV-Sd
 for qemu-devel@nongnu.org; Fri, 16 May 2025 16:51:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uG21A-00058Z-UC
 for qemu-devel@nongnu.org; Fri, 16 May 2025 16:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747428653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9XZlZO2rzZJ/IBuAXpPQ22ftRWZ1B4hGugE3MTtRLNc=;
 b=UaxShxm1nGuceDaGetfgd2lz0EGLixMQBdnXcdDjup3Hp0tOdy0klk3VOghgp0C0K1kmzk
 SjvURmbKp2A1SmAt1fk+9Ws/CBVN22q1/4hPBgKOfPSMiSmIHo/PF3Hf8OprMhCBAcUMcA
 bQuMmVXAyQzCJuxoiP53W8oOCRkNOLg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669--pNZngW0MDCTeY4n89Q9SA-1; Fri, 16 May 2025 16:50:52 -0400
X-MC-Unique: -pNZngW0MDCTeY4n89Q9SA-1
X-Mimecast-MFC-AGG-ID: -pNZngW0MDCTeY4n89Q9SA_1747428651
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-442fa43e018so10497555e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 13:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747428651; x=1748033451;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9XZlZO2rzZJ/IBuAXpPQ22ftRWZ1B4hGugE3MTtRLNc=;
 b=gri1UGt/TvxtpThRI1THPzR6cnbse5jLhuJy696E7Z/7uWEIY2bvWjfKAmfP51qUYB
 PJJHIPScbMRb0MbWtYiw2zvVNPOUZTtv97R+6u6qWUw0V/4ee9Tce5msu9JTW0rwgyI7
 pOtrNJ8jlBxoRuJGp6V0iSG0LNG+DRAetk0WCc1xkGKoyLM3KgBgdZDMkKWf5f4ZKGYA
 XRLQh4UEZn9pwnsxfmeZJkfxI7Ph9De4+V9KyyuCAEwHhXfl9wbaiugGv9kJJ2k5pFfC
 sG/ZfnqeY3jr1l2//2jSRbkQ6FXzI4tE+6HK9dFuvo4gDi5ZbMjyRGhV/pESXriIcPZP
 4ulg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV07ZCEGZS77fXwBph1FQYTA9QkzHkNPOPmNLG2CIUqGz7r5ww41cAB9p0EtIeeApT6+tRIql7RCcY+@nongnu.org
X-Gm-Message-State: AOJu0YyLsBt+3Fe4Yrrkq1y1K1PSFGervnDkC7bs7S5fywi1YagpXOfT
 LKm6lUJSUOdU5DwWrCiIbLaV8z+Wj854hOMC0NEAoqDkGYKG4Eo3SN6hwa9Rh/MmIGLJYqQVv/V
 qTLDmccH9/nHudCzGXKe9kIUoLWZAdrWZ5ku7LMlXJbaxxFLmELaoO7ZG
X-Gm-Gg: ASbGncti1Qz/2+xDYT+PoUm+vh0ONh0jfjRdx+j/8/4Quzvl/2NaI9/5e8hS/AFxTvi
 t9pkqV5HLN9XmjxSevjWp8hWtpZbI6FHVSeprwg+oCFdhOj2Tp0YT5MZKCDbB0s4lHgsvLnYoEi
 e96YbejBw5TLndPf35R2Q2vqlpqqck1+ItXUcHJavYYqEENLURl3/8FenMn2hf8qjVhSm6xPmni
 bygEQja3vLCT5jz9ImzJbcDGVYRbNdKRF+GmduWUEOwpO3cQobm0i4VdHxu/Pd3PqtBVvkdvtwZ
 ZRE5vtmvhwLU0yFRZWhFOpxQBYV5rRmDz8Hcab0ULD/gBMnVmJqAPnorZRSKO0mIU+WGq6+GTUQ
 HU3dI7exJoo7SeoSLHJ4/ln0gCkJeDhQp4jzODSE=
X-Received: by 2002:a05:6000:4284:b0:3a0:b978:1f2b with SMTP id
 ffacd0b85a97d-3a35ca7b515mr4563248f8f.11.1747428650842; 
 Fri, 16 May 2025 13:50:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsCsBp8iVPzUAScvS567nF/WY6fCVXSIKkzZy+1rq3g/CzRjJBnZUZTasDuF7qOAB15vG9OQ==
X-Received: by 2002:a05:6000:4284:b0:3a0:b978:1f2b with SMTP id
 ffacd0b85a97d-3a35ca7b515mr4563222f8f.11.1747428650465; 
 Fri, 16 May 2025 13:50:50 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f47:4700:e6f9:f453:9ece:7602?
 (p200300d82f474700e6f9f4539ece7602.dip0.t-ipconnect.de.
 [2003:d8:2f47:4700:e6f9:f453:9ece:7602])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca62b5dsm3998594f8f.55.2025.05.16.13.50.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 13:50:50 -0700 (PDT)
Message-ID: <31cf87f6-94a4-4801-bbe9-882043cd88f2@redhat.com>
Date: Fri, 16 May 2025 22:50:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] vfio: return mr from vfio_get_xlat_addr
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>
References: <1747415599-131553-1-git-send-email-steven.sistare@oracle.com>
 <e6b1e5ee-f8d3-40b5-a608-67469a8b599b@redhat.com>
 <717acf0a-bdeb-45ed-bd44-7c054247836e@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <717acf0a-bdeb-45ed-bd44-7c054247836e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 16.05.25 21:26, Steven Sistare wrote:
> On 5/16/2025 2:58 PM, David Hildenbrand wrote:
>> On 16.05.25 19:13, Steve Sistare wrote:
>>> Modify memory_get_xlat_addr and vfio_get_xlat_addr to return the memory
>>> region that the translated address is found in.  This will be needed by
>>> CPR in a subsequent patch to map blocks using IOMMU_IOAS_MAP_FILE.
>>>
>>> Also return the xlat offset, so we can simplify the interface by removing
>>> the out parameters that can be trivially derived from mr and xlat.
>>>
>>> Lastly, rename the functions to  to memory_translate_iotlb() and
>>> vfio_translate_iotlb().
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>    hw/vfio/listener.c      | 33 ++++++++++++++++++++++-----------
>>>    hw/virtio/vhost-vdpa.c  |  9 +++++++--
>>>    include/system/memory.h | 19 +++++++++----------
>>>    system/memory.c         | 32 +++++++-------------------------
>>>    4 files changed, 45 insertions(+), 48 deletions(-)
>>>
>>> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
>>> index bfacb3d..a4931f1 100644
>>> --- a/hw/vfio/listener.c
>>> +++ b/hw/vfio/listener.c
>>> @@ -90,16 +90,17 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>>>               section->offset_within_address_space & (1ULL << 63);
>>>    }
>>> -/* Called with rcu_read_lock held.  */
>>> -static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>>> -                               ram_addr_t *ram_addr, bool *read_only,
>>> -                               Error **errp)
>>> +/*
>>> + * Called with rcu_read_lock held.
>>> + * The returned MemoryRegion must not be accessed after calling rcu_read_unlock.
>>> + */
>>> +static MemoryRegion *vfio_translate_iotlb(IOMMUTLBEntry *iotlb, hwaddr *xlat_p,
>>> +                                          Error **errp)
>>>    {
>>> -    bool ret, mr_has_discard_manager;
>>> +    MemoryRegion *mr;
>>> -    ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
>>> -                               &mr_has_discard_manager, errp);
>>> -    if (ret && mr_has_discard_manager) {
>>> +    mr = memory_translate_iotlb(iotlb, xlat_p, errp);
>>> +    if (!mr && memory_region_has_ram_discard_manager(mr)) {
>>
>> Pretty sue this should be if (mr && ...)
>>
>> otherwise we'd be dereferencing NULL :)
> 
> Hmmmm.
> That is why we cannot return mr as the function return value.
> There are cases where the function can return error, but the mr is
> valid.  We want to take the branch in that case.  From the original
> code:
>       if (ret && mr_has_discard_manager) {

It's late in Germany, but didn't we return "ret = true" when we would 
now return mr != NULL?

I mean, there is no reason to warn about mr_has_discard_manager if ... 
there is nothing to translate to?

-- 
Cheers,

David / dhildenb


