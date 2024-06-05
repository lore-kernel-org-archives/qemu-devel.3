Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA63C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 14:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sErdO-0001oD-RX; Wed, 05 Jun 2024 10:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sErdN-0001kR-AD
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:29:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sErdK-0000ua-SI
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717597737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T9Nrn7IClOWjVQcglMa+NPp2ISRJf/FiKqOFRvqY67E=;
 b=A/rmvA6Im57LC4OtXwHykJ+rbxcl8yQqvKaHhAdRUUT1naoePMJ+BoimiS6bPGISX6aGTg
 I0CY/KK8SBjeJE40kqEWhTYxHL6pc8hr2ii27Hs+GvJewg/t5zWyRAlhRg5HoMlxUH8TGc
 S0GnSH1IzOQtznmPsdvowh4+Y/hkqZw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-Yp2_Dsq5OxS78VGi8a_kGw-1; Wed,
 05 Jun 2024 10:28:56 -0400
X-MC-Unique: Yp2_Dsq5OxS78VGi8a_kGw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0ACB1944DDD
 for <qemu-devel@nongnu.org>; Wed,  5 Jun 2024 14:28:52 +0000 (UTC)
Received: from localhost (unknown [10.39.195.154])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 46D451955DC0; Wed,  5 Jun 2024 14:28:50 +0000 (UTC)
Date: Wed, 5 Jun 2024 10:28:49 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, slp@redhat.com, jasowang@redhat.com
Subject: Re: [RFC PATCH 1/1] vhost-user: add shmem mmap request
Message-ID: <20240605142849.GC135899@fedora.redhat.com>
References: <20240530152223.780232-1-aesteve@redhat.com>
 <20240530152223.780232-2-aesteve@redhat.com>
 <20240604185416.GB90471@fedora.redhat.com>
 <CADSE00+yvsOhiJJg0ePgr7AYVCkjm9xWNj7KpAOFMwj2wuEpGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hiBNGfgsFw0JO4PV"
Content-Disposition: inline
In-Reply-To: <CADSE00+yvsOhiJJg0ePgr7AYVCkjm9xWNj7KpAOFMwj2wuEpGg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


--hiBNGfgsFw0JO4PV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 10:13:32AM +0200, Albert Esteve wrote:
> On Tue, Jun 4, 2024 at 8:54=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>=20
> > On Thu, May 30, 2024 at 05:22:23PM +0200, Albert Esteve wrote:
> > > Add SHMEM_MAP/UNMAP requests to vhost-user.
> > >
> > > This request allows backends to dynamically map
> > > fds into a shared memory region indentified by
> >
> > Please call this "VIRTIO Shared Memory Region" everywhere (code,
> > vhost-user spec, commit description, etc) so it's clear that this is not
> > about vhost-user shared memory tables/regions.
> >
> > > its `shmid`. Then, the fd memory is advertised
> > > to the frontend through a BAR+offset, so it can
> > > be read by the driver while its valid.
> >
> > Why is a PCI BAR mentioned here? vhost-user does not know about the
> > VIRTIO Transport (e.g. PCI) being used. It's the frontend's job to
> > report VIRTIO Shared Memory Regions to the driver.
> >
> >
> I will remove PCI BAR, as it is true that it depends on the
> transport. I was trying to explain that the driver
> will use the shm_base + shm_offset to access
> the mapped memory.
>=20
>=20
> > >
> > > Then, the backend can munmap the memory range
> > > in a given shared memory region (again, identified
> > > by its `shmid`), to free it. After this, the
> > > region becomes private and shall not be accessed
> > > by the frontend anymore.
> >
> > What does "private" mean?
> >
> > The frontend must mmap PROT_NONE to reserve the virtual memory space
> > when no fd is mapped in the VIRTIO Shared Memory Region. Otherwise an
> > unrelated mmap(NULL, ...) might use that address range and the guest
> > would have access to the host memory! This is a security issue and needs
> > to be mentioned explicitly in the spec.
> >
>=20
> I mentioned private because it changes the mapping from MAP_SHARED
> to MAP_PRIVATE. I will highlight PROT_NONE instead.

I see. Then "MAP_PRIVATE" would be clearer. I wasn't sure whether you
mean mmap flags or something like the memory range is no longer
accessible to the driver.

