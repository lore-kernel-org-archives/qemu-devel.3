Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CA7D37E4D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 15:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg2iC-0000f4-EJ; Wed, 14 Jan 2026 10:23:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg2hd-0000Ft-AU
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 10:22:38 -0500
Received: from p-east2-cluster4-host2-snip4-9.eps.apple.com ([57.103.78.170]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg2ha-00007S-VD
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 10:22:33 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPS id
 5C3FF1800B93; Wed, 14 Jan 2026 15:22:27 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=lgwCp5DfxciUDn8r7r6up05OxWfXTLGq2WF/7T24a1c=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=FcuohIUzi34mKqTnIJEBI7H78oPg3uKWuSv1KUa5xB9w3cBUXpILtPA5D9z5lB8F9obdlxlPXCsVcFa5Fs6Igw3t/0ubMvSbBgzlL3fbPvrxPx4ayKJf+EkvGGV+XUKTap8v/wi3aXxGL+gKkyZ991z6TEejqzy44uF5qWl6UZtIAHVtV/CL2hJWYRDi/s+yjsPrI3I1BpmVzj+RJBi+GiCUWAU0JUue22wY4jZWOrXxKF/SyqKxDUIUTWdeAvAZ4ODKcek/l90VOlW4DiUhoLJWnR0vMAzSGdbY0bZZxA0wJ65igJC6/15sFXhGSgdJ8z24DEvFOVguntFUfjcKoA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPSA id
 A162718000BB; Wed, 14 Jan 2026 15:22:24 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v4 1/3] vmapple: apple-gfx: make it work on the latest macOS
 release
Date: Wed, 14 Jan 2026 16:22:18 +0100
Message-ID: <20260114152220.89640-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114152220.89640-1-mohamed@unpredictable.fr>
References: <20260114152220.89640-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: oR71TJI554D-g6OjIc1ED1wR-7pO8Y-k
X-Authority-Info: v=2.4 cv=aNH9aL9m c=1 sm=1 tr=0 ts=6967b4b4
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=XaNHVGzJZ3ayr3Wv:21 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=qV0ahJ5E5Ghjqxzh6q4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEyOCBTYWx0ZWRfX2iBNML6c2ODp
 xjhLWGg8lUCcvuomyUt+8EG+S20RalJP5QX4R9Wc+8UGWtKEZ7Md1+UpcbIrDthgXS4vel/wGBo
 cgSJ79WhhE9F2FQT9WdABfNIUMmw8jQWD1QlUyHWzSvBoFMqXjNg4P8MQTOGg4+4PpopGysv9lU
 OqDKZwbQib3Ow2hB3afp4+lc5JKZpEAG4sm3QZ2L5ckL6ku8Rxx+1C0W3uNH/s5mNq2RoYna1au
 ikKlIMfBGp5zrw7ynIt84JRSjkHHnygZVy8AhM7vCPoTMxYdDVUWV9v3oaPNHxslFCVXcuaO1AW
 5zEEh+mdhET0cmT9G3+
X-Proofpoint-ORIG-GUID: oR71TJI554D-g6OjIc1ED1wR-7pO8Y-k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 clxscore=1030 spamscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601140128
X-JNJ: AAAAAAABKNO+gPE5GxBrsxXb5fe1/ObWgbuNwDk8k9zJmXh7orkKmbmD/I/hHcEIyXRV2vV4gJT5AFYmivPb6Xy80DemTKQneHfpVxyEbsRb+0Jf9Kv+/KpLBiJmG6TAZUDCDUTookiCXNy5NOubMDoic458df8FXi7ZKsxBBguTQSlSshTticvIRVEoYexH6SWoK1X7B9itzui7MJcv0EWR5w2Di9aF75SOD86/E895zi28YZZgk+Chr9cIKYJkgWSlxc3SsqEs54j02Y8aNhUdenDhOLcLBPrkBuFY5fVb5oIsEeU8wenGyRzOsU2Pz1pf2Tiy4lvS5UGrtOs80zJFmm99p6lNmexiF6cL1skAkksHzX7ZzC2AYu4UFgGKYCcdSNZM0+NhDvLv2FY2pTAdr4uKf6u7F9sgXen+tM3iHeswvvDmZX9x1XZqJFYekBG515+pS7ycT0S6uORKUl1c6d1a9fOPoU9yeLqEfpzYGiQyHnnUjOmo4Ljdz7XO12FtpPPJnreitWFVWmhR2wv37i0JIRhVb3HnMagqWWy6nP7kr/vjcIwDtS9stf74x3Zxr6Fta7wOspgrioypPs8nZVMLna6Sd6dX5MQP8vghaaTWiw/jeyGoAjhF+CrhQgOIEYNV/MZe0brRuEW3aMhNZ1n38ora9wtehQ89BkHewC79s+sAIfmEY3I55eQGMkqL1IGowFHPHNgAGQw=
Received-SPF: pass client-ip=57.103.78.170;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Follow changes in memory management introduced on macOS 15.4.

