Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE65E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPhV-0000XU-DB; Wed, 11 Dec 2024 11:36:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPhP-0008Qd-Cx
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:36:31 -0500
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPhN-0002C0-Ev
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:36:31 -0500
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6d8e8445219so39245276d6.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934988; x=1734539788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h9jQSwq7lR/Eg53AlnqkWC3Nk0mGhQSS5bECu5mg0fo=;
 b=zywVREdw71KSLU4TnymldYFgHnko/Z+ZMLRo0PSAyLM3ZbZ2h6bXlk239e72ZmMCQA
 22GReijbSRjD1mnBaE0jPTxFk7DRSq6T9Lz5uzqGhQlezl8Hhye25o0trorS/uCFFTfG
 C8fgDrYW8EIpnJ1eKfmIfC9YNo6aTTZ4QM2XSxGowhsV4+UrZyRH3dOxS4dQHAx+w98/
 6FeNjnFSAjXf4/xYb/OE40Nq++0pFAXnJPIvPPZdN3I00Uixs+wWXiGhJLaFtqk9ijgD
 Uu3Ww7UOxz9soRupdnqdwEjqazUx5Re41TMVWOAp7HhQxr2tREBdZt0xy6ofMm43DweI
 b1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934988; x=1734539788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h9jQSwq7lR/Eg53AlnqkWC3Nk0mGhQSS5bECu5mg0fo=;
 b=NNtK05MxN7cblkInZdwS+sgG+f6QXUXootZ+tXedHp0i/lL4YS56tVaWOUAsjTa4rT
 L1g3iiwu2xia0KHl8CjkPIDJkIS2ZJfN3lU1Q3vLcJbWjQi2UPBEo/5jCymXJy5XYnKC
 aUVYDUtgmOSYte2ApOYyMU2UWuuXz9uC9BYDPJsRJ3ELz6QLOlSUzKmBlXChGLVkWnli
 pcQEZjIy+dm75+RP2nhqP8Qul6DXvH1uAkmfdDgApaiAFjiuAA+iG6L4kNt/sd7EDYoc
 O+pfIYz17VCTWT/kEkSpTbcZxgeEZl9dNDySb3IDqkYQTftqehpMMwzt6iwz334tZpNu
 QAJw==
X-Gm-Message-State: AOJu0Yzgx5HUokP9B5lwtReFKh9VEQLqRGXU6DYWhJaQODO5xOvLGbyo
 oJOG+MUaAgrgmw7KHzmUicCwGkXIkgZJl7VMoWKHfx+H7Hv8QzlW9PTjfGFwyovAuOdGBVZE9Rr
 Cmbj11ATQ
X-Gm-Gg: ASbGnct7ff0ICrDOMdI3Dmw3f69YN0OuTEl9VUTT1LMP02MfR5qVxFdfw/7/1PAM3dB
 6LqpAILw2IkFmA/PwF3whK8p2+7FuPiUWmq63VilWqk9RwSbFyf2S0+jfopErr2DwqJTo+wrBx3
 9risQ6jGzzjIcmQXIEXjo2ukZ80zxr2ErXAAtsIU9vgp5/h9vnCpIsOcPxpsu0x6vDSUh7HSgVf
 3oDF+PBaJEpeE2iHTECbqCyT7831+g76E/unW8XrQTIgrBrIn86LINKMIH0jg==
X-Google-Smtp-Source: AGHT+IGWuwOhE1RkMMGdJyEtATHbq467CbCTT59LjaSv1OFEN6t+kSlJqzD8FyvIuPnqmZhkHU1xHQ==
X-Received: by 2002:a05:6214:ca7:b0:6d8:8e0f:8c0f with SMTP id
 6a1803df08f44-6dae29f0f37mr7670656d6.18.1733934988433; 
 Wed, 11 Dec 2024 08:36:28 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da675214sm71856276d6.11.2024.12.11.08.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:36:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 50/69] target/arm: Convert FCVTN, BFCVTN to decodetree
Date: Wed, 11 Dec 2024 10:30:17 -0600
Message-ID: <20241211163036.2297116-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf30.google.com
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
 target/arm/tcg/translate-a64.c | 89 ++++++++++++++++++----------------
 target/arm/tcg/a64.decode      |  5 ++
 2 files changed, 52 insertions(+), 42 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 7b76945b0a..d4d19c9caa 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9051,6 +9051,49 @@ TRANS(SQXTUN_v, do_2misc_narrow_vector, a, f_scalar_sqxtun)
 TRANS(SQXTN_v, do_2misc_narrow_vector, a, f_scalar_sqxtn)
 TRANS(UQXTN_v, do_2misc_narrow_vector, a, f_scalar_uqxtn)
 
