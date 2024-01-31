Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B59C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 17:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVEg4-00045M-NK; Wed, 31 Jan 2024 12:47:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rVEfy-00044r-Up
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 12:47:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rVEfw-0007xc-PM
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 12:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706723223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ILYztaESA9bZT1/pY1CVEJY9y26xbOdFAKe9DFiOR9A=;
 b=gOSyyaBG0yo8Ybrq3WoRmVSGSiLZoCYvuTGI8YpX4H/60zfdQwrBh1RGgjvwJhTaDfDEwT
 22/r3neWITULpq/adpsyj1Xbr7IIVFlEM3pZa6zvV6SzDqqwuCiJAWGovlmdfjoZc3YRYR
 18bwHjqjAvlkI8H5o5JOYFLjUSLhf6U=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-KXt_Lr9gN2i4CyO3Ercr_g-1; Wed, 31 Jan 2024 12:45:29 -0500
X-MC-Unique: KXt_Lr9gN2i4CyO3Ercr_g-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-55f63fd55ffso557a12.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 09:45:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706723128; x=1707327928;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ILYztaESA9bZT1/pY1CVEJY9y26xbOdFAKe9DFiOR9A=;
 b=jKoYpNTJMt37Hhw+Jn/OF7EL4qgFV92yhtljEXoGivQQ87V5ysCPVhtt2SKjb8ncDl
 nRtHjdnjKbhXZx0tmQr5XM0XPytEPtFSxJVclKInyVS09q4Etq1tqilV/bAI2gI7+2Pk
 zEMHUpcK9V9qaf/MLz8n7VPX470AxgopQU3+HxyVVdimLQrgdSHKgTfYNjYy3su7b1gB
 xXaDbEdxuugK3jRcv7PX2DPurQhHM+35aKndoCQmXKtYmOzyHWc439+qIn+JKW7+U5X/
 Isdxu9bkcMpI+HyeutB+mj9K8c9kKoT09zCAOQTd3rfhziCQ7jtpijxn9XzUIWjoLC/M
 YEYw==
X-Gm-Message-State: AOJu0YxbxKzmk6PiyQKNKJ9GcfFdfW3qmO2Eg8cpBuTuh1bSzJvymeRx
 0MoCPS2RnaGIedBvu3Pi91ZVxVaaFot7jY9xLKp1TGYtYSYFMNx8cUWj2e+Oxq/1abMwNcxZxnj
 mRQAnHGXGNpUyW/yTR8pEU3xBudBjw8nahyywfDMTi+ul3X9yoMAH
X-Received: by 2002:aa7:c457:0:b0:55e:ed79:6ff1 with SMTP id
 n23-20020aa7c457000000b0055eed796ff1mr1691637edr.20.1706723128818; 
 Wed, 31 Jan 2024 09:45:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkug1/EqJ3+Ez1Ny0yrbNBi6CzZEhqyAP1w7WAIondAhkdR/FrQD4O4Zbb6OrB/xY8DdXT9g==
X-Received: by 2002:aa7:c457:0:b0:55e:ed79:6ff1 with SMTP id
 n23-20020aa7c457000000b0055eed796ff1mr1691623edr.20.1706723128466; 
 Wed, 31 Jan 2024 09:45:28 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXIm0aYisu2dgm5OXJqIbVzGJKnKY+TUS/Wd1uiszjckS1SD00JOdKww/nmhhQdBNSluipvmBQBXrLG3dJTlxxUf5onWFeiiI+C7Ae1GxYSNqWy7KrpBOCn1VA=
Received: from sgarzare-redhat (host-82-53-134-47.retail.telecomitalia.it.
 [82.53.134.47]) by smtp.gmail.com with ESMTPSA id
 k7-20020aa7c047000000b0055f3edfc3desm1843004edo.20.2024.01.31.09.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 09:45:28 -0800 (PST)
Date: Wed, 31 Jan 2024 18:45:26 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] blkio: Respect memory-alignment for bounce buffer
 allocations
Message-ID: <gyzwcv5zfvxr5hjo33kdspotoog4zchcinxufhabms3slf3c3q@blvlgunraoti>
References: <20240131173140.42398-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240131173140.42398-1-kwolf@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
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

On Wed, Jan 31, 2024 at 06:31:40PM +0100, Kevin Wolf wrote:
>blkio_alloc_mem_region() requires that the requested buffer size is a
>multiple of the memory-alignment property. If it isn't, the allocation
>fails with a return value of -EINVAL.
>
>Fix the call in blkio_resize_bounce_pool() to make sure the requested
>size is properly aligned.
>
>I observed this problem with vhost-vdpa, which requires page aligned
>memory. As the virtio-blk device behind it still had 512 byte blocks, we
>got bs->bl.request_alignment = 512, but actually any request that needed
>a bounce buffer and was not aligned to 4k would fail without this fix.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>---
> block/blkio.c | 3 +++
> 1 file changed, 3 insertions(+)

Thanks for fixinig this!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/block/blkio.c b/block/blkio.c
>index 0a0a6c0f5f..b989617608 100644
>--- a/block/blkio.c
>+++ b/block/blkio.c
>@@ -89,6 +89,9 @@ static int blkio_resize_bounce_pool(BDRVBlkioState *s, int64_t bytes)
>     /* Pad size to reduce frequency of resize calls */
>     bytes += 128 * 1024;
>
>+    /* Align the pool size to avoid blkio_alloc_mem_region() failure */
>+    bytes = QEMU_ALIGN_UP(bytes, s->mem_region_alignment);
>+
>     WITH_QEMU_LOCK_GUARD(&s->blkio_lock) {
>         int ret;
>
>-- 
>2.43.0
>


