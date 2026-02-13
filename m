Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A763FEF48C2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 03:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqk8X-0008JJ-DP; Thu, 12 Feb 2026 22:46:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vqk8W-0008JA-Nh
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 22:46:32 -0500
Received: from p-west1-cluster4-host9-snip4-8.eps.apple.com ([57.103.65.159]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vqk8V-0005cn-06
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 22:46:32 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-11 (Postfix) with ESMTPS id
 F1A1718002D8; Fri, 13 Feb 2026 03:46:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770954389; x=1773546389;
 bh=GMKDLR1ZRQkqFLoZNb51fIAURVKjNkL9YCABneXfO8s=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=E78hpZtczR9HOsmA/th4k1SVxOlPNpXl9zWh1N56arOMmt03iirWipJaqvXVwtpqHltsXnQ4TXeersshaQAjhVf7TODJ62yBVSGs7P93BaprUGOAmUspNamfWkD58UsZ4ylttO8otYq9dALY3uo0JRFTMo5IUgONy2xLKwbIfLlSHbUXJUJCGAqUMhwqdN8OMTMMZ5OOh533+4enB0TROzSIXCLSL2xP6VAzhizT5y+TMM6iiKpww8y+JG2TXF3OdJsFqyBUZ8XkdAbN9KNsxSyM9Na1/0QKTYLBtnBM0svylfrOINM/3PMmmjFRcXvmFLMntbUMtcNgpR9Bi6RbOw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-11 (Postfix) with ESMTPSA id
 9DF3518002E4; Fri, 13 Feb 2026 03:46:25 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 07/10] whpx: remove remaining winhvemulation support code
Date: Fri, 13 Feb 2026 04:45:50 +0100
Message-ID: <20260213034556.13471-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260213034556.13471-1-mohamed@unpredictable.fr>
References: <20260213034556.13471-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0vQIbi4TjvnbayvRVXZXamZJIroDiaIO
X-Authority-Info-Out: v=2.4 cv=C5HkCAP+ c=1 sm=1 tr=0 ts=698e9e95
 cx=c_apl:c_apl_out:c_pps a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=UBzWkQmmy9v7-gCQCgEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDAyNSBTYWx0ZWRfX0cUYDt//7ha1
 Ya9tqQpDjbujV91sLgup4LagCuHyHPRcHTXXx/f2m0QO2gvhm0/rF58dv1hs4NQpzQ2em2qHqqr
 EztXev0c9oOH89hy7wUNwchwKkDxH1G8v71swDAmLWCTf1v4wFfP6gr8zLBbHNdNKyBWUk3LZ5V
 /NCxmMN3ZC0lTaGSt33P2OkUB8/CzyE0FyLYzgxSVncEs+XzeXQ5ww2j6MO1AhFajR85m+VZk3C
 4jT9Y0KKs4vSE3JaDlmWUw3bLzli0dAXHLabsHa9mbgy6Yk6CA3Ggir3gqgkpKIisiDa0aVFwrZ
 PX7tDAIObOQxR8hRPKRH8QKAD6378Be2zo5nQ25l93teuHchwsl/X1luIOF3P8=
