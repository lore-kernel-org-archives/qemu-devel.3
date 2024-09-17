Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD12C35FF3
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 08:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqTZ8-00028c-4F; Tue, 17 Sep 2024 04:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sqTZ6-000283-30
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 04:28:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sqTZ4-0004nR-9x
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 04:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726561680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lu4wF/EFqXuHajRRX+VXC9g3ZKvzyuHU9vNx71P1bw4=;
 b=G0XUdG4ktpwR1w51JIy9f3bTOnQbE3lOwAvl4zZk88FT4Gu6T8t1QlAPs44zcrmMJ+2X0W
 iaaKdrcCd/FMsUuVN6oJj1Thwg6MH/k0buLiSMoceQAmtaQfhUtXTuxiuwlHJlpq8P1vr2
 f6d2/LP8syU8qdysbigBAHnkDdgGpZw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-RdyMaU_WP-aTVdOTjvginA-1; Tue,
 17 Sep 2024 04:27:56 -0400
X-MC-Unique: RdyMaU_WP-aTVdOTjvginA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C533C1955D44; Tue, 17 Sep 2024 08:27:54 +0000 (UTC)
Received: from localhost (unknown [10.2.16.41])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D84730001A1; Tue, 17 Sep 2024 08:27:52 +0000 (UTC)
Date: Tue, 17 Sep 2024 10:27:51 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 slp@redhat.com, hi@alyssa.is, mst@redhat.com, david@redhat.com,
 jasowang@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
 stevensd@chromium.org
Subject: Re: [PATCH v3 4/5] vhost-user-dev: Add cache BAR
Message-ID: <20240917082751.GD575885@fedora.redhat.com>
References: <20240912145335.129447-1-aesteve@redhat.com>
 <20240912145335.129447-5-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AgX8e14WeGQrpK21"
Content-Disposition: inline
In-Reply-To: <20240912145335.129447-5-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--AgX8e14WeGQrpK21
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 04:53:34PM +0200, Albert Esteve wrote:
> Add a cache BAR in the vhost-user-device
> into which files can be directly mapped.
>=20
> The number, shmid, and size of the VIRTIO Shared
> Memory subregions is retrieved through a get_shmem_config
> message sent by the vhost-user-base module
> on the realize step, after virtio_init().
>=20
> By default, if VHOST_USER_PROTOCOL_F_SHMEM
> feature is not supported by the backend,
> there is no cache.
>=20
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---

Not all devices derive from vhost-user-base.c so this does not offer
full coverage. I think that's okay since few devices currently use
VIRTIO Shared Memory Regions. A note about this in the commit
description would be useful though. Which vhost-user devices gain VIRTIO
Shared Memory Region support and what should you do if your device is
not included in this list?

