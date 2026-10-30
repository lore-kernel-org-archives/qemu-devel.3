Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A77606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ocVltD5c
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmTU-0003yW-NU; Fri, 30 Oct 2026 09:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSu-0002lu-Pz
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:20 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSq-0005WP-VK
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:15 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6deb848ddd7so535111eaf.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 06:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793366168; x=1793970968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=atAC01GEf0RC/TlwNQYSAbvHRgqsLoIGLDuuvf/uLTg=;
 b=ocVltD5cLbGmQAbV2JVYQJ0yJ83Ap/MOXgZLPMcNAMoaAhsaRMxiafOcrRZUsz1S76
 /BVyAIiLr/3JSvRoJZzxn6aVT9pYa9pwfckK2szYGKP0B4XFqzaxlbDXsduNrm/MhTrF
 SP14i1Ys6XgdcvW5gSXsUt/tAOJ9241cNDnopS0GpwoeBP6zAcOq3HbK+8wTdQ0muXFX
 ksY7nz8t4/wvLc1pGcZccxGc88Sgivxrx+AmMO6Aowg87/qkVWX+DZquGTO6RG9YyRBY
 ZGaE+Dv5qqjoot2OPwj3AKiKBX7wyLDMQc64fbmLigZzeHBAMODtcU4IB7QIL0oEsjwY
 GOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793366168; x=1793970968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=atAC01GEf0RC/TlwNQYSAbvHRgqsLoIGLDuuvf/uLTg=;
 b=iP18sIxzg2K1GDuOWZq3CBtcFJ8MRh4A0ty2oC/73VVbWOSIoq7yXyI2LfJLqoA9P7
 0ilL30QYbVLaXKq/L+qVieQs85ViZKGublqhc6Vv13nqEgYvn/D7ZM88qybvmbbiTni3
 ItcAW4F2zSIx5/TtfnyUcGEQHNNBr3GZmzBQVm3X5ZXbsf2CegTE3pbB0d/djksNYfJC
 NOUNkm605Dg/Wy7gWPA4CNCyQDEwlJSZSAqDuVQtH/GEaKd19TRJk2AAl0tmHoSyyVQG
 2e+HUJnaiQXzZMMORo/dnA1PfWXDU5pf6bbPQgS7SAuYmiFQwm4cys8s+rUrQNLFKxD0
 SnOQ==
X-Gm-Message-State: AFq9FYJ6XRyAimwDZKf+UrZ74qWMI4PaK69VIQ/lgiuFpCdhfhu7MMUF
 p0mOUXwcpPERjjnNKiD4CUDq2MHfIcRCYRbrGutlnV/zg6kSqg26SJZ0AugqYaOKRn1var55eZg
 BusVJ
X-Gm-Gg: AYBFou0Vrap+KYcchB8o1Atx7Q4hnG5U1b7YGgUQKjHYjqXdJbPZ7442x+WVlOWwp8F
 zG7HojPVVIeR5OknHA/8IYhpEbvaFNk7FMn2ZmMFqlY0LXJrE1wI7Fhs/rxuSaP7IzDQce/Ax41
 s+7l24mHctxrcd/zPOHhGryCvDhOyUuNiBsl4kZ9QC8FMZAu3CDeSwuq/+pzYK6938J5sWYu6gY
 eIPS1GjyFetrlDTg7GD3DN9CMx8XPpJfxzR59Lqpv5wEBN9q8owL0myvykZFBVwc1/rQbhuCDAa
 AClQUl5a4epal1G0jdzhMlGlU8/gle7kLVoBNWgxyvthHkr4BSoTn3AOwWRoGKsvrh95tDMYDWM
 N8yq6/wgvsRtLNH73HHKayB7W2+seuGh50Y45ZCM2096DnOWBRMO9edLqcg5Oj/UJqGPvxDJuAD
 tNMcEMHcgLiaMrB22FTR29nrIeDfuOVQNxeZABD7YHSgBnymUF3oYrhSx16EXsf+B6F2XpCi6Bw
 I/ihTPj2OB9pxpgoM3ts0+eGAx6r3HhDHJAPYpehNOR0fth1kerwdo8El94BUuhqNdQWlFgfh3q
 qbyDnjF+rDzsDGLppbbRhcl3Knv4ew==
