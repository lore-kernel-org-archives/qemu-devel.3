Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9DCE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2yF-0000Hj-F4; Tue, 10 Dec 2024 11:20:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2y6-0007ph-1k
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:20:14 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2y4-0006pQ-3i
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:20:13 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-53ffaaeeb76so3064232e87.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847610; x=1734452410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6DQlHI7uclEdcPfrfvz33hHRsZVW+9hnV/7JAZehGk4=;
 b=dvgCbJHSjDiNWUH/H/Kp5s7dgWGvDiD3YfPFR8RMorffhw1zQ8EPOfRickhnHvuWUz
 4wrcrEWKZ8BhzDFBwjZ/dsRuwgrnVPd4g1wHGuDRfCVMi6ZvLuQeyjTuKkPwH9onwhwN
 tW9i4oJaEqmm5Ilaap/3QumCM04jMQ4IdjXsyV9ZTQFY86bAJXwy2pZmpR0OTxnf3m1j
 GR743O2GbFmpL6kMhfLeNl32PKiiUipJ2JhsdCCjjBH24wJQlF8dgEZGEpI87e5ZCI7Y
 Yh2zypKL6NzC3s0DaF+HMeNxPdLqT+sJ2YS8MTRCboefqSlL6fE0DUO23IYEHAxEQ7Dx
 /dvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847610; x=1734452410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6DQlHI7uclEdcPfrfvz33hHRsZVW+9hnV/7JAZehGk4=;
 b=GkDePkJkOzgN+C+/tIPTIUPJ52R6+liJw8ERQzOuKxPpCVELnLYpVuD+gX6hLq4kmY
 8GRalQEg9t20eKj5ySwZSBsvTxKcgMXAPQOXotdVxzfinSXFPrXPLBwpDEF3o4RQBGuL
 VJ1UZZzJihqTh7riA3LQvZfizJEwqDTPFlmnGNKOhvF4PRTz14SV2AxecTCvQw54wFb5
 Xm6Ix5+0vbVfhtWXfdkX/sLrJIMKu5K2tRxffn6EYRFEdn32/h4b7yZeXh1PYrjBxzt5
 Ip7zhWZo4rGjcRGsXjCCk5c6/4Df/Evb2KtQOTDgl+o4HnqbR46PA9oQ4gzfp8wFGG5A
 9xsw==
X-Gm-Message-State: AOJu0YyWgTUalgeV1F7lFII5AbofBikLmswrEbv3wbSs6Z+WB+l/W83s
 MTTvTEvy53+W64p0Ksit+HPooH0q+xuQnWc7iqkt5RjCXqagd70zUdMy8A3HNXOBW8Rb9gU5A+b
 SnXWQhK5t
X-Gm-Gg: ASbGnctgrld4nieZVzOnbxfcbkN7EvWUNRbQfvVgVZ+RTz1Bif7l1TENhEL/MoYkLq8
 J9aNTfyn5kvAGrOfMrauSrFfTSSp2hp3pAo+LmJ3NBm7yMWUUDsqI2jil2focjAGKA6+uG2fMzt
 cIA4C98HTDUOa3kX6E0yURKs8BAn8Ula8m0NDZVdRn7i+IoecD5RmHTCsfNA4g0w6ScwfYXMQZS
 XuLUTjh4LAR69TfVe3ZT+Gex9wU1JVvBR9D8//Y3razc7xo5AVphzdEUq4=
X-Google-Smtp-Source: AGHT+IHI09HuVZ6JRHKX4khk6wwzIKO2PZX1iFI17qIRXu3C7p2tDNyfRhdGo2d/7wL9FKCWw4g7UA==
X-Received: by 2002:a05:6512:6c8:b0:53f:f71:4d74 with SMTP id
 2adb3069b0e04-53f0f714e3amr5508310e87.8.1733847610127; 
 Tue, 10 Dec 2024 08:20:10 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53f93377eefsm1026343e87.67.2024.12.10.08.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:20:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 37/69] target/arm: Introduce gen_gvec_cls, gen_gvec_clz
Date: Tue, 10 Dec 2024 10:17:01 -0600
Message-ID: <20241210161733.1830573-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x136.google.com
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

Add gvec interfaces for CLS and CLZ operations.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h      |  5 +++++
 target/arm/tcg/gengvec.c        | 35 +++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c  | 29 +++++++--------------------
 target/arm/tcg/translate-neon.c | 29 ++-------------------------
 4 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 20cd0e851c..5c6c24f057 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -578,6 +578,11 @@ void gen_gvec_umaxp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
 void gen_gvec_uminp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                     uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 
+void gen_gvec_cls(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                  uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_clz(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                  uint32_t opr_sz, uint32_t max_sz);
+
 /*
  * Forward to the isar_feature_* tests given a DisasContext pointer.
  */
diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index f652520b65..834b2961c0 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -2358,3 +2358,38 @@ void gen_gvec_urhadd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
     assert(vece <= MO_32);
     tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &g[vece]);
 }
