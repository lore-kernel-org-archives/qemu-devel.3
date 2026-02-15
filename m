Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9BBEF586B
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 05:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrUbH-0000R5-LI; Sun, 15 Feb 2026 00:23:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrUb9-0000Pl-4l
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 00:23:11 -0500
Received: from p-west2-cluster1-host11-snip4-10.eps.apple.com ([57.103.68.33]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrUb7-0004u5-EH
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 00:23:10 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPS id
 4CFA618006AA; Sun, 15 Feb 2026 05:23:07 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771132988; x=1773724988;
 bh=bIb2USwKqldYX6wHKR7h+SU/ZoexRDb/MQYEkd5ZjcI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=YYfhpvChqZ7aML0lmom7XVtMP+JvYL+/5YPUUxvgC+qTe12aBRvhFY/fX+Q1c7F1aaWf+yViwWMnsid+AxljCBT/Pv0fUZxJBsC8x6DmOURNH12p/7HAyohJb9leeOUXWG/5qvlNxeB8ibE/f7azX2H0/5FVM4LRLy2bptNzzGnKCHo0bGHt83K/D4Blx6ESNHP+aJfdq5XXgLRHnTlNGsprsw7Z8XQYxf0ibFrqIDiZKs0XAHAnm4zY4pRu+N4TWGlmzsUJSde4WUmESFVDbadvkxJ96JRxq7HxJqrVg668VkMs0waOr7eH2otfnJ9SMvLjeMtdfjtjZjtzYZfV9w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPSA id
 CE0CC1800103; Sun, 15 Feb 2026 05:23:03 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>, Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wei Liu <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 10/14] whpx: i386: remove remaining winhvemulation support
 code
Date: Sun, 15 Feb 2026 06:22:21 +0100
Message-ID: <20260215052225.22513-11-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260215052225.22513-1-mohamed@unpredictable.fr>
References: <20260215052225.22513-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=eurSD4pX c=1 sm=1 tr=0 ts=6991583c
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=UBzWkQmmy9v7-gCQCgEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDAzNiBTYWx0ZWRfX/3Anl09FbqaP
 hiKWLP+CZynOd8TDdaFhRRbASyajAOLtNZsNvhK/SZWCLsOVEKyz4hzRFdiDA145ovCsGXjVTQT
 pUQBmRrmhnSAcBDd3nCjC9B9Hlei8s8C2ET+4xNqay/0h18TKrtna9olYY8SKzOT3JrwcHrYlIo
 750RGAZ2eJBlwgzMuMJzbfZdAZN27AXbjTGWzaiWRS6wbTW56gS39UXp2MVGKXRpl0Q1vxT2IZp
 H6HgPDHbJ6cD3daLCXcm1Yx0oECt/3NyvdjgoWhcr73WGyg5IyTfqRhVQnY8FQuj+X7Ivln0BJ0
 Iqf7VnC7uVoLDe9Inya50ftKjYgFXbUcuYDULTS6HX/oWjo+nFMsOnfryanuY4=
X-Proofpoint-GUID: tP7qtZw-iqdUbFhDN-FEcdEz6YizJh6d
X-Proofpoint-ORIG-GUID: tP7qtZw-iqdUbFhDN-FEcdEz6YizJh6d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_02,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1030
 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602150036
X-JNJ: AAAAAAABeE7R4N3+f5FgO1KgxJIeF8dk4dA2NWw2UGidy4kY4h17K7eFSPaALrQxlmxe89Tj0iK7yL3sC4LMyMtLmVzVwjRdu14qD8LRrXbsnu+pwCY0ZWDtAg1z4d8qjd49+t2NhEF15/YEq1WD8K9KbhxSUEsxLapusr2tbM0LowUtw2DjkvIl/JSSNnGTm+O8kcpZT4wDIt83HjcHOMAHekSq2rrVa3yEADZ+yYDG2R21BBSmVR8uub39FM2R5ER1rq7gYpb6bGLOhLA7x6i+VSzq3wkXpBEwkZhlMLCF9nw+wl/BSurk1HEL7j9GrhMal+j0FHUyVuPKAHUkDrqQ3TkG6DuyC8izU82TMrSNoEdNOgyvkk72RCBmYalw7gvP0B6uw83G93r7RuPtHvOt9NYpyWQ8RszSGX9k+dGW6+O5wzmWALlC76bWxobAi7dAszEc82uXq+CGZDHPmoK+D2FkmhZZ7La5mgiNzx7k2EBjZAkHz9xGGY1fQgiXZhwQI7kJaNsptScNqMOPENcxqE1c8jgQwWg5QrGB3mpFwW08CmLaJKkNwYGzWs9jej+gIcwCn0p87KkmdsdDgj0dAEVC05wsYjHY5FsgLuV0PoP2JAsqWBa79VmFxu6n1sN4fCQk7w2W4mJSvo0Zn9Jxj5g1QDf2L/+VvgtZhHzeihW4qu0xj1uXUlSGioUemm72IvsHW+w8rpa0mMYlalhY1z/pm4BZ2lm8dL1imeKt3y7OmOK6OkzHu90RHzqXsy7bYZSxK4eOGU46N6CXmR3q4U0HN1cZ3eFRkuc4hwSVl4RfIxMNCWIzfren
Received-SPF: pass client-ip=57.103.68.33;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 4af32c3e1f..86bc807e56 100644
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