X-Proofpoint-ORIG-GUID: 0vQIbi4TjvnbayvRVXZXamZJIroDiaIO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1030 mlxlogscore=999 mlxscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602130025
X-JNJ: AAAAAAABMBoQz/FN1pyCXXvEdgmYa3bDf/DjMByqeHIwmaQR2sWLHXIc/lqVwI9w87+0wdbY0HOSRE0wgwUcCsOkVvfIuvsGCZSqBA3e3xaUIbLsSyzi/Pds+CqdHy3+JL6J2m6ykf64XIaoccu+wEIGGfuyv0sP4JjGnaWo/7hM5CSmk/DQDGdOZVmFDZTc1a6POcRNnMEmEtSuAq4ybWuYd0aNus9Wz1ccn68XLGnGn9IC8RXJc1LveLVyxMRcx8F07lM7vNOhGrJV4S4My8lXqtydvzZvtz1+PR1i91NKNDSsYz4qBlIQ3F9+tUGKQaMXSwsJpU3Kf97sR5VE6MhokfTpsG159U/xrOBM5hhVvc0YEE8JIYn82LxNMWulaKdvc9si0O3ULq3xNqZ/gohwO2YmQDmPAGWFG/DdHdXQ7kB81cClpBigv/EGy4k5KhuhsQJ5yoxSGj80OIzKw+BD7tWRYFjPjZTbUJU3RtoezcR52JXvZP2G7KjH3kpwynwxmUwJl0bkGUJtJRzHtMu9D2ZdChbu/PdtZxF5FO3LFoMjhiNU80ps1QWXAzpZfpIN5M+zY0IjJoapnidD9BjfRKaAHJEouaa6SslE+SjC7ZWCnxiDZZKYra151p58Ye56hGwhKi8Ui1YM0AbOxsnyWIHSGbqZ5Qk+JOdlxF9TZC3hz+PuolskSGSi1nOlIRCCbUWSycyaM5TRnXiBcINIuTCnLWykps0H+fbVMB/nEvb3i4QGjOUWBKhDokcE/vxQskiQqw/KFMqp/7hFmw4j7EppWEAOTWy5Aw==
Received-SPF: pass client-ip=57.103.65.159;
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

After moving away to target/i386/emulate, this is no longer necessary.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/whpx/whpx-common.c       | 22 ----------------------
 include/system/whpx-common.h   |  3 ---
 include/system/whpx-internal.h | 16 ----------------
 meson.build                    |  3 +--
 4 files changed, 1 insertion(+), 43 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index c2263c2496..245e64a12f 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -39,9 +39,6 @@ bool whpx_allowed;
 bool whpx_irqchip_in_kernel;
 static bool whp_dispatch_initialized;
 static HMODULE hWinHvPlatform;
-#ifdef HOST_X86_64
-static HMODULE hWinHvEmulation;
-#endif
 
 struct whpx_state whpx_global;
 struct WHPDispatch whp_dispatch;
