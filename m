Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B296D6AAF8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 19:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Nla-0000OS-V2; Thu, 02 Apr 2026 15:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8Nl8-0000Hy-Sa
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 15:31:20 -0400
Received: from p-west1-cluster6-host9-snip4-2.eps.apple.com ([57.103.67.85]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8Nl6-0008FC-28
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 15:31:17 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-1 (Postfix) with ESMTPS id
 F29491800221; Thu, 02 Apr 2026 19:31:12 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775158274; x=1777750274;
 bh=jSFEY3OW57r5Gmf0SB6G349rIgUNCT10rXc1M/CBSww=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=UM4OVm4moINXD038xrJuejlaG3+8ieGxKyWnLusXcfcTpaz8sIqEYbxWC9ZLBWlyNOt236v7/6kDobzchrceutPw9oPM1mR86b5Lve9l64/jINw/cN4b+NZ9Rp4HBI/w4yAs4sZCVTwo57+VxmF7x6orwV9Gr47OLBowml+eUYbcT/Pp5rCeCHH+z9+4i0Ib0gMo9f2GNa2v+/8b8VFQUW1c4vdMS5auxhzRoe6zHi1161JPHyHnvzn+wVvQ8Bz83oTA+u1DnmXWZkF0p/u70JtG9fXi1YmrRY3SpMjM1uSVu68idXVf+2BZWbw86RzSJPN9CsIlyp0OwiOQQo67Ww==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-1 (Postfix) with ESMTPSA id
 573011800228; Thu, 02 Apr 2026 19:31:10 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 1/6] target/i386: emulate: include name of unhandled
 instruction
Date: Thu,  2 Apr 2026 21:30:59 +0200
Message-ID: <20260402193104.56331-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402193104.56331-1-mohamed@unpredictable.fr>
References: <20260402193104.56331-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1Cvr_OtJn6U2L2Xhh8txNimTDuqaYJtK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE3NSBTYWx0ZWRfX6PQqXfwut1Rz
 deBHWLkq2qRYvIc4o4p948zohVmMYEYjf7LIxYXC4SEVY9fRgV5RPBuQNeoSmlaZOhFqSPUHOhn
 RYBJu6mlf59dE/lt50Al8Cm6UpE70mVgbwTg80aSpW+BTnRM8Nrym6z4ASnQSyq1wnVSuYcQIHA
 UIAa6N78Z1tDeziUWG23F//xVDhkAN66ueT0wLzyLw6tlBfZtlrwlWs3vXDdfVQk/H0wzp7nwhW
 FMg6LEp6tBgUvSh/VFyEwEiL3X6ZaOLLH1dKKCKMOTQuaY9fxzcA4sAns4D3TXR7C9vUo1Xb8RG
 RmtT4nF2tLePsedRX3STTuG1aoFsL+rZoFbboY0fQIvHNNWH9g3wyFs2Qr82Ts=
X-Authority-Info-Out: v=2.4 cv=G5UR0tk5 c=1 sm=1 tr=0 ts=69cec401
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=x0iqa3ucmZZh0HPruXgA:9
X-Proofpoint-GUID: 1Cvr_OtJn6U2L2Xhh8txNimTDuqaYJtK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_03,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1030 phishscore=0 spamscore=0 mlxlogscore=903 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604020175
Received-SPF: pass client-ip=57.103.67.85;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
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


