Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481CAE8FDBE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 15:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaF1q-0001Zi-TG; Mon, 29 Dec 2025 10:19:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaF1j-0001WB-9I
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 10:19:20 -0500
Received: from p-west1-cluster3-host6-snip4-5.eps.apple.com ([57.103.66.18]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaF1h-0004dZ-3o
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 10:19:18 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-10-percent-1 (Postfix) with ESMTPS id
 D755E1800293; Mon, 29 Dec 2025 15:19:12 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=lgwCp5DfxciUDn8r7r6up05OxWfXTLGq2WF/7T24a1c=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=UGc8MIpoYBZBd4ub7fNh0nRxV50+2j8/kmK+Wc1g0OSdnAFmVjGilIjOLhVyAXlMFApDlUFk/fmW3OoLeKAxRKrCPve8kS8GKngzJe6qbnZxDw5ClEafzY0VQwWWdAaqFiYJ3PartGWoHajRfwIdUlW8K8CiDROyzUyF6BeEABvI8PdT4h3cDVFhhbgfcmOVxs0pZmJY0ZC67aULQc/wyNcBL/ubK3jxK+IuOuHCtHkhCjDwNJnfBRdjV8E5GE4PFX6MmRGpHwjjtCI4vljrFbZO+eSX+whke0j/bdXQKwd/TuJxjUZF9HTDiHbOlsed9wYwmGayQGVVKAlyxh6jdw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-10-percent-1 (Postfix) with ESMTPSA id
 000DC18005BC; Mon, 29 Dec 2025 15:19:08 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [RFC v3 2/4] vmapple: apple-gfx: make it work on the latest macOS
 release
Date: Mon, 29 Dec 2025 16:18:48 +0100
Message-ID: <20251229151850.96852-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251229151850.96852-1-mohamed@unpredictable.fr>
References: <20251229151850.96852-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE0MCBTYWx0ZWRfXyMGK16BH7AJH
 QFR/P2A4xCGjYRgCmSmFIpi6X9URvYfqrPyHIcyM/1KZxECNzWxzj9Fm0E5g6igGXfNVefxwguy
 4AXw29GARW0KGHYrPAVw1HszrPshUZUzYSxT8rIVVHtUdOW6t6XVkqYGDKkmMA3+juS3wDqmNFF
 aryRjyvKUEaebh2OW4Bm0bp5VQ/JjM1rWicvz+k/MDw/5SpD33TOA84S7px9zDkaE+6D/w/Xl8Z
 BV8kCEG8FqzZy1zWX9YvaXZgsrSM16Sl6zHajc/970AZZiAswntTl3FvfqDrjQnTaBZrzyCd+P6
 GZwKUrowtWxui+RBmh+
X-Proofpoint-GUID: jTB4IL4EJfCznX7_eMSjKVNkxBWFjiEO
X-Authority-Info: v=2.4 cv=d+b4CBjE c=1 sm=1 tr=0 ts=69529bf1 cx=c_apl:c_pps
 a=azHRBMxVc17uSn+fyuI/eg==:117 a=azHRBMxVc17uSn+fyuI/eg==:17
 a=XaNHVGzJZ3ayr3Wv:21 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=qV0ahJ5E5Ghjqxzh6q4A:9
X-Proofpoint-ORIG-GUID: jTB4IL4EJfCznX7_eMSjKVNkxBWFjiEO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_04,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1030
 adultscore=0 phishscore=0 mlxlogscore=999 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512290140
X-JNJ: AAAAAAAB+FbBXeRK+XBThZrM7nu/u6Xy8c7jSQGFNR5Rd+mrXOnCyLIEbawzsKPjzuJHVRj8LzJRyfp/JpsAl4/sEdtydlVGcjpJPr+IaUQLG5w34AT3WRNbagWGaU1WcTH58GUfTczPWyKiZKNwAXTkDTGMDX4gL/ucUPDG/KNXTK/InxwDwvVv5rGdunQQ1xwU/fHI3ad69STk99u1TFF2itZIaAQFAIajhXn1BUQ8oslhnfstJOqB85LPkPZkFCdfQBPpLxp/SoXuTpfN7BL1wbpDeEoyEzzMnseIDJTZPO3RHTfFIlCKpmphLOsFT/q3ttz6SoiWyIQRyl5Hfpka/xA/7KPokGQ6ZifVRjSxDmvsqtCkR4TXxOD5u88ISLs9r/0rekTmC6AFZ6aKxvP9JLJq75Gkh7ScP9+GT1MTj/qtWm3aiCWPq89cSUXhZjRRyOM99YsGqbAWWq4XnP1Za5lsGoByN/fj84Fp4oJ3UKy9cGtJ4a9tvgvvfFgGzMWnbWmmg/vg5GtJpylCwx42wSitNROT/yH3ZH0RzJeBU/5W2+dYz0qs9WZJ6Y/v4al0JjzBqU6owWNFslEsy7TZkNiJoinQ1P4iaofi6WeKtheviCON/f113SEKh+YicL5RqDYdHG36BSvbLsUUC3/8QDdB8VprT2eRwgRgk2x0QzTp+vjmkcdQ8dQBnT71jQ6ISdqMF9thd2FK
Received-SPF: pass client-ip=57.103.66.18;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