+
+void gen_gvec_cls(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                  uint32_t opr_sz, uint32_t max_sz)
+{
+    static const GVecGen2 g[] = {
+        { .fni4 = gen_helper_neon_cls_s8,
+          .vece = MO_8 },
+        { .fni4 = gen_helper_neon_cls_s16,
+          .vece = MO_16 },
+        { .fni4 = tcg_gen_clrsb_i32,
+          .vece = MO_32 },
+    };
+    assert(vece <= MO_32);
+    tcg_gen_gvec_2(rd_ofs, rn_ofs, opr_sz, max_sz, &g[vece]);
+}
+
+static void gen_clz32_i32(TCGv_i32 d, TCGv_i32 n)
+{
+    tcg_gen_clzi_i32(d, n, 32);
+}
+
+void gen_gvec_clz(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                  uint32_t opr_sz, uint32_t max_sz)
+{
+    static const GVecGen2 g[] = {
+        { .fni4 = gen_helper_neon_clz_u8,
+          .vece = MO_8 },
+        { .fni4 = gen_helper_neon_clz_u16,
+          .vece = MO_16 },
+        { .fni4 = gen_clz32_i32,
+          .vece = MO_32 },
+    };
+    assert(vece <= MO_32);
+    tcg_gen_gvec_2(rd_ofs, rn_ofs, opr_sz, max_sz, &g[vece]);
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index bdbdc466ac..77d9f6452a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10321,6 +10321,13 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
+    case 0x4: /* CLZ, CLS */
+        if (u) {
+            gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_clz, size);
+        } else {
+            gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_cls, size);
+        }
+        return;
     case 0x5:
         if (u && size == 0) { /* NOT */
             gen_gvec_fn2(s, is_q, rd, rn, tcg_gen_gvec_not, 0);
@@ -10379,13 +10386,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
             if (size == 2) {
                 /* Special cases for 32 bit elements */
                 switch (opcode) {
-                case 0x4: /* CLS */
-                    if (u) {
-                        tcg_gen_clzi_i32(tcg_res, tcg_op, 32);
-                    } else {
-                        tcg_gen_clrsb_i32(tcg_res, tcg_op);
-                    }
-                    break;
                 case 0x2f: /* FABS */
                     gen_vfp_abss(tcg_res, tcg_op);
                     break;
@@ -10450,21 +10450,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                         gen_helper_neon_cnt_u8(tcg_res, tcg_op);
                     }
                     break;
-                case 0x4: /* CLS, CLZ */
-                    if (u) {
-                        if (size == 0) {
-                            gen_helper_neon_clz_u8(tcg_res, tcg_op);
-                        } else {
-                            gen_helper_neon_clz_u16(tcg_res, tcg_op);
-                        }
-                    } else {
-                        if (size == 0) {
-                            gen_helper_neon_cls_s8(tcg_res, tcg_op);
-                        } else {
-                            gen_helper_neon_cls_s16(tcg_res, tcg_op);
-                        }
-                    }
-                    break;
                 default:
                 case 0x7: /* SQABS, SQNEG */
                     g_assert_not_reached();
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 9c8829ad7d..1c89a53272 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -3120,6 +3120,8 @@ DO_2MISC_VEC(VCGT0, gen_gvec_cgt0)
 DO_2MISC_VEC(VCLE0, gen_gvec_cle0)
 DO_2MISC_VEC(VCGE0, gen_gvec_cge0)
 DO_2MISC_VEC(VCLT0, gen_gvec_clt0)
+DO_2MISC_VEC(VCLS, gen_gvec_cls)
+DO_2MISC_VEC(VCLZ, gen_gvec_clz)
 
 static bool trans_VMVN(DisasContext *s, arg_2misc *a)
 {
@@ -3227,33 +3229,6 @@ static bool trans_VREV16(DisasContext *s, arg_2misc *a)
     return do_2misc(s, a, gen_rev16);
 }
 
-static bool trans_VCLS(DisasContext *s, arg_2misc *a)
-{
-    static NeonGenOneOpFn * const fn[] = {
-        gen_helper_neon_cls_s8,
-        gen_helper_neon_cls_s16,
-        gen_helper_neon_cls_s32,
-        NULL,
-    };
-    return do_2misc(s, a, fn[a->size]);
-}
-
-static void do_VCLZ_32(TCGv_i32 rd, TCGv_i32 rm)
-{
-    tcg_gen_clzi_i32(rd, rm, 32);
-}
-
-static bool trans_VCLZ(DisasContext *s, arg_2misc *a)
-{
-    static NeonGenOneOpFn * const fn[] = {
-        gen_helper_neon_clz_u8,
-        gen_helper_neon_clz_u16,
-        do_VCLZ_32,
-        NULL,
-    };
-    return do_2misc(s, a, fn[a->size]);
-}
-
 static bool trans_VCNT(DisasContext *s, arg_2misc *a)
 {
     if (a->size != 0) {
-- 
2.43.0


