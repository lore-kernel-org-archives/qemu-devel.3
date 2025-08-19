Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD268CA0EF5
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 10:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoJnp-00068h-Eb; Tue, 19 Aug 2025 06:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uoJnn-00068Y-Vd
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 06:42:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uoJnl-0000uw-SK
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 06:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755600168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A9U3S/vqdVijasjzjkoy5f3UP+TpFUqjiIWL7JWfU/0=;
 b=BJ3ZKTQn2EQ9NcugtRE4Mn9wLI25M7W88KWT4P+P9fniaU7aGa9RFWht03Jcas4jtAlK1h
 h09I4mjKAVaUw4H+4l7GB3PBlyKsnHp18vuORUSJjARSSJVuoqN9cjQM1A/4QBFJSEx4hc
 F9xUmTDIBQQPDEeQigX5gTiFXAO/L0Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-G8wFeGETM-SCJvg-jA_nfg-1; Tue,
 19 Aug 2025 06:42:43 -0400
X-MC-Unique: G8wFeGETM-SCJvg-jA_nfg-1
X-Mimecast-MFC-AGG-ID: G8wFeGETM-SCJvg-jA_nfg_1755600162
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D2821800345; Tue, 19 Aug 2025 10:42:42 +0000 (UTC)
Received: from localhost (unknown [10.2.16.68])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0008A19A4C9C; Tue, 19 Aug 2025 10:42:40 +0000 (UTC)
Date: Tue, 19 Aug 2025 06:42:34 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, david@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, hi@alyssa.is,
 jasowang@redhat.com, Laurent Vivier <lvivier@redhat.com>,
 dbassey@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, stevensd@chromium.org,
 Fabiano Rosas <farosas@suse.de>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, slp@redhat.com
Subject: Re: [PATCH v7 8/8] vhost-user-device: Add shared memory BAR
Message-ID: <20250819104234.GB30271@fedora>
References: <20250818100353.1560655-1-aesteve@redhat.com>
 <20250818100353.1560655-9-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="keuUt6S3CFvYv7DO"
