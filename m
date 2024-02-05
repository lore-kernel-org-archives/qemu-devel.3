Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE669C4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 12:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWy0i-0005XC-9I; Mon, 05 Feb 2024 07:23:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rWy0T-0005WL-UG
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 07:23:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rWy0P-0003ch-5D
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 07:23:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707135799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ebgF7RLwEE8ViALxgBwXsFlJlilyjqG75HqoUyoY8ik=;
 b=Dm7Z8TLF0CFfUux9igLESVEx+lZUCBGQ271YgKVOE/enADnwCoA0sOZHGHBAxYyYLg6uCk
 QX+8BS9vCCabwZI3dK11gBsIRNAk1ggaq4QIsD0g11o6v+FCDZSRvuCcVMSyJuN/56Izfn
 pjlzFj9fZSr482jEts6CIUKe+Kwvo/Q=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-6pyTJsiEPO2J_S4SXiWgbA-1; Mon, 05 Feb 2024 07:23:17 -0500
X-MC-Unique: 6pyTJsiEPO2J_S4SXiWgbA-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-60403a678f2so75199967b3.3
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 04:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707135797; x=1707740597;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ebgF7RLwEE8ViALxgBwXsFlJlilyjqG75HqoUyoY8ik=;
 b=Fyrg0bDmYW5y70Mu7DHahOcGmdUogl29oGVY+GC862KjCk69veKvuz9p7Ai5E2pUgu
 rjkvr/wWfFsArl92R9FAelf+y2p+kHOrv9v0Lnk0R0x9uZ6UKPySwv8aNyW07U2vm3Et
 fWvfOttvMV/D0cwuVuYhmZDX8bnYH3tIw7sOzFTnjD7zMqjL56OdHTmFqHQkvWD+gFuq
 LG2xZD7F0rrnHlzA/8OvEkvxPl6h5TMZp4bwb+DZ2dwPxgnigbCXIj2I/wcT7Gp7V6HS
 zjRkEJyX4Rg9WKlBlSVhcGhxHwggGy+9VzDDbfREYr4dCFzk0u5lrszecIM8EKYroXTa
 f4qQ==
X-Gm-Message-State: AOJu0YxLrR2aXZmgSfHRO+izGa9DDUfGo+6Fw93fTDT3dNYYzDexKoml
 R4SBW5Em4mEn4GZteH5lOzBMsWInWRElkhDl8t9fw5+kYEDf+Nb2Y4jzLG71OOn0+spkILSqTec
 awelCZ3mwnl3WjXPGos5KxdG48dTf8fv1aUEWwSRbUmWNqCjuMHVy4jxn2L77t9nrL1hlN3zf1p
 jRxQQ1B5fYvou77iUi1L9w2KN3LBU=
X-Received: by 2002:a25:ac4:0:b0:dc6:be1f:6d98 with SMTP id
 187-20020a250ac4000000b00dc6be1f6d98mr12652604ybk.16.1707135797160; 
 Mon, 05 Feb 2024 04:23:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIS1sW4M4qC0YkXLXEck0dagpTBUqgMt0J9afTgbnTx1e/kD1/SVgUmEjrS6KsXnsm8vb9PjiCbiTI0Vz0EG4=
X-Received: by 2002:a25:ac4:0:b0:dc6:be1f:6d98 with SMTP id
 187-20020a250ac4000000b00dc6be1f6d98mr12652589ybk.16.1707135796858; Mon, 05
 Feb 2024 04:23:16 -0800 (PST)
MIME-Version: 1.0
References: <20240202132521.32714-1-kwolf@redhat.com>
In-Reply-To: <20240202132521.32714-1-kwolf@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 5 Feb 2024 13:22:40 +0100
Message-ID: <CAJaqyWfMETO=C6oBj2VVo+CZ=kNe-aJSYja0WpLDLbFQV5sTnA@mail.gmail.com>
Subject: Re: [PATCH] vdpa-dev: Fix initialisation order to restore VDUSE
 compatibility
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mst@redhat.com, sgarzare@redhat.com, 
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Feb 2, 2024 at 2:25=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrote:
>
> VDUSE requires that virtqueues are first enabled before the DRIVER_OK
> status flag is set; with the current API of the kernel module, it is
> impossible to enable the opposite order in our block export code because
> userspace is not notified when a virtqueue is enabled.
>
> This requirement also mathces the normal initialisation order as done by
> the generic vhost code in QEMU. However, commit 6c482547 accidentally
> changed the order for vdpa-dev and broke access to VDUSE devices with
> this.
>
> This changes vdpa-dev to use the normal order again and use the standard
> vhost callback .vhost_set_vring_enable for this. VDUSE devices can be
> used with vdpa-dev again after this fix.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 6c4825476a4351530bcac17abab72295b75ffe98
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  hw/virtio/vdpa-dev.c   |  5 +----
>  hw/virtio/vhost-vdpa.c | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
> index eb9ecea83b..13e87f06f6 100644
> --- a/hw/virtio/vdpa-dev.c
> +++ b/hw/virtio/vdpa-dev.c
> @@ -253,14 +253,11 @@ static int vhost_vdpa_device_start(VirtIODevice *vd=
ev, Error **errp)
>
>      s->dev.acked_features =3D vdev->guest_features;
>
> -    ret =3D vhost_dev_start(&s->dev, vdev, false);
> +    ret =3D vhost_dev_start(&s->dev, vdev, true);
>      if (ret < 0) {
>          error_setg_errno(errp, -ret, "Error starting vhost");
>          goto err_guest_notifiers;
>      }
> -    for (i =3D 0; i < s->dev.nvqs; ++i) {
> -        vhost_vdpa_set_vring_ready(&s->vdpa, i);
> -    }
>      s->started =3D true;
>
>      /*
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 3a43beb312..c4574d56c5 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -904,6 +904,22 @@ int vhost_vdpa_set_vring_ready(struct vhost_vdpa *v,=
 unsigned idx)
>      return r;
>  }
>
> +static int vhost_vdpa_set_vring_enable(struct vhost_dev *dev, int enable=
)
> +{
> +    struct vhost_vdpa *v =3D dev->opaque;
> +    unsigned int i;
> +    int ret;
> +
> +    for (i =3D 0; i < dev->nvqs; ++i) {
> +        ret =3D vhost_vdpa_set_vring_ready(v, i);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>  static int vhost_vdpa_set_config_call(struct vhost_dev *dev,
>                                         int fd)
>  {
> @@ -1524,6 +1540,7 @@ const VhostOps vdpa_ops =3D {
>          .vhost_set_features =3D vhost_vdpa_set_features,
>          .vhost_reset_device =3D vhost_vdpa_reset_device,
>          .vhost_get_vq_index =3D vhost_vdpa_get_vq_index,
> +        .vhost_set_vring_enable =3D vhost_vdpa_set_vring_enable,
>          .vhost_get_config  =3D vhost_vdpa_get_config,
>          .vhost_set_config =3D vhost_vdpa_set_config,
>          .vhost_requires_shm_log =3D NULL,
> --
> 2.43.0
>

vhost-vdpa net enables CVQ before dataplane ones to configure all the
device in the destination of a live migration. To go back again to
this callback would cause the device to enable the dataplane before
virtqueues are configured again.

How does VDUSE userspace knows how many queues should enable? Can't
the kernel perform the necessary actions after DRIVER_OK, like
configuring the kick etc?

Thanks!


