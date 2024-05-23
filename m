Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4466AC25B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 16:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAB7J-0005Dh-VZ; Thu, 23 May 2024 12:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAB6p-00050x-Bz
 for qemu-devel@nongnu.org; Thu, 23 May 2024 12:16:12 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAB6l-0002Yk-Kw
 for qemu-devel@nongnu.org; Thu, 23 May 2024 12:16:03 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f69422c090so3102485b3a.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 09:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716480958; x=1717085758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+UEAzmz2yf/FXZrHjq+7bspL7xDnH65PbwwSYmcMRBs=;
 b=gRPIjRZ/82jLqMxvnQmgMW3EHB5I2GSy3SoEgELq6Q0JodQOO3rs5SRvMSJxm66fXG
 JVwzU4irOdHp8df+OmPysZNu8Pn4gJwOZxxW4BztFonNb+i8xjV2kaDJ0qDJ+wpDDaqm
 Xqlfh+m8t7UKFtRvx6ZvLlUgPvKfhOfTfDnr1QcQThJVlkGhPQ8z7o5gzWYM6rx+0moY
 8fnRMAvjCnOg0ZpMp5nsR5feSPhkB704frOOHkCdJd9sHODBvrV1UCWC9ELqOTopdioo
 PKBzdq2Q1YQvlYKJczts+uUjP60ko/2oFNq6YV3RgzWSXE8Yhc2rR16AjypPHf0tzyl/
 4X6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716480958; x=1717085758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+UEAzmz2yf/FXZrHjq+7bspL7xDnH65PbwwSYmcMRBs=;
 b=bmelSAge6Wl0Z1NvJwdPM8VHEjnHIPSsTzgJNuaO2+cTYTFWlThsOWCUYf69324g3B
 zz7+8Oky5/P0T/gTawgNgYrL6tZqEPbsFiwmMbBvCjqKRr2pPU/vOIdSKWVrwdxtrb2f
 ZIASdfWT3IWdQxDNLHWT2k1rbXZOdAcsBC/EQ0mAwsaqDe3roUSXf0Q0N8kwx1g7NUZQ
 uKX/wwwmeW1huivOLTrJyHTocFgnh3POToIGzCFdcrvKauMP9Sq5gpGY41oJ7nngI16V
 LgZlHsMr7/NbXnj8onk/jTbszloOumoZFywp3b2iD+jqbkSx4LeffWG0Nc/XFQ0gVlz0
 QV0Q==
X-Gm-Message-State: AOJu0YxClRj6FIenBajey8Ex+nSlsGhk+gN6cxthQu77plJczYjbnuRE
 plnzX4n2PPIVm5f2yAt+8eEp9I6CUpuHYPkZwlCGcEL3LMPcN+0bOKHflmzdKwlwZOwIt/awyTi
 c
X-Google-Smtp-Source: AGHT+IGCTAxgljplSGUe7Y2XrpFQ2IS9JB0bgR5axTyU0S5MXn1dJdvweU12bQot8uZ1YLvMISa5Kg==
X-Received: by 2002:a05:6300:8084:b0:1af:a37e:367e with SMTP id
 adf61e73a8af0-1b1f887ebdcmr4909402637.15.1716480957840; 
 Thu, 23 May 2024 09:15:57 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a9d9acsm24890255b3a.90.2024.05.23.09.15.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 09:15:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/5] tcg/aarch64: Support TCG_TARGET_HAS_tst_vec
Date: Thu, 23 May 2024 09:15:51 -0700
Message-Id: <20240523161553.774673-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523161553.774673-1-richard.henderson@linaro.org>
References: <20240523161553.774673-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h     |  2 +-
 tcg/aarch64/tcg-target.c.inc | 26 ++++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 138bafb9da..8bd9e6a5eb 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -167,7 +167,7 @@ typedef enum {
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       1
 #define TCG_TARGET_HAS_cmpsel_vec       0
-#define TCG_TARGET_HAS_tst_vec          0
+#define TCG_TARGET_HAS_tst_vec          1
 
 #define TCG_TARGET_DEFAULT_MO (0)
 #define TCG_TARGET_NEED_LDST_LABELS
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 56fc9cb9e0..ffa8a3e519 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2737,7 +2737,8 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
             TCGCond cond = args[3];
             AArch64Insn insn;
 
-            if (cond == TCG_COND_NE) {
+            switch (cond) {
+            case TCG_COND_NE:
                 if (const_args[2]) {
                     if (is_scalar) {
                         tcg_out_insn(s, 3611, CMTST, vece, a0, a1, a1);
@@ -2752,7 +2753,27 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                     }
                     tcg_out_insn(s, 3617, NOT, is_q, 0, a0, a0);
                 }
-            } else {
+                break;
+
+            case TCG_COND_TSTNE:
+            case TCG_COND_TSTEQ:
+                if (const_args[2]) {
+                    /* (x & 0) == 0 */
+                    tcg_out_dupi_vec(s, type, MO_8, a0,
+                                     -(cond == TCG_COND_TSTEQ));
+                    break;
+                }
+                if (is_scalar) {
+                    tcg_out_insn(s, 3611, CMTST, vece, a0, a1, a2);
+                } else {
+                    tcg_out_insn(s, 3616, CMTST, is_q, vece, a0, a1, a2);
+                }
+                if (cond == TCG_COND_TSTEQ) {
+                    tcg_out_insn(s, 3617, NOT, is_q, 0, a0, a0);
+                }
+                break;
+
+            default:
                 if (const_args[2]) {
                     if (is_scalar) {
                         insn = cmp0_scalar_insn[cond];
@@ -2791,6 +2812,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                     }
                     tcg_out_insn_3616(s, insn, is_q, vece, a0, a1, a2);
                 }
+                break;
             }
         }
         break;
-- 
2.34.1


