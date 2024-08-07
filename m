Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F6AC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 00:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbUE1-0007G7-TW; Tue, 06 Aug 2024 20:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbUD2-0002x9-RC
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:07:21 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbUCz-0001DP-4k
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:07:20 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fec34f94abso11913145ad.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 17:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722989236; x=1723594036;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bfd/g3qnKmKlalH95hAzpJLDLKpqsukOO1ZJ1hRrjxo=;
 b=Fvz8VuSViBTYj2NPA/snQ1CePrIpJyIPDD6UIfxcpUibRTCC8SD3z+GFD0JyZswRT6
 URPYhjIQxYy3jSu/Y0wNQXYezOnuZDuKZgrj0lQNNPs0vIhW5iy5BD9n3boCsMIycOGz
 AJBWP/Ro02oa/tEEu5OBgeOO0+HiCa/SeDuJvgPxvDFZQVZqEf974cnuYKsJOmkU+Z94
 36s+Tv9XTTHSjHDUlnoPffYJcwRVSk8qOYRp9WpeZ/GPHDSU0qSvV3pvXomfkcS24yKZ
 ydoyXIKDf9zhODCTxXKAWQlN2tCplB90JJb6tgKGUIJ9PdTyZJft8g3HDR1fXdz3qMOL
 P1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722989236; x=1723594036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bfd/g3qnKmKlalH95hAzpJLDLKpqsukOO1ZJ1hRrjxo=;
 b=AcBZYwBM8CfK8S1fPaKXGGaPp2LMkd7VVcJACasLn1zFjhXo7R941BCfodOS7qbeGW
 6HG++NW5M4t90dSec5JbHRDjuYMqby3jijzM9TFLmJHfLu/TB5afD7GIzRP2WH14+hs1
 0kHE6/d2iGxZeAQBPrpqEm2QR+PurkqHbVA7vpH3ikHclUr2hI2X/z+BtpW+3AoYEslH
 EAXTf6eBkVucJgKFvcBKDsBig4sggx4MyczMBBN4rEN9CLzEwnCteR5lqHg6j29eMKZj
 ouAE6XL+GJGCWTRDK0RWj9Ww/8RyQWIS5blw1vp2U5VUs6s6x3huX50cH0ZwQnnUTHKH
 pn3A==
X-Gm-Message-State: AOJu0Yy1E+FVJxC4r9NCmK4wBLy2+3zpyo8ZAEUemBy4wnzT4GVBNLwN
 WHTFNfdcZnHzL8OC5F6mywcN9Jf5xNu9TMLLe1at1PNwjBzCgkZV4egBdT84rY0yOrBb/3kFK7N
 k
X-Google-Smtp-Source: AGHT+IHvQtwhYrt5pVXwKp3c2lKdaGUTW8QdDSecmHAFvamcIkeADsy+nOoZmfUcuDYDWqWkCdUiGw==
X-Received: by 2002:a17:903:24c:b0:1fb:35c7:8eb2 with SMTP id
 d9443c01a7336-1ff5747ef12mr149537665ad.55.1722989235556; 
 Tue, 06 Aug 2024 17:07:15 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f59cc2sm93381845ad.92.2024.08.06.17.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 17:07:15 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v3 16/20] disas/riscv: enable disassembly for zicfiss
 instructions
Date: Tue,  6 Aug 2024 17:06:47 -0700
Message-ID: <20240807000652.1417776-17-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240807000652.1417776-1-debug@rivosinc.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x636.google.com
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
---
 disas/riscv.c | 34 ++++++++++++++++++++++++++++++++++
 disas/riscv.h |  1 +
 2 files changed, 35 insertions(+)

diff --git a/disas/riscv.c b/disas/riscv.c
index c7c92acef7..c4e47fbc78 100644
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
@@ -4036,11 +4049,32 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
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
+                                if ((inst & (0b011111 << 7)) == 0) {
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
+                                if (((inst & (0b011111 << 15)) == 0) &&
+                                    ((inst & (0b011111 << 7)) == 0)) {
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


