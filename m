Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBA7C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 16:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXOZr-0002sA-67; Tue, 06 Feb 2024 11:45:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rXOZp-0002rP-M3
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 11:45:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rXOZn-0006LV-1a
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 11:45:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707237938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ax9ne6UVj4pzcv4LBGjL0YO3pgsSCS5YVde/hA4bwgI=;
 b=Pme6NO+7izVCFvGf7lCZB6T7zWY2pZ8aUBfhmVNjlFLWNv8aW5LK48Usyi3LQXolu5Xq9l
 PA5VX4vy+hjspNsuRTZ7Kx18zDYmAZ4qWKQ46vcmvAz0o2/M13GyvvKPHRNCrdvUW6q7s4
 v6pQpEO6zefOHBe4shB6CTlKTMJy3hU=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-S7FwfNy7MaONdRELolpimg-1; Tue, 06 Feb 2024 11:45:37 -0500
X-MC-Unique: S7FwfNy7MaONdRELolpimg-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-dc6ba69e803so9740523276.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 08:45:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707237936; x=1707842736;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ax9ne6UVj4pzcv4LBGjL0YO3pgsSCS5YVde/hA4bwgI=;
 b=os+hMeKovo4RljE2PItHMmMgzE0Cll72sZLmH5yBh9l2VKQvj9SfTfJeIFpzsPwtIt
 R2WNFsNuNoRVbuViHv/Y8mH6+uyzQGD+VEg5z3T54k8F/es6dtKeDh3RuM6CMt4I/9tN
 ihG7IKP5iWjplloxPLVqD/yLG/otKtn58f3YcDUAvplG3EXUgxuHL+2RAncgwOHx0mA8
 TIMszRdQfezMhdkr0F0pvUJZehrGMUqEZo07OhS7mR5c/KgMdVFcC34UeXYr0UiWokYj
 jB+lh2PaqSJ3+EvOZSk55kOWXZ7JPChOWdWnHWGXxWCNMwQg7z1eTLh/vFq3Sl1k7BUN
 O55A==
X-Gm-Message-State: AOJu0YztlVcDxdzh6/NoPX3gEqkWA+yXjEe124/sufRHgbgWE62g+Gqq
 SH5n9ZaDMIWvXviTypeP1YbmsnEA+Am8bglOEE7oiMDvHQnHLqsJiaAE+mO31mzv3+Uiy9E4CBk
 5pbWOVkIWi0FJ/NayIwgJwSoLJY0pJPseIafOJTAY4Wv5mtcHGe/S+QZCFGKrCHqT1cHu5scoE+
 qYtwEovPBH7bK2RlgxrV5TXlye9o4=
X-Received: by 2002:a25:c7cb:0:b0:dc3:6990:99eb with SMTP id
 w194-20020a25c7cb000000b00dc3699099ebmr2113515ybe.55.1707237934885; 
 Tue, 06 Feb 2024 08:45:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoGtyQ5SA1S5bnzMLWe90NfKjB5oEE0HdJaAyV6rzx5nF8aGbysRz9jESHssubNbxyE+p7KHyaDzzwhN8lW6I=
X-Received: by 2002:a25:c7cb:0:b0:dc3:6990:99eb with SMTP id
 w194-20020a25c7cb000000b00dc3699099ebmr2113476ybe.55.1707237934545; Tue, 06
 Feb 2024 08:45:34 -0800 (PST)
MIME-Version: 1.0
References: <20240202132521.32714-1-kwolf@redhat.com>
 <CAJaqyWfMETO=C6oBj2VVo+CZ=kNe-aJSYja0WpLDLbFQV5sTnA@mail.gmail.com>
 <ZcDnXpE_IGkSVzTu@redhat.com>
In-Reply-To: <ZcDnXpE_IGkSVzTu@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 6 Feb 2024 17:44:58 +0100
Message-ID: <CAJaqyWenrGrE2Bjqw+TUy=WoMV56=4dY4rz5waN=rfrk7iAR2Q@mail.gmail.com>
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
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Feb 5, 2024 at 2:49=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 05.02.2024 um 13:22 hat Eugenio Perez Martin geschrieben:
> > On Fri, Feb 2, 2024 at 2:25=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wr=
ote:
> > >
> > > VDUSE requires that virtqueues are first enabled before the DRIVER_OK
> > > status flag is set; with the current API of the kernel module, it is
> > > impossible to enable the opposite order in our block export code beca=
use
> > > userspace is not notified when a virtqueue is enabled.
> > >
> > > This requirement also mathces the normal initialisation order as done=
 by
> > > the generic vhost code in QEMU. However, commit 6c482547 accidentally
> > > changed the order for vdpa-dev and broke access to VDUSE devices with
> > > this.
> > >
> > > This changes vdpa-dev to use the normal order again and use the stand=
ard
> > > vhost callback .vhost_set_vring_enable for this. VDUSE devices can be
> > > used with vdpa-dev again after this fix.
> > >
> > > Cc: qemu-stable@nongnu.org
> > > Fixes: 6c4825476a4351530bcac17abab72295b75ffe98
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > ---
> > >  hw/virtio/vdpa-dev.c   |  5 +----
> > >  hw/virtio/vhost-vdpa.c | 17 +++++++++++++++++
> > >  2 files changed, 18 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
> > > index eb9ecea83b..13e87f06f6 100644
> > > --- a/hw/virtio/vdpa-dev.c
> > > +++ b/hw/virtio/vdpa-dev.c
> > > @@ -253,14 +253,11 @@ static int vhost_vdpa_device_start(VirtIODevice=
 *vdev, Error **errp)
