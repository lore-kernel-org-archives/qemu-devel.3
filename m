Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76196606A31F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMPjY-00026L-QY; Thu, 29 Oct 2026 08:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xMPjO-000257-TS
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 08:59:48 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xMPjL-0004GJ-Bb
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 08:59:46 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8AxHNI7Q+Nqh3UaAA--.11561S3;
 Thu, 29 Oct 2026 20:59:39 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJCx9cw6Q+NqsDwxAA--.9638S3;
 Thu, 29 Oct 2026 20:59:39 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH 1/2] target/loongarch: Add asrtle_du()/asrtgt_du() helpers
Date: Thu, 29 Oct 2026 21:01:08 +0800
Message-ID: <20261029130109.185509-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261029130109.185509-1-maobibo@loongson.cn>
References: <20261029130109.185509-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCx9cw6Q+NqsDwxAA--.9638S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj97XoW5Ar4xZrW8WrWDAw47JF4fp5X_AFW8toW0kF
 4UGwn3Gr1SkFnYkrs3Xw1xXF909rZ7A3sFk3Z5ua1xXry5KFyUAws8Za1xJFZagrykXa4I
 ga4DJas3Zr9rl-sFpf9Il3svdjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf9Il3
 svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIY
 CTnIWjp_UUUY87kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcI
 k0rVWrJVCq3wAFIxvE14AKwVWUAVWUZwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
 021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
 4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAF
 wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
 AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
 r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
 IIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
 w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
 0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8SksDUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index b863ba1dc2..b050436a77 100644
--- a/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc
@@ -81,7 +81,7 @@ static bool gen_fload_gt(DisasContext *ctx, arg_frr *a, MemOp mop)
 
     CHECK_FPE;
 
-    gen_helper_asrtgt_d(tcg_env, src1, src2);
+    gen_helper_asrtgt_du(tcg_env, src1, src2);
     addr = make_address_x(ctx, src1, src2);
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     maybe_nanbox_load(dest, mop);
@@ -99,7 +99,7 @@ static bool gen_fstore_gt(DisasContext *ctx, arg_frr *a, MemOp mop)
 
     CHECK_FPE;
 
-    gen_helper_asrtgt_d(tcg_env, src1, src2);
+    gen_helper_asrtgt_du(tcg_env, src1, src2);
     addr = make_address_x(ctx, src1, src2);
     tcg_gen_qemu_st_tl(src3, addr, ctx->mem_idx, mop);
 
@@ -115,7 +115,7 @@ static bool gen_fload_le(DisasContext *ctx, arg_frr *a, MemOp mop)
 
     CHECK_FPE;
 
-    gen_helper_asrtle_d(tcg_env, src1, src2);
+    gen_helper_asrtle_du(tcg_env, src1, src2);
     addr = make_address_x(ctx, src1, src2);
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     maybe_nanbox_load(dest, mop);
@@ -133,7 +133,7 @@ static bool gen_fstore_le(DisasContext *ctx, arg_frr *a, MemOp mop)
 
     CHECK_FPE;
 
-    gen_helper_asrtle_d(tcg_env, src1, src2);
+    gen_helper_asrtle_du(tcg_env, src1, src2);
     addr = make_address_x(ctx, src1, src2);
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


