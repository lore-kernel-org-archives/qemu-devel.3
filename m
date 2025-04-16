Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A9DC369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 05:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4vc6-0007wP-JM; Wed, 16 Apr 2025 01:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1u4vbi-0007tC-0I
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 01:46:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1u4vbd-0008DM-NL
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 01:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744782397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RyvNXtWcRmDO9stoppMg4G2oHvhXfPQuqs4ps4FGDW4=;
 b=SdxbHbdsBEsaYVs5e+Yg+xKuzJ5WPaPDbN4qdsKQXe3gDowG7FXN5fmpolhsRB7sONxrZO
 vHovyMvGPve9ORfyBHji67QG9r5IR2AizZVy/M79Ahk7Jf391o45nCCAZU2Kxp3sj3Ex2a
 iHTCcOSeUdqWcAxMLHufPm+mKiom450=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-rJw4zENbOpuKB60LKTNVeA-1; Wed, 16 Apr 2025 01:46:36 -0400
X-MC-Unique: rJw4zENbOpuKB60LKTNVeA-1
X-Mimecast-MFC-AGG-ID: rJw4zENbOpuKB60LKTNVeA_1744782395
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ff7aecba07so6231051a91.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 22:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744782395; x=1745387195;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RyvNXtWcRmDO9stoppMg4G2oHvhXfPQuqs4ps4FGDW4=;
 b=H2ObBBmpRh4cVQK+mmD4Qagks+S1qC+yqSjmD2BDQCD7DJfqf6UW6xUM50Drj/Gi8a
 Hla7fmI/JcwNBXBe4bblht+MMY+v6bncV4w8qBXFHs1PRImjnKOuKCkNRJZ3dTCNfhKJ
 En9D7qJDMukiu8Z3DkiUhTZPKtv7iNd3ipOx3vRPo5T0sDpvK2ZL0X9KHyWQ+sNW2HJg
 GuMjmzYgmUpceJSpBc3RLPm8l5fvyX7draat/oYRxIIYLS9mnssZuzC/j2aR0BLxmyuJ
 N7x3QKxHL8/ArzDZSqP6EjWumkuro/gOJWAwAzea82jpFAIkD5Iw12VP1zu3cfcgQL5p
 sRHA==
X-Gm-Message-State: AOJu0Yw6C0xhijA5lAQ2ucD96cO2xqo62S1r7hKDrfKwosG8KG37M3pb
 5nofpKuJe9meIOo0pHXWCTI+hWOpDS/3tpUCXC2mn77FetbdA6jRUoIPKdYSjprJm8fWnOK2VBm
 Q40U2CtvrrzNBJCxeSXxHYzhZI3qCW3LCLtl1lpP+l2MtdRyg9mf23ruu5MS7COxmpDKOELLPEH
 XkQJaUmu8sUQpoGSwNhZhsNpMSqvA=
X-Gm-Gg: ASbGncu9abcUxd0UYnOWQBtVWu41TuG8Fl9qrrt32B1FshnXU4ypd1wXFlfbHuZJhAs
 49zsBZEpBXeXJaiaT08eIQUpp4JeE8XHyJLPIQiPdzbwv2Vr6MUxLVfDtUXXQhFj99Joz
X-Received: by 2002:a17:90b:2c86:b0:2ee:f550:3848 with SMTP id
 98e67ed59e1d1-30863d1d966mr922405a91.5.1744782394941; 
 Tue, 15 Apr 2025 22:46:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHH/yZ+B8oUmMWbnfneiXQQqZ+N6dQVGjNyF4AeEWoFkpTlNe42/BTC4WHg2V8oRBuyUJplLkr1/m3JKEFOcPc=
X-Received: by 2002:a17:90b:2c86:b0:2ee:f550:3848 with SMTP id
 98e67ed59e1d1-30863d1d966mr922367a91.5.1744782394468; Tue, 15 Apr 2025
 22:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250410-reset-v1-1-751cd0064395@daynix.com>
In-Reply-To: <20250410-reset-v1-1-751cd0064395@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 Apr 2025 13:46:23 +0800
X-Gm-Features: ATxdqUFvxxwYpgMjD12qr-fRq3-UOsXksaBOUstKCCe2bZyP24oE3LotDDFsOpw
Message-ID: <CACGkMEv5JfUFkwQzE5iHuxnKsVm6u1d89Ek5n4Gw2a2D2DEvVw@mail.gmail.com>
Subject: Re: [PATCH] virtio: Call set_features during reset
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 devel@daynix.com, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Apr 10, 2025 at 3:42=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> virtio-net expects set_features() will be called when the feature set
> used by the guest changes to update the number of virtqueues. Call it
> during reset as reset clears all features and the queues added for
> VIRTIO_NET_F_MQ or VIRTIO_NET_F_RSS will need to be removed.

