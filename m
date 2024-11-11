Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273C9D2E9D6
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 10:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tARsY-0007oc-1k; Mon, 11 Nov 2024 05:42:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tARsK-0007o4-2n
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 05:42:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tARsH-0007ND-RA
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 05:42:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731321743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=X4MnMtg5ej/tnhJaAYYAcviY9tyhNClA3VwOJEaiMrw=;
 b=MKFJIN8ESzw8KbGHDzZvcH3QdjkezOD6CvXAaS693tJUkzH9RiYBr3UfrCxtyfS3lsuoEK
 7CTM3xgCaHKOi5gM35SzryJ09FN8jlZSCeyLhPhR0UGR52sPh2oGi64z3WQr8mHiuIqFP2
 poid96tPxCfHHDneoN2Ah3MjOuesHUg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-hJnIOjEuN2aKqrfkC-g3_Q-1; Mon, 11 Nov 2024 05:42:17 -0500
X-MC-Unique: hJnIOjEuN2aKqrfkC-g3_Q-1
X-Mimecast-MFC-AGG-ID: hJnIOjEuN2aKqrfkC-g3_Q
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-539e7dc83ecso2656725e87.2
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 02:42:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731321735; x=1731926535;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=X4MnMtg5ej/tnhJaAYYAcviY9tyhNClA3VwOJEaiMrw=;
 b=CObjKrUQcm6Ntk2mGgslCdp2SiYIWG81UuKZOGKcm0rcdBN8/blehXaXegSrsrzTMg
 v6r4XT65H2+p9Fgkwq7qvWBuOuqmlDk3hPTCZcWJ/DYwiR9KwX8wLkVJ7EWmmbmwaEoj
 LhJkarF+//uNsznF6arBcAa0tox2EWDPTB2s4E+D2GZititxtzH2MQOiG7qa3815VXw4
 JuKVja7R6haizJpXVryQ4qYJzPq2ZkFy+7KW+nB51Ejwk8tExyBy4W5iRoLPjdG48nUX
 yX5vO4pHTQ4wFRJFYT069alc05pxN3sq/ic+mD8CSQify3XSYwO3l3g/kqu6hk6reHfV
 sNFw==
X-Gm-Message-State: AOJu0YxyqTGUVbz+x504lAuUha33+7jCn9fRGVHEPiKTOZdMd+RFCJ6p
 3qSkNigZdVEBsdm4T2FVYQVHeaE3aMPrdKc5lHDLyTSYpvq8duX0yGqLN9hqUn7CZWYtxUlVCxv
 Mi35Gd8NICrJE3MEJOjX3vCjzO+zkO6OZw1+cSvgJx1ao0Zk9Mi7E
X-Received: by 2002:a05:6512:3da9:b0:539:ffb5:8d2c with SMTP id
 2adb3069b0e04-53d862cb450mr4273758e87.30.1731321735287; 
 Mon, 11 Nov 2024 02:42:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHq+4btrjb6NeWH6s9QdUAEK6Yo3smtpWCRhcqoZ4GxKpwAnoIKf3VY8uuz0fVVmU433xnqwg==
X-Received: by 2002:a05:6512:3da9:b0:539:ffb5:8d2c with SMTP id
 2adb3069b0e04-53d862cb450mr4273747e87.30.1731321734838; 
 Mon, 11 Nov 2024 02:42:14 -0800 (PST)
