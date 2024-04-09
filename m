Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23971CD1297
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 07:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru5y4-0006oi-9r; Tue, 09 Apr 2024 03:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ru5y3-0006mK-KF
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 03:32:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ru5y1-0001d5-AL
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 03:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712647948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LWDhehH7wmu/YDkzC1AQ1ScvZA4zxlmQ/2HFjTowbXA=;
 b=cyM3lS3bjBfN2afEwjdE1Y8horatZ+Ez+ehiP17tJX6icBloSn077kMO/MR9AD5DtB8oTu
 G8jnctNuWK0VfeLYFtrxqdttaVkv2xL+DaNZ/yPIV1eHnlqzLXneFx0KhzGHqHay+dGvQo
 62VFLH//I8en3wTRiGIc8HmypFAE3R8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-lRFOqLklMWiQ83TGg93v7g-1; Tue, 09 Apr 2024 03:32:26 -0400
X-MC-Unique: lRFOqLklMWiQ83TGg93v7g-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-56e242ec7ffso2472003a12.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 00:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712647945; x=1713252745;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LWDhehH7wmu/YDkzC1AQ1ScvZA4zxlmQ/2HFjTowbXA=;
 b=HJccNYNQhnSRJn4hn8FbRddWIJg4AWsyaRf59WzK0qyn+MSQEDkGpa2w6uf10BUJ/w
 BzRH2GdENbdEM17NVo4vPCEFQUVZSERgIyRBJhbHEpvl3CxoTnWjQ+/SyqgKNvkrwEoC
 I6XEg9o5DL9Fyyg9XgkgUvEm6JaziZfBMBJKneZiLhlvb57ihD/eee6NGHPz4M8h37Uc
 wcKya6OcY+mao9cC3hEreRH0S++cxT3wiuYDutyJtnMu2idVJQNwLAWt91dnB1EiNrZS
 9uhfvTWdc62ozjIXIwYmCHOq6H1vNKh2aqwnahaibe5nzXf6pHclUeGfqMH6Fb3g2Du6
 mnQg==
X-Gm-Message-State: AOJu0YyQZ+eORIKhIBtOADXeJ/aifw27xaEAfdM8NpxiG/IKS1DNtLba
 vM/hbmypFr/F/wT+hs+fPQJWZnshfCGMHsZAhx4kRSxXSKKd5XIppe8Ekc19cGsDeEqIaJ8n1xk
 qdqIYXrpm03EUU8v//wkYibkELjdir8P+E2ByWmzpwNRHjCLlUF6nHSClA8VTjVtgiin/PqTs3G
 ByprVDRUQBclaNH3czFxp4qClabXkCcA==
X-Received: by 2002:a17:906:cce6:b0:a4d:ffcb:1f4e with SMTP id
 ot38-20020a170906cce600b00a4dffcb1f4emr5429065ejb.75.1712647944800; 
 Tue, 09 Apr 2024 00:32:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqu8lUNRb1sMNTGDqhKI9fo17fz7ExE4PiqihgeH5ybLxB/zp5bHKxHgr/tASPJjwrIu97jw==
X-Received: by 2002:a17:906:cce6:b0:a4d:ffcb:1f4e with SMTP id
 ot38-20020a170906cce600b00a4dffcb1f4emr5429041ejb.75.1712647944031; 
 Tue, 09 Apr 2024 00:32:24 -0700 (PDT)
Received: from redhat.com ([2.52.134.26]) by smtp.gmail.com with ESMTPSA id
 cw23-20020a170906c79700b00a51bf5932aesm3814519ejb.28.2024.04.09.00.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 00:32:23 -0700 (PDT)
Date: Tue, 9 Apr 2024 03:32:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 3/7] virtio-snd: rewrite invalid tx/rx message handling
Message-ID: <731655f87f319fd06f27282c6cafbc2467ac8045.1712647890.git.mst@redhat.com>
References: <cover.1712647890.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1712647890.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

The current handling of invalid virtqueue elements inside the TX/RX virt
queue handlers is wrong.

