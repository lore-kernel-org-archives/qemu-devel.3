Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D6DC3064D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 02:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO78Y-00031H-Qq; Sun, 30 Jun 2024 22:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sO78W-00030C-Bq
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 22:51:24 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sO78U-0000Gi-D2
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 22:51:24 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5ba33b08550so1282289eaf.2
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2024 19:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719802281; x=1720407081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v8ctItCGfyeAkHxXU4PbxRnvrKAFyRywgfWFR/Aj32s=;
 b=ema0Nc/adOPDBVBO3usYdvf7a3LvHZwU6gPs4LvuvCCrRbStuyDVo1ET9Zv+MpW8sH
 JTnIcqixzOe/fDyrqH5wnWhkQ9HWd4qi69vs6v2ckCgrbKSoImrnalJhh+wWzpvmykRX
 IvzMRRPtnmA+dy87kxPL0B29oP6yFyAxcnGcOO9ifU8vQEKHjdcTcp+EA8IXBeB9rp8J
 lXQwWx+6QoanMXlh1FDlKTYdNcvw6ayDCt/myBxFW8NegvMztR+JmgWrg1+dLY4pbgrW
 h57yBnOGt6JdNTyTpzYy9dYcgnNB1XJ1tvrMCE1jkwMrGMTbfd5yx0ZLnvdh1nNITBrS
 TdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719802281; x=1720407081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v8ctItCGfyeAkHxXU4PbxRnvrKAFyRywgfWFR/Aj32s=;
 b=LJZuI4dMSeHPV+SFH3uRUFK85tii12eBz4kb9dkfMqaGEMdBFGp9zrbkhlQ8Kc5JhB
 kA0f6h4iVUr+8x8ZWxtcylPUJ+ldMoIxHt1tyAhbcfL+P5N9ONlmkVE/pFwnQsHiB1e2
 wUAoaO/zZAFzsc/FFwhjlYHew+9q2+0iLKZVClotTMKQrAj4hHKTyBABSNugseDfGkq8
 JTCTc6cmHVbiYgXfneIABJxsahoFesSC/ck0PfVIu9PQiKhAFyEg/rGoHiypPQhp45Ko
 UAoBdE9O5rhYVEzCDTj2ZoSOj2dVQrwXJNN3iiFcLnilGsq9hXL2PC51TzZd1OAYvItm
 0XWA==
X-Gm-Message-State: AOJu0YyHdu2omGRD3Q2aa4lc2Y4xuIZec0CUQYdt5S6htX6rMeV8hz82
 nGIsLM0FoVtmhNT9obCmBTqPtMZnbB0DC5LEly3NqDZTv5MSVYF7ePT4UbeHAzgYL5cXawgDhAI
 k
X-Google-Smtp-Source: AGHT+IFnWMAPEcMXFW+JxIMi07bQZZeg/a/6n/CzE9EcIDrjVACaJC9wNILwBMfy+nZ+yMGIfRL/WQ==
X-Received: by 2002:a05:6358:7e16:b0:19f:45a6:4965 with SMTP id
 e5c5f4694b2df-1a6acccd74emr502455955d.7.1719802280921; 
 Sun, 30 Jun 2024 19:51:20 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3b9349sm5531698a91.37.2024.06.30.19.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 19:51:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH 5/5] target/i386: Introduce cc_op_size
Date: Sun, 30 Jun 2024 19:51:15 -0700
Message-Id: <20240701025115.1265117-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701025115.1265117-1-richard.henderson@linaro.org>
References: <20240701025115.1265117-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
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

Replace arithmetic on cc_op with a helper function.
Assert that the op has a size and that it is valid
for the configuration.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/translate.c | 29 ++++++++++++++++++-----------
 target/i386/tcg/emit.c.inc  |  3 ++-
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index e675afca47..e98bed0805 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -322,6 +322,16 @@ static uint8_t cc_op_live(CCOp op)
     g_assert_not_reached();
 }
 
