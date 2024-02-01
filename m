Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686B6C47DDB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 10:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVUOG-0003io-QJ; Thu, 01 Feb 2024 05:33:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rVUOF-0003iX-RE
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 05:33:51 -0500
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rVUOD-0004qx-Ie
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 05:33:51 -0500
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3637b935e80so2470745ab.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 02:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706783626; x=1707388426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qjpON3cPks6DBAlROmi6sm64J8dDNhFlT1cYucf3+UQ=;
 b=PfbIYp3Z9JM0Ba+3p6N+FQoQPqpQ/pnczv6mf5+EQKsJsP023G95SoyCuPOtrzU3Z8
 X6tTzKqviFx46T63yumKuo14oOrMdBtnAL8ysfk3rJUYnudRVh3Af4T8AIYY5/kO8SU7
 LH9/6rgCE1Fqu7sdBR2JcbPxdn7sORDO/3tSS5Fd7m+R8Yj0TVxedG0wI+q3SUyWhgVP
 Pun/rF57V9BdY5kwTz1DzZZyfB+WRxnL55SF6s+vgM3i8NK67Vc5Ivt/NidLO1S6utGS
 N1IW1Su+goIuEkTOoXchXxiNLbtcUOBLHpMyCqrDcvt5mX8TVNzrlcIYRH7wqwauTCUw
 aIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706783626; x=1707388426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qjpON3cPks6DBAlROmi6sm64J8dDNhFlT1cYucf3+UQ=;
 b=D6gbEyDdfzyf54sQdxSwK+t3TxF3pqOBSooxHnfsv8IVdEQN83SfAiVmtNV3aNaofu
 W/tcZxhWMBeGujB+1JiiefGjwVgRnEm/0CymhAb9/JM0lUFFwXTDlaLR5YcAfyvkps3H
 v6MhYrgP3SUGen/aGvrQYnJ2FYCw+R1xv+06TMk9rZbgmqAb0ci8gGRSoEVxdOHquSiP
 67YBcv1XWSEnlwhOynNBEq5fGEVgJwUuaQYisdk7ZwzAr0J6SgbcuW4eZUSeaKXjaOEe
 UqUGI9k/I6vnk5nOOzTUp+URhL3OeP65rnjT6s81j+8M7CkrIKLaLgS7/OVSyEOjb1oC
 16JA==
X-Gm-Message-State: AOJu0YwFN96OdxTjZEBWY0LjJOJeaMymLywjJJMni7YRRmxXGJt9azJd
 cDg21OQBX74gxCLweGYU/Dk9gIgFT8rLHfsBVbC6dB/mM069fECzKm5JAAJQzR0=
X-Google-Smtp-Source: AGHT+IFn4uMUn62uoHFUGjtDhsXxJjNljyW+3VU3zWSbcn2YIEWVXbjvmhmxko822Cs4Qi2JgC4zLw==
X-Received: by 2002:a05:6e02:f02:b0:363:a7dd:f05a with SMTP id
 x2-20020a056e020f0200b00363a7ddf05amr78869ilj.4.1706783626402; 
 Thu, 01 Feb 2024 02:33:46 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXK6OqsrVumSd1kshGo02qOnvfsGUJYJVIZRTYm93hEANB9X6lA0ZCNqdUe0Nq98fq2V4tM+S/SpGTUmpwdvgKnFBJetLIfjsrQHQAoIHLe5E8g174BQ49ERwGyPyoFb8yehmjIPby47nAGixEUFJe3vzh4xc6E3p2ENcw9LalISV0vMWdlaHTOYW66IfHaAhiLO75FTk7mFtaGLrc6TWza6JpQlfNGlk7arKpTGcNLPpCJ8V28ROfOgxlm5elp+57Ip/QxZsbpdOm/TZQnEIMafiIMeCv1NZaHe2UZ
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-73-169-12-54.hsd1.co.comcast.net. [73.169.12.54])
 by smtp.gmail.com with ESMTPSA id
 q3-20020a92c003000000b00361b6a1e6aasm3152089ild.87.2024.02.01.02.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 02:33:45 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 3/3] Hexagon (target/hexagon) Enable more short-circuit
 packets (HVX)
