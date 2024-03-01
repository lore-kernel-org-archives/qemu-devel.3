Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068F9C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 20:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg98J-0007vO-66; Fri, 01 Mar 2024 15:05:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rg987-0007uR-9k
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 15:05:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rg985-0008Me-4X
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 15:05:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709323511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K8ROXt87b41leJzrs1qawudk/3ANLOKhm3rIOBD7Src=;
 b=acr09A4Cyl+EnrUVyHCzYDgz+SUMBnudgZrwCPv59CzGPXHZkStGeiKi574C6fkEwPHUPf
 qIQ/cUFwevme4j91/WJLfvm0j8R2wlMMdzg/U4QyAWhkvkmhvHMk0ESPwi7NHz5Bzq8loj
 LF7/ZrfduaiuA03R2iU6t/iQGcG+wbs=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-M_0S8UrcMdCdQPmp11OloA-1; Fri, 01 Mar 2024 15:05:09 -0500
X-MC-Unique: M_0S8UrcMdCdQPmp11OloA-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-dcc05887ee9so3835797276.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 12:05:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709323509; x=1709928309;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K8ROXt87b41leJzrs1qawudk/3ANLOKhm3rIOBD7Src=;
 b=pQiqcE46vuGrx0+YGwIc/Q9k1gstblwMh5DW+5It9TDmngNQ2YvNvH7+5j446cUbM6
 d4ZbirvAGkNJ0w1L0KrAO8JoyXKbAWC+2mLwUgVg++zNU2T5BHPIpADuGnapJo0HIBnr
 BV5CcyQqdlZX9A2bVOA0Th9eMsfNHGujMfYACNt9NCucej52xfNk01hSUMOqs/hbFjOx
 DGIlFE27hH3gVh14CmZ7OHLHbKfA+x1lndPf9MAFK2wJcshPAQgkvdolImJby7kuIZSQ
 pMEQnaP4YDviXDDZuS7Eo3KmYY5kadnPj1nQEh2jiftSXllyb903NjcKzAdYZKQrbzhX
 BzjA==
X-Gm-Message-State: AOJu0Yw8i4O3qE4YVd015sabXU4yJEwxVWnInNmVDNNHQVsO3zz6Ra06
 Jwo8dQbou+qIXqLxQdrk4Ef/MT0KZ3TXLTbvGyfXpoRbVnckuPwaPUuhSVvbQVZm1gJqXXleZXS
 HvOX8MlxLwKLimA6w3fH+ZqCQbvCelcm2Qz69BebCLEfELO+Y7wnzEHVS00E9V4uDpV4RtWcv+5
 YSHlXTOeLJSY8V90diSfWk92SJTxo=
X-Received: by 2002:a25:d092:0:b0:dcd:a28e:e5e0 with SMTP id
 h140-20020a25d092000000b00dcda28ee5e0mr2451346ybg.25.1709323509330; 
 Fri, 01 Mar 2024 12:05:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5TcnCVv6iSZnCkGwsdCpzXD9prVZ0M6KM4DYmuVzRCgZBCAOHCwn7854IQHOU8gcLVdj6jPCYMzve35ofmOU=
X-Received: by 2002:a25:d092:0:b0:dcd:a28e:e5e0 with SMTP id
 h140-20020a25d092000000b00dcda28ee5e0mr2451321ybg.25.1709323509061; Fri, 01
 Mar 2024 12:05:09 -0800 (PST)
MIME-Version: 1.0
References: <20240301134330.4191007-1-jonah.palmer@oracle.com>
 <20240301134330.4191007-8-jonah.palmer@oracle.com>
