Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A25606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 06:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOrMv-0002fv-At; Thu, 05 Nov 2026 01:54:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xOrMp-0002Vj-Us
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 01:54:37 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xOrMn-0000zN-Rc
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 01:54:35 -0500
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8DxC9KxJ+xqaI8cAA--.17263S3;
 Thu, 05 Nov 2026 14:52:33 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJAxnM6wJ+xq+4EyAA--.17799S4;
 Thu, 05 Nov 2026 14:52:32 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>
Subject: [PULL 10/13] target/loongarch: Add asrtle_du()/asrtgt_du() helpers
Date: Thu,  5 Nov 2026 14:53:42 +0800
Message-ID: <20261105065345.966691-11-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105065345.966691-1-maobibo@loongson.cn>
References: <20261105065345.966691-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxnM6wJ+xq+4EyAA--.17799S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj97XoW5Ar4xZrW8WrWDAw47JF4fp5X_AFWxXoW0kF
 18Gws3Gr1SkFnYkrs3Xw1xJF909rZ7A39Fk3Z5ua1xXryUKFyUAws8ua1xJFZYgrykXa4x
 Ka4DJas3Zr9rl-sFpf9Il3svdjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf9Il3
 svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIY
 CTnIWjp_UUUY07kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcI
 k0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
 021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F
 4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
 0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
 7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcV
 C0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
 04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
 CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j8CztUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

According to the LoongArch manual, ldle/ldgt/stle/stgt and
fldle/fldgt/fstle/fstgt perform unsigned address comparison, whereas
asrtle/asrtgt perform signed address comparison.

Add the asrtle_du() and asrtgt_du() helpers, and use them for the
instructions that perform unsigned address comparison.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Xianglai Li <lixianglai@loongson.cn>
---
 target/loongarch/tcg/helper.h                 |  2 ++
 .../tcg/insn_trans/trans_fmemory.c.inc        |  8 ++++----
 .../tcg/insn_trans/trans_memory.c.inc         |  8 ++++----
 target/loongarch/tcg/op_helper.c              | 20 +++++++++++++++++++
 4 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
index e76c73c775..7ee655b027 100644
--- a/target/loongarch/tcg/helper.h
+++ b/target/loongarch/tcg/helper.h
@@ -7,6 +7,8 @@ DEF_HELPER_2(raise_exception, noreturn, env, i32)
 
 DEF_HELPER_FLAGS_3(asrtle_d, TCG_CALL_NO_WG, void, env, tl, tl)
 DEF_HELPER_FLAGS_3(asrtgt_d, TCG_CALL_NO_WG, void, env, tl, tl)
+DEF_HELPER_FLAGS_3(asrtle_du, TCG_CALL_NO_WG, void, env, tl, tl)
+DEF_HELPER_FLAGS_3(asrtgt_du, TCG_CALL_NO_WG, void, env, tl, tl)
 
 DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, tl, tl, tl, tl)
 DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, tl, tl, tl, tl)
diff --git a/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc b/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc
index 628b33330b..9ad90f4379 100644
--- a/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc
@@ -81,7 +81,7 @@ static bool gen_fload_gt(DisasContext *ctx, arg_frr *a, MemOp mop)
 
     CHECK_FPE;
 
-    gen_helper_asrtgt_d(tcg_env, src1, src2);
+    gen_helper_asrtgt_du(tcg_env, src1, src2);
     addr = make_address_i(ctx, src1, 0);
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     maybe_nanbox_load(dest, mop);
@@ -99,7 +99,7 @@ static bool gen_fstore_gt(DisasContext *ctx, arg_frr *a, MemOp mop)
 
     CHECK_FPE;
 
-    gen_helper_asrtgt_d(tcg_env, src1, src2);
+    gen_helper_asrtgt_du(tcg_env, src1, src2);
     addr = make_address_i(ctx, src1, 0);
     tcg_gen_qemu_st_tl(src3, addr, ctx->mem_idx, mop);
 
@@ -115,7 +115,7 @@ static bool gen_fload_le(DisasContext *ctx, arg_frr *a, MemOp mop)
 
     CHECK_FPE;
 