> > >
> > >      s->dev.acked_features =3D vdev->guest_features;
> > >
> > > -    ret =3D vhost_dev_start(&s->dev, vdev, false);
> > > +    ret =3D vhost_dev_start(&s->dev, vdev, true);
> > >      if (ret < 0) {
> > >          error_setg_errno(errp, -ret, "Error starting vhost");
> > >          goto err_guest_notifiers;
> > >      }
> > > -    for (i =3D 0; i < s->dev.nvqs; ++i) {
> > > -        vhost_vdpa_set_vring_ready(&s->vdpa, i);
> > > -    }
> > >      s->started =3D true;
> > >
> > >      /*
> > > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > > index 3a43beb312..c4574d56c5 100644
> > > --- a/hw/virtio/vhost-vdpa.c
> > > +++ b/hw/virtio/vhost-vdpa.c
> > > @@ -904,6 +904,22 @@ int vhost_vdpa_set_vring_ready(struct vhost_vdpa=
 *v, unsigned idx)
> > >      return r;
> > >  }
> > >
> > > +static int vhost_vdpa_set_vring_enable(struct vhost_dev *dev, int en=
able)
> > > +{
> > > +    struct vhost_vdpa *v =3D dev->opaque;
> > > +    unsigned int i;
> > > +    int ret;
> > > +
> > > +    for (i =3D 0; i < dev->nvqs; ++i) {
> > > +        ret =3D vhost_vdpa_set_vring_ready(v, i);
> > > +        if (ret < 0) {
> > > +            return ret;
> > > +        }
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> > > +
> > >  static int vhost_vdpa_set_config_call(struct vhost_dev *dev,
> > >                                         int fd)
> > >  {
> > > @@ -1524,6 +1540,7 @@ const VhostOps vdpa_ops =3D {
> > >          .vhost_set_features =3D vhost_vdpa_set_features,
> > >          .vhost_reset_device =3D vhost_vdpa_reset_device,
> > >          .vhost_get_vq_index =3D vhost_vdpa_get_vq_index,
> > > +        .vhost_set_vring_enable =3D vhost_vdpa_set_vring_enable,
> > >          .vhost_get_config  =3D vhost_vdpa_get_config,
> > >          .vhost_set_config =3D vhost_vdpa_set_config,
> > >          .vhost_requires_shm_log =3D NULL,
> >
> > vhost-vdpa net enables CVQ before dataplane ones to configure all the
> > device in the destination of a live migration. To go back again to
> > this callback would cause the device to enable the dataplane before
> > virtqueues are configured again.
>
> Not that it makes a difference, but I don't think it would actually be
> going back. Even before your commit 6c482547, we were not making use of
> the generic callback but just called the function in a slightly
> different place (but less different than after commit 6c482547).
>
> But anyway... Why don't the other vhost backend need the same for
> vhost-net then? Do they just not support live migration?
>

They don't support control virtqueue. More specifically, control
virtqueue is handled directly in QEMU.

> I don't know the code well enough to say where the problem is, but if
> vhost-vdpa networking code relies on the usual vhost operations not
> being implemented and bypasses VhostOps to replace it, that sounds like
> a design problem to me.

I don't follow this. What vhost operation is expected not to be implemented=
?

> Maybe VhostOps needs a new operation to enable
> just a single virtqueue that can be used by the networking code instead?
>
> > How does VDUSE userspace knows how many queues should enable? Can't
> > the kernel perform the necessary actions after DRIVER_OK, like
> > configuring the kick etc?
>
> Not sure if I understand the question. The vdpa kernel interface always
> enables individual queues, so the VDUSE userspace will enable whatever
> queues it was asked to enable. The only restriction is that the queues
> need to be enabled before setting DRIVER_OK.
>
> The interface that enables all virtqueues at once seems to be just
> .vhost_set_vring_enable in QEMU.
>

It enables all virtqueues of the same vhost device in QEMU, but QEMU
creates one vhost_dev per each vhost-net virtqueue pair and another
one for CVQ. This goes back to the time where mq vhost-kernel net
devices were implemented by mergin many tap devices. net/vhost-vdpa.c
only enables the last one, which corresponds to CVQ, and then enables
the rest once all messages have been received.

On the other hand, .vhost_set_vring_enable is also used for queue
reset (vhost_net_virtqueue_reset and vhost_net_virtqueue_restart). In
other words, it is called after the set DRIVER_OK. I guess it is fine
for VDUSE as long as it does not offer vring reset capabilities, but
future wise should we start going in that direction?

But kernels without VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK should be
supported, right. Maybe we can add vhost_vdpa_set_vring_enable and
call vhost_dev_start with vrings parameters conditional to the feature
flag? That way the caller can enable it later or just enable all the
rings altogether.

Thanks!


