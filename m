Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4632ECA0ED3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 07:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slkRz-0003dF-2r; Wed, 04 Sep 2024 03:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1slkRy-0003cg-5q
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 03:29:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1slkRu-0006of-3N
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 03:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725434945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x4t/ZUljBgbTZOcKtvR/609CNvb9JEtL49iCUkTwFvQ=;
 b=dGZ3fj0BZtpDhnFpT2ialcU6jivBfiSzkG2hs2TYVH+d6YeyKx7/gLYP1CDRPn4xx0z/IL
 s6Aur/+/xBHc0lNMv1dai6RGXDz84RPpOFW2i5/Cxjhe1uZaWpRAtMxVK/pF/+GbtqbBpJ
 ZRRi2bAQ745qogZOtmucqs3Q3hKa1ak=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-OlrLjwOGPSexjQ28NL4BQg-1; Wed, 04 Sep 2024 03:29:03 -0400
X-MC-Unique: OlrLjwOGPSexjQ28NL4BQg-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2d889fc26e7so3912984a91.3
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 00:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725434942; x=1726039742;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x4t/ZUljBgbTZOcKtvR/609CNvb9JEtL49iCUkTwFvQ=;
 b=CqJzZIGOWmVDcZmEXSxk8ulce/k4hpSjAfPE8wQ7ZUtXvnckEc5oTTIEBUhBu24joS
 MG2ZfMKbZ2y7QMBXs4Ii3n0Ik74kaCQ1vhxQ0tk3QOLQFYAk+mDVcSGNvpPu9iah+eIh
 lTN4qvkf+R0iE600kGHkfCs3vq4HfvgGhbEWiDimmGM3qPeJ8vJqeVwFa1N9sHA67bEt
 iUgivA/ISQbTDnQJ3RM5H82PGpc7jSNBmLL5ox+6AldhcULO1DGk3+mw4+QHAzsLwlak
 elwE0wGA/0YDn34r62eUCOeKmTzNdQAdSWwTA0gz5OOCWyOCxy5596IJvS9aMxgDhPPe
 wUMQ==
X-Gm-Message-State: AOJu0YwJ6g+XtmvZU3yLZT/tIOFhV/Rn99UCroCo1LQC3URmHJ5FusI6
 6PFvy9DguwfUIDDnZsHti0ZaEwKrHSsiLpVv8asq5o/0/t/1HI6hdYH0Qr2sskd9J3rznFomK/n
 CX5jRInEel/7eA0cIsUsiahmJ62CMElGPrDaCTpmuxDHYFoM58GF1mU3r6JmsCTV4zrW6wLiYUd
 CAZYkKfpWukDhauISjX4QQGz6/6fQ=
X-Received: by 2002:a05:6a20:b58b:b0:1c0:f2d9:a44a with SMTP id
 adf61e73a8af0-1ced0469115mr13702687637.22.1725434942320; 
 Wed, 04 Sep 2024 00:29:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrOOwMHoGYSSpWF8x3EpkwZ9v3XLCvovOYTg5XAa6ZpUtsOUE9vwfbSsvTeFT9gUY4GECEAPrvHdXHs9K8SS0=
X-Received: by 2002:a05:6a20:b58b:b0:1c0:f2d9:a44a with SMTP id
 adf61e73a8af0-1ced0469115mr13702673637.22.1725434941895; Wed, 04 Sep 2024
 00:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240628145710.1516121-1-aesteve@redhat.com>
 <20240628145710.1516121-2-aesteve@redhat.com>
 <20240711074510.GC563880@dynamic-pd01.res.v6.highway.a1.net>
In-Reply-To: <20240711074510.GC563880@dynamic-pd01.res.v6.highway.a1.net>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 4 Sep 2024 09:28:50 +0200
Message-ID: <CADSE00+WMkYhmwqZkFKH7WkrDxnwBzL9G54uEaoMLnQUaqJbfg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/5] vhost-user: Add VIRTIO Shared Memory map
 request
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, david@redhat.com, 
 slp@redhat.com, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000cb98a6062146205d"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000cb98a6062146205d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 9:45=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:

