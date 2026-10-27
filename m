Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E39606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=v1DCRse4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLjaC-0002kR-0B; Tue, 27 Oct 2026 11:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjZ1-00011b-Bv
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:58:16 -0400
Received: from ci-2002k-snip6-11.eps.apple.com ([2a01:b747:3005:206::71]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYx-0005op-C4
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:58:15 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPS id
 8C38618004A6; Tue, 27 Oct 2026 15:58:03 +0000 (UTC)
X-ICL-RepId: 01a17e15-3ce4-743c-aa46-33268b46bdfa
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0PWFsIWwQPH0wMUQJCBVZeWhEdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kFQQxNBF4ARQdJC08CQAZcHx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQE4ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793116685; x=1824652685;
 bh=kXKzF3JxfE1w6BI+AtlgIv6wP7f/bEIQ3Z2YLqyjVko=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=v1DCRse4zVEHeJZakipaeFnAQjgRbwvgW0H+MAMG9Pevh53GrvSQTLZHP3Mq7ZDvIU6iR6GXHRmAR6uqkbPzHE1zuGp6TyQHm5l4sW83rsiK0NOtcg931Nzbf+0dAmH6FPJPn8egt+PaLFsjy91N9OS5s+K7dCYMWBYDXHyMftKLwojdP0eHlPe4yPeAglsl52qIlfaveu5cLTG19rFQqPJK3oKtOLS1wUfKjdXFVE4z1VcmiADfmOfE5Zws2PbY1T7wfgFhs5kKwa/ogNm+zHTOnkKqkB5tnIAR24PEkqZjcxFQ5QSo0zRj9QKZFfuH2H8wYy9m9FRJcJPlHMpDhw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPSA id
 0E5AE180015E; Tue, 27 Oct 2026 15:58:01 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 16/18] whpx: i386: also save debug registers
Date: Tue, 27 Oct 2026 16:57:35 +0100
Message-ID: <20261027155737.59271-17-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027155737.59271-1-mohamed@unpredictable.fr>
References: <20261027155737.59271-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _p2AHmLR4nz-NjDpR5X3l2lf-5HLuPKy
X-Proofpoint-ORIG-GUID: _p2AHmLR4nz-NjDpR5X3l2lf-5HLuPKy
X-Authority-Info-Out: v=2.4 cv=W9I1lBWk c=1 sm=1 tr=0 ts=6ae0ca0c
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=3nrfYwkK1g5-NatN6WYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MyBTYWx0ZWRfXxLt4zApCY/lZ
 MyLl0hTzuK/gTwuehRdFXaIq6OtPTxtw9eamGPhPMvKArWdIX8o7umUMhxOWQaz87J94doUS2Ti
 ftmvDQGCLfIJg8AZt4Aqs0VI0ygK6CO7te71+lYWhIYiSThJrUFli6mbKAy0Fx+ZK80v7CrVx7d
 7bgcA7w2ZxPDQT5XN1TrqEeAjbFAGgH9SskXK/YHGG90aalGCfg5VtfEaVKqosyJVyJXntDBnbf
 SElzFohW7GquNdnpQreHGSLKJrc/xFEpDcLblihEgUnWBzGlJYxSgzgKbR+7QPBqvQrC6agHsxb
 Z1RBgbDmWTtkpML5C48cc9e8BT4VD0mE1DFp2N8niSc66YkrevLAvgN1lsdD7M=
