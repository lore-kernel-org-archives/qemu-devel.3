Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE059CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 18:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Inc-0005q9-Gt; Mon, 29 Sep 2025 14:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3InM-0005gK-UV
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:40:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3In9-00058A-Pz
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759171199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T0O+eU4XG8LdJZviIyvo+ga4HJceK4YGN6DUHYWGNOM=;
 b=M0LsO4uv9GzAZXbgaotaG7MYGLfzcHGmgWTmvAiyLYcj3EChsRyjGa75CkYXCHdg7/IZ+0
 jLrTDaPYzsme85AHOOha83nKHB9e9bYPo8dBceaqSlUEw/r7+WnXVJYUpgkuUSCUI2Jcjv
 m10ZvYoeotgKxdlmAscfDxnhtj6QUMc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-Ms1h2fowMP6btFlo2dYRCA-1; Mon,
 29 Sep 2025 14:39:55 -0400
X-MC-Unique: Ms1h2fowMP6btFlo2dYRCA-1
X-Mimecast-MFC-AGG-ID: Ms1h2fowMP6btFlo2dYRCA_1759171194
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5389D1800359; Mon, 29 Sep 2025 18:39:54 +0000 (UTC)
Received: from localhost (unknown [10.2.17.29])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EEF871800452; Mon, 29 Sep 2025 18:39:52 +0000 (UTC)
Date: Mon, 29 Sep 2025 14:39:51 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, stevensd@chromium.org, dbassey@redhat.com,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, slp@redhat.com,
 hi@alyssa.is, Fabiano Rosas <farosas@suse.de>,
 Stefano Garzarella <sgarzare@redhat.com>, jasowang@redhat.com,
 david@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v8 1/7] vhost-user: Add VirtIO Shared Memory map request
Message-ID: <20250929183951.GD81824@fedora>
References: <20250910115420.1012191-1-aesteve@redhat.com>
 <20250910115420.1012191-2-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2UXRdJ/0ElJV1bBM"
Content-Disposition: inline
In-Reply-To: <20250910115420.1012191-2-aesteve@redhat.com>
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


