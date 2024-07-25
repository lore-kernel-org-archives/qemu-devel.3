Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DBBC3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8LQ-0005ao-VA; Thu, 25 Jul 2024 19:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8LO-0005Em-LY; Thu, 25 Jul 2024 19:57:58 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8LM-0001UG-EP; Thu, 25 Jul 2024 19:57:58 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2cb4b6ecb3dso297693a91.3; 
 Thu, 25 Jul 2024 16:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951874; x=1722556674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UTxSm/R8dHWAfGGPYY701TgFo6fw0I+acE2mG7oqJ6s=;
 b=cUIts4MjtVKTLLORF07prxnUPDjvR78a37uIOro5Y/2zqacCzvIDC3EHkj20PUfBkE
 FXuvODPYEugft4I8Qts1kBLspkalvfacg4CB5cZbjgc2ORK+XsmM8vDSiqpIXOmMWSNS
 LCn1yxm2gzG+PFRqhldN3yAhR5ankYb9dv6ZDGIG5z7av+XEL/FXtyIDasuH17rolRhl
 q02qR7aKde/08eBtUGCRq6ow4PbsUvWCnlarsglw0U0KFb+5gTsTm9SLmhXO7PRrqSmj
 kdrZa8wCivMTuJHHGPUaJ20Psacs34r2pbT2EdzSnbTNNmjYJSsSuV3Uaasgd3wRC7jT
 zXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951874; x=1722556674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UTxSm/R8dHWAfGGPYY701TgFo6fw0I+acE2mG7oqJ6s=;
 b=N0SdF6IKoWPXmFQVKw00DefgzxOoZoK9qC47tsYy/A0qZFRoGPQMVXIs3Jp7ACMhpT
 on+kn9e3TfSLBCpC2BIHn5anbqQvJFEgri3YteXjWZHxh30mkn/6jjZiPZVLNhgmaOja
 bte77fj0yCPhsHfgn6hd6PtGsqLD4al0meDZiwmf40ihrWBgA28ryvtVBfQIT+kxSEeE
 mi0b+pMmNZFwqBrULo2ITTMKO1emHx7+78AQUFRxH9dkqyR2+JtuyHzGEO7w0Dv/OMkl
 EMe/VGCSt6hW5hgq9J4gueQdPdxYPxUtTu1r87bkZHrRdsiRICIyBZQkFOo31DU2BsEE
 omxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8aoB+SkW2yqJqDhbGSbZQ3IQ7xoq1I//y5tcHfLRYmKnSZGL+QynX/Vdub7Xxufql1J73Y2bBQ34rsZs0unejCnyV
X-Gm-Message-State: AOJu0YwQ4/LupjFz5vAfVaUKDdNMLysVfdZsfcO6ULAWT5oic7Mu7NRf
 fKiYPFZY4IS8pSED1+ExqMF2H4wOycijqDqxRyO4RvdeWyQ61BlnRVH9pg==
X-Google-Smtp-Source: AGHT+IHAs4n8b9/UwOSOAVoTK3/cYt60D2oSPAVIFc8tWVsRF2vzYh8NgmR5YXat1Ctaa5KOEedWlw==
X-Received: by 2002:a17:90a:c683:b0:2cb:4b88:2aaf with SMTP id
 98e67ed59e1d1-2cf237b7d2dmr5441689a91.12.1721951874256; 
 Thu, 25 Jul 2024 16:57:54 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:57:53 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 58/96] target/ppc: Moving VSX scalar storage access insns to
 decodetree.
Date: Fri, 26 Jul 2024 09:53:31 +1000
Message-ID: <20240725235410.451624-59-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1033.google.com
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

	lxs{d, iwa, ibz, ihz, iwz, sp}x		: X-form
	stxs{d, ib, ih, iw, sp}x		: X-form

The changes were verified by validating that the tcg-ops generated by those
instructions remain the same, which were captured using the '-d in_asm,op' flag.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/insn32.decode            | 13 +++++
 target/ppc/translate/vsx-impl.c.inc | 79 +++++++++++++----------------
 target/ppc/translate/vsx-ops.c.inc  | 11 ----
 3 files changed, 49 insertions(+), 54 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 4f86b175f1..f2661df918 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -993,6 +993,19 @@ STXVRHX         011111 ..... ..... ..... 0010101101 .   @X_TSX
 STXVRWX         011111 ..... ..... ..... 0011001101 .   @X_TSX
 STXVRDX         011111 ..... ..... ..... 0011101101 .   @X_TSX
 
