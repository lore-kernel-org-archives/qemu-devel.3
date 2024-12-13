Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6A0E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9XZ-0007O3-Qy; Fri, 13 Dec 2024 12:33:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XD-00074w-OH
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:04 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XB-0001Xt-LH
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:03 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso13698935e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111180; x=1734715980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J70fG9zjVQ0I6Fr//x/raIzh21DkB5SQh0C3nL/+Ijk=;
 b=gP3f67xjEBm62xBAvCAlx/HYo/UMAMv2zvp70YeAs5IXd7LAoMmzZpAKUNkjrxmmB5
 5LMp20AjBi9oVd9AkpIDaVuJUsJkZowg9DsYI2kPX9CKocYjIMRK84UkZ7HbCD3KDltz
 m9LkIV8Kt/33YTn7Q2O1hOcWP5QKrSSxl/rS8cd631QreuWU+gvPD3/q8wvgdrvH+3Le
 uwgjUAM660HpauJh06VXlpA07OdrYVNzil1iGQ+P5qFYbreJ6sunB7r0FRvgBRq6vl0v
 qzPjMRNF9V6FTmXnMIfEco1RxXzYn+TdncfTXa4GiECXVRzOkGbvVBAy+IpAYWmy4nB3
 b5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111180; x=1734715980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J70fG9zjVQ0I6Fr//x/raIzh21DkB5SQh0C3nL/+Ijk=;
 b=NFCtCVVKDUUrvgu4KsHtcLlALXJWDCsWBRnzH0FVg9EXFTvH3Z9BS0SsB5UpBFIeLq
 j1iS9dNsZn1FV3d0BG2RRK+yPIm3CQUoCWb5XWOM0Kmi72jSjDYM+3bpURIPv0UWm6oA
 EBAQy52qli6zDn0y4rEGggcL0mus32S8t2oQ9lhWdLv57z5uhjnCpjERMmL0JbR7Svig
 nSMwhsw9zRhdXclDtSPm2IdfKyS+ZbwMWaSE+LQRA8vYk7mprhTWX3nB8tq9yt7WIwCx
 6+VowKN9vyd7/4roaNHQBCTxQjPdryfeU8qmhoWh9hWZnvvuw/GE4PtZMnWgqvesN8Hg
 dorA==
X-Gm-Message-State: AOJu0YxUlLUouQi32jumyvx6dVFUG8TYFVG0l+JvsyeK/s04Wjp9tQCM
 N2BOMRtYPfY/2YmxqqmF5GCk9QYdc4Q4hYcoba2d/I37bHj3qD+rugbESyH2NV2IdASKlh0D1YJ
 r
X-Gm-Gg: ASbGncusPa0pSncrDKeLA+Qeyf2S5W9itFhScokqjt/FIB4JBDLlkmaxXU46cp3Qutk
 EqhVHM9DbXjikxmTg3CBUaEHn+U0adHJO6tPzG23YdQ7NksCz6PL8DRbXCmG4yB3IS0XFXbCFBs
 wLQCXyZ/+s/UOe4H90QpLaxyDrFMZKZiMivF+AOm2sCc0AxH6pV8+ZIBgMAJYwSJtabgtKU7Fu7
 1R13XOsAuflVK4ocXT/Do7ECsHTJsp67tDebmmQPFyFSuDUJk30eoUgjXL6ew==
X-Google-Smtp-Source: AGHT+IGu85y69xa7g64JqEMzQEUMbNOTavNywENMtVmpQxY1i4JEQE6Y0awAY743uHhyjCLfK6RdAA==
X-Received: by 2002:a05:600c:1906:b0:434:f2f4:4c07 with SMTP id
 5b1f17b1804b1-4362aa3e03dmr30737505e9.15.1734111179932; 
 Fri, 13 Dec 2024 09:32:59 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.32.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:32:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/85] target/arm: Convert FSQRT (scalar) to decodetree
Date: Fri, 13 Dec 2024 17:31:31 +0000
Message-Id: <20241213173229.3308926-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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
Message-id: 20241211163036.2297116-28-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  1 +
 target/arm/tcg/translate-a64.c | 72 ++++++++++++++++++++++++++++------
 2 files changed, 62 insertions(+), 11 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index b9cc8963da8..3b1e8e07760 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1327,6 +1327,7 @@ FMINV_s         0110 1110 10 11000 01111 10 ..... .....     @rr_q1e2
 FMOV_s          00011110 .. 1 000000 10000 ..... .....      @rr_hsd
 FABS_s          00011110 .. 1 000001 10000 ..... .....      @rr_hsd
 FNEG_s          00011110 .. 1 000010 10000 ..... .....      @rr_hsd
