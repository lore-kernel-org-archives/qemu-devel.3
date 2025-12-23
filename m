Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4203E748F7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 21:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYAGd-0002sK-61; Tue, 23 Dec 2025 16:50:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vYAGb-0002rR-96
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 16:50:05 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vYAGZ-0006tn-By
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 16:50:05 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 32627596A03;
 Tue, 23 Dec 2025 22:50:02 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id ZoGEs03-kd50; Tue, 23 Dec 2025 22:50:00 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 33007596A07; Tue, 23 Dec 2025 22:50:00 +0100 (CET)
Message-ID: <5b4c9ebe17612ae45e6df24ba1d510f4b4e3b98d.1766525089.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1766525089.git.balaton@eik.bme.hu>
References: <cover.1766525089.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 4/6] memory: Shorten memory_region_init_rom_nomigrate
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael S. Tsirkin <mst@redhat.com>,
 philmd@linaro.org
Date: Tue, 23 Dec 2025 22:50:00 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Use the shortcut memory_region_init_ram_nomigrate as we have no flags
to pass and remove some extra line breaks to make the function occupy
less lines. Also shorten some other function prototypes.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 system/memory.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 3d538fb9af..bff9677f7a 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1568,12 +1568,9 @@ static void memory_region_set_ops(MemoryRegion *mr,
     mr->terminates = true;
 }
 
-void memory_region_init_io(MemoryRegion *mr,
-                           Object *owner,
-                           const MemoryRegionOps *ops,
-                           void *opaque,
-                           const char *name,
-                           uint64_t size)
+void memory_region_init_io(MemoryRegion *mr, Object *owner,
+                           const MemoryRegionOps *ops, void *opaque,
+                           const char *name, uint64_t size)
 {
     memory_region_init(mr, owner, name, size);
     memory_region_set_ops(mr, ops, opaque);
@@ -1689,30 +1686,23 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr, Object *owner,
     mr->ram_device = true;
 }
 
-void memory_region_init_alias(MemoryRegion *mr,
-                              Object *owner,
-                              const char *name,
-                              MemoryRegion *orig,
-                              hwaddr offset,
-                              uint64_t size)
+void memory_region_init_alias(MemoryRegion *mr, Object *owner,
+                              const char *name, MemoryRegion *orig,
+                              hwaddr offset, uint64_t size)
 {
     memory_region_init(mr, owner, name, size);
     mr->alias = orig;
     mr->alias_offset = offset;
 }
 
-bool memory_region_init_rom_nomigrate(MemoryRegion *mr,
-                                      Object *owner,
-                                      const char *name,
-                                      uint64_t size,
+bool memory_region_init_rom_nomigrate(MemoryRegion *mr, Object *owner,
+                                      const char *name, uint64_t size,
                                       Error **errp)
 {
-    if (!memory_region_init_ram_flags_nomigrate(mr, owner, name,
-                                                size, 0, errp)) {
-         return false;
+    if (!memory_region_init_ram_nomigrate(mr, owner, name, size, errp)) {
+        return false;
     }
     mr->readonly = true;
-
     return true;
 }
 
-- 
2.41.3


