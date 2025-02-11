Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DF1C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht5V-0006SP-3r; Tue, 11 Feb 2025 11:26:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tht5N-0006PW-Hc
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:10 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tht5L-000341-Ug
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:09 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4394829ef0fso12778655e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291166; x=1739895966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UTlj99r0T6pPfzjdgb6uJLs6OLra7ZAWbShTkPt4ma4=;
 b=UwRZ/t9TdxmiVifI8E2XYz55n6GAS61CI91oboq7L4GVhfTzJRvOwobxcSlehAxZhV
 YMw/6qEqdOubWXavvolyCEx8Ptjwnngqq/h38Ek/MkwsG043KtFcaMbAORLu3Pp4WhIb
 AhkSbBhesFatJWyK4yPvtCEYmJv4Cmtq90O2ltHprg0ySZV+wjx05rLqj16aCQs5CW18
 oRxA+GKZ4fnyUabTKANa181Ro9SPo2L8xQWp5gi2rDMi3pSZCHsDPaySIEE+qNfOEStQ
 /lWHgDcuW0XU2ODPhY6jPbrsLeSRk0hB27WKALpsQTknS4XY2afLsP57yKjA6pAkLE+g
 71HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291166; x=1739895966;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UTlj99r0T6pPfzjdgb6uJLs6OLra7ZAWbShTkPt4ma4=;
 b=wEkR990wfecxqWasF+XISqL3VGVF3Lot7TigNC3LOqPhVqzmEUb2BX4RekGIKwyCdG
 1wWyxBuu7OE7yxpoVE4vGZ99J+jogBIBg4CQnlTJxu0vERxaYL1GSc9yhG/U+jgU/P3g
 W8rD79VliLmBC0lbxsotMgOqqJlkrgL+ntVGzIVWoLloTXMSXa4+fSNWep+hvxgWM1D5
 wIevZ7kWGj3YKLd6EHZZFNLg5SHAIdNMiVK4BPbAQNBBJjSG8hEROnZM8SKpeMwVABBw
 heFyH2RAixzKy3BWRiThyNwFblh8feH9x8+QX8bOZjBMkJAHY+TybQFZbOehlUlcMINl
 TV8A==
X-Gm-Message-State: AOJu0Ywwcw/V86k+ljcbPJgTRKKXXsDkAuXxJxi8bM3cTjsspk5CCkim
 rS4+8JsFTOZqFWTX7XMxvze3uXagvvkLcTMZzuf7DJvtRyPiYhMHOk3QSjdR8L9NlG1UEYE9VFz
 JRoA=
X-Gm-Gg: ASbGncsc+nARofYB6W3a9Bi72z/h4NgPGyc9qIcdrgyUrfQwKg2aXDmi8gRLnUHepQK
 nBfrTRuIBVT0CQLAj9AtKaxtxaJZehNiowFmsS+Wmd3e9r5lJgDLFDeyTU9/VcdS/MkLBulyT+V
 y0eIVobrSkyij7h2AT1p/bTVZ5477bRU4SeoHXGEFAPpitgrfTTcQpzJUM7gjosuxHHZLcyAAnt
 GGFwe3uAWTYRb1vbb1V7dHL3ftasRVWkKu9Ey3V/KZPr4mXLkZgvMeA6ySfxOGPH1w1DDue79/a
 kiW3LepX81S5Lgu6oVZMPm9wevsF+lOUxQGw7xiSqNTmD5t4UA4AjOa8H0ksTUCzZg==
X-Google-Smtp-Source: AGHT+IGkCXBxUVQPAcwuBwCHilnHMerM7BP5F+KU9LkREX3u5uTfqDzwWPGP48jiMzjznLIXWRH9ew==
X-Received: by 2002:a05:600c:3d8b:b0:438:a313:cda9 with SMTP id
 5b1f17b1804b1-4394cf0112dmr34712495e9.10.1739291166027; 
 Tue, 11 Feb 2025 08:26:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393963c84esm102195835e9.27.2025.02.11.08.26.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Feb 2025 08:26:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/alpha: Do not mix exception flags and FPCR bits
Date: Tue, 11 Feb 2025 17:26:04 +0100
Message-ID: <20250211162604.83446-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

get_float_exception_flags() returns exception flags,
which are distinct from the FPCR bits used as error code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20250211130626.3940412-1-peter.maydell@linaro.org>
---
 target/alpha/fpu_helper.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
index f810a9b6a47..6aefb9b851a 100644
--- a/target/alpha/fpu_helper.c
+++ b/target/alpha/fpu_helper.c
@@ -455,29 +455,28 @@ static uint64_t do_cvttq(CPUAlphaState *env, uint64_t a, int roundmode)
 {
     float64 fa;
     int64_t ret;
-    uint32_t exc;
+    uint32_t exc = 0;
+    int flags;
 
     fa = t_to_float64(a);
     ret = float64_to_int64_modulo(fa, roundmode, &FP_STATUS);
 
-    exc = get_float_exception_flags(&FP_STATUS);
-    if (unlikely(exc)) {
+    flags = get_float_exception_flags(&FP_STATUS);
+    if (unlikely(flags)) {
         set_float_exception_flags(0, &FP_STATUS);
 
         /* We need to massage the resulting exceptions. */
-        if (exc & float_flag_invalid_cvti) {
+        if (flags & float_flag_invalid_cvti) {
             /* Overflow, either normal or infinity. */
             if (float64_is_infinity(fa)) {
                 exc = FPCR_INV;
             } else {
                 exc = FPCR_IOV | FPCR_INE;
             }
-        } else if (exc & float_flag_invalid) {
+        } else if (flags & float_flag_invalid) {
             exc = FPCR_INV;
-        } else if (exc & float_flag_inexact) {
+        } else if (flags & float_flag_inexact) {
             exc = FPCR_INE;
-        } else {
-            exc = 0;
         }
     }
     env->error_code = exc;
-- 
2.47.1


