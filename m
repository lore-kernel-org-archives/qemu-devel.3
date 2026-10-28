Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D9E606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=WdVvL+XF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM6aK-0006Wy-Kf; Wed, 28 Oct 2026 12:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6aI-0006Vw-1X
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:33:06 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6aG-0007YM-9b
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:33:05 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-84621d8c7aaso582506a34.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 09:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793205183; x=1793809983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D2fdLlvb+BRbVtRIo4uLPfcunyMOSQZp2TZDVBOzWlg=;
 b=WdVvL+XF73LN1OfLkluP7XTTEbOYV1FoYesA5lFX8cV3k+q/TM58qjrqRhFQW/qW+K
 r1kxxS/ums9xTDwqXyTKGmCehNRl8zBwhRqzthNLkrZO4S2E55cFwM8Se2A4qPWJNZnv
 TokFW2OHpDzPzQjllualjP8bwtaDBox3hcvsRPmLIg1klHha0crqYxSr6XrgujarIP7j
 gt658kuN875z35bHGGaDKLmliTWZF5yvNb7nIr5H3QuWeQmBt86B2XpOF8+WDRxdnD4I
 Wx0o9MoR922MMgqd9DRPSFwg82yQEo+iQtWs7TS76pSornPh82T7COHKGG6zJS0/Gziu
 5YKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793205183; x=1793809983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=D2fdLlvb+BRbVtRIo4uLPfcunyMOSQZp2TZDVBOzWlg=;
 b=u8KrwSB/yzRWaYDt+4JIz8tovS82fJ3fbejD1bj9WAkMQEqxxIiG2Ts91+Lt+XDgaP
 Tw5kWcwiOJ3L0XVQSMsa+x5r+KVQYViANjoXk58JPG9sw+76mQU9PKmcHyCEhCPVIr3A
 Xk90dnTLLJBnPd8EX+hk7ApBzuSz8wK9t5mPFa34AqKtCxPw5DIi23YXuAIlb8/aNLto
 s9JiQcJ1yzeCd6KExgd5oxgexmr5j47iZ9NWg/Q+4PPvvxaqfz/nEH41AkIcKQCw1zKP
 UvEtOZOOaa4781a0i9uzJ62gSLIAzT1knzlPBix6+opjkDa1D10vIBkBITku0HeDFjQG
 pykg==
X-Gm-Message-State: AFq9FYJCRQxxVclHsfLFSk0LEkvcOxXxjDO3b8/0c9+e8FqkmLfBlU7o
 oZCq8UsrIek4wM+w59YUISoXdmRR56evl6+UupDcH1SFyDxdBKcec5yCTYnTRWwEDsvJIxq9ub2
 ravy7
X-Gm-Gg: AYBFou3FZUGS9jE980fDXCFcYdVh2ILwOpYe9e93HuMvUKCzN8WfjuGNs1ArrVOP54g
 XQldQEM2GhhvT6pjCga9YyCio9+s0y+5hBnN1B6Uhuf9WXpAK8Ad6i+PVUtig+gSlBzY+y0nxip
 gOmWSkE7rR6P8dlux33tZh8pbOc4Zp1Ji3RmdvumYsmMfZ3y5bW4UEYhJBr1XtOc3gjFjER84kk
 rZoy0yXJ0nRrBZvCFPTZ9/kN38yyTZdU1J+MuekB/AefyhcZoeNpuA3IWzkWx5OmIZ3Vi7xHmqH
 P+GMFckAuBN0rOQ6TblvTR4FIlm7qtq0edG2omal0QP89IJVrsPOMZ/MWbDlaNBSYaHEbOYSN+R
 LTExbTJ8oGBGzOp3vuo4RI0BVY/bCRnMKvBSpUR9jqDHMZnGQ2C57sWC2vtHfHodx2rh9o3gyzS
 uSepr1NSll6IZDwOkt8gO4mXICo6Wu7z/Ks9694uMUN5GOGPkMB57zdRFhunD/gXkFwu/O6Iu6v
 V3qy/bWs5rGCWQYfPuoF0pCSl8z4skP0UZ0Soo5lVYjgYyUDbcyis/hqRZ6qFsAwoC39520MLzi
 RxrM0+r1eJcrtm27OOW4RIPOaIKjcCsiBg==
X-Received: by 2002:a05:6830:25d1:b0:82f:5471:4dd7 with SMTP id
 46e09a7af769-85ac11bfa1cmr2611687a34.30.1793205182730; 
 Wed, 28 Oct 2026 09:33:02 -0700 (PDT)
