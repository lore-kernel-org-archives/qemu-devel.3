Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96F6C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtkk-0004IT-3X; Wed, 19 Aug 2026 23:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtkQ-0003yN-9n
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:27 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtkO-0004AH-RR
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:22 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c998fd549a8so1222138a12.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197639; x=1787802439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IIaVZ5Le07IarJEOt1XE2S2+XTMommd1hEXZNLsmCmI=;
 b=aA9/xPPdh4X0Byi/Ns9j03S2rijjgjuB0m+SHWI0k2UbdAIGeLsp246ZFIi6HIf9OG
 GOqvTqlJDEESEPOxebDZ730DWc660k8bLBXrj00RgiExifq1lk9/e9PIy7FILny+9R5M
 c9EucwVh0eNgDa3DL7dQ8HN2RstO6Hi1NxIKDHcdiDfCGlfyNIMUG/nnnGycf+NUNKGt
 QFiGUGGdWCuREsSjQkVlT4lmt55Y3Xqia2Qm8m2TOFwkITFW6N2EJBColvBWWboVzbEj
 gUViatx0q2+U3jYAYrpDfx+wk1XIk3lJu6Qhvd/vN5A+/2QxYJm0p99tKDD66J4cv7oF
 Di0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197639; x=1787802439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IIaVZ5Le07IarJEOt1XE2S2+XTMommd1hEXZNLsmCmI=;
 b=aK1BUeP9Y8E9DJe+OsTFc9Gn2fLYLCD+FxswiovnF9qcYGFu42J6ZdzJH5ZdOQ+OlA
 DnXYWoEeGJenwzfoeiHLzVE6/BexQHa7m20bM75Lo+PcZQVN52oaEPlaOlw2flEWl5gx
 Lk5NjDV2yPNh1S0HezlvosJjYzI2eziTE1sgK/KkeT/S0EG27h+MB6w1eOAvuxCmku1/
 nlT4FHjqm+eS69/PzRzkd9gfS9H8In/gN/FACwphQ35SvcNZR8IcGwexzhYmGI0kq9yd
 ziHPGUpCZpnK//dRitAG5nmELxc+JK7GkxkRTNpIAm5lYUAG6TVMMd3mNTuGebQvGUBB
 2m+w==
X-Gm-Message-State: AOJu0Yy7J7Wx7w2OlchlGprIZBGmJ713Ka4/cQQtkLLzqVPKVwinueZa
 C5dsCon11Mwa/2Tyf2rNHSknbpFXaEaRqn54v9LTD8es9/tFX2gjMLAZ2/13Rw==
X-Gm-Gg: AR+sD10oc2T7HVFi3qS/l22QLlJz7M2tQZ3u0bQ0WaFp4A12kb7DUdebcxu12343sXE
 iqoAkGt2CEQ59OkFeLnpe6NVhnZkAFDPznJr+TUlYOIDqg2Qz+yr61Axuk2Wm1cutdYDkxM1w/x
 T1Udfitz7Vvp8kP/jMfxxqYMu9JkdQFTYL6Rn9WJeaCxXKYb2omzS7VHtM2XJ9HD3Bxlnym1Lxh
 0H4iWaoBW0SEoJ8N2kYSJ/BGEVqqNkDwq4gRey5ryGU+80ctCjzvyYALlLkP8TmMT1UmfFsO9Vn
 A1xhehlJtqDepA0cn/mif+nrni5M1mS5kypbsG/Mj5Z/3oiEOytD7+yE+k6oWc7NRCPqNYXgG0P
 dLhgDnRWMKL/D6ARDejAzd86FpLHaZUEmq7pn3YJh8PHkIDmU0Vv+EtEEDA0bKbiOhshLIHuvLR
 2yklT3PuKA/O2qpUcnK1TSb/Rv67TpM9ov4kzuCVKksqQXeBeTjktg5WO4gdieJck2vWqoAc6qk
 pEFJcOr4c9fVAOb
X-Received: by 2002:a05:6a21:3382:b0:3cc:9620:5816 with SMTP id
 adf61e73a8af0-3cd0164cc07mr18078509637.8.1787197639315; 
 Wed, 19 Aug 2026 20:47:19 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:47:18 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 53/93] disas/riscv: Handle c.slli imm != 0 during decode
Date: Thu, 20 Aug 2026 13:43:50 +1000
Message-ID: <20260820034430.1186695-54-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x532.google.com
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
Message-ID: <20260812223142.349142-18-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index a8fbefb9bd..77347b557d 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1930,7 +1930,7 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "c.bnez", rv_codec_cb, rv_fmt_rs1_rs2_offset, NULL, rv_op_bne, rv_op_bne,
       rv_op_bne },
     { "c.slli", rv_codec_ci_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_slli,
-      rv_op_slli, rv_op_slli, rvcd_imm_nz },
+      rv_op_slli, rv_op_slli },
     { "c.fldsp", rv_codec_ci_ldsp, rv_fmt_frd_offset_rs1, NULL, rv_op_fld,
       rv_op_fld, rv_op_fld },
     { "c.lwsp", rv_codec_ci_lwsp, rv_fmt_rd_offset_rs1, NULL, rv_op_lw,
@@ -3085,7 +3085,9 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
     case 2:
         switch ((inst >> 13) & 0b111) {
         case 0:
-            op = rv_op_c_slli;
+            if (isa != rv32 || (inst & 0x1000) == 0) {
+                op = rv_op_c_slli; /* or unspecified HINT */
+            }
             break;
         case 1:
             if (isa == rv128) {
-- 
2.54.0


