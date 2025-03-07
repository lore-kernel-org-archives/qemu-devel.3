Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D27C282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZIT-00010m-5u; Fri, 07 Mar 2025 10:07:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIR-000108-Dn
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:31 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIO-0008IT-I4
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:31 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3912fdddf8fso908910f8f.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741360047; x=1741964847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sPQzlaT0o0OQv6YSIoANGooc60IYlGPPa8yEd55FTZY=;
 b=tEQ2plXsuPBXDt5CX0G0Q1N/bldX2cygHPW5ksPr+6Lf1c37EKQ+aguLtWU7Rf8zCo
 /7upp0JH7jfuZjGE+9ckibz3Fok0ebGzpjiMgEMDD5XROPDI4884iI9lbc7rYELWsZ/M
 YiePlKKAxYuutG7EhVxpbTMuXXjn50azwqo/81DzE8dtMZrZ0GAhB4fNDBek57F3hECi
 EzRsJjrHYBWllGfUrMdBm1W579gIVESNOH6jvDnmz5e649RnPGLYLYt02v8OmR+O/b0D
 C2/QKFyPoEew/iSF24qq4e9it9EvEOWvF1CdgMjIRrlOrNdn/T4V+eaWGWxMFxILJrXV
 LJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741360047; x=1741964847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sPQzlaT0o0OQv6YSIoANGooc60IYlGPPa8yEd55FTZY=;
 b=JqGW6j0XlwSMnFsghBCKJ1F1G38/5dBzUIMY2X9i5EJUec6/qjWOCfV2fEMCSP+npw
 5iic/D+UXkRLEEBlkv6+oJNdkY/i65ITXSlXFR5vVwPVhm5+lgk7dP1CdvQL4KF6dSpt
 pe0CJNFYY2kQRCgXj+efwz2kaY/ZYXPWXGQsA4Y+RJF+syz2anmrYUWp4+an3i6FKh7V
 ctGosvGqmz5hJNcbPpg++dfRaRQGCoCaGfzHF3uPBXfjCULpC8Fp5OzLSHsYFnKX/ZH3
 AGP4DuK2QD0C1GCT7euNK5fXXcw7LCW17PoHZz58B/T0s9q0yJoYw7J2B+D9A5OLwqwR
 INrQ==
X-Gm-Message-State: AOJu0YyOhLngRYx8sZjh+BHUGxM79g6MlbKyhOOoKTN7olmZDnzPeWUu
 MmwuOGT3PeLqOcFOsY94qXLYZqph8oc8zScHEHEev+RwZLC27NBcvlVP0/08dCnk9xMbQa84Pta
 m
X-Gm-Gg: ASbGncsG1XDwrBDB6XN3amaisDcovYtZu5d1MyhaTcA+DAQtAuPBJEpDjwhEaSP3p7X
 2hgTDP+5fHOjLuW4fqR/9HuTrKVQOlxg30L9f6dfo03V1Ma9D3GMp8yuVUu1A89Y8oWNQvRj3am
 JQmlNVGdVPc9QAROLVveDx1mX70rPDmBzbSfBTMAMQwNKjY+3PE+psQm+g8bua9aLNaJRJfHse+
 SnXuKpahnIxxqn5iDZeCGH+o2Zr4vckJzn4rUnMlBOE6TifdAwuUDiHa9OP8KondLhDOaS1nxqs
 QCT3QBOjlLycZvi+ygvUeBPUkJZdayTkXr0odzedRWFTm1bATcU=
X-Google-Smtp-Source: AGHT+IE8MKMD7umqqa+qkpjcmwKxKoSzmHkMxY4KzV/nOpCvlExwBFHEPs0nKbcJL8/pe3qfIcMFcQ==
X-Received: by 2002:a5d:5989:0:b0:390:e9ee:f27a with SMTP id
 ffacd0b85a97d-39132143902mr2315721f8f.28.1741360046791; 
 Fri, 07 Mar 2025 07:07:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1031fdsm5443627f8f.89.2025.03.07.07.07.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 07:07:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/21] target/arm: Correct LDRD atomicity and fault behaviour
Date: Fri,  7 Mar 2025 15:07:00 +0000
Message-ID: <20250307150708.3222813-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307150708.3222813-1-peter.maydell@linaro.org>
References: <20250307150708.3222813-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

