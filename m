Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F2ACCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 17:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEA5F-0003Q1-GR; Wed, 29 Oct 2025 13:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5A-0003O4-SV
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:35:37 -0400
Received: from p-east2-cluster4-host7-snip4-7.eps.apple.com ([57.103.78.238]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA4v-0003F6-C4
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:35:35 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 833D91821F5A; Wed, 29 Oct 2025 17:35:16 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=+fMggmtg/uZNHz3nywgemPAlDNuqwqAYkYrWDswgN9E=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=gkIKHAcvQtvbT3+E7lQJOuWdIX0vY5froNjzCzSbJiQy5I8xsN9DMHC50HgAU8lmsIQH037sFumALdFfY2RHdqZEhwSm+bjlWohrSU8OMTmNtgnziKNqBRbk1CAZq9kL+AcwRKKJie1ppGYXjRpQxO+lu+squKBo/lDxW7g9MHEDZmv964JIUZVe20M4ny9Xl1VIP+PnKYIxS5OOanbbfI87IzFnJvS3pHJlkAjU4lGToKpRbxKSh2AfBLOOWQEZlRIaZZCVHfdeUXbpX4O+sj3xSFon+XMy0OgRQvf4Ly5jvtnQQOw8qoERDbH2IwDBOcTVzz52YaSo25+ZZgMlsQ==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 F30741846C36; Wed, 29 Oct 2025 16:55:17 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sebastian Ott <sebott@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v10 01/28] target/arm/kvm: add constants for new PSCI versions
Date: Wed, 29 Oct 2025 17:54:43 +0100
Message-ID: <20251029165510.45824-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251029165510.45824-1-mohamed@unpredictable.fr>
References: <20251029165510.45824-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDE0MCBTYWx0ZWRfX08lYxwcpRPJF
 oYbuIQ+A1NfcjdRftrfqnnlroEJhdTr59vbcNNTuhgFmIlZ4OeKfp/Q/5yl0KbH12D9m1P4EENV
 0ZnVe5AT4V5cnEmr5GbhvGGFsRtClk6+KlREhCUDTFSYO5hJv9KEnRa1Vw4Xrg088T93Gojh54h
 2ZEsPv6noQHaqIVZCx560D+t7gMg9FWaU+GJw/Cblp7rk867YE2Kotldbzp4S3prDQ2zS5X8eEy
 1f3gxGUscL5RhMpZN00tshfCb9BMQ9VmXFrJgxU6Vl4yKJKbFd1wSXVZ9T8/NcWdRUwD6d600=
X-Proofpoint-GUID: XLLgT9CHI5YMLuY1mGSaYyLCP6T7ebh5
X-Proofpoint-ORIG-GUID: XLLgT9CHI5YMLuY1mGSaYyLCP6T7ebh5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxlogscore=787 adultscore=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510290140
X-JNJ: AAAAAAABWyX62p9XQNvmqfbj25ymUukuLqE1vE2C/X2TQTw3dUS1u76qkirvGW4FOtpmANglZSGTzxUZ1a9DhLpgtmkFm06ssfqDbDpjvQd9bPlTc0PwwDy4vsZKr9orknoaAoFGEwRIUjaeY7NNHoG+rXwji0tugwqvJL7YqXPNNLr6oovRYg+o9JEJ4q/imZMM7QWtNz/jkijNZjMHCu39MJ+XcOVOO/nY6N12NTQGPFsFaZKPQt5y+uemHFAzACndWBLCang0kzpjbJESUA0Nn/XXWqOsZKG2YdWNdrDig6k5GpDF9WsvCDb5I1sdv2Gn9z3o6ZiL3lX6a9stf2brPAHXD+LouJYN2EMBcCPogvlqbppbOWg9SuZRM4jENKMS8ULJmuUj+BiDSxEKmrREJVxKL+9peDrtDSRLS5AO4QaKIpYsc/BqsnHW09K19rDurWjIRFx6C38Zu5fEiGaRMOQr+2No5VLTYdS3dsI/En/7/bo2P1bMcyDWE3KPDbYVnyrg0NSgX7oS3Qi7hzkvSW1926XuPfef5c20do8x8WBLP5O5XOh/azsBj6jjdSpGw8pdoIri8s57zgHU6q7xZqoDpLF5e0uQ29/aSD65ppwsF1zdT7PALoYEtSfFjIeMlddZ/4qqtuKIQPoQiqwUfq6JQXYAF91XzoQ5PEGUy2Cqi42TA09zQIWOtXEp+gPjyDsrtL1uoor5TmtZZan/7pAVOvEtbA0ebNGafY690Fk0It55X7f60jvDxLZBOpPJvPhWbJrhn8xe31NV+sLUnTg6vsciIDCZ+7LRFpg=
Received-SPF: pass client-ip=57.103.78.238;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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


