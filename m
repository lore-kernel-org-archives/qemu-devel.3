Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6C4C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhMz-0006IC-P3; Fri, 04 Jul 2025 10:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIZ-0005v6-4i
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:55 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIW-0006Aw-Mf
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:54 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2ef461b9daeso865863fac.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751638911; x=1752243711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9JmrM0K8ZLfI+GER2A7TZLp0p7wKAFK1cAuaQ0BJ0Lc=;
 b=BkwsERth012mH3wkDTS9zlsV8jqORu4Z+kwnTA/+qV7MH/pjn0E5+2bb5hoqQZVMcd
 28lpXw/vTpLJMnU4CpVJW+PE95umzvaEUu1SC8HcwQb9tDvS7b4KUcTk7wCzQoEpBuCE
 G2axE2SRv1v6ZtRhED4FsGwjQpNKrNws2krt5GaoPLAXLssu4kWbN5QBl6xQD7Z2Kapm
 v9NtkoQiDwUNe+FsvPxuaNafXlKrpVEioIDjDWvM92NY2rlL+OdXrlMQAcg+bQMKdViS
 ApwwmjAuXm0sZrChhrywL4y+sJAdKpR5cxyqwtvyLFzUDyV+ghKLb74IZ1jt+V3oXyuc
 AZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638911; x=1752243711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9JmrM0K8ZLfI+GER2A7TZLp0p7wKAFK1cAuaQ0BJ0Lc=;
 b=LHwoyi1Pmf3eaAR7fFU/eRkvS2O/sl/pCIyTLBoc+7ZwVx+V+mI72+3XkyiRnNfmx1
 M07DWh6HTbaruvLoLp+580GjU/vaRl7uf8syC0z+XWZU1cQNjIgmjkyMVDsHNDrj1d0Y
 EiC9/gXz/n4q3D18ATOhpmRMgHERHh1kMD7ccqMoXIFLHsS0qiL6wpV9qRhb5Awes51o
 rpJ8gVeWCzmgz16eNx5MJLtQ6IbP6VunnEmehXTYmJg8CYpSiNb6QcjWKNFXEVswV8Nc
 k3DYtVi4610OWASU6bVvpIzxbuls1NZavATw+mioC0GsDktJGi0/NAK7NzahZPDj6hmA
 OXgA==
X-Gm-Message-State: AOJu0YzzTxNN+C97HRQaCL/P9fX3830hM0BmBof2Ly2I7JbTPLkQBvWM
 dPWPPf7j+u1dO0boTd8UBm56l+ArJ4f0ibHdt1kCd/cesrCvf1Lsb9Yly8BOMYZH4VZSNn4yXL1
 1bykhCCk=
X-Gm-Gg: ASbGncuMMeGFyQtBOyyag/yI0aYubj4L9ZGc5N6RarwXzyExbWhb8oartDmqUn3cHQp
 SXtgzpAe4Gig/zegrokgdzNhGcambb4soDRCE9RNETKojIofJdnR2SI7R1bsIVimHC1A8Suny/f
 SroFHl8HPNwRMHExoD7lpNLyWLTzDyCWXVoMGWEcrvarQOIC5Clvr8j6LTECIPm+hVLjkejZ1L5
 S+ABIIu83uwuQiERH/jSm73PuIlNuNUa48FpA1p0vbDXfAwaIjhE97i7NgmkxaqKay58oQhWTUx
 i/vMCplN/+zvTfjpRE7W/NR0p4G112OKe3nUpRAr9v+Ti6PkAC6Q99MOzRwxyXaQJa9uZJMuSLz
 MjGqEbyxOTFqZUlNxP83Usuj4QvFfDrUQmtlTrNqtEgswv3P0
X-Google-Smtp-Source: AGHT+IFstzqDn4QWUSOdI2FFNKhZ6HJk5zxd//C2TViXYvsqZfZJ9VLkXLfhQrdTtzOLPbDYmjg52g==
X-Received: by 2002:a05:6870:aa8d:b0:2b7:f8d9:d5f7 with SMTP id
 586e51a60fabf-2f796d5efecmr1641977fac.19.1751638911237; 
 Fri, 04 Jul 2025 07:21:51 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff0471esm528016fac.3.2025.07.04.07.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:21:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 036/108] target/arm: Implement SME2 FMLAL, BFMLAL
