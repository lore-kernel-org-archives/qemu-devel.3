Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899FCC30653
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 19:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMBGo-0003yj-6L; Tue, 25 Jun 2024 14:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMB5B-00019M-P0
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 14:40:09 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMB3d-00067T-MT
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 14:39:45 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f9de13d6baso40991565ad.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 11:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719340550; x=1719945350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PecZkInRMvU6dxX9NAjaqUD1RvRTPZR33lK52/GwzZA=;
 b=SvdAjfFZtIbKTxqJtVXM3wglGZPuDT1qt/9pjckoktNRO8XOdBlwZvf/qRa/bGLOgM
 3J1zn3e5ogTgLJcLymcooFC3b3Q8CDYRFNb5m+GFesT1KtRfwJqRrBwe5Gq/Kbx/dlNZ
 P/dA/o4GYGJlS+vxoCTSoSYb3jULMt5DxpPgjW31pL0/hqcHOu2L27KMZWSg2IIiqYPf
 is3/eneAzAPscYdo4+zjHe6jv6+zpnlGc9G5Mua+YnkmTTO1Dm2QFtMERaYTyRjt7SxJ
 9lX7U3kttYXWHwCk/u94PQayH39+Qt0+4QrWirAdjrPzQvudAzXMo/7wX8+xQ3q3zQ50
 fnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719340550; x=1719945350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PecZkInRMvU6dxX9NAjaqUD1RvRTPZR33lK52/GwzZA=;
 b=edyRha0hYCHqbB7os2vDdCl5Iqm1LPCKQqan3CtKQqViFQfWSA9/9MVRHHArp81mU6
 EG6WkJd9L9WT+PNW6Ggx97DVzzefp+2KFd/gL8fV+pCWmfAdhYZjdFap+LxJH8Z33t0w
 PoSv9fLsKDM2nMAsDxl+jurRKrVfL/i20wIOAVZw7jU8IX1Lat+5H4iA2h5udDfzMPjs
 f31IHe0mOaidRBWz9cA+nI10kzBmdPi0dGy/xr3CixT7SQhxAKlRZyJpaZF94K7jElS6
 LRgfC45JDYimDKC+bUAEfNmO9jaIxbjxUJ9sY2Rw/4XRbmDYgg6BcEjZNY8kxJFGqYLh
 TYYw==
X-Gm-Message-State: AOJu0YyJtV4CJpYpw65HsfFzxilDcW0NUc94Kus4ts67B/GemiUxFJPt
 xPOyd4bNMQp+D5rfeHYGnYV56Hzn35l/MkEWkjDvSMByhCQbJYEDvWLiNGRT/aT4UPJbb+w6oxD
 I
X-Google-Smtp-Source: AGHT+IHkxUor8eUO37ZgszVYd3+UVvBM5JR18FeOUzLjJD7JkggjEkzFPDMMYUSUwKXbeRxCptgBUg==
X-Received: by 2002:a17:902:ea03:b0:1f9:c1f0:7150 with SMTP id
 d9443c01a7336-1fa23f224a5mr85343315ad.8.1719340549928; 
 Tue, 25 Jun 2024 11:35:49 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb3c6027sm84693235ad.133.2024.06.25.11.35.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 11:35:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 13/13] target/arm: Delete dead code from disas_simd_indexed
Date: Tue, 25 Jun 2024 11:35:36 -0700
Message-Id: <20240625183536.1672454-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625183536.1672454-1-richard.henderson@linaro.org>
References: <20240625183536.1672454-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

MLA, MLS, SQDMULH, SQRDMULH, were converted with 8db93dcd3def
and f80701cb44d, and this code should have been removed then.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 93 ----------------------------------
 1 file changed, 93 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 161fa2659c..6c07aeaf3b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -11976,7 +11976,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     int h = extract32(insn, 11, 1);
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
-    bool is_long = false;
     int index;
 
     switch (16 * u + opcode) {
@@ -11990,12 +11989,10 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
             unallocated_encoding(s);
             return;
         }
