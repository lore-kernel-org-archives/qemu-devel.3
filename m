Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD47E606A320
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 12:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=ML4bc0T1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLftm-0003c6-Ts; Tue, 27 Oct 2026 08:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLfsE-0003G0-Ky
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 08:01:59 -0400
Received: from ci-2005f-snip6-11.eps.apple.com ([2a01:b747:3005:202::3f]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLfsB-0007xx-FA
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 08:01:50 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPS id
 2174618000A2; Tue, 27 Oct 2026 12:01:43 +0000 (UTC)
X-ICL-RepId: 01a17d3c-dc9c-7b78-80fa-8aa6eec4dd6d
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0MWFsIWwQPH0wMUQJCBVZeWhEdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kFQQtIAl4CRQdDCUwLQARGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793102503; x=1824638503;
 bh=aVO//rcw+/g+zgWWL2JKU1Q7a9ghZlEWC73o0mq9AQ4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ML4bc0T14Gs+yFtkoqNBlrFCge9Pf+xOJprdiH5pxfFgmlgMUdkVaeq76BQyJZy/AO2Y+8b3nB/ME2d1UgfOxg4bNuYvl1zjUblGnzlgOhovq6ofr2qyFRDz7AyOVOjVdW4FcuEp25xZGBdw0kGnvpUzAjSGYEmcKp4OW4c6bOGLj2dOwN6sE66iSh9avacb5QMtSkOrOqavduruorp+StfLoTBg0/YGliH9mWKvu9Ux66DmL0PqmOuVGPcIRJ/AQx0/n8CWLXtQht6za19ewxnKqGwln0faWzgKqe40r5DnBoBbC8oOOmNOABLfPAFYUFz+WJhUH/4N5eYMLl3Osg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPSA id
 A65011800122; Tue, 27 Oct 2026 12:01:41 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 2/6] hvf: arm: remove broken ID_AA64PFR0_EL1.GIC sync
Date: Tue, 27 Oct 2026 13:01:31 +0100
Message-ID: <20261027120135.53048-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027120135.53048-1-mohamed@unpredictable.fr>
References: <20261027120135.53048-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NyBTYWx0ZWRfXznn8kW2O7hnq
 ZkKwhYNpkjGB0nVae8296f4BXnOyuYlfZije+6FIAbzpr4rfoGwJUwQk+5s4OjWXiyu8LJzzkEj
 Kjt4LoDh7VCZyT/2rvjKUWwTloVD0VBv2WpsOw/akM2/ucVlvMrHW8ce58QJuU4OawWAfxR8N60
 qGH/CEormJ+xPNfw4slMM2wF/xLkEoVd6NXm3SnOTc8IV2gGFxN76WYuziBKjiOhm9u4In5JlMR
 kjzXGIo/BiHqEpQ8uZv0M6V/m0Vc3c0E0FKc4Ud4GL0KERwGaj/c6NRm77QqCf3Y38qpVqDRiEE
 NhA08jTsTl3cy28HnFxjm9VZpArBUDAtq17/yW2jqrcwuly4tkC3FYIFPqbhco=
X-Proofpoint-GUID: qJLswU7Y7Yv9kD_Zx4ifn_2UDqTbUzPJ
X-Proofpoint-ORIG-GUID: qJLswU7Y7Yv9kD_Zx4ifn_2UDqTbUzPJ
X-Authority-Info-Out: v=2.4 cv=DvZbOW/+ c=1 sm=1 tr=0 ts=6ae092a7
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=wg_TqX3Y1j1pn484TWkA:9 a=cvBusfyB2V15izCimMoJ:22
X-JNJ: AAAAAAABF17vqh1HDralDw9ryXOE7X8VEMbgx6BgJWKT8g1WGgxg7KikNBetHfRg9CFmNvcqgRc6Ocz8gg4V5lE893EXC20qjQdN9i3vCKO1YTSyQLM8LlgotJXQYH0HpfEYResMeCLuW1a6EoduVRf7IRECO1kONvAPcwxlkLyh8oqUsdEibt4sbIVkcVm0aeLJXxIN91tw63AosVXL1R/A7moB7Zi6eYpSRvc7vPbbMHL3/ACMBwdaSuC7hwZ4BSMPsvzNA/0hDU/9aGUQlf+VvEcfUSHbT6JfAiT1lM6rcctkvTwe5dDBwqyWt4kDPC/smCnXJYbVX9QqZKtWiX+GlvcCNAqwXoZeUXtIM3u84H/dC238sipdsoDmoH/F75kLn8uaGCEWqxxdpfr7yLoXqF7QBrGXZ2TT84ZaTxKqZw0yvOmV8KOKQv2UFiF6pDzbakJ91qR6lBAgmWRNSMy5DTTC+sPs4tbaHV6ojkPjuQZy0Hny9Uvy6f+uB1Oik6XEDwj7WAnqYUi5qYHTDvKSKhq2OCTJeE2Cbs1yQI4udEQ8eJIe5+3B1J6jFk23Vno4CGkwVpOsvABxoFvn5qxwo7bQylQc26FXNHk+uEyV+CNaxQy42QX876/LjK+dIJjb2U2NLXNt2IDbKOAq0QVBQ8kTU02z1jBuWVMtZHpYahfx18X4NW6nT87IP/VO4CpK8yXCPro3FUNCzhz9ArMhuab1z8cWwXt8NQ67ns4pyyW5NlshGgZBpQGFmYHLaBX4M7fe2AeDcCvxJ2/4IbV9jj6zGBvXiWIa8ByHW8WcdTx5WgyS2SOYIrRIN+1LIZeFGG9mZZPK0Q==
Received-SPF: pass client-ip=2a01:b747:3005:202::3f;
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

The GIC is only realised after this executes
in arm_gicv3_common_realize.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 6085ac2284..5213842d2d 100644
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


