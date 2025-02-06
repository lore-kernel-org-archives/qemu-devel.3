Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A9AC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg80u-0008SV-Bz; Thu, 06 Feb 2025 14:58:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80P-0007Ik-Oi
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:45 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80L-0000ae-HA
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:45 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21f2cfd821eso24839705ad.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 11:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738871860; x=1739476660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aqQSNjJPfJiJWB/rQi/NVdAo28lt+Z/CJCxR799djcw=;
 b=BIZ7qlFSp/jl0z19CjqYNqzBJpUv8verUef7MLUA6ZkKhj9Tuaq63N9PZECJdN13xd
 wr6ruIevMQSZlPO7jyjD+9N4NWvv1i/ziQRdf6k7HArWQ9GKZ0O2NMPyVEPAmOpRTqw2
 Pebdz5orYVchRwMNRdrt2q9cL0WNgkZex4TvNFNiYNqUTNaY7WWmXoHfEmUQQub6QxwY
 ZW9PdY9WnSy4Igu3wILBm5caMPlzqYZ5jLxhDPVzqkOzbbze4XpciGBKQMlw0RHgfRVE
 NUfThD6OYRUH+0uRxSnaSbZF/HmAQEcByJX/y1o5f+qakHy1tlBbSeEV18eO7+tZeRm7
 4y+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871860; x=1739476660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aqQSNjJPfJiJWB/rQi/NVdAo28lt+Z/CJCxR799djcw=;
 b=HQcP5zwCzLXG7gbfAUOb6tpBwMtCx8MxkGDcXiN/GfU30lHf4lDoJz5Xgk80A+GhK7
 z3YmnXh5xjt+iMdIOI/zgS4XWrSyv6Cmk1SRwMjdll6HAVfXJXfbzelDP07DAP/lVnQB
 t3vNrpxDeRkWqaUJsda2je0O1NqYJ2pW6BWpan2nhK2ko1gC+yXkVZ3ziGN0qPdU4SUf
 pI7lX3n1AcM12mjsHrZDkL0eQZ8Z3FP+hwisA8fzx0mYa/7gS2wb7LlR3gXlW8Z0LlhD
 X+fCEtfoKAvDKWcCPlLv9FJxjDE5IpbBKDNnJwcQND1lYMmJPsWDTdhJhPNHjD3X/5Uz
 Qz3Q==
X-Gm-Message-State: AOJu0Yys8aIQnsdI1/FtCSMz0q1FD15JBiB3gg52NbhyfeoleAxCB3qX
 EUxw9oi6gjqgKBVT6eVGN2rQXMI458/rHaAcKJH40TedFXFdwkkyHXD5QxLYitDnGjxDT6RYFKG
 c
X-Gm-Gg: ASbGncv3Rgfw6pMn3Vr4WJ3yf90FnuAWRtB4nfI432H4qbKJJiicIfNb1rFBmLtqwJ4
 43bf3qXhlMIknt1ioN87LLrW1LJJL01hL3BhEz6GuIHczaEgRIn1PotIpc+I/GJa9n58aUn0c2L
 8aNR4b3nAKxkZMkYgfAklRLjeEosAE1jrVDOdqI89MWX2ZsBevfJ/x1u9YnGw53zp7zVEpfWx2Y
 rp7Xjlx0L6gwKH1wYca3tJ4UDe9/kPqAJL+EtXmlDWDARGavEoCrUs0W1eH8elOW2v+3+o4JAXc
 8p0pZ2eoPF32Z/CnVNPF1KEhV2lrGwcDKi3JJantdtZ0sQA=
X-Google-Smtp-Source: AGHT+IFHynd1MuOFluk7gu/xv00m14W+MIyM6upI/njhDN6m0YUIrAnV+DfDbd4/0bPyXm7jskzzMA==
X-Received: by 2002:a05:6a21:3405:b0:1e2:2e4:689a with SMTP id
 adf61e73a8af0-1ee03b762b2mr993415637.41.1738871859877; 
 Thu, 06 Feb 2025 11:57:39 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c16370sm1666993b3a.152.2025.02.06.11.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:57:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 31/61] target/arm: Implement SME2 FMLAL, BFMLAL
Date: Thu,  6 Feb 2025 11:56:45 -0800
Message-ID: <20250206195715.2150758-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 93 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sme.decode      | 71 ++++++++++++++++++++++++++
 2 files changed, 164 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 8aae70201c..ec12bfd089 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -751,3 +751,96 @@ TRANS_FEAT(ADD_azz_nn_s, aa64_sme2, do_azz_nn, a, MO_32, tcg_gen_gvec_add_var)
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
+    if (sme_sm_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        int vstride = svl / nreg;
+        TCGv_ptr t_za = get_zarray(s, rv, off, nreg);
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
+    return do_azz_acc_fp(s, a->n, 2, a->rv, a->off, a->zn, a->zm, sub, 1,
+                         multi, FPST_ZA, gen_helper_gvec_bfmlal);
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
+                         (a->idx << 2) | sub, 1,
+                         false, FPST_ZA, gen_helper_gvec_bfmlal_idx);
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


