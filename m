Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D89C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 10:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkL2l-0005Zl-Pp; Tue, 18 Feb 2025 05:41:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tkL2h-0005ZH-Pp
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 05:41:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tkL2f-0001Zw-Af
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 05:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739875288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TLHjBGYca3Ffr1NGZQ0h/Uyv8KnIn+i45mhfdAT6FT4=;
 b=ax9v/OJ9hOvtjRZpghGVE6BsQ0yDyR+RJa+Bu/rmPlf5pT4wGcOoEKZw0jf0Z68cT0FS1A
 Zx7I1eOBYch4zftlWFC3WC3J7xHdN9xnTIJxI8oPC5P/hjUIma1bR8JWi2SEchvivnIpWl
 Q95EnML1EocQFBYqd5Y7R5vhtIx+Zjk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-RiVlZCkfOs26dQQqhoi5Cg-1; Tue,
 18 Feb 2025 05:41:22 -0500
X-MC-Unique: RiVlZCkfOs26dQQqhoi5Cg-1
X-Mimecast-MFC-AGG-ID: RiVlZCkfOs26dQQqhoi5Cg_1739875281
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BDBE18EB2C3; Tue, 18 Feb 2025 10:41:21 +0000 (UTC)
Received: from localhost (unknown [10.2.16.24])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F34D1956094; Tue, 18 Feb 2025 10:41:19 +0000 (UTC)
Date: Tue, 18 Feb 2025 18:41:16 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, slp@redhat.com, stevensd@chromium.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, david@redhat.com,
 hi@alyssa.is, mst@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH v4 7/9] vhost-user-devive: Add shmem BAR
Message-ID: <20250218104116.GK10767@fedora>
References: <20250217164012.246727-1-aesteve@redhat.com>
 <20250217164012.246727-8-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EN7sjCqoiyNwOvIl"
Content-Disposition: inline
In-Reply-To: <20250217164012.246727-8-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


