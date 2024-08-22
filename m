Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59C1C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 08:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh38O-0005jp-Sx; Thu, 22 Aug 2024 04:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sh38N-0005fj-UZ
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 04:25:31 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sh38I-00061P-Pf
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 04:25:31 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fc47abc040so4604395ad.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 01:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724315125; x=1724919925;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xugLMS7bIcHjucROSt6zPCraajq6ySsaBiEybklJnW0=;
 b=3EOo3MSbEJ9ql0Jc8fbZn3NnhZ6+UkovFVeSGM2m4U2NKrpgoQUxbmG0tpLmTdzO2q
 Cs+eXYah0AO99EvTJw++CST7cvnoVd0t7iNVJtIgi7hJijWaAq1qwFjcXt9W4GN/qFnf
 OlO4OdKIWEGadSxhtdaZLKpDf1E6oLhxe2Iriif1BN382oE8lKbtdg7rlWS1kfys90VD
 ynlzK203kmpvV+vvgY7NY5dmMPutX5NXLscHQI97y33+oDhGEEqdxCZls5hn6govgTBZ
 JmMLyirBvEQ5VMAoqpDgz4NNV8rhjj4SfWTrdTVNbANv8KcUXzxoDZXeczY627UmqnoE
 IQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724315125; x=1724919925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xugLMS7bIcHjucROSt6zPCraajq6ySsaBiEybklJnW0=;
 b=LB49Uv0k7EsoAENo5X3aJzeAdNSK1o45rYu5nSuT2CGk7KuqDVB7hDAGMqrfYVaOxn
 ygJv4FlrwSNmbd9Bge1zG1puKROR7ZhqxKfkZ0Fj5hwO4QwZrrvxHowWUlHuXrKceg8U
 eJjtNKN1hIF2lRPjByOrRu+DJt061tEVceU8AcwOH9RhiOmr+GiO1EtuVfO4yZIRBFPi
 Xp3HHYTbAasTZ3F/70s/ilvDlRawt0TPR+fnTPTHybbEXFt3CW0vJSvP+WGZ8yTtuBcu
 5Q57mKUUsx+1bZQjmargYUlNF7uZX0cTe7bkmQfC06pHEs6q6zMKK+LyUXmucDHypu1t
 qHng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKqjoWYQGLDci7r0qh7QPVAww2ojeAuVRP2BzR3k144Kb8caZ7LQyYbxapBDm9Flms3CPXOdHnLapm@nongnu.org
X-Gm-Message-State: AOJu0YyOCdH9VFEkkaciCcrppKpRSPdwNS8mE5x/dLog7CbkpjTO4KBM
 CYpe5E7YmHk5iqWXoZ4Xve2cUIroqRug05YK57skqRORSm0sZEPeYZA5MTe1YfY=
X-Google-Smtp-Source: AGHT+IGXsYRMz9xg5DQa+HNwx1pl8ssbPPMdlRvbK12P+U7/26DkpLeiFEyKmgvx/H+CLzME3fqmHQ==
X-Received: by 2002:a17:902:e850:b0:1f9:fc92:1b65 with SMTP id
 d9443c01a7336-20367af1bf7mr59389505ad.9.1724315125092; 
 Thu, 22 Aug 2024 01:25:25 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20385589225sm7641295ad.115.2024.08.22.01.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 01:25:24 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v7 16/17] disas/riscv: enable disassembly for zicfiss
 instructions
Date: Thu, 22 Aug 2024 01:25:02 -0700
Message-ID: <20240822082504.3979610-17-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240822082504.3979610-1-debug@rivosinc.com>
References: <20240822082504.3979610-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Enable disassembly for sspush, sspopchk, ssrdp & ssamoswap.
Disasembly is only enabled if zimop and zicfiss ext is set to true.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 disas/riscv.c | 40 +++++++++++++++++++++++++++++++++++++++-
 disas/riscv.h |  1 +
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index c7c92acef7..f1f4ffc50a 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -975,6 +975,11 @@ typedef enum {
     rv_op_amocas_b  = 944,
     rv_op_amocas_h  = 945,
     rv_op_lpad = 946,
+    rv_op_sspush = 947,
+    rv_op_sspopchk = 948,
+    rv_op_ssrdp = 949,
+    rv_op_ssamoswap_w = 950,
+    rv_op_ssamoswap_d = 951,
 } rv_op;
 
 /* register names */
