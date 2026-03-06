Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D1BFCB606
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 14:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWY1-0008M2-Hg; Fri, 06 Mar 2026 09:53:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyWXy-0008Ky-IQ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:52:58 -0500
Received: from qs-2003c-snip4-11.eps.apple.com ([57.103.86.33]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyWXv-0001J2-OI
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:52:58 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPS id
 36ECB180024C; Fri,  6 Mar 2026 14:52:52 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772808774; x=1775400774;
 bh=GVjgelet6juA7y3YXimV8LF2BRmuP1Fw6cT9Kz06ayU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=TZBwQz+HiM2a+Ufr9cTSjsFrk7EVDNUn/NZ637i9cWSekpcYa6IEvYKhe96ChrLvjXjnjwK8rVbM0yEAS/p43nDvHgF/qmM31IHPrqXFPbWGgHCE2lIc4BZII1e+BJxYTPiBVPyevyzZ1U95J1nblCkjYwa7TaM17YvxDarJnPIxe0qJvOeRABBwmqOexEMheEUKmeKLXG0VK7lktYmVhLU0yCPA13NWeLmuvlxUa8a8ynltBYmxmWZFppJrqGmBxlMKfisQjuv8df3rQF4+rvKF2Y5fyRFUFFuWup4qBIR9CZwsAeWZSGRg1iWOysVoJJSKEMZUBxsER7JAOVE6Vw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPSA id
 51CEB1800168; Fri,  6 Mar 2026 14:52:50 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v5 1/2] vmapple: apple-gfx: make it work on the latest macOS
 release
Date: Fri,  6 Mar 2026 15:52:45 +0100
Message-ID: <20260306145246.10274-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306145246.10274-1-mohamed@unpredictable.fr>
References: <20260306145246.10274-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VhLKXywF1D1zLPUmzk0_EcVClY-ktPm1
X-Proofpoint-GUID: VhLKXywF1D1zLPUmzk0_EcVClY-ktPm1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE0MyBTYWx0ZWRfXzfQV7CkedAkV
 mMErs52aTXrw/R9XKFDT/wbI8is+XHWbiW4mQ0yrPV1dx5paQ8gYgSa16Ovighb5+YrFDF0gaCr
 +3ff5BruD5rbrvV6raX0nKJZr+RfBmgrGSA4O0SZaEFw5BwwhbKr3bT33i1N2PM0GJ3QVQv4HLN
 zlkD0pvRdl4bjLEM94YkMcfXWwyMCVCvZ05RLQg7Hg/O4KBOovKZ5uhVdZlcuJYKPOMKFKAalv4
 HLAQRHcc6pUBITICODr6NiUlLkuSOFIaHoAjqvOh9RLFJLks/niHQkwoNNAs6p/XlZ7u1QF0Rmb
 UITBCd0L+ZqL8Rs6p7Xfeua2CO8faEBunDg0iMAeEamzB6E4jaVyZfNys8XnIU=
X-Authority-Info-Out: v=2.4 cv=DMeCIiNb c=1 sm=1 tr=0 ts=69aaea44
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=XaNHVGzJZ3ayr3Wv:21 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=2lQx5wYd1WNrG3klcQkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 clxscore=1030
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2603060143
X-JNJ: AAAAAAABoQUV4fJT64D6sbFwlKpLCdZ3W6K3Fon2oTVkn8OK6Ba4FZthXswxzBql0bdQ1uC8SzAZC7wT+8Vmog+1bN/aW7zgnjyMZBvJWOqs2+Q0Y2iC3MpSR2DXM4+LU48ud3KZQHGA+gibtWrlqOFPR6fPG8m37V6bcp97IQSBGv2cdjLciPmbXixq3F2RDdUHQ5kMaNd78LI1ttgK/nseOeeFmXlIVwGJLkCki70UqOiEDF2T8GE5+nfOI/8TWjX+3yuAAeM5F8n9eiWKsE+6wTRUZBsPnHEjIux/6dswkZ/L/iUaB0fMBH+snll7B60YnkZdoTV3O9Ps+7/C9iyT/1ZqXX3ntbi/KwyB5Ec500v5ReI2ZpAWbdNPaYv1Co/OhqDSus8YTDjdzR7HV+n1EtAaOd6eERpHt7DcVPdQV3W9Jj3fiacSykbfrjxHWDQLbJYEV+Di+dr7nJNYxYcDZUBwweDiSLt73ZPoDneBpP1H9hZCcS8qXk3ZmfZ1R62E1aDtUIU1aMkEyHpOVdV9v5HR1cYGz3x6anOmF+pv23sOa9e6u7yl3oAZxBCGwM8KtNVzApckx9msguf845Y0J7iOrF0aLg6BtNont7sigxmeGh1iY5ouiP9XWlj+o8O++xSXu7kUqvGtTa9r5gbiNBrsaaB4u1hTO2uY4V1MsKSm6tq2p7/wA2Ty2qk/orrTtk7TUed4I+Io2BTOvDH/mgs0KC0F23V5/3MD1HaltjNNPbsBdkFbbg==
Received-SPF: pass client-ip=57.103.86.33;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 hw/display/apple-gfx-mmio.m | 62 ++++++++++++++++++++++++++++---------
 hw/display/apple-gfx.h      | 18 +++++++++++
 hw/display/apple-gfx.m      | 43 ++++++++++++++++++++++++-
 3 files changed, 107 insertions(+), 16 deletions(-)

