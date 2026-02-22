Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42E0C636A0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 18:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuDnb-0000Fv-8o; Sun, 22 Feb 2026 13:03:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDnX-00005C-D7
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:03:15 -0500
Received: from qs-2007d-snip4-10.eps.apple.com ([57.103.84.170]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDnU-0000UW-Ga
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:03:15 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPS id
 02B281800506; Sun, 22 Feb 2026 18:03:09 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771783392; x=1774375392;
 bh=Tz3bvcnMe5CE3w/zA9xLDVXBu2mGec3HnRSmhDH3Hu8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=XvFa6fjz5P7Ds8urOui9nMKP698tQEYn1J3eBiyok4+BKcHtFoQ3AqWZ3mZB9qQyBvbZNi6D+MeQfs32Cp5tYw0bL/beuPQA+R8OCLjbUUowpZKF957nkhmY2/dL9sV634TLZidjMJ1qpEo909MgHO6NSpzvFaIawg8DEZ6+uf8UyjUDSCmrGb1j9fwJX/d1woX2HiiR224JI5xfU5iGY90V6uyq9N894YI2Iux9EH0GS6zu34oZhwIWMzBpAy9OPVOcLnySCROOjPXqYfOuR2cJzLXa3A9AkDTYI4TrQuoK0p/Ywxc90iK65EOgLqh2Q1ajcxECerzp23SMTHfaSg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPSA id
 87CE718004DC; Sun, 22 Feb 2026 18:03:07 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, qemu-arm@nongnu.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v4 12/16] whpx: i386: remove remaining winhvemulation support
 code
Date: Sun, 22 Feb 2026 19:02:36 +0100
Message-ID: <20260222180241.14621-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260222180241.14621-1-mohamed@unpredictable.fr>
References: <20260222180241.14621-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: M3BW7qvUAXaLCIWiz5LnZMmgzUXIJkkJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIyMDE3NCBTYWx0ZWRfXxqmum9okEUHl
 opso1qi9/qKS+gWgW3xFDBht7YQzg7s4Vsf4tkXU0N6SzbK+bRg1txE62ZiSXfwXc8jDSW5YLLS
 nDDSd9H1F/xPw8gboQtr3+P5KhYCDSG6lqAQXgvnvG3WGQlvyH7GmFzfE10JPUO1BuQdeHicIG+
 gZSZI4tZvwyIOyNXi3Rpol1U/Fk94Dxe/vn/oX+grNFIHMDHcbceayk/k+HvFyzvO4B8r5cpJP2
 IsnioWL1Tl15qzVmYfCbhR4WxcCzrVs+jRRnn3NjoFW2zt2twEo0RBWwJvGB14DMD+suFNWakwG
 rBEPgjZt32BNCTe9z8/ja/0iSC20LvarF+cdxeEGyUp1AmhkpwJa8ppY7w/ouM=
X-Authority-Info-Out: v=2.4 cv=AN8t5o3d c=1 sm=1 tr=0 ts=699b44df
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=UBzWkQmmy9v7-gCQCgEA:9
X-Proofpoint-GUID: M3BW7qvUAXaLCIWiz5LnZMmgzUXIJkkJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-22_04,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 clxscore=1030 malwarescore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602220174
X-JNJ: AAAAAAABHLuELVn4Xzx4UzDhatAUI8OpQRPPo2ir/64sdbBD9BN9Jxhoyk44FfxBDULvFPq2McgtHhJ1+e4DHIBdNlQbLHXfz6uSwOQb4Q7zVZwlu3Ze+i9relf1FLMtlsms4B7Cd5/UUhn6VIfcLU8n0iG/mn6fFRPbsHY5e4ipkIA2kyX2fq1iqSEvLxJh+KRRnyJlLAB9UzWSOtv2ECrDahb2mdQfMaQzvbsUPBdZBMV06fTphxug53AgB3WTBvcnkevwIG4yprIIKBb7gE03zTKUr7tLZrqEgfqb6UJeujdao+igNUvo8ezddlgiZ7AAPur1lKSxxDes04g8PASwSm6mTENNRo5BTF4xTS4J5WzfesJ1PWXBKdCKzHpEBmlrwnjL3oBV/Nrtb1/+DtuxrfHrqjqoSTv63dfw2TaUM8NgcEnBGjODaE4sQPrLBKYT/og/6TrI2f604fUflCCRVoPi0SS5JveMKo6VlLmMjTrO5MxrgVSrc7S8A4mtIRWdOCN2VUBZ77fp8F4gZV6LHn+e9jydo5dJ1kl8dVSyJ0kvhXaHTKih4q1JkUzbt/s5TVHbqMf4g3oSXydYriVoiOG8ApmRiIz6MAR+9SOdlYl6kTtynm02hCoQbvGPZC1h4k4u9lTzgu0CjcgBr9hWqYZSTXV8tX/Iwjc5FpvnKSEWA2XBDbUWUHc9bNDW06p2YNgKM7VM6+aBxdbhHFMF22AMcBxUX7SXhdc74aMa1tNUDi4CIO/5cdK81+5UB/MdTRB7Busq7YEhq8rxNGesJs0TGzl+/B7OubidehqStYWTqkn2NfTTVA==
Received-SPF: pass client-ip=57.103.84.170;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


