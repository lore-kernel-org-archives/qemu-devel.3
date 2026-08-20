Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA06DC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtkq-0004y7-8O; Wed, 19 Aug 2026 23:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtkN-0003pZ-Ou
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:19 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtkM-0004A2-7V
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:19 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-38e347638adso1950775a91.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197637; x=1787802437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wqpgx19U+U0hdUaAa6qWGdcaekLx063/m+xN5qlHCgk=;
 b=nvdPNwJOQG65zzMBDwtpbKicBztOGgqzhxHR0vIGmd3/kSDHxZSXF+R0gjJytbmDeo
 sVvAOUBmiFwwG8RKqK7eBS34xM1TS8MEI6L7NrRXUXaQVWMcdhvsmB06rYVA0mU/1Ck+
 4zIUR0Xg+vysvuspmh+o7Sl87qwtoVmEu9yC4bbIwOcKIGcnzR2hQCu6ePXyaX85imO9
 CBtctVeE1E15R5srabvwfMngz5M1GeiZdRA99n1u7kutgdQdqhzm0mpzaz6lLd261XJp
 nP9yLE9FH5OypR0ziZeC34tV/ZTfp6zhOkqEsWwEoKlCdH6sK8IEQu9MDBekEcZGPD7O
 8RdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197637; x=1787802437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wqpgx19U+U0hdUaAa6qWGdcaekLx063/m+xN5qlHCgk=;
 b=a26/cF4/HvEui9GDdWLDOzT59yk11hojbwxcUZi6LL9Y31qihZ9hxN9MCoe6PM6qzT
 KQ+AmbX+quc5Q/LqggG98tsGumSUTwcqkdChP24ndW/jdW022M2hhzKvqn5m/PQ9K4ce
 pjghV04x/kHABV3nFPwW/muH1VnBQKn5R9zhonfCNO7PPaA5lnFd9+g9F3GwqFZCciHw
 zrPq5FE8H+2zM+5A0RR+UmMN12kUVivLaoS3/qtwVjJ0paUmGGjl3TlaL84a8wbfue/u
 qy02iFjvE4OfxZa0REDD9N9nvS3VNnFGqna5Igot3TOYKw+WGE79tF8s0eLJTamd0uRX
 5jcQ==
X-Gm-Message-State: AFuF++mDaVsE5JjOft1k8/DnPDz00kTceOZ3ts1oOeXf2jhxb39p1/sG
 WGJLNntEWbeSfDSFwoN+5VwX4ptWls+ed5WWv5FdBJc9vdGdh79Cw2JTJkerWQ==
X-Gm-Gg: AR+sD13gVFVXnE+UvI5yVrW3NQPY+9BVqfzBqkVePgAUT/U5IwlqFX4aUGuqXInyhAZ
 755Gv++lTRRY+yVKjzpYc/t9M0oskuUrBvx9Nfq3eqQKLo8u9SezDWE3vGf9Gme6MXg6wnt4tNG
 Sykj6brpyczSU9lVRgO/4I28AEG1n0Dv+Hy+ZT95e2VfzSeeLs0oldiZ6/HH/nPjoSJSRPl4fA/
 nj5axPbbLUCn3SBqBcC3VxXDFudR+RUE3vwYy+ePqpwbi29yxfApoFpLgTYQSJSkAGceXl8Ps6h
 bTJXAxwvEml1s4DYuokTdN/3M7X0kNdjc5SrOyfHsctDjTu1EgduDX1+IKU+s6TplPOOnSWJKBx
 QI5Mv17DrHgGvR+o9dN94HUXw5HOYM50jPuOdFnbfzSVUo1toXKYDaoLfouCeaWfUvTsJtWkaEV
 D8hiUKfVvyHPe/t76EtQ1Zd/1Rm8Tu0YE0Z7bNCfMjGirAA3nuUbSZ+VS/X74qOglWB9BcyGF/1
 XYcGA==
X-Received: by 2002:a17:90b:1804:b0:38f:dec8:f7e9 with SMTP id
 98e67ed59e1d1-395810b5a15mr16885007a91.12.1787197636737; 
 Wed, 19 Aug 2026 20:47:16 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:47:16 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 52/93] disas/riscv: Handle c.{srli,srai} imm during decode
Date: Thu, 20 Aug 2026 13:43:49 +1000
Message-ID: <20260820034430.1186695-53-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1032.google.com
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

Zero shift immediate to c.srli and c.srai are not illegal,
but are reserved as HINTs.  Go ahead and disassemble as
shifts rather than falling back to invalid.

On the other hand, shift immediate >= 32 with RV32 is
reserved for custom extensions, and we need to reject those
early so that the extension disassemblers get a look in.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-17-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.54.0


