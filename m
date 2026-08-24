Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32AAC5DF98
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNat-0004aN-N9; Mon, 24 Aug 2026 01:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNaC-00042s-QS
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:57 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNaB-0002Xo-86
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:56 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-cbee3777e1cso1794841a12.3
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550654; x=1788155454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IIaVZ5Le07IarJEOt1XE2S2+XTMommd1hEXZNLsmCmI=;
 b=K8P+UreK3AL4gGmzFxq3U6jo8PJ9Pu/vYTUulzA3jw6p9UFrm8jNH9mdYy9VVJdsiN
 tzUqvju87SPlkqhmQLRLmVgQ91kvgoqGN0pa1j91ZDH3Wk9Vb7n1CTB8OSHLvpW3OhKQ
 nkiClJPTauc50ogDnvmFKzUiGnwShIgZWvQ+f6fIy4mwgQH/cc/G44BMxcm23+W+febQ
 L58aEXfZveB2oCBvrOJcE6x5Ca0SgbZe6BmeqXu6fKlEU/iw9ajRn7RYQ+tYH8fNnzaY
 fT1racMTFBUFSa1MUEIhCfwxsvhTrLppdXjdrVyYeiNuL9eWuN2vmY1Vtr+EeTFTizlz
 Ncag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550654; x=1788155454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IIaVZ5Le07IarJEOt1XE2S2+XTMommd1hEXZNLsmCmI=;
 b=jts1Qs5Ix4FYTb/G6yLdouH/Rt+hn/9auPve1WA/X0AthQR5v7IytpoXrP/NWjuZqh
 AIXK7GxZ1SF77ZAZdku6fyuSZKrvD5x+qadPclh17LNyN0dalno9SjHM1WO95dN9BYNj
 u7fCEVkBFX3nHN0PquB+lcD58Jm1gYDLpoDNGMYq1LLVAHPiIdiGIiMJ+E4Hy7oKpS8h
 4zu2ZSPOz+9iHz2n09HeoO+mQdTHHVfLpf73qrv1EyLKQ8auPqTcUIOBj25h7YkkK9TH
 sXxRqDzYbSfO4teGjZ46Vg2Dj5U1n/XZzJ6TOgyPEn2A1L1U0WcDNfRBfGWTyUQChhrI
 uR9w==
X-Gm-Message-State: AFuF++k13xq0SccDpwHfUWefKlbTaEpS86t6ESn2VVY0xxcnwQEgC1CI
 Wrkph5vNzlv8qP1py2vZnZXUzvpuZLD+v25+ggt7MAC6tHipoS++FSh8lOGKLQ==
X-Gm-Gg: AR+sD12NbArF6uD9pCaz4+pDkLOIqlV8LQ9Q35/Mn8+Y7Rl+zzKy3q81xirTXaKAVT/
 pWY4vi9730okh+tJAPKVKbO7wsn7h31SXdKjvD8Yute7rY3FRJJErdrBn7wVfRfJ0BmBktOkGS4
 bCcJ6EQJLm/3/gNdRIh77bpI57r+1DNq1X+FRm3UHJG7oMIL00myBPilfQXQ+J6J1uVa4qut16d
 AzcC+VjIhP3ZMGEjV3fYJLLGL3DLYTIApLR+hWmKxh4ezRnBw/E8m7ku+mKnqj9H4pmiTMVY2KW
 X8Fx3sKsbgcOTAebcZRf5D/BOBV29/b7C4yeeZ2rbvBuc9cUb8y52UalEj87uMsCTHwidMqsJUT
 tztajB3Wud6OwlR/bOLSUpOZwiS5P9BF7kLxMvS4Eo7HXxKxpepeR+QERUQtqbeTmN321jLEunN
 bQ3AbH6SznqX+SxOYwMxuDi2t5cG+nUEemleEf/7T7igGu8NnSIjh54yuucbnY9bukrdnad/epR
 XZTtZvorgYi4eB2
X-Received: by 2002:a17:90b:53c3:b0:38e:5c6:4db9 with SMTP id
 98e67ed59e1d1-395c39cbc42mr43635485a91.11.1787550653842; 
 Sun, 23 Aug 2026 22:50:53 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:50:53 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 50/96] disas/riscv: Handle c.slli imm != 0 during decode
Date: Mon, 24 Aug 2026 15:47:20 +1000
Message-ID: <20260824054806.2790041-51-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x535.google.com
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


