Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A051D3B996
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 21:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT4yV-000187-J8; Tue, 09 Dec 2025 16:10:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT4yN-00014y-2T
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 16:10:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT4yI-00078S-OL
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 16:10:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765314608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cF3keHBDhHxJkCaup5WcYhcv9nwQOT2TA4jH6OZ2NDo=;
 b=GILFBUMNyqJgb3866Fb0HgwXf/NtMkE5D+fO4/o/pkU9CTYtNwaNvfQL1/G5d9j4Xe+ufR
 MdlJyASIbSPNye8tImZYtEt0rF9F8p1IdN+7ZWiZdi7CSJ+DviMKRIJhvAKHnIlsy+49oJ
 2R7wio3ErIQv/kju7JH2gFd9749Kp1w=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-BJtYTjDfO6aHQHYgsCjXBg-1; Tue, 09 Dec 2025 16:10:06 -0500
X-MC-Unique: BJtYTjDfO6aHQHYgsCjXBg-1
X-Mimecast-MFC-AGG-ID: BJtYTjDfO6aHQHYgsCjXBg_1765314606
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b2ea3d12fcso1332225485a.0
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 13:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765314606; x=1765919406; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cF3keHBDhHxJkCaup5WcYhcv9nwQOT2TA4jH6OZ2NDo=;
 b=qYIFEhRqInsFpK3Kxl9aozEnys9LePnpuERMyryPQIDabo5FqHp33sX1RkguXTM7Sd
 OQubu+R/HxEZDnca83enSWVM2KnfiiCD9L3QcvOJVEbKG2UrlAYRb+C/7KQSFA6FvgJJ
 2O0bXHtZowMT8yIFLrmIZvRYqUMw0QUPKRFP9TWJ0BC7jDfouvWiR//A0EF90jN5pi68
 5JMi2CUbcnhqwqTCtj+TtNh2Cdt8amrnvansbfc4jWTMSXABgrbzpJJrpZBgvCJDOeHn
 sMQh2YQe4F5iqsS3pGC9kQGo902eQK7m7xJvwa6cTvJ+k0hyIAVXO1iDoQ+HgekIYSLi
 WtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765314606; x=1765919406;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cF3keHBDhHxJkCaup5WcYhcv9nwQOT2TA4jH6OZ2NDo=;
 b=PjtEVWNvVIIxLUghxytIc+nqf7xIldFbx3HE/3zp98ttairOHwshXBQ/bRT0Jdo+pd
 NTfBz/RucbcD0XiYFlmOuu6f9QzlMdbxwtB+NNGmNRwiekxbbBhzo3g6sqz+wG4qsF0w
 pwBuwKI25lNa5tP+MkrLFRsTqSvi9ky9M+YYR2Ee0fFIp3RmBetDvSxztwp6BJiNLf/5
 6RlPgdU+LgxNumUulDtIDKZUhYICjuzNbyiWoIobuMts+idmHhG4g/A6QSntUawMLVsx
 0aweFI5nfvzU+ivUr2pnuox8u7/naqVwtyD2lc4nZrjh3d11y2Koic2L1uQCocxYiUO6
 pNDg==
X-Gm-Message-State: AOJu0Yxzlj3Q5XdfTsQNA4DOJN+0p0ZU0F7DM1V17j6AhQcyeoP6UjiZ
 PTS0AQs+dUAyZ75mwpa3RNMQhzTcXYSY1B2UIlWsxELxWfeIhG/cyE5VBZ+ojN+64+QyT0e1hpB
 DZSV6YNJT+MKJ17mevvT7r09FQO26cZPx/r4+ysBi9YRqOrjMwYsss9iL
X-Gm-Gg: ASbGncsK3Hyj/x3J6syY7tsOygmc5FahB57mlc/m2d4ago0GFibfLldXxq/kKJaNK9x
 AIgPQZqwlJ1t995prEdALAF2uYlxh31bf1BOAIMoMuJbRXl2fP/EuotRsRZ6u6lHGwP8aBnDIoU
 OerNN203KyB/bL1SVifJAU4EJl0rPwEgtQgsBEjIS5aFEA6RGc5A7HkthCwb211NT8ozwKXN/N7
 VzWQt2mT3gVWfl0fqFrZrsvaniEQm/79sNuqpYGfyy9JOPduCsHWPS9ykeZY3Oyb6rL7TA2b/2g
 PFDEuM0eESL0vJZ5NHvCEgETwRa4xcyZ5opzrgoTGy3A1Cz6Icj6Tr3O3fDEtSbX6lLGsZpW/7V
 7Ong=