diff --git a/hw/display/apple-gfx-mmio.m b/hw/display/apple-gfx-mmio.m
index 58beaadd1f..323dcfe8cd 100644
--- a/hw/display/apple-gfx-mmio.m
+++ b/hw/display/apple-gfx-mmio.m
@@ -19,6 +19,7 @@
 #include "hw/core/irq.h"
 #include "apple-gfx.h"
 #include "trace.h"
+#include "system/address-spaces.h"
 
 #import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
 
@@ -36,12 +37,19 @@ typedef bool(^IOSFCMapMemory)(uint64_t phys, uint64_t len, bool ro, void **va,
 
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
 
@@ -182,20 +190,34 @@ static bool apple_gfx_mmio_unmap_surface_memory(void *ptr)
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
+    PGMemoryMapDescriptor* memory_map_descriptor;
+
+    /*
+     * The legacy memory management API is no longer present
+     * for the IOSurface mapper as of macOS 15.4.
+     */
+    if (@available(macOS 15.4, *)) {
+        memory_map_descriptor = [PGMemoryMapDescriptor new];
+        FlatView* fv = address_space_to_flatview(&address_space_memory);
+        flatview_for_each_range(fv, apple_gfx_register_memory_cb, memory_map_descriptor);
+        /* the device model defines this as a single-page MMIO region, hence 16KB */
+        iosfc_desc.mmioLength = 0x10000;
+        iosfc_desc.memoryMapDescriptor = memory_map_descriptor;
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
@@ -223,13 +245,23 @@ static void apple_gfx_mmio_realize(DeviceState *dev, Error **errp)
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
index 3197bd853d..72b360454e 100644
--- a/hw/display/apple-gfx.h
+++ b/hw/display/apple-gfx.h
@@ -12,6 +12,7 @@
 #include "system/memory.h"
 #include "hw/core/qdev-properties.h"
 #include "ui/surface.h"
+#include "objc/NSObject.h"
 
 #define TYPE_APPLE_GFX_MMIO         "apple-gfx-mmio"
 #define TYPE_APPLE_GFX_PCI          "apple-gfx-pci"
@@ -23,6 +24,17 @@
 @protocol MTLTexture;
 @protocol MTLCommandQueue;
 
+typedef struct PGGuestPhysicalRange_s
+{
+    uint64_t physicalAddress;
+    uint64_t physicalLength;
+    void *hostAddress;
+} PGGuestPhysicalRange_t;
+
+@interface PGMemoryMapDescriptor : NSObject
+-(void)addRange:(PGGuestPhysicalRange_t) range;
+@end
+
 typedef QTAILQ_HEAD(, PGTask_s) PGTaskList;
 
 typedef struct AppleGFXDisplayMode {
@@ -68,6 +80,12 @@ void *apple_gfx_host_ptr_for_gpa_range(uint64_t guest_physical,
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
index e0a765fcb1..92404d20bf 100644
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
@@ -596,6 +597,37 @@ void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char* obj_name)
     /* TODO: PVG framework supports serialising device state: integrate it! */
 }
 
+@interface PGDeviceDescriptor (IOSurfaceMapper)
+@property (readwrite, nonatomic, copy, nullable) PGMemoryMapDescriptor* memoryMapDescriptor;
+@end
+
+bool apple_gfx_register_memory_cb(Int128 start, Int128 len,
+                                  const MemoryRegion *mr_const,
+                                  hwaddr offset_in_region, void *opaque) {
+    MemoryRegion *mr = (MemoryRegion *)mr_const;
+    PGGuestPhysicalRange_t range;
+    PGMemoryMapDescriptor *memory_map_descriptor = opaque;
+    if (memory_access_is_direct(mr, true, MEMTXATTRS_UNSPECIFIED)) {
+        range.physicalAddress = start;
+        range.physicalLength = len;
+        range.hostAddress = memory_region_get_ram_ptr(mr);
+        [memory_map_descriptor addRange:range];
+        memory_region_ref(mr);
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
@@ -763,7 +795,16 @@ bool apple_gfx_common_realize(AppleGFXState *s, DeviceState *dev,
 
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


