Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9459CCA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 12:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoLks-0003wK-QA; Tue, 19 Aug 2025 08:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1uoLkq-0003vt-Mr
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 08:47:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1uoLkm-0003Er-Q4
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 08:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755607672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b5f1DTR6sh21n47cQx3MlE4tltQt3iVUXbyoHiZXnzU=;
 b=YW655zc4e9RgtD6Rsya1nyp7pjdvNqJHlDbIgQ9qKrqXSshwFoncM9B/noJ+Hg8dBNUXov
 is/V2t6v7VE/p02kRCWsgWZLDYpE7hjtIh2depI/nUE+qMw5WqEz/60k2YmogCVGA2RYJ/
 1olUN/PoX7UX1DjvFVhwivg9sWX/ETc=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-LpTcPaYBOASfSutZvSoH-Q-1; Tue, 19 Aug 2025 08:47:50 -0400
X-MC-Unique: LpTcPaYBOASfSutZvSoH-Q-1
X-Mimecast-MFC-AGG-ID: LpTcPaYBOASfSutZvSoH-Q_1755607669
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-24457f4f3ecso62889105ad.0
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 05:47:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755607669; x=1756212469;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b5f1DTR6sh21n47cQx3MlE4tltQt3iVUXbyoHiZXnzU=;
 b=pbDWvs/pv7kL5dtqKJ3RhnCoEU6Qc9Zg6An1O+FmT/lff4NlL9ddKeUrALwU1nOTHw
 AcWqItCnlLzilCi3rWoPCYA/TuETDruBxgDqU5yCDlHC6u6oiSSsIyh9oIfRiMkl80gA
 dSGWzdN9WfuMKe//xUsdN4nA9nXM+mKIlpnOHhFCHz4k39UQ5G8G3AZUgneUQTyoO/XG
 JHOCk8MY4vd/eq8nSI9VmEXB3JBcElM07SpzSQpi6QNe47ad2mXW8VBTwPBSd5SK6G8/
 nCxwrWeLNm0GdwjJ7Gu9e/L7n6L12cD/Gk8lM97Jsnad1fhjjLLuVpDJBLJpza483aPe
 UyCQ==
X-Gm-Message-State: AOJu0Yxgix1ZRD4dgtdEwqJuIe5L5ZE33d8vVIiEUYR+rC+ufMMX9b2Z
 lTTWnPAS/di2iiA9nArKH+I0BIA/othd8WZEOrQB11ueK3nsIltW/lo5nB2Ec/IqGuEvSzya3Zg
 NrBMqz0ijw3iWc6Fh6VQQji8hwk8NvgCwc1l/xEg+ZOBgvwvj1O02xQ+uh26Pm/ivNnoiIHMhF1
 Ugkw665R0rMEO/f0nYnKil3oa1TfyVzeU=
X-Gm-Gg: ASbGncsvAnfKFD4+2qNeScOGwpUQPGqmO2nU46OJLAjAg/wL/Zo+Z9ffRpucnpGqnTn
 PKxYb4zIJRnTwsTUCbh2FcsZgtHbKiinVNLo4o59Xj+XPPSM+Xt2W96Q5uPYhuwAZ1O3xkLhv12
 1uiDCuTAGqgEqV0IvAryHR
X-Received: by 2002:a17:902:ce81:b0:234:d431:ec6e with SMTP id
 d9443c01a7336-245e04346e4mr26059985ad.3.1755607668797; 
 Tue, 19 Aug 2025 05:47:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNDtPj6CIvVLzMt9VxW4MZl+15pxik3urQtqA4uWvIfYAg7pXuNcRP/oykyZNhtF1/KxKac76U7NS03+e2zho=
X-Received: by 2002:a17:902:ce81:b0:234:d431:ec6e with SMTP id
 d9443c01a7336-245e04346e4mr26059475ad.3.1755607667840; Tue, 19 Aug 2025
 05:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250818100353.1560655-1-aesteve@redhat.com>
 <20250818100353.1560655-2-aesteve@redhat.com>
 <20250818185816.GB16685@fedora>