--2UXRdJ/0ElJV1bBM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 01:54:14PM +0200, Albert Esteve wrote:
> Add SHMEM_MAP/UNMAP requests to vhost-user for dynamic management of
> VIRTIO Shared Memory mappings.
>=20
> This implementation introduces VirtioSharedMemoryMapping as a unified
> QOM object that manages both the mapping metadata and MemoryRegion
> lifecycle. This object provides reference-counted lifecycle management
> with automatic cleanup of file descriptors and memory regions
> through QOM finalization.
>=20
> This request allows backends to dynamically map file descriptors into a
> VIRTIO Shared Memory Region identified by their shmid. Maps are created
> using memory_region_init_ram_from_fd() with configurable read/write
> permissions, and the resulting MemoryRegions are added as subregions to
> the shmem container region. The mapped memory is then advertised to the
> guest VIRTIO drivers as a base address plus offset for reading and
> writting according to the requested mmap flags.
>=20
> The backend can unmap memory ranges within a given VIRTIO Shared Memory
> Region to free resources. Upon receiving this message, the frontend
> removes the MemoryRegion as a subregion and automatically unreferences
> the VirtioSharedMemoryMapping object, triggering cleanup if no other
> references exist.
>=20
> Error handling has been improved to ensure consistent behavior across
> handlers that manage their own vhost_user_send_resp() calls. Since
> these handlers clear the VHOST_USER_NEED_REPLY_MASK flag, explicit
> error checking ensures proper connection closure on failures,
> maintaining the expected error flow.
>=20
> Note the memory region commit for these operations needs to be delayed
> until after we respond to the backend to avoid deadlocks.
>=20
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  hw/virtio/vhost-user.c                    | 206 +++++++++++++++++++++-
>  hw/virtio/virtio.c                        | 198 +++++++++++++++++++++
>  include/hw/virtio/virtio.h                | 136 ++++++++++++++
>  subprojects/libvhost-user/libvhost-user.c |  70 ++++++++
>  subprojects/libvhost-user/libvhost-user.h |  54 ++++++
>  5 files changed, 662 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 1e1d6b0d6e..4783b1904b 100644
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
> @@ -1768,6 +1788,172 @@ vhost_user_backend_handle_shared_object_lookup(st=
ruct vhost_user *u,
>      return 0;
>  }
> =20
> +/**
> + * vhost_user_backend_handle_shmem_map() - Handle SHMEM_MAP backend requ=
est
> + * @dev: vhost device
> + * @ioc: QIOChannel for communication
> + * @hdr: vhost-user message header
> + * @payload: message payload containing mapping details
> + * @fd: file descriptor for the shared memory region
> + *
> + * Handles VHOST_USER_BACKEND_SHMEM_MAP requests from the backend. Creat=
es
> + * a VhostUserShmemObject to manage the shared memory mapping and adds it
> + * to the appropriate VirtIO shared memory region. The VhostUserShmemObj=
ect
> + * serves as an intermediate parent for the MemoryRegion, ensuring proper
> + * lifecycle management with reference counting.
> + *
> + * Returns: 0 on success, negative errno on failure
> + */
> +static int
> +vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
> +                                    QIOChannel *ioc,
> +                                    VhostUserHeader *hdr,
> +                                    VhostUserPayload *payload,
> +                                    int fd)
> +{
> +    VirtioSharedMemory *shmem;
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

uninitialized

> +        return -EFAULT;
> +    }
> +
> +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> +        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr.size) {
> +        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
> +                     vu_mmap->shm_offset, vu_mmap->len);
> +        return -EFAULT;
> +    }
> +
> +    g_string_printf(shm_name, "virtio-shm%i-%lu",
> +                    vu_mmap->shmid, vu_mmap->shm_offset);
> +
> +    memory_region_transaction_begin();
> +
> +    /* Create VirtioSharedMemoryMapping object */
> +    VirtioSharedMemoryMapping *mapping =3D virtio_shared_memory_mapping_=
new(
> +        vu_mmap->shmid, fd, vu_mmap->fd_offset, vu_mmap->shm_offset,
> +        vu_mmap->len, vu_mmap->flags & VHOST_USER_FLAG_MAP_RW);
> +
> +    if (!mapping) {
> +        memory_region_transaction_commit();
> +        return -EFAULT;
> +    }
> +
> +    /* Add the mapping to the shared memory region */
> +    if (virtio_add_shmem_map(shmem, mapping) !=3D 0) {
> +        error_report("Failed to add shared memory mapping");
> +        object_unref(OBJECT(mapping));
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
> +/**
> + * vhost_user_backend_handle_shmem_unmap() - Handle SHMEM_UNMAP backend =
request
> + * @dev: vhost device
> + * @ioc: QIOChannel for communication
> + * @hdr: vhost-user message header
> + * @payload: message payload containing unmapping details
> + *
> + * Handles VHOST_USER_BACKEND_SHMEM_UNMAP requests from the backend. Rem=
oves
> + * the specified memory mapping from the VirtIO shared memory region. Th=
is
> + * automatically unreferences the associated VhostUserShmemObject, which=
 may
> + * trigger its finalization and cleanup (munmap, close fd) if no other
> + * references exist.
> + *
> + * Returns: 0 on success, negative errno on failure
> + */
> +static int
> +vhost_user_backend_handle_shmem_unmap(struct vhost_dev *dev,
> +                                      QIOChannel *ioc,
> +                                      VhostUserHeader *hdr,
> +                                      VhostUserPayload *payload)
> +{
> +    VirtioSharedMemory *shmem;
> +    VirtioSharedMemoryMapping *mmap =3D NULL;
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

uninitialized

> +        return -EFAULT;
> +    }
> +
> +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> +        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr.size) {
> +        error_report("Bad offset/len for unmmap %" PRIx64 "+%" PRIx64,
> +                     vu_mmap->shm_offset, vu_mmap->len);
> +        return -EFAULT;
> +    }
> +
> +    mmap =3D virtio_find_shmem_map(shmem, vu_mmap->shm_offset, vu_mmap->=
len);
> +    if (!mmap) {
> +        error_report("Shared memory mapping not found at offset %" PRIx64
> +                     " with length %" PRIx64,
> +                     vu_mmap->shm_offset, vu_mmap->len);
> +        return -EFAULT;
> +    }
> +
> +    memory_region_transaction_begin();
> +    memory_region_del_subregion(&shmem->mr, mmap->mr);
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
> @@ -1833,8 +2019,24 @@ static gboolean backend_read(QIOChannel *ioc, GIOC=
ondition condition,
>                                                               &payload.ob=
ject);
>          break;
>      case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
> -        ret =3D vhost_user_backend_handle_shared_object_lookup(dev->opaq=
ue, ioc,
> -                                                             &hdr, &payl=
oad);
> +        /* Handler manages its own response, check error and close conne=
ction */
> +        if (vhost_user_backend_handle_shared_object_lookup(dev->opaque, =
ioc,
> +                                                           &hdr, &payloa=
d) < 0) {
> +            goto err;
> +        }
> +        break;

