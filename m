Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7825CC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 18:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUVEY-0000ie-02; Wed, 25 Jun 2025 14:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uUVEV-0000iT-2t
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 14:52:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uUVES-0007Lu-O8
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 14:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750877544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ZUSNGE/gIcxEGHmOnmuOdVHjx0Pa7IqPKZAThSrAtU=;
 b=XwW48x89dP3l9Aw2q/8XVav76qiWyE6lBDCq5Z1EvRxSN1nehakcRdllkJGibZJDp1Rwp9
 mA36s9yVnUmFsXQTsbL3R3+dq8JjFnmfwdN5383iRSGfBTy2iB9SYAo8f3KODQydUUy/ru
 2Cd1v8/OWYR2kNgumF7CqEdDYGYWWIo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-cdwRtBhUMh2qmpyoCx0S6w-1; Wed,
 25 Jun 2025 14:52:19 -0400
X-MC-Unique: cdwRtBhUMh2qmpyoCx0S6w-1
X-Mimecast-MFC-AGG-ID: cdwRtBhUMh2qmpyoCx0S6w_1750877538
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D92B1809C91; Wed, 25 Jun 2025 18:52:17 +0000 (UTC)
Received: from localhost (unknown [10.2.17.63])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EC5D31956094; Wed, 25 Jun 2025 18:52:15 +0000 (UTC)
Date: Wed, 25 Jun 2025 12:47:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, slp@redhat.com, david@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, jasowang@redhat.com,
 stevensd@chromium.org, hi@alyssa.is,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v5 7/7] vhost-user-devive: Add shmem BAR
Message-ID: <20250625164710.GC19307@fedora>
References: <20250609144729.884027-1-aesteve@redhat.com>
 <20250609144729.884027-8-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wYnWEEHTW0mRTMjm"
Content-Disposition: inline
In-Reply-To: <20250609144729.884027-8-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--wYnWEEHTW0mRTMjm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 09, 2025 at 04:47:29PM +0200, Albert Esteve wrote:
> diff --git a/hw/virtio/vhost-user-device-pci.c b/hw/virtio/vhost-user-dev=
ice-pci.c
> index f10bac874e..eeb52671a0 100644
> --- a/hw/virtio/vhost-user-device-pci.c
> +++ b/hw/virtio/vhost-user-device-pci.c
> @@ -8,14 +8,18 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qapi/error.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/virtio/vhost-user-base.h"
>  #include "hw/virtio/virtio-pci.h"
> =20
> +#define VIRTIO_DEVICE_PCI_SHMEM_BAR 2

This BAR number conflicts with `--device
vhost-user-device-pci,modern-pio-notify=3Don`. Please take a look at the
how other devices using VIRTIO Shared Memory arrange BARs.

> +
>  struct VHostUserDevicePCI {
>      VirtIOPCIProxy parent_obj;
> =20
>      VHostUserBase vub;
> +    MemoryRegion shmembar;
>  };
> =20
>  #define TYPE_VHOST_USER_DEVICE_PCI "vhost-user-device-pci-base"
> @@ -25,10 +29,36 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VHOST_=
USER_DEVICE_PCI)
>  static void vhost_user_device_pci_realize(VirtIOPCIProxy *vpci_dev, Erro=
r **errp)
>  {
>      VHostUserDevicePCI *dev =3D VHOST_USER_DEVICE_PCI(vpci_dev);
> -    DeviceState *vdev =3D DEVICE(&dev->vub);
> +    DeviceState *dev_state =3D DEVICE(&dev->vub);
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev_state);
> +    VirtSharedMemory *shmem, *next;
> +    uint64_t offset =3D 0, shmem_size =3D 0;
> =20
>      vpci_dev->nvectors =3D 1;
> -    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> +    qdev_realize(dev_state, BUS(&vpci_dev->bus), errp);
> +
> +    QSIMPLEQ_FOREACH_SAFE(shmem, &vdev->shmem_list, entry, next) {
> +        if (shmem->mr->size > UINT64_MAX - shmem_size) {
> +            error_setg(errp, "Total shared memory required overflow");
> +            return;
> +        }
> +        shmem_size =3D shmem_size + shmem->mr->size;
> +    }
> +    if (shmem_size) {
> +        memory_region_init(&dev->shmembar, OBJECT(vpci_dev),
> +                           "vhost-device-pci-shmembar", shmem_size);
> +        QSIMPLEQ_FOREACH_SAFE(shmem, &vdev->shmem_list, entry, next) {
> +            memory_region_add_subregion(&dev->shmembar, offset, shmem->m=
r);
> +            virtio_pci_add_shm_cap(vpci_dev, VIRTIO_DEVICE_PCI_SHMEM_BAR,
> +                                   offset, shmem->mr->size, 0);

The last argument is the shmid. It cannot be hardcoded to 0.

> +            offset =3D offset + shmem->mr->size;
> +        }
> +        pci_register_bar(&vpci_dev->pci_dev, VIRTIO_DEVICE_PCI_SHMEM_BAR,
> +                        PCI_BASE_ADDRESS_SPACE_MEMORY |
> +                        PCI_BASE_ADDRESS_MEM_PREFETCH |
> +                        PCI_BASE_ADDRESS_MEM_TYPE_64,
> +                        &dev->shmembar);
> +    }
>  }
> =20
>  static void vhost_user_device_pci_class_init(ObjectClass *klass,
> --=20
> 2.49.0
>=20

--wYnWEEHTW0mRTMjm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhcKA0ACgkQnKSrs4Gr
c8igXgf7BjLHpgR+pflZ/jICbbdryeh0ZsAExTifg/yQr07ptNYicdGd1xB2heIw
KMDdmCpX6/pve+R/K5zzD+9S8i2K/uHw+d8XnqqT3qs37pzfvVeEEYbAb5cyIOS4
fS7ZRdC0MxC1uTsvPbLoqPb5PCoDS3pFhzehFMlU7eNOnl6Tklr6lIpH6e2+xLHt
ZCRCBbcH5N4CUBqnXzNc0nRwN0EKD5Sgb6/PrY6/NlXncvWaDofUuSKoy2iQ/sjl
hcHJe2TinJnUwu/Pm/Ua9+m/yYC5XQFcGY4y3nM+1gT/79f7TjwXtX8ynaJcQQbm
vxz9Dd9SlHGFM/lpt8wrN9l+ij79XA==
=0sQJ
-----END PGP SIGNATURE-----

--wYnWEEHTW0mRTMjm--


