Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABEBC48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 07:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWtTI-0001Bz-VO; Mon, 05 Feb 2024 02:32:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rWtTE-0001BZ-G9
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 02:32:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rWtTC-0002Sb-I7
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 02:32:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707118365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WmO+rrCeMO3ESdcPF+696JtVaktlX0N/vkbfimWgFKc=;
 b=BK6WSc9tXlxuHysbHnXFS6hZFghyALza8nMnmr3aIRx34OEZjDZ/YUKCUavzw47HwsaZVz
 GbkEuM8FPaUar2/75AO7m95YjFelg6CQvZb6SS5x/FYaY0WQiCkvWy99TISLDo6ZYH5qZa
 Wsi8JccPJrtANJxGU7ujtXKC8awK9DE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-RT91j8ydNymgTpEvg1pjgw-1; Mon, 05 Feb 2024 02:32:41 -0500
X-MC-Unique: RT91j8ydNymgTpEvg1pjgw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40f02515093so23205495e9.2
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 23:32:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707118360; x=1707723160;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WmO+rrCeMO3ESdcPF+696JtVaktlX0N/vkbfimWgFKc=;
 b=Qo6P7F87KBEYvNpSghWtIfiYtBKr3vCUErZx7JsKBi377K9osxuLlzyJSJpaqIZP3s
 6NEMN0buKa0zagdNM8WxXB+5srHwIQK8EmF0HVwtI51qzcf86sPI/5RIYWHq0gsZrN1s
 2cDr/Pu3EqUWWqO8YqYSlAxRk/G8+pnehS+Y2PffVG+ORK7sIBf7dnGiE88ZH5G/xCe6
 FeWVaMq30QfkJYcy2vyrHBS93xZ8Tavqj7Nr3jHt2OodbXjutVcuve3SS5XI03N6Bwvx
 tMOpkqxB8pgfbg5WMfP0QuK/FebitUzD9pK1CoKYjoqGevr54ZiHXvQ1W7p0meaJq5EE
 fDfQ==
X-Gm-Message-State: AOJu0Yx2qSc0EWkSS8CGl84gJk+m1x+5+ocgMR+wiPjcwEMqOizxHEWX
 E3C7FeQBJ22ZDHDJ0h7Gg8s5eJbWj2mg63CXqC/K8vpO5I64Dnmjhbxjs9dldRmNMbpy0u94d86
 AdULTyKrzOb4x8VQ1sEswGNwxcc/3HLLN8M/uUiKGEaiyrD1Cm0Rg
X-Received: by 2002:a05:600c:1d08:b0:40f:d598:bdbb with SMTP id
 l8-20020a05600c1d0800b0040fd598bdbbmr2748216wms.11.1707118360500; 
 Sun, 04 Feb 2024 23:32:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEINVhj7d2GB4WZ0+iOE8U3/1c1zGmiCkiLBhndyLvXi7eGl3iYkmggplUvWdG513P8SNA0fg==
X-Received: by 2002:a05:600c:1d08:b0:40f:d598:bdbb with SMTP id
 l8-20020a05600c1d0800b0040fd598bdbbmr2748203wms.11.1707118360161; 
 Sun, 04 Feb 2024 23:32:40 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUMk+BhAONtFTGFcpa2179oIsqQtFbN2Mzzc68m+UhauDmy+PhNJm87ZpDKT2dfNnT+B9vmczpUlBmlN/DhIqxw1JPiG/i+X5cfSm/o1jgMFT1Mlj/rMYQrt8gshyTjN/peQM4lffVT7K32g8Lq+nt2cR8g/S0B21LOtGxi53M3yDwDZ1kzMTG4vPSirPgFyUcnQODQO+fABRzFDmmAz1d5GPj1JeUnNpasrrzrKqM=
Received: from [10.218.83.77] ([88.128.88.102])
 by smtp.gmail.com with ESMTPSA id
 u8-20020a05600c19c800b0040fb0c90da6sm7641977wmq.14.2024.02.04.23.32.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Feb 2024 23:32:39 -0800 (PST)
Message-ID: <5f8701ff-7fd7-4ec1-94b4-7138f652774f@redhat.com>
Date: Mon, 5 Feb 2024 08:32:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/15] libvhost-user: Speedup gpa_to_mem_region() and
 vu_gpa_to_va()
Content-Language: en-US
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
References: <20240202215332.118728-1-david@redhat.com>
 <20240202215332.118728-12-david@redhat.com>
 <CAFubqFvC24ng0kHJectz3zN3UDHR6T+Cs7J+RUfm+zT92HR+Zg@mail.gmail.com>
 <21d326c9-f07f-435f-9cbb-6a4e7ac46c65@redhat.com>
 <CAFubqFv6ryzXHC-wPaFv5hkFET+CO7H=M3LGMU5yXGYWeJuUpA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAFubqFv6ryzXHC-wPaFv5hkFET+CO7H=M3LGMU5yXGYWeJuUpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 04.02.24 23:07, Raphael Norwitz wrote:
