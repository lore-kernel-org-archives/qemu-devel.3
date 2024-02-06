Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBF8C48260
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 02:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXBVH-0003vv-Kl; Mon, 05 Feb 2024 21:48:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rXBVF-0003uA-Kd
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 21:48:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rXBV5-0007t3-S9
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 21:48:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707187674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d4ZCB+7ROboc7hezLTAygYGe6I945IVPo0uZ8x5Swgc=;
 b=WQ50QEblSfnuYOMbpkzhkkyxpazlTWLgmORG2u2uYMM2M4VtvIVCkD6c07IeClCS95aMae
 WobQPPTsb58Oq5duSw4qEFAEF0y+gqUV2xAO/RJF7xzXAQgFUKMSZ5B2m78czdDZElHmKJ
 NkmpqS93Mqa7pz0dEIvFt6E5Mtc3KKU=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-9dZ0qRUwOkOtOwghjTm_BA-1; Mon, 05 Feb 2024 21:47:53 -0500
X-MC-Unique: 9dZ0qRUwOkOtOwghjTm_BA-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5cf962e1fcbso5655086a12.3
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 18:47:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707187672; x=1707792472;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d4ZCB+7ROboc7hezLTAygYGe6I945IVPo0uZ8x5Swgc=;
 b=xL9Z6+tl3BRlcOOPAjoxkWgvuvW1WGrACOZOTAyOhgTOeZ6hOmyvJ4e0dQxDEFD5eZ
 luh3qy3JhbgY2zNMBxg1aY2gwlQftvoFtYkIOboMq58J9eEgTPmqKCyNlA0S42Jxa9/H
 u8Oc6pe3bg7sE7sLU9PVSVlSLm2cU1VtEij4gTdSy+lO+n0MVeRdb9WiGoNub/K4l+GX
 g9UqN5fTru3QSQhwqDoSprYduWgkKa7tnNBkfohcvdEx/4rVnmgM4C9B99fT4CfALr7C
 kvx7MFQWaNnpGBRUS5vqug9LsSu4Rx2N5BFPRozp7FgV6eYOll444gFxfnJnpQa2EIcL
 v9zw==
X-Gm-Message-State: AOJu0YxzwBx5MKlQTcxEcb3SwGrOVfsQ1ya3JZSQg79PvFq/mW3Wu6Fk
 jCL+B/HcecIxpfPbsWp4bS6fyToT+/o4F0zS4I0tF/K+ztKxiOsHBjAaRg7ywV52oC2W/ISxgzZ
 qWtegjdgvuNkF2pO1qCU1QeEXqUZGJk+PRdRP7OQYml/MpX87I7X1OG4jfXR/8lfrC4jNt06qA2
 kJx5qeDP/zZy0rj2ei+aabYDFX95M=
X-Received: by 2002:a05:6a20:f38a:b0:19e:2aab:f727 with SMTP id
 qr10-20020a056a20f38a00b0019e2aabf727mr330242pzb.57.1707187672026; 
 Mon, 05 Feb 2024 18:47:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhfdxV7GtyI3LBnhLQ/Jh9Sd4H7x8fy3af7rI6eOJc1u2VSHQPvLXRZlwzmb6OmCxWfsLVRkzgxSZfLhQc1lU=
X-Received: by 2002:a05:6a20:f38a:b0:19e:2aab:f727 with SMTP id
 qr10-20020a056a20f38a00b0019e2aabf727mr330235pzb.57.1707187671764; Mon, 05
 Feb 2024 18:47:51 -0800 (PST)
MIME-Version: 1.0
References: <20240202132521.32714-1-kwolf@redhat.com>
 <zmopxf5zt6m36nfujntn72idlinm7qmx23wjvwiazmq4b75lsa@a2omit34pjif>
In-Reply-To: <zmopxf5zt6m36nfujntn72idlinm7qmx23wjvwiazmq4b75lsa@a2omit34pjif>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 6 Feb 2024 10:47:40 +0800
Message-ID: <CACGkMEvLpg+nPgHsE_6stFM1OGXbHpuE=j7XLwt_YxpxhWJgZw@mail.gmail.com>
Subject: Re: [PATCH] vdpa-dev: Fix initialisation order to restore VDUSE
 compatibility
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 qemu-block@nongnu.org, mst@redhat.com, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Feb 5, 2024 at 6:51=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Fri, Feb 02, 2024 at 02:25:21PM +0100, Kevin Wolf wrote:
> >VDUSE requires that virtqueues are first enabled before the DRIVER_OK
> >status flag is set; with the current API of the kernel module, it is
> >impossible to enable the opposite order in our block export code because
> >userspace is not notified when a virtqueue is enabled.

Did this mean virtio-blk will enable a virtqueue after DRIVER_OK? Sepc
is not clear about this and that's why we introduce
VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK.

>
> Yeah, IMHO the VDUSE protocol is missing a VDUSE_SET_VQ_READY message,