X-JNJ: AAAAAAABs4pI86vesmbGtvks070lj/wrqm6LNmFk2oe1AzKCkYzXS879yYa/dIgWKUq48zfo33VFY+lfJ7f7/7ynYTQGqlPFSB9qPqaETXt6qcP6qb7qSiIyUeG9KIFai46b2y7JQjH9vErBnYw0SGmnOmu2fX4PJ3hOsrCNPykhbqeQ4EK54cpSdT6rkXweNYC2PRGyhpAXMbmpknYsBxJ33tJUGnQLBQTakck4MGknMrjFm8SxntMKgGigg+VLesBgZAyJX89EyzKf/WLLV9bAOAGLAiJisB7je5QWB5hYQVuCjcsEocth/04hvlygq0M9k7ps8aFSAYvQ7UMi/oloGXi0YOjIdNsohKnzTAyLwCMuqe5A6lTFcciMnLEibj6/K8Ae5Y3nwRSxeUIKTMUW3km4jIaHI4bQBXR+kmDsSVyVcqnH7o85ULq5uNvjkN5Zhv0sz107vxi2dtCmXVCj7TJomNYMsEzT2rIVC0vYGOPdKb0KAVC4vPI6uW3HzVysUxBZYOR8CJVyW8DiQyi85jhZLZ93v/8+pRdDbb4cO9qYKqVMzcIIvE46Psv5aTgWAdH5eoKcvPXAEbJD+t9u3KtAjECTcRah4DOl61bEkrSM/lq9JvtgRwQ+MDUMPZbK/WOFkFR8l/duV1blOBQiT4b2VOeX7Qzn0ChaBupvJTaWoJ4eXHHJQjbBPPnVX2FrTk2k0Zqb1x1+sXFxYbfX0Esr32XggHtVrTOKQEstcWFwIOR3nAw4JBguxgLgOlo/Cu30OwWntnAijWmAnba3G5z7BroH+kBo1R7rhfIf0gNL/JA=
Received-SPF: pass client-ip=2a01:b747:3005:206::71;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 43 +++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 26ca879c89..d2cd8e8001 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -101,16 +101,6 @@ static const WHV_REGISTER_NAME whpx_register_names[] = {
     WHvX64RegisterCr3,
     WHvX64RegisterCr4,
 
-    /* X64 Debug Registers */
-    /*
-     * WHvX64RegisterDr0,
-     * WHvX64RegisterDr1,
-     * WHvX64RegisterDr2,
-     * WHvX64RegisterDr3,
-     * WHvX64RegisterDr6,
-     * WHvX64RegisterDr7,
-     */
-
     /* X64 MSRs */
     WHvX64RegisterEfer,
 #ifdef TARGET_X86_64
@@ -126,7 +116,12 @@ static const WHV_REGISTER_NAME whpx_register_names[] = {
     WHvX64RegisterCstar,
     WHvX64RegisterSfmask,
 #endif
-
+    WHvX64RegisterDr0,
+    WHvX64RegisterDr1,
+    WHvX64RegisterDr2,
+    WHvX64RegisterDr3,
+    WHvX64RegisterDr6,
+    WHvX64RegisterDr7
     /* Interrupt / Event Registers */
     /*
      * WHvRegisterPendingInterruption,
@@ -686,6 +681,19 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
         vcxt.values[idx++].Reg64 = env->fmask;
 #endif
 
+        assert(whpx_register_names[idx] == WHvX64RegisterDr0);
+        vcxt.values[idx++].Reg64 = env->dr[0];
+        assert(whpx_register_names[idx] == WHvX64RegisterDr1);
+        vcxt.values[idx++].Reg64 = env->dr[1];
+        assert(whpx_register_names[idx] == WHvX64RegisterDr2);
+        vcxt.values[idx++].Reg64 = env->dr[2];
+        assert(whpx_register_names[idx] == WHvX64RegisterDr3);
+        vcxt.values[idx++].Reg64 = env->dr[3];
+        assert(whpx_register_names[idx] == WHvX64RegisterDr6);
+        vcxt.values[idx++].Reg64 = env->dr[6];
+        assert(whpx_register_names[idx] == WHvX64RegisterDr7);
+        vcxt.values[idx++].Reg64 = env->dr[7];
+
         /* Interrupt / Event Registers - Skipped */
 
         assert(idx == RTL_NUMBER_OF(whpx_register_names));
@@ -1070,6 +1078,19 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
     env->fmask = vcxt.values[idx++].Reg64;
 #endif
 
+    assert(whpx_register_names[idx] == WHvX64RegisterDr0);
+    env->dr[0] = vcxt.values[idx++].Reg64;
+    assert(whpx_register_names[idx] == WHvX64RegisterDr1);
+    env->dr[1] = vcxt.values[idx++].Reg64;
+    assert(whpx_register_names[idx] == WHvX64RegisterDr2);
+    env->dr[2] = vcxt.values[idx++].Reg64;
+    assert(whpx_register_names[idx] == WHvX64RegisterDr3);
+    env->dr[3] = vcxt.values[idx++].Reg64;
+    assert(whpx_register_names[idx] == WHvX64RegisterDr6);
+    env->dr[6] = vcxt.values[idx++].Reg64;
+    assert(whpx_register_names[idx] == WHvX64RegisterDr7);
+    env->dr[7] = vcxt.values[idx++].Reg64;
+
     /* Interrupt / Event Registers - Skipped */
 
     assert(idx == RTL_NUMBER_OF(whpx_register_names));
-- 
2.54.0 (Apple Git-157)