This looks like a bug fix that is unrelated to this patch. The change
doesn't look correct though: the vhost-user response is skipped when
vhost_user_backend_handle_shared_object_lookup() returns non-zero and
the return value in the payload is replaced with 0 in the -EINVAL and
vhost_user_get_shared_object() failure cases.

I suggest dropping this and sending a separate patch (independently from
this series) that fixes VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP replies.

> +    case VHOST_USER_BACKEND_SHMEM_MAP:
> +        /* Handler manages its own response, check error and close conne=
ction */

This comment is not true: the response is only sent in the success case.
Errors do not result in a response being sent because goto err skips
vhost_user_send_resp().

Please take a look and ensure that a response is sent in all cases.

> +        if (vhost_user_backend_handle_shmem_map(dev, ioc, &hdr, &payload,
> +                                                fd ? fd[0] : -1) < 0) {
> +            goto err;
> +        }
> +        break;
> +    case VHOST_USER_BACKEND_SHMEM_UNMAP:
> +        /* Handler manages its own response, check error and close conne=
ction */

Same here.

> +        if (vhost_user_backend_handle_shmem_unmap(dev, ioc, &hdr, &paylo=
ad) < 0) {
> +            goto err;
> +        }
>          break;
>      default:
>          error_report("Received unexpected msg type: %d.", hdr.request);
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 9a81ad912e..ba5ffa58bd 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3045,6 +3045,181 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
>      return vmstate_save_state(f, &vmstate_virtio, vdev, NULL);
>  }
> =20
> +VirtioSharedMemory *virtio_new_shmem_region(VirtIODevice *vdev, uint8_t =
shmid, uint64_t size)
> +{
> +    VirtioSharedMemory *elem;
> +    g_autofree char *name =3D NULL;
> +
> +    elem =3D g_new0(VirtioSharedMemory, 1);
> +    elem->shmid =3D shmid;
> +
> +    /* Initialize embedded MemoryRegion as container for shmem mappings =
*/
> +    name =3D g_strdup_printf("virtio-shmem-%d", shmid);
> +    memory_region_init(&elem->mr, OBJECT(vdev), name, size);
> +    QTAILQ_INIT(&elem->mmaps);
> +    QSIMPLEQ_INSERT_TAIL(&vdev->shmem_list, elem, entry);
> +    return elem;
> +}
> +
> +VirtioSharedMemory *virtio_find_shmem_region(VirtIODevice *vdev, uint8_t=
 shmid)
> +{
> +    VirtioSharedMemory *shmem, *next;
> +    QSIMPLEQ_FOREACH_SAFE(shmem, &vdev->shmem_list, entry, next) {
> +        if (shmem->shmid =3D=3D shmid) {
> +            return shmem;
> +        }
> +    }
> +    return NULL;
> +}
> +
> +static void virtio_shared_memory_mapping_instance_init(Object *obj)
> +{
> +    VirtioSharedMemoryMapping *mapping =3D VIRTIO_SHARED_MEMORY_MAPPING(=
obj);
> +
> +    mapping->shmid =3D 0;
> +    mapping->fd =3D -1;
> +    mapping->offset =3D 0;
> +    mapping->len =3D 0;
> +    mapping->mr =3D NULL;
> +}
> +
> +static void virtio_shared_memory_mapping_finalize(Object *obj)

The naming is inconsistent, instance_init vs finalize:
  .instance_init =3D virtio_shared_memory_mapping_instance_init,
  .instance_finalize =3D virtio_shared_memory_mapping_finalize,

virtio_shared_memory_mapping_instance_finalize() would be consistent.

