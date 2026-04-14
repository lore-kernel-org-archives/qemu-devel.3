Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC6CF9D0E7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 16:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCgpx-0003u8-U2; Tue, 14 Apr 2026 12:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wCgpv-0003u0-OY
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 12:42:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wCgpt-0003gI-PM
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 12:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776184920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f/rNg2G8LVLSGObtFJQYT5FoGLMARNFUzEUSGrzAYQA=;
 b=SFKmp709eO/1f29bdZ22LvNiLgWZ2QB44Yt24Eapq1NZKbBmGhuvLq3uddbR1YuX/moxux
 Wpl3o8ZTZbr1hXknashdfhxlZhBzKpDg7Z8HQiAQNjp9HH8XvOuKSxoetSOkkuwqDAYrRN
 KEXR+U7iBe0p7Td9FyvLZbhXCDSgKhE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-wCp-__XxOb-IZaa0NgPyOA-1; Tue, 14 Apr 2026 12:41:59 -0400
X-MC-Unique: wCp-__XxOb-IZaa0NgPyOA-1
X-Mimecast-MFC-AGG-ID: wCp-__XxOb-IZaa0NgPyOA_1776184918
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8a1accb970fso153583076d6.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 09:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776184918; x=1776789718; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=f/rNg2G8LVLSGObtFJQYT5FoGLMARNFUzEUSGrzAYQA=;
 b=fm5m/3bts1s2QI3g79UklbRFV5/rTwxn8afj9/1LBjP4KNCu4ruz8/ah/UebS5I6hf
 Ns7I4Hm2MzsOrdSjiciCOqGGoCo1R3esZaWwf/ysGxtHzyEri2KCubB8HEW+trqPp0fv
 kuhwBXrVlgtgmKEjLUeR+JFWDkWOf2Z/OZaaSy8sk7yPicNkHsTGomlXOsdf03ErJn6H
 QwTE6Ysz4rv7HX2f1ECnuD5RqkPUqADCsWmIilClmHV3FzyNryJnbIK9s2KIs5hqJ7YT
 Szwl7X0J0209T32IzK/BeazuVWwSkqUtMyxF2y3jOwTqu8lV+SKrZAAWuaV6fRwmlyi8
 oyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776184918; x=1776789718;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f/rNg2G8LVLSGObtFJQYT5FoGLMARNFUzEUSGrzAYQA=;
 b=itRTr40IopxnUVo8m2WeX2Ck1YVhSvCK102eIwAiWSh9NfQ72WPr09xAr6uOnyFG/D
 LHhkUMbWN/0RKjEfEkx1hmomtzzOt3ZfUX3VKzpRKPuGFQMkOp8FpZik0qs7NMIm7Uvm
 x20PeUlyxwmKyBZMj9UC5+oZqJ2w2RDRA8APHBAFlknrYTfFJ28xsDKgzQ8r5V3z9duy
 5WRQ+O4Qmra42RPdaTMKGK7wYTp86GQJBiRDyerQy99GwtLYTzSDSd+Fz0GnlnSn1ATB
 SHikjCEuFPhWNXY9Jevr8vXfQmZvcvWne1I1WnP8R7G2i/oWXS6wUZOJWVS99+W3hu6g
 /tXw==
X-Gm-Message-State: AOJu0Yw06GPD1PFVPtpHvMutG7rin/K/kaUotQ4LE4e0Pqh50mtPJH1Q
 PpPhE2xtCJmjRxV1b1W1pMb7Ill1aYuq+Bpjs1OOk1Umo0rOrHizgsw20ZHgkDBam1TEu+P+1NE
 flS8CxP+r1CGfKNhUASXF7nMKXaw+SS+/G3ZCiD7GVvt7WXlhn/JmG9Y1