-    gen_helper_asrtle_d(tcg_env, src1, src2);
+    gen_helper_asrtle_du(tcg_env, src1, src2);
     addr = make_address_i(ctx, src1, 0);
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     maybe_nanbox_load(dest, mop);
@@ -133,7 +133,7 @@ static bool gen_fstore_le(DisasContext *ctx, arg_frr *a, MemOp mop)
 
     CHECK_FPE;
 
-    gen_helper_asrtle_d(tcg_env, src1, src2);
+    gen_helper_asrtle_du(tcg_env, src1, src2);
     addr = make_address_i(ctx, src1, 0);
     tcg_gen_qemu_st_tl(src3, addr, ctx->mem_idx, mop);
 
diff --git a/target/loongarch/tcg/insn_trans/trans_memory.c.inc b/target/loongarch/tcg/insn_trans/trans_memory.c.inc
index dcecf02e54..ae2a0dbf30 100644
--- a/target/loongarch/tcg/insn_trans/trans_memory.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_memory.c.inc
@@ -79,7 +79,7 @@ static bool gen_load_gt(DisasContext *ctx, arg_rrr *a, MemOp mop)
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
 
-    gen_helper_asrtgt_d(tcg_env, src1, src2);
+    gen_helper_asrtgt_du(tcg_env, src1, src2);
     src1 = make_address_i(ctx, src1, 0);
     tcg_gen_qemu_ld_tl(dest, src1, ctx->mem_idx, mop);
     gen_set_gpr(a->rd, dest, EXT_NONE);
@@ -93,7 +93,7 @@ static bool gen_load_le(DisasContext *ctx, arg_rrr *a, MemOp mop)
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
 
-    gen_helper_asrtle_d(tcg_env, src1, src2);
+    gen_helper_asrtle_du(tcg_env, src1, src2);
     src1 = make_address_i(ctx, src1, 0);
     tcg_gen_qemu_ld_tl(dest, src1, ctx->mem_idx, mop);
     gen_set_gpr(a->rd, dest, EXT_NONE);
@@ -107,7 +107,7 @@ static bool gen_store_gt(DisasContext *ctx, arg_rrr *a, MemOp mop)
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
 
-    gen_helper_asrtgt_d(tcg_env, src1, src2);
+    gen_helper_asrtgt_du(tcg_env, src1, src2);
     src1 = make_address_i(ctx, src1, 0);
     tcg_gen_qemu_st_tl(data, src1, ctx->mem_idx, mop);
 
@@ -120,7 +120,7 @@ static bool gen_store_le(DisasContext *ctx, arg_rrr *a, MemOp mop)
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
 
-    gen_helper_asrtle_d(tcg_env, src1, src2);
+    gen_helper_asrtle_du(tcg_env, src1, src2);
     src1 = make_address_i(ctx, src1, 0);
     tcg_gen_qemu_st_tl(data, src1, ctx->mem_idx, mop);
 
diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
index 44772d03a4..25ed328753 100644
--- a/target/loongarch/tcg/op_helper.c
+++ b/target/loongarch/tcg/op_helper.c
@@ -43,6 +43,26 @@ void HELPER(asrtgt_d)(CPULoongArchState *env, target_ulong rj, target_ulong rk)
     }
 }
 
+void HELPER(asrtle_du)(CPULoongArchState *env, target_ulong rj, target_ulong rk)
+{
+    CPUSysState *sys = env_sys(env);
+
+    if (rj > rk) {
+        sys->CSR_BADV = rj;
+        do_raise_exception(env, EXCCODE_BCE, GETPC());
+    }
+}
+
+void HELPER(asrtgt_du)(CPULoongArchState *env, target_ulong rj, target_ulong rk)
+{
+    CPUSysState *sys = env_sys(env);
+
+    if (rj <= rk) {
+        sys->CSR_BADV = rj;
+        do_raise_exception(env, EXCCODE_BCE, GETPC());
+    }
+}
+
 target_ulong HELPER(crc32)(target_ulong val, target_ulong m, uint64_t sz)
 {
     uint8_t buf[8];
-- 
2.54.0