I think you meant when VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is
negotiated. If this is truth, it seems a little more complicated, for
example the get_backend_features needs to be forward to the userspace?
This seems suboptimal to implement this in the spec first and then we
can leverage the features. Or we can have another parameter for the
ioctl that creates the vduse device.

> I'll start another thread about that, but in the meantime I agree that
> we should fix QEMU since we need to work properly with old kernels as
> well.
>
> >
> >This requirement also mathces the normal initialisation order as done by
> >the generic vhost code in QEMU. However, commit 6c482547 accidentally
> >changed the order for vdpa-dev and broke access to VDUSE devices with
> >this.
> >
> >This changes vdpa-dev to use the normal order again and use the standard
> >vhost callback .vhost_set_vring_enable for this. VDUSE devices can be
> >used with vdpa-dev again after this fix.
>
> I like this approach and the patch LGTM, but I'm a bit worried about
> this function in hw/net/vhost_net.c:
>
>      int vhost_set_vring_enable(NetClientState *nc, int enable)
>      {
>          VHostNetState *net =3D get_vhost_net(nc);
>          const VhostOps *vhost_ops =3D net->dev.vhost_ops;
>
>          nc->vring_enable =3D enable;
>
>          if (vhost_ops && vhost_ops->vhost_set_vring_enable) {
>              return vhost_ops->vhost_set_vring_enable(&net->dev, enable);
>          }
>
>          return 0;
>      }
>
> @Eugenio, @Jason, should we change some things there if vhost-vdpa
> implements the vhost_set_vring_enable callback?

Eugenio may know more, I remember we need to enable cvq first for
shadow virtqueue to restore some states.

>
> Do you remember why we didn't implement it from the beginning?

It seems the vrings parameter is introduced after vhost-vdpa is implemented=
.

Thanks

>
> Thanks,
> Stefano
>
> >
> >Cc: qemu-stable@nongnu.org
> >Fixes: 6c4825476a4351530bcac17abab72295b75ffe98
> >Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >---
> > hw/virtio/vdpa-dev.c   |  5 +----
> > hw/virtio/vhost-vdpa.c | 17 +++++++++++++++++
> > 2 files changed, 18 insertions(+), 4 deletions(-)
> >
> >diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
> >index eb9ecea83b..13e87f06f6 100644
> >--- a/hw/virtio/vdpa-dev.c
> >+++ b/hw/virtio/vdpa-dev.c
> >@@ -253,14 +253,11 @@ static int vhost_vdpa_device_start(VirtIODevice *v=
dev, Error **errp)
> >
> >     s->dev.acked_features =3D vdev->guest_features;
> >
> >-    ret =3D vhost_dev_start(&s->dev, vdev, false);
> >+    ret =3D vhost_dev_start(&s->dev, vdev, true);
> >     if (ret < 0) {
> >         error_setg_errno(errp, -ret, "Error starting vhost");
> >         goto err_guest_notifiers;
> >     }
> >-    for (i =3D 0; i < s->dev.nvqs; ++i) {
> >-        vhost_vdpa_set_vring_ready(&s->vdpa, i);
> >-    }
> >     s->started =3D true;
> >
> >     /*
> >diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> >index 3a43beb312..c4574d56c5 100644
> >--- a/hw/virtio/vhost-vdpa.c
> >+++ b/hw/virtio/vhost-vdpa.c
> >@@ -904,6 +904,22 @@ int vhost_vdpa_set_vring_ready(struct vhost_vdpa *v=
, unsigned idx)
> >     return r;
> > }
> >
> >+static int vhost_vdpa_set_vring_enable(struct vhost_dev *dev, int enabl=
e)
> >+{
> >+    struct vhost_vdpa *v =3D dev->opaque;
> >+    unsigned int i;
> >+    int ret;
> >+
> >+    for (i =3D 0; i < dev->nvqs; ++i) {
> >+        ret =3D vhost_vdpa_set_vring_ready(v, i);
> >+        if (ret < 0) {
> >+            return ret;
> >+        }
> >+    }
> >+
> >+    return 0;
> >+}
> >+
> > static int vhost_vdpa_set_config_call(struct vhost_dev *dev,
> >                                        int fd)
> > {
> >@@ -1524,6 +1540,7 @@ const VhostOps vdpa_ops =3D {
> >         .vhost_set_features =3D vhost_vdpa_set_features,
> >         .vhost_reset_device =3D vhost_vdpa_reset_device,
> >         .vhost_get_vq_index =3D vhost_vdpa_get_vq_index,
> >+        .vhost_set_vring_enable =3D vhost_vdpa_set_vring_enable,
> >         .vhost_get_config  =3D vhost_vdpa_get_config,
> >         .vhost_set_config =3D vhost_vdpa_set_config,
> >         .vhost_requires_shm_log =3D NULL,
> >--
> >2.43.0
> >
>


