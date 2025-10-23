Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491D4CCF9E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBmjQ-0000ja-Ib; Thu, 23 Oct 2025 00:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmjP-0000iz-HI
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:19 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmjN-0007KD-LU
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:19 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7a26ea3bf76so493163b3a.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761192916; x=1761797716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FIywLHQdV6UPgECalZOtYVqVU23U/5XRJdU3/A1ZS6s=;
 b=kgbozq+OtbUs52WI7V3UV2/TBkcXtFBrJhTo4n/dlAFBOivLgQvRlUNedvcXWTa7F7
 o0f+W8EgF6En3E34Ty2rR5lf6Lg0gxWnxStodPUwCfDr+bFWlwwR9SL3fxXpz7lP5uap
 UpOaQzqOsNagVztDIYsiXuJNImYwlU7bJao2EZ5qqPAhxLvbZ6qdWv8cGmI8S7eT1H6L
 pzuoc1BTB+0HEJLY1ueMZpt00zW5ibpb51hMzsfXZDo3Pyo8tUO4YjfdIvX4BrUKXIQ1
 cWJnyr/E8LBcN9K0/v4k7+tF1YomlmPBAO09X8ONnuk0ulf6JGFLPFCswVdSRM7JI2Zy
 TSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761192916; x=1761797716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FIywLHQdV6UPgECalZOtYVqVU23U/5XRJdU3/A1ZS6s=;
 b=Pi7YBnaHgor8JgrZAff3cCKDHq4dqPozTGtbHFIL20K/n0MRf2Kgb+8fxaNalv5P0k
 hFTiJuOjZVlETEoHvx9XloXnGPkmhJBqUfGl5C4CR7xA3L8WMHGGhgQSIUI+kInImmPG
 Os+iOcmVRjLeYVqSCGV1yzN3VB6sAl2xwjTkBlK+fBU/TQPowCcUXyiGQFziFMkrszyu
 VHj7vV0yRD8Ljjxy6xX7dKYOctd0sPw2C9cto5btpT8SS5vWZXHWdTbmsjQuqWobBG7h
 QQY/pCjniGAXjZy3cjHZSTSr/w6Dsd7NRxN9yDuxUBfL0AYJ1iNYRXASHFpDOP6eZfPR
 0nFA==
X-Gm-Message-State: AOJu0YwZqvw72zDU5JGbjB6H6aQAMJSuWQdv7P+fjlk3kZcvD/kKmjPV
 6KDZlhyPTS2B805QB/wUZipkr2hMFA0/RZEpXPBv8BFvxTvL48+udiUW2MaokA==
X-Gm-Gg: ASbGncvxW/Li+bb+gNuDKi7Mv2PUGYbY63lGefhyLW5RHYj/9kUkMIkmSBHWgWdcOBz
 jUxXdpti5zgwrv8Rd5CjkNCTeUOkdBdeWmQD2AYC6+uZS2kutwH2l13uI5tXN1qiOOhh1/B01j1
 qQ1X2lpa2EWijwzMZGJBcTXMP0pxWfqJyGh3ZvQtgCjn9eF38U0APry0aOr7UGglALZlcu9myQf
 Yvi2adZFnUaSaSBa2c6+/i5VnKPs3bVS/cZiXICBR6koX3itg7j6+g/2DoENQrpEts6eYUTPnef
 jlG1xJwu5dkoQCagz3n4e4czbxoORGecCG6dGmJcA5bBFI03alRJ/pJAA1fssTQJcEwA2B1gQRB
 1V4FUeGsF6CUrnWmGgh1Ozhy6FSbUP/0WXrtXs5VfBqYZ+Xz52/xWYgXnmJuVw5N0BdGfFr2pHR
 Zlcb63i2VWn0ov0TgnaBKYopLolPtrWGpD2BHtIgVzxnSQu2EOhVCoRyRm9loMyI57xsIQFBSjP
 MYTrpo9PWXEYJOLjbt7
