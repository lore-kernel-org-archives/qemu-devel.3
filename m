Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDE5CCF9EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDtRS-000277-WA; Tue, 28 Oct 2025 19:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtRA-00020X-5I
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:49:13 -0400
Received: from p-east1-cluster5-host4-snip4-5.eps.apple.com ([57.103.89.166]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtQi-0004mJ-Di
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:49:11 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPS id
 7D27C18034CD; Tue, 28 Oct 2025 23:48:38 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=4aQelUdZ9m4SoQ1tmmqgdVsoa/ORFIMr7NbmJ7jciug=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=BGCmC6ZfuCUXRtd0JFYWzA0rhTb5b31BWx9NwNxc0ci8HOOIRzjygnzUpUKY4sxrb2oX8y84siiT3PANnuN3eVPOSQnjcevp8EMku2+Kc8OwW63ln+EFdP8vWe0VlbFFIAs3jwd0XxR4TrFNUuNMmh3OxHb572a6ZEE0QIJPU9gdOQ2EpT4RlZc44wO47aEvsdkWHLarU13lE0PPZFUry7Qjmi0OqqD+1inWD5MZExiAcISye4UGDDhQaqP8P2ivzAtszkSz/47uZbN0RRktsF03lcu1siINZvt5GTi1DDDJTGsAsr/+tYDPJ32MJwKUz/Ug+q2bizhll7Rh1/ctlg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPSA id
 1ED791803128; Tue, 28 Oct 2025 23:48:36 +0000 (UTC)
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
Subject: [PATCH v9 14/27] target/arm: cpu: mark WHPX as supporting PSCI 1.3
Date: Wed, 29 Oct 2025 00:47:44 +0100
Message-ID: <20251028234757.39609-15-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251028234757.39609-1-mohamed@unpredictable.fr>
References: <20251028234757.39609-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDIwMiBTYWx0ZWRfXyDZ5go2WVk78
 IkTljeuV1RBUpFzFpKkopK2T9WLro6C1lf1khYrIctcFzTpS335YmfJi2MnkziiT+cgnmh2er1m
 IyIvXWAOrpuf7uWLUPvaSc/Xl8SJNqf2GmXZnGTel06jdt5gyHithIW9hj7XWDH2+couiTyWyfn
 FRvSsYhBSb7Xd95Fc6woutY7xuCJhPpY58fpajKuh6RroPEoorxKwQdauZg2VUPPGlljMeDx/rO
 9MaGzgaplsOSf1ms4g+t8lokgHZMvn2Jk+oFLczVQBbdUOp+sXDIZMwiaXlGGtZUfqbU2VzEU=
X-Proofpoint-GUID: dHNrwL2uq8V8QPCTYMqW-y-JCcWQ0hap
X-Proofpoint-ORIG-GUID: dHNrwL2uq8V8QPCTYMqW-y-JCcWQ0hap
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 mlxlogscore=824 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510280202
X-JNJ: AAAAAAAB32bekbIqEoUzLINE4fjTa5dw5KsPi0z92OF9vLW5kbmJWXTWF6jyfUBwG3MJwQJaRN56/hCQwfOT4KKMmj4hlF4dubeABHLs0ZncKs1WBN1H5hUcHRJUF0+BeCYpiWnRhyhQNAKZ51Qa61rY367MSHm5HSLgIhxxCrtYq7ZS7NBsXBEq+jwQ3h8/n5MrPEGJKnPZC5cG5LUu5KVcX9p1L9wG7m5dXBFaotqnYdvgdDVw7JKM0GUXvhHiLe0EWdC1+oRlx2jLxTNcGFVZODvyT1c9m24kFuSFR5Jxl7ozFaAYH19a/9GWdr3QcycLeW9vqZdyGmOF/JEXS8Y2Ro6xoCLyQKiwLoFOpQ2Hbft7n/n0naH3N9vaHWSV8gyusJuQs7ImGgZW/2lUCUQ0rFrdNewkP5jVOi8HAMlNcqq5JryRBWZ4KAAuFIQ6zEkvb1xjkkUgIIMDBu7swxILs/wtvpKpkRk34bkVfkCIrATMRtIqO3juTmFV0xATdQfyj0wTeEx4rtBKWDvu8MapMulzm2WrzHOw9bFGsf7fz8DIcxQHjnl4nL60CqwyoJz0jlcsIBS84zgBIZbhvZMN+1SZkq5LrKNKeYYf0eugWdetlIlep7ZqoieuGgc5hdeL/Qiqh5ILumXj0wWfwx/kuP0OH/Sdun4wpYvrzUv2QRjkJWaORg+0ACLzznzcXWapiQ0mkjxxu0JBKWMARLJHFDcjhLPrAXlVd6oQwXbcyiu75fIN7HtvQpnn8U6bnlxSuFN0Vae4ZC4xFaElDoNIhjLiRdLW2rf7tYbOfQ==
Received-SPF: pass client-ip=57.103.89.166;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hyper-V supports PSCI 1.3, and that implementation is exposed through
WHPX.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d2fc17eab6..854b46f40a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -23,6 +23,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "exec/page-vary.h"
+#include "system/whpx.h"
 #include "target/arm/idau.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
@@ -1143,6 +1144,8 @@ static void arm_cpu_initfn(Object *obj)
     if (tcg_enabled() || hvf_enabled()) {
         /* TCG and HVF implement PSCI 1.1 */
         cpu->psci_version = QEMU_PSCI_VERSION_1_1;
+    } else if (whpx_enabled()) {
+        cpu->psci_version = QEMU_PSCI_VERSION_1_3;
     }
 }
 
-- 
2.50.1 (Apple Git-155)


