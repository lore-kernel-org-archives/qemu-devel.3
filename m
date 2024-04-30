Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97800C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qOw-0004K1-Sa; Tue, 30 Apr 2024 12:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1qOf-0004EP-Nl
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:32:03 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1qOc-0001Ph-62
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:32:01 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41b21ed19f5so41727105e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714494715; x=1715099515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TprQUrjgnD8N9rBUQzPSRwctmXsY08QQexwUVLZZZX4=;
 b=ZVK1Co475QKlNIztDm7mUM+oi9fXwnQf2xD+OWa0xb8pEBG7x5CAWSUn1L3qXy0ruk
 83y9OLx0YJe8LzHjaMzM4SGQsHz98S0BrzgW4RznGiLFkVfLPFGHE4jFijNQMaa8C/cl
 l0vLcHufAogTf0Rg031+zpYgiVClGiP1hIXYcVu5EBqSJgSQUAPD2Mb8y1F+kxcme5rN
 acggEPPVg39mOxenXD6Sb49lOwE7vBYgQ24Amg7a8fzAHNwijXzsCalpjnLvwQpwTHru
 BV9x3p/thT6cZM8O8V0cmYdpWBKm+pYPCj+LEuYBN2OvMg6O+VAD3saS8vySTuRag8AR
 Bf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714494715; x=1715099515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TprQUrjgnD8N9rBUQzPSRwctmXsY08QQexwUVLZZZX4=;
 b=bis1+dMIxuhYPDJv6duooF4Ryqxbrx5gCc6DGgInN+4ut/mNgjAQsT45+cKexHQ5lJ
 8ONUOgGXN/qyhJoz1652vEnJrlgHo+YIkXPMetyS8GfjEbteLD01fYaUDIe/7F4038Js
 UpaDIwQtv2GUESCHaz7A7rh/diy0ORVJdqjUsxgT3fVOKiN83zJD4uB9zQ3KtCe6tQZf
 eWvPZwq8BHfH08k9KiKpHpSldEJjsVtOuQv8nFl/oIpuFw5fiB97Mn2h9FwGKata+qgA
 SI3x0vp/n78nyl6Gf5JAsMUaclOoMrqNpdbgM/bmW2sBIBCO5r7jj4ZwSi9EUFvnT7X5
 x5Ww==
X-Gm-Message-State: AOJu0YwRWsoOb61KoiBrPm5CuGUhtHUvq1g+EqwWvRcm1PD/0Vza5cr4
 m4LAvGCizjGRO5ZbHewLVCvq5tBAAn3OjipN65745fln1f4xB0/R6fmcr8/3HuWtSbleaqu400Q
 Z
X-Google-Smtp-Source: AGHT+IEMNS4YajCJsNALoNCqdY8zaWToNhwu1CQNxluvzB4TQX1VBjvxvLWsSKVOgQMQ/DkUyrRrjw==
X-Received: by 2002:a05:600c:46ca:b0:41b:f30a:41f1 with SMTP id
 q10-20020a05600c46ca00b0041bf30a41f1mr48497wmo.7.1714494715673; 
 Tue, 30 Apr 2024 09:31:55 -0700 (PDT)
Received: from m1x-phil.lan (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 l2-20020a05600c4f0200b0041be78ae1f0sm12665835wmq.2.2024.04.30.09.31.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Apr 2024 09:31:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Paul Cercueil <paul@crapouillou.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 4/4] target/sh4: Rename TCGv variables as manual for SUBV
 opcode
Date: Tue, 30 Apr 2024 18:31:25 +0200
Message-ID: <20240430163125.77430-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240430163125.77430-1-philmd@linaro.org>
References: <20240430163125.77430-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/translate.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 47c0f3404e..e599ab9d1a 100644
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
+            tcg_gen_sub_i32(result, Rn, Rm);
+            /* T = ((Rn ^ Rm) & (Result ^ Rn)) >> 31 */
+            tcg_gen_xor_i32(t1, result, Rn);
+            tcg_gen_xor_i32(t2, Rn, Rm);
             tcg_gen_and_i32(t1, t1, t2);
             tcg_gen_shri_i32(cpu_sr_t, t1, 31);
-            tcg_gen_mov_i32(REG(B11_8), t0);
+            tcg_gen_mov_i32(Rn, result);
         }
         return;
     case 0x2008: /* tst Rm,Rn */
-- 
2.41.0


