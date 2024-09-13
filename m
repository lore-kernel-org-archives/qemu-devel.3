Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C0FFA372A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 08:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp1M4-0005EQ-BX; Fri, 13 Sep 2024 04:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaozhenguo1@gmail.com>)
 id 1sp1M2-0005DD-CY
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 04:08:34 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yaozhenguo1@gmail.com>)
 id 1sp1M0-0004kU-KA
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 04:08:34 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7178df70f28so1445437b3a.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 01:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726214911; x=1726819711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8AXURNAi+BDX4azNt4WUsGR8sMriNn0bmqexN5+D+MU=;
 b=VFWJAkHqkN9iQJrpVE/S5dJMHSzJIS7gj+yMTuChcA7UMMlO593bXlt2JFFutw5ezi
 rdQXTgz40V9STm+B0LhJjSVU3F4Xfd/tJoaNFLxg1juK0BcrA2WY5FB1SJlB91Q+4YqJ
 nOB/mQpsWErd6Erw35DlG6iZAbqOTnWMVAuyhAgw0C+a2mOH5BVK6rAWCw83jU1cxrYy
 pa0n1D64bzJaj5EIFRzKmvaAgVN+pojG6AiYAgjnhkqw9fSbgyjU7okbmznw5Iy5K1X3
 G39S5TGlTjqDRfvh2moQTUwuQjzRCvMCugRrTo7tIOU0eeTKIvkhIim8qpeAIcgMMjOs
 zEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726214911; x=1726819711;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8AXURNAi+BDX4azNt4WUsGR8sMriNn0bmqexN5+D+MU=;
 b=I5b1bXKZvzf9SWwG7UChPQOMomXcGFTcwdsWM39FwRTU662sTy5u7DgsNts20d1act
 itd+VEyFSeF6Y/rIxEm+fgpuBUeS+NKt5AiO2q4F4d9IV2rtZ8d2z8iAzgHUBZzFZiqC
 U1NmP3t/ed983xav5IEYwnOlrJJJ2a0AhMu5XdfMjHF06TQfO7G9p1qNI1NRbJZgPZNR
 pHAMUYjN8hzI8Bidr0x3Uw+ruqtzY/FPaePvzwSYhbXIyjW5mlSX2fprobBeZCaZdE+5
 RFa1qIx46O+DXK7aMTPMuOBZ4ikaqMQW/S3C/OI2/59Zq7w+gz6ToCDe2PD6m7GAat1N
 N8/Q==
X-Gm-Message-State: AOJu0YzAlDbh0/m3RvoTx4qRYL8D3hicKpTGGupU1QC587IDJQB/j7Uk
 m4tvUwvfxwQUsO9+K+M2b2CUF8uB4xO5OozZb4JCXHtxkLUcMoXV
X-Google-Smtp-Source: AGHT+IHL65v/9Y4IZomWevQGvrRZUSTaCw0v5jp2mqo5STr3Ewzvz/9FN+hi/reohBDN0cJSdaTLwg==
X-Received: by 2002:a05:6a20:ac43:b0:1cf:36f2:21e9 with SMTP id
 adf61e73a8af0-1cf76358fdfmr7223972637.32.1726214910634; 
 Fri, 13 Sep 2024 01:08:30 -0700 (PDT)
Received: from localhost.localdomain ([2408:80e0:41fc:0:fe2d:0:1:8699])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe5309sm5635701b3a.84.2024.09.13.01.08.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Sep 2024 01:08:30 -0700 (PDT)
From: yaozhenguo <yaozhenguo1@gmail.com>
X-Google-Original-From: yaozhenguo <yaozhenguo@jd.com>
To: alex.bennee@linaro.org,
	mst@redhat.com,
	sgarzare@redhat.com
Cc: qemu-devel@nongnu.org,
	yaozhenguo@jd.com
Subject: [PATCH V1] virtio/vhost-user: fix qemu abort when hotunplug
 vhost-user-net device
Date: Fri, 13 Sep 2024 16:08:00 +0800
Message-Id: <20240913080800.40816-1-yaozhenguo@jd.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=yaozhenguo1@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

During the process of hot-unplug in vhost-user-net NIC, vhost_user_cleanup
may add same rcu node to rcu list. Function calls are as follows:

vhost_user_cleanup
    ->vhost_user_host_notifier_remove
        ->call_rcu(n, vhost_user_host_notifier_free, rcu);
    ->g_free_rcu(n, rcu);

When this happens, QEMU will abort in try_dequeue:

if (head == &dummy && qatomic_mb_read(&tail) == &dummy.next) {
    abort();
}

