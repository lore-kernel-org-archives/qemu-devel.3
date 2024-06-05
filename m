Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63BBC27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 08:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sElmS-00044v-Mr; Wed, 05 Jun 2024 04:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1sElmQ-00044f-UF
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:13:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1sElmN-0001HB-DH
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717575234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mnHzxH+/AEWeerQ3jxI8q/cidVVZEDDgV7PjVa3wlIM=;
 b=QBqO1SUbtg94mrUgYEKYvkuNU9+N/t/MFMBUnEF2ROvzKPWcHUU6QFgUITaVyZHmsun7zR
 r+tqV/3RiBGQW7+P04khPtefYGOp9qQ0ysmLUHXUmuJ8AN2GYtjt/fO5VeXIzKjuAl0Vz4
 0Yz4ctjvAEPWEfPwE90VmDgR8xFn9gw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-JL5Ex0SJMv-feEg0PQdpaw-1; Wed, 05 Jun 2024 04:13:45 -0400
X-MC-Unique: JL5Ex0SJMv-feEg0PQdpaw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2c1e6fc4122so1967571a91.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 01:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717575224; x=1718180024;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mnHzxH+/AEWeerQ3jxI8q/cidVVZEDDgV7PjVa3wlIM=;
 b=g27ytHWmehPwY1DTvUvDtvIub8Vv8YUCM77F6NSFadbCvLg39b9d6o11QqEdedn76w
 3pevnGSM+VsMfySFh+C6PqNyyphmj0v00NbhbVUNbc1l96bgsyrsBfTmRlcz4KAaurGf
 dZkI7nLRmVul1a1Z/x9MnX5FQ6Nn7zsw7Ri2mW3FG4GCn3aPCmwbnZNz0Tj5IVgB6bP8
 uY4uWXJj+pYfzCpl9yPoncONJo1dQto+iMy4xQDOrNn2EPYzznCASos5k9g7RW1al3pW
 IdSWnFK9gfmPJEhft0ILW5JN0CIzIaGXeNF2xnzSZ32MCMdYaNofU9OFcBv/v90KtQEL
 Zqwg==
X-Gm-Message-State: AOJu0YzbKBJCBTJvzD5ugTVzWw6/GsFiASJ/X8bWJAmyWBBP3pMY4ddW
 2Ux0HA0ocU4H5L+1L/aGjYJXsvrlMP9lRvONX8LqbyEG5b3C0Wg4L2XmqsCSa8vy+cZFHAqakFJ
 bDZLcJOxnfltjigqtCx5FqgJ4TIRqgXmB1Jo05ZiTe7yoiuY0HJmUwqpZyAm+dOFcPFmaIzPkL6
 Or38OtC61M9zwc5Z6T+xUBNUBFJG6yBaBbdd2Dsw==
X-Received: by 2002:a17:90b:46c7:b0:2c2:264a:3704 with SMTP id
 98e67ed59e1d1-2c27db0ac9emr1808486a91.18.1717575224234; 
 Wed, 05 Jun 2024 01:13:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/PCDakJeCquIc9l426MF3bIltYmYn1B/gEMnJxKST99sG9UjMLdfQQ7PzSLqUvf7xndnNzZOeedvzEZjabR8=
X-Received: by 2002:a17:90b:46c7:b0:2c2:264a:3704 with SMTP id
 98e67ed59e1d1-2c27db0ac9emr1808465a91.18.1717575223588; Wed, 05 Jun 2024
 01:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240530152223.780232-1-aesteve@redhat.com>
 <20240530152223.780232-2-aesteve@redhat.com>
 <20240604185416.GB90471@fedora.redhat.com>
In-Reply-To: <20240604185416.GB90471@fedora.redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 5 Jun 2024 10:13:32 +0200
Message-ID: <CADSE00+yvsOhiJJg0ePgr7AYVCkjm9xWNj7KpAOFMwj2wuEpGg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] vhost-user: add shmem mmap request
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, slp@redhat.com, jasowang@redhat.com
Content-Type: multipart/alternative; boundary="00000000000013cd5b061a2025db"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--00000000000013cd5b061a2025db
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 8:54=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:

> On Thu, May 30, 2024 at 05:22:23PM +0200, Albert Esteve wrote:
> > Add SHMEM_MAP/UNMAP requests to vhost-user.
> >
> > This request allows backends to dynamically map
> > fds into a shared memory region indentified by
>
> Please call this "VIRTIO Shared Memory Region" everywhere (code,
> vhost-user spec, commit description, etc) so it's clear that this is not
> about vhost-user shared memory tables/regions.
>
> > its `shmid`. Then, the fd memory is advertised
> > to the frontend through a BAR+offset, so it can
> > be read by the driver while its valid.
>
> Why is a PCI BAR mentioned here? vhost-user does not know about the
> VIRTIO Transport (e.g. PCI) being used. It's the frontend's job to
> report VIRTIO Shared Memory Regions to the driver.
>
>
I will remove PCI BAR, as it is true that it depends on the
transport. I was trying to explain that the driver
will use the shm_base + shm_offset to access
the mapped memory.


