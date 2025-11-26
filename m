Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB393D111A9
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 21:43:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vONHd-0003QF-Gb; Wed, 26 Nov 2025 16:42:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vONHb-0003Q1-N8
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 16:42:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vONHY-0007lE-G2
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 16:42:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764193353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=St3+zQTOZPOLIQiqK0cMr3+5ZNY8YrMy2wqmBM1GrTM=;
 b=RC/damLJgxgyKwG4kMWVh95O87zOO+m5BxBy3rsU5aCP5xmhmsB9sQrOT5rigyPTbIL3Kw
 pdXBLxG6iMs9GK2Z4BfX2VQGQmKzN1sFSmXQ29kDj2JN59NsuxnoymBUYYOOe5H0HfI29N
 rHkUWjtKiBlLw2RXOMPNvCgEWbpRSQw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-NhciOV-UO0GLjMSNkQV33A-1; Wed, 26 Nov 2025 16:42:31 -0500
X-MC-Unique: NhciOV-UO0GLjMSNkQV33A-1
X-Mimecast-MFC-AGG-ID: NhciOV-UO0GLjMSNkQV33A_1764193351
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8a1c15daa69so55318085a.1
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 13:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764193351; x=1764798151; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=St3+zQTOZPOLIQiqK0cMr3+5ZNY8YrMy2wqmBM1GrTM=;
 b=UPBi/1K8DViP4BykM9ipES8fPQAd3CuqGyh0PlJSKKuT674g7BaMZ19Fm2jeBffiS8
 EONCWZjbnc7vyonT7/izk/hRdvZuW9Xwrn7vlC54CeeptbunYzvyDwDfUwlFrhvNMRjb
 rOelGn7HaPFyvJtoTAIbyYzI2E3GmA5cTjLaWkyvAkWIh4QSkwaOmrsGNxcvE21g58F4
 gxC4e4ybU6Z84mYYw8gEnyHxjR/eWcS3mal4XtOPWpQAUk8ImYNIa79uEjTnUHO5ZJh+
 +wkHMYdfJXBi7y6pXXT22H29uoadDYT3FZVC7xEY5OmWm+MDpWBJCd6DBT9N4AB2HpVF
 GXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764193351; x=1764798151;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=St3+zQTOZPOLIQiqK0cMr3+5ZNY8YrMy2wqmBM1GrTM=;
 b=NBRKmUrsOsmyjFttF9OKzgVN34s0YAWAI7bnGgovBpkim9szbkeVyT3tCNg8Q7ecSo
 AJrp07M/3c8RO9clYyy3+1RE08X2Lz2YkdmRn/xxHRo7HF15nC0UDVjKe1jDAwiddpfU
 qSA7z+zUNBJIW0ho9nfY8iHJof+/V87sIond51T5q5tTOurQEVGTnYiVHrTV7ZeBD6Wz
 gvs+tRQLV0GGLDJY/FWUZORxr+VgH2F/Tux/FpNxKzrjv0xLnUL3iDDYyso0XOvS7wts
 CULJq+GsGbrkVo4GVy7o5R5KgrDHCCzbP4M9utSv29yJ9/Pp1mt1L+UH7rtxFKTc1kGl
 qe9w==
X-Gm-Message-State: AOJu0YwX6NVAHCfjop7QF5/GfdcIrD70cgVt686vPwkGtKLaLtHnyrUn
 XlBmY/WPXMxDQJUucIRRlr/hct24Ln1FkYYJ+oM24I5+qmzkYikEFItAvvjMYs5jFEJVi0ltxQ5
 AFKo7sO0BoUbq1bbigOkmSE3iqDjHUzo4rff4tlDf5h65lSPbMBPIBt3E
X-Gm-Gg: ASbGncvPK/zjfJEuS3sTv4KcldmmESs+K7YzG70ztQ/hOmXntzT8LbIskIbPK3gnmLc
 ZEoemt+7HfIgw4Ym6JWaWxTs4WuFVkOGHo3CGQAQXPa0kyOaxl+KzffnlFPsoLVbcbA07heXKfw
 gD53pttUeMHiS0QE8qU+tTQU1094Pylh3h0zIX8igJTztHsww4EXCwCSSh+CEaV6zxh04oFIAjR
 T5PP5ibgrRPqS8ROsVmUjVfTxjtlE5BHN7abrW8PjbF80UoEsJkxxHouyLk8HnF1Nod3edYqoMH
 Y3xtyM2+EyRKorNdzRu0GiMhRJUFuqqHl2S9vsTW7Se0shNNdsDyfDJjNBrxbQj5Dpeci690I3U
 CCfY=
X-Received: by 2002:a05:620a:3188:b0:864:48eb:34e with SMTP id
 af79cd13be357-8b4ebdaea45mr1078042885a.55.1764193350931; 
 Wed, 26 Nov 2025 13:42:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsOmEt8n4/WQzTnrFyJ0Ft8b/MwcuXwpjsKyz5XWU3OT9YiWWbouA7Gb4UlILhggdEA+LT5w==