--EN7sjCqoiyNwOvIl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 05:40:10PM +0100, Albert Esteve wrote:
> Add a shmem BAR block in the vhost-user-device,
> which files can be directly mapped into.
>=20
> The number, shmid, and size of the VIRTIO Shared
> Memory subregions is retrieved through a
> get_shmem_config message sent by the
> vhost-user-base module on the realize step,
> after virtio_init().
>=20
> By default, if VHOST_USER_PROTOCOL_F_SHMEM
> feature is not supported by the backend,
> there is no cache.
>=20
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  hw/virtio/vhost-user-base.c       | 47 +++++++++++++++++++++++++++++--
>  hw/virtio/vhost-user-device-pci.c | 36 +++++++++++++++++++++--
>  2 files changed, 78 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> index 2bc3423326..8d4bca98a8 100644
> --- a/hw/virtio/vhost-user-base.c
> +++ b/hw/virtio/vhost-user-base.c
> @@ -16,6 +16,7 @@
>  #include "hw/virtio/virtio-bus.h"
>  #include "hw/virtio/vhost-user-base.h"
>  #include "qemu/error-report.h"
> +#include "migration/blocker.h"
> =20
>  static void vub_start(VirtIODevice *vdev)
>  {
> @@ -271,7 +272,8 @@ static void vub_device_realize(DeviceState *dev, Erro=
r **errp)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>      VHostUserBase *vub =3D VHOST_USER_BASE(dev);
> -    int ret;
> +    uint64_t memory_sizes[VIRTIO_MAX_SHMEM_REGIONS];
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
> @@ -328,11 +330,50 @@ static void vub_device_realize(DeviceState *dev, Er=
ror **errp)
>                           VHOST_BACKEND_TYPE_USER, 0, errp);
> =20
>      if (ret < 0) {
> -        do_vhost_user_cleanup(vdev, vub);
> +        goto err;
> +    }
> +
> +    ret =3D vub->vhost_dev.vhost_ops->vhost_get_shmem_config(&vub->vhost=
_dev,
> +                                                           &nregions,
> +                                                           memory_sizes,
> +                                                           errp);
> +
> +    if (ret < 0) {
> +        goto err;
> +    }
> +
> +    for (i =3D 0; i < nregions; i++) {
> +        if (memory_sizes[i]) {
> +            if (vub->vhost_dev.migration_blocker =3D=3D NULL) {
> +                error_setg(&vub->vhost_dev.migration_blocker,
> +                       "Migration disabled: devices with VIRTIO Shared M=
emory "
> +                       "Regions do not support migration yet.");
> +                ret =3D migrate_add_blocker_normal(
> +                    &vub->vhost_dev.migration_blocker,
> +                    errp);
> +
> +                if (ret < 0) {
> +                    goto err;
> +                }
> +            }
> +
> +            if (memory_sizes[i] % qemu_real_host_page_size() !=3D 0) {
> +                error_setg(errp, "Shared memory %d size must be a power =
of 2 "
> +                                 "no smaller than the page size", i);
> +                goto err;
> +            }
> +
> +            memory_region_init(virtio_new_shmem_region(vdev)->mr,

Does this code support non-contiguous shmids? For example, if a device
has two Shared Memory Regions defined in its spec but the first one is
optional, then the device might have memory_sizes[0] =3D=3D 0 and
memory_sizes[1] > 0. In that case the Shared Memory Region must have
shmid 1 and not shmid 0.

> +                               OBJECT(vdev), "vub-shm-" + i,
> +                               memory_sizes[i]);
> +        }
>      }
> =20
>      qemu_chr_fe_set_handlers(&vub->chardev, NULL, NULL, vub_event, NULL,
>                               dev, NULL, true);
> +    return;
> +err:
> +    do_vhost_user_cleanup(vdev, vub);
>  }
> =20
>  static void vub_device_unrealize(DeviceState *dev)
> diff --git a/hw/virtio/vhost-user-device-pci.c b/hw/virtio/vhost-user-dev=
ice-pci.c
> index efaf55d3dd..f215cae925 100644
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
> +
>  struct VHostUserDevicePCI {
>      VirtIOPCIProxy parent_obj;
> =20
>      VHostUserBase vub;
> +    MemoryRegion shmembar;
>  };
> =20
>  #define TYPE_VHOST_USER_DEVICE_PCI "vhost-user-device-pci-base"
> @@ -25,10 +29,38 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VHOST_=
USER_DEVICE_PCI)
>  static void vhost_user_device_pci_realize(VirtIOPCIProxy *vpci_dev, Erro=
r **errp)
>  {
>      VHostUserDevicePCI *dev =3D VHOST_USER_DEVICE_PCI(vpci_dev);
> -    DeviceState *vdev =3D DEVICE(&dev->vub);
> +    DeviceState *dev_state =3D DEVICE(&dev->vub);
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev_state);
> +    MemoryRegion *mr;
> +    uint64_t offset =3D 0, shmem_size =3D 0;
> +    int i;
> =20
>      vpci_dev->nvectors =3D 1;
> -    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> +    qdev_realize(dev_state, BUS(&vpci_dev->bus), errp);
> +
> +    for (i =3D 0; i < vdev->n_shmem_regions; i++) {
> +        mr =3D vdev->shmem_list[i].mr;
> +        if (mr->size > UINT64_MAX - shmem_size) {
> +            error_setg(errp, "Total shared memory required overflow");
> +            return;
> +        }
> +        shmem_size =3D shmem_size + mr->size;
> +    }
> +    if (shmem_size) {
> +        memory_region_init(&dev->shmembar, OBJECT(vpci_dev),
> +                           "vhost-device-pci-shmembar", shmem_size);
> +        for (i =3D 0; i < vdev->n_shmem_regions; i++) {
> +            memory_region_add_subregion(&dev->shmembar, offset, mr);
> +            virtio_pci_add_shm_cap(vpci_dev, VIRTIO_DEVICE_PCI_SHMEM_BAR,
> +                                   offset, mr->size, i);
> +            offset =3D offset + mr->size;
> +        }
> +        pci_register_bar(&vpci_dev->pci_dev, VIRTIO_DEVICE_PCI_SHMEM_BAR,
> +                        PCI_BASE_ADDRESS_SPACE_MEMORY |
> +                        PCI_BASE_ADDRESS_MEM_PREFETCH |
> +                        PCI_BASE_ADDRESS_MEM_TYPE_64,
> +                        &dev->shmembar);
> +    }
>  }
> =20
>  static void vhost_user_device_pci_class_init(ObjectClass *klass, void *d=
ata)
> --=20
> 2.48.1
>=20

--EN7sjCqoiyNwOvIl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAme0Y8wACgkQnKSrs4Gr
c8hYAwf/fTeFYhyNL8BOmD/xNwToaXnJrY+e+/b4UNxfFoodPcyIDgPvgYDehbqw
NmxSvhVvAAvcwLzLpGzCfr+5JupeTHakg58HwrTN5sXQlCaiu7I1rp2gD32HbP8C
Dyq+xNh3pNteT5B0AvnyNDCid6YXYY3TgL+B43bhUktluwcFQscYE/qjLFIJprAE
amfMG4yMYOhKHMeTycPn0E0GJqAz+8KSXeR3udDG9hJ3KbgyhmrV6nx/lppxAsg8
ggiUwY6MGZGKM7KFndSGD6h26SJuxLgx8a1zdD3WH6Aha3MFz964273jNw8TzH7l
AP/cvFDlu5bjRpjRdMJ+SJ0zV0l7Iw==
=vN3/
-----END PGP SIGNATURE-----

--EN7sjCqoiyNwOvIl--


