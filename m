Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36C3C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 14:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6t8S-00075m-6u; Tue, 14 May 2024 10:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael@enfabrica.net>)
 id 1s6sfu-0000P1-2z
 for qemu-devel@nongnu.org; Tue, 14 May 2024 09:58:38 -0400
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael@enfabrica.net>)
 id 1s6sfs-00040N-82
 for qemu-devel@nongnu.org; Tue, 14 May 2024 09:58:37 -0400
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6969388c36fso21629226d6.1
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 06:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=enfabrica.net; s=google; t=1715695114; x=1716299914; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EwlkUSVY2yvHjIBzm6NS2PGgqOzueCbHLywOrfH7nzY=;
 b=HQdz5zwXtEHjLSR2WkWHz26zn1WgVSYjmNzvpTzqNWQwa9ShiQM0VwM7hAm+fSwR/E
 H49NZbAo4GgBXrdHdPDilcPPINp0eNClYDr7zeNybDmmk4KDuKndd2RgVyOgARpKvyUi
 /1/EdhPh6mNyoXcZMZHauNXytdxMDNRpygpPPyYpMDxNasVtrdSptGcxYjRiljSilszT
 T3y+Nk5VpX9Tr4Y6m+Ozw21T3bA2uHoH8wzTaS0EkaNeCtLL/WkTDP+SN0q3EQMTmroS
 TqXUbfuhG0BTryrTX4LmKHbR66MNFYFuK6K2bxfdC+a9fXw1poNF1UhagTnThvtEvOYI
 w8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715695114; x=1716299914;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EwlkUSVY2yvHjIBzm6NS2PGgqOzueCbHLywOrfH7nzY=;
 b=hh0KANCyFZfwmhKT323hiVdpP6N/QEESXT8PpaTWDLnQ86m3OPOd4cs9NrX1nTLs3+
 qGUkp4+5PkA3ow1A21t4K7SFZbinleQwkyYwTdVg5UMxJu4cfXEkdF7Gj1MRKsBUd4TL
 YSNAzv6LdHuZ7Qe8sqoIU6pxg2fjFpGgbObjuIQaUMB44M4Tj7eBz3sTY9aU5Gk6MMc2
 JADk0xrBX78mt3uyoV+Y3tylYBXbJAVsCE3yxiZxKCx1lTsHRrPQ9Zbokbmx3oYY1Wrr
 fB1DjzT5gbHfDj4//LfwvL2MuoIB/MH2G1/ihPQOjRrXycgK3NDpYv2vAtlr+Y+iN8wv
 Q4yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWznxJByuE4t+q0da6g8uMv5Gn5t9r0wb35PEtXxESeSbCMHihkX+wuD+D7y61IxhRUX3TyHwP+PUv4n8LSM6kiP/qBumo=
X-Gm-Message-State: AOJu0Yzfneeo/OHvvwkIkeuxaZM8IRzmJeBS/aVI3o8RQ2KO9r/gx4nu
 ArFwJSc1u0747HazMPmkQtiR7LoFiBomlEUSOIwMoapLAsA9M6M+Lcfx79hv8lkBlrTtiIbVDF5
 4rKqwHkbIl66mo73cVG40w+4pUyGalpRG9utsYw==
X-Google-Smtp-Source: AGHT+IHp71619MyuVls0JYZZ7SoEFhl4v+b0KH3hlo7gclH2Hwtw/AZEmjSPfrK5piQD/ajVpW3IiZZ/He9HOG9EKn0=
X-Received: by 2002:a05:6214:5789:b0:6a0:b905:97b0 with SMTP id
 6a1803df08f44-6a16820d12fmr166017746d6.39.1715695114596; Tue, 14 May 2024
 06:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240514061239.86461-1-fengli@smartx.com>
 <20240514061239.86461-2-fengli@smartx.com>
In-Reply-To: <20240514061239.86461-2-fengli@smartx.com>
From: Raphael Norwitz <raphael@enfabrica.net>
Date: Tue, 14 May 2024 09:58:23 -0400
Message-ID: <CAMDpr=f7=H0-8PAiodcQ-J_MOaEzXmXUbkA_b2uoY36a887_BA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Revert "vhost-user: fix lost reconnect"
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
X-Mailman-Approved-At: Tue, 14 May 2024 10:27:59 -0400
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

The code for these two patches looks fine. Just some questions on the
failure case you're trying to fix.


On Tue, May 14, 2024 at 2:12=E2=80=AFAM Li Feng <fengli@smartx.com> wrote:
>
> This reverts commit f02a4b8e6431598612466f76aac64ab492849abf.
>
> Since the current patch cannot completely fix the lost reconnect
> problem, there is a scenario that is not considered:
> - When the virtio-blk driver is removed from the guest os,
>   s->connected has no chance to be set to false, resulting in

