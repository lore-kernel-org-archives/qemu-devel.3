Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479C6C3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 17:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqFQ2-0004G8-Ey; Mon, 16 Sep 2024 13:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sqFQ0-0004Fc-E4
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 13:21:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sqFPy-00022i-6V
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 13:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726507300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ukBrW9IrapY789/d7tPkVDk8shbmU5uX8iA+rMIPA34=;
 b=dE8wJG/MwAoq+k60oZdf6ZipqUKjp/sYMkx4nh+jkpuagdZ0xjf/ONyVLJqJdkicYqrDuO
 iDaXRAYPDKOvroO36CLlBGI5WDV4CbO8VuTWIh2QKiJMXElIiS0YYQ6uFbBzwCPkpqkwl/
 W+FL10VrpjNDOez75o5aEXAx3Q2zZJQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-SqIU6BEjOOWDI8lNYlLVwQ-1; Mon,
 16 Sep 2024 13:21:36 -0400
X-MC-Unique: SqIU6BEjOOWDI8lNYlLVwQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3275E1933E97; Mon, 16 Sep 2024 17:21:34 +0000 (UTC)
Received: from localhost (unknown [10.2.16.252])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 53F253001FE8; Mon, 16 Sep 2024 17:21:32 +0000 (UTC)
Date: Mon, 16 Sep 2024 19:21:30 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 slp@redhat.com, hi@alyssa.is, mst@redhat.com, david@redhat.com,
 jasowang@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
 stevensd@chromium.org
Subject: Re: [PATCH v3 1/5] vhost-user: Add VIRTIO Shared Memory map request
Message-ID: <20240916172130.GE521955@fedora.home>
References: <20240912145335.129447-1-aesteve@redhat.com>
 <20240912145335.129447-2-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UDOlremhtS706+sx"
