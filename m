Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF35BD6AAFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 19:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Nla-0000Nf-JE; Thu, 02 Apr 2026 15:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8NlI-0000Kv-E8
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 15:31:28 -0400
Received: from p-west1-cluster6-host10-snip4-10.eps.apple.com ([57.103.67.103]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8NlE-0008GK-AT
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 15:31:27 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-1 (Postfix) with ESMTPS id
 E779518000A2; Thu, 02 Apr 2026 19:31:19 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775158281; x=1777750281;
 bh=5KViXWu5mLq4rMws2uUToPUiw/2iSeLmnIpZ8cIoM4w=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=YJmH4M1JSdrX9OlOjO5vCT/+Pl5FjSsmQ+DbhqkjPbQjjxZ+lrT/7TI0YkbKE+5sC1PzKUIz/gNzrbugrq/CUf1pVHLlQrybETEGaI8RU3FNl2g0xHPhrBwDt8jA4MpjG6VaTnAom8TvYl3Oc2cENMOZkpcaSOWQskYoxF0VlUUUuo4KHcHjL4+Qs1bpp43eaDw2B3/jkzWUFjPJKaNm9mG6G/g/+578RNDsDXa+N0IpLi0q0xCrQE3Clgnjfg63QkdBoSIg2fgI9uzVvkMvU65eIC035Z7Q9rnpatMI6wNyrwQuJHBCOPJms6553C27ae1wHJ7Vr820/eCOj0jcKg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-1 (Postfix) with ESMTPSA id
 6E90D180017C; Thu, 02 Apr 2026 19:31:17 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 4/6] whpx: i386: disable TbFlushHypercalls for emulated
 LAPIC
Date: Thu,  2 Apr 2026 21:31:02 +0200
Message-ID: <20260402193104.56331-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402193104.56331-1-mohamed@unpredictable.fr>
References: <20260402193104.56331-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE3NSBTYWx0ZWRfX5fu3XT6PVWMA
 MMKxFP6cuNOKR+QZBHg7/60kxwneH0jylUO2pNB1aT3WEDhFvWg9764YFleLji5/U1FwDgYgbN/
 hA2hMkmtEO+tbsnLL4o2JE1yNQDWGoqBMqSt/qjUzpBH1Qf0JZ37N1A+c1fiHlEjaLacOwq6+sp
 HdruSvaEeG3dHFh2kqjOgu9OcJqYutPBC8/j9/rHpkdARE3XLALlYCZXNWQqYtzUjHuDeoLbHJO
 8SK4DXya087CbKLbr6MsLfHMWqmKIYVCv+iJg5/zu3chvzOb9yqGsVmOn+lOw6UrJdVwZkJaKbt
 3UCEEqSyzE6a0EwSr/+eVkePi37C4wJQnFuQgrz60svzjBtBcJYIx37c9uUDGw=
X-Authority-Info-Out: v=2.4 cv=fME0HJae c=1 sm=1 tr=0 ts=69cec408
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Rm0zj2O9plGGl-KjdfMA:9
X-Proofpoint-ORIG-GUID: w8-i90rPeQjhNBSh7nEr2oR5TnNfN_S3
X-Proofpoint-GUID: w8-i90rPeQjhNBSh7nEr2oR5TnNfN_S3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_03,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=734
 phishscore=0 clxscore=1030 suspectscore=0
 lowpriorityscore=0 spamscore=0
 mlxscore=0 bulkscore=0 adultscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604020175
Received-SPF: pass client-ip=57.103.67.103;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

AccessHypercallRegs was present twice so clean that up.

Remove TbFlushHypercalls (and its extended Gva range sub-feature)
from the user-mode LAPIC case as it behaves oddly there.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index db8855cbea..3cd83b506b 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2483,10 +2483,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     synthetic_features.Bank0.AccessPartitionReferenceTsc = 1;
     synthetic_features.Bank0.AccessHypercallRegs = 1;
     synthetic_features.Bank0.AccessFrequencyRegs = 1;
-    synthetic_features.Bank0.EnableExtendedGvaRangesForFlushVirtualAddressList = 1;
     synthetic_features.Bank0.AccessVpIndex = 1;
-    synthetic_features.Bank0.AccessHypercallRegs = 1;
-    synthetic_features.Bank0.TbFlushHypercalls = 1;
 
     if (whpx_irqchip_in_kernel()) {
         synthetic_features.Bank0.AccessSynicRegs = 1;
@@ -2494,6 +2491,12 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         synthetic_features.Bank0.AccessIntrCtrlRegs = 1;
         synthetic_features.Bank0.SyntheticClusterIpi = 1;
         synthetic_features.Bank0.DirectSyntheticTimers = 1;
+        /* 
+         * These technically work without the Hyper-V LAPIC
+         * but behave oddly for multi-core VMs.
+         */
+        synthetic_features.Bank0.TbFlushHypercalls = 1;
+        synthetic_features.Bank0.EnableExtendedGvaRangesForFlushVirtualAddressList = 1;
     }
 
     if (!is_legacy_os && whpx->hyperv_enlightenments_allowed) {
-- 
2.50.1 (Apple Git-155)


