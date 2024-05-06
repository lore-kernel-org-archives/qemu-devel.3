Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08528C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mmI-0007gJ-7h; Sun, 05 May 2024 21:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mm8-0007ap-9O
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:17 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mm0-0002Pq-WD
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:15 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2b4348fa971so924608a91.1
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957447; x=1715562247; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dSa/7vypbJwbnH1dMvxjbflSOgZgpWf+dcwolGGLVOg=;
 b=yvtX36umn9rSz0OZtEpRC8FOv6zRulnhKnvTanmjkKN43ulXfDFZe0lo3n0jCm1rJV
 GUZVk1L8cwpwrnZLYdYRHjC1UIukzUkMVKgb4Io/hgr6MTtODPD3XDasrYiCx6ElVVqR
 i9Oef8dlbDT/EV7ZUsWVKtNqcjI1TnxUkrPmvYSbhiTMdKaeDQVefBvJ75aM5TjvITW6
 YYqaIlgbI14v7cfriGtop4hs7MTFa3NRsY1fXnBkvBorTXgBloM6TXmLY+lzGQz6OxxX
 D5K/sjBfAX9ehqZkiCCNq4bHrMmRCHhhVyLh5FvZGObMmcvqoNOodkfVjCQigsYcYNpv
 FN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957447; x=1715562247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dSa/7vypbJwbnH1dMvxjbflSOgZgpWf+dcwolGGLVOg=;
 b=I4lWzRKMUETOFbEoZQCenZ91mwC3L1iafTqMaZPpnKheZnOfkBx+mxqw+Pd269XpOx
 o1Sn6SIIKKY8ADHkaRaD6fqi0+uSzfsyL0TUvE1SGy28K5CLJenjT9jkdNER1lHss4+N
 cE14asKqyR71mUgKfJvtAntMp9Ars0/9OStySmZJaw81EQ5sTu8Y3YXOuE8p/AOl96EZ
 cRK0cTwHkMiQ1lcQR0zwRh5P6Qs0dzhf9+ADeIgqiY23KlouaConD7LKsBMn6UZN+oCk
 HbFTwM/+J6AR7mhYE2jBHtHuk3EdetN7YovM/+bn7F/Y+HOf5NGLEbqr+DgkOQTjOGzq
 1DOw==
X-Gm-Message-State: AOJu0YyVBIsDD2qmDugqnXtUAXgyTCuPgvC+1ROZ/gwDuVkzGRVnoL29
 /p81xUiQz9JFsx3Da3WztgsA4gs5+A6r7XBl39OtioSjfLzwNKRDwjgaNssI7w8n0Qcbmk2u6jK
 a
X-Google-Smtp-Source: AGHT+IGGsQ7szIFDUNJ9Ooanj5Dnx1ja2+rbWr73i53CK7DPn27tzqLuA5pO0z3zJdCVM9LhbKNW3w==
X-Received: by 2002:a17:90b:3ec5:b0:2b4:b366:ad8f with SMTP id
 rm5-20020a17090b3ec500b002b4b366ad8fmr3489000pjb.16.1714957447349; 
 Sun, 05 May 2024 18:04:07 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 pv7-20020a17090b3c8700b002a5f44353d2sm8958232pjb.7.2024.05.05.18.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:04:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 02/57] target/arm: Split out gengvec64.c
Date: Sun,  5 May 2024 18:03:08 -0700
Message-Id: <20240506010403.6204-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Split some routines out of translate-a64.c and translate-sve.c
that are used by both.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.h |   4 +
 target/arm/tcg/gengvec64.c     | 190 +++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c |  26 -----
 target/arm/tcg/translate-sve.c | 145 +------------------------
 target/arm/tcg/meson.build     |   1 +
 5 files changed, 197 insertions(+), 169 deletions(-)
 create mode 100644 target/arm/tcg/gengvec64.c

