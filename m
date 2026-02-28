Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C28DFD0048
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 21:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwS9e-0004Ah-PK; Sat, 28 Feb 2026 16:47:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwS9c-0004AO-8t
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 16:47:16 -0500
Received: from qs-2005k-snip4-1.eps.apple.com ([57.103.86.232]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwS9a-0002Tj-93
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 16:47:15 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPS id
 3502E18001A9; Sat, 28 Feb 2026 21:47:12 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772315233; x=1774907233;
 bh=LjzGrhEn0ykJAOrChlujow4EMgIqhCxyPavUws3eZDg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=EfEVqr2PLTNRlJCHm49sFxU6s1DbRhx2Zu+U6OgGC/KQr+K+2DukQHSBQsGKY6Rt80LNriY4AP73MN9mkXiLBET7I3V3a4gmt5aP6qMT/D1+7ne7vX/LMWG/cAOY6T9GSz5na7POCnhk2l9xGtTm80SsINWAHSkYC18389QYGm61K2S22iTLFrDlRX3M567A0Pp3ODIhkQYZd0PiHxXP2qkmnvzqssCcPjLCk1IgBkLskVTQaGm4wckX3PI2jJiXhkcgb+SlmM1c7CS5JUXjv+zoJRlCO+tWHBLy0CIpV2Y0yAodOLXcPjvDxDTG8/x7fxNjCMQd30RQ5Y4pOjzYZA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPSA id
 9F0AC1800121; Sat, 28 Feb 2026 21:47:10 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 3/8] whpx: i386: enable synthetic processor features
Date: Sat, 28 Feb 2026 22:46:59 +0100
Message-ID: <20260228214704.19048-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260228214704.19048-1-mohamed@unpredictable.fr>
References: <20260228214704.19048-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9TGchPliEnsy24kq-Fm6YUSrXMORdcJ7
X-Proofpoint-GUID: 9TGchPliEnsy24kq-Fm6YUSrXMORdcJ7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDIwMyBTYWx0ZWRfX7YIu+EobIagd
 C9HfzvwOfmdM8pCiqwYBCSSWdtSwhlT8+FBTtg9Rj/xbgdnoEtuaAK/RtsxOsR/NrlxL2AHviaC
 75F02Fe1RAKHFj8T1t3ryWFO+g9sTU1phqYFQu4M17u2FJJe8Eu+CwPk+SajNM5fLF2xrCavuxo
 ypjs1zDFnU+J8ZzsWo5Alk3BDeYP1XkHh1n00b4X9f3DrodmuAvkPmAlY0BlIgTZwKSWxwzWFhe
 pZHoL+8Ok7EaMWD4RhtFWiSIcs+EZDvXIczx6XKS8AkglMJqNvIEtym4b5MtwvV1SXTUGo437sj
 Zn4Lr7JmTHGvFpzT3araUXpdMNvMwiuEQwN1lauFAiSnRplRohbhnLnmOXW1xw=
X-Authority-Info-Out: v=2.4 cv=ArDjHe9P c=1 sm=1 tr=0 ts=69a36260
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=zrTx395S4Ej948ve6SYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_07,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1030 spamscore=0 mlxlogscore=812 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602280203
X-JNJ: AAAAAAABozOBi5JSX3fGrhzryL5KidU6I1MXvNRYamalN/HEGtMr2kzhIgQvBuuLHU2n1I1S1sHVMkl3gapallDtd/4nG2t58ON53EQ/xd0Bcr96j0mMWuBuKJuLmEPEH1MUKP7ZOWAz0PTzO6Q9wBwtbydWj0hySwa1ZMSXiY89MZNdhRzY/LYq4JFTAAw/Spg3FelsM0eV9rJ4umljRYClp6QjTu9pPvZnRfOxfVShsjJNhGQeTn1GE9EXsetxYNkFhFTt8ayujAB3hPocoe6DEAo5QWbGOiOlImEhQjhDJZWuDpCKst6ktxfJmTIrtpZHHw+Kn/6OxF5NTEDFT2oCZnz2puvAQkXXzXrmnwoO3G0rlsYY8VMNhbxZ/gZ8gDkR5hsU2s/NTURl4tJ7atZRx7NfjWiCWFS5kzxG5yPA8Kf0dS5kkx64N7IkOSfQCXIkl2jjfEvjXyaT9VNY3Jdm878TIH02gS4g1y8qN9u0DE2hQbxjjCeKnm9AxSpZ7b1fKXRsuiya3Fuomrd3e+zi/xV54pm92TDClQvbJWIvXV2vwH/HzdY08+V1DktP9KMq8/o6CdzDOufsmHtMC6MwHc5oIMy1YW7LEa9nMBZ8nuYYlEWOsSXN3AiKOvHnTG2QLQQTWcgRZxO04ttmACYz1RxYbGp1vIG0ZSc8TAgtZXPE9Xk=
Received-SPF: pass client-ip=57.103.86.232;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.966, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.722,
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


