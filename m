Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96B4FF5135
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABUG-0005s8-QP; Tue, 07 Apr 2026 14:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wABSZ-0002iK-VX
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:47:36 -0400
Received: from p-east2-cluster2-host5-snip4-7.eps.apple.com ([57.103.78.30]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wA8Bo-0002Ei-Np
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 11:18:05 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-5 (Postfix) with ESMTPS id
 377CD18013F0; Tue, 07 Apr 2026 15:18:01 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775575083; x=1778167083;
 bh=G89W4sMC3YwwxzvqsgVypuGjICEkNIb9nBQsRfciAZw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ddLl0Xi03WdGL1H2NZx4gYJRukW6mGTefyss/DJkcfZm/MFdrkVnHbAqecQM//zaUJEHLYXq19n/7nWmi09uSVINqiiv3JfV0lpBp/L7eDgsaG4gfdW+ftIo1k7DT8O4rOYbPqPNCVZA6Xu0aUexU3VNv1UGTiuaLA6hFk0JE2bpUc6QTEkfiXYkxTE96CPqZWDG3NGp5lI9MkbpDPwyJItb3zJ1oN4pzGD8AVNco5GwwbIOY03o2jP6Un3/6vkaysV/7dfJycLd8vErM1P5TDNFnlkZ7Rn4csRHMicNXhcX/SFUHJItCDIjTfB4CA3hyq1AwykddSGio0G83sfZTw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-5 (Postfix) with ESMTPSA id
 37F2518013CD; Tue, 07 Apr 2026 15:17:25 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v9 11/13] whpx: i386: IO port fast path cleanup
Date: Tue,  7 Apr 2026 17:17:05 +0200
Message-ID: <20260407151707.46536-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260407151707.46536-1-mohamed@unpredictable.fr>
References: <20260407151707.46536-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE0MCBTYWx0ZWRfX+CbY9d32pmDM
 JCEfmK8qXeIAPt+2fSYx2PaNDcJQvJcUU/bOsVc7xUlHbIcUvnWbPjGVzYjBP4gIFTq8bLeIpLE
 tcesdLz7/yOyKB4oyh+iTNC49Qsw/ex/VgfISlQ/sUmKHH0uwy7J70V2hWqwKUkdUOBBH2K+Fgn
 ++9/zk7TFUj3ECWZFf85FwUwEg6vXeuhr/aNINTaqiSnX7lKyAq2P1SRsRqFgth6sWEwmI9QM0K
 CE0almHEHmPAQWUuwA9/3mNCnRBTygY5/CjuUd6DKOnimYCcvBG6Za1xC5h0u/AdxpK0s8Bs8Jr
 emRTAzjSm3joZl+5BSejsBtz48jQGzBUgvt3TA69877l32Y/2kRP7sgmXI37A4=
X-Authority-Info-Out: v=2.4 cv=Cuiys34D c=1 sm=1 tr=0 ts=69d52029
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Vrzv6M8N8vcM0KmfSJEA:9
X-Proofpoint-GUID: TS6MgRrhwAJjznr-CL9Q-e_XrT_-mfZy
X-Proofpoint-ORIG-GUID: TS6MgRrhwAJjznr-CL9Q-e_XrT_-mfZy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=812
 malwarescore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0
 spamscore=0 bulkscore=0 clxscore=1030 mlxscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604070140
Received-SPF: pass client-ip=57.103.78.30;
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
index 7c80d653d1..61aec98e66 100644
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


