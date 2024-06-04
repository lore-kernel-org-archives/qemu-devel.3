Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87BBC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 18:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZIi-0001X9-Ul; Tue, 04 Jun 2024 14:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sEZIg-0001Wf-HH
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 14:54:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sEZId-0004ms-Ue
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 14:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717527262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r0eu0knB70b0H66qeRg6U2bIJPgbSupoTzuc7x7HVFU=;
 b=MTO7iNq4uDV57GOezn7FeLbm8SMCtPIj55/+L9ls7iwychlq10Zwq8QIVUvxjWeHjDjPtQ
 QN6t4nw54Xzm7ZDg0/7kHcfxSpFfNtsa8Uneof/jp49maQ4Xt9aaol15Q3in9vquJ6sNI/
 0svYKT6qasmhHKLhnysd4XzXwdHniME=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-kbMRUoioOKaPGoi-BVINbg-1; Tue, 04 Jun 2024 14:54:20 -0400
X-MC-Unique: kbMRUoioOKaPGoi-BVINbg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55EBC8007A3
 for <qemu-devel@nongnu.org>; Tue,  4 Jun 2024 18:54:20 +0000 (UTC)
Received: from localhost (unknown [10.39.195.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD24D111DCFF;
 Tue,  4 Jun 2024 18:54:18 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:54:16 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, slp@redhat.com, jasowang@redhat.com
Subject: Re: [RFC PATCH 1/1] vhost-user: add shmem mmap request
Message-ID: <20240604185416.GB90471@fedora.redhat.com>
References: <20240530152223.780232-1-aesteve@redhat.com>
 <20240530152223.780232-2-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8zQ8sZXeub3CbO/H"
Content-Disposition: inline
In-Reply-To: <20240530152223.780232-2-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--8zQ8sZXeub3CbO/H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 05:22:23PM +0200, Albert Esteve wrote:
> Add SHMEM_MAP/UNMAP requests to vhost-user.
>=20
> This request allows backends to dynamically map
> fds into a shared memory region indentified by

Please call this "VIRTIO Shared Memory Region" everywhere (code,
vhost-user spec, commit description, etc) so it's clear that this is not
about vhost-user shared memory tables/regions.

> its `shmid`. Then, the fd memory is advertised
> to the frontend through a BAR+offset, so it can
> be read by the driver while its valid.

Why is a PCI BAR mentioned here? vhost-user does not know about the
VIRTIO Transport (e.g. PCI) being used. It's the frontend's job to
report VIRTIO Shared Memory Regions to the driver.

>=20
> Then, the backend can munmap the memory range
> in a given shared memory region (again, identified
> by its `shmid`), to free it. After this, the
> region becomes private and shall not be accessed
> by the frontend anymore.

What does "private" mean?

The frontend must mmap PROT_NONE to reserve the virtual memory space
when no fd is mapped in the VIRTIO Shared Memory Region. Otherwise an
unrelated mmap(NULL, ...) might use that address range and the guest
would have access to the host memory! This is a security issue and needs
to be mentioned explicitly in the spec.

>=20
> Initializing the memory region is reponsiblity
> of the PCI device that will using it.

What does this mean?

>=20
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  docs/interop/vhost-user.rst |  23 ++++++++
>  hw/virtio/vhost-user.c      | 106 ++++++++++++++++++++++++++++++++++++
>  hw/virtio/virtio.c          |   2 +
>  include/hw/virtio/virtio.h  |   3 +
>  4 files changed, 134 insertions(+)

Two missing pieces:

1. QEMU's --device vhost-user-device needs a way to enumerate VIRTIO
Shared Memory Regions from the vhost-user backend. vhost-user-device is
a generic vhost-user frontend without knowledge of the device type, so
it doesn't know what the valid shmids are and what size the regions
have.

2. Other backends don't see these mappings. If the guest submits a vring
descriptor referencing a mapping to another backend, then that backend
won't be able to access this memory. David Gilbert hit this problem when
working on the virtiofs DAX Window. Either the frontend needs to forward
all SHMAP_MAP/UNMAP messages to the other backends (inefficient and
maybe racy!) or a new "memcpy" message is needed as a fallback for when
vhost-user memory region translation fails.

>=20
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index d8419fd2f1..3caf2a290c 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -1859,6 +1859,29 @@ is sent by the front-end.
>    when the operation is successful, or non-zero otherwise. Note that if =
the
>    operation fails, no fd is sent to the backend.
> =20
> +``VHOST_USER_BACKEND_SHMEM_MAP``
> +  :id: 9
> +  :equivalent ioctl: N/A
> +  :request payload: fd and ``struct VhostUserMMap``
> +  :reply payload: N/A
> +
> +  This message can be submitted by the backends to advertise a new mappi=
ng
> +  to be made in a given shared memory region. Upon receiving the message,
> +  QEMU will mmap the given fd into the shared memory region with the

s/QEMU/the frontend/

> +  requested ``shmid``. A reply is generated indicating whether mapping
> +  succeeded.

Please document whether mapping over an existing mapping is allowed. I
think it should be allowed because it might be useful to atomically
update a mapping without a race where the driver sees unmapped memory.

If mapping over an existing mapping is allowed, does the new mapping
need to cover the old mapping exactly, or can it span multiple previous
mappings or a subset of an existing mapping?

=46rom a security point of view we need to be careful here. A potentially
untrusted backend process now has the ability to mmap an arbitrary file
descriptor into the frontend process. The backend can cause
denial of service by creating many small mappings to exhaust the OS
limits on virtual memory areas. The backend can map memory to use as
part of a security compromise, so we need to be sure the virtual memory
addresses are not leaked to the backend and only read/write page
permissions are available.

> +``VHOST_USER_BACKEND_SHMEM_UNMAP``
> +  :id: 10
> +  :equivalent ioctl: N/A
> +  :request payload: ``struct VhostUserMMap``
> +  :reply payload: N/A
> +
> +  This message can be submitted by the backends so that QEMU un-mmap

s/QEMU/the frontend/

> +  a given range (``offset``, ``len``) in the shared memory region with t=
he
> +  requested ``shmid``.

Does the range need to correspond to a previously-mapped VhostUserMMap
or can it cross multiple VhostUserMMaps, be a subset of a VhostUserMMap,
etc?

> +  A reply is generated indicating whether unmapping succeeded.
> +
>  .. _reply_ack:
> =20
>  VHOST_USER_PROTOCOL_F_REPLY_ACK
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index cdf9af4a4b..9526b9d07f 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -115,6 +115,8 @@ typedef enum VhostUserBackendRequest {
>      VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,
>      VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,
>      VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
> +    VHOST_USER_BACKEND_SHMEM_MAP =3D 9,
> +    VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,
>      VHOST_USER_BACKEND_MAX
>  }  VhostUserBackendRequest;
> =20
> @@ -192,6 +194,23 @@ typedef struct VhostUserShared {
>      unsigned char uuid[16];
>  } VhostUserShared;
> =20
> +/* For the flags field of VhostUserMMap */
> +#define VHOST_USER_FLAG_MAP_R (1u << 0)
> +#define VHOST_USER_FLAG_MAP_W (1u << 1)
> +
> +typedef struct {
> +    /* Shared memory region ID */
> +    uint8_t shmid;

There is a hole (padding) in the struct since the following fields are
naturally aligned to 8 bytes. I suggest moving shmid to the end to
reduce the chance of information leaks if padding is not zeroed.

> +    /* File offset */
> +    uint64_t fd_offset;
> +    /* Offset within the shared memory region */
> +    uint64_t shm_offset;
> +    /* Size of region to map */

To avoid giving "region" additional meanings:

s/Size of the region to map/Size of the mapping/

> +    uint64_t len;
> +    /* Flags for the mmap operation, from VHOST_USER_FLAG_* */
> +    uint64_t flags;
> +} VhostUserMMap;
> +
>  typedef struct {
>      VhostUserRequest request;
> =20
> @@ -224,6 +243,7 @@ typedef union {
>          VhostUserInflight inflight;
>          VhostUserShared object;
>          VhostUserTransferDeviceState transfer_state;
> +        VhostUserMMap mmap;
>  } VhostUserPayload;
> =20
>  typedef struct VhostUserMsg {
> @@ -1748,6 +1768,85 @@ vhost_user_backend_handle_shared_object_lookup(str=
uct vhost_user *u,
>      return 0;
>  }
> =20
> +static int
> +vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
> +                                  VhostUserMMap *vu_mmap,
> +                                  int fd)
> +{
> +    void *addr =3D 0;
> +    MemoryRegion *mr =3D NULL;
> +
> +    if (fd < 0) {
> +        error_report("Bad fd for map");
> +        return -EBADF;
> +    }
> +
> +    if (!dev->vdev->shmem_list ||
> +        dev->vdev->n_shmem_regions <=3D vu_mmap->shmid) {
> +        error_report("Shared memory region at "
> +                     "ID %d unitialized", vu_mmap->shmid);
> +        return -EFAULT;
> +    }
> +
> +    mr =3D &dev->vdev->shmem_list[vu_mmap->shmid];
> +
> +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> +        (vu_mmap->shm_offset + vu_mmap->len) > mr->size) {
> +        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
> +                     vu_mmap->shm_offset, vu_mmap->len);
> +        return -EFAULT;
> +    }
> +
> +    void *shmem_ptr =3D memory_region_get_ram_ptr(mr);
> +
> +    addr =3D mmap(shmem_ptr + vu_mmap->shm_offset, vu_mmap->len,
> +        ((vu_mmap->flags & VHOST_USER_FLAG_MAP_R) ? PROT_READ : 0) |
> +        ((vu_mmap->flags & VHOST_USER_FLAG_MAP_W) ? PROT_WRITE : 0),
> +        MAP_SHARED | MAP_FIXED, fd, vu_mmap->fd_offset);
> +    if (addr =3D=3D MAP_FAILED) {
> +        error_report("Failed to mmap mem fd");
> +        return -EFAULT;
> +    }
> +
> +    return 0;
> +}
> +
> +static int
> +vhost_user_backend_handle_shmem_unmap(struct vhost_dev *dev,
> +                                    VhostUserMMap *vu_mmap)
> +{
> +    void *addr =3D 0;
> +    MemoryRegion *mr =3D NULL;
> +
> +    if (!dev->vdev->shmem_list ||
> +        dev->vdev->n_shmem_regions <=3D vu_mmap->shmid) {
> +        error_report("Shared memory region at "
> +                     "ID %d unitialized", vu_mmap->shmid);
> +        return -EFAULT;
> +    }
> +
> +    mr =3D &dev->vdev->shmem_list[vu_mmap->shmid];
> +
> +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> +        (vu_mmap->shm_offset + vu_mmap->len) > mr->size) {
> +        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
> +                     vu_mmap->shm_offset, vu_mmap->len);
> +        return -EFAULT;
> +    }
> +
> +    void *shmem_ptr =3D memory_region_get_ram_ptr(mr);
> +
> +    addr =3D mmap(shmem_ptr + vu_mmap->shm_offset, vu_mmap->len,
> +                PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, =
0);
> +
> +    if (addr =3D=3D MAP_FAILED) {
> +        error_report("Failed to unmap memory");
> +        return -EFAULT;
> +    }
> +
> +    return 0;
> +}
> +
>  static void close_backend_channel(struct vhost_user *u)
>  {
>      g_source_destroy(u->backend_src);
> @@ -1816,6 +1915,13 @@ static gboolean backend_read(QIOChannel *ioc, GIOC=
ondition condition,
>          ret =3D vhost_user_backend_handle_shared_object_lookup(dev->opaq=
ue, ioc,
>                                                               &hdr, &payl=
oad);
>          break;
> +    case VHOST_USER_BACKEND_SHMEM_MAP:
> +        ret =3D vhost_user_backend_handle_shmem_map(dev, &payload.mmap,
> +                                                fd ? fd[0] : -1);
> +        break;
> +    case VHOST_USER_BACKEND_SHMEM_UNMAP:
> +        ret =3D vhost_user_backend_handle_shmem_unmap(dev, &payload.mmap=
);
> +        break;
>      default:
>          error_report("Received unexpected msg type: %d.", hdr.request);
>          ret =3D -EINVAL;
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 893a072c9d..59596370ec 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3264,6 +3264,8 @@ void virtio_init(VirtIODevice *vdev, uint16_t devic=
e_id, size_t config_size)
>              virtio_vmstate_change, vdev);
>      vdev->device_endian =3D virtio_default_endian();
>      vdev->use_guest_notifier_mask =3D true;
> +    vdev->shmem_list =3D NULL;
> +    vdev->n_shmem_regions =3D 0;
>  }
> =20
>  /*
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 7d5ffdc145..34bec26593 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -165,6 +165,9 @@ struct VirtIODevice
>       */
>      EventNotifier config_notifier;
>      bool device_iotlb_enabled;
> +    /* Shared memory region for vhost-user mappings. */
> +    MemoryRegion *shmem_list;
> +    int n_shmem_regions;
>  };
> =20
>  struct VirtioDeviceClass {
> --=20
> 2.44.0
>=20

--8zQ8sZXeub3CbO/H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZfYtgACgkQnKSrs4Gr
c8hAsAf+PcOyntv3z3JouRbnWjH0xltlVQh2UGQcGlUS8ztTep8rLlSd2Oul77q2
yB6e+BIMFfJITOisIyZ4/CChVqV66RODEEXwDhwP45pKUcJ6FwFicPOSHPXBDN/w
vGc+FUKrSIsY2QIkpshONheFcfCLu2g/RqkvMvaO1MUpLKw0dpUuwdbgakfQuxPW
UwdaZQ+23xVmhsKxSmoMhYy7rMUnDJlM2cqkGuexqxZmjrCFszXaTGJjDJjnm5oy
7v16BuYmB85DB7F3DH+R830eY2pIaiPoyOaHE65P81d6fR+5fKInytDZuEr1Ovmw
6767kucV4U+l1Y+5dDXznfYxwT4Cdg==
=XEqE
-----END PGP SIGNATURE-----

--8zQ8sZXeub3CbO/H--


