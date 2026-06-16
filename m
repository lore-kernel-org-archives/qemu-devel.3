Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62FDCD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQgD-00055S-9P; Tue, 16 Jun 2026 06:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQgB-00055A-Rh
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:05:59 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQgA-00033i-3z
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:05:59 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-36ba3ea5c46so2530871a91.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604356; x=1782209156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RRf/OCA5n4oLQ6t53w/gBNFvqFD+L9t5JUJVVGr/W3M=;
 b=YDjt5y0fOW5gf5RWiEJxPO5Fq5PHzdAkYK13xvnZC8B2S5SgvEGxCUmmvNuffGIa06
 vQ+IiYoBN6NUn0zMZ2RZ8655MexspALCoeYYxeMfmensXDlwjf9ycNi8yIYjDZXwspXD
 MdlvHR96dTK4uKCvvUROwgt+MJsKFjhZn9kmJmiOJTDNbbqYEM4+NuD1BlckjlbMB+cj
 NJCZUrrBtalb/5FVfKHU2L36lNX5kSuPlNYelfu9bLKQuTEeoT3fZFeEDUwvJ463Vh8v
 LV6uexcaojhYLDSjTs9EJCnJm7PSMBmrxfVxtJLT1H5zqR8HS6Houp8FJUzlBhlvOm7R
 WiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604356; x=1782209156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RRf/OCA5n4oLQ6t53w/gBNFvqFD+L9t5JUJVVGr/W3M=;
 b=JUNusc6B/QdzhZwJ8gVJ0Ahgq1N7KxvTI6J1XMlkIFDL9XACWUtW8Di76vGheEIOoR
 tXMFvQD9+m388TiF+EgOYYofwDK/WFjDsaCZh5SYX8V7iKvmqJJSYjL9PsLFwsNQwLqX
 MkepZEN4v0HulCF+s1tZpTcs03iQiEQ5VyNsKOfBZhyJCYj9KQTlRczQlIVvPvzwAm18
 W6Zux0yjuyXe/HuGI3kzvx/FoStTnk+eIWgbWgSNJ2xd3t2ul3fjBmpMrr5Ellc19akr
 utZUlF4/g/X2U4WuOGGiOAG0nnr5WvwK1fXX/1EM8j16lMM/T48jrITvdFoFlctN0s3R
 0NIw==
X-Gm-Message-State: AOJu0Yycc7/sl941Xav9YXNLdYCH6AZkvAZ1t5SFiV87Oa9Az/QUq3Sv
 RmmuK2Hx9bhVqbpGAxMiZIZxiQFS3uBGxsgb0A5w3s5enIGgcbfCz5L9KuJxIMyJ
X-Gm-Gg: Acq92OGIp19JbMuvUAQhmIyx/fMHnicUSbhG2U3oovVQYiydJ5iWcfA3dyNCrVMOQWH
 WpEdEUOwo11wpRalnAC/J5APJX5Sf9IraFPMGnbcD/vuWIUOaRr/hlagcQhtboGp+djBd1TK0DX
 vVIvy7sF0JsBedGq0ESPzZMqBiDPkVZQeWxL5gmnSWfIwqgfNQ8LN08at+SSAwfTHmH1Igj2fYX
 ti7scq0bj8w+98JJDfjJ7eTyRf3pTO7ZL5jofPnaFT3wy5y7cTMUb9eP2wTmlbRmw1aZAXXeaMu
 KRzGWGUC9TAu8TSsnX7AXsAEdBIx5iT9CygFB6zZlJz/Hgk4ZhiMyOjPnDP7VCGBq4zmeHAJvZQ
 4kiY/k5RUe+OO/fbmRjN2YC1N+VvttP9b/Np5jfcxPMYrptBKjANI15+pEuV43JreKfyGPxsyU4
 XVOmYhMEGcXrRLjsNhC2CSVLOblO+W7iutLJw0vHXV
X-Received: by 2002:a17:90b:17c7:b0:35f:b647:d98a with SMTP id
 98e67ed59e1d1-37a01e2e21fmr18424160a91.5.1781604356414; 
 Tue, 16 Jun 2026 03:05:56 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:05:55 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 06/83] disas/riscv.c: add 'cbo' insns to disassembler
Date: Tue, 16 Jun 2026 20:04:09 +1000
Message-ID: <20260616100527.1939565-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1029.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

We forgot to add 'cbo' insns to disas/riscv.c.  The result is that the
disassembler recognizes all of them as 'lq', an insn that happens to
share the same opcode space.

While we're at it reorder cbo_* entries in insn32.decode using opcode
order instead of insn name.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3480
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260519204714.1376551-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn32.decode |  2 +-
 disas/riscv.c              | 29 ++++++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 6e35c4b1e6..21272fdb50 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -207,9 +207,9 @@ ldu      ............   ..... 111 ..... 0000011 @i
 {
   [
     # *** RV32 Zicbom Standard Extension ***
+    cbo_inval  0000000 00000 ..... 010 00000 0001111 @sfence_vm
     cbo_clean  0000000 00001 ..... 010 00000 0001111 @sfence_vm
     cbo_flush  0000000 00010 ..... 010 00000 0001111 @sfence_vm
-    cbo_inval  0000000 00000 ..... 010 00000 0001111 @sfence_vm
 
     # *** RV32 Zicboz Standard Extension ***
     cbo_zero   0000000 00100 ..... 010 00000 0001111 @sfence_vm
diff --git a/disas/riscv.c b/disas/riscv.c
index d416a4d6b3..36609efdf5 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -985,6 +985,10 @@ typedef enum {
     rv_op_ssamoswap_d = 953,
     rv_op_c_sspush = 954,
     rv_op_c_sspopchk = 955,
+    rv_op_cbo_inval = 956,
+    rv_op_cbo_clean = 957,
+    rv_op_cbo_flush = 958,
+    rv_op_cbo_zero = 959,
 } rv_op;
 
 /* register names */
@@ -2255,6 +2259,10 @@ const rv_opcode_data rvi_opcode_data[] = {
       rv_op_sspush, 0 },
     { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1, NULL, rv_op_sspopchk,
       rv_op_sspopchk, 0 },
+   { "cbo.inval", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
+   { "cbo.clean", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
+   { "cbo.flush", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
+   { "cbo.zero", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -2876,7 +2884,26 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             switch ((inst >> 12) & 0b111) {
             case 0: op = rv_op_fence; break;
             case 1: op = rv_op_fence_i; break;
-            case 2: op = rv_op_lq; break;
+            case 2:
+               /*
+                * 'lq' shares the "(...) 010 ..... 0001111" opcode space
+                * with 'cbo' insns.  Check the next 5 bits to select
+                * what we want:
+                *
+                * cbo_inval  0000000 00000 ..... 010 00000 0001111
+                * cbo_clean  0000000 00001 ..... 010 00000 0001111
+                * cbo_flush  0000000 00010 ..... 010 00000 0001111
+                * cbo_zero   0000000 00100 ..... 010 00000 0001111
+                *
+                * Anything that doesn't match these will default to 'lq'.
+                */
+               switch ((inst >> 17) & 0b11111) {
+               case 0: op = rv_op_cbo_inval; break;
+               case 1: op = rv_op_cbo_clean; break;
+               case 2: op = rv_op_cbo_flush; break;
+               case 4: op = rv_op_cbo_zero; break;
+               default: op = rv_op_lq; break;
+               }
             }
             break;
         case 4:
-- 
2.54.0


