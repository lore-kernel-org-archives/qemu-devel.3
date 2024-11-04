Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7820D1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84J6-000347-1p; Mon, 04 Nov 2024 16:08:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Ip-0002mP-Bh
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:08:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84In-0005R1-Ni
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eiDVC07ihD3E+eT5P1KT2iajuWbM2zWQGNYOe37hqBQ=;
 b=O60Jb03p3DkbKd6vr/e5yEhf6/6vX95OBksH5pwBU8rmjhSEkCGECWBGL4DPJgtagJzLkT
 bxl5fDHTBOApV2wp+JBoGeN7CEwtMr035lHcu+mKo/VUQtmH1s62RctNh/01GCzY5KWpVJ
 OGYzNFlYRUvHUTniWUF/QQdNxLG7TgY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-vtt-YCSSM4-2qDPFFVq_ig-1; Mon, 04 Nov 2024 16:07:56 -0500
X-MC-Unique: vtt-YCSSM4-2qDPFFVq_ig-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315544642eso34449445e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:07:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754474; x=1731359274;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eiDVC07ihD3E+eT5P1KT2iajuWbM2zWQGNYOe37hqBQ=;
 b=Km8/vPRcW/u1XKNCgFrfKqmgbrUP0QQZWSojinE8dIs07kOWD6Q+lOoxHg0CRHUvrw
 AH8ygkAmC9bKVmuKbG7cL/X+WuGdn+Rh+QmWKCidm9eq772PlHFWw/+LBQZdrw7RcmDG
 UyKoqfVuMogZ2frWFE7TllQ1qSJWdsBa0RaKi+xy54Hj/6PkHRSSwKbB6BeQOonHM6kO
 P1BvadYi7TQLl8t5K8BdlGisvc1zMzTST4M/S6MZtIe6rbvmIRKTwO+ILE308mRVl7Sh
 6AzpY0DHrCR8jRk/VfMn2JbBhp2ddlcPanOIaK53oXMiJ6wszI/4OUjklU/Bp/uUZROD
 niRg==
X-Gm-Message-State: AOJu0YzxyOtfLi7EMAD5Wt7kowyjnq4GXBdCK8vlkBAXkv3aCkcpti3k
 uNWSiDjMKKFVTJDYW5lvToDS5VyyR0MQlNY7TQyB2TMmZs9uHKHlbuVQMAJHc6HoLmxT0NAfnx0
 FXIZwkwdl+xzZC0iixc48oE8XA/DwCqf8Jf8qUhLBbGiPOJbcPfK7ZYScBYEVRpAIui5vJRcQ2n
 Dww8xrJ6xtqMZSRgVWda5Ys5VnBMyFzQ==
X-Received: by 2002:a05:600c:1c26:b0:432:9fdb:1490 with SMTP id
 5b1f17b1804b1-4329fdb1571mr19515005e9.7.1730754474376; 
 Mon, 04 Nov 2024 13:07:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGg4zXy6CILSRzJGN51NdBd/XWyGadrcWz8GUqq7CELFdyOB6K4PU34S00rLv5jleFJwPP8ag==
X-Received: by 2002:a05:600c:1c26:b0:432:9fdb:1490 with SMTP id
 5b1f17b1804b1-4329fdb1571mr19514745e9.7.1730754473854; 
 Mon, 04 Nov 2024 13:07:53 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9207d4sm191968705e9.20.2024.11.04.13.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:07:52 -0800 (PST)
Date: Mon, 4 Nov 2024 16:07:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 yaozhenguo <yaozhenguo1@gmail.com>, yaozhenguo <yaozhenguo@jd.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 34/65] virtio/vhost-user: fix qemu abort when hotunplug
 vhost-user-net device
Message-ID: <963b02764537c66af88b82bd297c375b147e0756.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: yaozhenguo <yaozhenguo1@gmail.com>

During the hot-unplugging of vhost-user-net type network cards,
the vhost_user_cleanup function may add the same rcu node to
the rcu linked list. The function call in this case is as follows:

vhost_user_cleanup
    ->vhost_user_host_notifier_remove
        ->call_rcu(n, vhost_user_host_notifier_free, rcu);
    ->g_free_rcu(n, rcu);

When this happens, QEMU will abort in try_dequeue:

if (head == &dummy && qatomic_mb_read(&tail) == &dummy.next) {
    abort();
}

backtrace is as follows:
0  __pthread_kill_implementation () at /usr/lib64/libc.so.6
1  raise () at /usr/lib64/libc.so.6
2  abort () at /usr/lib64/libc.so.6
3  try_dequeue () at ../util/rcu.c:235
4  call_rcu_thread (0) at ../util/rcu.c:288
5  qemu_thread_start (0) at ../util/qemu-thread-posix.c:541
6  start_thread () at /usr/lib64/libc.so.6
7  clone3 () at /usr/lib64/libc.so.6

The reason for the abort is that adding two identical nodes to
the rcu linked list will cause the rcu linked list to become a ring,
but when the dummy node is added after the two identical nodes,
the ring is opened. But only one node is added to list with
rcu_call_count added twice. This will cause rcu try_dequeue abort.

