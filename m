Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ACA606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 11:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=coCtCtf1;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KOSTohQw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMOXN-0003Ly-LA; Thu, 29 Oct 2026 07:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xMOXL-0003LS-I6
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 07:43:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xMOXJ-0004ks-Ff
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 07:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793274191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dRf9//xhKjO2LpE4rxRS6+7WnZ7O7e8nA9mecYUpUds=;
 b=coCtCtf14pETzm4YXcG/LlKtueJs2en16RjWoTJgcFL6K31POAzUac3Je8JcoFKb4XGnwB
 fGJXQRBl2OuY+CFZFJCNEXK/CBLxULwwgyhPFDuLgVRC8cXdYk/iOGUKt/hLAHQGW7SUMJ
 FnAZhDDHKzIFCfjgwIhNl4OwiJXw2kw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-PJDj6GSbPRqwpj6H1jU7wA-1; Thu, 29 Oct 2026 07:43:10 -0400
X-MC-Unique: PJDj6GSbPRqwpj6H1jU7wA-1
X-Mimecast-MFC-AGG-ID: PJDj6GSbPRqwpj6H1jU7wA_1793274189
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a16dc2323cso18416935e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 04:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793274189; x=1793878989; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dRf9//xhKjO2LpE4rxRS6+7WnZ7O7e8nA9mecYUpUds=;
 b=KOSTohQwIybXHb44bYL+UKOFKU21aIZNT+NItC4bSifVwbCSDBIRq+9nQBFM/iBLWq
 YHnCL76rJt95OhKCFvWGvykE34zyqyXdfqzoOOKpkRmaJn6Bldhouz6FojAYlOyhY4gv
 XpFVCSgr2WKTdLA/U5FCZIWHsqJKRQ/25O0EcjpH9Z3I6BY3lPfl6aGfwv9Wyn/TK/VA
 jV2wVRtE9AGnlGbO6/IbiCClXxS9X2FQtqPFndkkiTUaE2O7GeWquhe3UTLa/V5vQFmP
 DCEkqUG2c/Nx2yC/vWNT1G/NFUM9wSh91Uwb0hIHe9Jiwqt6CDkVJWOA7BGynhuQWw8F
 a/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793274189; x=1793878989;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dRf9//xhKjO2LpE4rxRS6+7WnZ7O7e8nA9mecYUpUds=;
 b=ejO9kPm8QkODKquCKYAqAYL3qJ2bHWeWOgdp1y55H22XLuIN+rl2/RHb2QbcI5MudE
 OucX7a0zkl3zCwDYOf8fziTiWu8ew+BuzhDwNRRRj8MrApq2j6jLFCEvJ3N7kaa+UDp+
 /cLnMQrvjmoUu6mpFbtZkS/yazJUGZTc4JgWZ513RMNABqVnXuMi4O9pPOcTDNFb+ccG
 EOoOzKeh585RWVMwhPZAFAkIrALT1PvH2TKnK/xNsEcutNyA+ZQjFNpaKE3Us9u1SKqo
 mhPE1z919oSZAxEmmkdysYlj2EJPWQEoEAZXmcjWbA2k5GTwJzJ1EH30v1O3xw+yTYEV
 njTw==
X-Gm-Message-State: AFq9FYJPqgopkDwMR5KaOzaP+1TqHjeGvcoPlI0TccNSMvrs5cJRnVPg
 XZT3SrEmLT+zPLAXY5Fwjk7VEaqVOoyOvEqlxkEoS4XiTcbx8uTz8WEk49tXzdPF9HBCHW10dwI
 pC7mWF8NjKf0Tzqzr/lNlxbbRYDqshLSBLd6VRJGD/w+IZkq+np4hxfs4
X-Gm-Gg: AYBFou1nMLVh/yNkorvINq0lOWShNljrTmT0Z6oy9JyTDN+PSNOdmXc7wVfxHRLkol0
 LDVphWxp9+vM5eSr+JWRHjRFbbzfrF+TYz+NeF1QdbJ1jXSbMb7BKd8poI6pXgr0AoxzGPWPT8V
 rEy3lBGHN/n0pCMrE0112vV/X3ldV79V4xnEhZHnxTJs0TMRN9hwOCEzuxJXuQqN92caqiQXSnX
 9WFCDXvFrv7INV8ea6Dk/gOAU9Pc3LavTJXGeKWv4YpUgfFqFuoo8hsnrBKBVTh46qSt8sNSH/S
 uZGqVMnaqCs89RqPKabcfP/ggRT3+Utxmt+FbwX5mq4WAPGsxC5Tyimd0A2bE2fsD2dli5G7IB2
 KYmbZvbXspfxKbAOTxHzrcn1dkF07R1r8QhjXzvonzbEjlzT347GBjA==
X-Received: by 2002:a05:600c:1c17:b0:4a3:59c9:a756 with SMTP id
 5b1f17b1804b1-4a965dd3247mr122943805e9.6.1793274189064; 
 Thu, 29 Oct 2026 04:43:09 -0700 (PDT)
X-Received: by 2002:a05:600c:1c17:b0:4a3:59c9:a756 with SMTP id
 5b1f17b1804b1-4a965dd3247mr122943365e9.6.1793274188623; 
 Thu, 29 Oct 2026 04:43:08 -0700 (PDT)
Received: from sgarzare-redhat ([81.127.154.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7ee57589sm68073985e9.2.2026.10.29.04.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 04:43:08 -0700 (PDT)
Date: Thu, 29 Oct 2026 12:43:01 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Tim Pambor <timpambor@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 qemu-block@nongnu.org, Raphael Norwitz <rnorwitz@nvidia.com>, 
 Brad Smith <brad@comstyle.com>
Subject: Re: [PATCH 1/8] vhost-user: kick via event_notifier_set()
Message-ID: <auMXJo3ShmKS0ezB@sgarzare-redhat>
References: <20261022-vhost-user-posix-v1-0-0bd4d450d23c@gmail.com>
 <20261022-vhost-user-posix-v1-1-0bd4d450d23c@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022-vhost-user-posix-v1-1-0bd4d450d23c@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 22, 2026 at 03:47:22PM +0200, Tim Pambor wrote:
> vhost-user injects a kick by writing to the fd it has just passed to the
> back-end. With an eventfd that fd is writable, but when pipes are used
> it is the read end and the write fails.
> 
> Instead, kick via event_notifier_set() on the queue's host notifier,
> which writes to the correct end in both cases.
> 
> Signed-off-by: Tim Pambor <timpambor@gmail.com>
> ---
>  hw/virtio/vhost-user.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 65889b0776..b817b15d0b 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1527,16 +1527,9 @@ static int vhost_user_set_vring_kick(struct vhost_dev *dev,
>       * receiving a kick. The spec suggests this to improve compatibility.
>       */
>      if (file->fd != -1) {
> -        uint64_t val = 1;
> -        ssize_t nwritten;
> +        VirtQueue *vq = virtio_get_queue(dev->vdev, file->index);
>  
> -        do {
> -            nwritten = write(file->fd, &val, sizeof(val));
> -        } while (nwritten < 0 && errno == EINTR);
> -
> -        if (nwritten < 0 && errno != EAGAIN /* back-end can already read */) {
> -            return -errno;
> -        }

Please add a comment here explaining why we are not using file->fd (like 
you correctly did in the commit message), or update the comment before 
this block.

Also, should we add an assert to check that file->fd is equal to 
event_notifier_get_fd() ?

The rest LGTM.

Stefano

> +        return event_notifier_set(virtio_queue_get_host_notifier(vq));
>      }
>  
>      return 0;
> 
> -- 
> 2.55.0
> 


