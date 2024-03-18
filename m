Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BBBC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 18:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmI9U-0002iM-Dd; Mon, 18 Mar 2024 14:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rmI9T-0002ho-6o
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 14:56:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rmI9R-0001o0-I6
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 14:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710788159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=STgw3oqyAMmFa+vXUCtU6SIK4dBGKF7cWf4+emcEJxY=;
 b=Qgi8G+GxaMpDNBXCoyfY+/tKYXy05FY5mAx440eOQpsvuA0aLsZydOQ8ZmwyuKVYWRB1ZU
 vIJyWv1ssJSfhZJf7PMzVZprWxuU7MgOvTiawvXxyS6wMHtEKBiHaBGNnrjFxi0uwvjICn
 tAwS2tHiYPZG4ncFH1J1NKZBEYjgRB0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-oT1WPHmVPN-Gu8PqsoE44Q-1; Mon, 18 Mar 2024 14:55:57 -0400
X-MC-Unique: oT1WPHmVPN-Gu8PqsoE44Q-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-60a0151f194so79907217b3.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 11:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710788157; x=1711392957;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=STgw3oqyAMmFa+vXUCtU6SIK4dBGKF7cWf4+emcEJxY=;
 b=kjRXyQ2CvMY7KxTQMk2JMBNuEPMsgMby16oni+zZlZVVkJ6DyvEWe304wVVLps7aZk
 J6a8Wa4z07W0hOYK2PbHit45OI7L/Ru7QpZoO6piS7QcM5F3ko04PCQcyzT5eTKpio+K
 I2HT1ZV/1pSff6NZS3cg33tOG6ZoJvHg3gNObmbpkq/fxD6xT8aURWEWLUiR+cjhU1MU
 vNunxONWoM1RZkBuWH3UyEUgigj6P3Wnno+CriSrQsXO/ksed1NdGfABbLZKSmYje61a
 4FdcFo2ULNhpO4TSWXahUfJ1YT1jZiUS+SQ0kXMnNWtksCKjfBdOsRpnQqi2DFPccrK1
 fL6A==
X-Gm-Message-State: AOJu0Yy4Sup3uGZWs3Z8xNcsGr0WPsG1xVqyXrPZsi/GR3+4e6529npe
 ZoADrvD0S88dGYHbS9MXzfnBWOabZBP/9GyYOsWn8e7JqvtnvpXKLGZdXeawKR2mBLtwR1MlKYt
 DlQiuDL9dUEg1mkGkUgiCAo22MaQCiOE3sKoQd/MvS6v/CIPQEpqlx4bkdyNEjm1KypfVU1OSXO
 QJSq+Dt6FeWNm0OP0KbbOwoALGJ3c=
X-Received: by 2002:a81:a987:0:b0:60d:a849:7b3b with SMTP id
 g129-20020a81a987000000b0060da8497b3bmr11364791ywh.22.1710788155814; 
 Mon, 18 Mar 2024 11:55:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaikRMvl6UJZrErjOBm/Fxncwx54ekKC7J7j1zFfik9VJ5F2suYojhWyz8rmH8NrYEhhcakpsLvuv/ExKF96U=
X-Received: by 2002:a81:a987:0:b0:60d:a849:7b3b with SMTP id
 g129-20020a81a987000000b0060da8497b3bmr11364722ywh.22.1710788154074; Mon, 18
 Mar 2024 11:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240207092702.25242-1-sgarzare@redhat.com>
In-Reply-To: <20240207092702.25242-1-sgarzare@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 18 Mar 2024 19:55:18 +0100
Message-ID: <CAJaqyWdfiJ4LVj=MuJ1i2iNYdH719mXbpN6bxn5ZEZo-LN1xtQ@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: check vhost_vdpa_set_vring_ready() return
 value
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, lulu@redhat.com, kwolf@redhat.com, 
 Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
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

On Wed, Feb 7, 2024 at 10:27=E2=80=AFAM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> vhost_vdpa_set_vring_ready() could already fail, but if Linux's
> patch [1] will be merged, it may fail with more chance if
> userspace does not activate virtqueues before DRIVER_OK when
> VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not negotiated.
>
> So better check its return value anyway.
>
> [1] https://lore.kernel.org/virtualization/20240206145154.118044-1-sgarza=
re@redhat.com/T/#u
>

If any, I'd split the patches in CVQ and generic vdpa device. But I
don't think it is a big deal so

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Sorry for the long delay!

> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> Note: This patch conflicts with [2], but the resolution is simple,
> so for now I sent a patch for the current master, but I'll rebase
> this patch if we merge the other one first.
>
> [2] https://lore.kernel.org/qemu-devel/20240202132521.32714-1-kwolf@redha=
t.com/
> ---
>  hw/virtio/vdpa-dev.c |  8 +++++++-
>  net/vhost-vdpa.c     | 15 ++++++++++++---
>  2 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
> index eb9ecea83b..d57cd76c18 100644
> --- a/hw/virtio/vdpa-dev.c
> +++ b/hw/virtio/vdpa-dev.c
> @@ -259,7 +259,11 @@ static int vhost_vdpa_device_start(VirtIODevice *vde=
v, Error **errp)
>          goto err_guest_notifiers;
>      }
>      for (i =3D 0; i < s->dev.nvqs; ++i) {
> -        vhost_vdpa_set_vring_ready(&s->vdpa, i);
> +        ret =3D vhost_vdpa_set_vring_ready(&s->vdpa, i);
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "Error starting vring %d", i);
> +            goto err_dev_stop;
> +        }
>      }
>      s->started =3D true;
>
> @@ -274,6 +278,8 @@ static int vhost_vdpa_device_start(VirtIODevice *vdev=
, Error **errp)
>
>      return ret;
>
> +err_dev_stop:
> +    vhost_dev_stop(&s->dev, vdev, false);
>  err_guest_notifiers:
>      k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
>  err_host_notifiers:
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 3726ee5d67..e3d8036479 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -381,7 +381,10 @@ static int vhost_vdpa_net_data_load(NetClientState *=
nc)
>      }
>
>      for (int i =3D 0; i < v->dev->nvqs; ++i) {
> -        vhost_vdpa_set_vring_ready(v, i + v->dev->vq_index);
> +        int ret =3D vhost_vdpa_set_vring_ready(v, i + v->dev->vq_index);
> +        if (ret < 0) {
> +            return ret;
> +        }
>      }
>      return 0;
>  }
> @@ -1213,7 +1216,10 @@ static int vhost_vdpa_net_cvq_load(NetClientState =
*nc)
>
>      assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
>
> -    vhost_vdpa_set_vring_ready(v, v->dev->vq_index);
> +    r =3D vhost_vdpa_set_vring_ready(v, v->dev->vq_index);
> +    if (unlikely(r < 0)) {
> +        return r;
> +    }
>
>      if (v->shadow_vqs_enabled) {
>          n =3D VIRTIO_NET(v->dev->vdev);
> @@ -1252,7 +1258,10 @@ static int vhost_vdpa_net_cvq_load(NetClientState =
*nc)
>      }
>
>      for (int i =3D 0; i < v->dev->vq_index; ++i) {
> -        vhost_vdpa_set_vring_ready(v, i);
> +        r =3D vhost_vdpa_set_vring_ready(v, i);
> +        if (unlikely(r < 0)) {
> +            return r;
> +        }
>      }
>
>      return 0;
> --
> 2.43.0
>


