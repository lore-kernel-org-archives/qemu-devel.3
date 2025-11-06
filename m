Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB299CCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 19:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH5Rp-0003RK-Ek; Thu, 06 Nov 2025 14:15:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3q_MMaQYKChYKGx49L2AA270.yA8C08G-z0H079A929G.AD2@flex--yubinz.bounces.google.com>)
 id 1vH5Rh-0003QY-RC
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 14:14:58 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3q_MMaQYKChYKGx49L2AA270.yA8C08G-z0H079A929G.AD2@flex--yubinz.bounces.google.com>)
 id 1vH5Rg-0006IG-7D
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 14:14:57 -0500
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-2930e2e8e7fso16954225ad.2
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 11:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1762456492; x=1763061292; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1uQ4pclRddECNaveNKLWgHY6D0yMd5vtB78zuNiHPMM=;
 b=xY70Z3HyL0qiwXGGgOLGSdfVrPZD7tQJ16IySHo1AtFXKFELKNOwlJvCJ5GCNeOry4
 /55O+nYBzJ5bIEItv66XK9D20jvple/Xjjvc8/dA3pZwMRXOFPWEgvFjSuK/Bt3UqN8+
 utjgiNB20D+IK/7VnRyu8y8eNfSw0Lt/mvNR/cRiOHO4P2FmPRt/zApK2m0dgAA2bgBk
 baTyXa1ZLf16xsc2PpngBZ1v9+2zb3Vu4n0pBpZN2CvE+JzBF8ylhbPBtlJvl87liu2z
 TmaW2F7/D2i5UNpX9w3+E3g8Z4Jh1jvV4d2UhVKMeMesm7ct2cyPYqxjTnK6IZEByqdq
 rQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762456492; x=1763061292;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1uQ4pclRddECNaveNKLWgHY6D0yMd5vtB78zuNiHPMM=;
 b=QCLw62w91QmPztC7Juxps4IFIUCOxWQWCQJsOIwjm76wMBQw0w455omNZWLCOYxm3I
 TZ6U6y0/j2OZA1KsuxxqgNCJXGsxvF3hyQrhmbsoYHqG0bt7QSdCiQvxM359tnsXc+Xf
 rUN0rwkUhcN9iinxDJxX743Q6dlXzewwFFlgPCqJvZyPkaBFLHy+jN53QZizIaQHe2Wl
 eJkSX37/3LawwGhHRnd8AtkPWDRl4LxWHcCHLLhAReltN805IwQ+kCvjSJFkabF8jUcK
 Xchp1gJSBZsxoLW6/x7W9yoeBWGO1ktI6ljEl1GCT5mxfASKw9exHQ/dHc5VEVHR8LoD
 MjiA==
X-Gm-Message-State: AOJu0YwukKoqsqf++E+yG/YtaaCGHd5V7CFQwZIkfq3zUCpJ3MIMAol1
 mfG4dLkWZNIEf5rKofI2NmIZKiATmIZ1PZpPWDvCxOzDIRwwChqFGqmnyGTFpvEUT93h9hDNYGS
 1fimVCklqRWp4OQwSkXs4sHdln7GevzcoF/MXPexrKHhBFish9WXEIwAveUESyknuQv2DYIm5KN
 I0sCWlBx6ylOxj2LkoetzZ2bDo5C3CVXN2FNg=
X-Google-Smtp-Source: AGHT+IExSxDpE0vnYuPjNjsF8fOjkg/LapP5wI99KnFgcahj3rrIKJpP3ZB3xN4D0NQxozoi812Ctawa+Wk=
X-Received: from dlbcf38.prod.google.com
 ([2002:a05:7022:45a6:b0:119:9f33:34ac])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:19cd:b0:296:217:33ff
 with SMTP id d9443c01a7336-297c04576famr6309345ad.48.1762456491648; Thu, 06
 Nov 2025 11:14:51 -0800 (PST)
Date: Thu, 06 Nov 2025 19:14:23 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAI/zDGkC/x3MQQqAIBBG4avErBNUSqirRAvJv5qNigMRiHdPW
 n6L9yoJCkNoHSoVPCycYocZBzpuHy8oDt1ktZ2N0bPykoGg5MqclAnTEuAOeOeoJ7ng5PffbXt
 rH28r/xpeAAAA
X-Change-Id: 20251105-aspeed-sgpio-1d49de6cea66
X-Mailer: b4 0.14.2
Message-ID: <20251106-aspeed-sgpio-v1-0-b026093716fa@google.com>
Subject: [PATCH 0/2] hw/gpio: Add Aspeed Serial GPIO (SGPIO) controller model
From: Yubin Zou <yubinz@google.com>
To: qemu-devel@nongnu.org
Cc: "=?utf-8?q?C=C3=A9dric_Le_Goater?=" <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Yubin Zou <yubinz@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3q_MMaQYKChYKGx49L2AA270.yA8C08G-z0H079A929G.AD2@flex--yubinz.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
Yubin Zou (2):
      hw/gpio: Add the skeleton of Aspeed Serial gpio
      hw/gpio Add the Interrupt logic to Aspeed Serial gpio

 hw/arm/aspeed_ast10x0.c          |   6 +-
 hw/arm/aspeed_ast27x0.c          |  26 +++
 hw/gpio/aspeed_sgpio.c           | 349 +++++++++++++++++++++++++++++++++++++++
 hw/gpio/meson.build              |   1 +
 include/hw/arm/aspeed_soc.h      |   8 +-
 include/hw/gpio/aspeed_sgpio.h   |  68 ++++++++
 tests/qtest/ast2700-sgpio-test.c | 152 +++++++++++++++++
 tests/qtest/meson.build          |   1 +
 8 files changed, 606 insertions(+), 5 deletions(-)
---
base-commit: 917ac07f9aef579b9538a81d45f45850aba42906
change-id: 20251105-aspeed-sgpio-1d49de6cea66

Best regards,
-- 
Yubin Zou <yubinz@google.com>


