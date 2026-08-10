Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEDFC5AD4E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 05:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtJ0c-00042V-BP; Mon, 10 Aug 2026 01:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wtJ03-00040E-QO
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 01:56:39 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wtJ02-0007mr-3Z
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 01:56:39 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c9b373d5af0so1080109a12.2
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 22:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1786341397; x=1786946197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=64CMGN31294nAEJtyRhT/fogu+ligZ1n2U+FSvAoY8M=;
 b=KzDRUaySsJjnO319FnnUw89FYu1p3O4oRgkUUP+hd3ki2ngmnjcniZYi036h5Xj3i+
 yuCYesy91fLvejicZM6I0ixMZF29j+HNODUoCGThBtvpyZ6ABxrdqk77dLaItf8dSJkK
 vi5se18KsJ+1CqvTb8aXMNkds3jXvpZcqPGXZR7CPRsljGxk4qVW0WKxXMqDxPGsGHVY
 Mm/x/Ml59kBZHDJflmsgH4C4qNdTgwMp8W4sNiSEzmSfYjhnVWahc3NdeatlA4Q2cdZZ
 9kDIqN6y+o2qRlGkggLxLpHWHYS0JRdo4E6aVpASme/B49m65UlzEi7zbOr7JjTH0tEB
 VfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786341397; x=1786946197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=64CMGN31294nAEJtyRhT/fogu+ligZ1n2U+FSvAoY8M=;
 b=rzfqVyAZx6/NQDPqVnXswchwJ0QzGGXTxSlYNXGVzp/vTrJQLUVVUXn5yY+/Vgp8yo
 4QPyWUo89S6B4faySXDZZcktUbD/oT5hXmqwJwNEbpLCzRFNsDzD+QXR1qEEk6FmnlHd
 lDYsIDEoYerokm1rDnIcO0j5y3CLXLRUPLMQsgB3HBVovOAkQ6K9VCEGIsuwhFF9KfD5
 nlAncZef6YHhzzUECXIE9NThjUAdQonX+Q75Y3YVvylZFn1L+h+R6bs+MPOR6Wtkj3BY
 CSJmB+q3UXF72q4jaqDB4MrTtb3cTvnNr6GfPsPemzFcpCqOKDphOLjL88zyDhVbeEXm
 ytLQ==
X-Gm-Message-State: AOJu0YwYM875rii0/loTYJYRVxjxf/LCmFitPg1M8syJovw8mFYtBrzr
 xZCk/aYxwy8pOeBjv2rg31TPEiNWhdzDnCHC2yWgrIRwGJp5lzL0CQ9F6N1wC36losHmOkf3zyR
 ApYHPgEvd36x9qG7ECC/jmqlWNB14FfqdKTyMAODf+sLGv+Nvf7qTtuw7vd7RzCmqD33zHkVtRr
 KTk03s0STeF7Z903HGXV2eUWqtwI8DBK2tJNgD7KDD294=
X-Gm-Gg: AR+sD126UAE1jfJya18lTmPCm7qKE22pUdPRGebRdugYcPNrBakULxSTbRpmQmrgwuX
 0ecfQhgWv1UUDGps3ObjU4F7xWUdxyZ9Fm67MqVMZyoGhMgNbzaPi710zMjX0wKFk6xvlgL5OK7
 Y5uNASK7rFUgOWybTYhly+gb08YPrIZWrVjno174kASxsWNQrSmCTuH7V3M+Tgh5h9kX967dxRp
 bQfn4Y7+wY4Oewg3z3VWfGXW/v3plceDKMr6Pn5Ogc8gFncBQJJ/kIVRo+Yt+LjdAoIOYsXE3ok
 dvl8uBP4HzlgBeE9+AKE4XOhlnZela2ccNs0ZUBHwsD3wt4QRtFtoh+y+EAiytTcSv/36zXf0JU
 4xiwxZlNGiqHppjHEpvTTSdHX8/8gXvoNqETTIfqKnWNTUrIlhVmFpwYnKQbUA9Z+AlzjJgggU8
 OO4SJS0srYEBYop3968ObOfTbZ1JF4oTlGZq9FF+ubbJ2dG6NwdW946ph94vAuNPrQqWQ1SSOkd
 44cpifjMRURf48=
