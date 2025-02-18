Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E802C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 10:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkKvb-0001vL-1I; Tue, 18 Feb 2025 05:34:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tkKvZ-0001up-9e
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 05:34:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tkKvW-0000rH-AP
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 05:34:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739874845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=As1jmVgerOf5bCVudJmfe3lgYa94RDnfAYwNaRuYs3g=;
 b=VGz8hgdimrsH4vQ8HIGNOQtD6XK+UDUbE7wGFlRCMuTljzuzV8yoR9u/Psfw6A/oR/TCam
 tCQoAEQ4dYgz8QbwCO9rgumAsO2AUyXBH3GHs5UKe3hEJI9i8klJ6fRDBBvQzWux/X+6I5
 KeKPRcpMsmClWZA7HMCMs1IDzccu7Pw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-1Mtv3SenO_eotlUqVgBgkw-1; Tue, 18 Feb 2025 05:34:03 -0500
X-MC-Unique: 1Mtv3SenO_eotlUqVgBgkw-1
X-Mimecast-MFC-AGG-ID: 1Mtv3SenO_eotlUqVgBgkw_1739874842
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2fc518f0564so5229228a91.2
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 02:34:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739874842; x=1740479642;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=As1jmVgerOf5bCVudJmfe3lgYa94RDnfAYwNaRuYs3g=;
 b=ESzI9o0Dx77nROQvsClpD7xnjv5xG9VwtTyat/oJZ0sOPlIEpGiwdSSxnQpklfMey2
 z8QGGMs5av7FZSLvI0QIkAF7fQRus0uzguw10sg/Zti5rjSveYTqBsUWK7/OkJ4F6EPr
 zJ5erpfZteZNjF0oRkKApQXNgpOwj6Fn1KQGEr1Sw5M/bNTgFQLFmlIxG4s0fx9I6kXr
 nao+GXczuk9Z/2Afr872YDP3a9A7SQ9PFtHrn0SgAA1h+eD1FyFuGIuR5srs1mL1Am8Z
 AgyoIpW/x+3L3Uq48wdJrIXhOIXZK9SmAHJE1xwr/o3AmoDO5uvTXMNdUTjqn/eNTwWU
 7NdQ==
X-Gm-Message-State: AOJu0Yz+nqYdVR321v/defePhJb1bbt8jQek0KUBw3nMZFVsoa/k8jNZ
 iFwIlPC4nWuVnKqO3Xm+w+mmQrlx658w7Au/YwLoMlJ/RRS3Q0OqvgpJK5t/whhWxt+uRzN+yBd
 Xj079cQ3iB1jBqaV85bXy7miQCfI3J7p34sv0zSpxt1FdeGKgJEMF85Iw6ZKyCBqJeZlzfVfetG
 Ppmp1VXSt2HwZkLj+rds5oUz6Q7zY=
X-Gm-Gg: ASbGncuypSdzqw8cWWFVTM83dtilWZnPEv4KnpPwCZfca22gQNgRqV6N5/H7hwADrqO
 lCmPbNeUaXgInUm6kdAaypG7PFnp9YuwCveD1CAl3Z31fhp3Jo+1+wPiqoo1tOJjP
X-Received: by 2002:a17:90b:4cc3:b0:2ee:af31:a7bd with SMTP id
 98e67ed59e1d1-2fc40d13e11mr19633239a91.5.1739874841817; 
 Tue, 18 Feb 2025 02:34:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRnUshNfFuhUA/kyewhvi/9HVf7fy7fIaFgq7fYWywABlOu2s6vU4vEUDBfbBmLWZFdME2r+PoXU/NJhONqfM=
X-Received: by 2002:a17:90b:4cc3:b0:2ee:af31:a7bd with SMTP id
 98e67ed59e1d1-2fc40d13e11mr19633203a91.5.1739874841358; Tue, 18 Feb 2025
 02:34:01 -0800 (PST)
MIME-Version: 1.0
References: <20250217164012.246727-1-aesteve@redhat.com>
 <20250217164012.246727-2-aesteve@redhat.com>
 <20250218064321.GE10767@fedora>