Backtrace is as follows:
0  __pthread_kill_implementation () at /usr/lib64/libc.so.6
1  raise () at /usr/lib64/libc.so.6
2  abort () at /usr/lib64/libc.so.6
3  try_dequeue () at ../util/rcu.c:235
4  call_rcu_thread (0) at ../util/rcu.c:288
5  qemu_thread_start (0) at ../util/qemu-thread-posix.c:541
6  start_thread () at /usr/lib64/libc.so.6
7  clone3 () at /usr/lib64/libc.so.6

Reason for the abort is that adding two identical nodes to the rcu list will
cause it becomes a ring. After dummy node is added to the tail of the list in
try_dequeue, the ring is opened. But lead to a situation that only one node is
added to list and rcu_call_count is added twice. This will cause try_dequeue
abort.

This issue happens when n->addr != 0 in vhost_user_host_notifier_remove. It can
happens in a hotplug stress test with a 32queue vhost-user-net type NIC.
Because n->addr is set in VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG function.
during device hotplug process and it is cleared in vhost_dev_stop during device
hot-unplug. Since VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG is a message sent
by DPDK to qemu, it is asynchronous. So, there is no guaranteed order between
the two processes of setting n->addr and clearing n->addr. If setting n->addr
in hotplug occurs after clearing n->addr in hotunplug, the issue will occur.
So, it is necessary to merge g_free_rcu and vhost_user_host_notifier_free into
one rcu node.

Fixes: 503e355465 ("virtio/vhost-user: dynamically assign VhostUserHostNotifiers")

Signed-off-by: yaozhenguo <yaozhenguo@jd.com>
---
 hw/virtio/vhost-user.c         | 34 ++++++++++++++++++----------------
 include/hw/virtio/vhost-user.h |  1 +
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 00561da..b2da3cf 100644
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
+    if (n->need_free) {
+        memory_region_transaction_begin();
+        object_unparent(OBJECT(&n->mr));
+        memory_region_transaction_commit();
+        g_free(n);
+    }
 }
 
 /*
@@ -1195,17 +1202,20 @@ static void vhost_user_host_notifier_free(VhostUserHostNotifier *n)
  * under rcu.
  */
 static void vhost_user_host_notifier_remove(VhostUserHostNotifier *n,
-                                            VirtIODevice *vdev)
+                                            VirtIODevice *vdev, bool free)
 {
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
+    n->need_free = free;
+    call_rcu(n, vhost_user_host_notifier_free, rcu);
 }
 
 static int vhost_user_set_vring_base(struct vhost_dev *dev,
@@ -1280,7 +1290,7 @@ static int vhost_user_get_vring_base(struct vhost_dev *dev,
 
     VhostUserHostNotifier *n = fetch_notifier(u->user, ring->index);
     if (n) {
-        vhost_user_host_notifier_remove(n, dev->vdev);
+        vhost_user_host_notifier_remove(n, dev->vdev, false);
     }
 
     ret = vhost_user_write(dev, &msg, NULL, 0);
@@ -1562,7 +1572,7 @@ static int vhost_user_backend_handle_vring_host_notifier(struct vhost_dev *dev,
      * new mapped address.
      */
     n = fetch_or_create_notifier(user, queue_idx);
-    vhost_user_host_notifier_remove(n, vdev);
+    vhost_user_host_notifier_remove(n, vdev, false);
 
     if (area->u64 & VHOST_USER_VRING_NOFD_MASK) {
         return 0;
@@ -2737,13 +2747,7 @@ static void vhost_user_state_destroy(gpointer data)
 {
     VhostUserHostNotifier *n = (VhostUserHostNotifier *) data;
     if (n) {
-        vhost_user_host_notifier_remove(n, NULL);
-        object_unparent(OBJECT(&n->mr));
-        /*
-         * We can't free until vhost_user_host_notifier_remove has
-         * done it's thing so schedule the free with RCU.
-         */
-        g_free_rcu(n, rcu);
+        vhost_user_host_notifier_remove(n, NULL, true);
     }
 }
 
@@ -2765,9 +2769,7 @@ void vhost_user_cleanup(VhostUserState *user)
     if (!user->chr) {
         return;
     }
-    memory_region_transaction_begin();
     user->notifiers = (GPtrArray *) g_ptr_array_free(user->notifiers, true);
-    memory_region_transaction_commit();
     user->chr = NULL;
 }
 
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 324cd86..a171f29 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -54,6 +54,7 @@ typedef struct VhostUserHostNotifier {
     void *addr;
     void *unmap_addr;
     int idx;
+    bool need_free;
 } VhostUserHostNotifier;
 
 /**
-- 
1.8.3.1


