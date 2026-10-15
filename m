Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09095CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ4i-0002OJ-2A; Thu, 15 Oct 2026 06:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4d-0002Lb-S3
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:35 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4c-0007px-6W
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:35 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48de6a62a4cso2211644f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792061553; x=1792666353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3TvlNt6Uhs3RRjPBsmT8z05kBxg3aU3J+VUG3t3mvE8=;
 b=Fdc395bdMMd7Z0dOyx7LUHj/QW94jdcB4prRFE1vF44OUbCOoSLbi3x5+gW+Dqn4cU
 zvJo63lkWgBtXZpxKJ6POFK9CnTwkyS0MjQgLiJUDYsCCtcwZi+Rq8HMyDqNZreVfVWs
 uzpbUgbQkjcHPK7Itx83Sck6HdDULAi5XwW2v+Qtuk6cfXiC9z8+xj+RqDsWVmCyMg7o
 aiyM9IA4SRfAJpD5+brq/XWQ3Zk/W/IJE1i/iOhfEwwF+UzdtKLCmsF9xOgHKcfhNtXX
 LN+Hu7sZ+PfSVw4cyw47W9a+57nK+HAxvuoeCfGd2T6MET18MGsYCI+LCsFFboNfDip0
 Trtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061553; x=1792666353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3TvlNt6Uhs3RRjPBsmT8z05kBxg3aU3J+VUG3t3mvE8=;
 b=ngzp/MGJByIvXaJbanuZL7zCgD6oOJkYO4Bj0dFwIuPiQC0KoaAsecuBbbn6/8WPn+
 6YefRZUpxQ9RZI4XK3AwS6FxcRBV2XxGb2tKFVp+XmdQXVMxLSxdc0e25bkIOI0rZlew
 k1Vg0jbuwH95B0nYvwkUmlqiCTNH/R7zflkGinwjkG93pXifbUh2lg4wOIzgKy8qA4vR
 aa6vnFwuoEI2wokftuqy2BnBn4Zeg8c6WFCIs1GEsSY029bY9/jSfUH5s5qPFHfiYv5S
 lvTI6K4aah207T+K82PUfIApHK+60CG5t0Mm7v4pCjJzaaPYLySzfp84sRJHBJjmeSC+
 ra9Q==
X-Gm-Message-State: AFq9FYLzWLX8/AQ2kViwZJDcgci88/jJtA+7VS5Uf1rDQ11z5BdWDpPC
 Yx+Q4+uaIkAfe/qxpGETzwkToHSeVlr5qT9HMmGmE0tfvsh58nXQpB9tFuhLt1Uv40BM06vl0+E
 FvhWIqcY=
X-Gm-Gg: AYBFou0jtYM6FUggyi8fO38s++jH8PGBLZu4ZOS+8XPkDd1ia+Zs9WRCEWiwihNI4zP
 wTY7KdQI97ea6uBhqNlOJRzEeQkMElCE1xUcLTmy9N5p2xmhKXugB8gVAOyK+23lMajLN41KgN/
 xptZeujZrlviTVC1Sh+MCc2uz8wi6FXYi7wOIKRn2q52xxaRF3xAmxvsOJ1qReELqMVXgfZPLVP
 0XN0qsakw7zdhDjD+Eb6Lsx6JO6kBnXEGEXOQex+OxuVNzESe5thhfG6ab7eH5Y/mKBtFMkGuok
 k68duUpl80/Dcdxa5YG0c3/JkqM+tor2lIV9gHgKl5d/Sy7lffngWzmF4Rs1SE6Eh1w91Yg853v
 zSkFoZQMDc3O1q8Bf8nDemo+RrvIugDfYIE/uvpmrxrYhg8uEPpBZvo3CIYc8gQpNhM0Z83gUTU
 XyDcjHbOWqqB8Et8jNKiKE/joc2NeTizEpqe1tRZGDkmk0OAV0XTw/JP+1hkt0kWCdYWFrxFNqR
 aQXku3R3IKQa2MTxgcKS5euCxw5szpMVCUyp8E2/vW/x1itIgFWBwQWRsIoIf+Uly1Wcl1rV36H
 gbw4
X-Received: by 2002:a05:6000:4906:b0:48d:f72a:338c with SMTP id
 ffacd0b85a97d-48df72a3559mr2321461f8f.55.1792061552788; 
 Thu, 15 Oct 2026 03:52:32 -0700 (PDT)
