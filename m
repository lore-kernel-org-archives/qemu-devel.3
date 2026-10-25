Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522B8606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bdFAU4jn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsVx-00069d-JF; Sun, 25 Oct 2026 03:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsVq-00069E-H6
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:26 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsVo-0003fF-DC
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:26 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so1737726f8f.2
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912762; x=1793517562; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=17VwI6+W/lOAyjthWBMqegzhHFG1dp9dNE7TOU5pG5U=;
 b=bdFAU4jnYJMMmteZr2DDQ85vBd/6uMDdCrD9iScdcGROzEj/Wz+IxFY7HiBkoozus3
 Ax/IceUW87yZUdNeE4azdjzZo2BR40J1HtlR1Rz6E3RZHTweIPAsqfbYk9PA3J6CkCgb
 0SPg8fVY7nz1mVSbeQ1TvF4O7KUf8YXks/BHRZZGjE9S10sVNNvD6c6ijR8u5vwld6PF
 Ok4muFyJ5yBvlReOfPF4OYAcpoIdVjAE0gXREAb3hJp6rfpM/Riqd2hdmgC0+ekwaaiV
 ryAdGX2IBffPVU1Kb8exgszutRXj3bETSS8EEbQnqrXBjyUPcUUdjI+cNviFltigSFvx
 sJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912762; x=1793517562;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=17VwI6+W/lOAyjthWBMqegzhHFG1dp9dNE7TOU5pG5U=;
 b=b2Shgd1Wi35fa8d76HBa1HK3oqDa7v0FzeGWm4xFAyVA4+TGTM1uQR9/L45DjQoGFo
 Sn8EnFb3Y1UBlaU2IqdDbBDUBJZGPMBcPO421NTeSCSqLolcau2RKLkYOAn6Blq59Kdx
 Oz+59i+XRSnPyngbmMyzvSF0P9yZF1HdLl5SGJM1KJP3ZbRMdlZNGMNzld/AJ46sv2fZ
 CAZGpeT32s14HZAme9ovnHTT7E744H9XAmhB+z9NgR0SaBzJkCyzI+O96sG3W2sbHHUw
 CacVYJiMiAKgC1NTYtqlJblS7T84UJTJl7+umUuHqti8OvB8wON5z5QqFGnsAj0NhSFj
 KmJw==
X-Gm-Message-State: AFq9FYJugAlq8ufTKao+FQ+eUyejztC9OIefVaEPhkcNfe9ZA29jz1eM
 ZJTamiAWWW52z9/Vh+p7Hzv2p8eMX4qivsLkW6Qh6I1bMmE3ucJzsxDSvK1LYdXY3kLbrP9F5RZ
 U/sDGgQ0=
X-Gm-Gg: AYBFou0b9Ye+TjNM0AsD9rv0SrEip2MC7LCCu2W3KMKtpfA+PRPFeTYRzYX1/K04rak
 HzyRLb8LDqP+qyvAi6p9ySh0kBtJ4iM+lyRLIQa8pE4BlS/fA3nxtKmARe52LDTzaoRJsxFn/z3
 PD6tp7vQl5O+RRNyAWf9vPKtYVqKg5zJv6O6zyotUC0dCr/TXQp1gGXS+CWpfchaHDbzwkKP727
 3HfgfeI77QgM4zbfRCM9ZrFhU6azDAH0crI5iVF3T3oFVYae0W0Pyns7fbhPhWC15/IFVbw5O2t
 Uo4HJbMlLAz1Z4tyFLdnfCajgA99QufhoCWxo/JJZwJH+kKsfLTaSDKLCXbW5FPhT8jK6QU5F1n
 pwXOnc00nH530m0CybrDwZAd2/X9OnBaU1nuVFlqlcGmqd4EQ754893IFlLnd4AQlhwvH6zzzC9
 6jz3w2SRvdbpKVgZ0kJJrH7vAvDJDatEVOhB5W4Zd4J1joUVE/yOedVP3fgpkVCTw3MBrOSe+CG
 HX1PPnzmyuTyCbEXDPbEbq6aiPP1rTZql3DodpwYlZB0fZXksyeLYGK/Q==
