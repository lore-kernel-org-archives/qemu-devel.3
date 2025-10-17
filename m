Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87C9CCD19A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 11:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9iaN-0007SG-Jt; Fri, 17 Oct 2025 07:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v9iaK-0007S4-Dr
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 07:25:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v9iaB-0005CZ-PX
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 07:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760700308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nF1wrHO9l0YSRYPLfuycFckVVGg7uR0Nxu9z5ETfXJ0=;
 b=ilU89jm56+UX2fvkTsuDd1VkLbiN8u5WOr6uKz1mFIC/dkDMYC0PzI4h7bm1YChDwE1H8O
 5zLIMEAlp9qJPcEaQJ3qwxyIMyfVYPHU4PRzR2gn8QJksel3vhBcCxM9lV+E3RL/SXJRW6
 vm88ndhPuJSEzvT3L5Y49Do+1ZyvoCw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-d4ddkqExMvSnniY2lpGv8w-1; Fri, 17 Oct 2025 07:25:06 -0400
X-MC-Unique: d4ddkqExMvSnniY2lpGv8w-1
X-Mimecast-MFC-AGG-ID: d4ddkqExMvSnniY2lpGv8w_1760700305
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-27c62320f16so19980605ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 04:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760700305; x=1761305105;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nF1wrHO9l0YSRYPLfuycFckVVGg7uR0Nxu9z5ETfXJ0=;
 b=aR7hczk0qVvrfoZEplE5fDOFsPGyTBAugBRXBVmCVjwIl6c51rdyRTjkdb1Md+2+Sp
 yEMHvtWB84TunxfL9ozERub1iTKUokbwsERbhw7E9PQC9d97eQZMZvLW4OG6M0XEXZHa
 q0GHj4AYoWzPgwTcrJ3sdK4mMuy6ss8PP+EJJ+EVpB+siALxvUs5FicC0jG3Xc5fjnX2
 nWKuretvSz59fqKbU9LX7GhzOZk2VeMna5K8ykiJHRz0N3qL/lcc0ZOMEJ3BEy/Cqx+o
 7UX0MpWJk7c2tx9E1OGy5I+C/gAQnBwjEYrPCraZVeiA+5qy1fLnaHaUnOkPazPnB9q9
 xP/w==
X-Gm-Message-State: AOJu0YzDd7MrZKklyrKjR9Z7NR+21GwEcoPpt+3v99Xnp7eK+yaLV7Vk
 DLMd248ywGMMI+kk16yfiUj0gEOif0IPq0jlMgPw6ndS6gqPgvIEBuh71xqLdm3XFa57+QMg8ts
 U9/auBmTbxMu+ND5C0DU5+3oofANnEPkwv7L9+dJ8XArr/T+z2/3d7gif9e7KD1Yue7BVFnuBhE
 W7bcguYGpsB/8HZ8zqekDCsKX3KIHYcf8=
X-Gm-Gg: ASbGncvYIby9UhOTmlew3pbECzyDVYN23cJ29T7f0y2pQFDh1hEX5H4OCTKpfcGvrRb
 QMwKZGa88rcVWpHr+VHjXFXMuP7klHIh/wLOLlhhSq6IwjNfuylfkjszSQK6GexXN6xIJ2jyS3W
 cuBYpbhjlBdFnViBzTPJEGWIUGGPk/fF4mPTt4NH6qd7DjpG9M/YQ=
X-Received: by 2002:a17:903:950:b0:268:cc5:5e4e with SMTP id
 d9443c01a7336-290c9c89320mr41224095ad.1.1760700304702; 
 Fri, 17 Oct 2025 04:25:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOq3O/A9B+H9ntOAmr53GYMwulVLxTlWXwrZfX7Ax+LUI+jPHtEOZ3FDxPUUYwEOuEbjhsmmyCCZfT+SQVwdM=
X-Received: by 2002:a17:903:950:b0:268:cc5:5e4e with SMTP id
 d9443c01a7336-290c9c89320mr41223695ad.1.1760700304213; Fri, 17 Oct 2025
 04:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20251016143827.1850397-1-aesteve@redhat.com>
 <20251016143827.1850397-2-aesteve@redhat.com>
 <nl5smdnd5neyuqykpwkruq2onc32hq7jbgbylv33xq4rrsksvc@hk6u3b33iws3>
