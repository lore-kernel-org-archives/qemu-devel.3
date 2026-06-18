Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113EECD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 04:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa42R-0000zn-KP; Thu, 18 Jun 2026 00:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa42L-0000sD-GR
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:07:29 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa42I-00045h-8r
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:07:27 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-36ba706ab46so305805a91.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 21:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781755645; x=1782360445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0IzYhfBiv4AFus9PqvoAgcoWpyF7SxwPSwNNybn7Crw=;
 b=F67YbCFM4igOBQVYK8W2h/4CRvF1yfd8vBqveRKboK+hjzWiF9SbNRlxPntpjJJoBR
 jmMLfjtTyQivznaRy2R4yYE4UmhabA5ClZubT9B0b5IKZf+gs4LsQeMYvAo6MJgxZkjd
 m2XbHfhwzMnUPIfcVoIC8SvSP8fkeHkI1Gbk0KeX75+9zuyO6nM1m9tj5/iTqRruoxED
 bY+Op9rl5YJlr8FY2BYYtlEQdrcEKTJDU5+CRbnVyyUKA7PhkpXfQ8x2spoEph68bx2S
 ZocnRR0PRgLeuq8kbbLJDckip/zS9wm7EfmUfO7gljqgLS3yqRpXQiCSJoWc0PodA0WY
 2vpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781755645; x=1782360445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0IzYhfBiv4AFus9PqvoAgcoWpyF7SxwPSwNNybn7Crw=;
 b=ldTH1m6LYmbwYpo+d5PHqhPL6JxLo5evh4k8RHmPag9Xv4bAOsBQNPVB/xLcrT3ho9
 EgcJfo9lqsy0GWlfvTVHo/msqb867wAnxqVAkhqlDlzvrxZfzvOZVNSaIjLCS5kDqtxX
 Hl81rDpEVLEyDXEd4BZYw3vhO87Ns8MzQmUUhv35p89k35HtDqKDckCsxmHDPI7ce0DP
 nVAgJdPMkGcnSAkdJB21NnK5CU5tqmS7C7vnREMTrVbX98nSoUwDtOGubd/M6PXQKnpg
 R9JS48HBslPboFhN8HqOLBKN2dz3No9jcqfsLOlSDuINj7Yzsg1NM0GLdUUuEq0xC3AG
 M3jw==
X-Gm-Message-State: AOJu0YwFDhD1SSWYlqw1BYtq68fAmxmYD6qT6us5+7k2Bk6ybDfZsyG1
 FvPTCEtDTBBOElMjDWX24j2QQB1zzTgzF2DoMMtMNldbHa3c33Ba1uzWXQ4g1m68Xy6rkB9T84I
 /wMAT
X-Gm-Gg: AfdE7cnx85ufZs9h+svEi06FfeFFJ82UThsBR4LvxmQiEWu6THYQrRiCEE+sr3Wro5k
 50ehrflfrVcO2D+5iT7lxGoHLTGrEO+Lt+N0K0DA3Nr3Q31V7kGpiiUlS9AGgfNy5QbG3l3pfKr
 +uyGgsQunvjHEwO5W2lCAVPC3Lomq/dBSjzdUvziom1ssAyo7FuM22Rii7jLe5sTIDJAtuy/AM+
 IQl0q434cvLirqwDtrLKb7BdlMj/60Mrp219EtZB7IhYKDWgkKgIw4kb+EYkiZRL5Ls0rRur1Z2
 aunaX8p7vpKBexkDhsxIWU3blRaxVlvR2hMGjVfl5jG01i/s4f7vyuOgOmdlerroTRdm2LtSe1k
 PF7PzVHfYIfG8FeSb5z1e6vUvf3OkQo/MAMeKTn9B1UYFGl57rl2q67nx0u/6IReNOj4opaO09/
 8FQZ22syFBdsxJxzMcWtd5hfRgGavbN0aAsRbUlaX1Ek+6j0/QVA==
X-Received: by 2002:a17:90b:4f:b0:36b:93f7:a903 with SMTP id
 98e67ed59e1d1-37c936a98b5mr6816629a91.18.1781755644686; 
 Wed, 17 Jun 2026 21:07:24 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c5222e042sm8830476a91.16.2026.06.17.21.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 21:07:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 5/8] target/arm: Implement FIRSTP, LASTP
Date: Wed, 17 Jun 2026 21:07:15 -0700
Message-ID: <20260618040718.572950-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618040718.572950-1-richard.henderson@linaro.org>
References: <20260618040718.572950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve-defs.h |  3 ++
 target/arm/tcg/sve_helper.c      | 30 +++++++++++++++++
 target/arm/tcg/translate-sve.c   | 56 ++++++++++++++++++++++++++++++++
 target/arm/tcg/sve.decode        |  3 ++
 4 files changed, 92 insertions(+)