> >
> > Then, the backend can munmap the memory range
> > in a given shared memory region (again, identified
> > by its `shmid`), to free it. After this, the
> > region becomes private and shall not be accessed
> > by the frontend anymore.
>
> What does "private" mean?
>
> The frontend must mmap PROT_NONE to reserve the virtual memory space
> when no fd is mapped in the VIRTIO Shared Memory Region. Otherwise an
> unrelated mmap(NULL, ...) might use that address range and the guest
> would have access to the host memory! This is a security issue and needs
> to be mentioned explicitly in the spec.
>

I mentioned private because it changes the mapping from MAP_SHARED
to MAP_PRIVATE. I will highlight PROT_NONE instead.


>
> >
> > Initializing the memory region is reponsiblity
> > of the PCI device that will using it.
>
> What does this mean?
>

The MemoryRegion is declared in `struct VirtIODevice`,
but it is uninitialized in this commit. So I was trying to say
that the initialization will happen in, e.g., vhost-user-gpu-pci.c
with something like `memory_region_init` , and later `pci_register_bar`.

I am testing that part still.


>
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  docs/interop/vhost-user.rst |  23 ++++++++
> >  hw/virtio/vhost-user.c      | 106 ++++++++++++++++++++++++++++++++++++
> >  hw/virtio/virtio.c          |   2 +
> >  include/hw/virtio/virtio.h  |   3 +
> >  4 files changed, 134 insertions(+)
>
> Two missing pieces:
>
> 1. QEMU's --device vhost-user-device needs a way to enumerate VIRTIO
> Shared Memory Regions from the vhost-user backend. vhost-user-device is
> a generic vhost-user frontend without knowledge of the device type, so
> it doesn't know what the valid shmids are and what size the regions
> have.
>

Ok. I was assuming that if a device (backend) makes a request without a
valid shmid or not enough size in the region to perform the mmap, would
just fail in the VMM performing the actual mmap operation. So it would
not necessarily need to know about valid shmids or region sizes.


>
> 2. Other backends don't see these mappings. If the guest submits a vring
> descriptor referencing a mapping to another backend, then that backend
> won't be able to access this memory. David Gilbert hit this problem when
> working on the virtiofs DAX Window. Either the frontend needs to forward
> all SHMAP_MAP/UNMAP messages to the other backends (inefficient and
> maybe racy!) or a new "memcpy" message is needed as a fallback for when
> vhost-user memory region translation fails.
>

Ok. In which scenario would another device want to access the same mapping?
If it is for a shared VIRTIO object, the device that receives the dmabuf fd
could
just do a new mapping in its VIRTIO shared memory region.


>
> >
> > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> > index d8419fd2f1..3caf2a290c 100644
> > --- a/docs/interop/vhost-user.rst
> > +++ b/docs/interop/vhost-user.rst
> > @@ -1859,6 +1859,29 @@ is sent by the front-end.
> >    when the operation is successful, or non-zero otherwise. Note that i=
f
> the
> >    operation fails, no fd is sent to the backend.
> >
> > +``VHOST_USER_BACKEND_SHMEM_MAP``
> > +  :id: 9
> > +  :equivalent ioctl: N/A
> > +  :request payload: fd and ``struct VhostUserMMap``
> > +  :reply payload: N/A
> > +
> > +  This message can be submitted by the backends to advertise a new
> mapping
> > +  to be made in a given shared memory region. Upon receiving the
> message,
> > +  QEMU will mmap the given fd into the shared memory region with the
>
> s/QEMU/the frontend/
>
> > +  requested ``shmid``. A reply is generated indicating whether mapping
> > +  succeeded.
>
> Please document whether mapping over an existing mapping is allowed. I
> think it should be allowed because it might be useful to atomically
> update a mapping without a race where the driver sees unmapped memory.
>
>
So in my understanding, the frontend (driver) in the guest would initiate
the
mmap/munmap by sending request to the backend (vhost-user device).
Then the vhost-user device sends a request to the VMM to perform the
mapping. We could enforce an ACK to ensure that the mmap operation finished
before the vhost-user device responds to the driver, and thus avoid
races. This way, we support only the simple usecase of not allowing
mmaps over an already mapped region.