Received: from stoup ([2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b1f4368f3sm2538965a34.7.2026.10.28.09.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:33:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v3 12/16] tcg/loongarch64: Import SLADD insns
Date: Wed, 28 Oct 2026 11:32:41 -0500
Message-ID: <20261028163245.1031673-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028163245.1031673-1-richard.henderson@linaro.org>
References: <20261028163245.1031673-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-insn-defs.c.inc | 30 ++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tcg/loongarch64/tcg-insn-defs.c.inc b/tcg/loongarch64/tcg-insn-defs.c.inc
index e907fc755f..ececc6a3dd 100644
--- a/tcg/loongarch64/tcg-insn-defs.c.inc
+++ b/tcg/loongarch64/tcg-insn-defs.c.inc
@@ -4,7 +4,7 @@
  *
  * This file is auto-generated by genqemutcgdefs from
  * https://github.com/loongson-community/loongarch-opcodes,
- * from commit 1b95bb8c443ad71e266120fd97bd227df2d8ecfc.
+ * from commit 2d84c975e8894afc8b3ee9b8559f10308a658440.
  * DO NOT EDIT.
  */
 
@@ -24,6 +24,7 @@ typedef enum {
     OPC_REVBIT_D = 0x00005400,
     OPC_SEXT_H = 0x00005800,
     OPC_SEXT_B = 0x00005c00,
+    OPC_SLADD_W = 0x00040000,
     OPC_ADD_W = 0x00100000,
     OPC_ADD_D = 0x00108000,
     OPC_SUB_W = 0x00110000,
@@ -62,6 +63,7 @@ typedef enum {
     OPC_MOD_D = 0x00228000,
     OPC_DIV_DU = 0x00230000,
     OPC_MOD_DU = 0x00238000,
+    OPC_SLADD_D = 0x002c0000,
     OPC_SLLI_W = 0x00408000,
     OPC_SLLI_D = 0x00410000,
     OPC_SRLI_W = 0x00448000,
@@ -619,6 +621,18 @@ encode_djk_insn(LoongArchInsn opc, TCGReg d, TCGReg j, TCGReg k)
     return encode_djk_slots(opc, d, j, k);
 }
 
+static int32_t __attribute__((unused)) encode_djkua2_insn(LoongArchInsn opc,
+                                                          TCGReg d, TCGReg j,
+                                                          TCGReg k,
+                                                          uint32_t ua2)
+{
+    tcg_debug_assert(d >= 0 && d <= 0x1f);
+    tcg_debug_assert(j >= 0 && j <= 0x1f);
+    tcg_debug_assert(k >= 0 && k <= 0x1f);
+    tcg_debug_assert(ua2 <= 0x3);
+    return encode_djka_slots(opc, d, j, k, ua2);
+}
+
 static int32_t __attribute__((unused))
 encode_djsk12_insn(LoongArchInsn opc, TCGReg d, TCGReg j, int32_t sk12)
 {
@@ -1426,6 +1440,13 @@ static void __attribute__((unused)) tcg_out_opc_sext_b(TCGContext *s, TCGReg d,
     tcg_out32(s, encode_dj_insn(OPC_SEXT_B, d, j));
 }
 
+/* Emits the `sladd.w d, j, k, ua2` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_sladd_w(TCGContext *s, TCGReg d, TCGReg j, TCGReg k, uint32_t ua2)
+{
+    tcg_out32(s, encode_djkua2_insn(OPC_SLADD_W, d, j, k, ua2));
+}
+
 /* Emits the `add.w d, j, k` instruction.  */
 static void __attribute__((unused)) tcg_out_opc_add_w(TCGContext *s, TCGReg d,
                                                       TCGReg j, TCGReg k)
@@ -1692,6 +1713,13 @@ static void __attribute__((unused)) tcg_out_opc_mod_du(TCGContext *s, TCGReg d,
     tcg_out32(s, encode_djk_insn(OPC_MOD_DU, d, j, k));
 }
 
+/* Emits the `sladd.d d, j, k, ua2` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_sladd_d(TCGContext *s, TCGReg d, TCGReg j, TCGReg k, uint32_t ua2)
+{
+    tcg_out32(s, encode_djkua2_insn(OPC_SLADD_D, d, j, k, ua2));
+}
+
 /* Emits the `slli.w d, j, uk5` instruction.  */
 static void __attribute__((unused)) tcg_out_opc_slli_w(TCGContext *s, TCGReg d,
                                                        TCGReg j, uint32_t uk5)
-- 
2.53.0


