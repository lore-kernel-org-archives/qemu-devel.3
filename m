Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B09E98E08
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRSY-0000nZ-4F; Mon, 23 Feb 2026 03:38:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRSM-0000Pa-0d
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:18 -0500
Received: from p-east2-cluster3-host5-snip4-10.eps.apple.com ([57.103.77.201]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRSI-0002FS-CI
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:17 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPS id
 38116180017E; Mon, 23 Feb 2026 08:38:08 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771835891; x=1774427891;
 bh=Tz3bvcnMe5CE3w/zA9xLDVXBu2mGec3HnRSmhDH3Hu8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=dgmMwrps6dPy1e2gixAjhnV0Zi1VuaAVWiQ/hOEjGRrMZqFIjiT+p6gdsVO1daNKZd0haGX8ESYhAiG9e/W5KDog8PcZki6c9uEu6FUmYIzHeikVYNcgJZTIhkRx+3kt8Hlsy+/ZdmWQx2Fvnn4VD/nnZS9cbnnvqnqibomB+hV8FSEixQ8bVDxEzftvfgWlP9U0aUEQnptWj3ixz5AxZGhruhuN82KT8slXYnXO0/El2+NSItcWTPfOlzFR733ZF+V50dl+0lSFRskI2ohdbt3VimiHg4mWdOUmg27OUJMLKGSvVf6X2ducUFPumDfrAgL31wlvmTu5GvUO22lzrg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPSA id
 7D6661800179; Mon, 23 Feb 2026 08:38:05 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 12/27] whpx: i386: remove remaining winhvemulation support
 code
Date: Mon, 23 Feb 2026 09:37:18 +0100
Message-ID: <20260223083734.48533-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223083734.48533-1-mohamed@unpredictable.fr>
References: <20260223083734.48533-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3NiBTYWx0ZWRfXym2uUgmvNOEm
 Phw3BHyx2x0gNi9Yx2ohZETjl4x/3LHKChTLqBqQicXyPzUo/KWIwlQps0o9W0mL8eJYB6DuCqf
 BBzlfrFRUs0FweegmNOnjpvzAhIXuEGtWa14+TPJyBkBOQhfVeOgbDXBv6VObukZJ9l10+WKYBP
 0jcI3SW39ysh+BSIhjmSPqqxGWL/YzmyP2PE4Rk+c54FZC77rLrQo4kb7USU/FzU324zHLfm2pe
 xZ28Zn1TDQXFPHqmSgxBg68UFSgcE3Lj5E2wPL+NfQjqPUNT93ZxwSDddLQswtVL9+0VFKuLrEL
 wow31GtvBorrWu7FxcWnggbNvg1QLdZXVj1/lYTcH9U1w3sH3c27EwpKY5Hrsw=
X-Proofpoint-GUID: g7w74lZj6lGu_w0NBU5aIVNvP5cJyu3k
X-Proofpoint-ORIG-GUID: g7w74lZj6lGu_w0NBU5aIVNvP5cJyu3k
X-Authority-Info-Out: v=2.4 cv=E8HAZKdl c=1 sm=1 tr=0 ts=699c11f1
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=UBzWkQmmy9v7-gCQCgEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1030 bulkscore=0 adultscore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230076
X-JNJ: AAAAAAABRt7HQLqx9tmZf0wR9iYS0I9O88hYySutCFEKE9oDuXsclX58rWihnHrnmdZMx6S94MRDbKaaojO30oPi+EDrC/IA9lsqcEHZ9EudELwED64lbeFNlNxd98SnMBkPgSRdI24xge0+WTvVhvAmX0tL5e6qC9Ux5lkvPDICok58Jcipvv5kTz4p3BJUCNRmJ5HsgR9JqvucxU3e6ib7q7HYYpatfBEf22cFyEx4yzbjbVvLaEsUjawdEEtw3Hi5NsFx3ABXjuviHS7oSuw+hvmatnWCKVbBTX2XCoMyz12X6S9rTobKH//ptSqPsv/DnTTvJpLCazngJBzpoaW4uQDg6ZU9dq8FAgtFgoDMvYgd0cFApnmeObJmcy0PRLILK2/IQgRTVL3f+BC4wM0YTvfuMAyHBPDUbQbJh2oFXj1TbxGr3Jsn2rIgpV7Pfzyl45fJrwdL7Az1F0hEp8goRWd9UXq5wFdBXKJ3AJzuV4Uq5APx10BM7xHnpkItoiwjUcdYfJJNTsN8woUtWrZFJ0vGNaJNY0b/+mg+8GcqET7EOeYIJQN4PDzMHH3nn6lR1+xNeCVeCrOTUZunBLscnW9dEZIzXKf8+sLysT29aOXpzR3q/xOjDTbpna2j3evHVHRX635xnz7JTBjgyeDTCFmRSyn16wa2G+N0F856GzFaSeLFL+jyhZDsli2tlchqdvw1TNumHlo/ov9+TtP98/9iaYQZREUBwOpoOB7W0B53Ofl7ztix739I9++BiDTrJM6XC8MLWsZby2dGYDbjJlCtos+DOKClEarNlI8DwGlGzOa69uZ53KksW2ClC+ay4oVi
Received-SPF: pass client-ip=57.103.77.201;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
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

After moving away to target/i386/emulate, this is no longer necessary.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/whpx/whpx-common.c       | 22 ----------------------
 include/system/whpx-common.h   |  3 ---
 include/system/whpx-internal.h | 16 ----------------
 meson.build                    |  3 +--
 4 files changed, 1 insertion(+), 43 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 21e9f1a178..88eef55799 100644
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
index a4e16e1309..04289afd97 100644
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