Content-Disposition: inline
In-Reply-To: <20250818100353.1560655-9-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--keuUt6S3CFvYv7DO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 12:03:53PM +0200, Albert Esteve wrote:
> Add shared memory BAR support to vhost-user-device-pci
> to enable direct file mapping for VIRTIO Shared
> Memory Regions.
>=20
> The implementation creates a consolidated shared
> memory BAR that contains all VIRTIO Shared
> Memory Regions as subregions. Each region is
> configured with its proper shmid, size, and
> offset within the BAR. The number and size of
> regions are retrieved via VHOST_USER_GET_SHMEM_CONFIG
> message sent by vhost-user-base during realization
> after virtio_init().
>=20
> Specifiically, it uses BAR 3 to avoid conflicts, as
> it is currently unused.
>=20
> The shared memory BAR is only created when the
> backend supports VHOST_USER_PROTOCOL_F_SHMEM and
> has configured shared memory regions. This maintains
> backward compatibility with backends that do not
> support shared memory functionality.
>=20
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  hw/virtio/vhost-user-base.c       | 49 +++++++++++++++++++++++++++++--
>  hw/virtio/vhost-user-device-pci.c | 34 +++++++++++++++++++--
>  2 files changed, 78 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> index ff67a020b4..932f9b5596 100644
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
> @@ -276,7 +277,9 @@ static void vub_device_realize(DeviceState *dev, Erro=
r **errp)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>      VHostUserBase *vub =3D VHOST_USER_BASE(dev);
> -    int ret;
> +    uint64_t memory_sizes[VIRTIO_MAX_SHMEM_REGIONS];
> +    g_autofree char *name =3D NULL;
> +    int i, ret, nregions;
> =20
>      if (!vub->chardev.chr) {
>          error_setg(errp, "vhost-user-base: missing chardev");
> @@ -319,7 +322,7 @@ static void vub_device_realize(DeviceState *dev, Erro=
r **errp)
> =20
>      /* Allocate queues */
>      vub->vqs =3D g_ptr_array_sized_new(vub->num_vqs);
> -    for (int i =3D 0; i < vub->num_vqs; i++) {
> +    for (i =3D 0; i < vub->num_vqs; i++) {
>          g_ptr_array_add(vub->vqs,
>                          virtio_add_queue(vdev, vub->vq_size,
>                                           vub_handle_output));
> @@ -333,11 +336,51 @@ static void vub_device_realize(DeviceState *dev, Er=
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
> +            name =3D g_strdup_printf("vub-shm-%d", i);

name is leaked because it's scope extends until the end of the function
(after the loop) but a newly allocated string is assigned each time
around the loop. This can be fixed by moving the local variable
declaration inside the if statement body.

> +            memory_region_init(&virtio_new_shmem_region(vdev, i)->mr,
> +                               OBJECT(vdev), name,
> +                               memory_sizes[i]);

->mr is already initialized inside virtio_new_shmem_region(). I suggest
changing the definition of virtio_new_shmem_region() like this:

  void virtio_add_shmem_region(VirtIODevice *vdev, uint8_t shmid,
                               uint64_t size)

and then calling it like this:

  virtio_add_shmem_region(vdev, shmid, memory_sizes[i]);

("new" usually returns a new instance whereas "add" modifies an owner
object/container. I think "add" is more appropriate here.)

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
> index f10bac874e..bac99e7c60 100644
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
> +#define VIRTIO_DEVICE_PCI_SHMEM_BAR 3
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
> +    VirtioSharedMemory *shmem, *next;
> +    uint64_t offset =3D 0, shmem_size =3D 0;
> =20
>      vpci_dev->nvectors =3D 1;
> -    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> +    qdev_realize(dev_state, BUS(&vpci_dev->bus), errp);
> +
> +    QSIMPLEQ_FOREACH_SAFE(shmem, &vdev->shmem_list, entry, next) {

This is not specific to vhost-user-device-pci.c. All VIRTIO devices with
Shared Memory Regions need PCI BAR setup code. Since vdev->shmem_list is
part of the core hw/virtio/ code, it would make sense to move this into
into hw/virtio/virtio-pci.c.

> +        if (shmem->mr.size > UINT64_MAX - shmem_size) {
> +            error_setg(errp, "Total shared memory required overflow");
> +            return;
> +        }
> +        shmem_size =3D shmem_size + shmem->mr.size;
> +    }
> +    if (shmem_size) {
> +        memory_region_init(&dev->shmembar, OBJECT(vpci_dev),
> +                           "vhost-device-pci-shmembar", shmem_size);
> +        QSIMPLEQ_FOREACH_SAFE(shmem, &vdev->shmem_list, entry, next) {
> +            memory_region_add_subregion(&dev->shmembar, offset, &shmem->=
mr);
> +            virtio_pci_add_shm_cap(vpci_dev, VIRTIO_DEVICE_PCI_SHMEM_BAR,
> +                                   offset, shmem->mr.size, shmem->shmid);
> +            offset =3D offset + shmem->mr.size;
> +        }
> +        pci_register_bar(&vpci_dev->pci_dev, VIRTIO_DEVICE_PCI_SHMEM_BAR,
> +                        PCI_BASE_ADDRESS_SPACE_MEMORY |
> +                        PCI_BASE_ADDRESS_MEM_PREFETCH |
> +                        PCI_BASE_ADDRESS_MEM_TYPE_64,
> +                        &dev->shmembar);

This does not follow the same approach as virtio-gpu-pci.c and
virtio-vga.c. They config the VirtIOPCIProxy's BARs
(->modern_io_bar_idx, ->modern_mem_bar_idx, and ->msix_bar_idx) to
control the BAR layout first and then call qdev_realize().

Why does this patch do things differently? It looks like it's assuming
vpci_dev always has a specific BAR layout (it could change).

> +    }

>  }
> =20
>  static void vhost_user_device_pci_class_init(ObjectClass *klass,
> --=20
> 2.49.0
>=20

--keuUt6S3CFvYv7DO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmikVRoACgkQnKSrs4Gr
c8h0Nwf+LSXQL8dwg+qKfrFZH29Ifnr4qwDsEA51yh+w+S73s846Gl4cHzKvyso8
bCTdqTW/P9/wyUMHQYXRfOQiwbvi6WnfDL4wjVaiQ+kAsuT/sKlehXeAqDF19VX1
GBqy6cUiqYUcLjiuMKdL4wQzqE1OWDUu9CsnPHdsVzuLuXbja6m1ynPdUNy8ejnx
OAOyTzvFEiEw9A2t3BJAPHLmwOh8JxPvXcvBtihy1XGO/pmBbNMUyowaGJHJ0GDq
rRVRiQwe+QFCZ9HGfHetH6VtSRJf3v2p6taXZPXl2/8t6/QSQ77tLEATSdxr56w6
4OohmgnWd7TXE6zf9WFXaYz+3utaeQ==
=Qoz6
-----END PGP SIGNATURE-----

--keuUt6S3CFvYv7DO--


