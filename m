Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9303CA6019
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 14:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFBK7-00044G-KZ; Fri, 09 Oct 2026 10:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1xFBGs-0003TD-9b
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 10:08:31 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1xFBGm-0007zC-B3
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 10:08:25 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5bcb2eceb3eso505388e87.0
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 07:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791554898; x=1792159698; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9MWlePecrx9LZo7UifxQd1oGav0EgMKJo7fKfwDqlJ8=;
 b=pxolG/VsXAziuz1+PBle9qlsvwVtqXdYdhxSbzykV+6FwkbbW4BXdDU8md72RI2rnU
 rbKSAbod7mo8B7b20YAfzn5VEYV62vEXu+pTKazHR19wc3z3GwwRurrOHFKH+OLU08Fb
 vaUDMEirjl/eu8r0w2rNPsPQp1eaYar1lb+NTOLxSWqOppHy0QPPvO8MWX3DOUkTotxp
 IY+G1N/EaQzhU08As13KTuMoQwfIddjWyFcJ7p2Rvw27bUt2tzn2ng7208A5RKD+/MxC
 uJXipLQHQjOp05Wxlsy4rrIr4I2a75Wu3ipPK6OtKTXJt9289yfSV3K4XZj1QH6iwy9r
 QHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791554898; x=1792159698;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9MWlePecrx9LZo7UifxQd1oGav0EgMKJo7fKfwDqlJ8=;
 b=A6naKPrlASD7YCTHNj4lV7icVpH5SEfRzQ1ivgivt25zP+WC2TEkpG+Vp881w0OWp/
 UAPJavQuHPbN1nvIUXVa003WoJW/ZVplxPgS0lh7zaJcUb/aH/aDh3xPFL+rnu56KRYl
 zkIjygqDWAXnGGDG1ZEue/v6h7+8btLPe9ipu/iQ3YbfyDqN8kMUlJMNA1NlRplKxsDx
 jz6qEYmw3gz8APxjMII5MfTgvjBj8M/7iZNGcRxMj0YNMimCB/1RCMzXJrs/JQ16lTKT
 SBxYIK8zWRhhDUJeFu0sZXLgDBkbqAQo4MDb2p+OP2gDS8t5sj2RBD4rqWJElaJa7IuD
 Z3YA==
X-Gm-Message-State: AFq9FYILxtWvXt5YazCcHr1jSVfCVG2JQrLFmc/rwdJx+TKCo7m551jQ
 3fCcb0kp+KTcNAiQl4GdKeAKGM1g2m6z0cR+Mf8syWW2+9NfrtVBFvYLvVypWEjzdjk=
X-Gm-Gg: AYBFou3kwWJGs+0+/2Dfk11oWMR9T3IRHTvn2y+i0MdCkHitnGGAXUG1MayRkVarbWl
 zMy3WifgN7Msu4BIOWKee1uyKE3dMNhYxNQ+A33ODahtCHlPy+x5hd+Mc2Trmnmk91NJlFoYL6P
 XbLgYK+TKdK05dpBqilYmefdVUQ/ZKBvAdDG8ESeb2AxVjWNJksgzo/GZBXBmwzpVdL12WYn9/X
 KjB40jrpLRv8zDqnJiMRa6FMvQ6thpTsWzfD0+U2lGE1KUpq/FmbbeQTRiXVSdWkmBRL/graBJ4
 HjoHjPzzSkDJNk9D1pk7JQldksmT0eOCbGRhgEDOlZ3LhBIeMb/3jbJc/UAOXzva4ITIj/YSjtH
 MDjnk3IFBUr1sbFJTAPp7UlIFbAIUSCu3En1C1qiiqPCMOr27r4x1GbepNrI3S6yHeX1WPnvRCi
 N6cyexE7rgTYIMkY1geVS6sMs7rL+arqrPhKXsi7NPWm8rel4MSA3+xBGTGCqHQOuFg/PqEWc+R
 9zx2bAroYzz8eGhDK33Nn1UUN8+8/N5pf2Hqg==