Our LDRD implementation is wrong in two respects:

 * if the address is 4-aligned and the load crosses a page boundary
   and the second load faults and the first load was to the
   base register (as in cases like "ldrd r2, r3, [r2]", then we
   must not update the base register before taking the fault
 * if the address is 8-aligned the access must be a 64-bit
   single-copy atomic access, not two 32-bit accesses

Rewrite the handling of the loads in LDRD to use a single
tcg_gen_qemu_ld_i64() and split the result into the destination
registers. This allows us to get the atomicity requirements
right, and also implicitly means that we won't update the
base register too early for the page-crossing case.

Note that because we no longer increment 'addr' by 4 in the course of
performing the LDRD we must change the adjustment value we pass to
op_addr_ri_post() and op_addr_rr_post(): it no longer needs to
subtract 4 to get the correct value to use if doing base register
writeback.

STRD has the same problem with not getting the atomicity right;
we will deal with that in the following commit.

Cc: qemu-stable@nongnu.org
Reported-by: Stu Grossman <stu.grossman@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250227142746.1698904-2-peter.maydell@linaro.org
---
 target/arm/tcg/translate.c | 70 +++++++++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 24 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index d8225b77c8c..93772da39a4 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -5003,10 +5003,49 @@ static bool op_store_rr(DisasContext *s, arg_ldst_rr *a,
     return true;
 }
 
+static void do_ldrd_load(DisasContext *s, TCGv_i32 addr, int rt, int rt2)
+{
+    /*
+     * LDRD is required to be an atomic 64-bit access if the
+     * address is 8-aligned, two atomic 32-bit accesses if
+     * it's only 4-aligned, and to give an alignment fault
+     * if it's not 4-aligned. This is MO_ALIGN_4 | MO_ATOM_SUBALIGN.
+     * Rt is always the word from the lower address, and Rt2 the
+     * data from the higher address, regardless of endianness.
+     * So (like gen_load_exclusive) we avoid gen_aa32_ld_i64()
+     * so we don't get its SCTLR_B check, and instead do a 64-bit access
+     * using MO_BE if appropriate and then split the two halves.
+     *
+     * For M-profile, and for A-profile before LPAE, the 64-bit
+     * atomicity is not required. We could model that using
+     * the looser MO_ATOM_IFALIGN_PAIR, but providing a higher
+     * level of atomicity than required is harmless (we would not
+     * currently generate better code for IFALIGN_PAIR here).
+     *
+     * This also gives us the correct behaviour of not updating
+     * rt if the load of rt2 faults; this is required for cases
+     * like "ldrd r2, r3, [r2]" where rt is also the base register.
+     */
+    int mem_idx = get_mem_index(s);
+    MemOp opc = MO_64 | MO_ALIGN_4 | MO_ATOM_SUBALIGN | s->be_data;
+    TCGv taddr = gen_aa32_addr(s, addr, opc);
+    TCGv_i64 t64 = tcg_temp_new_i64();
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    TCGv_i32 tmp2 = tcg_temp_new_i32();
+
+    tcg_gen_qemu_ld_i64(t64, taddr, mem_idx, opc);
+    if (s->be_data == MO_BE) {
+        tcg_gen_extr_i64_i32(tmp2, tmp, t64);
+    } else {
+        tcg_gen_extr_i64_i32(tmp, tmp2, t64);
+    }
+    store_reg(s, rt, tmp);
+    store_reg(s, rt2, tmp2);
+}
+
 static bool trans_LDRD_rr(DisasContext *s, arg_ldst_rr *a)
 {
-    int mem_idx = get_mem_index(s);
-    TCGv_i32 addr, tmp;
+    TCGv_i32 addr;
 
     if (!ENABLE_ARCH_5TE) {
         return false;
@@ -5017,18 +5056,10 @@ static bool trans_LDRD_rr(DisasContext *s, arg_ldst_rr *a)
     }
     addr = op_addr_rr_pre(s, a);
 
-    tmp = tcg_temp_new_i32();
-    gen_aa32_ld_i32(s, tmp, addr, mem_idx, MO_UL | MO_ALIGN);
-    store_reg(s, a->rt, tmp);
-
-    tcg_gen_addi_i32(addr, addr, 4);
-
-    tmp = tcg_temp_new_i32();
-    gen_aa32_ld_i32(s, tmp, addr, mem_idx, MO_UL | MO_ALIGN);
-    store_reg(s, a->rt + 1, tmp);
+    do_ldrd_load(s, addr, a->rt, a->rt + 1);
 
     /* LDRD w/ base writeback is undefined if the registers overlap.  */
-    op_addr_rr_post(s, a, addr, -4);
+    op_addr_rr_post(s, a, addr, 0);
     return true;
 }
 
@@ -5152,23 +5183,14 @@ static bool op_store_ri(DisasContext *s, arg_ldst_ri *a,
 
 static bool op_ldrd_ri(DisasContext *s, arg_ldst_ri *a, int rt2)
 {
-    int mem_idx = get_mem_index(s);
-    TCGv_i32 addr, tmp;
+    TCGv_i32 addr;
 
     addr = op_addr_ri_pre(s, a);
 
-    tmp = tcg_temp_new_i32();
-    gen_aa32_ld_i32(s, tmp, addr, mem_idx, MO_UL | MO_ALIGN);
-    store_reg(s, a->rt, tmp);
-
-    tcg_gen_addi_i32(addr, addr, 4);
-
-    tmp = tcg_temp_new_i32();
-    gen_aa32_ld_i32(s, tmp, addr, mem_idx, MO_UL | MO_ALIGN);
-    store_reg(s, rt2, tmp);
+    do_ldrd_load(s, addr, a->rt, rt2);
 
     /* LDRD w/ base writeback is undefined if the registers overlap.  */
-    op_addr_ri_post(s, a, addr, -4);
+    op_addr_ri_post(s, a, addr, 0);
     return true;
 }
 
-- 
2.43.0


