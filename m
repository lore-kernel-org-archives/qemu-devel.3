Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CC6606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JCuz3yl9;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Drq30/8K
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWIXl-0004jj-TP; Wed, 25 Nov 2026 14:20:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWIXU-0004Is-J5
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:20:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWIXM-0004ai-UO
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:20:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795634409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VphzlssZHqecN7zpx0ZrsWbx3uvGMQFlKeZHHLbs+wo=;
 b=JCuz3yl9rgIbJNTisLD1dxzsc4RU+OM3ZiPLMGwibSIP21CS1ayh/IuKvi8fSx0rPo+SgZ
 bSaAiXd/h6E+Bs30QqfD8EKks5g3ooQGmTb6ULrg1E5JBgw1hbOM7ntrE7PWUdefL75L6a
 zrA8Mwgl6FaGv0kfj8ad0iXSrGGWpaI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-fbT4YT23NLmiWzIZCnataw-1; Wed, 25 Nov 2026 19:20:08 +0000
X-MC-Unique: fbT4YT23NLmiWzIZCnataw-1
X-Mimecast-MFC-AGG-ID: fbT4YT23NLmiWzIZCnataw_1795634407
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5383d650f2dso108406871cf.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 11:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795634407; x=1796239207; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VphzlssZHqecN7zpx0ZrsWbx3uvGMQFlKeZHHLbs+wo=;
 b=Drq30/8KNAg9U80OktbqMFxCtsIrAgvqw2sbw5N8TcjYB33s7hKkioSAstnlHGOQMC
 nz/Tv9zM+t4WG76muxEOk2gi5HU+c4FNjqbK196hmlCtVHysXgxSP8+xkWNioKnbxxWk
 BUpHn9y3gOCljoaMx5TzGnp8nJzRj7NnaYrIZb8ydpC8JSDKID+nvlDMMNFS9MEQYhfW
 feLvNGJmUBeyi8ETuqqAha0hhGAwBX9e9AL0YazUYPXWm+B/YMUh+rz7K5iGRb1D6G1x
 czGTA3nu+Uiqb3A2Fpbya8ffbz5pLV38pfC88dbeLsaOAIQJxQldXaRHM179h/bm6tUL
 Z3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795634407; x=1796239207;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VphzlssZHqecN7zpx0ZrsWbx3uvGMQFlKeZHHLbs+wo=;
 b=j6XUS48SZR+C2x+XPSsfRaXdnlNWuHkpVmByGSrwf88GWdxwmqI28WnQrYdeBJ6tTJ
 z+A87wZYAAFL9QSnGRkTJW8Fuf5k+tjYO+C030+d+khzMln8LseU6RiWfwrwFOrluMsM
 qgoE17HvO+p7l4IzwGm/6TJ8ZDCUGk28OOhGCsQQ4bs4p9jOtJM23cVtlVfBbuM6Q73c
 G8PIITzxy/14yfGHJPbS40k3mHBJN9gxZ8IoaSAfhdNvZty9M6GfanqKcm7fGepX6ZoI
 xlp9zwvAs/7nlsgsBf2C1vFwVcU69K6xTiib5TYO+D0Wkyd1EWAzLeArgAeqzyUYlUpg
 r53Q==
X-Gm-Message-State: APuU4Z9fY0lZKAJeNMW907XUUxiHjEM2WJCd/xZuco0D+Gb3vIe96tnj
 K5NgZng5Wjh4w9t+RTQjky7alAwxp/lFW0RY/m1Hx9FJFa9QeXBiAzI4mMVsOuwUGsb60+BKpgY
 usBCPgUF+8UKGbwI6hIKxYit2D0mmbxCAQk/vybkxhjEhqLlBhoQ/Whqa
X-Gm-Gg: AZFdTZdbUIHKG6k2IYUhbB4u2dqeJdD0wNDGQDU8t2nRGg11etSRkzOz5ON6voAh0Y+
 Pfot0H5+0ejXtpDfQmT3KePV7L0FTjIAeQq/Y3ZA6vVglfMdgFg426G0ZpvasE6iY/ngB6w4h74
 toI69aZ0q+giAPfwqkgAn9MlHlSyZ6+0hDtAF9mS3WJkzuDpyOxwDBzvMWwwB1qq0nHvlNISV1w
 xH2ZTOhfY/2jsFn+pMysYlg4HPlxBpWxt/qMvGtGsX+55CqQ5UfhqFtoBCX7gwLSm+YeIyz7QNq
 iIQQgSH/InqSrlBWKpgv1rLSK5HDWQiSE/ITjG+MADPhTucMTpbXtGJVUfzTx1Xz5NJddSaINzg
 WlwKo/PTL2+4NXiRpxcmJS6q+8KlmyqGM5WKe390/R1FH
X-Received: by 2002:a05:622a:60e:b0:55d:2d38:b08 with SMTP id
 d75a77b69052e-55d76a0f880mr338482271cf.29.1795634406982; 
 Wed, 25 Nov 2026 11:20:06 -0800 (PST)