+static MemOp cc_op_size(CCOp op)
+{
+    MemOp size = op & 3;
+
+    assert(op >= CC_OP_FIRST_BWLQ && op <= CC_OP_LAST_BWLQ);
+    assert(size <= MO_TL);
+
+    return size;
+}
+
 static void set_cc_op_1(DisasContext *s, CCOp op, bool dirty)
 {
     int dead;
@@ -884,7 +894,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
     switch (s->cc_op) {
     case CC_OP_SUBB ... CC_OP_SUBQ:
         /* (DATA_TYPE)CC_SRCT < (DATA_TYPE)CC_SRC */
-        size = s->cc_op - CC_OP_SUBB;
+        size = cc_op_size(s->cc_op);
         gen_ext_tl(s->cc_srcT, s->cc_srcT, size, false);
         gen_ext_tl(cpu_cc_src, cpu_cc_src, size, false);
         return (CCPrepare) { .cond = TCG_COND_LTU, .reg = s->cc_srcT,
@@ -892,7 +902,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
 
     case CC_OP_ADDB ... CC_OP_ADDQ:
         /* (DATA_TYPE)CC_DST < (DATA_TYPE)CC_SRC */
-        size = s->cc_op - CC_OP_ADDB;
+        size = cc_op_size(s->cc_op);
         gen_ext_tl(cpu_cc_dst, cpu_cc_dst, size, false);
         gen_ext_tl(cpu_cc_src, cpu_cc_src, size, false);
         return (CCPrepare) { .cond = TCG_COND_LTU, .reg = cpu_cc_dst,
@@ -910,7 +920,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
 
     case CC_OP_SHLB ... CC_OP_SHLQ:
         /* (CC_SRC >> (DATA_BITS - 1)) & 1 */
-        size = s->cc_op - CC_OP_SHLB;
+        size = cc_op_size(s->cc_op);
         return gen_prepare_sign_nz(cpu_cc_src, size);
 
     case CC_OP_MULB ... CC_OP_MULQ:
@@ -918,7 +928,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
                              .reg = cpu_cc_src };
 
     case CC_OP_BMILGB ... CC_OP_BMILGQ:
-        size = s->cc_op - CC_OP_BMILGB;
+        size = cc_op_size(s->cc_op);
         gen_ext_tl(cpu_cc_src, cpu_cc_src, size, false);
         return (CCPrepare) { .cond = TCG_COND_EQ, .reg = cpu_cc_src };
 
@@ -972,10 +982,7 @@ static CCPrepare gen_prepare_eflags_s(DisasContext *s, TCGv reg)
     case CC_OP_POPCNT:
         return (CCPrepare) { .cond = TCG_COND_NEVER };
     default:
-        {
-            MemOp size = (s->cc_op - CC_OP_ADDB) & 3;
-            return gen_prepare_sign_nz(cpu_cc_dst, size);
-        }
+        return gen_prepare_sign_nz(cpu_cc_dst, cc_op_size(s->cc_op));
     }
 }
 
@@ -1016,7 +1023,7 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
         return (CCPrepare) { .cond = TCG_COND_ALWAYS };
     default:
         {
-            MemOp size = (s->cc_op - CC_OP_ADDB) & 3;
+            MemOp size = cc_op_size(s->cc_op);
             if (size == MO_TL) {
                 return (CCPrepare) { .cond = TCG_COND_EQ, .reg = cpu_cc_dst };
             } else {
@@ -1042,7 +1049,7 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
     switch (s->cc_op) {
     case CC_OP_SUBB ... CC_OP_SUBQ:
         /* We optimize relational operators for the cmp/jcc case.  */
-        size = s->cc_op - CC_OP_SUBB;
+        size = cc_op_size(s->cc_op);
         switch (jcc_op) {
         case JCC_BE:
             gen_ext_tl(s->cc_srcT, s->cc_srcT, size, false);
@@ -3176,7 +3183,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                CC_DST alone, setting CC_SRC, and using a CC_OP_SAR of the
                same width.  */
             tcg_gen_mov_tl(cpu_cc_src, s->tmp4);
-            set_cc_op(s, ((s->cc_op - CC_OP_MULB) & 3) + CC_OP_SARB);
+            set_cc_op(s, CC_OP_SARB + cc_op_size(s->cc_op));
             break;
         default:
             /* Otherwise, generate EFLAGS and replace the C bit.  */
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 38b399783e..e9d5d196ce 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3106,7 +3106,8 @@ static bool gen_eflags_adcox(DisasContext *s, X86DecodedInsn *decode, bool want_
          * bit, we might as well fish CF out of EFLAGS and save a shift.
          */
         if (want_carry && (!need_flags || s->cc_op == CC_OP_SHLB + MO_TL)) {
-            tcg_gen_shri_tl(decode->cc_dst, cpu_cc_src, (8 << (s->cc_op - CC_OP_SHLB)) - 1);
+            MemOp size = cc_op_size(s->cc_op);
+            tcg_gen_shri_tl(decode->cc_dst, cpu_cc_src, (8 << size) - 1);
             got_cf = true;
         }
         gen_mov_eflags(s, decode->cc_src);
-- 
2.34.1


