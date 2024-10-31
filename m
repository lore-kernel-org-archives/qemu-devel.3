Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F368E6894F
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 03:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MHS-0002Sb-BW; Wed, 30 Oct 2024 23:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MHF-00028G-QS
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:55:18 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MHE-0004Db-49
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:55:17 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20cceb8d8b4so3319365ad.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346914; x=1730951714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OAP9AZLtcFQgpuQslqJYLvFkfp7LJJbsLdpYLJLPX0A=;
 b=kFdl9tdqHa1GkzEvWNOfl4W2ha1CrVxi0TFOYErIc/SJaslc0aOL90qQCS/xSbj8ob
 wCoCXWlVnIy1MORmEgZUO0uDd704jjRbofC+xHq+lECKBPYi+22e3E5dbnEVSbuhab+X
 Hz2vOqLDtzpWD8/2iStZ1UPrLWE800l0GWqsOhsz2Aa1uxZGVdF+ft7fjJscXkK4taQc
 QzbvYRfTNHqyKS61kCseN370NSdZyE9UIfNAWqxlrR4XbUoVZHsr7bOQHGmPfbKNdjMa
 jNMQtGw92pRacKtROpyu+BXrxAwxaRB84QM/RxiWEHdFRU/G56lDUQKkGli/VLyZO31z
 VSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346914; x=1730951714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OAP9AZLtcFQgpuQslqJYLvFkfp7LJJbsLdpYLJLPX0A=;
 b=YNDQV5d4EWJ3k9ZP1KWQBrXxZ+p4DELcE9HMZx5oSMuvnkeRSeB91BY3ueXOyoqnt8
 WiIGPtxH90l4GBT/pBF1Y6WCFn/l1I9FWWXf6Z7opin6dNZhJs1B1/HqM4po9I3Uuszx
 B0BZuK2ouhqJWrVEMLDbycKBeE0UmtKlsfAE8tB3EQYCyxDjFWNyxaZ6Py7RgqFxUz3O
 2z9JTY32P7g9an/K29XjY9gXeHk014CQpWcvXuIX7W2firuiVjbXTzIM8hiwPrTIQf/d
 VaFLeRj5iXOEAGacTsyMl+lv1lfyeLZlJcVcZAleh4GhP3wEfyDq6c6IupzQE2Wa3BN0
 AS+w==
X-Gm-Message-State: AOJu0YwXCtnzPRsQv032gnZany5MrYRUiPmGR/lgI3IDCjgNc7sAKgFQ
 i8gGT7Vj+gq9gJ0+wUYCVCF3aKTNuTTn9Sb981BHCk4VbELhHzdImIAKajBe
X-Google-Smtp-Source: AGHT+IGpA6ZvlkSV5wpqbS7jIP0y2etfwYD0eYfHs2ncbMaol/6XPLcsEU+BgAsVxkwxKuRtujr6qg==
X-Received: by 2002:a17:902:e847:b0:20b:db4:d913 with SMTP id
 d9443c01a7336-211056d1f68mr17789535ad.11.1730346913953; 
 Wed, 30 Oct 2024 20:55:13 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:55:13 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Deepak Gupta <debug@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 34/50] disas/riscv: enable disassembly for compressed
 sspush/sspopchk
Date: Thu, 31 Oct 2024 13:53:02 +1000
Message-ID: <20241031035319.731906-35-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
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

From: Deepak Gupta <debug@rivosinc.com>

sspush and sspopchk have equivalent compressed encoding taken from zcmop.
cmop.1 is sspush x1 while cmop.5 is sspopchk x5. Due to unusual encoding
for both rs1 and rs2 from space bitfield, this required a new codec.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241008225010.1861630-20-debug@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.h |  1 +
 disas/riscv.c | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index e197f5d435..d211700cb2 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -167,6 +167,7 @@ typedef enum {
     rv_codec_r2_imm2_imm5,
     rv_codec_fli,
     rv_codec_lp,
+    rv_codec_cmop_ss,
 } rv_codec;
 
 /* structures */
diff --git a/disas/riscv.c b/disas/riscv.c
index 1f0eb66d01..9c1e332dde 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -982,6 +982,8 @@ typedef enum {
     rv_op_ssrdp = 951,
     rv_op_ssamoswap_w = 952,
     rv_op_ssamoswap_d = 953,
+    rv_op_c_sspush = 954,
+    rv_op_c_sspopchk = 955,
 } rv_op;
 
 /* register names */
@@ -2248,6 +2250,10 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "ssrdp", rv_codec_r, rv_fmt_rd, NULL, 0, 0, 0 },
     { "ssamoswap.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
     { "ssamoswap.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "c.sspush", rv_codec_cmop_ss, rv_fmt_rs2, NULL, rv_op_sspush,
+      rv_op_sspush, 0 },
+    { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1, NULL, rv_op_sspopchk,
+      rv_op_sspopchk, 0 },
 };
 
 /* CSR names */
@@ -2608,7 +2614,13 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
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
@@ -4929,6 +4941,11 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa)
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
 
-- 
2.47.0