X-Google-Smtp-Source: AGHT+IGnwUPtiEHmVeMPPQxiX//5TVGfdGtaTUKP/2Hd/sRKtgeCivxYSHnVY8N0ZkL8Q551SAZYUw==
X-Received: by 2002:a05:6a00:4309:b0:7a2:70c5:f74f with SMTP id
 d2e1a72fcca58-7a270c5f822mr3633207b3a.32.1761192915515; 
 Wed, 22 Oct 2025 21:15:15 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a274abe5f0sm961640b3a.34.2025.10.22.21.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:15:14 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 08/37] target/riscv: Conceal MO_TE within gen_storepair_tl()
Date: Thu, 23 Oct 2025 14:14:06 +1000
Message-ID: <20251023041435.1775208-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023041435.1775208-1-alistair.francis@wdc.com>
References: <20251023041435.1775208-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x435.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

All callers of gen_storepair_tl() set the MO_TE flag. Set it once in
the callee.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251010155045.78220-9-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_xthead.c.inc | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/insn_trans/trans_xthead.c.inc
index 859cbc26cb..2f31842791 100644
--- a/target/riscv/insn_trans/trans_xthead.c.inc
+++ b/target/riscv/insn_trans/trans_xthead.c.inc
@@ -926,6 +926,7 @@ static bool gen_loadpair_tl(DisasContext *ctx, arg_th_pair *a, MemOp memop,
     addr1 = get_address(ctx, a->rs, imm);
     addr2 = get_address(ctx, a->rs, memop_size(memop) + imm);
 
+    memop |= MO_TE;
     tcg_gen_qemu_ld_tl(t1, addr1, ctx->mem_idx, memop);
     tcg_gen_qemu_ld_tl(t2, addr2, ctx->mem_idx, memop);
     gen_set_gpr(ctx, a->rd1, t1);
@@ -937,19 +938,19 @@ static bool trans_th_ldd(DisasContext *ctx, arg_th_pair *a)
 {
     REQUIRE_XTHEADMEMPAIR(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_loadpair_tl(ctx, a, MO_TE | MO_SQ, 4);
+    return gen_loadpair_tl(ctx, a, MO_SQ, 4);
 }
 
 static bool trans_th_lwd(DisasContext *ctx, arg_th_pair *a)
 {
     REQUIRE_XTHEADMEMPAIR(ctx);
-    return gen_loadpair_tl(ctx, a, MO_TE | MO_SL, 3);
+    return gen_loadpair_tl(ctx, a, MO_SL, 3);
 }
 
 static bool trans_th_lwud(DisasContext *ctx, arg_th_pair *a)
 {
     REQUIRE_XTHEADMEMPAIR(ctx);
-    return gen_loadpair_tl(ctx, a, MO_TE | MO_UL, 3);
+    return gen_loadpair_tl(ctx, a, MO_UL, 3);
 }
 
 static bool gen_storepair_tl(DisasContext *ctx, arg_th_pair *a, MemOp memop,
@@ -964,6 +965,7 @@ static bool gen_storepair_tl(DisasContext *ctx, arg_th_pair *a, MemOp memop,
     addr1 = get_address(ctx, a->rs, imm);
     addr2 = get_address(ctx, a->rs, memop_size(memop) + imm);
 
+    memop |= MO_TE;
     tcg_gen_qemu_st_tl(data1, addr1, ctx->mem_idx, memop);
     tcg_gen_qemu_st_tl(data2, addr2, ctx->mem_idx, memop);
     return true;
@@ -973,13 +975,13 @@ static bool trans_th_sdd(DisasContext *ctx, arg_th_pair *a)
 {
     REQUIRE_XTHEADMEMPAIR(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_storepair_tl(ctx, a, MO_TE | MO_SQ, 4);
+    return gen_storepair_tl(ctx, a, MO_SQ, 4);
 }
 
 static bool trans_th_swd(DisasContext *ctx, arg_th_pair *a)
 {
     REQUIRE_XTHEADMEMPAIR(ctx);
-    return gen_storepair_tl(ctx, a, MO_TE | MO_SL, 3);
+    return gen_storepair_tl(ctx, a, MO_SL, 3);
 }
 
 /* XTheadSync */
-- 
2.51.0


