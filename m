Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BCDC47DDB
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 21:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUw68-0008Mu-5a; Tue, 30 Jan 2024 16:56:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rUw65-0008M6-Ak; Tue, 30 Jan 2024 16:56:49 -0500
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rUw63-0006TZ-6Z; Tue, 30 Jan 2024 16:56:49 -0500
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-214d1139620so1299674fac.3; 
 Tue, 30 Jan 2024 13:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706651805; x=1707256605; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aJ+jbUdEqhj8WwDZ1MvKTSY6NCcP4aOpfr28/dJ7ftM=;
 b=OffbKcHMltZTMCEbz5CvVVOHfGJd/oQ9WnLoLvM+m7py/JdhDidcKuuf03Q3osn9q7
 645EYgdWxXTa/EvjJ7MSJ/+F8kEHDVK9GpbjHdb3EbBoIvHHoHZ+DpvBiWivBHSkqewf
 spUE09rEcUUOri3J4qvP6uIajCC/fppH3BnkpJpWTChf3vtWi8wuBXlh8x1tBZegc7ZW
 h8x367hDJI6L1RjAzqdOxRtVwcqa2AJE8+XvMC+BxCOFpqIk6XGAtwWLncVViWAHvY9T
 b0ZbTSFN3ffYOHHYIFYMaK5JkmBYZVfUuJRBzVTN09rKIBixIkbPRAQ/5MFmQNMb+eYy
 DvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706651805; x=1707256605;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aJ+jbUdEqhj8WwDZ1MvKTSY6NCcP4aOpfr28/dJ7ftM=;
 b=oes15a988rEPw/+jWMYXzROl9du3S9D6rA4czMi6763FxKnXDR86hCwGDDGYbA5W5Q
 G0A4GPwoURT0IIrjf39SIWzMK55xAqz4syft0QHoe/xOgeX1GZUU9JZIvgSLLtksDxAl
 slgNonM3fqIb+q07+MVmMiRKQAeCkUSazwoYHpRXmQu5c2pwAicYMZTSdgc1MpjL44Kf
 nEqLbjJygbEKrS4+w97W9nbkmNz4jyRLvoqVHgFu+gYK2XUjbznERViwRhYck9uD+Clz
 4ptuBwIA7maMJcq//UruJyZhOjvWF5uUy+Ue1viFBK8PBsM/mhNFBTtM851ZSp52GZDt
 lFZw==
X-Gm-Message-State: AOJu0YzNBz0Eg627LYCjU/Rlw0AsywlXuxhC+OsOhRkZfq1yW+cGhyZL
 LY1wN1q85v4xjf6enjPnXrYp6SCuu2jp16hIXrnYfDedmOVTY0skNYoD6suvQxgx8C+g0MLkclz
 fxKfXvVrSmlWlXjVebfnlAHrKqBU=
X-Google-Smtp-Source: AGHT+IHs5xsKd8v7fbUuYjZ2tBJevqvDLSZiI99UQzAIWbH1SvbpmCyv+EgAiATKHVk6PW30OCRFFEgwMcP+HHoQWcs=
X-Received: by 2002:a05:6870:7e12:b0:218:a8f7:8d4a with SMTP id
 wx18-20020a0568707e1200b00218a8f78d4amr3221544oab.17.1706651804852; Tue, 30
 Jan 2024 13:56:44 -0800 (PST)
MIME-Version: 1.0
References: <20240122172625.415386-1-stefanha@redhat.com>
In-Reply-To: <20240122172625.415386-1-stefanha@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 30 Jan 2024 16:56:32 -0500
Message-ID: <CAJSP0QXDPcjONcxRdapvzCV=QL9gHyh-v2rC0eVy4W_eBM764Q@mail.gmail.com>
Subject: Re: [PATCH] virtio-blk: avoid using ioeventfd state in irqfd
 conditional
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, 22 Jan 2024 at 12:27, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> Requests that complete in an IOThread use irqfd to notify the guest
> while requests that complete in the main loop thread use the traditional
> qdev irq code path. The reason for this conditional is that the irq code
> path requires the BQL:
>
>   if (s->ioeventfd_started && !s->ioeventfd_disabled) {
>       virtio_notify_irqfd(vdev, req->vq);
>   } else {
>       virtio_notify(vdev, req->vq);
>   }
>
> There is a corner case where the conditional invokes the irq code path
> instead of the irqfd code path:
>
>   static void virtio_blk_stop_ioeventfd(VirtIODevice *vdev)
>   {
>       ...
>       /*
>        * Set ->ioeventfd_started to false before draining so that host notifiers
>        * are not detached/attached anymore.
>        */
>       s->ioeventfd_started = false;
>
>       /* Wait for virtio_blk_dma_restart_bh() and in flight I/O to complete */
>       blk_drain(s->conf.conf.blk);
>
> During blk_drain() the conditional produces the wrong result because
> ioeventfd_started is false.
>
> Use qemu_in_iothread() instead of checking the ioeventfd state.
>
> Buglink: https://issues.redhat.com/browse/RHEL-15394
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---

Ping?

> Based-on: https://repo.or.cz/qemu/kevin.git/shortlog/c14962c3ea6f0998d028142ed14affcb9dfccf28
>
> Stable backport notes: dataplane_started is being renamed to
> ioeventfd_started in the next block pull request. This patch can be
> safely applied to -stable although the variable name has changed and
> git-am will complain.
>
>  hw/block/virtio-blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 227d83569f..287c31ee3c 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -64,7 +64,7 @@ static void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status)
>      iov_discard_undo(&req->inhdr_undo);
>      iov_discard_undo(&req->outhdr_undo);
>      virtqueue_push(req->vq, &req->elem, req->in_len);
> -    if (s->ioeventfd_started && !s->ioeventfd_disabled) {
> +    if (qemu_in_iothread()) {
>          virtio_notify_irqfd(vdev, req->vq);
>      } else {
>          virtio_notify(vdev, req->vq);
> --
> 2.43.0
>
>

