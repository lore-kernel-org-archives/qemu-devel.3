Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36712C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 04:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Sc5-0007gW-2Q; Thu, 16 May 2024 00:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael@enfabrica.net>)
 id 1s7Sbx-0007aS-57
 for qemu-devel@nongnu.org; Thu, 16 May 2024 00:20:57 -0400
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael@enfabrica.net>)
 id 1s7Sbu-0005re-1l
 for qemu-devel@nongnu.org; Thu, 16 May 2024 00:20:56 -0400
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-69b50b8239fso70625116d6.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 21:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=enfabrica.net; s=google; t=1715833253; x=1716438053; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ree70I4T1kP5nIhRwCyaYXmy3zb/hRU8n2ky5i4Lr0=;
 b=CF1mSbMeNXeEN7bWBmbV9qZuLEeUoGvWn2qMywnN+L8D+dNM1kIjbojbNipFE/geeD
 00QyirG4qd/Hoo/EIz4zaRje9o0NYqDqSuV//eXn7OivsOO/aJER1VOmY4p1ha7l0uUf
 Mk41/Xv+w0sNS0Ev6ytJ3mRJljwq/gtWxra9UBwSgBT8xrvknoQZrCQVLyT+c3r6z21R
 hz5Z/gk1Ww5M4hM6tPPDyZMQjlGHvurabhQ04o0t5wj9O232v4SsJWKKJt6U+N7RNbEk
 G0bUcmaY+nT/RYoyILPt7OKmzrB92CYIZR4jUsuYffVdK/Xna9gF8QoD0kmYp4Melqo7
 in6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715833253; x=1716438053;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5ree70I4T1kP5nIhRwCyaYXmy3zb/hRU8n2ky5i4Lr0=;
 b=H45xAVPXpP9H+1c9VA3/+01txQTy6npmm7a7+7dSkKoajfKj4z5uUTl6DcZDiLlPbC
 wxhnMPfZsIKSwn2QgghlWE3rvTsJ3D2vyyqOT3Z6TFI+7apDvMNCj+kxF+ARQt4lhEFQ
 Qgin+0A7w3XK73ChbXpSjERO9/ZKFBSos5bkxcjJ28irO75xCXkgHEoxBJ92OCaD+u3c
 UrVOTxxioYn3aq/AU3i1dthn0Bw1Q+Is44uYC4mKo32xSeCPRwH8MkDTNwl6wogNcueS
 ihL4U60p3ik0rS1ubctlXkw+kriTPoo8GRSA+5dDjjMhTXnRylSdZdWpuacEzVn2K0vK
 4+Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvqPHp70TW/bPCWIAemYCbveMT1gqrLY9iDPnBakcntsa8tS7vOjVS+VFtKTNcuGuGeKf8G7nZeUX0Y0tIiysPo1ZiKC0=
X-Gm-Message-State: AOJu0Yyl85Xr//pYjghcd0qRYOvIj21jR37aVQVfXgGAI7fSJxMe7uEv
 R6iIC+izmRT4TRXlh9wuVSTRx+cSh02txX4jji8H7dSL+le4cKNhTN6PXtywoSnOLZb4DWSDisk
 M7qAT0m0nrE/kon3wNNyCPH6gkeqqUyT58WC9ifCRe/FaRZJ+s4YmMQ==
X-Google-Smtp-Source: AGHT+IETWA5ZmnUdYWZ4CRRb/ywpj+JbLxD/wrZiX5ggVKQzkdxHbmLaz0iyA+BKDydKUgFomBccTOtVgSPOd91k3ZU=
X-Received: by 2002:a05:6214:1786:b0:6a0:e7d8:4adb with SMTP id
 6a1803df08f44-6a15cc805d6mr352039326d6.26.1715833253047; Wed, 15 May 2024
 21:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240516025753.130171-1-fengli@smartx.com>
 <20240516025753.130171-3-fengli@smartx.com>
In-Reply-To: <20240516025753.130171-3-fengli@smartx.com>
From: Raphael Norwitz <raphael@enfabrica.net>
Date: Thu, 16 May 2024 00:20:42 -0400
Message-ID: <CAMDpr=cGunkw+uEUuuExgj+BH-fm-r6Wy=6+qJaSF1ig00Kx8A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] vhost-user: fix lost reconnect again
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::f32;
 envelope-from=raphael@enfabrica.net; helo=mail-qv1-xf32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, May 15, 2024 at 10:58=E2=80=AFPM Li Feng <fengli@smartx.com> wrote:
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
> We need to ensure that even if vhost_dev_init initialization fails, the e=
vent
> handler still needs to be reinstalled when s->connected is false.
>
> All vhost-user devices have this issue, including vhost-user-blk/scsi.
>
> Fixes: 71e076a07d ("hw/virtio: generalise CHR_EVENT_CLOSED handling")
>

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>

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

