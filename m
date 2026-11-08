Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF269606A320
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 09:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=Gk8jgT7N
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPzcx-0006Gz-Sj; Sun, 08 Nov 2026 04:55:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xPzbO-0005Ry-Fr
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:54:18 -0500
Received: from st-2004l-snip6-5.eps.apple.com ([2a01:b747:3001:201::74]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xPzbM-0005yx-5I
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:54:18 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 BFA91180009C; Sun, 08 Nov 2026 09:54:11 +0000 (UTC)
X-ICL-RepId: 01a1ba94-6c70-7c28-8ee5-b9e2ef524329
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtIBUMGWgReC0wHQwJZEhVdRV4CXwpfFV04RgNHGVcUUBtHDFUHV15fChMLU1ZHHkkKVgleCEYRWxRWQ1EZEgJaRQVNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4YWRtAFV0RUBlWCV4VFx5BTVoCVk0FSgNfAVoDQAFIClgDWwFeDkgLXARGBF1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIHWEcURw4PE0wLRwJaNFYfVBlaAw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794131653; x=1825667653;
 bh=nVK8vDM8XzoQ7gU4FL1Cwxgq28hF7I8+bUQSMNiuXqA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Gk8jgT7NY2hDh/YqaFvVFvuteeuIl/guR9DPfVXm/RbC2zjl7VbRx8u9G7AG9LOL1ATFm5b8gpxq8zbXdP2dy0DKNCnFF8cJhRxf0/YUkdZ0R/0bSKWkWVFSF/ufSNopVy7EqELsgdOwijNJNw9W17gKUaCsITAqlwf52MCVZsvcWzlU4PTT7ZEbqm140yxDKNlpZtgLLyXEx7TqWTEc2wqphV/8092OABhHu971xvCxp+mSWFd3Sn+RkS6WauCZNIrNtvq7T9rMppX0gjyswMfHW2A3wwt+BN4o/USiFRirbdDF+r+P0PVvIhbNQI6g2cSsoD54tMykpDVG0HAJ/A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 821A818000CF; Sun, 08 Nov 2026 09:54:10 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 05/13] whpx: i386: save/restore xss
Date: Sun,  8 Nov 2026 02:53:55 -0700
Message-ID: <20261108095403.70813-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261108095403.70813-1-mohamed@unpredictable.fr>
References: <20261108095403.70813-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 78yMvUOEDbqg2SFD_ZO1f96EggqiAN-b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAzOSBTYWx0ZWRfXyIMts92ULh5t
 X6QFGdLYFNh2M71Qp6HUrfWxcrSTtBNs5xDeynvzuhzrU9HKSHZRmVamrnDSlA4mXb6RJycEJeT
 z0ykqMugzCNnMJeYBveyyqgvOORO68NtUYg67WYnPX7kJaLZ4aZqzvDaXDBha/ulXyuEswRiRF8
 yTztnYYXReuw5PtOxjQZvF94JP/gZvk3nEHQ4FzZqDy/5Q4NCCUBRwzujelM0+7QQ0vuMF+hCpG
 gItNibGkOHSYxD602xwHiohj8+1+lVJn9SDav6gWkQfAvdOPCFbzoSTxO4hG2SIy2P0/FqltNRs
 /3ffx4PLv+zZtDbvKhX3I+0GhNQLksNu56CqL7T9b6i113nkf9PP2Wq5SVpYes=
