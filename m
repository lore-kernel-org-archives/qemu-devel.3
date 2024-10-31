Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A96E68953
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MHV-0002np-Sy; Wed, 30 Oct 2024 23:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MHC-00023E-Kq
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:55:17 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MHA-0004DM-Vb
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:55:14 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7db238d07b3so446047a12.2
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346911; x=1730951711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IpbmVYRsQHTshVOLheV2H2hr8xzumFDJSdvIQ9aBZ9o=;
 b=DkUUxqHNVjv1Zaqfvn7mbKY2XVCPpLVXq6i/IhrYfqA6fckN3SArNYHljwVGo7Kkos
 ZFKTyNucaQO3c4Yhj+GHNdX8jVtfJkv5KMtVcPwAg+2anNI/5LNh3DnJlrpvCYxGMHSr
 HgOy8RleM5zYgmxEQW5pPX8kQH7WE5Tsp+k5l+BmYhbCL4XK73rzSXjxXaT7tsGtlZiN
 8/icqirLj/jU0aegqRfp4BcHeYetHsajky05MyyfspMEBsGfLtiOecJbSxV8cQpaKQEh
 p0OOWmZ+qXwe5/8umPqHlZFYNss4ykbgJbaO1zLFyiE8fLofSdjvxksGkJU3A0oPdNXG
 hWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346911; x=1730951711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IpbmVYRsQHTshVOLheV2H2hr8xzumFDJSdvIQ9aBZ9o=;
 b=obKdz621Dnwdo4ZGyQrkdmRovKyXpS2GDt3lZjjBx1vJ2dJpj1vqdWlY82g5xWZsSg
 IXrcaeFHlZGANLiAQEaDRg+wnrWqKViwfR7Vqa58OHBOBWUdb33BYbOaZOuf7XEZj48t
 Bd0tQgmh3r204nEDLf+5nAcqfucXeRPJ6KdQJmK2sLyzfrOi9GbolH8lgDxCRPK71fCg
 WKXxjMncplxZJnIY3SL687A5o+0uOgGM+RSmbRI/RMZVkedR5C+SsDgGy2yatxx0gafy
 6DsCnAfMCy+WlNRy+FhaoJ6QPHiWJetqja9F5y+q9YZPz1XUFRAF/BV7phrMImA2U5Pi
 mJQw==
X-Gm-Message-State: AOJu0YzmjhBjH2BszsdeIfofSQ1W4lDxSro37Lkrr03DBSVzoVdrVNgX
 nuFKeK+XvsDtXm9McRAB/QyM/jKhYkLmHWA7oMGXAETxUrjC5ZDl5qUDB13l
X-Google-Smtp-Source: AGHT+IHMYDQXTehQaYm+DBMLjuInHndOheuIfOJn+XB370WWchnMLHPCBU5JsoSnO5mcb4nWvkeVGg==
X-Received: by 2002:a05:6a21:e90:b0:1d9:de8:f355 with SMTP id
 adf61e73a8af0-1d9a83cdd71mr21815543637.14.1730346911233; 
 Wed, 30 Oct 2024 20:55:11 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.55.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:55:10 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Deepak Gupta <debug@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 33/50] disas/riscv: enable disassembly for zicfiss instructions
Date: Thu, 31 Oct 2024 13:53:01 +1000
Message-ID: <20241031035319.731906-34-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
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

From: Deepak Gupta <debug@rivosinc.com>

Enable disassembly for sspush, sspopchk, ssrdp & ssamoswap.
Disasembly is only enabled if zimop and zicfiss ext is set to true.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241008225010.1861630-19-debug@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.h |  1 +
 disas/riscv.c | 40 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index ae78352e38..e197f5d435 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -224,6 +224,7 @@ enum {
 
 #define rv_fmt_none                   "O\t"
 #define rv_fmt_rs1                    "O\t1"
+#define rv_fmt_rs2                    "O\t2"
 #define rv_fmt_offset                 "O\to"
 #define rv_fmt_pred_succ              "O\tp,s"
 #define rv_fmt_rs1_rs2                "O\t1,2"
diff --git a/disas/riscv.c b/disas/riscv.c
index 513225129c..1f0eb66d01 100644
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
-- 
2.47.0


