Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77227606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=H7fbFIdv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0TO-0000Z5-9k; Thu, 22 Oct 2026 17:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK0T8-0000SN-Cg
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:37:04 -0400
Received: from st-2006c-snip6-8.eps.apple.com ([2a01:b747:3001:203::1d]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK0T5-0005qk-AQ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:37:01 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-1 (Postfix) with ESMTPS id
 3BC0718001FB; Thu, 22 Oct 2026 21:36:57 +0000 (UTC)
X-ICL-RepId: 01a1658b-b56f-7373-9620-9274d6101ff1
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0MWFsIWwQPH0wMUQJCBVZeSgwdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kAQghLBVkARQBBD04GQAJGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1792705018; x=1824241018;
 bh=2jaaHxoh/zRE+vfdqjaf+dvT8F0+8p54HfLCOmDbC+8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=H7fbFIdv8PmFZYrlUsVZWrt357Prmo8j7BCRFRpnGEtWCpdmHjlx5qEcRWO8CVj7qxjLWb8pBirY0w2O03D66/AJftV/WHxERCj421ubA++LAzLUEAvd6m64sx9UCkYkjXzeSMRhQjsjd0rhwn97Ix18Zz1tkROLpW7keWmX9cICC/EHnR6xLPp+mLFDfZ794OshPf6xHXOvDywJka54a/haTtIHrCrNxSuqeT6/WfRg4l8xF3XHFGJ6GzjNa50stArhiLVLk5dlaM5HnfnLizGiUlh0fQhyNe5dVvicCqHRmUR6NHUvSZyayORWU3cPcd5yuS0MvM/Z7cSEvuq+zg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-1 (Postfix) with ESMTPSA id
 0690F18003C3; Thu, 22 Oct 2026 21:36:55 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH 4/6] hvf: arm: remove broken ID_AA64PFR0_EL1.GIC sync
Date: Thu, 22 Oct 2026 23:36:45 +0200
Message-ID: <20261022213647.21665-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022213647.21665-1-mohamed@unpredictable.fr>
References: <20261022213647.21665-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NiBTYWx0ZWRfX613Opv4J0Z7j
 moWFIE66pZJvPIR4jB03TkSm4n1FhfAFFFqnDOAnJM9sYLhWS0UF96Mcq5Crk4RFODQL5V3tdu9
 rTCbEMRP4I5W/wipmJWnEylH1XLCCvQXh8Gk9iqAWWN6huN2C/gYw0/3oHUC7dpEm2Qd/NZTvFj
 L4B1z1Gr5v8tyAcDUUbmiY7q9Q/e9h4m3fkxe6GndzhImVyBGlQDBwuaL1sVUY3iZbfTIMgRUvB
 zCnGHCp4isTiU15OOe45ClOyyUBixYu7qMS2A9cPYq2XseHk+Otyu9g3a/NOK7mAdSg2vcn12D+
 iKwY1vuYyoW97dplWKVfjk0TVCnGYSfUdjhSMm1rNbj+FCh/93EZo/pOr59oag=
X-Proofpoint-ORIG-GUID: yPhfc4ksxz6isOUP3766Poy3EQuqdXiM
X-Authority-Info-Out: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=6ada81f9
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=wg_TqX3Y1j1pn484TWkA:9
X-Proofpoint-GUID: yPhfc4ksxz6isOUP3766Poy3EQuqdXiM
X-JNJ: AAAAAAAB2oKWSqaA5cE0/B4m4Mx1zFaew4Z+FNfAN3BH7M9zWluvYhbACR89XIoAFQlMEzD65sb6qvfMNMtdK/FU4U1IbX5bwZCQxqOZ+7jjpNsePIur+0z2rjuWsEyCwhXKJrCkKCUL9pbh6jNkEQGqqKyrvOb8uVrXNq7f3fD0jkx3ey/IXoTA8D+dW0w2Sx1A32BqJdY3pSMZu6xj/evJ+02hrRIXwl93qemkQfP/G0tESc1LLLghXh+06D/ja6YKA5SLShwdQB15CptLaOK2YgFWtMQuBqHx2vJnLVS3o0Xx3VQzUN+UUF6SzBys+EK1RwkEORh1FMr18vQ55QmNmlSQt1EU88xOrTvkx5vjUY2wAFpgjo1S0QzZW62WBqai26dRa2JZoz1tV4qrCA+f3Vs+ErL+aIaq7VFlsxv+ruV+gYAHNFw2Qs6l5SYIgzPJSv369ZxgaQfXw+wYXBYW6P2oE0XOV5X4GVEygpQduBdpJzwyVcg40YBc1FVvVbMCb7A4onf8wI4N6GshCnegezl8+W2MdmQzYUV8lOD3VHF+XZYhQtc00DnlyS9BzgFrnFZIO5bq7BqkElnBrYA8VII4Ge+TEmU0Zq9zKul1lFuXm5zB/xrJr9PFaSYtBahEuRPkK4MBHj6NM7w8f1Vh1OhOg3UAZ39FiakVX7RAJoMo1kgpuAnlYtxY2gas8N+B0ezJZgofynNwDb5N2sKK1WBwRpQvKaYv0Px+s4UF/RbCOj71/vOyE+Ncd0fI22Gd/mbm5XvWNiNggWmUCJ1f9rSVU8ghCQsc6fq+wNYoqL+6KZZ20z4VaA==
Received-SPF: pass client-ip=2a01:b747:3001:203::1d;
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

The GIC is only realised after this executes
in arm_gicv3_common_realize.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index df047b5dcc..1237077603 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1480,7 +1480,6 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     assert_hvf_ok(ret);
 
     pfr = GET_IDREG(&arm_cpu->isar, ID_AA64PFR0);
-    pfr |= env->gicv3state ? (1 << 24) : 0;
     ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64PFR0_EL1, pfr);
     assert_hvf_ok(ret);
 
-- 
2.54.0 (Apple Git-157)


