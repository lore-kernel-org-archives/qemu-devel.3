Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97D8C3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 16:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRaBu-0006K5-O9; Wed, 10 Jul 2024 12:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1sRaBs-0006It-Ah
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 12:29:12 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1sRaBq-0003Jn-OH
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 12:29:12 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-703626a0704so2132832a34.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 09:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720628949; x=1721233749; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vutYKBwUgKicDGnZakQ3TCvpokZVR+OPOniByF+dnMM=;
 b=QGresObtxk/ZIbnOeK/Ju8KY2rWQh1DrAF/WXI2B/PVRO1COUHenCvUwEvoTZHFMQW
 DdwFLXaHUdRHarVEAV7FdePSj5peSubNAjRmSNO6HqHpmyKthWTUYAeQ1LNj4WkN7MJO
 CVXuy1u2uhDY5PjbPQzsUAw5+7io2sPEutiHro92LPdNUDr8oAinzLdrY0ekNSSTUC+l
 CT+Fclp/fAn6VBC+6swKcqpktnUM1gkar7FBq5eqpXvT+8RTP2cJD0bNkcJb1JJXXZE+
 XADRWWwhCoO2OHwcsX+ZLG9R5zpyM1OdwE8GFQYSRuUKytB84xoSJzxgL+FIPgW1TguC
 Gi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720628949; x=1721233749;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vutYKBwUgKicDGnZakQ3TCvpokZVR+OPOniByF+dnMM=;
 b=NwwhsEJDzD1tXhEf1KGrRw82w0nCqTK8bg+NbkOBCClz4ELzP2I8g0fEASSDS+Odoj
 D2SSXYvLNOgIMPCXs7NzT0TN5/V85yNUbwI6JkSsAsWpbN2PUjPRv3ctX47sKeKhA30E
 gCHAZ5iCHw7r+hNKspQvQPJHeJngob3R2sKYYvCb6zKjmquMnEXsT5zWvicdZJDO0eLj
 0E0XoHjUE7B9Dt/GaLU/gjmVDNkHvmucrNUVtTjqyN9UpLtsS9xTO/CWuMvg0Wv3dWb3
 nyvBUEiyI2UVxB9Gxp0nf7R1gRJxyUR7Tx95tFvUDVcsyx2u5yy1rYG5n5g1f4Kwngud
 3iBg==
X-Gm-Message-State: AOJu0YyUSGZtOjI9gyPy8eqm806hpI+of/TNysN5DNhMuzx0alD4Dj9G
 S1DfoxNOC3ltubgP6N8PCJWd8YHgUPR0eop5KlT8khGBnFk99tadFPxNoEv+/ab04LjVZGn8wqK
 SFZWCR1lBnZ6VW8QzM3gVO9+Q+C8=
X-Google-Smtp-Source: AGHT+IGJZMtSYYe43ycQrOW3c0hCuJsu40izs7C8eH4SX0iF8U7AdgFzeEaj2lejGgXYkbNnTTIV+SHHWM80pJd+aWw=
X-Received: by 2002:a05:6870:b14d:b0:25e:1816:7f4f with SMTP id
 586e51a60fabf-25eae88cfc4mr5231125fac.31.1720628948824; Wed, 10 Jul 2024
 09:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240710112310.316551-1-hreitz@redhat.com>
In-Reply-To: <20240710112310.316551-1-hreitz@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 10 Jul 2024 18:28:56 +0200
Message-ID: <CAJSP0QWMKZxQTKuhQ1dASm9xqfWiumLz7ciVZy2APjPhT4VuFw@mail.gmail.com>
Subject: Re: [PATCH] virtio: Always reset vhost devices
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 10 Jul 2024 at 13:25, Hanna Czenczek <hreitz@redhat.com> wrote:
>
> Requiring `vhost_started` to be true for resetting vhost devices in
> `virtio_reset()` seems like the wrong condition: Most importantly, the
> preceding `virtio_set_status(vdev, 0)` call will (for vhost devices) end
> up in `vhost_dev_stop()` (through vhost devices' `.set_status`
> implementations), setting `vdev->vhost_started = false`.  Therefore, the
> gated `vhost_reset_device()` call is unreachable.
>
> `vhost_started` is not documented, so it is hard to say what exactly it
> is supposed to mean, but judging from the fact that `vhost_dev_start()`
> sets it and `vhost_dev_stop()` clears it, it seems like it indicates
> whether there is a vhost back-end, and whether that back-end is
> currently running and processing virtio requests.
>
> Making a reset conditional on whether the vhost back-end is processing
> virtio requests seems wrong; in fact, it is probably better to reset it
> only when it is not currently processing requests, which is exactly the
> current order of operations in `virtio_reset()`: First, the back-end is
> stopped through `virtio_set_status(vdev, 0)`, then we want to send a
> reset.
>
> Therefore, we should drop the `vhost_started` condition, but in its
> stead we then have to verify that we can indeed send a reset to this
> vhost device, by not just checking `k->get_vhost != NULL` (introduced by
> commit 95e1019a4a9), but also that the vhost back-end is connected
> (`hdev = k->get_vhost(); hdev != NULL && hdev->vhost_ops != NULL`).
>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>

I think an additional SET_STATUS 0 call is made to the vDPA vhost
backend after this patch, but that seems fine.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

> ---
>  hw/virtio/virtio.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 893a072c9d..4410d62126 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2146,8 +2146,12 @@ void virtio_reset(void *opaque)
>          vdev->device_endian = virtio_default_endian();
>      }
>
> -    if (vdev->vhost_started && k->get_vhost) {
> -        vhost_reset_device(k->get_vhost(vdev));
> +    if (k->get_vhost) {
> +        struct vhost_dev *hdev = k->get_vhost(vdev);
> +        /* Only reset when vhost back-end is connected */
> +        if (hdev && hdev->vhost_ops) {
> +            vhost_reset_device(hdev);
> +        }
>      }
>
>      if (k->reset) {
> --
> 2.45.2
>
>

