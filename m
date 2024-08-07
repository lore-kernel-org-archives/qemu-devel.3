Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F63C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 13:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbgPg-0001a1-3A; Wed, 07 Aug 2024 09:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaozhenguo1@gmail.com>)
 id 1sbdOC-000766-5g
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 05:55:28 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yaozhenguo1@gmail.com>)
 id 1sbdOA-0004D2-EA
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 05:55:27 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7105043330aso1437396b3a.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 02:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723024525; x=1723629325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Uviacm/uMbm2emfL4M26wkPAMIKsc8+30xZJBnQdb0I=;
 b=H1ItiyK6eB++yyaDiXd6TaCn4l/p5Hd/EOPI3DNTUnyCsxkntL/CPcPcpMPPrxBHF9
 aOilttMIrZZRnLHYm8dOcCjxNZwnyJzy2RJvXJVUNFEviFC1HTh63dTKbB8Me2Z5WtOl
 ndYHyHVR+deUFKJJa7XEYQL/UfF13ueGG6IlX4IG2x3OFdKCT7DrcnnpD39gI8s66XXZ
 7HvqAuUFWIQbiHX6ukC3y3UdP10804CSBj1Ujrp0n6Kepdmf7Btm4RLra+S7PdMwmXAa
 YW9bMpbLhm2y+c6LVKJk8+/65pfwHtb85ozWmNw9Lly06Fzq8tvWSVxLIuBGkeDRHhlM
 y+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723024525; x=1723629325;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uviacm/uMbm2emfL4M26wkPAMIKsc8+30xZJBnQdb0I=;
 b=d7iHwxFlZJr6ezDeIGg2cl24Ixm0TLRIWtZ++bwZa5BSHyoFvXgMOrLeLylgiMhyEj
 HtTonFtG95F86T0ltxhg5iWnHWNeQ3S/1jsMfzLe+ivqRGV430gAZtoxbFAmJzlCqSS/
 jpf660PRkmjzHJWOGrjQ4BkrgFBkJuqOH5U6BK4QfEj0WwsVoSph7ynyIZSGUf5BQYB/
 oqAZLHCMkwR9b2lTRSE5q1HJ/D7F8+xAbqsQwyc0a/HOAugLhUGH9Bpr4Eu2bb0GpwoH
 4VFvXuMHEvCyrq5/ujxxF5iSnafjsdjJNUEocHkJVfdDnuCF9QOy8/5DIyJE+lsW1umh
 W+cA==
X-Gm-Message-State: AOJu0YyQ/YhmLSQsHnqMw9JT35Sl338MnalN/bpviRmjIsf3T2SHTi+j
 DcTQk2DxE5f9RllqAD/5FsOyP1cPuYn1X9Giyv3bRR36/07m7JW2X9HRvg==
X-Google-Smtp-Source: AGHT+IEcCSXz7WB7mKn3x6RxbzU1KtqyvlAsxlnb6mq/IXN+Ruky0V3E2UewjSvOLKEaE+IPQab9Og==
X-Received: by 2002:a05:6a00:17a0:b0:706:6af8:e088 with SMTP id
 d2e1a72fcca58-7106cfa1e92mr19953089b3a.3.1723024524487; 
 Wed, 07 Aug 2024 02:55:24 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.92])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec73d8csm8353474b3a.92.2024.08.07.02.55.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Aug 2024 02:55:24 -0700 (PDT)
From: yaozhenguo <yaozhenguo1@gmail.com>
X-Google-Original-From: yaozhenguo <yaozhenguo@jd.com>
To: alex.bennee@linaro.org,
	mst@redhat.com,
	sgarzare@redhat.com
Cc: qemu-devel@nongnu.org,
	yaozhenguo@jd.com
Subject: [PATCH] virtio/vhost-user: fix qemu crash when hotunplug
 vhost-user-net device
Date: Wed,  7 Aug 2024 17:55:08 +0800
Message-Id: <20240807095508.54750-1-yaozhenguo@jd.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=yaozhenguo1@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 07 Aug 2024 09:09:09 -0400
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

When hotplug and hotunplug vhost-user-net device quickly.
qemu will crash. BT is as below:

