Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2494D3C932
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 23:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTTcu-00047X-0J; Wed, 10 Dec 2025 18:29:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3XgI6aQYKCpsTP6DIUBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--yubinz.bounces.google.com>)
 id 1vTTcq-00045c-JL
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 18:29:40 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3XgI6aQYKCpsTP6DIUBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--yubinz.bounces.google.com>)
 id 1vTTcn-0005h2-Ih
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 18:29:40 -0500
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-2956a694b47so4941715ad.1
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 15:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765409375; x=1766014175; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jlT/6P0B57KMueWAXzaEBYHdojZpxIWjvZ2+S8hYL28=;
 b=P03HUqld+Ifrk3l0r5YTZtn8uhzV7YF/jDjgdJb8J/eqaAqE5cN3R6809YrTOhjzcQ
 mZRIOSp8Baa5Jqi7Qd8MyzwJ6vg3KaKxbgJ3ZT0ZUyxOPNyi1mVNagIdgC8HOD6RwHm6
 ZzTj0ecrVbjDq7iXCU/OnAMRU9HsKNpNhmV0FTOaHv6fB9omZBkefQ2ZXEchl7K7UBiX
 wpzBMuIZsyXksuimXn3xtUflbrWXOqtuH0359bFh9VH6rdZ6zDmCiTymJMh2WX3bPd/c
 NGzwchOoC/jTbEuZN05giQvOOXX7liKbkAn/lL+BzsVUW3J5OMiENpz/5wjzzRyEY/H1
 RH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765409375; x=1766014175;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jlT/6P0B57KMueWAXzaEBYHdojZpxIWjvZ2+S8hYL28=;
 b=ptCZOBrXTzauAENHVpjkKROTSriyNeOCnY+M67N5zRSF7iTJHZXNgS2rCaFpqsxeGf
 6T3QFF/huxOL8V6ddGH6I7wdyO82vT1M9UGNjLT5rMENS0+e2HYT2asUtJj8zHMr6q4f
 rkgff87ErUHbr84e/MPm8F1h+0iv7F8WPd4ebTZc913e7em7Apu3tdFrg3VEWjDJGS/c
 m+hDUiQSE0H35Pv5f5QKr9k/RL5GDJgwiE+pYvbqgLQEG35d7t6nUr8LkyMAhqgQOi2j
 6GL9G1N3XciJZAfaO6BRLdUlhXqEWxH51EJBz8fZeIvndnaFMAlj8CGPb34Jf2vJU7PD
 MW+A==
X-Gm-Message-State: AOJu0Yw30uaZp1o8nGug8mGWEtX/iqG1FGJMoIJeVvJhr921hD37sVvt
 ZkydHTG35vBGwmy6O4nWlgeO4xOp9l+AWcGq+C60yxry27AasWM862Y0NujZnHI8wLcAgwaRRW9
 qmwWYwjeqicK+i+hZszviMpIAVPVYTQrAtDkDp1WrAKUseJcuXMtQJn0DW10aRyfzul8tm716M7
 1s/pDnSrL9ZCrXW+rQASI5Yg8eL4VUN53fWNk=
X-Google-Smtp-Source: AGHT+IGqFTRoTxITdACgkT+gJY7fwfPx8pse0IIdB8wgX4lbI3zpuBCUFzDz+meXj9b//UTwoBucJFEUgZ4=
X-Received: from dlbbk2.prod.google.com ([2002:a05:7022:4282:b0:11d:cfca:1df5])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:78f:b0:119:e55a:9c06
 with SMTP id a92af1059eb24-11f296d74cbmr3308511c88.34.1765409374561; Wed, 10
 Dec 2025 15:29:34 -0800 (PST)
Date: Wed, 10 Dec 2025 23:29:11 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEcCOmkC/13M0QrCIBTG8VcZ5zpDXTrsqveILkzP3IHKoSHF2
 LvnBhHr8vvg/5sgYyLMcGwmSFgoU3zU0e4acIN9BGTk6wbJpRKCK2bziOhZDiNFJvzBeNQOrdZ
 QkzFhT6+VO1/qHig/Y3qvehHL+4X0FiqCcXblUnPTdkL39hRiDDfcu3iHRSryV0tu/mpZa9NpV
 L3qDHdyU8/z/AHyaNmg5wAAAA==
