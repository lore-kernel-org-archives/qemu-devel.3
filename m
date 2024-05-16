Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18C1C25B77
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 04:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Sat-0006ZI-Ms; Thu, 16 May 2024 00:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael@enfabrica.net>)
 id 1s7Sas-0006Yt-Iu
 for qemu-devel@nongnu.org; Thu, 16 May 2024 00:19:50 -0400
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael@enfabrica.net>)
 id 1s7Saq-0005ET-7u
 for qemu-devel@nongnu.org; Thu, 16 May 2024 00:19:50 -0400
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6a0badb6892so40554986d6.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 21:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=enfabrica.net; s=google; t=1715833187; x=1716437987; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ED1j3eg9jdFST/gkMCo0s3MkfqEk3yQncspyHFEyqT8=;
 b=Ced0epVwP5fZ1cDGkeiGTD9xyHLYyepgx3wrF5NW6luhKjJtpT5OXmBaazQwuUGrFL
 8axwSuLgcqTH9khFVQfOitnnKS8xVTEShW6JFgNLFNSyk/AH44VfrEuWJkoFFvz7waXr
 V24SyunTYE8vpqQE8lnhrSuHADjc2cM57C6AssuPTHxehq9nqHYOVHFn7IopAQ2ZldHH
 iqx6sYFlFQUcMhlj3jo7c9lwNyX2X+yNjPNLCMNVwq3CYFUyG5QMq+zkEG4QJFge7yDa
 q+tMyjvblFeqiJfocamwRqs9oR1eotl85WlCP55RjpPr0eFVgYgrFS7OcN/QGw9Iwz8R
 J45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715833187; x=1716437987;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ED1j3eg9jdFST/gkMCo0s3MkfqEk3yQncspyHFEyqT8=;
 b=va5gNtn5rLC+R3yAQLNQL8xM8yPJeSF7cTnmURyAXQoJXkxKnB7kLmRSDww8jShkuY
 elqhRVcjRNzs1EfpvKf/r1GWfKPZNzpTVmZF+RN6FzFi6u5xyimVMhUS4tSmzIqp0P7a
 jszEVE7FVuoWGwMOTmjUU6SSJ/LjriavSzhPEgTfln8n/AbRqCd6H+2ooMNXvwD/tdkQ
 ZUnui1EpyKevPzYk88iXtSZT1ZC0V122OcKLpjbK7DyyjPSoPJfrRJmVBWKZXk+JDqzT
 nMqBVk4zwIkXLxE3MwRUXmWWm0Ot8hhLGB+kkE33RQZbmXJ+05FwNZDXIww5GJplEgd9
 dsIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNCFbxHw4sj16SDIGzztn/z9VxZXvA9poSQ2Mg8GdwW96VgLpmse3WcIBjcWBzt8jE5rYBgF4PFat67hbtSJQAKyAkdZg=
X-Gm-Message-State: AOJu0YyjEYp72lxurOf0yMV3vCVEynjGEMsxOkaV6NZP7dYDfo65pReD
 lPk9wlOnmMBM40M+i/15fQ2FnzFKlAEb21CiGhK/7e8uCzn7IjDYnk7vx3fUuTrQrNPKwQsaRD4
 o8P8QfW5d2t+a/1oR8Kuz6GkWBsyure+jxX1oTQ==
X-Google-Smtp-Source: AGHT+IH0VKjurH9pfxiDsndcMLOH/1lFDNWMfqxKN4cBt5JhvyhoSEFMhducs2pIQRPraZxBcJOpFlUHCRtsmPcn/pI=
X-Received: by 2002:a05:6214:4342:b0:6a3:5db0:a821 with SMTP id
 6a1803df08f44-6a35db0a8c7mr24957286d6.25.1715833186869; Wed, 15 May 2024
 21:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240514061239.86461-1-fengli@smartx.com>
 <20240514061239.86461-3-fengli@smartx.com>
 <CAMDpr=crBG2ViSRSmrmtGQ7gn90XB_QHLdt74EbgG-k2hxiPhg@mail.gmail.com>
 <0BF8DF49-CB9A-4D0A-A994-099A7925DF09@smartx.com>
 <CAMDpr=cSEPH2CHFn76=2Z3PrZ644-wdq_7S++pCFdesbzC6ikA@mail.gmail.com>
 <2A51C37E-972B-4231-8D08-7A4560ED5E49@smartx.com>
In-Reply-To: <2A51C37E-972B-4231-8D08-7A4560ED5E49@smartx.com>
From: Raphael Norwitz <raphael@enfabrica.net>
Date: Thu, 16 May 2024 00:19:36 -0400
Message-ID: <CAMDpr=dzgrYuQ68TeiYpRB1cZvaOU4bXhH787sxVzjqg9o414w@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=raphael@enfabrica.net; helo=mail-qv1-xf2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

OK - I'm happy with this approach then.