X-Received: by 2002:a05:6820:7097:20b0:6b7:83c5:fde8 with SMTP id
 006d021491bc7-714f240aab7mr873627eaf.41.1793366167995; 
 Fri, 30 Oct 2026 06:16:07 -0700 (PDT)
Received: from stoup ([50.233.235.3]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a90ae4e6bcsm1796812fac.3.2026.10.30.06.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:16:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 13/19] tcg/x86_64: Introduce TCG_REG_NONE
Date: Fri, 30 Oct 2026 08:15:48 -0500
Message-ID: <20261030131554.41208-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030131554.41208-1-richard.henderson@linaro.org>
References: <20261030131554.41208-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Rather than hard-code -1, or compare < 0, use something
more descriptive.  This also allows more use of TCGReg.

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/x86_64/tcg-target.h     |  1 +
 tcg/x86_64/tcg-target.c.inc | 66 ++++++++++++++++++++-----------------
 2 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/tcg/x86_64/tcg-target.h b/tcg/x86_64/tcg-target.h
index 7ebae56a7d..7109722f24 100644
--- a/tcg/x86_64/tcg-target.h
+++ b/tcg/x86_64/tcg-target.h
@@ -31,6 +31,7 @@
 #define MAX_CODE_GEN_BUFFER_SIZE  (2 * GiB)
 
 typedef enum {
+    TCG_REG_NONE = -1,
     TCG_REG_EAX = 0,
     TCG_REG_ECX,
     TCG_REG_EDX,
diff --git a/tcg/x86_64/tcg-target.c.inc b/tcg/x86_64/tcg-target.c.inc
index 46efee87e6..d85e95a32b 100644
--- a/tcg/x86_64/tcg-target.c.inc
+++ b/tcg/x86_64/tcg-target.c.inc
@@ -210,7 +210,8 @@ static bool tcg_target_const_match(int64_t val, int ct,
     return 0;
 }
 
-# define LOWREGMASK(x)	((x) & 7)
+#define LOWREGMASK(x)   ((x) & 7)
+#define REGOR0(x)       ((x) == TCG_REG_NONE ? 0 : (x))
 
 #define P_EXT		0x100		/* 0x0f opcode prefix */
 #define P_EXT38         0x200           /* 0x0f 0x38 opcode prefix */
@@ -525,7 +526,7 @@ static const uint8_t tcg_cond_to_jcc[] = {
     [TCG_COND_TSTNE] = JCC_JNE,
 };
 
-static void tcg_out_opc(TCGContext *s, int opc, int r, int rm, int x)
+static void tcg_out_opc(TCGContext *s, int opc, TCGReg r, TCGReg rm, TCGReg x)
 {
     int rex;
 
@@ -573,14 +574,14 @@ static void tcg_out_opc(TCGContext *s, int opc, int r, int rm, int x)
     tcg_out8(s, opc);
 }
 
-static void tcg_out_modrm(TCGContext *s, int opc, int r, int rm)
+static void tcg_out_modrm(TCGContext *s, int opc, TCGReg r, TCGReg rm)
 {
     tcg_out_opc(s, opc, r, rm, 0);
     tcg_out8(s, 0xc0 | (LOWREGMASK(r) << 3) | LOWREGMASK(rm));
 }
 
-static void tcg_out_vex_opc(TCGContext *s, int opc, int r, int v,
-                            int rm, int index)
+static void tcg_out_vex_opc(TCGContext *s, int opc, TCGReg r, TCGReg v,
+                            TCGReg rm, TCGReg index)
 {
     int tmp;
 
@@ -631,8 +632,8 @@ static void tcg_out_vex_opc(TCGContext *s, int opc, int r, int v,
     tcg_out8(s, opc);
 }
 
-static void tcg_out_evex_opc(TCGContext *s, int opc, int r, int v,
-                             int rm, int index, int aaa, bool z)
+static void tcg_out_evex_opc(TCGContext *s, int opc, TCGReg r, TCGReg v,
+                             TCGReg rm, TCGReg index, int aaa, bool z)
 {
     /* The entire 4-byte evex prefix; with R' and V' set. */
     uint32_t p = 0x08041062;
@@ -677,7 +678,8 @@ static void tcg_out_evex_opc(TCGContext *s, int opc, int r, int v,
     tcg_out8(s, opc);
 }
 
-static void tcg_out_vex_modrm(TCGContext *s, int opc, int r, int v, int rm)
+static void tcg_out_vex_modrm(TCGContext *s, int opc, TCGReg r,
+                              TCGReg v, TCGReg rm)
 {
     if (opc & P_EVEX) {
         tcg_out_evex_opc(s, opc, r, v, rm, 0, 0, false);
@@ -688,7 +690,7 @@ static void tcg_out_vex_modrm(TCGContext *s, int opc, int r, int v, int rm)
 }
 
 static void tcg_out_vex_modrm_type(TCGContext *s, int opc,
-                                   int r, int v, int rm, TCGType type)
+                                   TCGReg r, TCGReg v, TCGReg rm, TCGType type)
 {
     if (type == TCG_TYPE_V256) {
         opc |= P_VEXL;
@@ -696,8 +698,8 @@ static void tcg_out_vex_modrm_type(TCGContext *s, int opc,
     tcg_out_vex_modrm(s, opc, r, v, rm);
 }
 
-static void tcg_out_evex_modrm_type(TCGContext *s, int opc, int r, int v,
-                                    int rm, int aaa, bool z, TCGType type)
+static void tcg_out_evex_modrm_type(TCGContext *s, int opc, TCGReg r, TCGReg v,
+                                    TCGReg rm, int aaa, bool z, TCGType type)
 {
     if (type == TCG_TYPE_V256) {
         opc |= P_VEXL;
@@ -711,12 +713,12 @@ static void tcg_out_evex_modrm_type(TCGContext *s, int opc, int r, int v,
    mode for absolute addresses, ~RM is the size of the immediate operand
    that will follow the instruction.  */
 
-static void tcg_out_sib_offset(TCGContext *s, int r, int rm, int index,
+static void tcg_out_sib_offset(TCGContext *s, TCGReg r, TCGReg rm, TCGReg index,
                                int shift, intptr_t offset)
 {
     int mod, len;
 
-    if (index < 0 && rm < 0) {
+    if (index == TCG_REG_NONE && rm == TCG_REG_NONE) {
         /*
          * Try for a rip-relative addressing mode.  This has replaced
          * the 32-bit-mode absolute addressing encoding.
@@ -747,7 +749,7 @@ static void tcg_out_sib_offset(TCGContext *s, int r, int rm, int index,
 
     /* Find the length of the immediate addend.  Note that the encoding
        that would be used for (%ebp) indicates absolute addressing.  */
-    if (rm < 0) {
+    if (rm == TCG_REG_NONE) {
         mod = 0, len = 4, rm = 5;
     } else if (offset == 0 && LOWREGMASK(rm) != TCG_REG_EBP) {
         mod = 0, len = 0;
@@ -759,7 +761,7 @@ static void tcg_out_sib_offset(TCGContext *s, int r, int rm, int index,
 
     /* Use a single byte MODRM format if possible.  Note that the encoding
        that would be used for %esp is the escape to the two byte form.  */
-    if (index < 0 && LOWREGMASK(rm) != TCG_REG_ESP) {
+    if (index == TCG_REG_NONE && LOWREGMASK(rm) != TCG_REG_ESP) {
         /* Single byte MODRM format.  */
         tcg_out8(s, mod | (LOWREGMASK(r) << 3) | LOWREGMASK(rm));
     } else {
@@ -768,7 +770,7 @@ static void tcg_out_sib_offset(TCGContext *s, int r, int rm, int index,
         /* Note that the encoding that would place %esp into the index
            field indicates no index register.  In 64-bit mode, the REX.X
            bit counts, so %r12 can be used as the index.  */
-        if (index < 0) {
+        if (index == TCG_REG_NONE) {
             index = 4;
         } else {
             tcg_debug_assert(index != TCG_REG_ESP);
@@ -785,32 +787,34 @@ static void tcg_out_sib_offset(TCGContext *s, int r, int rm, int index,
     }
 }
 
-static void tcg_out_modrm_sib_offset(TCGContext *s, int opc, int r, int rm,
-                                     int index, int shift, intptr_t offset)
+static void tcg_out_modrm_sib_offset(TCGContext *s, int opc, TCGReg r,
+                                     TCGReg rm, TCGReg index,
+                                     int shift, intptr_t offset)
 {
-    tcg_out_opc(s, opc, r, rm < 0 ? 0 : rm, index < 0 ? 0 : index);
+    tcg_out_opc(s, opc, r, REGOR0(rm), REGOR0(index));
     tcg_out_sib_offset(s, r, rm, index, shift, offset);
 }
 
-static void tcg_out_vex_modrm_sib_offset(TCGContext *s, int opc, int r, int v,
-                                         int rm, int index, int shift,
+static void tcg_out_vex_modrm_sib_offset(TCGContext *s, int opc,
+                                         TCGReg r, TCGReg v, TCGReg rm,
+                                         TCGReg index, int shift,
                                          intptr_t offset)
 {
-    tcg_out_vex_opc(s, opc, r, v, rm < 0 ? 0 : rm, index < 0 ? 0 : index);
+    tcg_out_vex_opc(s, opc, r, v, REGOR0(rm), REGOR0(index));
     tcg_out_sib_offset(s, r, rm, index, shift, offset);
 }
 
 /* A simplification of the above with no index or shift.  */
-static inline void tcg_out_modrm_offset(TCGContext *s, int opc, int r,
-                                        int rm, intptr_t offset)
+static void tcg_out_modrm_offset(TCGContext *s, int opc, TCGReg r,
+                                 TCGReg rm, intptr_t offset)
 {
-    tcg_out_modrm_sib_offset(s, opc, r, rm, -1, 0, offset);
+    tcg_out_modrm_sib_offset(s, opc, r, rm, TCG_REG_NONE, 0, offset);
 }
 
-static inline void tcg_out_vex_modrm_offset(TCGContext *s, int opc, int r,
-                                            int v, int rm, intptr_t offset)
+static void tcg_out_vex_modrm_offset(TCGContext *s, int opc, TCGReg r,
+                                     TCGReg v, TCGReg rm, intptr_t offset)
 {
-    tcg_out_vex_modrm_sib_offset(s, opc, r, v, rm, -1, 0, offset);
+    tcg_out_vex_modrm_sib_offset(s, opc, r, v, rm, TCG_REG_NONE, 0, offset);
 }
 
 /* Output an opcode with an expected reference to the constant pool.  */
@@ -1890,7 +1894,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 
 #ifdef CONFIG_USER_ONLY
 static HostAddress x86_guest_base = {
-    .index = -1
+    .index = TCG_REG_NONE
 };
 
 #if defined(__linux__)
@@ -2174,7 +2178,7 @@ static void tgen_qemu_ld(TCGContext *s, TCGType type, TCGReg data,
     HostAddress h;
 
     ldst = prepare_host_addr(s, &h, addr, oi, true);
-    tcg_out_qemu_ld_direct(s, data, -1, h, type, get_memop(oi));
+    tcg_out_qemu_ld_direct(s, data, TCG_REG_NONE, h, type, get_memop(oi));
 
     if (ldst) {
         ldst->type = type;
@@ -2312,7 +2316,7 @@ static void tgen_qemu_st(TCGContext *s, TCGType type, TCGReg data,
     HostAddress h;
 
     ldst = prepare_host_addr(s, &h, addr, oi, false);
-    tcg_out_qemu_st_direct(s, data, -1, h, get_memop(oi));
+    tcg_out_qemu_st_direct(s, data, TCG_REG_NONE, h, get_memop(oi));
 
     if (ldst) {
         ldst->type = type;
-- 
2.53.0