Date: Thu,  1 Feb 2024 03:33:40 -0700
Message-Id: <20240201103340.119081-4-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201103340.119081-1-ltaylorsimpson@gmail.com>
References: <20240201103340.119081-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12f;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Look for read-after-write instead of overlap of reads and writes

HVX instructions with helpers have pass-by-reference semantics, so
we check for overlaps of reads and writes within the same instruction.

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/translate.h          | 88 +++++++++++++++++++++++------
 target/hexagon/translate.c          | 58 ++-----------------
 target/hexagon/gen_analyze_funcs.py | 19 ++++---
 target/hexagon/hex_common.py        | 45 ++++++++++-----
 4 files changed, 115 insertions(+), 95 deletions(-)

diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index d5e7f49ad8..00cc2bcd63 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -50,23 +50,27 @@ typedef struct DisasContext {
     int tmp_vregs_num[VECTOR_TEMPS_MAX];
     int vreg_log[NUM_VREGS];
     int vreg_log_idx;
+    DECLARE_BITMAP(vregs_written, NUM_VREGS);
+    DECLARE_BITMAP(insn_vregs_written, NUM_VREGS);
     DECLARE_BITMAP(vregs_updated_tmp, NUM_VREGS);
     DECLARE_BITMAP(vregs_updated, NUM_VREGS);
     DECLARE_BITMAP(vregs_select, NUM_VREGS);
     DECLARE_BITMAP(predicated_future_vregs, NUM_VREGS);
     DECLARE_BITMAP(predicated_tmp_vregs, NUM_VREGS);
-    DECLARE_BITMAP(vregs_read, NUM_VREGS);
+    DECLARE_BITMAP(insn_vregs_read, NUM_VREGS);
     int qreg_log[NUM_QREGS];
     int qreg_log_idx;
-    DECLARE_BITMAP(qregs_read, NUM_QREGS);
+    DECLARE_BITMAP(qregs_written, NUM_QREGS);
+    DECLARE_BITMAP(insn_qregs_written, NUM_QREGS);
+    DECLARE_BITMAP(insn_qregs_read, NUM_QREGS);
     bool pre_commit;
     bool need_commit;
     TCGCond branch_cond;
     target_ulong branch_dest;
     bool is_tight_loop;
     bool short_circuit;
-    bool has_hvx_helper;
     bool read_after_write;
+    bool has_hvx_overlap;
     TCGv new_value[TOTAL_PER_THREAD_REGS];
     TCGv new_pred_value[NUM_PREGS];
     TCGv pred_written;
@@ -146,10 +150,25 @@ intptr_t ctx_future_vreg_off(DisasContext *ctx, int regnum,
 intptr_t ctx_tmp_vreg_off(DisasContext *ctx, int regnum,
                           int num, bool alloc_ok);
 
+static inline void ctx_start_hvx_insn(DisasContext *ctx)
+{
+    bitmap_zero(ctx->insn_vregs_written, NUM_VREGS);
+    bitmap_zero(ctx->insn_vregs_read, NUM_VREGS);
+    bitmap_zero(ctx->insn_qregs_written, NUM_QREGS);
+    bitmap_zero(ctx->insn_qregs_read, NUM_QREGS);
+}
+
 static inline void ctx_log_vreg_write(DisasContext *ctx,
                                       int rnum, VRegWriteType type,
-                                      bool is_predicated)
+                                      bool is_predicated, bool has_helper)
 {
+    if (has_helper) {
+        set_bit(rnum, ctx->insn_vregs_written);
+        if (test_bit(rnum, ctx->insn_vregs_read)) {
+            ctx->has_hvx_overlap = true;
+        }
+    }
+    set_bit(rnum, ctx->vregs_written);
     if (type != EXT_TMP) {
         if (!test_bit(rnum, ctx->vregs_updated)) {
             ctx->vreg_log[ctx->vreg_log_idx] = rnum;
@@ -175,42 +194,77 @@ static inline void ctx_log_vreg_write(DisasContext *ctx,
 
 static inline void ctx_log_vreg_write_pair(DisasContext *ctx,
                                            int rnum, VRegWriteType type,
-                                           bool is_predicated)
+                                           bool is_predicated, bool has_helper)
 {
-    ctx_log_vreg_write(ctx, rnum ^ 0, type, is_predicated);
-    ctx_log_vreg_write(ctx, rnum ^ 1, type, is_predicated);
+    ctx_log_vreg_write(ctx, rnum ^ 0, type, is_predicated, has_helper);
+    ctx_log_vreg_write(ctx, rnum ^ 1, type, is_predicated, has_helper);
 }
 
-static inline void ctx_log_vreg_read(DisasContext *ctx, int rnum)
+static inline void ctx_log_vreg_read(DisasContext *ctx, int rnum,
+                                     bool has_helper)
 {
-    set_bit(rnum, ctx->vregs_read);
+    if (has_helper) {
+        set_bit(rnum, ctx->insn_vregs_read);
+        if (test_bit(rnum, ctx->insn_vregs_written)) {
+            ctx->has_hvx_overlap = true;
+        }
+    }
+    if (test_bit(rnum, ctx->vregs_written)) {
+        ctx->read_after_write = true;
+    }
 }
 
-static inline void ctx_log_vreg_read_new(DisasContext *ctx, int rnum)
+static inline void ctx_log_vreg_read_new(DisasContext *ctx, int rnum,
+                                         bool has_helper)
 {
     g_assert(is_gather_store_insn(ctx) ||
              test_bit(rnum, ctx->vregs_updated) ||
              test_bit(rnum, ctx->vregs_select) ||
              test_bit(rnum, ctx->vregs_updated_tmp));
-    set_bit(rnum, ctx->vregs_read);
+    if (has_helper) {
+        set_bit(rnum, ctx->insn_vregs_read);
+        if (test_bit(rnum, ctx->insn_vregs_written)) {
+            ctx->has_hvx_overlap = true;
+        }
+    }
+    if (is_gather_store_insn(ctx)) {
+        ctx->read_after_write = true;
+    }
 }
 
-static inline void ctx_log_vreg_read_pair(DisasContext *ctx, int rnum)
+static inline void ctx_log_vreg_read_pair(DisasContext *ctx, int rnum,
+                                          bool has_helper)
 {
-    ctx_log_vreg_read(ctx, rnum ^ 0);
-    ctx_log_vreg_read(ctx, rnum ^ 1);
+    ctx_log_vreg_read(ctx, rnum ^ 0, has_helper);
+    ctx_log_vreg_read(ctx, rnum ^ 1, has_helper);
 }
 
 static inline void ctx_log_qreg_write(DisasContext *ctx,
-                                      int rnum)
+                                      int rnum, bool has_helper)
 {
+    if (has_helper) {
+        set_bit(rnum, ctx->insn_qregs_written);
+        if (test_bit(rnum, ctx->insn_qregs_read)) {
+            ctx->has_hvx_overlap = true;
+        }
+    }
+    set_bit(rnum, ctx->qregs_written);
     ctx->qreg_log[ctx->qreg_log_idx] = rnum;
     ctx->qreg_log_idx++;
 }
 
-static inline void ctx_log_qreg_read(DisasContext *ctx, int qnum)
+static inline void ctx_log_qreg_read(DisasContext *ctx,
+                                     int qnum, bool has_helper)
 {
-    set_bit(qnum, ctx->qregs_read);
+    if (has_helper) {
+        set_bit(qnum, ctx->insn_qregs_read);
+        if (test_bit(qnum, ctx->insn_qregs_written)) {
+            ctx->has_hvx_overlap = true;
+        }
+    }
+    if (test_bit(qnum, ctx->qregs_written)) {
+        ctx->read_after_write = true;
+    }
 }
 
 extern TCGv hex_gpr[TOTAL_PER_THREAD_REGS];
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 751ca71790..ed4b4acd1d 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -378,60 +378,10 @@ static bool need_commit(DisasContext *ctx)
         return true;
     }
 
-    if (pkt->num_insns == 1) {
-        if (pkt->pkt_has_hvx) {
-            /*
-             * The HVX instructions with generated helpers use
-             * pass-by-reference, so they need the read/write overlap
-             * check below.
-             * The HVX instructions with overrides are OK.
-             */
-            if (!ctx->has_hvx_helper) {
-                return false;
-            }
-        } else {
-            return false;
-        }
-    }
-
-    if (ctx->read_after_write) {
+    if (ctx->read_after_write || ctx->has_hvx_overlap) {
         return true;
     }
 
-    /* Check for overlap between HVX reads and writes */
-    for (int i = 0; i < ctx->vreg_log_idx; i++) {
-        int vnum = ctx->vreg_log[i];
-        if (test_bit(vnum, ctx->vregs_read)) {
-            return true;
-        }
-    }
-    if (!bitmap_empty(ctx->vregs_updated_tmp, NUM_VREGS)) {
-        int i = find_first_bit(ctx->vregs_updated_tmp, NUM_VREGS);
-        while (i < NUM_VREGS) {
-            if (test_bit(i, ctx->vregs_read)) {
-                return true;
-            }
-            i = find_next_bit(ctx->vregs_updated_tmp, NUM_VREGS, i + 1);
-        }
-    }
-    if (!bitmap_empty(ctx->vregs_select, NUM_VREGS)) {
-        int i = find_first_bit(ctx->vregs_select, NUM_VREGS);
-        while (i < NUM_VREGS) {
-            if (test_bit(i, ctx->vregs_read)) {
-                return true;
-            }
-            i = find_next_bit(ctx->vregs_select, NUM_VREGS, i + 1);
-        }
-    }
-
-    /* Check for overlap between HVX predicate reads and writes */
-    for (int i = 0; i < ctx->qreg_log_idx; i++) {
-        int qnum = ctx->qreg_log[i];
-        if (test_bit(qnum, ctx->qregs_read)) {
-            return true;
-        }
-    }
-
     return false;
 }
 
@@ -453,8 +403,8 @@ static void mark_implicit_pred_reads(DisasContext *ctx)
 static void analyze_packet(DisasContext *ctx)
 {
     Packet *pkt = ctx->pkt;
-    ctx->has_hvx_helper = false;
     ctx->read_after_write = false;
+    ctx->has_hvx_overlap = false;
     for (int i = 0; i < pkt->num_insns; i++) {
         Insn *insn = &pkt->insn[i];
         ctx->insn = insn;
@@ -485,13 +435,13 @@ static void gen_start_packet(DisasContext *ctx)
     ctx->future_vregs_idx = 0;
     ctx->tmp_vregs_idx = 0;
     ctx->vreg_log_idx = 0;
+    bitmap_zero(ctx->vregs_written, NUM_VREGS);
     bitmap_zero(ctx->vregs_updated_tmp, NUM_VREGS);
     bitmap_zero(ctx->vregs_updated, NUM_VREGS);
     bitmap_zero(ctx->vregs_select, NUM_VREGS);
     bitmap_zero(ctx->predicated_future_vregs, NUM_VREGS);
     bitmap_zero(ctx->predicated_tmp_vregs, NUM_VREGS);
-    bitmap_zero(ctx->vregs_read, NUM_VREGS);
-    bitmap_zero(ctx->qregs_read, NUM_QREGS);
+    bitmap_zero(ctx->qregs_written, NUM_QREGS);
     ctx->qreg_log_idx = 0;
     for (i = 0; i < STORES_MAX; i++) {
         ctx->store_width[i] = 0;
diff --git a/target/hexagon/gen_analyze_funcs.py b/target/hexagon/gen_analyze_funcs.py
index 890e6a3a95..81e1d9cfa3 100755
--- a/target/hexagon/gen_analyze_funcs.py
+++ b/target/hexagon/gen_analyze_funcs.py
@@ -43,6 +43,16 @@ def gen_analyze_func(f, tag, regs, imms):
     f.write("{\n")
 
     f.write("    Insn *insn G_GNUC_UNUSED = ctx->insn;\n")
+    if (hex_common.is_hvx_insn(tag)):
+        if hex_common.has_hvx_helper(tag):
+            f.write(
+                "    const bool G_GNUC_UNUSED insn_has_hvx_helper = true;\n"
+            )
+            f.write("    ctx_start_hvx_insn(ctx);\n")
+        else:
+            f.write(
+                "    const bool G_GNUC_UNUSED insn_has_hvx_helper = false;\n"
+            )
 
     ## Declare all the registers
     for regno, register in enumerate(regs):
@@ -64,15 +74,6 @@ def gen_analyze_func(f, tag, regs, imms):
         if reg.is_written():
             reg.analyze_write(f, tag, regno)
 
-    has_generated_helper = not hex_common.skip_qemu_helper(
-        tag
-    ) and not hex_common.is_idef_parser_enabled(tag)
-
-    ## Mark HVX instructions with generated helpers
-    if (has_generated_helper and
-        "A_CVI" in hex_common.attribdict[tag]):
-        f.write("    ctx->has_hvx_helper = true;\n")
-
     f.write("}\n\n")
 
 
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 33801e4bd7..9e7f613e3c 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -241,6 +241,16 @@ def is_idef_parser_enabled(tag):
     return tag in idef_parser_enabled
 
 
+def is_hvx_insn(tag):
+    return "A_CVI" in attribdict[tag]
+
+
+def has_hvx_helper(tag):
+    return (is_hvx_insn(tag) and
+            not skip_qemu_helper(tag) and
+            not is_idef_parser_enabled(tag))
+
+
 def imm_name(immlett):
     return f"{immlett}iV"
 
@@ -704,7 +714,8 @@ def analyze_write(self, f, tag, regno):
         newv = hvx_newv(tag)
         predicated = "true" if is_predicated(tag) else "false"
         f.write(code_fmt(f"""\
-            ctx_log_vreg_write(ctx, {self.reg_num}, {newv}, {predicated});
+            ctx_log_vreg_write(ctx, {self.reg_num}, {newv}, {predicated},
+                               insn_has_hvx_helper);
         """))
 
 class VRegSource(Register, Hvx, OldSource):
@@ -724,7 +735,7 @@ def helper_hvx_desc(self, f):
         """))
     def analyze_read(self, f, regno):
         f.write(code_fmt(f"""\
-            ctx_log_vreg_read(ctx, {self.reg_num});
+            ctx_log_vreg_read(ctx, {self.reg_num}, insn_has_hvx_helper);
         """))
 
 class VRegNewSource(Register, Hvx, NewSource):
@@ -741,7 +752,7 @@ def helper_hvx_desc(self, f):
         """))
     def analyze_read(self, f, regno):
         f.write(code_fmt(f"""\
-            ctx_log_vreg_read_new(ctx, {self.reg_num});
+            ctx_log_vreg_read_new(ctx, {self.reg_num}, insn_has_hvx_helper);
         """))
 
 class VRegReadWrite(Register, Hvx, ReadWrite):
@@ -767,13 +778,14 @@ def helper_hvx_desc(self, f):
         """))
     def analyze_read(self, f, regno):
         f.write(code_fmt(f"""\
-            ctx_log_vreg_read(ctx, {self.reg_num});
+            ctx_log_vreg_read(ctx, {self.reg_num}, insn_has_hvx_helper);
         """))
     def analyze_write(self, f, tag, regno):
         newv = hvx_newv(tag)
         predicated = "true" if is_predicated(tag) else "false"
         f.write(code_fmt(f"""\
-            ctx_log_vreg_write(ctx, {self.reg_num}, {newv}, {predicated});
+            ctx_log_vreg_write(ctx, {self.reg_num}, {newv}, {predicated},
+                               insn_has_hvx_helper);
         """))
 
 class VRegTmp(Register, Hvx, ReadWrite):
@@ -801,13 +813,14 @@ def helper_hvx_desc(self, f):
         """))
     def analyze_read(self, f, regno):
         f.write(code_fmt(f"""\
-            ctx_log_vreg_read(ctx, {self.reg_num});
+            ctx_log_vreg_read(ctx, {self.reg_num}, insn_has_hvx_helper);
         """))
     def analyze_write(self, f, tag, regno):
         newv = hvx_newv(tag)
         predicated = "true" if is_predicated(tag) else "false"
         f.write(code_fmt(f"""\
-            ctx_log_vreg_write(ctx, {self.reg_num}, {newv}, {predicated});
+            ctx_log_vreg_write(ctx, {self.reg_num}, {newv}, {predicated},
+                               insn_has_hvx_helper);
         """))
 
 class VRegPairDest(Register, Hvx, Dest):
@@ -832,7 +845,8 @@ def analyze_write(self, f, tag, regno):
         newv = hvx_newv(tag)
         predicated = "true" if is_predicated(tag) else "false"
         f.write(code_fmt(f"""\
-            ctx_log_vreg_write_pair(ctx, {self.reg_num}, {newv}, {predicated});
+            ctx_log_vreg_write_pair(ctx, {self.reg_num}, {newv}, {predicated},
+                                    insn_has_hvx_helper);
         """))
 
 class VRegPairSource(Register, Hvx, OldSource):
@@ -859,7 +873,7 @@ def helper_hvx_desc(self, f):
         """))
     def analyze_read(self, f, regno):
         f.write(code_fmt(f"""\
-            ctx_log_vreg_read_pair(ctx, {self.reg_num});
+            ctx_log_vreg_read_pair(ctx, {self.reg_num}, insn_has_hvx_helper);
         """))
 
 class VRegPairReadWrite(Register, Hvx, ReadWrite):
@@ -891,13 +905,14 @@ def helper_hvx_desc(self, f):
         """))
     def analyze_read(self, f, regno):
         f.write(code_fmt(f"""\
-            ctx_log_vreg_read_pair(ctx, {self.reg_num});
+            ctx_log_vreg_read_pair(ctx, {self.reg_num}, insn_has_hvx_helper);
         """))
     def analyze_write(self, f, tag, regno):
         newv = hvx_newv(tag)
         predicated = "true" if is_predicated(tag) else "false"
         f.write(code_fmt(f"""\
-            ctx_log_vreg_write_pair(ctx, {self.reg_num}, {newv}, {predicated});
+            ctx_log_vreg_write_pair(ctx, {self.reg_num}, {newv}, {predicated},
+                                    insn_has_hvx_helper);
         """))
 
 class QRegDest(Register, Hvx, Dest):