-        is_long = true;
         break;
     case 0x03: /* SQDMLAL, SQDMLAL2 */
     case 0x07: /* SQDMLSL, SQDMLSL2 */
     case 0x0b: /* SQDMULL, SQDMULL2 */
-        is_long = true;
         break;
     default:
     case 0x00: /* FMLAL */
@@ -12047,96 +12044,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
 
     if (size == 3) {
         g_assert_not_reached();
-    } else if (!is_long) {
-        /* 32 bit floating point, or 16 or 32 bit integer.
-         * For the 16 bit scalar case we use the usual Neon helpers and
-         * rely on the fact that 0 op 0 == 0 with no side effects.
-         */
-        TCGv_i32 tcg_idx = tcg_temp_new_i32();
-        int pass, maxpasses;
-
-        if (is_scalar) {
-            maxpasses = 1;
-        } else {
-            maxpasses = is_q ? 4 : 2;
-        }
-
-        read_vec_element_i32(s, tcg_idx, rm, index, size);
-
-        if (size == 1 && !is_scalar) {
-            /* The simplest way to handle the 16x16 indexed ops is to duplicate
-             * the index into both halves of the 32 bit tcg_idx and then use
-             * the usual Neon helpers.
-             */
-            tcg_gen_deposit_i32(tcg_idx, tcg_idx, tcg_idx, 16, 16);
-        }
-
-        for (pass = 0; pass < maxpasses; pass++) {
-            TCGv_i32 tcg_op = tcg_temp_new_i32();
-            TCGv_i32 tcg_res = tcg_temp_new_i32();
-
-            read_vec_element_i32(s, tcg_op, rn, pass, is_scalar ? size : MO_32);
-
-            switch (16 * u + opcode) {
-            case 0x10: /* MLA */
-            case 0x14: /* MLS */
-            {
-                static NeonGenTwoOpFn * const fns[2][2] = {
-                    { gen_helper_neon_add_u16, gen_helper_neon_sub_u16 },
-                    { tcg_gen_add_i32, tcg_gen_sub_i32 },
-                };
-                NeonGenTwoOpFn *genfn;
-                bool is_sub = opcode == 0x4;
-
-                if (size == 1) {
-                    gen_helper_neon_mul_u16(tcg_res, tcg_op, tcg_idx);
-                } else {
-                    tcg_gen_mul_i32(tcg_res, tcg_op, tcg_idx);
-                }
-                if (opcode == 0x8) {
-                    break;
-                }
-                read_vec_element_i32(s, tcg_op, rd, pass, MO_32);
-                genfn = fns[size - 1][is_sub];
-                genfn(tcg_res, tcg_op, tcg_res);
-                break;
-            }
-            case 0x0c: /* SQDMULH */
-                if (size == 1) {
-                    gen_helper_neon_qdmulh_s16(tcg_res, tcg_env,
-                                               tcg_op, tcg_idx);
-                } else {
-                    gen_helper_neon_qdmulh_s32(tcg_res, tcg_env,
-                                               tcg_op, tcg_idx);
-                }
-                break;
-            case 0x0d: /* SQRDMULH */
-                if (size == 1) {
-                    gen_helper_neon_qrdmulh_s16(tcg_res, tcg_env,
-                                                tcg_op, tcg_idx);
-                } else {
-                    gen_helper_neon_qrdmulh_s32(tcg_res, tcg_env,
-                                                tcg_op, tcg_idx);
-                }
-                break;
-            default:
-            case 0x01: /* FMLA */
-            case 0x05: /* FMLS */
-            case 0x09: /* FMUL */
-            case 0x19: /* FMULX */
-            case 0x1d: /* SQRDMLAH */
-            case 0x1f: /* SQRDMLSH */
-                g_assert_not_reached();
-            }
-
-            if (is_scalar) {
-                write_fp_sreg(s, rd, tcg_res);
-            } else {
-                write_vec_element_i32(s, tcg_res, rd, pass, MO_32);
-            }
-        }
-
-        clear_vec_high(s, is_q, rd);
     } else {
         /* long ops: 16x16->32 or 32x32->64 */
         TCGv_i64 tcg_res[2];
-- 
2.34.1


