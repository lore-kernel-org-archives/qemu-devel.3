Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118DAC83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 15:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udsS6-0000Rl-HI; Mon, 21 Jul 2025 11:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1udsS1-0000Jq-5D
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 11:29:14 -0400
Received: from p-east3-cluster7-host2-snip4-9.eps.apple.com ([57.103.84.150]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1udsRy-0008DR-D2
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 11:29:12 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPS id
 8B6B91800615; Mon, 21 Jul 2025 15:29:07 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=jUuG2nWJYMdDKWpXlx5PRoGJVPTWdBjLgl1UQZhKdl0=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=elo4QUoUzwHTIK3J9o6jjQHaXjZtO6Vp1fadREoWwCNdL/UPDbOwXn1+ExZJG4KYP5I6Z4KDRJKly2kaEwlNcAU4jWGMO+XPnmySLb9z2TzOx8/P8m/VFh33NUDVJ21Xf/Fty3a+vXp5iEzrTtCX+p3Y3BgN3XRU2gGvc7IQ5ODPKJAYcBvqbJwKROAfQPboDzcrHAMMWxM1ddoPyQZVs9IivMY7JQuiZOX3kFzFfRPQ6SYaPCCJKnSQxgKd6ugzgc6Jviex6C4P6D/iGG9n7aaX3PNbdYtySFsKn0vS+dw3n41RJlb1J6wjQ3Sd5Rr8lwmx5fc9E0W72dAHZEq1MA==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPSA id
 C238218000B7; Mon, 21 Jul 2025 15:29:05 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH 1/2] target/arm: hvf: add timer frequency note
Date: Mon, 21 Jul 2025 17:29:01 +0200
Message-Id: <20250721152902.38671-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250721152902.38671-1-mohamed@unpredictable.fr>
References: <20250721152902.38671-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _xWChcKvkEqUFlZpnK8SVXzVKUW_EsGE
X-Proofpoint-GUID: _xWChcKvkEqUFlZpnK8SVXzVKUW_EsGE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEzOCBTYWx0ZWRfX2bKfgI5R8NHw
 4pbLhq9FrKC1jegtJ/OuyUKw7+fFIERFNdmyoAtsMUFzHA5gLZEd+2/ZIqTAzjEVx8wmRfc1VeU
 E1UiptYExtcYg6l2rPRkvG7nwhBkEkzh6zSZEBA3GyZ4Fflkjzx1gzKCk4oG0pOkIcyi+8NJ+mU
 vUi0MfI13H2W22uWgLXdE1HTMNI6Bm5TEflFKMI9TWk+/Wr0pmwZYI7pdKnFEkKmdOOzNtLSYk4
 68E0TzW+A03j4rPMYCjf78VyiyP4gQ+6awCetFLezqw9uU68EAzJL/+YKGgWvs+S3iTC+9Lko=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 clxscore=1030 suspectscore=0 mlxscore=0
 mlxlogscore=816
 spamscore=0 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507210138
Received-SPF: pass client-ip=57.103.84.150;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Apple M3 and later, the timer frequency within apps and VM guests are different from each other.

Note that app binaries compiled with older SDKs continue to retain a non-1 GHz timer frequency on Apple M3/M4.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index c9cfcdc08b..4331a3386a 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1018,6 +1018,13 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     int i;
 
     env->aarch64 = true;
+    /*
+     * TODO: This does not correspond to the exposed generic
+     * timer frequency to the guest on Apple M3/M4.
+     * This is due to a scaled 1GHz counter being exposed
+     * to applications built with newer SDKs when running
+     * on that silicon, while VMs get an unscaled counter.
+     */
     asm volatile("mrs %0, cntfrq_el0" : "=r"(arm_cpu->gt_cntfrq_hz));
 
     /* Allocate enough space for our sysreg sync */
-- 
2.39.5 (Apple Git-154)


