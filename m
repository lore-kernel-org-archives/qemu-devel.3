Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B182CCF9EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDtQu-0001qf-T4; Tue, 28 Oct 2025 19:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtQt-0001qA-9U
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:48:55 -0400
Received: from p-east1-cluster5-host6-snip4-10.eps.apple.com ([57.103.89.191]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtQf-0004lY-Jf
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:48:55 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPS id
 347B418034E0; Tue, 28 Oct 2025 23:48:27 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=1HDLl+vsTco3N+tEGqvISSZb2bm2NYHKpsf2pCMBzc0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=YhmXj4iWI4HJh/0x3IVSgDszfALMhfq11gliN4XXk/mSABe/DNLp4PK7tYEhzd/1K2SzmPi/kZ9/67x/uHznUib3xHO5i6hKQK0R9oYTMARq6rMMG9TH2Pkd2Luf9A9gQRzJaua+hF14IZzl4HTxFOmQay0UJFCkPExQbGkqMhkN5SS/vfyFo5VPfJ9cGCxVugZwLtHaYIGfJ/SuNnisf6vpt6zBZBi5XrjRZ2lszFufBZeBXGKG8q+Z/ThzSpLNRS/H0iALYZX8KGvdBgoFq6McT3TRRbgz/gRb9ERPkbemelkD9v4t9lL9gMGstDMUOz7h3zYL6VeF5a20VIkRbA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPSA id
 D45901803135; Tue, 28 Oct 2025 23:48:24 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v9 08/27] whpx: ifdef out winhvemulation on non-x86_64
Date: Wed, 29 Oct 2025 00:47:38 +0100
Message-ID: <20251028234757.39609-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251028234757.39609-1-mohamed@unpredictable.fr>
References: <20251028234757.39609-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hvE44vxaJSZq5ABCVQWMHx7t55LpEPEn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDIwMiBTYWx0ZWRfX0J1LgiUp0nt8
 Kj9Ag5Y7DQJqqVGcYxbtXCdpjxvT9giVXaKtmN0EHBIbMu9FLHbWKrHNuQ+4wEEnPuij2o0gMhl
 yHI7tAgANyi+lFjYxhv70F4OX4fwr+Edu90nmXpx/tUIv2aPPGaEk+80R8bSaBIzYpPG3/g4RcV
 ju4oI6rDQYMk2qazx5COzv1SrcxiA3hyvxtsjK/6husJODPe0GHX56fb6jXpRxEQkLQGCQabu6B
 HNERsWMeFZQ3fvIYOdSTzm8kM+PeFE/C/cXg9uyLQ+rCEBnocxYDEpSIUQtomkdGuctmadetc=
X-Proofpoint-ORIG-GUID: hvE44vxaJSZq5ABCVQWMHx7t55LpEPEn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=767
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0
 clxscore=1030 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2510280202
X-JNJ: AAAAAAABebvpXY+dYVo6E7x8swO0UuX70KoLXs06gDSsxpqLVvbkpJAkZ1FwsQN9GU7x/EYR43whoDvyv1/1UtDnhL4z8fr4nOectjt9oKl6FSrmGkWOq8C0hWucuNoLRsZcwoWphQAELPn25J6PJexrVl3az6DVA/6M7y8+QqABJPbZ+ft9F+cHzqZGw7hZWgndyM1K0mQ+WJOX3onGGqWW3J2TguTfqDwbM5ueTcvg/Z8lXE3eXLzcXvlb/mHGOu6ueJg86+96WRW3riXvqR0mT5cBU/9Wj/ykpXCrdMHAhVXEn7m20dM2hL/uVvriGC8quk10soQuggJo5NnxCMK8ex9kxQ7lg27BczCEoM3vKPpxHeDJ0tZ7IyxXpnwPbfIS7+uxIiMUbKrL6aWaThnE9HHf+K53TJ+F2aMkMlGQdJzmXkgMjECHdOvucM0evVOldi0MbxerrzUVrKil45v9v41hfkLEWJ8y7yKPIGa3kiHsGna1jo+GFhonrqWYgKXs2BygdsFcahdQdqwKvq3c2bCYTDPcGAPrWsHgxCPP8omRFtDaiMJy3mJ9x28srlzf2OIeYm8A8tjkOZLS86sEbsZTfQ2SeGk5+t1mhMO6/4BrWi1qqpx0aaikRLGFFpmE3fnc2Wxr0DXsfe6cxytG2d0akQm1to4q/Ro+chaNCww5YD/N/lJ3PJ9hdNstDHejA4WRWGNhu8tR4reba2vZGZxC/+I5mSgWcU8lYF9BSsUcqW17RHd7
Received-SPF: pass client-ip=57.103.89.191;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

