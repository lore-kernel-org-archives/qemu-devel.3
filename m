Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578CDC5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHXk-000140-1f; Wed, 12 Aug 2026 18:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHXi-00012f-8c
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:35:26 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHXg-0001pL-Gb
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:35:26 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2ce7d2adef4so18784135ad.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786574123; x=1787178923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2pFXc97irB+xqhuEeXsJuqz1K7COxcjkvhRgUnmVu88=;
 b=SsIn1xEew6olATWkW+9pZCJyM8WWwkEKOJcKtkfDanZngasrnUyL4y86UN8S5gGTU2
 3aFX+6kFFwm8HkOUJgIS2ifCaZ6dB6+eFdSj/yI3T/Kyyxiry3KMu/K/BIN+DVc7nby7
 OmakEsotFAQI9pON12G/a7RjulToN06QWlDOlHQahaq1WgTUjTneZRRztTpnaR7tk1R2
 0SMyL/R4m1WvafaPkE3x+AYhfQ6A11VLky+AeNLzkMN1IKCDOLDC2B4uat02YHuWF+oN
 Kns2CVARWVI1R1EuHH7fWvmgIZnTic7bL2wEt/Qcv9zkQy1gYRr3xNzuN0QRhkf0vQpy
 FcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786574123; x=1787178923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2pFXc97irB+xqhuEeXsJuqz1K7COxcjkvhRgUnmVu88=;
 b=P30/2gakLi4uudmFfmXA3UpuVW7tlLNU4GCeLFVKfdic8F5r9VJX/7XeRrbf/eQybQ
 UAracgL2JRONPN8mo0xUjbvr0fpBcDYHggKNO4yPpkvUY0a3l9mbN/MdbffuqWB/lgus
 CcAylR+qXjHfahmY2Tk2f5+fT8v06oTAVlAE0fQfMvDw8KUTsiO6j18dsQ7Fr3jpAO0B
 ffjFFHj7pZuofgyRSr+OoHnUr2/VU4GlR4ns67ACdw9DougHZzKhseDW61ShjQeYTd2d
 uMRqkNW0K6/6lDE+EVg4XXCRoKkiFTOr1cHe8O/d9knISEcflqKiv4SOLS6VPht7XVyi
 HJTg==
X-Gm-Message-State: AOJu0Yz/ZfcNzYEQLVOjFQvkz3KLMqmwdfBNQaoU4Z2QiSpkwBDJ18rE
 SXMwhvnrezKQJBUEcS5jVPTguw8M3dbDc85UKEEGB3zME0fRkLsU5jMtSgKcY+htguFw83uMKIM
 y/HXo
X-Gm-Gg: AR+sD12pqmVtGbt8fvz5T6kcfWs7l1QYWEpFpFEHdau6gIShMJ58QeqBJZbzOf3zdPb
 k+LvaSP6HIqcGCyto8M4bQzm8KSv5aHC9jEHvLO4AjBMpFJnNbFNE4VHHykZc7QS8na3xDJQEns
 fwAgVy7tCXzDIwhGZYiSbACFDtK/xny/Np+JggclCf1Qx+Z0BtqKkkhKzHtNNRYgLTk0byflQqc
 uoDuLfUPp8ynKjM1A90BNtFbCDVuNP+n7ZSmfdq052VsFq3hvYxkMZ5lFJEkry3072B59zeSjMH
 2IkOlsnD6DHYbLpvSipatVVMO+PbhWP8FLsyYVi735olU4Ijncl/D3kp6okbl6mXo23d35AHbsc
 bCtMSdcAPTT9gFA+PkPt4wWXXk+9ydti3koGZIu/oG6M0+beItJi1Wm+h5E21F5PaDNtGZWYrDs
 uywA6QV1KQcKWCngceL0FWMWe79N/1n4AHLzqdHHIKqj7fen2h/JOdM4YLTS3pawqado4LrkjbU
 VwFl3d13oas65W0Bg+4
X-Received: by 2002:a17:90b:3c0c:b0:38e:64b0:8bce with SMTP id
 98e67ed59e1d1-3931e351897mr1986080a91.20.1786574123042; 
 Wed, 12 Aug 2026 15:35:23 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931f41cd2fsm464854a91.12.2026.08.12.15.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:35:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 42/52] disas/riscv: Split xlrbr_opcode_data
Date: Wed, 12 Aug 2026 15:31:32 -0700
Message-ID: <20260812223142.349142-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Move the table to riscv-xlrbr-op.c.inc and massage
the lines into OP() form.  Drop illegal as unused.
Return pointers to objects directly.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.43.0


