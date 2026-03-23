Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D81F483E7
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 19:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4l5S-0005rM-EJ; Mon, 23 Mar 2026 15:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4l5Q-0005os-5H
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 15:37:16 -0400
Received: from p-west3-cluster3-host6-snip4-4.eps.apple.com ([57.103.72.145]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4l5L-0004Y9-NV
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 15:37:14 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPS id
 25EFA1800273; Mon, 23 Mar 2026 19:37:03 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774294624; x=1776886624;
 bh=2nLpn0O/CnlM8jHVd/S21trgTmB4bL47YrOHN68V7Uw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=LQowyuayCdABptHq3SRUlvmMmDQIq6pBPP+ywhRT477ldCm6wtY/xzfP3/qO8Qrd3HRqZRelqE7ary6tft3FQxeDqCQQsMoeAJGiUCxfgY8qNOp342ylPVqvjSzv41F7ygITv1PzZgG8Xt1YLDRhxuDO1VNJni4Sg6gp7a+fQ2lmDkxsasjgcJX2KFcoUABrFEizqQ2EVknsLQhoTwQIKUUSb05al4ggL29STCHdvuRP53jK5jS9U6JnuBnq5bJiUDqj8jzorZ48ZRPIPqq5X4Wewic9+5pjgfwRqmSkVFN12JrWGQtoxxwWfQtmPvuoqtWfrG3MUB7Z23l/3P/7xw==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPSA id
 25DD7180027E; Mon, 23 Mar 2026 19:37:01 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH 07/12] whpx: i386: add implementation of new x86_emul_ops
Date: Mon, 23 Mar 2026 20:36:40 +0100
Message-ID: <20260323193645.82602-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260323193645.82602-1-mohamed@unpredictable.fr>
References: <20260323193645.82602-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0NSBTYWx0ZWRfX+ypluZYSq3Hz
 a4jV/WCEfzypGV3rU0xS7n6bFZN7i/47klgHmKqx0uQH3aMYQ37AwJ5HyXBgxArWk6PUAycxXEG
 pAJNlNq5ZfW7TLXbtfceL5blc0eU0b4jpP2eigw9pOBEq9ubGF5YpKLoiuwMPRXB9S5Qk152PdA
 0No9/gu/YBItsW2HZ9OGR3Sor8+rkF4WLtUjqaDuWBdGu3vWyhD78lvDdzoZ3rQwwsE/ubiNHsd
 fQUlm0RAalg9cXS95JCyA04byfis19pPKz75W1GoBPWfH3BDhg/jJCtbkj6n3nVJitmjxLtNmAc
 TBu7zFooVmVvmKEi7k53FDBqsPzhDOoad0mjWMRtl0XneJoCXjTgn255UXAU3E=
X-Authority-Info-Out: v=2.4 cv=PfPyRyhd c=1 sm=1 tr=0 ts=69c1965f
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=od5n6cu0qASRTXmq4OYA:9
X-Proofpoint-GUID: Uxq_mH9ICMBW0fuzYtT3f8d9B90N-6v-
X-Proofpoint-ORIG-GUID: Uxq_mH9ICMBW0fuzYtT3f8d9B90N-6v-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 phishscore=0 clxscore=1030
 bulkscore=0 spamscore=0
 adultscore=0 mlxlogscore=890 lowpriorityscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603230145
Received-SPF: pass client-ip=57.103.72.145;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
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

target/i386/emulate now has new ops for fetching whether the guest is in
protected mode, long mode or user mode without fetching control
registers.

Use those for faster vmexits.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 69d141e7cc..3484c33c02 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -885,10 +885,32 @@ static void read_segment_descriptor(CPUState *cpu,
     }
 }
 
+static bool is_protected_mode(CPUState *cpu)
+{
+    AccelCPUState *vcpu = cpu->accel;
+
+    return vcpu->exit_ctx.VpContext.ExecutionState.Cr0Pe == 1;  
+}
+
+static bool is_long_mode(CPUState *cpu)
+{
+    AccelCPUState *vcpu = cpu->accel;
+
+    return vcpu->exit_ctx.VpContext.ExecutionState.EferLma == 1;  
+}
+
+static bool is_user_mode(CPUState *cpu)
+{
+    AccelCPUState *vcpu = cpu->accel;
+    return vcpu->exit_ctx.VpContext.ExecutionState.Cpl == 3;
+}
 
 static const struct x86_emul_ops whpx_x86_emul_ops = {
     .read_segment_descriptor = read_segment_descriptor,
-    .handle_io = handle_io
+    .handle_io = handle_io,
+    .is_protected_mode = is_protected_mode,
+    .is_long_mode = is_long_mode,
+    .is_user_mode = is_user_mode
 };
 
 static void whpx_init_emu(void)
-- 
2.50.1 (Apple Git-155)


