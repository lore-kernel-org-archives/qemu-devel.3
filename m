Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50236CD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUay-0004l9-0V; Fri, 22 May 2026 14:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUaq-0004ho-ME
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:32 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUao-0005No-VO
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:32 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2b4650d5f5cso31743705ad.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779474449; x=1780079249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+WCZC6SUBC071bfRFwXvhf4AY+W4PJMZ0UFTCQc+Jc8=;
 b=jfGEf0UH+xkGIbTdurkSsnqOk6o6leEn1J9HhomkB6g7JL33lLyX25C1ziA3goPhuE
 GdQglxVzIK6fGndcx/STBBzdn55nMomRf0XjHNTs7wH9ZWL1wjgYFl/zeaVkxmpYnaCk
 OWzS6ptpsgH/OQyrteGoxbFS72Q5CDJkgbTO9y8l8zH4zBHWsgxtqE5KUYidXB7oeDS+
 x+sDBKtdLk/i8c9RLhd/JOyKQ8gHAt23csCSeGn+P0LkYeI4dVuNku1m/q9fwxMeZ1B+
 kzGeS8gVAtAvgtuAAXvum4oy1MoVPwbDu3wcU7e4TVC0vocxeVXh6rIw0JKs+1D5HpHF
 Z2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779474449; x=1780079249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+WCZC6SUBC071bfRFwXvhf4AY+W4PJMZ0UFTCQc+Jc8=;
 b=AKe3JVTmo2XZNOxJ9viNzwztGLQGbJgz0mjI3nJBJS2SyN4gPSuATq6zVTzCDgG0he
 Uyf/C4BG1QMDphKrebt1XFhklVogWY9+99y5QihxAarzrDwntUhF0aTcyanzSaqwlgvx
 FBmITwhZbuDiuhpdXmqpP1Qsa6nuWu2s4F15vex99eMHf+SJniAqUhKzr+o6cwB5VqkG
 9vOFlesvlvqTVEf7kZUNR4vWt04PRZF2A7GP5XweHckuXYOodQDmBWlzx0JYj6M+ATaB
 hD/zvn2b7UDxw8vC9kEJgItHJR3//q4P39Y5wwzFcnTA1Jn4W1TP/ptztzq15dk8SqdT
 F6lQ==
X-Gm-Message-State: AOJu0YyIj9JGHUIP5EZ0dWjHdq2Kajmidj4iLJnEnM1Am7MCluSFg8xB
 URDfAQpmnbPql5H1E6q+ObuTzyJXINrPHz1gWc3G5S4pP6LlowyBokodBBRsEUh9zkWihThSXtP
 YS2GO
X-Gm-Gg: Acq92OHUwcOYg0Vpz8reVZTun7YXbLXA3Qz0nY1a63uInU25MabXvXpiHeQ4cSzPvWU
 B22r8y5IQaBmMIJsh/f27fXHlum5C2uhoZMe2byt8C7C8aoFXx3uR/m7On31Qz5PN5/B0r3BHBu
 V7WbmP+BRkBQyIFLrYMOQMviKg3ME8BJVZvWqFXTDAEaYiVYsYmyLwUtKRYxwCJYSumPJ3uYB2t
 eH9uSZxavLoV5QDqUcrDdBJlPnfZtFHyESLNOZ6bkqwADdYMkiGbxZ3DKuTmfIhVn7esGXcXKNQ
 JVlY6uhMd1lkmN5Ye4Ddioxpu3HZ5XSlM8XEFdtb558MvK1zrkjvweyndiOMyy3P+YHHatqofLD
 5tkeHr1CF1Icj5iVsJe5dw7Wz1lF/bK8I0Iw2B5cgzz6Wawz6W7GZYLMfwZuyt8N2sUBdghhkT9
 Y7NKowQSNixQWaOGrDTtURw+dy0prNLi/E6eIdUXk=
X-Received: by 2002:a17:902:db07:b0:2ba:3e50:e3f5 with SMTP id
 d9443c01a7336-2beb0634c8amr53733745ad.30.1779474449345; 
 Fri, 22 May 2026 11:27:29 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5900b8bsm21824735ad.76.2026.05.22.11.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:27:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/30] fpu: Use parts64_round_to_int in
 parts_s390_divide_to_integer
Date: Fri, 22 May 2026 11:26:34 -0700
Message-ID: <20260522182658.184604-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522182658.184604-1-richard.henderson@linaro.org>
References: <20260522182658.184604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

We will not expose parts_round_to_int_normal.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 905ba6ecf8..08ea56a71d 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5197,12 +5197,11 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
          * Rounding of partial quotient may be inexact. This is the whole point
          * of distinguishing partial quotients, so ignore the exception.
          */
-        *n = *q;
-        parts64_round_to_int_normal(n,
-                                    is_q_smallish
-                                    ? final_quotient_rounding_mode
-                                    : float_round_to_zero,
-                                    0, fmt->frac_size);
+        *n = parts64_round_to_int(q,
+                                  is_q_smallish
+                                  ? final_quotient_rounding_mode
+                                  : float_round_to_zero,
+                                  0, status, fmt);
 
         /* Compute precise remainder */
         r_precise = parts64_muladd(b, n, a,
-- 
2.43.0


