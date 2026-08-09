Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD8FC5AD7B
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtC83-00014S-Hp; Sun, 09 Aug 2026 18:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC82-00012l-Ig
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:26 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7z-0007Rx-Q7
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:26 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-84874b52eabso1636655b3a.0
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786314982; x=1786919782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xBVmfASb1dhHWckdEJS1YAk1pkEyuhDec0JXLQb2rFc=;
 b=e9xSQeLZJGxg32ovVy0aQbe+P0a1pYFlpsX+kNHKHiZmUVISwjRdH5ZfEMpIbwn7qq
 U3+wcamIH343Bkr1CeJn/h8pgi02zOh37br1iKvCNlUkvE88wrsRk29xqYAk4s7qRYF9
 W2+eIRnYhIC3M2m1qyk9jvcKRScxBhqGXBnQ46h2nfNgYH6HxbvPP2TRnlX8HNOsMVsf
 iJEGypVmE1VpBltSMuHJtow/QGgXV5FaBOrBE8A/fPYkV4SNyPuvMFmtMLK356o7sGbN
 NUE1R5J4f9ujLIS8ldI6/ZtZbD6te8pgnRMli7T7+LOcUQ2yYrM6rOPy9bWDCMzlgdqW
 RjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786314982; x=1786919782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xBVmfASb1dhHWckdEJS1YAk1pkEyuhDec0JXLQb2rFc=;
 b=pI3h3Uv+ggVrkkZFgJlCcGp1RIuS2UXOq5Ng0aN7INp9wXyZQj/2bJRL9Jl5weWkTu
 De/MlksrurqVm/MjeeLVcc/v+bo0+psOBMY+bnZ4P0wACx9Rn9Zjm+pF68OV8B9NVo/a
 7VZsby6AOEfgso0qTnfCEn1rRMth/AgRuHwW8jZfPCY5mY8Uc/V4iTy4kGZzPi9axdHf
 Oacm2SxxUUMIJIypkuV8YErP/ORiRw6qM0MoFgYn/M+lnWp+kZHS27m7bS5ST7fJbr3P
 Dby3Wz8coKqnZyteKC/ZrfC78Dg1ZjVW9jJ8hBIrJMTstBwCMktWFpG1tiwOHByNFS80
 9nmQ==
X-Gm-Message-State: AOJu0YxJpAlmoZp6KXpcSEZOOVGKb+RiywGxX/ft0hj1FFKNwp9A+Tup
 lGao8ioSqOdfLMqDSz6M168RY7f+XgEaXqwDqRXaHEUzU59jDzGBXv1Kqm4eYXwH4YlVaqXUlnP
 rtGA4
X-Gm-Gg: AR+sD11kN8xJ+HB7mRc8yQ+VZwBgolmYVndhrBEizFS7ueoYWgEPHq1oGp6cHVstO/s
 LvE8wU9bkQaUxfda/CAgsAOiINnImL1rfcOzhC1jpLe4Wgw+QEvf5NqdB6ynaFrjuOybcuLYA73
 +n3Syw8B9KzwKETggzjCgWdO9xgzfjJK+SPBa5Abzx9kH8bGyUuDynkDI2kbCQymsS0xxc7ZxHd
 L5aChl2xoaDKV+uvLfo3bT78Oh/imaaapFLmlgjjtQYJG2lu3TTnbSVmUojNs387sYoMhovZWde
 r8fSm52xqtqBwPo4sdS+ISn8XaiaN1JW8Vb4U4cgYbiT0TPqwdprysg81q6VViZEW0FbyHD7eGF
 h8DVPe5jJywGvas4JSvNAb7CiYEYmyWpx022OIinOI21q2tw8XWs3JeH/H/s5mmyduNNKEHPCyT
 yrVoEk1sY+41pXiM5m5fCKPExJfDXamkLNR28FDfRJb3hv6IvHnWNoyY3Ua0d5iPRHZ5K7ZWNUh
 1BTQCQzCHsmDEnDawsj
X-Received: by 2002:a05:6a00:2d8a:b0:845:3914:f039 with SMTP id
 d2e1a72fcca58-84f5e09ce58mr19098646b3a.26.1786314982239; 
 Sun, 09 Aug 2026 15:36:22 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f19ace6sm2998102a12.2.2026.08.09.15.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:36:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 28/56] disas/riscv: Handle aliases of csrrs during decode
