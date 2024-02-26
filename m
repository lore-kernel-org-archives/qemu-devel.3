Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4C9C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 05:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reTP0-0003Ba-4g; Mon, 26 Feb 2024 00:19:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reTOZ-00038n-HI
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 00:19:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reTOX-0001yo-QQ
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 00:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708924756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dGIGbjZFKxlVqzBwK2Xf2rWPBns5jqDNfuAkmXZ4IBE=;
 b=KfMXdY+V5BLKe4ai6VTRdkiWt/GIcrgWQTwy4mtvMLQKOocHFi5m09q2XhZ/iM6a7/vUHQ
 GjoInM1r+M4or95xjF6CqqF91D+g5zISz3gCmrjf7b3eNDP+M09Cq/uUPVa7IB/Wu7wjjK
 vqJZwpFtGMSvKUCa+DTfEdUTUn183j0=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-QZstI_pQNHCc3Rxw--Rntg-1; Mon, 26 Feb 2024 00:19:14 -0500
X-MC-Unique: QZstI_pQNHCc3Rxw--Rntg-1
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-7c2cda10fb2so94116839f.1
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 21:19:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708924753; x=1709529553;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dGIGbjZFKxlVqzBwK2Xf2rWPBns5jqDNfuAkmXZ4IBE=;
 b=s16OP1+s+QjVJhRuPY8T0yUPHswTJ02gkT6OggmPkSuvoxvINvdBuRsW6jCghpHht6
 4kv4BY+XkKmKLwJErLk+28zOvVsORe+4Mbh7GSkPhhKPsn41WrZZP9Qz603k32OnVvj+
 Q3CFY3hL1R72NXqwy5YYNiMAhgNuCUolwT+xuDNDD9ZRnDtJJMf40pR0y9YS7Jv7jv7E
 jLrk3en8cUX/r5gcWPoJGdu8lYdaY6Q/MsP7LAh8TiIq2zkHNb7td6PItF2wux3SSp1G
 8OhjTgrLrbPuy4ncBpO4WCA9eFHUOVh/JVkxbphb4NAOPV+/3y13y/sCmP9e8x+OBrnI
 Mozg==
X-Gm-Message-State: AOJu0YzjU5v90g6cMagioiC70Wf3vV32VFJ3bE9NKeXAIh7P8lnMWKPs
 Uszdz6+AYRmM6QNfdLXrk7W9HaP4ZEfePi5cygd5sSPZoYAFHRE4X+/dfbxNSX6tZ5yzMle7cNx
 NTcS87wXrGsy5rvhaHo684qryX3YK4N0cPXV+J5JDXEZq4P6emPzf
X-Received: by 2002:a05:6e02:1d98:b0:365:2f19:e58e with SMTP id
 h24-20020a056e021d9800b003652f19e58emr5568609ila.3.1708924753645; 
 Sun, 25 Feb 2024 21:19:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGf4PkTBpCzaczUZeBMcmEehHfdUMzoEvMMy6eTzVY417c7dFd4IuRVMid1zulkxgDNPYO4gg==
X-Received: by 2002:a05:6e02:1d98:b0:365:2f19:e58e with SMTP id
 h24-20020a056e021d9800b003652f19e58emr5568593ila.3.1708924753272; 
 Sun, 25 Feb 2024 21:19:13 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 k5-20020a633d05000000b005e43cb66a7asm3124483pga.87.2024.02.25.21.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 21:19:12 -0800 (PST)
Date: Mon, 26 Feb 2024 13:19:05 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v4 14/34] migration/ram: Add incoming 'fixed-ram' migration
Message-ID: <ZdwfSbjra0bNG2gQ@x1n>
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-15-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240220224138.24759-15-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
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

On Tue, Feb 20, 2024 at 07:41:18PM -0300, Fabiano Rosas wrote:
> Add the necessary code to parse the format changes for the 'fixed-ram'
> capability.
> 
> One of the more notable changes in behavior is that in the 'fixed-ram'
> case ram pages are restored in one go rather than constantly looping
> through the migration stream.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

Two more nitpicks below.