> If mapping over an existing mapping is allowed, does the new mapping
> need to cover the old mapping exactly, or can it span multiple previous
> mappings or a subset of an existing mapping?
>
> From a security point of view we need to be careful here. A potentially
> untrusted backend process now has the ability to mmap an arbitrary file
> descriptor into the frontend process. The backend can cause
> denial of service by creating many small mappings to exhaust the OS
> limits on virtual memory areas. The backend can map memory to use as
> part of a security compromise, so we need to be sure the virtual memory
> addresses are not leaked to the backend and only read/write page
> permissions are available.
>

Right, security from untrusted backends is usally the hardest part to me.
But vhost-user devices do only see shm_offset, so this should be safe, no?


>
> > +``VHOST_USER_BACKEND_SHMEM_UNMAP``
> > +  :id: 10
> > +  :equivalent ioctl: N/A
> > +  :request payload: ``struct VhostUserMMap``
> > +  :reply payload: N/A
> > +
> > +  This message can be submitted by the backends so that QEMU un-mmap
>
> s/QEMU/the frontend/
>

This is probably my bad, but I really thought the frontend is the driver.
So frontend/backend as alternative terms for vhost-user driver/device.
And then here we would keep QEMU or use VMM instead?


>
> > +  a given range (``offset``, ``len``) in the shared memory region with
> the
> > +  requested ``shmid``.
>
> Does the range need to correspond to a previously-mapped VhostUserMMap
> or can it cross multiple VhostUserMMaps, be a subset of a VhostUserMMap,
> etc?
>

I would prefer to keep it simple and disallow mapping over a
previously-mapped
region. The range need to correspond to a valid (within size bound), free,
memory region, or else the request will fail. I will add that to the text.

Nonetheless, I am open to discuss other options.


