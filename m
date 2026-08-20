Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37418C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtjx-0002LN-De; Wed, 19 Aug 2026 23:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjw-0002Gz-19
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:52 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtju-00046l-HZ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:51 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-cc1469c1b83so1787362a12.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197609; x=1787802409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WGgzdLMhBzqqG5u7HPy4pNvhAXusg8bxQ2Tn3SIcnEE=;
 b=asQ9m269yWHw5ENOzOsReFq9VSGuDh3zVbfAXx/JmbWb6peTnqaEGLQw6gLyEhKWYD
 MJy8JfUWB1NCVuqWJamkSdPb1WQG5PtOmpt1G+vA9BpUAVhhrm+vOfOjsDZq1Y6RrnA+
 zcMerWuGDtsdMw1vs3lAmTen/T1PIENuoKDUIGNMk/9pF5lXkBYkdyGcfoLPzVYRi9pW
 3Dy0rw9DOvIqIPNOog5fhPtVGOyzwpj0C/bcWpSOzyOuXMuJ878z8AMnXKdSR4ntNBiH
 4kYcdbbWvgUKvw1DRocjORQ0dGYhvi9r9cs1cX3+zMP2rWxwLTRMu9SGg1+dbL4iSH4z
 Kcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197609; x=1787802409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WGgzdLMhBzqqG5u7HPy4pNvhAXusg8bxQ2Tn3SIcnEE=;
 b=EM/FRMYcCGyd1sJje0nZxDVK1gHyhSirpUMkGiSJx83uSllqXo0Co3rlnkqgHHL58j
 Kz+ICHWcfbY+R+zBXGYliDOtACSp59mpknuQdVbdVCKr/lcdLzBv5As/JjIJ338okI6w
 ljSnE2nQJ6Doks/wfuufj1U5SK2TZpbk44CKr5pDJsbEo/GJyJMpceWXZSFaIfTxLAYW
 Uk7Op/PuJlUaQXDZKikdV8eZXtBeVGWSqKOvqenXlKagua7zl7W6VHHonYUOONh6Wwck
 im9wi5ZK2xLhuckEM1zJ3vvVTywgY2p1QlpPXaRcxGYg3c7ZSyh4u6aSTLUVm7P1QZLG
 ENqA==
X-Gm-Message-State: AOJu0YyRF1CwOihkBXDeW7Xwfff24dVhVGH5S56U7BYXFUzK2dUKAav4
 AASzTs8XidFVl+3TKotxLFRnWhcLPp/C9POj+R9iGpSgzsVaGLNep/7vjw9DSw==
X-Gm-Gg: AR+sD1063dYtf48/25UMlXiW/Uc7nl/SEyY2WI9/GGrrcEiQsoVrqyDscTY4an9JkX7
 EuQnmJU3AuRDN3gq7MsAfKKpGH1HhwTeKqJyOqAX+l9w2/BSD09Pec3bLlrewde1KHnAWbKvvg4
 YjeeW/ypC3a4Mkxmdk/jBD1B31+fzr+hBdj9xMGKcZWQR7zOjDebXFJUxMqqL793pKfhy9kC46Y
 Y0lm39sEnR0ma+gw4mou8GTrF+3Sg+ceigy9ocEbc9qmE5xXHxGsPXDXFsCMm3Rl05ndM6Lb1mL
 adB8TyM9snZrVkN5fECG9ddyJKGsh8oabqsezZ/xSXBNXkga6k07UAezJlANdc/Jv6bQMBmvUN3
 w1ssw9gB1VPDh2okpWS1CSXQsNyDsfHkNm1CqSS1+yuaPk13n/6ugzU7JY3Wnk55SuN2LpwxA7u
 27bw579CUqnJvrcb6RxUcNNaiaOgcj5XT/IQ0xiyc3I2z1EJbJpOIlN56iBwmG+mJe/ss+fMCOO
 fcdew==
X-Received: by 2002:a05:6a20:2446:b0:3cc:22bb:8911 with SMTP id
 adf61e73a8af0-3cd00e65097mr16039277637.6.1787197608997; 
 Wed, 19 Aug 2026 20:46:48 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:46:48 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 42/93] disas/riscv: Pass rv_opcode_data pointer to/from
 decode_inst_lift_pseudo
Date: Thu, 20 Aug 2026 13:43:39 +1000
Message-ID: <20260820034430.1186695-43-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x530.google.com
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
Message-ID: <20260812223142.349142-7-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 47fae7316c..0be2f07612 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5358,21 +5358,22 @@ static GString *format_inst(size_t tab, rv_decode *dec)
 
 /* lift instruction to pseudo-instruction */
 
-static void decode_inst_lift_pseudo(rv_decode *dec)
+static const rv_opcode_data *decode_inst_lift_pseudo(rv_decode *dec,
+                                                     const rv_opcode_data *op)
 {
-    const rv_opcode_data *opcode_data = dec->opcode_data;
-    const rv_comp_data *comp_data = opcode_data[dec->op].pseudo;
-    if (!comp_data) {
-        return;
-    }
-    while (comp_data->constraints) {
-        if (check_constraints(dec, comp_data->constraints)) {
-            dec->op = comp_data->op;
-            dec->codec = opcode_data[dec->op].codec;
-            return;
+    const rv_comp_data *comp_data = op->pseudo;
+    if (comp_data) {
+        while (comp_data->constraints) {
+            if (check_constraints(dec, comp_data->constraints)) {
+                dec->op = comp_data->op;
+                op = &dec->opcode_data[dec->op];
+                dec->codec = op->codec;
+                break;
+            }
+            comp_data++;
         }
-        comp_data++;
     }
+    return op;
 }
 
 /* decompress instruction */
@@ -5464,7 +5465,7 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
     op = &dec.opcode_data[dec.op];
     decode_inst_operands(&dec, isa, op);
     op = decode_inst_decompress(&dec, isa, op);
-    decode_inst_lift_pseudo(&dec);
+    op = decode_inst_lift_pseudo(&dec, op);
     return format_inst(24, &dec);
 }
 
-- 
2.54.0


