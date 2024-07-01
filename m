Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68F5C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 20:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sONQ8-0003Bi-Iw; Mon, 01 Jul 2024 16:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sONQ5-0003BR-Uy
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 16:14:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sONQ4-0001Ae-Az
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 16:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719864875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lOvFdcz7K52N6SM7IUW/pf2PVkY0VVtHQdaVBHVrw18=;
 b=R3SL9KWCmzVSdI43ZLdSJBVVjs5y9NvMQ7nVqew6FYj6X/d29sfwSlNy71sE7ff1MYtg8V
 uwGhW9Ohjh/1yWVKI4aYO4fu/mNr1qGOlJZkhYjUNirrzOeh7bv7LRbpJzAXEsu/GaS6gQ
 N6kp3/zmha0cvE/NJiqdrLKuqB1tOwo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-ohyjGHoSOXG6ibbGT4bIjg-1; Mon, 01 Jul 2024 16:14:31 -0400
X-MC-Unique: ohyjGHoSOXG6ibbGT4bIjg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-36743ab5fb3so2210521f8f.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 13:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719864870; x=1720469670;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lOvFdcz7K52N6SM7IUW/pf2PVkY0VVtHQdaVBHVrw18=;
 b=CZ/MInPBdhKbWnrsAPwJ+l5HGT8I8Xhq+iWH7c7GIrSht+NQCXMzw8VRQqHM3+XcwL
 EFyrx9MkwAMiMfXC6ogfNYLTus0A8C2oNGTvLkHFBKPkTk8i4kppf/Qa0p7Z0kqc46uT
 5ZtVHK3bJaQ9BmkEBfbfA8WEgObxPiwlWaikwVlncQYqfwWbou4RZDVu6yxoMggcNyXl
 O81N+aEWC25bjyWFflwM7x/4DvLRGyDl9C9F/9mVSj+ZFoU2j/+fa1w8NXDY1yQ4XtQK
 8CU3i6PNE4tlCPvCxoMPtqHbIki0/wqY8RXzjQJ1w6hfmiYjCG+VdmZg/w6eSy2gNK/1
 JbCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAlfOiotcpsM5CUJRaIHZ8heYfOjhhoMXof8jH+VgijF2jQ4fVpiYoo4HB0lIqrY9ozUM8dUxCqEhRJRUVMupwmh+P/S0=
X-Gm-Message-State: AOJu0YzAfWSW7V8UHP+bYYwdbYi8w0thEXA1IpxR5qE8iAnLapreJPkn
 NzIJhM6bDOkixjY7S9/AugMFAs169qpLTuKW0xOMbd508EDu2X0pme3SwnFOCtRXfb5ra7C89Fb
 RT15VMn00j3zSnIphCX/syov2zPjmZ8dWdFI1j25NdeGXK/V0GcgsrsgjhNVf
X-Received: by 2002:a5d:554b:0:b0:362:e874:54e8 with SMTP id
 ffacd0b85a97d-36760ab6165mr7808191f8f.30.1719864869749; 
 Mon, 01 Jul 2024 13:14:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUx3AqI/TY5MwKB64a6GOsGKmsZNNu2CoWIWxgOwo3i8gmzx0mvqEyh5yZicvjw8bfviv43Q==
X-Received: by 2002:a5d:554b:0:b0:362:e874:54e8 with SMTP id
 ffacd0b85a97d-36760ab6165mr7808183f8f.30.1719864869194; 
 Mon, 01 Jul 2024 13:14:29 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b097fd4sm166665475e9.29.2024.07.01.13.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 13:14:28 -0700 (PDT)
Date: Mon, 1 Jul 2024 16:14:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dmitry Frolov <frolov@swemel.ru>
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3] hw/net/virtio-net.c: fix crash in iov_copy()
Message-ID: <20240701161404-mutt-send-email-mst@kernel.org>
References: <20240613143529.602591-2-frolov@swemel.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613143529.602591-2-frolov@swemel.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 13, 2024 at 05:35:30PM +0300, Dmitry Frolov wrote:
> A crash found while fuzzing device virtio-net-socket-check-used.
> Assertion "offset == 0" in iov_copy() fails if less than guest_hdr_len bytes
> were transmited.
> 
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Jason, are you merging this?

> ---
> v1: https://patchew.org/QEMU/20240527133140.218300-2-frolov@swemel.ru/
> v2: broken
> v3: goto instead of repeating code
> ---
>  hw/net/virtio-net.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 9c7e85caea..8f30972708 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2735,6 +2735,10 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
>           */
>          assert(n->host_hdr_len <= n->guest_hdr_len);
>          if (n->host_hdr_len != n->guest_hdr_len) {
> +            if (iov_size(out_sg, out_num) < n->guest_hdr_len) {
> +                virtio_error(vdev, "virtio-net header is invalid");
> +                goto detach;
> +            }
>              unsigned sg_num = iov_copy(sg, ARRAY_SIZE(sg),
>                                         out_sg, out_num,
>                                         0, n->host_hdr_len);
> -- 
> 2.43.0


