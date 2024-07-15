Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0255C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 21:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTSpq-0003Vn-Pc; Mon, 15 Jul 2024 17:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sTSpo-0003Uo-Su
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 17:02:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sTSpn-0001lv-9W
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 17:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721077328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XflZLiy2DaOqa39FdhV5jZ5vMUsd9tXXjQ59cHjafvA=;
 b=ZNoqRaNpG6fY001cRTrejRjZTJLDsRnKEMAm+G/JgyxJlXCHP5qx4FZ7FZgvFePVsFruNb
 Z8yK4wyZbsH3IviTawytrKaMej3jC2+fxaal/zmHx1phao8nqMZS9DX+EOgrrW7KdVC02v
 BwBJuDvMXYDjxQMEZvg/A2Va4Oi+AY4=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-0xKcQm9ePcuhmSVywwHkvQ-1; Mon, 15 Jul 2024 17:02:05 -0400
X-MC-Unique: 0xKcQm9ePcuhmSVywwHkvQ-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-64b9800b377so76019627b3.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 14:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721077324; x=1721682124;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XflZLiy2DaOqa39FdhV5jZ5vMUsd9tXXjQ59cHjafvA=;
 b=b787DW9/oLi/LSxnmp+34IhTI3wkjxTx31XPk05S6huQ4grzcpbsFfJa4FiEmjZZUR
 iAiY9eIs9Bi5Af7lEzSRW6ewp9WI4rfROk/tih7vvwZMvY+y1n8mkkV2I4YMaAlNszae
 ij6upFodZ2gd7Hd/DN7hWQKyfoFsdvyBLaQr2eTKVSXStlG7oueae7Y30XFGjC/2HgYF
 i/uIMbiH2f9s8rfQvwfonzV/3ynV37LcmeErMnBg+9ez5XA8x6J39ri66M+rFvgob5FU
 Prnb4gXIQq64mC/pnfIZk7xAJBiYX4EbS75SEHgne/8pSlPXF2HkA0uuLREhVEkcLxCW
 zX5A==
X-Gm-Message-State: AOJu0YzgB7DT14/olpsw0WYWwoflb7C5NUFGyDfAIFxD520xnfbgmeqC
 BBWiudcGQQ5pSYZjbRICUn11jaFPhXZfU31bpe6kbQg6hp4tavUtHOybmh7flXwUyRpv6swAIym
 DKdkRPTVBunr/lD6LkfbSDCZetM1Qsi6ndrMmndeBRnBdeDvJuz0YMBMCIKNtcMT/ldhLxdjNB4
 RBgefb6ZaKWtbwAqHj79q1lVJEvTU=
X-Received: by 2002:a0d:ea13:0:b0:650:92da:a987 with SMTP id
 00721157ae682-663890c217amr670567b3.16.1721077324552; 
 Mon, 15 Jul 2024 14:02:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG23kAQGhFSUFz9LhXvmxxFtCLrx4wNMOrGA+TTRUXc1dg7e7yHD1+J2AgZhCeJzDLhrxSUOz4zHMp35kAKd/Q=
X-Received: by 2002:a0d:ea13:0:b0:650:92da:a987 with SMTP id
 00721157ae682-663890c217amr670387b3.16.1721077324304; Mon, 15 Jul 2024
 14:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240715095939.72492-1-zhao1.liu@intel.com>
 <20240715095939.72492-2-zhao1.liu@intel.com>
In-Reply-To: <20240715095939.72492-2-zhao1.liu@intel.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 15 Jul 2024 23:01:08 +0200
Message-ID: <CAJaqyWcRv53hNYXT31tZ9M317OTBsxSgQ5bJvo1y-E=VoVS24g@mail.gmail.com>
Subject: Re: [PATCH] hw/virtio/vdpa-dev: Check returned value instead of
 dereferencing @errp
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 15, 2024 at 11:45=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wro=
te:
>
> As the comment in qapi/error, dereferencing @errp requires
> ERRP_GUARD():
>
> * =3D Why, when and how to use ERRP_GUARD() =3D
> *
> * Without ERRP_GUARD(), use of the @errp parameter is restricted:
> * - It must not be dereferenced, because it may be null.
> ...
> * ERRP_GUARD() lifts these restrictions.
> *
> * To use ERRP_GUARD(), add it right at the beginning of the function.
> * @errp can then be used without worrying about the argument being
> * NULL or &error_fatal.
> *
> * Using it when it's not needed is safe, but please avoid cluttering
> * the source with useless code.
>
> Though vhost_vdpa_device_realize() is called at DeviceClass.realize()
> context and won't get NULL @errp, it's still better to follow the
> requirement to add the ERRP_GUARD().
>
> But qemu_open() and vhost_vdpa_device_get_u32()'s return values can
> distinguish between successful and unsuccessful calls, so check the
> return values directly without dereferencing @errp, which eliminates
> the need of ERRP_GUARD().
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: "Eugenio P=C3=A9rez" <eperezma@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  hw/virtio/vdpa-dev.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
> index 64b96b226c39..7b439efdc1d3 100644
> --- a/hw/virtio/vdpa-dev.c
> +++ b/hw/virtio/vdpa-dev.c
> @@ -50,6 +50,7 @@ vhost_vdpa_device_get_u32(int fd, unsigned long int cmd=
, Error **errp)
>
>  static void vhost_vdpa_device_realize(DeviceState *dev, Error **errp)
>  {
> +    ERRP_GUARD();

Good catch, thank you! But removing the err dereferencing eliminates
the need for ERRP_GUARD(), doesn't it?

Thanks!

>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>      VhostVdpaDevice *v =3D VHOST_VDPA_DEVICE(vdev);
>      struct vhost_vdpa_iova_range iova_range;
> @@ -63,19 +64,19 @@ static void vhost_vdpa_device_realize(DeviceState *de=
v, Error **errp)
>      }
>
>      v->vhostfd =3D qemu_open(v->vhostdev, O_RDWR, errp);
> -    if (*errp) {
> +    if (v->vhostfd < 0) {
>          return;
>      }
>
>      v->vdev_id =3D vhost_vdpa_device_get_u32(v->vhostfd,
>                                             VHOST_VDPA_GET_DEVICE_ID, err=
p);
> -    if (*errp) {
> +    if (v->vdev_id < 0) {
>          goto out;
>      }
>
>      max_queue_size =3D vhost_vdpa_device_get_u32(v->vhostfd,
>                                                 VHOST_VDPA_GET_VRING_NUM,=
 errp);
> -    if (*errp) {
> +    if (max_queue_size < 0) {
>          goto out;
>      }
>
> @@ -89,7 +90,7 @@ static void vhost_vdpa_device_realize(DeviceState *dev,=
 Error **errp)
>
>      v->num_queues =3D vhost_vdpa_device_get_u32(v->vhostfd,
>                                                VHOST_VDPA_GET_VQS_COUNT, =
errp);
> -    if (*errp) {
> +    if (v->num_queues < 0) {
>          goto out;
>      }
>
> @@ -127,7 +128,7 @@ static void vhost_vdpa_device_realize(DeviceState *de=
v, Error **errp)
>      v->config_size =3D vhost_vdpa_device_get_u32(v->vhostfd,
>                                                 VHOST_VDPA_GET_CONFIG_SIZ=
E,
>                                                 errp);
> -    if (*errp) {
> +    if (v->config_size < 0) {
>          goto vhost_cleanup;
>      }
>
> --
> 2.34.1
>


