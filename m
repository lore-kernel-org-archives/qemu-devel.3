Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A10DC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 20:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8PDs-0005oa-L4; Fri, 25 Apr 2025 16:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8PDq-0005kV-IJ
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 16:00:30 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8PDo-0001qG-Cu
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 16:00:30 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-af91fc1fa90so2436955a12.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 13:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745611227; x=1746216027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Cu65p5wA/kdMllhcJE399RRLiDKs0b7xdef5af6HKIw=;
 b=y22SLR6KkQ+4oVJ3xzqlb1LoZl7pUhCuYcp5xTPVKMVskY64xbBtFyRMLAg2R84idN
 VVz/so3z88r4lqjI2RWGszZJy4SUP73sTMmzRmNfBnheWn0JTTet4pQUn4tz8I2CD/6+
 w8h8jTI/zQhuljpX2GJEVeYbfUC/57ggiQ0LTzksLw+4wbRjLJCGHeaBpxLf+H/OyOAP
 IUEy1reHbsshVeQdHRBUZykEjLL1cHEHk+NS5hU46av5oajrJrcI+murKHWB460zkYyg
 8QPuw+fT/KZMtHyU9X2nV/qi8N1Snxs4A0rw41ItjHetxFGMEsZKgxMKNXCUIsLAWFDN
 lvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745611227; x=1746216027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cu65p5wA/kdMllhcJE399RRLiDKs0b7xdef5af6HKIw=;
 b=Q/XxWZmMpb3D97mqL5L0pQy28X3EuLSHnMoMe/2g7rQFsEjULnXr9JE9vfnmOgeG5n
 Mj2LqArIRR5kXHWGWDHwqubaK2Z86HrkiLE2dn6etSbmmK6FMlmcgN0t4P3OXi28hHK5
 IaE3288F7LPUhV3rStEkCKx1mzTVjFhSYsaIwTE4I96qMt5W4tSwIwrTPYmiu+Sv/LnV
 c4ikDnQ4qTOyaeNyDi+VyAyvTeYY94NV6k9KUnkdHe96b70GBdTdliCfVuTmumFPc8Yw
 /1JTrYxVtMlYeLsdXJBQwiGquSRIlDPyIIjzo5MzrZ7BUaU4CPK1JdsaIluEjNVfX16A
 0Gwg==
X-Gm-Message-State: AOJu0Yz88O0w0BhnNdtu0Okj5UgkPID7uB+zMRe3d0CQnjUhL44iram6
 6TsDVPQafzqTwu9YIlWbUHi8EtKN2QpqlDiWqvKHivkQ7is7cRRthc2Bile7XYs0r8f+G9pFs5/
 5
X-Gm-Gg: ASbGnctZ1Eh0jOy2EEFOsTKhDumcA8XToLTiTq3qqCVx83qOGVLf2WzHNGTYfgQwecf
 FL9M8G1e66PzpQjXmSvLaShqw8s2K11GtbjbJzpIOnPWzUZv1I1qqj8buz5IsW3oWRK68Hlv3DF
 Xa9Wn3up1v4mY6CcWmc5ysGniF25Gq2dnN1xJW5+gmfrTrbmQmT2jHTtPGvblSs5sdcOdu7IrI4
 pvpLhN0DLYx1R3Fp9Wy5pBTxJuN9vNphTZCWrcod1weDds6qmnxADTaPEkFuOaz//X/QQx8lXf4
 da929OSGmhh+UlLRNqW1QogN+SA6kKpeHPC+yTFx3yuKd7iCD8Ng6I5OcLYkuab3BDHFV7g4aok
 =
X-Google-Smtp-Source: AGHT+IENjZ3O69Ia8NqYA0gVS/l/c+NM32PU86s2LKaQYRvGXJ1GoA2LBBI9Y1l2SP0EM5A39hfRHQ==
X-Received: by 2002:a05:6a20:cf8f:b0:1f5:889c:3cbd with SMTP id
 adf61e73a8af0-2045b9f19d3mr5785887637.35.1745611226650; 
 Fri, 25 Apr 2025 13:00:26 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f7702f70sm3315981a12.10.2025.04.25.13.00.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 13:00:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] tcg/sparc64: Implement CTPOP
Date: Fri, 25 Apr 2025 13:00:24 -0700
Message-ID: <20250425200024.853260-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425200024.853260-1-richard.henderson@linaro.org>
References: <20250425200024.853260-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target.c.inc | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index d47c1d43b2..e5177d2f7f 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -210,6 +210,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define ARITH_UDIVX (INSN_OP(2) | INSN_OP3(0x0d))
 #define ARITH_SDIVX (INSN_OP(2) | INSN_OP3(0x2d))
 #define ARITH_MOVCC (INSN_OP(2) | INSN_OP3(0x2c))
+#define ARITH_POPC (INSN_OP(2) | INSN_OP3(0x2e))
 #define ARITH_MOVR (INSN_OP(2) | INSN_OP3(0x2f))
 
 #define ARITH_ADDXC (INSN_OP(2) | INSN_OP3(0x36) | INSN_OPF(0x11))
@@ -274,6 +275,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define STW_LE     (STWA  | INSN_ASI(ASI_PRIMARY_LITTLE))
 #define STX_LE     (STXA  | INSN_ASI(ASI_PRIMARY_LITTLE))
 
+static bool use_popc_instructions;
 #if defined(__VIS__) && __VIS__ >= 0x300
 #define use_vis3_instructions  1
 #else
@@ -1511,8 +1513,23 @@ static const TCGOutOpBinary outop_clz = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_ctpop(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_arith(s, a0, TCG_REG_G0, a1, ARITH_POPC);
+}
+
+static TCGConstraintSetIndex cset_ctpop(TCGType type, unsigned flags)
+{
+    if (use_popc_instructions && type == TCG_TYPE_I64) {
+        return C_O1_I1(r, r);
+    }
+    return C_NotImplemented;
+}
+
 static const TCGOutOpUnary outop_ctpop = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_ctpop,
+    .out_rr = tgen_ctpop,
 };
 
 static const TCGOutOpBinary outop_ctz = {
@@ -2084,15 +2101,15 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
 static void tcg_target_init(TCGContext *s)
 {
+    unsigned long hwcap = qemu_getauxval(AT_HWCAP);
+
     /*
      * Only probe for the platform and capabilities if we haven't already
      * determined maximum values at compile time.
      */
+    use_popc_instructions = (hwcap & HWCAP_SPARC_POPC) != 0;
 #ifndef use_vis3_instructions
-    {
-        unsigned long hwcap = qemu_getauxval(AT_HWCAP);
-        use_vis3_instructions = (hwcap & HWCAP_SPARC_VIS3) != 0;
-    }
+    use_vis3_instructions = (hwcap & HWCAP_SPARC_VIS3) != 0;
 #endif
 
     tcg_target_available_regs[TCG_TYPE_I32] = ALL_GENERAL_REGS;
-- 
2.43.0