They are added in a per-stream invalid queue to be processed after the
handler is done examining each message, but the invalid message might
not be specifying any stream_id; which means it's invalid to add it to
any stream->invalid queue since stream could be NULL at this point.

This commit moves the invalid queue to the VirtIOSound struct which
guarantees there will always be a valid temporary place to store them
inside the tx/rx handlers. The queue will be emptied before the handler
returns, so the queue must be empty at any other point of the device's
lifetime.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <virtio-snd-rewrite-invalid-tx-rx-message-handling-v1.manos.pitsidianakis@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/audio/virtio-snd.h |  16 +++-
 hw/audio/virtio-snd.c         | 137 +++++++++++++++-------------------
 2 files changed, 77 insertions(+), 76 deletions(-)

diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index 3d79181364..8dafedb276 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -151,7 +151,6 @@ struct VirtIOSoundPCMStream {
     QemuMutex queue_mutex;
     bool active;
     QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) queue;
-    QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) invalid;
 };
 
 /*
@@ -223,6 +222,21 @@ struct VirtIOSound {
     QemuMutex cmdq_mutex;
     QTAILQ_HEAD(, virtio_snd_ctrl_command) cmdq;
     bool processing_cmdq;
+    /*
+     * Convenience queue to keep track of invalid tx/rx queue messages inside
+     * the tx/rx callbacks.
+     *
+     * In the callbacks as a first step we are emptying the virtqueue to handle
+     * each message and we cannot add an invalid message back to the queue: we
+     * would re-process it in subsequent loop iterations.
+     *
+     * Instead, we add them to this queue and after finishing examining every
+     * virtqueue element, we inform the guest for each invalid message.
+     *
+     * This queue must be empty at all times except for inside the tx/rx
+     * callbacks.
+     */
+    QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) invalid;
 };
 
 struct virtio_snd_ctrl_command {
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 30493f06a8..90d9a2796e 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -456,7 +456,6 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
         stream->s = s;
         qemu_mutex_init(&stream->queue_mutex);
         QSIMPLEQ_INIT(&stream->queue);
-        QSIMPLEQ_INIT(&stream->invalid);
 
         /*
          * stream_id >= s->snd_conf.streams was checked before so this is
@@ -611,9 +610,6 @@ static size_t virtio_snd_pcm_get_io_msgs_count(VirtIOSoundPCMStream *stream)
         QSIMPLEQ_FOREACH_SAFE(buffer, &stream->queue, entry, next) {
             count += 1;
         }
-        QSIMPLEQ_FOREACH_SAFE(buffer, &stream->invalid, entry, next) {
-            count += 1;
-        }
     }
     return count;
 }
@@ -831,47 +827,36 @@ static void virtio_snd_handle_event(VirtIODevice *vdev, VirtQueue *vq)
     trace_virtio_snd_handle_event();
 }
 
+/*
+ * Must only be called if vsnd->invalid is not empty.
+ */
 static inline void empty_invalid_queue(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOSoundPCMBuffer *buffer = NULL;
-    VirtIOSoundPCMStream *stream = NULL;
     virtio_snd_pcm_status resp = { 0 };
     VirtIOSound *vsnd = VIRTIO_SND(vdev);
-    bool any = false;
 
-    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
-        stream = vsnd->pcm->streams[i];
-        if (stream) {
-            any = false;
-            WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-                while (!QSIMPLEQ_EMPTY(&stream->invalid)) {
-                    buffer = QSIMPLEQ_FIRST(&stream->invalid);
-                    if (buffer->vq != vq) {
-                        break;
-                    }
-                    any = true;
-                    resp.status = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
-                    iov_from_buf(buffer->elem->in_sg,
-                                 buffer->elem->in_num,
-                                 0,
-                                 &resp,
-                                 sizeof(virtio_snd_pcm_status));
-                    virtqueue_push(vq,
-                                   buffer->elem,
-                                   sizeof(virtio_snd_pcm_status));
-                    QSIMPLEQ_REMOVE_HEAD(&stream->invalid, entry);
-                    virtio_snd_pcm_buffer_free(buffer);
-                }
-                if (any) {
-                    /*
-                     * Notify vq about virtio_snd_pcm_status responses.
-                     * Buffer responses must be notified separately later.
-                     */
-                    virtio_notify(vdev, vq);
-                }
-            }
-        }
+    g_assert(!QSIMPLEQ_EMPTY(&vsnd->invalid));
+
+    while (!QSIMPLEQ_EMPTY(&vsnd->invalid)) {
+        buffer = QSIMPLEQ_FIRST(&vsnd->invalid);
+        /* If buffer->vq != vq, our logic is fundamentally wrong, so bail out */
+        g_assert(buffer->vq == vq);
+
+        resp.status = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+        iov_from_buf(buffer->elem->in_sg,
+                     buffer->elem->in_num,
+                     0,
+                     &resp,
+                     sizeof(virtio_snd_pcm_status));
+        virtqueue_push(vq,
+                       buffer->elem,
+                       sizeof(virtio_snd_pcm_status));
+        QSIMPLEQ_REMOVE_HEAD(&vsnd->invalid, entry);
+        virtio_snd_pcm_buffer_free(buffer);
     }
+    /* Notify vq about virtio_snd_pcm_status responses. */
+    virtio_notify(vdev, vq);
 }
 
 /*
@@ -883,15 +868,14 @@ static inline void empty_invalid_queue(VirtIODevice *vdev, VirtQueue *vq)
  */
 static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
 {
-    VirtIOSound *s = VIRTIO_SND(vdev);
-    VirtIOSoundPCMStream *stream = NULL;
+    VirtIOSound *vsnd = VIRTIO_SND(vdev);
     VirtIOSoundPCMBuffer *buffer;
     VirtQueueElement *elem;
     size_t msg_sz, size;
     virtio_snd_pcm_xfer hdr;
     uint32_t stream_id;
     /*
-     * If any of the I/O messages are invalid, put them in stream->invalid and
+     * If any of the I/O messages are invalid, put them in vsnd->invalid and
      * return them after the for loop.
      */
     bool must_empty_invalid_queue = false;
@@ -901,7 +885,7 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
     }
     trace_virtio_snd_handle_tx_xfer();
 