> On Sun, Feb 4, 2024 at 9:51 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 04.02.24 03:10, Raphael Norwitz wrote:
>>> One comment on this one.
>>>
>>> On Fri, Feb 2, 2024 at 4:56 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> Let's speed up GPA to memory region / virtual address lookup. Store the
>>>> memory regions ordered by guest physical addresses, and use binary
>>>> search for address translation, as well as when adding/removing memory
>>>> regions.
>>>>
>>>> Most importantly, this will speed up GPA->VA address translation when we
>>>> have many memslots.
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>    subprojects/libvhost-user/libvhost-user.c | 49 +++++++++++++++++++++--
>>>>    1 file changed, 45 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
>>>> index d036b54ed0..75e47b7bb3 100644
>>>> --- a/subprojects/libvhost-user/libvhost-user.c
>>>> +++ b/subprojects/libvhost-user/libvhost-user.c
>>>> @@ -199,19 +199,30 @@ vu_panic(VuDev *dev, const char *msg, ...)
>>>>    static VuDevRegion *
>>>>    vu_gpa_to_mem_region(VuDev *dev, uint64_t guest_addr)
>>>>    {
>>>> -    unsigned int i;
>>>> +    int low = 0;
>>>> +    int high = dev->nregions - 1;
>>>>
>>>>        /*
>>>>         * Memory regions cannot overlap in guest physical address space. Each
>>>>         * GPA belongs to exactly one memory region, so there can only be one
>>>>         * match.
>>>> +     *
>>>> +     * We store our memory regions ordered by GPA and can simply perform a
>>>> +     * binary search.
>>>>         */
>>>> -    for (i = 0; i < dev->nregions; i++) {
>>>> -        VuDevRegion *cur = &dev->regions[i];
>>>> +    while (low <= high) {
>>>> +        unsigned int mid = low + (high - low) / 2;
>>>> +        VuDevRegion *cur = &dev->regions[mid];
>>>>
>>>>            if (guest_addr >= cur->gpa && guest_addr < cur->gpa + cur->size) {
>>>>                return cur;
>>>>            }
>>>> +        if (guest_addr >= cur->gpa + cur->size) {
>>>> +            low = mid + 1;
>>>> +        }
>>>> +        if (guest_addr < cur->gpa) {
>>>> +            high = mid - 1;
>>>> +        }
>>>>        }
>>>>        return NULL;
>>>>    }
>>>> @@ -273,9 +284,14 @@ vu_remove_all_mem_regs(VuDev *dev)
>>>>    static void
>>>>    _vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *msg_region, int fd)
>>>>    {
>>>> +    const uint64_t start_gpa = msg_region->guest_phys_addr;
>>>> +    const uint64_t end_gpa = start_gpa + msg_region->memory_size;
>>>>        int prot = PROT_READ | PROT_WRITE;
>>>>        VuDevRegion *r;
>>>>        void *mmap_addr;
>>>> +    int low = 0;
>>>> +    int high = dev->nregions - 1;
>>>> +    unsigned int idx;
>>>>
>>>>        DPRINT("Adding region %d\n", dev->nregions);
>>>>        DPRINT("    guest_phys_addr: 0x%016"PRIx64"\n",
>>>> @@ -295,6 +311,29 @@ _vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *msg_region, int fd)
>>>>            prot = PROT_NONE;
>>>>        }
>>>>
>>>> +    /*
>>>> +     * We will add memory regions into the array sorted by GPA. Perform a
>>>> +     * binary search to locate the insertion point: it will be at the low
>>>> +     * index.
>>>> +     */
>>>> +    while (low <= high) {
>>>> +        unsigned int mid = low + (high - low)  / 2;
>>>> +        VuDevRegion *cur = &dev->regions[mid];
>>>> +
>>>> +        /* Overlap of GPA addresses. */
>>>
>>> Looks like this check will only catch if the new region is fully
>>> contained within an existing region. I think we need to check whether
>>> either start or end region are in the range, i.e.:
>>
>> That check should cover all cases of overlaps, not just fully contained.
>>
>> See the QEMU implementation of range_overlaps_rang() that contains a
>> similar logic:
>>
>> return !(range2->upb < range1->lob || range1->upb < range2->lob);
>>
>>      !(range2->upb < range1->lob || range1->upb < range2->lob);
>> =  !(range2->upb < range1->lob) && !(range1->upb < range2->lob)
>> =   range2->upb >= range1->lob && range1->upb >= range2->lob
>> =   range1->lob <= range2->upb && range2->lob <= range1->upb
>>
>> In QEMU, upb is inclusive, if it were exclusive (like we have here):
>>
>> =   range1->lob < range2->upb && range2->lob < range1->upb
>>
>> Which is what we have here with:
>>
>> range1->lob = start_gpa
>> range1->upb = end_gpa
>> range2->lob = cur->gpa
>> range2->upb = cur->gpa + cur->size
>>
>> Also if you are interested, see
>>
>> https://stackoverflow.com/questions/3269434/whats-the-most-efficient-way-to-test-if-two-ranges-overlap
>>
>> Thanks!
> 
> Got it, thanks for the full explanation. With that:
> 
> Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>

Thanks!

-- 
Cheers,

David / dhildenb


