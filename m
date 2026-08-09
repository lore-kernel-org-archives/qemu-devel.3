Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5CFC5AD4E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtCBG-0005uc-8K; Sun, 09 Aug 2026 18:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtCBE-0005tG-Vc
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:39:45 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtCBC-00083N-0o
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:39:44 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-38101f85591so3261646a91.1
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786315181; x=1786919981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HPktSh0uMMuMi7kM/ExryJclVyqS0CaAF0oCr9EJbrc=;
 b=TcZcinHiGmE8XVFCmU2JTpxSnmEgtugbpFfcpJzXLCl1Hd3UCo4O5ydg3CwAEH6RpC
 xuZUqohl/bzpgIqmuPj2MAlTMq3HeHjykBRQ3FGpI/rGF8gTeTGVycWQZDADQkRy6sOR
 Lo8MyNmUz9vDC1szUdtx+FQPmTY17x/AVeET1cV3fgIpAtgkej8Kxty5HyonHgEHbOfp
 iFSsDL5N6+hk/BPwKrT3Om15stNa2+HPOUN1C1CV2dRWDYZ9u3XWOh6xdXBPgAihQghW
 HdxBBKhT8x2Lrh2yqTJbXOp8bdqt9VGLT/nSfWl2vXzh/6Uwpvcu8CqhrAAzn/faRQy5
 up4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786315181; x=1786919981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HPktSh0uMMuMi7kM/ExryJclVyqS0CaAF0oCr9EJbrc=;
 b=XITypmBXH/WliqHEWWH8IbCJhkLhlg6P7u9Y0uquL5f05eY83TVEesj9sxIc1u59Hz
 po5YAAAXfL3LNGVymMu1HWhrMddVoLoPACzbaXyTtEwv+eKWHsie38hImmqfp5bYL19z
 TBHljS6sKrZWT9hGLvqa79G6feZ4agNRXHBaTGE8o9RgkDYWq1p5m9O+SuKJMiomZ82a
 nU4Xr82t3D1fJymGF8daiy5qDZBsj2jW/7UJy9QGB6iHlahH/ieiajjYXDC5QnQiQcoi
 QOwCQLgpe9oEqWxXgJFFzlHcYGb/VewRZ/li9o7L7T46lrQ3bRa0EwBfiz6djGd+Inte
 bzBQ==
X-Gm-Message-State: AOJu0YwGg7W1sE2A9RCXmO1qMgMRzKYhiZx8BuhvDZBSD/s0vD2kHZ7b
 a38Fg2iWcXeJrI1Sm1O6moc7ETLtV+RmH99hCFTpr9tUmnBd6+csizYJh8wOC3d/ty/JTQNoDhm
 TYBVu
X-Gm-Gg: AR+sD13CsAPUSd1vl73exi82E0nCbNcK5xfwOmg1TvsionbCfBYHE7Ww18T0843a+7d
 cgqnxBU+ip0NlpaGNUbv99nfvodYW97vG8MC5B+yIwDXr99pN98RJXKWC0E3Zw8HCDJJTrk+Dxx
 EIXnVmbScgl07ErBW1TOoUhfbZ/AKdrxPlu0KKNoSutauSqApdiF8zQblIh7M9yPr0+PejqBnUa
 bMc0arqv71TxDanvv0RrXvKSlsvDbLfheiadnUVpyGkC6iPwkJa2SxZR71/CsxGtX5ytIKdh1ee
 4upuPGBazGNRsO3apr9zzfaaBlepFQBl4O09O0zhXlq/eLhYy0ywPUVudSpgnAvSmmvgewr9H4U
 z7IDt+uUvyk3LuBtrfy7PgVdYGvK3AyA7RiNUrsnXBLXr0IF3k2b8/nLxX5hJKS9Q65jcShsf35
 Nj0YpYrrdH1DHWCD5S3nN+z7vsyLwr6UBlLOicLvEFIcXuss9BqgJZKoDA5Fol8dD/2GTT1u0Z9
 DpY6fmWUwvAQ7vUfUWAobu/9f+rT84=
X-Received: by 2002:a17:90b:268d:b0:38e:5ce1:ae30 with SMTP id
 98e67ed59e1d1-392846b0c3amr6105498a91.14.1786315180567; 
 Sun, 09 Aug 2026 15:39:40 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-390b1573defsm4264430a91.1.2026.08.09.15.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:39:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 45/56] disas/riscv: Split ventana_opcode_data
Date: Sun,  9 Aug 2026 15:35:34 -0700
Message-ID: <20260809223545.730664-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Move the table to riscv-xventana-op.c.inc and massage
the lines into OP() form.  Drop vt.illegal as unused.
Return pointers to objects directly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv-xventana.c        | 21 ++++++---------------
 disas/riscv-xventana-op.c.inc |  2 ++
 2 files changed, 8 insertions(+), 15 deletions(-)
 create mode 100644 disas/riscv-xventana-op.c.inc

diff --git a/disas/riscv-xventana.c b/disas/riscv-xventana.c
index a4e59312d0..5d2e07865f 100644
--- a/disas/riscv-xventana.c
+++ b/disas/riscv-xventana.c
@@ -8,35 +8,26 @@
 #include "disas/riscv.h"
 #include "disas/riscv-xventana.h"
 
-typedef enum {
-    /* 0 is reserved for rv_op_illegal. */
-    ventana_op_vt_maskc = 1,
-    ventana_op_vt_maskcn = 2,
-} rv_ventana_op;
-
-static const rv_opcode_data ventana_opcode_data[] = {
-    { "vt.illegal", rv_codec_illegal, rv_fmt_none },
-    { "vt.maskc", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "vt.maskcn", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-};
+#define OP(N, ...) static const rv_opcode_data op_##N = { __VA_ARGS__ };
+#include "riscv-xventana-op.c.inc"
+#undef OP
 
 const rv_opcode_data *decode_xventanacondops(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
-    rv_opcode op = rv_op_illegal;
 
     switch (((inst >> 0) & 0b11)) {
     case 3:
         switch (((inst >> 2) & 0b11111)) {
         case 30:
             switch (((inst >> 22) & 0b1111111000) | ((inst >> 12) & 0b0000000111)) {
-            case 6: op = ventana_op_vt_maskc; break;
-            case 7: op = ventana_op_vt_maskcn; break;
+            case 6: return &op_vt_maskc;
+            case 7: return &op_vt_maskcn;
             }
             break;
         }
         break;
     }
 
-    return op == rv_op_illegal ? NULL : &ventana_opcode_data[op];
+    return NULL;
 }
diff --git a/disas/riscv-xventana-op.c.inc b/disas/riscv-xventana-op.c.inc
new file mode 100644
index 0000000000..0fe4666aee
--- /dev/null
+++ b/disas/riscv-xventana-op.c.inc
@@ -0,0 +1,2 @@
+OP(vt_maskc, "vt.maskc", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(vt_maskcn, "vt.maskcn", rv_codec_r, rv_fmt_rd_rs1_rs2)
-- 
2.43.0