X-Change-Id: 20251105-aspeed-sgpio-1d49de6cea66
X-Mailer: b4 0.14.2
Message-ID: <20251210-aspeed-sgpio-v3-0-eb8b0cf3dd51@google.com>
Subject: [PATCH v3 0/6] hw/gpio/aspeed_sgpio: Add Aspeed Serial GPIO (SGPIO)
 controller model
From: Yubin Zou <yubinz@google.com>
To: qemu-devel@nongnu.org
Cc: "=?utf-8?q?C=C3=A9dric_Le_Goater?=" <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>, 
 Nabih Estefan <nabihestefan@google.com>, qemu-arm@nongnu.org, 
 Yubin Zou <yubinz@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3XgI6aQYKCpsTP6DIUBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--yubinz.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

This series introduces a model for the Aspeed Serial GPIO (SGPIO) controller,
commonly found on Aspeed SoCs such as the AST2700. The SGPIO peripheral
provides a large number of GPIO pins that can be controlled and monitored
serially.

Improvement to QEMU:
These patches enhance QEMU's hardware emulation capabilities for platforms
using Aspeed SoCs, particularly for BMC simulations. By modeling the SGPIO
controller, QEMU can more accurately represent the hardware, allowing for
better development and testing of firmware and software that relies on these
GPIOs for various functions like sensor monitoring, presence detect, and
system control signals.

Impact (Before/After):

Before:
QEMU lacked a model for the Aspeed SGPIO controller. Any guest software
attempting to interact with the SGPIO register space would find no device.
Firmware features depending on SGPIO pin states or interrupts could not be
tested in QEMU.

After:
QEMU emulates the Aspeed SGPIO controller on supported machines (e.g.,
ast2700-evb).
- Guest firmware can configure SGPIO pins, set output values, and read input
  values through the memory-mapped registers.
- External entities (like test scripts or other QEMU components) can interact
  with the pins via QOM properties (e.g., to simulate external signal changes).
  Path example: /machine/soc/sgpio[0]/sgpio0
- The model generates interrupts based on input pin transitions, according to
  the configured mode (level/edge), enabling testing of interrupt handlers.

Signed-off-by: Yubin Zou <yubinz@google.com>
---
Changes in v3:
- Fix commit message typo and address several review feedback in
  commit 2/6.
- Switch to use g_autofree and drop g_free.
- Use "%03d" instead of "%d".
- Link to v2: https://lore.kernel.org/qemu-devel/20251209-aspeed-sgpio-v2-0-976e5f5790c2@google.com

Changes in v2:
Split the v1 into smaller commits and reorder it for better review:
- Link to v1: https://lore.kernel.org/qemu-devel/20251106-aspeed-sgpio-v1-0-b026093716fa@google.com

---
Yubin Zou (6):
      hw/gpio/aspeed_sgpio: Add basic device model for Aspeed SGPIO
      hw/gpio/aspeed_sgpio: Add QOM property accessors for SGPIO pins
      hw/gpio/aspeed_sgpio: Implement SGPIO interrupt handling
      hw/arm/aspeed_soc: Update Aspeed SoC to support two SGPIO controllers
      hw/arm/aspeed_ast27x0: Wire SGPIO controller to AST2700 SoC
      test/qtest: Add Unit test for Aspeed SGPIO

 include/hw/arm/aspeed_soc.h      |   8 +-
 include/hw/gpio/aspeed_sgpio.h   |  68 ++++++++
 hw/arm/aspeed_ast10x0.c          |   6 +-
 hw/arm/aspeed_ast27x0.c          |  26 +++
 hw/gpio/aspeed_sgpio.c           | 348 +++++++++++++++++++++++++++++++++++++++
 tests/qtest/ast2700-sgpio-test.c | 152 +++++++++++++++++
 hw/gpio/meson.build              |   1 +
 tests/qtest/meson.build          |   1 +
 8 files changed, 605 insertions(+), 5 deletions(-)
---
base-commit: 917ac07f9aef579b9538a81d45f45850aba42906
change-id: 20251105-aspeed-sgpio-1d49de6cea66

Best regards,
-- 
Yubin Zou <yubinz@google.com>


