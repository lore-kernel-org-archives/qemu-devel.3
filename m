Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9A2C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8REE-0002Yk-Kg; Fri, 25 Apr 2025 18:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAw-0003hg-MI
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:43 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAs-0001rU-UK
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:37 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso2343256b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618733; x=1746223533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v886I5H2Mw8qQp5f4MKKqQgb6gk5xn9nu28E/SnRfuE=;
 b=Voc3B8qXS+rYJBvMawtsWOAqOxuvwgYus4P8N6aPxki70yQZSRXR/BHS3/pMW61rP/
 kbIJvBCdOWWrwU2uqMtYYRGEjiWfurW+pE5uQf0yt0agJ4ff4nIhb+728wz6TuNwzO/k
 9TyfIHbcb1NVGAXXl5LS3H77W/z14DYu0jbXWTmpvl3LRam+8GPIkGMCcnXLnzaGBt0R
 YFq4Gh2XRtkrfwsalNFjepT9NirlnnhnWvdRUqONQTEOneVOHPS0qNgIFcxVJXdfyTJy
 KVMYvz5zmW5S6n6VJjUwcvY9XtKco8POj3H1HzJvz47ImZrNroS8gHAc2+9doY3fI4Hm
 AvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618733; x=1746223533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v886I5H2Mw8qQp5f4MKKqQgb6gk5xn9nu28E/SnRfuE=;
 b=EWgXyKTpd9mS1dRNni6RTOiBOMN3INn4dsOnzRaRLbV3FZWXr8rcMq5qoF4/B7xVWU
 ITYpzIByWGPGqS6+ION397r0hamE9LqwaMJwivka7Rpj8W4A0OuFiJPSfR4OfswHhuqs
 ESuHIFfT21fiKJI4e41wHlirOebUqpS77M8L+7p5gpFIv6r3kgJ5dc5mpCHAH4YhZZ8e
 uRBYC3p9RQTkeVcoV47pQI4EAA50AmoA4Va8UsilIrtPcnt/W4sR6cvNaVwwlctekRVR
 ovWPWcTXT3va5WvP5Vvs6wPQCAgc9+mAHotG4alCVBNbE9ZBo16TkB/dtEdTwp4z/tUJ
 kmZA==
X-Gm-Message-State: AOJu0Yz6AeQnzdtWH3uK4O1/Kg5HWbTuvvEYDa+eeQut++p5+ZXmvDLI
 Z/9C5EOObElDQqRmEQIzfip1hP/ZNuXPcK7AzIsH8N6Wu7jrXs5ObQRoLy11uTKX7ziDUtUccpL
 a
X-Gm-Gg: ASbGnctvj3o9E4MfC0lpatir9sCxJlWIH83QHVYVZ5BjT0IcLcmp7/V5pv+w1OtdW3I
 pF9/zU7CdUh7We7YCZ6y1iCV1HPSV6EyW2DVmxztxd3TrjVmub7lZLagAXiFEhSvkoOL/ChfWjP
 FnkB0i0oNXuSc3O3oCqU8yun3i1WeeYmpTs1WRD8HUfLz/29pQMkld+dyjs6H6HtDzNYUErFrZE
 YYpNQI7AuCmGZFuUDQBzXUDhH849lwsE+yXj+hDpReC52Aok/N5/61nbw4kPS0wUilmYfbdW5K/
 ogtGdDY3K/bpH7j8rqAgtDkMn13t9fpaH918OxsGPRoPPji7NhjVe4Wxo7nmnxZuHqsh18FIEA7
 JqAgVn9lZjg==
X-Google-Smtp-Source: AGHT+IG19iAxxn3r0apWc8t5eOOA/8OMfJUvyT0DbBj7c67oqFMYhBUo0Z5HARfQ4inQg5GIlwBr1Q==
X-Received: by 2002:a05:6a00:2306:b0:736:4e14:8ec5 with SMTP id
 d2e1a72fcca58-73fd7cba6d9mr5080412b3a.11.1745618733544; 
 Fri, 25 Apr 2025 15:05:33 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 133/159] target/sh4: Use tcg_gen_addcio_i32 for addc
Date: Fri, 25 Apr 2025 14:54:27 -0700
Message-ID: <20250425215454.886111-134-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sh4/translate.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 712a57fb54..712117be22 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -695,14 +695,8 @@ static void _decode_opc(DisasContext * ctx)
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