X-Received: by 2002:a05:620a:3193:b0:8b2:62f9:9fd8 with SMTP id
 af79cd13be357-8ba3a6629a3mr68282085a.61.1765314606119; 
 Tue, 09 Dec 2025 13:10:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFt7T6y2zpeUuZJ2zI8ODU8/ngzUST8yT7uTtyYKDOGQ5GaiXwIB//D4U9MwQknABubbCve8A==
X-Received: by 2002:a05:620a:3193:b0:8b2:62f9:9fd8 with SMTP id
 af79cd13be357-8ba3a6629a3mr68275685a.61.1765314605526; 
 Tue, 09 Dec 2025 13:10:05 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b6252b53fdsm1359018585a.16.2025.12.09.13.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 13:10:05 -0800 (PST)
Date: Tue, 9 Dec 2025 16:10:03 -0500
From: Peter Xu <peterx@redhat.com>
To: Chuang Xu <xuchuangxclwt@bytedance.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, sgarzare@redhat.com,
 richard.henderson@linaro.org, pbonzini@redhat.com, david@kernel.org,
 philmd@linaro.org, farosas@suse.de
Subject: Re: [RFC v1 2/2] migration: merge fragmented clear_dirty ioctls
Message-ID: <aTiQK-a-ZcANCFbk@x1.local>
References: <20251208120952.37563-1-xuchuangxclwt@bytedance.com>
 <20251208120952.37563-3-xuchuangxclwt@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251208120952.37563-3-xuchuangxclwt@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Mon, Dec 08, 2025 at 08:09:52PM +0800, Chuang Xu wrote:
> From: xuchuangxclwt <xuchuangxclwt@bytedance.com>
> 
> When the addresses processed are not aligned, a large number of
> clear_dirty ioctl occur (e.g. a 16MB misaligned memory can generate
> 4096 clear_dirty ioctls), which increases the time required for
> bitmap_sync and makes it more difficult for dirty pages to converge.
> 
> Attempt to merge those fragmented clear_dirty ioctls.

(besides separate perf results I requested as in the cover letter reply..)

Could you add something into the commit log explaining at least one example
that you observe?  E.g. what is the VM setup, how many ramblocks are the
ones not aligned?

Have you considered setting rb->clear_bmap when it's available?  It'll
postpone the remote clear even further until page sent.  Logically it
should be more efficient, but it may depend on the size of unaligned
ramblocks that you're hitting indeed, as clear_bmap isn't PAGE_SIZE based
but it can be much bigger.  Some discussion around this would be nice on
how you chose the current solution.

