Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE8FC3DA63
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 02:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUGbO-00058Y-Mn; Wed, 17 Jul 2024 22:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGbL-00050z-Se
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:10:35 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGbJ-0003Kn-AQ
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:10:35 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fb3cf78ff3so3045925ad.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 19:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721268631; x=1721873431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UMNx1WUxJIrc+DjxZZ+deqYjb0Rm41drdRBC2LVTxI8=;
 b=AqIsgLvJoa2XEy6SwUPp7irUyW3lRbM0VhRZAPCurtqwK7DT6iH6PZxUn5rhb3e8fg
 VAVFBpOgfVIWLa5JqBKYqsYN9isVM3u2zyMTWzfI8e7krGPu4bm6WBwGqF1i+xxS5EZF
 +OCSQTP9cquWdLvBnB3f6ijq6oT8FvcJwzeKqFnM4hqjd46wGbKpKaq2IgIoIt3fYkPG
 /NZenLlHWNLJF6wGl4HyuZjNQ8Eq7B4BrQ7zfrwrVa5gwJ/GPWzj80wz2C5jhPKlvpf1
 A0z/EIiCeKKxMqN1uFQu9Gbb7UL1V3CQZ3rS4HplLJaUhpUzYRBzPgQKUEXF9DeeIBW1
 m9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721268631; x=1721873431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UMNx1WUxJIrc+DjxZZ+deqYjb0Rm41drdRBC2LVTxI8=;
 b=wr3awmDJLQK4HhYvzUtV7GZl2sQFmuRABmkO8ZVaDmEuGZCk1JVVtwfvVnUbQIS0TE
 x8wj9hUUPX2KrXnCfPkloMT7nbR2BkDCi52TgbkH2uqrK+LZATJz44F56Mz9XJUAYcWK
 fT30Rz/wh/UUH2sw/fJ94cboIY0bD0/2hrDmPBy0M//U2InNrVDBGSP0VPR+cIS7sWaU
 keagLSVSVpQ1JUrpuXb+wTUV4y7Qd5Pyisb+fHCCpmF8xEioZcmEzmwWJU6Z6fbfzi3a
 v0ikNoTABXB2vH1Zjj/tI5vYGu5q2gzMw4ChQICPsDoMZrNh8nD6C0x1JTFqOyUu//yn
 paMQ==
X-Gm-Message-State: AOJu0YxQdM6qg8T/TJwyGfKhqorAWeXyhtc8wgzALF+64PUf3FH2XOOs
 yItCUhvyyqOffHX1LbsQnvM6lFLs6p3xrXYjo9YQ2McQxMwkkwcps+TZwWaW
X-Google-Smtp-Source: AGHT+IGvnp9hJB7mYYL1IjHiullWHfFs6PQsnZqWqleFFUgkudIE+Mrlsvwmcs1V4zYCs1cB+y469g==
X-Received: by 2002:a17:903:40c3:b0:1fc:5eac:9873 with SMTP id
 d9443c01a7336-1fc5eac99e4mr6029555ad.30.1721268631022; 
 Wed, 17 Jul 2024 19:10:31 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bba949bsm81999385ad.69.2024.07.17.19.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 19:10:30 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Deepak Gupta <debug@rivosinc.com>
Subject: [PULL 02/30] disas/riscv: Support zimop disassemble
Date: Thu, 18 Jul 2024 12:09:44 +1000
Message-ID: <20240718021012.2057986-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718021012.2057986-1-alistair.francis@wdc.com>
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
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

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Deepak Gupta <debug@rivosinc.com>
Message-ID: <20240709113652.1239-3-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/disas/riscv.c b/disas/riscv.c
index 90d6b26de9..0b82ab2322 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -906,6 +906,46 @@ typedef enum {
     rv_op_amocas_w = 875,
     rv_op_amocas_d = 876,
     rv_op_amocas_q = 877,
+    rv_mop_r_0     = 878,
+    rv_mop_r_1     = 879,
+    rv_mop_r_2     = 880,
+    rv_mop_r_3     = 881,
+    rv_mop_r_4     = 882,
+    rv_mop_r_5     = 883,
+    rv_mop_r_6     = 884,
+    rv_mop_r_7     = 885,
+    rv_mop_r_8     = 886,
+    rv_mop_r_9     = 887,
+    rv_mop_r_10    = 888,
+    rv_mop_r_11    = 889,
+    rv_mop_r_12    = 890,
+    rv_mop_r_13    = 891,
+    rv_mop_r_14    = 892,
+    rv_mop_r_15    = 893,
+    rv_mop_r_16    = 894,
+    rv_mop_r_17    = 895,
+    rv_mop_r_18    = 896,
+    rv_mop_r_19    = 897,
+    rv_mop_r_20    = 898,
+    rv_mop_r_21    = 899,
+    rv_mop_r_22    = 900,
+    rv_mop_r_23    = 901,
+    rv_mop_r_24    = 902,
+    rv_mop_r_25    = 903,
+    rv_mop_r_26    = 904,
+    rv_mop_r_27    = 905,
+    rv_mop_r_28    = 906,
+    rv_mop_r_29    = 907,
+    rv_mop_r_30    = 908,
+    rv_mop_r_31    = 909,
+    rv_mop_rr_0    = 910,
+    rv_mop_rr_1    = 911,
+    rv_mop_rr_2    = 912,
+    rv_mop_rr_3    = 913,
+    rv_mop_rr_4    = 914,
+    rv_mop_rr_5    = 915,
+    rv_mop_rr_6    = 916,
+    rv_mop_rr_7    = 917,
 } rv_op;
 
 /* register names */
@@ -2096,6 +2136,46 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "amocas.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
     { "amocas.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
     { "amocas.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "mop.r.0", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.1", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.2", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.3", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.4", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.5", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.6", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.7", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.8", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.9", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.10", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.11", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.12", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.13", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.14", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.15", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.16", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.17", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.18", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.19", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.20", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.21", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.22", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.23", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.24", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.25", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.26", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.27", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.28", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.29", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.30", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.31", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.rr.0", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
+    { "mop.rr.1", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
+    { "mop.rr.2", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
+    { "mop.rr.3", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
+    { "mop.rr.4", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
+    { "mop.rr.5", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
+    { "mop.rr.6", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
+    { "mop.rr.7", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -3855,6 +3935,24 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 1: op = rv_op_csrrw; break;
             case 2: op = rv_op_csrrs; break;
             case 3: op = rv_op_csrrc; break;
+            case 4:
+                if (dec->cfg->ext_zimop) {
+                    int imm_mop5, imm_mop3;
+                    if ((extract32(inst, 22, 10) & 0b1011001111)
+                        == 0b1000000111) {
+                        imm_mop5 = deposit32(deposit32(extract32(inst, 20, 2),
+                                                       2, 2,
+                                                       extract32(inst, 26, 2)),
+                                             4, 1, extract32(inst, 30, 1));
+                        op = rv_mop_r_0 + imm_mop5;
+                    } else if ((extract32(inst, 25, 7) & 0b1011001)
+                               == 0b1000001) {
+                        imm_mop3 = deposit32(extract32(inst, 26, 2),
+                                             2, 1, extract32(inst, 30, 1));
+                        op = rv_mop_rr_0 + imm_mop3;
+                    }
+                }
+                break;
             case 5: op = rv_op_csrrwi; break;
             case 6: op = rv_op_csrrsi; break;
             case 7: op = rv_op_csrrci; break;
-- 
2.45.2


