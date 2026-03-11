Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E2B1049515
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 10:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0GmF-0002Q0-Fm; Wed, 11 Mar 2026 06:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0Gm5-0002IL-CZ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 06:26:45 -0400
Received: from ci-2004c-snip4-11.eps.apple.com ([57.103.89.33]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0Gm2-0001md-6b
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 06:26:45 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-0 (Postfix) with ESMTPS id
 0B3401800108; Wed, 11 Mar 2026 10:26:32 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773224794; x=1775816794;
 bh=WYWW55OHPn7bG5onS6coAsknXdJYCR6ZZ92rG3QEQEo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=NPVsTvJcXJBhgoh0pPLxmS489WzF7LQtj1MhWCQzNfxXxuBqev1q4Vt2nXL3M/ywD8SaovvlNIYmap4Kgz7sJXLBNlw6z7kWhQGdTyes7/am2EHt39cuRbcRdgtnF87v4tj7iHQSurkY3qAtvoSSkBVDb4EW1wzJ810F3Y4YPVUUJxs55dUBe/4WV6CdVKMdm9sWaw80jishMLMgBsfSU5UclewxMqTNAdg9tQG3GPuaxw4smE1baBEsYP5uq5dp4IvgQ9YK46XJpmfWiji4PWsv+Pyp9QwzYEWj3Wjjr5S66tZGOYCAbAOWF8xZf71LNXFFXro7VnMepfdnD+ufaw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-0 (Postfix) with ESMTPSA id
 A177E18000A4; Wed, 11 Mar 2026 10:26:31 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH 3/3] docs: mention that WHPX supports Arm too
Date: Wed, 11 Mar 2026 11:26:26 +0100
Message-ID: <20260311102626.46546-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260311102626.46546-1-mohamed@unpredictable.fr>
References: <20260311102626.46546-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Qv57gAJ4PKSPQ4Wg03j-ySGWqHZ3c2th
X-Authority-Info-Out: v=2.4 cv=ULTQ3Sfy c=1 sm=1 tr=0 ts=69b14359
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=dI0m1LqQuSCw5fg3QP0A:9
X-Proofpoint-GUID: Qv57gAJ4PKSPQ4Wg03j-ySGWqHZ3c2th
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA4NyBTYWx0ZWRfX7yk4X3JVyJlm
 QejIsOzsFLSNq9l+ctJ+j226hDp3PH2Mq1fT7Aka5/Nf3W1OJFbDKGtON2zteTPl9C2J8h+pP5G
 OrQbSHiK3dMdDWZW3raYAWDmUTdKtLNUp8uOxZDSt4U8rMZBcy3mbarshNC//n5IRBp0ladPrSA
 oYUzjc8uMLAhilY8BXcNqZ3uiKEGu26XXdYiEF4MEGVl5AlL2xk002LGwZKiaIG+4JuiFKCstXO
 rOIyaP0opjtV3CraWFpQDtzkeeQiFPud7zwGwaDDVfgBV2N79NU3+uFBlUevEqJU3cvpbs7nbtn
 P74iKxu1DqlRF6SE3jajL3jKtZgHcC5GAJJlfsyGfx0DG7ImJJ8p4MCJjF6HNU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=718
 suspectscore=0 clxscore=1030 malwarescore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603110087
X-JNJ: AAAAAAAB5u3/ZbeZykaecSXWGV+i0tb4ATRv/cvwR7qPPNkksBGk27XmYSkroAetB5PoJtfirfmtDx7xa35Ou6uI0kunPQB9hm7/d1GMbP2cR/zUzwuLoCLUkjk1XcP9WOoT8uiZQdTzi7rtfAwCmXiiSk7ETdTSh9Ms+WbXjM6cZdeWwUTslxqRSP5dxONfVUkRlOJSR90pQUjYgpZ3sMKCiBtw7WRonQvRk7+l8J7ntU81buG/48jMztU5RS4GzTxyqzYccjRZdBlrSHXuZ/v/PguFgrC5E5HAh0eAbRixD0u9FZeaRUzEH7nslE2BxKechoqmx42gTHQOvhDxAB/DMVi4Hkw8DGGMszqHFCuM9drfAzxVDqaFvhDPCc2JXy520SojOIYLBOaX6xUcbIhqXpuAm/RoNcuCx1UMPIV3pXlacyq6fBLveBS2guriFUkK/8aclFAZTR39pjN3UynGH8lBKSY0SAasWTXIpXzM1dnmvlcutFT9KN6Su8hL8T3wrBCpaTotgpHDn5tDm+BjnIoMuSWbGcjw90Syi9S5YECVM2/U/62GrFFhyOg/fXOWBBHR3t32JoXLWZg8lCxLx87993LdAcoylktDCWPjiEZGGktP+1HKaa/taRZMZA0=
Received-SPF: pass client-ip=57.103.89.33;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
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
 docs/about/build-platforms.rst | 2 +-
 docs/system/introduction.rst   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index ae138ff0e0..6e3088d524 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -43,7 +43,7 @@ Those hosts are officially supported, with various accelerators:
    * - CPU Architecture
      - Accelerators
    * - Arm
-     - hvf, kvm, tcg, xen
+     - hvf, kvm, tcg, whpx, xen
    * - PPC
      - kvm, tcg
    * - RISC-V
diff --git a/docs/system/introduction.rst b/docs/system/introduction.rst
index 2dfa371e0f..be387a6645 100644
--- a/docs/system/introduction.rst
+++ b/docs/system/introduction.rst
@@ -31,7 +31,7 @@ Tiny Code Generator (TCG) capable of emulating many CPUs.
     - x86, Arm
   * - Windows Hypervisor Platform (whpx)
     - Windows
-    - x86
+    - Arm, x86
   * - NetBSD Virtual Machine Monitor (nvmm)
     - NetBSD
     - x86
-- 
2.50.1 (Apple Git-155)