X-Received: by 2002:a05:620a:3188:b0:864:48eb:34e with SMTP id
 af79cd13be357-8b4ebdaea45mr1078040685a.55.1764193350417; 
 Wed, 26 Nov 2025 13:42:30 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b32932d9ecsm1494665885a.3.2025.11.26.13.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 13:42:30 -0800 (PST)
Date: Wed, 26 Nov 2025 16:42:28 -0500
From: Peter Xu <peterx@redhat.com>
To: Pawel Zmarzly <pzmarzly0@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [PATCH] migration: Fix writing mapped_ram + ignore_shared
 snapshots
Message-ID: <aSd0ROg_3snWMuCB@x1.local>
References: <20251126154734.940066-1-pzmarzly0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251126154734.940066-1-pzmarzly0@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Nov 26, 2025 at 03:47:34PM +0000, Pawel Zmarzly wrote:
> Currently if you set these flags and have any shared memory object, saving
> a snapshot will fail with:
> 
>     Failed to write bitmap to file: Unable to write to file: Bad address

This one is slightly more involved..  I suggest we put the stack dump
otherwise it's not clear what this error is about.

I reproduced it, so you can take this if you see fit:

#2  0x000055ca83dbb903 in qio_channel_file_pwritev (ioc=0x7f84e0010130, iov=0x7f841649e880, niov=1, offset=160, errp=0x7f841649e8d8) at ../io/channel-file.c:209
#3  0x000055ca83dc5044 in qio_channel_pwritev (ioc=0x7f84e0010130, iov=0x7f841649e880, niov=1, offset=160, errp=0x7f841649e8d8) at ../io/channel.c:467
#4  0x000055ca83dc50b2 in qio_channel_pwrite (ioc=0x7f84e0010130, buf=0x0, buflen=131072, offset=160, errp=0x7f841649e8d8) at ../io/channel.c:478
#5  0x000055ca83db8e29 in qemu_put_buffer_at (f=0x55caab660c40, buf=0x0, buflen=131072, pos=160) at ../migration/qemu-file.c:536
#6  0x000055ca83aa651c in ram_save_file_bmap (f=0x55caab660c40) at ../migration/ram.c:3223
#7  0x000055ca83aa6bcc in ram_save_complete (f=0x55caab660c40, opaque=0x55ca856b7020 <ram_state>) at ../migration/ram.c:3426
#8  0x000055ca83aaf2f2 in qemu_savevm_complete (se=0x55caab112420, f=0x55caab660c40) at ../migration/savevm.c:1521
#9  0x000055ca83aaf707 in qemu_savevm_state_complete_precopy_iterable (f=0x55caab660c40, in_postcopy=false) at ../migration/savevm.c:1627
#10 0x000055ca83aafa3a in qemu_savevm_state_complete_precopy (f=0x55caab660c40, iterable_only=false) at ../migration/savevm.c:1719
#11 0x000055ca83a8cca3 in migration_completion_precopy (s=0x55caab111bf0) at ../migration/migration.c:3027
#12 0x000055ca83a8cd6b in migration_completion (s=0x55caab111bf0) at ../migration/migration.c:3064
#13 0x000055ca83a8dcd6 in migration_iteration_run (s=0x55caab111bf0) at ../migration/migration.c:3542
#14 0x000055ca83a8e410 in migration_thread (opaque=0x55caab111bf0) at ../migration/migration.c:3834

IMHO the important bit is stack #4/#5 where buf==0x0.

So the issue is that ram_list_init_bitmaps() will not initialize file
bitmap for shared ramblocks if x-ignore-share=on.

This is another hint that the two features being used together never
worked.  The commit log should also mention that then it's fine we break
the file format in this specific case.

> 
> We need to skip writing RAMBlocks that are backed by shared objects.

Correct.

Fabiano had a proposal in the other email that we could skip calling
mapped_ram_setup_ramblock() completely for migrate_ram_is_ignored()
ramblocks.

But now I doubt if that's the best we can have.

The tricky bit here is x-ignore-share=on has one special use case, where
the src QEMU saves the snapshot with ramblocks share=on, while load the
snapshot with the exact same ramblocks but instead specify share=off (see
b17fbbe55cb).

Then to make such work, we may need to always still dump the header exactly
as what you did in this patch, otherwise migrate_ram_is_ignored() may
return differently on src / dst on the same ramblock in this case.

Above will also better be mentioned in the commit message.. to justify why
we still need the mapped-ram headers at all for shared ramblocks, rather
than skipping them.

> 
> Also, we should mark these RAMBlocks as skipped, so the snapshot format stays
> readable to tools that later don't know QEMU's command line (for example
> scripts/analyze-migration.py). I used bitmap_offset=0 pages_offset=0 for this.

Right, this is another reason, thanks for pointing this out.

Likely the root reason here is the same as I replied to Fabiano elsewhere,
that we treat ram_bytes_total_with_ignored() as total size of all the
ramblocks, hence we need to include shared ones here in headers.