> +{
> +    VirtioSharedMemoryMapping *mapping =3D VIRTIO_SHARED_MEMORY_MAPPING(=
obj);
> +
> +    /* Clean up MemoryRegion if it exists */
> +    if (mapping->mr) {
> +        /* Unparent the MemoryRegion to trigger cleanup */
> +        object_unparent(OBJECT(mapping->mr));
> +        mapping->mr =3D NULL;
> +    }
> +
> +    /* Close file descriptor */
> +    if (mapping->fd >=3D 0) {
> +        close(mapping->fd);
> +        mapping->fd =3D -1;
> +    }
> +}
> +
> +VirtioSharedMemoryMapping *virtio_shared_memory_mapping_new(uint8_t shmi=
d,
> +                                                            int fd,
> +                                                            uint64_t fd_=
offset,
> +                                                            uint64_t shm=
_offset,
> +                                                            uint64_t len,
> +                                                            bool allow_w=
rite)
> +{
> +    VirtioSharedMemoryMapping *mapping;
> +    MemoryRegion *mr;
> +    g_autoptr(GString) mr_name =3D g_string_new(NULL);
> +    uint32_t ram_flags;
> +    Error *local_err =3D NULL;
> +
> +    if (len =3D=3D 0) {
> +        error_report("Shared memory mapping size cannot be zero");
> +        return NULL;
> +    }
> +
> +    fd =3D dup(fd);
> +    if (fd < 0) {
> +        error_report("Failed to duplicate fd: %s", strerror(errno));
> +        return NULL;
> +    }
> +
> +    /* Determine RAM flags */
> +    ram_flags =3D RAM_SHARED;
> +    if (!allow_write) {
> +        ram_flags |=3D RAM_READONLY_FD;
> +    }
> +
> +    /* Create the VirtioSharedMemoryMapping */
> +    mapping =3D VIRTIO_SHARED_MEMORY_MAPPING(
> +        object_new(TYPE_VIRTIO_SHARED_MEMORY_MAPPING));
> +
> +    /* Set up object properties */
> +    mapping->shmid =3D shmid;
> +    mapping->fd =3D fd;
> +    mapping->offset =3D shm_offset;
> +    mapping->len =3D len;
> +
> +    /* Create MemoryRegion as a child of this object */
> +    mr =3D g_new0(MemoryRegion, 1);
> +    g_string_printf(mr_name, "virtio-shmem-%d-%" PRIx64, shmid, shm_offs=
et);
> +
> +    /* Initialize MemoryRegion with file descriptor */
> +    if (!memory_region_init_ram_from_fd(mr, OBJECT(mapping), mr_name->st=
r,
> +                                        len, ram_flags, fd, fd_offset,
> +                                        &local_err)) {
> +        error_report_err(local_err);
> +        g_free(mr);
> +        close(fd);
> +        object_unref(OBJECT(mapping));
> +        return NULL;
> +    }
> +
> +    mapping->mr =3D mr;
> +    return mapping;
> +}
> +
> +int virtio_add_shmem_map(VirtioSharedMemory *shmem,
> +                         VirtioSharedMemoryMapping *mapping)
> +{
> +    if (!mapping) {
> +        error_report("VirtioSharedMemoryMapping cannot be NULL");
> +        return -1;
> +    }
> +    if (!mapping->mr) {
> +        error_report("VirtioSharedMemoryMapping has no MemoryRegion");
> +        return -1;
> +    }
> +
> +    /* Validate boundaries against the VIRTIO shared memory region */
> +    if (mapping->offset + mapping->len > shmem->mr.size) {
> +        error_report("Memory exceeds the shared memory boundaries");
> +        return -1;
> +    }
> +
> +    /* Add as subregion to the VIRTIO shared memory */
> +    memory_region_add_subregion(&shmem->mr, mapping->offset, mapping->mr=
);
> +
> +    /* Add to the mapped regions list */
> +    QTAILQ_INSERT_TAIL(&shmem->mmaps, mapping, link);
> +
> +    return 0;
> +}
> +
> +VirtioSharedMemoryMapping *virtio_find_shmem_map(VirtioSharedMemory *shm=
em,
> +                                          hwaddr offset, uint64_t size)
> +{
> +    VirtioSharedMemoryMapping *mapping;
> +    QTAILQ_FOREACH(mapping, &shmem->mmaps, link) {
> +        if (mapping->offset =3D=3D offset && mapping->mr->size =3D=3D si=
ze) {
> +            return mapping;
> +        }
> +    }
> +    return NULL;
> +}
> +
> +void virtio_del_shmem_map(VirtioSharedMemory *shmem, hwaddr offset,
> +                          uint64_t size)
> +{
> +    VirtioSharedMemoryMapping *mapping =3D virtio_find_shmem_map(shmem, =
offset, size);
> +    if (mapping =3D=3D NULL) {
> +        return;
> +    }
> +
> +    /*
> +     * Remove from memory region first
> +     */
> +    memory_region_del_subregion(&shmem->mr, mapping->mr);

There is an identical call in vhost_user_backend_handle_shmem_unmap().
It looks like memory_region_del_subregion()'s
assert(subregion->container =3D=3D mr) would fail here when called from
vhost_user_backend_handle_shmem_unmap().

How does this work?

> +
> +    /*
> +     * Remove from list and unref the mapping which will trigger automat=
ic cleanup
> +     * when the reference count reaches zero.
> +     */
> +    QTAILQ_REMOVE(&shmem->mmaps, mapping, link);
> +    object_unref(OBJECT(mapping));
> +}
> +
>  /* A wrapper for use as a VMState .put function */
>  static int virtio_device_put(QEMUFile *f, void *opaque, size_t size,
>                                const VMStateField *field, JSONWriter *vmd=
esc)
> @@ -3521,6 +3696,7 @@ void virtio_init(VirtIODevice *vdev, uint16_t devic=
e_id, size_t config_size)
>              NULL, virtio_vmstate_change, vdev);
>      vdev->device_endian =3D virtio_default_endian();
>      vdev->use_guest_notifier_mask =3D true;
> +    QSIMPLEQ_INIT(&vdev->shmem_list);
>  }
> =20
>  /*
> @@ -4032,11 +4208,24 @@ static void virtio_device_free_virtqueues(VirtIOD=
evice *vdev)
>  static void virtio_device_instance_finalize(Object *obj)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(obj);
> +    VirtioSharedMemory *shmem;
> =20
>      virtio_device_free_virtqueues(vdev);
> =20
>      g_free(vdev->config);
>      g_free(vdev->vector_queues);
> +    while (!QSIMPLEQ_EMPTY(&vdev->shmem_list)) {
> +        shmem =3D QSIMPLEQ_FIRST(&vdev->shmem_list);
> +        while (!QTAILQ_EMPTY(&shmem->mmaps)) {
> +            VirtioSharedMemoryMapping *mapping =3D QTAILQ_FIRST(&shmem->=
mmaps);
> +            virtio_del_shmem_map(shmem, mapping->offset, mapping->mr->si=
ze);
> +        }
> +
> +        /* Clean up the embedded MemoryRegion */
> +        object_unparent(OBJECT(&shmem->mr));
> +        QSIMPLEQ_REMOVE_HEAD(&vdev->shmem_list, entry);
> +        g_free(shmem);
> +    }
>  }

