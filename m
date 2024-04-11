Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFBBCD1292
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 10:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rurUw-0006BR-0p; Thu, 11 Apr 2024 06:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rurTr-0005Bk-Vm
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:16:32 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rurTm-0007V9-5E
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:16:31 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-343c891bca5so4897311f8f.2
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 03:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712830583; x=1713435383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TngF+9Flkc8Ihe+8OkjidPkiP1940GOGXxohU6xSHFo=;
 b=Bvd2d0jIKuuWpq3aXGxTREH3PuavjFdc9GOPgWMGu230MvDukKBJnYPFDudeQfhCYR
 uVCxh2Vje6zy6Iaopn1Zo7dFHUkPQzYMlbOJ0c1jbM9MDtWj33M845foy3XFlqYlDeu8
 IxAaGgIhPesPMiWNRpyaz8a2XapDd1/EEZzt1RBSnJCNnvj6koX/iv5o5DHc0pf1fPPt
 Q9QTOoRe8U5dh614w26Vu+CmJvVQdUGRodYO83WIHkBje/yHetopp3B96CM7J7LRKDCG
 nIrNQBkDJmfvTTFOzN7qvsATe/jK04HwoZIwUceriia9qHF2JMjNvOruqg65Cn5rRajA
 VwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712830583; x=1713435383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TngF+9Flkc8Ihe+8OkjidPkiP1940GOGXxohU6xSHFo=;
 b=RFM3yINGsKeR0DT0SHPcNowVj+hDUOE1COg6OwSH04qC9/GfLJfyzUs0Pol1Qbdtbd
 lQOHYX1V9kJjM1xd9LeNXYTSL8C4i8Lk0UlttdpOV7vo/4Ga/oPixDxcL9NR4ocdZD3z
 X+eAFRRG490IP7w8fiuqkPopJJ0KkkjiayGkH/LGhH2FSC9PjbVdgh53Tq4LQWiPXL1H
 sZZ4L9yDvtS/gXTs4ga5Qb/ea56vo2pIuFpdAQPfPjP51rLd/o0H7bBtWycErcygBYrv
 xmZ3vf6fysp2dJXN/iSx4XBqt6ClqWmsvFGDwJr2LEYQsVHF+b/Y3nKVF21NWRBmd9XE
 6THQ==
X-Gm-Message-State: AOJu0YwU9TUqowG3KMY9r7hszvwNLYmH77xFzNmV+O6c4eQWoxA/9wa3
 5SiQ2CUOG3VS8deQQPVFEnXC734YlxJQDMMftcVA69FaPn+T83d2RzlvfBoadepXfMJ8fYLVWZx
 GwCg=
X-Google-Smtp-Source: AGHT+IFr4kWKlSx9Mg10izvC3Z0ZvArjeCv79MrwZfhQdwYXPdXAzPjFDzxiA6LLEQ2WakAqohoVDw==
X-Received: by 2002:a5d:644b:0:b0:341:66c2:3dbb with SMTP id
 d11-20020a5d644b000000b0034166c23dbbmr3737072wrw.30.1712830583121; 
 Thu, 11 Apr 2024 03:16:23 -0700 (PDT)
Received: from localhost.localdomain
 (137.red-88-29-174.dynamicip.rima-tde.net. [88.29.174.137])
 by smtp.gmail.com with ESMTPSA id
 u7-20020adfeb47000000b0033ec9ddc638sm1413671wrn.31.2024.04.11.03.16.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Apr 2024 03:16:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 05/13] hw/mips/malta: Replace sprintf() by snprintf()
Date: Thu, 11 Apr 2024 12:15:41 +0200
Message-ID: <20240411101550.99392-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240411101550.99392-1-philmd@linaro.org>
References: <20240411101550.99392-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
resulting in painful developper experience.

Replace sprintf() by snprintf() in order to avoid:

  [120/169] Compiling C object libcommon.fa.p/system_qtest.c.o
  hw/mips/malta.c:860:9: warning: 'sprintf' is deprecated:
          sprintf(rng_seed_hex + i * 2, "%02x", rng_seed[i]);
          ^
    This function is provided for compatibility reasons only.
    Due to security concerns inherent in the design of sprintf(3),
    it is highly recommended that you use snprintf(3) instead.
    [-Wdeprecated-declarations]

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/malta.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 9fc6a7d313..5d33aa5123 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -857,7 +857,8 @@ static char *rng_seed_hex_new(void)
 
     qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
     for (size_t i = 0; i < sizeof(rng_seed); ++i) {
-        sprintf(rng_seed_hex + i * 2, "%02x", rng_seed[i]);
+        snprintf(rng_seed_hex + i * 2, sizeof(rng_seed_hex) - i * 2,
+                 "%02x", rng_seed[i]);
     }
 
     return g_strdup(rng_seed_hex);
-- 
2.41.0


