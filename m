Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2F5D6AB1C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 23:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8RlC-0004Fn-38; Thu, 02 Apr 2026 19:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8RlA-0004FL-BM
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 19:47:36 -0400
Received: from p-west2-cluster6-host6-snip4-1.eps.apple.com ([57.103.70.34]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8Rl8-00042c-Mo
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 19:47:36 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-6 (Postfix) with ESMTPS id
 094251800138; Thu, 02 Apr 2026 23:47:30 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775173652; x=1777765652;
 bh=jSFEY3OW57r5Gmf0SB6G349rIgUNCT10rXc1M/CBSww=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=a2oAvlv0jODbR5Ae/eWAArBOEf2BVOeiZfb3dN81B3XkNbpGTzq9UkMFgsUIueZ4OaCsTkfPeV1UkB+U4oN3EXqHj2II6VZJK98M9b+0I35SZ990Jb9fN26I/h3OOAX/xebIQVrN7TvBVAqokvjRcZJS7DYkTpS79E7H3ZyNt9yyottlz4sUOYWW3JPFKYvsXzHmQcn5PrkuYRUHcthUwSjNoAZ14j2rZEFaStA9Q5e+fCEtS/7264uzZ6G7Fqxld6Zaep/ozgs0BDOJNpmchUpbnO4k3mKaOvWYgBXNSmWInSLSD/mMOVJrA/w0U9Nh/Rjm50q8fsxe1mgz7uAWIQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-6 (Postfix) with ESMTPSA id
 146D6180011E; Thu, 02 Apr 2026 23:47:28 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v3 1/7] target/i386: emulate: include name of unhandled
 instruction
Date: Fri,  3 Apr 2026 01:47:18 +0200
Message-ID: <20260402234724.88276-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402234724.88276-1-mohamed@unpredictable.fr>
References: <20260402234724.88276-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDIxMiBTYWx0ZWRfXybt9psVA9pVZ
 pjHvCxDKNWmbipvjrHFk/umggtDWNiQjvTTwH6wYvaWX6XD1VZIYCPwa087vlhMLb8l5eKcgYNZ
 CH7dZRsCaly37xBRocjUNuuTnFdBZ5rwYClm9vfILiLGovslQjCw6y8KYCEXc/BtAtvVhWEFmk4
 Vursa8MkrtM63eU5zaLsvCYGclXolhzqo2HAZsBvqWlC8UkDhBXhxEa5CAFVwJLkbZ2F0p7q4kO
 XLdoXsaoiMbfJIO3b+aLocSiQYKydt5YnrN//SU8P5hp9w4g3Cv71NU2aEwv02chM39aI1muv1/
 EMDDELQy0TsmPLcoAtGwGGvBQ9mDCn5gsaFfBlhglJXoCorVI3UOwbwkhCbPsY=
X-Proofpoint-GUID: DxRbvDKC-UprgcSirXR5wnw9UNbBSYVW
X-Proofpoint-ORIG-GUID: DxRbvDKC-UprgcSirXR5wnw9UNbBSYVW
X-Authority-Info-Out: v=2.4 cv=UOnQ3Sfy c=1 sm=1 tr=0 ts=69cf0013
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=x0iqa3ucmZZh0HPruXgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1030 mlxscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=903 adultscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2604020212
Received-SPF: pass client-ip=57.103.70.34;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Instead of just the command number, include the instruction name to make debugging easier.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86_emu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index 55b1a68eb6..c2da1a133f 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -1399,8 +1399,8 @@ static void init_cmd_handler(void)
 bool exec_instruction(CPUX86State *env, struct x86_decode *ins)
 {
     if (!_cmd_handler[ins->cmd].handler) {
-        printf("Unimplemented handler (" TARGET_FMT_lx ") for %d (%x %x)\n",
-                env->eip,
+        printf("Unimplemented handler (" TARGET_FMT_lx ") for %s - %d (%x %x)\n",
+                env->eip, decode_cmd_to_string(ins->cmd),
                 ins->cmd, ins->opcode[0],
                 ins->opcode_len > 1 ? ins->opcode[1] : 0);
         env->eip += ins->len;
-- 
2.50.1 (Apple Git-155)


