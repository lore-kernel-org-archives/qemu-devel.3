Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2BDC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 15:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udsS6-0000SY-UQ; Mon, 21 Jul 2025 11:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1udsS1-0000KV-Bb
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 11:29:14 -0400
Received: from p-east3-cluster7-host5-snip4-2.eps.apple.com ([57.103.84.173]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1udsRz-0008Db-H0
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 11:29:13 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPS id
 83FA618000A2; Mon, 21 Jul 2025 15:29:08 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=zuqF8TehqinG6O+4wRmDxo4/6hiz3J1Qgh7XOTESXgw=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=bwGm+JAE2e8UgXxkBRqZKncdBujsRkeybHB+Qv5oLLopa/xwVa0/yPOaH03DpyFboIM8too1QtnsUJUTmxTx57bt2DKNewUrhbRMhoIb2XeJ2RRr814P4mGAMWUmxqWBsDs/gDKHFoYInZsMmWq8efqR0vDMiuGpOjWjyKESlfzG5Re5ekryQoZtTjyQiC/vTKqEWfX5a6UksxZIb7r1GZabn69m3hIKvcBeYrSywyVHEjbLDJ2pKAZLE+Doah8S4yCO4GWuyPNYj1tMatUPOKW6LV4UOpqgikCyzaTd00Ds9pXiKPQMd1/4HiLnh5+M2irk/o96yYH9jmsn5fGAEQ==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPSA id
 C772818002BA; Mon, 21 Jul 2025 15:29:06 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH 2/2] target/arm: hvf: stubbing reads to LORC_EL1
Date: Mon, 21 Jul 2025 17:29:02 +0200
Message-Id: <20250721152902.38671-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250721152902.38671-1-mohamed@unpredictable.fr>
References: <20250721152902.38671-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mXGf_pPXWhYANCrCxL5B-Ak8B2KBLgaS
X-Proofpoint-ORIG-GUID: mXGf_pPXWhYANCrCxL5B-Ak8B2KBLgaS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEzOCBTYWx0ZWRfXwa1ct7BLEZsI
 3IxLFchcTeSUbLi+DOmnYJMh1C+wfv8RK8CmPAUfbbb7RRcVFwGPY+SY1HZzVNQwc23N6nvQM2B
 u5bcyVQ7/sEj2hZRPI7tEagH+0U40FYfHnDM1if6nbRy3CS413nJe4lFKGEj6EGPqqf2TBhzWhM
 uXzxkrDLU/o8bKbVNJW/ACPoQGpir+1/GkgkRBK0l27+Ylf2Lf/BbfMgR8WQf/xE8YqAd3+0a13
 CC2Ut1p9qtynYNpfxK48gf5lHrmOs7IG5z2/t8N39DrgyISWXPR6SuDoHK3MiqeGwBpdNTfaM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 clxscore=1030 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=710 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2507210138
Received-SPF: pass client-ip=57.103.84.173;
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

Linux zeroes LORC_EL1 on boot at EL2, without further interaction with FEAT_LOR afterwards.

Stub out LORC_EL1 accesses as FEAT_LOR is a mandatory extension on Armv8.1+.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 4331a3386a..2730c9793d 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -186,6 +186,7 @@ void hvf_arm_init_debug(void)
 #define SYSREG_OSLAR_EL1      SYSREG(2, 0, 1, 0, 4)
 #define SYSREG_OSLSR_EL1      SYSREG(2, 0, 1, 1, 4)
 #define SYSREG_OSDLR_EL1      SYSREG(2, 0, 1, 3, 4)
+#define SYSREG_LORC_EL1       SYSREG(3, 0, 10, 4, 3)
 #define SYSREG_CNTPCT_EL0     SYSREG(3, 3, 14, 0, 1)
 #define SYSREG_CNTP_CTL_EL0   SYSREG(3, 3, 14, 2, 1)
 #define SYSREG_PMCR_EL0       SYSREG(3, 3, 9, 12, 0)
@@ -1657,6 +1658,9 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_OSDLR_EL1:
         /* Dummy register */
         return 0;
+    case SYSREG_LORC_EL1:
+        /* Dummy register */
+        return 0;
     case SYSREG_ICC_AP0R0_EL1:
     case SYSREG_ICC_AP0R1_EL1:
     case SYSREG_ICC_AP0R2_EL1:
-- 
2.39.5 (Apple Git-154)