Why would the virtio-blk driver being removed (unloaded?) in the guest
effect s->connected? Isn't this variable just tracking whether Qemu is
connected to the backend process? What does it have to do with the
guest driver state?

>   subsequent reconnection not being executed.
>
> The next patch will completely fix this issue with a better approach.
>
> Signed-off-by: Li Feng <fengli@smartx.com>
> ---
>  hw/block/vhost-user-blk.c      |  2 +-
>  hw/scsi/vhost-user-scsi.c      |  3 +--
>  hw/virtio/vhost-user-base.c    |  2 +-
>  hw/virtio/vhost-user.c         | 10 ++--------
>  include/hw/virtio/vhost-user.h |  3 +--
>  5 files changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 9e6bbc6950..41d1ac3a5a 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -384,7 +384,7 @@ static void vhost_user_blk_event(void *opaque, QEMUCh=
rEvent event)
>      case CHR_EVENT_CLOSED:
>          /* defer close until later to avoid circular close */
>          vhost_user_async_close(dev, &s->chardev, &s->dev,
> -                               vhost_user_blk_disconnect, vhost_user_blk=
_event);
> +                               vhost_user_blk_disconnect);
>          break;
>      case CHR_EVENT_BREAK:
>      case CHR_EVENT_MUX_IN:
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index a63b1f4948..48a59e020e 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -214,8 +214,7 @@ static void vhost_user_scsi_event(void *opaque, QEMUC=
hrEvent event)
>      case CHR_EVENT_CLOSED:
>          /* defer close until later to avoid circular close */
>          vhost_user_async_close(dev, &vs->conf.chardev, &vsc->dev,
> -                               vhost_user_scsi_disconnect,
> -                               vhost_user_scsi_event);
> +                               vhost_user_scsi_disconnect);
>          break;
>      case CHR_EVENT_BREAK:
>      case CHR_EVENT_MUX_IN:
> diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> index a83167191e..4b54255682 100644
> --- a/hw/virtio/vhost-user-base.c
> +++ b/hw/virtio/vhost-user-base.c
> @@ -254,7 +254,7 @@ static void vub_event(void *opaque, QEMUChrEvent even=
t)
>      case CHR_EVENT_CLOSED:
>          /* defer close until later to avoid circular close */
>          vhost_user_async_close(dev, &vub->chardev, &vub->vhost_dev,
> -                               vub_disconnect, vub_event);
> +                               vub_disconnect);
>          break;
>      case CHR_EVENT_BREAK:
>      case CHR_EVENT_MUX_IN:
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index cdf9af4a4b..c929097e87 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -2776,7 +2776,6 @@ typedef struct {
>      DeviceState *dev;
>      CharBackend *cd;
>      struct vhost_dev *vhost;
> -    IOEventHandler *event_cb;
>  } VhostAsyncCallback;
>
>  static void vhost_user_async_close_bh(void *opaque)
> @@ -2791,10 +2790,7 @@ static void vhost_user_async_close_bh(void *opaque=
)
>       */
>      if (vhost->vdev) {
>          data->cb(data->dev);
> -    } else if (data->event_cb) {
> -        qemu_chr_fe_set_handlers(data->cd, NULL, NULL, data->event_cb,
> -                                 NULL, data->dev, NULL, true);
> -   }
> +    }
>
>      g_free(data);
>  }
> @@ -2806,8 +2802,7 @@ static void vhost_user_async_close_bh(void *opaque)
>   */
>  void vhost_user_async_close(DeviceState *d,
>                              CharBackend *chardev, struct vhost_dev *vhos=
t,
> -                            vu_async_close_fn cb,
> -                            IOEventHandler *event_cb)
> +                            vu_async_close_fn cb)
>  {
>      if (!runstate_check(RUN_STATE_SHUTDOWN)) {
>          /*
> @@ -2823,7 +2818,6 @@ void vhost_user_async_close(DeviceState *d,
>          data->dev =3D d;
>          data->cd =3D chardev;
>          data->vhost =3D vhost;
> -        data->event_cb =3D event_cb;
>
>          /* Disable any further notifications on the chardev */
>          qemu_chr_fe_set_handlers(chardev,
> diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-use=
r.h
> index d7c09ffd34..324cd8663a 100644
> --- a/include/hw/virtio/vhost-user.h
> +++ b/include/hw/virtio/vhost-user.h
> @@ -108,7 +108,6 @@ typedef void (*vu_async_close_fn)(DeviceState *cb);
>
>  void vhost_user_async_close(DeviceState *d,
>                              CharBackend *chardev, struct vhost_dev *vhos=
t,
> -                            vu_async_close_fn cb,
> -                            IOEventHandler *event_cb);
> +                            vu_async_close_fn cb);
>
>  #endif
> --
> 2.45.0
>