Content-Disposition: inline
In-Reply-To: <20240912145335.129447-2-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--UDOlremhtS706+sx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 04:53:31PM +0200, Albert Esteve wrote:
> Add SHMEM_MAP/UNMAP requests to vhost-user to
> handle VIRTIO Shared Memory mappings.
>=20
> This request allows backends to dynamically map
> fds into a VIRTIO Shared Memory Region indentified
> by its `shmid`. Then, the fd memory is advertised
> to the driver as a base addres + offset, so it
> can be read/written (depending on the mmap flags
> requested) while its valid.
>=20
> The backend can munmap the memory range
> in a given VIRTIO Shared Memory Region (again,
> identified by its `shmid`), to free it. Upon
> receiving this message, the front-end must
> mmap the regions with PROT_NONE to reserve
> the virtual memory space.
>=20
> The device model needs to create MemoryRegion
> instances for the VIRTIO Shared Memory Regions
> and add them to the `VirtIODevice` instance.
>=20
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  hw/virtio/vhost-user.c                    | 122 ++++++++++++++++++++++
>  hw/virtio/virtio.c                        |  13 +++
>  include/hw/virtio/virtio.h                |   5 +
>  subprojects/libvhost-user/libvhost-user.c |  60 +++++++++++
>  subprojects/libvhost-user/libvhost-user.h |  52 +++++++++
>  5 files changed, 252 insertions(+)
>=20
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 00561daa06..338cc942ec 100644
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
> @@ -192,6 +194,24 @@ typedef struct VhostUserShared {
>      unsigned char uuid[16];
>  } VhostUserShared;
> =20
> +/* For the flags field of VhostUserMMap */
> +#define VHOST_USER_FLAG_MAP_R (1u << 0)
> +#define VHOST_USER_FLAG_MAP_W (1u << 1)
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
> +    /* Flags for the mmap operation, from VHOST_USER_FLAG_* */
> +    uint64_t flags;
> +} VhostUserMMap;
> +
>  typedef struct {
>      VhostUserRequest request;
> =20
> @@ -224,6 +244,7 @@ typedef union {
>          VhostUserInflight inflight;
>          VhostUserShared object;
>          VhostUserTransferDeviceState transfer_state;
> +        VhostUserMMap mmap;
>  } VhostUserPayload;
> =20
>  typedef struct VhostUserMsg {
> @@ -1749,6 +1770,100 @@ vhost_user_backend_handle_shared_object_lookup(st=
ruct vhost_user *u,
>      return 0;
>  }
> =20
> +static int
> +vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
> +                                    VhostUserMMap *vu_mmap,
> +                                    int fd)
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
> +        error_report("Device only has %d VIRTIO Shared Memory Regions. "
> +                     "Requested ID: %d",
> +                     dev->vdev->n_shmem_regions, vu_mmap->shmid);
> +        return -EFAULT;
> +    }
> +
> +    mr =3D &dev->vdev->shmem_list[vu_mmap->shmid];
> +
> +    if (!mr) {
> +        error_report("VIRTIO Shared Memory Region at "
> +                     "ID %d unitialized", vu_mmap->shmid);
> +        return -EFAULT;
> +    }
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
> +
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
> +                                      VhostUserMMap *vu_mmap)
> +{
> +    void *addr =3D 0;
> +    MemoryRegion *mr =3D NULL;
> +
> +    if (!dev->vdev->shmem_list ||
> +        dev->vdev->n_shmem_regions <=3D vu_mmap->shmid) {
> +        error_report("Device only has %d VIRTIO Shared Memory Regions. "
> +                     "Requested ID: %d",
> +                     dev->vdev->n_shmem_regions, vu_mmap->shmid);
> +        return -EFAULT;
> +    }
> +
> +    mr =3D &dev->vdev->shmem_list[vu_mmap->shmid];
> +
> +    if (!mr) {
> +        error_report("VIRTIO Shared Memory Region at "
> +                     "ID %d unitialized", vu_mmap->shmid);
> +        return -EFAULT;
> +    }
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
> @@ -1817,6 +1932,13 @@ static gboolean backend_read(QIOChannel *ioc, GIOC=
ondition condition,
>          ret =3D vhost_user_backend_handle_shared_object_lookup(dev->opaq=
ue, ioc,
>                                                               &hdr, &payl=
oad);
>          break;
> +    case VHOST_USER_BACKEND_SHMEM_MAP:
> +        ret =3D vhost_user_backend_handle_shmem_map(dev, &payload.mmap,
> +                                                  fd ? fd[0] : -1);
> +        break;
> +    case VHOST_USER_BACKEND_SHMEM_UNMAP:
> +        ret =3D vhost_user_backend_handle_shmem_unmap(dev, &payload.mmap=
);
> +        break;
>      default:
>          error_report("Received unexpected msg type: %d.", hdr.request);
>          ret =3D -EINVAL;
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 9e10cbc058..ccc4f2cd75 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3059,6 +3059,17 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
>      return vmstate_save_state(f, &vmstate_virtio, vdev, NULL);
>  }
> =20
> +MemoryRegion *virtio_new_shmem_region(VirtIODevice *vdev)
> +{
> +    MemoryRegion *mr;
> +    ++vdev->n_shmem_regions;
> +    vdev->shmem_list =3D g_renew(MemoryRegion, vdev->shmem_list,
> +                               vdev->n_shmem_regions);
> +    mr =3D &vdev->shmem_list[vdev->n_shmem_regions - 1];
> +    mr =3D g_new0(MemoryRegion, 1);
> +    return mr;
> +}

This function looks broken. shmem_list[] is reallocated so old
MemoryRegion pointers will be dangling pointers. And then the
MemoryRegion is allocated again using g_new0() but there is no way to
retrieve that address again via shmem_list[].

I expected something like this:

  MemoryRegion *virtio_new_shmem_region(VirtIODevice *vdev)
  {
      MemoryRegion *mr;

      assert(vdev->n_shmem_regions < INT_MAX);
      ++vdev->n_shmem_regions;
      vdev->shmem_list =3D g_renew(MemoryRegion *, vdev->shmem_list,
                                 vdev->n_shmem_regions);
      mr =3D g_new0(MemoryRegion, 1);
      vdev->shmem_list[vdev->n_shmem_regions - 1] =3D mr;
      return mr;
  }

> +
>  /* A wrapper for use as a VMState .put function */
>  static int virtio_device_put(QEMUFile *f, void *opaque, size_t size,
>                                const VMStateField *field, JSONWriter *vmd=
esc)
> @@ -3481,6 +3492,8 @@ void virtio_init(VirtIODevice *vdev, uint16_t devic=
e_id, size_t config_size)
>              virtio_vmstate_change, vdev);
>      vdev->device_endian =3D virtio_default_endian();
>      vdev->use_guest_notifier_mask =3D true;
> +    vdev->shmem_list =3D NULL;

shmem_list[] and each MemoryRegion needs to be free somewhere.
virtio_device_instance_finalize()?