-    for (;;) {
+    for (VirtIOSoundPCMStream *stream = NULL;; stream = NULL) {
         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
         if (!elem) {
             break;
@@ -913,16 +897,16 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
                             &hdr,
                             sizeof(virtio_snd_pcm_xfer));
         if (msg_sz != sizeof(virtio_snd_pcm_xfer)) {
-            continue;
+            goto tx_err;
         }
         stream_id = le32_to_cpu(hdr.stream_id);
 
-        if (stream_id >= s->snd_conf.streams
-            || s->pcm->streams[stream_id] == NULL) {
-            continue;
+        if (stream_id >= vsnd->snd_conf.streams
+            || vsnd->pcm->streams[stream_id] == NULL) {
+            goto tx_err;
         }
 
-        stream = s->pcm->streams[stream_id];
+        stream = vsnd->pcm->streams[stream_id];
         if (stream->info.direction != VIRTIO_SND_D_OUTPUT) {
             goto tx_err;
         }
@@ -942,13 +926,11 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
         continue;
 
 tx_err:
-        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-            must_empty_invalid_queue = true;
-            buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer));
-            buffer->elem = elem;
-            buffer->vq = vq;
-            QSIMPLEQ_INSERT_TAIL(&stream->invalid, buffer, entry);
-        }
+        must_empty_invalid_queue = true;
+        buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer));
+        buffer->elem = elem;
+        buffer->vq = vq;
+        QSIMPLEQ_INSERT_TAIL(&vsnd->invalid, buffer, entry);
     }
 
     if (must_empty_invalid_queue) {
@@ -965,15 +947,14 @@ tx_err:
  */
 static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
 {
-    VirtIOSound *s = VIRTIO_SND(vdev);
-    VirtIOSoundPCMStream *stream = NULL;
+    VirtIOSound *vsnd = VIRTIO_SND(vdev);
     VirtIOSoundPCMBuffer *buffer;
     VirtQueueElement *elem;
     size_t msg_sz, size;
     virtio_snd_pcm_xfer hdr;
     uint32_t stream_id;
     /*
-     * if any of the I/O messages are invalid, put them in stream->invalid and
+     * if any of the I/O messages are invalid, put them in vsnd->invalid and
      * return them after the for loop.
      */
     bool must_empty_invalid_queue = false;
@@ -983,7 +964,7 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
     }
     trace_virtio_snd_handle_rx_xfer();
 
-    for (;;) {
+    for (VirtIOSoundPCMStream *stream = NULL;; stream = NULL) {
         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
         if (!elem) {
             break;
@@ -995,16 +976,16 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
                             &hdr,
                             sizeof(virtio_snd_pcm_xfer));
         if (msg_sz != sizeof(virtio_snd_pcm_xfer)) {
-            continue;
+            goto rx_err;
         }
         stream_id = le32_to_cpu(hdr.stream_id);
 
-        if (stream_id >= s->snd_conf.streams
-            || !s->pcm->streams[stream_id]) {
-            continue;
+        if (stream_id >= vsnd->snd_conf.streams
+            || !vsnd->pcm->streams[stream_id]) {
+            goto rx_err;
         }
 
-        stream = s->pcm->streams[stream_id];
+        stream = vsnd->pcm->streams[stream_id];
         if (stream == NULL || stream->info.direction != VIRTIO_SND_D_INPUT) {
             goto rx_err;
         }
@@ -1021,13 +1002,11 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
         continue;
 
 rx_err:
-        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-            must_empty_invalid_queue = true;
-            buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer));
-            buffer->elem = elem;
-            buffer->vq = vq;
-            QSIMPLEQ_INSERT_TAIL(&stream->invalid, buffer, entry);
-        }
+        must_empty_invalid_queue = true;
+        buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer));
+        buffer->elem = elem;
+        buffer->vq = vq;
+        QSIMPLEQ_INSERT_TAIL(&vsnd->invalid, buffer, entry);
     }
 
     if (must_empty_invalid_queue) {
@@ -1127,6 +1106,7 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
         virtio_add_queue(vdev, 64, virtio_snd_handle_rx_xfer);
     qemu_mutex_init(&vsnd->cmdq_mutex);
     QTAILQ_INIT(&vsnd->cmdq);
+    QSIMPLEQ_INIT(&vsnd->invalid);
 
     for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
         status = virtio_snd_set_pcm_params(vsnd, i, &default_params);
@@ -1376,13 +1356,20 @@ static void virtio_snd_unrealize(DeviceState *dev)
 
 static void virtio_snd_reset(VirtIODevice *vdev)
 {
-    VirtIOSound *s = VIRTIO_SND(vdev);
+    VirtIOSound *vsnd = VIRTIO_SND(vdev);
     virtio_snd_ctrl_command *cmd;
 
-    WITH_QEMU_LOCK_GUARD(&s->cmdq_mutex) {
-        while (!QTAILQ_EMPTY(&s->cmdq)) {
-            cmd = QTAILQ_FIRST(&s->cmdq);
-            QTAILQ_REMOVE(&s->cmdq, cmd, next);
+    /*
+     * Sanity check that the invalid buffer message queue is emptied at the end
+     * of every virtio_snd_handle_tx_xfer/virtio_snd_handle_rx_xfer call, and
+     * must be empty otherwise.
+     */
+    g_assert(QSIMPLEQ_EMPTY(&vsnd->invalid));
+
+    WITH_QEMU_LOCK_GUARD(&vsnd->cmdq_mutex) {
+        while (!QTAILQ_EMPTY(&vsnd->cmdq)) {
+            cmd = QTAILQ_FIRST(&vsnd->cmdq);
+            QTAILQ_REMOVE(&vsnd->cmdq, cmd, next);
             virtio_snd_ctrl_cmd_free(cmd);
         }
     }
-- 
MST