+LXSDX           011111 ..... ..... ..... 1001001100 .   @X_TSX
+LXSIWAX         011111 ..... ..... ..... 0001001100 .   @X_TSX
+LXSIBZX         011111 ..... ..... ..... 1100001101 .   @X_TSX
+LXSIHZX         011111 ..... ..... ..... 1100101101 .   @X_TSX
+LXSIWZX         011111 ..... ..... ..... 0000001100 .   @X_TSX
+LXSSPX          011111 ..... ..... ..... 1000001100 .   @X_TSX
+
+STXSDX          011111 ..... ..... ..... 1011001100 .   @X_TSX
+STXSIBX         011111 ..... ..... ..... 1110001101 .   @X_TSX
+STXSIHX         011111 ..... ..... ..... 1110101101 .   @X_TSX
+STXSIWX         011111 ..... ..... ..... 0010001100 .   @X_TSX
+STXSSPX         011111 ..... ..... ..... 1010001100 .   @X_TSX
+
 ## VSX Vector Binary Floating-Point Sign Manipulation Instructions
 
 XVABSDP         111100 ..... 00000 ..... 111011001 ..   @XX2
diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
index a769f199ce..de2a26a213 100644
--- a/target/ppc/translate/vsx-impl.c.inc
+++ b/target/ppc/translate/vsx-impl.c.inc
@@ -24,30 +24,27 @@ static inline TCGv_ptr gen_acc_ptr(int reg)
     return r;
 }
 
