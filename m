Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D545C54E66
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 14:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkPiK-0008LB-EE; Wed, 13 Mar 2024 10:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rkPiI-0008K7-WB
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 10:36:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rkPiF-0006Rt-GO
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 10:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710340570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=miS+0oKJrZZnKQmGEWQSW2jhvP7iN2gpZqqKFDF7Roo=;
 b=YCuVM3DhQuI0FmsCw/Pfkq6v3wpVct0J4xcmIDZtHTUbA8WIKVcGU5n4ivtYaCcAfylaWB
 EuT61iZEqrus15WytVScYwAHLtfLyMlUL2IR+7LRdFJLgCIrLYYLNrn7z7SP58Dr8cxoTR
 kNsWSFHNCfRBWAI3ONa6iv3Ob/NQYYo=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-UkdNjUt8NI-liagi6gZuEw-1; Wed, 13 Mar 2024 10:36:09 -0400
X-MC-Unique: UkdNjUt8NI-liagi6gZuEw-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-dc64e0fc7c8so1538774276.2
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 07:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710340567; x=1710945367;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=miS+0oKJrZZnKQmGEWQSW2jhvP7iN2gpZqqKFDF7Roo=;
 b=rU3+Zteb8ty6Dnv7PEJjR+bnYZP5SOkOrxMF7rJ0MYEBwL5+2hyR1GxlNt7wnJDYTd
 s0TpBczSWHo0lJEIoWnHOMeZp9HPApazKux5o8exfGfq8G7Od0UMTGYi+N00jTn783hN
 bkMU1gr2xpc6xulsivYopsYW+iqw24+eUkW01nt4Na1/NomEqLJRfXPZws0qElOa5oHR
 b9OG4KqKQhhZtBF1Qbp230Xq7vezv9eiWy4xm+GW0Ws2SW3TLVTHWCFmJeGSirCbeW/1
 aTJNfuqHyJVg3Z8uW+Awmn+xUHrWiQt9yWKjO4FDdFpXUx3QALxMevpugI3ONZKky2Kr
 vhWQ==
X-Gm-Message-State: AOJu0YyQy1bXRGKcuBHQM2aqKCLs3BGueSrP9hY34xbCjtOAxus8JA3f
 /cBYB8AkzQObffnYFAUhjKLic257QJhkwLT63Wm3Rp+XyJLP1j4xpp0PX6DgjQGasUiN//ki3x2
 UIjAh4wbN4XXeAYJ5SSYnl/fe9doqe3Ix15QmbB8VsExe4Muc0PkCdrtFuY6RlmPU/qI69Fz95i
 upcEjkNWN2s/O94uAYER6wVzIs9BQ=
X-Received: by 2002:a05:6902:602:b0:dcd:aa92:ecae with SMTP id
 d2-20020a056902060200b00dcdaa92ecaemr2279497ybt.63.1710340567504; 
 Wed, 13 Mar 2024 07:36:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXg8L1/H/y9NYwvhY+pmMn853I80LIY7IKUAYIYOyS/Je9dF+W22Frla3PfGKJ0YYW5gkn/9/ywlNa0gQ/mN0=
X-Received: by 2002:a05:6902:602:b0:dcd:aa92:ecae with SMTP id
 d2-20020a056902060200b00dcdaa92ecaemr2279464ybt.63.1710340567236; Wed, 13 Mar
 2024 07:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240313115412.3334962-1-jonah.palmer@oracle.com>
 <20240313115412.3334962-3-jonah.palmer@oracle.com>
In-Reply-To: <20240313115412.3334962-3-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 13 Mar 2024 15:35:31 +0100
Message-ID: <CAJaqyWfbsFO6W1aszyGJEFCdJRhHUvBmyH=NHdLGJWmVQH4G0Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] virtio: Prevent creation of device using
 notification-data with ioeventfd
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, raphael@enfabrica.net, 
 kwolf@redhat.com, hreitz@redhat.com, pasic@linux.ibm.com, 
 borntraeger@linux.ibm.com, farman@linux.ibm.com, thuth@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com, 
 cohuck@redhat.com, pbonzini@redhat.com, fam@euphon.net, stefanha@redhat.com, 
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, leiyang@redhat.com, 
 schalla@marvell.com, vattunuru@marvell.com, jerinj@marvell.com, 
 dtatulea@nvidia.com, virtio-fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.971,
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

On Wed, Mar 13, 2024 at 12:55=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.=
com> wrote:
>
> Prevent the realization of a virtio device that attempts to use the
> VIRTIO_F_NOTIFICATION_DATA transport feature without disabling
> ioeventfd.
>
> Due to ioeventfd not being able to carry the extra data associated with
> this feature, having both enabled is a functional mismatch and therefore
> Qemu should not continue the device's realization process.
>
> Although the device does not yet know if the feature will be
> successfully negotiated, many devices using this feature wont actually
> work without this extra data and would fail FEATURES_OK anyway.
>
> If ioeventfd is able to work with the extra notification data in the
> future, this compatibility check can be removed.
>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  hw/virtio/virtio.c         | 22 ++++++++++++++++++++++
>  include/hw/virtio/virtio.h |  2 ++
>  2 files changed, 24 insertions(+)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index bcb9e09df0..d0a433b465 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2971,6 +2971,20 @@ int virtio_set_features(VirtIODevice *vdev, uint64=
_t val)
>      return ret;
>  }
>
> +void virtio_device_check_notification_compatibility(VirtIODevice *vdev,
> +                                                    Error **errp)
> +{
> +    VirtioBusState *bus =3D VIRTIO_BUS(qdev_get_parent_bus(DEVICE(vdev))=
);
> +    VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(bus);
> +    DeviceState *proxy =3D DEVICE(BUS(bus)->parent);
> +
> +    if (virtio_host_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA) &&
> +        k->ioeventfd_enabled(proxy)) {
> +        error_setg(errp,
> +                   "notification_data=3Don without ioeventfd=3Doff is no=
t supported");
> +    }
> +}
> +
>  size_t virtio_get_config_size(const VirtIOConfigSizeParams *params,
>                                uint64_t host_features)
>  {
> @@ -3731,6 +3745,14 @@ static void virtio_device_realize(DeviceState *dev=
, Error **errp)
>          }
>      }
>
> +    /* Devices should not use both ioeventfd and notification data featu=
re */
> +    virtio_device_check_notification_compatibility(vdev, &err);
> +    if (err !=3D NULL) {
> +        error_propagate(errp, err);
> +        vdc->unrealize(dev);
> +        return;
> +    }
> +
>      virtio_bus_device_plugged(vdev, &err);
>      if (err !=3D NULL) {
>          error_propagate(errp, err);
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 53915947a7..e0325d84d0 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -346,6 +346,8 @@ void virtio_queue_reset(VirtIODevice *vdev, uint32_t =
queue_index);
>  void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index);
>  void virtio_update_irq(VirtIODevice *vdev);
>  int virtio_set_features(VirtIODevice *vdev, uint64_t val);
> +void virtio_device_check_notification_compatibility(VirtIODevice *vdev,
> +                                                    Error **errp);

Why not make it static?

>
>  /* Base devices.  */
>  typedef struct VirtIOBlkConf VirtIOBlkConf;
> --
> 2.39.3
>


