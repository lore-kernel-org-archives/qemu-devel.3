Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECD9C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 02:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUGbl-0005wg-Mb; Wed, 17 Jul 2024 22:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGbj-0005or-Ps
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:10:59 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGbi-0003Qd-0R
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:10:59 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fc5549788eso2955125ad.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 19:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721268656; x=1721873456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mpi5fzkajuLIxq+xc/MjDRsGYOnn0Yt14lPOvh9/gK8=;
 b=RUlpg6wsjS9cIhBqOBv6F3vy8kFKwMNPYV85oujZsoQLhXd+J0UzgTyxxEOc29qJIL
 9epAKF6dE6YDaXrIczWxLKcMyyMf5kOQmoClZ9O14hH1O+vDTwB6Ao3qu+HMs5zGvuHg
 wZilWeOv7ImaU+b3bWSNJ2Q6FYba9+C/344dINIpcyFTsLKBnsZfA3biSTuEPp3lWZ1d
 5l88r2n+RZKi8KJcRTCz5s3DNf9n3KRKaCmCvSyazCiUk3/2bfY/D0MErwH9+5mGy0sJ
 WSocX9JJylqPtwzIpEBdK66HCC1uRxR9w0ES2AL2KM5/5WAlSxgnn+dXbl3H0dXnFVSp
 uMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721268656; x=1721873456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mpi5fzkajuLIxq+xc/MjDRsGYOnn0Yt14lPOvh9/gK8=;
 b=L+4o5xoVQnFKd/jCU23gvGLs4LHusz2W11P9y3djh/qaXhpKPkYN5t7OfsGuSj2Cwg
 Eqx75nsuP3+st+1UIDQBm1myh/xvbsRESjoVFeQMupzmZ3ZfMMcIvjlOYJmcIeHiCu2I
 xU+L7WI8Szp/n/z+AA2+r7xkk+kQRv/HtCZCqPNDxCMgMcd0IDe5gB0kapXTti76oaaV
 JDrymwAh9rLhiptt8535siH741UTr/QjDErP1M5HSjPRs/I1YZPISvk5jwz8/3mCrYYy
 Lk2uhlZsxxAmrnlfHZVnonxNZvusklEJ0Imz/0myDPg6YF+NtyHHDIHI4K6qaXZvUWpi
 Uqig==
X-Gm-Message-State: AOJu0YzaPeigUs8LCZ0vOuamnUl/n1sP3sRAb2bGukKlkdlSYLvHeBti
 Mk5lmviCKE5EVBoVNrtg/GtvRCUf0fcbsvOx2QfCnPRm1HjoLK/suYQC67X7
X-Google-Smtp-Source: AGHT+IF5C1mtYXxywScJQKYKUVMOcxwAlnBJnJJaim+gdhedoSJe6W5tn3qe4goLuFjC9zCOXSWO3g==
X-Received: by 2002:a17:902:c412:b0:1fa:9c04:946a with SMTP id
 d9443c01a7336-1fc4e105abemr33805055ad.1.1721268656422; 
 Wed, 17 Jul 2024 19:10:56 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bba949bsm81999385ad.69.2024.07.17.19.10.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 19:10:55 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 11/30] disas/riscv: Support zabha disassemble
Date: Thu, 18 Jul 2024 12:09:53 +1000
Message-ID: <20240718021012.2057986-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718021012.2057986-1-alistair.francis@wdc.com>
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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
Message-ID: <20240709113652.1239-12-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/disas/riscv.c b/disas/riscv.c
index d29cb1ff7d..c8364c2b07 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -954,6 +954,26 @@ typedef enum {
     rv_c_mop_11    = 923,
     rv_c_mop_13    = 924,
     rv_c_mop_15    = 925,
+    rv_op_amoswap_b = 926,
+    rv_op_amoadd_b  = 927,
+    rv_op_amoxor_b  = 928,
+    rv_op_amoor_b   = 929,
+    rv_op_amoand_b  = 930,
+    rv_op_amomin_b  = 931,
+    rv_op_amomax_b  = 932,
+    rv_op_amominu_b = 933,
+    rv_op_amomaxu_b = 934,
+    rv_op_amoswap_h = 935,
+    rv_op_amoadd_h  = 936,
+    rv_op_amoxor_h  = 937,
+    rv_op_amoor_h   = 938,
+    rv_op_amoand_h  = 939,
+    rv_op_amomin_h  = 940,
+    rv_op_amomax_h  = 941,
+    rv_op_amominu_h = 942,
+    rv_op_amomaxu_h = 943,
+    rv_op_amocas_b  = 944,
+    rv_op_amocas_h  = 945,
 } rv_op;
 
 /* register names */