X-Received: by 2002:a05:6000:4202:b0:48d:ff71:dd87 with SMTP id
 ffacd0b85a97d-48e3eb9a3bamr5956251f8f.17.1792912762378; 
 Sun, 25 Oct 2026 00:19:22 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 002/100] tcg: Annotate functions in tcg.h with QEMU_*_NONNULL
Date: Sun, 25 Oct 2026 08:17:37 +0100
Message-ID: <20261025071915.1123867-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h | 58 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 2e00518934..e131345170 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -489,9 +489,10 @@ static inline TCGTemp *arg_temp(TCGArg a)
 }
 
 #ifdef CONFIG_DEBUG_TCG
-size_t temp_idx(TCGTemp *ts);
-TCGTemp *tcgv_i32_temp(TCGv_i32 v);
+QEMU_ARG_NONNULL size_t temp_idx(TCGTemp *ts);
+QEMU_RET_ARG_NONNULL TCGTemp *tcgv_i32_temp(TCGv_i32 v);
 #else
+QEMU_ARG_NONNULL
 static inline size_t temp_idx(TCGTemp *ts)
 {
     return ts - tcg_ctx->temps;
@@ -502,104 +503,124 @@ static inline size_t temp_idx(TCGTemp *ts)
  * its index means that we don't use 0.  That leaves offset 0 free for
  * a NULL representation without having to leave index 0 unused.
  */
+QEMU_RET_ARG_NONNULL
 static inline TCGTemp *tcgv_i32_temp(TCGv_i32 v)
 {
     return (void *)tcg_ctx + (uintptr_t)v;
 }
 #endif
 
+QEMU_RET_ARG_NONNULL
 static inline TCGTemp *tcgv_i64_temp(TCGv_i64 v)
 {
     return tcgv_i32_temp((TCGv_i32)v);
 }
 
+QEMU_RET_ARG_NONNULL
 static inline TCGTemp *tcgv_i128_temp(TCGv_i128 v)
 {
     return tcgv_i32_temp((TCGv_i32)v);
 }
 
+QEMU_RET_ARG_NONNULL
 static inline TCGTemp *tcgv_ptr_temp(TCGv_ptr v)
 {
     return tcgv_i32_temp((TCGv_i32)v);
 }
 
+QEMU_RET_ARG_NONNULL
 static inline TCGTemp *tcgv_vec_temp(TCGv_vec v)
 {
     return tcgv_i32_temp((TCGv_i32)v);
 }
 
+QEMU_ARG_NONNULL
 static inline TCGArg tcgv_i32_arg(TCGv_i32 v)
 {
     return temp_arg(tcgv_i32_temp(v));
 }
 
+QEMU_ARG_NONNULL
 static inline TCGArg tcgv_i64_arg(TCGv_i64 v)
 {
     return temp_arg(tcgv_i64_temp(v));
 }
 
+QEMU_ARG_NONNULL
 static inline TCGArg tcgv_i128_arg(TCGv_i128 v)
 {
     return temp_arg(tcgv_i128_temp(v));
 }
 
+QEMU_ARG_NONNULL
 static inline TCGArg tcgv_ptr_arg(TCGv_ptr v)
 {
     return temp_arg(tcgv_ptr_temp(v));
 }
 
+QEMU_ARG_NONNULL
 static inline TCGArg tcgv_vec_arg(TCGv_vec v)
 {
     return temp_arg(tcgv_vec_temp(v));
 }
 
+QEMU_RET_ARG_NONNULL
 static inline TCGv_i32 temp_tcgv_i32(TCGTemp *t)
 {
     (void)temp_idx(t); /* trigger embedded assert */
     return (TCGv_i32)((void *)t - (void *)tcg_ctx);
 }
 
+QEMU_RET_ARG_NONNULL
 static inline TCGv_i64 temp_tcgv_i64(TCGTemp *t)
 {
     return (TCGv_i64)temp_tcgv_i32(t);
 }
 
+QEMU_RET_ARG_NONNULL
 static inline TCGv_i128 temp_tcgv_i128(TCGTemp *t)
 {
     return (TCGv_i128)temp_tcgv_i32(t);
 }
 
+QEMU_RET_ARG_NONNULL
 static inline TCGv_ptr temp_tcgv_ptr(TCGTemp *t)
 {
     return (TCGv_ptr)temp_tcgv_i32(t);
 }
 
+QEMU_RET_ARG_NONNULL
 static inline TCGv_vaddr temp_tcgv_vaddr(TCGTemp *t)
 {
     return (TCGv_vaddr)temp_tcgv_i32(t);
 }
 
+QEMU_RET_ARG_NONNULL
 static inline TCGv_vec temp_tcgv_vec(TCGTemp *t)
 {
     return (TCGv_vec)temp_tcgv_i32(t);
 }
 
+QEMU_ARG_NONNULL
 static inline TCGArg tcg_get_insn_param(TCGOp *op, unsigned arg)
 {
     return op->args[arg];
 }
 
+QEMU_ARG_NONNULL
 static inline void tcg_set_insn_param(TCGOp *op, unsigned arg, TCGArg v)
 {
     op->args[arg] = v;
 }
 
+QEMU_ARG_NONNULL
 static inline uint64_t tcg_get_insn_start_param(TCGOp *op, unsigned arg)
 {
     tcg_debug_assert(arg < INSN_START_WORDS);
     return tcg_get_insn_param(op, arg);
 }
 
+QEMU_ARG_NONNULL
 static inline void tcg_set_insn_start_param(TCGOp *op, unsigned arg, uint64_t v)
 {
     tcg_debug_assert(arg < INSN_START_WORDS);
@@ -628,9 +649,9 @@ static inline bool tcg_op_buf_full(void)
 /* pool based memory allocation */
 
 /* user-mode: mmap_lock must be held for tcg_malloc_internal. */
-void *tcg_malloc_internal(TCGContext *s, int size);
-void tcg_pool_reset(TCGContext *s);
-TranslationBlock *tcg_tb_alloc(TCGContext *s);
+QEMU_RET_ARG_NONNULL void *tcg_malloc_internal(TCGContext *s, int size);
+QEMU_ARG_NONNULL void tcg_pool_reset(TCGContext *s);
+QEMU_ARG_NONNULL TranslationBlock *tcg_tb_alloc(TCGContext *s);
 
 void tcg_region_reset_all(void);
 
@@ -643,7 +664,7 @@ size_t tcg_code_capacity(void);
  *
  * Insert @tb into the region trees.
  */
-void tcg_tb_insert(TranslationBlock *tb);
+QEMU_ARG_NONNULL void tcg_tb_insert(TranslationBlock *tb);
 
 /**
  * tcg_tb_remove:
@@ -651,7 +672,7 @@ void tcg_tb_insert(TranslationBlock *tb);
  *
  * Remove @tb from the region trees.
  */
-void tcg_tb_remove(TranslationBlock *tb);
+QEMU_ARG_NONNULL void tcg_tb_remove(TranslationBlock *tb);
 
 /**
  * tcg_tb_lookup:
@@ -685,6 +706,7 @@ void tcg_tb_foreach(GTraverseFunc func, gpointer user_data);
 size_t tcg_nb_tbs(void);
 
 /* user-mode: Called with mmap_lock held.  */
+QEMU_RET_NONNULL
 static inline void *tcg_malloc(int size)
 {
     TCGContext *s = tcg_ctx;
@@ -703,8 +725,10 @@ static inline void *tcg_malloc(int size)
     }
 }
 
+QEMU_ARG_NONNULL
 void tcg_func_start(TCGContext *s);
 
+QEMU_ARG_NONNULL
 int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start);
 
 void tb_target_set_jmp_target(const TranslationBlock *, int,
@@ -794,7 +818,10 @@ void tcg_gen_call7(void *func, TCGHelperInfo *, TCGTemp *ret,
                    TCGTemp *, TCGTemp *, TCGTemp *, TCGTemp *,
                    TCGTemp *, TCGTemp *, TCGTemp *);
 
+QEMU_RET_NONNULL
 TCGOp *tcg_emit_op(TCGOpcode opc, unsigned nargs);
+
+QEMU_ARG_NONNULL
 void tcg_op_remove(TCGContext *s, TCGOp *op);
 
 /**
@@ -805,10 +832,13 @@ void tcg_op_remove(TCGContext *s, TCGOp *op);
  * a starting point with tcg_last_op(), speculatively emit opcodes,
  * then decide whether or not to keep those opcodes after the fact.
  */
+QEMU_ARG_NONNULL
 void tcg_remove_ops_after(TCGOp *op);
 
+QEMU_ARG_NONNULL
 void tcg_optimize(TCGContext *s);
 
+QEMU_RET_NONNULL
 TCGLabel *gen_new_label(void);
 
 /**
@@ -817,7 +847,7 @@ TCGLabel *gen_new_label(void);
  *
  * Encode a label for storage in the TCG opcode stream.
  */
-
+QEMU_ARG_NONNULL
 static inline TCGArg label_arg(TCGLabel *l)
 {
     return (uintptr_t)l;
@@ -848,7 +878,7 @@ static inline TCGLabel *arg_label(TCGArg i)
  * This version relies on GCC's void pointer arithmetic to get the
  * correct result.
  */
-
+QEMU_ARG_NONNULL
 static inline ptrdiff_t tcg_ptr_byte_diff(const void *a, const void *b)
 {
     return a - b;
@@ -862,7 +892,7 @@ static inline ptrdiff_t tcg_ptr_byte_diff(const void *a, const void *b)
  * Produce a pc-relative difference, from the current code_ptr
  * to the destination address.
  */
-
+QEMU_ARG_NONNULL
 static inline ptrdiff_t tcg_pcrel_diff(TCGContext *s, const void *target)
 {
     return tcg_ptr_byte_diff(target, tcg_splitwx_to_rx(s->code_ptr));
@@ -876,6 +906,7 @@ static inline ptrdiff_t tcg_pcrel_diff(TCGContext *s, const void *target)
  * Produce a difference, from the beginning of the current TB code
  * to the destination address.
  */
+QEMU_ARG_NONNULL
 static inline ptrdiff_t tcg_tbrel_diff(TCGContext *s, const void *target)
 {
     return tcg_ptr_byte_diff(target, tcg_splitwx_to_rx(s->code_buf));
@@ -888,7 +919,7 @@ static inline ptrdiff_t tcg_tbrel_diff(TCGContext *s, const void *target)
  * Compute the current code size within the translation block.
  * This is used to fill in qemu's data structures for goto_tb.
  */
-
+QEMU_ARG_NONNULL
 static inline size_t tcg_current_code_size(TCGContext *s)
 {
     return tcg_ptr_byte_diff(s->code_ptr, s->code_buf);
@@ -946,12 +977,15 @@ static inline size_t tcg_current_code_size(TCGContext *s)
 #define TB_EXIT_REQUESTED 3
 
 #ifdef CONFIG_TCG_INTERPRETER
+QEMU_ARG_NONNULL
 uintptr_t tcg_qemu_tb_exec(CPUArchState *env, const void *tb_ptr);
 #else
-typedef uintptr_t tcg_prologue_fn(CPUArchState *env, const void *tb_ptr);
+typedef QEMU_ARG_NONNULL uintptr_t
+    tcg_prologue_fn(CPUArchState *env, const void *tb_ptr);
 extern tcg_prologue_fn *tcg_qemu_tb_exec;
 #endif
 
+QEMU_ARG_NONNULL
 void tcg_register_jit(const void *buf, size_t buf_size);
 
 /* Return zero if the tuple (opc, type, vece) is unsupportable;
-- 
2.53.0