@@ -2234,6 +2239,11 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "amocas.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
     { "amocas.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
     { "lpad", rv_codec_lp, rv_fmt_imm, NULL, 0, 0, 0 },
+    { "sspush", rv_codec_r, rv_fmt_rs2, NULL, 0, 0, 0 },
+    { "sspopchk", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
+    { "ssrdp", rv_codec_r, rv_fmt_rd, NULL, 0, 0, 0 },
+    { "ssamoswap.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "ssamoswap.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -2251,6 +2261,7 @@ static const char *csr_name(int csrno)
     case 0x0009: return "vxsat";
     case 0x000a: return "vxrm";
     case 0x000f: return "vcsr";
+    case 0x0011: return "ssp";
     case 0x0015: return "seed";
     case 0x0017: return "jvt";
     case 0x0040: return "uscratch";
@@ -3077,6 +3088,8 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 66: op = rv_op_amoor_w; break;
             case 67: op = rv_op_amoor_d; break;
             case 68: op = rv_op_amoor_q; break;
+            case 74: op = rv_op_ssamoswap_w; break;
+            case 75: op = rv_op_ssamoswap_d; break;
             case 96: op = rv_op_amoand_b; break;
             case 97: op = rv_op_amoand_h; break;
             case 98: op = rv_op_amoand_w; break;
@@ -4028,7 +4041,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 3: op = rv_op_csrrc; break;
             case 4:
                 if (dec->cfg->ext_zimop) {
-                    int imm_mop5, imm_mop3;
+                    int imm_mop5, imm_mop3, reg_num;
                     if ((extract32(inst, 22, 10) & 0b1011001111)
                         == 0b1000000111) {
                         imm_mop5 = deposit32(deposit32(extract32(inst, 20, 2),
@@ -4036,11 +4049,36 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                                                        extract32(inst, 26, 2)),
                                              4, 1, extract32(inst, 30, 1));
                         op = rv_mop_r_0 + imm_mop5;
+                        /* if zicfiss enabled and mop5 is shadow stack */
+                        if (dec->cfg->ext_zicfiss &&
+                            ((imm_mop5 & 0b11100) == 0b11100)) {
+                                /* rs1=0 means ssrdp */
+                                if ((inst & (0b011111 << 15)) == 0) {
+                                    op = rv_op_ssrdp;
+                                    }
+                                /* rd=0 means sspopchk */
+                                reg_num = (inst >> 15) & 0b011111;
+                                if (((inst & (0b011111 << 7)) == 0) &&
+                                    ((reg_num == 1) || (reg_num == 5))) {
+                                    op = rv_op_sspopchk;
+                                }
+                        }
                     } else if ((extract32(inst, 25, 7) & 0b1011001)
                                == 0b1000001) {
                         imm_mop3 = deposit32(extract32(inst, 26, 2),
                                              2, 1, extract32(inst, 30, 1));
                         op = rv_mop_rr_0 + imm_mop3;
+                        /* if zicfiss enabled and mop3 is shadow stack */
+                        if (dec->cfg->ext_zicfiss &&
+                            ((imm_mop3 & 0b111) == 0b111)) {
+                                /* rs1=0 and rd=0 means sspush */
+                                reg_num = (inst >> 20) & 0b011111;
+                                if (((inst & (0b011111 << 15)) == 0) &&
+                                    ((inst & (0b011111 << 7)) == 0) &&
+                                    ((reg_num == 1) || (reg_num == 5))) {
+                                    op = rv_op_sspush;
+                                }
+                        }
                     }
                 }
                 break;
diff --git a/disas/riscv.h b/disas/riscv.h
index 1182457aff..4895c5a301 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -224,6 +224,7 @@ enum {
 
 #define rv_fmt_none                   "O\t"
 #define rv_fmt_rs1                    "O\t1"
+#define rv_fmt_rs2                    "O\t2"
 #define rv_fmt_offset                 "O\to"
 #define rv_fmt_pred_succ              "O\tp,s"
 #define rv_fmt_rs1_rs2                "O\t1,2"
-- 
2.44.0


