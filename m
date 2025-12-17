Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304A6D609D5
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 00:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVfJF-00064K-Ms; Tue, 16 Dec 2025 19:22:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3vvdBaQYKCgc51ipu6nvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--yubinz.bounces.google.com>)
 id 1vVfJE-0005zs-K9
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:22:28 -0500
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3vvdBaQYKCgc51ipu6nvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--yubinz.bounces.google.com>)
 id 1vVfJC-000556-L0
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:22:28 -0500
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-be8c77ecc63so7900013a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 16:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765930943; x=1766535743; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yl+gcw2nJqkBZU0PVg1fG9b10LfH4tcGif07p7f9C9I=;
 b=p5u2S3bH7JkClDPE5mec9saXEpCW8m0yLuLB5ItByhEQRAWB3yluHYyurlpIRbzlUa
 N0LzAGC3H+yeSePSzdzeRFbxjzkR+LxfGvp4QYkF/3I9cS9uJRx3IRDK0A3jISyxL704
 rAZuI3hl7kA6nfwNhJXixY7UyA/nFLMM26Zd6ZyxXCChqzmg202ScBW0hDI1udZii+/U
 ywQMdXfdfY7CnEmMaI9ENBnUpZHT15BRwnX+Kfit9HUxCf78TNy/rMCl7QZ1D9l1r1Mm
 XBWMQIYdg+Vn5aLLhVhDCBg1p38ieC4JHsKxR86pS4pHKa8EXfq4iZ+rNiAysYtoVzuQ
 ayOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765930943; x=1766535743;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yl+gcw2nJqkBZU0PVg1fG9b10LfH4tcGif07p7f9C9I=;
 b=YNAPVBos8l90mDdsWOz+qbelhbKRFgp4SR7mSeC4aJJ6JqepdI4IXew7x7hwB/NAQ5
 ZPGLRTXQ3P7ZnzU1HSuNGuvLISHYbOnYaexuzA/waDCcEPUKz27BV9nm26EBCVnLcydn
 XeRwBGsiN9jo6RjEPcSeIoPvF5vQyVsVIQqU0n9djTO1+NiXWOU1ZoNFxCFMuJRDY3tW
 3XKbwl7KrFSUYdvKoYXoPmRixY2XO/shG/aaWSaKVHDgyFbiv0ZDlwZC5QKSgJ0K8PkO
 Js2p8QuMLQ7XtO7tk+BTLTHSBpzki+Cf4sInRM/mtmBxWsl2h+7/GlJtTWHQs6Hfbg93
 s2PQ==
X-Gm-Message-State: AOJu0Yxd0CmXCO3X+zeHU19koM2F0WjGAQa4+z50W40Wb0Xy2QhUnwEV
 FbmbU2Z5UxqZu0MO/kZtKLsI9tEMJ9d9YuR11GaeMeQVh0fm1CAtKwf/fJbZwHIjDJ6bXaY7tAm
 SlFSlmkG4wj/TTPU1veFVkdZQMDiaEHUKVJuNQOuQMAHw90ELRZ52LVs53k0wKNCbOccTXaLNoU
 XoGhaaBYnzBMNS3QLgqmugrDKzz/WwqxqOe8g=
X-Google-Smtp-Source: AGHT+IH1aRO6kMHKBN69E6XF7l4zDVP9+dsXNNWzAPyuUWrJ1cmiScuVnpoakP9MZugiYtTy99itgHq5g9Y=
X-Received: from dlbtz16.prod.google.com
 ([2002:a05:7022:ead0:b0:11d:f5c6:adcf])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7023:906:b0:11a:c387:1357
 with SMTP id a92af1059eb24-11f349c5823mr10148418c88.16.1765930942578; Tue, 16
 Dec 2025 16:22:22 -0800 (PST)
Date: Wed, 17 Dec 2025 00:22:10 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALP3QWkC/2XM0Q6CIBiG4VtxHEf7QcHoqPtoHSD8IluFg+Zqz
 nsP3Vpph9+3Pe9IEkaPiRyLkUQcfPLhnke1K4jp9N0h9TZvwoELxkBQnXpES5PrfaDMVsqiNKi
 lJJn0EVv/XHLnS96dT48QX0t9YPP7Ccl1aGAUaANcgiprJlt9ciG4K+5NuJG5NPCv5qA2mmeta
 omiFbUCw/90+aMZbHSZNTaHBkxbWivYSk/T9AaozgTJJQEAAA==
X-Change-Id: 20251105-aspeed-sgpio-1d49de6cea66
X-Mailer: b4 0.14.2
Message-ID: <20251217-aspeed-sgpio-v4-0-28bbb8dcab30@google.com>
Subject: [PATCH v4 0/6] hw/gpio/aspeed_sgpio: Add Aspeed Serial GPIO (SGPIO)
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3vvdBaQYKCgc51ipu6nvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--yubinz.bounces.google.com;
 helo=mail-pg1-x549.google.com
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
Changes in v4:
- Fix indentation issue, replace SysBusDevice by SysBusDeviceClass,
  remove unused function in 1/6.
- Fix g_autofree usage in 2/6.
- Switch to use  %03d in unit test, remove unused headers in 6/6. 
- Link to v3: https://lore.kernel.org/qemu-devel/20251210-aspeed-sgpio-v3-0-eb8b0cf3dd51@google.com

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
 hw/gpio/aspeed_sgpio.c           | 347 +++++++++++++++++++++++++++++++++++++++
 tests/qtest/ast2700-sgpio-test.c | 166 +++++++++++++++++++
 hw/gpio/meson.build              |   1 +
 tests/qtest/meson.build          |   1 +
 8 files changed, 618 insertions(+), 5 deletions(-)
---
base-commit: 917ac07f9aef579b9538a81d45f45850aba42906
change-id: 20251105-aspeed-sgpio-1d49de6cea66

Best regards,
-- 
Yubin Zou <yubinz@google.com>