The semantics across device reset also need to be defined. I think
mappings should be deleted when the device is reset, but the VIRTIO
Shared Memory Regions should remain. The reason I think this behavior
makes sense is that it prevents stale fds remaining open and mapped into
the guest (e.g. GPU or virtiofs resources). It seems safer than relying
on the backend to unmap explicitly.

> =20
>  static const Property virtio_properties[] =3D {
> @@ -4402,9 +4591,18 @@ static const TypeInfo virtio_device_info =3D {
>      .class_size =3D sizeof(VirtioDeviceClass),
>  };
> =20
> +static const TypeInfo virtio_shared_memory_mapping_info =3D {
> +    .name =3D TYPE_VIRTIO_SHARED_MEMORY_MAPPING,
> +    .parent =3D TYPE_OBJECT,
> +    .instance_size =3D sizeof(VirtioSharedMemoryMapping),
> +    .instance_init =3D virtio_shared_memory_mapping_instance_init,
> +    .instance_finalize =3D virtio_shared_memory_mapping_finalize,
> +};
> +
>  static void virtio_register_types(void)
>  {
>      type_register_static(&virtio_device_info);
> +    type_register_static(&virtio_shared_memory_mapping_info);
>  }
> =20
>  type_init(virtio_register_types)
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index c594764f23..8cecb221cb 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -98,6 +98,46 @@ enum virtio_device_endian {
>      VIRTIO_DEVICE_ENDIAN_BIG,
>  };
> =20
> +#define TYPE_VIRTIO_SHARED_MEMORY_MAPPING "virtio-shared-memory-mapping"
> +OBJECT_DECLARE_SIMPLE_TYPE(VirtioSharedMemoryMapping, VIRTIO_SHARED_MEMO=
RY_MAPPING)
> +
> +/**
> + * VirtioSharedMemoryMapping:
> + * @parent: Parent QOM object
> + * @shmid: VIRTIO Shared Memory Region ID =20
> + * @fd: File descriptor for the shared memory region
> + * @offset: Offset within the VIRTIO Shared Memory Region
> + * @len: Size of the mapping
> + * @mr: MemoryRegion associated with this shared memory mapping
> + * @link: List entry for the shared memory region's mapping list
> + *
> + * A QOM object that represents an individual file descriptor-based shar=
ed
> + * memory mapping within a VIRTIO Shared Memory Region. It manages the
> + * MemoryRegion lifecycle and file descriptor cleanup through QOM refere=
nce
> + * counting. When the object is unreferenced and its reference count dro=
ps
> + * to zero, it automatically cleans up the MemoryRegion and closes the f=
ile
> + * descriptor.
> + */
> +struct VirtioSharedMemoryMapping {
> +    Object parent;
> +   =20
> +    uint8_t shmid;
> +    int fd;
> +    hwaddr offset;
> +    uint64_t len;
> +    MemoryRegion *mr;
> +    QTAILQ_ENTRY(VirtioSharedMemoryMapping) link;
> +};
> +
> +struct VirtioSharedMemory {
> +    uint8_t shmid;
> +    MemoryRegion mr;
> +    QTAILQ_HEAD(, VirtioSharedMemoryMapping) mmaps;
> +    QSIMPLEQ_ENTRY(VirtioSharedMemory) entry;
> +};
> +
> +typedef struct VirtioSharedMemory VirtioSharedMemory;
> +
>  /**
>   * struct VirtIODevice - common VirtIO structure
>   * @name: name of the device
> @@ -167,6 +207,8 @@ struct VirtIODevice
>       */
>      EventNotifier config_notifier;
>      bool device_iotlb_enabled;
> +    /* Shared memory region for mappings. */
> +    QSIMPLEQ_HEAD(, VirtioSharedMemory) shmem_list;
>  };
> =20
>  struct VirtioDeviceClass {
> @@ -295,6 +337,100 @@ void virtio_notify(VirtIODevice *vdev, VirtQueue *v=
q);
> =20
>  int virtio_save(VirtIODevice *vdev, QEMUFile *f);
> =20
> +/**
> + * virtio_new_shmem_region() - Create a new shared memory region
> + * @vdev: VirtIODevice
> + * @shmid: Shared memory ID
> + * @size: Size of the shared memory region
> + *
> + * Creates a new VirtioSharedMemory region for the given device and ID.
> + * The returned VirtioSharedMemory is owned by the VirtIODevice and will
> + * be automatically freed when the device is destroyed. The caller
> + * should not free the returned pointer.
> + *
> + * Returns: Pointer to the new VirtioSharedMemory region, or NULL on fai=
lure
> + */
> +VirtioSharedMemory *virtio_new_shmem_region(VirtIODevice *vdev, uint8_t =
shmid, uint64_t size);
> +
> +/**
> + * virtio_find_shmem_region() - Find an existing shared memory region
> + * @vdev: VirtIODevice
> + * @shmid: Shared memory ID to find
> + *
> + * Finds an existing VirtioSharedMemory region by ID. The returned point=
er
> + * is owned by the VirtIODevice and should not be freed by the caller.
> + *
> + * Returns: Pointer to the VirtioSharedMemory region, or NULL if not fou=
nd
> + */
> +VirtioSharedMemory *virtio_find_shmem_region(VirtIODevice *vdev, uint8_t=
 shmid);
> +
> +/**
> + * virtio_shared_memory_mapping_new() - Create a new VirtioSharedMemoryM=
apping
> + * @shmid: VIRTIO Shared Memory Region ID
> + * @fd: File descriptor for the shared memory
> + * @fd_offset: Offset within the file descriptor
> + * @shm_offset: Offset within the VIRTIO Shared Memory Region
> + * @len: Size of the mapping
> + * @allow_write: Whether to allow write access to the mapping
> + *
> + * Creates a new VirtioSharedMemoryMapping that manages a shared memory =
mapping.
> + * The object will create a MemoryRegion using memory_region_init_ram_fr=
om_fd()
> + * as a child object. When the object is finalized, it will automatically
> + * clean up the MemoryRegion and close the file descriptor.
> + *
> + * Return: A new VirtioSharedMemoryMapping on success, NULL on error.
> + */
> +VirtioSharedMemoryMapping *virtio_shared_memory_mapping_new(uint8_t shmi=
d,
> +                                                            int fd,
> +                                                            uint64_t fd_=
offset,
> +                                                            uint64_t shm=
_offset,
> +                                                            uint64_t len,
> +                                                            bool allow_w=
rite);
> +
> +/**
> + * virtio_add_shmem_map() - Add a memory mapping to a shared region
> + * @shmem: VirtioSharedMemory region
> + * @mapping: VirtioSharedMemoryMapping to add (transfers ownership)
> + *
> + * Adds a memory mapping to the shared memory region. The VirtioSharedMe=
moryMapping
> + * ownership is transferred to the shared memory region and will be auto=
matically
> + * cleaned up through QOM reference counting when virtio_del_shmem_map()=
 is
> + * called or when the shared memory region is destroyed.
> + *
> + * Returns: 0 on success, negative errno on failure
> + */
> +int virtio_add_shmem_map(VirtioSharedMemory *shmem,
> +                         VirtioSharedMemoryMapping *mapping);
> +
> +/**
> + * virtio_find_shmem_map() - Find a memory mapping in a shared region
> + * @shmem: VirtioSharedMemory region
> + * @offset: Offset within the shared memory region
> + * @size: Size of the mapping to find
> + *
> + * Finds an existing memory mapping that covers the specified range.
> + * The returned VirtioSharedMemoryMapping is owned by the VirtioSharedMe=
mory
> + * region and should not be freed by the caller.
> + *
> + * Returns: Pointer to the VirtioSharedMemoryMapping, or NULL if not fou=
nd
> + */
> +VirtioSharedMemoryMapping *virtio_find_shmem_map(VirtioSharedMemory *shm=
em,
> +                                          hwaddr offset, uint64_t size);
> +
> +/**
> + * virtio_del_shmem_map() - Remove a memory mapping from a shared region
> + * @shmem: VirtioSharedMemory region
> + * @offset: Offset of the mapping to remove
> + * @size: Size of the mapping to remove
> + *
> + * Removes a memory mapping from the shared memory region. This will
> + * automatically unref the associated VhostUserShmemObject, which may
> + * trigger its finalization and cleanup if no other references exist.
> + * The mapping's MemoryRegion will be properly unmapped and cleaned up.
> + */
> +void virtio_del_shmem_map(VirtioSharedMemory *shmem, hwaddr offset,
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

--2UXRdJ/0ElJV1bBM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmja0ncACgkQnKSrs4Gr
c8glWggAj725igs6R1TSW8nNE4iotH7C1kWv6lpRas4w/+ExqZHst4zuzb84ER+L
c3uwFyjbMY86NopL+V/UEoqq2kTPDVx6emMP3nc6n/xGufzEIO+s8u/nJ2uwAitZ
oIS59oh7efoFseR8a+lvENH/8WI14YKibecc5HDAcxeFVV+Zc7+8JeOyOSvrCiO2
g71OJc8oUogBXpVWEtZOlYZXaUXx+FxQy+sxjC3K3n1b9OC23CDfaVe7kqIbMfq7
yDmwxdAWuOJSmXfuAVnGzp0ggK3VEGDCMXNf+I7kLN6YL0i/hgZ2VucxxW4rGAyG
FuUr+6uHaxFYeBWOGWaJmootqgIQyw==
=FMTA
-----END PGP SIGNATURE-----

--2UXRdJ/0ElJV1bBM--


