Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F00BC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhP0-0002Bd-FB; Fri, 04 Jul 2025 10:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhLo-0003xl-7f
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:19 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhLj-0007uB-I1
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:15 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-73b0ea4e138so827680a34.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639108; x=1752243908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZfH+TBNr4UGCBawjnJleJmZyYrHxkG1+R38RVn3NA/g=;
 b=fSswHqjYvpljtFScCID9TfEhfG1fLeQGFulHYwlReVbYT0qsYdoCspkgJncCOatqrE
 fXl7vB6WsHU6ml+tyV3g+HtvpmsIt5JbWjz7to8p/uf9UHX3osrUUVBY9O2YUFym25cK
 c6j392MI7Q/opkSwmrsgP9yMYXpMtUt1yf5rMUgwu+CnPcM1DGghZ6Ptvp5wEDk6Iz4v
 QTYYFfOGels6lFr9S8nuA03Wh2etafo4OIcu6J1USaC6c4KvBQKWqK33b5DKYl6Nx2hW
 82pp//OgeJswhsL8nMbY8CJFDWYrhoKqxRBVjuB4OmWR2KE5G23AGuK57K2JUtIIAus7
 zWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639108; x=1752243908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZfH+TBNr4UGCBawjnJleJmZyYrHxkG1+R38RVn3NA/g=;
 b=OghSzYhy3HbiWIR3UK4JmaGFkPhjNIrBOgVTkK9l4rKhXz8wGCw8OGQ8OfkQKVw/eZ
 MUXfdkzgs51EOeEzr4/J60WTWTBzGqIe1Z0CnYaju510jET74JGzKoUSK5NWDwf2QCtK
 kQx1WyLIJGsLWEAc7mT1GWgwemebSNgE36wOTn5uplL/E2gwCrpys2hX7nkMh8JfDOWF
 wIf7dQH95pi4Bg4XdI6yUgK8ZZ1PuBA+j6oUG7uO3RZzFbbFrXVrPpq/w2VJ75PyvD+l
 I+HznZ7lzeuzulKCVdy2DYmE2L0lNiGyCwj+X+fwC/JstWVnEbpN2AZUVaxYFoE7TJyf
 eWIA==
X-Gm-Message-State: AOJu0YyXc6b8j4EGWPmi8VPbRofJ/cZH9ZF3sYnSQof20jOqb1qIFF0C
 c/ArpQ39PptiJtfaUqzDP3NxLWbX9yboAE3ofCp81VCDqmCWXTsfDb0EuqgOwGmrWOxSHL1U87f
 XZltKIpc=
X-Gm-Gg: ASbGncu0vWgL61I4JlN8Nq6oddOziLZRxfj8jMgyTIwJ8ZU2Yw3evMKqIn6k8RsNgIu
 MmwdPOIYty2xTPsNMyD93vRJOmx3vSIY7HjUKKTGXJMOXIoFQPoZ7BFFhLhcmdeeWWB0CKlUWPb
 /lIrvBu8MfFi86k/e9N7JYiYKJ4rt2Eu5tBKpq+80XLeZvHe/b+DF15Ahj0xOrRjKZ/FypuzHO5
 GpCbaYaVegrMeLry15uev/SEisxVAPpyWui8yTt98/gI3F9CAwuFXIw8S9hyfS8yqtI2+TVk014
 PO/Q7HbDtf+JO8A1zvrllGOwZ4B1jNq3wkrr0Ky2gAX3u5l+eMn5f3JoYzY+QT1CoIopgaxfjks
 e1ms14bzcfdICN90RRQ4IJj4A3RzabuszJAQkJ1+XgpXoR5Fj