The legacy memory management API has been removed for the IOSurface mapper on that macOS version.

Also enable process isolation for a sandboxed GPU process when on a new OS.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/display/apple-gfx-mmio.m | 65 ++++++++++++++++++++++++++++---------
 hw/display/apple-gfx.h      | 13 ++++++++
 hw/display/apple-gfx.m      | 47 ++++++++++++++++++++++++++-
 3 files changed, 109 insertions(+), 16 deletions(-)

diff --git a/hw/display/apple-gfx-mmio.m b/hw/display/apple-gfx-mmio.m
index 58beaadd1f..2031baceda 100644
--- a/hw/display/apple-gfx-mmio.m
+++ b/hw/display/apple-gfx-mmio.m
@@ -19,6 +19,7 @@
 #include "hw/core/irq.h"
 #include "apple-gfx.h"
 #include "trace.h"
+#include "system/address-spaces.h"
 
 #import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
 
@@ -34,14 +35,25 @@
 typedef bool(^IOSFCMapMemory)(uint64_t phys, uint64_t len, bool ro, void **va,
                               void *, void *);
 
+@interface PGMemoryMapDescriptor : NSObject
+-(void)addRange:(struct PGGuestPhysicalRange_s) range;
+@end
+
 @interface PGDeviceDescriptor (IOSurfaceMapper)
 @property (readwrite, nonatomic) bool usingIOSurfaceMapper;
+@property (readwrite, nonatomic) bool enableArgumentBuffers;
+@property (readwrite, nonatomic) bool enableProcessIsolation;
+@property (readwrite, nonatomic) bool enableProtectedContent;
+
+@property (readwrite, nonatomic, copy, nullable) PGMemoryMapDescriptor* memoryMapDescriptor;
 @end
 
 @interface PGIOSurfaceHostDeviceDescriptor : NSObject
 -(PGIOSurfaceHostDeviceDescriptor *)init;
 @property (readwrite, nonatomic, copy, nullable) IOSFCMapMemory mapMemory;
 @property (readwrite, nonatomic, copy, nullable) IOSFCUnmapMemory unmapMemory;
+@property (readwrite, nonatomic, copy, nullable) PGMemoryMapDescriptor* memoryMapDescriptor;
+@property (readwrite, nonatomic) unsigned long long mmioLength;
 @property (readwrite, nonatomic, copy, nullable) IOSFCRaiseInterrupt raiseInterrupt;
 @end
 
@@ -182,20 +194,33 @@ static bool apple_gfx_mmio_unmap_surface_memory(void *ptr)
     PGIOSurfaceHostDeviceDescriptor *iosfc_desc =
         [PGIOSurfaceHostDeviceDescriptor new];
     PGIOSurfaceHostDevice *iosfc_host_dev;
-
-    iosfc_desc.mapMemory =
-        ^bool(uint64_t phys, uint64_t len, bool ro, void **va, void *e, void *f) {
-            *va = apple_gfx_mmio_map_surface_memory(phys, len, ro);
-
-            trace_apple_gfx_iosfc_map_memory(phys, len, ro, va, e, f, *va);
-
-            return *va != NULL;
-        };
-
-    iosfc_desc.unmapMemory =
-        ^bool(void *va, void *b, void *c, void *d, void *e, void *f) {
-            return apple_gfx_mmio_unmap_surface_memory(va);
-        };
+    PGMemoryMapDescriptor* memoryMapDescriptor = [PGMemoryMapDescriptor new];
+
+    /*
+     * The legacy memory management API is no longer present
+     * for the IOSurface mapper as of macOS 15.4.
+     */
+    if (@available(macOS 15.4, *)) {
+        FlatView* fv = address_space_to_flatview(&address_space_memory);
+        flatview_for_each_range(fv, apple_gfx_register_memory_cb, memoryMapDescriptor);
+        /* Single-page MMIO region: 16KB */
+        iosfc_desc.mmioLength = 0x10000;
+        iosfc_desc.memoryMapDescriptor = memoryMapDescriptor;
+    } else {
+        iosfc_desc.mapMemory =
+            ^bool(uint64_t phys, uint64_t len, bool ro, void **va, void *e, void *f) {
+                *va = apple_gfx_mmio_map_surface_memory(phys, len, ro);
+
+                trace_apple_gfx_iosfc_map_memory(phys, len, ro, va, e, f, *va);
+
+                return *va != NULL;
+            };
+
+        iosfc_desc.unmapMemory =
+            ^bool(void *va, void *b, void *c, void *d, void *e, void *f) {
+                return apple_gfx_mmio_unmap_surface_memory(va);
+            };
+    }
 
     iosfc_desc.raiseInterrupt = ^bool(uint32_t vector) {
         trace_apple_gfx_iosfc_raise_irq(vector);
@@ -223,13 +248,23 @@ static void apple_gfx_mmio_realize(DeviceState *dev, Error **errp)
         };
 
         desc.usingIOSurfaceMapper = true;
