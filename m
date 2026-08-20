Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFEEC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtlX-0006sL-Qk; Wed, 19 Aug 2026 23:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtlW-0006rg-0b
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:30 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtlU-0004PQ-Eb
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:29 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2ceb096e675so20659905ad.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197707; x=1787802507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h2oaOCJCF/+kDDtd38kYag9b0rC6YDKI4au6Nbv4V2A=;
 b=AuCaIFdgG/SEUhaWwKmYs0z33er+54mRDZaoHE2laXo6kEKlimzVMvBppd880d9dzw
 FJJNqZsq1jiA4uNa11fh0MjTx15JUqBIVcskY39M1oXkuLd+YaI02DnZW+ULucAcgXf/
 Dh+MmzHPowb+2hpXJRjh/VhY7vkeOSctumfepmIA895Voqf4ngVB75gZQvytPb6zc9sE
 0LpMsWK61usjMtG+yz646QYxCRb96eLtbKbrBdEVPw0vSKqzhKculjdKV/LnCXc3KmOh
 rm+FpAlIHVvlo6YwzSQoO1cJr3MfR9LQYB2R2J1bala6LA7bIzWwjB2hO3ACwojzqJka
 YxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197707; x=1787802507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h2oaOCJCF/+kDDtd38kYag9b0rC6YDKI4au6Nbv4V2A=;
 b=FgEIviBoQCgCJ4lzDtvvFrVwu50lR4T/0MafAbx6VuecH1+ETYITnRyMBKC/v//uX9
 ocwmVD4Kp/ETADJLV77COoWHbcMyHMZpj3rly2M6zpcDrpkI9E25B9vRmy3iufMoKpl8
 xwckw00iT5KkFpfIs8tY8dJqttzE7+f8aAxiEgwE1OZTcesDuRWgfWdnQaYGCn0AtnGa
 rgt4YhTnm4kMjW1IS4HtCZDvMGOfv2jf0LO5iAYYgtNTrFsyBEBN5T0qNi2TM3ehPBiK
 kF40wTiiek1aw7zKJZ+7/a/KfgQOp6sX8LUiKVmt5t3CyTelF9yemyZOoDOf/5h21s4R
 fDnQ==
X-Gm-Message-State: AFuF++mraq8KrXEQNXRjVGd2CBVTj9nojDAxiem7exLoWWdt++whqcrx
 7kjFWdGFIelbERd8L8vUDYzoNEpsECO748T3TOwylDFevBdlGSz3mbgzVdq42g==
X-Gm-Gg: AR+sD13Jm3RXc0GmgLq9CfJ5TVRN/b4lzqafeTAQRTutUQtLi8mT3b3y7dzmmKQDIU+
 uJteytMjsiykrp/5FHnDhTK708ClAXlEZFE8+2BTjFT+FQO82EDPVd9+PKkxegnkHWkI5DNgnpn
 hSpDUkFRt/wnp/5TA0KW2asii6tV+XPTkEguhpUcFMtYAFJeHIVdmYXAMup/khyUYlTHOwH7QFW
 Rc47w2x53V6u/87pLztHw3D3mbMA2qpmMZRrSROy489ZrVFwuN9XYi87keP4hodTX/z7nibn/jq
 08ubgSXcw8BM3mwUVpF1HOcgVZsfyKZ7inacwyQkw3VtSRnu4EeCbOwStBTE1gq9fzmo9LTLBFi
 8gDqEvyGSPzWNGbrGCddsbFJr5PqR1uqVxmg3MsC1Or1G0z/CG8JlhjRnxojjQT7rMeTgV7P0QU
 UN+8I8VoepXczzWsUdxfzyb160tTSjqCqxMXQmuUe37kmNb/Qr3k6eAPr8fj8YYI9uTZBrx1Yd2
 s+A3A==
X-Received: by 2002:a17:90b:3945:b0:37f:eafd:3505 with SMTP id
 98e67ed59e1d1-39580eafaa7mr19068358a91.6.1787197706998; 
 Wed, 19 Aug 2026 20:48:26 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:48:26 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 78/93] disas/riscv: Split xlrbr_opcode_data
Date: Thu, 20 Aug 2026 13:44:15 +1000
Message-ID: <20260820034430.1186695-79-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Move the table to riscv-xlrbr-op.c.inc and massage
the lines into OP() form.  Drop illegal as unused.
Return pointers to objects directly.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-43-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv-xlrbr.c        | 54 +++++++++-----------------------------
 disas/riscv-xlrbr-op.c.inc |  8 ++++++
 2 files changed, 20 insertions(+), 42 deletions(-)
 create mode 100644 disas/riscv-xlrbr-op.c.inc

