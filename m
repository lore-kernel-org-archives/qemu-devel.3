Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8474DCFA76A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 10:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMNzA-0004aw-8G; Fri, 21 Nov 2025 05:03:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNz5-0004Yz-8l
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:03:19 -0500
Received: from p-east3-cluster7-host2-snip4-5.eps.apple.com ([57.103.84.146]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNys-0007rF-GM
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:03:15 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 AB20018010EB; Fri, 21 Nov 2025 10:02:46 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=+fMggmtg/uZNHz3nywgemPAlDNuqwqAYkYrWDswgN9E=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=TpWSNx4s5gIlbKztRQPrKco/S1MuRTtTUFvqm8LLhlLtVcL7FHcfGU3hQAGYBo4C+KiZqMaJpokw0D6eDubLPpWd3g81G0O25rWY/92ir/rDLH/YZv+lvaTFkoHSgc7EAzzMinAMRZEH2G5+9DX/aGUxO5+wlkEYT7Zqgj6i35W60TY+d/sCge9B42EqhDvUhkXdNJSXW7zROu54zesJKeGD9jdfZhV10auchED6A6TGXBp85V0fn3E0fNZ3tO4YVIUWBxRtOWowG/ZcOAZW5Z+xdeyXgEcQopi1c98XqMRniNCGMiBoUSFQLXB66UOLr9xy6BxlZqX2k78v8565Kw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 7507D18000A6; Fri, 21 Nov 2025 10:02:44 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu <peterx@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Sebastian Ott <sebott@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v11 01/28] target/arm/kvm: add constants for new PSCI versions
Date: Fri, 21 Nov 2025 11:02:13 +0100
Message-ID: <20251121100240.89117-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251121100240.89117-1-mohamed@unpredictable.fr>
References: <20251121100240.89117-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jUpG7bmBWYPtbOGUzmWrAjOfj4JT4tNR
X-Proofpoint-GUID: jUpG7bmBWYPtbOGUzmWrAjOfj4JT4tNR
X-Authority-Info: v=2.4 cv=ZdMQ98VA c=1 sm=1 tr=0 ts=692038c7 cx=c_apl:c_pps
 a=bsP7O+dXZ5uKcj+dsLqiMw==:117 a=bsP7O+dXZ5uKcj+dsLqiMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8
 a=DAm2dGrMCKCYv6Tpj9cA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3NiBTYWx0ZWRfX5zi0LuepaGoI
 Vc8rqwV38fQJeXhxzY/GrACyF315RXg7g1xLeggnsIqxvCoS41JtPbirIzxgv+xN/R7hCv8zx48
 jEbj7YiRdNFKdV/DTiGwMztyC95ruGSF+mdq0na1ysdmXAF/LBExVT73Et0PjZ+lydLve1Snw4j
 FlRWs8L/gQxz+Gy1sKK8KKWipYcJ/2uaWiJ63zEO4+MJ0SO/Ma9r2u2MY34V6mlkXIjc3MwTjK1
 SgP6YUrBLixFM7fBjqNkaug6jtPdddfEPU9y6HlJe4hCRAf3M8RZeBsvsTcIU5Nk0Xln51Yotc4
 dIJVE6TY43cr7U9qVkS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 clxscore=1030
 mlxscore=0 mlxlogscore=919 phishscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210076
X-JNJ: AAAAAAABuZBPNeSdoDy4/Kd1GR6CvyjHJLRHl4KLz704tyS7KNTOjR+tR8BSuxvOd7IbcseLFL2Bwh7zHyxyRQKzUvANiCxLG+GCm30PSnAKcGhxBCny3c75wx6+JFytId1AvhraEq4DS7leZ8eOkYjjPABHE6JyMACyb9pV4H+/Oo8/c2J3yOkwuJoRHjMqKKIAXKZxSD/7s9cwpldPfpD1QZsJJVxNYcOnfRM1fbml7zg6GT4DhMdDb4ZsDcsffTKtF1MjgO0n5VB/Jgr/ZzUJpfqPBlZ9guYvFLelgIQqWJkNQJROsoRGxKYt8shJLhZH2k1hwhHLneyUwYxgDA+8rhxRaoN9a8JzT5dcFvN9je9juu6Ry6YCVfrx9LlXbveP1rF3zfV0wa62C/ABE/qeKuILtZfh1ByTyZA4axnrsTbQzXzYYMfuxwJWc494hlvjd1LLkuHY4iKOUHQkiJGCxNjZDISrRsoCwBEjqVRq9yc1WWKIaVWWTlt+kqb4BNMvQRe4JezkDDUSTiYSNrB1ZD1oTpUGg5nncV7t7JfDlBuX8KPz5dbd39l0YfLPIiaL0g3a0PZ+BPN/UlCyM+GR70uHmLgxZ6JnQWkvUkR+OjE8mzZqINQGP/huDelpE5k/mHpJmgxuQdbX3x/PQYu8bbAIByCHHemU1zo1e1IwWwjko3AtDgDUdNZJhwNmCPR7WEdzdKmS+cw5vqIDQcNpFSbV5UG1pTpSWV2R0MHgQcBD6Afo2YuAKKeYGGQ2RqcMJD8H
Received-SPF: pass client-ip=57.103.84.146;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Sebastian Ott <sebott@redhat.com>

Add constants for PSCI version 1_2 and 1_3.

Signed-off-by: Sebastian Ott <sebott@redhat.com>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/kvm-consts.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
index 54ae5da7ce..9fba3e886d 100644
--- a/target/arm/kvm-consts.h
+++ b/target/arm/kvm-consts.h
@@ -97,6 +97,8 @@ MISMATCH_CHECK(QEMU_PSCI_1_0_FN_PSCI_FEATURES, PSCI_1_0_FN_PSCI_FEATURES);
 #define QEMU_PSCI_VERSION_0_2                     0x00002
 #define QEMU_PSCI_VERSION_1_0                     0x10000
 #define QEMU_PSCI_VERSION_1_1                     0x10001
+#define QEMU_PSCI_VERSION_1_2                     0x10002
+#define QEMU_PSCI_VERSION_1_3                     0x10003
 
 MISMATCH_CHECK(QEMU_PSCI_0_2_RET_TOS_MIGRATION_NOT_REQUIRED, PSCI_0_2_TOS_MP);
 /* We don't bother to check every possible version value */
-- 
2.50.1 (Apple Git-155)