0  __pthread_kill_implementation () at /usr/lib64/libc.so.6
1  raise () at /usr/lib64/libc.so.6
2  abort () at /usr/lib64/libc.so.6
3  try_dequeue () at ../util/rcu.c:235
4  call_rcu_thread (opaque=opaque@entry=0x0) at ../util/rcu.c:288
5  qemu_thread_start (args=0x55b10d9ceaa0) at ../util/qemu-thread-posix.c:541
6  start_thread () at /usr/lib64/libc.so.6
7  clone3 () at /usr/lib64/libc.so.6

1. device_del qmp process

virtio_set_status
  vhost_dev_stop
    vhost_user_get_vring_base
      vhost_user_host_notifier_remove

vhost_user_slave_handle_vring_host_notifier maybe called asynchronous after
vhost_user_host_notifier_remove. vhost_user_host_notifier_remove will not
all call_rcu because of notifier->addr is NULL at this time.

2. netdev_del qmp process

vhost_user_cleanup
       vhost_user_host_notifier_remove
       g_free_rcu

vhost_user_host_notifier_remove and g_free_rcu will sumbit same rcu_head
to rcu node list. rcu_call_count add twice but only one node is added.
rcu thread will abort when calling try_dequeue with node list is empty.
Fix this by moving g_free(n) to vhost_user_host_notifier_free.

Fixes: 503e355465 ("virtio/vhost-user: dynamically assign VhostUserHostNotifiers")
Signed-off-by: yaozhenguo <yaozhenguo@jd.com>
---
 hw/virtio/vhost-user.c         | 23 +++++++++++------------
 include/hw/virtio/vhost-user.h |  1 +
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 00561daa06..7ab37c0da2 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1188,6 +1188,12 @@ static void vhost_user_host_notifier_free(VhostUserHostNotifier *n)
     assert(n && n->unmap_addr);
     munmap(n->unmap_addr, qemu_real_host_page_size());
     n->unmap_addr = NULL;
+    if (n->need_free) {
+        memory_region_transaction_begin();
+        object_unparent(OBJECT(&n->mr));
+        memory_region_transaction_commit();
+        g_free(n);
+    }
 }
 
 /*
@@ -1195,7 +1201,7 @@ static void vhost_user_host_notifier_free(VhostUserHostNotifier *n)
  * under rcu.
  */
 static void vhost_user_host_notifier_remove(VhostUserHostNotifier *n,
-                                            VirtIODevice *vdev)
+                                            VirtIODevice *vdev, bool free)
 {
     if (n->addr) {
         if (vdev) {
@@ -1204,6 +1210,7 @@ static void vhost_user_host_notifier_remove(VhostUserHostNotifier *n,
         assert(!n->unmap_addr);
         n->unmap_addr = n->addr;
         n->addr = NULL;
+        n->need_free = free;
         call_rcu(n, vhost_user_host_notifier_free, rcu);
     }
 }
@@ -1280,7 +1287,7 @@ static int vhost_user_get_vring_base(struct vhost_dev *dev,
 
     VhostUserHostNotifier *n = fetch_notifier(u->user, ring->index);
     if (n) {
-        vhost_user_host_notifier_remove(n, dev->vdev);
+        vhost_user_host_notifier_remove(n, dev->vdev, false);
     }
 
     ret = vhost_user_write(dev, &msg, NULL, 0);
@@ -1562,7 +1569,7 @@ static int vhost_user_backend_handle_vring_host_notifier(struct vhost_dev *dev,
      * new mapped address.
      */
     n = fetch_or_create_notifier(user, queue_idx);
-    vhost_user_host_notifier_remove(n, vdev);
+    vhost_user_host_notifier_remove(n, vdev, false);
 
     if (area->u64 & VHOST_USER_VRING_NOFD_MASK) {
         return 0;
@@ -2737,13 +2744,7 @@ static void vhost_user_state_destroy(gpointer data)
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
 
@@ -2765,9 +2766,7 @@ void vhost_user_cleanup(VhostUserState *user)
     if (!user->chr) {
         return;
     }
-    memory_region_transaction_begin();
     user->notifiers = (GPtrArray *) g_ptr_array_free(user->notifiers, true);
-    memory_region_transaction_commit();
     user->chr = NULL;
 }
 
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 324cd8663a..a171f29e0b 100644
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
2.43.0


