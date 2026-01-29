Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088A4D6B07A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUku-0004uy-5a; Thu, 29 Jan 2026 11:20:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vlUko-0004sh-TJ
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:20:24 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vlUkk-0000e1-Lm
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:20:22 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6DFDE596AE1;
 Thu, 29 Jan 2026 17:20:15 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id W-2937ki1alH; Thu, 29 Jan 2026 17:20:13 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 54489596A38; Thu, 29 Jan 2026 17:20:13 +0100 (CET)
Message-ID: <87d6eafa7c7f7f62de0e82dd5c70cd0d0a4f59b8.1769703287.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1769703287.git.balaton@eik.bme.hu>
References: <cover.1769703287.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 1/4] memory: Remove memory_region_init_rom_device_nomigrate()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Thu, 29 Jan 2026 17:20:13 +0100 (CET)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

This function is never used, remove it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 docs/devel/memory.rst                         |  1 -
 include/system/memory.h                       | 27 ------------
 .../memory-region-housekeeping.cocci          |  8 ----
 system/memory.c                               | 41 ++++++-------------
 4 files changed, 13 insertions(+), 64 deletions(-)

diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
index f22146e56c..8558f70a42 100644
--- a/docs/devel/memory.rst
+++ b/docs/devel/memory.rst
@@ -114,7 +114,6 @@ the backing memory yourself, you can call the functions:
 
 - memory_region_init_ram_nomigrate()
 - memory_region_init_rom_nomigrate()
-- memory_region_init_rom_device_nomigrate()
 
 which only initialize the MemoryRegion and leave handling
 migration to the caller.
diff --git a/include/system/memory.h b/include/system/memory.h
index 8f8725ea2d..0562af3136 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1614,33 +1614,6 @@ bool memory_region_init_rom_nomigrate(MemoryRegion *mr,
                                       uint64_t size,
                                       Error **errp);
 
-/**
- * memory_region_init_rom_device_nomigrate:  Initialize a ROM memory region.
- *                                 Writes are handled via callbacks.
- *
- * Note that this function does not do anything to cause the data in the
- * RAM side of the memory region to be migrated; that is the responsibility
- * of the caller.
- *
- * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
- * @ops: callbacks for write access handling (must not be NULL).
- * @opaque: passed to the read and write callbacks of the @ops structure.
- * @name: Region name, becomes part of RAMBlock name used in migration stream
- *        must be unique within any device
- * @size: size of the region.
- * @errp: pointer to Error*, to store an error if it happens.
- *
- * Return: true on success, else false setting @errp with error.
- */
-bool memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
-                                             Object *owner,
-                                             const MemoryRegionOps *ops,
-                                             void *opaque,
-                                             const char *name,
-                                             uint64_t size,
-                                             Error **errp);
-
 /**
  * memory_region_init_iommu: Initialize a memory region of a custom type
  * that translates addresses
diff --git a/scripts/coccinelle/memory-region-housekeeping.cocci b/scripts/coccinelle/memory-region-housekeeping.cocci
index 29651ebde9..7f89e9712e 100644
--- a/scripts/coccinelle/memory-region-housekeeping.cocci
+++ b/scripts/coccinelle/memory-region-housekeeping.cocci
@@ -97,14 +97,6 @@ expression NAME;
 expression SIZE;
 expression ERRP;
 @@
--memory_region_init_rom_device_nomigrate(MR, NULL, OPS, OPAQUE, NAME, SIZE, ERRP);
-+memory_region_init_rom_device(MR, NULL, OPS, OPAQUE, NAME, SIZE, ERRP);
- ...
--vmstate_register_ram_global(MR);
-
-
-// Device is owner
-@@
 typedef DeviceState;
 identifier device_fn, dev, obj;
 expression E1, E2, E3, E4, E5;
diff --git a/system/memory.c b/system/memory.c
index 4bf00d82bc..a9032fb2cf 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1748,32 +1748,6 @@ bool memory_region_init_rom_nomigrate(MemoryRegion *mr,
     return true;
 }
 
-bool memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
-                                             Object *owner,
-                                             const MemoryRegionOps *ops,
-                                             void *opaque,
-                                             const char *name,
-                                             uint64_t size,
-                                             Error **errp)
-{
-    Error *err = NULL;
-    assert(ops);
-    memory_region_init(mr, owner, name, size);
-    mr->ops = ops;
-    mr->opaque = opaque;
-    mr->terminates = true;
-    mr->rom_device = true;
-    mr->destructor = memory_region_destructor_ram;
-    mr->ram_block = qemu_ram_alloc(size, 0, mr, &err);
-    if (err) {
-        mr->size = int128_zero();
-        object_unparent(OBJECT(mr));
-        error_propagate(errp, err);
-        return false;
-    }
-    return true;
-}
-
 void memory_region_init_iommu(void *_iommu_mr,
                               size_t instance_size,
                               const char *mrtypename,
@@ -3802,9 +3776,20 @@ bool memory_region_init_rom_device(MemoryRegion *mr,
                                    Error **errp)
 {
     DeviceState *owner_dev;
+    Error *err = NULL;
 
-    if (!memory_region_init_rom_device_nomigrate(mr, owner, ops, opaque,
-                                                 name, size, errp)) {
+    assert(ops);
+    memory_region_init(mr, owner, name, size);
+    mr->ops = ops;
+    mr->opaque = opaque;
+    mr->terminates = true;
+    mr->rom_device = true;
+    mr->destructor = memory_region_destructor_ram;
+    mr->ram_block = qemu_ram_alloc(size, 0, mr, &err);
+    if (err) {
+        mr->size = int128_zero();
+        object_unparent(OBJECT(mr));
+        error_propagate(errp, err);
         return false;
     }
     /* This will assert if owner is neither NULL nor a DeviceState.
-- 
2.41.3