>=20
>=20
> >
> > >
> > > Initializing the memory region is reponsiblity
> > > of the PCI device that will using it.
> >
> > What does this mean?
> >
>=20
> The MemoryRegion is declared in `struct VirtIODevice`,
> but it is uninitialized in this commit. So I was trying to say
> that the initialization will happen in, e.g., vhost-user-gpu-pci.c
> with something like `memory_region_init` , and later `pci_register_bar`.

Okay. The device model needs to create MemoryRegion instances for the
device's Shared Memory Regions and add them to the VirtIODevice.

--device vhost-user-device will need to query the backend since, unlike
vhost-user-gpu-pci and friends, it doesn't have knowledge of specific
device types. It will need to create MemoryRegions enumerated from the
backend.

By the way, the VIRTIO MMIO Transport also supports VIRTIO Shared Memory
Regions so this work should not be tied to PCI.

>=20
> I am testing that part still.
>=20
>=20
> >
> > >
> > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > > ---
> > >  docs/interop/vhost-user.rst |  23 ++++++++
> > >  hw/virtio/vhost-user.c      | 106 ++++++++++++++++++++++++++++++++++=
++
> > >  hw/virtio/virtio.c          |   2 +
> > >  include/hw/virtio/virtio.h  |   3 +
> > >  4 files changed, 134 insertions(+)
> >
> > Two missing pieces:
> >
> > 1. QEMU's --device vhost-user-device needs a way to enumerate VIRTIO
> > Shared Memory Regions from the vhost-user backend. vhost-user-device is
> > a generic vhost-user frontend without knowledge of the device type, so
> > it doesn't know what the valid shmids are and what size the regions
> > have.
> >
>=20
> Ok. I was assuming that if a device (backend) makes a request without a
> valid shmid or not enough size in the region to perform the mmap, would
> just fail in the VMM performing the actual mmap operation. So it would
> not necessarily need to know about valid shmids or region sizes.

But then --device vhost-user-device wouldn't be able to support VIRTIO
Shared Memory Regions, which means this patch series is incomplete. New
vhost-user features need to support both --device vhost-user-<type>-*
and --device vhost-user-device.

What's needed is:
1. New vhost-user messages so the frontend can query the shmids and
   sizes from the backend.
2. QEMU --device vhost-user-device code that queries the VIRTIO Shared
   Memory Regions from the vhost-user backend and then creates
   MemoryRegions for them.

>=20
>=20
> >
> > 2. Other backends don't see these mappings. If the guest submits a vring
> > descriptor referencing a mapping to another backend, then that backend
> > won't be able to access this memory. David Gilbert hit this problem when
> > working on the virtiofs DAX Window. Either the frontend needs to forward
> > all SHMAP_MAP/UNMAP messages to the other backends (inefficient and
> > maybe racy!) or a new "memcpy" message is needed as a fallback for when
> > vhost-user memory region translation fails.
> >
>=20
> Ok. In which scenario would another device want to access the same mappin=
g?
> If it is for a shared VIRTIO object, the device that receives the dmabuf =
fd
> could
> just do a new mapping in its VIRTIO shared memory region.

You can reproduce this with two virtiofs devices. Where device A has the
DAX Window feature enabled. The test program mmaps the DAX file and then
opens a new file on device B and performs an O_DIRECT write(2) syscall.

I think that this issue must be address in this series since this issue
is introduced by enabling VIRTIO Shared Memory Regions in vhost-user.

A bit more detail:

Device A has a VIRTIO Shared Memory Region. An application mmaps that
memory (examples: guest userspace driver using Linux VFIO, a guest
kernel driver that exposes the memory to userspace via mmap, or guest
kernel DAX). The application passes that memory as an I/O buffer to
device B (e.g. O_DIRECT disk I/O).

The result is that device B's vhost-user backend receives a vring
descriptor that points to a guest memory address in device A's VIRTIO
Shared Memory Region. Since device B does not have this memory in its
table, it cannot translate the address and the device breaks.

>=20
>=20
> >
> > >
> > > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> > > index d8419fd2f1..3caf2a290c 100644
> > > --- a/docs/interop/vhost-user.rst
> > > +++ b/docs/interop/vhost-user.rst
> > > @@ -1859,6 +1859,29 @@ is sent by the front-end.
> > >    when the operation is successful, or non-zero otherwise. Note that=
 if
