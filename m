Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A7910854AA
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 22:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1XGr-0003zU-D8; Sat, 14 Mar 2026 18:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w1XGq-0003yt-8l
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 18:15:44 -0400
Received: from p-west1-cluster3-host10-snip4-10.eps.apple.com ([57.103.66.103]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w1XGo-0001W3-Ob
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 18:15:43 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-15 (Postfix) with ESMTPS id
 801B71800267; Sat, 14 Mar 2026 22:15:39 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773526541; x=1776118541;
 bh=ocVBiiCbfqFuJ/DgB2v8laNKE69rBUiexmnNbVFv6+4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=OT2/g3T1NR5ddM7eQKklt5fCnuFOrYvBMcIhNsTITCwxQC7a+8XuHL8RqV8JTU6vQ6ok5qp7yTOltsxygdfXx1sSyAtXB0eHAa8lNSEugsBphFh0OOb/Uuwpk8smf5flFY99zAhMLiKbWhm+Xb5fubKtQYT4WfdyvjZplDx0A3Hr5pV/tj0ONxz9dBNXIMadQwelN3xOvtBEnsYGVkIa3L7XyFeoBWV/fOnZsTtKIs9N3O8Nn9d7a5vFgCCSv9GBDFA+mCJYD279zVSpQ23zCPX86Idbyzfv/G0a8CMI8YjgkEdZkBnUK4JMAZXDCUmFMuI1ekizDJFXWRZ0UEQ6xA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-15 (Postfix) with ESMTPSA id
 706811800244; Sat, 14 Mar 2026 22:15:37 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v3 3/6] whpx: arm: enable more enlightements
Date: Sat, 14 Mar 2026 23:15:26 +0100
Message-ID: <20260314221529.47841-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260314221529.47841-1-mohamed@unpredictable.fr>
References: <20260314221529.47841-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: aFfNbpsL3rNNUHv-DxexpkoF-K8uyjdJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDE3NSBTYWx0ZWRfXxRbQEJKushJP
 BJLEQ8ZewTOjO4cCpHYsOVRm/e/ElDy5JJP1hculIALNRZy6RVXKcO6W3nuSu/K3aNLNmYyTWwl
 PdVLlgGZLfYAU1HehtaNk2cKUgIbkC/uavEdavz22Vps48mqaNJQVPpC3uhdXzBeelnDbxe2CG4
 kMuzfJFT3inpS1dAnHUsVWKy7fQZgFMvqb0rKI4671kYwaAJdec3qLl6FFcP4doFO637VMTkrdE
 vJUWbKuq8gT0nyvPC3NLSm8YoGvWtP4yjLmWlO8zC5gpRmWd8Yheykj+qGznenJ2MHhkzNJJr+i
 W/i2BEM6lYRq/uED8rgn9UqOqpDLU+msBCvcrqxgMq3+audswjOf6b7jrCuMys=
X-Proofpoint-GUID: aFfNbpsL3rNNUHv-DxexpkoF-K8uyjdJ
X-Authority-Info-Out: v=2.4 cv=aoa/yCZV c=1 sm=1 tr=0 ts=69b5de0c
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=qTR2NBNECMohrFtl0CEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-14_06,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 clxscore=1030 adultscore=0
 mlxscore=0 phishscore=0
 mlxlogscore=732 lowpriorityscore=0 spamscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603140175
Received-SPF: pass client-ip=57.103.66.103;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

Linux uses AccessVpRegs without checking availability and panics if it's not there. Expose it unconditionally.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/whpx/whpx-all.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 3df60a950d..9e5bc03a21 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -832,6 +832,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     UINT32 whpx_cap_size;
     WHV_PARTITION_PROPERTY prop;
     WHV_CAPABILITY_FEATURES features;
+    WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS synthetic_features;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     int pa_range = 0;
 
@@ -942,7 +943,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     }
 
     /* Enable synthetic processor features */
-    WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS synthetic_features;
     memset(&synthetic_features, 0, sizeof(WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS));
     synthetic_features.BanksCount = 1;
 
@@ -953,13 +953,15 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     synthetic_features.Bank0.AccessPartitionReferenceTsc = 1;
     synthetic_features.Bank0.AccessHypercallRegs = 1;
     synthetic_features.Bank0.AccessVpIndex = 1;
-    synthetic_features.Bank0.AccessHypercallRegs = 1;
     synthetic_features.Bank0.TbFlushHypercalls = 1;
     synthetic_features.Bank0.AccessSynicRegs = 1;
     synthetic_features.Bank0.AccessSyntheticTimerRegs = 1;
     synthetic_features.Bank0.AccessIntrCtrlRegs = 1;
     synthetic_features.Bank0.SyntheticClusterIpi = 1;
     synthetic_features.Bank0.DirectSyntheticTimers = 1;
+    synthetic_features.Bank0.FastHypercallOutput = 1;
+    synthetic_features.Bank0.AccessVpRegs = 1;
+    synthetic_features.Bank0.SyncContext = 1;
 
     /*
      * On ARM64, have enlightenments off by default
-- 
2.50.1 (Apple Git-155)


