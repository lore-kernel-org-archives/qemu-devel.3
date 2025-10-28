Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5F0CCF9EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDtQd-0001gb-Vw; Tue, 28 Oct 2025 19:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtQc-0001f9-5e
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:48:38 -0400
Received: from p-east1-cluster6-host6-snip4-7.eps.apple.com ([57.103.90.188]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtQQ-0004jj-R3
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:48:37 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPS id
 65B0E180311D; Tue, 28 Oct 2025 23:48:14 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=+fMggmtg/uZNHz3nywgemPAlDNuqwqAYkYrWDswgN9E=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=JcP5Iqvbd3vqNqoWEC55SlvwbMSe7nmp5DXSJt2V09xcZoYHU5Eo9I3qnehZv4vMTYx5SYQOI4TNYUcfT9+xRDJpUoAGmN6yNeBepY3YzN1m7CIbhEbmuZ8+piCVMwsy1FDGdXhODvd604W7wARBX7pIsccuA0mWuHdmuncm2nUfOnX9PGMnKySlnIocyEc+q30lUUt/r79WFesG3/2+fVgldMhv+Ig1LCrl9kTrJnxuyGgQzVUc/xGYw8Y3Shs5+CqbHRVi3AaC4J1UNnWWHth+QSIedUpI2d4+wCZN9+zBseO8Y2Jsth+6+ZyBejzSiM7W42lcClaBS+f6AzPYkA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPSA id
 E38D2180238B; Tue, 28 Oct 2025 23:48:11 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Sebastian Ott <sebott@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v9 01/27] target/arm/kvm: add constants for new PSCI versions
Date: Wed, 29 Oct 2025 00:47:31 +0100
Message-ID: <20251028234757.39609-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251028234757.39609-1-mohamed@unpredictable.fr>
References: <20251028234757.39609-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDIwMiBTYWx0ZWRfXyuA12r72p99Q
 XoC+6A+IkBLONLF4EW7pnG84tXVXeVuBLxjKFLL3oa3K1On6kO5/4NJqERqHToahzB6slat/MRE
 YKyRSrxyPdgvl8dH1SK/uWfraFgNnQHS+0bks8xfb602djvHeSAEXI4dMxEa7T7jEBnpKaYK2TE
 gfeCob5NTYvuJZmTEuoo6W1HKF70+EM8hLVxAFfTJ4f4AzRm6PJDNhYHmvahj5gJE7PVjMA7x9p
 8wS42GgDCdY4NfEFxdTgUv5B1oVvjNHLjGet50imqo7r7mOyI5KszfL78IwkMbwKppk7QD7vI=
X-Proofpoint-GUID: SbfRseXO7cKOW8ZjSb12OZClxSvFXQLB
X-Proofpoint-ORIG-GUID: SbfRseXO7cKOW8ZjSb12OZClxSvFXQLB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1030 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=920 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510280202
X-JNJ: AAAAAAABMx8uZuPhdFVKpDBdzZXbrreaj8psMbczxky7gTx1lAvbGAhxNNRaPttglYCWw+rCPres4eQun22oygnhx+Iv/Ue6PlO3Z5PghBgKiV6THqOv6HLcLoACiGZxH9s+PFeFQxxctERLmZBgt0YKpvxQbuSFa4BwxqJszwd7qp+9JH43tqEnP9izoMhfCAVZCuYOfifalquwPkaEhix1NQ/4zGwXaypJQZ9A+G5AJ12XWjzpojrqs4VUlWazvN7zkT2iz0x3kg78wfH5Jpz3nOvtuCys0LH0LTmL6lx85GHhh2NpgemQCEg1zJggSdr8+l9uNMoB5tbn5tFetiNpXgUdGcjOMIWfyknh6owwFof2Y7kFr7Kf373ilqOfyLuq43ABVprb5km7SCZwvEWkE4sE/k3So0RjKZcgIu+hTGbNj/zS0XiOql/pAQN7PqmUnpXoOlLq0eyFP7De0Nfwma+wbSGf7EBex3Eop0jCQ1SvMhnG4w6EEHEWkdFbNwmdg8WFbdZCHa50tvQwez72iwu1rrIcd9dsNHBJ/F38WLDY+5E61lTRG7BFi7RFvgSeaMIJugZOjvyisTEWLTldurw4vh/9EVb21Z4Mxdrr2YtFbj4oQUJZCyQpJ6TavCTDvgF/IM15+IqAPMBVpxAs7A+VQoKjgu0oYRwPq3wc7xO//v4auDiDDoIgj+5DZbla0X7tcLKHqmAScN+q5gazrd+9Uaww7dz0E/rdnuHekJ8QzK7OLoHzTMPDpFBr3jkF7kfwIDAxQVASnZuPtOIItigiux/tBxY=
Received-SPF: pass client-ip=57.103.90.188;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