Received: from stoup.fritz.box
 (p200300ca3f0f8b006e0ed1a687ab6860.dip0.t-ipconnect.de.
 [2003:ca:3f0f:8b00:6e0e:d1a6:87ab:6860])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df5b88207sm3075949f8f.59.2026.10.15.03.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:52:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 07/16] tcg/riscv64: Rename sb-type to b-type format
Date: Thu, 15 Oct 2026 12:51:59 +0200
Message-ID: <20261015105212.356392-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015105212.356392-1-richard.henderson@linaro.org>
References: <20261015105212.356392-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42a.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The current riscv documentation calls this b-type.

Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv64/tcg-target.c.inc | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 158697cbc93..fb0ba046829 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -468,9 +468,9 @@ static tcg_insn_unit encode_s(RISCVInsn opc, TCGReg rs1, TCGReg rs2, uint32_t im
     return opc | (rs1 & 0x1f) << 15 | (rs2 & 0x1f) << 20 | encode_simm12(imm);
 }
 
-/* Type-SB */
+/* Type-B */
 
-static tcg_insn_unit encode_sbimm12(uint32_t imm)
+static tcg_insn_unit encode_bimm12(uint32_t imm)
 {
     tcg_insn_unit ret = 0;
 
@@ -482,9 +482,9 @@ static tcg_insn_unit encode_sbimm12(uint32_t imm)
     return ret;
 }
 
-static tcg_insn_unit encode_sb(RISCVInsn opc, TCGReg rs1, TCGReg rs2, uint32_t imm)
+static tcg_insn_unit encode_b(RISCVInsn opc, TCGReg rs1, TCGReg rs2, uint32_t imm)
 {
-    return opc | (rs1 & 0x1f) << 15 | (rs2 & 0x1f) << 20 | encode_sbimm12(imm);
+    return opc | (rs1 & 0x1f) << 15 | (rs2 & 0x1f) << 20 | encode_bimm12(imm);
 }
 
 /* Type-U */
@@ -581,7 +581,7 @@ static void tcg_out_opc_store(TCGContext *s, RISCVInsn opc,
 static void tcg_out_opc_branch(TCGContext *s, RISCVInsn opc,
                                TCGReg rs1, TCGReg rs2, uint32_t imm)
 {
-    tcg_out32(s, encode_sb(opc, rs1, rs2, imm));
+    tcg_out32(s, encode_b(opc, rs1, rs2, imm));
 }
 
 static void tcg_out_opc_upper(TCGContext *s, RISCVInsn opc,
@@ -608,14 +608,14 @@ static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
  * Relocations
  */
 
-static bool reloc_sbimm12(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
+static bool reloc_bimm12(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
 {
     const tcg_insn_unit *src_rx = tcg_splitwx_to_rx(src_rw);
     intptr_t offset = (intptr_t)target - (intptr_t)src_rx;
 
     tcg_debug_assert((offset & 1) == 0);
     if (offset == sextreg(offset, 0, 12)) {
-        *src_rw |= encode_sbimm12(offset);
+        *src_rw |= encode_bimm12(offset);
         return true;
     }
 
@@ -658,7 +658,7 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
     tcg_debug_assert(addend == 0);
     switch (type) {
     case R_RISCV_BRANCH:
-        return reloc_sbimm12(code_ptr, (tcg_insn_unit *)value);
+        return reloc_bimm12(code_ptr, (tcg_insn_unit *)value);
     case R_RISCV_JAL:
         return reloc_jimm20(code_ptr, (tcg_insn_unit *)value);
     case R_RISCV_CALL:
@@ -1646,7 +1646,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     MemOp opc = get_memop(l->oi);
 
     /* resolve label address */
-    if (!reloc_sbimm12(l->label_ptr[0], tcg_splitwx_to_rx(s->code_ptr))) {
+    if (!reloc_bimm12(l->label_ptr[0], tcg_splitwx_to_rx(s->code_ptr))) {
         return false;
     }
 
@@ -1664,7 +1664,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     MemOp opc = get_memop(l->oi);
 
     /* resolve label address */
-    if (!reloc_sbimm12(l->label_ptr[0], tcg_splitwx_to_rx(s->code_ptr))) {
+    if (!reloc_bimm12(l->label_ptr[0], tcg_splitwx_to_rx(s->code_ptr))) {
         return false;
     }
 
-- 
2.53.0