winhvemulation is x86_64 only.

In the future, we might want to get rid of winhvemulation usage
entirely.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/whpx/whpx-common.c       | 14 ++++++++++++--
 include/system/whpx-common.h   |  2 ++
 include/system/whpx-internal.h |  7 ++++++-
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 66c9238586..95664a1df7 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -41,7 +41,9 @@
 bool whpx_allowed;
 static bool whp_dispatch_initialized;
 static HMODULE hWinHvPlatform;
+#ifdef __x86_64__
 static HMODULE hWinHvEmulation;
+#endif
 
 struct whpx_state whpx_global;
 struct WHPDispatch whp_dispatch;
@@ -236,8 +238,10 @@ void whpx_destroy_vcpu(CPUState *cpu)
     struct whpx_state *whpx = &whpx_global;
 
     whp_dispatch.WHvDeleteVirtualProcessor(whpx->partition, cpu->cpu_index);
+#ifdef __x86_64__
     AccelCPUState *vcpu = cpu->accel;
     whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
+#endif
     g_free(cpu->accel);
 }
 
@@ -412,8 +416,12 @@ static bool load_whp_dispatch_fns(HMODULE *handle,
         LIST_WINHVPLATFORM_FUNCTIONS(WHP_LOAD_FIELD)
         break;
     case WINHV_EMULATION_FNS_DEFAULT:
+#ifdef __x86_64__
         WHP_LOAD_LIB(WINHV_EMULATION_DLL, hLib)
         LIST_WINHVEMULATION_FUNCTIONS(WHP_LOAD_FIELD)
+#else
+        g_assert_not_reached();
+#endif
         break;
     case WINHV_PLATFORM_FNS_SUPPLEMENTAL:
         WHP_LOAD_LIB(WINHV_PLATFORM_DLL, hLib)
@@ -539,11 +547,11 @@ bool init_whp_dispatch(void)
     if (!load_whp_dispatch_fns(&hWinHvPlatform, WINHV_PLATFORM_FNS_DEFAULT)) {
         goto error;
     }
-
+#ifdef __x86_64__
     if (!load_whp_dispatch_fns(&hWinHvEmulation, WINHV_EMULATION_FNS_DEFAULT)) {
         goto error;
     }
-
+#endif
     assert(load_whp_dispatch_fns(&hWinHvPlatform,
         WINHV_PLATFORM_FNS_SUPPLEMENTAL));
     whp_dispatch_initialized = true;
@@ -553,9 +561,11 @@ error:
     if (hWinHvPlatform) {
         FreeLibrary(hWinHvPlatform);
     }
+#ifdef __x86_64__
     if (hWinHvEmulation) {
         FreeLibrary(hWinHvEmulation);
     }
+#endif
     return false;
 }
 
diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index e549c7539c..7a7c607e0a 100644
--- a/include/system/whpx-common.h
+++ b/include/system/whpx-common.h
@@ -3,7 +3,9 @@
 #define SYSTEM_WHPX_COMMON_H
 
 struct AccelCPUState {
+#ifdef __x86_64__
     WHV_EMULATOR_HANDLE emulator;
+#endif
     bool window_registered;
     bool interruptable;
     bool ready_for_pic_interrupt;
diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index c59f9de091..4565436682 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -4,8 +4,9 @@
 
 #include <windows.h>
 #include <winhvplatform.h>
+#ifdef __x86_64__
 #include <winhvemulation.h>
-
+#endif
 #include "hw/i386/apic.h"
 
 typedef enum WhpxBreakpointState {
@@ -100,12 +101,16 @@ void whpx_apic_get(APICCommonState *s);
 
 /* Define function typedef */
 LIST_WINHVPLATFORM_FUNCTIONS(WHP_DEFINE_TYPE)
+#ifdef __x86_64__
 LIST_WINHVEMULATION_FUNCTIONS(WHP_DEFINE_TYPE)
+#endif
 LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DEFINE_TYPE)
 
 struct WHPDispatch {
     LIST_WINHVPLATFORM_FUNCTIONS(WHP_DECLARE_MEMBER)
+#ifdef __x86_64__
     LIST_WINHVEMULATION_FUNCTIONS(WHP_DECLARE_MEMBER)
+#endif
     LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DECLARE_MEMBER)
 };
 
-- 
2.50.1 (Apple Git-155)


