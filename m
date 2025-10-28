Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA175CCF9EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDtRw-0002Lo-Lp; Tue, 28 Oct 2025 19:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtRp-0002HT-4d
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:49:54 -0400
Received: from p-east1-cluster6-host8-snip4-8.eps.apple.com ([57.103.90.209]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtR7-0004q7-4w
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:49:49 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPS id
 76A851803784; Tue, 28 Oct 2025 23:49:03 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=jo9W/NpYfEdIC6CdCIx10Eqt7ku8SV4hAzngP6kYZbk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=XIncgXhBk50Vcordu5gvwevqrJ8GSMFUSS3RnksGGjVyuj3ZLiPqfnm/RajHSbIvRUw8kiN6HycyohwsklEoGVYGGRjW4k+/mjMIfoF5YmXX9sA5Got+gQNpY9HZVyKNc5ZPgr5xyo/5UUGhRavltP2PX6DD306gm5UW+8anfSCEbe2JskKeByX1oHdPi5GK/JzI1zF8s38GHEOW5sgSqoWudqKkbYJHMK+Xk/Qi0QFCQBWBIm38MOGtHUe75l9OSYnKd9cLSzmd0aK94trJf7ImFq2Aqkqv8tzPuFMHSuXqZTq3568d3Yjn9kxXUVdYe/8IEJ6A38NqW2owuC7jIw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPSA id
 79B7418034E9; Tue, 28 Oct 2025 23:49:01 +0000 (UTC)
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
Subject: [PATCH v9 26/27] whpx: apic: use non-deprecated APIs to control
 interrupt controller state
Date: Wed, 29 Oct 2025 00:47:56 +0100
Message-ID: <20251028234757.39609-27-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251028234757.39609-1-mohamed@unpredictable.fr>
References: <20251028234757.39609-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8BQWhcjgj0pFxB1AX12Sp58gS_Qqy9dP
X-Proofpoint-GUID: 8BQWhcjgj0pFxB1AX12Sp58gS_Qqy9dP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDIwMiBTYWx0ZWRfX2MvCCfOYXxUA
 LuAplZwli74JgUiJpmGEmSqWc7uwrfZwBCMR8Xc3DesPasiSYgI39252XlNNspuBQxU7pbym9ck
 jDWwO3432KNK1qwVdSI8zO56rsRWqJ8gUBycYSSjzhZ3lHcBW2CPpTZUaYT4VeuaQLt+hP726l0
 afN1mFHj8TyJNbs+VPIJd/US0w50hGbwFl4fdTwSk/aCPlsjVzcHgb3aaBft183ujsml4AMyT1K
 BOTrJ1vSxzPvXpHxIwt2ximSj163BYPaaOMmwqTmdIt3mDQ+1bf4R1Z0SRc2jKEPIkLmR3Qmo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 clxscore=1030 malwarescore=0
 bulkscore=0 mlxlogscore=752 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2510280202
X-JNJ: AAAAAAABql2qxcO0yN7mA0ewvSlf95mNqQPItJJjeOnD/tTGo/FSyPD+ENl4hYUYVr/fF+SwbDwDpnTfE/i0hF+3w/EKsUY6oBwsd6HbtOaU84fVeZiHLmdmp0rFvL4yys6ZGzRg/5gGKDJPi8nOCJv9qDGciYF4YtTKKkp8nSnIYgnCqIAs6APJs9hcRE+Y7Q0G8d6RqVYiK3C7ADJYalKYMwBjXHDLTHMjNqIGCiYtCK94bDEFrM+rzIWSvo9lysWABbeqkbJDlmfD6NWzD/KgLx4Ylgm/VCezE4EmCW1PZ7IbRy+QdWspPe/SbVV8H3HHEVzvQBjwIuhun3bOnliogzJt4k1l6dCJfg5dtPltza7btfFXGM25ByDoOSJVfA1VHWnTHNzEN+bnZQU3G2expGUkOMpc/a0xKwsZ+0KGAsoIpFJIgdGTQuVcCPWsYU70S0f4rKUX5s0sz4mEmmf49Zkx0+2Yc4WwvCnNM79F53h9wFYqYGJML+ogiFgbCSYj+ZZ0z2frgGcJx4K5Nthe9uVXiwqLRCkMsnXXCbYIimr4x8AEFn9ymXT/kal5qX676Sq8NfEJNdf9E4SWq4EaJ9ut9Ly0h26gtEIn7iabNvtvUWfzh6lL92fGU9SDlkxCT4fP9cGAAKb/fquohAkrqH7xR3G/J1DinKDsVzAgRGJCij4mUMDZPzqB/I8G+i3k/PmhV7V5Byj2EvlUCX1h4wn7qRsACCVzaLpHrfhTkFXX6elkOEpC/liJB98esqMqlwnvyVG4eU7ZDoZGlruyUeKXfqPIcjs=
Received-SPF: pass client-ip=57.103.90.209;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

WHvGetVirtualProcessorInterruptControllerState2 and
WHvSetVirtualProcessorInterruptControllerState2 are
deprecated since Windows 10 version 2004.

Use the non-deprecated WHvGetVirtualProcessorState and
WHvSetVirtualProcessorState when available.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/system/whpx-internal.h |  9 +++++++
 target/i386/whpx/whpx-apic.c   | 46 +++++++++++++++++++++++++---------
 2 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 81c0c1819f..90b4077b76 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -86,6 +86,15 @@ void whpx_apic_get(APICCommonState *s);
   X(HRESULT, WHvSetVirtualProcessorInterruptControllerState2, \
         (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, PVOID State, \
          UINT32 StateSize)) \
+  X(HRESULT, WHvGetVirtualProcessorState, \
+        (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, \
+        WHV_VIRTUAL_PROCESSOR_STATE_TYPE StateType, PVOID Buffer, \
+        UINT32 BufferSizeInBytes, UINT32 *BytesWritten)) \
+  X(HRESULT, WHvSetVirtualProcessorState, \
+        (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, \
+        WHV_VIRTUAL_PROCESSOR_STATE_TYPE StateType, PVOID Buffer, \
+        UINT32 BufferSizeInBytes)) \
+
 
 #define LIST_WINHVEMULATION_FUNCTIONS(X) \
   X(HRESULT, WHvEmulatorCreateEmulator, (const WHV_EMULATOR_CALLBACKS* Callbacks, WHV_EMULATOR_HANDLE* Emulator)) \
diff --git a/target/i386/whpx/whpx-apic.c b/target/i386/whpx/whpx-apic.c
index b934fdcbe1..fa45a64b21 100644
--- a/target/i386/whpx/whpx-apic.c
+++ b/target/i386/whpx/whpx-apic.c
@@ -137,11 +137,21 @@ static void whpx_apic_put(CPUState *cs, run_on_cpu_data data)
     whpx_put_apic_base(CPU(s->cpu), s->apicbase);
     whpx_put_apic_state(s, &kapic);
 
-    hr = whp_dispatch.WHvSetVirtualProcessorInterruptControllerState2(
-        whpx_global.partition,
-        cs->cpu_index,
-        &kapic,
-        sizeof(kapic));
+    if (whp_dispatch.WHvSetVirtualProcessorState) {
+        hr = whp_dispatch.WHvSetVirtualProcessorState(
+            whpx_global.partition,
+            cs->cpu_index,
+            WHvVirtualProcessorStateTypeInterruptControllerState2,
+            &kapic,
+            sizeof(kapic));
+    } else {
+        hr = whp_dispatch.WHvSetVirtualProcessorInterruptControllerState2(
+            whpx_global.partition,
+            cs->cpu_index,
+            &kapic,
+            sizeof(kapic));
+    }
+
     if (FAILED(hr)) {
         fprintf(stderr,
             "WHvSetVirtualProcessorInterruptControllerState failed: %08lx\n",
@@ -155,16 +165,28 @@ void whpx_apic_get(APICCommonState *s)
 {
     CPUState *cpu = CPU(s->cpu);
     struct whpx_lapic_state kapic;
+    HRESULT hr;
+
+    if (whp_dispatch.WHvGetVirtualProcessorState) {
+        hr = whp_dispatch.WHvGetVirtualProcessorState(
+            whpx_global.partition,
+            cpu->cpu_index,
+            WHvVirtualProcessorStateTypeInterruptControllerState2,
+            &kapic,
+            sizeof(kapic),
+            NULL);
+    } else {
+        hr = whp_dispatch.WHvGetVirtualProcessorInterruptControllerState2(
+            whpx_global.partition,
+            cpu->cpu_index,
+            &kapic,
+            sizeof(kapic),
+            NULL);
+    }
 
-    HRESULT hr = whp_dispatch.WHvGetVirtualProcessorInterruptControllerState2(
-        whpx_global.partition,
-        cpu->cpu_index,
-        &kapic,
-        sizeof(kapic),
-        NULL);
     if (FAILED(hr)) {
         fprintf(stderr,
-            "WHvSetVirtualProcessorInterruptControllerState failed: %08lx\n",
+            "WHvGetVirtualProcessorInterruptControllerState failed: %08lx\n",
             hr);
 
         abort();
-- 
2.50.1 (Apple Git-155)