X-Gm-Gg: AeBDietqz7WtyCO4/r+NRfn94Ibx1PWaV6z3ntKxeYuszi0cPJ50A4A71sMbv6ZM7GO
 tvGdWy9O250mxGSkhJFwIuyF7p+j5x1iZvVC2yS4GUlCBk05cPqqPUNnWeuvvzpObeX8ICH4dQF
 YBrLV6sVzxK8SBi3XZfDnu3g0C58yjCPmRcYXE97dnOcFrKsVx5ycZjLqQYpFoxsz0vLjfYIafw
 JoB02GmBxCD6EoPnq6DKijkxfkH8mvqpwQB6Ngrc2GbM5hN5olyMQ9oWxvP6cQ/NHZ1Mw9hN+HT
 Ps/MAJ2Bs603xbPeaQ3Phx9G1ZDVAIbqEvFwUL0xYVRumkg1gaqND1TgngFHypaDU4qK8FViqSV
 BaqKuPKmfKM3taRdkBRxtJ4vQHXc1XNvP4g/tHG8q70CeRfRPeMECx/aBEg==
X-Received: by 2002:a05:6214:1bca:b0:8ac:b2e8:8681 with SMTP id
 6a1803df08f44-8acb2e8905fmr119564156d6.5.1776184917880; 
 Tue, 14 Apr 2026 09:41:57 -0700 (PDT)
X-Received: by 2002:a05:6214:1bca:b0:8ac:b2e8:8681 with SMTP id
 6a1803df08f44-8acb2e8905fmr119563526d6.5.1776184917321; 
 Tue, 14 Apr 2026 09:41:57 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84a47a0dsm125927756d6.22.2026.04.14.09.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 09:41:56 -0700 (PDT)
Date: Tue, 14 Apr 2026 12:41:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Trieu Huynh <vikingtc4@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Li Zhijian <lizhijian@fujitsu.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH] migration/ram: avoid page population in ram_handle_zero
 via madvise
Message-ID: <ad5uUqgY1IDvq37g@x1.local>
References: <20260328130110.166469-1-vikingtc4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260328130110.166469-1-vikingtc4@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Sat, Mar 28, 2026 at 10:01:10PM +0900, Trieu Huynh wrote:
> When the destination receives a zero page during precopy migration,
> ram_handle_zero() calls buffer_is_zero() which reads the page. For
> anonymous mmap this is benign (reads map to the shared zero page), but
> for memory-backend-memfd (mmap(MAP_SHARED) of a memfd) even a read
> commits a physical page in the tmpfs page cache.
> 
> As a result, after migration all zero pages of the guest are committed
> on the destination, turning a sparse RSS into a fully-populated one
> (see GitLab issue #2839: a 256 GB VM went from ~4 GB RSS before
> migration to ~256 GB after).
> 
> Add a bool can_discard parameter and call madvise(MADV_DONTNEED) when
> it is true. This releases tmpfs/anonymous pages back to the kernel's
> zero-page pool without reading the mapping at all. The madvise is
> issued before any read or write, preventing the initial page fault
> entirely.

Trieu,

Thanks again for the patch.

> 
> Callers pass can_discard = !(block->flags & RAM_PREALLOC) so that

I wonder if this will be enough.  E.g. see ram_block_discard_range() where
it special cased RAM_READONLY_FD.

> backends with prealloc=on are unaffected: deliberately pre-faulted pages
> must not be discarded. On the destination side vCPUs are paused
> (RUN_STATE_INMIGRATE) while precopy pages are loaded, so madvise is
> race-free.
> 
> After migration for VM with 4GB RAM, the RSS on destination was reduced
> to 247 MB (vs 4148 MB before change), measured via VmRSS in
> /proc/$PID/status.
> 
> Relates-to: https://wiki.qemu.org/ToDo/LiveMigration#Avoid_page_population_when_page_is_not_populated
> See-also: https://gitlab.com/qemu-project/qemu/-/issues/2839

Please always loop in people that were involved in the discussions.  I'm
adding Dan here.

