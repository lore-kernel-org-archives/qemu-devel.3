Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CD0CCF9F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 17:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEA5R-0003YF-RO; Wed, 29 Oct 2025 13:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5N-0003Ut-6I
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:35:49 -0400
Received: from p-east2-cluster1-host11-snip4-10.eps.apple.com ([57.103.76.53]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5D-0003K0-4n
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:35:48 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 D465C1824483; Wed, 29 Oct 2025 17:35:22 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=1HDLl+vsTco3N+tEGqvISSZb2bm2NYHKpsf2pCMBzc0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=BwAsqKOSbip07u5CS/m/UfySTMI1w5sgi/boEIqlxAgCJZnqMcPYAeRm9+Fk9szVsHvl3ewxEkzwICWPHysoxHvBwMz8oRywdytz088XdX+UiudcEtJhU/fWkpJUwRLZoR+p6RTX1mdJdzyH+2j/j15yPIKmI9AGtaI5ijFUYCWMTcCI80xWF54f1siNcHN14s9duu/DcthNwBAAMdLYFZlEf5Ih+F0+QgtEzRBUJaALSmhKDoabQmC7NQgMoDwD9fEfR8KsQXyazyydcOJ7lcljAicEbQtg//Yov1xYXpCyBL5Nk1QxTgpqZAoOswb4/wzIvOr2+soOPUN8X0upFA==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 8E4521859E66; Wed, 29 Oct 2025 16:55:30 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v10 08/28] whpx: ifdef out winhvemulation on non-x86_64
Date: Wed, 29 Oct 2025 17:54:50 +0100
Message-ID: <20251029165510.45824-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251029165510.45824-1-mohamed@unpredictable.fr>
References: <20251029165510.45824-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NEJjKMJ3uqR4tUUv3UdyP86MizXMCZB5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDE0MCBTYWx0ZWRfX3fl1uFD1Ytjq
 bt98jpt2ftshxAr9lpguSvWhQPSSc0PRh7eXQWShczoc9QVDMH94Gbs50N377PkShWfR30in7Hd
 K9L4Acxj3Hz3m3iDJjlZei7BaNBWLzdsXm0TEou5GD1a9VS5Ba6UHu/lE0j5H3P7QHqaolhhq60
 pfwJZFku0dS7VTU9DbwYawvLsQ5JZNRPZJLsn3NtBQLjv1UKLT3EuH/asOKGcztLC41Io3VzfXN
 txTgKCLjtZaDiXRLiZvTuTNMo797rnK52ymFrf6GjXhp22COdFU5e6Ky/Vz5zSm7Ja//W8Ffs=
X-Proofpoint-ORIG-GUID: NEJjKMJ3uqR4tUUv3UdyP86MizXMCZB5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=633 mlxscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 adultscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510290140
X-JNJ: AAAAAAAByo7/N4vbmLcRbOgnRTmmKl9nApjKURLXZm1hkyggvasJuajH3PpfPkuio45T9OUo3gbWMEQb0FGNYhoWvPzkOLdqLfyjuZoyWtF/rm0mUqGFOsGtdIg3Ix/JEYRqc6yv+OSgKfa3mTwD6fEp6TTa7OY+8wmYRd0alx01yIs4S7Ch24wdq4JIZYMCZCIE7RUpsw4LzxPCU+070oYwiVPS3/JF0a5FRsti0eSjPWTHxkUDFu9NZipcnxjwemT/idtmPPluLXW0r/4a9IK4CSu78bB16C3YM6RRbDFMZ4m0ngu4h0Fziy7WVSZBNiIOX7CsLhV7oJ+L/DCOgL7WUScmglRM43r6lFMEhB/5XFrbcDxxyI+6tBUDNnfVUBQPbs75AcmqqDJ73AxO0TgxNIMxW6+Z1dCWvMKqR9itkS/qcVRd2XgEJ82Lfqs4NIzYBzG4nuyqNWmANCEmys4EhuTi4SeQ24shTI+XNZBMZOXu41+2y0oyua+0c3L1RFOiNBpiDwX2hd1kHRiTMQvzeAvndKJ8NHIfJy/bcEtYCnswoCeyKDSw3d9nSRR7z09vllyGDDhec/99vyuWGKFMXT5gsEn2FedmCM5aB4sWWmlFyEmNGGq0Q7YKU887wA7Qd5SEwVGjuqYqUczbAKObD/cViQn1RNVVCpJzRXJeB6SDwG8w3FcKw8feMRcuO5/sj7Ov0V8+Z4Prb1tY0qe2/DaymCHRpB7K1eBD2zRgWzo3OS8iwKMnNX4eYDT4LefbxoVESPDEP5MSHR5+SPlKPsHN
Received-SPF: pass client-ip=57.103.76.53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