Date: Fri,  4 Jul 2025 08:19:59 -0600
Message-ID: <20250704142112.1018902-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 98 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sme.decode      | 71 ++++++++++++++++++++++++
 2 files changed, 169 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index aabdb96675..9ec02d960d 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -805,3 +805,101 @@ TRANS_FEAT(ADD_azz_nn_s, aa64_sme2, do_azz_nn, a, MO_32, tcg_gen_gvec_add_var)
 TRANS_FEAT(SUB_azz_nn_s, aa64_sme2, do_azz_nn, a, MO_32, tcg_gen_gvec_sub_var)
 TRANS_FEAT(ADD_azz_nn_d, aa64_sme2_i16i64, do_azz_nn, a, MO_64, tcg_gen_gvec_add_var)
 TRANS_FEAT(SUB_azz_nn_d, aa64_sme2_i16i64, do_azz_nn, a, MO_64, tcg_gen_gvec_sub_var)
+
+/*
+ * Expand array multi-vector single (n1), array multi-vector (nn),
+ * and array multi-vector indexed (nx), for floating-point accumulate.
+ *   multi: true for nn, false for n1.
+ *   fpst: >= 0 to set ptr argument for FPST_*, < 0 for ENV.
+ *   data: stuff for simd_data, including any index.
+ */
+#define FPST_ENV  -1
+
+static bool do_azz_acc_fp(DisasContext *s, int nreg, int nsel,
+                          int rv, int off, int zn, int zm,
+                          int data, int shsel, bool multi, int fpst,
+                          gen_helper_gvec_4_ptr *fn)
+{
+    if (sme_smza_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        int vstride = svl / nreg;
+        TCGv_ptr t_za = get_zarray(s, rv, off, nreg, nsel);
+        TCGv_ptr t, ptr;
+
+        if (fpst >= 0) {
+            ptr = fpstatus_ptr(fpst);
+        } else {
+            ptr = tcg_env;
+        }
+        t = tcg_temp_new_ptr();
+
+        for (int r = 0; r < nreg; ++r) {
+            TCGv_ptr t_zn = vec_full_reg_ptr(s, zn);
+            TCGv_ptr t_zm = vec_full_reg_ptr(s, zm);
+
+            for (int i = 0; i < nsel; ++i) {
+                int o_za = (r * vstride + i) * sizeof(ARMVectorReg);
+                int desc = simd_desc(svl, svl, data | (i << shsel));
+
+                tcg_gen_addi_ptr(t, t_za, o_za);
+                fn(t, t_zn, t_zm, t, ptr, tcg_constant_i32(desc));
+            }
+
+            /*
+             * For multiple-and-single vectors, Zn may wrap.
+             * For multiple vectors, both Zn and Zm are aligned.
+             */
+            zn = (zn + 1) % 32;
+            zm += multi;
+        }
+    }
+    return true;
+}
+
+static bool do_fmlal(DisasContext *s, arg_azz_n *a, bool sub, bool multi)
+{
+    return do_azz_acc_fp(s, a->n, 2, a->rv, a->off, a->zn, a->zm,
+                         (1 << 2) | sub, 1,
+                         multi, FPST_ENV, gen_helper_sve2_fmlal_zzzw_s);
+}
+
+TRANS_FEAT(FMLAL_n1, aa64_sme2, do_fmlal, a, false, false)
+TRANS_FEAT(FMLSL_n1, aa64_sme2, do_fmlal, a, true, false)
+TRANS_FEAT(FMLAL_nn, aa64_sme2, do_fmlal, a, false, true)
+TRANS_FEAT(FMLSL_nn, aa64_sme2, do_fmlal, a, true, true)
+
+static bool do_fmlal_nx(DisasContext *s, arg_azx_n *a, bool sub)
+{
+    return do_azz_acc_fp(s, a->n, 2, a->rv, a->off, a->zn, a->zm,
+                         (a->idx << 3) | (1 << 2) | sub, 1,
+                         false, FPST_ENV, gen_helper_sve2_fmlal_zzxw_s);
+}
+
+TRANS_FEAT(FMLAL_nx, aa64_sme2, do_fmlal_nx, a, false)
+TRANS_FEAT(FMLSL_nx, aa64_sme2, do_fmlal_nx, a, true)
+
+static bool do_bfmlal(DisasContext *s, arg_azz_n *a, bool sub, bool multi)
+{
+    return do_azz_acc_fp(s, a->n, 2, a->rv, a->off, a->zn, a->zm,
+                         0, 0, multi, FPST_ZA,
+                         (!sub ? gen_helper_gvec_bfmlal
+                          : s->fpcr_ah ? gen_helper_gvec_ah_bfmlsl
+                          : gen_helper_gvec_bfmlsl));
+}
+
+TRANS_FEAT(BFMLAL_n1, aa64_sme2, do_bfmlal, a, false, false)
+TRANS_FEAT(BFMLSL_n1, aa64_sme2, do_bfmlal, a, true, false)
+TRANS_FEAT(BFMLAL_nn, aa64_sme2, do_bfmlal, a, false, true)
+TRANS_FEAT(BFMLSL_nn, aa64_sme2, do_bfmlal, a, true, true)
+
+static bool do_bfmlal_nx(DisasContext *s, arg_azx_n *a, bool sub)
+{
+    return do_azz_acc_fp(s, a->n, 2, a->rv, a->off, a->zn, a->zm,
+                         a->idx << 1, 0, false, FPST_ZA,
+                         !sub ? gen_helper_gvec_bfmlal_idx
+                         : s->fpcr_ah ? gen_helper_gvec_ah_bfmlsl_idx
+                         : gen_helper_gvec_bfmlsl_idx);
+}
+
+TRANS_FEAT(BFMLAL_nx, aa64_sme2, do_bfmlal_nx, a, false)
+TRANS_FEAT(BFMLSL_nx, aa64_sme2, do_bfmlal_nx, a, true)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index a6dee08661..9850c19d90 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -261,6 +261,30 @@ SUB_azz_n1_s    11000001 0011 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=4
 SUB_azz_n1_d    11000001 0110 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=2
 SUB_azz_n1_d    11000001 0111 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=4
 
