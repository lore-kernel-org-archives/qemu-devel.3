Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE07C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 04:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtko-0004eD-6a; Wed, 19 Aug 2026 23:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtkV-0003yT-BO
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:27 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtkT-0004Ax-U4
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:27 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c9eefcf9175so1353047a12.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197645; x=1787802445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=toVDeATvXKbZsEV6lrO/6YOhYfdtzoWUhVqQYDrEcNA=;
 b=JA4nZ5Tj1r0Hy/3LA6ycvSqgH2PJB4gzAlYWirjCPgyGIfYcIvHEk8h+SslVX2ikV7
 W/aZ010nQXQFQ1Bhib+4Tz09d294L6HmHkIC+/3gVaw0hhvGF1XalGm4i5bDa92tQ8BW
 jUjZHCRw0crdK0gqIRBWppoIikl8vGdptOD/SwqTvu9BrYffsYyoNuwD1hAleRL25WHx
 d5jdbSpBZOGPFHXjnzLFFx3jj0IOL08RS6mr0SU0B4yRdB0STFn7xRrzxcMtkjNyqCB1
 V8o9/NqjFlxLQR+be895r1P/kRKzUn92tosnvhzl+r4XpwRMdd/dXNLrLjVoiLN4icuY
 HiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197645; x=1787802445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=toVDeATvXKbZsEV6lrO/6YOhYfdtzoWUhVqQYDrEcNA=;
 b=ilS+dYhzg2OemX+6b4Jv1xBELXkPPoegiMBK9UtPEw2VWOSQyY4FPR4hFvgKsykuaW
 yC/gOKbr+UdDHUz8/EKaqUdJDwYodwHnUuC/oV2XnSCT/6/L5AmLPu1PqU7hSpEhiwPO
 aVoWdfGRjDqnrri5/daC0r/HJELTy47EUwLR9z2NUjkfZkCrY1YqOBSl/msB2wSPxaRf
 YXpUngbCGP3Y1MC0WlT0parpG8FKdzyyRy5XGH4jEhlTu9lDUvUDfi8dJsD51aLSoydM
 au7EsCiO9ZwMfTxOJKyvrRQx3J3n+bvAYVZ8dxwq9FRqgaet9QDfREamte9fc8RNxlGm
 7j+g==
X-Gm-Message-State: AFuF++lCQw0dOUg9WHLTWVW1gopQkjflW0rGG6DWKmxrHFr1+hPOU2HL
 LLX3SjbbzaIlSiC9MXMk4FZzbrW4J+FomtEOwhTYDIGoAeaCnkGClVrvodNiRQ==
X-Gm-Gg: AR+sD10b2e3o9UFcHSGtnU9OfaPQxy591Au8ze6qD6bi/bLCR7wmBggEowlgBSnnLt6
 NnYXv5VrqrC6db/eZMPgIUz7uoV6XSaf/6yE49FSvfr2wyo2s3rK0Q1K/G6k+iB0xE+Aiz+WGNR
 ZCGjjGXxJUE27gQH3ZChd4oJ2ShypTCP2M8qoceOMzxx5IhBQhxZKRVMZXwSEulVZNeQNrpx6x1
 QAT8v4sC38s4fFqRADU4cuNh7wQQhktGNVBR/W1IiRwnTBbUPKm4U5IHFBg6Fp7ML1RcxRRrtgX
 C03RfsMIqkAHz6RNwrp7kZe8O+kEaHd7HMIBPC4MBfx7vncgMQagacf4kjZhv2PHLBCXXW5KV+W
 lK4UsFOJGkOUchWEKSh+LQR3yPrs/4JIwHChDJQIHsyyBS+65jMSzvMgu+MOhKoENIaUH0A2rbH
 d67lWyaJoleuVT+vnIVvrDto4daq3xGqk3Z9Jvb/xkcPDyahzn0+7pqAcxgCMoDfANOBbDIDXvJ
 7h8Zz72DsJLlD+LiQ==
X-Received: by 2002:a17:90b:39ab:b0:36d:b424:4f17 with SMTP id
 98e67ed59e1d1-39580a53474mr15870143a91.1.1787197644671; 
 Wed, 19 Aug 2026 20:47:24 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:47:24 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 55/93] disas/riscv: Remove rvcd_imm_nz
Date: Thu, 20 Aug 2026 13:43:52 +1000
Message-ID: <20260820034430.1186695-56-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x533.google.com
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

Remove rvcd_imm_nz and rv_opcode_data.decomp_data as unused.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-20-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.h | 5 -----
 disas/riscv.c | 7 +------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index 31bb0db86c..3909d73dd0 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -186,7 +186,6 @@ typedef struct {
     short decomp_rv32;
     short decomp_rv64;
     short decomp_rv128;
-    short decomp_data;
 } rv_opcode_data;
 
 typedef struct {
@@ -217,10 +216,6 @@ enum {
     rv_op_illegal = 0
 };
 
-enum {
-    rvcd_imm_nz = 0x1
-};
-
 /* instruction formats */
 
 #define rv_fmt_none                   "O\t"
diff --git a/disas/riscv.c b/disas/riscv.c
index ddc2f73eae..95957506bd 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5417,12 +5417,7 @@ static const rv_opcode_data *decode_inst_decompress(rv_decode *dec, rv_isa isa,
     }
 
     if (decomp_op != rv_op_illegal) {
-        if ((op->decomp_data & rvcd_imm_nz) && dec->imm == 0) {
-            dec->opcode_data = rvi_opcode_data;
-            dec->op = rv_op_illegal;
-        } else {
-            dec->op = decomp_op;
-        }
+        dec->op = decomp_op;
         op = &dec->opcode_data[decomp_op];
     }
     return op;
-- 
2.54.0


