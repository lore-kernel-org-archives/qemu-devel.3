Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC17FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 17:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYUZV-0006kE-S5; Mon, 29 Jul 2024 13:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUZL-0005rO-Pf
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:54:00 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUZJ-0000O1-Ql
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:53:59 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7a23fbb372dso2113734a12.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 10:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722275635; x=1722880435;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GwN8KazdAM6rfbJ9pEQTaPAvCowqMjvonYMvwP9Ekyo=;
 b=fN1ZviW4rEc0xjdamaeNlb2IYRFj/79K1wa81G60BM8DnkdqzwO06SbNYcDn5RBTKb
 yfexMH5JP+xx+QJBPqylYhlkug5o8+4h1Xl1teQizpu7GZ6QDYwWuyhrfvGSeVk5YzFy
 RgAi1DtXBdT1cuqxaM6irxiQbC1eFxlFxE7HLl6v/r/1n4I0gerh9HU7SFSa1mvO35tm
 jgBju42CgCjEUgqx4euTCf815Z562Hcu/b5S3Yf0CSV6ZstHubbTrK0YaLpI7Mopa8M9
 MowXHgImqRSQlDd5k+DzWmRvg+N/F7cqA2xZ5xvubqycUIhsdCHQrd/IE6T4aMum2zSQ
 yB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722275635; x=1722880435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GwN8KazdAM6rfbJ9pEQTaPAvCowqMjvonYMvwP9Ekyo=;
 b=BJL3LfGQPDc9RQegAWYtxHVMeRIeDMA8LMGA/SRXzUuac2h0M2nf8e3QYKOJ9qEIJv
 q3qhn3vKOND8sPD/xMOhT0mLUBPQ5w/WMZJi6F6Gej1aAIh+RTCEPd0fiqp47BCz0pcl
 wPrW8A1Z3Fc+vuCuMYdej2/VZqQDyUFFvZQ3fYtf8Ag3+e4c59bgFF7rR1k8HRuyoBIg
 yteNAU/AlNqFqMX20bAsrSSLXuI3H8d+waen2t2xACDOrTjHdTFMdha8eo5LLvxdWpmY
 tYVRY/vmKXRdUxV/RSPVXlVIJ92IIADKV6mtmPMzUyEJH6alTmD9NNl+te8dJavnmpn1
 HQjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZNV/rRXckc/4UArFjJ3wJxu3Vfj998a/y1L2JpjBA6VH0eBH322G/rr2KtJKi/ZexkOH7oC2/3becoe07Ui8bAdGyxX0=
X-Gm-Message-State: AOJu0Yzic54AEAv9XIzuBTP/Lni6jULd/aeJXze524L06wC9QsKetlUb
 AyLioZlpHlZKATm6I7QtXgPj+jEBumjpWQXRct9BoF7fKCNSn0IB7xX7kW9gOoI=
X-Google-Smtp-Source: AGHT+IE5/MaQM/xoGUU0IfgNAzA1oXVtpmD9nE2YW639UsHztg34gTFOmo2rmOLZaS9LaWerPiXmjQ==
X-Received: by 2002:a05:6a21:2d08:b0:1c2:5fa8:2de2 with SMTP id
 adf61e73a8af0-1c4a117c6f2mr7041531637.10.1722275635456; 
 Mon, 29 Jul 2024 10:53:55 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f7c71b15sm6303141a12.18.2024.07.29.10.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 10:53:55 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v2 20/24] disas/riscv: enable disassembly for compressed
 sspush/sspopchk
Date: Mon, 29 Jul 2024 10:53:22 -0700
Message-ID: <20240729175327.73705-21-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240729175327.73705-1-debug@rivosinc.com>
References: <20240729175327.73705-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=debug@rivosinc.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

sspush and sspopchk have equivalent compressed encoding taken from zcmop.
cmop.1 is sspush x1 while cmop.5 is sspopchk x5. Due to unusual encoding
for both rs1 and rs2 from space bitfield, this required a new codec.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 disas/riscv.c | 19 ++++++++++++++++++-
 disas/riscv.h |  1 +
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index c4e47fbc78..82175e75ee 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -980,6 +980,8 @@ typedef enum {
     rv_op_ssrdp = 949,
     rv_op_ssamoswap_w = 950,
     rv_op_ssamoswap_d = 951,
+    rv_op_c_sspush = 952,
+    rv_op_c_sspopchk = 953,
 } rv_op;
 
 /* register names */
@@ -2244,6 +2246,10 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "ssrdp", rv_codec_r, rv_fmt_rd, NULL, 0, 0, 0 },
     { "ssamoswap.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
     { "ssamoswap.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "c.sspush", rv_codec_cmop_ss, rv_fmt_rs2, NULL, rv_op_sspush,
+      rv_op_sspush, 0 },
+    { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1, NULL, rv_op_sspopchk,
+      rv_op_sspopchk, 0 },
 };
 
 /* CSR names */
@@ -2604,7 +2610,13 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             if (dec->cfg->ext_zcmop) {
                 if ((((inst >> 2) & 0b111111) == 0b100000) &&
                     (((inst >> 11) & 0b11) == 0b0)) {
-                    op = rv_c_mop_1 + ((inst >> 8) & 0b111);
+                    unsigned int cmop_code = 0;
+                    cmop_code = ((inst >> 8) & 0b111);
+                    op = rv_c_mop_1 + cmop_code;
+                    if (dec->cfg->ext_zicfiss) {
+                        op = (cmop_code == 0) ? rv_op_c_sspush : op;
+                        op = (cmop_code == 2) ? rv_op_c_sspopchk : op;
+                    }
                     break;
                 }
             }
@@ -4919,6 +4931,11 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa)
     case rv_codec_lp:
         dec->imm = operand_lpl(inst);
         break;
+    case rv_codec_cmop_ss:
+        dec->rd = rv_ireg_zero;
+        dec->rs1 = dec->rs2 = operand_crs1(inst);
+        dec->imm = 0;
+        break;
     };
 }
 
diff --git a/disas/riscv.h b/disas/riscv.h
index 4895c5a301..6a3b371cd3 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -167,6 +167,7 @@ typedef enum {
     rv_codec_r2_imm2_imm5,
     rv_codec_fli,
     rv_codec_lp,
+    rv_codec_cmop_ss,
 } rv_codec;
 
 /* structures */
-- 
2.44.0