diff --git a/target/arm/tcg/translate-a64.h b/target/arm/tcg/translate-a64.h
index 7b811b8ac5..91750f0ca9 100644
--- a/target/arm/tcg/translate-a64.h
+++ b/target/arm/tcg/translate-a64.h
@@ -193,6 +193,10 @@ void gen_gvec_rax1(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
 void gen_gvec_xar(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                   uint32_t rm_ofs, int64_t shift,
                   uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_eor3(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
+                   uint32_t a, uint32_t oprsz, uint32_t maxsz);
+void gen_gvec_bcax(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
+                   uint32_t a, uint32_t oprsz, uint32_t maxsz);
 
 void gen_sve_ldr(DisasContext *s, TCGv_ptr, int vofs, int len, int rn, int imm);
 void gen_sve_str(DisasContext *s, TCGv_ptr, int vofs, int len, int rn, int imm);
diff --git a/target/arm/tcg/gengvec64.c b/target/arm/tcg/gengvec64.c
new file mode 100644
index 0000000000..093b498b13
--- /dev/null
+++ b/target/arm/tcg/gengvec64.c
@@ -0,0 +1,190 @@
+/*
+ *  AArch64 generic vector expansion
+ *
+ *  Copyright (c) 2013 Alexander Graf <agraf@suse.de>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "translate.h"
+#include "translate-a64.h"
+
+
+static void gen_rax1_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m)
+{
+    tcg_gen_rotli_i64(d, m, 1);
+    tcg_gen_xor_i64(d, d, n);
+}
+
+static void gen_rax1_vec(unsigned vece, TCGv_vec d, TCGv_vec n, TCGv_vec m)
+{
+    tcg_gen_rotli_vec(vece, d, m, 1);
+    tcg_gen_xor_vec(vece, d, d, n);
+}
+
+void gen_gvec_rax1(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = { INDEX_op_rotli_vec, 0 };
+    static const GVecGen3 op = {
+        .fni8 = gen_rax1_i64,
+        .fniv = gen_rax1_vec,
+        .opt_opc = vecop_list,
+        .fno = gen_helper_crypto_rax1,
+        .vece = MO_64,
+    };
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &op);
+}
+
+static void gen_xar8_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, int64_t sh)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+    uint64_t mask = dup_const(MO_8, 0xff >> sh);
+
+    tcg_gen_xor_i64(t, n, m);
+    tcg_gen_shri_i64(d, t, sh);
+    tcg_gen_shli_i64(t, t, 8 - sh);
+    tcg_gen_andi_i64(d, d, mask);
+    tcg_gen_andi_i64(t, t, ~mask);
+    tcg_gen_or_i64(d, d, t);
+}
+
+static void gen_xar16_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, int64_t sh)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+    uint64_t mask = dup_const(MO_16, 0xffff >> sh);
+
+    tcg_gen_xor_i64(t, n, m);
+    tcg_gen_shri_i64(d, t, sh);
+    tcg_gen_shli_i64(t, t, 16 - sh);
+    tcg_gen_andi_i64(d, d, mask);
+    tcg_gen_andi_i64(t, t, ~mask);
+    tcg_gen_or_i64(d, d, t);
+}
+
+static void gen_xar_i32(TCGv_i32 d, TCGv_i32 n, TCGv_i32 m, int32_t sh)
+{
+    tcg_gen_xor_i32(d, n, m);
+    tcg_gen_rotri_i32(d, d, sh);
+}
+
+static void gen_xar_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, int64_t sh)
+{
+    tcg_gen_xor_i64(d, n, m);
+    tcg_gen_rotri_i64(d, d, sh);
+}
+
+static void gen_xar_vec(unsigned vece, TCGv_vec d, TCGv_vec n,
+                        TCGv_vec m, int64_t sh)
+{
+    tcg_gen_xor_vec(vece, d, n, m);
+    tcg_gen_rotri_vec(vece, d, d, sh);
+}
+
+void gen_gvec_xar(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                  uint32_t rm_ofs, int64_t shift,
+                  uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop[] = { INDEX_op_rotli_vec, 0 };
+    static const GVecGen3i ops[4] = {
+        { .fni8 = gen_xar8_i64,
+          .fniv = gen_xar_vec,
+          .fno = gen_helper_sve2_xar_b,
+          .opt_opc = vecop,
+          .vece = MO_8 },
+        { .fni8 = gen_xar16_i64,
+          .fniv = gen_xar_vec,
+          .fno = gen_helper_sve2_xar_h,
+          .opt_opc = vecop,
+          .vece = MO_16 },
+        { .fni4 = gen_xar_i32,
+          .fniv = gen_xar_vec,
+          .fno = gen_helper_sve2_xar_s,
+          .opt_opc = vecop,
+          .vece = MO_32 },
+        { .fni8 = gen_xar_i64,
+          .fniv = gen_xar_vec,
+          .fno = gen_helper_gvec_xar_d,
+          .opt_opc = vecop,
+          .vece = MO_64 }
+    };
+    int esize = 8 << vece;
+
+    /* The SVE2 range is 1 .. esize; the AdvSIMD range is 0 .. esize-1. */
+    tcg_debug_assert(shift >= 0);
+    tcg_debug_assert(shift <= esize);
+    shift &= esize - 1;
+
+    if (shift == 0) {
+        /* xar with no rotate devolves to xor. */
+        tcg_gen_gvec_xor(vece, rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz);
+    } else {
+        tcg_gen_gvec_3i(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz,
+                        shift, &ops[vece]);
+    }
+}
+
+static void gen_eor3_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_i64 k)
+{
+    tcg_gen_xor_i64(d, n, m);
+    tcg_gen_xor_i64(d, d, k);
+}
+
+static void gen_eor3_vec(unsigned vece, TCGv_vec d, TCGv_vec n,
+                         TCGv_vec m, TCGv_vec k)
+{
+    tcg_gen_xor_vec(vece, d, n, m);
+    tcg_gen_xor_vec(vece, d, d, k);
+}
+
+void gen_gvec_eor3(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
+                   uint32_t a, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen4 op = {
+        .fni8 = gen_eor3_i64,
+        .fniv = gen_eor3_vec,
+        .fno = gen_helper_sve2_eor3,
+        .vece = MO_64,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    };
+    tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &op);
+}
+
+static void gen_bcax_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_i64 k)
+{
+    tcg_gen_andc_i64(d, m, k);
+    tcg_gen_xor_i64(d, d, n);
+}
+
+static void gen_bcax_vec(unsigned vece, TCGv_vec d, TCGv_vec n,
+                         TCGv_vec m, TCGv_vec k)
+{
+    tcg_gen_andc_vec(vece, d, m, k);
+    tcg_gen_xor_vec(vece, d, d, n);
+}
+
+void gen_gvec_bcax(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
+                   uint32_t a, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen4 op = {
+        .fni8 = gen_bcax_i64,
+        .fniv = gen_bcax_vec,
+        .fno = gen_helper_sve2_bcax,
+        .vece = MO_64,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    };
+    tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &op);
+}
+
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 976094a5c8..283078d385 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -13617,32 +13617,6 @@ static void disas_crypto_two_reg_sha(DisasContext *s, uint32_t insn)
     gen_gvec_op2_ool(s, true, rd, rn, 0, genfn);
 }
 
