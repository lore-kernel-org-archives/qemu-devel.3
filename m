Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00CCCAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 19:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3J7S-0004j4-Ny; Mon, 29 Sep 2025 15:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3J7O-0004is-OX
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 15:01:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3J75-0002gX-K8
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 15:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759172439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y9kLEseH9FaQbEsQCJSpVKhtoRDOGqamtLx5jrbRLZM=;
 b=TN78jUxi8GI9xVwqtKEtMUcXSuQjW3kMZc/XbXu2KAYprxo7ly99ZcUjQYoF9ZrqDe3B/8
 Tr2xS9aqcxeal0gNm4cWnh0MUZYqwyHGRTiGGoICqHw9g+b4xOm47nVBYWpzOXTRjiMSOt
 UlPAi0i5sRmYd2FhvCR9ktc5A13NTi4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-VEGxjB1qMh2JEH96xaVwpw-1; Mon,
 29 Sep 2025 15:00:35 -0400
X-MC-Unique: VEGxjB1qMh2JEH96xaVwpw-1
X-Mimecast-MFC-AGG-ID: VEGxjB1qMh2JEH96xaVwpw_1759172434
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C35FE19560AF; Mon, 29 Sep 2025 19:00:33 +0000 (UTC)
Received: from localhost (unknown [10.2.17.29])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9CB26180047F; Mon, 29 Sep 2025 19:00:32 +0000 (UTC)
Date: Mon, 29 Sep 2025 15:00:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, stevensd@chromium.org, dbassey@redhat.com,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, slp@redhat.com,
 hi@alyssa.is, Fabiano Rosas <farosas@suse.de>,
 Stefano Garzarella <sgarzare@redhat.com>, jasowang@redhat.com,
 david@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v8 7/7] vhost-user-device: Add shared memory BAR
Message-ID: <20250929190031.GG81824@fedora>
References: <20250910115420.1012191-1-aesteve@redhat.com>
 <20250910115420.1012191-8-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0FXhHpedK9FJGkGu"
Content-Disposition: inline
In-Reply-To: <20250910115420.1012191-8-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--0FXhHpedK9FJGkGu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 01:54:20PM +0200, Albert Esteve wrote:
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
>  hw/virtio/vhost-user-base.c       | 47 +++++++++++++++++++++++++++++--
>  hw/virtio/vhost-user-device-pci.c | 34 ++++++++++++++++++++--
>  2 files changed, 76 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> index ff67a020b4..82f49500e4 100644
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
> +    int i, ret, nregions, regions_processed =3D 0;
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
> @@ -333,11 +336,49 @@ static void vub_device_realize(DeviceState *dev, Er=
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
> +    for (i =3D 0; i < VIRTIO_MAX_SHMEM_REGIONS && regions_processed < nr=
egions; i++) {
> +        if (memory_sizes[i]) {
> +            regions_processed++;
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
> +            virtio_new_shmem_region(vdev, i, memory_sizes[i]);
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

64-bit PCI memory BARs require two contiguous 32-bit BARs. Choosing BAR
3 won't work because modern_mem_bar_idx =3D 4 (and 5) and there is a
collision.

virtio-gpu-hostmem uses BAR 2 and 3 for VIRTIO Shared Memory Regions. In
order to do this, it rearranges the other VIRTIO PCI BARs in
virtio_vga_base_realize(). Following that approach should be safe.

--0FXhHpedK9FJGkGu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmja108ACgkQnKSrs4Gr
c8gBlgf/SFItlhQC8ZNVp5gIu6TvUlPP+Jx8dM4AMfoI6IqpdzhKJCCxbsHjtSCB
imIQxkZpmLqBGPae3jr/8fSHtq4ATzQhsRUf25N+qRUt9KM7mYYa8h9EgaRfeLW7
SizPHa0ETJvFi27R8wILOp2B2jodM5MnS5Jn1WuP2oDlr2U/2i3fhdGL7IK6CAq4
uKDshKanEbdAW7AbhbQ90c4BSjgJs+CYkWMNo21faVedubBnV2CqYASJsPfnQ3SU
Z4sPjCrcEfWTp/Sc6L7vbeFZ+cLu4qR3DUV54OeuvpoGG90aLf/gjW3O6i4UEfJM
ANXo9HIf5xlXcMmAeM126yQxy1WRpA==
=9vaI
-----END PGP SIGNATURE-----

--0FXhHpedK9FJGkGu--