> On Fri, Jun 28, 2024 at 04:57:06PM +0200, Albert Esteve wrote:
> > Add SHMEM_MAP/UNMAP requests to vhost-user to
> > handle VIRTIO Shared Memory mappings.
> >
> > This request allows backends to dynamically map
> > fds into a VIRTIO Shared Memory Region indentified
> > by its `shmid`. Then, the fd memory is advertised
> > to the driver as a base addres + offset, so it
> > can be read/written (depending on the mmap flags
> > requested) while its valid.
> >
> > The backend can munmap the memory range
> > in a given VIRTIO Shared Memory Region (again,
> > identified by its `shmid`), to free it. Upon
> > receiving this message, the front-end must
> > mmap the regions with PROT_NONE to reserve
> > the virtual memory space.
> >
> > The device model needs to create MemoryRegion
> > instances for the VIRTIO Shared Memory Regions
> > and add them to the `VirtIODevice` instance.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  docs/interop/vhost-user.rst               |  27 +++++
> >  hw/virtio/vhost-user.c                    | 122 ++++++++++++++++++++++
> >  hw/virtio/virtio.c                        |  12 +++
> >  include/hw/virtio/virtio.h                |   5 +
> >  subprojects/libvhost-user/libvhost-user.c |  65 ++++++++++++
> >  subprojects/libvhost-user/libvhost-user.h |  53 ++++++++++
> >  6 files changed, 284 insertions(+)
> >
> > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> > index d8419fd2f1..d52ba719d5 100644
> > --- a/docs/interop/vhost-user.rst
> > +++ b/docs/interop/vhost-user.rst
> > @@ -1859,6 +1859,33 @@ is sent by the front-end.
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
> > +  to be made in a given VIRTIO Shared Memory Region. Upon receiving th=
e
> message,
> > +  The front-end will mmap the given fd into the VIRTIO Shared Memory
> Region
> > +  with the requested ``shmid``. A reply is generated indicating whethe=
r
> mapping
> > +  succeeded.
> > +
> > +  Mapping over an already existing map is not allowed and request shal=
l
> fail.
> > +  Therefore, the memory range in the request must correspond with a
> valid,
> > +  free region of the VIRTIO Shared Memory Region.
> > +
> > +``VHOST_USER_BACKEND_SHMEM_UNMAP``
> > +  :id: 10
> > +  :equivalent ioctl: N/A
> > +  :request payload: ``struct VhostUserMMap``
> > +  :reply payload: N/A
> > +
> > +  This message can be submitted by the backends so that the front-end
> un-mmap
> > +  a given range (``offset``, ``len``) in the VIRTIO Shared Memory
> Region with
>
> s/offset/shm_offset/
>
> > +  the requested ``shmid``.
>
> Please clarify that <offset, len> must correspond to the entirety of a
> valid mapped region.
>
> By the way, the VIRTIO 1.3 gives the following behavior for the virtiofs
> DAX Window:
>
>   When a FUSE_SETUPMAPPING request perfectly overlaps a previous
>   mapping, the previous mapping is replaced. When a mapping partially
>   overlaps a previous mapping, the previous mapping is split into one or
>   two smaller mappings. When a mapping is partially unmapped it is also
>   split into one or two smaller mappings.
>
>   Establishing new mappings or splitting existing mappings consumes
>   resources. If the device runs out of resources the FUSE_SETUPMAPPING
>   request fails until resources are available again following
>   FUSE_REMOVEMAPPING.
>
> I think SETUPMAPPING/REMOVMAPPING can be implemented using
> SHMEM_MAP/UNMAP. SHMEM_MAP/UNMAP do not allow atomically replacing
> partial ranges, but as far as I know that's not necessary for virtiofs
> in practice.
>
> It's worth mentioning that mappings consume resources and that SHMEM_MAP
> can fail when there are no resources available. The process-wide limit
> is vm.max_map_count on Linux although a vhost-user frontend may reduce
> it further to control vhost-user resource usage.
>
> > +  A reply is generated indicating whether unmapping succeeded.
> > +
> >  .. _reply_ack:
> >
> >  VHOST_USER_PROTOCOL_F_REPLY_ACK
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index cdf9af4a4b..7ee8a472c6 100644
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
> > @@ -192,6 +194,24 @@ typedef struct VhostUserShared {
> >      unsigned char uuid[16];
> >  } VhostUserShared;
> >
> > +/* For the flags field of VhostUserMMap */
> > +#define VHOST_USER_FLAG_MAP_R (1u << 0)
> > +#define VHOST_USER_FLAG_MAP_W (1u << 1)
> > +
> > +typedef struct {
> > +    /* VIRTIO Shared Memory Region ID */
> > +    uint8_t shmid;
> > +    uint8_t padding[7];
> > +    /* File offset */
> > +    uint64_t fd_offset;
> > +    /* Offset within the VIRTIO Shared Memory Region */
> > +    uint64_t shm_offset;
> > +    /* Size of the mapping */
> > +    uint64_t len;
> > +    /* Flags for the mmap operation, from VHOST_USER_FLAG_* */
> > +    uint64_t flags;
> > +} VhostUserMMap;
> > +
> >  typedef struct {
> >      VhostUserRequest request;
> >
> > @@ -224,6 +244,7 @@ typedef union {
> >          VhostUserInflight inflight;
> >          VhostUserShared object;
> >          VhostUserTransferDeviceState transfer_state;
> > +        VhostUserMMap mmap;
> >  } VhostUserPayload;
> >
> >  typedef struct VhostUserMsg {
> > @@ -1748,6 +1769,100 @@
> vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
> >      return 0;
> >  }
> >
> > +static int
> > +vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
> > +                                    VhostUserMMap *vu_mmap,
> > +                                    int fd)
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
> > +        error_report("Device only has %d VIRTIO Shared Memory Regions.=
 "
> > +                     "Requested ID: %d",
> > +                     dev->vdev->n_shmem_regions, vu_mmap->shmid);
> > +        return -EFAULT;
> > +    }
> > +
> > +    mr =3D &dev->vdev->shmem_list[vu_mmap->shmid];
> > +
> > +    if (!mr) {
> > +        error_report("VIRTIO Shared Memory Region at "
> > +                     "ID %d unitialized", vu_mmap->shmid);
> > +        return -EFAULT;
> > +    }
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
>
> Missing check for overlap between range [shm_offset, shm_offset + len)
> and existing mappings.
>
> > +        ((vu_mmap->flags & VHOST_USER_FLAG_MAP_R) ? PROT_READ : 0) |
> > +        ((vu_mmap->flags & VHOST_USER_FLAG_MAP_W) ? PROT_WRITE : 0),
> > +        MAP_SHARED | MAP_FIXED, fd, vu_mmap->fd_offset);
> > +
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
> > +                                      VhostUserMMap *vu_mmap)
> > +{
> > +    void *addr =3D 0;
> > +    MemoryRegion *mr =3D NULL;
> > +
> > +    if (!dev->vdev->shmem_list ||
> > +        dev->vdev->n_shmem_regions <=3D vu_mmap->shmid) {
> > +        error_report("Device only has %d VIRTIO Shared Memory Regions.=
 "
> > +                     "Requested ID: %d",
> > +                     dev->vdev->n_shmem_regions, vu_mmap->shmid);
> > +        return -EFAULT;
> > +    }
> > +
> > +    mr =3D &dev->vdev->shmem_list[vu_mmap->shmid];
> > +
> > +    if (!mr) {
> > +        error_report("VIRTIO Shared Memory Region at "
> > +                     "ID %d unitialized", vu_mmap->shmid);
> > +        return -EFAULT;
> > +    }
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
>
> Missing check for existing mapping with exact range [shm_offset, len)
> match.
>
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
> > @@ -1816,6 +1931,13 @@ static gboolean backend_read(QIOChannel *ioc,
> GIOCondition condition,
> >          ret =3D
> vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
> >                                                               &hdr,
> &payload);
> >          break;
> > +    case VHOST_USER_BACKEND_SHMEM_MAP:
> > +        ret =3D vhost_user_backend_handle_shmem_map(dev, &payload.mmap=
,
> > +                                                  fd ? fd[0] : -1);
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
> > index 893a072c9d..9f2da5b11e 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -2856,6 +2856,16 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
> >      return vmstate_save_state(f, &vmstate_virtio, vdev, NULL);
> >  }
> >
> > +MemoryRegion *virtio_new_shmem_region(VirtIODevice *vdev)
> > +{
> > +    MemoryRegion *mr =3D g_new0(MemoryRegion, 1);
> > +    ++vdev->n_shmem_regions;
> > +    vdev->shmem_list =3D g_renew(MemoryRegion, vdev->shmem_list,
> > +                               vdev->n_shmem_regions);
>
> Where is shmem_list freed?
>
> The name "list" is misleading since this is an array, not a list.
>
> > +    vdev->shmem_list[vdev->n_shmem_regions - 1] =3D *mr;
> > +    return mr;
> > +}
>
> This looks weird. The contents of mr are copied into shmem_list[] and
> then the pointer to mr is returned? Did you mean for the field's type to
> be MemoryRegion **shmem_list and then vdev->shmem_list[...] =3D mr would
> stash the pointer?
>
> > +
> >  /* A wrapper for use as a VMState .put function */
> >  static int virtio_device_put(QEMUFile *f, void *opaque, size_t size,
> >                                const VMStateField *field, JSONWriter
> *vmdesc)
> > @@ -3264,6 +3274,8 @@ void virtio_init(VirtIODevice *vdev, uint16_t
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
> > index 7d5ffdc145..16d598aadc 100644
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
> > @@ -280,6 +283,8 @@ void virtio_notify(VirtIODevice *vdev, VirtQueue
> *vq);
> >
> >  int virtio_save(VirtIODevice *vdev, QEMUFile *f);
> >
> > +MemoryRegion *virtio_new_shmem_region(VirtIODevice *vdev);
> > +
> >  extern const VMStateInfo virtio_vmstate_info;
> >
> >  #define VMSTATE_VIRTIO_DEVICE \
> > diff --git a/subprojects/libvhost-user/libvhost-user.c
> b/subprojects/libvhost-user/libvhost-user.c
> > index a879149fef..28556d183a 100644
> > --- a/subprojects/libvhost-user/libvhost-user.c
> > +++ b/subprojects/libvhost-user/libvhost-user.c
> > @@ -1586,6 +1586,71 @@ vu_rm_shared_object(VuDev *dev, unsigned char
> uuid[UUID_LEN])
> >      return vu_send_message(dev, &msg);
> >  }
> >
> > +bool
> > +vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
> > +             uint64_t shm_offset, uint64_t len, uint64_t flags)
> > +{
> > +    bool result =3D false;
> > +    VhostUserMsg msg_reply;
> > +    VhostUserMsg vmsg =3D {
> > +        .request =3D VHOST_USER_BACKEND_SHMEM_MAP,
> > +        .size =3D sizeof(vmsg.payload.mmap),
> > +        .flags =3D VHOST_USER_VERSION,
> > +        .payload.mmap =3D {
> > +            .shmid =3D shmid,
> > +            .fd_offset =3D fd_offset,
> > +            .shm_offset =3D shm_offset,
> > +            .len =3D len,
> > +            .flags =3D flags,
> > +        },
> > +    };
> > +
> > +    if (vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK))=
 {
> > +        vmsg.flags |=3D VHOST_USER_NEED_REPLY_MASK;
> > +    }
> > +
> > +    pthread_mutex_lock(&dev->backend_mutex);
> > +    if (!vu_message_write(dev, dev->backend_fd, &vmsg)) {
> > +        pthread_mutex_unlock(&dev->backend_mutex);
> > +        return false;
> > +    }
> > +
> > +    /* Also unlocks the backend_mutex */
> > +    return vu_process_message_reply(dev, &vmsg);
> > +}
> > +
> > +bool
> > +vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
> > +               uint64_t shm_offset, uint64_t len)
> > +{
> > +    bool result =3D false;
> > +    VhostUserMsg msg_reply;
> > +    VhostUserMsg vmsg =3D {
> > +        .request =3D VHOST_USER_BACKEND_SHMEM_UNMAP,
> > +        .size =3D sizeof(vmsg.payload.mmap),
> > +        .flags =3D VHOST_USER_VERSION,
> > +        .payload.mmap =3D {
> > +            .shmid =3D shmid,
> > +            .fd_offset =3D fd_offset,
>
> What is the meaning of this field? I expected it to be set to 0.
>

Probably true. I just kept it generic for backends to decide what to set it
to,
without considering the real use.
I will remove the parameter and set it to 0 in the request.


>
> > +            .shm_offset =3D shm_offset,
> > +            .len =3D len,
> > +        },
> > +    };
> > +
> > +    if (vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK))=
 {
> > +        vmsg.flags |=3D VHOST_USER_NEED_REPLY_MASK;
> > +    }
> > +
> > +    pthread_mutex_lock(&dev->backend_mutex);
> > +    if (!vu_message_write(dev, dev->backend_fd, &vmsg)) {
> > +        pthread_mutex_unlock(&dev->backend_mutex);
> > +        return false;
> > +    }
> > +
> > +    /* Also unlocks the backend_mutex */
> > +    return vu_process_message_reply(dev, &vmsg);
> > +}
> > +
> >  static bool
> >  vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
> >  {
> > diff --git a/subprojects/libvhost-user/libvhost-user.h
> b/subprojects/libvhost-user/libvhost-user.h
> > index deb40e77b3..7f6c22cc1a 100644
> > --- a/subprojects/libvhost-user/libvhost-user.h
> > +++ b/subprojects/libvhost-user/libvhost-user.h
> > @@ -127,6 +127,8 @@ typedef enum VhostUserBackendRequest {
> >      VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,
> >      VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,
> >      VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
> > +    VHOST_USER_BACKEND_SHMEM_MAP =3D 9,
> > +    VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,
> >      VHOST_USER_BACKEND_MAX
> >  }  VhostUserBackendRequest;
> >
> > @@ -186,6 +188,24 @@ typedef struct VhostUserShared {
> >      unsigned char uuid[UUID_LEN];
> >  } VhostUserShared;
> >
> > +/* For the flags field of VhostUserMMap */
> > +#define VHOST_USER_FLAG_MAP_R (1u << 0)
> > +#define VHOST_USER_FLAG_MAP_W (1u << 1)
> > +
> > +typedef struct {
> > +    /* VIRTIO Shared Memory Region ID */
> > +    uint8_t shmid;
> > +    uint8_t padding[7];
> > +    /* File offset */
> > +    uint64_t fd_offset;
> > +    /* Offset within the VIRTIO Shared Memory Region */
> > +    uint64_t shm_offset;
> > +    /* Size of the mapping */
> > +    uint64_t len;
> > +    /* Flags for the mmap operation, from VHOST_USER_FLAG_* */
> > +    uint64_t flags;
> > +} VhostUserMMap;
> > +
> >  #if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
> >  # define VU_PACKED __attribute__((gcc_struct, packed))
> >  #else
> > @@ -214,6 +234,7 @@ typedef struct VhostUserMsg {
> >          VhostUserVringArea area;
> >          VhostUserInflight inflight;
> >          VhostUserShared object;
> > +        VhostUserMMap mmap;
> >      } payload;
> >
> >      int fds[VHOST_MEMORY_BASELINE_NREGIONS];
> > @@ -597,6 +618,38 @@ bool vu_add_shared_object(VuDev *dev, unsigned cha=
r
> uuid[UUID_LEN]);
> >   */
> >  bool vu_rm_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN]);
> >
> > +/**
> > + * vu_shmem_map:
> > + * @dev: a VuDev context
> > + * @shmid: VIRTIO Shared Memory Region ID
> > + * @fd_offset: File offset
> > + * @shm_offset: Offset within the VIRTIO Shared Memory Region
> > + * @len: Size of the mapping
> > + * @flags: Flags for the mmap operation
> > + *
> > + * Advertises a new mapping to be made in a given VIRTIO Shared Memory
> Region.
> > + *
> > + * Returns: TRUE on success, FALSE on failure.
> > + */
> > +bool vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
> > +                  uint64_t shm_offset, uint64_t len, uint64_t flags);
> > +
> > +/**
> > + * vu_shmem_map:
> > + * @dev: a VuDev context
> > + * @shmid: VIRTIO Shared Memory Region ID
> > + * @fd_offset: File offset
> > + * @shm_offset: Offset within the VIRTIO Shared Memory Region
> > + * @len: Size of the mapping
> > + *
> > + * The front-end un-mmaps a given range in the VIRTIO Shared Memory
> Region
> > + * with the requested `shmid`.
> > + *
> > + * Returns: TRUE on success, FALSE on failure.
> > + */
> > +bool vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
> > +                  uint64_t shm_offset, uint64_t len);
> > +
> >  /**
> >   * vu_queue_set_notification:
> >   * @dev: a VuDev context
> > --
> > 2.45.2
> >
>

--000000000000cb98a6062146205d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 11, 2024 at 9:45=E2=80=AF=
AM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com">stefanha@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On Fri, Jun 28, 2024 at 04:57:06PM +0200, Albert Esteve wrote:<br>
&gt; Add SHMEM_MAP/UNMAP requests to vhost-user to<br>
&gt; handle VIRTIO Shared Memory mappings.<br>
&gt; <br>
&gt; This request allows backends to dynamically map<br>
&gt; fds into a VIRTIO Shared Memory Region indentified<br>
&gt; by its `shmid`. Then, the fd memory is advertised<br>
&gt; to the driver as a base addres + offset, so it<br>
&gt; can be read/written (depending on the mmap flags<br>
&gt; requested) while its valid.<br>
&gt; <br>
&gt; The backend can munmap the memory range<br>
&gt; in a given VIRTIO Shared Memory Region (again,<br>
&gt; identified by its `shmid`), to free it. Upon<br>
&gt; receiving this message, the front-end must<br>
&gt; mmap the regions with PROT_NONE to reserve<br>
&gt; the virtual memory space.<br>
&gt; <br>
&gt; The device model needs to create MemoryRegion<br>
&gt; instances for the VIRTIO Shared Memory Regions<br>
&gt; and add them to the `VirtIODevice` instance.<br>
&gt; <br>
&gt; Signed-off-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com"=
 target=3D"_blank">aesteve@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/interop/vhost-user.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 27 +++++<br>
&gt;=C2=A0 hw/virtio/vhost-user.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 122 ++++++++++++++++++++++<br>
&gt;=C2=A0 hw/virtio/virtio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 12 +++<br>
&gt;=C2=A0 include/hw/virtio/virtio.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A05 +<br>
&gt;=C2=A0 subprojects/libvhost-user/libvhost-user.c |=C2=A0 65 +++++++++++=
+<br>
&gt;=C2=A0 subprojects/libvhost-user/libvhost-user.h |=C2=A0 53 ++++++++++<=
br>
&gt;=C2=A0 6 files changed, 284 insertions(+)<br>
&gt; <br>
&gt; diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst=
<br>
&gt; index d8419fd2f1..d52ba719d5 100644<br>
&gt; --- a/docs/interop/vhost-user.rst<br>
&gt; +++ b/docs/interop/vhost-user.rst<br>
&gt; @@ -1859,6 +1859,33 @@ is sent by the front-end.<br>
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
&gt; +=C2=A0 to be made in a given VIRTIO Shared Memory Region. Upon receiv=
ing the message,<br>
&gt; +=C2=A0 The front-end will mmap the given fd into the VIRTIO Shared Me=
mory Region<br>
&gt; +=C2=A0 with the requested ``shmid``. A reply is generated indicating =
whether mapping<br>
&gt; +=C2=A0 succeeded.<br>
&gt; +<br>
&gt; +=C2=A0 Mapping over an already existing map is not allowed and reques=
t shall fail.<br>
&gt; +=C2=A0 Therefore, the memory range in the request must correspond wit=
h a valid,<br>
&gt; +=C2=A0 free region of the VIRTIO Shared Memory Region.<br>
&gt; +<br>
&gt; +``VHOST_USER_BACKEND_SHMEM_UNMAP``<br>
&gt; +=C2=A0 :id: 10<br>
&gt; +=C2=A0 :equivalent ioctl: N/A<br>
&gt; +=C2=A0 :request payload: ``struct VhostUserMMap``<br>
&gt; +=C2=A0 :reply payload: N/A<br>
&gt; +<br>
&gt; +=C2=A0 This message can be submitted by the backends so that the fron=
t-end un-mmap<br>
&gt; +=C2=A0 a given range (``offset``, ``len``) in the VIRTIO Shared Memor=
y Region with<br>
<br>
s/offset/shm_offset/<br>
<br>
&gt; +=C2=A0 the requested ``shmid``.<br>
<br>
Please clarify that &lt;offset, len&gt; must correspond to the entirety of =
a<br>
valid mapped region.<br>
<br>
By the way, the VIRTIO 1.3 gives the following behavior for the virtiofs<br=
>
DAX Window:<br>
<br>
=C2=A0 When a FUSE_SETUPMAPPING request perfectly overlaps a previous<br>
=C2=A0 mapping, the previous mapping is replaced. When a mapping partially<=
br>
=C2=A0 overlaps a previous mapping, the previous mapping is split into one =
or<br>
=C2=A0 two smaller mappings. When a mapping is partially unmapped it is als=
o<br>
=C2=A0 split into one or two smaller mappings.<br>
<br>
=C2=A0 Establishing new mappings or splitting existing mappings consumes<br=
>
=C2=A0 resources. If the device runs out of resources the FUSE_SETUPMAPPING=
<br>
=C2=A0 request fails until resources are available again following<br>
=C2=A0 FUSE_REMOVEMAPPING.<br>
<br>
I think SETUPMAPPING/REMOVMAPPING can be implemented using<br>
SHMEM_MAP/UNMAP. SHMEM_MAP/UNMAP do not allow atomically replacing<br>
partial ranges, but as far as I know that&#39;s not necessary for virtiofs<=
br>
in practice.<br>
<br>
It&#39;s worth mentioning that mappings consume resources and that SHMEM_MA=
P<br>
can fail when there are no resources available. The process-wide limit<br>
is vm.max_map_count on Linux although a vhost-user frontend may reduce<br>
it further to control vhost-user resource usage.<br>
<br>
&gt; +=C2=A0 A reply is generated indicating whether unmapping succeeded.<b=
r>
&gt; +<br>
&gt;=C2=A0 .. _reply_ack:<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 VHOST_USER_PROTOCOL_F_REPLY_ACK<br>
&gt; diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c<br>
&gt; index cdf9af4a4b..7ee8a472c6 100644<br>
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
&gt; @@ -192,6 +194,24 @@ typedef struct VhostUserShared {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 unsigned char uuid[16];<br>
&gt;=C2=A0 } VhostUserShared;<br>
&gt;=C2=A0 <br>
&gt; +/* For the flags field of VhostUserMMap */<br>
&gt; +#define VHOST_USER_FLAG_MAP_R (1u &lt;&lt; 0)<br>
&gt; +#define VHOST_USER_FLAG_MAP_W (1u &lt;&lt; 1)<br>
&gt; +<br>
&gt; +typedef struct {<br>
&gt; +=C2=A0 =C2=A0 /* VIRTIO Shared Memory Region ID */<br>
&gt; +=C2=A0 =C2=A0 uint8_t shmid;<br>
&gt; +=C2=A0 =C2=A0 uint8_t padding[7];<br>
&gt; +=C2=A0 =C2=A0 /* File offset */<br>
&gt; +=C2=A0 =C2=A0 uint64_t fd_offset;<br>
&gt; +=C2=A0 =C2=A0 /* Offset within the VIRTIO Shared Memory Region */<br>
&gt; +=C2=A0 =C2=A0 uint64_t shm_offset;<br>
&gt; +=C2=A0 =C2=A0 /* Size of the mapping */<br>
&gt; +=C2=A0 =C2=A0 uint64_t len;<br>
&gt; +=C2=A0 =C2=A0 /* Flags for the mmap operation, from VHOST_USER_FLAG_*=
 */<br>
&gt; +=C2=A0 =C2=A0 uint64_t flags;<br>
&gt; +} VhostUserMMap;<br>
&gt; +<br>
&gt;=C2=A0 typedef struct {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VhostUserRequest request;<br>
&gt;=C2=A0 <br>
&gt; @@ -224,6 +244,7 @@ typedef union {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserInflight inflight;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserShared object;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserTransferDeviceState transfe=
r_state;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserMMap mmap;<br>
&gt;=C2=A0 } VhostUserPayload;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 typedef struct VhostUserMsg {<br>
&gt; @@ -1748,6 +1769,100 @@ vhost_user_backend_handle_shared_object_lookup=
(struct vhost_user *u,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static int<br>
&gt; +vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserMMap *vu_=
mmap,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int fd)<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Device only has %d VIR=
TIO Shared Memory Regions. &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&quot;Requested ID: %d&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dev-&gt;vdev-&gt;n_shmem_regions, vu_mmap-&gt;shmid);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 mr =3D &amp;dev-&gt;vdev-&gt;shmem_list[vu_mmap-&gt;shm=
id];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!mr) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;VIRTIO Shared Memory R=
egion at &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&quot;ID %d unitialized&quot;, vu_mmap-&gt;shmid);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
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
<br>
Missing check for overlap between range [shm_offset, shm_offset + len)<br>
and existing mappings.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ((vu_mmap-&gt;flags &amp; VHOST_USER_FLAG=
_MAP_R) ? PROT_READ : 0) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ((vu_mmap-&gt;flags &amp; VHOST_USER_FLAG=
_MAP_W) ? PROT_WRITE : 0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 MAP_SHARED | MAP_FIXED, fd, vu_mmap-&gt;f=
d_offset);<br>
&gt; +<br>
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
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserMM=
ap *vu_mmap)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 void *addr =3D 0;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion *mr =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!dev-&gt;vdev-&gt;shmem_list ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev-&gt;vdev-&gt;n_shmem_regions &lt;=3D =
vu_mmap-&gt;shmid) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Device only has %d VIR=
TIO Shared Memory Regions. &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&quot;Requested ID: %d&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dev-&gt;vdev-&gt;n_shmem_regions, vu_mmap-&gt;shmid);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 mr =3D &amp;dev-&gt;vdev-&gt;shmem_list[vu_mmap-&gt;shm=
id];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!mr) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;VIRTIO Shared Memory R=
egion at &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&quot;ID %d unitialized&quot;, vu_mmap-&gt;shmid);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
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
<br>
Missing check for existing mapping with exact range [shm_offset, len)<br>
match.<br>
<br>
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
&gt; @@ -1816,6 +1931,13 @@ static gboolean backend_read(QIOChannel *ioc, G=
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
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fd ? fd[0] : -1);<br>
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
&gt; index 893a072c9d..9f2da5b11e 100644<br>
&gt; --- a/hw/virtio/virtio.c<br>
&gt; +++ b/hw/virtio/virtio.c<br>
&gt; @@ -2856,6 +2856,16 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return vmstate_save_state(f, &amp;vmstate_virtio, =
vdev, NULL);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +MemoryRegion *virtio_new_shmem_region(VirtIODevice *vdev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion *mr =3D g_new0(MemoryRegion, 1);<br>
&gt; +=C2=A0 =C2=A0 ++vdev-&gt;n_shmem_regions;<br>
&gt; +=C2=A0 =C2=A0 vdev-&gt;shmem_list =3D g_renew(MemoryRegion, vdev-&gt;=
shmem_list,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vdev-&gt;n_shmem_regions);<br>
<br>
Where is shmem_list freed?<br>
<br>
The name &quot;list&quot; is misleading since this is an array, not a list.=
<br>
<br>
&gt; +=C2=A0 =C2=A0 vdev-&gt;shmem_list[vdev-&gt;n_shmem_regions - 1] =3D *=
mr;<br>
&gt; +=C2=A0 =C2=A0 return mr;<br>
&gt; +}<br>
<br>
This looks weird. The contents of mr are copied into shmem_list[] and<br>
then the pointer to mr is returned? Did you mean for the field&#39;s type t=
o<br>
be MemoryRegion **shmem_list and then vdev-&gt;shmem_list[...] =3D mr would=
<br>
stash the pointer?<br>
<br>
&gt; +<br>
&gt;=C2=A0 /* A wrapper for use as a VMState .put function */<br>
&gt;=C2=A0 static int virtio_device_put(QEMUFile *f, void *opaque, size_t s=
ize,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const VMStateField *field, JSONWr=
iter *vmdesc)<br>
&gt; @@ -3264,6 +3274,8 @@ void virtio_init(VirtIODevice *vdev, uint16_t de=
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
&gt; index 7d5ffdc145..16d598aadc 100644<br>
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
&gt; @@ -280,6 +283,8 @@ void virtio_notify(VirtIODevice *vdev, VirtQueue *=
vq);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 int virtio_save(VirtIODevice *vdev, QEMUFile *f);<br>
&gt;=C2=A0 <br>
&gt; +MemoryRegion *virtio_new_shmem_region(VirtIODevice *vdev);<br>
&gt; +<br>
&gt;=C2=A0 extern const VMStateInfo virtio_vmstate_info;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define VMSTATE_VIRTIO_DEVICE \<br>
&gt; diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/l=
ibvhost-user/libvhost-user.c<br>
&gt; index a879149fef..28556d183a 100644<br>
&gt; --- a/subprojects/libvhost-user/libvhost-user.c<br>
&gt; +++ b/subprojects/libvhost-user/libvhost-user.c<br>
&gt; @@ -1586,6 +1586,71 @@ vu_rm_shared_object(VuDev *dev, unsigned char u=
uid[UUID_LEN])<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return vu_send_message(dev, &amp;msg);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +bool<br>
&gt; +vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_t fd_offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t shm_offset, =
uint64_t len, uint64_t flags)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 bool result =3D false;<br>
&gt; +=C2=A0 =C2=A0 VhostUserMsg msg_reply;<br>
&gt; +=C2=A0 =C2=A0 VhostUserMsg vmsg =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .request =3D VHOST_USER_BACKEND_SHMEM_MAP=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .size =3D sizeof(vmsg.payload.mmap),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =3D VHOST_USER_VERSION,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .payload.mmap =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .shmid =3D shmid,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .fd_offset =3D fd_offset,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .shm_offset =3D shm_offset,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .len =3D len,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =3D flags,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_=
REPLY_ACK)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vmsg.flags |=3D VHOST_USER_NEED_REPLY_MAS=
K;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 pthread_mutex_lock(&amp;dev-&gt;backend_mutex);<br>
&gt; +=C2=A0 =C2=A0 if (!vu_message_write(dev, dev-&gt;backend_fd, &amp;vms=
g)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pthread_mutex_unlock(&amp;dev-&gt;backend=
_mutex);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Also unlocks the backend_mutex */<br>
&gt; +=C2=A0 =C2=A0 return vu_process_message_reply(dev, &amp;vmsg);<br>
&gt; +}<br>
&gt; +<br>
&gt; +bool<br>
&gt; +vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t fd_offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t shm_o=
ffset, uint64_t len)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 bool result =3D false;<br>
&gt; +=C2=A0 =C2=A0 VhostUserMsg msg_reply;<br>
&gt; +=C2=A0 =C2=A0 VhostUserMsg vmsg =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .request =3D VHOST_USER_BACKEND_SHMEM_UNM=
AP,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .size =3D sizeof(vmsg.payload.mmap),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =3D VHOST_USER_VERSION,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .payload.mmap =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .shmid =3D shmid,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .fd_offset =3D fd_offset,<b=
r>
<br>
What is the meaning of this field? I expected it to be set to 0.<br></block=
quote><div><br></div><div>Probably true. I just kept it generic for backend=
s to decide what to set it to,</div><div>without considering the real use.<=
/div><div>I will remove the parameter and set it to 0 in the request.</div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .shm_offset =3D shm_offset,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .len =3D len,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_=
REPLY_ACK)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vmsg.flags |=3D VHOST_USER_NEED_REPLY_MAS=
K;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 pthread_mutex_lock(&amp;dev-&gt;backend_mutex);<br>
&gt; +=C2=A0 =C2=A0 if (!vu_message_write(dev, dev-&gt;backend_fd, &amp;vms=
g)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pthread_mutex_unlock(&amp;dev-&gt;backend=
_mutex);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Also unlocks the backend_mutex */<br>
&gt; +=C2=A0 =C2=A0 return vu_process_message_reply(dev, &amp;vmsg);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static bool<br>
&gt;=C2=A0 vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)<br>
&gt;=C2=A0 {<br>
&gt; diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/l=
ibvhost-user/libvhost-user.h<br>
&gt; index deb40e77b3..7f6c22cc1a 100644<br>
&gt; --- a/subprojects/libvhost-user/libvhost-user.h<br>
&gt; +++ b/subprojects/libvhost-user/libvhost-user.h<br>
&gt; @@ -127,6 +127,8 @@ typedef enum VhostUserBackendRequest {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,<br>
&gt; +=C2=A0 =C2=A0 VHOST_USER_BACKEND_SHMEM_MAP =3D 9,<br>
&gt; +=C2=A0 =C2=A0 VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_BACKEND_MAX<br>
&gt;=C2=A0 }=C2=A0 VhostUserBackendRequest;<br>
&gt;=C2=A0 <br>
&gt; @@ -186,6 +188,24 @@ typedef struct VhostUserShared {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 unsigned char uuid[UUID_LEN];<br>
&gt;=C2=A0 } VhostUserShared;<br>
&gt;=C2=A0 <br>
&gt; +/* For the flags field of VhostUserMMap */<br>
&gt; +#define VHOST_USER_FLAG_MAP_R (1u &lt;&lt; 0)<br>
&gt; +#define VHOST_USER_FLAG_MAP_W (1u &lt;&lt; 1)<br>
&gt; +<br>
&gt; +typedef struct {<br>
&gt; +=C2=A0 =C2=A0 /* VIRTIO Shared Memory Region ID */<br>
&gt; +=C2=A0 =C2=A0 uint8_t shmid;<br>
&gt; +=C2=A0 =C2=A0 uint8_t padding[7];<br>
&gt; +=C2=A0 =C2=A0 /* File offset */<br>
&gt; +=C2=A0 =C2=A0 uint64_t fd_offset;<br>
&gt; +=C2=A0 =C2=A0 /* Offset within the VIRTIO Shared Memory Region */<br>
&gt; +=C2=A0 =C2=A0 uint64_t shm_offset;<br>
&gt; +=C2=A0 =C2=A0 /* Size of the mapping */<br>
&gt; +=C2=A0 =C2=A0 uint64_t len;<br>
&gt; +=C2=A0 =C2=A0 /* Flags for the mmap operation, from VHOST_USER_FLAG_*=
 */<br>
&gt; +=C2=A0 =C2=A0 uint64_t flags;<br>
&gt; +} VhostUserMMap;<br>
&gt; +<br>
&gt;=C2=A0 #if defined(_WIN32) &amp;&amp; (defined(__x86_64__) || defined(_=
_i386__))<br>
&gt;=C2=A0 # define VU_PACKED __attribute__((gcc_struct, packed))<br>
&gt;=C2=A0 #else<br>
&gt; @@ -214,6 +234,7 @@ typedef struct VhostUserMsg {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserVringArea area;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserInflight inflight;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserShared object;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserMMap mmap;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 } payload;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 int fds[VHOST_MEMORY_BASELINE_NREGIONS];<br>
&gt; @@ -597,6 +618,38 @@ bool vu_add_shared_object(VuDev *dev, unsigned ch=
ar uuid[UUID_LEN]);<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 bool vu_rm_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN=
]);<br>
&gt;=C2=A0 <br>
&gt; +/**<br>
&gt; + * vu_shmem_map:<br>
&gt; + * @dev: a VuDev context<br>
&gt; + * @shmid: VIRTIO Shared Memory Region ID<br>
&gt; + * @fd_offset: File offset<br>
&gt; + * @shm_offset: Offset within the VIRTIO Shared Memory Region<br>
&gt; + * @len: Size of the mapping<br>
&gt; + * @flags: Flags for the mmap operation<br>
&gt; + *<br>
&gt; + * Advertises a new mapping to be made in a given VIRTIO Shared Memor=
y Region.<br>
&gt; + *<br>
&gt; + * Returns: TRUE on success, FALSE on failure.<br>
&gt; + */<br>
&gt; +bool vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_t fd_offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64=
_t shm_offset, uint64_t len, uint64_t flags);<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * vu_shmem_map:<br>
&gt; + * @dev: a VuDev context<br>
&gt; + * @shmid: VIRTIO Shared Memory Region ID<br>
&gt; + * @fd_offset: File offset<br>
&gt; + * @shm_offset: Offset within the VIRTIO Shared Memory Region<br>
&gt; + * @len: Size of the mapping<br>
&gt; + *<br>
&gt; + * The front-end un-mmaps a given range in the VIRTIO Shared Memory R=
egion<br>
&gt; + * with the requested `shmid`.<br>
&gt; + *<br>
&gt; + * Returns: TRUE on success, FALSE on failure.<br>
&gt; + */<br>
&gt; +bool vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t fd_offset,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64=
_t shm_offset, uint64_t len);<br>
&gt; +<br>
&gt;=C2=A0 /**<br>
&gt;=C2=A0 =C2=A0* vu_queue_set_notification:<br>
&gt;=C2=A0 =C2=A0* @dev: a VuDev context<br>
&gt; -- <br>
&gt; 2.45.2<br>
&gt; <br>
</blockquote></div></div>

--000000000000cb98a6062146205d--


