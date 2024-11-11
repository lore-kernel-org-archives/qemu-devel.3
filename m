Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0225D3ABCF
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 22:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAcv3-0001IP-5a; Mon, 11 Nov 2024 17:30:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAcv0-0001I1-Ln
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 17:29:58 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAcuz-0006lK-1F
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 17:29:58 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4315eeb2601so63245405e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 14:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731364194; x=1731968994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0AKRwDlBDWBLPaBtzDp9aTzEOum/fHmH3izgoL0EAGM=;
 b=i/Y5NAVugXYWf6zTanGZY4wfLqr342vT8ZaO/WxsDdlzBjRXR62nk+m8iSlSJIeW9l
 xkgg9LkyZuQ3amr5bRWPh/GFh6+O9ZljJ9B+z+14COoTqwIVn+YxKttfkjJOwO/U33Uq
 aO9GQ11UeTz/QqTdFaF+DNaqlsWs0YcO7XACGo3AfhgrkcLbX9yMudkJIYtNdKi6I2+n
 wYOzoQCMAPSVtjvJcsbbQn8EnZuOwgkQ5fiE5zTNBV9a/bakXcTe6DL4LzUB4F8L2MKj
 ive1/pvNKkNqQYCnpSL37ePTXR7t2FBfIThyLFXvQl5ytLxmohsANTldN5DsS15+/buP
 JKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731364194; x=1731968994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0AKRwDlBDWBLPaBtzDp9aTzEOum/fHmH3izgoL0EAGM=;
 b=kN54WXh6W2978Z2XCkRpcdiXMkpEHSda7TZmaTOLPUb/8XWXAeALqCFGtXy6U4/rET
 /JAoKfRwKMYnNb+PUlLAFV81Rdt/7TwYdQRaLT+YRbExCC2YzSAiLxBB1/eBRPDPKIw+
 SIWC2e/01dhlmlY3PxNQkqHve5XqfdWWELuJ3vGeT0Hb8Z/AnaX8Y2B519PsRo6r8uaM
 9ngHrkSCL6k2hGz7VQuwG90o4DyQW537Dac0zR8WZ8yWruUw5k45ZlegMFDJLLzCC1Kn
 xC8EMEpGS1En9gA/bIE78PTkLCL5J5uZ4d7ekMaJGjE18NCdIGeFP2F3tWTKntnjtEBT
 2zHA==
X-Gm-Message-State: AOJu0YyQZim8EPMqeNEwwezNLJYfkgniA5TeqRHpMGQSqVQckRfLD4BR
 BxOaJttwjNn4EGIEoOIo4VHZriHEPIuk+eErAO3rQl/HAy3KQRfiUrQr/RtNeyc8PyqIUZEap/q
 g
X-Google-Smtp-Source: AGHT+IFdKittLDMKVPt38ODhsFkQZjFlHlPHMRyrfC5AY5rB34nCWOZtJtQ+wt2hwDlT+Ych2FEVPA==
X-Received: by 2002:a05:600c:3146:b0:42c:b508:750e with SMTP id
 5b1f17b1804b1-432b750584amr144432835e9.11.1731364193663; 
 Mon, 11 Nov 2024 14:29:53 -0800 (PST)
Received: from localhost.localdomain
 (vau06-h02-176-184-43-163.dsl.sta.abo.bbox.fr. [176.184.43.163])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa73886bsm222637815e9.39.2024.11.11.14.29.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Nov 2024 14:29:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 2/3] target/mips: Extract generic gen_lx() helper
Date: Mon, 11 Nov 2024 23:29:35 +0100
Message-ID: <20241111222936.59869-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241111222936.59869-1-philmd@linaro.org>
References: <20241111222936.59869-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Extract gen_lx() from gen_mips_lx(); inline the Octeon
check in decode_opc_special3_legacy().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.h |  1 +
 target/mips/tcg/translate.c | 55 +++++++++++++------------------------
 2 files changed, 20 insertions(+), 36 deletions(-)

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index ed69ba15e5..a65ab4a747 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -168,6 +168,7 @@ void gen_store_fpr32(DisasContext *ctx, TCGv_i32 t, int reg);
 void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg);
 int get_fp_bit(int cc);
 
+void gen_lx(DisasContext *ctx, int rd, int base, int index, MemOp mop);
 void gen_ldxs(DisasContext *ctx, int base, int index, int rd);
 void gen_align(DisasContext *ctx, int wordsz, int rd, int rs, int rt, int bp);
 void gen_addiupc(DisasContext *ctx, int rx, int imm,
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 7152f5418e..acadd3d891 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -2035,6 +2035,15 @@ static void gen_lxr(DisasContext *ctx, TCGv reg, TCGv addr,
     tcg_gen_or_tl(reg, t0, t1);
 }
 
+void gen_lx(DisasContext *ctx, int rd, int base, int index, MemOp mop)
+{
+    TCGv t0 = tcg_temp_new();
+
+    gen_base_index_addr(ctx, t0, base, index);
+    tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mo_endian(ctx) | mop);
+    gen_store_gpr(t0, rd);
+}
+
 /* Load */
 static void gen_ld(DisasContext *ctx, uint32_t opc,
                    int rt, int base, int offset)
@@ -11327,41 +11336,6 @@ enum {
 
 /* MIPSDSP functions. */
 
-/* Indexed load is not for DSP only */
-static void gen_mips_lx(DisasContext *ctx, uint32_t opc,
-                        int rd, int base, int offset)
-{
-    TCGv t0;
-
-    if (!(ctx->insn_flags & INSN_OCTEON)) {
-        check_dsp(ctx);
-    }
-    t0 = tcg_temp_new();
-
-    gen_base_index_addr(ctx, t0, base, offset);
-
-    switch (opc) {
-    case OPC_LBUX:
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_UB);
-        gen_store_gpr(t0, rd);
-        break;
-    case OPC_LHX:
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mo_endian(ctx) | MO_SW);
-        gen_store_gpr(t0, rd);
-        break;
-    case OPC_LWX:
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mo_endian(ctx) | MO_SL);
-        gen_store_gpr(t0, rd);
-        break;
-#if defined(TARGET_MIPS64)
-    case OPC_LDX:
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ);
-        gen_store_gpr(t0, rd);
-        break;
-#endif
-    }
-}
-
 static void gen_mipsdsp_arith(DisasContext *ctx, uint32_t op1, uint32_t op2,
                               int ret, int v1, int v2)
 {
@@ -13609,15 +13583,24 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case OPC_LX_DSP:
+        if (!(ctx->insn_flags & INSN_OCTEON)) {
+            check_dsp(ctx);
+        }
         op2 = MASK_LX(ctx->opcode);
         switch (op2) {
 #if defined(TARGET_MIPS64)
         case OPC_LDX:
+            gen_lx(ctx, rd, rs, rt, MO_UQ);
+            break;
 #endif
         case OPC_LBUX:
+            gen_lx(ctx, rd, rs, rt, MO_UB);
+            break;
         case OPC_LHX:
+            gen_lx(ctx, rd, rs, rt, MO_SW);
+            break;
         case OPC_LWX:
-            gen_mips_lx(ctx, op2, rd, rs, rt);
+            gen_lx(ctx, rd, rs, rt, MO_SL);
             break;
         default:            /* Invalid */
             MIPS_INVAL("MASK LX");
-- 
2.45.2


