Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71F5F99C9E
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEEFA-0006qZ-0o; Sat, 18 Apr 2026 18:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEF3-0006TP-MG
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:24 -0400
Received: from p-east2-cluster1-host7-snip4-10.eps.apple.com ([57.103.76.73]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEF1-00050y-6b
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:21 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 9B5671800200; Sat, 18 Apr 2026 22:34:11 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776551655; x=1779143655;
 bh=cbyw4J9p3BxQsYUbbf+71GgW3JjwCzY5skdqOd0TL1w=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=XwNacDEQNwddzkJEiAH1ziZJ0LbR9GUWflcseBC5zZ5x041M1mTpjxsUhhR2liZcPbREjhhxJ6q1ANjzTLpr1FDhEfH+/IQU/ZSpkPuchlq+OoMGkpcVp9lH4olxG/EOMGIhV7OHNJe1jRpzkOfTeMyy0+db0NlYidqIwWpCpKRT8X0AtA2RL3lt0RW06vSfAs2yitsQ1RGfVzNwZ0nqpv+XQl68pBQKR8ddq0q28WeSrc7W/55qDo98CuV9S6FSPSoOnQb/Yw47lu4D5NW6X4csXQaqJ5i96VVGCzTN4W7Vb4z+BPXi4hfS1CM337SueLnYYk/VUERh2Vq98295Qg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 0B66418000B2; Sat, 18 Apr 2026 22:34:08 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 25/38] whpx: i386: set WHvX64RegisterInitialApicId
Date: Sun, 19 Apr 2026 00:33:07 +0200
Message-ID: <20260418223320.51330-26-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260418223320.51330-1-mohamed@unpredictable.fr>
References: <20260418223320.51330-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDIyOCBTYWx0ZWRfX52ks4epzl7T9
 CejhoMK5GH0JsraSAMGyawfZ/3kuejk9Z+1e1mVIYLJB47Xbsu0x0v33qQViICfPenY3VvD26Yr
 A10FcvFM6eND64KtLu2j2njT1/MaBPVQhc77z5J0eWxSiXlJQC8sdttXqQpVPriXJ3rGb5g+atd
 lIb6VLIbevbkFhXL7s8/2t3Z+Gt8u+AD5OF43n835B2l6hmWqNJZU+8EVZl9njr4ihjIvgV/yT5
 /LKSpDjWxRVXCs/002/8E5T/060sfUj0YOyZ7OLKoSZD6Jj7HGOjteSxuf9Wiie1N86bGl3JYFP
 l8RU+ymD8wcG7fjZN3u/TFVIEUBq98zS0YN5/rmPICZHOEfYL+rgemzLNeVIQM=
X-Authority-Info-Out: v=2.4 cv=c/WmgB9l c=1 sm=1 tr=0 ts=69e406e5
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=DsSKBDvzyVHF_5agjq4A:9
X-Proofpoint-GUID: z3rb19yKk9PDi52qeNbuo8FfIywsZqFX
X-Proofpoint-ORIG-GUID: z3rb19yKk9PDi52qeNbuo8FfIywsZqFX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_06,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 adultscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=985
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604180228
Received-SPF: pass client-ip=57.103.76.73;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Keep Hyper-V aware of the initial APIC ID chosen.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 5c2a9bb8ad..a7282eb96a 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2398,6 +2398,11 @@ int whpx_init_vcpu(CPUState *cpu)
         goto error;
     }
 
+    if (!whpx_irqchip_in_kernel()) {
+        WHV_REGISTER_VALUE apic_id = {.Reg64 = x86_cpu->apic_state->initial_apic_id};
+        whpx_set_reg(cpu, WHvX64RegisterInitialApicId, apic_id);
+    }
+
     /*
      * vcpu's TSC frequency is either specified by user, or use the value
      * provided by Hyper-V if the former is not present. In the latter case, we
-- 
2.50.1 (Apple Git-155)