X-Received: by 2002:a05:6512:3d8d:b0:5b6:172a:c36e with SMTP id
 2adb3069b0e04-5bcde3582bfmr715221e87.8.1791554898277; 
 Fri, 09 Oct 2026 07:08:18 -0700 (PDT)
Received: from localhost (broadband-5-228-114-10.ip.moscow.rt.ru.
 [5.228.114.10]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcddebc900sm656664e87.69.2026.10.09.07.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 07:08:17 -0700 (PDT)
From: Konstantin Semichastnov <antikostya2@gmail.com>
Date: Fri, 09 Oct 2026 17:03:04 +0300
Subject: [PATCH 3/6] hw/riscv/ntrace: do not use gen_updiscon to gen
 IndirectBranch message
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-upstream-ntrace_filter-v1-3-8f061c9b24da@gmail.com>
References: <20261009-upstream-ntrace_filter-v1-0-8f061c9b24da@gmail.com>
In-Reply-To: <20261009-upstream-ntrace_filter-v1-0-8f061c9b24da@gmail.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Alexei Filippov <halip0503@gmail.com>, 
 Grigoriy Bereznyakov <gregoriy93.gb@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7955; i=antikostya2@gmail.com; 
 h=from:subject:message-id;
 bh=lqHuEKvKTq4MTvSOUlNDACwTXLoA9TplPIssPbZSIcs=; 
 b=owEBbQKS/ZANAwAKAUiKpW6lUN52AcsmYgBqyPQWtY9q/LnOwavImmphd7hbjygXHIPJ8ZxML
 UgegELHpgKJAjMEAAEKAB0WIQRMBWLx2o+linEPEBhIiqVupVDedgUCasj0FgAKCRBIiqVupVDe
 dvPyD/9pF3dRyPuYvCdpmenJ9nb9YrLzzi9I7BWEqD7ElhSuDts5ixR3gyHRifUBAzTh0SJgHUH
 oF7c/1W7CEFF5+c22moGyI6nr4sPG8QnrcoKw/UKHflYSXdGGwfRlc0pXOHrR/3XQS2usDaPEdY
 9HTh/tbKGftfu1AgREC8CJzKMNbqY6mGWn3sEx7kNmhqzjTUgEmf7bvViQQuI8aXapv90S5nU3z
 WfgF7BQwVFNIP2FxKFuFmgThPLsmtI2673dPtTsOOTQPDR5BUIGLWWs7YSuPP9pNGTPztSeqyra
 IH4YOQJUbOxJ92/taPbCdDjbuhuA6+JViXdPM4fbgU2gAtYIUYR4a2YWXK92UZ/cTQUdO7CN8pz
 BhfzfDtfhrnxHIul9xDY1cGkFjT//uM4HskvIL3OTuE7AOWGOqBIUFHNZIjQf0AyE4pNRSd+Mwc
 asOkMxZgsiX1FmhtsGKk56PMnxyrcs3Q+fk0nZWkIjL0dYJxPrbVi8LjJLdRfiD/vHIX53Ymgqc
 PjChfJIJgiyuDms+oUOsW/JbVO2SVEuoC5uJsEP2xNKLlyOQ06m/HxTVvQrS0HTHHPmaBWKXJLH
 70QWyxTFfwzMTF+PBZYQQhhFgyVzLzpQH/iUFktSVcjYxaYnsB32C3/g1a3UMTnYJR6yvjtQM8X
 8OFhdf/SuRluleA==
X-Developer-Key: i=antikostya2@gmail.com; a=openpgp;
 fpr=4C0562F1DA8FA58A710F1018488AA56EA550DE76
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=antikostya2@gmail.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

According to Table 3 RISCV Ntrace Spec 1.0 IndirectBranch messages
should be emitted on next ingress port cycle, cz we can't know target pc
earlier.
So, lets generate indirectBranchHist on next instruction after indirect
branch will happened. Also, we should aply same rule to all interrupt,
exceptions, mret, sret instructuion. So, we can't use gen_updiscon as we
would generate two messages instead of 1.
So, we will create separate helper to deal with indirectBranchHist.

Signed-off-by: Alexei Filippov <halip0503@gmail.com>
---
 hw/riscv/trace-encoder.c                | 20 ++++++++++++++------
 hw/riscv/trace-encoder.h                | 18 ++++++++++++------
 target/riscv/helper.h                   |  1 +
 target/riscv/insn_trans/trans_rvi.c.inc |  1 +
 target/riscv/op_helper.c                |  2 ++
 target/riscv/trace_helper.c             | 27 +++++++++++++++++++++++----
 target/riscv/translate.c                | 10 ++++++++++
 7 files changed, 63 insertions(+), 16 deletions(-)

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index 50d971336b..cfe6d5f7c8 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -771,7 +771,15 @@ void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
     uint8_t msg_size;
     bool is_branch_taken;
 
-    g_assert(!trencoder->ntrace);
+    if (trencoder->ntrace) {
+        trencoder_send_indirect_branch_hist(
+                trencoder,
+                trencoder->pending_branch_trace.source_pc,
+                get_inst_len_at(trencoder->pending_branch_trace.source_pc),
+                trencoder->pending_branch_trace.target_pc,
+                trencoder->pending_branch_trace.type);
+        return;
+    }
 
     if (trencoder->updiscon_pending) {
         trencoder_send_updiscon(trencoder, pc);
@@ -942,11 +950,11 @@ void trencoder_trace_trap_insn(Object *trencoder_obj, uint64_t curr_pc,
     uint8_t msg_size;
 
     if (trencoder->ntrace) {
-        uint32_t curr_inst_len = get_inst_len_at(curr_pc);
-        uint32_t btype = is_interrupt ? BTYPE_INTERRUPT : BTYPE_EXCEPTION;
-
-        trencoder_send_indirect_branch_hist(trencoder, curr_pc, curr_inst_len,
-                                            target_pc, btype);
+        trencoder->pending_branch_trace.type = is_interrupt ? BTYPE_INTERRUPT :
+                                                              BTYPE_EXCEPTION;
+        trencoder->pending_branch_trace.source_pc = curr_pc;
+        trencoder->pending_branch_trace.target_pc = target_pc;
+        trencoder->trace_next_insn = true;
         return;
     }
 
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
index 9d2f1c162e..cb792a6c46 100644
--- a/hw/riscv/trace-encoder.h
+++ b/hw/riscv/trace-encoder.h
@@ -16,6 +16,17 @@
 #include "cpu.h"
 
 #define TRACE_R_MAX (0xFFF / 4)
+typedef enum {
+    BTYPE_CONTROL_FLOW = 0,
+    BTYPE_EXCEPTION    = 2,
+    BTYPE_INTERRUPT    = 3,
+} TraceBranchType;
+
+typedef struct NtraceIndirectBranch {
+    TraceBranchType type;
+    hwaddr source_pc;
+    hwaddr target_pc;
+} NtraceIndirectBranch;
 
 struct TraceEncoder {
     /*< private >*/
@@ -50,6 +61,7 @@ struct TraceEncoder {
     uint64_t last_addr_reported;
     uint64_t last_icnt_reset;
     uint64_t icnt_accumulated;
+    NtraceIndirectBranch pending_branch_trace;
 
     uint64_t sync_cnt;
 };
@@ -60,12 +72,6 @@ typedef enum {
     BRANCH_TAKEN_UNCONDITIONAL = 2,
 } TraceBranchRes;
 
-typedef enum {
-    BTYPE_CONTROL_FLOW = 0,
-    BTYPE_EXCEPTION    = 2,
-    BTYPE_INTERRUPT    = 3,
-} TraceBranchType;
-
 typedef enum {
     CORRELATION_TRACE_DISABLED = 4,
 } TraceStopReason;
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index dcf2b74cb6..056a8abcf9 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -133,6 +133,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
 DEF_HELPER_2(trace_insn, void, env, i64)
 DEF_HELPER_3(trace_updiscon, void, env, tl, tl)
 DEF_HELPER_5(trace_branch, void, env, tl, tl, tl, int)
+DEF_HELPER_3(trace_indirect_branch, void, env, tl, tl)
 
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(sret, tl, env)
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 06fba108a8..cf8dc4a5f4 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -184,6 +184,7 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
     }
 
     gen_trace_updiscon(ctx);
+    gen_trace_indirect_branch(ctx, target_pc);
 
     lookup_and_goto_ptr(ctx);
 
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 12fb0209f6..ded6d79193 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -354,6 +354,7 @@ target_ulong helper_sret(CPURISCVState *env)
     }
 
     trencoder_trace_priv_change(cpu->trencoder, env->pc, prev_priv);
+    helper_trace_indirect_branch(env, env->pc, retpc);
     riscv_cpu_set_mode(env, prev_priv, prev_virt);
 
     /*
@@ -444,6 +445,7 @@ target_ulong helper_mret(CPURISCVState *env)
     }
 
     trencoder_trace_priv_change(cpu->trencoder, env->pc, prev_priv);
+    helper_trace_indirect_branch(env, env->pc, retpc);
     riscv_cpu_set_mode(env, prev_priv, prev_virt);
     /*
      * If forward cfi enabled for new priv, restore elp status
diff --git a/target/riscv/trace_helper.c b/target/riscv/trace_helper.c
index d7763a998f..af36c01a02 100644
--- a/target/riscv/trace_helper.c
+++ b/target/riscv/trace_helper.c
@@ -35,10 +35,7 @@ void helper_trace_updiscon(CPURISCVState *env, target_ulong curr_pc,
     RISCVCPU *cpu = env_archcpu(env);
     TraceEncoder *te = TRACE_ENCODER(cpu->trencoder);
 
-    if (te->ntrace) {
-        trencoder_send_indirect_branch_hist(te, curr_pc, curr_inst_len, env->pc,
-                                            BTYPE_CONTROL_FLOW);
-    } else {
+    if (!te->ntrace) {
         te->updiscon_pending = true;
         te->trace_next_insn = true;
     }
@@ -51,6 +48,21 @@ void helper_trace_branch(CPURISCVState *env, target_ulong pc,
 
     trencoder_report_branch(cpu->trencoder, pc, insn_len, offset, taken);
 }
+
+void helper_trace_indirect_branch(CPURISCVState *env, target_ulong curr_pc,
+                                  target_ulong target_pc)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+    TraceEncoder *te = TRACE_ENCODER(cpu->trencoder);
+
+    if (te->ntrace) {
+            te->pending_branch_trace.target_pc = target_pc;
+            te->pending_branch_trace.source_pc = curr_pc;
+            te->pending_branch_trace.type = BTYPE_CONTROL_FLOW;
+            te->trace_next_insn = true;
+    }
+}
+
 #else /* #ifndef CONFIG_USER_ONLY */
 void helper_trace_insn(CPURISCVState *env, uint64_t pc)
 {
@@ -68,4 +80,11 @@ void helper_trace_branch(CPURISCVState *env, target_ulong pc,
 {
     return;
 }
+
+void helper_trace_indirect_branch(CPURISCVState *env, hwaddr curr_pc,
+                                  hwaddr target_pc)
+{
+    return;
+}
+
 #endif /* #ifndef CONFIG_USER_ONLY*/
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 781068ad84..3496c2a3d5 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -628,6 +628,16 @@ static void gen_trace_updiscon(DisasContext *ctx)
     gen_set_label(skip);
 }
 
+static void gen_trace_indirect_branch(DisasContext *ctx, TCGv target_pc)
+{
+    TCGLabel *skip = gen_new_label();
+    TCGv curr_pc = tcg_constant_tl(ctx->base.pc_next);
+
+    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_trace_running, 0, skip);
+    gen_helper_trace_indirect_branch(tcg_env, curr_pc, target_pc);
+    gen_set_label(skip);
+}
+
 static void gen_trace_branch(int taken, target_ulong imm, target_ulong cur_insn_len)
 {
     TCGLabel *skip = gen_new_label();

-- 
2.43.0


