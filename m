Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88115C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHUZ-0007L2-G1; Wed, 12 Aug 2026 18:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUV-0007HB-UZ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:07 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUQ-0000zG-Nx
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:07 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-ca80d708489so267441a12.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786573921; x=1787178721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zAbQ1lW/UBeMCTj457GMk2iIu8DiRtvoUqBPQhy3IvM=;
 b=F8o3Rc6JggEFypmShKKWmtM0U5WVgKiJ+jyGBsKD45b4OUdHXuc32MekIIpjgH7Xq4
 Ye6zrtY1lqUO7vFiN5aoM0GIDkWOd8ELl8CZNKQD7ggPY8Psc9Brar8AnQYngsHS2DOy
 nk25JAnYOIyZdwIvCKkm2yPmeB12gwgySjE4cbgGrlbVKuBKsT2/NbqwWvYd3/2KjTNl
 e87a89PRKhqIhDFp/Ny6rz8pHYCZfo7SCfTk1a6RocQfW8UYuslukVZN4uUEbSMH+yaK
 pi7t9slxIn/nTbULLyc3YHHCRkSgNjrQ59dTwHUXS43zXk9OewGV8znQdo7v7esrJzsG
 5TVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786573921; x=1787178721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zAbQ1lW/UBeMCTj457GMk2iIu8DiRtvoUqBPQhy3IvM=;
 b=gtlGO21phzkKs7oQc68gpRXtz3lo77r9dVugVnj8KRVX7uYtiiMByEqYF1LeJkdsA9
 XricacsMPIRM23mHujuAYShdxuZ3gAH3xvqmb1+ektB0L3p2Taoyiclw/Y2ZFs8/F9vY
 233oaz6VOm73JCikdf6xa0nls0q4xPBDH/8Dkm5KUTIgEPRGIy7tO1GQ6ElN0P4HY5lv
 RerpegjVqFyX62iENg3UXcQx+jqGRgyfYd5rBaaQUAeF5j4i6wu7BBDNkr8AYajp97pR
 dTEPNzkdLQPgUQL9py7xJnTnsFVUnyAihUlEGeHOJ8Rk4Joka1Pi8KavyHPT7XjBLMCG
 kQow==
X-Gm-Message-State: AOJu0YwsFt4bGPZCt3VGRPlbQO9BNXfRE+2xYMikNcx/QrtPA8Nf9SA6
 7nEUq+raTie3CC+M+dHngc2qVAX2H1rG/IAxoaH/Lvs/YGMEejR94j/+i2hYbYM5u5NwqGM+fly
 7qouZ
X-Gm-Gg: AR+sD12Ie1j1oiRY7SEZRXbyDUCgzwjcjQYF2uFeBQy3+yds+WIltm30+R9qqOLPez8
 grcV3yR4hm6S6sBc6PUsRG/rmjvwq0Zj90A2AKIL7vbTagyzOrTA9v1T3+4zrK3ieZuHJYwzw2k
 u2rOl4m/H+hNkcZi8xfknGqGhg6IIgX3/nEgmHOPmM6CvjJ/u4knIA5Hcm6cq6DqDPnCUJUzIQR
 t0ppIn9ANVy8Mo1sM6QHEB/KAnxNW0vDBLUrVBwVmyPrVC0Jl5ugZVB3QVabwZHrhQZTRW8xVMl
 hhntjcWAle1goGWyMR9rpQWc7Jkx0XValFEEisUMAuWnQZEvcoLRjs0Cf3FesgoybGjjA+6I+QB
 Tj/LNO6ovCIN7JbPB6jay169HQ0dH47wGZcMOEXxhkTPhkPjOVWSyo/Ogfqd34c/A8/rVp1x/d1
 UoQbE0J6qCDodDeweFWBpO9SmDa9+B3nPzL4OSLIs3LXB5BJSjrtE+F+HlAscru9GgOtGuCt6Sc
 97hoD1xOH9bdmL7zGQF
X-Received: by 2002:a05:6a21:58b:b0:3c3:750f:3cf9 with SMTP id
 adf61e73a8af0-3cc57634f09mr1167650637.11.1786573921317; 
 Wed, 12 Aug 2026 15:32:01 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721cb0bsm212031a12.26.2026.08.12.15.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:32:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 16/52] disas/riscv: Handle c.{srli,srai} imm during decode
Date: Wed, 12 Aug 2026 15:31:06 -0700
Message-ID: <20260812223142.349142-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Zero shift immediate to c.srli and c.srai are not illegal,
but are reserved as HINTs.  Go ahead and disassemble as
shifts rather than falling back to invalid.

On the other hand, shift immediate >= 32 with RV32 is
reserved for custom extensions, and we need to reject those
early so that the extension disassemblers get a look in.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index d6fbb3bca6..a8fbefb9bd 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1906,9 +1906,9 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "c.lui", rv_codec_ci_lui, rv_fmt_rd_uimm, NULL, rv_op_lui, rv_op_lui,
       rv_op_lui },
     { "c.srli", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srli,
-      rv_op_srli, rv_op_srli, rvcd_imm_nz },
+      rv_op_srli, rv_op_srli },
     { "c.srai", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srai,
-      rv_op_srai, rv_op_srai, rvcd_imm_nz },
+      rv_op_srai, rv_op_srai },
     { "c.andi", rv_codec_cb_imm, rv_fmt_rd_rs1_imm, NULL, rv_op_andi,
       rv_op_andi, rv_op_andi },
     { "c.sub", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_sub, rv_op_sub,
@@ -3042,10 +3042,16 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
         case 4:
             switch ((inst >> 10) & 0b11) {
             case 0:
-                op = rv_op_c_srli;
+                /* For rv32, shamt[5]=1 is designated for custom extensions. */
+                if (isa != rv32 || (inst & 0x1000) == 0) {
+                    op = rv_op_c_srli; /* or unspecified HINT */
+                }
                 break;
             case 1:
-                op = rv_op_c_srai;
+                /* For rv32, shamt[5]=1 is designated for custom extensions. */
+                if (isa != rv32 || (inst & 0x1000) == 0) {
+                    op = rv_op_c_srai; /* or unspecified HINT */
+                }
                 break;
             case 2: op = rv_op_c_andi; break;
             case 3:
-- 
2.43.0


