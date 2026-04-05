Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD75E64005
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 02:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9DJu-0003c8-IO; Sat, 04 Apr 2026 22:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w9DJs-0003bz-TO
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 22:34:36 -0400
Received: from p-east2-cluster5-host1-snip4-7.eps.apple.com ([57.103.79.10]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w9DJr-0008H0-Fj
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 22:34:36 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 F048B18000B8; Sun, 05 Apr 2026 02:34:30 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775356474; x=1777948474;
 bh=iMaqy92qTMtN0/VpAFedvsY2TEecY1Ap34g33JpCGSc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=MboLBv8zrWuc9eztSTqp/Ehg5u+voWXOdl46GmT8nPXJO0sD6JqPDysw2Qqyff2lqhVL19yuKgh/MiK5vpDJws1og3U16Kf0Nbrgl4oGahP9wgFfINuUNSDWMfUiVsLRU8BeYCKP0dWgEqH6YS/sNqH4IZhLc4tB1RJPKEZIB2ngliEkBNVw72pCDg/OvMzIYh02Zgn+Fv+uBuJBpX957j/JFLXAK+HDvgyMwDx9+gq/Q/h94Jt60oO7iYtLktL5cHagEWYcHUt2tzNTCijWtF0MTtEiRGQxu2zHwnZ9gIa3LCJ6UbLWprgcosK9vI4tR/8T0cwfr5fH0oa/vVJ6xg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 B337518000AB; Sun, 05 Apr 2026 02:34:28 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v7 11/11] whpx: i386: IO port fast path cleanup
Date: Sun,  5 Apr 2026 04:34:09 +0200
Message-ID: <20260405023409.23142-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260405023409.23142-1-mohamed@unpredictable.fr>
References: <20260405023409.23142-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDAyNCBTYWx0ZWRfXyPP7HYNF/E2Z
 CdyZnYmgjWPtPOygU8UF+zqfSOp/9p1RkKTQXncsqb0dVTeFRlJi5LaOK66ZLvmWJbJfTsHgwYg
 betGk56SmJi4vAbqvRGzTiWokqsV4spWgLLOT+Q+a0ViJyLPMCs2kL+I0LLQDlMaXrG90OQAjbs
 6iwvJCpC9RXdQe4ygYnYDuwLUTLEYbGptpB12qnwDoSYJYgXKVfem0rx0A2Ms/CsZE4eNBq4NdK
 CQWI6ewGrQbkLbGRWtgBxWXb6lBIP/Bi4JLlx+RLacz1fRLMq7E0G5yLddiAvA7nfloUK6i//sC
 yQWrBN2tnkAU1zZD1tde9vv6tgOG1txrZQWWkmj3kBkE5DkZCoydSRP/Itqse8=
X-Authority-Info-Out: v=2.4 cv=De8aa/tW c=1 sm=1 tr=0 ts=69d1ca38
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Vrzv6M8N8vcM0KmfSJEA:9
X-Proofpoint-GUID: izskt5RAIr3rHo9hQcGhc2YlmPxy1uhQ
X-Proofpoint-ORIG-GUID: izskt5RAIr3rHo9hQcGhc2YlmPxy1uhQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1030 spamscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=811 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604050024
Received-SPF: pass client-ip=57.103.79.10;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

vmport calls synchronise_state within an I/O port read.
Support that properly.

What was there before worked because of a side effect of
whpx_get_reg synchronising context if cpu->vcpu_dirty.

Remove that whpx_get_reg call in whpx_bump_rip too as it's no longer
needed now.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 8bc1a609d2..0cc04c38fe 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -862,7 +862,6 @@ static void handle_io(CPUState *env, uint16_t port, void *buffer,
 static void whpx_bump_rip(CPUState *cpu, WHV_RUN_VP_EXIT_CONTEXT *exit_ctx)
 {
     WHV_REGISTER_VALUE reg;
-    whpx_get_reg(cpu, WHvX64RegisterRip, &reg);
     reg.Reg64 = exit_ctx->VpContext.Rip + exit_ctx->VpContext.InstructionLength;
     whpx_set_reg(cpu, WHvX64RegisterRip, reg);
 }
@@ -890,13 +889,23 @@ static int whpx_handle_portio(CPUState *cpu,
         } else {
             reg.Reg64 = (uint64_t)val;
         }
-        whpx_bump_rip(cpu, exit_ctx);
-        whpx_set_reg(cpu, WHvX64RegisterRax, reg);
+        /* vmport calls cpu_synchronize_state on an I/O port read */
+        if (!cpu->vcpu_dirty) {
+            whpx_bump_rip(cpu, exit_ctx);
+            whpx_set_reg(cpu, WHvX64RegisterRax, reg);
+        } else {
+            env->eip = exit_ctx->VpContext.Rip + exit_ctx->VpContext.InstructionLength;
+            env->regs[R_EAX] = reg.Reg64;
+        }
         return 0;
     } else if (!ctx->AccessInfo.StringOp && ctx->AccessInfo.IsWrite) {
         RAX(env) = ctx->Rax;
         handle_io(cpu, ctx->PortNumber, &RAX(env), 1, ctx->AccessInfo.AccessSize, 1);
-        whpx_bump_rip(cpu, exit_ctx);
+        if (!cpu->vcpu_dirty) {
+            whpx_bump_rip(cpu, exit_ctx);
+        } else {
+            env->eip = exit_ctx->VpContext.Rip + exit_ctx->VpContext.InstructionLength;
+        }
         return 0;
     }
 
-- 
2.50.1 (Apple Git-155)