@@ -2192,6 +2212,26 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "c.mop.11", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
     { "c.mop.13", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
     { "c.mop.15", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
+    { "amoswap.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amoadd.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amoxor.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amoor.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amoand.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amomin.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amomax.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amominu.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amomaxu.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amoswap.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amoadd.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amoxor.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amoor.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amoand.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amomin.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amomax.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amominu.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amomaxu.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amocas.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amocas.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -2986,9 +3026,13 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
         case 11:
             switch (((inst >> 24) & 0b11111000) |
                     ((inst >> 12) & 0b00000111)) {
+            case 0: op = rv_op_amoadd_b; break;
+            case 1: op = rv_op_amoadd_h; break;
             case 2: op = rv_op_amoadd_w; break;
             case 3: op = rv_op_amoadd_d; break;
             case 4: op = rv_op_amoadd_q; break;
+            case 8: op = rv_op_amoswap_b; break;
+            case 9: op = rv_op_amoswap_h; break;
             case 10: op = rv_op_amoswap_w; break;
             case 11: op = rv_op_amoswap_d; break;
             case 12: op = rv_op_amoswap_q; break;
@@ -3010,27 +3054,43 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 26: op = rv_op_sc_w; break;
             case 27: op = rv_op_sc_d; break;
             case 28: op = rv_op_sc_q; break;
+            case 32: op = rv_op_amoxor_b; break;
+            case 33: op = rv_op_amoxor_h; break;
             case 34: op = rv_op_amoxor_w; break;
             case 35: op = rv_op_amoxor_d; break;
             case 36: op = rv_op_amoxor_q; break;
+            case 40: op = rv_op_amocas_b; break;
+            case 41: op = rv_op_amocas_h; break;
             case 42: op = rv_op_amocas_w; break;
             case 43: op = rv_op_amocas_d; break;
             case 44: op = rv_op_amocas_q; break;
+            case 64: op = rv_op_amoor_b; break;
+            case 65: op = rv_op_amoor_h; break;
             case 66: op = rv_op_amoor_w; break;
             case 67: op = rv_op_amoor_d; break;
             case 68: op = rv_op_amoor_q; break;
+            case 96: op = rv_op_amoand_b; break;
+            case 97: op = rv_op_amoand_h; break;
             case 98: op = rv_op_amoand_w; break;
             case 99: op = rv_op_amoand_d; break;
             case 100: op = rv_op_amoand_q; break;
+            case 128: op = rv_op_amomin_b; break;
+            case 129: op = rv_op_amomin_h; break;
             case 130: op = rv_op_amomin_w; break;
             case 131: op = rv_op_amomin_d; break;
             case 132: op = rv_op_amomin_q; break;
+            case 160: op = rv_op_amomax_b; break;
+            case 161: op = rv_op_amomax_h; break;
             case 162: op = rv_op_amomax_w; break;
             case 163: op = rv_op_amomax_d; break;
             case 164: op = rv_op_amomax_q; break;
+            case 192: op = rv_op_amominu_b; break;
+            case 193: op = rv_op_amominu_h; break;
             case 194: op = rv_op_amominu_w; break;
             case 195: op = rv_op_amominu_d; break;
             case 196: op = rv_op_amominu_q; break;
+            case 224: op = rv_op_amomaxu_b; break;
+            case 225: op = rv_op_amomaxu_h; break;
             case 226: op = rv_op_amomaxu_w; break;
             case 227: op = rv_op_amomaxu_d; break;
             case 228: op = rv_op_amomaxu_q; break;
-- 
2.45.2


