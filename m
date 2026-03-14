Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1504D10854AA
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 22:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1XGy-00043N-9W; Sat, 14 Mar 2026 18:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w1XGu-00041Y-1V
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 18:15:48 -0400
Received: from p-west1-cluster3-host9-snip4-2.eps.apple.com ([57.103.66.85]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w1XGs-0001XP-EI
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 18:15:47 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-15 (Postfix) with ESMTPS id
 C6E521800254; Sat, 14 Mar 2026 22:15:43 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773526545; x=1776118545;
 bh=mNoHFLi9Ie//3+PZu7rLmkHCcXLLViQdJfE2tYZVxGA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=M3N4b3HT4MQGI9HiHmAxU6B/+rPGWDl+os+YUfhEWyRAIlLyRF7PjJt4B9LdG+dWYQhRRMwhMPVGUWDyCfATYKbwDQr8PwL0rlo7Yv/BMSAuk8NtO7PILi828IbMXOwj44YyLiLToZL7Rusj13OMXBcBxeIFIFFPZm8i/TWbXaD32srvO0RAGQLOaoBVrB9wQJx6V0BRco2mhiqz4NfmOoVjK5SHP02KYZ9zZxnbpuN15JHhKeds2vBqtCJ/va1KfHyVIgkg2hbWWgUUQ9ckebUMheQT3ZzfwvBjIYfYksi8dlJub2w1X0LED5Vlt11VNE1EqDLqpyKTHtbwss416w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-15 (Postfix) with ESMTPSA id
 1294B1800248; Sat, 14 Mar 2026 22:15:41 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH v3 6/6] whpx: arm: fix ID_AA64MMFR3_EL1 host feature register
 index
Date: Sat, 14 Mar 2026 23:15:29 +0100
Message-ID: <20260314221529.47841-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260314221529.47841-1-mohamed@unpredictable.fr>
References: <20260314221529.47841-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDE3NSBTYWx0ZWRfXyB7d6ZQ/Or8I
 qjDU1PkfyS5FP4Kh+6WMKXL7H+qyVb9kM1F4N1V8QINgqZ1WsEDly0U6Ypr0uX4AqKKEG+nEm8k
 i7OqObuo/QjkrtoLp6UelTavyReAnE9RaZT2Xz6me/dAxzasHZf9+orEL7pDnCjfusrRjmoxULe
 z7Rlfa/RNUUPmwcU6TVjAiBkl+H+RsRxRLOnR59a6Fvh0/YSLej395eSqG0/433OgyBKBWnp5r4
 j98ilgKhmir8hwpb1X0AjggSM9eYyj7l6ERH/N9TaCUv1ITHvIkNBSEBd+he4sod1yVwbJ+5aGT
 9M6nuDC1Adqwl5nEC1TMGI+4DhEeVBr9IgcBHo1K9ZQlc+5eE8xL3UOZykhDUI=
X-Proofpoint-GUID: 4420SG31ThM7cirF_l4cWgnmPhpAufRK
X-Proofpoint-ORIG-GUID: 4420SG31ThM7cirF_l4cWgnmPhpAufRK
X-Authority-Info-Out: v=2.4 cv=JuP8bc4C c=1 sm=1 tr=0 ts=69b5de10
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=Pn7qWn3sc5hC6z4bglAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-14_06,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=887 mlxscore=0 clxscore=1030 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603140175
Received-SPF: pass client-ip=57.103.66.85;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
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

From: Osama Abdelkader <osama.abdelkader@gmail.com>

IdAa64Mmfr3El1 was stored in idregs[ID_AA64MMFR2_EL1_IDX], overwriting
MMFR2 and leaving MMFR3 never set. Use ID_AA64MMFR3_EL1_IDX so the host
MMFR3 value is stored in the correct slot.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 8aa24f2adc..bbf0f6be96 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -684,7 +684,7 @@ static bool whpx_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         { WHvArm64RegisterIdAa64Mmfr0El1, &ahcf->isar.idregs[ID_AA64MMFR0_EL1_IDX] },
         { WHvArm64RegisterIdAa64Mmfr1El1, &ahcf->isar.idregs[ID_AA64MMFR1_EL1_IDX] },
         { WHvArm64RegisterIdAa64Mmfr2El1, &ahcf->isar.idregs[ID_AA64MMFR2_EL1_IDX] },
-        { WHvArm64RegisterIdAa64Mmfr3El1, &ahcf->isar.idregs[ID_AA64MMFR2_EL1_IDX] }
+        { WHvArm64RegisterIdAa64Mmfr3El1, &ahcf->isar.idregs[ID_AA64MMFR3_EL1_IDX] }
     };
 
     int i;
-- 
2.50.1 (Apple Git-155)


