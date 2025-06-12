Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAC7C61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 16:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPkdw-0006OM-S4; Thu, 12 Jun 2025 12:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uPkdv-0006O8-KI
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 12:19:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uPkds-0005y5-Dy
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 12:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749745141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZD8LY5bc4ye4oq2xDu1si4aFAsDcq6gWds6eOJvWyf4=;
 b=SYbvZgKgF10EMhqXz2nMaVX5ADcuykOaOodBNBc0UEDyo2Pz1aWgfALp2fQuiD2K7R64c+
 nJvUmCJSZsQVRv5dHwUlv2Xi7+dZ0gSsfUwZROcdWJGaFrYmWWqeQLVFZVi/kHM1+daOHV
 ZJ3iirlgwCar7RWnGQOME8iBa2fMWCA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-h4VCj3qENFWuRLE3hLK0Hg-1; Thu,
 12 Jun 2025 12:19:00 -0400
X-MC-Unique: h4VCj3qENFWuRLE3hLK0Hg-1
X-Mimecast-MFC-AGG-ID: h4VCj3qENFWuRLE3hLK0Hg_1749745139
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 248AB180AD41; Thu, 12 Jun 2025 16:18:59 +0000 (UTC)
Received: from localhost (unknown [10.2.16.98])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8828930044CC; Thu, 12 Jun 2025 16:18:57 +0000 (UTC)
Date: Thu, 12 Jun 2025 12:18:56 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, slp@redhat.com, david@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, jasowang@redhat.com,
 stevensd@chromium.org, hi@alyssa.is,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v5 1/7] vhost-user: Add VirtIO Shared Memory map request
Message-ID: <20250612161856.GB224651@fedora>
References: <20250609144729.884027-1-aesteve@redhat.com>
 <20250609144729.884027-2-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="X0y+SNX3m4YavZX3"
Content-Disposition: inline
In-Reply-To: <20250609144729.884027-2-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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


--X0y+SNX3m4YavZX3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 09, 2025 at 04:47:23PM +0200, Albert Esteve wrote:
> Add SHMEM_MAP/UNMAP requests to vhost-user to
> handle VIRTIO Shared Memory mappings.
>=20
> This request allows backends to dynamically map
> fds into a VIRTIO Shared Memory Region indentified

identified

> by its `shmid`. The map is performed by calling
> `memory_region_init_ram_from_fd` and adding the
> new region as a subregion of the shmem container
> MR. Then, the fd memory is advertised to the
> driver as a base addres + offset, so it can be

address

> read/written (depending on the mmap flags
> requested) while it is valid.

I'm not sure what the last sentence is referring to. Does "driver" mean
a QEMU device model or a VIRTIO driver? Neither of these make a lot of
sense to me.

>=20
> The backend can unmap the memory range
> in a given VIRTIO Shared Memory Region (again,
> identified by its `shmid`), to free it.
> Upon receiving this message, the front-end
> must delete the MR as a subregion of
> the shmem container region and free its
> resources.
>=20
> Note that commit all these operations need
> to be delayed to after we respond the request
> to the backend to avoid deadlocks.

Rephrased:
"Note the memory region commit for these operations needs to be delayed
until after we respond to the backend to avoid deadlocks."

By the way, what is the reason for the deadlock?