+%off3_x2        0:3 !function=times_2
+%off2_x2        0:2 !function=times_2
+
+@azz_nx1_o3x2   ........ ... . zm:4 . .. ... zn:5 .. ...    \
+                &azz_n off=%off3_x2 rv=%mova_rv
+@azz_nx1_o2x2   ........ ... . zm:4 . .. ... zn:5 ... ..    \
+                &azz_n off=%off2_x2 rv=%mova_rv
+
+FMLAL_n1        11000001 001 0 .... 0 .. 011 ..... 00 ...   @azz_nx1_o3x2 n=1
+FMLAL_n1        11000001 001 0 .... 0 .. 010 ..... 000 ..   @azz_nx1_o2x2 n=2
+FMLAL_n1        11000001 001 1 .... 0 .. 010 ..... 000 ..   @azz_nx1_o2x2 n=4
+
+FMLSL_n1        11000001 001 0 .... 0 .. 011 ..... 01 ...   @azz_nx1_o3x2 n=1
+FMLSL_n1        11000001 001 0 .... 0 .. 010 ..... 010 ..   @azz_nx1_o2x2 n=2
+FMLSL_n1        11000001 001 1 .... 0 .. 010 ..... 010 ..   @azz_nx1_o2x2 n=4
+
+BFMLAL_n1       11000001 001 0 .... 0 .. 011 ..... 10 ...   @azz_nx1_o3x2 n=1
+BFMLAL_n1       11000001 001 0 .... 0 .. 010 ..... 100 ..   @azz_nx1_o2x2 n=2
+BFMLAL_n1       11000001 001 1 .... 0 .. 010 ..... 100 ..   @azz_nx1_o2x2 n=4
+
+BFMLSL_n1       11000001 001 0 .... 0 .. 011 ..... 11 ...   @azz_nx1_o3x2 n=1
+BFMLSL_n1       11000001 001 0 .... 0 .. 010 ..... 110 ..   @azz_nx1_o2x2 n=2
+BFMLSL_n1       11000001 001 1 .... 0 .. 010 ..... 110 ..   @azz_nx1_o2x2 n=4
+
 ### SME2 Multi-vector Multiple Array Vectors
 
 %zn_ax2         6:4 !function=times_2