-        s->pgiosfc = apple_gfx_prepare_iosurface_host_device(s);
+        desc.enableArgumentBuffers = true;
+        /* 
+         * Process isolation needs PGMemoryMapDescriptor instead of
+         * the legacy memory management interface present in releases
+         * older than macOS 15.4.
+         */
+        if (@available(macOS 15.4, *)) {
+            desc.enableProcessIsolation = true;
+        }
 
         if (!apple_gfx_common_realize(&s->common, dev, desc, errp)) {
             [s->pgiosfc release];
             s->pgiosfc = nil;
         }
 
+        s->pgiosfc = apple_gfx_prepare_iosurface_host_device(s);
+
         [desc release];
         desc = nil;
     }
diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h
index 3197bd853d..1b94a55a7d 100644
--- a/hw/display/apple-gfx.h
+++ b/hw/display/apple-gfx.h
@@ -23,6 +23,13 @@
 @protocol MTLTexture;
 @protocol MTLCommandQueue;
 
+typedef struct PGGuestPhysicalRange_s
+{
+    uint64_t physicalAddress;
+    uint64_t physicalLength;
+    void *hostAddress;
+} PGGuestPhysicalRange_t;
+
 typedef QTAILQ_HEAD(, PGTask_s) PGTaskList;
 
 typedef struct AppleGFXDisplayMode {
@@ -68,6 +75,12 @@ void *apple_gfx_host_ptr_for_gpa_range(uint64_t guest_physical,
                                        uint64_t length, bool read_only,
                                        MemoryRegion **mapping_in_region);
 
+bool apple_gfx_register_memory_cb(Int128 start,
+                            Int128 len,
+                            const MemoryRegion *mr,
+                            hwaddr offset_in_region,
+                            void *opaque);
+
 extern const PropertyInfo qdev_prop_apple_gfx_display_mode;
 
 #endif
diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index e0a765fcb1..68ca8e93b6 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -21,6 +21,7 @@
 #include "system/address-spaces.h"
 #include "system/dma.h"
 #include "migration/blocker.h"
+#include "system/memory.h"
 #include "ui/console.h"
 #include "apple-gfx.h"
 #include "trace.h"
@@ -596,6 +597,41 @@ void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char* obj_name)
     /* TODO: PVG framework supports serialising device state: integrate it! */
 }
 
+@interface PGMemoryMapDescriptor : NSObject
+-(void)addRange:(struct PGGuestPhysicalRange_s) range;
+@end
+
+@interface PGDeviceDescriptor (IOSurfaceMapper)
+@property (readwrite, nonatomic, copy, nullable) PGMemoryMapDescriptor* memoryMapDescriptor;
+@end
+
+bool apple_gfx_register_memory_cb(Int128 start,
+                            Int128 len,
+                            const MemoryRegion *mr,
+                            hwaddr offset_in_region,
+                            void *opaque) {
+    PGGuestPhysicalRange_t range;
+    PGMemoryMapDescriptor* memoryMapDescriptor = opaque;
+    if (mr->ram) {
+        range.physicalAddress = start;
+        range.physicalLength = len;
+        range.hostAddress = memory_region_get_ram_ptr(mr);
+        [memoryMapDescriptor addRange:range];
+    }
+    return false;
+}
+
+static void apple_gfx_register_memory(AppleGFXState *s,
+                                                     PGDeviceDescriptor *desc)
+{
+    PGMemoryMapDescriptor* memoryMapDescriptor = [PGMemoryMapDescriptor new];
+
+    FlatView* fv = address_space_to_flatview(&address_space_memory);
+    flatview_for_each_range(fv, apple_gfx_register_memory_cb, memoryMapDescriptor);
+
+    desc.memoryMapDescriptor = memoryMapDescriptor;
+}
+
 static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
                                                      PGDeviceDescriptor *desc)
 {
@@ -763,7 +799,16 @@ bool apple_gfx_common_realize(AppleGFXState *s, DeviceState *dev,
 
     desc.device = s->mtl;
 
-    apple_gfx_register_task_mapping_handlers(s, desc);
+    /* 
+     * The legacy memory management interface doesn't allow for
+     * vGPU sandboxing. As such, always use the new interface
+     * on macOS 15.4 onwards. 
+     */
+    if (@available(macOS 15.4, *)) {
+        apple_gfx_register_memory(s, desc);
+    } else {
+        apple_gfx_register_task_mapping_handlers(s, desc);
+    }
 
     s->cursor_show = true;
 
-- 
2.50.1 (Apple Git-155)


