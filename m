Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF40C5CFC1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 08:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvsk0-0004dj-6a; Mon, 17 Aug 2026 04:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuxu@nucleisys.com>)
 id 1wvsjx-0004dH-Fw; Mon, 17 Aug 2026 04:30:41 -0400
Received: from smtpbguseast3.qq.com ([54.243.244.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuxu@nucleisys.com>)
 id 1wvsjs-0004Cl-32; Mon, 17 Aug 2026 04:30:41 -0400
X-QQ-mid: zesmtpsz4t1786955415tf300e903
X-QQ-Originating-IP: I2ckG5cVQosX8OVWY2qWW921xCoRSUIQIxE6jfmyFaE=
Received: from XL-L17C6SCQBD5V.corp.nucleisys. ( [58.19.1.122])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 17 Aug 2026 16:30:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8252797677432225739
EX-QQ-RecipientCnt: 6
From: Xu Liu <liuxu@nucleisys.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Xu Liu <liuxu@nucleisys.com>
Subject: [PATCH] target/riscv: Make Zcmt JVT loads endian-aware
Date: Mon, 17 Aug 2026 16:30:05 +0800
Message-ID: <02050B1BBB8815BE+20260817083005.2392-1-liuxu@nucleisys.com>
X-Mailer: git-send-email 2.50.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:nucleisys.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MBoHLcWngaPNSHYwq35vM7CYiPYCASAD3giYX4E6kwMTR9H7MNRzHSzD
 qPT1KDmim3l0CMVvC8RHNf/1NGU/5iB9NsoKSTOfBdoYTUXq7QDAqdEnmx5WyN3K7ck1Xxl
 eIzTC/032UjHj0m5oYnaoacNgapTjFdveySme5I5Oxq9v6E6J1NBS4uuz+uOJEQQSEp/vGI
 rUwBrKq5dexu4FTMXBpVYNDqAS4WTZkOSuu2FNaMrzA59JmRPBorGDw/mdnWyNXbSWLY0oT
 MF+4nQcqJseVs5ZGf7TMI9074v3rpPlTLDfYcirH2quBlR0j+K0Q3I0k6lM5cHoJyz6T9dU
 JmrHMgzZhWROoQOhQ9OUdR+MR6z4KMqDjvQOYdprG5xMmTPn8qkeVodthXUugtYgDVUf2Ks
 SXxnA+9Q06P2yIRYz4JnmszvKAvIy31HhG9CWId4HBb+7nRLexoFTR0UuOTSaf9U1s0lVw0
 Q0ICEIVDLMd2UpLjwXrrlmBrrsRpk/ZDYBpzEmuJ5Nfph1jG6DdKuDpLf4eN1K4NVgyCCjW
 6QRtn7+SZEyEw+U4+L4B1FaTOsxcRnh9bnHdRyEYpRZ0UCvOutoKcrOluHxGfyjqeVKKg2V
 ngbpcCydLu9JXpaCffD5RwpIphSLu6wIKuYP+BhJ7gzvFJCKXaOJeAggoJUMR5D84TPahI2
 U39Tfk8HMVFGdsDrVGwm+SsFc+GJ10zgAyosF9YvwagLI/jbtvrXoe6/yhP0+EKxV7WTF9C
 AvSc1CUqhJet5E4HJrOdPDdGa+3oo5w11okqZhwHBSulQQsR4YbqMiYtyWMsZCA81DeSxKJ
 yKPiU2DUhM5Vcz/AWB6lFxW/asWg/rCyDWutzKi4dFiLe3Z4biTpc5pqgFrid/2BNNiv4dc
 iwsh0LKvyocvIWqj/FJaczNhS82UV6lANTZOvlWg+GpJafxqVSaBwOO5kTnl9T9sd/5zpMO
 RLJ4rfhO1k3LN+ndjAdcOFh5Cxhy7TW/3qOxmOyRtGny87i2MhZWHEE6hIN0eOmf7gFmFys
 00NXS+PfYehQNbEdPIT9zyDp/cEKY=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
Received-SPF: pass client-ip=54.243.244.52; envelope-from=liuxu@nucleisys.com;
 helo=smtpbguseast3.qq.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
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

The Zcmt specification says JVT table entries follow the current data
endianness. Support that behavior as described by the specification so
big-endian guests can use JVT tables stored in big-endian form.

Signed-off-by: Xu Liu <liuxu@nucleisys.com>
---
 target/riscv/tcg/zce_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/tcg/zce_helper.c b/target/riscv/tcg/zce_helper.c
index 15bf0a99c8a..c6ba4c1a476 100644
--- a/target/riscv/tcg/zce_helper.c
+++ b/target/riscv/tcg/zce_helper.c
@@ -18,12 +18,14 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "internals.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
 
 target_ulong HELPER(cm_jalt)(CPURISCVState *env, uint32_t index)
 {
     unsigned mmu_index = cpu_mmu_index(env_cpu(env), true);
+    MemOp endian = mo_endian_env(env);
     MemOpIdx oi;
 
 #if !defined(CONFIG_USER_ONLY)
@@ -45,11 +47,11 @@ target_ulong HELPER(cm_jalt)(CPURISCVState *env, uint32_t index)
     }
 
     if (xlen == 32) {
-        oi = make_memop_idx(MO_LEUL, mmu_index);
+        oi = make_memop_idx(MO_UL | endian, mmu_index);
         t0 = base + (index << 2);
         target = cpu_ldl_code_mmu(env, t0, oi, 0);
     } else {
-        oi = make_memop_idx(MO_LEUQ, mmu_index);
+        oi = make_memop_idx(MO_UQ | endian, mmu_index);
         t0 = base + (index << 3);
         target = cpu_ldq_code_mmu(env, t0, oi, 0);
     }
-- 
2.25.1


