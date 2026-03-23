Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5178AF483E7
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 19:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4l5T-0005sJ-AC; Mon, 23 Mar 2026 15:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4l5O-0005oX-4c
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 15:37:15 -0400
Received: from p-west3-cluster3-host6-snip4-3.eps.apple.com ([57.103.72.144]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4l5L-0004YV-LG
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 15:37:13 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPS id
 06389180010F; Mon, 23 Mar 2026 19:37:06 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774294628; x=1776886628;
 bh=7tlXE8XDGj2kvKBxePF9x7GibMqita798tBBZD+buV0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=cmhMS975zrf1zQxJtVvWbe/cbDJU5vt5Y1XgKY1AtLjcsvVnYP88PJa/UFXZXCP6nlhgNPrnkwm9RwCQzKq77Sh0ST+95hfCbZKi/Xk3NK7zcIDbXSKoggVjr/oYDEftD5L4uC/8nlBC/a5aG52wQXH+t8oY99inBJUQkTYztHQK17+x4MFXp5+OzAYPN7oSwcyzMgUhUCYMz3N4X6mi7FLmVQiJ3VG7NMm62kCv4tahAO/ScfRnpFao87nf5TKRFqXm4A1Rv7PCK+hul5OmL6FeR90AmQ7C6M1DkZ/+eVqr/Wd2wrTXUmB8ySvtfxGt7Z6JY4Jo5RjEr44QZuA1Yg==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPSA id
 1519F18000B9; Mon, 23 Mar 2026 19:37:04 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH 09/12] whpx: i386: indirect access to CRs
Date: Mon, 23 Mar 2026 20:36:42 +0100
Message-ID: <20260323193645.82602-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260323193645.82602-1-mohamed@unpredictable.fr>
References: <20260323193645.82602-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0NSBTYWx0ZWRfX0mESrA4ICWrY
 ctSaux9hTNFVNvBqoE7DkYYqiBfHm4a6h3MntIov0hIjAAA1jGPImKaeD6/ld0gIZDq87A3pscj
 R2CPCNTe/fumHMPLDvaq/+GUuXclaNoDy2Ax6zMRmhZ5xsgAh1TE68BqpncDWZfiDpbIYWU6VvW
 DefY1mK4NGotUT+6KMX08HZw8pIb6948LqfwsRW8fM0RCblBbcFEzJ1IIHt+sNfJwY1I9xFZYhA
 9VKthMtnVCAzVbjVLewmL930QbkftqJLB+MnoGD7/iDFsLQnf6CnsI18Bei1GdaON4yjTgbgEMV
 IW0TV/JpsWKye4C7Pdczj8WR0eJiA4In2kp9W0KkJ7eSirgFSAnG6aAv5EzSRU=
X-Authority-Info-Out: v=2.4 cv=JNQ2csKb c=1 sm=1 tr=0 ts=69c19663
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kcTmfTs-UkjvTY61EfIA:9
X-Proofpoint-ORIG-GUID: THuzm96cbPMXdDbc_ShpU9GRRhQgZYlc
X-Proofpoint-GUID: THuzm96cbPMXdDbc_ShpU9GRRhQgZYlc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=849
 spamscore=0 mlxscore=0
 bulkscore=0 clxscore=1030 adultscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603230145
Received-SPF: pass client-ip=57.103.72.144;
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 3484c33c02..32f01682c1 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -905,12 +905,42 @@ static bool is_user_mode(CPUState *cpu)
     return vcpu->exit_ctx.VpContext.ExecutionState.Cpl == 3;
 }
 
+static target_ulong read_cr(CPUState *cpu, int cr)
+{
+    WHV_REGISTER_NAME whv_cr;
+    WHV_REGISTER_VALUE val;
+
+    switch (cr) {
+    case 0:
+        whv_cr = WHvX64RegisterCr0;
+        break;
+    case 2:
+        whv_cr = WHvX64RegisterCr2;
+        break;
+    case 3:
+        whv_cr = WHvX64RegisterCr3;
+        break;
+    case 4:
+        whv_cr = WHvX64RegisterCr4;
+        break;
+    case 8:
+        whv_cr = WHvX64RegisterCr8;
+        break;
+    default:
+        abort();
+    }
+    whpx_get_reg(cpu, whv_cr, &val);
+
+    return val.Reg64;
+}
+
 static const struct x86_emul_ops whpx_x86_emul_ops = {
     .read_segment_descriptor = read_segment_descriptor,
     .handle_io = handle_io,
     .is_protected_mode = is_protected_mode,
     .is_long_mode = is_long_mode,
-    .is_user_mode = is_user_mode
+    .is_user_mode = is_user_mode,
+    .read_cr = read_cr
 };
 
 static void whpx_init_emu(void)
-- 
2.50.1 (Apple Git-155)


