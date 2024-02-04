Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836F9C4828F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 14:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWdqW-00089J-1L; Sun, 04 Feb 2024 09:51:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rWdqU-000897-Jc
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 09:51:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rWdqS-0006Wy-Km
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 09:51:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707058303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7bh18/CJNRbYHknwr2oFzwqqVCzpqaxAMo9YQVKF9Cw=;
 b=eo7PnK10paRT6nLteIUCzGHEerWgqBgJYia9triIPY/y85vIQycUoSc3E4aR8pxctpWoiB
 mZWuGLOYfOef65PZyX7cvNtbM3JiMOlAyrWdU+oNkxRe5TXOMPNTqVXkVk+2xCHq5fg/Y7
 JPYMT3H5oGA+Y9yHYfULaeFSuCC38+k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-imO4d5UxO_Ww-yV3alSr6w-1; Sun, 04 Feb 2024 09:51:40 -0500
X-MC-Unique: imO4d5UxO_Ww-yV3alSr6w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40fca312e15so11215765e9.0
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 06:51:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707058299; x=1707663099;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7bh18/CJNRbYHknwr2oFzwqqVCzpqaxAMo9YQVKF9Cw=;
 b=peJ0XI/bmhBhscJGKXgBx8hWPJdM8n5XqhFRnoH7bQrsfKqun+/Rf/MdRdulQ1bblV
 z9cawoFfCdClkmnubCL1zb0ndUlY/CHrzzK+yconsY37+ovf2rTnSVLmP0HG2J/KNgvg
 dmGd8j5H2X3ZiTig4vPVQjf6QdFd2wwnYzKAqRXFsJ1EWA6hcgzE+nGnB0/c/8feTtQO
 69eh6Cu2pb7NmXVSaZcx4Sc+eCdPLFYV3ED+8wVquZAg0JOrNFt9f9pu24nbngl5UJEJ
 WBzSfSDVAy4ixeusLttDFLM6hPxyxlo6BMHGvQBqfEipY+kLlknhulNKiE/FoQ3O/zX+
 DM0Q==
X-Gm-Message-State: AOJu0YyZXLGpV51DAN1E/B+BEn5cprQqc601z+uC5QbRDiw/yNWhQHgX
 0XtBl03gmFt3NULEZ9NUaoMUv4NZPG6MmKuLlM5WCdvZ7amIqAtwWLoRtmwhBI9cs0muNworaZm
 3AuONyRibsRWqhTNlHqNxhVUBNNhHIqcM2XYJWNBdUfBosjt7ksfY
X-Received: by 2002:a5d:6245:0:b0:33a:f105:ea3b with SMTP id
 m5-20020a5d6245000000b0033af105ea3bmr8509182wrv.22.1707058299450; 
 Sun, 04 Feb 2024 06:51:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1stWMsD5bmzEFJfLFS2XJCNgnoyABJ8CkgCkNPZMJPUrg3LMWFGoLH3dgVLqWvdf+f1WERA==
X-Received: by 2002:a5d:6245:0:b0:33a:f105:ea3b with SMTP id
 m5-20020a5d6245000000b0033af105ea3bmr8509170wrv.22.1707058299054; 
 Sun, 04 Feb 2024 06:51:39 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXBMFQ+Irsbfiu5S59kT1EpFYYz7iBDUUD6z7i9WQUsI1+rwYe4zvwQaEP/hhvO5kHgZyg7yrix7H8Q7wbgAjZ5G+DVc6kQOKvvZUja/3HR25dMbq/UEpq5pk+oGP/LmIrPvxn0KpuxT3p1GiPNFyVDKo6M+4iM4/RsT3PZjmXuRBJGL9ytBxQ52QGJer9gfHUtXKgQgS3+80oV4oVIvQKZqf7jFbT3PQyldNBN/G8=
Received: from ?IPV6:2003:cb:c725:700:519c:c741:25de:232f?
 (p200300cbc7250700519cc74125de232f.dip0.t-ipconnect.de.
 [2003:cb:c725:700:519c:c741:25de:232f])
 by smtp.gmail.com with ESMTPSA id
 a18-20020adff7d2000000b0033b13922263sm6050943wrq.60.2024.02.04.06.51.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Feb 2024 06:51:38 -0800 (PST)
Message-ID: <21d326c9-f07f-435f-9cbb-6a4e7ac46c65@redhat.com>
Date: Sun, 4 Feb 2024 15:51:37 +0100
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
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAFubqFvC24ng0kHJectz3zN3UDHR6T+Cs7J+RUfm+zT92HR+Zg@mail.gmail.com>
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

