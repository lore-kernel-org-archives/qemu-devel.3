Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1A0CF649E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 09:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svCSM-00052h-Ku; Mon, 30 Sep 2024 05:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svCSK-0004kY-Cq
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:12:36 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svCSI-0004gh-OW
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:12:36 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42cb9a0c300so31647385e9.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 02:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727687552; x=1728292352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EToKFctF2fRtYpb52soo3m8yr83BCZf/5mioMKUv2bg=;
 b=L8Y6AQHh799tW7TKo2t/YZQ6SB+Lso2wVe0mPLV/Sd0F8axe6JRotPqm59lcmIafbb
 8bAawoc4VP9mnRR36YGpmhVdZZnZ7uq8ToxUuYO+bTdoOGhnaRt800mWZ8+3E2Kh/E1e
 tAw+C6RGKZZToC4wP0dPR+/C8CZR1CXoOyfJjUm6DFHNJgAXnzC4jZBxm6jj7pJUgy+6
 CfZrnfy5Pxm47doyGLLjCV8Fy4z8JZS+A7GhINQBo6mWQxFL0nMaSe0tAZxmt8G4VSEt
 zpUeH7MvkkPOYzf/zv21bt47Por2ZYLvmcN0zjRsGVKTskKT6BE5xv8WdSy8TyLcU7UN
 KwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727687552; x=1728292352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EToKFctF2fRtYpb52soo3m8yr83BCZf/5mioMKUv2bg=;
 b=qskFoFVlTZum36JgkutnO3K2RdlyyZG1qslzXsBs5cWvs/eR3aMOq1U4ZbPKWzMf2G
 drLHUUEXqhNpWzSSsxtMVZqteY4q9GbWy8zRCjTXx4SxYLfFFzzAybA/qwUcFEwV5EZ+
 dQDk5h8Kvnwrw5f3qxqCTa0Cobq9HG4/KlPZG51EwUECZKFZHi9xRgdWfX9YxXS7zvAW
 KkNt6bYlXvzOmvYqKrPvoD+rznSKA/UDmy3uPNqf7dXRDGykCXyURZ7vPZ39Cc/dR+P4
 xbT9Z3ToBMtXM44zSUlPlcsYn7v0FI+jdjx8+s/Y5uR9RuFsVdOYKFd7shp0UKG1OKsU
 U/Cg==
X-Gm-Message-State: AOJu0Yzr45Pn3bD7H/8yowpbb9HOa0PJvN7H8BMY68PTzVkBIDbjmVet
 XeB7Z73WUAs7rKohh3MAQtKDo5vvQ+H9aaREzxECrXklr8I3L32X87MTuaoB05+oqwAnIRls6Qg
 A
X-Google-Smtp-Source: AGHT+IFNQ+dcllj3FH/1H792+7wbVFI2MZSpAoA7GTZoNegr+HAz4WlN3eoWFLqSIuVCmm04wDSc2Q==
X-Received: by 2002:a05:600c:4751:b0:42c:de9b:a1b5 with SMTP id
 5b1f17b1804b1-42f5849732amr77291775e9.32.1727687552382; 
 Mon, 30 Sep 2024 02:12:32 -0700 (PDT)
Received: from localhost.localdomain (183.red-88-28-18.dynamicip.rima-tde.net.
 [88.28.18.183]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a52915sm144727645e9.39.2024.09.30.02.12.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 02:12:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 12/12] hw/mips/malta: Remove TARGET_BIG_ENDIAN #ifdef'ry
Date: Mon, 30 Sep 2024 11:11:01 +0200
Message-ID: <20240930091101.40591-13-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930091101.40591-1-philmd@linaro.org>
References: <20240930091101.40591-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Move code evaluation from preprocessor to compiler so
the if() ladder is always processed. Mostly to unify
style in not using TARGET_BIG_ENDIAN #ifdef anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/malta.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 71cc11fc45..a3b6f63089 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1196,8 +1196,7 @@ void mips_malta_init(MachineState *machine)
          * In little endian mode the 32bit words in the bios are swapped,
          * a neat trick which allows bi-endian firmware.
          */
-#if !TARGET_BIG_ENDIAN
-        {
+        if (!TARGET_BIG_ENDIAN) {
             uint32_t *end, *addr;
             const size_t swapsize = MIN(bios_size, 0x3e0000);
             addr = rom_ptr(FLASH_ADDRESS, swapsize);
@@ -1210,7 +1209,6 @@ void mips_malta_init(MachineState *machine)
                 addr++;
             }
         }
-#endif
     }
 
     /*
-- 
2.45.2


