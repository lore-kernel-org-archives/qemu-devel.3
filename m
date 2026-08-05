Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C35C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wreiu-0008L3-PP; Wed, 05 Aug 2026 12:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wreiu-0008K8-1q
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:44:08 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wreis-0001yN-F1
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:44:07 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2cea3004256so15725305ad.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 09:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1785948245; x=1786553045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fQC/YI21g4WDDTrfzNXtxzDhPQ+c5T/h+/PxMuIADQc=;
 b=ObVOttRDi/4Ld/op2t7A+i4jl5ozG4L42VT0vGt0luomG3iojiDreoHNqAQFcIgHfu
 7qjdlB9nbS8pLyFf+cFo+ebZdZUWgXTIXYKLrN/2DalNveNlhDHvivniq6p7lwDObwTh
 EiPIFmhukLlqEBlvM6iGIUWKmXaH2dcpd6aS1zsroc7MnXBSIF83S0AUhh14UulgeiRz
 bHCkz3GUFkcHKrKc68QqxMHSXlFJxQgydhb7Ccc9nImAoII75n1n7k7M5gb2iIESb2f1
 u0+coC4xNvVt/OgK54Nxv+kdvVpZJ5cMmqS/yPorHhqPhtmuNL1aMcAcWMnVDy2LrWgR
 aPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785948245; x=1786553045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fQC/YI21g4WDDTrfzNXtxzDhPQ+c5T/h+/PxMuIADQc=;
 b=R/OIT3ZpKg6l8IQHdTDwP7KN1xHpeIEeipAX/Zs8CzkeXp5ti0q2WrF5dkBQkmm3S/
 bX/OKimeiGj6EHxrPAXbMnydVSORkF6w4ALRZCNe0nUjXk85iunM/zqrLhkCatAvjRfE
 xSZMML/nXy/Hpp8PypXRas8/OBsA8L60D0eZy0HaSOSRHX/eU2IcclAoasU/QuFCxm68
 gvVSpeRUt8zYhzZZU+uAH76TNlDbO6rb0kTF1mqIMhVntAxwCzzf35gt8P7IQBPhZmeb
 hagTlR57xz9HgoA660i9e+drLlSwWnneBFZXxIZ5VXjRFD157ky3NmrqJsmkd5v8QxF7
 6czw==
X-Gm-Message-State: AOJu0YxMBPnnUxu2wBVo2211z3GfVm6bbsZUpMysT4pvQFlZk5zyaDkz
 PcgtXHZVQ5QMw8XUNEe/MLhQhEkTuGiUjtTauonfqxOrSF4EYb7M7r1Hax+dfs7RtcF9xmtiyRC
 hCy9IWRD0+932t6VNlv0T6MQed+TYJ7Ad3+VZwGFBQoHQE0PFod2P0nyKehE1vlh3AwJaNQWKjx
 j4nEXoMBIQMwBHYX9BpY9UBl2DYQl4rIhLk5creah29mu1AjrV
X-Gm-Gg: AR+sD10npQcEcMloG+HC6Q6dt9wb3vn+fzSxk4gj+itpUA+F/be7vqqzRBRngDdTP8G
 BHSA7vU6pBpnkPFCY5jptBB473P6LBuUM8GP4JJt6HqchC3vpLKFGWVncanmcBWgs0pG/9+Vi1s
 wt4W3QjvSd9uHycyYudbA/gu/QesyKQyifT7PbWXPIO3AwwzkVni0vya06gg9K7YC7Qtg/DmqF6
 xb3yiNxXlLqylLfjWbss/UQg6ioQEF3ShSrrR++xdRnEpwM5CegKo2dDeniVbD0yWcd5AXL77Dj
 BDdm44qru30AEFscWvfwcgPuV5YRXgoPoCrh9EGYD/0Pntcgr85e7/E3GPZkObxbSC98ZXONvHn
 lVdCrEcFu1w+sZh4Le4ScLRa1S2mZp1CTDF/EnPlPjSS9tZ4oqVtGZKACR0A1bock7sE2EXokUI
 FNfiFTYx76h279nhK3/g7t1UATxE2EAXGt/Ap3oYnqdRfqwyC7XvNHZ6t0XZFxWs+lhKuRormvj
 GDDba+h1s4BqT7B
X-Received: by 2002:a05:6a20:e347:b0:3bd:3800:7538 with SMTP id
 adf61e73a8af0-3cb85ffdacamr9379164637.33.1785948245005; 
 Wed, 05 Aug 2026 09:44:05 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158644a195sm16719065eec.13.2026.08.05.09.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 09:44:04 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v7 5/8] target/riscv: Support raising misaligned exceptions
 for floating-point loads/stores
Date: Thu,  6 Aug 2026 00:43:42 +0800
Message-ID: <20260805164345.698208-6-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805164345.698208-1-frank.chang@sifive.com>
References: <20260805164345.698208-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x632.google.com
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

From: Frank Chang <frank.chang@sifive.com>

When the Zicclsm extension is not enabled, raise misaligned load/store
exceptions for misaligned accesses from floating-point load/store
instructions (RVF, RVD, Zfh).

Signed-off-by: Frank Chang <frank.chang@sifive.com>
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


