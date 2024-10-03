Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F13CF34BE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 18:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swQet-0007Xx-S0; Thu, 03 Oct 2024 14:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1swQeW-0007Gq-2W
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:34:19 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1swQeU-00056x-2Y
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:34:15 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-208cf673b8dso13430425ad.3
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 11:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727980451; x=1728585251;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3TSRZRYfN0fde9td8T2Zgyxq8CzAPhtR30l69z8A4EM=;
 b=2XoE+nBsiMnfxuAa6AhmJOsbrff4Hq/QloVvpvlbYukmXdZWUJBVkVafKpS1uBvbjw
 p6qdXTPEzAy/WXrfMRbJE+NsHsQS5rufbti9i0mnxPWOrkP5B5lMiYXuqOaS1kzjLxSI
 hbcf5P/pkwsLG3KoHtL0A92bZqbCj6na5oYlWYion1Y/NkeWHo6NJTgk/Z44lGhu3cVA
 UhGBz/EWwO9YujQ/GNlIlfRE2OZuKWcAjn3Gpgr4i2uJBqpRD7UBQmsq1Zx+wDZaRGPp
 dHSpsXfOt2HUs4VJ4H8JtmlLLJFhgXBBSKiI2ade0vR0bS2tg/QvZQDrk6+CBA1ELljt
 VFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727980451; x=1728585251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3TSRZRYfN0fde9td8T2Zgyxq8CzAPhtR30l69z8A4EM=;
 b=UKCoOziq5aPWv3N47B/BpMvX6C1pnaJwvP5+zfvzAFFo6Vp0r2OlgZ7VOZE46gEfKR
 DbeXRMivEkq7D5XmI8hUIcOUqdxJFfRXCGQ2KntWfekKZE9YXllTjNDOQFrjkX8OVGXj
 VlIXE8sdD1a5/AEumyh8Y/qDc0z+Inc6lTG7WRAyEsJ6dJ0pH3AUB/HMif63TyuyTIiX
 gk08fMyViq7tSaTKW67wES+0VQgO6tX9yWB+snA/BHGJ/O0W59wStqixRYA0nOdT/3d/
 yFYl6kT3/vZsBj867uKj6+6TOmFqZ8657+KlD231fgBJ1ZftcZEn3gE1MNWcUkQ0I6lg
 MlVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyzRvebr9rsMAbftD2wjBrewk/xB3QZN1OVCrrpQXyyd2d9olwVUPi/rSO4e1hT5tWwmpG/gkUyZ8F@nongnu.org
X-Gm-Message-State: AOJu0YwkKET8L3Om7x8u5SK00x3B/R4P5m249Zm6RfZs7tjhtRqq1e1S
 tmLoNKuU7F2aP36S9xTyB82cvtShiSDb4E8pXnMUMo50XOEP1KP/GsNuda7S/T4=
X-Google-Smtp-Source: AGHT+IHrr1IN+1Nh7BLepB3GNGfOl5yT4WCcN8mB1SH6hfKXIPGaH/jPIFFNMnyq+pTUhfuwoPF+dQ==
X-Received: by 2002:a17:902:ec82:b0:20b:fbcf:f941 with SMTP id
 d9443c01a7336-20bff039359mr1234625ad.47.1727980450742; 
 Thu, 03 Oct 2024 11:34:10 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20beefad16asm11796245ad.193.2024.10.03.11.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 11:34:10 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v15 19/21] disas/riscv: enable disassembly for zicfiss
 instructions
Date: Thu,  3 Oct 2024 11:33:40 -0700
Message-ID: <20241003183342.679249-20-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241003183342.679249-1-debug@rivosinc.com>
References: <20241003183342.679249-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Enable disassembly for sspush, sspopchk, ssrdp & ssamoswap.
Disasembly is only enabled if zimop and zicfiss ext is set to true.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 40 +++++++++++++++++++++++++++++++++++++++-
 disas/riscv.h |  1 +
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 2942a5800f..0f9ecd8a14 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -977,6 +977,11 @@ typedef enum {
     rv_op_wrs_sto = 946,
     rv_op_wrs_nto = 947,
     rv_op_lpad = 948,
+    rv_op_sspush = 949,
+    rv_op_sspopchk = 950,
+    rv_op_ssrdp = 951,
+    rv_op_ssamoswap_w = 952,
+    rv_op_ssamoswap_d = 953,
 } rv_op;
 
 /* register names */
@@ -2238,6 +2243,11 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "wrs.sto", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0 },
     { "wrs.nto", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0 },
     { "lpad", rv_codec_lp, rv_fmt_imm, NULL, 0, 0, 0 },
+    { "sspush", rv_codec_r, rv_fmt_rs2, NULL, 0, 0, 0 },
+    { "sspopchk", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
+    { "ssrdp", rv_codec_r, rv_fmt_rd, NULL, 0, 0, 0 },
+    { "ssamoswap.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "ssamoswap.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -2255,6 +2265,7 @@ static const char *csr_name(int csrno)
     case 0x0009: return "vxsat";
     case 0x000a: return "vxrm";
     case 0x000f: return "vcsr";
+    case 0x0011: return "ssp";
     case 0x0015: return "seed";
     case 0x0017: return "jvt";
     case 0x0040: return "uscratch";
@@ -3081,6 +3092,8 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 66: op = rv_op_amoor_w; break;
             case 67: op = rv_op_amoor_d; break;
             case 68: op = rv_op_amoor_q; break;
+            case 74: op = rv_op_ssamoswap_w; break;
+            case 75: op = rv_op_ssamoswap_d; break;
             case 96: op = rv_op_amoand_b; break;
             case 97: op = rv_op_amoand_h; break;
             case 98: op = rv_op_amoand_w; break;
@@ -4034,7 +4047,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 3: op = rv_op_csrrc; break;
             case 4:
                 if (dec->cfg->ext_zimop) {
-                    int imm_mop5, imm_mop3;
+                    int imm_mop5, imm_mop3, reg_num;
                     if ((extract32(inst, 22, 10) & 0b1011001111)
                         == 0b1000000111) {
                         imm_mop5 = deposit32(deposit32(extract32(inst, 20, 2),
@@ -4042,11 +4055,36 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                                                        extract32(inst, 26, 2)),
                                              4, 1, extract32(inst, 30, 1));
                         op = rv_mop_r_0 + imm_mop5;
+                        /* if zicfiss enabled and mop5 is shadow stack */
+                        if (dec->cfg->ext_zicfiss &&
+                            ((imm_mop5 & 0b11100) == 0b11100)) {
+                                /* rs1=0 means ssrdp */
+                                if ((inst & (0b011111 << 15)) == 0) {
+                                    op = rv_op_ssrdp;
+                                }
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
2.45.0


