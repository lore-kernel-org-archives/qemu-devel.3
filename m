Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEDB60A260F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 12:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=h1/RHqKQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLftq-0003eK-5A; Tue, 27 Oct 2026 08:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLfsF-0003G5-Ut
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 08:02:00 -0400
Received: from ci-2005h-snip6-11.eps.apple.com ([2a01:b747:3005:202::53]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLfsD-0007yG-F1
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 08:01:51 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPS id
 5853B1808312; Tue, 27 Oct 2026 12:01:44 +0000 (UTC)
X-ICL-RepId: 01a17d3c-e189-7abc-b4cf-4d8cdb3da146
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0MWFsIWwQPH0wMUQJCBVZeWhEdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kFQQtIAl4CRQdDCUwLQANGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793102505; x=1824638505;
 bh=OXOoVdU41G0atQYKPs/YO1/9LOoOVcGYDCRG4R1jipo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=h1/RHqKQ9acCrmoks0D2Nep08CG48ozQHFKvGUgfAPWDtbLzbUEzdHEZO49Alsnu7vgmGKdWThhQ88vgsSB0nbcpO94c/RBfQj7q3hLXLXzTRrZ6mj8zt0xgfBcDfE6BHtcGiaOX3Pj2da8dXAglgz+G1le8yBulI7Q65mNcEdNbKuMMzRqcuOehkhOiZQJEwiGLQlAjm59XmQXJ6ka9vHR/RsDA1YRAaPMxZ5mwoApDgVmquKFWf3SfNzac9Ls/D1+zVFpZzLBxNjNPjRNiguQmGzmLsLn3uFnFEToSjB3PPabgieYBRJX2QjSL0IRkAAk3kgjs4OtmH1nshca+XA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPSA id
 033F21808302; Tue, 27 Oct 2026 12:01:42 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 3/6] hvf: arm: advertise ID_AA64PFR0_EL1.GIC
Date: Tue, 27 Oct 2026 13:01:32 +0100
Message-ID: <20261027120135.53048-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027120135.53048-1-mohamed@unpredictable.fr>
References: <20261027120135.53048-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WYyyJ1ZLAGNtzFcVcnTXAKUXgKTm7mwy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NyBTYWx0ZWRfX+ZTgxq2gCfcY
 BvvMSqnMcBikwEY4wWOVmeAS5yQLQkv7STtkwdMO1vPyJRH0lZZ4BjoZd//vkpK52TVyJPn12Ky
 XATpqE0Y4w2VDV7iBqn5TwKcaJG+scLTO66dHC5k4raKdB+vG6E4rCsaHJ/Y3Y3kFO/UE31RKRf
 NkGjagNbTHLknrdgnACk+tj78+ckOUD/VkaGofV3wuX89akuhd27wV7Aa4jDzBteTAIp6J8JpRW
 EOi2cCft4ypattqaZOyNgSetN8C8tLpBWvAW9ejRXDtsYCrs4j761eS5KzG+5roumTKim5CCwU4
 xQ3mFfUDdv0RC/rTO1V0l4kI8t5ZfQSB/a1VZBQp1JMGnhXijS/UFxckwJn8Mc=
X-Authority-Info-Out: v=2.4 cv=L70QguT8 c=1 sm=1 tr=0 ts=6ae092a8
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=uXxi2Sgme_zNQaG30wMA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: WYyyJ1ZLAGNtzFcVcnTXAKUXgKTm7mwy
X-JNJ: AAAAAAABGfxiCIelZgSlcV0q2qMdr+fxkWIH0auAy+D11NhLLCL8mcpoNiwFxCvQxOlPA5o3+83cQuJhjtHvcEl0QJDWWtCBQlGPGNIFEHXB6ZWxK5EkwjN3xsfYq6DET/yhj4i/ziU6vi7fcrLI2PEjNO/wC4x3MQ44CtfaO3Pibql8ldV8ZnNmdSRfDLcJk2dwtKpdP02Y/K5kwaf8iI/WiuOfZuuO7N4w+dFHIW1qNVDM7JTw4h0rAI8Op/jB9+bRrRDZClUnOhgcPQAkyQYuO4c9IFcP1sWa90auEB5CciDr7aTcpf8S6vDzFajUw0UTXslRAIGlPYvwKF2S3ziveeAgdHyAVqt+2SXI87v1FqGWw3e1CkISZ4lspZaghzO2kLjJ5Z8pwuR+tiCL1kqjSVpqoqdB3QeO6QjeHuR1+Qwd5RPGmtPxHgElK0rwYyw/VAp4F0c6Lxm3KS/0w8uS5e/rNfykMyvSdQ60jDzpDir4eGS9arjudLqZJxbf8Iy76CuYse/ORc2g/DqFjdgMUVnDUAAI8wslxSaB5DUAVDzkwEC0Tzu4Q6kbKKcHt9wmhEZ5tlupiCQioDS5I368Tk8TwIEdVL2BFfbaubES7Clu5ErSqdGjTxxZx24glEpLhbn3AIvhfqmebwP6HhS2wQ7MEOWTx7n8PLpmO2TrOy/2ysR3fdldOBhO4JFQWMfnLIEdkGbloHL5wu5ClCncVXfv8wEFGFBAN5qk9OQbFRy6Ap4rfaw/orkmdkFjpJ6U14cUw5k3eYwezq0wDPXd0pfYlm4D48cCz0Eolg==
Received-SPF: pass client-ip=2a01:b747:3005:202::53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For the kernel-irqchip=on case, advertise ID_AA64PFR0_EL1.GIC.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5213842d2d..acbc257091 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1230,6 +1230,18 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         FIELD_DP64_IDREG(&host_isar, ID_AA64PFR1, SME, 0);
     }
 
+    /*
+     * On HVF, kernel-irqchip implies GICv3.
+     * The kernel-irqchip=off,gic-version=3 legacy case also supports
+     * the host CPU interface but advertising it in ID_AA64PFR0_EL1
+     * is not implemented yet.
+     */
+
+    if (hvf_irqchip_in_kernel()) {
+        /* Advertise the GIC system register interface */
+        FIELD_DP64_IDREG(&host_isar, ID_AA64PFR0, GIC, 1);
+    }
+
     ahcf->isar = host_isar;
 
     /*
-- 
2.54.0 (Apple Git-157)


