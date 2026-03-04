Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5199EF8FE0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxlzM-0008H3-7J; Wed, 04 Mar 2026 08:10:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vxlzK-0008Gv-35
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:10:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vxlzG-0005hc-Sz
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:10:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772629801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7nAuZavf20SD8D+Xp8YjmXnnOqEXZcL58YxJjjaU6EM=;
 b=clBytmI/o6GHKZDEkjxqmLMRV0mcEy2GlpRTuP/a0qH/i/EotlNDMdBQR7ODSGRLn7Tpt9
 /277g7g+NRVRwMXIi5Rbrx2Pktu6mdnmR/oT8IVuzKI2RN+siAxbl85IrppyeYdjZn/n4W
 vLrdxLx4OJ3HOCIcC5ykstLi6BNXGoQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-x4q4S3urNqO8o2pLbNTDUQ-1; Wed, 04 Mar 2026 08:08:41 -0500
X-MC-Unique: x4q4S3urNqO8o2pLbNTDUQ-1
X-Mimecast-MFC-AGG-ID: x4q4S3urNqO8o2pLbNTDUQ_1772629720
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4832c4621c2so74058065e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772629720; x=1773234520; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7nAuZavf20SD8D+Xp8YjmXnnOqEXZcL58YxJjjaU6EM=;
 b=q6bTPr8bsatZmkYYjuCVlz9b79rZ1m0t+hMPCG8n67pTGTnylYp6BLXtGQ30rPObzs
 u08aU0NaVjpX6QftdsEim29aC5xC8LXsvZLC3MGuZGTd0wWFdGj1eGgcCZEmI/I84B/X
 H8+1woeRwHJbmeJJaSlARqhGaIuO4OVZjstVqERp4LrliHCUkTmfmY90+j6c3hmvhW0t
 VmLcs70xfeAXDd/Y85Yy8keh1ZMKkUm7I+lQ/HdN+wocycWYbSzHqVEAdRSOjC2Iu3Bq
 l5J13jB4pW++EIaehBsXoGSUXmRm5umLPEiUblcwkPZkYxuql9HugacWBA4tK+WhSnMH
 kIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772629720; x=1773234520;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7nAuZavf20SD8D+Xp8YjmXnnOqEXZcL58YxJjjaU6EM=;
 b=LQJO/pEXmbBZ65mIDMcsv4hCHAHPNwFvqCXGjHknLmh77mkgcrb8b75LBpgD4p4oxg
 1RNOoNMU7GKz/4ECv2NJJQNjHEmebeZcln9gJdVRo8tWqMK+IcakkScCeoBaTOSXa7ey
 Gc4wCqqzDh2PRTfeXvrZlq7qIVkDuuhbfHTfL46E+i1oMEBLiRwviBp7mcpBWvw6m5hD
 Cfc+sfu5WqhlfSfnfnb1wTruMEfCHNP0Zz3iDFCGhRyCkA0rf7wkKF5C6tJnAdkxsfNo
 LDF6Qqwq+/wOOVSLbxDqzxqWr3INIhl4YAZwDzz+k7OHWfsejKTj2OTnP4svyrcKqh+R
 PtWA==
X-Gm-Message-State: AOJu0Yw5h24ukIvCsn/xZT38dhE8vgfp30ok83ah/dfrsG22iwu4mLA2
 g3ewVRDWd2s4v6P8SJyfSKT04inERBB+eF7O0tPUHJq19trv848Wco+bmIA7q/ewDw1E5ZPU8HS
 PXMti9EQ4LqWYNi9lzicq7k1eokUL2/6jaSX9i7AjFULuy1tAaQrQ9Hxx
