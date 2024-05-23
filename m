Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F00C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 16:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAB7B-0005Aw-Lf; Thu, 23 May 2024 12:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAB6p-00050y-D4
 for qemu-devel@nongnu.org; Thu, 23 May 2024 12:16:12 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAB6m-0002Yt-H6
 for qemu-devel@nongnu.org; Thu, 23 May 2024 12:16:03 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f4dcc3eeb3so2084265b3a.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 09:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716480959; x=1717085759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WpiThysDuX7JPl+AhNyZ7t+FQuyygOMAjCR+jn6zrYU=;
 b=uRfaNYSwYeEgN3GdyhYeQT0LrtqnbxvLseKq8Gb/+/3iQbYND5m8HO4Rm898X9mGzw
 ogOJhs7D+4Rc8332DOf47JNAhiSUs89g75Gi6Q/1gwxgvK03B7He6uX5exSPfWXzR43m
 OAfgPKKTaxXqzldM4BFk33qVghJnAkeie0+CNxN80nStXWDfphx/DZ4cZgR0inPvDAZn
 9xGJZrMaHeuHF/EaCNENUcPLY/3vjEO2PFdejpCUU7XCE/zXt0DrWN+cGCvQ6hmoPlXK
 RmHvHNESJMeEJrLzqa3K/T01M95r7ZVcAQP3MNP2VXqF/8J3UH18WfhbMI3Maiuz7BE3
 Uu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716480959; x=1717085759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WpiThysDuX7JPl+AhNyZ7t+FQuyygOMAjCR+jn6zrYU=;
 b=l1I1frgA1m64SvfHgeURYweQhOPZo0BC7k7c+VEHNvN8LsRnM5OZ5UInBmZ7k8cnmk
 Cu+NPRnN5ucw28FZYreKdAMT5ALPOhXGAUN9culXqnBpacAFdYbd0dW8oMAK1qhIu831
 SDXgnpcrRX+1Nl/K1sHqkwR5f45O/SLXjCoDmp8PBOUrzvClCIv2yHZgKMrlUblYGk8M
 aJEBdvsD2kTOHB0HfR4B4ZWbmKJDIBU2x60uzHafTisvOF8rdTB+tN6E5+mTVOuq0dIl
 nT3QFzIECI5ETYJQa/yOQeeNfppCRxgmYsRfsX+GPf6/9Df+/e/k9lFO4f6uOs03pa+W
 8igQ==
X-Gm-Message-State: AOJu0YzN6ydZzmGtMDVIovvvsT5HC1OcBjeeXwGtc8JUV5lGiQ46tuvq
 niycRxz3jhdWdO5jQQ0olVNRPAm7OzcLOeTmTE6NWKFHr3m/Bkcb/ie8apDPu5EawLG0dYztcwv
 X
X-Google-Smtp-Source: AGHT+IH8P7J43gxiNuqO99tKh4Ww3p48VDgz8Szae0iZUQScrYo/93XlaIGrnAsYTNXS1q6zqFSE9w==
X-Received: by 2002:a05:6a00:2451:b0:6ec:fdcd:18eb with SMTP id
 d2e1a72fcca58-6f6d61e7b45mr6387362b3a.21.1716480958627; 
 Thu, 23 May 2024 09:15:58 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a9d9acsm24890255b3a.90.2024.05.23.09.15.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 09:15:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/5] tcg/arm: Support TCG_TARGET_HAS_tst_vec
Date: Thu, 23 May 2024 09:15:52 -0700
Message-Id: <20240523161553.774673-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523161553.774673-1-richard.henderson@linaro.org>
References: <20240523161553.774673-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
 tcg/arm/tcg-target.h     |  2 +-
 tcg/arm/tcg-target.c.inc | 23 ++++++++++++++++++++---
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 434a892e07..fb7261499b 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -150,7 +150,7 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       1
 #define TCG_TARGET_HAS_cmpsel_vec       0
-#define TCG_TARGET_HAS_tst_vec          0
+#define TCG_TARGET_HAS_tst_vec          1
 
 #define TCG_TARGET_DEFAULT_MO (0)
 #define TCG_TARGET_NEED_LDST_LABELS
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 6a04c73c76..3de5f50b62 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2740,17 +2740,33 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_cmp_vec:
         {
             TCGCond cond = args[3];
+            ARMInsn insn;
 
-            if (cond == TCG_COND_NE) {
+            switch (cond) {
+            case TCG_COND_NE:
                 if (const_args[2]) {
                     tcg_out_vreg3(s, INSN_VTST, q, vece, a0, a1, a1);
                 } else {
                     tcg_out_vreg3(s, INSN_VCEQ, q, vece, a0, a1, a2);
                     tcg_out_vreg2(s, INSN_VMVN, q, 0, a0, a0);
                 }
-            } else {
-                ARMInsn insn;
+                break;
 
+            case TCG_COND_TSTNE:
+            case TCG_COND_TSTEQ:
+                if (const_args[2]) {
+                    /* (x & 0) == 0 */
+                    tcg_out_dupi_vec(s, type, MO_8, a0,
+                                     -(cond == TCG_COND_TSTEQ));
+                    break;
+                }
+                tcg_out_vreg3(s, INSN_VTST, q, vece, a0, a1, a2);
+                if (cond == TCG_COND_TSTEQ) {
+                    tcg_out_vreg2(s, INSN_VMVN, q, 0, a0, a0);
+                }
+                break;
+
+            default:
                 if (const_args[2]) {
                     insn = vec_cmp0_insn[cond];
                     if (insn) {
@@ -2769,6 +2785,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                     tcg_debug_assert(insn != 0);
                 }
                 tcg_out_vreg3(s, insn, q, vece, a0, a1, a2);
+                break;
             }
         }
         return;
-- 
2.34.1


