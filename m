Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63979C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 14:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6t8T-00076O-Mg; Tue, 14 May 2024 10:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael@enfabrica.net>)
 id 1s6sg1-0000Wk-RP
 for qemu-devel@nongnu.org; Tue, 14 May 2024 09:58:45 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael@enfabrica.net>)
 id 1s6sg0-00040r-3L
 for qemu-devel@nongnu.org; Tue, 14 May 2024 09:58:45 -0400
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-792b8d989e4so480544585a.2
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 06:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=enfabrica.net; s=google; t=1715695122; x=1716299922; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xVnKBQ/97Zk8q0vtBpa88IohAkhA5S3T+Atu/XvGi+c=;
 b=H9EjMfvYHpbx/5R/nblFfnkZxfgeHRTucp9bs8xp9mlR5DgLcfd3TAp/mCeuolHf3u
 bSHaFyf5tS65Jko3P52qnVqrn+tWMafmZJeNU8LHgMLGi2VzHLSIoz5ZDEIn2QzWdUGq
 rAgF/BlPCgQAASOJKvufRa3WrdBlsPfLp0PF2MhcbAVgXnEJKzNrAcpemeDkMCRrfUUO
 TYneW+ZYD3gFlB0pjUqrZvHVHShjSvIqPf+NvdJ6QZ0uxOQKanWnCYsPXzK6+aWgbDEY
 DYZSE2Jc4haEImGTtlB/o6kNjkopWHI685wbKZATmK3jmSYedAU52WqFbV7DQxsL9yML
 wVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715695122; x=1716299922;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xVnKBQ/97Zk8q0vtBpa88IohAkhA5S3T+Atu/XvGi+c=;
 b=LoIIrzFduXy1qsvr90f/4khvRhPzUyK5JxpwrfjvSo67zZYxufwi/xZOMDVp5jQMln
 DJGprc2SF4hPOp6RXQrPqWaCNB1Ey4QLx9AwbqRZesxj6plK+Ia75hDvbH+ygoHB9YJa
 M0Ze4Jzfdrx21TG1vIKv7kb5lb245pHaQ9IxkHiWrFGTjegkjF2EeCRNUtgZr9Lxx/8T
 M3oCcHJQpro+/ZrSB4M/lQCo549DLqs6p9q2l3IOu0nbNtLCjsWypWWh0lrNj6XghuJY
 FayWsJhsi5tMVGw1KG9oo4d+hm7KqhHiYhnKblJ/gz3ntZGXEdwpVBF3USq+7oLhvm66
 NHxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq4DsXqYAXFVT+rVtHiBCgJKNfnQ4TTiCoIyJyQIExqeKT2PU7tpWZdHc9dYp6VKZmiAzulAlMK5dGCp+kM0UEFSW93Bs=
X-Gm-Message-State: AOJu0YyEGLW4MQ6HfvUnJ6oo6odVJwvlm+TesVRN8dfqmB2N5v5L752S
 40jsHqEU8kCeQVvlun94tX+MsuF/g++G6zy8zLclfHNbhoqv/Ehixmsjuu3wYBjBfu3DbTQgumx
 2Tax9ATiagA2weVMlUVjFUFtqEbBkvnHsgZonqA==
X-Google-Smtp-Source: AGHT+IHijGkvnPVlrDoXuL3/+ha1WilSI7RPv/osPmQRSjLrwPc9KkarLjVJnnBScKLKMZn30W8gilQeMtbhSLuJO+s=
X-Received: by 2002:a05:6214:4409:b0:6a0:544f:f608 with SMTP id
 6a1803df08f44-6a16815e158mr137312896d6.14.1715695121877; Tue, 14 May 2024
 06:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240514061239.86461-1-fengli@smartx.com>
 <20240514061239.86461-3-fengli@smartx.com>
In-Reply-To: <20240514061239.86461-3-fengli@smartx.com>
From: Raphael Norwitz <raphael@enfabrica.net>
Date: Tue, 14 May 2024 09:58:31 -0400
Message-ID: <CAMDpr=crBG2ViSRSmrmtGQ7gn90XB_QHLdt74EbgG-k2hxiPhg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vhost-user: fix lost reconnect again
To: Li Feng <fengli@smartx.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "open list:Block layer core" <qemu-block@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Yajun Wu <yajunw@nvidia.com>, Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=raphael@enfabrica.net; helo=mail-qk1-x734.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 14 May 2024 10:28:00 -0400
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

Code looks good. Just a question on the error case you're trying to fix.

