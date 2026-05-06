Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6927ECD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcll-0000Ba-CJ; Wed, 06 May 2026 09:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcli-0008Qh-Ks
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:58:30 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKclh-0008RJ-1b
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:58:30 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43d734223e4so633577f8f.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075906; x=1778680706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Jv9fwwqWCOIA7tkY/IRQQiea14CdYAGlBRTbGc/KAYc=;
 b=Tn6z0iOWcB9gM8lWjg1Mu6pcjSqyY4ChoT7A+xzwk6zkI9o82YnmOd0yQXrTWiVNlY
 gPdk5ybmw2cy8A2rZSdiKsW+3AbvSOQIQN3Uadz67VbbEU9yNLQv8wc7q0Guue/JevAq
 k+HxRMzSobZe9D7ACRUliP8/1n1Qz0wfh2UPm44jWg5U+lG/Oo4JwxaJpX28h3gv0N7J
 00/cyUlPnw3DcZJCbWdckVr2S7J3P8xIUFMaOEILAYQux9WBDEAKEPEPcr2nqdePgg2Q
 suxidTC4a+01yjVRPTTdKSdaJHcj3m5ZsrNCqQaiLLPlVLsIUABwlTJKHGxyBhT8JWQ8
 XrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075906; x=1778680706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Jv9fwwqWCOIA7tkY/IRQQiea14CdYAGlBRTbGc/KAYc=;
 b=nApILNI9y/iGHuYevNkFjm3ugC7Nbd0EUryJjhXLNDHNRjIRSHgwN/QFxxPK/2sSqF
 uzmKBYkmd3WheSnWAg9Bk6pz8rGVFtn09t+6v0AT5UnOeHgKHDReOfMmW4kgO3VvJK7n
 mQ/Sg1I+TyZs2g606LXcUx/25LItlq5Kgppo/k5uh8YOMWvQrB0C2GTLnDbdsSqye/4R
 kbHGoNr1umkrHqyIhMJ6U2ih7fKmZnbHnhzEoX1ccbhvUIvuUnw45kN2GuNNZhCZFmBY
 /lVYWWcgv1OrZINc5A4i6NJD+lFDgGbrxxy2frmvRRUpdpNKEugGPGtdaNEfGGwkmcFQ
 tDXQ==
X-Gm-Message-State: AOJu0Yzxvvdxx9ezQRl2472D6Ms6PUga1cWN/9V/huPJcblOBwP7ni6+
 omUh4lBZKeVzP+fzhNQpulOqS5x1J8vV37dpi109hxrfNmkZJ5Q+Lk9czbtnkwulUg4t887xPu4
 9Mppfve8=
X-Gm-Gg: AeBDiesbWPuJpegmpAo7SY/oBrKSO9nFdRxR12UsjOLlbrluvEuzXGyyhpk4osGk4yL
 pEsLOST9GGPsymSCz+g4ZYQw5q4fzOcU1n8D61PrL3eRbM8wsSxWGMGM/PqTsafNcSWlc5XhxnR
 Djd4Ufjef0WAELbU6J9UAJrtDTcuAMsU8ZA+knXkHRD52KZs3bt4G+WKgLuUy2OCfLym+3NddVr
 DKW8zJVoOmTS5fD1sMjGXEDi6jqVhUU6y80eb4UWtR6XynOlkikggZQK0LdCSowuRCLp8NJaXuV
 6C+GHdJ1kfoLF4uK4YRTU+6EFwmPB4HrEHjePMWZL4uL0fNkU8SdxqVGG5wGO/r08a8k395W5qN
 2/JWiZcrAgdEoQhYUg/JzvymHTygO5tFmiXvuVCmvqPHI9Sc12kCuG9i+4nvLiGuYFPbLTn4+na
 FlTWNF3pkbSO6oWQ2OWI6QriPIHyXtUkjxvLnCrHsyMGyta8COIZAy+Tp7VpSZ2zhsAotf8TBL/
 DtJK1xD7XE=
X-Received: by 2002:a05:6000:40dc:b0:44f:da08:179a with SMTP id
 ffacd0b85a97d-45165d24154mr5641798f8f.16.1778075906536; 
 Wed, 06 May 2026 06:58:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45052a48b23sm13024464f8f.14.2026.05.06.06.58.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:58:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 024/110] hw/misc/allwinner-cpucfg.c: make compilation unit
 common
Date: Wed,  6 May 2026 15:53:56 +0200
Message-ID: <20260506135524.20617-25-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

include "target/arm/cpu.h" is needed because of:
bool target_aa64 = arm_feature(cpu_env(target_cpu), ARM_FEATURE_AARCH64);

This file is reused between various allwinner boards, including 32 and
64 bits cpus.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20260312224702.1608408-3-pierrick.bouvier@linaro.org>
---
 hw/misc/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 245ab9b98cc..cd084a19363 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -46,7 +46,7 @@ system_ss.add(when: 'CONFIG_ALLWINNER_SRAMC', if_true: files('allwinner-sramc.c'
 system_ss.add(when: 'CONFIG_ALLWINNER_A10_CCM', if_true: files('allwinner-a10-ccm.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_A10_DRAMC', if_true: files('allwinner-a10-dramc.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3-ccu.c'))
-specific_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-cpucfg.c'))
+system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-cpucfg.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3-dramc.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3-sysctrl.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-sid.c'))
-- 
2.53.0


