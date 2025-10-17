Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0685CCCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 12:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9jgu-0006gx-TJ; Fri, 17 Oct 2025 08:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v9jgr-0006fX-R5
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 08:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v9jgj-0008DN-2W
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 08:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760704558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UorR2+3U3j9esSZZzol5g/ETNlxkJJawJaLpkJgK+48=;
 b=Mxl2ocKkEx7uFyojyVbK0tXz0cjQaRwBjCtjPBp2KwRrolR8JSeY+paHWWjSpyn83Y+dHL
 Uaxmo8CL0aFd5QUixidf6ztNQr9LKA0ra/9Q4Q22dDnsbL7HT7nGup7MEicm0GcviXWHIC
 hKGMo1yI+1tig4T7xh6FnWPbEzoaf3U=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-rApMwzGvMAeDSowHpwDqFg-1; Fri, 17 Oct 2025 08:35:57 -0400
X-MC-Unique: rApMwzGvMAeDSowHpwDqFg-1
X-Mimecast-MFC-AGG-ID: rApMwzGvMAeDSowHpwDqFg_1760704556
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2698b5fbe5bso27852775ad.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 05:35:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760704556; x=1761309356;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UorR2+3U3j9esSZZzol5g/ETNlxkJJawJaLpkJgK+48=;
 b=lmjKbjbxiKvE1lJv3noL+4xBRi245rek8eYbatorYySlfCwmwGG2R5H56TvssCSf3u
 Tvw7KcV5qczzueorDkO10pDShh7R2Ic2KSOP4JcQGsc9r/cWMHDTs81p6XlhK/k4YW/e
 o9TYMLBsJp/LVjVQ89vVVxhD/spzVy16/UuHdGyNVh1CXx82jxlW0DavgJWjLrCns+pu
 BdxVhbzcrVCZ+AFGpdqmXpTCKkO5yzbG/MFhwTXmCpvF8wxpbMs3lAD4bzrFTbkud5vW
 6LnYbumxt4AHHzxRXnswEaBohNGv6p6PflS7eYOyxvGzpZOQzZTn9SVhFw/4WeYNVUuS
 EBOg==
X-Gm-Message-State: AOJu0Yzfxbe17SKk8dOek/wMPt06xnI25BseV/HmFe7A2gw7pyo5vOat
 wNtPhPRwg1PV852txlGAH7Zgyn8+VzIoQ/1keJzOCATRiAbax0rl1JNw9ofi/xpGWtg8N6KVtXY
 PLc48qcW6uFHqcQ34iWmhHy5iv4wYDbwRZpfSk7J/y8yEue4b81lvxRAoBFY5tpgZS+dZ38kcjR
 zUYrHboCr/kQjprBPJzpvKvMnrZSLwEe0=
X-Gm-Gg: ASbGncsDZkLnE6KHqePIAND251SGsejtgdc95ZwqpnbVJUeRob/i/HT0oe5Pq6Uqgx+
 PfzvK2vXz7aSDHJ34mEjK7gUxqEwoC3oYRQ2p6X8lKfkoFfZXBT32fQz0bVqDsn9MHWIw+sDCUC
 La8l5RNNp2RHpTj45qlkO1hONwo4HhN1Gj2HNKPQycWqoFOrsEORA=
X-Received: by 2002:a17:903:2441:b0:271:479d:3de3 with SMTP id
 d9443c01a7336-290c9c93d94mr45636565ad.12.1760704555929; 
 Fri, 17 Oct 2025 05:35:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdSuxb+AU6R0k4olutmwnZoPqS5aunHtBMkAnM1BBFYxof+ezQOV+2bSI2F7r1DOMcbcgqiNlg4noIgIiUsvo=