+FSQRT_s         00011110 .. 1 000011 10000 ..... .....      @rr_hsd
 
 # Floating-point Immediate
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 2a5cb704752..f3989246f9c 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8344,6 +8344,63 @@ static const FPScalar1Int f_scalar_fneg = {
 };
 TRANS(FNEG_s, do_fp1_scalar_int, a, &f_scalar_fneg)
 
+typedef struct FPScalar1 {
+    void (*gen_h)(TCGv_i32, TCGv_i32, TCGv_ptr);
+    void (*gen_s)(TCGv_i32, TCGv_i32, TCGv_ptr);
+    void (*gen_d)(TCGv_i64, TCGv_i64, TCGv_ptr);
+} FPScalar1;
+
+static bool do_fp1_scalar(DisasContext *s, arg_rr_e *a,
+                          const FPScalar1 *f, int rmode)
+{
+    TCGv_i32 tcg_rmode = NULL;
+    TCGv_ptr fpst;
+    TCGv_i64 t64;
+    TCGv_i32 t32;
+    int check = fp_access_check_scalar_hsd(s, a->esz);
+
+    if (check <= 0) {
+        return check == 0;
+    }
+
+    fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
+    if (rmode >= 0) {
+        tcg_rmode = gen_set_rmode(rmode, fpst);
+    }
+
+    switch (a->esz) {
+    case MO_64:
+        t64 = read_fp_dreg(s, a->rn);
+        f->gen_d(t64, t64, fpst);
+        write_fp_dreg(s, a->rd, t64);
+        break;
+    case MO_32:
+        t32 = read_fp_sreg(s, a->rn);
+        f->gen_s(t32, t32, fpst);
+        write_fp_sreg(s, a->rd, t32);
+        break;
+    case MO_16:
+        t32 = read_fp_hreg(s, a->rn);
+        f->gen_h(t32, t32, fpst);
+        write_fp_sreg(s, a->rd, t32);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (rmode >= 0) {
+        gen_restore_rmode(tcg_rmode, fpst);
+    }
+    return true;
+}
+
+static const FPScalar1 f_scalar_fsqrt = {
+    gen_helper_vfp_sqrth,
+    gen_helper_vfp_sqrts,
+    gen_helper_vfp_sqrtd,
+};
+TRANS(FSQRT_s, do_fp1_scalar, a, &f_scalar_fsqrt, -1)
+
 /* Floating-point data-processing (1 source) - half precision */
 static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
 {
@@ -8352,10 +8409,6 @@ static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
     TCGv_i32 tcg_res = tcg_temp_new_i32();
 
     switch (opcode) {
-    case 0x3: /* FSQRT */
-        fpst = fpstatus_ptr(FPST_FPCR_F16);
-        gen_helper_vfp_sqrth(tcg_res, tcg_op, fpst);
-        break;
     case 0x8: /* FRINTN */
     case 0x9: /* FRINTP */
     case 0xa: /* FRINTM */
@@ -8382,6 +8435,7 @@ static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
     case 0x0: /* FMOV */
     case 0x1: /* FABS */
     case 0x2: /* FNEG */
+    case 0x3: /* FSQRT */
         g_assert_not_reached();
     }
 
@@ -8400,9 +8454,6 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
     tcg_res = tcg_temp_new_i32();
 
     switch (opcode) {
-    case 0x3: /* FSQRT */
-        gen_fpst = gen_helper_vfp_sqrts;
-        break;
     case 0x6: /* BFCVT */
         gen_fpst = gen_helper_bfcvt;
         break;
@@ -8438,6 +8489,7 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
     case 0x0: /* FMOV */
     case 0x1: /* FABS */
     case 0x2: /* FNEG */
+    case 0x3: /* FSQRT */
         g_assert_not_reached();
     }
 
@@ -8465,9 +8517,6 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
     tcg_res = tcg_temp_new_i64();
 
     switch (opcode) {
-    case 0x3: /* FSQRT */
-        gen_fpst = gen_helper_vfp_sqrtd;
-        break;
     case 0x8: /* FRINTN */
     case 0x9: /* FRINTP */
     case 0xa: /* FRINTM */
@@ -8500,6 +8549,7 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
     case 0x0: /* FMOV */
     case 0x1: /* FABS */
     case 0x2: /* FNEG */
+    case 0x3: /* FSQRT */
         g_assert_not_reached();
     }
 
@@ -8619,7 +8669,6 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
             goto do_unallocated;
         }
         /* fall through */
-    case 0x3:
     case 0x8 ... 0xc:
     case 0xe ... 0xf:
         /* 32-to-32 and 64-to-64 ops */
@@ -8672,6 +8721,7 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
     case 0x0: /* FMOV */
     case 0x1: /* FABS */
     case 0x2: /* FNEG */
+    case 0x3: /* FSQRT */
         unallocated_encoding(s);
         break;
     }
-- 
2.34.1


