Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206B4606A326
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Umoh8MwF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJX7p-00033e-PQ; Wed, 21 Oct 2026 10:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX7n-00033M-MM
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:03 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX7l-0001TS-MN
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:03 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a1e477fe16so4792815e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592220; x=1793197020; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Hk/FL8DuTtkfbbgkPiGPU0Sf9WZy/mlE9ULa3yiVabc=;
 b=Umoh8MwFbOZp+h2RleYE3Hfba02L1ayR3Vaq7pcFCfAmP9xbfY/YYdyxn0hL3BXp5+
 oLVu0S7YWailjyBbgW20nS/zUcnAV9jO8o8zKhAyZa3J5h7a/vfhaQjGEdPrJV6W9RWr
 Ah6KWotYgLnrTxAyXZMjzUM6IwB8Yph/ofOpfBDUvOcO1YMPSps9PXSY6lfHud8hPwUp
 h/5rc4xuicd89uInJuLv2PTAsndy21z+6ExBvTv8xTKByAwKF5TLsyOp4G9Z7Gl4AqHL
 +jr3y3XxuKOWEewEzY8EAtkPDGGq4vMSxw93dWAIXU9us84MSEJrmdN0EX2gh9DVqJUs
 5HKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592220; x=1793197020;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Hk/FL8DuTtkfbbgkPiGPU0Sf9WZy/mlE9ULa3yiVabc=;
 b=nraojc5VB9TVUoq99+FI5VuMvFikyEZG3A/6JCO6JMKAmjp1aluyxIlJIZhzfqfQgz
 AB776yAOGXqEwZK9X7rmmF12f86FHPD5yifmzNRXwLXMexr7RHria+zNmwKlYGx+YdJF
 EXeFZdV6c3+cdyXKypp9bGJ0zuqVVJnuVw4/dP/yE/2fAPu0uMg6336Bq1CT6LF5tAyV
 5EtuEayejyfqonjCnygygv3+Nbzroz3Q4AYV3ehrM8S9tUyEhaFv6fzVXE6NbUyHK8tA
 BUJQ9axh4KHqRlyA/uayEF325hSHghBj4D+Ic84f8tUpSxzWhDn77swJ3cRif4GUtSOQ
 aRzA==
X-Gm-Message-State: AFq9FYLwRiffpDn18+3aw/16PC4GBx+x828l1YrCDCiDBSC1Oqpj4FbS
 1POLY5+aUkSVoDwjK1snweRk7ZIrtfrto4ElwQnDa3VgbxsVkGMNi8Ui3LUQid1s6IRwHqgRHEC
 gRrfqaas=
X-Gm-Gg: AYBFou3GXh8JaZazyybCFmG48cjgulTuKFqO2gt7VpVpOUDwvcICc9XezAbRHlQbuNp
 Cc6IvS20QIBygdXUop2bSLhSvy3U9a7hjE1Aw1Z2hUWp/WEjMPgexmsdIU/RnqdXngEJu4dYwoY
 jYLONqLSIRi0nmQuQEPLptTivHRKUgM1QG/quLh9VP3I0QGGWSG+/gIkl+6O2+F0e3CTSVf0JMV
 T5+NT96HecjQqtLeDlOXA3qwqZ+ixzE6YPKYeXkdzBjJ2OXoQIr+P/JiZFWJRmLplOTnEOllAkb
 55LkUjx/EVr6fS613YeaVtzZQL90hmEG0ZJPgdrHnPekEN1DeVo7UPlhj78oX4zx4AkOMNAqZUF
 jDbC0W1JeoOkrxuAHRusQ+lX2UQ7Aga0LEEPYJGezGBnxXpOHq2xLqNDGJWWBjwjRxLGcfCyJV5
 VXjOlRa16RqWDq5lVIMmLnLHP0YHs0upmNWSZsQlgjrOXyny07B2jwfboB29Kz93dNhqfSwCdsX
 13NRbVxzCFmQYwy42ujGbypV59EP/JsTSDQLYmJP5osrqtF8YH/nhyCy0myznfB86S2wNAtH0Sk
 W86Q8KH+w25xalCE5HaIkd6b3cQ=
X-Received: by 2002:a05:600c:8012:b0:4a1:a39b:e75b with SMTP id
 5b1f17b1804b1-4a1fdd2434cmr47142445e9.21.1792592219903; 
 Wed, 21 Oct 2026 07:16:59 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:16:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 002/100] tcg: Annontate functions in tcg.h with
 QEMU_*_NONNULL
Date: Wed, 21 Oct 2026 16:15:14 +0200
Message-ID: <20261021141652.363109-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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