> > the
> > >    operation fails, no fd is sent to the backend.
> > >
> > > +``VHOST_USER_BACKEND_SHMEM_MAP``
> > > +  :id: 9
> > > +  :equivalent ioctl: N/A
> > > +  :request payload: fd and ``struct VhostUserMMap``
> > > +  :reply payload: N/A
> > > +
> > > +  This message can be submitted by the backends to advertise a new
> > mapping
> > > +  to be made in a given shared memory region. Upon receiving the
> > message,
> > > +  QEMU will mmap the given fd into the shared memory region with the
> >
> > s/QEMU/the frontend/
> >
> > > +  requested ``shmid``. A reply is generated indicating whether mappi=
ng
> > > +  succeeded.
> >
> > Please document whether mapping over an existing mapping is allowed. I
> > think it should be allowed because it might be useful to atomically
> > update a mapping without a race where the driver sees unmapped memory.
> >
> >
> So in my understanding, the frontend (driver) in the guest would initiate
> the
> mmap/munmap by sending request to the backend (vhost-user device).
> Then the vhost-user device sends a request to the VMM to perform the
> mapping. We could enforce an ACK to ensure that the mmap operation finish=
ed
> before the vhost-user device responds to the driver, and thus avoid
> races. This way, we support only the simple usecase of not allowing
> mmaps over an already mapped region.

I think it's fine to start with the stricter model where no overlapping
mappings are allowed. If someone needs overlapping mappings in the
future, a feature bit could be added to negotiate support.

Please document that overlapping mappings are not supported.

> > If mapping over an existing mapping is allowed, does the new mapping
> > need to cover the old mapping exactly, or can it span multiple previous
> > mappings or a subset of an existing mapping?
> >
> > From a security point of view we need to be careful here. A potentially
> > untrusted backend process now has the ability to mmap an arbitrary file
> > descriptor into the frontend process. The backend can cause
> > denial of service by creating many small mappings to exhaust the OS
> > limits on virtual memory areas. The backend can map memory to use as
> > part of a security compromise, so we need to be sure the virtual memory
> > addresses are not leaked to the backend and only read/write page
> > permissions are available.
> >
>=20
> Right, security from untrusted backends is usally the hardest part to me.
> But vhost-user devices do only see shm_offset, so this should be safe, no?

Yes, I think the current interface is safe, too.

> >
> > > +``VHOST_USER_BACKEND_SHMEM_UNMAP``
> > > +  :id: 10
> > > +  :equivalent ioctl: N/A
> > > +  :request payload: ``struct VhostUserMMap``
> > > +  :reply payload: N/A
> > > +
> > > +  This message can be submitted by the backends so that QEMU un-mmap
> >
> > s/QEMU/the frontend/
> >
>=20
> This is probably my bad, but I really thought the frontend is the driver.
> So frontend/backend as alternative terms for vhost-user driver/device.

"vhost-user driver" is not a term that's used, as far as I know. The
vhost-user spec calls it the front-end (older code and docs may call it
the vhost-user master).

> And then here we would keep QEMU or use VMM instead?

The vhost-user spec uses both front-end and QEMU to mean the same thing.
VMM is not used in the vhost-user spec. I suggest using front-end in new
spec text because QEMU is not the only application that implements this
spec anymore.

>=20
>=20
> >
> > > +  a given range (``offset``, ``len``) in the shared memory region wi=
th
> > the
> > > +  requested ``shmid``.
> >
> > Does the range need to correspond to a previously-mapped VhostUserMMap
> > or can it cross multiple VhostUserMMaps, be a subset of a VhostUserMMap,
> > etc?
> >
>=20
> I would prefer to keep it simple and disallow mapping over a
> previously-mapped
> region. The range need to correspond to a valid (within size bound), free,
> memory region, or else the request will fail. I will add that to the text.
>=20
> Nonetheless, I am open to discuss other options.

That sounds good. I'm not aware of any use cases that require anything fanc=
y.