@@ -280,3 +304,50 @@ SUB_azz_nn_s    11000001 101 ....0 0 .. 110 ....0 11 ...    @azz_2x2_o3
 SUB_azz_nn_s    11000001 101 ...01 0 .. 110 ...00 11 ...    @azz_4x4_o3
 SUB_azz_nn_d    11000001 111 ....0 0 .. 110 ....0 11 ...    @azz_2x2_o3
 SUB_azz_nn_d    11000001 111 ...01 0 .. 110 ...00 11 ...    @azz_4x4_o3
+
+@azz_2x2_o2x2   ........ ... ..... . .. ... ..... ... ..    \
+                &azz_n n=2 rv=%mova_rv zn=%zn_ax2 zm=%zm_ax2 off=%off2_x2
+@azz_4x4_o2x2   ........ ... ..... . .. ... ..... ... ..    \
+                &azz_n n=4 rv=%mova_rv zn=%zn_ax4 zm=%zm_ax4 off=%off2_x2
+
+FMLAL_nn        11000001 101 ....0 0 .. 010 ....0 000 ..    @azz_2x2_o2x2
+FMLAL_nn        11000001 101 ...01 0 .. 010 ...00 000 ..    @azz_4x4_o2x2
+
+FMLSL_nn        11000001 101 ....0 0 .. 010 ....0 010 ..    @azz_2x2_o2x2
+FMLSL_nn        11000001 101 ...01 0 .. 010 ...00 010 ..    @azz_4x4_o2x2
+
+BFMLAL_nn       11000001 101 ....0 0 .. 010 ....0 100 ..    @azz_2x2_o2x2
+BFMLAL_nn       11000001 101 ...01 0 .. 010 ...00 100 ..    @azz_4x4_o2x2
+
+BFMLSL_nn       11000001 101 ....0 0 .. 010 ....0 110 ..    @azz_2x2_o2x2
+BFMLSL_nn       11000001 101 ...01 0 .. 010 ...00 110 ..    @azz_4x4_o2x2
+
+### SME2 Multi-vector Indexed
+
+&azx_n          n off rv zn zm idx
+
+%idx3_15_10     15:1 10:2
+%idx2_10_2      10:2 2:1
+
+@azx_1x1_o3x2   ........ .... zm:4 . .. . .. zn:5 .. ...    \
+                &azx_n n=1 rv=%mova_rv off=%off3_x2 idx=%idx3_15_10
+@azx_2x1_o2x2   ........ .... zm:4 . .. . .. ..... .. ...   \
+                &azx_n n=2 rv=%mova_rv off=%off2_x2 zn=%zn_ax2 idx=%idx2_10_2
+@azx_4x1_o2x2   ........ .... zm:4 . .. . .. ..... .. ...   \
+                &azx_n n=4 rv=%mova_rv off=%off2_x2 zn=%zn_ax4 idx=%idx2_10_2
+
+FMLAL_nx        11000001 1000 .... . .. 1 .. ..... 00 ...   @azx_1x1_o3x2
+FMLAL_nx        11000001 1001 .... 0 .. 1 .. ....0 00 ...   @azx_2x1_o2x2
+FMLAL_nx        11000001 1001 .... 1 .. 1 .. ...00 00 ...   @azx_4x1_o2x2
+
+FMLSL_nx        11000001 1000 .... . .. 1 .. ..... 01 ...   @azx_1x1_o3x2
+FMLSL_nx        11000001 1001 .... 0 .. 1 .. ....0 01 ...   @azx_2x1_o2x2
+FMLSL_nx        11000001 1001 .... 1 .. 1 .. ...00 01 ...   @azx_4x1_o2x2
+
+BFMLAL_nx       11000001 1000 .... . .. 1 .. ..... 10 ...   @azx_1x1_o3x2
+BFMLAL_nx       11000001 1001 .... 0 .. 1 .. ....0 10 ...   @azx_2x1_o2x2
+BFMLAL_nx       11000001 1001 .... 1 .. 1 .. ...00 10 ...   @azx_4x1_o2x2
+
+BFMLSL_nx       11000001 1000 .... . .. 1 .. ..... 11 ...   @azx_1x1_o3x2
+BFMLSL_nx       11000001 1001 .... 0 .. 1 .. ....0 11 ...   @azx_2x1_o2x2
+BFMLSL_nx       11000001 1001 .... 1 .. 1 .. ...00 11 ...   @azx_4x1_o2x2
-- 
2.43.0


