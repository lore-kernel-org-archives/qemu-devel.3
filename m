Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA43DC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbT-0005MO-RV; Mon, 24 Aug 2026 01:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNal-0004Si-Gx
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:31 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNaV-0002bo-8o
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:18 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-38deea72eebso3423244a91.1
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550673; x=1788155473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IJUxA2gEgVqA7Wq69py4RBGAGJf+JNTEdoMwMM1C2vc=;
 b=XABIN8yeZzpJi4Q/kCkBLTlalD/7J8jE6KPbEQOyjOoIPD2pkf8OSeD9/iBKRbdnrA
 /PNSvvzkjRLO5XP/RmV0PYealAmIiZTbtl16mRhUuCis/7mZzDrYHL4FLPICKPK9+AUA
 pxxql8CWemYKWrsTfRHNzgfePOdV6Mi9qIUveIG3hyLcjrTkf27EYuUdkeYB3VhKumc7
 ZGeSM/o2b8n7Bc1/vps91tQaVd8Hu/B09vjv+JJ8usfcGU3d0H8yATNqAFLGz2SELt1r
 O1XIXNq5pVhvbQ3jCVd8RfdiYAlQynbmQhZLRS4XlP90YaV5oAs2UZf+01+Znk56wkOD
 BVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550673; x=1788155473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IJUxA2gEgVqA7Wq69py4RBGAGJf+JNTEdoMwMM1C2vc=;
 b=slEOOBDo1DxXZOWkjadHYAqVP1ncTncZSFWYWQ8QuOfKEzki2Y9W5hwpWe8TqvspOQ
 jnzpnSrigTQBf0j4jKtl8PUg+XH/UNwrdtAqk7Pd8iqUGWobPpDlOf9X80R2zzAQviZV
 DTHLbx0BUP+odxOrqcFeO9BzTmJUf6XniASiPOohJp1sJyQovocQQ/AuDJY5JpY0QdQR
 7Pk7O22pMlVclylE6Uh0aWz7LFxtpMDpH83rAi20KW77xFS1VWszdqObYtGbrH+LTtgP
 2+i0j5YTwoJaHPTXbP5lPlvkkeFDKySrHsj5JzBpz0dvyJ6UMQAx7dILAojixNXYX+EC
 JmFw==
X-Gm-Message-State: AFuF++nqgaDfmWWVTjaq902rOU4at+3VWIJq0HwIpNfcVhUKUnUSVfIY
 D3fbWEEzWUyXnVcNiIHpTT+hqMDua7qXm5baBdEKGQgxWPX3cLFn1h0T5WAcig==
X-Gm-Gg: AR+sD11Ibp2dMkonzmgQfMUayqY4eRlgHoSvcWlF0QFeyfK2EJj0UOK1lY0VmcuVfTw
 vp0l90hTeYHTOSaGV+ontilpDPsY7islgS+tgXHZXafCgRRc/VNpTllRUKioch57IR1mfMEL/yB
 iPmJgy8hrOjti7zQ6pK0CRnEGHyRDjxTtMgUwZI5vf1nXdSDZOFczwA/i51SWFAwaW0C/9iEoiV
 ASYI6BXSTjbepxPfdmXy7WspdMhERNUUIvvCkyG5WHRDoszi+EbsoOyc1RYr/7ZY1AzzHC8Dn8P
 mLdr6dgYGVVHvohbkUKJAKosJYPQTfHAVA6PoYg1/Z9U4HhPjnvHt+PlKbjHUCZuEA388KAELbz
 yyx8ZNiq7IXkrnjKMu8FWZSQ0EBGTiY1voFHn981wFh1M3ZmpxLbrUEcnf9lQ0OZxr1//zpFO8I
 pTb/QdprfNX4FA1LFe5N/KPZEEMvSSDeYdD7z1o9T98rX8pOQb24l44UlbtXVJqRqgyzHz4FLUn
 o8MOA==