X-Google-Smtp-Source: AGHT+IG4XszohT5asPTVy7IJx1j57vvpKvCFGf3WGTqe6b69ujRCoPgZt0v6NHB97/C/acJSbvu2hw==
X-Received: by 2002:a05:6830:498f:b0:72b:a465:d955 with SMTP id
 46e09a7af769-73ca661fa7bmr1529963a34.12.1751639108457; 
 Fri, 04 Jul 2025 07:25:08 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac5eesm310233eaf.29.2025.07.04.07.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:25:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 050/108] target/arm: Implement SME2 FADD, FSUB, BFADD, BFSUB
Date: Fri,  4 Jul 2025 08:20:13 -0600
Message-ID: <20250704142112.1018902-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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
 target/arm/tcg/helper.h        |  2 ++
 target/arm/tcg/translate-sme.c | 44 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/vec_helper.c    |  2 ++
 target/arm/tcg/sme.decode      | 25 +++++++++++++++++++
 4 files changed, 73 insertions(+)

diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
index 37dd384659..392bf7b9b5 100644
--- a/target/arm/tcg/helper.h
+++ b/target/arm/tcg/helper.h
@@ -731,10 +731,12 @@ DEF_HELPER_FLAGS_4(gvec_fclt0_d, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fadd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fadd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fadd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_bfadd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fsub_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fsub_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fsub_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_bfsub, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fmul_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fmul_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 3f9a80248a..664fdd86aa 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1072,6 +1072,50 @@ TRANS_FEAT(BFMLA_nx, aa64_sme_b16b16, do_fmla_nx, a, FPST_ZA,
 TRANS_FEAT(BFMLS_nx, aa64_sme_b16b16, do_fmla_nx, a, FPST_ZA,
            s->fpcr_ah ? gen_helper_gvec_ah_bfmls_idx : gen_helper_gvec_bfmls_idx)
 
+static bool do_faddsub(DisasContext *s, arg_az_n *a, ARMFPStatusFlavour fpst,
+                       gen_helper_gvec_3_ptr *fn)
+{
+    if (sme_smza_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        int n = a->n;
+        int zm = a->zm;
+        int vstride = svl / n;
+        TCGv_ptr t_za = get_zarray(s, a->rv, a->off, n, 0);
+        TCGv_ptr ptr = fpstatus_ptr(fpst);
+        TCGv_ptr t = tcg_temp_new_ptr();
+
+        for (int r = 0; r < n; ++r) {
+            TCGv_ptr t_zm = vec_full_reg_ptr(s, zm + r);
+            int o_za = r * vstride * sizeof(ARMVectorReg);
+            int desc = simd_desc(svl, svl, 0);
+
+            tcg_gen_addi_ptr(t, t_za, o_za);
+            fn(t, t, t_zm, ptr, tcg_constant_i32(desc));
+        }
+    }
+    return true;
+}
+
+TRANS_FEAT(FADD_nn_h, aa64_sme_f16f16, do_faddsub, a,
+           FPST_ZA_F16, gen_helper_gvec_fadd_h)
+TRANS_FEAT(FSUB_nn_h, aa64_sme_f16f16, do_faddsub, a,
+           FPST_ZA_F16, gen_helper_gvec_fsub_h)
+
+TRANS_FEAT(FADD_nn_s, aa64_sme2, do_faddsub, a,
+           FPST_ZA, gen_helper_gvec_fadd_s)
+TRANS_FEAT(FSUB_nn_s, aa64_sme2, do_faddsub, a,
+           FPST_ZA, gen_helper_gvec_fsub_s)
+
+TRANS_FEAT(FADD_nn_d, aa64_sme2_f64f64, do_faddsub, a,
+           FPST_ZA, gen_helper_gvec_fadd_d)
+TRANS_FEAT(FSUB_nn_d, aa64_sme2_f64f64, do_faddsub, a,
+           FPST_ZA, gen_helper_gvec_fsub_d)
+
+TRANS_FEAT(BFADD_nn, aa64_sme_b16b16, do_faddsub, a,
+           FPST_ZA, gen_helper_gvec_bfadd)
+TRANS_FEAT(BFSUB_nn, aa64_sme_b16b16, do_faddsub, a,
+           FPST_ZA, gen_helper_gvec_bfsub)
+
 /*
  * Expand array multi-vector single (n1), array multi-vector (nn),
  * and array multi-vector indexed (nx), for integer accumulate.
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 51bfd767a3..d4ee6f4d29 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1470,10 +1470,12 @@ void HELPER(NAME)(void *vd, void *vn, void *vm,                            \
 DO_3OP(gvec_fadd_h, float16_add, float16)
 DO_3OP(gvec_fadd_s, float32_add, float32)
 DO_3OP(gvec_fadd_d, float64_add, float64)
+DO_3OP(gvec_bfadd, bfloat16_add, bfloat16)
 
 DO_3OP(gvec_fsub_h, float16_sub, float16)
 DO_3OP(gvec_fsub_s, float32_sub, float32)
 DO_3OP(gvec_fsub_d, float64_sub, float64)
+DO_3OP(gvec_bfsub, bfloat16_sub, bfloat16)
 
 DO_3OP(gvec_fmul_h, float16_mul, float16)
 DO_3OP(gvec_fmul_s, float32_mul, float32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index b3dd3bffc3..0badc8f9fa 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -510,6 +510,31 @@ FMLS_nn_h       11000001 101 ...01 0 .. 100 ...00 11 ...    @azz_4x4_o3
 FMLS_nn_s       11000001 101 ...01 0 .. 110 ...00 01 ...    @azz_4x4_o3
 FMLS_nn_d       11000001 111 ...01 0 .. 110 ...00 01 ...    @azz_4x4_o3
 
+&az_n           n off rv zm
+@az_2x2_o3      ........ ... ..... . .. ... ..... .. off:3  \
+                &az_n n=2 rv=%mova_rv zm=%zn_ax2
+@az_4x4_o3      ........ ... ..... . .. ... ..... .. off:3  \
+                &az_n n=4 rv=%mova_rv zm=%zn_ax4
+
+FADD_nn_h       11000001 101 00100 0 .. 111 ....0 00 ...    @az_2x2_o3
+FADD_nn_s       11000001 101 00000 0 .. 111 ....0 00 ...    @az_2x2_o3
+FADD_nn_d       11000001 111 00000 0 .. 111 ....0 00 ...    @az_2x2_o3
+FADD_nn_h       11000001 101 00101 0 .. 111 ...00 00 ...    @az_4x4_o3
+FADD_nn_s       11000001 101 00001 0 .. 111 ...00 00 ...    @az_4x4_o3
+FADD_nn_d       11000001 111 00001 0 .. 111 ...00 00 ...    @az_4x4_o3
+
+FSUB_nn_h       11000001 101 00100 0 .. 111 ....0 01 ...    @az_2x2_o3
+FSUB_nn_s       11000001 101 00000 0 .. 111 ....0 01 ...    @az_2x2_o3
+FSUB_nn_d       11000001 111 00000 0 .. 111 ....0 01 ...    @az_2x2_o3
+FSUB_nn_h       11000001 101 00101 0 .. 111 ...00 01 ...    @az_4x4_o3
+FSUB_nn_s       11000001 101 00001 0 .. 111 ...00 01 ...    @az_4x4_o3
+FSUB_nn_d       11000001 111 00001 0 .. 111 ...00 01 ...    @az_4x4_o3
+
+BFADD_nn        11000001 111 00100 0 .. 111 ....0 00 ...    @az_2x2_o3
+BFADD_nn        11000001 111 00101 0 .. 111 ...00 00 ...    @az_4x4_o3
+BFSUB_nn        11000001 111 00100 0 .. 111 ....0 01 ...    @az_2x2_o3
+BFSUB_nn        11000001 111 00101 0 .. 111 ...00 01 ...    @az_4x4_o3
+
 ### SME2 Multi-vector Indexed
 
 &azx_n          n off rv zn zm idx
-- 
2.43.0