-static void gen_rax1_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m)
-{
-    tcg_gen_rotli_i64(d, m, 1);
-    tcg_gen_xor_i64(d, d, n);
-}
-
-static void gen_rax1_vec(unsigned vece, TCGv_vec d, TCGv_vec n, TCGv_vec m)
-{
-    tcg_gen_rotli_vec(vece, d, m, 1);
-    tcg_gen_xor_vec(vece, d, d, n);
-}
-
-void gen_gvec_rax1(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
-                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
-{
-    static const TCGOpcode vecop_list[] = { INDEX_op_rotli_vec, 0 };
-    static const GVecGen3 op = {
-        .fni8 = gen_rax1_i64,
-        .fniv = gen_rax1_vec,
-        .opt_opc = vecop_list,
-        .fno = gen_helper_crypto_rax1,
-        .vece = MO_64,
-    };
-    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &op);
-}
-
 /* Crypto three-reg SHA512
  *  31                   21 20  16 15  14  13 12  11  10  9    5 4    0
  * +-----------------------+------+---+---+-----+--------+------+------+
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index ada05aa530..798ab2bfb1 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -527,94 +527,6 @@ TRANS_FEAT(ORR_zzz, aa64_sve, gen_gvec_fn_arg_zzz, tcg_gen_gvec_or, a)
 TRANS_FEAT(EOR_zzz, aa64_sve, gen_gvec_fn_arg_zzz, tcg_gen_gvec_xor, a)
 TRANS_FEAT(BIC_zzz, aa64_sve, gen_gvec_fn_arg_zzz, tcg_gen_gvec_andc, a)
 
-static void gen_xar8_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, int64_t sh)
-{
-    TCGv_i64 t = tcg_temp_new_i64();
-    uint64_t mask = dup_const(MO_8, 0xff >> sh);
-
-    tcg_gen_xor_i64(t, n, m);
-    tcg_gen_shri_i64(d, t, sh);
-    tcg_gen_shli_i64(t, t, 8 - sh);
-    tcg_gen_andi_i64(d, d, mask);
-    tcg_gen_andi_i64(t, t, ~mask);
-    tcg_gen_or_i64(d, d, t);
-}
-
-static void gen_xar16_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, int64_t sh)
-{
-    TCGv_i64 t = tcg_temp_new_i64();
-    uint64_t mask = dup_const(MO_16, 0xffff >> sh);
-
-    tcg_gen_xor_i64(t, n, m);
-    tcg_gen_shri_i64(d, t, sh);
-    tcg_gen_shli_i64(t, t, 16 - sh);
-    tcg_gen_andi_i64(d, d, mask);
-    tcg_gen_andi_i64(t, t, ~mask);
-    tcg_gen_or_i64(d, d, t);
-}
-
-static void gen_xar_i32(TCGv_i32 d, TCGv_i32 n, TCGv_i32 m, int32_t sh)
-{
-    tcg_gen_xor_i32(d, n, m);
-    tcg_gen_rotri_i32(d, d, sh);
-}
-
-static void gen_xar_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, int64_t sh)
-{
-    tcg_gen_xor_i64(d, n, m);
-    tcg_gen_rotri_i64(d, d, sh);
-}
-
-static void gen_xar_vec(unsigned vece, TCGv_vec d, TCGv_vec n,
-                        TCGv_vec m, int64_t sh)
-{
-    tcg_gen_xor_vec(vece, d, n, m);
-    tcg_gen_rotri_vec(vece, d, d, sh);
-}
-
-void gen_gvec_xar(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
-                  uint32_t rm_ofs, int64_t shift,
-                  uint32_t opr_sz, uint32_t max_sz)
-{
-    static const TCGOpcode vecop[] = { INDEX_op_rotli_vec, 0 };
-    static const GVecGen3i ops[4] = {
-        { .fni8 = gen_xar8_i64,
-          .fniv = gen_xar_vec,
-          .fno = gen_helper_sve2_xar_b,
-          .opt_opc = vecop,
-          .vece = MO_8 },
-        { .fni8 = gen_xar16_i64,
-          .fniv = gen_xar_vec,
-          .fno = gen_helper_sve2_xar_h,
-          .opt_opc = vecop,
-          .vece = MO_16 },
-        { .fni4 = gen_xar_i32,
-          .fniv = gen_xar_vec,
-          .fno = gen_helper_sve2_xar_s,
-          .opt_opc = vecop,
-          .vece = MO_32 },
-        { .fni8 = gen_xar_i64,
-          .fniv = gen_xar_vec,
-          .fno = gen_helper_gvec_xar_d,
-          .opt_opc = vecop,
-          .vece = MO_64 }
-    };
-    int esize = 8 << vece;
-
-    /* The SVE2 range is 1 .. esize; the AdvSIMD range is 0 .. esize-1. */
-    tcg_debug_assert(shift >= 0);
-    tcg_debug_assert(shift <= esize);
-    shift &= esize - 1;
-
-    if (shift == 0) {
-        /* xar with no rotate devolves to xor. */
-        tcg_gen_gvec_xor(vece, rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz);
-    } else {
-        tcg_gen_gvec_3i(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz,
-                        shift, &ops[vece]);
-    }
-}
-
 static bool trans_XAR(DisasContext *s, arg_rrri_esz *a)
 {
     if (a->esz < 0 || !dc_isar_feature(aa64_sve2, s)) {
@@ -629,61 +541,8 @@ static bool trans_XAR(DisasContext *s, arg_rrri_esz *a)
     return true;
 }
 
-static void gen_eor3_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_i64 k)
-{
-    tcg_gen_xor_i64(d, n, m);
-    tcg_gen_xor_i64(d, d, k);
-}
-
-static void gen_eor3_vec(unsigned vece, TCGv_vec d, TCGv_vec n,
-                         TCGv_vec m, TCGv_vec k)
-{
-    tcg_gen_xor_vec(vece, d, n, m);
-    tcg_gen_xor_vec(vece, d, d, k);
-}
-
-static void gen_eor3(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
-                     uint32_t a, uint32_t oprsz, uint32_t maxsz)
-{
-    static const GVecGen4 op = {
-        .fni8 = gen_eor3_i64,
-        .fniv = gen_eor3_vec,
-        .fno = gen_helper_sve2_eor3,
-        .vece = MO_64,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-    };
-    tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &op);
-}
-
-TRANS_FEAT(EOR3, aa64_sve2, gen_gvec_fn_arg_zzzz, gen_eor3, a)
-
-static void gen_bcax_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_i64 k)
-{
-    tcg_gen_andc_i64(d, m, k);
-    tcg_gen_xor_i64(d, d, n);
-}
-
-static void gen_bcax_vec(unsigned vece, TCGv_vec d, TCGv_vec n,
-                         TCGv_vec m, TCGv_vec k)
-{
-    tcg_gen_andc_vec(vece, d, m, k);
-    tcg_gen_xor_vec(vece, d, d, n);
-}
-
-static void gen_bcax(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
-                     uint32_t a, uint32_t oprsz, uint32_t maxsz)
-{
-    static const GVecGen4 op = {
-        .fni8 = gen_bcax_i64,
-        .fniv = gen_bcax_vec,
-        .fno = gen_helper_sve2_bcax,
-        .vece = MO_64,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-    };
-    tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &op);
-}
-
-TRANS_FEAT(BCAX, aa64_sve2, gen_gvec_fn_arg_zzzz, gen_bcax, a)
+TRANS_FEAT(EOR3, aa64_sve2, gen_gvec_fn_arg_zzzz, gen_gvec_eor3, a)
+TRANS_FEAT(BCAX, aa64_sve2, gen_gvec_fn_arg_zzzz, gen_gvec_bcax, a)
 
 static void gen_bsl(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
                     uint32_t a, uint32_t oprsz, uint32_t maxsz)
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index bdb5c7352f..508932a249 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -43,6 +43,7 @@ arm_ss.add(files(
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'cpu64.c',
+  'gengvec64.c',
   'translate-a64.c',
   'translate-sve.c',
   'translate-sme.c',
-- 
2.34.1