In-Reply-To: <20250218064321.GE10767@fedora>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 18 Feb 2025 11:33:49 +0100
X-Gm-Features: AWEUYZkIggR26dmotMSVrDoq26iPNpSzI_judq9mRqI86fEIukpHKhx1qJ5mW_I
Message-ID: <CADSE00+rcOE7BuO78poa8suM+=VU-09scCtEAdd57jn64rjUvQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] vhost-user: Add VirtIO Shared Memory map request
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, slp@redhat.com, stevensd@chromium.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Stefano Garzarella <sgarzare@redhat.com>, david@redhat.com, hi@alyssa.is,
 mst@redhat.com, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
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

On Tue, Feb 18, 2025 at 7:43=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Mon, Feb 17, 2025 at 05:40:04PM +0100, Albert Esteve wrote:
> > Add SHMEM_MAP/UNMAP requests to vhost-user to
> > handle VIRTIO Shared Memory mappings.
> >
> > This request allows backends to dynamically map
> > fds into a VIRTIO Shared Memory Region indentified
> > by its `shmid`. The map is performed by calling
> > `memory_region_init_ram_from_fd` and adding the
> > new region as a subregion of the shmem container
> > MR. Then, the fd memory is advertised to the
> > driver as a base addres + offset, so it can be
> > read/written (depending on the mmap flags
> > requested) while it is valid.
> >
> > The backend can unmap the memory range
> > in a given VIRTIO Shared Memory Region (again,
> > identified by its `shmid`), to free it.
> > Upon receiving this message, the front-end
> > must delete the MR as a subregion of
> > the shmem container region and free its
> > resources.
> >
> > Note that commit all these operations need
> > to be delayed to after we respond the request
> > to the backend to avoid deadlocks.
> >
> > The device model needs to create VirtSharedMemory
> > instances for the VirtIO Shared Memory Regions
> > and add them to the `VirtIODevice` instance.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  hw/virtio/vhost-user.c                    | 134 ++++++++++++++++++++++
> >  hw/virtio/virtio.c                        |  81 +++++++++++++
> >  include/hw/virtio/virtio.h                |  27 +++++
> >  subprojects/libvhost-user/libvhost-user.c |  70 +++++++++++
> >  subprojects/libvhost-user/libvhost-user.h |  55 +++++++++
> >  5 files changed, 367 insertions(+)
> >
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index 267b612587..d88e6f8c3c 100644
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
> > @@ -1770,6 +1791,111 @@ vhost_user_backend_handle_shared_object_lookup(=
struct vhost_user *u,
> >      return 0;
> >  }
> >
> > +static int
> > +vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
> > +                                    QIOChannel *ioc,
> > +                                    VhostUserHeader *hdr,
> > +                                    VhostUserPayload *payload,
> > +                                    int fd, Error **errp)
> > +{
> > +    VirtSharedMemory *shmem =3D NULL;
> > +    VhostUserMMap *vu_mmap =3D &payload->mmap;
> > +    g_autoptr(GString) shm_name =3D g_string_new(NULL);
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
> > +    shmem =3D &dev->vdev->shmem_list[vu_mmap->shmid];
> > +
> > +    if (!shmem) {
> > +        error_report("VIRTIO Shared Memory Region at "
> > +                     "ID %d unitialized", vu_mmap->shmid);
> > +        return -EFAULT;
> > +    }
> > +
> > +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> > +        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr->size) {
> > +        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
> > +                     vu_mmap->shm_offset, vu_mmap->len);
> > +        return -EFAULT;
> > +    }
> > +
> > +    g_string_printf(shm_name, "virtio-shm%i-%lu",
> > +                    vu_mmap->shmid, vu_mmap->shm_offset);
> > +
> > +    memory_region_transaction_begin();
> > +    virtio_add_shmem_map(shmem, shm_name->str, vu_mmap->shm_offset,
> > +                         vu_mmap->fd_offset, vu_mmap->len, fd, errp);
>
> Error handling is missing. In particular, if virtio_add_shmem_map() sets
> errp due to an error, then vhost_user_send_resp() will crash if it also
> needs to set the error. An Error object can only be filled in once.
>
> > +
> > +    hdr->size =3D sizeof(payload->u64);
> > +    vhost_user_send_resp(ioc, hdr, payload, errp);
>
> payload->u64 has not been initialized. It contains the contents of
> payload->mmap, which is not the u64 return value that must be sent here.
> I think something like the following is necessary:
> payload->u64 =3D 0;
>
> > +    memory_region_transaction_commit();
> > +
> > +    return 0;
> > +}
> > +
> > +static int
> > +vhost_user_backend_handle_shmem_unmap(struct vhost_dev *dev,
> > +                                      QIOChannel *ioc,
> > +                                      VhostUserHeader *hdr,
> > +                                      VhostUserPayload *payload,
> > +                                      Error **errp)
> > +{
> > +    VirtSharedMemory *shmem =3D NULL;
> > +    MappedMemoryRegion *mmap =3D NULL;
> > +    VhostUserMMap *vu_mmap =3D &payload->mmap;
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
> > +    shmem =3D &dev->vdev->shmem_list[vu_mmap->shmid];
> > +
> > +    if (!shmem) {
> > +        error_report("VIRTIO Shared Memory Region at "
> > +                     "ID %d unitialized", vu_mmap->shmid);
> > +        return -EFAULT;
> > +    }
> > +
> > +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> > +        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr->size) {
> > +        error_report("Bad offset/len for unmmap %" PRIx64 "+%" PRIx64,
> > +                     vu_mmap->shm_offset, vu_mmap->len);
> > +        return -EFAULT;
> > +    }
> > +
> > +    mmap =3D virtio_find_shmem_map(shmem, vu_mmap->shm_offset, vu_mmap=
->len);
> > +    if (!mmap) {
> > +        return -EFAULT;
> > +    }
> > +
> > +    memory_region_transaction_begin();
> > +    memory_region_del_subregion(shmem->mr, mmap->mem);
> > +
> > +    hdr->size =3D sizeof(payload->u64);
> > +    vhost_user_send_resp(ioc, hdr, payload, errp);
>
> Same uninitialized payload->u64 issue here.
>
> > +    memory_region_transaction_commit();
> > +
> > +    /* Free the MemoryRegion only after vhost_commit */
> > +    virtio_del_shmem_map(shmem, vu_mmap->shm_offset, vu_mmap->len);
> > +
> > +    return 0;
> > +}
> > +
> >  static void close_backend_channel(struct vhost_user *u)
> >  {
> >      g_source_destroy(u->backend_src);
> > @@ -1837,6 +1963,14 @@ static gboolean backend_read(QIOChannel *ioc, GI=
OCondition condition,
> >      case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
> >          ret =3D vhost_user_backend_handle_shared_object_lookup(dev->op=
aque, ioc,
> >                                                               &hdr, &pa=
yload);
> > +    case VHOST_USER_BACKEND_SHMEM_MAP:
> > +        ret =3D vhost_user_backend_handle_shmem_map(dev, ioc, &hdr, &p=
ayload,
> > +                                                  fd ? fd[0] : -1, &lo=
cal_err);
> > +        break;
> > +    case VHOST_USER_BACKEND_SHMEM_UNMAP:
> > +        ret =3D vhost_user_backend_handle_shmem_unmap(dev, ioc, &hdr, =
&payload,
> > +                                                    &local_err);
> > +        break;
> >          break;
> >      default:
> >          error_report("Received unexpected msg type: %d.", hdr.request)=
;
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 85110bce37..47d0ddb820 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -3063,6 +3063,75 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
> >      return vmstate_save_state(f, &vmstate_virtio, vdev, NULL);
> >  }
> >
> > +VirtSharedMemory *virtio_new_shmem_region(VirtIODevice *vdev)
> > +{
> > +    ++vdev->n_shmem_regions;
> > +    vdev->shmem_list =3D g_renew(VirtSharedMemory, vdev->shmem_list,
> > +                               vdev->n_shmem_regions);
> > +    vdev->shmem_list[vdev->n_shmem_regions - 1].mr =3D g_new0(MemoryRe=
gion, 1);
> > +    QTAILQ_INIT(&vdev->shmem_list[vdev->n_shmem_regions - 1].mmaps);
>
> QTAILQ cannot be used inside a struct that is reallocated using
> g_renew() because a dangling tql_prev pointer will be left after
> reallocation. From QTAILQ_INIT():
> (head)->tqh_circ.tql_prev =3D &(head)->tqh_circ; <--- not realloc-safe
>
> Instead of using g_renew() on an array, consider using a list from
> "qemu/queue.h". Lookup by shmid becomes O(n) instead of O(1), but it
> doesn't matter in practice since existing devices have a small number of
> VIRTIO Shared Memory Regions.
>
> > +    return &vdev->shmem_list[vdev->n_shmem_regions - 1];
> > +}
> > +
> > +void virtio_add_shmem_map(VirtSharedMemory *shmem, const char *shm_nam=
e,
> > +                          hwaddr shm_offset, hwaddr fd_offset, uint64_=
t size,
> > +                          int fd, Error **errp)
> > +{
> > +    MappedMemoryRegion *mmap;
> > +    fd =3D dup(fd);
> > +    if (fd < 0) {
> > +        error_setg_errno(errp, errno, "Failed to duplicate fd");
> > +        return;
> > +    }
> > +
> > +    if (shm_offset + size > shmem->mr->size) {
> > +        error_setg(errp, "Memory exceeds the shared memory boundaries"=
);
> > +        return;
>
> fd is leaked here.
>
> > +    }
> > +
> > +    mmap =3D g_new0(MappedMemoryRegion, 1);
> > +    mmap->mem =3D g_new0(MemoryRegion, 1);
> > +    mmap->offset =3D shm_offset;
> > +    if (!memory_region_init_ram_from_fd(mmap->mem,
> > +                                        OBJECT(shmem->mr),
> > +                                        shm_name, size, RAM_SHARED,
> > +                                        fd, fd_offset, errp)) {
> > +        error_setg(errp, "Failed to mmap region %s", shm_name);
> > +        close(fd);
> > +        g_free(mmap->mem);
> > +        g_free(mmap);
> > +        return;
> > +    }
> > +    memory_region_add_subregion(shmem->mr, shm_offset, mmap->mem);
> > +
> > +    QTAILQ_INSERT_TAIL(&shmem->mmaps, mmap, link);
> > +}
> > +
> > +MappedMemoryRegion *virtio_find_shmem_map(VirtSharedMemory *shmem,
> > +                                          hwaddr offset, uint64_t size=
)
> > +{
> > +    MappedMemoryRegion *mmap;
> > +    QTAILQ_FOREACH(mmap, &shmem->mmaps, link) {
> > +        if (mmap->offset =3D=3D offset && mmap->mem->size =3D=3D size)=
 {
> > +            return mmap;
> > +        }
> > +    }
> > +    return NULL;
> > +}
> > +
> > +void virtio_del_shmem_map(VirtSharedMemory *shmem, hwaddr offset,
> > +                          uint64_t size)
> > +{
> > +    MappedMemoryRegion *mmap =3D virtio_find_shmem_map(shmem, offset, =
size);
> > +    if (mmap =3D=3D NULL) {
> > +        return;
> > +    }
> > +
> > +    object_unparent(OBJECT(mmap->mem));
> > +    QTAILQ_REMOVE(&shmem->mmaps, mmap, link);
> > +    g_free(mmap);
> > +}
> > +
> >  /* A wrapper for use as a VMState .put function */
> >  static int virtio_device_put(QEMUFile *f, void *opaque, size_t size,
> >                                const VMStateField *field, JSONWriter *v=
mdesc)
> > @@ -3492,6 +3561,8 @@ void virtio_init(VirtIODevice *vdev, uint16_t dev=
ice_id, size_t config_size)
> >              virtio_vmstate_change, vdev);
> >      vdev->device_endian =3D virtio_default_endian();
> >      vdev->use_guest_notifier_mask =3D true;
> > +    vdev->shmem_list =3D NULL;
> > +    vdev->n_shmem_regions =3D 0;
> >  }
> >
> >  /*
> > @@ -4005,11 +4076,21 @@ static void virtio_device_free_virtqueues(VirtI=
ODevice *vdev)
> >  static void virtio_device_instance_finalize(Object *obj)
> >  {
> >      VirtIODevice *vdev =3D VIRTIO_DEVICE(obj);
> > +    VirtSharedMemory *shmem =3D NULL;
> > +    int i;
> >
> >      virtio_device_free_virtqueues(vdev);
> >
> >      g_free(vdev->config);
> >      g_free(vdev->vector_queues);
> > +    for (i =3D 0; i< vdev->n_shmem_regions; i++) {
> > +        shmem =3D &vdev->shmem_list[i];
> > +        while (!QTAILQ_EMPTY(&shmem->mmaps)) {
> > +            MappedMemoryRegion *mmap_reg =3D QTAILQ_FIRST(&shmem->mmap=
s);
> > +            QTAILQ_REMOVE(&shmem->mmaps, mmap_reg, link);
> > +            g_free(mmap_reg);
>
> Is it possible to reuse virtio_del_shmem_map() to avoid code duplication
> and inconsistencies?
>
>   while (!QTAILQ_EMPTY(&shmem->mmaps)) {
>       MappedMemoryRegion *mmap_reg =3D QTAILQ_FIRST(&shmem->mmaps);
>       virtio_del_shmem_map(shmem, mmap_reg->offset, mmap_reg->mem->size);
>   }

Yes that is a good idea, thanks. Maybe I could change the function
signature to receive the mmap_reg as parameter instead of the offset
and size combo.

>
> > +        }
> > +    }
>
> Missing g_free(vdev->shmem_list).
>
> >  }
> >
> >  static const Property virtio_properties[] =3D {
> > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > index 6386910280..a778547c79 100644
> > --- a/include/hw/virtio/virtio.h
> > +++ b/include/hw/virtio/virtio.h
> > @@ -98,6 +98,21 @@ enum virtio_device_endian {
> >      VIRTIO_DEVICE_ENDIAN_BIG,
> >  };
> >
> > +struct MappedMemoryRegion {
> > +    MemoryRegion *mem;
> > +    hwaddr offset;
> > +    QTAILQ_ENTRY(MappedMemoryRegion) link;
> > +};
> > +
> > +typedef struct MappedMemoryRegion MappedMemoryRegion;
> > +
> > +struct VirtSharedMemory {
> > +    MemoryRegion *mr;
> > +    QTAILQ_HEAD(, MappedMemoryRegion) mmaps;
> > +};
> > +
> > +typedef struct VirtSharedMemory VirtSharedMemory;
> > +
> >  /**
> >   * struct VirtIODevice - common VirtIO structure
> >   * @name: name of the device
> > @@ -167,6 +182,9 @@ struct VirtIODevice
> >       */
> >      EventNotifier config_notifier;
> >      bool device_iotlb_enabled;
> > +    /* Shared memory region for vhost-user mappings. */
>
> This is core VIRTIO code and Shared Memory Regions are a VIRTIO concept.
> It is possible that built-in (non-vhost) devices might also add their
> shared memory regions with virtio_new_shmem_region(), so let's not talk
> about vhost-user specifically.
>
> > +    VirtSharedMemory *shmem_list;
> > +    int n_shmem_regions;
> >  };
> >
> >  struct VirtioDeviceClass {
> > @@ -289,6 +307,15 @@ void virtio_notify(VirtIODevice *vdev, VirtQueue *=
vq);
> >
> >  int virtio_save(VirtIODevice *vdev, QEMUFile *f);
> >
> > +VirtSharedMemory *virtio_new_shmem_region(VirtIODevice *vdev);
> > +void virtio_add_shmem_map(VirtSharedMemory *shmem, const char *shm_nam=
e,
> > +                          hwaddr shm_offset, hwaddr fd_offset, uint64_=
t size,
> > +                          int fd, Error **errp);
> > +MappedMemoryRegion *virtio_find_shmem_map(VirtSharedMemory *shmem, hwa=
ddr offset,
> > +                                          uint64_t size);
> > +void virtio_del_shmem_map(VirtSharedMemory *shmem, hwaddr offset,
> > +                          uint64_t size);
> > +
> >  extern const VMStateInfo virtio_vmstate_info;
> >
> >  #define VMSTATE_VIRTIO_DEVICE \
> > diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/li=
bvhost-user/libvhost-user.c
> > index 9c630c2170..034cbfdc3c 100644
> > --- a/subprojects/libvhost-user/libvhost-user.c
> > +++ b/subprojects/libvhost-user/libvhost-user.c
> > @@ -1592,6 +1592,76 @@ vu_rm_shared_object(VuDev *dev, unsigned char uu=
id[UUID_LEN])
> >      return vu_send_message(dev, &msg);
> >  }
> >
> > +bool
> > +vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
> > +             uint64_t shm_offset, uint64_t len, uint64_t flags, int fd=
)
> > +{
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
> > +        .fd_num =3D 1,
> > +        .fds[0] =3D fd,
> > +    };
> > +
> > +    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SHMEM)) {
> > +        return false;
> > +    }
> > +
> > +    if (vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK))=
 {
> > +        vmsg.flags |=3D VHOST_USER_NEED_REPLY_MASK;
> > +    }
>
> Setting this flag is inconsistent with
> vhost_user_backend_handle_shmem_map() and
> vhost_user_backend_handle_shmem_unmap(). They call
> vhost_user_send_resp() explicitly instead of relying on backend_read()
> to send the return value when VHOST_USER_NEED_REPLY_MASK is set. This
> inconsistency means that a successful return message will be sent twice
> when VHOST_USER_NEED_REPLY_MASK is set.

