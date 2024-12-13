Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156BCE77183
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9YJ-0001Cq-CV; Fri, 13 Dec 2024 12:34:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XB-00073K-Ux
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:02 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9X9-0001XE-Vu
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:01 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3862d16b4f5so1351628f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111177; x=1734715977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=54cqaTCZDwpJNs8EfB+g2AzvMa88o+LYRMX74oNfRfM=;
 b=Ncn602QYC96hpJKHX5Q5GVzMi/P+uqX/Ox5sH2Qe+3ggRfJ6Rceee1+Q43+mEpLWvg
 XwN/5tCopn2KnPQTKDi2dEXEdWPvSI+0wq4T0EO/zYQXG7MWMZ+NxwK0k6hiZZv7fjCM
 UzPH1sxhn8Q7Sp0jvNSUUwvNs0b+wwBTi4YUZwTQy1bav6iai/lAKNyaitx0BiIRNZ4C
 2oTQxOJKb7PWa/ZRPACKHEmzwfIympE05kE9zGH9xSFJe/O2Q2tHIIa01YMAFMmkKQOT
 Eq3q+5NOdDnEZ8qVtnOlQcdNphRLKuFpdCtHFnJoGQcsgKI0avSWj/61qXaD53u5IdOJ
 Rnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111177; x=1734715977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=54cqaTCZDwpJNs8EfB+g2AzvMa88o+LYRMX74oNfRfM=;
 b=WK95+a5hCwX4ZlJnfM9OmwfLeIW9ktOFmP2+3Hvd2kBxcVMLEpnFQQf+3L8S7Z8Ulm
 +VaEgNoTlQdjPSpHFF2QWq6oD4ajdhw/Nh/Gd1B9nnJK1MqjL9nnVPRMJKL2L4NbwHIz
 d5xfcut5zqzXsyRZvZcr6Qoo2N6l4/MqdQG7hgnSXR6YI3klDzzv6kW/yYLPwDcd1Xdj
 Tx5qARsUlmCrorUsUvlatmqMXhiEFLwalYJHXr2PHzTg1gDryJdTSC1wYq+DAFHjzhJy
 V8uITI2vkFc281wNLBeGxaz7ZmYpRoafbAa8q1qgGSzMPahb9gDiG6fyssw1rhfZYxOU
 xXDA==
X-Gm-Message-State: AOJu0YzCn2MvRbSUyVurH2w/m3WArhKXhF4PS4zVU6p2j2Gn+pYRF5/T
 uDGq7AOtEqBKpMQY6o3xcLzlnl/4NUX+QylQIgi0VuT8ix3SEu2vE/iu16t+azJ08mEDgocqiZB
 Y
X-Gm-Gg: ASbGnctIypfPoDfYJxWInuRkjn4u+4ox3Lw1GPpZegDaKC377xMemOroohlFH70WhJl
 k+Mj5SSp2ZDKKdvsV7mS7WlnyNzL2czB2Pp+cy53Z1v19xyXFEsRrj8mldxk67ZsywHYCT2oP4e
 iGugbzP8ixHawmfsCU86DfPQyz3RdfOknPr5pgzv0En1oytQsPmA9U3aLX68swEZhz4X4t8hUU3
 vxB61e+0b7G7d+O78JbHgnCyvFDaHExKHmiID09WIC8rMJ4Fn6iR9pqF5Ik3A==
X-Google-Smtp-Source: AGHT+IHCxSILmbCSf99kbe5BCTj3g8eWTxKtO24BWa1cRWY0/LoDYsQpJUjsrFiCLwtZxdJ9JeTa+w==
X-Received: by 2002:a05:6000:186e:b0:385:df17:2148 with SMTP id
 ffacd0b85a97d-3878884747emr6883800f8f.20.1734111176974; 
 Fri, 13 Dec 2024 09:32:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.32.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:32:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/85] target/arm: Convert FMOV, FABS,
 FNEG (scalar) to decodetree
