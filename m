Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C668F5512F
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 06:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz7RT-0004NH-4v; Sun, 08 Mar 2026 01:16:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vz7RN-0004N0-JE
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 01:16:37 -0500
Received: from ci-2004i-snip4-3.eps.apple.com ([57.103.89.86]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vz7RL-00027I-Pu
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 01:16:37 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-13 (Postfix) with ESMTPS id
 6CC2818000B1; Sun,  8 Mar 2026 06:16:30 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772950591; x=1775542591;
 bh=SznU3WSAGXxT3MxSsF8nbvqng3uTYUTOYXmx9KuUh0s=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Uu8Yc1RM1el1p6ZWwv/xNrt8+hsJs3cqopz4E3dug3KMWLi6AMC3rYS8dSzpwx5QJNbmJT/PZdrlYC5Zv4wM12dD1BGJnMkGlF0ZNKJNzW5Ifwxz5ncYLuzj/rQCjSALZGmE8ehH10s28jW71KoEYkDT/b5xStzvbPdzIgrDxcg6nrA25nH3Ve3NjDZUp8DBEy74chWERZ/URE9P8IHwiCSN4e9PIwWO1l+XY0ZoLkepc2D2eT12X3xz5pRHN+r1BIuhh5/ihQb3Jp9bLvtVTAGF9ffXYf6jzxkJXJ2PclDDJUJRfw2Uazq67q/LkVT4PpYMw0Q3PjYPzz5oCzCYIA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-13 (Postfix) with ESMTPSA id
 0575518000AC; Sun,  8 Mar 2026 06:16:28 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH] hvf: arm: fix Windows boot with kernel-irqchip=on
Date: Sun,  8 Mar 2026 07:16:26 +0100
Message-ID: <20260308061626.20632-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UYn4AKVIfzamJa77KeDu7Buif6xsmms_
X-Proofpoint-ORIG-GUID: UYn4AKVIfzamJa77KeDu7Buif6xsmms_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA4MDA1NSBTYWx0ZWRfXynSsGZTz7JyE
 CYvJIid0fcKq729XQSrpgWiPOQxKhl4SswwAtAHN0F5cLhrkZGC131pi7pdvD7fCJQ0fwa26Qbv
 /buvb8k8YJZioaJCLGHY6KpeZ4U89mhuZOqxbd2NziHCRcAP5m7E8lUSNIOfcBXUqKMshVjrCdm
 d7I3SLAS/ZjVScBBew6WzzGmpDN4WkeCcGo7LpCrmDuYzwlTBa6JqTNDD4NCqS4Yiy9q31KL5e+
 yy+kdnGvgtxal8vaN30Gwv3ZyyWwGDrs+v/3aNqQwzxRq9FOi4eNvudwRnqjbjxA8foJqtSU6gs
 Yd51yeVvyc3u9HTQt0wSgwVyHqAGdxxlC+Of+EnDiq1cmeUkq05qqzNSN/JB7A=
X-Authority-Info-Out: v=2.4 cv=MZhhep/f c=1 sm=1 tr=0 ts=69ad143e
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=X-1JIfO4U8F6gRPhYcAA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-08_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1030 spamscore=0 mlxlogscore=788 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603080055
X-JNJ: AAAAAAABL0EnBQ6p/Fp4HMRpTaRZUm0yk2Lhb8i662UOwvm3eAz08gZT/M/vJPF8BrlxM44jbiqY5Gl3QJjDkuJaCAlIh84KUkO/a3+szxMEOS/lD+CJTeznYl/C12XmKADnHKtbc6SmuGLKBkDcn+YhyZZ1FLGkMqATcB2VNarcOk1JyzoLyFUyS14wHXHFTflwWEMy3BcTVcAVXfriQhShthjzltAMvkp+JnI2yRY+5n+OuSvS8VRcApB70/sW40nZl6NQMg364/ch0vC4EsjYuIb6BsB1m7VdDuklAtO2rxtCwYHmtb+q4EXJYB0DaRZeNRrPBYP0gNX8r91ObPhBHShOKUhbFsLrDekGuJ+eqJ+UYsi5ZY891NUZLkvypu0NJ0g9EHomxZc61QAUP+bDrT0DBHGMCRmNWPwqyt8k2f98Ie4Fw3epjiff6bPhasTY9JbK8391r0UeJMFgUhCgW02G+lg32hO3lph/rfSyy8eI7mtPcCAhuBAeiT5ygFWjT8fuO+ofnXPWVF6w38iILDg80nqgp/kgE9+5g0j09aCS1uHeCj4MmVXxCoB+U6mi3EdtkgRO0WraTZX9Lw7Fwtjb/Kd5Qbp+RofcZJr0cU+iootztM4gDS2z8eOb7kaAIN9GSxaKDsZTBeBxutxcD+quVzqR
Received-SPF: pass client-ip=57.103.89.86;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Windows really wants at least a single counter PMU so give it even when
using the kernel-irqchip with nested virt off.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 8aa59a1f77..883a341064 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1187,8 +1187,12 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
     clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar);
 
-    if (hvf_nested_virt_enabled()) {
+    /* Windows really wants at least a single counter PMU... */
+    if (hvf_irqchip_in_kernel()) {
         FIELD_DP64_IDREG(&host_isar, ID_AA64DFR0, PMUVER, 0x1);
+    }
+
+    if (hvf_nested_virt_enabled()) {
         /* SME is not implemented with nested virt on the Apple side */
         FIELD_DP64_IDREG(&host_isar, ID_AA64PFR1, SME, 0);
     }
-- 
2.50.1 (Apple Git-155)


