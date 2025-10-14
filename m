Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F94CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 15:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8gnA-0002Zu-D9; Tue, 14 Oct 2025 11:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v8gn5-0002W9-82
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:18:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v8gn2-0006WJ-GH
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760455088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MJWTfB1ZMVEdaoNKnbqZ2mgy/Eb90DCmXI0+aMixKJQ=;
 b=SCmUCgyfbf6enzIBk+Q1akYvGbKoEAZCIhkSpv7Ues5yeJ2s6G162arP2WD9de3cgSrurM
 PUmQNNrYKPWKoA0xzXjRDpOJ2aCFAHaCVmqgt1xgB97moe1mMzBfTDSZA6KQGdWMFxWAE0
 DZGd6zySf7Fn7RLYX2cABwBY7gy+blk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-hHZ3YYX5PjyXuvwPX7LP5Q-1; Tue,
 14 Oct 2025 11:18:05 -0400
X-MC-Unique: hHZ3YYX5PjyXuvwPX7LP5Q-1
X-Mimecast-MFC-AGG-ID: hHZ3YYX5PjyXuvwPX7LP5Q_1760455084
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3858619560A1; Tue, 14 Oct 2025 15:18:04 +0000 (UTC)
Received: from localhost (unknown [10.2.16.150])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 133461955F21; Tue, 14 Oct 2025 15:18:02 +0000 (UTC)
Date: Tue, 14 Oct 2025 11:18:02 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, stevensd@chromium.org, dbassey@redhat.com,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, slp@redhat.com,
 hi@alyssa.is, Fabiano Rosas <farosas@suse.de>,
 Stefano Garzarella <sgarzare@redhat.com>, jasowang@redhat.com,
 david@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v8 7/7] vhost-user-device: Add shared memory BAR
Message-ID: <20251014151802.GA11115@fedora>
References: <20250910115420.1012191-1-aesteve@redhat.com>
 <20250910115420.1012191-8-aesteve@redhat.com>
 <20250929190031.GG81824@fedora>
 <CADSE00KBfyW=bTaNjvr8xgTevzndsk=Rps6gvfE8yH4sYqHqgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YPYArgKc2GJn4xqk"
