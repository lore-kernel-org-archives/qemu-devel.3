Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0966DC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Ah-0001FS-3v; Thu, 25 Jul 2024 19:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8Af-00019h-KZ
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:53 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8Ad-0005Pl-5Q
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:53 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70d23caf8ddso378280b3a.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 16:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721951210; x=1722556010;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GwN8KazdAM6rfbJ9pEQTaPAvCowqMjvonYMvwP9Ekyo=;
 b=xgAVFoxfHNs8ASLmZW6XmTXCxHvUAAh/3Y3DBlz6gqj/KRDeCQQ8bd2eJOik3gZjzc
 aBuPP+j3bdJVzoPPKFjsurmIA4mCAPweMQ50f6ENVr/UIgDHvYDlJtflgU+qU5u6vQiV
 xmnenmN3xljMFLkaWUiSAtSqCxWa0Q6AlaahEH5p8Ktqosp9oqxqG95om3kAmiJQoYAc
 yOq4dwCHjL9hj+yc3xWEqzpZwlJ/aiKK9RsY5OdpjohVX1IjJW5qQO3u+GBU9wpNvY5K
 hWWTbezFBjbkL78ctdSufLvZ8mDzbDo6nN2k8Rh09Ml5foMijpm5FA79GrhUwKrDp+52
 qAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951210; x=1722556010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GwN8KazdAM6rfbJ9pEQTaPAvCowqMjvonYMvwP9Ekyo=;
 b=r2B0zMRItUEvnhF3PNMGm+TxJj5eqVNDVxKniPNMV9r93oCiRwe6b+4JLLG4zckHSH
 qKAETLMBG/FSapbaSEgQeJcGv7B0QDvYgQtetHrSmVoxwBLF1HCXSbhuZOFO1416kYd1
 W/Nm4GWvjkboeLIfhAkcWTQpY8nEdYmXIriVv632TI9Kb4WV09AIJ+lUq1RjwUEwD8WO
 mIAF5RD0M6ZFmTRYvLbKdmz+7Ad/0Cta5YHt/DijJ3MexpCeMs8RESjYMVALu1+rzuOP
 DJi1qhrv8AXOHsHVgZX0RpPuqcKirHRrQGk1gJ4z3d5GgBEzyTC10OZgTV53XcOXZBRz
 LZmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDvh4lFx49LximuXWz1Gk8vbAjATj9jyyI3QphzuN2BBOS1JlOkjD9VHGz9srHJ8z8bvP69MPfAqy7UVuYpsgJ+habwrM=
X-Gm-Message-State: AOJu0Yz95GozraRUjD8wiT5KvZNFg3nF18DZ+c+JcdkuIYDy0LL1Br0I
 75ODxXWrrM97ozlyC6hdtrK5qgISfOr8aDkQg1XIz7QvEt1fk7EXUwm3ygOZeqk=
X-Google-Smtp-Source: AGHT+IES+dr0cC4JL8Vqey3P4tDsQhYuxN7PAHfKAhu2NHHf8Jneip3Z4jfxP1qjPKJbed5cNBw12g==
X-Received: by 2002:a05:6a00:6f02:b0:70a:f3de:3ff with SMTP id
 d2e1a72fcca58-70eae90574fmr4036598b3a.14.1721951209759; 
 Thu, 25 Jul 2024 16:46:49 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead8128d0sm1647565b3a.118.2024.07.25.16.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:46:49 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH 20/24] disas/riscv: enable disassembly for compressed
 sspush/sspopchk
Date: Thu, 25 Jul 2024 16:46:09 -0700
Message-ID: <20240725234614.3850142-21-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240725234614.3850142-1-debug@rivosinc.com>
References: <20240725234614.3850142-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x431.google.com
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