> +    vdev->n_shmem_regions =3D 0;
>  }
> =20
>  /*
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 0fcbc5c0c6..d4a2f664d9 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -167,6 +167,9 @@ struct VirtIODevice
>       */
>      EventNotifier config_notifier;
>      bool device_iotlb_enabled;
> +    /* Shared memory region for vhost-user mappings. */
> +    MemoryRegion *shmem_list;
> +    int n_shmem_regions;
>  };
> =20
>  struct VirtioDeviceClass {
> @@ -286,6 +289,8 @@ void virtio_notify(VirtIODevice *vdev, VirtQueue *vq);
> =20
>  int virtio_save(VirtIODevice *vdev, QEMUFile *f);
> =20
> +MemoryRegion *virtio_new_shmem_region(VirtIODevice *vdev);
> +
>  extern const VMStateInfo virtio_vmstate_info;
> =20
>  #define VMSTATE_VIRTIO_DEVICE \
> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libv=
host-user/libvhost-user.c
> index 9c630c2170..496268e12b 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -1592,6 +1592,66 @@ vu_rm_shared_object(VuDev *dev, unsigned char uuid=
[UUID_LEN])
>      return vu_send_message(dev, &msg);
>  }
> =20
> +bool
> +vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
> +             uint64_t shm_offset, uint64_t len, uint64_t flags)
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
> +    };
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
> index deb40e77b3..ea4902e876 100644
> --- a/subprojects/libvhost-user/libvhost-user.h
> +++ b/subprojects/libvhost-user/libvhost-user.h
> @@ -127,6 +127,8 @@ typedef enum VhostUserBackendRequest {
>      VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,
>      VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,
>      VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
> +    VHOST_USER_BACKEND_SHMEM_MAP =3D 9,
> +    VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,
>      VHOST_USER_BACKEND_MAX
>  }  VhostUserBackendRequest;
> =20
> @@ -186,6 +188,24 @@ typedef struct VhostUserShared {
>      unsigned char uuid[UUID_LEN];
>  } VhostUserShared;
> =20
> +/* For the flags field of VhostUserMMap */
> +#define VHOST_USER_FLAG_MAP_R (1u << 0)
> +#define VHOST_USER_FLAG_MAP_W (1u << 1)
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
> +    /* Flags for the mmap operation, from VHOST_USER_FLAG_* */
> +    uint64_t flags;
> +} VhostUserMMap;
> +
>  #if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
>  # define VU_PACKED __attribute__((gcc_struct, packed))
>  #else
> @@ -214,6 +234,7 @@ typedef struct VhostUserMsg {
>          VhostUserVringArea area;
>          VhostUserInflight inflight;
>          VhostUserShared object;
> +        VhostUserMMap mmap;
>      } payload;
> =20
>      int fds[VHOST_MEMORY_BASELINE_NREGIONS];
> @@ -597,6 +618,37 @@ bool vu_add_shared_object(VuDev *dev, unsigned char =
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
> + *
> + * Advertises a new mapping to be made in a given VIRTIO Shared Memory R=
egion.
> + *
> + * Returns: TRUE on success, FALSE on failure.
> + */
> +bool vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
> +                  uint64_t shm_offset, uint64_t len, uint64_t flags);

How is the fd passed to the front-end?

> +
> +/**
> + * vu_shmem_map:

"vu_shmem_unmap:"

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
> 2.45.2
>=20

--UDOlremhtS706+sx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmboaRoACgkQnKSrs4Gr
c8iHXwf/UBHKq+QNY+yBRLGqXTs5sI/Ih94PUIjs/S2M+ViBKFhBiXieCYMNZviR
/WHsz5FhUbEB6qxaX4HQm9xKXHNAsngFCWtpGm4DzP7o5HXu7OyjHP50hH81zg5R
jvkslB7QUY3Ed6eicIjveZN+IGK7MCtb2VajDVk6CVBOLLgvDfzgu1aMJutOy0j8
S3OYXneKtVyKzvUSgsRiGJA+BJSbJv4W1ziEXUV+Wl3mNMqKmCJsNPm/VElN9G/C
aCjhfLmoZ1B+nb2p8uB8EY8KFNsTIemioUXD9ALmoVFAh2B8mGB24dN36dMSVJhn
WZC2DBFU/8jvb4jedwp7qLI0WurcHA==
=4HBi
-----END PGP SIGNATURE-----

--UDOlremhtS706+sx--