It's not clear to me what kind of problem we want to fix here. For
example, what happens if we don't do this.

>
> Fixes: f9d6dbf0bf6e ("virtio-net: remove virtio queues if the guest doesn=
't support multiqueue")
> Buglink: https://issues.redhat.com/browse/RHEL-73842
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/virtio/virtio.c | 86 +++++++++++++++++++++++++++---------------------=
------
>  1 file changed, 43 insertions(+), 43 deletions(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 85110bce3744..033e87cdd3b9 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2316,49 +2316,6 @@ void virtio_queue_enable(VirtIODevice *vdev, uint3=
2_t queue_index)
>      }
>  }
>
> -void virtio_reset(void *opaque)
> -{
> -    VirtIODevice *vdev =3D opaque;
> -    VirtioDeviceClass *k =3D VIRTIO_DEVICE_GET_CLASS(vdev);
> -    int i;
> -
> -    virtio_set_status(vdev, 0);
> -    if (current_cpu) {
> -        /* Guest initiated reset */
> -        vdev->device_endian =3D virtio_current_cpu_endian();
> -    } else {
> -        /* System reset */
> -        vdev->device_endian =3D virtio_default_endian();
> -    }
> -
> -    if (k->get_vhost) {
> -        struct vhost_dev *hdev =3D k->get_vhost(vdev);
> -        /* Only reset when vhost back-end is connected */
> -        if (hdev && hdev->vhost_ops) {
> -            vhost_reset_device(hdev);
> -        }
> -    }
> -
> -    if (k->reset) {
> -        k->reset(vdev);
> -    }
> -
> -    vdev->start_on_kick =3D false;
> -    vdev->started =3D false;
> -    vdev->broken =3D false;
> -    vdev->guest_features =3D 0;
> -    vdev->queue_sel =3D 0;
> -    vdev->status =3D 0;
> -    vdev->disabled =3D false;
> -    qatomic_set(&vdev->isr, 0);
> -    vdev->config_vector =3D VIRTIO_NO_VECTOR;
> -    virtio_notify_vector(vdev, vdev->config_vector);
> -
> -    for(i =3D 0; i < VIRTIO_QUEUE_MAX; i++) {
> -        __virtio_queue_reset(vdev, i);
> -    }
> -}
> -
>  void virtio_queue_set_addr(VirtIODevice *vdev, int n, hwaddr addr)
>  {
>      if (!vdev->vq[n].vring.num) {
> @@ -3169,6 +3126,49 @@ int virtio_set_features(VirtIODevice *vdev, uint64=
_t val)
>      return ret;
>  }
>
> +void virtio_reset(void *opaque)
> +{
> +    VirtIODevice *vdev =3D opaque;
> +    VirtioDeviceClass *k =3D VIRTIO_DEVICE_GET_CLASS(vdev);
> +    int i;
> +
> +    virtio_set_status(vdev, 0);
> +    if (current_cpu) {
> +        /* Guest initiated reset */
> +        vdev->device_endian =3D virtio_current_cpu_endian();
> +    } else {
> +        /* System reset */
> +        vdev->device_endian =3D virtio_default_endian();
> +    }
> +
> +    if (k->get_vhost) {
> +        struct vhost_dev *hdev =3D k->get_vhost(vdev);
> +        /* Only reset when vhost back-end is connected */
> +        if (hdev && hdev->vhost_ops) {
> +            vhost_reset_device(hdev);
> +        }
> +    }
> +
> +    if (k->reset) {
> +        k->reset(vdev);
> +    }
> +
> +    vdev->start_on_kick =3D false;
> +    vdev->started =3D false;
> +    vdev->broken =3D false;
> +    virtio_set_features_nocheck(vdev, 0);

I would just add a forward declaration instead for a smaller changset
to ease the review and backport.

> +    vdev->queue_sel =3D 0;
> +    vdev->status =3D 0;
> +    vdev->disabled =3D false;
> +    qatomic_set(&vdev->isr, 0);
> +    vdev->config_vector =3D VIRTIO_NO_VECTOR;
> +    virtio_notify_vector(vdev, vdev->config_vector);
> +
> +    for (i =3D 0; i < VIRTIO_QUEUE_MAX; i++) {
> +        __virtio_queue_reset(vdev, i);
> +    }
> +}
> +
>  static void virtio_device_check_notification_compatibility(VirtIODevice =
*vdev,
>                                                             Error **errp)
>  {
>
> ---
> base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
> change-id: 20250406-reset-5ed5248ee3c1
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>

Thanks

>
>


