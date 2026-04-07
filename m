Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85B5FF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABUD-0005jd-Vy; Tue, 07 Apr 2026 14:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wABSZ-0002eY-RO
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:47:35 -0400
Received: from p-east2-cluster2-host8-snip4-3.eps.apple.com ([57.103.78.56]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wA8Bq-0002F5-Sn
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 11:18:07 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-5 (Postfix) with ESMTPS id
 33AAD1805AD5; Tue, 07 Apr 2026 15:18:02 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775575086; x=1778167086;
 bh=zcmYD8sBYnUVL4imQw8BkyvhG03VGFAjf3wzcMF8rtM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=S35eQpnNqe7cPqyAIL0odtVczQ7IOrxheXEZ7ft0kbf0ixVvkBydbVuPF2nvVEbotAFudTPCVIXEs8B47Ht+ZPcIHv4gpmEC8/p3Y7DpL+UZViHSuBHiBa2MzRVRn/0q3X5u9fJ5DXGspGq8gUH+STTg/r3vT8Ftrjgk58aSzaOegxvx93Va+K9jVazwF9v43jWgrHixAAXQYL5rpXtEozYD0Njpy0ZzLbhUCjuKJeKaY2SIgvSBv/Z0XUKqjqDcELA5i0PfBR4AC9/SjPLitYcMDO5X5AqPMI5veVQUe8wO+7MITk+k3DWOss6tKPeHQvXZVYlOqfAZCBeKlRLNLQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-5 (Postfix) with ESMTPSA id
 924EF1803F3D; Tue, 07 Apr 2026 15:17:26 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v9 12/13] whpx: i386: disable enlightenments and LAPIC for
 isapc
Date: Tue,  7 Apr 2026 17:17:06 +0200
Message-ID: <20260407151707.46536-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260407151707.46536-1-mohamed@unpredictable.fr>
References: <20260407151707.46536-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE0MCBTYWx0ZWRfXzE3iSjJTw8n1
 Voz2jDUYtmX5lFZ2VsA87YUfB1o/blCZTvWsc5V4P/v10d8mkfDwYCGS7Y4Mbp71utxwxEObvZw
 7slWHDW8FtrTLMHgP9wFw1o9o8HZMA4AOgIk4T4j3UezYTeh9MhNzjzKqmQk7rM9mrT8dtn8DOe
 9e7C+i0WwnuI9hiJ6s/yvw0buQaLA3q256p1VHD/H08NA4xhMVb/VNrSuSlV7QhZVUQU9qp6bb1
 IOJiCQZIlsawJwb+/IuTn0aU+E6Ale8f+CXQF4qP/nuw4/tvMNzXe4df9yr9GKv27SNvRuuREjc
 asgSLdXlKJkNj8BgXbURlJrYuUi51g1qEtsXuUlggnv8d9lDlbkZuIDUpgdpY0=
X-Proofpoint-ORIG-GUID: s4v7njGhyyAU4baUzPELg1DvneMiqKB4
X-Proofpoint-GUID: s4v7njGhyyAU4baUzPELg1DvneMiqKB4
X-Authority-Info-Out: v=2.4 cv=Z5nh3XRA c=1 sm=1 tr=0 ts=69d5202c
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kaNVauZA35-AGszze7oA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1030 phishscore=0 mlxlogscore=815
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2604070140
Received-SPF: pass client-ip=57.103.78.56;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The isapc machine doesn't have an APIC. And Hyper-V enlightenments
don't sound too useful to have there so disable those.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 61aec98e66..7a31dc6427 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2470,6 +2470,14 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
+    /* for isapc, disable Hyper-V enlightenments and LAPIC */
+    if (!strcmp(MACHINE_GET_CLASS(ms)->name, "isapc")) {
+        whpx->kernel_irqchip_allowed = false;
+        whpx->kernel_irqchip_required = false;
+        whpx->hyperv_enlightenments_allowed = false;
+        whpx->hyperv_enlightenments_required = false;
+    }
+
     whpx->mem_quota = ms->ram_size;
 
     hr = whp_dispatch.WHvGetCapability(
-- 
2.50.1 (Apple Git-155)