X-Received: by 2002:a05:6a20:d52f:b0:3c3:9070:96b3 with SMTP id
 adf61e73a8af0-3cbce6caba0mr20533561637.3.1786341396511; 
 Sun, 09 Aug 2026 22:56:36 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be86fc7bsm39172122eec.1.2026.08.09.22.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 22:56:35 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v8 4/7] target/riscv: Support raising misaligned exceptions
 for floating-point loads/stores
Date: Mon, 10 Aug 2026 13:56:15 +0800
Message-ID: <20260810055618.1175500-5-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810055618.1175500-1-frank.chang@sifive.com>
References: <20260810055618.1175500-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Frank Chang <frank.chang@sifive.com>

When the Zicclsm extension is not enabled, raise misaligned load/store
exceptions for misaligned accesses from floating-point load/store
instructions (RVF, RVD, Zfh).

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/insn_trans/trans_rvd.c.inc   | 6 ++++++
 target/riscv/tcg/insn_trans/trans_rvf.c.inc   | 6 ++++++
 target/riscv/tcg/insn_trans/trans_rvzfh.c.inc | 6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/target/riscv/tcg/insn_trans/trans_rvd.c.inc b/target/riscv/tcg/insn_trans/trans_rvd.c.inc
index 3b9a745520a..1be2bee9465 100644
--- a/target/riscv/tcg/insn_trans/trans_rvd.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvd.c.inc
@@ -61,6 +61,9 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
         memop |= MO_ATOM_IFALIGN;
     }
     memop |= ctx->mo_endianness;
+    if (!ctx->cfg_ptr->ext_zicclsm) {
+        memop |= MO_ALIGN;
+    }
 
     decode_save_opc(ctx, 0);
     addr = get_address(ctx, a->rs1, a->imm);
@@ -86,6 +89,9 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
         memop |= MO_ATOM_IFALIGN;
     }
     memop |= ctx->mo_endianness;
+    if (!ctx->cfg_ptr->ext_zicclsm) {
+        memop |= MO_ALIGN;
+    }
 
     decode_save_opc(ctx, 0);
     addr = get_address(ctx, a->rs1, a->imm);
diff --git a/target/riscv/tcg/insn_trans/trans_rvf.c.inc b/target/riscv/tcg/insn_trans/trans_rvf.c.inc
index e935523c93c..481f7282da7 100644
--- a/target/riscv/tcg/insn_trans/trans_rvf.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvf.c.inc
@@ -52,6 +52,9 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
+    if (!ctx->cfg_ptr->ext_zicclsm) {
+        memop |= MO_ALIGN;
+    }
 
     decode_save_opc(ctx, 0);
     addr = get_address(ctx, a->rs1, a->imm);
@@ -75,6 +78,9 @@ static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
+    if (!ctx->cfg_ptr->ext_zicclsm) {
+        memop |= MO_ALIGN;
+    }
 
     decode_save_opc(ctx, 0);
     addr = get_address(ctx, a->rs1, a->imm);
diff --git a/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc b/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
index f36b46c2118..88711fb0769 100644
--- a/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
@@ -50,6 +50,9 @@ static bool trans_flh(DisasContext *ctx, arg_flh *a)
     REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
 
     memop |= ctx->mo_endianness;
+    if (!ctx->cfg_ptr->ext_zicclsm) {
+        memop |= MO_ALIGN;
+    }
     decode_save_opc(ctx, 0);
     t0 = get_gpr(ctx, a->rs1, EXT_NONE);
     if (a->imm) {
@@ -75,6 +78,9 @@ static bool trans_fsh(DisasContext *ctx, arg_fsh *a)
     REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
 
     memop |= ctx->mo_endianness;
+    if (!ctx->cfg_ptr->ext_zicclsm) {
+        memop |= MO_ALIGN;
+    }
     decode_save_opc(ctx, 0);
     t0 = get_gpr(ctx, a->rs1, EXT_NONE);
     if (a->imm) {
-- 
2.43.0


