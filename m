Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D409C0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 16:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGxN-0000Lm-Hk; Tue, 21 Jan 2025 11:18:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taGxL-0000Ks-Cx
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:18:23 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taGxJ-0005yy-Fl
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:18:23 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3862f32a33eso2696020f8f.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 08:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737476299; x=1738081099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QiLkG+BdnmN4Ze7Mdk4m092sKf5xWkvFggAcIbmlvGk=;
 b=daPZ+uW46ZF491v6zAI9yL/HgLEtVeOt1Swa/I1b7mes7nVfO0rj6Qc9kbeNtKwsN8
 xIH8sAj7pVJbWSjIb0p9lGEAZGFWdDzpXbyC4SZf2wfkOpf60PNbsedlf4EFoZAfGjDQ
 LGxmWyLEftblB8M4jUQjy/lFC4srz8i79e20Yy+P02k3JWuj+3aFyinp3Ky9bW8Lcu6M
 i3D93PbaQTUGqsV+Bt7Whhbp1WZkt85cVDZCb1ZQmhqMcGbk4Jl/TWgxQSiOSVAW4Cre
 GgSLNL9Sf/bTYlOWq1uE7lp1hCJS6TSir0211v/CGzQTOaAfvnP5PV4ZDHFeMJHpCXEp
 PzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737476299; x=1738081099;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QiLkG+BdnmN4Ze7Mdk4m092sKf5xWkvFggAcIbmlvGk=;
 b=XvTD8B8O6AN86SslbQVP1C3ZQEZwgaOPDnCt8CDQR0nz1Aa1Pa7Aqy7Nl3SVcax+Pj
 SB/2QH1U2WZSFyi5I574r/7FJRLKvlIJOBaWeg/tpn0beTGW0lDglQkIreRmPrI0FfGW
 3iH2ugrAAp5TvxW0+Zo6zE/Ce0zJxdJRdkyLj37aIjOM8Gr2iItpNkcTq8J0EXqudlz7
 2v+z2LybUvE/AUSFIurqbcNxpQ+1hf+OMXbJSSycaQOeyB9qnj0pPkwRB586mAXES09Z
 L68qmXLQlSbDRCby6SSDg1Waty3lQYLOFCjFr6L4H8bUhOASiJ5FT1NPwz+fn7gbS+nX
 DhUA==
X-Gm-Message-State: AOJu0YyBf8T7ngWDJyDGaqrnqHqmUEvSh3GFf/3Wab5SHeY0McVjQNRI
 QHA//saIb8fOdsQvFRS8LKq6ZzVYjMQF5iAvPkA99gcy3r2ocN4XxNpm1uCRjSpp4L7Lk2tmAXX
 6eU0=
X-Gm-Gg: ASbGncsMxGTNZAZVofQZuLe0KGmYUnXF8oBHwbecTMT5JlUlo49rDCZ1RieW3ybP5M0
 aYKgRyR/9OMSprGQ729ghe7E4l1uQ3sUDwmwNNt5GGRMQKERAFNfTRN1OCC7lcHZkIiAeujXgan
 lGW+jmPlhzd6s15HeXSvvpguTRxQgZL/vwqSTauLUm1VbfEa6HLxXBeLzRnVOzHor4js7ZF63P1
 KknApL+J6tioklXXPmu4yGRMSBbBw33++vv1G5YsvOI9HNLfJucaT8rXGZStiQic3+LNscvpcbN
 PkZpYWHokLOj99r8fHV5L9ym0qBJEF5f+dLVNYyqVPXX
X-Google-Smtp-Source: AGHT+IFO6+nA387HIPbZgpDy0jJBtnDXw722R9GkQPAsMp9u3fXvMJK37TNcv2SVSkcZvyfyTBotBA==
X-Received: by 2002:a05:6000:2a9:b0:385:dea3:6059 with SMTP id
 ffacd0b85a97d-38bf57b64d5mr16310805f8f.49.1737476299225; 
 Tue, 21 Jan 2025 08:18:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf321508esm14006876f8f.10.2025.01.21.08.18.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 08:18:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH 0/6] target/mips: Convert legacy qemu_allocate_irqs() to
 qemu_init_irq()
Date: Tue, 21 Jan 2025 17:18:11 +0100
Message-ID: <20250121161817.33654-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

IRQ cleanup in bonito64 in order to remove legacy qemu_allocate_irqs
call in target/mips/.

Philippe Mathieu-Daudé (6):
  hw/pci-host/bonito: Expose output IRQ as QDev GPIO
  target/mips: Create clock *after* accelerator vCPU is realized
  target/mips: Initialize CPU-specific timer/IRQs once in DeviceRealize
  target/mips: Pass env to cpu_mips_clock_init()
  target/mips: Move CPU timer from hw/mips/ to target/mips/system/
  target/mips: Allocate CPU IRQs within CPUMIPSState

 include/hw/mips/mips.h                        |  2 +-
 target/mips/cpu.h                             |  5 ++-
 target/mips/internal.h                        |  3 ++
 hw/intc/mips_gic.c                            |  4 +--
 hw/mips/cps.c                                 |  4 ---
 hw/mips/fuloong2e.c                           |  8 ++---
 hw/mips/jazz.c                                | 10 ++----
 hw/mips/loongson3_virt.c                      |  8 ++---
 hw/mips/malta.c                               |  8 ++---
 hw/mips/mipssim.c                             |  8 ++---
 hw/pci-host/bonito.c                          | 14 ++++----
 target/mips/cpu.c                             | 33 +++++++++++--------
 target/mips/system/cp0_timer.c                |  8 ++---
 .../mips/system/interrupts.c                  | 11 ++-----
 hw/mips/meson.build                           |  2 +-
 target/mips/system/meson.build                |  1 +
 16 files changed, 53 insertions(+), 76 deletions(-)
 rename hw/mips/mips_int.c => target/mips/system/interrupts.c (90%)

-- 
2.47.1