On Wed, May 15, 2024 at 10:48=E2=80=AFPM Li Feng <fengli@smartx.com> wrote:
>
>
>
> 2024=E5=B9=B45=E6=9C=8815=E6=97=A5 23:47=EF=BC=8CRaphael Norwitz <raphael=
@enfabrica.net> =E5=86=99=E9=81=93=EF=BC=9A
>
> The case your describing makes sense but now I have some concerns on
> the vhost_dev_cleanup bit.
>
> On Wed, May 15, 2024 at 1:47=E2=80=AFAM Li Feng <fengli@smartx.com> wrote=
:
>
>
>
>
> 2024=E5=B9=B45=E6=9C=8814=E6=97=A5 21:58=EF=BC=8CRaphael Norwitz <raphael=
@enfabrica.net> =E5=86=99=E9=81=93=EF=BC=9A
>
> Code looks good. Just a question on the error case you're trying to fix.
>
> On Tue, May 14, 2024 at 2:12=E2=80=AFAM Li Feng <fengli@smartx.com> wrote=
:
>
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
>  vhost_user_async_close(.. vhost_user_blk_disconnect ..)
>    qemu_chr_fe_set_handlers <----- clear the notifier callback
>      schedule vhost_user_async_close_bh
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
>
>
> Following on from the prior patch, why would "connected" be false when
> a CLOSE event happens?
>
>
> In OPEN event handling, vhost_user_blk_connect calls vhost_dev_init and e=
ncounters
> an error such that s->connected remains false.
> Next, after the CLOSE event arrives, it is found that s->connected is fal=
se, so nothing
> is done, but the event handler will be cleaned up in `vhost_user_async_cl=
ose`
> before the CLOSE event is executed.
>
>
> Got it - I see why the event handler is never re-installed in the code
> as it was before if we fail at get_features. That said, how do you
> explain your comment:
>
>
> OK, I will update the commit message because this code has changed some m=
onths ago.
>
>
> With this patch, the vhost_user_blk_disconnect will call the
> vhost_dev_cleanup() again, it's safe.
>
>
> I see vhost_dev_cleanup() accessing hdev without even a NULL check. In
> the case we're talking about here I don't think it's a problem because
> if vhost_dev_init() fails, connected will be false and hit the goto
> but I am concerned that there could be double-frees or use-after-frees
> in other cases.
>
>
> OK, you are right, with this patch, the vhost_dev_cleanup will not be
> called multiple times now.
>
> I think there is no need to worry about calling vhost_dev_cleanup multipl=
e times,
> because historically vhost_dev_cleanup has been allowed to be called mult=
iple
> times, and looking at the code, it can be found that calling vhost_dev_cl=
eanup
> multiple times is indeed safe.
>
> Look this patch:
>
> commit e0547b59dc0ead4c605d3f02d1c8829630a1311b
> Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Date:   Wed Jul 27 01:15:02 2016 +0400
>
>     vhost: make vhost_dev_cleanup() idempotent
>
>     It is called on multiple code path, so make it safe to call several
>     times (note: I don't remember a reproducer here, but a function calle=
d
>     'cleanup' should probably be idempotent in my book)
>
>     Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>     Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> Thanks,
> Li
>
>
> Thanks,
> Li
>
>
>
> All vhost-user devices have this issue, including vhost-user-blk/scsi.
>
> Fixes: 71e076a07d ("hw/virtio: generalise CHR_EVENT_CLOSED handling")
>
> Signed-off-by: Li Feng <fengli@smartx.com>
> ---
> hw/block/vhost-user-blk.c   |  3 ++-
> hw/scsi/vhost-user-scsi.c   |  3 ++-
> hw/virtio/vhost-user-base.c |  3 ++-
> hw/virtio/vhost-user.c      | 10 +---------
> 4 files changed, 7 insertions(+), 12 deletions(-)
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 41d1ac3a5a..c6842ced48 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -353,7 +353,7 @@ static void vhost_user_blk_disconnect(DeviceState *de=
v)
>    VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
>
>    if (!s->connected) {
> -        return;
> +        goto done;
>    }
>    s->connected =3D false;
>
> @@ -361,6 +361,7 @@ static void vhost_user_blk_disconnect(DeviceState *de=
v)
>
>    vhost_dev_cleanup(&s->dev);
>
> +done:
>    /* Re-instate the event handler for new connections */
>    qemu_chr_fe_set_handlers(&s->chardev, NULL, NULL, vhost_user_blk_event=
,
>                             NULL, dev, NULL, true);
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index 48a59e020e..b49a11d23b 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -181,7 +181,7 @@ static void vhost_user_scsi_disconnect(DeviceState *d=
ev)
>    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
>
>    if (!s->connected) {
> -        return;
> +        goto done;
>    }
>    s->connected =3D false;
>
> @@ -189,6 +189,7 @@ static void vhost_user_scsi_disconnect(DeviceState *d=
ev)
>
>    vhost_dev_cleanup(&vsc->dev);
>
> +done:
>    /* Re-instate the event handler for new connections */
>    qemu_chr_fe_set_handlers(&vs->conf.chardev, NULL, NULL,
>                             vhost_user_scsi_event, NULL, dev, NULL, true)=
;
> diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> index 4b54255682..11e72b1e3b 100644
> --- a/hw/virtio/vhost-user-base.c
> +++ b/hw/virtio/vhost-user-base.c
> @@ -225,13 +225,14 @@ static void vub_disconnect(DeviceState *dev)
>    VHostUserBase *vub =3D VHOST_USER_BASE(vdev);
>
>    if (!vub->connected) {
> -        return;
> +        goto done;
>    }
>    vub->connected =3D false;
>
>    vub_stop(vdev);
>    vhost_dev_cleanup(&vub->vhost_dev);
>
> +done:
>    /* Re-instate the event handler for new connections */
>    qemu_chr_fe_set_handlers(&vub->chardev,
>                             NULL, NULL, vub_event,
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index c929097e87..c407ea8939 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -2781,16 +2781,8 @@ typedef struct {
> static void vhost_user_async_close_bh(void *opaque)
> {
>    VhostAsyncCallback *data =3D opaque;
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
>    g_free(data);
> }
> --
> 2.45.0
>
>

