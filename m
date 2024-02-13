Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A005EC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 10:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZqKC-0006uo-DU; Tue, 13 Feb 2024 05:47:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZqK7-0006uW-HD
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 05:47:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZqK3-0003ti-44
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 05:47:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707821249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UapJ6TtL0Cz4dI8OrI0QI98H/KeuS0V029tlnyR5C88=;
 b=XSKCK1TwasLsVYfORka8Af9Z7M+aTf9xM/0PtXwiPUoGGcOCghwQo+LAWdpaD6NK2cQagu
 BdA+5ZQrctk/4V7paTqKmOhsyj7ui6ALHnyLvSEFXax8FfFVPwb8ZLk2pu6WImVdgTD/GD
 duZEH6FZNzzgf9fb+vQHDTJqjaQOUGA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-r-I0MyeqPDK93Dw3_pAfwg-1; Tue, 13 Feb 2024 05:47:27 -0500
X-MC-Unique: r-I0MyeqPDK93Dw3_pAfwg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d0d408ec2eso39656961fa.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 02:47:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707821246; x=1708426046;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UapJ6TtL0Cz4dI8OrI0QI98H/KeuS0V029tlnyR5C88=;
 b=cObq78Ms7HVZvBjcYVCdo1TuR/wz2XbvYs9AxYQiInSaPowI8/XFaOzDNWN2R1ZkGc
 4o39qGwBZOzvw4qko0NFHVUDXcgmxWQw0mkGyXRxeVGxXUV1j+sKGphjtq9mJ0eugMyD
 JwFgXKAEu/zLa1v0dA6IcQMw/5M0t7X9lTkukhGceq8mxaqxSM2G45zLnOs5tBI/Xg3N
 ZthcWDgHA/lF3yTyluPgSJGY3BZpwcMs3oLcBWR6W9sTPZFe42rtFqFttMwjWoAleI5n
 Jx0IimVsGA123PV/s78VUZW38RIvf2302wpFFYPfmQW1cb2YPBJFEtdfmN5Lai5XHw0g
 7nmg==
X-Gm-Message-State: AOJu0YzojYFiGHvbXktY+2bHw4I/97qWpvuJv8PZvnnMHB6/Fu6gBCvG
 dtFt6uN4j+7+xjHtdIJQ8WsJ5CWDLfZ55U6YMpTJPQfwy+oJQpQgZg3XGLr3yKLseMLBHjwoXc3
 JJPP+kWtE/TZZ8diziDki7zp4GLIfqq6ZfKVeXf/oEqnyhLaZzXUq
X-Received: by 2002:a2e:9a82:0:b0:2d0:a6c5:61a8 with SMTP id
 p2-20020a2e9a82000000b002d0a6c561a8mr6363668lji.38.1707821246284; 
 Tue, 13 Feb 2024 02:47:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEL71fvw7IBnC6Zy4LZnuW+8cguMIA2pRnLbNQxGdrEprp37vVyfYByiVLZg/ipd+/U7nZMtQ==
X-Received: by 2002:a2e:9a82:0:b0:2d0:a6c5:61a8 with SMTP id
 p2-20020a2e9a82000000b002d0a6c561a8mr6363660lji.38.1707821245953; 
 Tue, 13 Feb 2024 02:47:25 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWwRLx9Oa4taH2mLfe8lRHZt4z7OeGVmrw2lRBH4beGo/+XX0Ge4dSIMWpU0GN1tkRaIA/maIJZH4Kmsqx2v+Jd4GPTPJXKhlXqESwO7EpYF9sXHIk7+gSmZg==
Received: from redhat.com ([2.52.146.238]) by smtp.gmail.com with ESMTPSA id
 em8-20020a056402364800b00561740859b3sm3352173edb.19.2024.02.13.02.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 02:47:25 -0800 (PST)
Date: Tue, 13 Feb 2024 05:47:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: qemu-devel@nongnu.org, vattunuru@marvell.com, jerinj@marvell.com
Subject: Re: [PATCH] virtio-pci: correctly set virtio pci queue mem multiplier
Message-ID: <20240213054513-mutt-send-email-mst@kernel.org>
References: <20240212075233.1507612-1-schalla@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212075233.1507612-1-schalla@marvell.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
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

On Mon, Feb 12, 2024 at 01:22:33PM +0530, Srujana Challa wrote:
> Currently, virtio_pci_queue_mem_mult function returns 4K when
> VIRTIO_PCI_FLAG_PAGE_PER_VQ is set. But this is not correct
> when host has page size as 64K.
> This patch fixes the same.
> 
> Signed-off-by: Srujana Challa <schalla@marvell.com>

You can't tweak guest visible values like this without
compat machinery. It's also going to consume a ton more
phys memory - can this break any configs?
Why is this a problem? Just with vdpa?

> ---
>  hw/virtio/virtio-pci.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index e433879542..028df99991 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -316,12 +316,10 @@ static bool virtio_pci_ioeventfd_enabled(DeviceState *d)
>      return (proxy->flags & VIRTIO_PCI_FLAG_USE_IOEVENTFD) != 0;
>  }
>  
> -#define QEMU_VIRTIO_PCI_QUEUE_MEM_MULT 0x1000
> -
>  static inline int virtio_pci_queue_mem_mult(struct VirtIOPCIProxy *proxy)
>  {
>      return (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ) ?
> -        QEMU_VIRTIO_PCI_QUEUE_MEM_MULT : 4;
> +        qemu_real_host_page_size()  : 4;
>  }
>  
>  static int virtio_pci_ioeventfd_assign(DeviceState *d, EventNotifier *notifier,
> -- 
> 2.25.1