It is true that is inconsistent, I need to check for the field before
sending the reponse in the handlers. But at least it will not respond
twice as `vhost_user_send_resp()` unset the VHOST_USER_NEED_REPLY_MASK
bit.

>
> Either these new vhost-user messages could be specified with a mandatory
> reply payload or the patch could be updated to avoid the explicit
> vhost_user_send_resp() calls. I think the latter is more commonly used
> by other vhost-user messages, so it's probably best to do it the same
> way.

The explicit calls are necessary to be able to control that
vhost_commit is called after the response is sent, or else it will
cause a deadlock. What I need to do is to check for the
VHOST_USER_NEED_REPLY_MASK bit before calling it. Then
`vhost_user_send_resp()` will unset it to avoid double reponse.

>
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
> > +vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t shm_offset, uint64_=
t len)
> > +{
> > +    VhostUserMsg vmsg =3D {
> > +        .request =3D VHOST_USER_BACKEND_SHMEM_UNMAP,
> > +        .size =3D sizeof(vmsg.payload.mmap),
> > +        .flags =3D VHOST_USER_VERSION,
> > +        .payload.mmap =3D {
> > +            .shmid =3D shmid,
> > +            .fd_offset =3D 0,
> > +            .shm_offset =3D shm_offset,
> > +            .len =3D len,
> > +        },
> > +    };
> > +
> > +    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SHMEM)) {
> > +        return false;
> > +    }
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
> > diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/li=
bvhost-user/libvhost-user.h
> > index 2ffc58c11b..e9adb836f0 100644
> > --- a/subprojects/libvhost-user/libvhost-user.h
> > +++ b/subprojects/libvhost-user/libvhost-user.h
> > @@ -69,6 +69,8 @@ enum VhostUserProtocolFeature {
> >      /* Feature 16 is reserved for VHOST_USER_PROTOCOL_F_STATUS. */
> >      /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
> >      VHOST_USER_PROTOCOL_F_SHARED_OBJECT =3D 18,
> > +    /* Feature 19 is reserved for VHOST_USER_PROTOCOL_F_DEVICE_STATE *=
/
> > +    VHOST_USER_PROTOCOL_F_SHMEM =3D 20,
> >      VHOST_USER_PROTOCOL_F_MAX
> >  };
> >
> > @@ -127,6 +129,8 @@ typedef enum VhostUserBackendRequest {
> >      VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,
> >      VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,
> >      VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
> > +    VHOST_USER_BACKEND_SHMEM_MAP =3D 9,
> > +    VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,
> >      VHOST_USER_BACKEND_MAX
> >  }  VhostUserBackendRequest;
> >
> > @@ -186,6 +190,24 @@ typedef struct VhostUserShared {
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
> >  #define VU_PACKED __attribute__((packed))
> >
> >  typedef struct VhostUserMsg {
> > @@ -210,6 +232,7 @@ typedef struct VhostUserMsg {
> >          VhostUserVringArea area;
> >          VhostUserInflight inflight;
> >          VhostUserShared object;
> > +        VhostUserMMap mmap;
> >      } payload;
> >
> >      int fds[VHOST_MEMORY_BASELINE_NREGIONS];
> > @@ -593,6 +616,38 @@ bool vu_add_shared_object(VuDev *dev, unsigned cha=
r uuid[UUID_LEN]);
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
> > + * @fd: A file descriptor
> > + *
> > + * Advertises a new mapping to be made in a given VIRTIO Shared Memory=
 Region.
> > + *
> > + * Returns: TRUE on success, FALSE on failure.
> > + */
> > +bool vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
> > +                  uint64_t shm_offset, uint64_t len, uint64_t flags, i=
nt fd);
> > +
> > +/**
> > + * vu_shmem_unmap:
> > + * @dev: a VuDev context
> > + * @shmid: VIRTIO Shared Memory Region ID
> > + * @fd_offset: File offset
> > + * @len: Size of the mapping
> > + *
> > + * The front-end un-mmaps a given range in the VIRTIO Shared Memory Re=
gion
> > + * with the requested `shmid`.
> > + *
> > + * Returns: TRUE on success, FALSE on failure.
> > + */
> > +bool vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t shm_offset,
> > +                    uint64_t len);
> > +
> >  /**
> >   * vu_queue_set_notification:
> >   * @dev: a VuDev context
> > --
> > 2.48.1
> >


