Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CEAC87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 05:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ui4zj-0008Cf-Oc; Sat, 02 Aug 2025 01:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ui4zc-00086k-V4
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 01:41:19 -0400
Received: from p-east3-cluster1-host3-snip4-7.eps.apple.com ([57.103.87.30]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ui4zY-00062d-FA
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 01:41:15 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPS id
 00AF818008A7; Sat,  2 Aug 2025 05:41:05 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=9iTF2if2/m0cyl+nDOn7dg4Hrcpub8X7jpX8N8be3Wk=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type:x-icloud-hme;
 b=ZsLN5KS/XR7shM/5VWQiPTBR8nZF/j9hWxsJz4b9BqHBgDNMzupvQaG6+Z27jAtdTW1gO8Qbk63NBxODN9fWE3wkX7vFYderyictef71yfI4su2ofgx1nPZ9WSQqi+2d6yPV611A2/JmqvayVyETWYLjLBdjNNuClnT7dZm8HWMPu+o+cbOiNPJppcye/Qhgs+rdDJoZ8j4L1PEozJ0p8t6JYGYBdbD5UGLkTzuO8mLgu4L8UyzXcg3aiBrrymo9g6C+jpWXQKC40mU7S9hnnTYFp0M7Am4enKyHjLI7igBKsF9YwzFTLeGTfLWDbW6jWihROPEr6DCw5tKBtCAuGQ==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPSA id
 CCA5A1800880; Sat,  2 Aug 2025 05:41:02 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v2 02/14] whpx: Move around files before introducing AArch64
 support
Date: Sat,  2 Aug 2025 07:40:43 +0200
Message-Id: <20250802054055.74013-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250802054055.74013-1-mohamed@unpredictable.fr>
References: <20250802054055.74013-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _9RofRby3u42P0UhQyyefR-58KRoFRLg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAyMDA0NyBTYWx0ZWRfX+rKiQ2yxF33g
 hMQykKRBvKqwrl9Kq90FmK+Yt4aYxMRvC6xV3qGbaxFi5PlD7w7r29RuaC1BuFhZGIjIO429ZTd
 GCVDZmwDwfrEfPnD8b+RV74WcoOajDbVTKY6jGIbjTYnQe2PuXLDzqULpaGlYqZ+eaYWNQEqz7a
 S6KdqcIEBkrFhPWDjM36ekEd2vYeKDm4nDdwGVQG5rDu+YTndADriTGhvhfbDkBTSJbeTzK6w8u
 YEiv30rWb2kfuM9/20OKxHK78fj8M0ByZD2fXzT/bHV+8p8cSz+4z0h7pVsFfnpv6yPx8dWeI=
X-Proofpoint-ORIG-GUID: _9RofRby3u42P0UhQyyefR-58KRoFRLg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508020047
Received-SPF: pass client-ip=57.103.87.30;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Switch to a design where we can share whpx code between x86 and AArch64 when it makes sense to do so.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                                   |   2 +
 accel/meson.build                             |   1 +
 accel/whpx/meson.build                        |   6 +
 {target/i386 => accel}/whpx/whpx-accel-ops.c  |   4 +-
 .../whpx => include/system}/whpx-accel-ops.h  |   0
 target/i386/whpx/meson.build                  |   1 -
 target/i386/whpx/whpx-all.c                   |   4 +-
 target/i386/whpx/whpx-internal.h              | 119 ------------------
 8 files changed, 13 insertions(+), 124 deletions(-)
 create mode 100644 accel/whpx/meson.build
 rename {target/i386 => accel}/whpx/whpx-accel-ops.c (97%)
 rename {target/i386/whpx => include/system}/whpx-accel-ops.h (100%)
 delete mode 100644 target/i386/whpx/whpx-internal.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 28cea34271..238065e1c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -542,9 +542,11 @@ F: include/system/hvf_int.h
 WHPX CPUs
 M: Sunil Muthuswamy <sunilmut@microsoft.com>
 S: Supported
+F: accel/whpx/
 F: target/i386/whpx/
 F: accel/stubs/whpx-stub.c
 F: include/system/whpx.h
+F: include/system/whpx-accel-ops.h
 
 X86 Instruction Emulator
 M: Cameron Esfahani <dirty@apple.com>
diff --git a/accel/meson.build b/accel/meson.build
index 25b0f100b5..de927a3b37 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -6,6 +6,7 @@ user_ss.add(files('accel-user.c'))
 subdir('tcg')
 if have_system
   subdir('hvf')
+  subdir('whpx')
   subdir('qtest')
   subdir('kvm')
   subdir('xen')
