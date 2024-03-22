Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B13C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 10:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rncRs-00075D-1E; Fri, 22 Mar 2024 06:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rncRp-00070o-SZ
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 06:48:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rncRl-00045k-Bu
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 06:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711104504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9CJYsnhAl8UY2RPXfcbetaDbP2VSkH6ediVBvyZl/oI=;
 b=WJ9A7YihLGwt2vFR7/bWjryeIqKBzCDW4AzDNfHnZ4PuOYY0h/GapvmLxeWt/xrFCP812M
 URGc4nJQXn7frtFNF74cRRfqUwxi/fKKmU/pfVwI+cBHIkN09fzQDQMu5Le71YEWhS4ZuW
 UZOP2J++GQURV29culNt/4uNYVcSZ4U=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-evdt1KfbNharQypvHQAx3Q-1; Fri, 22 Mar 2024 06:48:23 -0400
X-MC-Unique: evdt1KfbNharQypvHQAx3Q-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-607838c0800so32054227b3.1
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 03:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711104502; x=1711709302;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9CJYsnhAl8UY2RPXfcbetaDbP2VSkH6ediVBvyZl/oI=;
 b=Cvf08Nvqv582jqA5iMMfntzFc9jwLv66AF7TFEr6eRESIuFZBY2edM/gXc9H6oFbvT
 KZJRBTf8mlNFuYn98xvvdP4FzVKE3cWo0QHC5QE+nUB/kpRU8FJocd17bl8t35MZVnNA
 RGGrK0Hn2/XwmluqUJ1kYROqlOs2YaYDfEP0o6aIlL1qKGO6XzfEqK/qVGdIU5GI6xoG
 k/G/YWRTfELf6+h1MpQKwVP+ZGso6JOd0mtarx+XJ5g8B7HIjFHpFOK99dMgDYOtgHVY
 cNxXTRzmN04mWrkN9mSmAvuFjetkN0vD0fTyo7FkVnBLWqh7htMWOdgb7e19Fmu6BAQl
 tCiw==
X-Gm-Message-State: AOJu0YzDss5Cu8D+ZRBMAwP6mFE7/w2vkHrZbp/Ui5YPVVjnsmTELnRc
 85vBhSZ370AazR0F5tBzZ7ctmxP7GPDW1IkT7lrUlBmKngGrGVgY2lXOhIjKXoGP9bxTmiJQXCR
 TP5quoIvrex3XdY6qiKOFYwpnwIAxNZFmfJi9txqgki24whG8uGcuL/S2+Ni8FIqaN4Ytoke00F
 7nMI3mvaLjyrcy9F/EwwwhFg4WFboeJkb4gJQN1A==
X-Received: by 2002:a25:ab09:0:b0:dcd:b806:7446 with SMTP id
 u9-20020a25ab09000000b00dcdb8067446mr940521ybi.1.1711104502520; 
 Fri, 22 Mar 2024 03:48:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfZyAKvutxjWCIs+Th3hwaOESysJOUIhpwxG0X4ClKckVHXaKMnfdVLLSnvVVaawv7VteEJUvPEiKiVHsZqjc=
X-Received: by 2002:a25:ab09:0:b0:dcd:b806:7446 with SMTP id
 u9-20020a25ab09000000b00dcdb8067446mr940509ybi.1.1711104502282; Fri, 22 Mar
 2024 03:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240321155717.1392787-1-jonah.palmer@oracle.com>
 <20240321155717.1392787-8-jonah.palmer@oracle.com>
In-Reply-To: <20240321155717.1392787-8-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 22 Mar 2024 11:47:46 +0100
Message-ID: <CAJaqyWe=cn79VGbtGGdy9vJs0pCs_Q3cWQ5snofOUN_97_YgKw@mail.gmail.com>
Subject: Re: [RFC 7/8] vhost/vhost-user: Add VIRTIO_F_IN_ORDER to vhost
 feature bits
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, raphael@enfabrica.net, 
 kwolf@redhat.com, hreitz@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, 
 fam@euphon.net, stefanha@redhat.com, qemu-block@nongnu.org, 
 schalla@marvell.com, leiyang@redhat.com, virtio-fs@lists.linux.dev, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Mar 21, 2024 at 4:57=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
