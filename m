Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF9EC52D7D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 01:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1selRK-0001Dr-VS; Thu, 15 Aug 2024 21:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1selRC-0000qt-Ly
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 21:07:32 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1selRA-0002Ka-6i
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 21:07:29 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7106cf5771bso1308165b3a.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 18:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723770447; x=1724375247;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bOp3QknnppYKc6NqQXS9ioOC0GJa+R1wT3E/uYEWjyw=;
 b=gXHBvgPDiZhZ/GUaJsaLKOF8jNQjxN83vHOsfVyKbi3NZkSqXRNlqziQaQwqckI46Y
 PHnVp0qXpcpW/2GxUQSBy3e5UepseQn7SXiddoK/1QzaEqaRyaMhs41NbKTBOaxuoAXK
 FSQWystWpWagBzvY0srd/UqC9hBIIIHDiBcGH0xQikeJOHn1ssSoJRj+dlGborzOv2Yi
 FeSvME8BzV10UGZjepnuKnbDQxzugz7WgbonNE8AAr9+lK/Z4SgnA2cpcqIedJCoZHf6
 3PZKeJZLLO0py5GJTclYwvWcmOsGTB4lAGco7Le5R5j/wS0qrH8VRTQ9FyILbYQQRkD3
 VAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723770447; x=1724375247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bOp3QknnppYKc6NqQXS9ioOC0GJa+R1wT3E/uYEWjyw=;
 b=g2O106jOLhic1aNyHENj+4ZpsE0CT+oUM+mwTAL34SD2ZoZXFiVEtElqJblRN6vV/t
 OVCdQ2397ufC649BBvBZ8r63iFg6QJ3HkySxEKGRM5taBge7d44XwIuuX1huLb60auE4
 yiUkM37l3eb4DUcxDJjDeud/d9m1arX1SPaA+j+td22Xe7EsEIpp0HoBBveTOGZmgytQ
 dH944q1QYq39tmRLH6SXcNGeLmvg74h1nFpXOG0vvTHTmXCZn2c/6UBZd+iNne7PiJ3E
 pwUYaj6w/9xZ2fn1DM+hatLKdPheHn+9MoOomvcB4qbvuqYXilABorYJIPqcO1W3L9V5
 WJxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDglMC75SFTm0kgxITltLKt6fTYAdak+E04M5azQdfen+hkOIDAM6QoA2OcaPdgRSf5SLSI1qabMyZT+UJ8ujrknchFLU=
X-Gm-Message-State: AOJu0Yz2Z6CC0dmiL3RZH5y7fG++fwseSIrVYiipb26HF8Ce2V8wMqso
 Dr7eBCS+BTQt4FhI0fohdksE/CYABfAb7EdAVWlt6legasoJSSAw0PMT9qVCqeI=
X-Google-Smtp-Source: AGHT+IFfKdbXc891ief6Hc8bW7LWrGsxu9+Bd+qA9x6dUKCJlNPlXZhFNrDdMDWA10JDzwH6xHpJlA==
X-Received: by 2002:a05:6a00:1404:b0:70d:262e:7279 with SMTP id
 d2e1a72fcca58-713c4dfbb8cmr1935237b3a.3.1723770446492; 
 Thu, 15 Aug 2024 18:07:26 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127ae120cdsm1604806b3a.77.2024.08.15.18.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 18:07:26 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, richard.henderson@linaro.org,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com, jim.shu@sifive.com,
 andy.chiu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v4 07/16] disas/riscv: enabled `lpad` disassembly
Date: Thu, 15 Aug 2024 18:07:01 -0700
Message-ID: <20240816010711.3055425-8-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240816010711.3055425-1-debug@rivosinc.com>
References: <20240816010711.3055425-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 18 +++++++++++++++++-
 disas/riscv.h |  2 ++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index c8364c2b07..c7c92acef7 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -974,6 +974,7 @@ typedef enum {
     rv_op_amomaxu_h = 943,
     rv_op_amocas_b  = 944,
     rv_op_amocas_h  = 945,
+    rv_op_lpad = 946,
 } rv_op;
 
 /* register names */
@@ -2232,6 +2233,7 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "amomaxu.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
     { "amocas.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
     { "amocas.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "lpad", rv_codec_lp, rv_fmt_imm, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -2925,7 +2927,13 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 7: op = rv_op_andi; break;
             }
             break;
-        case 5: op = rv_op_auipc; break;
+        case 5:
+            op = rv_op_auipc;
+            if (dec->cfg->ext_zicfilp &&
+                (((inst >> 7) & 0b11111) == 0b00000)) {
+                op = rv_op_lpad;
+            }
+            break;
         case 6:
             switch ((inst >> 12) & 0b111) {
             case 0: op = rv_op_addiw; break;
@@ -4482,6 +4490,11 @@ static uint32_t operand_tbl_index(rv_inst inst)
     return ((inst << 54) >> 56);
 }
 
+static uint32_t operand_lpl(rv_inst inst)
+{
+    return inst >> 12;
+}
+
 /* decode operands */
 
 static void decode_inst_operands(rv_decode *dec, rv_isa isa)
@@ -4869,6 +4882,9 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa)
         dec->imm = sextract32(operand_rs2(inst), 0, 5);
         dec->imm1 = operand_imm2(inst);
         break;
+    case rv_codec_lp:
+        dec->imm = operand_lpl(inst);
+        break;
     };
 }
 
diff --git a/disas/riscv.h b/disas/riscv.h
index 16a08e4895..1182457aff 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -166,6 +166,7 @@ typedef enum {
     rv_codec_r2_immhl,
     rv_codec_r2_imm2_imm5,
     rv_codec_fli,
+    rv_codec_lp,
 } rv_codec;
 
 /* structures */
@@ -228,6 +229,7 @@ enum {
 #define rv_fmt_rs1_rs2                "O\t1,2"
 #define rv_fmt_rd_imm                 "O\t0,i"
 #define rv_fmt_rd_uimm                "O\t0,Ui"
+#define rv_fmt_imm                    "O\ti"
 #define rv_fmt_rd_offset              "O\t0,o"
 #define rv_fmt_rd_uoffset             "O\t0,Uo"
 #define rv_fmt_rd_rs1_rs2             "O\t0,1,2"
-- 
2.44.0