Date: Fri, 13 Dec 2024 17:31:28 +0000
Message-Id: <20241213173229.3308926-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-25-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |   7 +++
 target/arm/tcg/translate-a64.c | 105 +++++++++++++++++++++++----------
 2 files changed, 81 insertions(+), 31 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 7868b1cb241..b9cc8963da8 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -47,6 +47,7 @@
 @rr_h           ........ ... ..... ...... rn:5 rd:5     &rr_e esz=1
 @rr_d           ........ ... ..... ...... rn:5 rd:5     &rr_e esz=3
 @rr_sd          ........ ... ..... ...... rn:5 rd:5     &rr_e esz=%esz_sd
+@rr_hsd         ........ ... ..... ...... rn:5 rd:5     &rr_e esz=%esz_hsd
 
 @rrr_b          ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=0
 @rrr_h          ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=1
@@ -1321,6 +1322,12 @@ FMAXV_s         0110 1110 00 11000 01111 10 ..... .....     @rr_q1e2
 FMINV_h         0.00 1110 10 11000 01111 10 ..... .....     @qrr_h
 FMINV_s         0110 1110 10 11000 01111 10 ..... .....     @rr_q1e2
 
+# Floating-point data processing (1 source)
+
+FMOV_s          00011110 .. 1 000000 10000 ..... .....      @rr_hsd
+FABS_s          00011110 .. 1 000001 10000 ..... .....      @rr_hsd
+FNEG_s          00011110 .. 1 000010 10000 ..... .....      @rr_hsd
+
 # Floating-point Immediate
 
 FMOVI_s         0001 1110 .. 1 imm:8 100 00000 rd:5         esz=%esz_hsd
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3c1784593a4..ca2b95510e2 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8283,6 +8283,67 @@ static bool trans_CSEL(DisasContext *s, arg_CSEL *a)
     return true;
 }
 