Received: from ?IPV6:2003:cb:c730:4300:18eb:6c63:a196:d3a2?
 (p200300cbc730430018eb6c63a196d3a2.dip0.t-ipconnect.de.
 [2003:cb:c730:4300:18eb:6c63:a196:d3a2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b054aed6sm168821855e9.15.2024.11.11.02.42.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Nov 2024 02:42:14 -0800 (PST)
Message-ID: <43700d36-b9f8-42da-ba72-b0ec6580032d@redhat.com>
Date: Mon, 11 Nov 2024 11:42:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] migration: Do not perform RAMBlock dirty sync
 during the first iteration
To: Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Wei Wang <wei.w.wang@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <cover.1731128180.git.yong.huang@smartx.com>
 <c25abae360ac204321acc5010a745a8e594f24bd.1731128180.git.yong.huang@smartx.com>
 <b2e42ed6-d514-46c9-993c-e7ae6384592f@redhat.com>
 <CAK9dgmak97Uv_RO+WFEb+KLkiuZ5+ibO3bigm3379L4aD55TvA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAK9dgmak97Uv_RO+WFEb+KLkiuZ5+ibO3bigm3379L4aD55TvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.743,
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

On 11.11.24 11:08, Yong Huang wrote:
> 
> 
> On Mon, Nov 11, 2024 at 5:27 PM David Hildenbrand <david@redhat.com 
> <mailto:david@redhat.com>> wrote:
> 
>     On 09.11.24 05:59, Hyman Huang wrote:
>      > The first iteration's RAMBlock dirty sync can be omitted because QEMU
>      > always initializes the RAMBlock's bmap to all 1s by default.
>      >
>      > Signed-off-by: Hyman Huang <yong.huang@smartx.com
>     <mailto:yong.huang@smartx.com>>
>      > ---
>      >   migration/cpu-throttle.c |  2 +-
>      >   migration/ram.c          | 11 ++++++++---
>      >   2 files changed, 9 insertions(+), 4 deletions(-)
>      >
>      > diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c
>      > index 5179019e33..674dc2004e 100644
>      > --- a/migration/cpu-throttle.c
>      > +++ b/migration/cpu-throttle.c
>      > @@ -141,7 +141,7 @@ void cpu_throttle_dirty_sync_timer_tick(void
>     *opaque)
>      >        * effect on guest performance, therefore omit it to avoid
>      >        * paying extra for the sync penalty.
>      >        */
>      > -    if (sync_cnt <= 1) {
>      > +    if (!sync_cnt) {
>      >           goto end;
>      >       }
>      >
>      > diff --git a/migration/ram.c b/migration/ram.c
>      > index 05ff9eb328..571dba10b7 100644
>      > --- a/migration/ram.c
>      > +++ b/migration/ram.c
>      > @@ -2718,7 +2718,7 @@ static void ram_list_init_bitmaps(void)
>      >   {
>      >       MigrationState *ms = migrate_get_current();
>      >       RAMBlock *block;
>      > -    unsigned long pages;
>      > +    unsigned long pages, clear_bmap_pages;
>      >       uint8_t shift;
>      >
>      >       /* Skip setting bitmap if there is no RAM */
>      > @@ -2736,6 +2736,7 @@ static void ram_list_init_bitmaps(void)
>      >
>      >           RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>      >               pages = block->max_length >> TARGET_PAGE_BITS;
>      > +            clear_bmap_pages = clear_bmap_size(pages, shift);
>      >               /*
>      >                * The initial dirty bitmap for migration must be
>     set with all
>      >                * ones to make sure we'll migrate every guest RAM
>     page to
>      > @@ -2751,7 +2752,12 @@ static void ram_list_init_bitmaps(void)
>      >                   block->file_bmap = bitmap_new(pages);
>      >               }
>      >               block->clear_bmap_shift = shift;
>      > -            block->clear_bmap =
>     bitmap_new(clear_bmap_size(pages, shift));
>      > +            block->clear_bmap = bitmap_new(clear_bmap_pages);
>      > +            /*
>      > +             * Set clear_bmap to 1 unconditionally, as we always
>     set bmap
>      > +             * to all 1s by default.
>      > +             */
>      > +            bitmap_set(block->clear_bmap, 0, clear_bmap_pages);
>      >           }
>      >       }
>      >   }
>      > @@ -2783,7 +2789,6 @@ static bool ram_init_bitmaps(RAMState *rs,
>     Error **errp)
>      >               if (!ret) {
>      >                   goto out_unlock;
>      >               }
>      > -            migration_bitmap_sync_precopy(false);
>      >           }
>      >       }
>      >   out_unlock:
> 
> 
>     For virtio-mem, we rely on the migration_bitmap_clear_discarded_pages()
>     call to clear all bits that correspond to unplugged memory ranges. 
> 
> 
>     If we ommit the sync, we can likely have bits of unplugged ranges still
>     set to "1", meaning we would try migrate them later, although we
>     shouldn't?
> 
> 
> 
> IIUC, migration_bitmap_clear_discarded_pagesis still called at the end of
> ram_init_bitmaps no matter if we omit the first sync.
 > > PRECOPY_NOTIFY_SETUPnotification is sent out at the end of
> ram_save_setup(ram_list_init_bitmaps),when 
> virtio_balloon_free_page_start() is
> called,migration_bitmap_clear_discarded_pages() has already completed 
> and the
> bmap has been correctly cleared.
> 
> ram_save_setup
>     -> ram_list_init_bitmaps
>         -> migration_bitmap_clear_discarded_pages
>      -> return precopy_notify(PRECOPY_NOTIFY_SETUP, errp);
> 
> You can double check it.

That's not my concern, let me clarify :)


Assume in KVM the bitmap is all 1s ("everything dirty").

In current code, we will sync the bitmap once (IIRC, clearing any dirty 
bits from KVM).

Then we call migration_bitmap_clear_discarded_pages() to clear all 
"discarded" pages that we shouldn't touch.

When we do the next bitmap sync, we will not get a "1" for discarded 
ranges, and we will never try migrating discarded ranges.


With your patch, we're omitting the first sync. Could we possibly get 
discarded ranges reported from KVM as dirty during the "now first" sync 
*after* the migration_bitmap_clear_discarded_pages() call, and try 
migrating discarded ranges?

I did not dive deep into the code, maybe 
migration_bitmap_clear_discarded_pages() ends up clearing the bits in 
KVM, but I recall that there was something special about the first 
bitmap sync.

-- 
Cheers,

David / dhildenb