> ---
> - added error propagation for read_ramblock_fixed_ram()
> - removed buf_size variable
> ---
>  migration/ram.c | 142 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 142 insertions(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 84c531722c..5932e1b8e1 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -106,6 +106,12 @@
>   */
>  #define FIXED_RAM_FILE_OFFSET_ALIGNMENT 0x100000
>  
> +/*
> + * When doing fixed-ram migration, this is the amount we read from the
> + * pages region in the migration file at a time.
> + */
> +#define FIXED_RAM_LOAD_BUF_SIZE 0x100000
> +
>  XBZRLECacheStats xbzrle_counters;
>  
>  /* used by the search for pages to send */
> @@ -2999,6 +3005,35 @@ static void fixed_ram_setup_ramblock(QEMUFile *file, RAMBlock *block)
>      qemu_set_offset(file, block->pages_offset + block->used_length, SEEK_SET);
>  }
>  
> +static bool fixed_ram_read_header(QEMUFile *file, FixedRamHeader *header,
> +                                  Error **errp)
> +{
> +    size_t ret, header_size = sizeof(FixedRamHeader);
> +
> +    ret = qemu_get_buffer(file, (uint8_t *)header, header_size);
> +    if (ret != header_size) {
> +        error_setg(errp, "Could not read whole fixed-ram migration header "
> +                   "(expected %zd, got %zd bytes)", header_size, ret);
> +        return false;
> +    }
> +
> +    /* migration stream is big-endian */
> +    header->version = be32_to_cpu(header->version);
> +
> +    if (header->version > FIXED_RAM_HDR_VERSION) {
> +        error_setg(errp, "Migration fixed-ram capability version mismatch "
> +                   "(expected %d, got %d)", FIXED_RAM_HDR_VERSION,
> +                   header->version);

Instead of "mismatch", perhaps "not supported"?

It doesn't need to strictly match the macro defined, e.g., if we boost it
some day we could support more than one versions?  However larger than the
macro means it came from a newer QEMU, hence not supported seems more
appropriate.

> +        return false;
> +    }
> +
> +    header->page_size = be64_to_cpu(header->page_size);
> +    header->bitmap_offset = be64_to_cpu(header->bitmap_offset);
> +    header->pages_offset = be64_to_cpu(header->pages_offset);
> +
> +    return true;
> +}
> +
>  /*
>   * Each of ram_save_setup, ram_save_iterate and ram_save_complete has
>   * long-running RCU critical section.  When rcu-reclaims in the code
> @@ -3900,6 +3935,102 @@ void colo_flush_ram_cache(void)
>      trace_colo_flush_ram_cache_end();
>  }
>  
> +static bool read_ramblock_fixed_ram(QEMUFile *f, RAMBlock *block,
> +                                    long num_pages, unsigned long *bitmap,
> +                                    Error **errp)
> +{
> +    ERRP_GUARD();
> +    unsigned long set_bit_idx, clear_bit_idx;
> +    ram_addr_t offset;
> +    void *host;
> +    size_t read, unread, size;
> +
> +    for (set_bit_idx = find_first_bit(bitmap, num_pages);
> +         set_bit_idx < num_pages;
> +         set_bit_idx = find_next_bit(bitmap, num_pages, clear_bit_idx + 1)) {
> +
> +        clear_bit_idx = find_next_zero_bit(bitmap, num_pages, set_bit_idx + 1);
> +
> +        unread = TARGET_PAGE_SIZE * (clear_bit_idx - set_bit_idx);
> +        offset = set_bit_idx << TARGET_PAGE_BITS;
> +
> +        while (unread > 0) {
> +            host = host_from_ram_block_offset(block, offset);
> +            if (!host) {
> +                error_setg(errp, "page outside of ramblock %s range",
> +                           block->idstr);
> +                return false;
> +            }
> +
> +            size = MIN(unread, FIXED_RAM_LOAD_BUF_SIZE);
> +
> +            read = qemu_get_buffer_at(f, host, size,
> +                                      block->pages_offset + offset);
> +            if (!read) {
> +                goto err;
> +            }
> +            offset += read;
> +            unread -= read;
> +        }
> +    }
> +
> +    return true;
> +
> +err:
> +    qemu_file_get_error_obj(f, errp);
> +    error_prepend(errp, "(%s) failed to read page " RAM_ADDR_FMT
> +                  "from file offset %" PRIx64 ": ", block->idstr, offset,
> +                  block->pages_offset + offset);
> +    return false;
> +}
> +
> +static void parse_ramblock_fixed_ram(QEMUFile *f, RAMBlock *block,
> +                                     ram_addr_t length, Error **errp)
> +{
> +    g_autofree unsigned long *bitmap = NULL;
> +    FixedRamHeader header;
> +    size_t bitmap_size;
> +    long num_pages;
> +
> +    if (!fixed_ram_read_header(f, &header, errp)) {
> +        return;
> +    }
> +
> +    block->pages_offset = header.pages_offset;
> +
> +    /*
> +     * Check the alignment of the file region that contains pages. We
> +     * don't enforce FIXED_RAM_FILE_OFFSET_ALIGNMENT to allow that
> +     * value to change in the future. Do only a sanity check with page
> +     * size alignment.
> +     */
> +    if (!QEMU_IS_ALIGNED(block->pages_offset, TARGET_PAGE_SIZE)) {
> +        error_setg(errp,
> +                   "Error reading ramblock %s pages, region has bad alignment",
> +                   block->idstr);
> +        return;
> +    }
> +
> +    num_pages = length / header.page_size;
> +    bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
> +
> +    bitmap = g_malloc0(bitmap_size);
> +    if (qemu_get_buffer_at(f, (uint8_t *)bitmap, bitmap_size,
> +                           header.bitmap_offset) != bitmap_size) {
> +        error_setg(errp, "Error reading dirty bitmap");
> +        return;
> +    }
> +
> +    if (!read_ramblock_fixed_ram(f, block, num_pages, bitmap, errp)) {
> +        return;
> +    }
> +
> +    /* Skip pages array */
> +    qemu_set_offset(f, block->pages_offset + length, SEEK_SET);
> +
> +    return;
> +}
> +
>  static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
>  {
>      int ret = 0;
> @@ -3908,6 +4039,17 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
>  
>      assert(block);
>  
> +    if (migrate_fixed_ram()) {
> +        Error *local_err = NULL;

We could move this to top, merge with the other local_err used by
qemu_ram_resize().

> +
> +        parse_ramblock_fixed_ram(f, block, length, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            return -EINVAL;
> +        }
> +        return 0;
> +    }
> +
>      if (!qemu_ram_is_migratable(block)) {
>          error_report("block %s should not be migrated !", block->idstr);
>          return -EINVAL;
> -- 
> 2.35.3
> 

-- 
Peter Xu


