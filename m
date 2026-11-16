Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F10606A33B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=PYeVDoWT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3Dn-0003yE-CC; Mon, 16 Nov 2026 15:22:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3DW-0003oh-Vm; Mon, 16 Nov 2026 15:22:19 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3DV-0003Tn-Ee; Mon, 16 Nov 2026 15:22:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860372; bh=vJ9mTYAxINzO4+6RqRAmiYIRxqpG7yhYI7Ffie0aKws=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PYeVDoWTaIf15TC13lpr/pvgYTQ2ePU0XxP9mL83Cy14hMHnhmPCaZU/8WTKHA/pz
 3NWmn2xiV5cAJCvThnwi23oGlp5dXLMAQGG826f9ilaKg3CbFzlKzr9ZEF92SU+c8w
 6JlkDC+/eADpiCEE0kSSFXLDuETIXSRwHAjFCtGeH72b96vJrfL66x6R9T4VtZGARB
 kzbhlueLCBJvjDlS14j8ifUroz4Q0dPGZrqZ+5TZJf5o8+u80ZSuMJzZGcb5yYVPQu
 U1XEGGdIEDO1cXj1SdToisrv1I7NB6SIgBY1H0LjgeLgr8vS3AXfu/B7jB1NZY4ikJ
 i2KTbS/ZmFtrw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8A5E21E7156;
 Mon, 16 Nov 2026 23:19:32 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 87C6045FB8F;
 Mon, 16 Nov 2026 23:19:32 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 57D4CB8E0E; Mon, 16 Nov 2026 23:19:32 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>,
 Michael S. Tsirkin <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 32/59] vhost: vhost_virtqueue_start(): drop extra
 local variables
Date: Mon, 16 Nov 2026 23:18:36 +0300
Message-ID: <20261116201922.534306-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

One letter named variables doesn't really help to read the code,
and they simply duplicate structure fields.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420200339.708640-15-vsementsov@yandex-team.ru>
(cherry picked from commit 4801e50cf1af17ffdd80b4b01b3f57581c9b91cc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 86e6ca6ce7e..cda28118c8a 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1264,7 +1264,6 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
     VirtioBusState *vbus = VIRTIO_BUS(qbus);
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
-    hwaddr l;
     int r;
     int vhost_vq_index = dev->vhost_ops->vhost_get_vq_index(dev, idx);
     struct vhost_vring_file file = {
@@ -1289,23 +1288,17 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
         /* Queue might not be ready for start */
         return 0;
     }
-
-    l = vq->desc_size;
-    vq->desc = vhost_memory_map(dev, vq->desc_phys, l, false);
+    vq->desc = vhost_memory_map(dev, vq->desc_phys, vq->desc_size, false);
     if (!vq->desc) {
         r = -ENOMEM;
         goto fail;
     }
-
-    l = vq->avail_size;
-    vq->avail = vhost_memory_map(dev, vq->avail_phys, l, false);
+    vq->avail = vhost_memory_map(dev, vq->avail_phys, vq->avail_size, false);
     if (!vq->avail) {
         r = -ENOMEM;
         goto fail;
     }
-
-    l = vq->used_size;
-    vq->used = vhost_memory_map(dev, vq->used_phys, l, true);
+    vq->used = vhost_memory_map(dev, vq->used_phys, vq->used_size, true);
     if (!vq->used) {
         r = -ENOMEM;
         goto fail;
-- 
2.47.3


