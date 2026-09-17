Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 933FCC982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x77Jb-0002jy-Fi; Thu, 17 Sep 2026 04:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77JI-0002gN-U9
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:36 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77JF-0001vc-TO
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:35 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39d654f02baso447215a91.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 01:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789633052; x=1790237852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cPJrBaA0GFDkhN4Z31mRC+eN+hx1ctVZKEDF0LhqC+8=;
 b=jgCR71/N7cCPnvwNxdm03HSLtrIDbj0pf2ZnVZKdm/FXuhP22u6xCOeqMb3r2gRCJq
 oqUXcqjAYNA6OfDbgCA3Hsxs7aTO3RgqO/A02j37b+NLZygpn6p7gZlcuR4qUXpLsBFn
 EDg/FgoJJGKbCwSCWCONWN8OPkumy/55Ti5B8/+QkgO6gwwDoNV7QTXNmR2TOJDuxWL2
 2t5A3m0SqsQiqaYVL2yzwIhIJL4CNElBkWZP0ObjBtqtf648POKaETMIclulKadnfkaw
 mJwCbKFgeRa7psufC/5WH6NG6wlMOai9IzBlEGzP9DO0jj5giJiTwsWgp+5pZk6GPlzC
 zVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789633052; x=1790237852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cPJrBaA0GFDkhN4Z31mRC+eN+hx1ctVZKEDF0LhqC+8=;
 b=EWYePQj7iuxKR93lK/v5kwlTlLqB+WP4GcXTsZEl10d8x30lBZBAh9xHOv5ZJF2xjF
 4BjdYu11rDilvXwh/h4pIRPGDbNSyRkz6KmQVwbxQT8b1kKoMQJoTFpuJ6G7I2cdD7ib
 flLgDbzx9bWkDJB2FKx/fvv/njk428QdS9gGjP0Qnl/RGGCHOMSkbClXrD2hFXNToFtf
 VSNYmB9YVozlulsLUgOdso0P7UldYUQv335xC/6UUA2nZFwJac2AyDrHcwyjQdTweGFq
 sro3B7UDkN0U/vplXw9LQGyqQ5CbURM+f31rohdPZgL74By9JKPfQf019RxkFKHwSnoS
 SsNw==
X-Gm-Message-State: AFuF++lpK46xVyvXwyYzzCn96bAlyBktY0Ty2edq5p68j4b2PqkLTPIq
 troOsPC3947RKYUo050JwK8Y8kO4nqQTByt6S/oD8j9sAFTydCCWxAjAULNlcSiJMt6ALYPehJv
 chYDH
X-Gm-Gg: AYBFou0qCegxSUT35tK1MyZE9QfC/QulkLNN1qpWxM6yTZrpS54EoXPWoIhwOZ2scPd
 JM4XViN5RKknMD+oBYgxKY1P44jukG09Dn/vvqgr8rtibhVpiVdV+eC2yqvN6G7jZGJbzWJrE3R
 Ts9EQ5J1xDJ9gQzYUtfFNe/2ktd2lHfyKCvP1am8jW5hwyGxfw5VKokA0iPiq+3DekAtJdetcLa
 S6VzbAvrvOj1Mzr+nk/o8Aiz7KjIe1qB+X7q/3GdbO6bIo67j2sKn5TwdYqqiXfegmep213Kr2S
 zo+AnZLC/CPkzqc63HkropwXXWKDxCm9ORR500pG+QhwcZm40A6ZFoaGP4tcRfE+XaNrRf1VkrN
 BuW+nVT27ThIkm3I1myokWhkYyfePJZzs7cUG0XFvGoOF0PYC7+lrATvmRyqmyocgDNqcu9seoy
 qY3hAEn5IDti8meQCZXenvpFJOmKcjD18JEhBP0HoKvejbH/QKUV4U9XJtV9sPSW+jJEaFqkfdd
 /5r0L7I68p4BbpKY+U=
X-Received: by 2002:a17:90b:524d:b0:39d:eca2:5c81 with SMTP id
 98e67ed59e1d1-39e1e2dea05mr13218449a91.8.1789633052368; 
 Thu, 17 Sep 2026 01:17:32 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c1943f4bcsm127638eec.21.2026.09.17.01.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 01:17:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v2 12/16] tcg/loongarch64: Import SLADD insns
Date: Wed, 16 Sep 2026 22:17:12 -1000
Message-ID: <20260917081716.946668-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917081716.946668-1-richard.henderson@linaro.org>
References: <20260917081716.946668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-insn-defs.c.inc | 30 ++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tcg/loongarch64/tcg-insn-defs.c.inc b/tcg/loongarch64/tcg-insn-defs.c.inc
index e907fc755f5..ececc6a3dd5 100644
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