> 
> This minor change to snapshot format should be safe, as offset=0 should not
> have ever been possible.

Maybe we should update mapped-ram.rst for this.  Please do so in one patch
if possible, we can also update it separately if we want.

> 
> Signed-off-by: Pawel Zmarzly <pzmarzly0@gmail.com>
> ---
> This requires my previous patch "migration: fix parsing snapshots with
> x-ignore-shared flag".

Now I start to question whether I should have that other fix of yours to be
for this release or next.

If this use case is completely broken, we shouldn't need to rush -rc
window, now I plan to merge all these fixes later when 11.0 dev window
opens.  Let me know if you, or Fabiano, has any comments.

> To make things easier, you can see the stack at
> https://gitlab.com/pzmarzly/qemu/-/commits/pzmarzly?ref_type=heads
> ---
>  migration/ram.c | 51 ++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 18 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 7d024b88b5..8063522a14 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3042,28 +3042,36 @@ static void mapped_ram_setup_ramblock(QEMUFile *file, RAMBlock *block)
>      header = g_new0(MappedRamHeader, 1);
>      header_size = sizeof(MappedRamHeader);
>  
> -    num_pages = block->used_length >> TARGET_PAGE_BITS;
> -    bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
> -
> -    /*
> -     * Save the file offsets of where the bitmap and the pages should
> -     * go as they are written at the end of migration and during the
> -     * iterative phase, respectively.
> -     */
> -    block->bitmap_offset = qemu_get_offset(file) + header_size;
> -    block->pages_offset = ROUND_UP(block->bitmap_offset +
> -                                   bitmap_size,
> -                                   MAPPED_RAM_FILE_OFFSET_ALIGNMENT);
> -
>      header->version = cpu_to_be32(MAPPED_RAM_HDR_VERSION);
>      header->page_size = cpu_to_be64(TARGET_PAGE_SIZE);
> -    header->bitmap_offset = cpu_to_be64(block->bitmap_offset);
> -    header->pages_offset = cpu_to_be64(block->pages_offset);
> +
> +    if (migrate_ram_is_ignored(block)) {

nitpick: we can some comment here on what does "setting both to 0" imply.

> +        header->bitmap_offset = 0;
> +        header->pages_offset = 0;
> +    } else {
> +        num_pages = block->used_length >> TARGET_PAGE_BITS;
> +        bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
> +
> +        /*
> +         * Save the file offsets of where the bitmap and the pages should
> +         * go as they are written at the end of migration and during the
> +         * iterative phase, respectively.
> +         */
> +        block->bitmap_offset = qemu_get_offset(file) + header_size;
> +        block->pages_offset = ROUND_UP(block->bitmap_offset +
> +                                       bitmap_size,
> +                                       MAPPED_RAM_FILE_OFFSET_ALIGNMENT);
> +
> +        header->bitmap_offset = cpu_to_be64(block->bitmap_offset);
> +        header->pages_offset = cpu_to_be64(block->pages_offset);
> +    }
>  
>      qemu_put_buffer(file, (uint8_t *) header, header_size);
>  
> -    /* prepare offset for next ramblock */
> -    qemu_set_offset(file, block->pages_offset + block->used_length, SEEK_SET);
> +    if (!migrate_ram_is_ignored(block)) {
> +        /* leave space for block data */

Nit, the comment is touched up but "block data" might be misleading.  IMHO
we could spell it out, here essentially it's both the bitmap and the page
contents.

IMHO it can be something like:

           /*
            * Reserve space for both the ramblock bitmap and page contents.
            * Only needed if the ramblock will be migrated.
            */

> +        qemu_set_offset(file, block->pages_offset + block->used_length, SEEK_SET);
> +    }
>  }
>  
>  static bool mapped_ram_read_header(QEMUFile *file, MappedRamHeader *header,
> @@ -3146,7 +3154,6 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
>              if (migrate_ignore_shared()) {
>                  qemu_put_be64(f, block->mr->addr);
>              }
> -
>              if (migrate_mapped_ram()) {
>                  mapped_ram_setup_ramblock(f, block);
>              }
> @@ -3217,6 +3224,10 @@ static void ram_save_file_bmap(QEMUFile *f)
>      RAMBlock *block;
>  
>      RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +        if (migrate_ram_is_ignored(block)) {
> +            continue;
> +        }
> +
>          long num_pages = block->used_length >> TARGET_PAGE_BITS;
>          long bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
>  
> @@ -4162,6 +4173,10 @@ static void parse_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
>          return;
>      }
>  
> +    if (migrate_ignore_shared() && header.bitmap_offset == 0 && header.pages_offset == 0) {

Over long line which will fail checkpatch.pl.

Optionally, we may introduce a tiny inline helper to check both offsets and
x-ignore-shared, then the helper can be e.g. ramblock_mapped_ram_ignored()
to help readability.

> +        return;
> +    }
> +
>      block->pages_offset = header.pages_offset;
>  
>      /*
> -- 
> 2.52.0
> 

Thanks,

-- 
Peter Xu