@@ -393,7 +390,6 @@ static bool load_whp_dispatch_fns(HMODULE *handle,
     HMODULE hLib = *handle;
 
     #define WINHV_PLATFORM_DLL "WinHvPlatform.dll"
-    #define WINHV_EMULATION_DLL "WinHvEmulation.dll"
     #define WHP_LOAD_FIELD_OPTIONAL(return_type, function_name, signature) \
         whp_dispatch.function_name = \
             (function_name ## _t)GetProcAddress(hLib, #function_name); \
@@ -420,14 +416,6 @@ static bool load_whp_dispatch_fns(HMODULE *handle,
         WHP_LOAD_LIB(WINHV_PLATFORM_DLL, hLib)
         LIST_WINHVPLATFORM_FUNCTIONS(WHP_LOAD_FIELD)
         break;
-    case WINHV_EMULATION_FNS_DEFAULT:
-#ifdef HOST_X86_64
-        WHP_LOAD_LIB(WINHV_EMULATION_DLL, hLib)
-        LIST_WINHVEMULATION_FUNCTIONS(WHP_LOAD_FIELD)
-#else
-        g_assert_not_reached();
-#endif
-        break;
     case WINHV_PLATFORM_FNS_SUPPLEMENTAL:
         WHP_LOAD_LIB(WINHV_PLATFORM_DLL, hLib)
         LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_LOAD_FIELD_OPTIONAL)
@@ -543,11 +531,6 @@ bool init_whp_dispatch(void)
     if (!load_whp_dispatch_fns(&hWinHvPlatform, WINHV_PLATFORM_FNS_DEFAULT)) {
         goto error;
     }
-#ifdef HOST_X86_64
-    if (!load_whp_dispatch_fns(&hWinHvEmulation, WINHV_EMULATION_FNS_DEFAULT)) {
-        goto error;
-    }
-#endif
     assert(load_whp_dispatch_fns(&hWinHvPlatform,
         WINHV_PLATFORM_FNS_SUPPLEMENTAL));
     whp_dispatch_initialized = true;
@@ -557,11 +540,6 @@ error:
     if (hWinHvPlatform) {
         FreeLibrary(hWinHvPlatform);
     }
-#ifdef HOST_X86_64
-    if (hWinHvEmulation) {
-        FreeLibrary(hWinHvEmulation);
-    }
-#endif
     return false;
 }
 
diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index 5bce33e336..fa2cc9a2ce 100644
--- a/include/system/whpx-common.h
+++ b/include/system/whpx-common.h
@@ -3,9 +3,6 @@
 #define SYSTEM_WHPX_COMMON_H
 
 struct AccelCPUState {
-#ifdef HOST_X86_64
-    WHV_EMULATOR_HANDLE emulator;
-#endif
     bool window_registered;
     bool interruptable;
     bool ready_for_pic_interrupt;
diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index ad6ade223e..7a1c9871f1 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -4,9 +4,6 @@
 
 #include <windows.h>
 #include <winhvplatform.h>
-#ifdef HOST_X86_64
-#include <winhvemulation.h>
-#endif
 #include "hw/i386/apic.h"
 #include "exec/vaddr.h"
 
@@ -89,12 +86,6 @@ void whpx_apic_get(APICCommonState *s);
   X(HRESULT, WHvResetPartition, \
         (WHV_PARTITION_HANDLE Partition)) \
 
-#define LIST_WINHVEMULATION_FUNCTIONS(X) \
-  X(HRESULT, WHvEmulatorCreateEmulator, (const WHV_EMULATOR_CALLBACKS* Callbacks, WHV_EMULATOR_HANDLE* Emulator)) \
-  X(HRESULT, WHvEmulatorDestroyEmulator, (WHV_EMULATOR_HANDLE Emulator)) \
-  X(HRESULT, WHvEmulatorTryIoEmulation, (WHV_EMULATOR_HANDLE Emulator, VOID* Context, const WHV_VP_EXIT_CONTEXT* VpContext, const WHV_X64_IO_PORT_ACCESS_CONTEXT* IoInstructionContext, WHV_EMULATOR_STATUS* EmulatorReturnStatus)) \
-  X(HRESULT, WHvEmulatorTryMmioEmulation, (WHV_EMULATOR_HANDLE Emulator, VOID* Context, const WHV_VP_EXIT_CONTEXT* VpContext, const WHV_MEMORY_ACCESS_CONTEXT* MmioInstructionContext, WHV_EMULATOR_STATUS* EmulatorReturnStatus)) \
-
 #define WHP_DEFINE_TYPE(return_type, function_name, signature) \
     typedef return_type (WINAPI *function_name ## _t) signature;
 
@@ -103,16 +94,10 @@ void whpx_apic_get(APICCommonState *s);
 
 /* Define function typedef */
 LIST_WINHVPLATFORM_FUNCTIONS(WHP_DEFINE_TYPE)
-#ifdef HOST_X86_64
-LIST_WINHVEMULATION_FUNCTIONS(WHP_DEFINE_TYPE)
-#endif
 LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DEFINE_TYPE)
 
 struct WHPDispatch {
     LIST_WINHVPLATFORM_FUNCTIONS(WHP_DECLARE_MEMBER)
-#ifdef HOST_X86_64
-    LIST_WINHVEMULATION_FUNCTIONS(WHP_DECLARE_MEMBER)
-#endif
     LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DECLARE_MEMBER)
 };
 
@@ -122,7 +107,6 @@ bool init_whp_dispatch(void);
 
 typedef enum WHPFunctionList {
     WINHV_PLATFORM_FNS_DEFAULT,
-    WINHV_EMULATION_FNS_DEFAULT,
     WINHV_PLATFORM_FNS_SUPPLEMENTAL
 } WHPFunctionList;
 
diff --git a/meson.build b/meson.build
index e8fd77aac0..8f5e55810f 100644
--- a/meson.build
+++ b/meson.build
@@ -865,8 +865,7 @@ if get_option('whpx').allowed() and host_os == 'windows'
     endif
    # Leave CONFIG_WHPX disabled
   else
-    if cc.has_header('winhvplatform.h', required: get_option('whpx')) and \
-      cc.has_header('winhvemulation.h', required: get_option('whpx'))
+    if cc.has_header('winhvplatform.h', required: get_option('whpx'))
       accelerators += 'CONFIG_WHPX'
     endif
   endif
-- 
2.50.1 (Apple Git-155)