X-Received: by 2002:a17:90b:538f:b0:38e:b400:a860 with SMTP id
 98e67ed59e1d1-395df29e128mr30334481a91.13.1787550672942; 
 Sun, 23 Aug 2026 22:51:12 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:51:12 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 57/96] disas/riscv: Handle aliases of csrrwi during decode
Date: Mon, 24 Aug 2026 15:47:27 +1000
Message-ID: <20260824054806.2790041-58-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102b.google.com
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
Message-ID: <20260812223142.349142-25-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.h |  2 --
 disas/riscv.c | 28 ++++++++--------------------
 2 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index d8c5acd969..3bbcbf10fb 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -84,8 +84,6 @@ typedef enum {
     rvc_imm_eq_zero,
     rvc_imm_eq_n1,
     rvc_imm_eq_p1,
-    rvc_csr_eq_0x001,
-    rvc_csr_eq_0x002,
 } rvc_constraint;
 
 typedef enum {
diff --git a/disas/riscv.c b/disas/riscv.c
index 9ec79baf4d..d3cbfb86ac 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1063,8 +1063,6 @@ static const rvc_constraint rvcc_ret[] = { rvc_rd_eq_x0, rvc_rs1_eq_ra,
                                            rvc_end };
 static const rvc_constraint rvcc_jr[] = { rvc_rd_eq_x0, rvc_imm_eq_zero,
                                           rvc_end };
-static const rvc_constraint rvcc_fsrmi[] = { rvc_csr_eq_0x002, rvc_end };
-static const rvc_constraint rvcc_fsflagsi[] = { rvc_csr_eq_0x001, rvc_end };
 
 /* pseudo-instruction metadata */
 
@@ -1145,12 +1143,6 @@ static const rv_comp_data rvcp_subw[] = {
     { rv_op_illegal, NULL }
 };
 
-static const rv_comp_data rvcp_csrrwi[] = {
-    { rv_op_fsrmi, rvcc_fsrmi },
-    { rv_op_fsflagsi, rvcc_fsflagsi },
-    { rv_op_illegal, NULL }
-};
-
 static const rv_comp_data rvcp_fsgnj_s[] = {
     { rv_op_fmv_s, rvcc_fmv_s },
     { rv_op_illegal, NULL }
@@ -1722,7 +1714,7 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "csrrw", rv_codec_i_csr, rv_fmt_rd_csr_rs1 },
     { "csrrs", rv_codec_i_csr, rv_fmt_rd_csr_rs1 },
     { "csrrc", rv_codec_i_csr, rv_fmt_rd_csr_rs1 },
-    { "csrrwi", rv_codec_i_csr, rv_fmt_rd_csr_zimm, rvcp_csrrwi },
+    { "csrrwi", rv_codec_i_csr, rv_fmt_rd_csr_zimm },
     { "csrrsi", rv_codec_i_csr, rv_fmt_rd_csr_zimm },
     { "csrrci", rv_codec_i_csr, rv_fmt_rd_csr_zimm },
     { "flw", rv_codec_i, rv_fmt_frd_offset_rs1 },
@@ -4469,7 +4461,13 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     }
                 }
                 break;
-            case 5: op = rv_op_csrrwi; break;
+            case 5:
+                switch (operand_csr12(inst)) {
+                case 1: op = rv_op_fsflagsi; break;
+                case 2: op = rv_op_fsrmi; break;
+                default: op = rv_op_csrrwi; break;
+                }
+                break;
             case 6: op = rv_op_csrrsi; break;
             case 7: op = rv_op_csrrci; break;
             }
@@ -4991,16 +4989,6 @@ static bool check_constraints(rv_decode *dec, const rvc_constraint *c)
                 return false;
             }
             break;
-        case rvc_csr_eq_0x001:
-            if (!(imm == 0x001)) {
-                return false;
-            }
-            break;
-        case rvc_csr_eq_0x002:
-            if (!(imm == 0x002)) {
-                return false;
-            }
-            break;
         default: break;
         }
         c++;
-- 
2.54.0