> 
> Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
> ---
>  accel/tcg/cputlb.c       |  5 +++--
>  include/system/physmem.h |  3 ++-
>  migration/ram.c          | 17 ++++++++++++++++-
>  system/memory.c          |  2 +-
>  system/physmem.c         | 19 +++++++++++--------
>  5 files changed, 33 insertions(+), 13 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index fd1606c856..8a054cb545 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -857,8 +857,9 @@ void tlb_flush_page_bits_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
>  void tlb_protect_code(ram_addr_t ram_addr)
>  {
>      physical_memory_test_and_clear_dirty(ram_addr & TARGET_PAGE_MASK,
> -                                             TARGET_PAGE_SIZE,
> -                                             DIRTY_MEMORY_CODE);
> +                                         TARGET_PAGE_SIZE,
> +                                         DIRTY_MEMORY_CODE,
> +                                         true);
>  }
>  
>  /* update the TLB so that writes in physical page 'phys_addr' are no longer
> diff --git a/include/system/physmem.h b/include/system/physmem.h
> index 879f6eae38..8529f0510a 100644
> --- a/include/system/physmem.h
> +++ b/include/system/physmem.h
> @@ -41,7 +41,8 @@ void physical_memory_dirty_bits_cleared(ram_addr_t start, ram_addr_t length);
>  
>  bool physical_memory_test_and_clear_dirty(ram_addr_t start,
>                                            ram_addr_t length,
> -                                          unsigned client);
> +                                          unsigned client,
> +                                          bool clear_dirty);
>  
>  DirtyBitmapSnapshot *
>  physical_memory_snapshot_and_clear_dirty(MemoryRegion *mr, hwaddr offset,
> diff --git a/migration/ram.c b/migration/ram.c
> index 29f016cb25..329168d081 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -995,18 +995,33 @@ static uint64_t physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>          }
>      } else {
>          ram_addr_t offset = rb->offset;
> +        unsigned long end, start_page;
> +        uint64_t mr_offset, mr_size;
>  
>          for (addr = 0; addr < length; addr += TARGET_PAGE_SIZE) {
> +            /*
> +             * Here we don't expect so many clear_dirty, so we call
> +             * physical_memory_test_and_clear_dirty with clear_dirty
> +             * set to false. Later we'll do make an overall clear_dirty
> +             * outside the loop.
> +             */
>              if (physical_memory_test_and_clear_dirty(
>                          start + addr + offset,
>                          TARGET_PAGE_SIZE,
> -                        DIRTY_MEMORY_MIGRATION)) {
> +                        DIRTY_MEMORY_MIGRATION,
> +                        false)) {
>                  long k = (start + addr) >> TARGET_PAGE_BITS;
>                  if (!test_and_set_bit(k, dest)) {
>                      num_dirty++;
>                  }
>              }
>          }
> +        end = TARGET_PAGE_ALIGN(start + addr + offset + TARGET_PAGE_SIZE)
> +              >> TARGET_PAGE_BITS;
> +        start_page = (start + offset) >> TARGET_PAGE_BITS;
> +        mr_offset = (ram_addr_t)(start_page << TARGET_PAGE_BITS) - offset;
> +        mr_size = (end - start_page) << TARGET_PAGE_BITS;
> +        memory_region_clear_dirty_bitmap(rb->mr, mr_offset, mr_size);
>      }
>  
>      return num_dirty;
> diff --git a/system/memory.c b/system/memory.c
> index 8b84661ae3..7b81b84f30 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2424,7 +2424,7 @@ void memory_region_reset_dirty(MemoryRegion *mr, hwaddr addr,
>  {
>      assert(mr->ram_block);
>      physical_memory_test_and_clear_dirty(
> -        memory_region_get_ram_addr(mr) + addr, size, client);
> +        memory_region_get_ram_addr(mr) + addr, size, client, true);
>  }
>  
>  int memory_region_get_fd(MemoryRegion *mr)
> diff --git a/system/physmem.c b/system/physmem.c
> index c9869e4049..21b2db3884 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -1091,8 +1091,9 @@ void physical_memory_set_dirty_range(ram_addr_t start, ram_addr_t length,
>  
>  /* Note: start and end must be within the same ram block.  */
>  bool physical_memory_test_and_clear_dirty(ram_addr_t start,
> -                                              ram_addr_t length,
> -                                              unsigned client)
> +                                          ram_addr_t length,
> +                                          unsigned client,
> +                                          bool clear_dirty)
>  {
>      DirtyMemoryBlocks *blocks;
>      unsigned long end, page, start_page;
> @@ -1126,9 +1127,11 @@ bool physical_memory_test_and_clear_dirty(ram_addr_t start,
>              page += num;
>          }
>  
> -        mr_offset = (ram_addr_t)(start_page << TARGET_PAGE_BITS) - ramblock->offset;
> -        mr_size = (end - start_page) << TARGET_PAGE_BITS;
> -        memory_region_clear_dirty_bitmap(ramblock->mr, mr_offset, mr_size);
> +        if (clear_dirty) {
> +            mr_offset = (ram_addr_t)(start_page << TARGET_PAGE_BITS) - ramblock->offset;
> +            mr_size = (end - start_page) << TARGET_PAGE_BITS;
> +            memory_region_clear_dirty_bitmap(ramblock->mr, mr_offset, mr_size);
> +        }
>      }
>  
>      if (dirty) {
> @@ -1140,9 +1143,9 @@ bool physical_memory_test_and_clear_dirty(ram_addr_t start,
>  
>  static void physical_memory_clear_dirty_range(ram_addr_t addr, ram_addr_t length)
>  {
> -    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_MIGRATION);
> -    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_VGA);
> -    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_CODE);
> +    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_MIGRATION, true);
> +    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_VGA, true);
> +    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_CODE, true);
>  }
>  
>  DirtyBitmapSnapshot *physical_memory_snapshot_and_clear_dirty
> -- 
> 2.20.1
> 

-- 
Peter Xu