+typedef struct FPScalar1Int {
+    void (*gen_h)(TCGv_i32, TCGv_i32);
+    void (*gen_s)(TCGv_i32, TCGv_i32);
+    void (*gen_d)(TCGv_i64, TCGv_i64);
+} FPScalar1Int;
+
+static bool do_fp1_scalar_int(DisasContext *s, arg_rr_e *a,
+                              const FPScalar1Int *f)
+{
+    switch (a->esz) {
+    case MO_64:
+        if (fp_access_check(s)) {
+            TCGv_i64 t = read_fp_dreg(s, a->rn);
+            f->gen_d(t, t);
+            write_fp_dreg(s, a->rd, t);
+        }
+        break;
+    case MO_32:
+        if (fp_access_check(s)) {
+            TCGv_i32 t = read_fp_sreg(s, a->rn);
+            f->gen_s(t, t);
+            write_fp_sreg(s, a->rd, t);
+        }
+        break;
+    case MO_16:
+        if (!dc_isar_feature(aa64_fp16, s)) {
+            return false;
+        }
+        if (fp_access_check(s)) {
+            TCGv_i32 t = read_fp_hreg(s, a->rn);
+            f->gen_h(t, t);
+            write_fp_sreg(s, a->rd, t);
+        }
+        break;
+    default:
+        return false;
+    }
+    return true;
+}
+
+static const FPScalar1Int f_scalar_fmov = {
+    tcg_gen_mov_i32,
+    tcg_gen_mov_i32,
+    tcg_gen_mov_i64,
+};
+TRANS(FMOV_s, do_fp1_scalar_int, a, &f_scalar_fmov)
+
+static const FPScalar1Int f_scalar_fabs = {
+    gen_vfp_absh,
+    gen_vfp_abss,
+    gen_vfp_absd,
+};
+TRANS(FABS_s, do_fp1_scalar_int, a, &f_scalar_fabs)
+
+static const FPScalar1Int f_scalar_fneg = {
+    gen_vfp_negh,
+    gen_vfp_negs,
+    gen_vfp_negd,
+};
+TRANS(FNEG_s, do_fp1_scalar_int, a, &f_scalar_fneg)
+
 /* Floating-point data-processing (1 source) - half precision */
 static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
 {
@@ -8291,15 +8352,6 @@ static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
     TCGv_i32 tcg_res = tcg_temp_new_i32();
 
     switch (opcode) {
-    case 0x0: /* FMOV */
-        tcg_gen_mov_i32(tcg_res, tcg_op);
-        break;
-    case 0x1: /* FABS */
-        gen_vfp_absh(tcg_res, tcg_op);
-        break;
-    case 0x2: /* FNEG */
-        gen_vfp_negh(tcg_res, tcg_op);
-        break;
     case 0x3: /* FSQRT */
         fpst = fpstatus_ptr(FPST_FPCR_F16);
         gen_helper_sqrt_f16(tcg_res, tcg_op, fpst);
@@ -8327,6 +8379,9 @@ static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
         gen_helper_advsimd_rinth(tcg_res, tcg_op, fpst);
         break;
     default:
+    case 0x0: /* FMOV */
+    case 0x1: /* FABS */
+    case 0x2: /* FNEG */
         g_assert_not_reached();
     }
 
@@ -8345,15 +8400,6 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
     tcg_res = tcg_temp_new_i32();
 
     switch (opcode) {
-    case 0x0: /* FMOV */
-        tcg_gen_mov_i32(tcg_res, tcg_op);
-        goto done;
-    case 0x1: /* FABS */
-        gen_vfp_abss(tcg_res, tcg_op);
-        goto done;
-    case 0x2: /* FNEG */
-        gen_vfp_negs(tcg_res, tcg_op);
-        goto done;
     case 0x3: /* FSQRT */
         gen_helper_vfp_sqrts(tcg_res, tcg_op, tcg_env);
         goto done;
@@ -8389,6 +8435,9 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
         gen_fpst = gen_helper_frint64_s;
         break;
     default:
+    case 0x0: /* FMOV */
+    case 0x1: /* FABS */
+    case 0x2: /* FNEG */
         g_assert_not_reached();
     }
 
@@ -8413,22 +8462,10 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
     TCGv_ptr fpst;
     int rmode = -1;
 
-    switch (opcode) {
-    case 0x0: /* FMOV */
-        gen_gvec_fn2(s, false, rd, rn, tcg_gen_gvec_mov, 0);
-        return;
-    }
-
     tcg_op = read_fp_dreg(s, rn);
     tcg_res = tcg_temp_new_i64();
 
     switch (opcode) {
-    case 0x1: /* FABS */
-        gen_vfp_absd(tcg_res, tcg_op);
-        goto done;
-    case 0x2: /* FNEG */
-        gen_vfp_negd(tcg_res, tcg_op);
-        goto done;
     case 0x3: /* FSQRT */
         gen_helper_vfp_sqrtd(tcg_res, tcg_op, tcg_env);
         goto done;
@@ -8461,6 +8498,9 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
         gen_fpst = gen_helper_frint64_d;
         break;
     default:
+    case 0x0: /* FMOV */
+    case 0x1: /* FABS */
+    case 0x2: /* FNEG */
         g_assert_not_reached();
     }
 
@@ -8581,7 +8621,7 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
             goto do_unallocated;
         }
         /* fall through */
-    case 0x0 ... 0x3:
+    case 0x3:
     case 0x8 ... 0xc:
     case 0xe ... 0xf:
         /* 32-to-32 and 64-to-64 ops */
@@ -8631,6 +8671,9 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
 
     default:
     do_unallocated:
+    case 0x0: /* FMOV */
+    case 0x1: /* FABS */
+    case 0x2: /* FNEG */
         unallocated_encoding(s);
         break;
     }
-- 
2.34.1


