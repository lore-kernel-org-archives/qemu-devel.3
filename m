Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0ADAC5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 04:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtkp-0004qQ-Dj; Wed, 19 Aug 2026 23:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtkd-0004Cf-Vi
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:36 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtkc-0004By-DI
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:35 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2cab973140bso21237815ad.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197653; x=1787802453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YtA6CjFYKwQR207w18iiKRkmLC1dp+/klVeKoHfdRLU=;
 b=tMw9LwQRxn5gKONn1Y0nvS9Q1t4LKxqafMVgU3E0x0jjA4jJHkhuT7f/KuNV2omn9h
 KFCq7TE+I2MXb2CJe9/n3/sW+jc3TKJoP7hPvrKPCewtZgxrUFW5S+c2EvqIj7UVlxYj
 TskFRi6/rojAoak6l39I7bV8uMOkri2q48Vbr9uny11vCarsI1GrJqkmSDDrYmTjxB0D
 DMILwfKPI2dIPzIrjzYcQhPCV5ksRFufo9A3mh4NS9Yav+D0YPtpEMWC+ZhVjv2fHMk6
 1h0rop4c13JDpnUsMvdsIm4sVoNC5sTeZnJwYYf6A/ewiS5KW5LnWmtd9ikKhAsfnMzZ
 TNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197653; x=1787802453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YtA6CjFYKwQR207w18iiKRkmLC1dp+/klVeKoHfdRLU=;
 b=R/kXbcp2bBlqXwAWpW4vnrF7Ww4sZRLbMMe9xLamfyMlofkX5qeSi9RITwHsY8AKP5
 Y3k30G/gvt5ikMptQc5p5wOnsyAm4KWvo3yHuM69ceNQE6jAyqn7EAGFfBzkTdztnWKg
 i9C6DJDs2hsicZUUm6jHjgheqba9xIt+OZ6Zr4KTMMrnn8PQ05fAbHP/ka1oBsFoOZCd
 BR+6ac4u1gRPs0ZSmvRHNpORpDA8cjkc/NYjVP7gTBq2XmW2xkyzYcLLJIej/s3vurUI
 Xlle1JkNyOp7YckcC69gTHhEZ7go4SfRtxMeh/3Tk1n6Twgccp/PIX1G/ozOyb+WP7vN
 1K1A==
X-Gm-Message-State: AFuF++msi3JcHyQBAoB0NY7n195uITDaAxjJ+2LaGQgJI1VZbJK54Pkf
 zgVrYTNIeGXxJPrYNGxhnJqE7UJLb/67Q9gKmxdDryrQg6gdsbbXkNXAYfCP2Q==
X-Gm-Gg: AR+sD100EKQIRQlDTtfkuxWYCB6gv0JRRHo2RqYFCTKCztoceYqGlRe0ckQwDUTXnDT
 HO9v2GNHPi6l6rQespbVa9dTgmTqcA9Zrz1Suk0o89XO3GT9Wz/rYTunLtXiCg2OG6PInfyn46H
 /Nta0HdhUaVqXBwMeIWDsIRuEGLXGCodzvO8WT3AM8F8OI6X3PUEFv+gK/oH41Y6rWpC/P2TAqs
 YCnZ1E7jBbG3yDAsAb7jI6rJ0qWPh5FvTY03WPIhltJ45ORR0xMIU12d9smOVc9XHAs1NC4+tiG
 XsIJCPHQBA8Fg7cqzEtq8WCcOfDkFzk83HgHwKJ80OWPih6dqgYExp1JzacWug8V5hQhHj8U+0G
 1cys5ZTQf2OiiJa3723AM0XMsD6+Gsr0lSBl9zZOt8OttomozJsiXo9SyACU44OLgRqoS6eLAjv
 zQ1ge/BA6lUFy8X/JXTp8FtU3o+Q765btjRCCgWKxh8ys7INP+hY/KcEHLzp2qFLBlCZlV8W5he
 EBw0w==
X-Received: by 2002:a17:90b:4a05:b0:37f:c22a:c188 with SMTP id
 98e67ed59e1d1-39580a80a65mr17778572a91.4.1787197652858; 
 Wed, 19 Aug 2026 20:47:32 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:47:32 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 58/93] disas/riscv: Handle aliases of csrrw during decode
Date: Thu, 20 Aug 2026 13:43:55 +1000
Message-ID: <20260820034430.1186695-59-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-23-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index bde1cc6e62..e464b8b075 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1081,9 +1081,6 @@ static const rvc_constraint rvcc_frrm[] = { rvc_rs1_eq_x0, rvc_csr_eq_0x002,
                                             rvc_end };
 static const rvc_constraint rvcc_frflags[] = { rvc_rs1_eq_x0, rvc_csr_eq_0x001,
                                                rvc_end };
-static const rvc_constraint rvcc_fscsr[] = { rvc_csr_eq_0x003, rvc_end };
-static const rvc_constraint rvcc_fsrm[] = { rvc_csr_eq_0x002, rvc_end };
-static const rvc_constraint rvcc_fsflags[] = { rvc_csr_eq_0x001, rvc_end };
 static const rvc_constraint rvcc_fsrmi[] = { rvc_csr_eq_0x002, rvc_end };
 static const rvc_constraint rvcc_fsflagsi[] = { rvc_csr_eq_0x001, rvc_end };
 
@@ -1166,14 +1163,6 @@ static const rv_comp_data rvcp_subw[] = {
     { rv_op_illegal, NULL }
 };
 
-static const rv_comp_data rvcp_csrrw[] = {
-    { rv_op_fscsr, rvcc_fscsr },
-    { rv_op_fsrm, rvcc_fsrm },
-    { rv_op_fsflags, rvcc_fsflags },
-    { rv_op_illegal, NULL }
-};
-
-
 static const rv_comp_data rvcp_csrrs[] = {
     { rv_op_rdcycle, rvcc_rdcycle },
     { rv_op_rdtime, rvcc_rdtime },
@@ -1761,7 +1750,7 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "sfence.vm", rv_codec_r, rv_fmt_rs1 },
     { "sfence.vma", rv_codec_r, rv_fmt_rs1_rs2 },
     { "wfi", rv_codec_none, rv_fmt_none },
-    { "csrrw", rv_codec_i_csr, rv_fmt_rd_csr_rs1, rvcp_csrrw },
+    { "csrrw", rv_codec_i_csr, rv_fmt_rd_csr_rs1 },
     { "csrrs", rv_codec_i_csr, rv_fmt_rd_csr_rs1, rvcp_csrrs },
     { "csrrc", rv_codec_i_csr, rv_fmt_rd_csr_rs1 },
     { "csrrwi", rv_codec_i_csr, rv_fmt_rd_csr_zimm, rvcp_csrrwi },
@@ -4443,7 +4432,14 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     break;
                 }
                 break;
-            case 1: op = rv_op_csrrw; break;
+            case 1:
+                switch (operand_csr12(inst)) {
+                case 1: op = rv_op_fsflags; break;
+                case 2: op = rv_op_fsrm; break;
+                case 3: op = rv_op_fscsr; break;
+                default: op = rv_op_csrrw; break;
+                }
+                break;
             case 2: op = rv_op_csrrs; break;
             case 3: op = rv_op_csrrc; break;
             case 4:
-- 
2.54.0


