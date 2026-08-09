Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E16C5AD4E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtC7h-0000m3-Iw; Sun, 09 Aug 2026 18:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7g-0000lJ-JO
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:04 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7f-0007KG-2n
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:04 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-cbb662575d3so542454a12.0
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786314961; x=1786919761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ojI3MxJHHeWD8C2qQpIjN6QY5DC1pEE2atzUlRgmXLI=;
 b=Zkv/44tOV3UpU0SuWwDlympIFNabS1TK6ePYlR4igsy1Vyw/EI5nT7o5t4yHDewH8v
 6hzl7Ehp2j81ERhOLK24OoVAh6vdwV1iItsm131PnAdLxRn/8FK5+XKog97hnhc9Vlqz
 1n2JYXbxOg8In/CELaeBWE8/yA6Ouxlenkxla2jwpUyu+eAyHpm2sA5DR5xVxLnte6u6
 P57Ei9MtoNqvBA+t9Qn7OvqHO1ZuY/UkrMlmLshBccQAXCREiUSt7u5U2p561B7chyBE
 pLFZ3g5Wd7j0kQhBPeERUfg8gBIheH0heVaxNPE1H77lnoysja9P31N/MEi62ATZGz7z
 mz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786314961; x=1786919761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ojI3MxJHHeWD8C2qQpIjN6QY5DC1pEE2atzUlRgmXLI=;
 b=Yx4ezDMA3OiM7b8VH2E+eg/PJ5ZNNEanXKYEIs68qkpZ+eNdie32TQRYNlkqGYeNuH
 PFRvBCkf1Y9+jgZnW29dbFOyWxfRrb4rcp8PO7rhqtOq73WzL5MEYsLSCjCfUfYWrP71
 7W18KJXS7tQ4+CwLwZT906wf6A9Wfn3jx30g9mbOuPOT+h56O4BAZDuju4y98f5nhxLB
 y/LO7wgkRFDLUtlJGmBrgGBk8O8U2QrQUiG426qpFv/4LIM9PW/W5oRGxWzhlYOIk1MU
 jECRYjtoBL8P/9BgNabZW/oB/NmO5Ad8968gHUwQ13oZiG7d9XsFpOgPmbVoxBNdPBOV
 b/Mg==
X-Gm-Message-State: AOJu0YwzU8o6lOjMZt96M7J/+Khbz75JCb8qE8/zl9jE9TME2wDY9QTS
 8mgc7R2NA7iax0WAeVU7I7knbuTUjXb+e28sQpL6T9SB/DBa/Vd2kwP39anC92waWkGgRXZ70lT
 KQPSq
X-Gm-Gg: AR+sD13ngWF0IENLR2kjW+lduAV0Z++uJIbqF+t2MDfyHAd6E8RUIynzmQrxelZrOds
 ECRf4OIPdTQv8kerfSEKiZDH5QH5fWVJ/xx19aQvmdoM69dLphF7TZ3CK4KStvNSx9w0dQTQ6nB
 1SsFembVdr0YzvR1Q1U02j8IuOMhMS/SkDLUpTFO1Aruz9Q9reilffG1ELWF1Affgo/B4+RSj9E
 Pf3mvM1LGwHmxsbLPUZhxl76u12EkbYFK2qxch74knsN6prNDleAkDlEdR812jc8I2+BgW7veCh
 rlKY444u6iLA2+WZf9Xawaj/t6wkPWCSzpYNhY63fySjUNMuwTxUS9DnigVdoYt95ns+H72nFfG
 tcLNiJs63p32b/yA5rztJB9lisTRQ9Ux66fJltswYNGiD3PDyzM0+AP7latkaeq+yraEsaQDSFf
 MWeqkEKw1O6jMGxIdZUn6g5oZZ9CWs6Bz1j3sW1ul/H6+1IYFZaLnm5v0/dKnPGdGqKOicPJKlg
 0TEtpHjIKStJMx6B43HwnNPNgy4pV8=
X-Received: by 2002:a05:6a20:3ca5:b0:3c3:a31b:3949 with SMTP id
 adf61e73a8af0-3cbadaf4a67mr29455251637.11.1786314961269; 
 Sun, 09 Aug 2026 15:36:01 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f19ace6sm2998102a12.2.2026.08.09.15.36.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:36:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 11/56] disas/riscv: Pass rv_opcode_data pointer to/from
 decode_inst_lift_pseudo
Date: Sun,  9 Aug 2026 15:35:00 -0700
Message-ID: <20260809223545.730664-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
2.43.0


