Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE2AC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8LM-0004r6-UA; Thu, 25 Jul 2024 19:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8LL-0004b7-9g; Thu, 25 Jul 2024 19:57:55 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8LJ-0001TX-2z; Thu, 25 Jul 2024 19:57:55 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2cb55ff1007so302229a91.0; 
 Thu, 25 Jul 2024 16:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951870; x=1722556670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E9vQihLVQja70UkFc6q48xsISJb7pQ0WxLAo767cMMM=;
 b=YUifoK3ZoioKHronjuYBfgASjm+IiS6USt/lzJzJTwL4tPRj6x5EPMLROHnVLj4fz8
 qmKjYIPKMRkgJd7vcv8oDwF/azGl1N3Bz3qFDP8yfVR5dzQTScCZA3qCBngr4szb0Us3
 XlkzBgIO4rYMuAGuD+2PvSERBF+axmBFY7ym2m3R2paiQjNc4NL39tPjjO3J+krD1WBQ
 n5PSFEgC+HrHZM1Pf425ne3VQhlAJuxNgUeIBJydKUwp0z/2owolTEzszEFc1p6F2EEp
 DGtC2zej43KOjuuBs9FJkWHe8AnF84KmpMobbs4F1CcNS3uBdp9gVxgwkuROIDo0LFxB
 Xt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951870; x=1722556670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E9vQihLVQja70UkFc6q48xsISJb7pQ0WxLAo767cMMM=;
 b=JTtVpR5/w9D50r3Q5E9MoKvl7s+LEJ6oBXvZF6FClHN8nU+M1+Nb1u3FmDzUk1Rmv8
 IHRkWgwvPTtIIc/sJcjZ7up/1Aq8YA2C/mFE5HZEXzgQg0uDwQfNgeIOAUdWATr5ObzG
 vHhdOPAHjTkLxJjTsR2QfqmbRZ45U2we5UKiBobpITGcQOlMHzrn9Oy+dNlYuNq55Yah
 5biSM9ZJza0oDmZwc9uwpuzS7R02+B1ZAhxj4LkbplDyEgZ4WqL7bMnWK1DvqxYK7V20
 d+GF+en7DVSfN0qSalaFG3w/lgcqdkdog7oIUhyrsuIZEXUKA5PhXLsktaaJLgE6U13H
 DpXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9JS57kBk2yX+v/yw+azcZNDgFnoVYC9qG9dc03KKKuf8fcc3TDG+CWN9NuhlHw44wdPnbPVBxl7SGmSOEBXRoNrrm
X-Gm-Message-State: AOJu0YzJJZvrwUr8TaVca9tBUDNeBtcb04xRPLh8wekc414yfymWhBnA
 IMpwgQ8Q+uSpo7qzqBeQ05WOqjl7Ne1m8Kt5B2T78C3GSOSHlwNdMOZE1w==
X-Google-Smtp-Source: AGHT+IGotxEYTE2+7Ug+jVViATVOedsiPA4YLNHUPqVZOVQCtrCkrW+e/aCrpdIHmAru3k/KnynqtA==
X-Received: by 2002:a17:90a:9f86:b0:2c9:9b65:af4d with SMTP id
 98e67ed59e1d1-2cf2e9ad99emr3800615a91.7.1721951870599; 
 Thu, 25 Jul 2024 16:57:50 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:57:50 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 57/96] target/ppc: Move VSX logical instructions to decodetree.
Date: Fri, 26 Jul 2024 09:53:30 +1000
Message-ID: <20240725235410.451624-58-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Chinmay Rath <rathc@linux.ibm.com>

Moving the following instructions to decodetree specification :

	xxl{and, andc, or, orc, nor, xor, nand, eqv}	: XX3-form

The changes were verified by validating that the tcg ops generated by those
instructions remain the same, which were captured with the '-d in_asm,op' flag.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/insn32.decode            | 11 ++++++++
 target/ppc/translate/vsx-impl.c.inc | 39 +++++++++++++----------------
 target/ppc/translate/vsx-ops.c.inc  | 11 --------
 3 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 1301e5bbc0..4f86b175f1 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -1138,6 +1138,17 @@ XXMFACC         011111 ... -- 00000 ----- 0010110001 -   @X_a
 XXMTACC         011111 ... -- 00001 ----- 0010110001 -   @X_a
 XXSETACCZ       011111 ... -- 00011 ----- 0010110001 -   @X_a
 
+## VSX Vector Logical instructions
+
+XXLAND          111100 ..... ..... ..... 10000010 ...   @XX3
+XXLANDC         111100 ..... ..... ..... 10001010 ...   @XX3
+XXLOR           111100 ..... ..... ..... 10010010 ...   @XX3
+XXLXOR          111100 ..... ..... ..... 10011010 ...   @XX3
+XXLNOR          111100 ..... ..... ..... 10100010 ...   @XX3
+XXLEQV          111100 ..... ..... ..... 10111010 ...   @XX3
+XXLNAND         111100 ..... ..... ..... 10110010 ...   @XX3
+XXLORC          111100 ..... ..... ..... 10101010 ...   @XX3
+
 ## VSX GER instruction
 
 XVI4GER8        111011 ... -- ..... ..... 00100011 ..-  @XX3_at xa=%xx_xa
diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
index 0d16e0f02b..a769f199ce 100644
--- a/target/ppc/translate/vsx-impl.c.inc
+++ b/target/ppc/translate/vsx-impl.c.inc
@@ -1573,26 +1573,24 @@ static void gen_xxbrw(DisasContext *ctx)
     set_cpu_vsr(xT(ctx->opcode), xtl, false);
 }
 
-#define VSX_LOGICAL(name, vece, tcg_op)                              \
-static void glue(gen_, name)(DisasContext *ctx)                      \
-    {                                                                \
-        if (unlikely(!ctx->vsx_enabled)) {                           \
-            gen_exception(ctx, POWERPC_EXCP_VSXU);                   \
-            return;                                                  \
-        }                                                            \
-        tcg_op(vece, vsr_full_offset(xT(ctx->opcode)),               \
-               vsr_full_offset(xA(ctx->opcode)),                     \
-               vsr_full_offset(xB(ctx->opcode)), 16, 16);            \
-    }
-
-VSX_LOGICAL(xxland, MO_64, tcg_gen_gvec_and)
-VSX_LOGICAL(xxlandc, MO_64, tcg_gen_gvec_andc)
-VSX_LOGICAL(xxlor, MO_64, tcg_gen_gvec_or)
-VSX_LOGICAL(xxlxor, MO_64, tcg_gen_gvec_xor)
-VSX_LOGICAL(xxlnor, MO_64, tcg_gen_gvec_nor)
-VSX_LOGICAL(xxleqv, MO_64, tcg_gen_gvec_eqv)
-VSX_LOGICAL(xxlnand, MO_64, tcg_gen_gvec_nand)
-VSX_LOGICAL(xxlorc, MO_64, tcg_gen_gvec_orc)
+static bool do_logical_op(DisasContext *ctx, arg_XX3 *a, unsigned vece,
+    void (*helper)(unsigned, uint32_t, uint32_t, uint32_t, uint32_t, uint32_t))
+{
+    REQUIRE_VSX(ctx);
+    helper(vece, vsr_full_offset(a->xt),
+            vsr_full_offset(a->xa),
+            vsr_full_offset(a->xb), 16, 16);
+    return true;
+}
+
+TRANS_FLAGS2(VSX, XXLAND, do_logical_op, MO_64, tcg_gen_gvec_and);
+TRANS_FLAGS2(VSX, XXLANDC, do_logical_op, MO_64, tcg_gen_gvec_andc);
+TRANS_FLAGS2(VSX, XXLOR, do_logical_op, MO_64, tcg_gen_gvec_or);
+TRANS_FLAGS2(VSX, XXLXOR, do_logical_op, MO_64, tcg_gen_gvec_xor);
+TRANS_FLAGS2(VSX, XXLNOR, do_logical_op, MO_64, tcg_gen_gvec_nor);
+TRANS_FLAGS2(VSX207, XXLEQV, do_logical_op, MO_64, tcg_gen_gvec_eqv);
+TRANS_FLAGS2(VSX207, XXLNAND, do_logical_op, MO_64, tcg_gen_gvec_nand);
+TRANS_FLAGS2(VSX207, XXLORC, do_logical_op, MO_64, tcg_gen_gvec_orc);
 
 #define VSX_XXMRG(name, high)                               \
 static void glue(gen_, name)(DisasContext *ctx)             \
@@ -2899,4 +2897,3 @@ TRANS64(PMXVF64GERNN, do_ger, gen_helper_XVF64GERNN)
 #undef GEN_XX2IFORM
 #undef GEN_XX3_RC_FORM
 #undef GEN_XX3FORM_DM
-#undef VSX_LOGICAL
diff --git a/target/ppc/translate/vsx-ops.c.inc b/target/ppc/translate/vsx-ops.c.inc
index 18510d757d..3c0a70cb7c 100644
--- a/target/ppc/translate/vsx-ops.c.inc
+++ b/target/ppc/translate/vsx-ops.c.inc
@@ -263,17 +263,6 @@ GEN_XX2FORM_EO(xvcvhpsp, 0x16, 0x1D, 0x18, PPC2_ISA300),
 GEN_XX2FORM_EO(xvcvsphp, 0x16, 0x1D, 0x19, PPC2_ISA300),
 GEN_XX2FORM_EO(xxbrq, 0x16, 0x1D, 0x1F, PPC2_ISA300),
 
-#define VSX_LOGICAL(name, opc2, opc3, fl2) \
-GEN_XX3FORM(name, opc2, opc3, fl2)
-
-VSX_LOGICAL(xxland, 0x8, 0x10, PPC2_VSX),
-VSX_LOGICAL(xxlandc, 0x8, 0x11, PPC2_VSX),
-VSX_LOGICAL(xxlor, 0x8, 0x12, PPC2_VSX),
-VSX_LOGICAL(xxlxor, 0x8, 0x13, PPC2_VSX),
-VSX_LOGICAL(xxlnor, 0x8, 0x14, PPC2_VSX),
-VSX_LOGICAL(xxleqv, 0x8, 0x17, PPC2_VSX207),
-VSX_LOGICAL(xxlnand, 0x8, 0x16, PPC2_VSX207),
-VSX_LOGICAL(xxlorc, 0x8, 0x15, PPC2_VSX207),
 GEN_XX3FORM(xxmrghw, 0x08, 0x02, PPC2_VSX),
 GEN_XX3FORM(xxmrglw, 0x08, 0x06, PPC2_VSX),
 GEN_XX3FORM_DM(xxsldwi, 0x08, 0x00),
-- 
2.45.2