>
> > +  A reply is generated indicating whether unmapping succeeded.
> > +
> >  .. _reply_ack:
> >
> >  VHOST_USER_PROTOCOL_F_REPLY_ACK
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index cdf9af4a4b..9526b9d07f 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -115,6 +115,8 @@ typedef enum VhostUserBackendRequest {
> >      VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,
> >      VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,
> >      VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
> > +    VHOST_USER_BACKEND_SHMEM_MAP =3D 9,
> > +    VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,
> >      VHOST_USER_BACKEND_MAX
> >  }  VhostUserBackendRequest;
> >
> > @@ -192,6 +194,23 @@ typedef struct VhostUserShared {
> >      unsigned char uuid[16];
> >  } VhostUserShared;
> >
> > +/* For the flags field of VhostUserMMap */
> > +#define VHOST_USER_FLAG_MAP_R (1u << 0)
> > +#define VHOST_USER_FLAG_MAP_W (1u << 1)
> > +
> > +typedef struct {
> > +    /* Shared memory region ID */
> > +    uint8_t shmid;
>
> There is a hole (padding) in the struct since the following fields are
> naturally aligned to 8 bytes. I suggest moving shmid to the end to
> reduce the chance of information leaks if padding is not zeroed.
>

I see. I can move it to the end of the struct or add a padding field in
between. I'll do what you suggested, as it sound like the simplest solution=
.


>
> > +    /* File offset */
> > +    uint64_t fd_offset;
> > +    /* Offset within the shared memory region */
> > +    uint64_t shm_offset;
> > +    /* Size of region to map */
>
> To avoid giving "region" additional meanings:
>
> s/Size of the region to map/Size of the mapping/
>

Ok, I will change it in the next drop. Probably will keep the RFC for
at least one more patch, seeing that there are a few things I wasn't
correctly considering.

Thanks for all the feedback!


>
> > +    uint64_t len;
> > +    /* Flags for the mmap operation, from VHOST_USER_FLAG_* */
> > +    uint64_t flags;
> > +} VhostUserMMap;
> > +
> >  typedef struct {
> >      VhostUserRequest request;
> >
> > @@ -224,6 +243,7 @@ typedef union {
> >          VhostUserInflight inflight;
> >          VhostUserShared object;
> >          VhostUserTransferDeviceState transfer_state;
> > +        VhostUserMMap mmap;
> >  } VhostUserPayload;
> >
> >  typedef struct VhostUserMsg {
> > @@ -1748,6 +1768,85 @@
> vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
> >      return 0;
> >  }
> >
> > +static int
> > +vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
> > +                                  VhostUserMMap *vu_mmap,
> > +                                  int fd)
> > +{
> > +    void *addr =3D 0;
> > +    MemoryRegion *mr =3D NULL;
> > +
> > +    if (fd < 0) {
> > +        error_report("Bad fd for map");
> > +        return -EBADF;
> > +    }
> > +
> > +    if (!dev->vdev->shmem_list ||
> > +        dev->vdev->n_shmem_regions <=3D vu_mmap->shmid) {
> > +        error_report("Shared memory region at "
> > +                     "ID %d unitialized", vu_mmap->shmid);
> > +        return -EFAULT;
> > +    }
> > +
> > +    mr =3D &dev->vdev->shmem_list[vu_mmap->shmid];
> > +
> > +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> > +        (vu_mmap->shm_offset + vu_mmap->len) > mr->size) {
> > +        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
> > +                     vu_mmap->shm_offset, vu_mmap->len);
> > +        return -EFAULT;
> > +    }
> > +
> > +    void *shmem_ptr =3D memory_region_get_ram_ptr(mr);
> > +
> > +    addr =3D mmap(shmem_ptr + vu_mmap->shm_offset, vu_mmap->len,
> > +        ((vu_mmap->flags & VHOST_USER_FLAG_MAP_R) ? PROT_READ : 0) |
> > +        ((vu_mmap->flags & VHOST_USER_FLAG_MAP_W) ? PROT_WRITE : 0),
> > +        MAP_SHARED | MAP_FIXED, fd, vu_mmap->fd_offset);
> > +    if (addr =3D=3D MAP_FAILED) {
> > +        error_report("Failed to mmap mem fd");
> > +        return -EFAULT;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static int
> > +vhost_user_backend_handle_shmem_unmap(struct vhost_dev *dev,
> > +                                    VhostUserMMap *vu_mmap)
> > +{
> > +    void *addr =3D 0;
> > +    MemoryRegion *mr =3D NULL;
> > +
> > +    if (!dev->vdev->shmem_list ||
> > +        dev->vdev->n_shmem_regions <=3D vu_mmap->shmid) {
> > +        error_report("Shared memory region at "
> > +                     "ID %d unitialized", vu_mmap->shmid);
> > +        return -EFAULT;
> > +    }
> > +
> > +    mr =3D &dev->vdev->shmem_list[vu_mmap->shmid];
> > +
> > +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> > +        (vu_mmap->shm_offset + vu_mmap->len) > mr->size) {
> > +        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
> > +                     vu_mmap->shm_offset, vu_mmap->len);
> > +        return -EFAULT;
> > +    }
> > +
> > +    void *shmem_ptr =3D memory_region_get_ram_ptr(mr);
> > +
> > +    addr =3D mmap(shmem_ptr + vu_mmap->shm_offset, vu_mmap->len,
> > +                PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1=
,
> 0);
> > +
> > +    if (addr =3D=3D MAP_FAILED) {
> > +        error_report("Failed to unmap memory");
> > +        return -EFAULT;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> >  static void close_backend_channel(struct vhost_user *u)
> >  {
> >      g_source_destroy(u->backend_src);
> > @@ -1816,6 +1915,13 @@ static gboolean backend_read(QIOChannel *ioc,
> GIOCondition condition,
> >          ret =3D
> vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
> >                                                               &hdr,
> &payload);
> >          break;
> > +    case VHOST_USER_BACKEND_SHMEM_MAP:
> > +        ret =3D vhost_user_backend_handle_shmem_map(dev, &payload.mmap=
,
> > +                                                fd ? fd[0] : -1);
> > +        break;
> > +    case VHOST_USER_BACKEND_SHMEM_UNMAP:
> > +        ret =3D vhost_user_backend_handle_shmem_unmap(dev, &payload.mm=
ap);
> > +        break;
> >      default:
> >          error_report("Received unexpected msg type: %d.", hdr.request)=
;
> >          ret =3D -EINVAL;
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 893a072c9d..59596370ec 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -3264,6 +3264,8 @@ void virtio_init(VirtIODevice *vdev, uint16_t
> device_id, size_t config_size)
> >              virtio_vmstate_change, vdev);
> >      vdev->device_endian =3D virtio_default_endian();
> >      vdev->use_guest_notifier_mask =3D true;
> > +    vdev->shmem_list =3D NULL;
> > +    vdev->n_shmem_regions =3D 0;
> >  }
> >
> >  /*
> > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > index 7d5ffdc145..34bec26593 100644
> > --- a/include/hw/virtio/virtio.h
> > +++ b/include/hw/virtio/virtio.h
> > @@ -165,6 +165,9 @@ struct VirtIODevice
> >       */
> >      EventNotifier config_notifier;
> >      bool device_iotlb_enabled;
> > +    /* Shared memory region for vhost-user mappings. */
> > +    MemoryRegion *shmem_list;
> > +    int n_shmem_regions;
> >  };
> >
> >  struct VirtioDeviceClass {
> > --
> > 2.44.0
> >
>

--00000000000013cd5b061a2025db
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 4, 2024 at 8:54=
=E2=80=AFPM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com">stef=
anha@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">On Thu, May 30, 2024 at 05:22:23PM +0200, Albert Esteve wrot=
e:<br>
&gt; Add SHMEM_MAP/UNMAP requests to vhost-user.<br>
&gt; <br>
&gt; This request allows backends to dynamically map<br>
&gt; fds into a shared memory region indentified by<br>
<br>
Please call this &quot;VIRTIO Shared Memory Region&quot; everywhere (code,<=
br>
vhost-user spec, commit description, etc) so it&#39;s clear that this is no=
t<br>
about vhost-user shared memory tables/regions.<br>
<br>
&gt; its `shmid`. Then, the fd memory is advertised<br>
&gt; to the frontend through a BAR+offset, so it can<br>
&gt; be read by the driver while its valid.<br>
<br>
Why is a PCI BAR mentioned here? vhost-user does not know about the<br>
VIRTIO Transport (e.g. PCI) being used. It&#39;s the frontend&#39;s job to<=
br>
report VIRTIO Shared Memory Regions to the driver.<br>
<br></blockquote><div><br></div><div>I will remove PCI BAR, as it is true t=
hat it depends on the</div><div>transport. I was trying to explain that the=
 driver</div><div>will use the shm_base=C2=A0+ shm_offset to access</div><d=
iv>the mapped memory.</div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
&gt; <br>
&gt; Then, the backend can munmap the memory range<br>
&gt; in a given shared memory region (again, identified<br>
&gt; by its `shmid`), to free it. After this, the<br>
&gt; region becomes private and shall not be accessed<br>
&gt; by the frontend anymore.<br>
<br>
What does &quot;private&quot; mean?<br>
<br>
The frontend must mmap PROT_NONE to reserve the virtual memory space<br>
when no fd is mapped in the VIRTIO Shared Memory Region. Otherwise an<br>
unrelated mmap(NULL, ...) might use that address range and the guest<br>
would have access to the host memory! This is a security issue and needs<br=
>
to be mentioned explicitly in the spec.<br></blockquote><div><br></div><div=
>I mentioned private because it changes the mapping from MAP_SHARED</div><d=
iv>to MAP_PRIVATE. I will highlight PROT_NONE instead.</div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; Initializing the memory region is reponsiblity<br>
&gt; of the PCI device that will using it.<br>
<br>
What does this mean?<br></blockquote><div><br></div><div>The MemoryRegion i=
s declared in `struct VirtIODevice`,</div><div>but it is uninitialized=C2=
=A0in this commit. So I was trying to say</div><div>that the initialization=
 will happen in, e.g., vhost-user-gpu-pci.c</div><div>with something like `=
memory_region_init` , and later `pci_register_bar`.</div><div><br></div><di=
v>I am testing that part still.</div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; Signed-off-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com"=
 target=3D"_blank">aesteve@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/interop/vhost-user.rst |=C2=A0 23 ++++++++<br>
&gt;=C2=A0 hw/virtio/vhost-user.c=C2=A0 =C2=A0 =C2=A0 | 106 +++++++++++++++=
+++++++++++++++++++++<br>
&gt;=C2=A0 hw/virtio/virtio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A02 +<br>
&gt;=C2=A0 include/hw/virtio/virtio.h=C2=A0 |=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 4 files changed, 134 insertions(+)<br>
<br>
Two missing pieces:<br>
<br>
1. QEMU&#39;s --device vhost-user-device needs a way to enumerate VIRTIO<br=
>
Shared Memory Regions from the vhost-user backend. vhost-user-device is<br>
a generic vhost-user frontend without knowledge of the device type, so<br>
it doesn&#39;t know what the valid shmids are and what size the regions<br>
have.<br></blockquote><div><br></div><div>Ok. I was assuming that if a devi=
ce (backend) makes a request without a</div><div>valid shmid or not enough =
size in the region to perform the mmap, would</div><div>just fail in the VM=
M performing the actual mmap operation. So it would</div><div>not necessari=
ly need to know about valid shmids=C2=A0or region sizes.</div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
2. Other backends don&#39;t see these mappings. If the guest submits a vrin=
g<br>
descriptor referencing a mapping to another backend, then that backend<br>
won&#39;t be able to access this memory. David Gilbert hit this problem whe=
n<br>
working on the virtiofs DAX Window. Either the frontend needs to forward<br=
>
all SHMAP_MAP/UNMAP messages to the other backends (inefficient and<br>
maybe racy!) or a new &quot;memcpy&quot; message is needed as a fallback fo=
r when<br>
vhost-user memory region translation fails.<br></blockquote><div><br></div>=
<div>Ok. In which=C2=A0scenario would another device want to access the sam=
e mapping?</div><div>If it is for a shared VIRTIO object, the device that r=
eceives the dmabuf fd could</div><div>just do a new mapping in its VIRTIO s=
hared memory region.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
<br>
&gt; <br>
&gt; diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst=
<br>
&gt; index d8419fd2f1..3caf2a290c 100644<br>
&gt; --- a/docs/interop/vhost-user.rst<br>
&gt; +++ b/docs/interop/vhost-user.rst<br>
&gt; @@ -1859,6 +1859,29 @@ is sent by the front-end.<br>
&gt;=C2=A0 =C2=A0 when the operation is successful, or non-zero otherwise. =
Note that if the<br>
&gt;=C2=A0 =C2=A0 operation fails, no fd is sent to the backend.<br>
&gt;=C2=A0 <br>
&gt; +``VHOST_USER_BACKEND_SHMEM_MAP``<br>
&gt; +=C2=A0 :id: 9<br>
&gt; +=C2=A0 :equivalent ioctl: N/A<br>
&gt; +=C2=A0 :request payload: fd and ``struct VhostUserMMap``<br>
&gt; +=C2=A0 :reply payload: N/A<br>
&gt; +<br>
&gt; +=C2=A0 This message can be submitted by the backends to advertise a n=
ew mapping<br>
&gt; +=C2=A0 to be made in a given shared memory region. Upon receiving the=
 message,<br>
&gt; +=C2=A0 QEMU will mmap the given fd into the shared memory region with=
 the<br>
<br>
s/QEMU/the frontend/<br>
<br>
&gt; +=C2=A0 requested ``shmid``. A reply is generated indicating whether m=
apping<br>
&gt; +=C2=A0 succeeded.<br>
<br>
Please document whether mapping over an existing mapping is allowed. I<br>
think it should be allowed because it might be useful to atomically<br>
update a mapping without a race where the driver sees unmapped memory.<br>
<br></blockquote><div><br></div><div>So in my understanding, the frontend (=
driver) in the guest would=C2=A0initiate the</div><div>mmap/munmap by sendi=
ng request to the backend (vhost-user device).</div><div>Then the vhost-use=
r device sends a request to the VMM to perform the</div><div>mapping. We co=
uld enforce an ACK to ensure that the mmap operation finished</div><div>bef=
ore the vhost-user device responds to the driver, and thus avoid</div><div>=
races. This way, we support only the simple usecase=C2=A0of not allowing</d=
iv><div>mmaps=C2=A0over an already mapped region.</div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
If mapping over an existing mapping is allowed, does the new mapping<br>
need to cover the old mapping exactly, or can it span multiple previous<br>
mappings or a subset of an existing mapping?<br>
<br>
From a security point of view we need to be careful here. A potentially<br>
untrusted backend process now has the ability to mmap an arbitrary file<br>
descriptor into the frontend process. The backend can cause<br>
denial of service by creating many small mappings to exhaust the OS<br>
limits on virtual memory areas. The backend can map memory to use as<br>
part of a security compromise, so we need to be sure the virtual memory<br>
addresses are not leaked to the backend and only read/write page<br>
permissions are available.<br></blockquote><div><br></div><div>Right, secur=
ity from untrusted backends is usally=C2=A0the hardest part to me.</div><di=
v>But vhost-user devices do only see shm_offset, so this should be safe, no=
?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +``VHOST_USER_BACKEND_SHMEM_UNMAP``<br>
&gt; +=C2=A0 :id: 10<br>
&gt; +=C2=A0 :equivalent ioctl: N/A<br>
&gt; +=C2=A0 :request payload: ``struct VhostUserMMap``<br>
&gt; +=C2=A0 :reply payload: N/A<br>
&gt; +<br>
&gt; +=C2=A0 This message can be submitted by the backends so that QEMU un-=
mmap<br>
<br>
s/QEMU/the frontend/<br></blockquote><div><br></div><div>This is probably m=
y bad, but I really thought the frontend is the driver.</div><div>So fronte=
nd/backend as alternative terms for vhost-user driver/device.</div><div>And=
 then here we would keep QEMU or use VMM instead?</div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 a given range (``offset``, ``len``) in the shared memory regio=
n with the<br>
&gt; +=C2=A0 requested ``shmid``.<br>
<br>
Does the range need to correspond to a previously-mapped VhostUserMMap<br>
or can it cross multiple VhostUserMMaps, be a subset of a VhostUserMMap,<br=
>
etc?<br></blockquote><div><br></div><div>I would prefer to keep it simple a=
nd disallow mapping over a previously-mapped</div><div>region. The range ne=
ed to correspond to a valid (within size bound), free,</div><div>memory reg=
ion, or else the request will fail. I will add that to the text.</div><div>=
<br></div><div>Nonetheless, I am open to discuss other options.</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 A reply is generated indicating whether unmapping succeeded.<b=
r>
&gt; +<br>
&gt;=C2=A0 .. _reply_ack:<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 VHOST_USER_PROTOCOL_F_REPLY_ACK<br>
&gt; diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c<br>
&gt; index cdf9af4a4b..9526b9d07f 100644<br>
&gt; --- a/hw/virtio/vhost-user.c<br>
&gt; +++ b/hw/virtio/vhost-user.c<br>
&gt; @@ -115,6 +115,8 @@ typedef enum VhostUserBackendRequest {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,<br>
&gt; +=C2=A0 =C2=A0 VHOST_USER_BACKEND_SHMEM_MAP =3D 9,<br>
&gt; +=C2=A0 =C2=A0 VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_MAX<br>
&gt;=C2=A0 }=C2=A0 VhostUserBackendRequest;<br>
&gt;=C2=A0 <br>
&gt; @@ -192,6 +194,23 @@ typedef struct VhostUserShared {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 unsigned char uuid[16];<br>
&gt;=C2=A0 } VhostUserShared;<br>
&gt;=C2=A0 <br>
&gt; +/* For the flags field of VhostUserMMap */<br>
&gt; +#define VHOST_USER_FLAG_MAP_R (1u &lt;&lt; 0)<br>
&gt; +#define VHOST_USER_FLAG_MAP_W (1u &lt;&lt; 1)<br>
&gt; +<br>
&gt; +typedef struct {<br>
&gt; +=C2=A0 =C2=A0 /* Shared memory region ID */<br>
&gt; +=C2=A0 =C2=A0 uint8_t shmid;<br>
<br>
There is a hole (padding) in the struct since the following fields are<br>
naturally aligned to 8 bytes. I suggest moving shmid to the end to<br>
reduce the chance of information leaks if padding is not zeroed.<br></block=
quote><div><br></div><div>I see. I can move it to the end of the struct or =
add a padding field in</div><div>between. I&#39;ll do what you suggested, a=
s it sound like the simplest solution.</div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 /* File offset */<br>
&gt; +=C2=A0 =C2=A0 uint64_t fd_offset;<br>
&gt; +=C2=A0 =C2=A0 /* Offset within the shared memory region */<br>
&gt; +=C2=A0 =C2=A0 uint64_t shm_offset;<br>
&gt; +=C2=A0 =C2=A0 /* Size of region to map */<br>
<br>
To avoid giving &quot;region&quot; additional meanings:<br>
<br>
s/Size of the region to map/Size of the mapping/<br></blockquote><div><br><=
/div><div>Ok, I will change it in the next drop. Probably will keep the RFC=
 for</div><div>at least one more patch, seeing that there are a few things =
I wasn&#39;t</div><div>correctly considering.</div><div><br></div><div>Than=
ks for all the feedback!</div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 uint64_t len;<br>
&gt; +=C2=A0 =C2=A0 /* Flags for the mmap operation, from VHOST_USER_FLAG_*=
 */<br>
&gt; +=C2=A0 =C2=A0 uint64_t flags;<br>
&gt; +} VhostUserMMap;<br>
&gt; +<br>
&gt;=C2=A0 typedef struct {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VhostUserRequest request;<br>
&gt;=C2=A0 <br>
&gt; @@ -224,6 +243,7 @@ typedef union {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserInflight inflight;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserShared object;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserTransferDeviceState transfe=
r_state;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserMMap mmap;<br>
&gt;=C2=A0 } VhostUserPayload;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 typedef struct VhostUserMsg {<br>
&gt; @@ -1748,6 +1768,85 @@ vhost_user_backend_handle_shared_object_lookup(=
struct vhost_user *u,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static int<br>
&gt; +vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserMMap *vu_mmap,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int fd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 void *addr =3D 0;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion *mr =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (fd &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Bad fd for map&quot;);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EBADF;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!dev-&gt;vdev-&gt;shmem_list ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev-&gt;vdev-&gt;n_shmem_regions &lt;=3D =
vu_mmap-&gt;shmid) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Shared memory region a=
t &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&quot;ID %d unitialized&quot;, vu_mmap-&gt;shmid);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 mr =3D &amp;dev-&gt;vdev-&gt;shmem_list[vu_mmap-&gt;shm=
id];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if ((vu_mmap-&gt;shm_offset + vu_mmap-&gt;len) &lt; vu_=
mmap-&gt;len ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (vu_mmap-&gt;shm_offset + vu_mmap-&gt;len=
) &gt; mr-&gt;size) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Bad offset/len for mma=
p %&quot; PRIx64 &quot;+%&quot; PRIx64,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0vu_mmap-&gt;shm_offset, vu_mmap-&gt;len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 void *shmem_ptr =3D memory_region_get_ram_ptr(mr);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 addr =3D mmap(shmem_ptr + vu_mmap-&gt;shm_offset, vu_mm=
ap-&gt;len,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ((vu_mmap-&gt;flags &amp; VHOST_USER_FLAG=
_MAP_R) ? PROT_READ : 0) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ((vu_mmap-&gt;flags &amp; VHOST_USER_FLAG=
_MAP_W) ? PROT_WRITE : 0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 MAP_SHARED | MAP_FIXED, fd, vu_mmap-&gt;f=
d_offset);<br>
&gt; +=C2=A0 =C2=A0 if (addr =3D=3D MAP_FAILED) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Failed to mmap mem fd&=
quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int<br>
&gt; +vhost_user_backend_handle_shmem_unmap(struct vhost_dev *dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserMMap *vu_=
mmap)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 void *addr =3D 0;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion *mr =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!dev-&gt;vdev-&gt;shmem_list ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev-&gt;vdev-&gt;n_shmem_regions &lt;=3D =
vu_mmap-&gt;shmid) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Shared memory region a=
t &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&quot;ID %d unitialized&quot;, vu_mmap-&gt;shmid);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 mr =3D &amp;dev-&gt;vdev-&gt;shmem_list[vu_mmap-&gt;shm=
id];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if ((vu_mmap-&gt;shm_offset + vu_mmap-&gt;len) &lt; vu_=
mmap-&gt;len ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (vu_mmap-&gt;shm_offset + vu_mmap-&gt;len=
) &gt; mr-&gt;size) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Bad offset/len for mma=
p %&quot; PRIx64 &quot;+%&quot; PRIx64,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0vu_mmap-&gt;shm_offset, vu_mmap-&gt;len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 void *shmem_ptr =3D memory_region_get_ram_ptr(mr);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 addr =3D mmap(shmem_ptr + vu_mmap-&gt;shm_offset, vu_mm=
ap-&gt;len,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PROT_NONE, MA=
P_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (addr =3D=3D MAP_FAILED) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Failed to unmap memory=
&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static void close_backend_channel(struct vhost_user *u)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_source_destroy(u-&gt;backend_src);<br>
&gt; @@ -1816,6 +1915,13 @@ static gboolean backend_read(QIOChannel *ioc, G=
IOCondition condition,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vhost_user_backend_handle_sh=
ared_object_lookup(dev-&gt;opaque, ioc,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&amp;hdr, &amp;payload);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case VHOST_USER_BACKEND_SHMEM_MAP:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vhost_user_backend_handle_shmem_m=
ap(dev, &amp;payload.mmap,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 fd ? fd[0] : -1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case VHOST_USER_BACKEND_SHMEM_UNMAP:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vhost_user_backend_handle_shmem_u=
nmap(dev, &amp;payload.mmap);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Received unexpect=
ed msg type: %d.&quot;, hdr.request);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -EINVAL;<br>
&gt; diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c<br>
&gt; index 893a072c9d..59596370ec 100644<br>
&gt; --- a/hw/virtio/virtio.c<br>
&gt; +++ b/hw/virtio/virtio.c<br>
&gt; @@ -3264,6 +3264,8 @@ void virtio_init(VirtIODevice *vdev, uint16_t de=
vice_id, size_t config_size)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_vmstate_change,=
 vdev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 vdev-&gt;device_endian =3D virtio_default_endian()=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 vdev-&gt;use_guest_notifier_mask =3D true;<br>
&gt; +=C2=A0 =C2=A0 vdev-&gt;shmem_list =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 vdev-&gt;n_shmem_regions =3D 0;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /*<br>
&gt; diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h<b=
r>
&gt; index 7d5ffdc145..34bec26593 100644<br>
&gt; --- a/include/hw/virtio/virtio.h<br>
&gt; +++ b/include/hw/virtio/virtio.h<br>
&gt; @@ -165,6 +165,9 @@ struct VirtIODevice<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 EventNotifier config_notifier;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool device_iotlb_enabled;<br>
&gt; +=C2=A0 =C2=A0 /* Shared memory region for vhost-user mappings. */<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion *shmem_list;<br>
&gt; +=C2=A0 =C2=A0 int n_shmem_regions;<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 struct VirtioDeviceClass {<br>
&gt; -- <br>
&gt; 2.44.0<br>
&gt; <br>
</blockquote></div></div>

--00000000000013cd5b061a2025db--


