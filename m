Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018A5C3DA47
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 08:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRp7e-0008Th-W3; Thu, 11 Jul 2024 04:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRp7d-0008RG-Ud
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:25:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRp7c-0000pE-1H
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720686345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gU9Va1O/Kr5siTHWte15JT4XhkKABv6GLn/rM5vWvVU=;
 b=Xn/wf7c91AXC8f+ZTt4sd9SnPePmdnC1WzuNv3xv1vvJBPpwEUpKW50Im/ixEpMOqYh8cy
 RpaQbMi4NzHIrtiN0I3iqeqUQ8BsaKXn8h5+mIc0A0beNQq2Y4JUYvDRD7FozMaK8RfmSk
 ErN7ybg7zOt2SwPzMxNX0GvPEZWw5YI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-rkvHjfsIMBKxJ7u9BVDOsQ-1; Thu,
 11 Jul 2024 04:25:42 -0400
X-MC-Unique: rkvHjfsIMBKxJ7u9BVDOsQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE7001955BCC; Thu, 11 Jul 2024 08:25:41 +0000 (UTC)
Received: from localhost (unknown [10.39.192.113])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B32881955E85; Thu, 11 Jul 2024 08:25:39 +0000 (UTC)
Date: Thu, 11 Jul 2024 10:25:38 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, david@redhat.com,
 slp@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH v2 3/5] vhost-user-dev: Add cache BAR
Message-ID: <20240711082538.GE563880@dynamic-pd01.res.v6.highway.a1.net>
References: <20240628145710.1516121-1-aesteve@redhat.com>
 <20240628145710.1516121-4-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MC7Jx3kN9UqELPcD"
Content-Disposition: inline
In-Reply-To: <20240628145710.1516121-4-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--MC7Jx3kN9UqELPcD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 04:57:08PM +0200, Albert Esteve wrote:
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

Michael: Please review vhost_user_device_pci_realize() below regarding
virtio-pci BAR layout. Thanks!