X-Gm-Gg: ATEYQzwYDgAv1khxT0+FB6lSKEbAviBvoMMqmt/N4CyRiY7ee/2hArFbG/Mm70AxRzt
 vHly40ooB6CEUVGTuFTSu2QDIXHe8BOsVIXxcKu7cqj5L0H60fss+XKp/drZZD5BHGVliu6hyy5
 q7i/4S3wy2+nTNBOohMWZaSPajkvEP8YJlmtXTm/WMUkMbTORIRpHQbs00MxU4LoFwpUKDiTaO4
 8fNrbZDw81a1eokQrRAzkYz97MIlpgaXaoP3O8m3CDk/EXz/+y3w7pGJz71xHJ7fovM86v95gMz
 Y5dw6kPkA9YkQD+krcLFp4+NqGpZVIdU7g4811KRKfWm9X7keyA16zgucwc3DnmHyFOUZh2qZkR
 jiPGXeXZJ7DMQB4H8MmJtr3qWo0ymRR5b1CVo2J3OApjfhtFlWyZAlMCLN2NgiN9uz39HB/U=
X-Received: by 2002:a05:600c:3b99:b0:477:63b5:7148 with SMTP id
 5b1f17b1804b1-4851983121emr32123405e9.6.1772629719938; 
 Wed, 04 Mar 2026 05:08:39 -0800 (PST)
X-Received: by 2002:a05:600c:3b99:b0:477:63b5:7148 with SMTP id
 5b1f17b1804b1-4851983121emr32122985e9.6.1772629719265; 
 Wed, 04 Mar 2026 05:08:39 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it.
 [82.53.134.58]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485188923c2sm51678315e9.14.2026.03.04.05.08.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:08:37 -0800 (PST)
Date: Wed, 4 Mar 2026 14:08:33 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, mst@redhat.com,
 dbassey@redhat.com, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 stefanha@redhat.com, manos.pitsidianakis@linaro.org, jasowang@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, 
 slp@redhat.com, hi@alyssa.is, stevensd@chromium.org
Subject: Re: [PATCH v13 1/7] vhost-user: Add VirtIO Shared Memory map request
Message-ID: <aagsazxNYDriNgDZ@sgarzare-redhat>
References: <20260219130334.787858-1-aesteve@redhat.com>
 <20260219130334.787858-2-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260219130334.787858-2-aesteve@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Feb 19, 2026 at 02:03:28PM +0100, Albert Esteve wrote:
