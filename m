Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA78C369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mB9-0000GL-52; Tue, 15 Apr 2025 15:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m5n-0008Vz-UI
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:37:18 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m4z-0004UU-Gv
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:37:08 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-736bfa487c3so5231355b3a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745766; x=1745350566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tLVTPuIhKyJGLJg0g4g6O/eA+lFZMtglqXcxP7e68KA=;
 b=yYa+mtGazHtw8F8RjPWbvTuVz9NxXZ6CT5BiV97ia/Wjcrd8FicEz5v4NP5nUCfCgq
 Cn0X0Elvk7yri9W3b471/UXUbwtz5r1DCRj+i9pTOQcL1XOgBTdKHGkTMa5psWyWZauc
 2lj/ufzgT03U7KcyvQeXOUxTCMSRobx0+FGEYDApCQcDfiX0sKhMiHB6246IXH/piFD8
 5pW0VTTPENgKtuRbLBj4shc3qLXcbz7ae4Oh7XYK5jX7y+CWuVzKcBWQ8IyopqMopm+Y
 EErJtI/6KN9DD3iqmIB1dsEzsylprAPYRFHqo4EExf7xn4TG1k9ivR5PF6nDuXFzwxDo
 kQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745766; x=1745350566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tLVTPuIhKyJGLJg0g4g6O/eA+lFZMtglqXcxP7e68KA=;
 b=T7HbBOQW+od1VW4JxGG/j9QAXUkRYDLUMqCg4qBT6gxywMxlN93vY42+YfODW0cHa7
 cACv0qqyFtSLy+7apSP0AejiJgR+RQ3ZZROnXXgEgwjmjcPZGCsZL2XHl4LtpQr4o0UE
 g4pXFos21iEOAg+pehevraY0S7EiJMyTHrpdSnKAkwEpR3wzrH6JeWwswByZwhgZPAC0
 x3bJztR4pRrgwWTT5sc+CffO0RFa5wWGjx++yT6t9GF4P9/tX1aXx6c8bdo7S6bXwz0f
 N9aOLjSM3HFr8VFwT23ALd7pmjbqdEDHFpP6Pze72qwemevL8UHVQbc3vXgLcoNJnayS
 BWag==
X-Gm-Message-State: AOJu0YxfgfRMOoso5phn8SBe4HSU+Gx/tA82/AOdnZMizqxInL3+S363
 cuXV5FbVv9v4UusK7YB5BllSM+TIkAslPkZkocPiPbWhI5ZGdZ9W1mQmE04HMsksb03NCy5cthX
 b
X-Gm-Gg: ASbGnctwzgPRRAO6RskoIM43yX0nK1KHt3xIeCivQM0L7RkPMpMwBYzIE3tPKo44CX2
 xHlGOO4jsm5EJ9Xh+D8uoe434VmvPeq2fcKbr2z/w84q/wUCDgWZ+/ej6SnlzLPvUXeYe5wFZLZ
 JTKha2YhFZAAHTzpgamx3GIrdYsOFBy8INbw3CHJg4W3y4HhRm7B/aO7rXyfgVHIZIpJTLwGLVj
 1748aEFNF8AnYmHrDKkElRSwMpj4wA+FfuQCjACYRyRhPNcJc4qWRrmkz3eWJA3Q19PPLwO4R1N
 uNnAzBzXydd3FNMM7OVv7V1hNk66XHI9aO6bLosYYqV26bnRbkQVzl1uFmFTkGY8st/9emjXbdg
 =
X-Google-Smtp-Source: AGHT+IEV+DhadOY7wy0agZCyC+xxUkcNQeLh2jo30/KXAopvMFQqek9YhA1KZnUTljjgaKOa+isRHA==
X-Received: by 2002:a05:6a00:802:b0:736:7a00:e522 with SMTP id
 d2e1a72fcca58-73c1f8c6a2bmr935230b3a.2.1744745765686; 
 Tue, 15 Apr 2025 12:36:05 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.36.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:36:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 130/163] target/sh4: Use tcg_gen_addcio_i32 for addc
Date: Tue, 15 Apr 2025 12:24:41 -0700
Message-ID: <20250415192515.232910-131-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
 target/sh4/translate.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 2ef48b1d17..e8029c0c7a 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -694,14 +694,8 @@ static void _decode_opc(DisasContext * ctx)
         tcg_gen_add_i32(REG(B11_8), REG(B11_8), REG(B7_4));
         return;
     case 0x300e: /* addc Rm,Rn */
-        {
-            TCGv t0, t1;
-            t0 = tcg_constant_tl(0);
-            t1 = tcg_temp_new();
-            tcg_gen_add2_i32(t1, cpu_sr_t, cpu_sr_t, t0, REG(B7_4), t0);
-            tcg_gen_add2_i32(REG(B11_8), cpu_sr_t,
-                             REG(B11_8), t0, t1, cpu_sr_t);
-        }
+        tcg_gen_addcio_i32(REG(B11_8), cpu_sr_t,
+                           REG(B11_8), REG(B7_4), cpu_sr_t);
         return;
     case 0x300f: /* addv Rm,Rn */
         {
-- 
2.43.0