In-Reply-To: <nl5smdnd5neyuqykpwkruq2onc32hq7jbgbylv33xq4rrsksvc@hk6u3b33iws3>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 17 Oct 2025 13:24:52 +0200
X-Gm-Features: AS18NWBv71y-SatjzdubxeYp6hydP8inIYv9GaNq-GJTrAdSXfR4kkda0zGrQJ0
Message-ID: <CADSE00+2PU0auFOMaSpgH3dgQ9UgYp+nsAusuQa=ZXbd=JLreQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/7] vhost-user: Add VirtIO Shared Memory map request
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 hi@alyssa.is, stefanha@redhat.com, david@redhat.com, jasowang@redhat.com, 
 dbassey@redhat.com, stevensd@chromium.org, 
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, slp@redhat.com, manos.pitsidianakis@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 17, 2025 at 11:23=E2=80=AFAM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
>
> On Thu, Oct 16, 2025 at 04:38:21PM +0200, Albert Esteve wrote:
> >Add SHMEM_MAP/UNMAP requests to vhost-user for dynamic management of
> >VIRTIO Shared Memory mappings.
> >
> >This implementation introduces VirtioSharedMemoryMapping as a unified
> >QOM object that manages both the mapping metadata and MemoryRegion
> >lifecycle. This object provides reference-counted lifecycle management
> >with automatic cleanup of file descriptors and memory regions
> >through QOM finalization.
> >
> >This request allows backends to dynamically map file descriptors into a
> >VIRTIO Shared Memory Region identified by their shmid. Maps are created
> >using memory_region_init_ram_from_fd() with configurable read/write
> >permissions, and the resulting MemoryRegions are added as subregions to
> >the shmem container region. The mapped memory is then advertised to the
> >guest VIRTIO drivers as a base address plus offset for reading and
> >writting according to the requested mmap flags.
> >
> >The backend can unmap memory ranges within a given VIRTIO Shared Memory
> >Region to free resources. Upon receiving this message, the frontend
> >removes the MemoryRegion as a subregion and automatically unreferences
> >the VirtioSharedMemoryMapping object, triggering cleanup if no other
> >references exist.
> >
> >Error handling has been improved to ensure consistent behavior across
> >handlers that manage their own vhost_user_send_resp() calls. Since
> >these handlers clear the VHOST_USER_NEED_REPLY_MASK flag, explicit
> >error checking ensures proper connection closure on failures,
> >maintaining the expected error flow.
> >
> >Note the memory region commit for these operations needs to be delayed
> >until after we reply to the backend to avoid deadlocks. Otherwise,
> >the MemoryListener would send a VHOST_USER_SET_MEM_TABLE message
> >before the reply.
> >
> >Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >Signed-off-by: Albert Esteve <aesteve@redhat.com>
> >---
> > hw/virtio/vhost-user.c                    | 267 ++++++++++++++++++++++
> > hw/virtio/virtio.c                        | 199 ++++++++++++++++
> > include/hw/virtio/virtio.h                | 135 +++++++++++
> > subprojects/libvhost-user/libvhost-user.c |  70 ++++++
> > subprojects/libvhost-user/libvhost-user.h |  54 +++++
> > 5 files changed, 725 insertions(+)
> >
> >diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> >index 36c9c2e04d..890be55937 100644
> >--- a/hw/virtio/vhost-user.c
> >+++ b/hw/virtio/vhost-user.c
> >@@ -104,6 +104,7 @@ typedef enum VhostUserRequest {
> >     VHOST_USER_GET_SHARED_OBJECT =3D 41,
> >     VHOST_USER_SET_DEVICE_STATE_FD =3D 42,
> >     VHOST_USER_CHECK_DEVICE_STATE =3D 43,
> >+    VHOST_USER_GET_SHMEM_CONFIG =3D 44,
> >     VHOST_USER_MAX
> > } VhostUserRequest;
> >
> >@@ -115,6 +116,8 @@ typedef enum VhostUserBackendRequest {
> >     VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,
> >     VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,
> >     VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
> >+    VHOST_USER_BACKEND_SHMEM_MAP =3D 9,
> >+    VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,
> >     VHOST_USER_BACKEND_MAX
> > }  VhostUserBackendRequest;
> >
> >@@ -136,6 +139,12 @@ typedef struct VhostUserMemRegMsg {
> >     VhostUserMemoryRegion region;
> > } VhostUserMemRegMsg;
> >
> >+typedef struct VhostUserShMemConfig {
> >+    uint32_t nregions;
> >+    uint32_t padding;
> >+    uint64_t memory_sizes[VIRTIO_MAX_SHMEM_REGIONS];
> >+} VhostUserShMemConfig;
> >+
> > typedef struct VhostUserLog {
> >     uint64_t mmap_size;
> >     uint64_t mmap_offset;
> >@@ -192,6 +201,23 @@ typedef struct VhostUserShared {
> >     unsigned char uuid[16];
> > } VhostUserShared;
> >
> >+/* For the flags field of VhostUserMMap */
> >+#define VHOST_USER_FLAG_MAP_RW (1u << 0)
> >+
> >+typedef struct {
> >+    /* VIRTIO Shared Memory Region ID */
> >+    uint8_t shmid;
> >+    uint8_t padding[7];
> >+    /* File offset */
> >+    uint64_t fd_offset;
> >+    /* Offset within the VIRTIO Shared Memory Region */
> >+    uint64_t shm_offset;
> >+    /* Size of the mapping */
> >+    uint64_t len;
> >+    /* Flags for the mmap operation, from VHOST_USER_FLAG_MAP_* */
> >+    uint64_t flags;
> >+} VhostUserMMap;
> >+
> > typedef struct {
> >     VhostUserRequest request;
> >
> >@@ -224,6 +250,8 @@ typedef union {
> >         VhostUserInflight inflight;
> >         VhostUserShared object;
> >         VhostUserTransferDeviceState transfer_state;
> >+        VhostUserMMap mmap;
> >+        VhostUserShMemConfig shmem;
> > } VhostUserPayload;
> >
> > typedef struct VhostUserMsg {
> >@@ -1768,6 +1796,196 @@ vhost_user_backend_handle_shared_object_lookup(s=
truct vhost_user *u,
> >     return 0;
> > }
> >
> >+/**
> >+ * vhost_user_backend_handle_shmem_map() - Handle SHMEM_MAP backend req=
uest
> >+ * @dev: vhost device
> >+ * @ioc: QIOChannel for communication
> >+ * @hdr: vhost-user message header
> >+ * @payload: message payload containing mapping details
> >+ * @fd: file descriptor for the shared memory region
> >+ *
> >+ * Handles VHOST_USER_BACKEND_SHMEM_MAP requests from the backend. Crea=
tes
> >+ * a VhostUserShmemObject to manage the shared memory mapping and adds =
it
> >+ * to the appropriate VirtIO shared memory region. The VhostUserShmemOb=
ject
> >+ * serves as an intermediate parent for the MemoryRegion, ensuring prop=
er
> >+ * lifecycle management with reference counting.
> >+ *
> >+ * Returns: 0 on success, negative errno on failure
> >+ */
> >+static int
> >+vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
> >+                                    QIOChannel *ioc,
> >+                                    VhostUserHeader *hdr,
> >+                                    VhostUserPayload *payload,
> >+                                    int fd)
> >+{
> >+    VirtioSharedMemory *shmem;
> >+    VhostUserMMap *vu_mmap =3D &payload->mmap;
> >+    VirtioSharedMemoryMapping *existing;
> >+    Error *local_err =3D NULL;
> >+    int ret =3D 0;
> >+
> >+    if (fd < 0) {
> >+        error_report("Bad fd for map");
> >+        ret =3D -EBADF;
> >+        goto send_reply;
> >+    }
> >+
> >+    if (QSIMPLEQ_EMPTY(&dev->vdev->shmem_list)) {
> >+        error_report("Device has no VIRTIO Shared Memory Regions. "
> >+                     "Requested ID: %d", vu_mmap->shmid);
> >+        ret =3D -EFAULT;
> >+        goto send_reply;
> >+    }
> >+
> >+    shmem =3D virtio_find_shmem_region(dev->vdev, vu_mmap->shmid);
> >+    if (!shmem) {
> >+        error_report("VIRTIO Shared Memory Region at "
> >+                     "ID %d not found or uninitialized", vu_mmap->shmid=
);
> >+        ret =3D -EFAULT;
> >+        goto send_reply;
> >+    }
> >+
> >+    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> >+        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr.size) {
> >+        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
> >+                     vu_mmap->shm_offset, vu_mmap->len);
> >+        ret =3D -EFAULT;
> >+        goto send_reply;
> >+    }
> >+
> >+    QTAILQ_FOREACH(existing, &shmem->mmaps, link) {
> >+        if (ranges_overlap(existing->offset, existing->len,
> >+                           vu_mmap->shm_offset, vu_mmap->len)) {
> >+            error_report("VIRTIO Shared Memory mapping overlap");
> >+            ret =3D -EFAULT;
> >+            goto send_reply;
> >+        }
> >+    }
> >+
> >+    memory_region_transaction_begin();
> >+
> >+    /* Create VirtioSharedMemoryMapping object */
> >+    VirtioSharedMemoryMapping *mapping =3D virtio_shared_memory_mapping=
_new(
> >+        vu_mmap->shmid, fd, vu_mmap->fd_offset, vu_mmap->shm_offset,
> >+        vu_mmap->len, vu_mmap->flags & VHOST_USER_FLAG_MAP_RW);
> >+
> >+    if (!mapping) {
> >+        ret =3D -EFAULT;
> >+        goto send_reply_commit;
> >+    }
> >+
> >+    /* Add the mapping to the shared memory region */
> >+    if (virtio_add_shmem_map(shmem, mapping) !=3D 0) {
> >+        error_report("Failed to add shared memory mapping");
> >+        object_unref(OBJECT(mapping));
> >+        ret =3D -EFAULT;
> >+        goto send_reply_commit;
> >+    }
> >+
> >+send_reply_commit:
> >+    /* Send reply and commit after transaction started */
> >+    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> >+        payload->u64 =3D !!ret;
> >+        hdr->size =3D sizeof(payload->u64);
> >+        if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)) {
> >+            error_report_err(local_err);
> >+            memory_region_transaction_commit();
> >+            return -EFAULT;
> >+        }
> >+    }
> >+    memory_region_transaction_commit();
>
> Sorry to be late, I did a quick review, my only doubts is here, maybe it
> was already discussed, but why do we commit after responding to the
> backend?
>
> Should we do it first to prevent the backend from =E2=80=9Cseeing=E2=80=
=9D something
> that hasn't been committed yet?