-#define VSX_LOAD_SCALAR(name, operation)                      \
-static void gen_##name(DisasContext *ctx)                     \
-{                                                             \
-    TCGv EA;                                                  \
-    TCGv_i64 t0;                                              \
-    if (unlikely(!ctx->vsx_enabled)) {                        \
-        gen_exception(ctx, POWERPC_EXCP_VSXU);                \
-        return;                                               \
-    }                                                         \
-    t0 = tcg_temp_new_i64();                                  \
-    gen_set_access_type(ctx, ACCESS_INT);                     \
-    EA = tcg_temp_new();                                      \
-    gen_addr_reg_index(ctx, EA);                              \
-    gen_qemu_##operation(ctx, t0, EA);                        \
-    set_cpu_vsr(xT(ctx->opcode), t0, true);                   \
-    /* NOTE: cpu_vsrl is undefined */                         \
+static bool do_lxs(DisasContext *ctx, arg_X *a,
+                   void (*op)(DisasContext *, TCGv_i64, TCGv))
+{
+    TCGv EA;
+    TCGv_i64 t0;
+    REQUIRE_VSX(ctx);
+    t0 = tcg_temp_new_i64();
+    gen_set_access_type(ctx, ACCESS_INT);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
+    op(ctx, t0, EA);
+    set_cpu_vsr(a->rt, t0, true);
+    /* NOTE: cpu_vsrl is undefined */
+    return true;
 }
 
-VSX_LOAD_SCALAR(lxsdx, ld64_i64)
-VSX_LOAD_SCALAR(lxsiwax, ld32s_i64)
-VSX_LOAD_SCALAR(lxsibzx, ld8u_i64)
-VSX_LOAD_SCALAR(lxsihzx, ld16u_i64)
-VSX_LOAD_SCALAR(lxsiwzx, ld32u_i64)
-VSX_LOAD_SCALAR(lxsspx, ld32fs)
+TRANS_FLAGS2(VSX, LXSDX, do_lxs, gen_qemu_ld64_i64);
+TRANS_FLAGS2(VSX207, LXSIWAX, do_lxs, gen_qemu_ld32s_i64);
+TRANS_FLAGS2(ISA300, LXSIBZX, do_lxs, gen_qemu_ld8u_i64);
+TRANS_FLAGS2(ISA300, LXSIHZX, do_lxs, gen_qemu_ld16u_i64);
+TRANS_FLAGS2(VSX207, LXSIWZX, do_lxs, gen_qemu_ld32u_i64);
+TRANS_FLAGS2(VSX207, LXSSPX, do_lxs, gen_qemu_ld32fs);
 
 static void gen_lxvd2x(DisasContext *ctx)
 {
@@ -266,29 +263,25 @@ VSX_VECTOR_LOAD_STORE_LENGTH(stxvl)
 VSX_VECTOR_LOAD_STORE_LENGTH(stxvll)
 #endif
 
-#define VSX_STORE_SCALAR(name, operation)                     \
-static void gen_##name(DisasContext *ctx)                     \
-{                                                             \
-    TCGv EA;                                                  \
-    TCGv_i64 t0;                                              \
-    if (unlikely(!ctx->vsx_enabled)) {                        \
-        gen_exception(ctx, POWERPC_EXCP_VSXU);                \
-        return;                                               \
-    }                                                         \
-    t0 = tcg_temp_new_i64();                                  \
-    gen_set_access_type(ctx, ACCESS_INT);                     \
-    EA = tcg_temp_new();                                      \
-    gen_addr_reg_index(ctx, EA);                              \
-    get_cpu_vsr(t0, xS(ctx->opcode), true);                   \
-    gen_qemu_##operation(ctx, t0, EA);                        \
+static bool do_stxs(DisasContext *ctx, arg_X *a,
+                    void (*op)(DisasContext *, TCGv_i64, TCGv))
+{
+    TCGv EA;
+    TCGv_i64 t0;
+    REQUIRE_VSX(ctx);
+    t0 = tcg_temp_new_i64();
+    gen_set_access_type(ctx, ACCESS_INT);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
+    get_cpu_vsr(t0, a->rt, true);
+    op(ctx, t0, EA);
+    return true;
 }
 
-VSX_STORE_SCALAR(stxsdx, st64_i64)
-
-VSX_STORE_SCALAR(stxsibx, st8_i64)
-VSX_STORE_SCALAR(stxsihx, st16_i64)
-VSX_STORE_SCALAR(stxsiwx, st32_i64)
-VSX_STORE_SCALAR(stxsspx, st32fs)
+TRANS_FLAGS2(VSX, STXSDX, do_stxs, gen_qemu_st64_i64);
+TRANS_FLAGS2(ISA300, STXSIBX, do_stxs, gen_qemu_st8_i64);
+TRANS_FLAGS2(ISA300, STXSIHX, do_stxs, gen_qemu_st16_i64);
+TRANS_FLAGS2(VSX207, STXSIWX, do_stxs, gen_qemu_st32_i64);
+TRANS_FLAGS2(VSX207, STXSSPX, do_stxs, gen_qemu_st32fs);
 
 static void gen_stxvd2x(DisasContext *ctx)
 {
diff --git a/target/ppc/translate/vsx-ops.c.inc b/target/ppc/translate/vsx-ops.c.inc
index 3c0a70cb7c..d44cb55836 100644
--- a/target/ppc/translate/vsx-ops.c.inc
+++ b/target/ppc/translate/vsx-ops.c.inc
@@ -1,9 +1,3 @@
-GEN_HANDLER_E(lxsdx, 0x1F, 0x0C, 0x12, 0, PPC_NONE, PPC2_VSX),
-GEN_HANDLER_E(lxsiwax, 0x1F, 0x0C, 0x02, 0, PPC_NONE, PPC2_VSX207),
-GEN_HANDLER_E(lxsiwzx, 0x1F, 0x0C, 0x00, 0, PPC_NONE, PPC2_VSX207),
-GEN_HANDLER_E(lxsibzx, 0x1F, 0x0D, 0x18, 0, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER_E(lxsihzx, 0x1F, 0x0D, 0x19, 0, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER_E(lxsspx, 0x1F, 0x0C, 0x10, 0, PPC_NONE, PPC2_VSX207),
 GEN_HANDLER_E(lxvd2x, 0x1F, 0x0C, 0x1A, 0, PPC_NONE, PPC2_VSX),
 GEN_HANDLER_E(lxvwsx, 0x1F, 0x0C, 0x0B, 0, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(lxvdsx, 0x1F, 0x0C, 0x0A, 0, PPC_NONE, PPC2_VSX),
@@ -15,11 +9,6 @@ GEN_HANDLER_E(lxvl, 0x1F, 0x0D, 0x08, 0, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(lxvll, 0x1F, 0x0D, 0x09, 0, PPC_NONE, PPC2_ISA300),
 #endif
 
-GEN_HANDLER_E(stxsdx, 0x1F, 0xC, 0x16, 0, PPC_NONE, PPC2_VSX),
-GEN_HANDLER_E(stxsibx, 0x1F, 0xD, 0x1C, 0, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER_E(stxsihx, 0x1F, 0xD, 0x1D, 0, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER_E(stxsiwx, 0x1F, 0xC, 0x04, 0, PPC_NONE, PPC2_VSX207),
-GEN_HANDLER_E(stxsspx, 0x1F, 0xC, 0x14, 0, PPC_NONE, PPC2_VSX207),
 GEN_HANDLER_E(stxvd2x, 0x1F, 0xC, 0x1E, 0, PPC_NONE, PPC2_VSX),
 GEN_HANDLER_E(stxvw4x, 0x1F, 0xC, 0x1C, 0, PPC_NONE, PPC2_VSX),
 GEN_HANDLER_E(stxvh8x, 0x1F, 0x0C, 0x1D, 0, PPC_NONE,  PPC2_ISA300),
-- 
2.45.2


