Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3029E7C706
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 07:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpLrp-0000q2-IQ; Mon, 09 Feb 2026 02:39:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vpLrg-0000n7-R1
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:39:26 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vpLrb-0004gA-Dt
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:39:24 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 39935807F7;
 Mon, 09 Feb 2026 10:39:18 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:129::1:13])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id BdLXu72As8c0-vI9MJv00; Mon, 09 Feb 2026 10:39:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770622757;
 bh=IrKi0wkNb4EqfoJsPMr+89zx9dQBD2rZEgN7gLm9Wuc=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=UN9tpCFePLsDELbdRh2f4TR51dilj6Jw9e1PKCJUDApwlAq4y2e2klvm4ZHNt/Ouv
 Gvv4BMpKDnpE60stBLPFNi59dJ34+J8FxYF5tseFtUOLXRUIanA6haIQN6FJH1b+xE
 4IsvYpDp1ut4usgOWyU6p6ikYRcSrNBpE5Pg9Y6U=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH 08/10] vhost: rename vring pointer fields to reflect user
 addresses
Date: Mon,  9 Feb 2026 10:39:05 +0300
Message-ID: <20260209073908.2125178-9-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260209073908.2125178-1-vsementsov@yandex-team.ru>
References: <20260209073908.2125178-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Rename vq->desc/avail/used to vq->desc_user/avail_user/used_user to
clearly indicate these fields contain user space addresses, not
physical addresses.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost.c         | 37 +++++++++++++++++++------------------
 include/hw/virtio/vhost.h |  6 +++---
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 659efee2b0..1cde1aaebf 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -489,11 +489,11 @@ static void vhost_vrings_unmap(struct vhost_dev *dev,
         return;
     }
 
-    vhost_memory_unmap(dev, &vq->used, vq->used_size, touched,
+    vhost_memory_unmap(dev, &vq->used_user, vq->used_size, touched,
                        touched ? vq->used_size : 0);
-    vhost_memory_unmap(dev, &vq->avail, vq->avail_size, 0,
+    vhost_memory_unmap(dev, &vq->avail_user, vq->avail_size, 0,
                        touched ? vq->avail_size : 0);
-    vhost_memory_unmap(dev, &vq->desc, vq->desc_size, 0,
+    vhost_memory_unmap(dev, &vq->desc_user, vq->desc_size, 0,
                        touched ? vq->desc_size : 0);
 }
 
@@ -504,13 +504,13 @@ static int vhost_vrings_map(struct vhost_dev *dev,
 {
     vq->desc_size = virtio_queue_get_desc_size(vdev, idx);
     vq->desc_phys = virtio_queue_get_desc_addr(vdev, idx);
-    vq->desc = NULL;
+    vq->desc_user = NULL;
     vq->avail_size = virtio_queue_get_avail_size(vdev, idx);
     vq->avail_phys = virtio_queue_get_avail_addr(vdev, idx);
-    vq->avail = NULL;
+    vq->avail_user = NULL;
     vq->used_size = virtio_queue_get_used_size(vdev, idx);
     vq->used_phys = virtio_queue_get_used_addr(vdev, idx);
-    vq->used = NULL;
+    vq->used_user = NULL;
 
     if (vq->desc_phys == 0) {
         /* Queue might not be ready for start */
@@ -521,16 +521,17 @@ static int vhost_vrings_map(struct vhost_dev *dev,
         return 1;
     }
 
-    vq->desc = vhost_memory_map(dev, vq->desc_phys, vq->desc_size, false);
-    if (!vq->desc) {
+    vq->desc_user = vhost_memory_map(dev, vq->desc_phys, vq->desc_size, false);
+    if (!vq->desc_user) {
         goto fail;
     }
-    vq->avail = vhost_memory_map(dev, vq->avail_phys, vq->avail_size, false);
-    if (!vq->avail) {
+    vq->avail_user = vhost_memory_map(dev, vq->avail_phys, vq->avail_size,
+                                      false);
+    if (!vq->avail_user) {
         goto fail;
     }
-    vq->used = vhost_memory_map(dev, vq->used_phys, vq->used_size, true);
-    if (!vq->used) {
+    vq->used_user = vhost_memory_map(dev, vq->used_phys, vq->used_size, true);
+    if (!vq->used_user) {
         goto fail;
     }
 
@@ -594,7 +595,7 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
 
         j = 0;
         r = vhost_verify_ring_part_mapping(
-                vq->desc, vq->desc_phys, vq->desc_size,
+                vq->desc_user, vq->desc_phys, vq->desc_size,
                 reg_hva, reg_gpa, reg_size);
         if (r) {
             break;
@@ -602,7 +603,7 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
 
         j++;
         r = vhost_verify_ring_part_mapping(
-                vq->avail, vq->avail_phys, vq->avail_size,
+                vq->avail_user, vq->avail_phys, vq->avail_size,
                 reg_hva, reg_gpa, reg_size);
         if (r) {
             break;
@@ -610,7 +611,7 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
 
         j++;
         r = vhost_verify_ring_part_mapping(
-                vq->used, vq->used_phys, vq->used_size,
+                vq->used_user, vq->used_phys, vq->used_size,
                 reg_hva, reg_gpa, reg_size);
         if (r) {
             break;
@@ -1106,9 +1107,9 @@ static int vhost_virtqueue_set_addr(struct vhost_dev *dev,
         addr.avail_user_addr = (uint64_t)(unsigned long)vq->avail_phys;
         addr.used_user_addr = (uint64_t)(unsigned long)vq->used_phys;
     } else {
-        addr.desc_user_addr = (uint64_t)(unsigned long)vq->desc;
-        addr.avail_user_addr = (uint64_t)(unsigned long)vq->avail;
-        addr.used_user_addr = (uint64_t)(unsigned long)vq->used;
+        addr.desc_user_addr = (uint64_t)(unsigned long)vq->desc_user;
+        addr.avail_user_addr = (uint64_t)(unsigned long)vq->avail_user;
+        addr.used_user_addr = (uint64_t)(unsigned long)vq->used_user;
     }
     addr.index = idx;
     addr.log_guest_addr = vq->used_phys;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index b292e9f0fe..684bafcaad 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -24,9 +24,9 @@ struct vhost_inflight {
 struct vhost_virtqueue {
     int kick;
     int call;
-    void *desc;
-    void *avail;
-    void *used;
+    void *desc_user;
+    void *avail_user;
+    void *used_user;
     int num;
     unsigned long long desc_phys;
     unsigned desc_size;
-- 
2.52.0


