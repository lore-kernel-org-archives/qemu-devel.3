Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E8FC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtk6-0002wu-IU; Wed, 19 Aug 2026 23:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtk4-0002dy-8t
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:00 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtk2-00047w-3f
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:00 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-38e07ebd263so1182859a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197617; x=1787802417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V3fM4y2C472xM9X4uqOcufwfeVn3Wu1NX6yZjjnlfQ0=;
 b=OTN0e6XFVmwTWTGZqjwLGhaVlxWl7a2ZHu4HWairBxQGX7a+D3hpY190+7gOHbR1jO
 fMFvUw3hXA8Vk6eS2c9isw5vbnBMwFumK0/h91edxHf2SMiHbTAl0Dnw+BneiGk1B1NK
 /N4oXXC96OwRRIZOG/nOefaISRqRTX9YsRp5tClFkMEnGLVVW7cbCoVdvWFeYpzndqRb
 O9EAz+7P9LD5L73A969A676SkBYoaBrC0JOW1dy6/fqOO8P56JW3UUolS8xdq0jhPpGw
 zCSAg8pvnFtmdAe+yvBvdBIaoUbd+Ft7ODTrF2kvIS9fpPQ/Xq3jGsuj5z877mqSZv1I
 A8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197617; x=1787802417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=V3fM4y2C472xM9X4uqOcufwfeVn3Wu1NX6yZjjnlfQ0=;
 b=diwGM/TEoOeuL7EcDpNR+AixXjYVNXeppM7BCLBPSTwmalHdNYV2jghWFw6Zs1Bjjl
 0SNrJi0f23aPm6tbW8CQYM68b5JAZRBMplFNCzfrudFkLEm3/QJrA8IRWn8Rc2C4vuh8
 +KbMGcaAX6HebruOKMpcIvHlVL09u11mAVXTE6rX1a1bwheJDeTYK9W8aKz0FDvMfkkM
 LNdusscvObH7xHpbhbNTdoOKKjrj+XzbN767aN/ZpeduUeof2Evbu7wEGo8AfhqWcC+u
 hMdxYokGrSHIz0M4do0cX62HrlknWeXMz0Z7Z+sYbGwU3Wu9SM0CsxHX8UNymNrRVbEv
 0i/Q==
X-Gm-Message-State: AFuF++nhZNN/tcdil089ZA9Hc1kspjbs9uSe5azoz4aR7Z7Kf39uRxk9
 cbFRmtf9YgKls3Pp/bBZS8gmflPrSw8UUt4UAWHen+oddlP3TOVsM7d/brnL8Q==
X-Gm-Gg: AR+sD10ylM9XQ9d2i1irD19N4Pp1bmcrbjlEwM8vq70WMBOnJmHXPN/my/6mOpdI2Um
 EuiLbJMD2Bn/pzNYz/dwePj+uy+8M/iHyodojAQ9LePGMznRRi4E2auhpdJKshBNq/G+Lc/m81u
 gU/h+DH9hLAaEjV74gCRMxbxqKV2wT7/Rz+FaWqJY+nNrBa13ej/nR/n/IIWN4d4noMpoN6GeuT
 bORmr+v9TT5Z1IfXPSUsdNUvDG+tQY7c4SioXY5nasKKL8C3hQy6XbSARaSRV06yG2HozgzKEgJ
 K0+CRQmjP7C2DydPmBoNHgMnUEv0so58Bq3uj5+HHpbOQJiHoj2zdMsaiJ+P9jD14BQ36zL/YpF
 lJYVmtJQdy/FdNj1b9nGKREvrJ6z8eVFGopsQR9FkgyY98E8xwfzalJpaklBnZgr+VHOdrnjRgp
 pqXcUSpxos2NpkhyztnnHFlyCsC2B0rlBTbz4kpN+IFGHnuiyD2w9Kl3Dak+iZCRgz+XbOgjp0C
 l3Q7g==
X-Received: by 2002:a17:90b:2dce:b0:38e:524:8797 with SMTP id
 98e67ed59e1d1-395810e91c8mr19152576a91.13.1787197616746; 
 Wed, 19 Aug 2026 20:46:56 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:46:56 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 45/93] disas/riscv: Set dec->opcode_data in decode function
Date: Thu, 20 Aug 2026 13:43:42 +1000
Message-ID: <20260820034430.1186695-46-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1035.google.com
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

This allows each opcode table to be private to the decode file.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-10-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv-xlrbr.h    |  2 --
 disas/riscv-xthead.h   |  2 --
 disas/riscv-xventana.h |  2 --
 disas/riscv-xlrbr.c    |  4 +++-
 disas/riscv-xthead.c   | 13 ++++++++++++-
 disas/riscv-xventana.c |  3 ++-
 disas/riscv.c          | 34 +++++++++++++++++-----------------
 7 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/disas/riscv-xlrbr.h b/disas/riscv-xlrbr.h
index 939a69ea6d..ebf3d4c133 100644
--- a/disas/riscv-xlrbr.h
+++ b/disas/riscv-xlrbr.h
@@ -12,8 +12,6 @@
 
 #include "disas/riscv.h"
 
