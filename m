Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34483C4829F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 17:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZweY-0001Hs-RA; Tue, 13 Feb 2024 12:33:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZweX-0001HQ-23
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 12:33:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZweU-0008Kk-Uo
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 12:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707845581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0LZl8D/Ou1vN/RSKYYVj9PvOh7MmXbKnVs5O/8OMRog=;
 b=OOCWnvs6FftiL2Aq7lU8+FwWo+wg44FdIKJLeAkbTv8FKDu65ZyfFRniahWrbdaRb81wYj
 gf/I9d7pp8iGXDSfzymPIkFRZ4I/4g1kCAnQz2QXcEwLCRHsOHTy0rmXniqoUTGvKZHE8W
 iVO4nt8GFrlEOp7dJ7g0U9rCkvj23go=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-l3hjPJrqMteiqvNseLInqA-1; Tue, 13 Feb 2024 12:32:58 -0500
X-MC-Unique: l3hjPJrqMteiqvNseLInqA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33b316fcaecso1734786f8f.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 09:32:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707845577; x=1708450377;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0LZl8D/Ou1vN/RSKYYVj9PvOh7MmXbKnVs5O/8OMRog=;
 b=YdcWZczQr77dnRm5O7HT2+ia2GR3Z2SS9mZp6NWGG2ZKguZowyazKahVwFfBvXbJHD
 /A6Jq3BxyKIg0PipScWYK7O70Nk+eAPwAq92cAJA1KJJqLvVRmzv7gujx5/2XW+y+pEK
 5XefTz6jick0ZQ9tScMpKXq0tq0cEueXTj2M/HnhiQGLsAnwQ3S5x4DFeXiPFdwc6FsG
 w6wzqlqTUSP0edKu75ddwiOGRsmD5mE1pPDYgGKT8tRIYJvRsHij/IfwhPaEhgAMx+Rz
 WBE3p+sMeoNzkBI93hVM0miMkec25FjDRlIGOJL8uknz65yHTPh4MjnnM9sCHwD0YKYB
 ZpTA==
X-Gm-Message-State: AOJu0YzbTPMpsjXuqrjFngNXK2cg5i3oUSpSV3FzvNzygWvxoSxsZfeB
 jbjuPBUuLBGXLQVB8sytwCUZ4H+JC0LRk6MN9kxupZbqMiB4kWt/i9zBk6kIGAWanpGPZzHTMwl
 qFEuZkDeO56qRlyDuq4twfY/q4b1qXW5sCvGXSgBrxrjBH8v1QdYs
X-Received: by 2002:a5d:6543:0:b0:33b:178a:6715 with SMTP id
 z3-20020a5d6543000000b0033b178a6715mr7185346wrv.24.1707845576857; 
 Tue, 13 Feb 2024 09:32:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGM7geOEeyI7luVrMfxU1nKdXIQhtwN5Qunl7rEbP9RecrC7imkdz6/g70UarL6/Pq5tPHEEA==
X-Received: by 2002:a5d:6543:0:b0:33b:178a:6715 with SMTP id
 z3-20020a5d6543000000b0033b178a6715mr7185330wrv.24.1707845576548; 
 Tue, 13 Feb 2024 09:32:56 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXVIRqp74AtWiACZLABnEs9knpsHmm3WbzvBKCkgHVrhIe5EYsU0kvRSF96F9Lx28M2OgP7laiMq7qS7Q+l/bjsdNB7beXpBwTYl79/pp+xazDFZHI8xzpCSflK5sqziJM8ugEqAy9H++YEKwZ/cwu1Ou9dl6OQVyrRfFbIB0a/ZkmLQ4T5xbWACngurmugEvwY33b2DRCFbYAJ8LM0Vg==
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 y12-20020a056000108c00b0033b40a3f92asm10112904wrw.25.2024.02.13.09.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 09:32:55 -0800 (PST)
Date: Tue, 13 Feb 2024 12:32:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [PATCH v1 01/15] libvhost-user: Fix msg_region->userspace_addr
 computation
Message-ID: <20240213123223-mutt-send-email-mst@kernel.org>
References: <20240202215332.118728-1-david@redhat.com>
 <20240202215332.118728-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202215332.118728-2-david@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Feb 02, 2024 at 10:53:18PM +0100, David Hildenbrand wrote:
> We barely had mmap_offset set in the past. With virtio-mem and
> dynamic-memslots that will change.
> 
> In vu_add_mem_reg() and vu_set_mem_table_exec_postcopy(), we are
> performing pointer arithmetics, which is wrong.

Wrong how? I suspect you mean arithmetic on void * pointers is not portable?

> Let's simply
> use dev_region->mmap_addr instead of "void *mmap_addr".
> 
> Fixes: ec94c8e621de ("Support adding individual regions in libvhost-user")
> Fixes: 9bb38019942c ("vhost+postcopy: Send address back to qemu")
> Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  subprojects/libvhost-user/libvhost-user.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
> index a3b158c671..7e515ed15d 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -800,8 +800,8 @@ vu_add_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
>           * Return the address to QEMU so that it can translate the ufd
>           * fault addresses back.
>           */
> -        msg_region->userspace_addr = (uintptr_t)(mmap_addr +
> -                                                 dev_region->mmap_offset);
> +        msg_region->userspace_addr = dev_region->mmap_addr +
> +                                     dev_region->mmap_offset;
>  
>          /* Send the message back to qemu with the addresses filled in. */
>          vmsg->fd_num = 0;
> @@ -969,8 +969,8 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
>          /* Return the address to QEMU so that it can translate the ufd
>           * fault addresses back.
>           */
> -        msg_region->userspace_addr = (uintptr_t)(mmap_addr +
> -                                                 dev_region->mmap_offset);
> +        msg_region->userspace_addr = dev_region->mmap_addr +
> +                                     dev_region->mmap_offset;
>          close(vmsg->fds[i]);
>      }
>  
> -- 
> 2.43.0


