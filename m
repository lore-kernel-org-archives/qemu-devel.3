Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4913DC3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 02:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUGbi-0005kc-P9; Wed, 17 Jul 2024 22:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGbW-0005RX-Al
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:10:46 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGbU-0003Os-Mb
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:10:46 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1fb8781ef1bso3421935ad.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 19:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721268643; x=1721873443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G8fKgY1s4Rw4kvkIdoDaVQ9dlz3PFc+KeixjaTnSrrU=;
 b=iDiLEgo3tomeZxiyHSrB5X55+AdZ5xdNc8pVkXiHVzz+U8FbXW84i5XFWdr4fekOtM
 It830YJxKyI2OZBrk/e70XywvC7xo255qmiskNjRP16RIi1PsLyMyo90i5UGYuRMiE9J
 d+F2bOwvFiK4+rosTjEONTiZWFHPQ/MQd1aUa/mw6soY5H4AytSQAsed8rUnLd1uponV
 mzQ4Vvcf3K3eT3SiDFWukY69BEPKFcZD9dZE335i6H6vW8uy3IcEXlvJ4/f3IYCXpTgP
 mbhRbcEcAkZxUrOBUWxV/URN1Wa9xuzLX7se5wG0RAwiJnplK+L1+1qrjtWKV+vF0UoA
 Hs7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721268643; x=1721873443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G8fKgY1s4Rw4kvkIdoDaVQ9dlz3PFc+KeixjaTnSrrU=;
 b=W2BH/3v7bCE1c55oTuQswyZJcN5ZnCfw8NRjo2ZeYOQeL1PGMZIh1y5MdhqxkYim28
 +A7rnFjvmx0R955Q8XEsZCwb5rszI4wyqcnUwfhBGHurhtzvG5tVKhvZuQkwsR63yIG4
 p++BWAHSorW98gnx58NcAgwEcDOXmHs478kIzvBpqsY/LxPOu9pheULUvHB0zTMyMXwE
 U6CgOH+PULKnwo5k6p1Qfdl8YsPndWlJTiC4apHKtIHO3x7WfMohryeZAuPUQu1ZAh+1
 3k8O4XzbkmT1qsejCqAN/gNhSbQ08ZxkrucHjsseq6TNPH/0vXMzh3TiDDYEBIPn82bx
 lllw==
X-Gm-Message-State: AOJu0YxSlFbUlrpQdrKNDoyUMEykhETurvt4DsS63wTXcC8hcGJRmZkZ
 2k39Zn9IwygACJ/cf2yPkhDymcpwXVWFkSKOrQ3E0xTndu5g98tmPKSL0s/9
X-Google-Smtp-Source: AGHT+IGHAIyk+WPGLnqByhLKgPohiQH07W1avPdH56UAbJxJYoQkSV9lRCUqxGDOD/h8TJrzPl7hzg==
X-Received: by 2002:a17:902:c945:b0:1f6:6ef0:dae4 with SMTP id
 d9443c01a7336-1fc4e16e600mr29300865ad.32.1721268642860; 
 Wed, 17 Jul 2024 19:10:42 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bba949bsm81999385ad.69.2024.07.17.19.10.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 19:10:42 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 06/30] target/riscv: Move gen_amo before implement Zabha
Date: Thu, 18 Jul 2024 12:09:48 +1000
Message-ID: <20240718021012.2057986-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718021012.2057986-1-alistair.francis@wdc.com>
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240709113652.1239-7-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c                | 21 +++++++++++++++++++++
 target/riscv/insn_trans/trans_rva.c.inc | 21 ---------------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 8a546f4ece..133550d6e2 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1077,6 +1077,27 @@ static bool gen_unary_per_ol(DisasContext *ctx, arg_r2 *a, DisasExtend ext,
     return gen_unary(ctx, a, ext, f_tl);
 }
 
+static bool gen_amo(DisasContext *ctx, arg_atomic *a,
+                    void(*func)(TCGv, TCGv, TCGv, TCGArg, MemOp),
+                    MemOp mop)
+{
+    TCGv dest = dest_gpr(ctx, a->rd);
+    TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
+
+    if (ctx->cfg_ptr->ext_zama16b) {
+        mop |= MO_ATOM_WITHIN16;
+    } else {
+        mop |= MO_ALIGN;
+    }
+
+    decode_save_opc(ctx);
+    src1 = get_address(ctx, a->rs1, 0);
+    func(dest, src1, src2, ctx->mem_idx, mop);
+
+    gen_set_gpr(ctx, a->rd, dest);
+    return true;
+}
+
 static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index eb080baddd..39bbf60f3c 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -96,27 +96,6 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
     return true;
 }
 
-static bool gen_amo(DisasContext *ctx, arg_atomic *a,
-                    void(*func)(TCGv, TCGv, TCGv, TCGArg, MemOp),
-                    MemOp mop)
-{
-    TCGv dest = dest_gpr(ctx, a->rd);
-    TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
-
-    if (ctx->cfg_ptr->ext_zama16b) {
-        mop |= MO_ATOM_WITHIN16;
-    } else {
-        mop |= MO_ALIGN;
-    }
-
-    decode_save_opc(ctx);
-    src1 = get_address(ctx, a->rs1, 0);
-    func(dest, src1, src2, ctx->mem_idx, mop);
-
-    gen_set_gpr(ctx, a->rd, dest);
-    return true;
-}
-
 static bool trans_lr_w(DisasContext *ctx, arg_lr_w *a)
 {
     REQUIRE_A_OR_ZALRSC(ctx);
-- 
2.45.2