X-Received: by 2002:a17:903:2441:b0:271:479d:3de3 with SMTP id
 d9443c01a7336-290c9c93d94mr45636125ad.12.1760704555481; Fri, 17 Oct 2025
 05:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20251016143827.1850397-1-aesteve@redhat.com>
 <20251016143827.1850397-2-aesteve@redhat.com>
 <nl5smdnd5neyuqykpwkruq2onc32hq7jbgbylv33xq4rrsksvc@hk6u3b33iws3>
 <CADSE00+2PU0auFOMaSpgH3dgQ9UgYp+nsAusuQa=ZXbd=JLreQ@mail.gmail.com>
 <5eyt46m7aausn2b26cgtjxhqwt7f6iia3wj7c2kkjaxjjic64p@dyhbrjq32djr>
In-Reply-To: <5eyt46m7aausn2b26cgtjxhqwt7f6iia3wj7c2kkjaxjjic64p@dyhbrjq32djr>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 17 Oct 2025 14:35:44 +0200
X-Gm-Features: AS18NWA9vB-9C8A5jSjM1lkEMdxwS1Vd2GdugzYZlTOkPQ7UmlsrmolLnsKGK44
Message-ID: <CADSE00LLz+hc1DN_x4zHXUSJ30Rf1Gy_WWQmMgMRKE6yOkY8xw@mail.gmail.com>
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

On Fri, Oct 17, 2025 at 2:13=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Fri, Oct 17, 2025 at 01:24:52PM +0200, Albert Esteve wrote:
> >On Fri, Oct 17, 2025 at 11:23=E2=80=AFAM Stefano Garzarella <sgarzare@re=
dhat.com> wrote:
> >>
> >> On Thu, Oct 16, 2025 at 04:38:21PM +0200, Albert Esteve wrote:
> >> >Add SHMEM_MAP/UNMAP requests to vhost-user for dynamic management of
> >> >VIRTIO Shared Memory mappings.
> >> >
> >> >This implementation introduces VirtioSharedMemoryMapping as a unified
> >> >QOM object that manages both the mapping metadata and MemoryRegion
> >> >lifecycle. This object provides reference-counted lifecycle managemen=
t
> >> >with automatic cleanup of file descriptors and memory regions
> >> >through QOM finalization.
> >> >
> >> >This request allows backends to dynamically map file descriptors into=
 a
