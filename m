Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E323606A325
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ivdXPBIJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM6aH-0006VW-1n; Wed, 28 Oct 2026 12:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6aE-0006U9-JB
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:33:02 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6aC-0007XW-Dl
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:33:02 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-8253bc5a613so798094a34.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 09:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793205179; x=1793809979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=atAC01GEf0RC/TlwNQYSAbvHRgqsLoIGLDuuvf/uLTg=;
 b=ivdXPBIJ3eDjFGYYE8dvAUU2a5YskLg/6DJXaLWO32vyMhIbPxR9rsiLBdMAhwVSzN
 8j5t6a4TvAuDOlmJtezdvaHjjXZRfaqi0m+qFHryD2DwmfQ2AYIMEGrfc9CHqCrTIVZ0
 vpDn+R1GE9LxM+78ml8QcsJL+H2v8GNxwOpzeC+JBsWtWGWnT/fOwBz9jRGkG8JCeWlW
 SVxhqRlgtO36cAz67Zi+n83Bg8hPkGVrk38rbIwNkiFSwA4N6GshZYzv40cGrxMWDNDC
 pyB1mO4hWyCuWMUCapGAi+2ifX/vM+sVwJC2hrJM02eklKBjyQ6BizpwD2x6xvC2HB0e
 +f9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793205179; x=1793809979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=atAC01GEf0RC/TlwNQYSAbvHRgqsLoIGLDuuvf/uLTg=;
 b=eQgxfl5ZuAZ2okOr0NVxg9jfALePWu0ou2wP9FO5MkB/gvFxENc4gQp3HA3A+uxnpp
 X0Z8Jd0xNt/AZAVYibEj5157NEDV05f3xk6GJbz9vLaTZboddKbcb/f+r0aBQMQqLiTL
 rxcKUv46lYwXuxqn84Qj+13JkCet8fLZ58BCdbAoaG+OerWERw0Deu40ihZnQDFoX8wy
 R13oLSiYxRr7/gYLhqZDW+VC+GMM7Aueqr9IYioijDGNk4ac89H/z7NBks7HsSpXlgFI
 mjYcy6S0ASx6WUNcyBA7UEzmRe2bh+ZgZ8nWNM0xA/tc66DYywXgIlyGoK4yomjWYtUG
 3uLQ==
X-Gm-Message-State: AFq9FYJeuDokmp9fsNwSfWUdxv/lpDLEcZdPZ4LZNanQQ5GNiKUr1q9H
 t/rhcGcSKOw+nbjBpGoGtTcQI5bVjLr+3pt1jrqeNoh0XSkobB+amcnDQsW6ntpFt5k6cjjgiDF
 uKF1J
X-Gm-Gg: AYBFou05OTG/j3tMVDuREDX5TLYic6enCO106SDYt+W6EG0rUwUQ5CQ8KWjsVr7i56h
 e1oO/4w3qpGXbbe+chFziigBSI94oUyezVWOHLpGoxg00VpUyf0srrKfJBOntzrjGU3GatEC06J
 yEFSmVCmeuSIT/eoAPReqsmw6Zcgyfj/WNI2RkKXW3JXr/OcanAGtCTq7X3Ww4mb+aKkq2H6m//
 3hXZOtZFNGRZ/B+Gg9t15Cui3fb18mMzD52x4WLbVqXxSdyXV0KEEDt1hQlLV7aoSnMZwghMBD0
 7aeiBLekc4PcA8LyGahnW46bTQku33wa4TC2XQFbT6OyiukHYb5uClWY9SWjjxkKxx5+gwoGQmw
 f777GdZKIWo1yrgUx/4F/5Pkiac95aSnjiFysR+SNJyxNAGn+3fOMmddXuThJ1xfExPaz78Tgk6
 g7yDIduWY9WFyvqHnBd5hkRt/C+cb7uxbxmOo3OkGERfTlihzWGn+HS3mh2Ba909AF4KLGX/3H7
 4CU7Vcty68qL02ddZaDtGwuDOWpQerZbWkToZTefa39psAqU00L40dSWQl+UAsemPXyLJHbIaYY
 aXyMOJV9IVeR0V8t14fpUYo5r/BCts4kMQ==
X-Received: by 2002:a05:6830:44a3:b0:843:b6f8:de3f with SMTP id
 46e09a7af769-85ab7c048d4mr2775768a34.18.1793205179076; 
 Wed, 28 Oct 2026 09:32:59 -0700 (PDT)
Received: from stoup ([2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b1f4368f3sm2538965a34.7.2026.10.28.09.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:32:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v3 10/16] tcg/x86_64: Introduce TCG_REG_NONE
Date: Wed, 28 Oct 2026 11:32:39 -0500
Message-ID: <20261028163245.1031673-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028163245.1031673-1-richard.henderson@linaro.org>
References: <20261028163245.1031673-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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