@@ -920,7 +935,7 @@ def helper_hvx_desc(self, f):
         """))
     def analyze_write(self, f, tag, regno):
         f.write(code_fmt(f"""\
-            ctx_log_qreg_write(ctx, {self.reg_num});
+            ctx_log_qreg_write(ctx, {self.reg_num}, insn_has_hvx_helper);
         """))
 
 class QRegSource(Register, Hvx, OldSource):
@@ -941,7 +956,7 @@ def helper_hvx_desc(self, f):
         """))
     def analyze_read(self, f, regno):
         f.write(code_fmt(f"""\
-            ctx_log_qreg_read(ctx, {self.reg_num});
+            ctx_log_qreg_read(ctx, {self.reg_num}, insn_has_hvx_helper);
         """))
 
 class QRegReadWrite(Register, Hvx, ReadWrite):
@@ -967,11 +982,11 @@ def helper_hvx_desc(self, f):
         """))
     def analyze_read(self, f, regno):
         f.write(code_fmt(f"""\
-            ctx_log_qreg_read(ctx, {self.reg_num});
+            ctx_log_qreg_read(ctx, {self.reg_num}, insn_has_hvx_helper);
         """))
     def analyze_write(self, f, tag, regno):
         f.write(code_fmt(f"""\
-            ctx_log_qreg_write(ctx, {self.reg_num});
+            ctx_log_qreg_write(ctx, {self.reg_num}, insn_has_hvx_helper);
         """))
 
 def init_registers():
-- 
2.34.1