diff --git a/accel/whpx/meson.build b/accel/whpx/meson.build
new file mode 100644
index 0000000000..7b3d6f1c1c
--- /dev/null
+++ b/accel/whpx/meson.build
@@ -0,0 +1,6 @@
+whpx_ss = ss.source_set()
+whpx_ss.add(files(
+  'whpx-accel-ops.c',
+))
+
+specific_ss.add_all(when: 'CONFIG_WHPX', if_true: whpx_ss)
diff --git a/target/i386/whpx/whpx-accel-ops.c b/accel/whpx/whpx-accel-ops.c
similarity index 97%
rename from target/i386/whpx/whpx-accel-ops.c
rename to accel/whpx/whpx-accel-ops.c
index da58805b1a..18488421bc 100644
--- a/target/i386/whpx/whpx-accel-ops.c
+++ b/accel/whpx/whpx-accel-ops.c
@@ -16,8 +16,8 @@
 #include "qemu/guest-random.h"
 
 #include "system/whpx.h"
-#include "whpx-internal.h"
-#include "whpx-accel-ops.h"
+#include "system/whpx-internal.h"
+#include "system/whpx-accel-ops.h"
 
 static void *whpx_cpu_thread_fn(void *arg)
 {
diff --git a/target/i386/whpx/whpx-accel-ops.h b/include/system/whpx-accel-ops.h
similarity index 100%
rename from target/i386/whpx/whpx-accel-ops.h
rename to include/system/whpx-accel-ops.h
diff --git a/target/i386/whpx/meson.build b/target/i386/whpx/meson.build
index 9c54aaad39..c3aaaff9fd 100644
--- a/target/i386/whpx/meson.build
+++ b/target/i386/whpx/meson.build
@@ -1,5 +1,4 @@
 i386_system_ss.add(when: 'CONFIG_WHPX', if_true: files(
   'whpx-all.c',
   'whpx-apic.c',
-  'whpx-accel-ops.c',
 ))
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index b72dcff3c8..5a431fc3c7 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -31,8 +31,8 @@
 #include "accel/accel-cpu-target.h"
 #include <winerror.h>
 
-#include "whpx-internal.h"
-#include "whpx-accel-ops.h"
+#include "system/whpx-internal.h"
+#include "system/whpx-accel-ops.h"
 
 #include <winhvplatform.h>
 #include <winhvemulation.h>
diff --git a/target/i386/whpx/whpx-internal.h b/target/i386/whpx/whpx-internal.h
deleted file mode 100644
index 6633e9c4ca..0000000000
--- a/target/i386/whpx/whpx-internal.h
+++ /dev/null
@@ -1,119 +0,0 @@
-#ifndef TARGET_I386_WHPX_INTERNAL_H
-#define TARGET_I386_WHPX_INTERNAL_H
-
-#include <windows.h>
-#include <winhvplatform.h>
-#include <winhvemulation.h>
-
-typedef enum WhpxBreakpointState {
-    WHPX_BP_CLEARED = 0,
-    WHPX_BP_SET_PENDING,
-    WHPX_BP_SET,
-    WHPX_BP_CLEAR_PENDING,
-} WhpxBreakpointState;
-
-struct whpx_breakpoint {
-    vaddr address;
-    WhpxBreakpointState state;
-    uint8_t original_instruction;
-};
-
-struct whpx_breakpoint_collection {
-    int allocated, used;
-    struct whpx_breakpoint data[0];
-};
-
-struct whpx_breakpoints {
-    int original_address_count;
-    vaddr *original_addresses;
-
-    struct whpx_breakpoint_collection *breakpoints;
-};
-
-struct whpx_state {
-    uint64_t mem_quota;
-    WHV_PARTITION_HANDLE partition;
-    uint64_t exception_exit_bitmap;
-    int32_t running_cpus;
-    struct whpx_breakpoints breakpoints;
-    bool step_pending;
-
-    bool kernel_irqchip_allowed;
-    bool kernel_irqchip_required;
-    bool apic_in_platform;
-};
-
-extern struct whpx_state whpx_global;
-void whpx_apic_get(DeviceState *s);
-
-#define WHV_E_UNKNOWN_CAPABILITY 0x80370300L
-
-/* This should eventually come from the Windows SDK */
-#define WHV_E_UNKNOWN_PROPERTY 0x80370302
-
-#define LIST_WINHVPLATFORM_FUNCTIONS(X) \
-  X(HRESULT, WHvGetCapability, (WHV_CAPABILITY_CODE CapabilityCode, VOID* CapabilityBuffer, UINT32 CapabilityBufferSizeInBytes, UINT32* WrittenSizeInBytes)) \
-  X(HRESULT, WHvCreatePartition, (WHV_PARTITION_HANDLE* Partition)) \
-  X(HRESULT, WHvSetupPartition, (WHV_PARTITION_HANDLE Partition)) \
-  X(HRESULT, WHvDeletePartition, (WHV_PARTITION_HANDLE Partition)) \
-  X(HRESULT, WHvGetPartitionProperty, (WHV_PARTITION_HANDLE Partition, WHV_PARTITION_PROPERTY_CODE PropertyCode, VOID* PropertyBuffer, UINT32 PropertyBufferSizeInBytes, UINT32* WrittenSizeInBytes)) \
-  X(HRESULT, WHvSetPartitionProperty, (WHV_PARTITION_HANDLE Partition, WHV_PARTITION_PROPERTY_CODE PropertyCode, const VOID* PropertyBuffer, UINT32 PropertyBufferSizeInBytes)) \
-  X(HRESULT, WHvMapGpaRange, (WHV_PARTITION_HANDLE Partition, VOID* SourceAddress, WHV_GUEST_PHYSICAL_ADDRESS GuestAddress, UINT64 SizeInBytes, WHV_MAP_GPA_RANGE_FLAGS Flags)) \
-  X(HRESULT, WHvUnmapGpaRange, (WHV_PARTITION_HANDLE Partition, WHV_GUEST_PHYSICAL_ADDRESS GuestAddress, UINT64 SizeInBytes)) \
-  X(HRESULT, WHvTranslateGva, (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, WHV_GUEST_VIRTUAL_ADDRESS Gva, WHV_TRANSLATE_GVA_FLAGS TranslateFlags, WHV_TRANSLATE_GVA_RESULT* TranslationResult, WHV_GUEST_PHYSICAL_ADDRESS* Gpa)) \
-  X(HRESULT, WHvCreateVirtualProcessor, (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, UINT32 Flags)) \
-  X(HRESULT, WHvDeleteVirtualProcessor, (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex)) \
-  X(HRESULT, WHvRunVirtualProcessor, (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, VOID* ExitContext, UINT32 ExitContextSizeInBytes)) \
-  X(HRESULT, WHvCancelRunVirtualProcessor, (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, UINT32 Flags)) \
-  X(HRESULT, WHvGetVirtualProcessorRegisters, (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, const WHV_REGISTER_NAME* RegisterNames, UINT32 RegisterCount, WHV_REGISTER_VALUE* RegisterValues)) \
-  X(HRESULT, WHvSetVirtualProcessorRegisters, (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, const WHV_REGISTER_NAME* RegisterNames, UINT32 RegisterCount, const WHV_REGISTER_VALUE* RegisterValues)) \
-
-/*
- * These are supplemental functions that may not be present
- * on all versions and are not critical for basic functionality.
- */
-#define LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(X) \
-  X(HRESULT, WHvSuspendPartitionTime, (WHV_PARTITION_HANDLE Partition)) \
-  X(HRESULT, WHvRequestInterrupt, (WHV_PARTITION_HANDLE Partition, \
-        WHV_INTERRUPT_CONTROL* Interrupt, UINT32 InterruptControlSize)) \
-  X(HRESULT, WHvGetVirtualProcessorInterruptControllerState2, \
-        (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, PVOID State, \
-         UINT32 StateSize, UINT32* WrittenSize)) \
-  X(HRESULT, WHvSetVirtualProcessorInterruptControllerState2, \
-        (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, PVOID State, \
-         UINT32 StateSize)) \
-
-#define LIST_WINHVEMULATION_FUNCTIONS(X) \
-  X(HRESULT, WHvEmulatorCreateEmulator, (const WHV_EMULATOR_CALLBACKS* Callbacks, WHV_EMULATOR_HANDLE* Emulator)) \
-  X(HRESULT, WHvEmulatorDestroyEmulator, (WHV_EMULATOR_HANDLE Emulator)) \
-  X(HRESULT, WHvEmulatorTryIoEmulation, (WHV_EMULATOR_HANDLE Emulator, VOID* Context, const WHV_VP_EXIT_CONTEXT* VpContext, const WHV_X64_IO_PORT_ACCESS_CONTEXT* IoInstructionContext, WHV_EMULATOR_STATUS* EmulatorReturnStatus)) \
-  X(HRESULT, WHvEmulatorTryMmioEmulation, (WHV_EMULATOR_HANDLE Emulator, VOID* Context, const WHV_VP_EXIT_CONTEXT* VpContext, const WHV_MEMORY_ACCESS_CONTEXT* MmioInstructionContext, WHV_EMULATOR_STATUS* EmulatorReturnStatus)) \
-
-#define WHP_DEFINE_TYPE(return_type, function_name, signature) \
-    typedef return_type (WINAPI *function_name ## _t) signature;
-
-#define WHP_DECLARE_MEMBER(return_type, function_name, signature) \
-    function_name ## _t function_name;
-
-/* Define function typedef */
-LIST_WINHVPLATFORM_FUNCTIONS(WHP_DEFINE_TYPE)
-LIST_WINHVEMULATION_FUNCTIONS(WHP_DEFINE_TYPE)
-LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DEFINE_TYPE)
-
-struct WHPDispatch {
-    LIST_WINHVPLATFORM_FUNCTIONS(WHP_DECLARE_MEMBER)
-    LIST_WINHVEMULATION_FUNCTIONS(WHP_DECLARE_MEMBER)
-    LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DECLARE_MEMBER)
-};
-
-extern struct WHPDispatch whp_dispatch;
-
-bool init_whp_dispatch(void);
-
-typedef enum WHPFunctionList {
-    WINHV_PLATFORM_FNS_DEFAULT,
-    WINHV_EMULATION_FNS_DEFAULT,
-    WINHV_PLATFORM_FNS_SUPPLEMENTAL
-} WHPFunctionList;
-
-#endif /* TARGET_I386_WHPX_INTERNAL_H */
-- 
2.39.5 (Apple Git-154)