diff --git a/target/arm/tcg/helper-sve-defs.h b/target/arm/tcg/helper-sve-defs.h
index b64a0faa19..19bd936f6e 100644
--- a/target/arm/tcg/helper-sve-defs.h
+++ b/target/arm/tcg/helper-sve-defs.h
@@ -961,6 +961,9 @@ DEF_HELPER_FLAGS_4(sve_brkns, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_cntp, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
 DEF_HELPER_FLAGS_2(sve2p1_cntp_c, TCG_CALL_NO_RWG_SE, i64, i32, i32)
 
+DEF_HELPER_FLAGS_3(sve_firstp, TCG_CALL_NO_RWG_SE, i64, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_lastp, TCG_CALL_NO_RWG_SE, i64, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_3(sve_whilel, TCG_CALL_NO_RWG, i32, ptr, i32, i32)
 DEF_HELPER_FLAGS_3(sve_whileg, TCG_CALL_NO_RWG, i32, ptr, i32, i32)
 
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index bd8fa2da7e..b2875a559b 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4328,6 +4328,36 @@ uint64_t HELPER(sve2p1_cntp_c)(uint32_t png, uint32_t desc)
     return count >> p.lg2_stride;
 }
 
+uint64_t HELPER(sve_firstp)(void *vn, void *vg, uint32_t pred_desc)
+{
+    intptr_t words = DIV_ROUND_UP(FIELD_EX32(pred_desc, PREDDESC, OPRSZ), 8);
+    intptr_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
+    uint64_t *n = vn, *g = vg, mask = pred_esz_masks[esz];
+
+    for (intptr_t i = 0; i < words; ++i) {
+        uint64_t t = n[i] & g[i] & mask;
+        if (t) {
+            return (i * 64 + ctz64(t)) >> esz;
+        }
+    }
+    return -1;
+}
+
+uint64_t HELPER(sve_lastp)(void *vn, void *vg, uint32_t pred_desc)
+{
+    intptr_t words = DIV_ROUND_UP(FIELD_EX32(pred_desc, PREDDESC, OPRSZ), 8);
+    intptr_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
+    uint64_t *n = vn, *g = vg, mask = pred_esz_masks[esz];
+
+    for (intptr_t i = words - 1; i >= 0; --i) {
+        uint64_t t = n[i] & g[i] & mask;
+        if (t) {
+            return (i * 64 + (63 - clz64(t))) >> esz;
+        }
+    }
+    return -1;
+}
+
 /* C.f. Arm pseudocode EncodePredCount */
 static uint64_t encode_pred_count(uint32_t elements, uint32_t count,
                                   uint32_t esz, bool invert)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 01199dbd78..63f64796e5 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3481,6 +3481,62 @@ static bool trans_SINCDECP_z(DisasContext *s, arg_incdec2_pred *a)
     return true;
 }
 
+static bool do_firstp_lastp(DisasContext *s, arg_rpr_esz *a, bool firstp)
+{
+    if (sve_access_check(s)) {
+        unsigned psz = pred_full_reg_size(s);
+        TCGv_i64 v = cpu_reg(s, a->rd);
+
+        if (psz <= 8) {
+            uint64_t psz_mask;
+
+            tcg_gen_ld_i64(v, tcg_env, pred_full_reg_offset(s, a->rn));
+            if (a->rn != a->pg) {
+                TCGv_i64 g = tcg_temp_new_i64();
+                tcg_gen_ld_i64(g, tcg_env, pred_full_reg_offset(s, a->pg));
+                tcg_gen_and_i64(v, v, g);
+            }
+
+            /*
+             * Reduce the pred_esz_masks value simply to reduce the
+             * size of the code generated here.
+             */
+            psz_mask = MAKE_64BIT_MASK(0, psz * 8);
+            tcg_gen_andi_i64(v, v, pred_esz_masks[a->esz] & psz_mask);
+
+            if (firstp) {
+                tcg_gen_ctzi_i64(v, v, -1);
+            } else {
+                tcg_gen_clzi_i64(v, v, 64);
+                tcg_gen_subfi_i64(v, 63, v);
+            }
+            tcg_gen_sari_i64(v, v, a->esz);
+        } else {
+            TCGv_ptr t_pn = tcg_temp_new_ptr();
+            TCGv_ptr t_pg = tcg_temp_new_ptr();
+            unsigned desc = 0;
+            TCGv_i32 t_desc;
+
+            desc = FIELD_DP32(desc, PREDDESC, OPRSZ, psz);
+            desc = FIELD_DP32(desc, PREDDESC, ESZ, a->esz);
+
+            tcg_gen_addi_ptr(t_pn, tcg_env, pred_full_reg_offset(s, a->rn));
+            tcg_gen_addi_ptr(t_pg, tcg_env, pred_full_reg_offset(s, a->pg));
+            t_desc = tcg_constant_i32(desc);
+
+            if (firstp) {
+                gen_helper_sve_firstp(v, t_pn, t_pg, t_desc);
+            } else {
+                gen_helper_sve_lastp(v, t_pn, t_pg, t_desc);
+            }
+        }
+    }
+    return true;
+}
+
+TRANS_FEAT(FIRSTP, aa64_sme2p2_or_sve2p2, do_firstp_lastp, a, true)
+TRANS_FEAT(LASTP, aa64_sme2p2_or_sve2p2, do_firstp_lastp, a, false)
+
 /*
  *** SVE Integer Compare Scalars Group
  */
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index a3eefd60e5..bdc2b7f0c0 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -852,6 +852,9 @@ BRKN            00100101 0. 01100001 .... 0 .... 0 ....         @pd_pg_pn_s
 CNTP            00100101 ..    100 000 10 ....     0 .... ..... @rd_pg4_pn
 CNTP_c          00100101 esz:2 100 000 10 000 vl:1 1 rn:4 rd:5
 
+FIRSTP          00100101 ..    100 001 10 ....     0 .... ..... @rd_pg4_pn
+LASTP           00100101 ..    100 010 10 ....     0 .... ..... @rd_pg4_pn
+
 # SVE inc/dec register by predicate count
 INCDECP_r       00100101 .. 10110 d:1 10001 00 .... .....     @incdec_pred u=1
 
-- 
2.43.0