Content-Disposition: inline
In-Reply-To: <CADSE00KBfyW=bTaNjvr8xgTevzndsk=Rps6gvfE8yH4sYqHqgA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--YPYArgKc2GJn4xqk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 05:37:52PM +0200, Albert Esteve wrote:
> On Mon, Sep 29, 2025 at 9:00=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.=
com> wrote:
> >
> > On Wed, Sep 10, 2025 at 01:54:20PM +0200, Albert Esteve wrote:
> > > Add shared memory BAR support to vhost-user-device-pci
> > > to enable direct file mapping for VIRTIO Shared
> > > Memory Regions.
> > >
> > > The implementation creates a consolidated shared
> > > memory BAR that contains all VIRTIO Shared
> > > Memory Regions as subregions. Each region is
> > > configured with its proper shmid, size, and
> > > offset within the BAR. The number and size of
> > > regions are retrieved via VHOST_USER_GET_SHMEM_CONFIG
> > > message sent by vhost-user-base during realization
> > > after virtio_init().
> > >
> > > Specifiically, it uses BAR 3 to avoid conflicts, as
> > > it is currently unused.
> > >
> > > The shared memory BAR is only created when the
> > > backend supports VHOST_USER_PROTOCOL_F_SHMEM and
> > > has configured shared memory regions. This maintains
> > > backward compatibility with backends that do not
> > > support shared memory functionality.
> > >
> > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > > ---
> > >  hw/virtio/vhost-user-base.c       | 47 +++++++++++++++++++++++++++++=
--
> > >  hw/virtio/vhost-user-device-pci.c | 34 ++++++++++++++++++++--
> > >  2 files changed, 76 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> > > index ff67a020b4..82f49500e4 100644
> > > --- a/hw/virtio/vhost-user-base.c
> > > +++ b/hw/virtio/vhost-user-base.c
> > > @@ -16,6 +16,7 @@
> > >  #include "hw/virtio/virtio-bus.h"
> > >  #include "hw/virtio/vhost-user-base.h"
> > >  #include "qemu/error-report.h"
> > > +#include "migration/blocker.h"
> > >
> > >  static void vub_start(VirtIODevice *vdev)
> > >  {
> > > @@ -276,7 +277,9 @@ static void vub_device_realize(DeviceState *dev, =
Error **errp)
> > >  {
> > >      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> > >      VHostUserBase *vub =3D VHOST_USER_BASE(dev);
> > > -    int ret;
> > > +    uint64_t memory_sizes[VIRTIO_MAX_SHMEM_REGIONS];
> > > +    g_autofree char *name =3D NULL;
> > > +    int i, ret, nregions, regions_processed =3D 0;
> > >
> > >      if (!vub->chardev.chr) {
> > >          error_setg(errp, "vhost-user-base: missing chardev");
> > > @@ -319,7 +322,7 @@ static void vub_device_realize(DeviceState *dev, =
Error **errp)
> > >
> > >      /* Allocate queues */
> > >      vub->vqs =3D g_ptr_array_sized_new(vub->num_vqs);
> > > -    for (int i =3D 0; i < vub->num_vqs; i++) {
> > > +    for (i =3D 0; i < vub->num_vqs; i++) {
> > >          g_ptr_array_add(vub->vqs,
> > >                          virtio_add_queue(vdev, vub->vq_size,
> > >                                           vub_handle_output));
> > > @@ -333,11 +336,49 @@ static void vub_device_realize(DeviceState *dev=
, Error **errp)
> > >                           VHOST_BACKEND_TYPE_USER, 0, errp);
> > >
> > >      if (ret < 0) {
> > > -        do_vhost_user_cleanup(vdev, vub);
> > > +        goto err;
> > > +    }
> > > +
> > > +    ret =3D vub->vhost_dev.vhost_ops->vhost_get_shmem_config(&vub->v=
host_dev,
> > > +                                                           &nregions,
> > > +                                                           memory_si=
zes,
> > > +                                                           errp);
> > > +
> > > +    if (ret < 0) {
> > > +        goto err;
> > > +    }
> > > +
> > > +    for (i =3D 0; i < VIRTIO_MAX_SHMEM_REGIONS && regions_processed =
< nregions; i++) {
> > > +        if (memory_sizes[i]) {
> > > +            regions_processed++;
> > > +            if (vub->vhost_dev.migration_blocker =3D=3D NULL) {
> > > +                error_setg(&vub->vhost_dev.migration_blocker,
> > > +                       "Migration disabled: devices with VIRTIO Shar=
ed Memory "
> > > +                       "Regions do not support migration yet.");
> > > +                ret =3D migrate_add_blocker_normal(
> > > +                    &vub->vhost_dev.migration_blocker,
> > > +                    errp);
> > > +
> > > +                if (ret < 0) {
> > > +                    goto err;
> > > +                }
> > > +            }
> > > +
> > > +            if (memory_sizes[i] % qemu_real_host_page_size() !=3D 0)=
 {
> > > +                error_setg(errp, "Shared memory %d size must be a po=
wer of 2 "
> > > +                                 "no smaller than the page size", i);
> > > +                goto err;
> > > +            }
> > > +
> > > +            virtio_new_shmem_region(vdev, i, memory_sizes[i]);
> > > +        }
> > >      }
> > >
> > >      qemu_chr_fe_set_handlers(&vub->chardev, NULL, NULL, vub_event, N=
ULL,
> > >                               dev, NULL, true);
> > > +    return;
> > > +err:
> > > +    do_vhost_user_cleanup(vdev, vub);
> > >  }
> > >
> > >  static void vub_device_unrealize(DeviceState *dev)
> > > diff --git a/hw/virtio/vhost-user-device-pci.c b/hw/virtio/vhost-user=
-device-pci.c
> > > index f10bac874e..bac99e7c60 100644
> > > --- a/hw/virtio/vhost-user-device-pci.c
> > > +++ b/hw/virtio/vhost-user-device-pci.c
> > > @@ -8,14 +8,18 @@
> > >   */
> > >
> > >  #include "qemu/osdep.h"
> > > +#include "qapi/error.h"
> > >  #include "hw/qdev-properties.h"
> > >  #include "hw/virtio/vhost-user-base.h"
> > >  #include "hw/virtio/virtio-pci.h"
> > >
> > > +#define VIRTIO_DEVICE_PCI_SHMEM_BAR 3
> >
> > 64-bit PCI memory BARs require two contiguous 32-bit BARs. Choosing BAR
> > 3 won't work because modern_mem_bar_idx =3D 4 (and 5) and there is a
> > collision.
> >
> > virtio-gpu-hostmem uses BAR 2 and 3 for VIRTIO Shared Memory Regions. In
> > order to do this, it rearranges the other VIRTIO PCI BARs in
> > virtio_vga_base_realize(). Following that approach should be safe.
>=20
> I see. But doing the same strategy would collide with
> virtio-gpu-hostmem if both devices are used simultaneously? Would that
> be ok?

virtio-gpu-* and vhost-user-device-pci are separate PCI devices with
their own BARs, how would they conflict?

--YPYArgKc2GJn4xqk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjuaakACgkQnKSrs4Gr
c8icdwgAsqfMJV+jwQ3OvZgfdw2s2tpEugZuN6xGcFJEb2zcaGhrhXEuVtSuexnB
qB3ExNSCqLTqxqdONc+RAEUeEU1AlDDNdKFSPQgAYhhc49PVRD+DUSf7Ugf3vXgf
hCU5mORqDRwmXBwlhmVHT24lLxSV28JgyWQiWH8Xy7qs8EcTiSNaMmp79efUa5Gt
mM+MHNs/+PEsm7pSVkBHrJiqDejLONnghm+2XdwVR+TppT2AtdBTyDlnoH/PCKUx
tHjzl+TfEniLqsk7iPJiK12zNUaGDnxBCQ42gM6KKrB9hIKiXe7NoqO4yUbJFyef
awFMbWhbPUEM25SQvLU08/5XmvNLiw==
=+fZp
-----END PGP SIGNATURE-----

--YPYArgKc2GJn4xqk--


