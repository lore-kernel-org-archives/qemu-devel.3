Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C4AC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mny-0002bM-49; Sun, 05 May 2024 21:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmx-0008Oy-4f
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:05:15 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmR-0002YN-36
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:05:06 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2a2d82537efso913910a91.2
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957474; x=1715562274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cvy/xAJhwcIPOwkcc5Fig2qaysU0XFh1mpPnIeZDXIg=;
 b=n8f2wrxcCqWCa05eiV4A421xF+k2OD+YXZ2lPJ6cLh6p0rRA/pQxkXK39DeEo4Va+/
 hQpXLlfOyU2q1rf9l9KNF+8BY9opeLayeuHxQljMuEop3vmq1d9UZEdS+79YjPXEsxwo
 Rsd+YR633tK0kcz2LaXiSgGCoMj05npcvVL1HsBkA9fZFDbdrYVvRND9InHk3SRaFQZY
 h5t9m8FraGWiksv8+91o3jJvzx86qp/O5VcZrREcGNkCGu+gOQ+PUWizVZSX4flwmr3v
 akTJ2ODemNQePYIMqkJEevOaMJvQOBXbOCBm3AyILjx7yVGK1iJdVpSxSEgfu53n3q54
 YsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957474; x=1715562274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cvy/xAJhwcIPOwkcc5Fig2qaysU0XFh1mpPnIeZDXIg=;
 b=Xs3SLpXhBZ4s/24Q+Gkle3v0FFWcuNbeVONA+RulbgMRt2TR4smL9nA0w/St1qJ1US
 S/Zzxw5CzWdg2k1dNThPNtB5kR5ysE2pNuhPs48LtwZViGJORoi1o2QMO3W0nBZilmDR
 oRF7xCiT+vm2Uu7ZxdRJ3XFQF1icjIuML4H0UyJu3Bq/3gZYw2EY2eHSpHKKKqnRytpI
 rWxeECJSKMj25OFECxKEJaxdQ+Fc+F0K6K2p01UcIIoQCdwIECwqBa7NNclNMyzvMJ0I
 4tkUbadbM+N8XEGn07ansrSEYr0b3O+kyQiUeJTNQ/y0WIsdsj3IilRrLgD6C9LTuiee
 djGA==
X-Gm-Message-State: AOJu0YzZZdTxgF1crvY64KSb5iiCp7E27THA9WaeqgU+grcPQil6fXoy
 fznfgmf7mSYl5fAWmwdUCSHkkcyMhWAjEz4g4DmuyKL4ZoQXhkjZhNfHnEv1UjzITxU5byE5tol
 t
X-Google-Smtp-Source: AGHT+IFP4ZKr+EvUN1C5CPVu7POR6R8WcdDbXfLEGBWWLF39KmPKITXykNE8nzFvfcmK4n9H2v9V8A==
X-Received: by 2002:a17:90b:39cc:b0:2b4:fcfd:7505 with SMTP id
 of12-20020a17090b39cc00b002b4fcfd7505mr2487437pjb.36.1714957473778; 
 Sun, 05 May 2024 18:04:33 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 pv7-20020a17090b3c8700b002a5f44353d2sm8958232pjb.7.2024.05.05.18.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:04:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 35/57] target/arm: Convert SUQADD, USQADD to decodetree
Date: Sun,  5 May 2024 18:03:41 -0700
Message-Id: <20240506010403.6204-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

These are faux 2-operand instructions, reading from rd.
Sort them next to the other three-operand same insns for clarity.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a64.decode      |  8 +++++
 target/arm/tcg/translate-a64.c | 64 ++++------------------------------
 2 files changed, 14 insertions(+), 58 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 5eced906a9..7cea0d2721 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -45,6 +45,7 @@
 @rrr_sd         ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=%esz_sd
 @rrr_hsd        ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=%esz_hsd
 @rrr_e          ........ esz:2 . rm:5 ...... rn:5 rd:5  &rrr_e
+@r2r_e          ........ esz:2 . ..... ...... rm:5 rd:5 &rrr_e rn=%rd
 
 @rrx_h          ........ .. .. rm:4 .... . . rn:5 rd:5  &rrx_e esz=1 idx=%hlm
 @rrx_s          ........ .. . rm:5  .... . . rn:5 rd:5  &rrx_e esz=2 idx=%hl
@@ -60,6 +61,7 @@
 @qrrr_h         . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=1
 @qrrr_sd        . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=%esz_sd
 @qrrr_e         . q:1 ...... esz:2 . rm:5 ...... rn:5 rd:5  &qrrr_e
+@qr2r_e         . q:1 ...... esz:2 . ..... ...... rm:5 rd:5 &qrrr_e rn=%rd
 
 @qrrx_h         . q:1 .. .... .. .. rm:4 .... . . rn:5 rd:5 \
                 &qrrx_e esz=1 idx=%hlm
@@ -750,6 +752,9 @@ UQADD_s         0111 1110 ..1 ..... 00001 1 ..... ..... @rrr_e
 SQSUB_s         0101 1110 ..1 ..... 00101 1 ..... ..... @rrr_e
 UQSUB_s         0111 1110 ..1 ..... 00101 1 ..... ..... @rrr_e
 
+SUQADD_s        0101 1110 ..1 00000 00111 0 ..... ..... @r2r_e
+USQADD_s        0111 1110 ..1 00000 00111 0 ..... ..... @r2r_e
+
 ### Advanced SIMD scalar pairwise
 
 FADDP_s         0101 1110 0011 0000 1101 10 ..... ..... @rr_h
