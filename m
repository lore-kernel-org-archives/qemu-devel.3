Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C12C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8eu-0001Of-Ji; Wed, 12 Aug 2026 09:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8ej-00017U-PP; Wed, 12 Aug 2026 09:06:06 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8ei-0004yp-1l; Wed, 12 Aug 2026 09:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539783; bh=xa6qc6ds+/cMq8qQuyVfCm8NyU9DzJInKr0AjmnjZYw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Wi06HRhUaBKQSDSf4fWaC74vstwDyAZMN190S6rydhY8jdMdcXOz2spmJ5gSb22hK
 VRxk2uwx8zY6N1sLFgwO1LULMUmPArnhRZo3TYuamt40yjs/yoTVwNxcuZ/jxSMR7/
 2gpBPyBVBr/4jO4PvCkRNseiPKPhzL6KDbe7sMAAMX/Ke0tCNzwW3pm4kEC5hMKLWj
 WNO1DVmwJG8A7JOfI2ep+webxsSWhJWFLXZmm9qstTBDewSJp5IVOe+8DdACyxR23d
 xYmi6g+VI1AcccM6bpUliozFhxBU1mgX9hqmae8HZPhPV30L657G+XA52XppY4HV1l
 94lKDehYic3wg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B3B851CA4A2;
 Wed, 12 Aug 2026 16:03:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EA286409B85;
 Wed, 12 Aug 2026 16:03:14 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 26CB12F8DA; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 035/102] hw/display/virtio-gpu: Block Rutabaga
 migration
Date: Wed, 12 Aug 2026 16:01:10 +0300
Message-ID: <20260812130233.621965-35-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

The migration stream encoding is not defined for Rutabaga yet.

Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfxstream")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260725-rutabaga-v1-1-4832b56e679d@rsg.ci.i.u-tokyo.ac.jp>
(cherry picked from commit 5c9ef661a60ad737c61f4a872226376b5f2d424a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 3b71f389dc3..dbf9270fab0 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -9,6 +9,7 @@
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-gpu-pixman.h"
 #include "hw/virtio/virtio-iommu.h"
+#include "migration/blocker.h"
 
 #include <glib/gmem.h>
 #include <rutabaga_gfx/rutabaga_gfx_ffi.h>
@@ -1078,6 +1079,7 @@ static void virtio_gpu_rutabaga_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
 
 static void virtio_gpu_rutabaga_realize(DeviceState *qdev, Error **errp)
 {
+    ERRP_GUARD();
     uint32_t num_capsets;
     VirtIOGPUBase *bdev = VIRTIO_GPU_BASE(qdev);
     VirtIOGPU *gpudev = VIRTIO_GPU(qdev);
@@ -1087,12 +1089,17 @@ static void virtio_gpu_rutabaga_realize(DeviceState *qdev, Error **errp)
     return;
 #endif
 
-    if (!virtio_gpu_rutabaga_init(gpudev, errp)) {
+    error_setg(&bdev->migration_blocker, "rutabaga is not yet migratable");
+    if (migrate_add_blocker(&bdev->migration_blocker, errp) < 0) {
         return;
     }
 
+    if (!virtio_gpu_rutabaga_init(gpudev, errp)) {
+        goto fail;
+    }
+
     if (!virtio_gpu_rutabaga_get_num_capsets(gpudev, &num_capsets, errp)) {
-        return;
+        goto fail;
     }
 
     bdev->conf.flags |= (1 << VIRTIO_GPU_FLAG_RUTABAGA_ENABLED);
@@ -1101,6 +1108,12 @@ static void virtio_gpu_rutabaga_realize(DeviceState *qdev, Error **errp)
 
     bdev->virtio_config.num_capsets = num_capsets;
     virtio_gpu_device_realize(qdev, errp);
+    if (!*errp) {
+        return;
+    }
+
+fail:
+    migrate_del_blocker(&bdev->migration_blocker);
 }
 
 static const Property virtio_gpu_rutabaga_properties[] = {
-- 
2.47.3


