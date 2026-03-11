Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB70C112584D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LEd-0008O0-Hy; Wed, 11 Mar 2026 11:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0LCv-0003WN-7w
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:10:50 -0400
Received: from p-west2-cluster3-host5-snip4-5.eps.apple.com ([57.103.69.88]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0LCt-00069K-09
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:10:44 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPS id
 2DE6418015DF; Wed, 11 Mar 2026 15:10:40 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773241841; x=1775833841;
 bh=iXss03+VuqA+zHOCrO0Fq55LkDRXA/o7G86b0iO7V1E=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=F6/jBlMk9vEiFVBhrDyMS7v/FgmGq0/Ng1Pt338bAtc/99iWBxEY5QPcoA/Ev9pG5sx7viphufDFPGrcPqcv248sMm0rcNxQCe/3lDEcAshwn7jESv3CYqN0f1OAUHoFIHeJN6oximBw2krfMCNHnqeOaSeAia4q7bj/8x29cwUqFMZ35T30iOcvnKOVOb+R/OHYyUkbius7NAFVfojG2xJ5EVry6YeuBpW7Sua9qBy/hqKvFWXJPGryJz/oOX+iWlT/sv1GIb+kOkpWRhGkrDrJTaHt82uOq+OLuB4YmTQAMq/EFnIkhtW0EHRcXvV3bIFvV2doGIabkSufsvGURQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPSA id
 0ACC71801B43; Wed, 11 Mar 2026 15:10:24 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org
Subject: [PATCH v2 5/5] target/arm: cpu: alter error message for host CPU type
Date: Wed, 11 Mar 2026 16:10:14 +0100
Message-ID: <20260311151014.55915-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260311151014.55915-1-mohamed@unpredictable.fr>
References: <20260311151014.55915-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: zSWG_bXSjnvPTHJFpCTZqhupewZdnuTQ
X-Authority-Info-Out: v=2.4 cv=OZWVzxTY c=1 sm=1 tr=0 ts=69b185f0
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=mrKu0lyS_soK1dkMJ0QA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEyOCBTYWx0ZWRfX00RyaJ7bcAKA
 kzvP+W6F5QPIZwtidFfU/3Mxkysz17yztMIXNb4lt/nXTK7EU9vMQzPo9HrjE75cJ5Gzj6Pfph9
 9RSiaWiRVUqoeHFPH4FLBCFNfwEP3BKZonK0ABjehVR4CU46mHtyGRuzkTKMnSSLZEPko/OeuVh
 c+iL/F0l8/awULwNkwAUKEQ9D/4nIkQsBFvIgMe4gmZjgU/wmSIUj8p5YnKwOTfMM4UskoSxOdV
 4qtrFKxN/R5aiexIjVL6Tsvs0HK+gljMEDZiVGIjnK2NOzJIt9tQzd/Mtoy+dF5PnjOkougPAS6
 3BjfTck4YI9xaK7j0XFPPgf+p5k6TSoRts2TIAL442Oi7KFTkF1PCdU6z2mCo8=
X-Proofpoint-ORIG-GUID: zSWG_bXSjnvPTHJFpCTZqhupewZdnuTQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=704 mlxscore=0 clxscore=1030 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603110128
X-JNJ: AAAAAAABZmzG8oSh/XQfgtxTxAYuIGWpcodrK9zC8EAWuVgQ1Jmldy4JPRETxRXmU/NqklLFOrqH8nbgoCtVRIzmfLSTN1w6etFZ/rJAQ0ttz5jkZnfDGvc0xzJaJ+E1Yoah9TIG9sTS7IQoQyNecpQrmidj0AN2HOUTCIOELColBOd0jeuDCvAW2V181cUzO/4TLAUwhfCHhNV4F/WEvXC3H1zd5gIwy93NxP+3lxvkSjLuKzO79ko8i+Sgfi2QPxpFPuWZxL+qC+1dyAICAML2KmakT5Bj1mKWLMsa6YBwRGgDcLH2h6Jgbj2Qhj7g83PftPEPaPYxQS7aNrRQQ+i4GMhqwjicl/4At2n9zJCVcVl70MWZ9xIKeMBr/i26uUNpmPerySB8VwqnxeCQchhQ4RGA8GCPmuLEL4dvXq6+YrhVTdEa1Bqwmwe5tDN3K3+XeKsZSIfNZLmUlg+R/AjRbx+9HYJcuvJ2ty5sZDXUrBrz/luvYJboWYTgmvPzWLNBkdRVlGm1yrh2wt23pNgU4rWtS/yRcQZM3j3IDiwtZQ/lMYU9iQldyOJ1qpg0s1BIaNwN8mH3gqzHDG6DolnImWGdJNDXavciJPzT2fsLrA6VCwHn/h4UOXHk+ZoBtCAt7CtG/4qkmyVN7+oYkXGHUYnSMOsQsaVQ7tdGgIM=
Received-SPF: pass client-ip=57.103.69.88;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7e3e84b4bb..e73d7eb4fc 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1629,8 +1629,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
      * this is the first point where we can report it.
      */
     if (cpu->host_cpu_probe_failed) {
-        if (!kvm_enabled() && !hvf_enabled()) {
-            error_setg(errp, "The 'host' CPU type can only be used with KVM or HVF");
+        if (!kvm_enabled() && !hvf_enabled() && !whpx_enabled()) {
+            error_setg(errp, "The 'host' CPU type can only be used with KVM, HVF or WHPX");
         } else {
             error_setg(errp, "Failed to retrieve host CPU features");
         }
-- 
2.50.1 (Apple Git-155)