-extern const rv_opcode_data rv_xlrbr_opcode_data[];
-
 void decode_xlrbr(rv_decode *, rv_isa);
 
 #endif /* DISAS_RISCV_XLRBR_H */
diff --git a/disas/riscv-xthead.h b/disas/riscv-xthead.h
index fcd42746e7..0c65c8e0af 100644
--- a/disas/riscv-xthead.h
+++ b/disas/riscv-xthead.h
@@ -11,8 +11,6 @@
 
 #include "disas/riscv.h"
 
-extern const rv_opcode_data xthead_opcode_data[];
-
 void decode_xtheadba(rv_decode *, rv_isa);
 void decode_xtheadbb(rv_decode *, rv_isa);
 void decode_xtheadbs(rv_decode *, rv_isa);
diff --git a/disas/riscv-xventana.h b/disas/riscv-xventana.h
index 72be9ffa16..1006c3be00 100644
--- a/disas/riscv-xventana.h
+++ b/disas/riscv-xventana.h
@@ -11,8 +11,6 @@
 
 #include "disas/riscv.h"
 
-extern const rv_opcode_data ventana_opcode_data[];
-
 void decode_xventanacondops(rv_decode*, rv_isa);
 
 #endif /* DISAS_RISCV_XVENTANA_H */
diff --git a/disas/riscv-xlrbr.c b/disas/riscv-xlrbr.c
index 57cb434523..f61028fce9 100644
--- a/disas/riscv-xlrbr.c
+++ b/disas/riscv-xlrbr.c
@@ -24,7 +24,7 @@ typedef enum {
     rv_op_crc32c_d = 8,
 } rv_xlrbr_op;
 
-const rv_opcode_data rv_xlrbr_opcode_data[] = {
+static const rv_opcode_data xlrbr_opcode_data[] = {
     { "illegal", rv_codec_illegal, rv_fmt_none, NULL, 0, 0, 0 },
     { "crc32.b", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
     { "crc32.h", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
@@ -75,5 +75,7 @@ void decode_xlrbr(rv_decode *dec, rv_isa isa)
         }
         break;
     }
+
+    dec->opcode_data = xlrbr_opcode_data;
     dec->op = op;
 }
diff --git a/disas/riscv-xthead.c b/disas/riscv-xthead.c
index 2f2ddb8dd9..96f80bc8e5 100644
--- a/disas/riscv-xthead.c
+++ b/disas/riscv-xthead.c
@@ -127,7 +127,7 @@ typedef enum {
     rv_op_th_sync_s,
 } rv_xthead_op;
 
-const rv_opcode_data xthead_opcode_data[] = {
+static const rv_opcode_data xthead_opcode_data[] = {
     { "th.illegal", rv_codec_illegal, rv_fmt_none, NULL, 0, 0, 0 },
     /* XTheadBa */
     { "th.addsl", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm, NULL, 0, 0, 0 },
@@ -272,6 +272,7 @@ void decode_xtheadba(rv_decode *dec, rv_isa isa)
         break;
     }
 
+    dec->opcode_data = xthead_opcode_data;
     dec->op = op;
 }
 
@@ -330,6 +331,7 @@ void decode_xtheadbb(rv_decode *dec, rv_isa isa)
         break;
     }
 
+    dec->opcode_data = xthead_opcode_data;
     dec->op = op;
 }
 
@@ -356,6 +358,7 @@ void decode_xtheadbs(rv_decode *dec, rv_isa isa)
         break;
     }
 
+    dec->opcode_data = xthead_opcode_data;
     dec->op = op;
 }
 
@@ -434,6 +437,7 @@ void decode_xtheadcmo(rv_decode *dec, rv_isa isa)
         break;
     }
 
+    dec->opcode_data = xthead_opcode_data;
     dec->op = op;
 }
 
@@ -461,6 +465,7 @@ void decode_xtheadcondmov(rv_decode *dec, rv_isa isa)
         break;
     }
 
+    dec->opcode_data = xthead_opcode_data;
     dec->op = op;
 }
 
@@ -498,6 +503,7 @@ void decode_xtheadfmemidx(rv_decode *dec, rv_isa isa)
         break;
     }
 
+    dec->opcode_data = xthead_opcode_data;
     dec->op = op;
 }
 
@@ -533,6 +539,7 @@ void decode_xtheadfmv(rv_decode *dec, rv_isa isa)
         break;
     }
 
+    dec->opcode_data = xthead_opcode_data;
     dec->op = op;
 }
 
@@ -564,6 +571,7 @@ void decode_xtheadmac(rv_decode *dec, rv_isa isa)
         break;
     }
 
+    dec->opcode_data = xthead_opcode_data;
     dec->op = op;
 }
 
@@ -638,6 +646,7 @@ void decode_xtheadmemidx(rv_decode *dec, rv_isa isa)
         break;
     }
 
+    dec->opcode_data = xthead_opcode_data;
     dec->op = op;
 }
 
@@ -672,6 +681,7 @@ void decode_xtheadmempair(rv_decode *dec, rv_isa isa)
         break;
     }
 