+static void gen_fcvtn_hs(TCGv_i64 d, TCGv_i64 n)
+{
+    TCGv_i32 tcg_lo = tcg_temp_new_i32();
+    TCGv_i32 tcg_hi = tcg_temp_new_i32();
+    TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
+    TCGv_i32 ahp = get_ahp_flag();
+
+    tcg_gen_extr_i64_i32(tcg_lo, tcg_hi, n);
+    gen_helper_vfp_fcvt_f32_to_f16(tcg_lo, tcg_lo, fpst, ahp);
+    gen_helper_vfp_fcvt_f32_to_f16(tcg_hi, tcg_hi, fpst, ahp);
+    tcg_gen_deposit_i32(tcg_lo, tcg_lo, tcg_hi, 16, 16);
+    tcg_gen_extu_i32_i64(d, tcg_lo);
+}
+
+static void gen_fcvtn_sd(TCGv_i64 d, TCGv_i64 n)
+{
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    gen_helper_vfp_fcvtsd(tmp, n, tcg_env);
+    tcg_gen_extu_i32_i64(d, tmp);
+}
+
+static ArithOneOp * const f_vector_fcvtn[] = {
+    NULL,
+    gen_fcvtn_hs,
+    gen_fcvtn_sd,
+};
+TRANS(FCVTN_v, do_2misc_narrow_vector, a, f_vector_fcvtn)
+
+static void gen_bfcvtn_hs(TCGv_i64 d, TCGv_i64 n)
+{
+    TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    gen_helper_bfcvt_pair(tmp, n, fpst);
+    tcg_gen_extu_i32_i64(d, tmp);
+}
+
+static ArithOneOp * const f_vector_bfcvtn[] = {
+    NULL,
+    gen_bfcvtn_hs,
+    NULL,
+};
+TRANS_FEAT(BFCVTN_v, aa64_bf16, do_2misc_narrow_vector, a, f_vector_bfcvtn)
+
 /* Common vector code for handling integer to FP conversion */
 static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
                                    int elements, int is_signed,
@@ -9633,33 +9676,6 @@ static void handle_2misc_narrow(DisasContext *s, bool scalar,
         tcg_res[pass] = tcg_temp_new_i64();
 
         switch (opcode) {
-        case 0x16: /* FCVTN, FCVTN2 */
-            /* 32 bit to 16 bit or 64 bit to 32 bit float conversion */
-            if (size == 2) {
-                TCGv_i32 tmp = tcg_temp_new_i32();
-                gen_helper_vfp_fcvtsd(tmp, tcg_op, tcg_env);
-                tcg_gen_extu_i32_i64(tcg_res[pass], tmp);
-            } else {
-                TCGv_i32 tcg_lo = tcg_temp_new_i32();
-                TCGv_i32 tcg_hi = tcg_temp_new_i32();
-                TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
-                TCGv_i32 ahp = get_ahp_flag();
-
-                tcg_gen_extr_i64_i32(tcg_lo, tcg_hi, tcg_op);
-                gen_helper_vfp_fcvt_f32_to_f16(tcg_lo, tcg_lo, fpst, ahp);
-                gen_helper_vfp_fcvt_f32_to_f16(tcg_hi, tcg_hi, fpst, ahp);
-                tcg_gen_deposit_i32(tcg_lo, tcg_lo, tcg_hi, 16, 16);
-                tcg_gen_extu_i32_i64(tcg_res[pass], tcg_lo);
-            }
-            break;
-        case 0x36: /* BFCVTN, BFCVTN2 */
-            {
-                TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
-                TCGv_i32 tmp = tcg_temp_new_i32();
-                gen_helper_bfcvt_pair(tmp, tcg_op, fpst);
-                tcg_gen_extu_i32_i64(tcg_res[pass], tmp);
-            }
-            break;
         case 0x56:  /* FCVTXN, FCVTXN2 */
             {
                 /*
@@ -9675,6 +9691,8 @@ static void handle_2misc_narrow(DisasContext *s, bool scalar,
         default:
         case 0x12: /* XTN, SQXTUN */
         case 0x14: /* SQXTN, UQXTN */
+        case 0x16: /* FCVTN, FCVTN2 */
+        case 0x36: /* BFCVTN, BFCVTN2 */
             g_assert_not_reached();
         }
 
@@ -10088,21 +10106,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                 unallocated_encoding(s);
                 return;
             }
-            /* fall through */
-        case 0x16: /* FCVTN, FCVTN2 */
-            /* handle_2misc_narrow does a 2*size -> size operation, but these
-             * instructions encode the source size rather than dest size.
-             */
-            if (!fp_access_check(s)) {
-                return;
-            }
-            handle_2misc_narrow(s, false, opcode, 0, is_q, size - 1, rn, rd);
-            return;
-        case 0x36: /* BFCVTN, BFCVTN2 */
-            if (!dc_isar_feature(aa64_bf16, s) || size != 2) {
-                unallocated_encoding(s);
-                return;
-            }
             if (!fp_access_check(s)) {
                 return;
             }
@@ -10155,6 +10158,8 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
             }
             break;
         default:
+        case 0x16: /* FCVTN, FCVTN2 */
+        case 0x36: /* BFCVTN, BFCVTN2 */
             unallocated_encoding(s);
             return;
         }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 295329448f..456912cd7c 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -21,6 +21,7 @@
 
 %rd             0:5
 %esz_sd         22:1 !function=plus_2
+%esz_hs         22:1 !function=plus_1
 %esz_hsd        22:2 !function=xor_2
 %hl             11:1 21:1
 %hlm            11:1 20:2
@@ -74,6 +75,7 @@
 @qrr_b          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=0
 @qrr_h          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=1
 @qrr_bh         . q:1 ...... . esz:1 ...... ...... rn:5 rd:5  &qrr_e
+@qrr_hs         . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=%esz_hs
 @qrr_e          . q:1 ...... esz:2 ...... ...... rn:5 rd:5  &qrr_e
 
 @qrrr_b         . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=0
@@ -1676,3 +1678,6 @@ XTN             0.00 1110 ..1 00001 00101 0 ..... .....     @qrr_e
 SQXTUN_v        0.10 1110 ..1 00001 00101 0 ..... .....     @qrr_e
 SQXTN_v         0.00 1110 ..1 00001 01001 0 ..... .....     @qrr_e
 UQXTN_v         0.10 1110 ..1 00001 01001 0 ..... .....     @qrr_e
+
+FCVTN_v         0.00 1110 0.1 00001 01101 0 ..... .....     @qrr_hs
+BFCVTN_v        0.00 1110 101 00001 01101 0 ..... .....     @qrr_h
-- 
2.43.0