> 
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> ---
>  migration/ram.c  | 16 +++++++++++++---
>  migration/ram.h  |  2 +-
>  migration/rdma.c |  9 ++++++++-
>  3 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 2a7e958e87..e57613e29d 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3638,9 +3638,13 @@ static inline void *colo_cache_from_block_offset(RAMBlock *block,
>   *
>   * @host: host address for the zero page
>   * @size: size of the zero page
> + * @can_discard: check whether RAMBlock was created with prealloc=on

This is fine, but let's avoid mentioning "prealloc=on" details.  It may not
always be the case. As a helper function, we should normally describe what
it implies when can_discard is set, not when it will be set.

>   */
> -void ram_handle_zero(void *host, uint64_t size)
> +void ram_handle_zero(void *host, uint64_t size, bool can_discard)
>  {
> +    if (can_discard && qemu_madvise(host, size, QEMU_MADV_DONTNEED) == 0) {

I also don't know if DONTNEED will always work as expected.  E.g. when
there're shared mappings and if the same page/folio is mapped elsewhere,
DONTNEED may not be enough.  Again, see ram_block_discard_range() on the
cases where ramblock is shared, or fd>0.

I wonder if we should just pass in ramblock itself as parameter with offset
to zero..  then we can do all the checks here and directly invoke
ram_block_discard_range() when it's applicable.

> +        return;
> +    }
>      if (!buffer_is_zero(host, size)) {
>          memset(host, 0, size);
>      }
> @@ -4086,7 +4090,7 @@ static bool handle_zero_mapped_ram(RAMBlock *block, unsigned long from_bit_idx,
>                     block->idstr);
>          return false;
>      }
> -    ram_handle_zero(host, size);
> +    ram_handle_zero(host, size, !(block->flags & RAM_PREALLOC));
>  
>      return true;
>  }
> @@ -4421,7 +4425,13 @@ static int ram_load_precopy(QEMUFile *f)
>                  ret = -EINVAL;
>                  break;
>              }
> -            ram_handle_zero(host, TARGET_PAGE_SIZE);
> +            {
> +                ram_addr_t ram_offset;
> +                RAMBlock *rb = qemu_ram_block_from_host(host, false,
> +                                                        &ram_offset);
> +                bool can_discard = rb && !(rb->flags & RAM_PREALLOC);

IMHO there's no need to redo the lookup, we can extend the lifespan of the
"block" variable right above when calculating the host address.

> +                ram_handle_zero(host, TARGET_PAGE_SIZE, can_discard);
> +            }
>              break;
>  
>          case RAM_SAVE_FLAG_PAGE:
> diff --git a/migration/ram.h b/migration/ram.h
> index 41697a7599..faa80f27d1 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -90,7 +90,7 @@ int ram_discard_range(const char *block_name, uint64_t start, size_t length);
>  int ram_postcopy_incoming_init(MigrationIncomingState *mis, Error **errp);
>  int ram_load_postcopy(QEMUFile *f, int channel);
>  
> -void ram_handle_zero(void *host, uint64_t size);
> +void ram_handle_zero(void *host, uint64_t size, bool can_discard);
>  
>  void ram_transferred_add(uint64_t bytes);
>  void ram_release_page(const char *rbname, uint64_t offset);
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 55ab85650a..d4c36af5b9 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -28,6 +28,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
>  #include "qemu/module.h"
> +#include "system/ramblock.h"
>  #include "qemu/rcu.h"
>  #include "qemu/sockets.h"
>  #include "qemu/bitmap.h"
> @@ -3413,7 +3414,13 @@ int rdma_registration_handle(QEMUFile *f)
>                               comp->value);
>                  goto err;
>              }
> -            ram_handle_zero(host_addr, comp->length);
> +            {
> +                ram_addr_t ram_offset;
> +                RAMBlock *rb = qemu_ram_block_from_host(host_addr, false,
> +                                                        &ram_offset);

Similar here, a slight difference is RDMA manages ramblocks with its own
internal data structure, so I wonder if we want to simply cache the block
pointer somewhere in qemu_rdma_init_one_block() if we want to make
ram_handle_zero() take the ramblock ptr directly.

The other thing is I'm not yet sure if you have tested this code.  Please
keep that in mind whatever patches one posted need to be properly tested.
It's definitely not good to send whatever not tested for merging.  Here,
this changes RDMA code path.  You can have a look at our RDMA unit tests,
but you'll also need to setup it.  There's a helper you can use, see
scripts/rdma-migration-helper.sh.

> +                bool can_discard = rb && !(rb->flags & RAM_PREALLOC);
> +                ram_handle_zero(host_addr, comp->length, can_discard);
> +            }
>              break;
>  
>          case RDMA_CONTROL_REGISTER_FINISHED:
> -- 
> 2.43.0
> 

-- 
Peter Xu