> Add support for the VIRTIO_F_IN_ORDER feature across a variety of vhost
> devices.
>
> The inclusion of VIRTIO_F_IN_ORDER in the feature bits arrays for these
> devices ensures that the backend is capable of offering and providing
> support for this feature, and that it can be disabled if the backend
> does not support it.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  hw/block/vhost-user-blk.c    | 1 +
>  hw/net/vhost_net.c           | 2 ++
>  hw/scsi/vhost-scsi.c         | 1 +
>  hw/scsi/vhost-user-scsi.c    | 1 +
>  hw/virtio/vhost-user-fs.c    | 1 +
>  hw/virtio/vhost-user-vsock.c | 1 +
>  net/vhost-vdpa.c             | 1 +
>  7 files changed, 8 insertions(+)
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 6a856ad51a..d176ed857e 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -51,6 +51,7 @@ static const int user_feature_bits[] =3D {
>      VIRTIO_F_RING_PACKED,
>      VIRTIO_F_IOMMU_PLATFORM,
>      VIRTIO_F_RING_RESET,
> +    VIRTIO_F_IN_ORDER,
>      VHOST_INVALID_FEATURE_BIT
>  };
>
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index e8e1661646..33d1d4b9d3 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -48,6 +48,7 @@ static const int kernel_feature_bits[] =3D {
>      VIRTIO_F_IOMMU_PLATFORM,
>      VIRTIO_F_RING_PACKED,
>      VIRTIO_F_RING_RESET,
> +    VIRTIO_F_IN_ORDER,
>      VIRTIO_NET_F_HASH_REPORT,
>      VHOST_INVALID_FEATURE_BIT
>  };
> @@ -76,6 +77,7 @@ static const int user_feature_bits[] =3D {
>      VIRTIO_F_IOMMU_PLATFORM,
>      VIRTIO_F_RING_PACKED,
>      VIRTIO_F_RING_RESET,
> +    VIRTIO_F_IN_ORDER,
>      VIRTIO_NET_F_RSS,
>      VIRTIO_NET_F_HASH_REPORT,
>      VIRTIO_NET_F_GUEST_USO4,
> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index ae26bc19a4..40e7630191 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -38,6 +38,7 @@ static const int kernel_feature_bits[] =3D {
>      VIRTIO_RING_F_EVENT_IDX,
>      VIRTIO_SCSI_F_HOTPLUG,
>      VIRTIO_F_RING_RESET,
> +    VIRTIO_F_IN_ORDER,
>      VHOST_INVALID_FEATURE_BIT
>  };
>
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index a63b1f4948..1d59951ab7 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -36,6 +36,7 @@ static const int user_feature_bits[] =3D {
>      VIRTIO_RING_F_EVENT_IDX,
>      VIRTIO_SCSI_F_HOTPLUG,
>      VIRTIO_F_RING_RESET,
> +    VIRTIO_F_IN_ORDER,
>      VHOST_INVALID_FEATURE_BIT
>  };
>
> diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
> index cca2cd41be..9243dbb128 100644
> --- a/hw/virtio/vhost-user-fs.c
> +++ b/hw/virtio/vhost-user-fs.c
> @@ -33,6 +33,7 @@ static const int user_feature_bits[] =3D {
>      VIRTIO_F_RING_PACKED,
>      VIRTIO_F_IOMMU_PLATFORM,
>      VIRTIO_F_RING_RESET,
> +    VIRTIO_F_IN_ORDER,
>
>      VHOST_INVALID_FEATURE_BIT
>  };
> diff --git a/hw/virtio/vhost-user-vsock.c b/hw/virtio/vhost-user-vsock.c
> index 9431b9792c..cc7e4e47b4 100644
> --- a/hw/virtio/vhost-user-vsock.c
> +++ b/hw/virtio/vhost-user-vsock.c
> @@ -21,6 +21,7 @@ static const int user_feature_bits[] =3D {
>      VIRTIO_RING_F_INDIRECT_DESC,
>      VIRTIO_RING_F_EVENT_IDX,
>      VIRTIO_F_NOTIFY_ON_EMPTY,
> +    VIRTIO_F_IN_ORDER,
>      VHOST_INVALID_FEATURE_BIT
>  };
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 85e73dd6a7..ed3185acfa 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -62,6 +62,7 @@ const int vdpa_feature_bits[] =3D {
>      VIRTIO_F_RING_PACKED,
>      VIRTIO_F_RING_RESET,
>      VIRTIO_F_VERSION_1,
> +    VIRTIO_F_IN_ORDER,
>      VIRTIO_NET_F_CSUM,
>      VIRTIO_NET_F_CTRL_GUEST_OFFLOADS,
>      VIRTIO_NET_F_CTRL_MAC_ADDR,
> --
> 2.39.3
>