@@ -868,6 +873,9 @@ UQADD_v         0.10 1110 ..1 ..... 00001 1 ..... ..... @qrrr_e
 SQSUB_v         0.00 1110 ..1 ..... 00101 1 ..... ..... @qrrr_e
 UQSUB_v         0.10 1110 ..1 ..... 00101 1 ..... ..... @qrrr_e
 
+SUQADD_v        0.00 1110 ..1 00000 00111 0 ..... ..... @qr2r_e
+USQADD_v        0.10 1110 ..1 00000 00111 0 ..... ..... @qr2r_e
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5d91263ebb..ccc30d61f3 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5097,6 +5097,8 @@ TRANS(SQADD_s, do_satacc_s, a, MO_SIGN, MO_SIGN, gen_sqadd_bhs, gen_sqadd_d)
 TRANS(SQSUB_s, do_satacc_s, a, MO_SIGN, MO_SIGN, gen_sqsub_bhs, gen_sqsub_d)
 TRANS(UQADD_s, do_satacc_s, a, 0, 0, gen_uqadd_bhs, gen_uqadd_d)
 TRANS(UQSUB_s, do_satacc_s, a, 0, 0, gen_uqsub_bhs, gen_uqsub_d)
+TRANS(SUQADD_s, do_satacc_s, a, MO_SIGN, 0, gen_suqadd_bhs, gen_suqadd_d)
+TRANS(USQADD_s, do_satacc_s, a, 0, MO_SIGN, gen_usqadd_bhs, gen_usqadd_d)
 
 static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a,
                           gen_helper_gvec_3_ptr * const fns[3])
@@ -5340,6 +5342,8 @@ TRANS(SQADD_v, do_gvec_fn3, a, gen_gvec_sqadd_qc)
 TRANS(UQADD_v, do_gvec_fn3, a, gen_gvec_uqadd_qc)
 TRANS(SQSUB_v, do_gvec_fn3, a, gen_gvec_sqsub_qc)
 TRANS(UQSUB_v, do_gvec_fn3, a, gen_gvec_uqsub_qc)
+TRANS(SUQADD_v, do_gvec_fn3, a, gen_gvec_suqadd_qc)
+TRANS(USQADD_v, do_gvec_fn3, a, gen_gvec_usqadd_qc)
 
 /*
  * Advanced SIMD scalar/vector x indexed element
@@ -10003,48 +10007,6 @@ static void handle_2misc_narrow(DisasContext *s, bool scalar,
     clear_vec_high(s, is_q, rd);
 }
 
-/* Remaining saturating accumulating ops */
-static void handle_2misc_satacc(DisasContext *s, bool is_scalar, bool is_u,
-                                bool is_q, unsigned size, int rn, int rd)
-{
-    TCGv_i64 res, qc, a, b;
-
-    if (!is_scalar) {
-        gen_gvec_fn3(s, is_q, rd, rd, rn,
-                     is_u ? gen_gvec_usqadd_qc : gen_gvec_suqadd_qc, size);
-        return;
-    }
-
-    res = tcg_temp_new_i64();
-    qc = tcg_temp_new_i64();
-    a = tcg_temp_new_i64();
-    b = tcg_temp_new_i64();
-
-    /* Read and extend scalar inputs to 64-bits. */
-    read_vec_element(s, a, rd, 0, size | (is_u ? 0 : MO_SIGN));
-    read_vec_element(s, b, rn, 0, size | (is_u ? MO_SIGN : 0));
-    tcg_gen_ld_i64(qc, tcg_env, offsetof(CPUARMState, vfp.qc));
-
-    if (size == MO_64) {
-        if (is_u) {
-            gen_usqadd_d(res, qc, a, b);
-        } else {
-            gen_suqadd_d(res, qc, a, b);
-        }
-    } else {
-        if (is_u) {
-            gen_usqadd_bhs(res, qc, a, b, size);
-        } else {
-            gen_suqadd_bhs(res, qc, a, b, size);
-            /* Truncate signed 64-bit result for writeback. */
-            tcg_gen_ext_i64(res, res, size);
-        }
-    }
-
-    write_fp_dreg(s, rd, res);
-    tcg_gen_st_i64(qc, tcg_env, offsetof(CPUARMState, vfp.qc));
-}
-
 /* AdvSIMD scalar two reg misc
  *  31 30  29 28       24 23  22 21       17 16    12 11 10 9    5 4    0
  * +-----+---+-----------+------+-----------+--------+-----+------+------+
@@ -10064,12 +10026,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     TCGv_ptr tcg_fpstatus;
 
     switch (opcode) {
-    case 0x3: /* USQADD / SUQADD*/
-        if (!fp_access_check(s)) {
-            return;
-        }
-        handle_2misc_satacc(s, true, u, false, size, rn, rd);
-        return;
     case 0x7: /* SQABS / SQNEG */
         break;
     case 0xa: /* CMLT */
@@ -10169,6 +10125,7 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
         }
         break;
     default:
+    case 0x3: /* USQADD / SUQADD */
         unallocated_encoding(s);
         return;
     }
@@ -11660,16 +11617,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
             return;
         }
         break;
-    case 0x3: /* SUQADD, USQADD */
-        if (size == 3 && !is_q) {
-            unallocated_encoding(s);
-            return;
-        }
-        if (!fp_access_check(s)) {
-            return;
-        }
-        handle_2misc_satacc(s, false, u, is_q, size, rn, rd);
-        return;
     case 0x7: /* SQABS, SQNEG */
         if (size == 3 && !is_q) {
             unallocated_encoding(s);
@@ -11844,6 +11791,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         break;
     }
     default:
+    case 0x3: /* SUQADD, USQADD */
         unallocated_encoding(s);
         return;
     }
-- 
2.34.1