>=20
> The device model needs to create VirtSharedMemory
> instances for the VirtIO Shared Memory Regions
> and add them to the `VirtIODevice` instance.
>=20
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  hw/virtio/vhost-user.c                    | 150 ++++++++++++++++++++++
>  hw/virtio/virtio.c                        |  97 ++++++++++++++
>  include/hw/virtio/virtio.h                |  29 +++++
>  subprojects/libvhost-user/libvhost-user.c |  70 ++++++++++
>  subprojects/libvhost-user/libvhost-user.h |  54 ++++++++
>  5 files changed, 400 insertions(+)
>=20
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 1e1d6b0d6e..9c635fb928 100644
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
> +#define VHOST_USER_FLAG_MAP_RW (1u << 0)
> +
> +typedef struct {
> +    /* VIRTIO Shared Memory Region ID */
> +    uint8_t shmid;
> +    uint8_t padding[7];
> +    /* File offset */
> +    uint64_t fd_offset;
> +    /* Offset within the VIRTIO Shared Memory Region */
> +    uint64_t shm_offset;
> +    /* Size of the mapping */
> +    uint64_t len;
> +    /* Flags for the mmap operation, from VHOST_USER_FLAG_MAP_* */
> +    uint16_t flags;
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
> @@ -1768,6 +1788,129 @@ vhost_user_backend_handle_shared_object_lookup(st=
ruct vhost_user *u,
>      return 0;
>  }
> =20
> +static int
> +vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
> +                                    QIOChannel *ioc,
> +                                    VhostUserHeader *hdr,
> +                                    VhostUserPayload *payload,
> +                                    int fd)
> +{
> +    uint32_t ram_flags;
> +    VirtSharedMemory *shmem;
> +    VhostUserMMap *vu_mmap =3D &payload->mmap;
> +    Error *local_err =3D NULL;
> +    g_autoptr(GString) shm_name =3D g_string_new(NULL);
> +
> +    if (fd < 0) {
> +        error_report("Bad fd for map");
> +        return -EBADF;
> +    }
> +
> +    if (QSIMPLEQ_EMPTY(&dev->vdev->shmem_list)) {
> +        error_report("Device has no VIRTIO Shared Memory Regions. "
> +                     "Requested ID: %d", vu_mmap->shmid);
> +        return -EFAULT;
> +    }
> +
> +    shmem =3D virtio_find_shmem_region(dev->vdev, vu_mmap->shmid);
> +    if (!shmem) {
> +        error_report("VIRTIO Shared Memory Region at "
> +                     "ID %d not found or unitialized", vu_mmap->shmid);
> +        return -EFAULT;
> +    }
> +
> +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> +        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr->size) {
> +        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
> +                     vu_mmap->shm_offset, vu_mmap->len);
> +        return -EFAULT;
> +    }
> +
> +    g_string_printf(shm_name, "virtio-shm%i-%lu",
> +                    vu_mmap->shmid, vu_mmap->shm_offset);
> +
> +    memory_region_transaction_begin();
> +    ram_flags =3D RAM_SHARED |
> +                ((vu_mmap->flags & VHOST_USER_FLAG_MAP_RW) ? 0 : RAM_REA=
DONLY);
> +    if (virtio_add_shmem_map(shmem, shm_name->str, vu_mmap->shm_offset,
> +                             vu_mmap->fd_offset, vu_mmap->len, ram_flags,
> +                             fd) !=3D 0) {
> +        memory_region_transaction_commit();
> +        return -EFAULT;
> +    }
> +
> +    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> +        payload->u64 =3D 0;
> +        hdr->size =3D sizeof(payload->u64);
> +        vhost_user_send_resp(ioc, hdr, payload, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            memory_region_transaction_commit();
> +            return -EFAULT;
> +        }
> +    }
> +
> +    memory_region_transaction_commit();
> +
> +    return 0;
> +}
> +
> +static int
> +vhost_user_backend_handle_shmem_unmap(struct vhost_dev *dev,
> +                                      QIOChannel *ioc,
> +                                      VhostUserHeader *hdr,
> +                                      VhostUserPayload *payload)
> +{
> +    VirtSharedMemory *shmem;
> +    MappedMemoryRegion *mmap =3D NULL;
> +    VhostUserMMap *vu_mmap =3D &payload->mmap;
> +    Error *local_err =3D NULL;
> +
> +    if (QSIMPLEQ_EMPTY(&dev->vdev->shmem_list)) {
> +        error_report("Device has no VIRTIO Shared Memory Regions. "
> +                     "Requested ID: %d", vu_mmap->shmid);
> +        return -EFAULT;
> +    }
> +
> +    shmem =3D virtio_find_shmem_region(dev->vdev, vu_mmap->shmid);
> +    if (!shmem) {
> +        error_report("VIRTIO Shared Memory Region at "
> +                     "ID %d not found or unitialized", vu_mmap->shmid);
> +        return -EFAULT;
> +    }
> +
> +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> +        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr->size) {
> +        error_report("Bad offset/len for unmmap %" PRIx64 "+%" PRIx64,
> +                     vu_mmap->shm_offset, vu_mmap->len);
> +        return -EFAULT;
> +    }
> +
> +    mmap =3D virtio_find_shmem_map(shmem, vu_mmap->shm_offset, vu_mmap->=
len);
> +    if (!mmap) {
> +        return -EFAULT;
> +    }
> +
> +    memory_region_transaction_begin();
> +    memory_region_del_subregion(shmem->mr, mmap->mem);
> +    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> +        payload->u64 =3D 0;
> +        hdr->size =3D sizeof(payload->u64);
> +        vhost_user_send_resp(ioc, hdr, payload, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            memory_region_transaction_commit();
> +            return -EFAULT;
> +        }
> +    }
> +    memory_region_transaction_commit();
> +
> +    /* Free the MemoryRegion only after vhost_commit */
> +    virtio_del_shmem_map(shmem, vu_mmap->shm_offset, vu_mmap->len);
> +
> +    return 0;
> +}
> +
>  static void close_backend_channel(struct vhost_user *u)
>  {
>      g_source_destroy(u->backend_src);
> @@ -1836,6 +1979,13 @@ static gboolean backend_read(QIOChannel *ioc, GIOC=
ondition condition,
>          ret =3D vhost_user_backend_handle_shared_object_lookup(dev->opaq=
ue, ioc,
>                                                               &hdr, &payl=
oad);
>          break;
> +    case VHOST_USER_BACKEND_SHMEM_MAP:
> +        ret =3D vhost_user_backend_handle_shmem_map(dev, ioc, &hdr, &pay=
load,
> +                                                  fd ? fd[0] : -1);
> +        break;
> +    case VHOST_USER_BACKEND_SHMEM_UNMAP:
> +        ret =3D vhost_user_backend_handle_shmem_unmap(dev, ioc, &hdr, &p=
ayload);
> +        break;
>      default:
>          error_report("Received unexpected msg type: %d.", hdr.request);
>          ret =3D -EINVAL;
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 5534251e01..208ad11685 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3035,6 +3035,92 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
>      return vmstate_save_state(f, &vmstate_virtio, vdev, NULL);
>  }
> =20
> +VirtSharedMemory *virtio_new_shmem_region(VirtIODevice *vdev, uint8_t sh=
mid)

The caller is not responsible for freeing the returned VirtSharedMemory.
Please add doc comments for the new APIs explaining these things.

> +{
> +    VirtSharedMemory *elem;
> +    elem =3D g_new0(VirtSharedMemory, 1);
> +    elem->shmid =3D shmid;
> +    elem->mr =3D g_new0(MemoryRegion, 1);

Maybe this will become clear in later commits, but at this point I'm
confused about elem->mr's lifecycle:
- memory_region_init() is not called?
- Where is this freed?
- Does it really need to be allocated on the heap instead of being
  embedded as a field within VirtSharedMemory?

> +    QTAILQ_INIT(&elem->mmaps);
> +    QSIMPLEQ_INSERT_TAIL(&vdev->shmem_list, elem, entry);
> +    return QSIMPLEQ_LAST(&vdev->shmem_list, VirtSharedMemory, entry);

More concise:

  return elem;

> +}
> +
> +VirtSharedMemory *virtio_find_shmem_region(VirtIODevice *vdev, uint8_t s=
hmid)
> +{
> +    VirtSharedMemory *shmem, *next;
> +    QSIMPLEQ_FOREACH_SAFE(shmem, &vdev->shmem_list, entry, next) {
> +        if (shmem->shmid =3D=3D shmid) {
> +            return shmem;
> +        }
> +    }
> +    return NULL;
> +}
> +
> +int virtio_add_shmem_map(VirtSharedMemory *shmem, const char *shm_name,
> +                          hwaddr shm_offset, hwaddr fd_offset, uint64_t =
size,
> +                          uint32_t ram_flags, int fd)
> +{
> +    Error *err =3D NULL;
> +    MappedMemoryRegion *mmap;
> +    fd =3D dup(fd);
> +    if (fd < 0) {
> +        error_report("Failed to duplicate fd: %s", strerror(errno));
> +        return -1;
> +    }
> +
> +    if (shm_offset + size > shmem->mr->size) {
> +        error_report("Memory exceeds the shared memory boundaries");
> +        close(fd);
> +        return -1;
> +    }
> +
> +    mmap =3D g_new0(MappedMemoryRegion, 1);
> +    mmap->mem =3D g_new0(MemoryRegion, 1);
> +    mmap->offset =3D shm_offset;
> +    memory_region_init_ram_from_fd(mmap->mem,
> +                                   OBJECT(shmem->mr),
> +                                   shm_name, size, ram_flags,
> +                                   fd, fd_offset, &err);
> +    if (err) {
> +        error_report_err(err);

There is an opportunity here to propagate errors to the caller by
adjusting the function prototype:

  bool virtio_add_shmem_map(..., Error **errp)

I don't know if the caller is going to do anything with the error
though, so I guess we can leave things as they are for now.

> +        close(fd);
> +        g_free(mmap->mem);
> +        g_free(mmap);
> +        return -1;
> +    }
> +    memory_region_add_subregion(shmem->mr, shm_offset, mmap->mem);
> +
> +    QTAILQ_INSERT_TAIL(&shmem->mmaps, mmap, link);
> +
> +    return 0;
> +}
> +
> +MappedMemoryRegion *virtio_find_shmem_map(VirtSharedMemory *shmem,
> +                                          hwaddr offset, uint64_t size)
> +{
> +    MappedMemoryRegion *mmap;
> +    QTAILQ_FOREACH(mmap, &shmem->mmaps, link) {
> +        if (mmap->offset =3D=3D offset && mmap->mem->size =3D=3D size) {
> +            return mmap;
> +        }
> +    }
> +    return NULL;
> +}
> +
> +void virtio_del_shmem_map(VirtSharedMemory *shmem, hwaddr offset,
> +                          uint64_t size)
> +{
> +    MappedMemoryRegion *mmap =3D virtio_find_shmem_map(shmem, offset, si=
ze);
> +    if (mmap =3D=3D NULL) {
> +        return;
> +    }
> +
> +    object_unparent(OBJECT(mmap->mem));

I'm not 100% confident about the lifecycle of the MemoryRegions in this
patch. There is a section in docs/devel/memory.rst with warnings about
dynamically destroying MemoryRegions at runtime.

I think a reference count is leaked because
memory_region_add_subregion() increments the refcount rather than taking
over the caller's refcount.

Using memory_region_del_subregion() + memory_region_unref() would be
clearer, but may violate the rule in the memory.rst documentation,
depending on when this function is called.

> +    QTAILQ_REMOVE(&shmem->mmaps, mmap, link);
> +    g_free(mmap);
> +}
> +
>  /* A wrapper for use as a VMState .put function */
>  static int virtio_device_put(QEMUFile *f, void *opaque, size_t size,
>                                const VMStateField *field, JSONWriter *vmd=
esc)
> @@ -3511,6 +3597,7 @@ void virtio_init(VirtIODevice *vdev, uint16_t devic=
e_id, size_t config_size)
>              NULL, virtio_vmstate_change, vdev);
>      vdev->device_endian =3D virtio_default_endian();
>      vdev->use_guest_notifier_mask =3D true;
> +    QSIMPLEQ_INIT(&vdev->shmem_list);
>  }
> =20
>  /*
> @@ -4022,11 +4109,21 @@ static void virtio_device_free_virtqueues(VirtIOD=
evice *vdev)
>  static void virtio_device_instance_finalize(Object *obj)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(obj);
> +    VirtSharedMemory *shmem;
> =20
>      virtio_device_free_virtqueues(vdev);
> =20
>      g_free(vdev->config);
>      g_free(vdev->vector_queues);
> +    while (!QSIMPLEQ_EMPTY(&vdev->shmem_list)) {
> +        shmem =3D QSIMPLEQ_FIRST(&vdev->shmem_list);
> +        while (!QTAILQ_EMPTY(&shmem->mmaps)) {
> +            MappedMemoryRegion *mmap_reg =3D QTAILQ_FIRST(&shmem->mmaps);
> +            virtio_del_shmem_map(shmem, mmap_reg->offset, mmap_reg->mem-=
>size);
> +        }
> +        QSIMPLEQ_REMOVE_HEAD(&vdev->shmem_list, entry);
> +        g_free(shmem);
> +    }
>  }
> =20
>  static const Property virtio_properties[] =3D {
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 214d4a77e9..331dbcfbe0 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -98,6 +98,23 @@ enum virtio_device_endian {
>      VIRTIO_DEVICE_ENDIAN_BIG,
>  };
> =20
> +struct MappedMemoryRegion {
> +    MemoryRegion *mem;
> +    hwaddr offset;
> +    QTAILQ_ENTRY(MappedMemoryRegion) link;
> +};
> +
> +typedef struct MappedMemoryRegion MappedMemoryRegion;
> +
> +struct VirtSharedMemory {
> +    uint8_t shmid;
> +    MemoryRegion *mr;
> +    QTAILQ_HEAD(, MappedMemoryRegion) mmaps;
> +    QSIMPLEQ_ENTRY(VirtSharedMemory) entry;
> +};
> +
> +typedef struct VirtSharedMemory VirtSharedMemory;

It would be nice to prefix the type names for namespacing reasons:
VirtSharedMemory -> VirtioSharedMemory
MappedMemoryRegion -> VirtioSharedMemoryMapping

> +
>  /**
>   * struct VirtIODevice - common VirtIO structure
>   * @name: name of the device
> @@ -167,6 +184,8 @@ struct VirtIODevice
>       */
>      EventNotifier config_notifier;
>      bool device_iotlb_enabled;
> +    /* Shared memory region for mappings. */
> +    QSIMPLEQ_HEAD(, VirtSharedMemory) shmem_list;
>  };
> =20
>  struct VirtioDeviceClass {
> @@ -289,6 +308,16 @@ void virtio_notify(VirtIODevice *vdev, VirtQueue *vq=
);
> =20
>  int virtio_save(VirtIODevice *vdev, QEMUFile *f);
> =20
> +VirtSharedMemory *virtio_new_shmem_region(VirtIODevice *vdev, uint8_t sh=
mid);
> +VirtSharedMemory *virtio_find_shmem_region(VirtIODevice *vdev, uint8_t s=
hmid);
> +int virtio_add_shmem_map(VirtSharedMemory *shmem, const char *shm_name,
> +                          hwaddr shm_offset, hwaddr fd_offset, uint64_t =
size,
> +                          uint32_t ram_flags, int fd);
> +MappedMemoryRegion *virtio_find_shmem_map(VirtSharedMemory *shmem,
> +                                          hwaddr offset, uint64_t size);
> +void virtio_del_shmem_map(VirtSharedMemory *shmem, hwaddr offset,
> +                          uint64_t size);
> +
>  extern const VMStateInfo virtio_vmstate_info;
> =20
>  #define VMSTATE_VIRTIO_DEVICE \
> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libv=
host-user/libvhost-user.c
> index 9c630c2170..034cbfdc3c 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -1592,6 +1592,76 @@ vu_rm_shared_object(VuDev *dev, unsigned char uuid=
[UUID_LEN])
>      return vu_send_message(dev, &msg);
>  }
> =20
> +bool
> +vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
> +             uint64_t shm_offset, uint64_t len, uint64_t flags, int fd)
> +{
> +    VhostUserMsg vmsg =3D {
> +        .request =3D VHOST_USER_BACKEND_SHMEM_MAP,
> +        .size =3D sizeof(vmsg.payload.mmap),
> +        .flags =3D VHOST_USER_VERSION,
> +        .payload.mmap =3D {
> +            .shmid =3D shmid,
> +            .fd_offset =3D fd_offset,
> +            .shm_offset =3D shm_offset,
> +            .len =3D len,
> +            .flags =3D flags,
> +        },
> +        .fd_num =3D 1,
> +        .fds[0] =3D fd,
> +    };
> +
> +    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SHMEM)) {
> +        return false;
> +    }
> +
> +    if (vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK)) {
> +        vmsg.flags |=3D VHOST_USER_NEED_REPLY_MASK;
> +    }
> +
> +    pthread_mutex_lock(&dev->backend_mutex);
> +    if (!vu_message_write(dev, dev->backend_fd, &vmsg)) {
> +        pthread_mutex_unlock(&dev->backend_mutex);
> +        return false;
> +    }
> +
> +    /* Also unlocks the backend_mutex */
> +    return vu_process_message_reply(dev, &vmsg);
> +}
> +
> +bool
> +vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t shm_offset, uint64_t =
len)
> +{
> +    VhostUserMsg vmsg =3D {
> +        .request =3D VHOST_USER_BACKEND_SHMEM_UNMAP,
> +        .size =3D sizeof(vmsg.payload.mmap),
> +        .flags =3D VHOST_USER_VERSION,
> +        .payload.mmap =3D {
> +            .shmid =3D shmid,
> +            .fd_offset =3D 0,
> +            .shm_offset =3D shm_offset,
> +            .len =3D len,
> +        },
> +    };
> +
> +    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SHMEM)) {
> +        return false;
> +    }
> +
> +    if (vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK)) {
> +        vmsg.flags |=3D VHOST_USER_NEED_REPLY_MASK;
> +    }
> +
> +    pthread_mutex_lock(&dev->backend_mutex);
> +    if (!vu_message_write(dev, dev->backend_fd, &vmsg)) {
> +        pthread_mutex_unlock(&dev->backend_mutex);
> +        return false;
> +    }
> +
> +    /* Also unlocks the backend_mutex */
> +    return vu_process_message_reply(dev, &vmsg);
> +}
> +
>  static bool
>  vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
>  {
> diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libv=
host-user/libvhost-user.h
> index 2ffc58c11b..26b710c92d 100644
> --- a/subprojects/libvhost-user/libvhost-user.h
> +++ b/subprojects/libvhost-user/libvhost-user.h
> @@ -69,6 +69,8 @@ enum VhostUserProtocolFeature {
>      /* Feature 16 is reserved for VHOST_USER_PROTOCOL_F_STATUS. */
>      /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
>      VHOST_USER_PROTOCOL_F_SHARED_OBJECT =3D 18,
> +    /* Feature 19 is reserved for VHOST_USER_PROTOCOL_F_DEVICE_STATE */
> +    VHOST_USER_PROTOCOL_F_SHMEM =3D 20,
>      VHOST_USER_PROTOCOL_F_MAX
>  };
> =20
> @@ -127,6 +129,8 @@ typedef enum VhostUserBackendRequest {
>      VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,
>      VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,
>      VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
> +    VHOST_USER_BACKEND_SHMEM_MAP =3D 9,
> +    VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,
>      VHOST_USER_BACKEND_MAX
>  }  VhostUserBackendRequest;
> =20
> @@ -186,6 +190,23 @@ typedef struct VhostUserShared {
>      unsigned char uuid[UUID_LEN];
>  } VhostUserShared;
> =20
> +/* For the flags field of VhostUserMMap */
> +#define VHOST_USER_FLAG_MAP_RW (1u << 0)
> +
> +typedef struct {
> +    /* VIRTIO Shared Memory Region ID */
> +    uint8_t shmid;
> +    uint8_t padding[7];
> +    /* File offset */
> +    uint64_t fd_offset;
> +    /* Offset within the VIRTIO Shared Memory Region */
> +    uint64_t shm_offset;
> +    /* Size of the mapping */
> +    uint64_t len;
> +    /* Flags for the mmap operation, from VHOST_USER_FLAG_MAP_* */
> +    uint16_t flags;
> +} VhostUserMMap;
> +
>  #define VU_PACKED __attribute__((packed))
> =20
>  typedef struct VhostUserMsg {
> @@ -210,6 +231,7 @@ typedef struct VhostUserMsg {
>          VhostUserVringArea area;
>          VhostUserInflight inflight;
>          VhostUserShared object;
> +        VhostUserMMap mmap;
>      } payload;
> =20
>      int fds[VHOST_MEMORY_BASELINE_NREGIONS];
> @@ -593,6 +615,38 @@ bool vu_add_shared_object(VuDev *dev, unsigned char =
uuid[UUID_LEN]);
>   */
>  bool vu_rm_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN]);
> =20
> +/**
> + * vu_shmem_map:
> + * @dev: a VuDev context
> + * @shmid: VIRTIO Shared Memory Region ID
> + * @fd_offset: File offset
> + * @shm_offset: Offset within the VIRTIO Shared Memory Region
> + * @len: Size of the mapping
> + * @flags: Flags for the mmap operation
> + * @fd: A file descriptor
> + *
> + * Advertises a new mapping to be made in a given VIRTIO Shared Memory R=
egion.
> + *
> + * Returns: TRUE on success, FALSE on failure.
> + */
> +bool vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
> +                  uint64_t shm_offset, uint64_t len, uint64_t flags, int=
 fd);