This happens when n->addr != 0. In some scenarios, this does happen.
For example, this situation will occur when using a 32-queue DPU
vhost-user-net type network card for hot-unplug testing, because
VhostUserHostNotifier->addr will be cleared during the processing of
VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG. However,it is asynchronous,
so we cannot guarantee that VhostUserHostNotifier->addr is zero in
vhost_user_cleanup. Therefore, it is necessary to merge g_free_rcu
and vhost_user_host_notifier_free into one rcu node.

Fixes: 503e355465 ("virtio/vhost-user: dynamically assign VhostUserHostNotifiers")
Signed-off-by: yaozhenguo <yaozhenguo@jd.com>
Message-Id: <20241011102913.45582-1-yaozhenguo@jd.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-user.h |  1 +
 hw/virtio/vhost-user.c         | 46 +++++++++++++++++++---------------
 2 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 324cd8663a..9a3f238b43 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -54,6 +54,7 @@ typedef struct VhostUserHostNotifier {
     void *addr;
     void *unmap_addr;
     int idx;
+    bool destroy;
 } VhostUserHostNotifier;
 
 /**
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 00561daa06..d1b0893b4d 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1185,9 +1185,16 @@ static int vhost_user_set_vring_num(struct vhost_dev *dev,
 
 static void vhost_user_host_notifier_free(VhostUserHostNotifier *n)
 {
-    assert(n && n->unmap_addr);
-    munmap(n->unmap_addr, qemu_real_host_page_size());
-    n->unmap_addr = NULL;
+    if (n->unmap_addr) {
+        munmap(n->unmap_addr, qemu_real_host_page_size());
+        n->unmap_addr = NULL;
+    }
+    if (n->destroy) {
+        memory_region_transaction_begin();
+        object_unparent(OBJECT(&n->mr));
+        memory_region_transaction_commit();
+        g_free(n);
+    }
 }
 
 /*
@@ -1195,17 +1202,28 @@ static void vhost_user_host_notifier_free(VhostUserHostNotifier *n)
  * under rcu.
  */
 static void vhost_user_host_notifier_remove(VhostUserHostNotifier *n,
-                                            VirtIODevice *vdev)
+                                            VirtIODevice *vdev, bool destroy)
 {
+    /*
+     * if destroy == false and n->addr == NULL, we have nothing to do.
+     * so, just return.
+     */
+    if (!n || (!destroy && !n->addr)) {
+        return;
+    }
+
     if (n->addr) {
         if (vdev) {
+            memory_region_transaction_begin();
             virtio_queue_set_host_notifier_mr(vdev, n->idx, &n->mr, false);
+            memory_region_transaction_commit();
         }
         assert(!n->unmap_addr);
         n->unmap_addr = n->addr;
         n->addr = NULL;
-        call_rcu(n, vhost_user_host_notifier_free, rcu);
     }
+    n->destroy = destroy;
+    call_rcu(n, vhost_user_host_notifier_free, rcu);
 }
 
 static int vhost_user_set_vring_base(struct vhost_dev *dev,
@@ -1279,9 +1297,7 @@ static int vhost_user_get_vring_base(struct vhost_dev *dev,
     struct vhost_user *u = dev->opaque;
 
     VhostUserHostNotifier *n = fetch_notifier(u->user, ring->index);
-    if (n) {
-        vhost_user_host_notifier_remove(n, dev->vdev);
-    }
+    vhost_user_host_notifier_remove(n, dev->vdev, false);
 
     ret = vhost_user_write(dev, &msg, NULL, 0);
     if (ret < 0) {
@@ -1562,7 +1578,7 @@ static int vhost_user_backend_handle_vring_host_notifier(struct vhost_dev *dev,
      * new mapped address.
      */
     n = fetch_or_create_notifier(user, queue_idx);
-    vhost_user_host_notifier_remove(n, vdev);
+    vhost_user_host_notifier_remove(n, vdev, false);
 
     if (area->u64 & VHOST_USER_VRING_NOFD_MASK) {
         return 0;
@@ -2736,15 +2752,7 @@ static int vhost_user_set_inflight_fd(struct vhost_dev *dev,
 static void vhost_user_state_destroy(gpointer data)
 {
     VhostUserHostNotifier *n = (VhostUserHostNotifier *) data;
-    if (n) {
-        vhost_user_host_notifier_remove(n, NULL);
-        object_unparent(OBJECT(&n->mr));
-        /*
-         * We can't free until vhost_user_host_notifier_remove has
-         * done it's thing so schedule the free with RCU.
-         */
-        g_free_rcu(n, rcu);
-    }
+    vhost_user_host_notifier_remove(n, NULL, true);
 }
 
 bool vhost_user_init(VhostUserState *user, CharBackend *chr, Error **errp)
@@ -2765,9 +2773,7 @@ void vhost_user_cleanup(VhostUserState *user)
     if (!user->chr) {
         return;
     }
-    memory_region_transaction_begin();
     user->notifiers = (GPtrArray *) g_ptr_array_free(user->notifiers, true);
-    memory_region_transaction_commit();
     user->chr = NULL;
 }
 
-- 
MST