diff --git a/disas/riscv-xlrbr.c b/disas/riscv-xlrbr.c
index b12916c9da..b4229e5c83 100644
--- a/disas/riscv-xlrbr.c
+++ b/disas/riscv-xlrbr.c
@@ -8,38 +8,16 @@
  */
 
 #include "qemu/osdep.h"
-
 #include "disas/riscv.h"
 #include "disas/riscv-xlrbr.h"
 
-typedef enum {
-    /* 0 is reserved for rv_op_illegal. */
-    rv_op_crc32_b = 1,
-    rv_op_crc32_h = 2,
-    rv_op_crc32_w = 3,
-    rv_op_crc32_d = 4,
-    rv_op_crc32c_b = 5,
-    rv_op_crc32c_h = 6,
-    rv_op_crc32c_w = 7,
-    rv_op_crc32c_d = 8,
-} rv_xlrbr_op;
-
-static const rv_opcode_data xlrbr_opcode_data[] = {
-    { "illegal", rv_codec_illegal, rv_fmt_none },
-    { "crc32.b", rv_codec_r, rv_fmt_rd_rs1 },
-    { "crc32.h", rv_codec_r, rv_fmt_rd_rs1 },
-    { "crc32.w", rv_codec_r, rv_fmt_rd_rs1 },
-    { "crc32.d", rv_codec_r, rv_fmt_rd_rs1 },
-    { "crc32c.b", rv_codec_r, rv_fmt_rd_rs1 },
-    { "crc32c.h", rv_codec_r, rv_fmt_rd_rs1 },
-    { "crc32c.w", rv_codec_r, rv_fmt_rd_rs1 },
-    { "crc32c.d", rv_codec_r, rv_fmt_rd_rs1 },
-};
+#define OP(N, ...) static const rv_opcode_data op_##N = { __VA_ARGS__ };
+#include "riscv-xlrbr-op.c.inc"
+#undef OP
 
 const rv_opcode_data *decode_xlrbr(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
-    rv_opcode op = rv_op_illegal;
 
     switch ((inst >> 0) & 0b1111111) {
     case 0b0010011:
@@ -47,34 +25,26 @@ const rv_opcode_data *decode_xlrbr(rv_decode *dec, rv_isa isa)
         case 0b001:
             switch ((inst >> 20 & 0b111111111111)) {
             case 0b011000010000:
-                op = rv_op_crc32_b;
-                break;
+                return &op_crc32_b;
             case 0b011000010001:
-                op = rv_op_crc32_h;
-                break;
+                return &op_crc32_h;
             case 0b011000010010:
-                op = rv_op_crc32_w;
-                break;
+                return &op_crc32_w;
             case 0b011000010011:
-                op = rv_op_crc32_d;
-                break;
+                return &op_crc32_d;
             case 0b011000011000:
-                op = rv_op_crc32c_b;
-                break;
+                return &op_crc32c_b;
             case 0b011000011001:
-                op = rv_op_crc32c_h;
-                break;
+                return &op_crc32c_h;
             case 0b011000011010:
-                op = rv_op_crc32c_w;
-                break;
+                return &op_crc32c_w;
             case 0b011000011011:
-                op = rv_op_crc32c_d;
-                break;
+                return &op_crc32c_d;
             }
             break;
         }
         break;
     }
 
-    return op == rv_op_illegal ? NULL : &xlrbr_opcode_data[op];
+    return NULL;
 }
diff --git a/disas/riscv-xlrbr-op.c.inc b/disas/riscv-xlrbr-op.c.inc
new file mode 100644
index 0000000000..57add37c24
--- /dev/null
+++ b/disas/riscv-xlrbr-op.c.inc
@@ -0,0 +1,8 @@
+OP(crc32_b, "crc32.b", rv_codec_r, rv_fmt_rd_rs1)
+OP(crc32_h, "crc32.h", rv_codec_r, rv_fmt_rd_rs1)
+OP(crc32_w, "crc32.w", rv_codec_r, rv_fmt_rd_rs1)
+OP(crc32_d, "crc32.d", rv_codec_r, rv_fmt_rd_rs1)
+OP(crc32c_b, "crc32c.b", rv_codec_r, rv_fmt_rd_rs1)
+OP(crc32c_h, "crc32c.h", rv_codec_r, rv_fmt_rd_rs1)
+OP(crc32c_w, "crc32c.w", rv_codec_r, rv_fmt_rd_rs1)
+OP(crc32c_d, "crc32c.d", rv_codec_r, rv_fmt_rd_rs1)
-- 
2.54.0