> ---
>  hw/virtio/vhost-user-base.c       | 39 +++++++++++++++++++++++++++++--
>  hw/virtio/vhost-user-device-pci.c | 37 ++++++++++++++++++++++++++---
>  2 files changed, 71 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> index a83167191e..e47c568a55 100644
> --- a/hw/virtio/vhost-user-base.c
> +++ b/hw/virtio/vhost-user-base.c
> @@ -268,7 +268,9 @@ static void vub_device_realize(DeviceState *dev, Erro=
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
> @@ -311,7 +313,7 @@ static void vub_device_realize(DeviceState *dev, Erro=
r **errp)
> =20
>      /* Allocate queues */
>      vub->vqs =3D g_ptr_array_sized_new(vub->num_vqs);
> -    for (int i =3D 0; i < vub->num_vqs; i++) {
> +    for (i =3D 0; i < vub->num_vqs; i++) {
>          g_ptr_array_add(vub->vqs,
>                          virtio_add_queue(vdev, vub->vq_size,
>                                           vub_handle_output));
> @@ -328,6 +330,39 @@ static void vub_device_realize(DeviceState *dev, Err=
or **errp)
>          do_vhost_user_cleanup(vdev, vub);
>      }
> =20
> +    ret =3D vub->vhost_dev.vhost_ops->vhost_get_shmem_config(&vub->vhost=
_dev,
> +                                                           &nregions,
> +                                                           memory_sizes,
> +                                                           errp);
> +
> +    if (ret < 0) {
> +        do_vhost_user_cleanup(vdev, vub);
> +    }
> +
> +    for (i =3D 0; i < nregions; i++) {
> +        if (memory_sizes[i]) {
> +            if (!is_power_of_2(memory_sizes[i]) ||
> +                memory_sizes[i] < qemu_real_host_page_size()) {

Or just if (memory_sizes[i] % qemu_real_host_page_size() !=3D 0)?

> +                error_setg(errp, "Shared memory %d size must be a power =
of 2 "
> +                                 "no smaller than the page size", i);
> +                return;
> +            }
> +
> +            cache_ptr =3D mmap(NULL, memory_sizes[i], PROT_READ,

Should this be PROT_NONE like in
vhost_user_backend_handle_shmem_unmap()?

> +                            MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> +            if (cache_ptr =3D=3D MAP_FAILED) {
> +                error_setg(errp, "Unable to mmap blank cache: %s",
> +                           strerror(errno));

error_setg_errno() can be used here.

> +                return;
> +            }
> +
> +            virtio_new_shmem_region(vdev);
> +            memory_region_init_ram_ptr(&vdev->shmem_list[i],
> +                                    OBJECT(vdev), "vub-shm-" + i,
> +                                    memory_sizes[i], cache_ptr);
> +        }
> +    }
> +
>      qemu_chr_fe_set_handlers(&vub->chardev, NULL, NULL, vub_event, NULL,
>                               dev, NULL, true);
>  }
> diff --git a/hw/virtio/vhost-user-device-pci.c b/hw/virtio/vhost-user-dev=
ice-pci.c
> index efaf55d3dd..314bacfb7a 100644
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
> +
>  struct VHostUserDevicePCI {
>      VirtIOPCIProxy parent_obj;
> =20
>      VHostUserBase vub;
> +    MemoryRegion cachebar;
>  };
> =20
>  #define TYPE_VHOST_USER_DEVICE_PCI "vhost-user-device-pci-base"
> @@ -25,10 +29,37 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VHOST_=
USER_DEVICE_PCI)
>  static void vhost_user_device_pci_realize(VirtIOPCIProxy *vpci_dev, Erro=
r **errp)
>  {
>      VHostUserDevicePCI *dev =3D VHOST_USER_DEVICE_PCI(vpci_dev);
> -    DeviceState *vdev =3D DEVICE(&dev->vub);
> -
> +    DeviceState *dev_state =3D DEVICE(&dev->vub);
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev_state);
> +    uint64_t offset =3D 0, cache_size =3D 0;
> +    int i;
> +   =20
>      vpci_dev->nvectors =3D 1;
> -    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> +    qdev_realize(dev_state, BUS(&vpci_dev->bus), errp);
> +
> +    for (i =3D 0; i < vdev->n_shmem_regions; i++) {
> +        if (vdev->shmem_list[i].size > UINT64_MAX - cache_size) {
> +            error_setg(errp, "Total shared memory required overflow");
> +            return;
> +        }
> +        cache_size =3D cache_size + vdev->shmem_list[i].size;
> +    }
> +    if (cache_size) {
> +        memory_region_init(&dev->cachebar, OBJECT(vpci_dev),
> +                           "vhost-device-pci-cachebar", cache_size);
> +        for (i =3D 0; i < vdev->n_shmem_regions; i++) {
> +            memory_region_add_subregion(&dev->cachebar, offset,
> +                                        &vdev->shmem_list[i]);
> +            virtio_pci_add_shm_cap(vpci_dev, VIRTIO_DEVICE_PCI_CACHE_BAR,
> +                                   offset, vdev->shmem_list[i].size, i);
> +            offset =3D offset + vdev->shmem_list[i].size;
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

--MC7Jx3kN9UqELPcD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaPlwIACgkQnKSrs4Gr
c8gyVQf/SF2dDI03z8/sTeGlKjUTtSx9jPQEugasBqpc0CW1mMqrMOjvWj/qaelq
1UNBPX4wmJuns18jcNAidYRKaZsdsS7Scz+OgS98vjjqAmvS/qODFEK/mj4U13F8
0IWlqVZWVolygb+HrS2Omd0HU8P/5VX7LCMR6F6swfQ782MJdG6MwXWnMCgoj/wo
6YXergtsrvWJvagKRGhrb4jpJlu++y7KAZMJu3uBm1I+MiXXugu5vewuHsVSczqp
XGuBexo0aDzJ0Qha7yGNTWX/L8nAajd/wpp/xOd99cMjPNHUQ495yufMO2oBeOzY
galulisnK0Bte3m+BRiTpgGXFibpmA==
=iCr9
-----END PGP SIGNATURE-----

--MC7Jx3kN9UqELPcD--


