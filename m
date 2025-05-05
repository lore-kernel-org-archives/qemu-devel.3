Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DB3C3ABB9
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl1G-0004b9-7c; Sun, 04 May 2025 21:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0s-0003xR-EJ
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:59 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0n-0002av-Sn
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:57 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7376e311086so5536795b3a.3
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409972; x=1747014772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d146Pj4KjTAmT+769pG7plO/J3O67dCMeGHKPEFKjBI=;
 b=sEkqx9PM+veOURtE60uK+BT4H8J2CrV6TZYHGemFQBvh3wbfVy+X0mt/FfWcOPnFEk
 FZxL946dpQqMjqitdLPM2XDhf7EvrNvBBhtGXZTeR8PT52lDMCZV5cefu9KAjekoNp/v
 fYGHKdn5jD82pE1zNdnfC7WkSQ4UPneLHaqZcrBzxC0MHGQAfRx1V8x8BFKP3EnfM/gy
 hI1PNX3Mgx1yZqitEdOgnkiBXKAIvXvWfLIJI4waMl+QkH9zlmo5UMPrTleox1mmzGrP
 GfGh/7xML1mSnc9q7KpQIYpI39/80PPbl6PtqpLcxPxYNe4OJqqWiqE7gJ6CRuI1ihA0
 Spfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409972; x=1747014772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d146Pj4KjTAmT+769pG7plO/J3O67dCMeGHKPEFKjBI=;
 b=fRH508xcUYJf9SAH/G/mw/lbN9O/Kx9veY2zTAj3WYYg+JHyuKjkw28PMQJGiRMiKs
 ytsPGWMH+olnP9gOg5G0wOhtMn7y+D78iF0w8RYpGKklFFI55T8hzcXMpFJrEcNXqlUo
 aSqSNAn6MehDLeTH9N4oeOJ85/y575ixP8Yb+cUozoIJIiF787dPL4XthISmRuUbTBjD
 G5kI1grPc8Tw+Wk/TRn1C9oO62HLb/g4xeMF0F4kNiJEk1+mhLr9mhslpSsnBXB74xqY
 jJJi5PPLjQm026D2MW7/gsRfV8SZXu05ApTy7BuyXp1z6YtjmRcjOSRpl9BTDLJW9pdE
 f5HQ==
X-Gm-Message-State: AOJu0YwXPppde7sG1CwK0RDPRSL1pO7coDo7TOj5Bmyx2f75R/Lkj1lB
 gUbf+4bPlQvYospIGwB9btJy0w+9dbFIAEEcueQuMslpQ9wA73gDDhGlFb67UpIpkMLutcxA7Sk
 owQI=
X-Gm-Gg: ASbGncv8kGUn44ieNp3cnns3SHHBek8LOO0MAcVOsSupAiByn13TgUNTnbCdd9qth1g
 TGnPChycbrYv5YxSKBMfwUeTq0AcszDtlmZ/8Mf0x+hRp2P+1TgQwoyyi0NRDKhfSlnyr/Z72aR
 3mn/Kc6ltPrSN67z0QwL008rNi2NykpxN/r4vOUsmvUbOIyrHaZG9gZWgvPfYrI7fQ5RHLMbhkC
 NPa3kinAaCLrH09crKAOsJ7xjxBFCyq61H/erVu3LvIxN6+GSawlXFQD/L5AXoVjx42qlY7j7U2
 DHEyGYjU5yUZAEaFP2j0QzfZWDB6WHtgzNOuR/VP
X-Google-Smtp-Source: AGHT+IGZ69sv3kczzHn3t5JXlx8OboELStxZ9BcN0YDHiBVacizLgdUVZrm/NwDxt4C9RQMegT+mlw==
X-Received: by 2002:a05:6a21:998e:b0:1f5:9431:46e7 with SMTP id
 adf61e73a8af0-20e97dae814mr7597572637.42.1746409972003; 
 Sun, 04 May 2025 18:52:52 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:52:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 26/48] target/arm/vfp_fpscr: compile file twice (user,
 system)
Date: Sun,  4 May 2025 18:52:01 -0700
Message-ID: <20250505015223.3895275-27-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index c8c80c3f969..06d479570e2 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -2,7 +2,6 @@ arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_ss.add(files(
   'gdbstub.c',
-  'vfp_fpscr.c',
 ))
 arm_ss.add(zlib)
 
@@ -32,6 +31,7 @@ arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
 arm_user_ss.add(files(
   'debug_helper.c',
   'helper.c',
+  'vfp_fpscr.c',
 ))
 
 arm_common_system_ss.add(files('cpu.c'), capstone)
@@ -40,6 +40,7 @@ arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
 arm_common_system_ss.add(files(
   'debug_helper.c',
   'helper.c',
+  'vfp_fpscr.c',
 ))
 
 subdir('hvf')
-- 
2.47.2


