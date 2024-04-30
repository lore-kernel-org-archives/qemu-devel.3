Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCBCC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qOt-0004Hz-Q2; Tue, 30 Apr 2024 12:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1qOa-0004D4-8U
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:31:57 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1qOV-0001NM-Ng
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:31:54 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2e0a2870bceso29308251fa.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714494709; x=1715099509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1JlWQ74k3ew3dFGdGKr3ZG9/zjKJQNhOFPSYmWrnhM=;
 b=QLb4xMsMw9la+lrqaIRyF+K9B+Rox3OzS6TpPsucwOlb1HXqo8umdObT6f0OiIrAYr
 wxlrTLlcmGQ/ARTW5Qt56qpeFgg4oRl48Cbkp4T4giN5XnyvJwqZOmdNEiGjU6TctVGS
 rVfwgk0XXTcXIymPIVsnYM7VncfBcQRSW3pIbNHO8GkL+0wr6NgayXpm1hgvHD+KLOhN
 Ydpnpez0AL0DZyH0SI1/LaU54oVOnZtaGB+dIVQcRbKDEJl5Y1znDp3xqf00ChqAIjcK
 ETcYRcoplcA6OnklqjnY4LCnXgdna+fg1D8ev7/05Pf3KwKhD5ZwlMGC7txsFhc4iMKy
 k/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714494709; x=1715099509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l1JlWQ74k3ew3dFGdGKr3ZG9/zjKJQNhOFPSYmWrnhM=;
 b=QTYTalx8VMML1k9l5n/81h4/eac/s4ALaUqCPSUqIn4lIYlXDgGoefo2Z1Qc5uWzZL
 gHUMUMpSEM9D7qTxgnCgZ8m4mTdUMPHG/MVowDoDd0LUoThKNt+mvPhWUrjzZP0PQeAW
 YOe5bt5Yla6qGQf+FCi1ur+O8hos+MBciVFJWC1URU3NX5rh3Q7in+QhcqF3/JAWTv/F
 ba5MN2WSA1EWpKK+ADz4tiiHUUq2LCuyxalimO+8BjekihYvij79ThvwFtSEeky/sCTn
 Ir/Lqyr8S60J065sckpi45hPUaqr5K8wcfUSXMABHnJw/lEWI2y0vqVkC1vT6m1pIIq+
 bBbA==
X-Gm-Message-State: AOJu0Yzqo3opcKeW/jkOhWN99JzVqP4lM+AhhQB4G9Z0e51dcXUg7OZS
 hCJTohh1Fcn21P1hfdoaNIxTre9GXoN11UNyNRr6L9qua7InJ6Oh7/mV1bny6L//fTovAXR+BJg
 6
X-Google-Smtp-Source: AGHT+IFHgTU6AU0ocYb+ZAK3qcdD36kLfwiCWLvOwMJFNFTYn8z5BAHFfpDInniHkXrMwzbqZfoUfQ==
X-Received: by 2002:a2e:914b:0:b0:2dd:bd92:649 with SMTP id
 q11-20020a2e914b000000b002ddbd920649mr144940ljg.36.1714494709665; 
 Tue, 30 Apr 2024 09:31:49 -0700 (PDT)
Received: from m1x-phil.lan (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 l16-20020a05600c4f1000b0041a1fee2854sm34744909wmq.17.2024.04.30.09.31.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Apr 2024 09:31:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Paul Cercueil <paul@crapouillou.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 3/4] target/sh4: Rename TCGv variables as manual for ADDV
 opcode
Date: Tue, 30 Apr 2024 18:31:24 +0200
Message-ID: <20240430163125.77430-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240430163125.77430-1-philmd@linaro.org>
References: <20240430163125.77430-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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

To easily compare with the SH4 manual, rename:

  REG(B11_8) -> Rn
  REG(B7_4) -> Rm
  t0 -> result

Mention how overflow is calculated.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sh4/translate.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 3e013b7c7c..47c0f3404e 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -705,16 +705,20 @@ static void _decode_opc(DisasContext * ctx)
         return;
     case 0x300f: /* addv Rm,Rn */
         {
-            TCGv t0, t1, t2;
-            t0 = tcg_temp_new();
-            tcg_gen_add_i32(t0, REG(B7_4), REG(B11_8));
+            TCGv Rn = REG(B11_8);
+            TCGv Rm = REG(B7_4);
+            TCGv result, t1, t2;
+
+            result = tcg_temp_new();
             t1 = tcg_temp_new();
-            tcg_gen_xor_i32(t1, t0, REG(B11_8));
             t2 = tcg_temp_new();
-            tcg_gen_xor_i32(t2, REG(B7_4), REG(B11_8));
+            tcg_gen_add_i32(result, Rm, Rn);
+            /* T = ((Rn ^ Rm) & (Result ^ Rn)) >> 31 */
+            tcg_gen_xor_i32(t1, result, Rn);
+            tcg_gen_xor_i32(t2, Rm, Rn);
             tcg_gen_andc_i32(cpu_sr_t, t1, t2);
             tcg_gen_shri_i32(cpu_sr_t, cpu_sr_t, 31);
-            tcg_gen_mov_i32(REG(B11_8), t0);
+            tcg_gen_mov_i32(Rn, result);
         }
         return;
     case 0x2009: /* and Rm,Rn */
-- 
2.41.0


