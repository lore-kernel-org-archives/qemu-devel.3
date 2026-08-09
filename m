Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA745C5AD5A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtC7w-0000wE-GI; Sun, 09 Aug 2026 18:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7t-0000u4-5y
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:17 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7r-0007PB-Oi
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:16 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2cca0c5799eso11458375ad.0
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786314974; x=1786919774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fdfz9CxjwIJrxebC/Gth0XWSxLeLNjiGdSLqVo06CHY=;
 b=G5kceu1dCtmeZTvxj5UU5+Ie7abFZkDKAfUjWKzRrJrUtwNXPR3pQWa8hBJAKlJ0ll
 jI5PdxrVHay4e7FoffLFV6bHmRf826cc1Uw04G1LKtE4BXMUMFWqdSQ02s3r628zuCuK
 wmpoXFfMR6kEJz2b+DNUuDWXJYSXl4w/pZYFYNhMP2VSUlz0ryyYTMOH4leUSb/glBNm
 803tRV9q97E4Pjbq8PskqVnrJUqNZkvhcGFx9yz1O3bJSj4UXinqcKdauz+J+TGD/XpR
 TfmhdJ7LKM6eKDLggVlPdCIdEa9zVBS2mxjVfLgS0yXtFoqY2yIpflzjt8b+p/Shhdrt
 Uw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786314974; x=1786919774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fdfz9CxjwIJrxebC/Gth0XWSxLeLNjiGdSLqVo06CHY=;
 b=HdFYiW2gmDabhPEbJtUedYc8BtM63ndc+GBvYxOaEI42urwJPrHjXAi7pkTCXI/84A
 K/xyUsJXDt6CRD40OM8GOxPrX2jN6Zr0t7AJZBqBf1rYQ0ueZYdeRtHeL9w70e8DtGFj
 MMKCYsaykpZEMNd1WyHyfcnm29XT9t68BpwtRRS7EUz+PEy8g01Hpr6WLQXFSC2Iv1Qn
 dpdL/4sFjjwGScXWASe1miSQjKTC3ElZOtRCR7KIMsNFhdAf2w7DcS+WEhoycXXBCcrU
 2zZ8nWvtRrRNUj+Fo8ZtFDlj+02WMgcsyGm8+t+lCS/Ur3u1RJQMjRkm+9Mu7Cxr8Qdj
 zM0w==
X-Gm-Message-State: AOJu0YxcTC4NxAu/Q+7J1rV5RkhfN/hboKYKaP4iSk0YS8EaGhqvrNTR
 5FhCkRV777bXPqJwJ5aaqplCjZX+KNoxlo/SmswoiaLlKDn+2qjTaylWcK4QUyrq7oBPNqudxcg
 ZC4pk
X-Gm-Gg: AR+sD12EUVUVdhYlccwxEizsef1XocqAaZe9cma2kLYccaPTtAWQ9Lqwao6nMq2B7FP
 UQ7fMCjZVxWEzLO/3ehDZOf1vPR/IIPDLIiJQrnHjbtsEJ3TYGrlbaDc5dkGJpTcdaI6mek8Jym
 f723VT1IZE+287JwuU3ZAlXK5JWKYOpzKjULVq77DuJwh8Guo/UP6TuoVwFrFKbrQtA1Ce2QPAT
 bFigb98SZVAh4mnHsKmK7lEo9sr73tMK1inxldmruXvRO3YL5LI4J31RArSoYfVIxmbgdxSi5Wo
 stBWJjqIAqEO2/Pckc1U6FHJjCjJ2udeGq1Bg5utijN5GzavQpHk152ilSl9ODR6eeKp967jf+K
 o4sizLw2qpEX60lVSYFhMbIOrhSHrla7MqBUDU4uMuOQdT8N+G5R8YfwV+Mc2eDv7iJ/SCG19dQ
 C8m/z4/SetEj7ONTnxk86b0gRY9/PNfAOTsn502VuCrXJfBQCFJr724JXyxuo8blFvR/BmzNS+1
 0lDZom4h7HsDScntWmA
X-Received: by 2002:a05:6a20:4324:b0:3bf:6ac8:8d29 with SMTP id
 adf61e73a8af0-3cbce8d863fmr14680162637.21.1786314974303; 
 Sun, 09 Aug 2026 15:36:14 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f19ace6sm2998102a12.2.2026.08.09.15.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:36:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 22/56] disas/riscv: Handle c.slli imm != 0 during decode
Date: Sun,  9 Aug 2026 15:35:11 -0700
Message-ID: <20260809223545.730664-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
 disas/riscv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index a8fbefb9bd..77347b557d 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1930,7 +1930,7 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "c.bnez", rv_codec_cb, rv_fmt_rs1_rs2_offset, NULL, rv_op_bne, rv_op_bne,
       rv_op_bne },
     { "c.slli", rv_codec_ci_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_slli,
-      rv_op_slli, rv_op_slli, rvcd_imm_nz },
+      rv_op_slli, rv_op_slli },
     { "c.fldsp", rv_codec_ci_ldsp, rv_fmt_frd_offset_rs1, NULL, rv_op_fld,
       rv_op_fld, rv_op_fld },
     { "c.lwsp", rv_codec_ci_lwsp, rv_fmt_rd_offset_rs1, NULL, rv_op_lw,
@@ -3085,7 +3085,9 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
     case 2:
         switch ((inst >> 13) & 0b111) {
         case 0:
-            op = rv_op_c_slli;
+            if (isa != rv32 || (inst & 0x1000) == 0) {
+                op = rv_op_c_slli; /* or unspecified HINT */
+            }
             break;
         case 1:
             if (isa == rv128) {
-- 
2.43.0


