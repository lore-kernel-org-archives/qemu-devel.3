Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3A8C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 09:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl2rw-000800-MW; Thu, 20 Feb 2025 04:29:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl2ru-0007zG-Si
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:29:18 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl2rt-0003Od-Dx
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:29:18 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2fc33aef343so1461025a91.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 01:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740043756; x=1740648556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f7n0sYwrB8IT7jhirk9RyIiTw/ke91kLSgIHGTYFSYs=;
 b=V1NNQNCTK6RAuJ0CHJVLVb8oVSoESYTMVsBWFJNu0LGyxsVnXy2GB2ppo2Ale433jt
 ki8bTReOFywM4UQC6Kd8URDpR3Kxu1vFW/stlua4KmG/Pw2L7KXMR7mMpnfUft1jNFm5
 kjUefrtJfLMCRh7RVz7o1f05CvabBpiBXpsJ5syT+w/QUO1GMjARMavr9htnviOAhHmg
 USemh6XeL0Bvb2nytGdLhQSRyKFoq6b1P7t9QFsXf3JOR9suX0fa9VBvWk0UW/a4xVWG
 YFY+H0t8UqcBTL/T5tPYniBy/je1pPAorivb/tRvo1oyRWC9d0l4Q9LuLT5PErsJztcV
 kwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740043756; x=1740648556;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f7n0sYwrB8IT7jhirk9RyIiTw/ke91kLSgIHGTYFSYs=;
 b=i/wM4EhZJuGFvO1aLwnsoUvDtFk7Qxlc7MFlicnf/y0z1hVnYinfFlK40EFuCHAoia
 HXO+YYT4jERxySOpP04AK48+SZ8BaG+HNpUKNAcFeQ+oQBXgUvRmnGxbwE6K8y0FZCxm
 JFyJ5rT5EIlX4hC5uq/cu3jWenHmZE1FGtgAGo9zRGNS5GRlFFgsWUSlXmp7wRnXTsLq
 MifW6DyprdwcfGPS2ABP3sAZlKrpdFiclbO6jW91wTlLvcasy5sUC4prGOBc7SeSYMNK
 EZ7YmqJ5uo02NRk9WkIAZYK1wBVga40+q2XNFjdR3Cz63lKdfvoJ5owEtKTTkdYm+F2a
 uZig==
X-Gm-Message-State: AOJu0YwwfJZdyIyJc2fYRwrJSKv4huNBjsPSRO1KUT09gvVXpdzoqF0O
 Vuz45ELQJBe7KQKN06jyHMVQWGomGlChuA1Owf6N5qNUYE/B2I09IC+upG56MeCLSIr/wWGsUZP
 a1Fw=
X-Gm-Gg: ASbGnctNWzPQmQtUFWsZgZRR9pCm645+zz585MzJ5pyX/I6sLCKaewBNvPnhs9WIwVD
 CYg8b4FPuHzU8Byw5ey6hVMKXPBfTl5ZdlxwPnrnb8BTl75QAfRJjLawu4Y+ePi7+usK5RjSkJm
 ms0Y3Ow1GlfTGZ1vGL20Sv6dKWypBKOVklk5+qFk71wNmlyA6g/rWb6MAUZjWwXxqpD1crTIg3C
 GHS9964hs02TIbtZotW1KFQhaqPPHJLjFhU63fspZ3GDYZv7vD1c081ioTgXwe305zk04CuA0F8
 dRLfw5ykX/l1OtSkDxJD15xN1dNSaJOVH2RkfWKL1rhZxpK9sXHAPAQqpN0XhWmNgg==
X-Google-Smtp-Source: AGHT+IG2Q3SYtbCe4wTkUv4WZF8hYqRULU15v/XV9f3q2XdUUXN3lL352G9sZmm2sqDD1X2AbWrY9A==
X-Received: by 2002:a17:90b:180a:b0:2f6:be57:49d2 with SMTP id
 98e67ed59e1d1-2fcb5a36812mr12484165a91.17.1740043755174; 
 Thu, 20 Feb 2025 01:29:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf98f6965sm15329037a91.29.2025.02.20.01.29.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Feb 2025 01:29:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>, Thomas Huth <huth@tuxfamily.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Rayhan Faizel <rayhan.faizel@gmail.com>, qemu-arm@nongnu.org,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc.michel@amd.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v2 0/9] hw/char: Improve RX FIFO depth uses
Date: Thu, 20 Feb 2025 10:28:53 +0100
Message-ID: <20250220092903.3726-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x102f.google.com
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

Since v1:
- Fixed typos (Luc)

Some UART devices implement a RX FIFO but their code
(via IOCanReadHandler) only return a size of 1 element,
while we can receive more chars.

This series takes advantage of the full depth.

Inspired by pm215 chat comment on yesterday's community
meeting on the PL011 Rust implementation description by
Paolo :)

Philippe Mathieu-Daudé (9):
  hw/char/pl011: Warn when using disabled receiver
  hw/char/pl011: Simplify a bit pl011_can_receive()
  hw/char/pl011: Improve RX flow tracing events
  hw/char/pl011: Really use RX FIFO depth
  hw/char/bcm2835_aux: Really use RX FIFO depth
  hw/char/imx_serial: Really use RX FIFO depth
  hw/char/mcf_uart: Use FIFO_DEPTH definition instead of magic values
  hw/char/mcf_uart: Really use RX FIFO depth
  hw/char/sh_serial: Return correct number of empty RX FIFO elements

 hw/char/bcm2835_aux.c |  6 ++++--
 hw/char/imx_serial.c  |  8 ++++++--
 hw/char/mcf_uart.c    | 16 +++++++++++-----
 hw/char/pl011.c       | 30 ++++++++++++++++++++++--------
 hw/char/sh_serial.c   | 30 ++++++++++++++----------------
 hw/char/trace-events  |  7 ++++---
 6 files changed, 61 insertions(+), 36 deletions(-)

-- 
2.47.1