On 04.02.24 03:10, Raphael Norwitz wrote:
> One comment on this one.
> 
> On Fri, Feb 2, 2024 at 4:56 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> Let's speed up GPA to memory region / virtual address lookup. Store the
>> memory regions ordered by guest physical addresses, and use binary
>> search for address translation, as well as when adding/removing memory
>> regions.
>>
>> Most importantly, this will speed up GPA->VA address translation when we
>> have many memslots.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   subprojects/libvhost-user/libvhost-user.c | 49 +++++++++++++++++++++--
>>   1 file changed, 45 insertions(+), 4 deletions(-)
>>
>> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
>> index d036b54ed0..75e47b7bb3 100644
>> --- a/subprojects/libvhost-user/libvhost-user.c
>> +++ b/subprojects/libvhost-user/libvhost-user.c
>> @@ -199,19 +199,30 @@ vu_panic(VuDev *dev, const char *msg, ...)
>>   static VuDevRegion *
>>   vu_gpa_to_mem_region(VuDev *dev, uint64_t guest_addr)
>>   {
>> -    unsigned int i;
>> +    int low = 0;
>> +    int high = dev->nregions - 1;
>>
>>       /*
>>        * Memory regions cannot overlap in guest physical address space. Each
>>        * GPA belongs to exactly one memory region, so there can only be one
>>        * match.
>> +     *
>> +     * We store our memory regions ordered by GPA and can simply perform a
>> +     * binary search.
>>        */
>> -    for (i = 0; i < dev->nregions; i++) {
>> -        VuDevRegion *cur = &dev->regions[i];
>> +    while (low <= high) {
>> +        unsigned int mid = low + (high - low) / 2;
>> +        VuDevRegion *cur = &dev->regions[mid];
>>
>>           if (guest_addr >= cur->gpa && guest_addr < cur->gpa + cur->size) {
>>               return cur;
>>           }
>> +        if (guest_addr >= cur->gpa + cur->size) {
>> +            low = mid + 1;
>> +        }
>> +        if (guest_addr < cur->gpa) {
>> +            high = mid - 1;
>> +        }
>>       }
>>       return NULL;
>>   }
>> @@ -273,9 +284,14 @@ vu_remove_all_mem_regs(VuDev *dev)
>>   static void
>>   _vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *msg_region, int fd)
>>   {
>> +    const uint64_t start_gpa = msg_region->guest_phys_addr;
>> +    const uint64_t end_gpa = start_gpa + msg_region->memory_size;
>>       int prot = PROT_READ | PROT_WRITE;
>>       VuDevRegion *r;
>>       void *mmap_addr;
>> +    int low = 0;
>> +    int high = dev->nregions - 1;
>> +    unsigned int idx;
>>
>>       DPRINT("Adding region %d\n", dev->nregions);
>>       DPRINT("    guest_phys_addr: 0x%016"PRIx64"\n",
>> @@ -295,6 +311,29 @@ _vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *msg_region, int fd)
>>           prot = PROT_NONE;
>>       }
>>
>> +    /*
>> +     * We will add memory regions into the array sorted by GPA. Perform a
>> +     * binary search to locate the insertion point: it will be at the low
>> +     * index.
>> +     */
>> +    while (low <= high) {
>> +        unsigned int mid = low + (high - low)  / 2;
>> +        VuDevRegion *cur = &dev->regions[mid];
>> +
>> +        /* Overlap of GPA addresses. */
> 
> Looks like this check will only catch if the new region is fully
> contained within an existing region. I think we need to check whether
> either start or end region are in the range, i.e.:

That check should cover all cases of overlaps, not just fully contained.

See the QEMU implementation of range_overlaps_rang() that contains a 
similar logic:

return !(range2->upb < range1->lob || range1->upb < range2->lob);

    !(range2->upb < range1->lob || range1->upb < range2->lob);
=  !(range2->upb < range1->lob) && !(range1->upb < range2->lob)
=   range2->upb >= range1->lob && range1->upb >= range2->lob
=   range1->lob <= range2->upb && range2->lob <= range1->upb

In QEMU, upb is inclusive, if it were exclusive (like we have here):

=   range1->lob < range2->upb && range2->lob < range1->upb

Which is what we have here with:

range1->lob = start_gpa
range1->upb = end_gpa
range2->lob = cur->gpa
range2->upb = cur->gpa + cur->size

Also if you are interested, see
 
https://stackoverflow.com/questions/3269434/whats-the-most-efficient-way-to-test-if-two-ranges-overlap

Thanks!

-- 
Cheers,

David / dhildenb


