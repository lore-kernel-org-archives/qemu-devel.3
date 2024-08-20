Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C87C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 00:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgCKY-0001JW-IS; Mon, 19 Aug 2024 20:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgCK7-0000me-TV
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:02:11 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgCJz-0001D5-RJ
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:02:04 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-201ee6b084bso40464815ad.2
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 17:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724112104; x=1724716904;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bOp3QknnppYKc6NqQXS9ioOC0GJa+R1wT3E/uYEWjyw=;
 b=GfE4lZCeaYvkaqRQAxW6HMG7lETWGSXODVafeyvkcP9Ll8qMrsFDnXDcYiMy4ZfhNl
 WKDYhpcwfZHolR2OUoqAfodbyAPxmeAfLMl2Wxsxosk5/kK1NaqGwLTwN2KZfeRMhvAx
 wnLh9cpE4hovKm91jbf3E8Ekb+Fmv4sgVWcfKB93merqqd98aafzBwlTMPvfVBfiWkO1
 ctFAH0xb1FjBIN1huclRL7BCx3bI9ymQuTrsGM3+fZWxWegvGQ9dU0TGP4gsBH0Bcd3M
 r7U02X0piD8zmtkI+GI4Jqv+aHb0hqItRpvG3xQJpEznbYbJdyHvddw5bi6gTm/xEEFZ
 3j2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724112104; x=1724716904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bOp3QknnppYKc6NqQXS9ioOC0GJa+R1wT3E/uYEWjyw=;
 b=NRfaLGrBz8SNu4Hdr82w2Ipkycog0VwyysPeI8Xb34hngVWkmi/0NyNPRuVsaq0T3B
 bu2n47Qb3CeK38jgE/dqv5p7mSY91C3DjGAevy4QysVZbGh7gD0njNWLs9Tit0yNCRLv
 rwzfmuoGcLceGBG8LqXwSPz0Brfr0wBQg2rU4yLcBWXnYPkiRXboi3QNIj5oTl3g7OSW
 SJwkyGPNZxTmqMpO3bl+V9xt03piTYXaHF9B45tdXc8etS8BKdnUs7BJTMUrBfjPry3t
 QhnSw7bjSOCCW1zNTxxP2/Yew0ZNDJ76+aqicFOE+Jz+jVamVVwgJxEAsTcJ170LwoV6
 TGBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV9GX4V9F3dyuLyNJvP8k9jNJDW67wVd7ppSRqsm22OLg/QxGWGWNOSBLkNrzue07XMOeUwgBEwSLsRmqz6wdah+zp9Wk=
X-Gm-Message-State: AOJu0YzqUrStUA7q4boeygzM87gn1nVQeGH4fpjmvK7MRXIdTed9YekT
 6Y8o2TIxx4wGIlcfDXGluaJ5noM1wtCG8Fr+FuPZgHq//FzR6Ff0sWYG+LFpGUo=
X-Google-Smtp-Source: AGHT+IEX2UFytvAseLBj80kaUDaLd4inGxYa4rsDW03FMsziaYRGOhoL9H3ZLJ4p5i+jx00UdH8ELw==
X-Received: by 2002:a17:902:f9ce:b0:1fb:8aa9:e2a9 with SMTP id
 d9443c01a7336-20203e8f81dmr119793635ad.15.1724112103955; 
 Mon, 19 Aug 2024 17:01:43 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f038a779sm67477445ad.188.2024.08.19.17.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 17:01:43 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 07/15] disas/riscv: enable `lpad` disassembly
Date: Mon, 19 Aug 2024 17:01:21 -0700
Message-ID: <20240820000129.3522346-8-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240820000129.3522346-1-debug@rivosinc.com>
References: <20240820000129.3522346-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