There is a race that leads to a deadlock. hw/virtio/vhost.c has a
MemoryListener that sends VHOST_USER_SET_MEM_TABLE messages in its
.commit() callback. If this happens before the reply, the backend will
not process it as it is stuck waiting for the SHMEM reply, and the
handler in qemu will not send it as it is waiting for the reply to the
SET_MEM_TABLE. So we have to delay the transaction commit to
immediately after the reply.

>
> Also, if vhost_user_send_resp() fails, should we call
> virtio_del_shmem_map()?

If vhost_user_send_resp() fails, the connection with the backend is
closed, so the mappings will indeed never be removed unless we reset.

Maybe better than removing the single mapping, would be to loop
through mappings in the shared memory and clean them all (same we do :

```
        while (!QTAILQ_EMPTY(&shmem->mmaps)) {
            VirtioSharedMemoryMapping *mapping =3D QTAILQ_FIRST(&shmem->mma=
ps);
            virtio_del_shmem_map(shmem, mapping->offset, mapping->mr->size)=
;
        }
```

But since a backend may utilize more than one shared memory region,
and we do not know the mapping between a given backend and its shared
memories, whatever we do will be incomplete (?). I think the only
solution after this happens is to reset (virtio_reset) to remove all
mappings from the all shared regions, and re-establish the backend
channel (is it possible?). Even if the channel cannot be restablished,
I wouldn't bother just removing one mapping, I would assume it needs a
reset.

>
> Thanks,
> Stefano
>
> >+    return 0;
> >+
> >+send_reply:
> >+    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> >+        payload->u64 =3D !!ret;
> >+        hdr->size =3D sizeof(payload->u64);
> >+        if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)) {
> >+            error_report_err(local_err);
> >+            return -EFAULT;
> >+        }
> >+    }
> >+    return 0;
> >+}
> >+
> >+/**
> >+ * vhost_user_backend_handle_shmem_unmap() - Handle SHMEM_UNMAP backend=
 request
> >+ * @dev: vhost device
> >+ * @ioc: QIOChannel for communication
> >+ * @hdr: vhost-user message header
> >+ * @payload: message payload containing unmapping details
> >+ *
> >+ * Handles VHOST_USER_BACKEND_SHMEM_UNMAP requests from the backend. Re=
moves
> >+ * the specified memory mapping from the VirtIO shared memory region. T=
his
> >+ * automatically unreferences the associated VhostUserShmemObject, whic=
h may
> >+ * trigger its finalization and cleanup (munmap, close fd) if no other
> >+ * references exist.
> >+ *
> >+ * Returns: 0 on success, negative errno on failure
> >+ */
> >+static int
> >+vhost_user_backend_handle_shmem_unmap(struct vhost_dev *dev,
> >+                                      QIOChannel *ioc,
> >+                                      VhostUserHeader *hdr,
> >+                                      VhostUserPayload *payload)
> >+{
> >+    VirtioSharedMemory *shmem;
> >+    VirtioSharedMemoryMapping *mmap =3D NULL;
> >+    VhostUserMMap *vu_mmap =3D &payload->mmap;
> >+    Error *local_err =3D NULL;
> >+    int ret =3D 0;
> >+
> >+    if (QSIMPLEQ_EMPTY(&dev->vdev->shmem_list)) {
> >+        error_report("Device has no VIRTIO Shared Memory Regions. "
> >+                     "Requested ID: %d", vu_mmap->shmid);
> >+        ret =3D -EFAULT;
> >+        goto send_reply;
> >+    }
> >+
> >+    shmem =3D virtio_find_shmem_region(dev->vdev, vu_mmap->shmid);
> >+    if (!shmem) {
> >+        error_report("VIRTIO Shared Memory Region at "
> >+                     "ID %d not found or uninitialized", vu_mmap->shmid=
);
> >+        ret =3D -EFAULT;
> >+        goto send_reply;
> >+    }
> >+
> >+    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> >+        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr.size) {
> >+        error_report("Bad offset/len for unmmap %" PRIx64 "+%" PRIx64,
> >+                     vu_mmap->shm_offset, vu_mmap->len);
> >+        ret =3D -EFAULT;
> >+        goto send_reply;
> >+    }
> >+
> >+    mmap =3D virtio_find_shmem_map(shmem, vu_mmap->shm_offset, vu_mmap-=
>len);
> >+    if (!mmap) {
> >+        error_report("Shared memory mapping not found at offset %" PRIx=
64
> >+                     " with length %" PRIx64,
> >+                     vu_mmap->shm_offset, vu_mmap->len);
> >+        ret =3D -EFAULT;
> >+        goto send_reply;
> >+    }
> >+
> >+send_reply:
> >+    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> >+        payload->u64 =3D !!ret;
> >+        hdr->size =3D sizeof(payload->u64);
> >+        if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)) {
> >+            error_report_err(local_err);
> >+            return -EFAULT;
> >+        }
> >+    }
> >+
> >+    if (!ret && mmap) {
> >+        /* Free the MemoryRegion only after reply */
> >+        virtio_del_shmem_map(shmem, vu_mmap->shm_offset, vu_mmap->len);
> >+    }
> >+
> >+    return 0;
> >+}
> >+
> > static void close_backend_channel(struct vhost_user *u)
> > {
> >     g_source_destroy(u->backend_src);
> >@@ -1836,6 +2054,19 @@ static gboolean backend_read(QIOChannel *ioc, GIO=
Condition condition,
> >         ret =3D vhost_user_backend_handle_shared_object_lookup(dev->opa=
que, ioc,
> >                                                              &hdr, &pay=
load);
> >         break;
> >+    case VHOST_USER_BACKEND_SHMEM_MAP:
> >+        /* Handler manages its own response, check error and close conn=
ection */
> >+        if (vhost_user_backend_handle_shmem_map(dev, ioc, &hdr, &payloa=
d,
> >+                                                fd ? fd[0] : -1) < 0) {
> >+            goto err;
> >+        }
> >+        break;
> >+    case VHOST_USER_BACKEND_SHMEM_UNMAP:
> >+        /* Handler manages its own response, check error and close conn=
ection */
> >+        if (vhost_user_backend_handle_shmem_unmap(dev, ioc, &hdr, &payl=
oad) < 0) {
> >+            goto err;
> >+        }
> >+        break;
> >     default:
> >         error_report("Received unexpected msg type: %d.", hdr.request);
> >         ret =3D -EINVAL;
> >@@ -3013,6 +3244,41 @@ static int vhost_user_check_device_state(struct v=
host_dev *dev, Error **errp)
> >     return 0;
> > }
> >
> >+static int vhost_user_get_shmem_config(struct vhost_dev *dev,
> >+                                       int *nregions,
> >+                                       uint64_t *memory_sizes,
> >+                                       Error **errp)
> >+{
> >+    int ret;
> >+    VhostUserMsg msg =3D {
> >+        .hdr.request =3D VHOST_USER_GET_SHMEM_CONFIG,
> >+        .hdr.flags =3D VHOST_USER_VERSION,
> >+    };
> >+
> >+    if (!virtio_has_feature(dev->protocol_features,
> >+                            VHOST_USER_PROTOCOL_F_SHMEM)) {
> >+        *nregions =3D 0;
> >+        return 0;
> >+    }
> >+
> >+    ret =3D vhost_user_write(dev, &msg, NULL, 0);
> >+    if (ret < 0) {
> >+        return ret;
> >+    }
> >+
> >+    ret =3D vhost_user_read(dev, &msg);
> >+    if (ret < 0) {
> >+        return ret;
> >+    }
> >+
> >+    assert(msg.payload.shmem.nregions <=3D VIRTIO_MAX_SHMEM_REGIONS);
> >+    *nregions =3D msg.payload.shmem.nregions;
> >+    memcpy(memory_sizes,
> >+           &msg.payload.shmem.memory_sizes,
> >+           sizeof(uint64_t) * VIRTIO_MAX_SHMEM_REGIONS);
> >+    return 0;
> >+}
> >+
> > const VhostOps user_ops =3D {
> >         .backend_type =3D VHOST_BACKEND_TYPE_USER,
> >         .vhost_backend_init =3D vhost_user_backend_init,
> >@@ -3051,4 +3317,5 @@ const VhostOps user_ops =3D {
> >         .vhost_supports_device_state =3D vhost_user_supports_device_sta=
te,
> >         .vhost_set_device_state_fd =3D vhost_user_set_device_state_fd,
> >         .vhost_check_device_state =3D vhost_user_check_device_state,
> >+        .vhost_get_shmem_config =3D vhost_user_get_shmem_config,
> > };
> >diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >index 153ee0a0cf..f96ed43c18 100644
> >--- a/hw/virtio/virtio.c
> >+++ b/hw/virtio/virtio.c
> >@@ -3086,6 +3086,173 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
> >     return vmstate_save_state(f, &vmstate_virtio, vdev, NULL, &error_fa=
tal);
> > }
> >
> >+VirtioSharedMemory *virtio_new_shmem_region(VirtIODevice *vdev, uint8_t=
 shmid, uint64_t size)
> >+{
> >+    VirtioSharedMemory *elem;
> >+    g_autofree char *name =3D NULL;
> >+
> >+    elem =3D g_new0(VirtioSharedMemory, 1);
> >+    elem->shmid =3D shmid;
> >+
> >+    /* Initialize embedded MemoryRegion as container for shmem mappings=
 */
> >+    name =3D g_strdup_printf("virtio-shmem-%d", shmid);
> >+    memory_region_init(&elem->mr, OBJECT(vdev), name, size);
> >+    QTAILQ_INIT(&elem->mmaps);
> >+    QSIMPLEQ_INSERT_TAIL(&vdev->shmem_list, elem, entry);
> >+    return elem;
> >+}
> >+
> >+VirtioSharedMemory *virtio_find_shmem_region(VirtIODevice *vdev, uint8_=
t shmid)
> >+{
> >+    VirtioSharedMemory *shmem, *next;
> >+    QSIMPLEQ_FOREACH_SAFE(shmem, &vdev->shmem_list, entry, next) {
> >+        if (shmem->shmid =3D=3D shmid) {
> >+            return shmem;
> >+        }
> >+    }
> >+    return NULL;
> >+}
> >+
> >+static void virtio_shared_memory_mapping_instance_init(Object *obj)
> >+{
> >+    VirtioSharedMemoryMapping *mapping =3D VIRTIO_SHARED_MEMORY_MAPPING=
(obj);
> >+
> >+    mapping->shmid =3D 0;
> >+    mapping->offset =3D 0;
> >+    mapping->len =3D 0;
> >+    mapping->mr =3D NULL;
> >+}
> >+
> >+static void virtio_shared_memory_mapping_instance_finalize(Object *obj)
> >+{
> >+    VirtioSharedMemoryMapping *mapping =3D VIRTIO_SHARED_MEMORY_MAPPING=
(obj);
> >+
> >+    /* Clean up MemoryRegion if it exists */
> >+    if (mapping->mr) {
> >+        /* Unparent the MemoryRegion to trigger cleanup */
> >+        object_unparent(OBJECT(mapping->mr));
> >+        mapping->mr =3D NULL;
> >+    }
> >+}
> >+
> >+VirtioSharedMemoryMapping *virtio_shared_memory_mapping_new(uint8_t shm=
id,
> >+                                                            int fd,
> >+                                                            uint64_t fd=
_offset,
> >+                                                            uint64_t sh=
m_offset,
> >+                                                            uint64_t le=
n,
> >+                                                            bool allow_=
write)
> >+{
> >+    VirtioSharedMemoryMapping *mapping;
> >+    MemoryRegion *mr;
> >+    g_autoptr(GString) mr_name =3D g_string_new(NULL);
> >+    uint32_t ram_flags;
> >+    Error *local_err =3D NULL;
> >+
> >+    if (len =3D=3D 0) {
> >+        error_report("Shared memory mapping size cannot be zero");
> >+        return NULL;
> >+    }
> >+
> >+    fd =3D dup(fd);
> >+    if (fd < 0) {
> >+        error_report("Failed to duplicate fd: %s", strerror(errno));
> >+        return NULL;
> >+    }
> >+
> >+    /* Determine RAM flags */
> >+    ram_flags =3D RAM_SHARED;
> >+    if (!allow_write) {
> >+        ram_flags |=3D RAM_READONLY_FD;
> >+    }
> >+
> >+    /* Create the VirtioSharedMemoryMapping */
> >+    mapping =3D VIRTIO_SHARED_MEMORY_MAPPING(
> >+        object_new(TYPE_VIRTIO_SHARED_MEMORY_MAPPING));
> >+
> >+    /* Set up object properties */
> >+    mapping->shmid =3D shmid;
> >+    mapping->offset =3D shm_offset;
> >+    mapping->len =3D len;
> >+
> >+    /* Create MemoryRegion as a child of this object */
> >+    mr =3D g_new0(MemoryRegion, 1);
> >+    g_string_printf(mr_name, "virtio-shmem-%d-%" PRIx64, shmid, shm_off=
set);
> >+
> >+    /* Initialize MemoryRegion with file descriptor */
> >+    if (!memory_region_init_ram_from_fd(mr, OBJECT(mapping), mr_name->s=
tr,
> >+                                        len, ram_flags, fd, fd_offset,
> >+                                        &local_err)) {
> >+        error_report_err(local_err);
> >+        g_free(mr);
> >+        close(fd);
> >+        object_unref(OBJECT(mapping));
> >+        return NULL;
> >+    }
> >+
> >+    mapping->mr =3D mr;
> >+    return mapping;
> >+}
> >+
> >+int virtio_add_shmem_map(VirtioSharedMemory *shmem,
> >+                         VirtioSharedMemoryMapping *mapping)
> >+{
> >+    if (!mapping) {
> >+        error_report("VirtioSharedMemoryMapping cannot be NULL");
> >+        return -1;
> >+    }
> >+    if (!mapping->mr) {
> >+        error_report("VirtioSharedMemoryMapping has no MemoryRegion");
> >+        return -1;
> >+    }
> >+
> >+    /* Validate boundaries against the VIRTIO shared memory region */
> >+    if (mapping->offset + mapping->len > shmem->mr.size) {
> >+        error_report("Memory exceeds the shared memory boundaries");
> >+        return -1;
> >+    }
> >+
> >+    /* Add as subregion to the VIRTIO shared memory */
> >+    memory_region_add_subregion(&shmem->mr, mapping->offset, mapping->m=
r);
> >+
> >+    /* Add to the mapped regions list */
> >+    QTAILQ_INSERT_TAIL(&shmem->mmaps, mapping, link);
> >+
> >+    return 0;
> >+}
> >+
> >+VirtioSharedMemoryMapping *virtio_find_shmem_map(VirtioSharedMemory *sh=
mem,
> >+                                          hwaddr offset, uint64_t size)
> >+{
> >+    VirtioSharedMemoryMapping *mapping;
> >+    QTAILQ_FOREACH(mapping, &shmem->mmaps, link) {
> >+        if (mapping->offset =3D=3D offset && mapping->mr->size =3D=3D s=
ize) {
> >+            return mapping;
> >+        }
> >+    }
> >+    return NULL;
> >+}
> >+
> >+void virtio_del_shmem_map(VirtioSharedMemory *shmem, hwaddr offset,
> >+                          uint64_t size)
> >+{
> >+    VirtioSharedMemoryMapping *mapping =3D virtio_find_shmem_map(shmem,=
 offset, size);
> >+    if (mapping =3D=3D NULL) {
> >+        return;
> >+    }
> >+
> >+    /*
> >+     * Remove from memory region first
> >+     */
> >+    memory_region_del_subregion(&shmem->mr, mapping->mr);
> >+
> >+    /*
> >+     * Remove from list and unref the mapping which will trigger automa=
tic cleanup
> >+     * when the reference count reaches zero.
> >+     */
> >+    QTAILQ_REMOVE(&shmem->mmaps, mapping, link);
> >+    object_unref(OBJECT(mapping));
> >+}
> >+
> > /* A wrapper for use as a VMState .put function */
> > static int virtio_device_put(QEMUFile *f, void *opaque, size_t size,
> >                               const VMStateField *field, JSONWriter *vm=
desc)
> >@@ -3212,6 +3379,7 @@ void virtio_reset(void *opaque)
> > {
> >     VirtIODevice *vdev =3D opaque;
> >     VirtioDeviceClass *k =3D VIRTIO_DEVICE_GET_CLASS(vdev);
> >+    VirtioSharedMemory *shmem;
> >     uint64_t features[VIRTIO_FEATURES_NU64S];
> >     int i;
> >
> >@@ -3251,6 +3419,14 @@ void virtio_reset(void *opaque)
> >     for (i =3D 0; i < VIRTIO_QUEUE_MAX; i++) {
> >         __virtio_queue_reset(vdev, i);
> >     }
> >+
> >+    /* Mappings are removed to prevent stale fds from remaining open. *=
/
> >+    QSIMPLEQ_FOREACH(shmem, &vdev->shmem_list, entry) {
> >+        while (!QTAILQ_EMPTY(&shmem->mmaps)) {
> >+            VirtioSharedMemoryMapping *mapping =3D QTAILQ_FIRST(&shmem-=
>mmaps);
> >+            virtio_del_shmem_map(shmem, mapping->offset, mapping->mr->s=
ize);
> >+        }
> >+    }
> > }
> >
> > static void virtio_device_check_notification_compatibility(VirtIODevice=
 *vdev,
> >@@ -3574,6 +3750,7 @@ void virtio_init(VirtIODevice *vdev, uint16_t devi=
ce_id, size_t config_size)
> >             NULL, virtio_vmstate_change, vdev);
> >     vdev->device_endian =3D virtio_default_endian();
> >     vdev->use_guest_notifier_mask =3D true;
> >+    QSIMPLEQ_INIT(&vdev->shmem_list);
> > }
> >
> > /*
> >@@ -4085,11 +4262,24 @@ static void virtio_device_free_virtqueues(VirtIO=
Device *vdev)
> > static void virtio_device_instance_finalize(Object *obj)
> > {
> >     VirtIODevice *vdev =3D VIRTIO_DEVICE(obj);
> >+    VirtioSharedMemory *shmem;
> >
> >     virtio_device_free_virtqueues(vdev);
> >
> >     g_free(vdev->config);
> >     g_free(vdev->vector_queues);
> >+    while (!QSIMPLEQ_EMPTY(&vdev->shmem_list)) {
> >+        shmem =3D QSIMPLEQ_FIRST(&vdev->shmem_list);
> >+        while (!QTAILQ_EMPTY(&shmem->mmaps)) {
> >+            VirtioSharedMemoryMapping *mapping =3D QTAILQ_FIRST(&shmem-=
>mmaps);
> >+            virtio_del_shmem_map(shmem, mapping->offset, mapping->mr->s=
ize);
> >+        }
> >+
> >+        /* Clean up the embedded MemoryRegion */
> >+        object_unparent(OBJECT(&shmem->mr));
> >+        QSIMPLEQ_REMOVE_HEAD(&vdev->shmem_list, entry);
> >+        g_free(shmem);
> >+    }
> > }
> >
> > static const Property virtio_properties[] =3D {
> >@@ -4455,9 +4645,18 @@ static const TypeInfo virtio_device_info =3D {
> >     .class_size =3D sizeof(VirtioDeviceClass),
> > };
> >
> >+static const TypeInfo virtio_shared_memory_mapping_info =3D {
> >+    .name =3D TYPE_VIRTIO_SHARED_MEMORY_MAPPING,
> >+    .parent =3D TYPE_OBJECT,
> >+    .instance_size =3D sizeof(VirtioSharedMemoryMapping),
> >+    .instance_init =3D virtio_shared_memory_mapping_instance_init,
> >+    .instance_finalize =3D virtio_shared_memory_mapping_instance_finali=
ze,
> >+};
> >+
> > static void virtio_register_types(void)
> > {
> >     type_register_static(&virtio_device_info);
> >+    type_register_static(&virtio_shared_memory_mapping_info);
> > }
> >
> > type_init(virtio_register_types)
> >diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> >index d97529c3f1..3f6dfba321 100644
> >--- a/include/hw/virtio/virtio.h
> >+++ b/include/hw/virtio/virtio.h
> >@@ -99,6 +99,45 @@ enum virtio_device_endian {
> >     VIRTIO_DEVICE_ENDIAN_BIG,
> > };
> >
> >+#define TYPE_VIRTIO_SHARED_MEMORY_MAPPING "virtio-shared-memory-mapping=
"
> >+OBJECT_DECLARE_SIMPLE_TYPE(VirtioSharedMemoryMapping, VIRTIO_SHARED_MEM=
ORY_MAPPING)
> >+
> >+/**
> >+ * VirtioSharedMemoryMapping:
> >+ * @parent: Parent QOM object
> >+ * @shmid: VIRTIO Shared Memory Region ID
> >+ * @fd: File descriptor for the shared memory region
> >+ * @offset: Offset within the VIRTIO Shared Memory Region
> >+ * @len: Size of the mapping
> >+ * @mr: MemoryRegion associated with this shared memory mapping
> >+ * @link: List entry for the shared memory region's mapping list
> >+ *
> >+ * A QOM object that represents an individual file descriptor-based sha=
red
> >+ * memory mapping within a VIRTIO Shared Memory Region. It manages the
> >+ * MemoryRegion lifecycle and file descriptor cleanup through QOM refer=
ence
> >+ * counting. When the object is unreferenced and its reference count dr=
ops
> >+ * to zero, it automatically cleans up the MemoryRegion and closes the =
file
> >+ * descriptor.
> >+ */
> >+struct VirtioSharedMemoryMapping {
> >+    Object parent;
> >+
> >+    uint8_t shmid;
> >+    hwaddr offset;
> >+    uint64_t len;
> >+    MemoryRegion *mr;
> >+    QTAILQ_ENTRY(VirtioSharedMemoryMapping) link;
> >+};
> >+
> >+struct VirtioSharedMemory {
> >+    uint8_t shmid;
> >+    MemoryRegion mr;
> >+    QTAILQ_HEAD(, VirtioSharedMemoryMapping) mmaps;
> >+    QSIMPLEQ_ENTRY(VirtioSharedMemory) entry;
> >+};
> >+
> >+typedef struct VirtioSharedMemory VirtioSharedMemory;
> >+
> > /**
> >  * struct VirtIODevice - common VirtIO structure
> >  * @name: name of the device
> >@@ -168,6 +207,8 @@ struct VirtIODevice
> >      */
> >     EventNotifier config_notifier;
> >     bool device_iotlb_enabled;
> >+    /* Shared memory region for mappings. */
> >+    QSIMPLEQ_HEAD(, VirtioSharedMemory) shmem_list;
> > };
> >
> > struct VirtioDeviceClass {
> >@@ -298,6 +339,100 @@ void virtio_notify(VirtIODevice *vdev, VirtQueue *=
vq);
> >
> > int virtio_save(VirtIODevice *vdev, QEMUFile *f);
> >
> >+/**
> >+ * virtio_new_shmem_region() - Create a new shared memory region
> >+ * @vdev: VirtIODevice
> >+ * @shmid: Shared memory ID
> >+ * @size: Size of the shared memory region
> >+ *
> >+ * Creates a new VirtioSharedMemory region for the given device and ID.
> >+ * The returned VirtioSharedMemory is owned by the VirtIODevice and wil=
l
> >+ * be automatically freed when the device is destroyed. The caller
> >+ * should not free the returned pointer.
> >+ *
> >+ * Returns: Pointer to the new VirtioSharedMemory region, or NULL on fa=
ilure
> >+ */
> >+VirtioSharedMemory *virtio_new_shmem_region(VirtIODevice *vdev, uint8_t=
 shmid, uint64_t size);
> >+
> >+/**
> >+ * virtio_find_shmem_region() - Find an existing shared memory region
> >+ * @vdev: VirtIODevice
> >+ * @shmid: Shared memory ID to find
> >+ *
> >+ * Finds an existing VirtioSharedMemory region by ID. The returned poin=
ter
> >+ * is owned by the VirtIODevice and should not be freed by the caller.
> >+ *
> >+ * Returns: Pointer to the VirtioSharedMemory region, or NULL if not fo=
und
> >+ */
> >+VirtioSharedMemory *virtio_find_shmem_region(VirtIODevice *vdev, uint8_=
t shmid);
> >+
> >+/**
> >+ * virtio_shared_memory_mapping_new() - Create a new VirtioSharedMemory=
Mapping
> >+ * @shmid: VIRTIO Shared Memory Region ID
> >+ * @fd: File descriptor for the shared memory
> >+ * @fd_offset: Offset within the file descriptor
> >+ * @shm_offset: Offset within the VIRTIO Shared Memory Region
> >+ * @len: Size of the mapping
> >+ * @allow_write: Whether to allow write access to the mapping
> >+ *
> >+ * Creates a new VirtioSharedMemoryMapping that manages a shared memory=
 mapping.
> >+ * The object will create a MemoryRegion using memory_region_init_ram_f=
rom_fd()
> >+ * as a child object. When the object is finalized, it will automatical=
ly
> >+ * clean up the MemoryRegion and close the file descriptor.
> >+ *
> >+ * Return: A new VirtioSharedMemoryMapping on success, NULL on error.
> >+ */
> >+VirtioSharedMemoryMapping *virtio_shared_memory_mapping_new(uint8_t shm=
id,
> >+                                                            int fd,
> >+                                                            uint64_t fd=
_offset,
> >+                                                            uint64_t sh=
m_offset,
> >+                                                            uint64_t le=
n,
> >+                                                            bool allow_=
write);
> >+
> >+/**
> >+ * virtio_add_shmem_map() - Add a memory mapping to a shared region
> >+ * @shmem: VirtioSharedMemory region
> >+ * @mapping: VirtioSharedMemoryMapping to add (transfers ownership)
> >+ *
> >+ * Adds a memory mapping to the shared memory region. The VirtioSharedM=
emoryMapping
> >+ * ownership is transferred to the shared memory region and will be aut=
omatically
> >+ * cleaned up through QOM reference counting when virtio_del_shmem_map(=
) is
> >+ * called or when the shared memory region is destroyed.
> >+ *
> >+ * Returns: 0 on success, negative errno on failure
> >+ */
> >+int virtio_add_shmem_map(VirtioSharedMemory *shmem,
> >+                         VirtioSharedMemoryMapping *mapping);
> >+
> >+/**
> >+ * virtio_find_shmem_map() - Find a memory mapping in a shared region
> >+ * @shmem: VirtioSharedMemory region
> >+ * @offset: Offset within the shared memory region
> >+ * @size: Size of the mapping to find
> >+ *
> >+ * Finds an existing memory mapping that covers the specified range.
> >+ * The returned VirtioSharedMemoryMapping is owned by the VirtioSharedM=
emory
> >+ * region and should not be freed by the caller.
> >+ *
> >+ * Returns: Pointer to the VirtioSharedMemoryMapping, or NULL if not fo=
und
> >+ */
> >+VirtioSharedMemoryMapping *virtio_find_shmem_map(VirtioSharedMemory *sh=
mem,
> >+                                          hwaddr offset, uint64_t size)=
;
> >+
> >+/**
> >+ * virtio_del_shmem_map() - Remove a memory mapping from a shared regio=
n
> >+ * @shmem: VirtioSharedMemory region
> >+ * @offset: Offset of the mapping to remove
> >+ * @size: Size of the mapping to remove
> >+ *
> >+ * Removes a memory mapping from the shared memory region. This will
> >+ * automatically unref the associated VhostUserShmemObject, which may
> >+ * trigger its finalization and cleanup if no other references exist.
> >+ * The mapping's MemoryRegion will be properly unmapped and cleaned up.
> >+ */
> >+void virtio_del_shmem_map(VirtioSharedMemory *shmem, hwaddr offset,
> >+                          uint64_t size);
> >+
> > extern const VMStateInfo virtio_vmstate_info;
> >
> > #define VMSTATE_VIRTIO_DEVICE \
> >diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/lib=
vhost-user/libvhost-user.c
> >index 9c630c2170..034cbfdc3c 100644
> >--- a/subprojects/libvhost-user/libvhost-user.c
> >+++ b/subprojects/libvhost-user/libvhost-user.c
> >@@ -1592,6 +1592,76 @@ vu_rm_shared_object(VuDev *dev, unsigned char uui=
d[UUID_LEN])
> >     return vu_send_message(dev, &msg);
> > }
> >
> >+bool
> >+vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
> >+             uint64_t shm_offset, uint64_t len, uint64_t flags, int fd)
> >+{
> >+    VhostUserMsg vmsg =3D {
> >+        .request =3D VHOST_USER_BACKEND_SHMEM_MAP,
> >+        .size =3D sizeof(vmsg.payload.mmap),
> >+        .flags =3D VHOST_USER_VERSION,
> >+        .payload.mmap =3D {
> >+            .shmid =3D shmid,
> >+            .fd_offset =3D fd_offset,
> >+            .shm_offset =3D shm_offset,
> >+            .len =3D len,
> >+            .flags =3D flags,
> >+        },
> >+        .fd_num =3D 1,
> >+        .fds[0] =3D fd,
> >+    };
> >+
> >+    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SHMEM)) {
> >+        return false;
> >+    }
> >+
> >+    if (vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK)) =
{
> >+        vmsg.flags |=3D VHOST_USER_NEED_REPLY_MASK;
> >+    }
> >+
> >+    pthread_mutex_lock(&dev->backend_mutex);
> >+    if (!vu_message_write(dev, dev->backend_fd, &vmsg)) {
> >+        pthread_mutex_unlock(&dev->backend_mutex);
> >+        return false;
> >+    }
> >+
> >+    /* Also unlocks the backend_mutex */
> >+    return vu_process_message_reply(dev, &vmsg);
> >+}
> >+
> >+bool
> >+vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t shm_offset, uint64_t=
 len)
