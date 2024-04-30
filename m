Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB85C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 14:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1ouS-00031y-W3; Tue, 30 Apr 2024 10:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1ouR-00031I-AN
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:56:43 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1ouP-0006hd-NP
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:56:43 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2de232989aaso69944021fa.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 07:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714488999; x=1715093799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W369Umf1RT7Ps9NkjMV9ydFMc4wa5Y+lFfUmRoyXGho=;
 b=de4a+7qaBArknf0P9503JJtLfLYVic5qIdJHmd9k1Sc42DKDzZcXQN/qHNzlLhQNPn
 BGwgXnTYhg69Q+DFfX7Pf+gZrNShzKktL/rNJA3nqm5rmEXvjeViFV0oFWr2ZbF/CSz5
 /nUNUZQkARoAfwrczJFZaJmkCpyeyWsJhLm3LBzsPDCXnT0Bx6/IPRMqNrXOfCVZhm+3
 KmB4im78nOAo8JSlsf88qorsOyh4jsQ1nIMaUe0NyANDuw6Q1S6dSOYExvV2CjSm1VEU
 UvBAC/zXPaAcRD/5eozMP/lphqvIp+ioB7thnr4r9fetBBvOC/Q4Q6YTJMhx7eB3yFTw
 dIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714489000; x=1715093800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W369Umf1RT7Ps9NkjMV9ydFMc4wa5Y+lFfUmRoyXGho=;
 b=Gzn7c2u6hF792B4oRDSKQLfATD7Tp427Fa/PwMn++HpM3E8H3XG/FHY6DJRdKYQ1eo
 r5tzKSj7L8VHjbswj/BsDdKn9I2jioZ+b6990o48lfwB9kbpi9E68SBO9yLGlGvXfDjO
 bYzMyFXTuuA71vMpouORTJlyoBcN/WyMALPUKWZXn7dhG2zLu86Rzl0dzly0/iTvgWtP
 oH9RJ+QULoDjaOpDJBxyx4iE6BEqEhE99dp6KNRXXtX+gNs4ldxjC3NKIskAcvw+xJby
 dXqeo4RdAH4hfXyJQ+YvUNOBudLt1MFDeY1ZI6svO8gapWebpx2hU2eTgjnKilnK9BHW
 NiuQ==
X-Gm-Message-State: AOJu0YyUOuGMpeuera99qQUIvwiB6DCoqhbIMRRgueB7cFjFaYG+PPup
 +ac/HWwZR+s4e3dB2SCl409+ja2fRDdZjbDhY/dCT6kmzJ3w/HEpQydecrsPHiNQJBCi+UGD7h3
 z
X-Google-Smtp-Source: AGHT+IF16HzydWtzykDyrw5CVgC7xJ3FdC8trdxKlKjFsaONNgMeSSj8KjmsY8jawOTaZkgpSBvb/Q==
X-Received: by 2002:a2e:88c7:0:b0:2df:65ed:2c34 with SMTP id
 a7-20020a2e88c7000000b002df65ed2c34mr8661757ljk.14.1714488999571; 
 Tue, 30 Apr 2024 07:56:39 -0700 (PDT)
Received: from m1x-phil.lan (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 n7-20020a05600c500700b0041bc412899fsm14017132wmr.42.2024.04.30.07.56.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Apr 2024 07:56:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Cercueil <paul@crapouillou.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 4/4] target/sh4: Rename TCGv variables as manual for SUBV
 opcode
Date: Tue, 30 Apr 2024 16:56:14 +0200
Message-ID: <20240430145614.76475-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240430145614.76475-1-philmd@linaro.org>
References: <20240430145614.76475-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

Mention how underflow is calculated.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/translate.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 47c0f3404e..b0ac631859 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -933,16 +933,20 @@ static void _decode_opc(DisasContext * ctx)
         return;
     case 0x300b: /* subv Rm,Rn */
         {
-            TCGv t0, t1, t2;
-            t0 = tcg_temp_new();
-            tcg_gen_sub_i32(t0, REG(B11_8), REG(B7_4));
+            TCGv Rn = REG(B11_8);
+            TCGv Rm = REG(B7_4);
+            TCGv result, t1, t2;
+
+            result = tcg_temp_new();
             t1 = tcg_temp_new();
-            tcg_gen_xor_i32(t1, t0, REG(B11_8));
             t2 = tcg_temp_new();
-            tcg_gen_xor_i32(t2, REG(B11_8), REG(B7_4));
+            tcg_gen_add_i32(result, Rn, Rm);
+            /* T = ((Rn ^ Rm) & (Result ^ Rn)) >> 31 */
+            tcg_gen_xor_i32(t1, result, Rn);
+            tcg_gen_xor_i32(t2, Rn, Rm);
             tcg_gen_and_i32(t1, t1, t2);
             tcg_gen_shri_i32(cpu_sr_t, t1, 31);
-            tcg_gen_mov_i32(REG(B11_8), t0);
+            tcg_gen_mov_i32(Rm, result);
         }
         return;
     case 0x2008: /* tst Rm,Rn */
-- 
2.41.0


