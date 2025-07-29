Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A510BC83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 12:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugiz8-0005eK-1u; Tue, 29 Jul 2025 07:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugiyV-0004TD-0D
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 07:58:32 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugiyM-0006Ht-EP
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 07:58:29 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4563cfac2d2so56897535e9.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 04:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753790296; x=1754395096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8k1VWDR5NkXCZxjy6qK+jjWf6Lwqctes1t+lFXTWiY0=;
 b=gVLGqHaJcTEztHGuLL7UdyPCWQTVvMq1u7sVZJuSEfSDYxwsoWkd8IKx57mqi0gR/z
 W0u/DXAcx3VlN32KIDIvKEhGM3x4mKCaCZLMg/hnl1VnepLI4F26/jVu5AGCeU5C/UGN
 UshwkUkNi4jowmBmgfgOYWzWe7hDaIu3KHzoKamdTsO7jCqukri7+OERkJaI/1Kzs1rQ
 0V4ls6G1dH059aGy+snXume1yX4gnGUTfaK9vVrOoqX25T7l6f8RmGEF6Ft422qdi7NU
 Gnd6V9ja1rICrwQG9IBfbYYGwhhEgZ9PEm94+WQJQCeGVW1tt+m+f83lQ28QY3Xjta4H
 0kXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753790296; x=1754395096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8k1VWDR5NkXCZxjy6qK+jjWf6Lwqctes1t+lFXTWiY0=;
 b=d1bNUX5t9O+hqsmFtykxNL9ZcwCMdialo47eby0Kpf6hPiYhaFdAlVi1m5JxZCzDmp
 92Sh+Dsh8f+NrrhaG3AH54wQl/YNENlzTMOprGltqj8CMHjWigzgzqkH5FjjnupfAz7y
 3RENuwcNdRD9ZbDmAEjrkeXqaBKU9FLmMCOEZkL1q4UuLDJHOUGeK39JWgv1BHd5Tvja
 TqeJAfxdBWRK14beTl37YaOj7Wj/mYjpwELendi/9HPF5ltWLiqFiL9nSIk+OS6GVsaF
 7RI5CDC2GCW0HhCahjpLy4HBxB2dFNUluQB8ZO0LQO9I6B9bkcDqu6lLP7oyR85PnZ6K
 dzfQ==
X-Gm-Message-State: AOJu0YzVM6YRK9WAL9QaIp6ULyn8OdG31lK+F0/mnVMIwZ7xeMPn/+PU
 h6JlagK/czFyO07B4rY1nxmD3qcCVr/yU55qkuOGIQeF8misbg4fsmIZwn3PWIGWns0zcODMdw8
 St2ii
X-Gm-Gg: ASbGncs3UTBbNyOMfwKIqgE7b0pYMHbkY+kvmiKB8jnDj6Zq0vOQ+J35rdjeFxlIX+6
 WJHAFILlMOzxQjrt6TpyonK/3+bg9MEPCPsybu2WwxJHOgMeHXkERKYPdnNUo3WrxODxhZ+1mAa
 KA+rVcPpL+4jdLJaGGtKs93TIXMX+93/ytcO2Hwq+AL/IAYGdCz3w2cWaZbhIH8HYYo/hE3xtV2
 ozMzlE6ex80DptbGPWTqXH7aDmuwCWYOcyqtGDmTYwS8hSUOa7rYnfLRPhu5b4wQg17f5zOn2o8
 uVXLAlmpdO5c2vBqDh0lvSJcLMouX0OjX5NwdPjceqmTVWBjFaGO3/DSRZG4F8ZCz1f8yX/Y1Ke
 uY248jl7LT0G+Z4WPLVtBM7Gf2xZZpq22fRv2kPewyOBmR3dakMd1ARY8EjEA/MbmH/wv0dKxoE
 B3JB+XDPo=
X-Google-Smtp-Source: AGHT+IHra7rFXFucz6wq1J1jpzusPCMuSvwop5muRiCJ1KmnClcXLn84E4A26jZE4H5OckCn6Cv1Gg==
X-Received: by 2002:a5d:584e:0:b0:3b5:e084:283b with SMTP id
 ffacd0b85a97d-3b776726b06mr10991742f8f.17.1753790295764; 
 Tue, 29 Jul 2025 04:58:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587272b405sm172160525e9.19.2025.07.29.04.58.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Jul 2025 04:58:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 8/9] roms/Makefile: fix npcmNxx_bootrom build rules
Date: Tue, 29 Jul 2025 13:57:33 +0200
Message-ID: <20250729115735.33619-9-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250729115735.33619-1-philmd@linaro.org>
References: <20250729115735.33619-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Michael Tokarev <mjt@tls.msk.ru>

Since commit 70ce076fa6dff60, the actual rom source dirs
are subdirs of vbootrom/ submodule, not in top-level of it.

Fixes: 70ce076fa6dff60 "roms: Update vbootrom to 1287b6e"
Fixes: 269b7effd90 ("pc-bios: Add NPCM8XX vBootrom")

Cc: qemu-stable@nongnu.org
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250727215511.807880-1-mjt@tls.msk.ru>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 roms/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/roms/Makefile b/roms/Makefile
index beff58d9d50..6af68a922f3 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -193,12 +193,12 @@ qboot:
 	cp qboot/build/bios.bin ../pc-bios/qboot.rom
 
 npcm7xx_bootrom:
-	$(MAKE) -C vbootrom CROSS_COMPILE=$(arm_cross_prefix)
-	cp vbootrom/npcm7xx_bootrom.bin ../pc-bios/npcm7xx_bootrom.bin
+	$(MAKE) -C vbootrom/npcm7xx CROSS_COMPILE=$(arm_cross_prefix)
+	cp vbootrom/npcm7xx/npcm7xx_bootrom.bin ../pc-bios/npcm7xx_bootrom.bin
 
 npcm8xx_bootrom:
-	$(MAKE) -C vbootrom CROSS_COMPILE=$(aarch64_cross_prefix)
-	cp vbootrom/npcm8xx_bootrom.bin ../pc-bios/npcm8xx_bootrom.bin
+	$(MAKE) -C vbootrom/npcm8xx CROSS_COMPILE=$(aarch64_cross_prefix)
+	cp vbootrom/npcm8xx/npcm8xx_bootrom.bin ../pc-bios/npcm8xx_bootrom.bin
 
 hppa-firmware:
 	$(MAKE) -C seabios-hppa parisc
-- 
2.49.0