> >+{
> >+    VhostUserMsg vmsg =3D {
> >+        .request =3D VHOST_USER_BACKEND_SHMEM_UNMAP,
> >+        .size =3D sizeof(vmsg.payload.mmap),
> >+        .flags =3D VHOST_USER_VERSION,
> >+        .payload.mmap =3D {
> >+            .shmid =3D shmid,
> >+            .fd_offset =3D 0,
> >+            .shm_offset =3D shm_offset,
> >+            .len =3D len,
> >+        },
> >+    };
> >+
> >+    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SHMEM)) {
> >+        return false;
> >+    }
> >+
> >+    if (vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK)) =
{
> >+        vmsg.flags |=3D VHOST_USER_NEED_REPLY_MASK;
> >+    }
> >+
> >+    pthread_mutex_lock(&dev->backend_mutex);
> >+    if (!vu_message_write(dev, dev->backend_fd, &vmsg)) {
> >+        pthread_mutex_unlock(&dev->backend_mutex);
> >+        return false;
> >+    }
> >+
> >+    /* Also unlocks the backend_mutex */
> >+    return vu_process_message_reply(dev, &vmsg);
> >+}
> >+
> > static bool
> > vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
> > {
> >diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/lib=
vhost-user/libvhost-user.h
> >index 2ffc58c11b..6a2d0f9fae 100644
> >--- a/subprojects/libvhost-user/libvhost-user.h
> >+++ b/subprojects/libvhost-user/libvhost-user.h
> >@@ -69,6 +69,8 @@ enum VhostUserProtocolFeature {
> >     /* Feature 16 is reserved for VHOST_USER_PROTOCOL_F_STATUS. */
> >     /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
> >     VHOST_USER_PROTOCOL_F_SHARED_OBJECT =3D 18,
> >+    /* Feature 19 is reserved for VHOST_USER_PROTOCOL_F_DEVICE_STATE */
> >+    VHOST_USER_PROTOCOL_F_SHMEM =3D 20,
> >     VHOST_USER_PROTOCOL_F_MAX
> > };
> >
> >@@ -127,6 +129,8 @@ typedef enum VhostUserBackendRequest {
> >     VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,
> >     VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,
> >     VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
> >+    VHOST_USER_BACKEND_SHMEM_MAP =3D 9,
> >+    VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,
> >     VHOST_USER_BACKEND_MAX
> > }  VhostUserBackendRequest;
> >
> >@@ -186,6 +190,23 @@ typedef struct VhostUserShared {
> >     unsigned char uuid[UUID_LEN];
> > } VhostUserShared;
> >
> >+/* For the flags field of VhostUserMMap */
> >+#define VHOST_USER_FLAG_MAP_RW (1u << 0)
> >+
> >+typedef struct {
> >+    /* VIRTIO Shared Memory Region ID */
> >+    uint8_t shmid;
> >+    uint8_t padding[7];
> >+    /* File offset */
> >+    uint64_t fd_offset;
> >+    /* Offset within the VIRTIO Shared Memory Region */
> >+    uint64_t shm_offset;
> >+    /* Size of the mapping */
> >+    uint64_t len;
> >+    /* Flags for the mmap operation, from VHOST_USER_FLAG_MAP_* */
> >+    uint64_t flags;
> >+} VhostUserMMap;
> >+
> > #define VU_PACKED __attribute__((packed))
> >
> > typedef struct VhostUserMsg {
> >@@ -210,6 +231,7 @@ typedef struct VhostUserMsg {
> >         VhostUserVringArea area;
> >         VhostUserInflight inflight;
> >         VhostUserShared object;
> >+        VhostUserMMap mmap;
> >     } payload;
> >
> >     int fds[VHOST_MEMORY_BASELINE_NREGIONS];
> >@@ -593,6 +615,38 @@ bool vu_add_shared_object(VuDev *dev, unsigned char=
 uuid[UUID_LEN]);
> >  */
> > bool vu_rm_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN]);
> >
> >+/**
> >+ * vu_shmem_map:
> >+ * @dev: a VuDev context
> >+ * @shmid: VIRTIO Shared Memory Region ID
> >+ * @fd_offset: File offset
> >+ * @shm_offset: Offset within the VIRTIO Shared Memory Region
> >+ * @len: Size of the mapping
> >+ * @flags: Flags for the mmap operation
> >+ * @fd: A file descriptor
> >+ *
> >+ * Advertises a new mapping to be made in a given VIRTIO Shared Memory =
Region.
> >+ *
> >+ * Returns: TRUE on success, FALSE on failure.
> >+ */
> >+bool vu_shmem_map(VuDev *dev, uint8_t shmid, uint64_t fd_offset,
> >+                  uint64_t shm_offset, uint64_t len, uint64_t flags, in=
t fd);
> >+
> >+/**
> >+ * vu_shmem_unmap:
> >+ * @dev: a VuDev context
> >+ * @shmid: VIRTIO Shared Memory Region ID
> >+ * @fd_offset: File offset
> >+ * @len: Size of the mapping
> >+ *
> >+ * The front-end un-mmaps a given range in the VIRTIO Shared Memory Reg=
ion
> >+ * with the requested `shmid`.
> >+ *
> >+ * Returns: TRUE on success, FALSE on failure.
> >+ */
> >+bool vu_shmem_unmap(VuDev *dev, uint8_t shmid, uint64_t shm_offset,
> >+                    uint64_t len);
> >+
> > /**
> >  * vu_queue_set_notification:
> >  * @dev: a VuDev context
> >--
> >2.49.0
> >
>