>  hw/virtio/vhost-user-base.c       | 37 +++++++++++++++++++++++++++--
>  hw/virtio/vhost-user-device-pci.c | 39 ++++++++++++++++++++++++++++---
>  2 files changed, 71 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> index 2bc3423326..f2597d021a 100644
> --- a/hw/virtio/vhost-user-base.c
> +++ b/hw/virtio/vhost-user-base.c
> @@ -271,7 +271,9 @@ static void vub_device_realize(DeviceState *dev, Erro=
r **errp)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>      VHostUserBase *vub =3D VHOST_USER_BASE(dev);
> -    int ret;
> +    uint64_t memory_sizes[8];
> +    void *cache_ptr;
> +    int i, ret, nregions;
> =20
>      if (!vub->chardev.chr) {
>          error_setg(errp, "vhost-user-base: missing chardev");
> @@ -314,7 +316,7 @@ static void vub_device_realize(DeviceState *dev, Erro=
r **errp)
> =20
>      /* Allocate queues */
>      vub->vqs =3D g_ptr_array_sized_new(vub->num_vqs);
> -    for (int i =3D 0; i < vub->num_vqs; i++) {
> +    for (i =3D 0; i < vub->num_vqs; i++) {
>          g_ptr_array_add(vub->vqs,
>                          virtio_add_queue(vdev, vub->vq_size,
>                                           vub_handle_output));
> @@ -331,6 +333,37 @@ static void vub_device_realize(DeviceState *dev, Err=
or **errp)
>          do_vhost_user_cleanup(vdev, vub);

Missing return statement.

>      }
> =20
> +    ret =3D vub->vhost_dev.vhost_ops->vhost_get_shmem_config(&vub->vhost=
_dev,
> +                                                           &nregions,
> +                                                           memory_sizes,

Buffer overflow. vhost_get_shmem_config() copies out up to 256
memory_sizes[] elements. Please introduce a constant in the VIRTIO
header and use it instead of hardcoding uint64_t memory_sizes[8] above.

> +                                                           errp);
> +
> +    if (ret < 0) {
> +        do_vhost_user_cleanup(vdev, vub);

Missing return statement.

> +    }
> +
> +    for (i =3D 0; i < nregions; i++) {
> +        if (memory_sizes[i]) {
> +            if (memory_sizes[i] % qemu_real_host_page_size() !=3D 0) {
> +                error_setg(errp, "Shared memory %d size must be a power =
of 2 "
> +                                 "no smaller than the page size", i);
> +                return;

Missing do_vhost_user_cleanup().

> +            }
> +
> +            cache_ptr =3D mmap(NULL, memory_sizes[i], PROT_NONE,
> +                            MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);



> +            if (cache_ptr =3D=3D MAP_FAILED) {
> +                error_setg_errno(errp, errno, "Unable to mmap blank cach=
e");
> +                return;

Missing do_vhost_user_cleanup().

> +            }
> +
> +            virtio_new_shmem_region(vdev);
> +            memory_region_init_ram_ptr(vdev->shmem_list[i].mr,
> +                                       OBJECT(vdev), "vub-shm-" + i,
> +                                       memory_sizes[i], cache_ptr);

I think memory_region_init_ram_ptr() is included in live migration, so
the contents of VIRTIO Shared Memory Regions will be transferred to the
destination QEMU and written to the equivalent memory region there. I'm
not sure this works:
1. If there are PROT_NONE memory ranges, then live migration will
   probably crash the source QEMU while trying to send this memory to
   the destination QEMU.
2. If the destination vhost-user device has not yet loaded its state and
   sent MAP messages setting up the VIRTIO Shared Memory Region, then
   receiving migrated data and writing it into this memory will fail.

QEMU has a migration blocker API so that devices can refuse live
migration. For the time being a migration blocker is probably needed
here. See migrate_add_blocker()/migrate_del_blocker().

> +        }
> +    }
> +
>      qemu_chr_fe_set_handlers(&vub->chardev, NULL, NULL, vub_event, NULL,
>                               dev, NULL, true);
>  }
> diff --git a/hw/virtio/vhost-user-device-pci.c b/hw/virtio/vhost-user-dev=
ice-pci.c
> index efaf55d3dd..abf4e90c21 100644
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
> +#define VIRTIO_DEVICE_PCI_CACHE_BAR 2

"Cache" is ambigous. Call it shmem_bar here and everywhere else?

> +
>  struct VHostUserDevicePCI {
>      VirtIOPCIProxy parent_obj;
> =20
>      VHostUserBase vub;
> +    MemoryRegion cachebar;
>  };
> =20
>  #define TYPE_VHOST_USER_DEVICE_PCI "vhost-user-device-pci-base"
> @@ -25,10 +29,39 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VHOST_=
USER_DEVICE_PCI)
>  static void vhost_user_device_pci_realize(VirtIOPCIProxy *vpci_dev, Erro=
r **errp)
>  {
>      VHostUserDevicePCI *dev =3D VHOST_USER_DEVICE_PCI(vpci_dev);
> -    DeviceState *vdev =3D DEVICE(&dev->vub);
> -
> +    DeviceState *dev_state =3D DEVICE(&dev->vub);
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev_state);
> +    MemoryRegion *mr;
> +    uint64_t offset =3D 0, cache_size =3D 0;
> +    int i;
> +   =20
>      vpci_dev->nvectors =3D 1;
> -    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> +    qdev_realize(dev_state, BUS(&vpci_dev->bus), errp);
> +
> +    for (i =3D 0; i < vdev->n_shmem_regions; i++) {
> +        mr =3D vdev->shmem_list[i].mr;
> +        if (mr->size > UINT64_MAX - cache_size) {
> +            error_setg(errp, "Total shared memory required overflow");
> +            return;
> +        }
> +        cache_size =3D cache_size + mr->size;
> +    }
> +    if (cache_size) {
> +        memory_region_init(&dev->cachebar, OBJECT(vpci_dev),
> +                           "vhost-device-pci-cachebar", cache_size);
> +        for (i =3D 0; i < vdev->n_shmem_regions; i++) {
> +            mr =3D vdev->shmem_list[i].mr;
> +            memory_region_add_subregion(&dev->cachebar, offset, mr);
> +            virtio_pci_add_shm_cap(vpci_dev, VIRTIO_DEVICE_PCI_CACHE_BAR,
> +                                   offset, mr->size, i);
> +            offset =3D offset + mr->size;
> +        }
> +        pci_register_bar(&vpci_dev->pci_dev, VIRTIO_DEVICE_PCI_CACHE_BAR,
> +                        PCI_BASE_ADDRESS_SPACE_MEMORY |
> +                        PCI_BASE_ADDRESS_MEM_PREFETCH |
> +                        PCI_BASE_ADDRESS_MEM_TYPE_64,
> +                        &dev->cachebar);
> +    }
>  }
> =20
>  static void vhost_user_device_pci_class_init(ObjectClass *klass, void *d=
ata)
> --=20
> 2.45.2
>=20

--AgX8e14WeGQrpK21
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmbpPYcACgkQnKSrs4Gr
c8gfWAf+I9Eo8/bSzIKu42uzytQMLF75ZLk0+VSTGPihocOmWanwnip00QqhnZ1S
BPktaECEuzDFpFPI+i6lhgqtBQF3tsffBRBnSB0+K/+kCEoPO3ogIpTCFnb0A314
TqBW7xdUJMMfhHHvjTyU63kvqDrvFwcmVzdJePKLrx69qy4Mw6qFO09H8V6spJim
qRYh838KRNOr+mxl0oBUuG464f5zhzv5mvA58IX1Ez44/JHVaR6Tm2B70WqllOp1
aOOnKp447UikX15hBu9REyB9V1PdXBe5RuS2wsrTEVSnDyOMQv3Ys7mrz9jm7+hv
zKrvmz1DLbUDqlN6MlObqxIwbz56pA==
=Xj4E
-----END PGP SIGNATURE-----

--AgX8e14WeGQrpK21--