X-Authority-Info-Out: v=2.4 cv=Kd3fcAYD c=1 sm=1 tr=0 ts=6af046c4
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=vvjR5Bv0Qg6bciTORDEA:9
X-Proofpoint-ORIG-GUID: 78yMvUOEDbqg2SFD_ZO1f96EggqiAN-b
X-JNJ: AAAAAAABqoQI8lw3BYiolSmSeGqUaPUvkI/9B3NQWHocsPy9BoYI1tyHy4knRwEJ0aRJOK
 naItuVcrs22Z6t/+wqQhzArBSN8rjMhHKIHlgNLFAfqbZ4z8YxcEqJLVJ+cbbivnq4l8Gs
 etvR3vl9Udi0Tvubb33Gu1x3oR3UC8INvlOORdcuqFYVJsaHN3NcfFuW3UpVdz/M+7PpFe
 b/2OSgZcWaWxXpBMDSY38HhjtkFHgwsy2A590gtRkeGrievrGmsBYRURq3Ptc4xNRvFhPE
 bbOk/VQ72tIgSqpNYdE+fArGTrUMAl8EkRiJX32v5XsUMHNnBaARTBln642kuIqE+/FdW/
 namMDyaGiB+ItRscTT6VTTZbf+pSSxZS1oZyl336jppGppcVqhXk15kOf7oAGcTVRZObLC
 /UiIMCW4f/1Z8uLVO4glJKHKGDznzynMr2W7ai5D8uII3Odlr9k9Iarzi/7LkxhFtsbJ5n
 Wva4lCEdLyeG7JuST0NsuQHMxH6yRYQ7qDx6XRQeSOnNLkUICou5nnN6v7gViCf++VPMkD
 VMc/wIOVt1SMwFgCKierd9RoRrTutHrc52KmAt3446oVGWK+ZI5z7wR3lilSn7nZmnKpru
 qdLpMzDBNiefqHRPX9X6Z7sPZNTWB6pkogaVmKB2mHOb3Al2gZcwvjWgCr2QwyvGCz0lMP
 RmyLIPUap7GxmMVoT36Msc7xJobEVYq6WcNnzgaLwc+4maMLoH3t4UOVdecGl9dbBJj4b6
 SnG6V7mwQw5MnhHUJocpsyiVymOC0DSLYQnLet2Wj+mw==
Received-SPF: pass client-ip=2a01:b747:3001:201::74;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

More work on VM save/restore

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 68272c5657..408a1667e0 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -346,6 +346,8 @@ static void whpx_set_xcrs(CPUState *cpu)
     struct whpx_state *whpx = &whpx_global;
     WHV_REGISTER_VALUE xcr0;
     WHV_REGISTER_NAME xcr0_name = WHvX64RegisterXCr0;
+    WHV_REGISTER_VALUE xss;
+    WHV_REGISTER_NAME xss_name = WHvX64RegisterXss;
 
     if (!whpx_has_xsave()) {
         return;
@@ -358,6 +360,17 @@ static void whpx_set_xcrs(CPUState *cpu)
     if (FAILED(hr)) {
         error_report("WHPX: Failed to set register xcr0, hr=%08lx", hr);
     }
+
+    if (!whpx_has_xsaves()) {
+        return;
+    }
+
+    xss.Reg64 = cpu_env(cpu)->xss;
+    hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
+        whpx->partition, cpu->cpu_index, &xss_name, 1, &xss);
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to set register xss, hr=%08lx", hr);
+    }
 }
 
 static int whpx_set_tsc(CPUState *cpu)
@@ -691,6 +704,8 @@ static void whpx_get_xcrs(CPUState *cpu)
     struct whpx_state *whpx = &whpx_global;
     WHV_REGISTER_VALUE xcr0;
     WHV_REGISTER_NAME xcr0_name = WHvX64RegisterXCr0;
+    WHV_REGISTER_VALUE xss;
+    WHV_REGISTER_NAME xss_name = WHvX64RegisterXss;
 
     if (!whpx_has_xsave()) {
         return;
@@ -705,6 +720,19 @@ static void whpx_get_xcrs(CPUState *cpu)
     }
 
     cpu_env(cpu)->xcr0 = xcr0.Reg64;
+
+    if (!whpx_has_xsaves()) {
+        return;
+    }
+
+    hr = whp_dispatch.WHvGetVirtualProcessorRegisters(
+        whpx->partition, cpu->cpu_index, &xss_name, 1, &xss);
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to get register xss, hr=%08lx", hr);
+        return;
+    }
+
+    cpu_env(cpu)->xss = xss.Reg64;
 }
 
 static void whpx_get_registers_for_vmexit(CPUState *cpu, WHPXStateLevel level)
-- 
2.54.0 (Apple Git-157)