X-Received: by 2002:a05:622a:60e:b0:55d:2d38:b08 with SMTP id
 d75a77b69052e-55d76a0f880mr338481461cf.29.1795634406354; 
 Wed, 25 Nov 2026 11:20:06 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d78451407sm164209251cf.2.2026.11.25.11.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 11:20:05 -0800 (PST)
Date: Wed, 25 Nov 2026 14:20:04 -0500
From: Peter Xu <peterx@redhat.com>
To: Murat Seker <muratseker@meta.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, philmd@oss.qualcomm.com
Subject: Re: [PATCH] system/physmem: Find RAM block offsets using binary search
Message-ID: <awc05Irn1HRAqo-q@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261102030325.2901097-1-muratseker@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261102030325.2901097-1-muratseker@meta.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 01, 2026 at 07:03:25PM -0800, Murat Seker wrote:
> find_ram_offset() scans all existing blocks for each candidate offset.
> This costs O(N^2) per allocation and O(N^3) when adding N blocks.
> 
> Sort the existing block offsets once per call and use binary search to
> find the closest following block. This reduces the cost to O(N log N)
> per allocation and O(N^2 log N) for adding N blocks. The chosen offsets
> remain unchanged.

This looks reasonable, do you have an existing use case you want to share
on the N you tested and how it improves?

> 
> Signed-off-by: Murat Seker <muratseker@meta.com>
> ---
>  system/physmem.c | 36 ++++++++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index a7300bb9d9..072c28bb17 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -1780,14 +1780,24 @@ static void *file_ram_alloc(RAMBlock *block,
>  }
>  #endif
>  
> +static int ram_offset_cmp(const void *a, const void *b)
> +{
> +    ram_addr_t x = *(const ram_addr_t *)a;
> +    ram_addr_t y = *(const ram_addr_t *)b;
> +
> +    return x < y ? -1 : x > y;
> +}
> +
>  /* Allocate space within the ram_addr_t space that governs the
>   * dirty bitmaps.
>   * Called with the ramlist lock held.
>   */
>  static ram_addr_t find_ram_offset(ram_addr_t size)
>  {
> -    RAMBlock *block, *next_block;
> +    RAMBlock *block;
>      ram_addr_t offset = RAM_ADDR_MAX, mingap = RAM_ADDR_MAX;
> +    g_autofree ram_addr_t *offsets = NULL;
> +    size_t num_blocks = 0;
>  
>      assert(size != 0); /* it would hand out same offset multiple times */
>  
> @@ -1795,8 +1805,19 @@ static ram_addr_t find_ram_offset(ram_addr_t size)
>          return 0;
>      }
>  
> +    RAMBLOCK_FOREACH(block) {
> +        num_blocks++;

Should be cheap to just keep a counter for n_ramblocks.

> +    }
> +    offsets = g_new(ram_addr_t, num_blocks);
> +    num_blocks = 0;
> +    RAMBLOCK_FOREACH(block) {
> +        offsets[num_blocks++] = block->offset;
> +    }
> +    qsort(offsets, num_blocks, sizeof(*offsets), ram_offset_cmp);

So this also reminded me of why we sorted the current list with size.

It is like that since Paolo's commit in 2012:

commit abb26d63e7e4492d306c13b7e0e799d4c11a067c
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed Nov 14 16:00:51 2012 +0100

    exec: sort the memory from biggest to smallest

Before that we sort with idstr, which seems to be less good.

But then now my question is do we still need to sort by size at all?  It
may be useful in the past if we need frequent lookup of ramblock, hopping
the larger sized ramblock is more likely to be accessed, but now we have
mru_block introduced, so I'm not sure how important is that.

Because if with it sorted with offset, and if we do not need best-fit but
instead using first-fit (may matter on dirty bitmap, but I'm also not sure
how much it matters.. we don't do adhoc alloc of ramblocks anyway), then
IIUC we can do O(N) easily in the stupid way.

What do you think?  Not sure if Paolo wants to comment too.

Thanks,

> +
>      RAMBLOCK_FOREACH(block) {
>          ram_addr_t candidate, next = RAM_ADDR_MAX;
> +        size_t lo = 0, hi = num_blocks;
>  
>          /* Align blocks to start on a 'long' in the bitmap
>           * which makes the bitmap sync'ing take the fast path.
> @@ -1807,11 +1828,18 @@ static ram_addr_t find_ram_offset(ram_addr_t size)
>          /* Search for the closest following block
>           * and find the gap.
>           */
> -        RAMBLOCK_FOREACH(next_block) {
> -            if (next_block->offset >= candidate) {
> -                next = MIN(next, next_block->offset);
> +        while (lo < hi) {
> +            size_t mid = lo + (hi - lo) / 2;
> +
> +            if (offsets[mid] < candidate) {
> +                lo = mid + 1;
> +            } else {
> +                hi = mid;
>              }
>          }
> +        if (lo < num_blocks) {
> +            next = offsets[lo];
> +        }
>  
>          /* If it fits remember our place and remember the size
>           * of gap, but keep going so that we might find a smaller
> -- 
> 2.53.0-Meta
> 

-- 
Peter Xu