>=20
>=20
> >
> > > +  A reply is generated indicating whether unmapping succeeded.
> > > +
> > >  .. _reply_ack:
> > >
> > >  VHOST_USER_PROTOCOL_F_REPLY_ACK
> > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > index cdf9af4a4b..9526b9d07f 100644
> > > --- a/hw/virtio/vhost-user.c
> > > +++ b/hw/virtio/vhost-user.c
> > > @@ -115,6 +115,8 @@ typedef enum VhostUserBackendRequest {
> > >      VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,
> > >      VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,
> > >      VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
> > > +    VHOST_USER_BACKEND_SHMEM_MAP =3D 9,
> > > +    VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,
> > >      VHOST_USER_BACKEND_MAX
> > >  }  VhostUserBackendRequest;
> > >
> > > @@ -192,6 +194,23 @@ typedef struct VhostUserShared {
> > >      unsigned char uuid[16];
> > >  } VhostUserShared;
> > >
> > > +/* For the flags field of VhostUserMMap */
> > > +#define VHOST_USER_FLAG_MAP_R (1u << 0)
> > > +#define VHOST_USER_FLAG_MAP_W (1u << 1)
> > > +
> > > +typedef struct {
> > > +    /* Shared memory region ID */
> > > +    uint8_t shmid;
> >
> > There is a hole (padding) in the struct since the following fields are
> > naturally aligned to 8 bytes. I suggest moving shmid to the end to
> > reduce the chance of information leaks if padding is not zeroed.
> >
>=20
> I see. I can move it to the end of the struct or add a padding field in
> between. I'll do what you suggested, as it sound like the simplest soluti=
on.
>=20
>=20
> >
> > > +    /* File offset */
> > > +    uint64_t fd_offset;
> > > +    /* Offset within the shared memory region */
> > > +    uint64_t shm_offset;
> > > +    /* Size of region to map */
> >
> > To avoid giving "region" additional meanings:
> >
> > s/Size of the region to map/Size of the mapping/
> >
>=20
> Ok, I will change it in the next drop. Probably will keep the RFC for
> at least one more patch, seeing that there are a few things I wasn't
> correctly considering.
>=20
> Thanks for all the feedback!

Great, thanks!

Stefan

>=20
>=20
> >
> > > +    uint64_t len;
> > > +    /* Flags for the mmap operation, from VHOST_USER_FLAG_* */
> > > +    uint64_t flags;
> > > +} VhostUserMMap;
> > > +
> > >  typedef struct {
> > >      VhostUserRequest request;
> > >
> > > @@ -224,6 +243,7 @@ typedef union {
> > >          VhostUserInflight inflight;
> > >          VhostUserShared object;
> > >          VhostUserTransferDeviceState transfer_state;
> > > +        VhostUserMMap mmap;
> > >  } VhostUserPayload;
> > >
> > >  typedef struct VhostUserMsg {
> > > @@ -1748,6 +1768,85 @@
> > vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
> > >      return 0;
> > >  }
> > >
> > > +static int
> > > +vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
> > > +                                  VhostUserMMap *vu_mmap,
> > > +                                  int fd)
> > > +{
> > > +    void *addr =3D 0;
> > > +    MemoryRegion *mr =3D NULL;
> > > +
> > > +    if (fd < 0) {
> > > +        error_report("Bad fd for map");
> > > +        return -EBADF;
> > > +    }
> > > +
> > > +    if (!dev->vdev->shmem_list ||
> > > +        dev->vdev->n_shmem_regions <=3D vu_mmap->shmid) {
> > > +        error_report("Shared memory region at "
> > > +                     "ID %d unitialized", vu_mmap->shmid);
> > > +        return -EFAULT;
> > > +    }
> > > +
> > > +    mr =3D &dev->vdev->shmem_list[vu_mmap->shmid];
> > > +
> > > +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> > > +        (vu_mmap->shm_offset + vu_mmap->len) > mr->size) {
> > > +        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
> > > +                     vu_mmap->shm_offset, vu_mmap->len);
> > > +        return -EFAULT;
> > > +    }
> > > +
> > > +    void *shmem_ptr =3D memory_region_get_ram_ptr(mr);
> > > +
> > > +    addr =3D mmap(shmem_ptr + vu_mmap->shm_offset, vu_mmap->len,
> > > +        ((vu_mmap->flags & VHOST_USER_FLAG_MAP_R) ? PROT_READ : 0) |
> > > +        ((vu_mmap->flags & VHOST_USER_FLAG_MAP_W) ? PROT_WRITE : 0),
> > > +        MAP_SHARED | MAP_FIXED, fd, vu_mmap->fd_offset);
> > > +    if (addr =3D=3D MAP_FAILED) {
> > > +        error_report("Failed to mmap mem fd");
> > > +        return -EFAULT;
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> > > +
> > > +static int
> > > +vhost_user_backend_handle_shmem_unmap(struct vhost_dev *dev,
> > > +                                    VhostUserMMap *vu_mmap)
> > > +{
> > > +    void *addr =3D 0;
> > > +    MemoryRegion *mr =3D NULL;
> > > +
> > > +    if (!dev->vdev->shmem_list ||
> > > +        dev->vdev->n_shmem_regions <=3D vu_mmap->shmid) {
> > > +        error_report("Shared memory region at "
> > > +                     "ID %d unitialized", vu_mmap->shmid);
> > > +        return -EFAULT;
> > > +    }
> > > +
> > > +    mr =3D &dev->vdev->shmem_list[vu_mmap->shmid];
> > > +
> > > +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> > > +        (vu_mmap->shm_offset + vu_mmap->len) > mr->size) {
> > > +        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
> > > +                     vu_mmap->shm_offset, vu_mmap->len);
> > > +        return -EFAULT;
> > > +    }
> > > +
> > > +    void *shmem_ptr =3D memory_region_get_ram_ptr(mr);
> > > +
> > > +    addr =3D mmap(shmem_ptr + vu_mmap->shm_offset, vu_mmap->len,
> > > +                PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, =
-1,
> > 0);
> > > +
> > > +    if (addr =3D=3D MAP_FAILED) {
> > > +        error_report("Failed to unmap memory");
> > > +        return -EFAULT;
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> > > +
> > >  static void close_backend_channel(struct vhost_user *u)
> > >  {
> > >      g_source_destroy(u->backend_src);
> > > @@ -1816,6 +1915,13 @@ static gboolean backend_read(QIOChannel *ioc,
> > GIOCondition condition,
> > >          ret =3D
> > vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
> > >                                                               &hdr,
> > &payload);
> > >          break;
> > > +    case VHOST_USER_BACKEND_SHMEM_MAP:
> > > +        ret =3D vhost_user_backend_handle_shmem_map(dev, &payload.mm=
ap,
> > > +                                                fd ? fd[0] : -1);
> > > +        break;
> > > +    case VHOST_USER_BACKEND_SHMEM_UNMAP:
> > > +        ret =3D vhost_user_backend_handle_shmem_unmap(dev, &payload.=
mmap);
> > > +        break;
> > >      default:
> > >          error_report("Received unexpected msg type: %d.", hdr.reques=
t);
> > >          ret =3D -EINVAL;
> > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > index 893a072c9d..59596370ec 100644
> > > --- a/hw/virtio/virtio.c
> > > +++ b/hw/virtio/virtio.c
> > > @@ -3264,6 +3264,8 @@ void virtio_init(VirtIODevice *vdev, uint16_t
> > device_id, size_t config_size)
> > >              virtio_vmstate_change, vdev);
> > >      vdev->device_endian =3D virtio_default_endian();
> > >      vdev->use_guest_notifier_mask =3D true;
> > > +    vdev->shmem_list =3D NULL;
> > > +    vdev->n_shmem_regions =3D 0;
> > >  }
> > >
> > >  /*
> > > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > > index 7d5ffdc145..34bec26593 100644
> > > --- a/include/hw/virtio/virtio.h
> > > +++ b/include/hw/virtio/virtio.h
> > > @@ -165,6 +165,9 @@ struct VirtIODevice
> > >       */
> > >      EventNotifier config_notifier;
> > >      bool device_iotlb_enabled;
> > > +    /* Shared memory region for vhost-user mappings. */
> > > +    MemoryRegion *shmem_list;
> > > +    int n_shmem_regions;
> > >  };
> > >
> > >  struct VirtioDeviceClass {
> > > --
> > > 2.44.0
> > >
> >

--hiBNGfgsFw0JO4PV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZgdiAACgkQnKSrs4Gr
c8jU0wf+NqACqM+sCVwWd5XW8fyn/3o1xeYZw5Ftnu6UJ4957fOGgeTTgdakKffA
O8rUdOOoupjr2AwrmNMcKnuDa7HeZt3OPXqo7MEt9Tct5kYT0ourBZsn3OC91vuC
W5Ccq68YO/naWMlKXkyJip5HGIiYtu9Qz3nifgwBlGeEBksGQGffS1QtXiVERnKH
e9/Hu96jK1WH8NGOnDlvZsgWsLz5S7Pjl1gbWuXq9/Hz9GTGuW8514x+sJUZB8+5
i0hc+VBOsmLk75+h61A+4a5jVjMxG6+P6c0vP0AOdhW7nCA/oQOXe4ibLWtu//3d
HzzRUUwKPfVi86oAI96rrUuUj+h38g==
=IuW6
-----END PGP SIGNATURE-----

--hiBNGfgsFw0JO4PV--