+    dec->opcode_data = xthead_opcode_data;
     dec->op = op;
 }
 
@@ -706,5 +716,6 @@ void decode_xtheadsync(rv_decode *dec, rv_isa isa)
         break;
     }
 
+    dec->opcode_data = xthead_opcode_data;
     dec->op = op;
 }
diff --git a/disas/riscv-xventana.c b/disas/riscv-xventana.c
index cd694f15f3..4539173d95 100644
--- a/disas/riscv-xventana.c
+++ b/disas/riscv-xventana.c
@@ -14,7 +14,7 @@ typedef enum {
     ventana_op_vt_maskcn = 2,
 } rv_ventana_op;
 
-const rv_opcode_data ventana_opcode_data[] = {
+static const rv_opcode_data ventana_opcode_data[] = {
     { "vt.illegal", rv_codec_illegal, rv_fmt_none, NULL, 0, 0, 0 },
     { "vt.maskc", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
     { "vt.maskcn", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
@@ -38,5 +38,6 @@ void decode_xventanacondops(rv_decode *dec, rv_isa isa)
         break;
     }
 
+    dec->opcode_data = ventana_opcode_data;
     dec->op = op;
 }
diff --git a/disas/riscv.c b/disas/riscv.c
index 9880b8de20..eb6d132a2c 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1656,7 +1656,7 @@ static uint32_t operand_lpl(rv_inst inst)
 
 /* instruction metadata */
 
-const rv_opcode_data rvi_opcode_data[] = {
+static const rv_opcode_data rvi_opcode_data[] = {
     { "illegal", rv_codec_illegal, rv_fmt_none, NULL, 0, 0, 0 },
     { "lui", rv_codec_u, rv_fmt_rd_uimm, NULL, 0, 0, 0 },
     { "auipc", rv_codec_u, rv_fmt_rd_uoffset, NULL, 0, 0, 0 },
@@ -2948,6 +2948,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
     rv_opcode op = rv_op_illegal;
+
     switch ((inst >> 0) & 0b11) {
     case 0:
         switch ((inst >> 13) & 0b111) {
@@ -4590,6 +4591,8 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
         }
         break;
     }
+
+    dec->opcode_data = rvi_opcode_data;
     dec->op = op;
 }
 
@@ -5421,33 +5424,30 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
     };
     const rv_opcode_data *op;
 
-    dec.opcode_data = rvi_opcode_data;
     decode_inst_opcode(&dec, isa);
 
     if (dec.op == rv_op_illegal && cfg) {
         static const struct {
             bool (*guard_func)(const RISCVCPUConfig *);
-            const rv_opcode_data *opcode_data;
             void (*decode_func)(rv_decode *, rv_isa);
         } decoders[] = {
-            { has_xtheadba_p, xthead_opcode_data, decode_xtheadba },
-            { has_xtheadbb_p, xthead_opcode_data, decode_xtheadbb },
-            { has_xtheadbs_p, xthead_opcode_data, decode_xtheadbs },
-            { has_xtheadcmo_p, xthead_opcode_data, decode_xtheadcmo },
-            { has_xtheadcondmov_p, xthead_opcode_data, decode_xtheadcondmov },
-            { has_xtheadfmemidx_p, xthead_opcode_data, decode_xtheadfmemidx },
-            { has_xtheadfmv_p, xthead_opcode_data, decode_xtheadfmv },
-            { has_xtheadmac_p, xthead_opcode_data, decode_xtheadmac },
-            { has_xtheadmemidx_p, xthead_opcode_data, decode_xtheadmemidx },
-            { has_xtheadmempair_p, xthead_opcode_data, decode_xtheadmempair },
-            { has_xtheadsync_p, xthead_opcode_data, decode_xtheadsync },
-            { has_XVentanaCondOps_p, ventana_opcode_data, decode_xventanacondops },
-            { has_xlrbr_p, rv_xlrbr_opcode_data, decode_xlrbr },
+            { has_xtheadba_p, decode_xtheadba },
+            { has_xtheadbb_p, decode_xtheadbb },
+            { has_xtheadbs_p, decode_xtheadbs },
+            { has_xtheadcmo_p, decode_xtheadcmo },
+            { has_xtheadcondmov_p, decode_xtheadcondmov },
+            { has_xtheadfmemidx_p, decode_xtheadfmemidx },
+            { has_xtheadfmv_p, decode_xtheadfmv },
+            { has_xtheadmac_p, decode_xtheadmac },
+            { has_xtheadmemidx_p, decode_xtheadmemidx },
+            { has_xtheadmempair_p, decode_xtheadmempair },
+            { has_xtheadsync_p, decode_xtheadsync },
+            { has_XVentanaCondOps_p, decode_xventanacondops },
+            { has_xlrbr_p, decode_xlrbr },
         };
 
         for (size_t i = 0; i < ARRAY_SIZE(decoders); i++) {
             if (decoders[i].guard_func(cfg)) {
-                dec.opcode_data = decoders[i].opcode_data;
                 decoders[i].decode_func(&dec, isa);
                 if (dec.op != rv_op_illegal) {
                     break;
-- 
2.54.0