In-Reply-To: <20250818185816.GB16685@fedora>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 19 Aug 2025 14:47:36 +0200
X-Gm-Features: Ac12FXwkV_o2kYWkXpI4j6dxG6goQZ0JddiwvNbRZHhsfAKovBq-nNHvAkZEbdk
Message-ID: <CADSE00KF9Ak_9+npLpXyY_nGux=+6o38819W-F15Yg_PUCa-Xw@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] vhost-user: Add VirtIO Shared Memory map request
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, david@redhat.com, 
 "Michael S. Tsirkin" <mst@redhat.com>, hi@alyssa.is, jasowang@redhat.com, 
 Laurent Vivier <lvivier@redhat.com>, dbassey@redhat.com, 
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 stevensd@chromium.org, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, slp@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Aug 18, 2025 at 10:41=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>
> On Mon, Aug 18, 2025 at 12:03:46PM +0200, Albert Esteve wrote:
>
> (I haven't fully reviewed this yet, but here are my current comments.)
>
> > Add SHMEM_MAP/UNMAP requests to vhost-user for
> > dynamic management of VIRTIO Shared Memory mappings.
> >
> > This implementation introduces VhostUserShmemObject
> > as an intermediate QOM parent for MemoryRegions
> > created for SHMEM_MAP requests. This object
> > provides reference-counted lifecycle management
> > with automatic cleanup.
> >
> > This request allows backends to dynamically map
> > file descriptors into a VIRTIO Shared Memory
> > Regions identified by their shmid. Maps are created
> > using memory_region_init_ram_device_ptr() with
> > configurable read/write permissions, and the resulting
> > MemoryRegions are added as subregions to the shmem
> > container region. The mapped memory is then advertised
> > to the guest VIRTIO drivers as a base address plus
> > offset for reading and writting according
> > to the requested mmap flags.
> >
> > The backend can unmap memory ranges within a given
> > VIRTIO Shared Memory Region to free resources.
> > Upon receiving this message, the frontend removes
> > the MemoryRegion as a subregion and automatically
> > unreferences the associated VhostUserShmemObject,
> > triggering cleanup if no other references exist.
> >
> > Error handling has been improved to ensure consistent
> > behavior across handlers that manage their own
> > vhost_user_send_resp() calls. Since these handlers
> > clear the VHOST_USER_NEED_REPLY_MASK flag, explicit
> > error checking ensures proper connection closure on
> > failures, maintaining the expected error flow.
> >
> > Note the memory region commit for these
> > operations needs to be delayed until after we
> > respond to the backend to avoid deadlocks.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  hw/virtio/meson.build                     |   1 +
> >  hw/virtio/vhost-user-shmem.c              | 134 ++++++++++++++
> >  hw/virtio/vhost-user.c                    | 207 +++++++++++++++++++++-
> >  hw/virtio/virtio.c                        | 109 ++++++++++++
> >  include/hw/virtio/vhost-user-shmem.h      |  75 ++++++++
> >  include/hw/virtio/virtio.h                |  93 ++++++++++
> >  subprojects/libvhost-user/libvhost-user.c |  70 ++++++++
> >  subprojects/libvhost-user/libvhost-user.h |  54 ++++++
> >  8 files changed, 741 insertions(+), 2 deletions(-)
> >  create mode 100644 hw/virtio/vhost-user-shmem.c
> >  create mode 100644 include/hw/virtio/vhost-user-shmem.h
> >
> > diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> > index 3ea7b3cec8..5efcf70b75 100644
> > --- a/hw/virtio/meson.build
> > +++ b/hw/virtio/meson.build
> > @@ -20,6 +20,7 @@ if have_vhost
> >      # fixme - this really should be generic
> >      specific_virtio_ss.add(files('vhost-user.c'))
> >      system_virtio_ss.add(files('vhost-user-base.c'))
> > +    system_virtio_ss.add(files('vhost-user-shmem.c'))
> >
> >      # MMIO Stubs
> >      system_virtio_ss.add(files('vhost-user-device.c'))
> > diff --git a/hw/virtio/vhost-user-shmem.c b/hw/virtio/vhost-user-shmem.=
c
> > new file mode 100644
> > index 0000000000..1d763b56b6
> > --- /dev/null
> > +++ b/hw/virtio/vhost-user-shmem.c
> > @@ -0,0 +1,134 @@
> > +/*
> > + * VHost-user Shared Memory Object
> > + *
> > + * Copyright Red Hat, Inc. 2025
> > + *
> > + * Authors:
> > + *     Albert Esteve <aesteve@redhat.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/virtio/vhost-user-shmem.h"
> > +#include "system/memory.h"
> > +#include "qapi/error.h"
> > +#include "qemu/error-report.h"
> > +#include "trace.h"
> > +
> > +/**
> > + * VhostUserShmemObject
> > + *
> > + * An intermediate QOM object that manages individual shared memory ma=
ppings
> > + * created by VHOST_USER_BACKEND_SHMEM_MAP requests. It acts as a pare=
nt for
> > + * MemoryRegion objects, providing proper lifecycle management with re=
ference
> > + * counting. When the object is unreferenced and its reference count d=
rops
> > + * to zero, it automatically cleans up the MemoryRegion and unmaps the=
 memory.
> > + */
> > +
> > +static void vhost_user_shmem_object_finalize(Object *obj);
> > +static void vhost_user_shmem_object_instance_init(Object *obj);
> > +
> > +static const TypeInfo vhost_user_shmem_object_info =3D {
> > +    .name =3D TYPE_VHOST_USER_SHMEM_OBJECT,
> > +    .parent =3D TYPE_OBJECT,
> > +    .instance_size =3D sizeof(VhostUserShmemObject),
> > +    .instance_init =3D vhost_user_shmem_object_instance_init,
> > +    .instance_finalize =3D vhost_user_shmem_object_finalize,
> > +};
> > +
> > +static void vhost_user_shmem_object_instance_init(Object *obj)
> > +{
> > +    VhostUserShmemObject *shmem_obj =3D VHOST_USER_SHMEM_OBJECT(obj);
> > +
> > +    shmem_obj->shmid =3D 0;
> > +    shmem_obj->fd =3D -1;
> > +    shmem_obj->shm_offset =3D 0;
> > +    shmem_obj->len =3D 0;
> > +    shmem_obj->mr =3D NULL;
> > +}
> > +
> > +static void vhost_user_shmem_object_finalize(Object *obj)
> > +{
> > +    VhostUserShmemObject *shmem_obj =3D VHOST_USER_SHMEM_OBJECT(obj);
> > +
> > +    /* Clean up MemoryRegion if it exists */
> > +    if (shmem_obj->mr) {
> > +        /* Unparent the MemoryRegion to trigger cleanup */
> > +        object_unparent(OBJECT(shmem_obj->mr));
> > +        shmem_obj->mr =3D NULL;
> > +    }
> > +
> > +    /* Close file descriptor */
> > +    if (shmem_obj->fd >=3D 0) {
> > +        close(shmem_obj->fd);
> > +        shmem_obj->fd =3D -1;
> > +    }
> > +}
> > +
> > +VhostUserShmemObject *vhost_user_shmem_object_new(uint8_t shmid,
> > +                                                   int fd,
> > +                                                   uint64_t fd_offset,
> > +                                                   uint64_t shm_offset=
,
> > +                                                   uint64_t len,
> > +                                                   uint16_t flags)
> > +{
> > +    VhostUserShmemObject *shmem_obj;
> > +    MemoryRegion *mr;
> > +    g_autoptr(GString) mr_name =3D g_string_new(NULL);
> > +    uint32_t ram_flags;
> > +    Error *local_err =3D NULL;
> > +
> > +    if (len =3D=3D 0) {
> > +        error_report("Shared memory mapping size cannot be zero");
> > +        return NULL;
> > +    }
> > +
> > +    fd =3D dup(fd);
> > +    if (fd < 0) {
> > +        error_report("Failed to duplicate fd: %s", strerror(errno));
> > +        return NULL;
> > +    }
> > +
> > +    /* Determine RAM flags */
> > +    ram_flags =3D RAM_SHARED;
> > +    if (!(flags & VHOST_USER_FLAG_MAP_RW)) {
> > +        ram_flags |=3D RAM_READONLY_FD;
> > +    }
> > +
> > +    /* Create the VhostUserShmemObject */
> > +    shmem_obj =3D VHOST_USER_SHMEM_OBJECT(
> > +        object_new(TYPE_VHOST_USER_SHMEM_OBJECT));
> > +
> > +    /* Set up object properties */
> > +    shmem_obj->shmid =3D shmid;
> > +    shmem_obj->fd =3D fd;
> > +    shmem_obj->shm_offset =3D shm_offset;
> > +    shmem_obj->len =3D len;
> > +
> > +    /* Create MemoryRegion as a child of this object */
> > +    mr =3D g_new0(MemoryRegion, 1);
> > +    g_string_printf(mr_name, "vhost-user-shmem-%d-%" PRIx64, shmid, sh=
m_offset);
> > +
> > +    /* Initialize MemoryRegion with file descriptor */
> > +    if (!memory_region_init_ram_from_fd(mr, OBJECT(shmem_obj), mr_name=
->str,
> > +                                        len, ram_flags, fd, fd_offset,
> > +                                        &local_err)) {
> > +        error_report_err(local_err);
> > +        g_free(mr);
> > +        close(fd);
> > +        object_unref(OBJECT(shmem_obj));
> > +        return NULL;
> > +    }
> > +
> > +    shmem_obj->mr =3D mr;
> > +    return shmem_obj;
> > +}
> > +
> > +static void vhost_user_shmem_register_types(void)
> > +{
> > +    type_register_static(&vhost_user_shmem_object_info);
> > +}
> > +
> > +type_init(vhost_user_shmem_register_types)
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index 1e1d6b0d6e..eb3ad728b0 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -11,6 +11,7 @@
> >  #include "qemu/osdep.h"
> >  #include "qapi/error.h"
> >  #include "hw/virtio/virtio-dmabuf.h"
> > +#include "hw/virtio/vhost-user-shmem.h"
> >  #include "hw/virtio/vhost.h"
> >  #include "hw/virtio/virtio-crypto.h"
> >  #include "hw/virtio/vhost-user.h"
> > @@ -115,6 +116,8 @@ typedef enum VhostUserBackendRequest {
> >      VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,
> >      VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,
> >      VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
> > +    VHOST_USER_BACKEND_SHMEM_MAP =3D 9,
> > +    VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,
> >      VHOST_USER_BACKEND_MAX
> >  }  VhostUserBackendRequest;
> >
> > @@ -192,6 +195,23 @@ typedef struct VhostUserShared {
> >      unsigned char uuid[16];
> >  } VhostUserShared;
> >
> > +/* For the flags field of VhostUserMMap */
> > +#define VHOST_USER_FLAG_MAP_RW (1u << 0)
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
> > +    /* Flags for the mmap operation, from VHOST_USER_FLAG_MAP_* */
> > +    uint16_t flags;
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
> > @@ -1768,6 +1789,172 @@ vhost_user_backend_handle_shared_object_lookup(=
struct vhost_user *u,
> >      return 0;
> >  }
> >
> > +/**
> > + * vhost_user_backend_handle_shmem_map() - Handle SHMEM_MAP backend re=
quest
> > + * @dev: vhost device
> > + * @ioc: QIOChannel for communication
> > + * @hdr: vhost-user message header
> > + * @payload: message payload containing mapping details
> > + * @fd: file descriptor for the shared memory region
> > + *
> > + * Handles VHOST_USER_BACKEND_SHMEM_MAP requests from the backend. Cre=
ates
> > + * a VhostUserShmemObject to manage the shared memory mapping and adds=
 it
> > + * to the appropriate VirtIO shared memory region. The VhostUserShmemO=
bject
> > + * serves as an intermediate parent for the MemoryRegion, ensuring pro=
per
> > + * lifecycle management with reference counting.
> > + *
> > + * Returns: 0 on success, negative errno on failure
> > + */
> > +static int
> > +vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
> > +                                    QIOChannel *ioc,
> > +                                    VhostUserHeader *hdr,
> > +                                    VhostUserPayload *payload,
> > +                                    int fd)
> > +{
> > +    VirtioSharedMemory *shmem;
> > +    VhostUserMMap *vu_mmap =3D &payload->mmap;
> > +    Error *local_err =3D NULL;
> > +    g_autoptr(GString) shm_name =3D g_string_new(NULL);
> > +
> > +    if (fd < 0) {
> > +        error_report("Bad fd for map");
> > +        return -EBADF;
> > +    }
> > +
> > +    if (QSIMPLEQ_EMPTY(&dev->vdev->shmem_list)) {
> > +        error_report("Device has no VIRTIO Shared Memory Regions. "
> > +                     "Requested ID: %d", vu_mmap->shmid);
> > +        return -EFAULT;
> > +    }
> > +
> > +    shmem =3D virtio_find_shmem_region(dev->vdev, vu_mmap->shmid);
> > +    if (!shmem) {
> > +        error_report("VIRTIO Shared Memory Region at "
> > +                     "ID %d not found or unitialized", vu_mmap->shmid)=
;
> > +        return -EFAULT;
> > +    }
> > +
> > +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> > +        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr.size) {
> > +        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
> > +                     vu_mmap->shm_offset, vu_mmap->len);
> > +        return -EFAULT;
> > +    }
> > +
> > +    g_string_printf(shm_name, "virtio-shm%i-%lu",
> > +                    vu_mmap->shmid, vu_mmap->shm_offset);
> > +
> > +    memory_region_transaction_begin();
> > +
> > +    /* Create VhostUserShmemObject as intermediate parent for MemoryRe=
gion */
> > +    VhostUserShmemObject *shmem_obj =3D vhost_user_shmem_object_new(
> > +        vu_mmap->shmid, fd, vu_mmap->fd_offset, vu_mmap->shm_offset,
> > +        vu_mmap->len, vu_mmap->flags);
> > +
> > +    if (!shmem_obj) {
> > +        memory_region_transaction_commit();
> > +        return -EFAULT;
> > +    }
> > +
> > +    /* Add the mapping using our VhostUserShmemObject as the parent */
> > +    if (virtio_add_shmem_map(shmem, shmem_obj) !=3D 0) {
> > +        error_report("Failed to add shared memory mapping");
> > +        object_unref(OBJECT(shmem_obj));
> > +        memory_region_transaction_commit();
> > +        return -EFAULT;
> > +    }
> > +
> > +    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> > +        payload->u64 =3D 0;
> > +        hdr->size =3D sizeof(payload->u64);
> > +        vhost_user_send_resp(ioc, hdr, payload, &local_err);
> > +        if (local_err) {
> > +            error_report_err(local_err);
> > +            memory_region_transaction_commit();
> > +            return -EFAULT;
> > +        }
> > +    }
> > +
> > +    memory_region_transaction_commit();
> > +
> > +    return 0;
> > +}
> > +
> > +/**
> > + * vhost_user_backend_handle_shmem_unmap() - Handle SHMEM_UNMAP backen=
d request
> > + * @dev: vhost device
> > + * @ioc: QIOChannel for communication
> > + * @hdr: vhost-user message header
> > + * @payload: message payload containing unmapping details
> > + *
> > + * Handles VHOST_USER_BACKEND_SHMEM_UNMAP requests from the backend. R=
emoves
> > + * the specified memory mapping from the VirtIO shared memory region. =
This
> > + * automatically unreferences the associated VhostUserShmemObject, whi=
ch may
> > + * trigger its finalization and cleanup (munmap, close fd) if no other
> > + * references exist.
> > + *
> > + * Returns: 0 on success, negative errno on failure
> > + */
> > +static int
> > +vhost_user_backend_handle_shmem_unmap(struct vhost_dev *dev,
> > +                                      QIOChannel *ioc,
> > +                                      VhostUserHeader *hdr,
> > +                                      VhostUserPayload *payload)
> > +{
> > +    VirtioSharedMemory *shmem;
> > +    VirtioSharedMemoryMapping *mmap =3D NULL;
> > +    VhostUserMMap *vu_mmap =3D &payload->mmap;
> > +    Error *local_err =3D NULL;
> > +
> > +    if (QSIMPLEQ_EMPTY(&dev->vdev->shmem_list)) {
> > +        error_report("Device has no VIRTIO Shared Memory Regions. "
> > +                     "Requested ID: %d", vu_mmap->shmid);
> > +        return -EFAULT;
> > +    }
> > +
> > +    shmem =3D virtio_find_shmem_region(dev->vdev, vu_mmap->shmid);
> > +    if (!shmem) {
> > +        error_report("VIRTIO Shared Memory Region at "
> > +                     "ID %d not found or unitialized", vu_mmap->shmid)=
;
> > +        return -EFAULT;
> > +    }
> > +
> > +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> > +        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr.size) {
> > +        error_report("Bad offset/len for unmmap %" PRIx64 "+%" PRIx64,
> > +                     vu_mmap->shm_offset, vu_mmap->len);
> > +        return -EFAULT;
> > +    }
> > +
> > +    mmap =3D virtio_find_shmem_map(shmem, vu_mmap->shm_offset, vu_mmap=
->len);
> > +    if (!mmap) {
> > +        error_report("Shared memory mapping not found at offset %" PRI=
x64
> > +                     " with length %" PRIx64,
> > +                     vu_mmap->shm_offset, vu_mmap->len);
> > +        return -EFAULT;
> > +    }
> > +
> > +    memory_region_transaction_begin();
> > +    memory_region_del_subregion(&shmem->mr, mmap->mem);
> > +    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> > +        payload->u64 =3D 0;
> > +        hdr->size =3D sizeof(payload->u64);
> > +        vhost_user_send_resp(ioc, hdr, payload, &local_err);
> > +        if (local_err) {
> > +            error_report_err(local_err);
> > +            memory_region_transaction_commit();
> > +            return -EFAULT;
> > +        }
> > +    }
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
> > @@ -1833,8 +2020,24 @@ static gboolean backend_read(QIOChannel *ioc, GI=
OCondition condition,
> >                                                               &payload.=
object);
> >          break;
> >      case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
> > -        ret =3D vhost_user_backend_handle_shared_object_lookup(dev->op=
aque, ioc,
> > -                                                             &hdr, &pa=
yload);
> > +        /* Handler manages its own response, check error and close con=
nection */
> > +        if (vhost_user_backend_handle_shared_object_lookup(dev->opaque=
, ioc,
> > +                                                           &hdr, &payl=
oad) < 0) {
> > +            goto err;
> > +        }
> > +        break;
> > +    case VHOST_USER_BACKEND_SHMEM_MAP:
> > +        /* Handler manages its own response, check error and close con=
nection */
> > +        if (vhost_user_backend_handle_shmem_map(dev, ioc, &hdr, &paylo=
ad,
> > +                                                fd ? fd[0] : -1) < 0) =
{
> > +            goto err;
> > +        }
> > +        break;
> > +    case VHOST_USER_BACKEND_SHMEM_UNMAP:
> > +        /* Handler manages its own response, check error and close con=
nection */
> > +        if (vhost_user_backend_handle_shmem_unmap(dev, ioc, &hdr, &pay=
load) < 0) {
> > +            goto err;
> > +        }
> >          break;
> >      default:
> >          error_report("Received unexpected msg type: %d.", hdr.request)=
;
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 9a81ad912e..1ead5f653f 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -14,6 +14,7 @@
> >  #include "qemu/osdep.h"
> >  #include "qapi/error.h"
> >  #include "qapi/qapi-commands-virtio.h"
> > +#include "hw/virtio/vhost-user-shmem.h"
> >  #include "trace.h"
> >  #include "qemu/defer-call.h"
> >  #include "qemu/error-report.h"
> > @@ -3045,6 +3046,100 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f=
)
> >      return vmstate_save_state(f, &vmstate_virtio, vdev, NULL);
> >  }
> >
> > +VirtioSharedMemory *virtio_new_shmem_region(VirtIODevice *vdev, uint8_=
t shmid)
> > +{
> > +    VirtioSharedMemory *elem;
> > +    g_autofree char *name =3D NULL;
> > +
> > +    elem =3D g_new0(VirtioSharedMemory, 1);
> > +    elem->shmid =3D shmid;
> > +
> > +    /* Initialize embedded MemoryRegion as container for shmem mapping=
s */
> > +    name =3D g_strdup_printf("virtio-shmem-%d", shmid);
> > +    memory_region_init(&elem->mr, OBJECT(vdev), name, UINT64_MAX);
> > +    QTAILQ_INIT(&elem->mmaps);
> > +    QSIMPLEQ_INSERT_TAIL(&vdev->shmem_list, elem, entry);
> > +    return QSIMPLEQ_LAST(&vdev->shmem_list, VirtioSharedMemory, entry)=
;
>
> "return elem;" is simpler.

This sounds familiar. I hope is not a change that got lost, but simply
that I changed
it somewhere else but I repeated the pattern here. I will change it.

>
> > +}
> > +
> > +VirtioSharedMemory *virtio_find_shmem_region(VirtIODevice *vdev, uint8=
_t shmid)
> > +{
> > +    VirtioSharedMemory *shmem, *next;
> > +    QSIMPLEQ_FOREACH_SAFE(shmem, &vdev->shmem_list, entry, next) {
> > +        if (shmem->shmid =3D=3D shmid) {
> > +            return shmem;
> > +        }
> > +    }
> > +    return NULL;
> > +}
> > +
> > +int virtio_add_shmem_map(VirtioSharedMemory *shmem,
> > +                         VhostUserShmemObject *shmem_obj)
> > +{
> > +    VirtioSharedMemoryMapping *mmap;
> > +    if (!shmem_obj) {
> > +        error_report("VhostUserShmemObject cannot be NULL");
> > +        return -1;
> > +    }
> > +    if (!shmem_obj->mr) {
> > +        error_report("VhostUserShmemObject has no MemoryRegion");
> > +        return -1;
> > +    }
> > +
> > +    /* Validate boundaries against the VIRTIO shared memory region */
> > +    if (shmem_obj->shm_offset + shmem_obj->len > shmem->mr.size) {
>
> From above:
>
>   memory_region_init(&elem->mr, OBJECT(vdev), name, UINT64_MAX);
>
> shmem->mr's size is UINT64_MAX and this if statement doesn't handle
> integer overflow. What is the purpose of this size check?
>
> > +        error_report("Memory exceeds the shared memory boundaries");
> > +        return -1;
> > +    }
> > +
> > +    /* Create the VirtioSharedMemoryMapping wrapper */
> > +    mmap =3D g_new0(VirtioSharedMemoryMapping, 1);
> > +    mmap->mem =3D shmem_obj->mr;
> > +    mmap->offset =3D shmem_obj->shm_offset;
> > +    mmap->shmem_obj =3D shmem_obj;
> > +
> > +    /* Take a reference on the VhostUserShmemObject */
> > +    object_ref(OBJECT(shmem_obj));
>
> Why is the reference count incremented here? The caller seems to pass
> ownership to this function...at least
> vhost_user_backend_handle_shmem_map() doesn't touch shmem_obj afterwards
> and doesn't unref it.

You are right. transfering ownership is better and does not require
the count increment. I'll remove this.

>
> > +
> > +    /* Add as subregion to the VIRTIO shared memory */
> > +    memory_region_add_subregion(&shmem->mr, mmap->offset, mmap->mem);
> > +
> > +    /* Add to the mapped regions list */
> > +    QTAILQ_INSERT_TAIL(&shmem->mmaps, mmap, link);
> > +
> > +    return 0;
> > +}
> > +
> > +VirtioSharedMemoryMapping *virtio_find_shmem_map(VirtioSharedMemory *s=
hmem,
> > +                                          hwaddr offset, uint64_t size=
)
> > +{
> > +    VirtioSharedMemoryMapping *mmap;
> > +    QTAILQ_FOREACH(mmap, &shmem->mmaps, link) {
> > +        if (mmap->offset =3D=3D offset && mmap->mem->size =3D=3D size)=
 {
> > +            return mmap;
> > +        }
> > +    }
> > +    return NULL;
> > +}
> > +
> > +void virtio_del_shmem_map(VirtioSharedMemory *shmem, hwaddr offset,
> > +                          uint64_t size)
> > +{
> > +    VirtioSharedMemoryMapping *mmap =3D virtio_find_shmem_map(shmem, o=
ffset, size);
> > +    if (mmap =3D=3D NULL) {
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * Unref the VhostUserShmemObject which will trigger automatic cle=
anup
> > +     * when the reference count reaches zero.
> > +     */
> > +    object_unref(OBJECT(mmap->shmem_obj));
> > +
> > +    QTAILQ_REMOVE(&shmem->mmaps, mmap, link);
> > +    g_free(mmap);
> > +}
> > +
> >  /* A wrapper for use as a VMState .put function */
> >  static int virtio_device_put(QEMUFile *f, void *opaque, size_t size,
> >                                const VMStateField *field, JSONWriter *v=
mdesc)
> > @@ -3521,6 +3616,7 @@ void virtio_init(VirtIODevice *vdev, uint16_t dev=
ice_id, size_t config_size)
> >              NULL, virtio_vmstate_change, vdev);
> >      vdev->device_endian =3D virtio_default_endian();
> >      vdev->use_guest_notifier_mask =3D true;
> > +    QSIMPLEQ_INIT(&vdev->shmem_list);
> >  }
> >
> >  /*
> > @@ -4032,11 +4128,24 @@ static void virtio_device_free_virtqueues(VirtI=
ODevice *vdev)
> >  static void virtio_device_instance_finalize(Object *obj)
> >  {
> >      VirtIODevice *vdev =3D VIRTIO_DEVICE(obj);
> > +    VirtioSharedMemory *shmem;
> >
> >      virtio_device_free_virtqueues(vdev);
> >
> >      g_free(vdev->config);
> >      g_free(vdev->vector_queues);
> > +    while (!QSIMPLEQ_EMPTY(&vdev->shmem_list)) {
> > +        shmem =3D QSIMPLEQ_FIRST(&vdev->shmem_list);
> > +        while (!QTAILQ_EMPTY(&shmem->mmaps)) {
> > +            VirtioSharedMemoryMapping *mmap_reg =3D QTAILQ_FIRST(&shme=
m->mmaps);
> > +            virtio_del_shmem_map(shmem, mmap_reg->offset, mmap_reg->me=
m->size);
> > +        }
> > +
> > +        /* Clean up the embedded MemoryRegion */
> > +        object_unparent(OBJECT(&shmem->mr));
> > +        QSIMPLEQ_REMOVE_HEAD(&vdev->shmem_list, entry);
> > +        g_free(shmem);
> > +    }
> >  }
> >
> >  static const Property virtio_properties[] =3D {
> > diff --git a/include/hw/virtio/vhost-user-shmem.h b/include/hw/virtio/v=
host-user-shmem.h
> > new file mode 100644
> > index 0000000000..1f8c7bdc1f
> > --- /dev/null
> > +++ b/include/hw/virtio/vhost-user-shmem.h
> > @@ -0,0 +1,75 @@
> > +/*
> > + * VHost-user Shared Memory Object
> > + *
> > + * Copyright Red Hat, Inc. 2025
> > + *
> > + * Authors:
> > + *     Albert Esteve <aesteve@redhat.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#ifndef VHOST_USER_SHMEM_H
> > +#define VHOST_USER_SHMEM_H
> > +
> > +#include "qemu/osdep.h"
> > +#include "qom/object.h"
> > +#include "system/memory.h"
> > +#include "qapi/error.h"
> > +
> > +/* vhost-user memory mapping flags */
> > +#define VHOST_USER_FLAG_MAP_RW (1u << 0)
>
> This constant is part of the vhost-user protocol. It would be nicer to
> keep that all in one file instead of spreading protocol definitions
> across multiple files.
>
> In this case you could replace vhost_user_shmem_object_new()'s flags
> argument with a bool allow_write argument. That way the vhost-user
> protocol parsing happens in vhost-user.c and not vhost-user-shmem.c.

I'll go for this option.

>
> Alternatively, you could move the protocol definitions from vhost-user.c
> into a header file and include them from vhost-user-shmem.c.
>
> > +
> > +#define TYPE_VHOST_USER_SHMEM_OBJECT "vhost-user-shmem"
> > +OBJECT_DECLARE_SIMPLE_TYPE(VhostUserShmemObject, VHOST_USER_SHMEM_OBJE=
CT)
> > +
> > +/**
> > + * VhostUserShmemObject:
> > + * @parent: Parent object
> > + * @shmid: VIRTIO Shared Memory Region ID
> > + * @fd: File descriptor for the shared memory region
> > + * @shm_offset: Offset within the VIRTIO Shared Memory Region
> > + * @len: Size of the mapping
> > + * @mr: MemoryRegion associated with this shared memory mapping
> > + *
> > + * An intermediate QOM object that manages individual shared memory ma=
ppings
> > + * created by VHOST_USER_BACKEND_SHMEM_MAP requests. It acts as a pare=
nt for
> > + * MemoryRegion objects, providing proper lifecycle management with re=
ference
> > + * counting. When the object is unreferenced and its reference count d=
rops
> > + * to zero, it automatically cleans up the MemoryRegion and unmaps the=
 memory.
> > + */
> > +struct VhostUserShmemObject {
> > +    Object parent;
> > +
> > +    uint8_t shmid;
> > +    int fd;
> > +    uint64_t shm_offset;
> > +    uint64_t len;
> > +    MemoryRegion *mr;
> > +};
> > +
> > +/**
> > + * vhost_user_shmem_object_new() - Create a new VhostUserShmemObject
> > + * @shmid: VIRTIO Shared Memory Region ID
> > + * @fd: File descriptor for the shared memory
> > + * @fd_offset: Offset within the file descriptor
> > + * @shm_offset: Offset within the VIRTIO Shared Memory Region
> > + * @len: Size of the mapping
> > + * @flags: Mapping flags (VHOST_USER_FLAG_MAP_*)
> > + *
> > + * Creates a new VhostUserShmemObject that manages a shared memory map=
ping.
> > + * The object will create a MemoryRegion using memory_region_init_ram_=
from_fd()
> > + * as a child object. When the object is finalized, it will automatica=
lly
> > + * clean up the MemoryRegion and close the file descriptor.
> > + *
> > + * Return: A new VhostUserShmemObject on success, NULL on error.
> > + */
> > +VhostUserShmemObject *vhost_user_shmem_object_new(uint8_t shmid,
> > +                                                   int fd,
> > +                                                   uint64_t fd_offset,
> > +                                                   uint64_t shm_offset=
,
> > +                                                   uint64_t len,
> > +                                                   uint16_t flags);
> > +
> > +#endif /* VHOST_USER_SHMEM_H */
> > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > index c594764f23..a563bbac2c 100644
> > --- a/include/hw/virtio/virtio.h
> > +++ b/include/hw/virtio/virtio.h
> > @@ -98,6 +98,26 @@ enum virtio_device_endian {
> >      VIRTIO_DEVICE_ENDIAN_BIG,
> >  };
> >
> > +struct VhostUserShmemObject;
> > +
> > +struct VirtioSharedMemoryMapping {
> > +    MemoryRegion *mem;
> > +    hwaddr offset;
> > +    QTAILQ_ENTRY(VirtioSharedMemoryMapping) link;
> > +    struct VhostUserShmemObject *shmem_obj; /* Intermediate parent obj=
ect */
> > +};
> > +
> > +typedef struct VirtioSharedMemoryMapping VirtioSharedMemoryMapping;
> > +
> > +struct VirtioSharedMemory {
> > +    uint8_t shmid;
> > +    MemoryRegion mr;
> > +    QTAILQ_HEAD(, VirtioSharedMemoryMapping) mmaps;
> > +    QSIMPLEQ_ENTRY(VirtioSharedMemory) entry;
> > +};
>
> VirtioSharedMemoryMapping and VirtioSharedMemory duplicate information
> from VhostUserShmemObject (shmid, memory region pointers, offsets). This
> makes the relationship between VIRTIO and vhost-user code confusing.
>
> I wonder if VhostUserShmemObject is specific to the vhost-user protocol
> or if any VIRTIO device implementation that needs a VIRTIO Shared Memory
> Region with an fd, offset, etc should be able to use it? If yes, then it
> should be renamed and made part of the core hw/virtio/ code rather than
> vhost-user.
>
> > +
> > +typedef struct VirtioSharedMemory VirtioSharedMemory;
> > +
> >  /**
> >   * struct VirtIODevice - common VirtIO structure
> >   * @name: name of the device
> > @@ -167,6 +187,8 @@ struct VirtIODevice
> >       */
> >      EventNotifier config_notifier;
> >      bool device_iotlb_enabled;
> > +    /* Shared memory region for mappings. */
> > +    QSIMPLEQ_HEAD(, VirtioSharedMemory) shmem_list;
> >  };
> >
> >  struct VirtioDeviceClass {
> > @@ -295,6 +317,77 @@ void virtio_notify(VirtIODevice *vdev, VirtQueue *=
vq);
> >
> >  int virtio_save(VirtIODevice *vdev, QEMUFile *f);
> >
> > +/**
> > + * virtio_new_shmem_region() - Create a new shared memory region
> > + * @vdev: VirtIODevice
> > + * @shmid: Shared memory ID
> > + *
> > + * Creates a new VirtioSharedMemory region for the given device and ID=
.
> > + * The returned VirtioSharedMemory is owned by the VirtIODevice and wi=
ll
> > + * be automatically freed when the device is destroyed. The caller
> > + * should not free the returned pointer.
> > + *
> > + * Returns: Pointer to the new VirtioSharedMemory region, or NULL on f=
ailure
> > + */
> > +VirtioSharedMemory *virtio_new_shmem_region(VirtIODevice *vdev, uint8_=
t shmid);
> > +
> > +/**
> > + * virtio_find_shmem_region() - Find an existing shared memory region
> > + * @vdev: VirtIODevice
> > + * @shmid: Shared memory ID to find
> > + *
> > + * Finds an existing VirtioSharedMemory region by ID. The returned poi=
nter
> > + * is owned by the VirtIODevice and should not be freed by the caller.
> > + *
> > + * Returns: Pointer to the VirtioSharedMemory region, or NULL if not f=
ound
> > + */
> > +VirtioSharedMemory *virtio_find_shmem_region(VirtIODevice *vdev, uint8=
_t shmid);
> > +
> > +/**
> > + * virtio_add_shmem_map() - Add a memory mapping to a shared region
> > + * @shmem: VirtioSharedMemory region
> > + * @shmem_obj: VhostUserShmemObject to add (takes a reference)
> > + *
> > + * Adds a memory mapping to the shared memory region. The VhostUserShm=
emObject
> > + * is added as a child of the mapping and will be automatically manage=
d through
> > + * QOM reference counting. The mapping will be removed when
> > + * virtio_del_shmem_map() is called or when the shared memory region i=
s
> > + * destroyed.
> > + *
> > + * Returns: 0 on success, negative errno on failure
> > + */
> > +int virtio_add_shmem_map(VirtioSharedMemory *shmem,
> > +                         struct VhostUserShmemObject *shmem_obj);
>
> This API suggests the answer to my question above about whether
> VhostUserShmemObject is really a core hw/virtio/ concept rather than a
> vhost-user protocol concept is "yes". I think VhostUserShmemObject
> should be renamed and maybe unified with VirtioSharedMemoryMapping.

The answer would yes, you are right. The messages to map/unmap are
vhost-user-specific, but shared memory is a core virtio concept. I
will rename it.

>
> > +
> > +/**
> > + * virtio_find_shmem_map() - Find a memory mapping in a shared region
> > + * @shmem: VirtioSharedMemory region
> > + * @offset: Offset within the shared memory region
> > + * @size: Size of the mapping to find
> > + *
> > + * Finds an existing memory mapping that covers the specified range.
> > + * The returned VirtioSharedMemoryMapping is owned by the VirtioShared=
Memory
> > + * region and should not be freed by the caller.
> > + *
> > + * Returns: Pointer to the VirtioSharedMemoryMapping, or NULL if not f=
ound
> > + */
> > +VirtioSharedMemoryMapping *virtio_find_shmem_map(VirtioSharedMemory *s=
hmem,
> > +                                          hwaddr offset, uint64_t size=
);
> > +
> > +/**
> > + * virtio_del_shmem_map() - Remove a memory mapping from a shared regi=
on
> > + * @shmem: VirtioSharedMemory region
> > + * @offset: Offset of the mapping to remove
> > + * @size: Size of the mapping to remove
> > + *
> > + * Removes a memory mapping from the shared memory region. This will
> > + * automatically unref the associated VhostUserShmemObject, which may
> > + * trigger its finalization and cleanup if no other references exist.
> > + * The mapping's MemoryRegion will be properly unmapped and cleaned up=
.
> > + */
> > +void virtio_del_shmem_map(VirtioSharedMemory *shmem, hwaddr offset,
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
> > index 2ffc58c11b..26b710c92d 100644
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
> > @@ -186,6 +190,23 @@ typedef struct VhostUserShared {
> >      unsigned char uuid[UUID_LEN];
> >  } VhostUserShared;
> >
> > +/* For the flags field of VhostUserMMap */
> > +#define VHOST_USER_FLAG_MAP_RW (1u << 0)
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
> > +    /* Flags for the mmap operation, from VHOST_USER_FLAG_MAP_* */
> > +    uint16_t flags;
> > +} VhostUserMMap;
> > +
> >  #define VU_PACKED __attribute__((packed))
> >
> >  typedef struct VhostUserMsg {
> > @@ -210,6 +231,7 @@ typedef struct VhostUserMsg {
> >          VhostUserVringArea area;
> >          VhostUserInflight inflight;
> >          VhostUserShared object;
> > +        VhostUserMMap mmap;
> >      } payload;
> >
> >      int fds[VHOST_MEMORY_BASELINE_NREGIONS];
> > @@ -593,6 +615,38 @@ bool vu_add_shared_object(VuDev *dev, unsigned cha=
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
> > 2.49.0
> >


