Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51551EA794C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 01:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnnw7-0002dx-OL; Wed, 04 Feb 2026 20:13:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vnnw3-0002bq-4i
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 20:13:31 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vnnvy-0002zk-1Y
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 20:13:29 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 72C50596AE1;
 Thu, 05 Feb 2026 02:13:22 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id VZaph-9X30w5; Thu,  5 Feb 2026 02:13:20 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5DED4596A42; Thu, 05 Feb 2026 02:13:20 +0100 (CET)
Message-ID: <088d103e1e6999616b6fec0b175f4699bcffa26a.1770253186.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1770253186.git.balaton@eik.bme.hu>
References: <cover.1770253186.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 2/8] memory: Remove memory_region_init_rom_nomigrate()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Thu, 05 Feb 2026 02:13:20 +0100 (CET)
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

All users were converted so no longer needed.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 docs/devel/memory.rst                         |  1 -
 include/system/memory.h                       | 26 -----------------
 .../memory-region-housekeeping.cocci          | 28 -------------------
 system/memory.c                               | 19 ++-----------
 4 files changed, 3 insertions(+), 71 deletions(-)

diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
index 8558f70a42..0bb5acab21 100644
--- a/docs/devel/memory.rst
+++ b/docs/devel/memory.rst
@@ -113,7 +113,6 @@ have a special case where you need to manage the migration of
 the backing memory yourself, you can call the functions:
 
 - memory_region_init_ram_nomigrate()
-- memory_region_init_rom_nomigrate()
 
 which only initialize the MemoryRegion and leave handling
 migration to the caller.
diff --git a/include/system/memory.h b/include/system/memory.h
index 0562af3136..7117699b10 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1588,32 +1588,6 @@ void memory_region_init_alias(MemoryRegion *mr,
                               hwaddr offset,
                               uint64_t size);
 
-/**
- * memory_region_init_rom_nomigrate: Initialize a ROM memory region.
- *
- * This has the same effect as calling memory_region_init_ram_nomigrate()
- * and then marking the resulting region read-only with
- * memory_region_set_readonly().
- *
- * Note that this function does not do anything to cause the data in the
- * RAM side of the memory region to be migrated; that is the responsibility
- * of the caller.
- *
- * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
- * @name: Region name, becomes part of RAMBlock name used in migration stream
- *        must be unique within any device
- * @size: size of the region.
- * @errp: pointer to Error*, to store an error if it happens.
- *
- * Return: true on success, else false setting @errp with error.
- */
-bool memory_region_init_rom_nomigrate(MemoryRegion *mr,
-                                      Object *owner,
-                                      const char *name,
-                                      uint64_t size,
-                                      Error **errp);
-
 /**
  * memory_region_init_iommu: Initialize a memory region of a custom type
  * that translates addresses
diff --git a/scripts/coccinelle/memory-region-housekeeping.cocci b/scripts/coccinelle/memory-region-housekeeping.cocci
index 7f89e9712e..e45703141a 100644
--- a/scripts/coccinelle/memory-region-housekeeping.cocci
+++ b/scripts/coccinelle/memory-region-housekeeping.cocci
@@ -16,17 +16,10 @@
 expression E1, E2, E3, E4, E5;
 symbol true;
 @@
-(
 - memory_region_init_ram(E1, E2, E3, E4, E5);
 + memory_region_init_rom(E1, E2, E3, E4, E5);
   ... WHEN != E1
 - memory_region_set_readonly(E1, true);
-|
-- memory_region_init_ram_nomigrate(E1, E2, E3, E4, E5);
-+ memory_region_init_rom_nomigrate(E1, E2, E3, E4, E5);
-  ... WHEN != E1
-- memory_region_set_readonly(E1, true);
-)
 
 
 @possible_memory_region_init_rom@
@@ -53,11 +46,7 @@ cocci.print_main("potential use of memory_region_init_rom*() in ", p)
 expression ROM, E1, E2, E3, E4;
 expression ALIAS, E5, E6, E7, E8;
 @@
-(
   memory_region_init_rom(ROM, E1, E2, E3, E4);
-|
-  memory_region_init_rom_nomigrate(ROM, E1, E2, E3, E4);
-)
   ...
    memory_region_init_alias(ALIAS, E5, E6, ROM, E7, E8);
 -  memory_region_set_readonly(ALIAS, true);
@@ -80,23 +69,6 @@ expression ERRP;
  ...
 -vmstate_register_ram_global(MR);
 @@
-expression MR;
-expression NAME;
-expression SIZE;
-expression ERRP;
-@@
--memory_region_init_rom_nomigrate(MR, NULL, NAME, SIZE, ERRP);
-+memory_region_init_rom(MR, NULL, NAME, SIZE, ERRP);
- ...
--vmstate_register_ram_global(MR);
-@@
-expression MR;
-expression OPS;
-expression OPAQUE;
-expression NAME;
-expression SIZE;
-expression ERRP;
-@@
 typedef DeviceState;
 identifier device_fn, dev, obj;
 expression E1, E2, E3, E4, E5;
diff --git a/system/memory.c b/system/memory.c
index c51d0798a8..65042bd9fa 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1738,21 +1738,6 @@ void memory_region_init_alias(MemoryRegion *mr,
     mr->alias_offset = offset;
 }
 
-bool memory_region_init_rom_nomigrate(MemoryRegion *mr,
-                                      Object *owner,
-                                      const char *name,
-                                      uint64_t size,
-                                      Error **errp)
-{
-    if (!memory_region_init_ram_flags_nomigrate(mr, owner, name,
-                                                size, 0, errp)) {
-         return false;
-    }
-    mr->readonly = true;
-
-    return true;
-}
-
 void memory_region_init_iommu(void *_iommu_mr,
                               size_t instance_size,
                               const char *mrtypename,
@@ -3757,9 +3742,11 @@ bool memory_region_init_rom(MemoryRegion *mr,
 {
     DeviceState *owner_dev;
 
-    if (!memory_region_init_rom_nomigrate(mr, owner, name, size, errp)) {
+    if (!memory_region_init_ram_flags_nomigrate(mr, owner, name,
+                                                size, 0, errp)) {
         return false;
     }
+    mr->readonly = true;
     /* This will assert if owner is neither NULL nor a DeviceState.
      * We only want the owner here for the purposes of defining a
      * unique name for migration. TODO: Ideally we should implement
-- 
2.41.3


