Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B55C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 02:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUGbh-0005e8-9r; Wed, 17 Jul 2024 22:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGbR-0005GY-NM
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:10:42 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGbP-0003OL-3K
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:10:41 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fc5239faebso2876255ad.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 19:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721268637; x=1721873437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7krw/iWmPDAPo0AIHcEhdPQl92KB84aFtQIUP8oRFWc=;
 b=UuH5VPfCgweuaeVLM9M/T7neNzXDK2nDVae2gNaexdVdrLK0P/4bEAvS1/opyhhPBt
 ZxBVGFegy0Zovjzr01iRcWshz3Fx3z80QMBq5Le5pGkStxhaR6gZsXztnviRvFR8M/s3
 wLmrE3bnef0mOOSYuN5M256BUtnxcvFQMHaGkk/AE3aNedKA4v5lH1r/ZTWTkfxPw1pV
 zzwpm4vDnHAhQdrjnx3gQjihxvo3mtD4ZscAgDVvIvAhqOx1nk3PHTcuRrAOOoFjlUe+
 +7kG4PheL+y0HJGIxiT4xX/VYVxhEjV7qjJf+FZs5+5nk0Qvywx+Lvk/Jxn/EGnrlUvp
 ykfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721268637; x=1721873437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7krw/iWmPDAPo0AIHcEhdPQl92KB84aFtQIUP8oRFWc=;
 b=jfqOaYuW6ehkLmgtykDCvS95Vkh78Mplan9Bv9qc4DyrACNg2X1VSslgAdphkR3DZ2
 PilLQifOcRD1ZbQCJlvZn6CCA9xjKb9NvWAW/D/ClocMdrzpnv57+htawbiFnCdJzZRG
 cUCmQa4STF4rnEgV9Je2BkZ9JmiEOdao3P/r0waqo608azHT4Nv9+R1mLIU/Ny+VZ38P
 X3tMoV8CLNFbRv7acZwOMiQVAhW6ErETWi9ugcRZwfAszUZWW4meRv5OcBg/sJEi5JY/
 /Zbn9EKp18UFT2H5cUorrSyxzZjD51aqZ/kUaogFnQq9zfduYnjwxVm+s3t+houK+BtO
 1bGg==
X-Gm-Message-State: AOJu0YwV9T27Mo+QOhn+f28Qg9S+C/snPv92GrEzTbjycxtfDiLtqK2O
 lVjsXhe+f5EDVm+9e8QuxRf72O4npk96ons9QYxiCOu+3BIvZpZd+otar2tk
X-Google-Smtp-Source: AGHT+IHXzIHJIhp93hRK5gc2ww+2oFlqTEBSy/wnIxLXjLNfT+W4WsGn9mDo4I7IDSHtlVY2iJhTHA==
X-Received: by 2002:a17:903:1105:b0:1fa:ff8:e66e with SMTP id
 d9443c01a7336-1fc4e6a36a5mr28424615ad.59.1721268637368; 
 Wed, 17 Jul 2024 19:10:37 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bba949bsm81999385ad.69.2024.07.17.19.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 19:10:36 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Deepak Gupta <debug@rivosinc.com>
Subject: [PULL 04/30] disas/riscv: Support zcmop disassemble
Date: Thu, 18 Jul 2024 12:09:46 +1000
Message-ID: <20240718021012.2057986-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718021012.2057986-1-alistair.francis@wdc.com>
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
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

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Although in QEMU disassemble, we usually lift compressed instruction
to an normal format when display the instruction name. For C.MOP.n,
it is more reasonable to directly display its compressed name, because
its behavior can be redefined by later extension.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Deepak Gupta <debug@rivosinc.com>
Message-ID: <20240709113652.1239-5-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/disas/riscv.c b/disas/riscv.c
index 0b82ab2322..d29cb1ff7d 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -946,6 +946,14 @@ typedef enum {
     rv_mop_rr_5    = 915,
     rv_mop_rr_6    = 916,
     rv_mop_rr_7    = 917,
+    rv_c_mop_1     = 918,
+    rv_c_mop_3     = 919,
+    rv_c_mop_5     = 920,
+    rv_c_mop_7     = 921,
+    rv_c_mop_9     = 922,
+    rv_c_mop_11    = 923,
+    rv_c_mop_13    = 924,
+    rv_c_mop_15    = 925,
 } rv_op;
 
 /* register names */
@@ -2176,6 +2184,14 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "mop.rr.5", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
     { "mop.rr.6", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
     { "mop.rr.7", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
+    { "c.mop.1",  rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
+    { "c.mop.3",  rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
+    { "c.mop.5",  rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
+    { "c.mop.7",  rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
+    { "c.mop.9",  rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
+    { "c.mop.11", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
+    { "c.mop.13", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
+    { "c.mop.15", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -2532,6 +2548,13 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             break;
         case 2: op = rv_op_c_li; break;
         case 3:
+            if (dec->cfg->ext_zcmop) {
+                if ((((inst >> 2) & 0b111111) == 0b100000) &&
+                    (((inst >> 11) & 0b11) == 0b0)) {
+                    op = rv_c_mop_1 + ((inst >> 8) & 0b111);
+                    break;
+                }
+            }
             switch ((inst >> 7) & 0b11111) {
             case 2: op = rv_op_c_addi16sp; break;
             default: op = rv_op_c_lui; break;
-- 
2.45.2


