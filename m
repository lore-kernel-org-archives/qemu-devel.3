Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C3BFD530A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 19:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw3Ah-0003G4-54; Fri, 27 Feb 2026 14:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vw3AY-0003Es-Oe
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 14:06:35 -0500
Received: from p-west2-cluster3-host6-snip4-4.eps.apple.com ([57.103.69.97]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vw3AW-0006RE-8Y
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 14:06:34 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPS id
 768E51800155; Fri, 27 Feb 2026 19:06:27 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772219188; x=1774811188;
 bh=LjzGrhEn0ykJAOrChlujow4EMgIqhCxyPavUws3eZDg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=f4fW1R68Yt+08jCkuj2LELOVbDapZWkwDw2sAhhxgUJh9+AlEyVUm5jrNSvDeZhEue5JsuWjLbxE5nPn8PJyQShF0ghN9NJiJJJ3J7O1sfPbs/jfkjlczCUJ02erJd7/tAr0Tb7QDomt7MKGz12LHBHOZIqb7dzu/KMVdLqpthYRWgOuJvaIGEcBoKHo41UQtdh3/O2bwnmhbBODYMCHfpf6WqwHeNqEXfgpbepxjWnEo+VgntJLZopsmUB79x+zNfayOAe1aql6u19V0ReVhh+N7Ah2XzkeAFn3ZVCu4NgtiP6FE7+enBUkHpmGcNlZeTJbnUB2B5VMpAxCILIURA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPSA id
 1E53818001B0; Fri, 27 Feb 2026 19:06:25 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH 3/4] whpx: i386: enable synthetic processor features
Date: Fri, 27 Feb 2026 20:06:18 +0100
Message-ID: <20260227190619.8867-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260227190619.8867-1-mohamed@unpredictable.fr>
References: <20260227190619.8867-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: K0CYA5vu2nTuqjOGsJNdEAifx3tsW4qq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE2OCBTYWx0ZWRfX46fsds8AoWCe
 LTh1P7aSMUxUqkWqcyJrrrUSMYB4EXcpwxidmbxICUyToma2tnYWP5uQVv7MaJrTSJXvHgAYIwo
 Rl5v8SA2EdlNrirEeTke4lpBxXi8FtsLmbwTCYbTFFO0xEeEdnvc3NH3uGoBquNYucGB6otnrmo
 cGglka2yMYy7hjQLWNIX+sXAXgKU+nynbt7GrufZt3qP8HuzqoAegbL9rSmgExhTGW9SxqMnWbb
 SF+fZHfLUdIU+6uEEbPl2vThb1CI3XOMnd+Q9toWpFNv6QemHwvPZT08dozJymhQoES6GQggM0E
 8QfqAs7leA1fzfNyPTmAm7GhXzti8MV5HU0xAlHGZzxwEwnoIaFyQ5W6phUuyY=
X-Proofpoint-ORIG-GUID: K0CYA5vu2nTuqjOGsJNdEAifx3tsW4qq
X-Authority-Info-Out: v=2.4 cv=N9Uk1m9B c=1 sm=1 tr=0 ts=69a1eb33
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=zrTx395S4Ej948ve6SYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 clxscore=1030 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=852 lowpriorityscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602270168
X-JNJ: AAAAAAAB8iFCAEPAbKZgLVEkUVVYiZqkYMGYQrq4sHTiZ2Fdhu6LYC57GujvsOcy54dtRp1EaL3A8nsTGofdpt1tI4iyKIl6ktA3v9iY/UpkGCcjRz+zlwrGei232iHXvASwiW4rKU7D0obvMi09FoHjLYMuZHf/EnmPu7XWbE3C6mElEkWWhc2jrPtfV2ua8VIH/DnalwyIYwoxuVGNEqgg7+Kmy5+Yk6LKuJYBlo7TKcFYTuGY0yf0oSpc/bcLU8OndyVK9s3FXa2PMaEWSM0iLPMqdj3zS4g51Ybb5AQWSllFuN2VIRwAbZQeEqm7iq4Cnl/FBKbp4iUfKe0tus1IGScgrfsXtrWql7Vz23pze/URxWAq17OCqBNL02dFU+qcpcn5Nf3NSR/SIiWrjpud74TPlX11hvIJCKdZP+6FJ4uAAAJhdsG3gFolXHgMPwXirbE7RAvXiN4ONjKoNVCKFR6Rh0l+NbsTHSyZhHRxNrJfLkhhsEPumaE2j8K+mH8m/HoD0Ic5Nw+aA3AXgjs7ZbrwaAd2JJ8NCT/46/zAr8f1Rr4K216Ve3EGT+1e7RILadb0LjwyW2aBDuHBd5J/cmcMEFgLGDWQ0mI=
Received-SPF: pass client-ip=57.103.69.97;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
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

At the point in time in which we setup the partition, the vCPUs
aren't available yet.

So enable them by default for now like what the MSHV backend does.

AccessFrequencyRegs is shared for both the LAPIC frequency reporting and the TSC frequency.

To still benefit from the fixed TSC frequency reporting when kernel-irqchip=off, still enable AccessFrequencyRegs anyway.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index ccc52d1f96..e7e0a50da6 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2152,6 +2152,40 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
+    /* Enable synthetic processor features */
+    WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS synthetic_features;
+    memset(&synthetic_features, 0, sizeof(WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS));
+    synthetic_features.BanksCount = 1;
+
+    synthetic_features.Bank0.HypervisorPresent = 1;
+    synthetic_features.Bank0.Hv1 = 1;
+    synthetic_features.Bank0.AccessPartitionReferenceCounter = 1;
+    synthetic_features.Bank0.AccessPartitionReferenceTsc = 1;
+    /* if kernel-irqchip=off, HV_X64_MSR_APIC_FREQUENCY = 0. */
+    synthetic_features.Bank0.AccessFrequencyRegs = 1;
+    synthetic_features.Bank0.AccessVpIndex = 1;
+    synthetic_features.Bank0.AccessHypercallRegs = 1;
+    synthetic_features.Bank0.TbFlushHypercalls = 1;
+
+    if (whpx_irqchip_in_kernel()) {
+        synthetic_features.Bank0.AccessSynicRegs = 1;
+        synthetic_features.Bank0.AccessSyntheticTimerRegs = 1;
+        synthetic_features.Bank0.AccessIntrCtrlRegs = 1;
+        synthetic_features.Bank0.SyntheticClusterIpi = 1;
+        synthetic_features.Bank0.DirectSyntheticTimers = 1;
+    }
+
+    hr = whp_dispatch.WHvSetPartitionProperty(
+            whpx->partition,
+            WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks,
+            &synthetic_features,
+            sizeof(WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS));
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to set synthetic features, hr=%08lx", hr);
+        ret = -EINVAL;
+        goto error;
+    }
+
     /* Register for MSR and CPUID exits */
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
     prop.ExtendedVmExits.X64MsrExit = 1;
-- 
2.50.1 (Apple Git-155)