> +
> +/**
> + * vu_shmem_unmap:
> + * @dev: a VuDev context
> + * @shmid: VIRTIO Shared Memory Region ID
> + * @fd_offset: File offset
> + * @len: Size of the mapping
> + *
> + * The front-end un-mmaps a given range in the VIRTIO Shared Memory Regi=
on
> + * with the requested `shmid`.
> + *
> + * Returns: TRUE on success, FALSE on failure.
> + */
> +bool vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t shm_offset,
> +                    uint64_t len);
> +
>  /**
>   * vu_queue_set_notification:
>   * @dev: a VuDev context
> --=20
> 2.49.0
>=20

--X0y+SNX3m4YavZX3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhK/fAACgkQnKSrs4Gr
c8jCYAf5AceRKaPcRh9y6XIUWECSLsEc4tAOGxX7oX7YVu7nddYjVdAzW8vtcDOe
LgQSDL26Yjx98AHOqiKtmEpdEShzdqV4uFkGSmlFi0TfXmPfyz+LPnsFitfow2B5
RlxoDToGTlmjoUCwubw/S7m1/RLY97gXjqnt8YnYnON7tbo52HorMKc755FjqfcH
BC06JKfSROf4Pa8PMf/NW2zOwhu0OKyfTjdDKxisgoAVuQKku3hOJkq7AFFlKAbr
jxcJnSlCkVIskjNDUSpabXmrOhD517a6P6qS62QgWuPB0zbvRQl9QkA+bmfYvJka
kn9MbgurN9Vk6vw0OsD6Z/Frya+yXQ==
=ISdc
-----END PGP SIGNATURE-----

--X0y+SNX3m4YavZX3--


