Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70429F54AC5
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w53U4-000762-MT; Tue, 24 Mar 2026 11:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w53T5-0005vn-8V
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:14:57 -0400
Received: from p-east2-cluster2-host7-snip4-10.eps.apple.com ([57.103.78.53]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w53T0-0005tN-Os
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:14:54 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPS id
 B88741801488; Tue, 24 Mar 2026 15:14:34 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774365277; x=1776957277;
 bh=zodV20KljGzIfu43VRyDL9cMkLVaJYP9ThhIqUxnyaU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=DbJvIxUjbL/BPL72T0O3z6+Yk1jH6MbLX8MVq+4WYsQvT81fvuHTwWJhuwsKAwO1Vy2/ggv+K28s0nufDhAZ2IFYctgtpzkar9Ac7xn/w6b2ajWTWQ04Jq2nc+gvmBXBnpUEKB1GsYFvBdg+jsCqHeT664LtEF3AzxeV/UsKCMC6CnHdcaTxee1DajSaDbj/IM94AqunRxdfDcEFjIRjszUo8r0kEDr3axteCl0aeHPkJlyfrLB1sYn4BZacxEQWf6nkQnyo3ILEvY0da2o16BlXjlMjGT5RvGgwWIg5ED9MEZu6xdFLEXLRyAA6cni9uorVYUw6T0kS3K7lPkbUJg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPSA id
 B8E311814D2F; Tue, 24 Mar 2026 15:13:52 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v3 09/12] whpx: i386: indirect access to CRs
Date: Tue, 24 Mar 2026 16:13:20 +0100
Message-ID: <20260324151323.74473-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260324151323.74473-1-mohamed@unpredictable.fr>
References: <20260324151323.74473-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExOSBTYWx0ZWRfX7Y4LH69998j8
 ++AwbcK3g1ntJAYwcoKQo3Gl1xVJ+NxDS65Vh+Cjjl0MaitoydCaRNxL0Ic170oeI1tbKmqlyQW
 +5vsPSM2MR9fg79ITKqkMp0yXCS9VZ4y4ijyaUbSdjvGXwvwLBc5v5AyfcIbPGUtmO0y//gM/Rq
 +ESEBzWw33iansRfiPS2ydt1+dz14GJenGj+4IbJnGFA9SWY5ArFT7OR8C1Ie3i3is24CsNOf8c
 UberGdnmfyESooxnQdx0JodinWET2XLbLsrLc98BROiTCUcVA0P6tXGrFH4HPAis2AREowLZpBS
 38C/e7tY9Yjm8YN08JVsqz2OMgceaRboV7JM/9MGm1dltUquHEiwrmIFTcyBYo=
X-Proofpoint-GUID: qMBHd86HAWWXnNzv9fjvNWQoHPVrM_n7
X-Authority-Info-Out: v=2.4 cv=H/rWAuYi c=1 sm=1 tr=0 ts=69c2aa5b
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kcTmfTs-UkjvTY61EfIA:9
X-Proofpoint-ORIG-GUID: qMBHd86HAWWXnNzv9fjvNWQoHPVrM_n7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1030
 mlxlogscore=878 bulkscore=0 mlxscore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603240119
Received-SPF: pass client-ip=57.103.78.53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index b97dc9fd51..71b33a632a 100644
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