In-Reply-To: <20240301134330.4191007-8-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 1 Mar 2024 21:04:33 +0100
Message-ID: <CAJaqyWfUk4m6pJGmGN9A5k7Eqb=eDjVk26udo_hanCOv9FjHEw@mail.gmail.com>
Subject: Re: [RFC 7/8] vhost/vhost-user: Add VIRTIO_F_NOTIFICATION_DATA to
 vhost feature bits
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, raphael@enfabrica.net, 
 kwolf@redhat.com, hreitz@redhat.com, pasic@linux.ibm.com, 
 borntraeger@linux.ibm.com, farman@linux.ibm.com, thuth@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com, 
 cohuck@redhat.com, pbonzini@redhat.com, fam@euphon.net, stefanha@redhat.com, 
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, virtio-fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On Fri, Mar 1, 2024 at 2:44=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.co=
m> wrote:
>
> Add support for the VIRTIO_F_NOTIFICATION_DATA feature across a variety
> of vhost devices.
>
> The inclusion of VIRTIO_F_NOTIFICATION_DATA in the feature bits arrays
> for these devices ensures that the backend is capable of offering and
> providing support for this feature, and that it can be disabled if the
> backend does not support it.
>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  hw/block/vhost-user-blk.c    | 1 +
>  hw/net/vhost_net.c           | 2 ++
>  hw/scsi/vhost-scsi.c         | 1 +
>  hw/scsi/vhost-user-scsi.c    | 1 +
>  hw/virtio/vhost-user-fs.c    | 2 +-
>  hw/virtio/vhost-user-vsock.c | 1 +
>  net/vhost-vdpa.c             | 1 +
>  7 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 6a856ad51a..983c0657da 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -51,6 +51,7 @@ static const int user_feature_bits[] =3D {
>      VIRTIO_F_RING_PACKED,
>      VIRTIO_F_IOMMU_PLATFORM,
>      VIRTIO_F_RING_RESET,
> +    VIRTIO_F_NOTIFICATION_DATA,
>      VHOST_INVALID_FEATURE_BIT
>  };
>
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index e8e1661646..bb1f975b39 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -48,6 +48,7 @@ static const int kernel_feature_bits[] =3D {
>      VIRTIO_F_IOMMU_PLATFORM,
>      VIRTIO_F_RING_PACKED,
>      VIRTIO_F_RING_RESET,
> +    VIRTIO_F_NOTIFICATION_DATA,
>      VIRTIO_NET_F_HASH_REPORT,
>      VHOST_INVALID_FEATURE_BIT
>  };
> @@ -55,6 +56,7 @@ static const int kernel_feature_bits[] =3D {
>  /* Features supported by others. */
>  static const int user_feature_bits[] =3D {
>      VIRTIO_F_NOTIFY_ON_EMPTY,
> +    VIRTIO_F_NOTIFICATION_DATA,
>      VIRTIO_RING_F_INDIRECT_DESC,
>      VIRTIO_RING_F_EVENT_IDX,
>

vdpa_feature_bits also needs this feature bit added.

Apart from that,

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index 58a00336c2..b8048f18e9 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -38,6 +38,7 @@ static const int kernel_feature_bits[] =3D {
>      VIRTIO_RING_F_EVENT_IDX,
>      VIRTIO_SCSI_F_HOTPLUG,
>      VIRTIO_F_RING_RESET,
> +    VIRTIO_F_NOTIFICATION_DATA,
>      VHOST_INVALID_FEATURE_BIT
>  };
>
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index a63b1f4948..0b050805a8 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -36,6 +36,7 @@ static const int user_feature_bits[] =3D {
>      VIRTIO_RING_F_EVENT_IDX,
>      VIRTIO_SCSI_F_HOTPLUG,
>      VIRTIO_F_RING_RESET,
> +    VIRTIO_F_NOTIFICATION_DATA,
>      VHOST_INVALID_FEATURE_BIT
>  };
>
> diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
> index cca2cd41be..ae48cc1c96 100644
> --- a/hw/virtio/vhost-user-fs.c
> +++ b/hw/virtio/vhost-user-fs.c
> @@ -33,7 +33,7 @@ static const int user_feature_bits[] =3D {
>      VIRTIO_F_RING_PACKED,
>      VIRTIO_F_IOMMU_PLATFORM,
>      VIRTIO_F_RING_RESET,
> -
> +    VIRTIO_F_NOTIFICATION_DATA,
>      VHOST_INVALID_FEATURE_BIT
>  };
>
> diff --git a/hw/virtio/vhost-user-vsock.c b/hw/virtio/vhost-user-vsock.c
> index 9431b9792c..802b44a07d 100644
> --- a/hw/virtio/vhost-user-vsock.c
> +++ b/hw/virtio/vhost-user-vsock.c
> @@ -21,6 +21,7 @@ static const int user_feature_bits[] =3D {
>      VIRTIO_RING_F_INDIRECT_DESC,
>      VIRTIO_RING_F_EVENT_IDX,
>      VIRTIO_F_NOTIFY_ON_EMPTY,
> +    VIRTIO_F_NOTIFICATION_DATA,
>      VHOST_INVALID_FEATURE_BIT
>  };
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 3726ee5d67..2827d29ce7 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -62,6 +62,7 @@ const int vdpa_feature_bits[] =3D {
>      VIRTIO_F_RING_PACKED,
>      VIRTIO_F_RING_RESET,
>      VIRTIO_F_VERSION_1,
> +    VIRTIO_F_NOTIFICATION_DATA,
>      VIRTIO_NET_F_CSUM,
>      VIRTIO_NET_F_CTRL_GUEST_OFFLOADS,
>      VIRTIO_NET_F_CTRL_MAC_ADDR,
> --
> 2.39.3
>