> >> >VIRTIO Shared Memory Region identified by their shmid. Maps are creat=
ed
> >> >using memory_region_init_ram_from_fd() with configurable read/write
> >> >permissions, and the resulting MemoryRegions are added as subregions =
to
> >> >the shmem container region. The mapped memory is then advertised to t=
he
> >> >guest VIRTIO drivers as a base address plus offset for reading and
> >> >writting according to the requested mmap flags.
> >> >
> >> >The backend can unmap memory ranges within a given VIRTIO Shared Memo=
ry
> >> >Region to free resources. Upon receiving this message, the frontend
> >> >removes the MemoryRegion as a subregion and automatically unreference=
s
> >> >the VirtioSharedMemoryMapping object, triggering cleanup if no other
> >> >references exist.
> >> >
> >> >Error handling has been improved to ensure consistent behavior across
> >> >handlers that manage their own vhost_user_send_resp() calls. Since
> >> >these handlers clear the VHOST_USER_NEED_REPLY_MASK flag, explicit
> >> >error checking ensures proper connection closure on failures,
> >> >maintaining the expected error flow.
> >> >
> >> >Note the memory region commit for these operations needs to be delaye=
d
> >> >until after we reply to the backend to avoid deadlocks. Otherwise,
> >> >the MemoryListener would send a VHOST_USER_SET_MEM_TABLE message
> >> >before the reply.
> >> >
> >> >Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >> >Signed-off-by: Albert Esteve <aesteve@redhat.com>
> >> >---
> >> > hw/virtio/vhost-user.c                    | 267 ++++++++++++++++++++=
++
> >> > hw/virtio/virtio.c                        | 199 ++++++++++++++++
> >> > include/hw/virtio/virtio.h                | 135 +++++++++++
> >> > subprojects/libvhost-user/libvhost-user.c |  70 ++++++
> >> > subprojects/libvhost-user/libvhost-user.h |  54 +++++
> >> > 5 files changed, 725 insertions(+)
> >> >
> >> >diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> >> >index 36c9c2e04d..890be55937 100644
> >> >--- a/hw/virtio/vhost-user.c
> >> >+++ b/hw/virtio/vhost-user.c
> >> >@@ -104,6 +104,7 @@ typedef enum VhostUserRequest {
> >> >     VHOST_USER_GET_SHARED_OBJECT =3D 41,
> >> >     VHOST_USER_SET_DEVICE_STATE_FD =3D 42,
> >> >     VHOST_USER_CHECK_DEVICE_STATE =3D 43,
> >> >+    VHOST_USER_GET_SHMEM_CONFIG =3D 44,
> >> >     VHOST_USER_MAX
> >> > } VhostUserRequest;
> >> >
> >> >@@ -115,6 +116,8 @@ typedef enum VhostUserBackendRequest {
> >> >     VHOST_USER_BACKEND_SHARED_OBJECT_ADD =3D 6,
> >> >     VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE =3D 7,
> >> >     VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP =3D 8,
> >> >+    VHOST_USER_BACKEND_SHMEM_MAP =3D 9,
> >> >+    VHOST_USER_BACKEND_SHMEM_UNMAP =3D 10,
> >> >     VHOST_USER_BACKEND_MAX
> >> > }  VhostUserBackendRequest;
> >> >
> >> >@@ -136,6 +139,12 @@ typedef struct VhostUserMemRegMsg {
> >> >     VhostUserMemoryRegion region;
> >> > } VhostUserMemRegMsg;
> >> >
> >> >+typedef struct VhostUserShMemConfig {
> >> >+    uint32_t nregions;
> >> >+    uint32_t padding;
> >> >+    uint64_t memory_sizes[VIRTIO_MAX_SHMEM_REGIONS];
> >> >+} VhostUserShMemConfig;
> >> >+
> >> > typedef struct VhostUserLog {
> >> >     uint64_t mmap_size;
> >> >     uint64_t mmap_offset;
> >> >@@ -192,6 +201,23 @@ typedef struct VhostUserShared {
> >> >     unsigned char uuid[16];
> >> > } VhostUserShared;
> >> >
> >> >+/* For the flags field of VhostUserMMap */
> >> >+#define VHOST_USER_FLAG_MAP_RW (1u << 0)
> >> >+
> >> >+typedef struct {
> >> >+    /* VIRTIO Shared Memory Region ID */
> >> >+    uint8_t shmid;
> >> >+    uint8_t padding[7];
> >> >+    /* File offset */
> >> >+    uint64_t fd_offset;
> >> >+    /* Offset within the VIRTIO Shared Memory Region */
> >> >+    uint64_t shm_offset;
> >> >+    /* Size of the mapping */
> >> >+    uint64_t len;
> >> >+    /* Flags for the mmap operation, from VHOST_USER_FLAG_MAP_* */
> >> >+    uint64_t flags;
> >> >+} VhostUserMMap;
> >> >+
> >> > typedef struct {
> >> >     VhostUserRequest request;
> >> >
> >> >@@ -224,6 +250,8 @@ typedef union {
> >> >         VhostUserInflight inflight;
> >> >         VhostUserShared object;
> >> >         VhostUserTransferDeviceState transfer_state;
> >> >+        VhostUserMMap mmap;
> >> >+        VhostUserShMemConfig shmem;
> >> > } VhostUserPayload;
> >> >
> >> > typedef struct VhostUserMsg {
> >> >@@ -1768,6 +1796,196 @@ vhost_user_backend_handle_shared_object_looku=
p(struct vhost_user *u,
> >> >     return 0;
> >> > }
> >> >
> >> >+/**
> >> >+ * vhost_user_backend_handle_shmem_map() - Handle SHMEM_MAP backend =
request
> >> >+ * @dev: vhost device
> >> >+ * @ioc: QIOChannel for communication
> >> >+ * @hdr: vhost-user message header
> >> >+ * @payload: message payload containing mapping details
> >> >+ * @fd: file descriptor for the shared memory region
> >> >+ *
> >> >+ * Handles VHOST_USER_BACKEND_SHMEM_MAP requests from the backend. C=
reates
> >> >+ * a VhostUserShmemObject to manage the shared memory mapping and ad=
ds it
> >> >+ * to the appropriate VirtIO shared memory region. The VhostUserShme=
mObject
> >> >+ * serves as an intermediate parent for the MemoryRegion, ensuring p=
roper
> >> >+ * lifecycle management with reference counting.
> >> >+ *
> >> >+ * Returns: 0 on success, negative errno on failure
> >> >+ */
> >> >+static int
> >> >+vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
> >> >+                                    QIOChannel *ioc,
> >> >+                                    VhostUserHeader *hdr,
> >> >+                                    VhostUserPayload *payload,
> >> >+                                    int fd)
> >> >+{
> >> >+    VirtioSharedMemory *shmem;
> >> >+    VhostUserMMap *vu_mmap =3D &payload->mmap;
> >> >+    VirtioSharedMemoryMapping *existing;
> >> >+    Error *local_err =3D NULL;
> >> >+    int ret =3D 0;
> >> >+
> >> >+    if (fd < 0) {
> >> >+        error_report("Bad fd for map");
> >> >+        ret =3D -EBADF;
> >> >+        goto send_reply;
> >> >+    }
> >> >+
> >> >+    if (QSIMPLEQ_EMPTY(&dev->vdev->shmem_list)) {
> >> >+        error_report("Device has no VIRTIO Shared Memory Regions. "
> >> >+                     "Requested ID: %d", vu_mmap->shmid);
> >> >+        ret =3D -EFAULT;
> >> >+        goto send_reply;
> >> >+    }
> >> >+
> >> >+    shmem =3D virtio_find_shmem_region(dev->vdev, vu_mmap->shmid);
> >> >+    if (!shmem) {
> >> >+        error_report("VIRTIO Shared Memory Region at "
> >> >+                     "ID %d not found or uninitialized", vu_mmap->sh=
mid);
> >> >+        ret =3D -EFAULT;
> >> >+        goto send_reply;
> >> >+    }
> >> >+
> >> >+    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> >> >+        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr.size) {
> >> >+        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
> >> >+                     vu_mmap->shm_offset, vu_mmap->len);
> >> >+        ret =3D -EFAULT;
> >> >+        goto send_reply;
> >> >+    }
> >> >+
> >> >+    QTAILQ_FOREACH(existing, &shmem->mmaps, link) {
> >> >+        if (ranges_overlap(existing->offset, existing->len,
> >> >+                           vu_mmap->shm_offset, vu_mmap->len)) {
> >> >+            error_report("VIRTIO Shared Memory mapping overlap");
> >> >+            ret =3D -EFAULT;
> >> >+            goto send_reply;
> >> >+        }
> >> >+    }
> >> >+
> >> >+    memory_region_transaction_begin();
> >> >+
> >> >+    /* Create VirtioSharedMemoryMapping object */
> >> >+    VirtioSharedMemoryMapping *mapping =3D virtio_shared_memory_mapp=
ing_new(
> >> >+        vu_mmap->shmid, fd, vu_mmap->fd_offset, vu_mmap->shm_offset,
> >> >+        vu_mmap->len, vu_mmap->flags & VHOST_USER_FLAG_MAP_RW);
> >> >+
> >> >+    if (!mapping) {
> >> >+        ret =3D -EFAULT;
> >> >+        goto send_reply_commit;
> >> >+    }
> >> >+
> >> >+    /* Add the mapping to the shared memory region */
> >> >+    if (virtio_add_shmem_map(shmem, mapping) !=3D 0) {
> >> >+        error_report("Failed to add shared memory mapping");
> >> >+        object_unref(OBJECT(mapping));
> >> >+        ret =3D -EFAULT;
> >> >+        goto send_reply_commit;
> >> >+    }
> >> >+
> >> >+send_reply_commit:
> >> >+    /* Send reply and commit after transaction started */
> >> >+    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> >> >+        payload->u64 =3D !!ret;
> >> >+        hdr->size =3D sizeof(payload->u64);
> >> >+        if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)) {
> >> >+            error_report_err(local_err);
> >> >+            memory_region_transaction_commit();
> >> >+            return -EFAULT;
> >> >+        }
> >> >+    }
> >> >+    memory_region_transaction_commit();
> >>
> >> Sorry to be late, I did a quick review, my only doubts is here, maybe =
it
> >> was already discussed, but why do we commit after responding to the
> >> backend?
> >>
> >> Should we do it first to prevent the backend from =E2=80=9Cseeing=E2=
=80=9D something
> >> that hasn't been committed yet?
> >
> >There is a race that leads to a deadlock. hw/virtio/vhost.c has a
> >MemoryListener that sends VHOST_USER_SET_MEM_TABLE messages in its
> >.commit() callback. If this happens before the reply, the backend will
> >not process it as it is stuck waiting for the SHMEM reply, and the
> >handler in qemu will not send it as it is waiting for the reply to the
> >SET_MEM_TABLE. So we have to delay the transaction commit to
> >immediately after the reply.
>
> Okay, I see now that you mentioned that in the commit description,
> great, I should have read it more carefully!
> IMO it would be worth adding a comment here, but I definitely won't ask
> you to send a v11 for this! (maybe a followup patch later).
>
> >
> >>
> >> Also, if vhost_user_send_resp() fails, should we call
> >> virtio_del_shmem_map()?
> >
> >If vhost_user_send_resp() fails, the connection with the backend is
> >closed, so the mappings will indeed never be removed unless we reset.
> >
> >Maybe better than removing the single mapping, would be to loop
> >through mappings in the shared memory and clean them all (same we do :
> >
> >```
> >        while (!QTAILQ_EMPTY(&shmem->mmaps)) {
> >            VirtioSharedMemoryMapping *mapping =3D QTAILQ_FIRST(&shmem->=
mmaps);
> >            virtio_del_shmem_map(shmem, mapping->offset, mapping->mr->si=
ze);
> >        }
> >```
> >
> >But since a backend may utilize more than one shared memory region,
> >and we do not know the mapping between a given backend and its shared
> >memories, whatever we do will be incomplete (?).
>
> I don't know if this is the right place to do this kind of cleanup,
> maybe further up in the stack.
>
>
> >I think the only
> >solution after this happens is to reset (virtio_reset) to remove all
> >mappings from the all shared regions, and re-establish the backend
> >channel (is it possible?). Even if the channel cannot be restablished,
> >I wouldn't bother just removing one mapping, I would assume it needs a
> >reset.
>
> So, in conclusion, we are saying that if we can no longer communicate
> with the backend, there is no point in maintaining a consistent state,
> because we have to reset the device anyway.

I guess what I'm saying after looking at the issue you raised (which
is reasonable and founded) is that the is no good option to ensure we
go back to a consistent state unless we reset.

> Are we already doing this, or should we be doing it?

I don't think we are? What I do not know is if we should. Probably yes.

I feel we should at least set the broken flag to true in case of an error:
dev->vdev->broken =3D true;

Looking at virtio/virtio.h: `bool broken; /* device in invalid state,
needs reset */`

I can send a separate patch.

>
> BTW, I don't want to stop this series, I just found this error path
> strange.

On the contrary, thanks for taking a look! It is better to clear any
potential issues before merging. Even if it needs a new version.

>
> Thanks,
> Stefano
>