On Tue, May 14, 2024 at 2:12=E2=80=AFAM Li Feng <fengli@smartx.com> wrote:
>
> When the vhost-user is reconnecting to the backend, and if the vhost-user=
 fails
> at the get_features in vhost_dev_init(), then the reconnect will fail
> and it will not be retriggered forever.
>
> The reason is:
> When the vhost-user fail at get_features, the vhost_dev_cleanup will be c=
alled
> immediately.
>
> vhost_dev_cleanup calls 'memset(hdev, 0, sizeof(struct vhost_dev))'.
>
> The reconnect path is:
> vhost_user_blk_event
>    vhost_user_async_close(.. vhost_user_blk_disconnect ..)
>      qemu_chr_fe_set_handlers <----- clear the notifier callback
>        schedule vhost_user_async_close_bh
>
> The vhost->vdev is null, so the vhost_user_blk_disconnect will not be
> called, then the event fd callback will not be reinstalled.
>
> With this patch, the vhost_user_blk_disconnect will call the
> vhost_dev_cleanup() again, it's safe.
>
> In addition, the CLOSE event may occur in a scenario where connected is f=
alse.
> At this time, the event handler will be cleared. We need to ensure that t=
he
> event handler can remain installed.

Following on from the prior patch, why would "connected" be false when
a CLOSE event happens?

>
> All vhost-user devices have this issue, including vhost-user-blk/scsi.
>
> Fixes: 71e076a07d ("hw/virtio: generalise CHR_EVENT_CLOSED handling")
>
> Signed-off-by: Li Feng <fengli@smartx.com>
> ---
>  hw/block/vhost-user-blk.c   |  3 ++-
>  hw/scsi/vhost-user-scsi.c   |  3 ++-
>  hw/virtio/vhost-user-base.c |  3 ++-
>  hw/virtio/vhost-user.c      | 10 +---------
>  4 files changed, 7 insertions(+), 12 deletions(-)
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 41d1ac3a5a..c6842ced48 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -353,7 +353,7 @@ static void vhost_user_blk_disconnect(DeviceState *de=
v)
>      VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
>
>      if (!s->connected) {
> -        return;
> +        goto done;
>      }
>      s->connected =3D false;
>
> @@ -361,6 +361,7 @@ static void vhost_user_blk_disconnect(DeviceState *de=
v)
>
>      vhost_dev_cleanup(&s->dev);
>
> +done:
>      /* Re-instate the event handler for new connections */
>      qemu_chr_fe_set_handlers(&s->chardev, NULL, NULL, vhost_user_blk_eve=
nt,
>                               NULL, dev, NULL, true);
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index 48a59e020e..b49a11d23b 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -181,7 +181,7 @@ static void vhost_user_scsi_disconnect(DeviceState *d=
ev)
>      VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
>
>      if (!s->connected) {
> -        return;
> +        goto done;
>      }
>      s->connected =3D false;
>
> @@ -189,6 +189,7 @@ static void vhost_user_scsi_disconnect(DeviceState *d=
ev)
>
>      vhost_dev_cleanup(&vsc->dev);
>
> +done:
>      /* Re-instate the event handler for new connections */
>      qemu_chr_fe_set_handlers(&vs->conf.chardev, NULL, NULL,
>                               vhost_user_scsi_event, NULL, dev, NULL, tru=
e);
> diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> index 4b54255682..11e72b1e3b 100644
> --- a/hw/virtio/vhost-user-base.c
> +++ b/hw/virtio/vhost-user-base.c
> @@ -225,13 +225,14 @@ static void vub_disconnect(DeviceState *dev)
>      VHostUserBase *vub =3D VHOST_USER_BASE(vdev);
>
>      if (!vub->connected) {
> -        return;
> +        goto done;
>      }
>      vub->connected =3D false;
>
>      vub_stop(vdev);
>      vhost_dev_cleanup(&vub->vhost_dev);
>
> +done:
>      /* Re-instate the event handler for new connections */
>      qemu_chr_fe_set_handlers(&vub->chardev,
>                               NULL, NULL, vub_event,
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index c929097e87..c407ea8939 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -2781,16 +2781,8 @@ typedef struct {
>  static void vhost_user_async_close_bh(void *opaque)
>  {
>      VhostAsyncCallback *data =3D opaque;
> -    struct vhost_dev *vhost =3D data->vhost;
>
> -    /*
> -     * If the vhost_dev has been cleared in the meantime there is
> -     * nothing left to do as some other path has completed the
> -     * cleanup.
> -     */
> -    if (vhost->vdev) {
> -        data->cb(data->dev);
> -    }
> +    data->cb(data->dev);
>
>      g_free(data);
>  }
> --
> 2.45.0
>