Date: Sun,  9 Aug 2026 15:35:17 -0700
Message-ID: <20260809223545.730664-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.h |  7 -----
 disas/riscv.c | 85 +++++++++++----------------------------------------
 2 files changed, 17 insertions(+), 75 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index 900363c603..d8c5acd969 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -86,13 +86,6 @@ typedef enum {
     rvc_imm_eq_p1,
     rvc_csr_eq_0x001,
     rvc_csr_eq_0x002,
-    rvc_csr_eq_0x003,
-    rvc_csr_eq_0xc00,
-    rvc_csr_eq_0xc01,
-    rvc_csr_eq_0xc02,
-    rvc_csr_eq_0xc80,
-    rvc_csr_eq_0xc81,
-    rvc_csr_eq_0xc82,
 } rvc_constraint;
 
 typedef enum {
diff --git a/disas/riscv.c b/disas/riscv.c
index e464b8b075..9ec79baf4d 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1063,24 +1063,6 @@ static const rvc_constraint rvcc_ret[] = { rvc_rd_eq_x0, rvc_rs1_eq_ra,
                                            rvc_end };
 static const rvc_constraint rvcc_jr[] = { rvc_rd_eq_x0, rvc_imm_eq_zero,
                                           rvc_end };
-static const rvc_constraint rvcc_rdcycle[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc00,
-                                               rvc_end };
-static const rvc_constraint rvcc_rdtime[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc01,
-                                              rvc_end };
-static const rvc_constraint rvcc_rdinstret[] = { rvc_rs1_eq_x0,
-                                                 rvc_csr_eq_0xc02, rvc_end };
-static const rvc_constraint rvcc_rdcycleh[] = { rvc_rs1_eq_x0,
-                                                rvc_csr_eq_0xc80, rvc_end };
-static const rvc_constraint rvcc_rdtimeh[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc81,
-                                               rvc_end };
-static const rvc_constraint rvcc_rdinstreth[] = { rvc_rs1_eq_x0,
-                                                  rvc_csr_eq_0xc82, rvc_end };
-static const rvc_constraint rvcc_frcsr[] = { rvc_rs1_eq_x0, rvc_csr_eq_0x003,
-                                             rvc_end };
-static const rvc_constraint rvcc_frrm[] = { rvc_rs1_eq_x0, rvc_csr_eq_0x002,
-                                            rvc_end };
-static const rvc_constraint rvcc_frflags[] = { rvc_rs1_eq_x0, rvc_csr_eq_0x001,
-                                               rvc_end };
 static const rvc_constraint rvcc_fsrmi[] = { rvc_csr_eq_0x002, rvc_end };
 static const rvc_constraint rvcc_fsflagsi[] = { rvc_csr_eq_0x001, rvc_end };
 
@@ -1163,19 +1145,6 @@ static const rv_comp_data rvcp_subw[] = {
     { rv_op_illegal, NULL }
 };
 
-static const rv_comp_data rvcp_csrrs[] = {
-    { rv_op_rdcycle, rvcc_rdcycle },
-    { rv_op_rdtime, rvcc_rdtime },
-    { rv_op_rdinstret, rvcc_rdinstret },
-    { rv_op_rdcycleh, rvcc_rdcycleh },
-    { rv_op_rdtimeh, rvcc_rdtimeh },
-    { rv_op_rdinstreth, rvcc_rdinstreth },
-    { rv_op_frcsr, rvcc_frcsr },
-    { rv_op_frrm, rvcc_frrm },
-    { rv_op_frflags, rvcc_frflags },
-    { rv_op_illegal, NULL }
-};
-
 static const rv_comp_data rvcp_csrrwi[] = {
     { rv_op_fsrmi, rvcc_fsrmi },
     { rv_op_fsflagsi, rvcc_fsflagsi },
@@ -1751,7 +1720,7 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "sfence.vma", rv_codec_r, rv_fmt_rs1_rs2 },
     { "wfi", rv_codec_none, rv_fmt_none },
     { "csrrw", rv_codec_i_csr, rv_fmt_rd_csr_rs1 },
-    { "csrrs", rv_codec_i_csr, rv_fmt_rd_csr_rs1, rvcp_csrrs },
+    { "csrrs", rv_codec_i_csr, rv_fmt_rd_csr_rs1 },
     { "csrrc", rv_codec_i_csr, rv_fmt_rd_csr_rs1 },
     { "csrrwi", rv_codec_i_csr, rv_fmt_rd_csr_zimm, rvcp_csrrwi },
     { "csrrsi", rv_codec_i_csr, rv_fmt_rd_csr_zimm },
@@ -4440,7 +4409,22 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 default: op = rv_op_csrrw; break;
                 }
                 break;
-            case 2: op = rv_op_csrrs; break;
+            case 2:
+                op = rv_op_csrrs;
+                if (operand_rs1(inst) == 0) {
+                    switch (operand_csr12(inst)) {
+                    case 0x001: op = rv_op_frflags; break;
+                    case 0x002: op = rv_op_frrm; break;
+                    case 0x003: op = rv_op_frcsr; break;
+                    case 0xc00: op = rv_op_rdcycle; break;
+                    case 0xc01: op = rv_op_rdtime; break;
+                    case 0xc02: op = rv_op_rdinstret; break;
+                    case 0xc80: op = rv_op_rdcycleh; break;
+                    case 0xc81: op = rv_op_rdtimeh; break;
+                    case 0xc82: op = rv_op_rdinstreth; break;
+                    }
+                }
+                break;
             case 3: op = rv_op_csrrc; break;
             case 4:
                 if (dec->cfg && dec->cfg->ext_zimop) {
@@ -5017,41 +5001,6 @@ static bool check_constraints(rv_decode *dec, const rvc_constraint *c)
                 return false;
             }
             break;
-        case rvc_csr_eq_0x003:
-            if (!(imm == 0x003)) {
-                return false;
-            }
-            break;
-        case rvc_csr_eq_0xc00:
-            if (!(imm == 0xc00)) {
-                return false;
-            }
-            break;
-        case rvc_csr_eq_0xc01:
-            if (!(imm == 0xc01)) {
-                return false;
-            }
-            break;
-        case rvc_csr_eq_0xc02:
-            if (!(imm == 0xc02)) {
-                return false;
-            }
-            break;
-        case rvc_csr_eq_0xc80:
-            if (!(imm == 0xc80)) {
-                return false;
-            }
-            break;
-        case rvc_csr_eq_0xc81:
-            if (!(imm == 0xc81)) {
-                return false;
-            }
-            break;
-        case rvc_csr_eq_0xc82:
-            if (!(imm == 0xc82)) {
-                return false;
-            }
-            break;
         default: break;
         }
         c++;
-- 
2.43.0