>Add SHMEM_MAP/UNMAP requests to vhost-user for dynamic management of
>VIRTIO Shared Memory mappings.
>
>This implementation introduces VirtioSharedMemoryMapping as a unified
>QOM object that manages both the mapping metadata and MemoryRegion
>lifecycle. This object provides reference-counted lifecycle management
>with automatic cleanup of file descriptors and memory regions
>through QOM finalization.
>
>This request allows backends to dynamically map file descriptors into a
>VIRTIO Shared Memory Region identified by their shmid. Maps are created
>using memory_region_init_ram_from_fd() with configurable read/write
>permissions, and the resulting MemoryRegions are added as subregions to
>the shmem container region. The mapped memory is then advertised to the
>guest VIRTIO drivers as a base address plus offset for reading and
>writting according to the requested mmap flags.
>
>The backend can unmap memory ranges within a given VIRTIO Shared Memory
>Region to free resources. Upon receiving this message, the frontend
>removes the MemoryRegion as a subregion and automatically unreferences
>the VirtioSharedMemoryMapping object, triggering cleanup if no other
>references exist.
>
>Error handling has been improved to ensure consistent behavior across
>handlers that manage their own vhost_user_send_resp() calls. Since
>these handlers clear the VHOST_USER_NEED_REPLY_MASK flag, explicit
>error checking ensures proper connection closure on failures,
>maintaining the expected error flow.
>
>Note the memory region commit for these operations needs to be delayed
>until after we reply to the backend to avoid deadlocks. Otherwise,
>the MemoryListener would send a VHOST_USER_SET_MEM_TABLE message
>before the reply.
>
>Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>Signed-off-by: Albert Esteve <aesteve@redhat.com>
>---
> hw/virtio/vhost-user.c                    | 269 ++++++++++++++++++++++
> hw/virtio/virtio.c                        | 201 ++++++++++++++++
> include/hw/virtio/virtio.h                | 135 +++++++++++
> include/system/memory.h                   |  13 ++
> subprojects/libvhost-user/libvhost-user.c |  70 ++++++
> subprojects/libvhost-user/libvhost-user.h |  54 +++++
> 6 files changed, 742 insertions(+)
>
>diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>index 63fa9a1b4b..5d3841d58b 100644
>--- a/hw/virtio/vhost-user.c
>+++ b/hw/virtio/vhost-user.c
>@@ -104,6 +104,7 @@ typedef enum VhostUserRequest {
>     VHOST_USER_GET_SHARED_OBJECT = 41,
>     VHOST_USER_SET_DEVICE_STATE_FD = 42,
>     VHOST_USER_CHECK_DEVICE_STATE = 43,
>+    VHOST_USER_GET_SHMEM_CONFIG = 44,
>     VHOST_USER_MAX
> } VhostUserRequest;
>
>@@ -115,6 +116,8 @@ typedef enum VhostUserBackendRequest {
>     VHOST_USER_BACKEND_SHARED_OBJECT_ADD = 6,
>     VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE = 7,
>     VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP = 8,
>+    VHOST_USER_BACKEND_SHMEM_MAP = 9,
>+    VHOST_USER_BACKEND_SHMEM_UNMAP = 10,
>     VHOST_USER_BACKEND_MAX
> }  VhostUserBackendRequest;
>
>@@ -136,6 +139,12 @@ typedef struct VhostUserMemRegMsg {
>     VhostUserMemoryRegion region;
> } VhostUserMemRegMsg;
>
>+typedef struct VhostUserShMemConfig {
>+    uint32_t nregions;
>+    uint32_t padding;
>+    uint64_t memory_sizes[VIRTIO_MAX_SHMEM_REGIONS];
>+} VhostUserShMemConfig;
>+
> typedef struct VhostUserLog {
>     uint64_t mmap_size;
>     uint64_t mmap_offset;
>@@ -192,6 +201,23 @@ typedef struct VhostUserShared {
>     unsigned char uuid[16];
> } VhostUserShared;
>
>+/* For the flags field of VhostUserMMap */
>+#define VHOST_USER_FLAG_MAP_RW (1u << 0)
>+
>+typedef struct {
>+    /* VIRTIO Shared Memory Region ID */
>+    uint8_t shmid;
>+    uint8_t padding[7];
>+    /* File offset */
>+    uint64_t fd_offset;
>+    /* Offset within the VIRTIO Shared Memory Region */
>+    uint64_t shm_offset;
>+    /* Size of the mapping */
>+    uint64_t len;
>+    /* Flags for the mmap operation, from VHOST_USER_FLAG_MAP_* */
>+    uint64_t flags;
>+} VhostUserMMap;
>+
> typedef struct {
>     VhostUserRequest request;
>
>@@ -224,6 +250,8 @@ typedef union {
>         VhostUserInflight inflight;
>         VhostUserShared object;
>         VhostUserTransferDeviceState transfer_state;
>+        VhostUserMMap mmap;
>+        VhostUserShMemConfig shmem;
> } VhostUserPayload;
>
> typedef struct VhostUserMsg {
>@@ -1771,6 +1799,196 @@ vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
>     return 0;
> }
>
>+/**
>+ * vhost_user_backend_handle_shmem_map() - Handle SHMEM_MAP backend request
>+ * @dev: vhost device
>+ * @ioc: QIOChannel for communication
>+ * @hdr: vhost-user message header
>+ * @payload: message payload containing mapping details
>+ * @fd: file descriptor for the shared memory region
>+ *
>+ * Handles VHOST_USER_BACKEND_SHMEM_MAP requests from the backend. Creates
>+ * a VhostUserShmemObject to manage the shared memory mapping and adds it
>+ * to the appropriate VirtIO shared memory region. The VhostUserShmemObject
>+ * serves as an intermediate parent for the MemoryRegion, ensuring proper
>+ * lifecycle management with reference counting.
>+ *
>+ * Returns: 0 on success, negative errno on failure
>+ */
>+static int
>+vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
>+                                    QIOChannel *ioc,
>+                                    VhostUserHeader *hdr,
>+                                    VhostUserPayload *payload,
>+                                    int fd)
>+{
>+    VirtioSharedMemory *shmem;
>+    VhostUserMMap *vu_mmap = &payload->mmap;
>+    VirtioSharedMemoryMapping *existing;
>+    Error *local_err = NULL;
>+    int ret = 0;
>+
>+    if (fd < 0) {
>+        error_report("Bad fd for map");
>+        ret = -EBADF;
>+        goto send_reply;
>+    }
>+
>+    if (QSIMPLEQ_EMPTY(&dev->vdev->shmem_list)) {
>+        error_report("Device has no VIRTIO Shared Memory Regions. "
>+                     "Requested ID: %d", vu_mmap->shmid);
>+        ret = -EFAULT;
>+        goto send_reply;
>+    }
>+
>+    shmem = virtio_find_shmem_region(dev->vdev, vu_mmap->shmid);
>+    if (!shmem) {
>+        error_report("VIRTIO Shared Memory Region at "
>+                     "ID %d not found or uninitialized", vu_mmap->shmid);
>+        ret = -EFAULT;
>+        goto send_reply;
>+    }
>+
>+    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
>+        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr.size) {

Any reason about not using `memory_region_size(&shmem->mr)` ?

>+        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
>+                     vu_mmap->shm_offset, vu_mmap->len);
>+        ret = -EFAULT;
>+        goto send_reply;
>+    }
>+
>+    QTAILQ_FOREACH(existing, &shmem->mmaps, link) {
>+        if (ranges_overlap(existing->offset, existing->len,
>+                           vu_mmap->shm_offset, vu_mmap->len)) {
>+            error_report("VIRTIO Shared Memory mapping overlap");
>+            ret = -EFAULT;
>+            goto send_reply;
>+        }
>+    }
>+
>+    memory_region_transaction_begin();
>+
>+    /* Create VirtioSharedMemoryMapping object */
>+    VirtioSharedMemoryMapping *mapping = virtio_shared_memory_mapping_new(
>+        vu_mmap->shmid, fd, vu_mmap->fd_offset, vu_mmap->shm_offset,
>+        vu_mmap->len, vu_mmap->flags & VHOST_USER_FLAG_MAP_RW);
>+
>+    if (!mapping) {
>+        ret = -EFAULT;
>+        goto send_reply_commit;
>+    }
>+
>+    /* Add the mapping to the shared memory region */
>+    if (virtio_add_shmem_map(shmem, mapping) != 0) {
>+        error_report("Failed to add shared memory mapping");
>+        object_unref(OBJECT(mapping));
>+        ret = -EFAULT;
>+        goto send_reply_commit;
>+    }
>+
>+send_reply_commit:
>+    /* Send reply and commit after transaction started */
>+    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
>+        payload->u64 = !!ret;
>+        hdr->size = sizeof(payload->u64);
>+        if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)) {
>+            error_report_err(local_err);
>+            memory_region_transaction_commit();
>+            return -EFAULT;
>+        }
>+    }
>+    memory_region_transaction_commit();
>+    return 0;
>+
>+send_reply:
>+    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
>+        payload->u64 = !!ret;
>+        hdr->size = sizeof(payload->u64);
>+        if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)) {
>+            error_report_err(local_err);
>+            return -EFAULT;
>+        }
>+    }
>+    return 0;
>+}
>+
>+/**
>+ * vhost_user_backend_handle_shmem_unmap() - Handle SHMEM_UNMAP backend request
>+ * @dev: vhost device
>+ * @ioc: QIOChannel for communication
>+ * @hdr: vhost-user message header
>+ * @payload: message payload containing unmapping details
>+ *
>+ * Handles VHOST_USER_BACKEND_SHMEM_UNMAP requests from the backend. Removes
>+ * the specified memory mapping from the VirtIO shared memory region. 
>This
>+ * automatically unreferences the associated VhostUserShmemObject, which may
>+ * trigger its finalization and cleanup (munmap, close fd) if no other
>+ * references exist.
>+ *
>+ * Returns: 0 on success, negative errno on failure
>+ */
>+static int
>+vhost_user_backend_handle_shmem_unmap(struct vhost_dev *dev,
>+                                      QIOChannel *ioc,
>+                                      VhostUserHeader *hdr,
>+                                      VhostUserPayload *payload)
>+{
>+    VirtioSharedMemory *shmem = NULL;
>+    VirtioSharedMemoryMapping *mmap = NULL;
>+    VhostUserMMap *vu_mmap = &payload->mmap;
>+    Error *local_err = NULL;
>+    int ret = 0;
>+
>+    if (QSIMPLEQ_EMPTY(&dev->vdev->shmem_list)) {
>+        error_report("Device has no VIRTIO Shared Memory Regions. "
>+                     "Requested ID: %d", vu_mmap->shmid);
>+        ret = -EFAULT;
>+        goto send_reply;
>+    }
>+
>+    shmem = virtio_find_shmem_region(dev->vdev, vu_mmap->shmid);
>+    if (!shmem) {
>+        error_report("VIRTIO Shared Memory Region at "
>+                     "ID %d not found or uninitialized", vu_mmap->shmid);
>+        ret = -EFAULT;
>+        goto send_reply;
>+    }
>+
>+    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
>+        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr.size) {
>+        error_report("Bad offset/len for unmmap %" PRIx64 "+%" PRIx64,
>+                     vu_mmap->shm_offset, vu_mmap->len);
>+        ret = -EFAULT;
>+        goto send_reply;
>+    }
>+
>+    mmap = virtio_find_shmem_map(shmem, vu_mmap->shm_offset, vu_mmap->len);
>+    if (!mmap) {
>+        error_report("Shared memory mapping not found at offset %" PRIx64
>+                     " with length %" PRIx64,
>+                     vu_mmap->shm_offset, vu_mmap->len);
>+        ret = -EFAULT;
>+        goto send_reply;
>+    }
>+
>+send_reply:
>+    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
>+        payload->u64 = !!ret;
>+        hdr->size = sizeof(payload->u64);
>+        if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)) {
>+            error_report_err(local_err);
>+            return -EFAULT;
>+        }
>+    }
>+
>+    if (!ret && shmem && mmap) {
>+        /* Free the MemoryRegion only after reply */
>+        virtio_del_shmem_map(shmem, vu_mmap->shm_offset, vu_mmap->len);
>+    }
>+
>+    return 0;
>+}
>+
> static void close_backend_channel(struct vhost_user *u)
> {
>     g_source_destroy(u->backend_src);
>@@ -1844,6 +2062,21 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
>         ret = vhost_user_backend_handle_shared_object_lookup(dev->opaque,
>                                                              &payload.object);
>         break;
>+    case VHOST_USER_BACKEND_SHMEM_MAP:
>+        /* Handler manages its own response, check error and close connection */
>+        reply_ack = false;
>+        if (vhost_user_backend_handle_shmem_map(dev, ioc, &hdr, &payload,
>+                                                fd ? fd[0] : -1) < 0) {
>+            goto err;
>+        }
>+        break;
>+    case VHOST_USER_BACKEND_SHMEM_UNMAP:
>+        /* Handler manages its own response, check error and close connection */
>+        reply_ack = false;
>+        if (vhost_user_backend_handle_shmem_unmap(dev, ioc, &hdr, &payload) < 0) {
>+            goto err;
>+        }
>+        break;
>     default:
>         error_report("Received unexpected msg type: %d.", hdr.request);
>         ret = -EINVAL;
>@@ -3021,6 +3254,41 @@ static int vhost_user_check_device_state(struct vhost_dev *dev, Error **errp)
>     return 0;
> }
>
>+static int vhost_user_get_shmem_config(struct vhost_dev *dev,
>+                                       int *nregions,
>+                                       uint64_t *memory_sizes,
>+                                       Error **errp)
>+{
>+    int ret;
>+    VhostUserMsg msg = {
>+        .hdr.request = VHOST_USER_GET_SHMEM_CONFIG,
>+        .hdr.flags = VHOST_USER_VERSION,
>+    };
>+
>+    if (!virtio_has_feature(dev->protocol_features,
>+                            VHOST_USER_PROTOCOL_F_SHMEM)) {
>+        *nregions = 0;
>+        return 0;
>+    }
>+
>+    ret = vhost_user_write(dev, &msg, NULL, 0);
>+    if (ret < 0) {
>+        return ret;
>+    }
>+
>+    ret = vhost_user_read(dev, &msg);
>+    if (ret < 0) {
>+        return ret;
>+    }
>+
>+    assert(msg.payload.shmem.nregions <= VIRTIO_MAX_SHMEM_REGIONS);

Is this `assert()` too much?
This means that a bad vhost-user backend can crash QEMU, so not sure 
it's really what we want, I'd return an error.

>+    *nregions = msg.payload.shmem.nregions;
>+    memcpy(memory_sizes,
>+           &msg.payload.shmem.memory_sizes,
>+           sizeof(uint64_t) * VIRTIO_MAX_SHMEM_REGIONS);
>+    return 0;
>+}
>+
> const VhostOps user_ops = {
>         .backend_type = VHOST_BACKEND_TYPE_USER,
>         .vhost_backend_init = vhost_user_backend_init,
>@@ -3059,4 +3327,5 @@ const VhostOps user_ops = {
>         .vhost_supports_device_state = vhost_user_supports_device_state,
>         .vhost_set_device_state_fd = vhost_user_set_device_state_fd,
>         .vhost_check_device_state = vhost_user_check_device_state,
>+        .vhost_get_shmem_config = vhost_user_get_shmem_config,
> };
>diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>index 3dc9423eae..2f608f33ae 100644
>--- a/hw/virtio/virtio.c
>+++ b/hw/virtio/virtio.c
>@@ -3111,6 +3111,173 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
>     return ret;
> }
>
>+VirtioSharedMemory *virtio_new_shmem_region(VirtIODevice *vdev, uint8_t shmid, uint64_t size)
>+{
>+    VirtioSharedMemory *elem;
>+    g_autofree char *name = NULL;
>+
>+    elem = g_new0(VirtioSharedMemory, 1);
>+    elem->shmid = shmid;
>+
>+    /* Initialize embedded MemoryRegion as container for shmem mappings */
>+    name = g_strdup_printf("virtio-shmem-%d", shmid);
>+    memory_region_init(&elem->mr, OBJECT(vdev), name, size);
>+    QTAILQ_INIT(&elem->mmaps);
>+    QSIMPLEQ_INSERT_TAIL(&vdev->shmem_list, elem, entry);
>+    return elem;
>+}
>+
>+VirtioSharedMemory *virtio_find_shmem_region(VirtIODevice *vdev, uint8_t shmid)
>+{
>+    VirtioSharedMemory *shmem, *next;
>+    QSIMPLEQ_FOREACH_SAFE(shmem, &vdev->shmem_list, entry, next) {
>+        if (shmem->shmid == shmid) {
>+            return shmem;
>+        }
>+    }
>+    return NULL;
>+}
>+
>+static void virtio_shared_memory_mapping_instance_init(Object *obj)
>+{
>+    VirtioSharedMemoryMapping *mapping = VIRTIO_SHARED_MEMORY_MAPPING(obj);
>+
>+    mapping->shmid = 0;
>+    mapping->offset = 0;
>+    mapping->len = 0;
>+    mapping->mr = NULL;
>+}
>+
>+static void virtio_shared_memory_mapping_instance_finalize(Object *obj)
>+{
>+    VirtioSharedMemoryMapping *mapping = VIRTIO_SHARED_MEMORY_MAPPING(obj);
>+
>+    /* Clean up MemoryRegion if it exists */
>+    if (mapping->mr) {
>+        /* Unparent the MemoryRegion to trigger cleanup */
>+        object_unparent(OBJECT(mapping->mr));
>+        mapping->mr = NULL;
>+    }
>+}
>+
>+VirtioSharedMemoryMapping *virtio_shared_memory_mapping_new(uint8_t shmid,
>+                                                            int fd,
>+                                                            uint64_t fd_offset,
>+                                                            uint64_t shm_offset,
>+                                                            uint64_t len,
>+                                                            bool allow_write)
>+{
>+    VirtioSharedMemoryMapping *mapping;
>+    MemoryRegion *mr;
>+    g_autoptr(GString) mr_name = g_string_new(NULL);
>+    uint32_t ram_flags;
>+    Error *local_err = NULL;
>+
>+    if (len == 0) {
>+        error_report("Shared memory mapping size cannot be zero");
>+        return NULL;
>+    }
>+
>+    fd = dup(fd);
>+    if (fd < 0) {
>+        error_report("Failed to duplicate fd: %s", strerror(errno));
>+        return NULL;
>+    }
>+
>+    /* Determine RAM flags */
>+    ram_flags = RAM_SHARED;
>+    if (!allow_write) {
>+        ram_flags |= RAM_READONLY_FD;
>+    }
>+
>+    /* Create the VirtioSharedMemoryMapping */
>+    mapping = VIRTIO_SHARED_MEMORY_MAPPING(
>+        object_new(TYPE_VIRTIO_SHARED_MEMORY_MAPPING));
>+
>+    /* Set up object properties */
>+    mapping->shmid = shmid;
>+    mapping->offset = shm_offset;
>+    mapping->len = len;
>+
>+    /* Create MemoryRegion as a child of this object */
>+    mr = g_new0(MemoryRegion, 1);
>+    g_string_printf(mr_name, "virtio-shmem-%d-%" PRIx64, shmid, shm_offset);
>+
>+    /* Initialize MemoryRegion with file descriptor */
>+    if (!memory_region_init_ram_from_fd(mr, OBJECT(mapping), mr_name->str,
>+                                        len, ram_flags, fd, fd_offset,
>+                                        &local_err)) {
>+        error_report_err(local_err);
>+        g_free(mr);
>+        close(fd);
>+        object_unref(OBJECT(mapping));
>+        return NULL;
>+    }
>+
>+    mapping->mr = mr;
>+    return mapping;
>+}
>+
>+int virtio_add_shmem_map(VirtioSharedMemory *shmem,
>+                         VirtioSharedMemoryMapping *mapping)
>+{
>+    if (!mapping) {
>+        error_report("VirtioSharedMemoryMapping cannot be NULL");
>+        return -1;
>+    }
>+    if (!mapping->mr) {
>+        error_report("VirtioSharedMemoryMapping has no MemoryRegion");
>+        return -1;
>+    }
>+
>+    /* Validate boundaries against the VIRTIO shared memory region */
>+    if (mapping->offset + mapping->len > memory_region_size(&shmem->mr)) {
>+        error_report("Memory exceeds the shared memory boundaries");
>+        return -1;
>+    }
>+
>+    /* Add as subregion to the VIRTIO shared memory */
>+    memory_region_add_subregion(&shmem->mr, mapping->offset, mapping->mr);
>+
>+    /* Add to the mapped regions list */
>+    QTAILQ_INSERT_TAIL(&shmem->mmaps, mapping, link);
>+
>+    return 0;
>+}
>+
>+VirtioSharedMemoryMapping *virtio_find_shmem_map(VirtioSharedMemory *shmem,
>+                                          hwaddr offset, uint64_t size)
>+{
>+    VirtioSharedMemoryMapping *mapping;
>+    QTAILQ_FOREACH(mapping, &shmem->mmaps, link) {
>+        if (mapping->offset == offset && mapping->len == size) {
>+            return mapping;
>+        }
>+    }
>+    return NULL;
>+}
>+
>+void virtio_del_shmem_map(VirtioSharedMemory *shmem, hwaddr offset,
>+                          uint64_t size)
>+{
>+    VirtioSharedMemoryMapping *mapping = virtio_find_shmem_map(shmem, offset, size);
>+    if (mapping == NULL) {
>+        return;
>+    }
>+
>+    /*
>+     * Remove from memory region first
>+     */
>+    memory_region_del_subregion(&shmem->mr, mapping->mr);
>+
>+    /*
>+     * Remove from list and unref the mapping which will trigger automatic cleanup
>+     * when the reference count reaches zero.
>+     */
>+    QTAILQ_REMOVE(&shmem->mmaps, mapping, link);
>+    object_unref(OBJECT(mapping));
>+}
>+
> /* A wrapper for use as a VMState .put function */
> static int virtio_device_put(QEMUFile *f, void *opaque, size_t size,
>                               const VMStateField *field, JSONWriter *vmdesc)
>@@ -3237,6 +3404,7 @@ void virtio_reset(void *opaque)
> {
>     VirtIODevice *vdev = opaque;
>     VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
>+    VirtioSharedMemory *shmem;
>     uint64_t features[VIRTIO_FEATURES_NU64S];
>     int i;
>
>@@ -3276,6 +3444,15 @@ void virtio_reset(void *opaque)
>     for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
>         __virtio_queue_reset(vdev, i);
>     }
>+
>+    /* Mappings are removed to prevent stale fds from remaining open. */
>+    QSIMPLEQ_FOREACH(shmem, &vdev->shmem_list, entry) {
>+        while (!QTAILQ_EMPTY(&shmem->mmaps)) {
>+            VirtioSharedMemoryMapping *mapping = QTAILQ_FIRST(&shmem->mmaps);
>+            virtio_del_shmem_map(shmem, mapping->offset,
>+                                 memory_region_size(mapping->mr));
>+        }
>+    }
> }
>
> static void virtio_device_check_notification_compatibility(VirtIODevice *vdev,
>@@ -3599,6 +3776,7 @@ void virtio_init(VirtIODevice *vdev, uint16_t 
>device_id, size_t config_size)
>             NULL, virtio_vmstate_change, vdev);
>     vdev->device_endian = virtio_default_endian();
>     vdev->use_guest_notifier_mask = true;
>+    QSIMPLEQ_INIT(&vdev->shmem_list);
> }
>
> /*
>@@ -4110,11 +4288,25 @@ static void virtio_device_free_virtqueues(VirtIODevice *vdev)
> static void virtio_device_instance_finalize(Object *obj)
> {
>     VirtIODevice *vdev = VIRTIO_DEVICE(obj);
>+    VirtioSharedMemory *shmem;
>
>     virtio_device_free_virtqueues(vdev);
>
>     g_free(vdev->config);
>     g_free(vdev->vector_queues);
>+    while (!QSIMPLEQ_EMPTY(&vdev->shmem_list)) {
>+        shmem = QSIMPLEQ_FIRST(&vdev->shmem_list);
>+        while (!QTAILQ_EMPTY(&shmem->mmaps)) {
>+            VirtioSharedMemoryMapping *mapping = QTAILQ_FIRST(&shmem->mmaps);
>+            virtio_del_shmem_map(shmem, mapping->offset,
>+                                 memory_region_size(mapping->mr));
>+        }
>+
>+        /* Clean up the embedded MemoryRegion */
>+        object_unparent(OBJECT(&shmem->mr));
>+        QSIMPLEQ_REMOVE_HEAD(&vdev->shmem_list, entry);
>+        g_free(shmem);
>+    }
> }
>
> static const Property virtio_properties[] = {
>@@ -4480,9 +4672,18 @@ static const TypeInfo virtio_device_info = {
>     .class_size = sizeof(VirtioDeviceClass),
> };
>
>+static const TypeInfo virtio_shared_memory_mapping_info = {
>+    .name = TYPE_VIRTIO_SHARED_MEMORY_MAPPING,
>+    .parent = TYPE_OBJECT,
>+    .instance_size = sizeof(VirtioSharedMemoryMapping),
>+    .instance_init = virtio_shared_memory_mapping_instance_init,
>+    .instance_finalize = virtio_shared_memory_mapping_instance_finalize,
>+};
>+
> static void virtio_register_types(void)
> {
>     type_register_static(&virtio_device_info);
>+    type_register_static(&virtio_shared_memory_mapping_info);
> }
>
> type_init(virtio_register_types)
>diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>index 27cd98d2fe..40d881ca09 100644
>--- a/include/hw/virtio/virtio.h
>+++ b/include/hw/virtio/virtio.h
>@@ -99,6 +99,45 @@ enum virtio_device_endian {
>     VIRTIO_DEVICE_ENDIAN_BIG,
> };
>
>+#define TYPE_VIRTIO_SHARED_MEMORY_MAPPING "virtio-shared-memory-mapping"
>+OBJECT_DECLARE_SIMPLE_TYPE(VirtioSharedMemoryMapping, VIRTIO_SHARED_MEMORY_MAPPING)
>+
>+/**
>+ * VirtioSharedMemoryMapping:
>+ * @parent: Parent QOM object
>+ * @shmid: VIRTIO Shared Memory Region ID
>+ * @fd: File descriptor for the shared memory region

`fd` is not there anymore.

The rest LGTM. I think we can eventually fix them later, so don't want 
to block this, but if you need to resend, please fix them.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


