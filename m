Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69A6CCA468
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 09:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3X7C-0003Dk-Nv; Tue, 30 Sep 2025 05:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1v3WzA-00016p-DN; Tue, 30 Sep 2025 05:49:28 -0400
Received: from mxct.zte.com.cn ([183.62.165.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1v3Wyz-0005Gg-Vf; Tue, 30 Sep 2025 05:49:28 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4cbYD92zqkz4xNtD;
 Tue, 30 Sep 2025 17:48:57 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
 by mse-fl2.zte.com.cn with SMTP id 58U9ml0l059640;
 Tue, 30 Sep 2025 17:48:47 +0800 (+08)
 (envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxlzmapp02[null]) by mapi (Zmail) with MAPI id mid12;
 Tue, 30 Sep 2025 17:48:49 +0800 (CST)
Date: Tue, 30 Sep 2025 17:48:49 +0800 (CST)
X-Zmail-TransId: 2b0468dba7817bb-0a1c6
X-Mailer: Zmail v1.0
Message-ID: <20250930174849833XG1Q1ETbNvg66WU2UVBTV@zte.com.cn>
Mime-Version: 1.0
From: <wang.yechao255@zte.com.cn>
To: <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, <zhiwei_liu@linux.alibaba.com>
Cc: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
Subject: =?UTF-8?B?W1BBVENIXSB0YXJnZXQvcmlzY3Y6IEZsdXNoIHRoZSBUTEIgZW50cnkgZm9yIHRoZSBzcGVjaWZpZWQgYWRkcmVzcw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 58U9ml0l059640
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Tue, 30 Sep 2025 17:48:57 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68DBA789.000/4cbYD92zqkz4xNtD
Received-SPF: pass client-ip=183.62.165.209;
 envelope-from=wang.yechao255@zte.com.cn; helo=mxct.zte.com.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 30 Sep 2025 05:57:39 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: yechao-w <wang.yechao255@zte.com.cn>

When the guest executes sfence/svinval with an address parameter,
invalidating only the specific TLB entry for that address rather
than the entire TLB enhances TCG performance.

Signed-off-by: yechao-w <wang.yechao255@zte.com.cn>
---
 target/riscv/helper.h                          | 2 +-
 target/riscv/insn_trans/trans_privileged.c.inc | 4 +++-
 target/riscv/insn_trans/trans_svinval.c.inc    | 4 +++-
 target/riscv/op_helper.c                       | 8 ++++++--
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index f712b1c368..de3757fa75 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -135,7 +135,7 @@ DEF_HELPER_1(mnret, tl, env)
 DEF_HELPER_1(ctr_clear, void, env)
 DEF_HELPER_1(wfi, void, env)
 DEF_HELPER_1(wrs_nto, void, env)
-DEF_HELPER_1(tlb_flush, void, env)
+DEF_HELPER_2(tlb_flush, void, env, tl)
 DEF_HELPER_1(tlb_flush_all, void, env)
 DEF_HELPER_4(ctr_add_entry, void, env, tl, tl, tl)
 /* Native Debug */
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index 8a62b4cfcd..b6865f51b2 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -154,8 +154,10 @@ static bool trans_wfi(DisasContext *ctx, arg_wfi *a)
 static bool trans_sfence_vma(DisasContext *ctx, arg_sfence_vma *a)
 {
 #ifndef CONFIG_USER_ONLY
+    TCGv addr = get_gpr(ctx, a->rs1, EXT_NONE);
+
     decode_save_opc(ctx, 0);
-    gen_helper_tlb_flush(tcg_env);
+    gen_helper_tlb_flush(tcg_env, addr);
     return true;
 #endif
     return false;
diff --git a/target/riscv/insn_trans/trans_svinval.c.inc b/target/riscv/insn_trans/trans_svinval.c.inc
index a06c3b214f..1b1b932ac6 100644
--- a/target/riscv/insn_trans/trans_svinval.c.inc
+++ b/target/riscv/insn_trans/trans_svinval.c.inc
@@ -24,12 +24,14 @@

 static bool trans_sinval_vma(DisasContext *ctx, arg_sinval_vma *a)
 {
+    TCGv addr = get_gpr(ctx, a->rs1, EXT_NONE);
+
     REQUIRE_SVINVAL(ctx);
     /* Do the same as sfence.vma currently */
     REQUIRE_EXT(ctx, RVS);
 #ifndef CONFIG_USER_ONLY
     decode_save_opc(ctx, 0);
-    gen_helper_tlb_flush(tcg_env);
+    gen_helper_tlb_flush(tcg_env, addr);
     return true;
 #endif
     return false;
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 110292e84d..0fe5fcb3ac 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -555,7 +555,7 @@ void helper_wrs_nto(CPURISCVState *env)
     }
 }

-void helper_tlb_flush(CPURISCVState *env)
+void helper_tlb_flush(CPURISCVState *env, target_ulong addr)
 {
     CPUState *cs = env_cpu(env);
     if (!env->virt_enabled &&
@@ -566,7 +566,11 @@ void helper_tlb_flush(CPURISCVState *env)
                (env->priv == PRV_U || get_field(env->hstatus, HSTATUS_VTVM))) {
         riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
     } else {
-        tlb_flush(cs);
+        if (addr) {
+            tlb_flush_page(cs, addr);
+        } else {
+            tlb_flush(cs);
+        }
     }
 }

-- 
2.27.0

