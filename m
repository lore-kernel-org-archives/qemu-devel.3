Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E4CC28B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 10:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsJ7B-0001D1-SU; Wed, 12 Mar 2025 06:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsJ79-00019o-8d
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:15:03 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsJ77-00072B-4M
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:15:02 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso38988015e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 03:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741774498; x=1742379298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V/b1xs0W5vKoA6/YGuAPP5iElJA93bMdDiOpcnicXqo=;
 b=NS+TLwUvkXh+Q9hiJj7RG+WMlXeD1f/ZCHxjA3UGJv48qN2gNkqlVTV0Gln7gINlGY
 eRbQ2ZfWZU+a8RZxHxPIgxkoRk+uFodDeVMB0z2JEBJp5ZzqcN8QTLoMQXNECgFpycMj
 VNyLiLibrHApXplKxSZLHCBh3VfJaJnksCz8sezTMwXG9WfrcwIJ//QmLY77mAXxX2Fs
 CXqAqLFRF8vezVuMIqxdXv9u75kbW4efao/L1Ck+2B7dFGjxV0zxshugM+M7fhu54D9Q
 0w1kpOSPrzoy9E7kjz4fLwBcIlG4z7nkg3foByHkoRG1KC1IH62K/hL/V/2hYRCFUwOz
 LSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741774498; x=1742379298;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V/b1xs0W5vKoA6/YGuAPP5iElJA93bMdDiOpcnicXqo=;
 b=m/YA/e4JZU3v/syetCMc/9/bbF2eh+cNwe7MrBq9JJe7pxewf+i8B3KGutMOEGsDId
 mZeFicDBaMdBGwtM9h3phusi2yYJZFu4o+t2Qq2FQfbj4Z1eorOFX3u9az93JAQwhkKw
 qsIcYk3+z2wo1ik/f1njgW9Vlwdw80doRJ3DcxEK8oZupUbL9WX2EpquIi6ia832bpnS
 nL4AipPP1pxcWMGdhcg/kqCKO1cNKFUIA1kbooJa5qzB93R3PB7HSWiHSWSoNSZPZZZS
 nZNFwoFHnJ9qavGyQobczGxorr+NvZYxt25+M0sBd8eUTSRxJGIbqmwIApBejrrExMvj
 KCGg==
X-Gm-Message-State: AOJu0YxFzBpwKY1ZE2D4ot/WPw8z99zLwGSCQ8KOyIyQLUCQXQUiKAX2
 EUXjVqI0qUYCL81OKvOkUk2fFy+UNqOUZgw9QdeZRO/yEOR+OoEyC9HuPDt/33i7H8nveJ722TQ
 1
X-Gm-Gg: ASbGncv1NR5nZIqtiDfiTxDcfmuqnWOtVaGOp3oXDNe9xrkSgQvzn0+3TC5Crwpsuoe
 bEG2haNpjYEYDoYbGwdnr1kuGl91TA+SvoXKs7OGHYZ25iIUfV0Tb+9dQj/JEYVzj0vge+4E8Ra
 7FU7z48LySnO2VeY8UkbV0K2+xzuJtLeptWfNDJuCYHmjjHV/QKY1wl/PGo9JaBGHiKtD4DCY8a
 IQu4cEWwXFOduxkblK/bc/Z4+mUbHA9Hji7lOzmpJqunPbX5gP5MUDS5KBX95CztQN0iIJ/8OB4
 OXsuccY7DK+uEZIqiiiaYJf5uMg6L0FR0EdtjvwX3zpEolYMkKnbu0lKQhrfNDQmoQCIX3JeXA/
 u6fD0jaPkAFgmEQFj6JMifhg2
X-Google-Smtp-Source: AGHT+IFBD49VpBhtdTR+E9ghb2HvDGAVKKtf0sQ6a4W66ulNWv/yMGphOvVuR7+v/hNbjmh6FiSgIA==
X-Received: by 2002:a5d:6d09:0:b0:38f:355b:13e9 with SMTP id
 ffacd0b85a97d-39132d33c10mr17328548f8f.15.1741774497927; 
 Wed, 12 Mar 2025 03:14:57 -0700 (PDT)
Received: from localhost.localdomain (99.167.185.81.rev.sfr.net.
 [81.185.167.99]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d0a8c5cf7sm16657695e9.29.2025.03.12.03.14.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Mar 2025 03:14:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 00/14] Misc HW patches for 2025-03-11
Date: Wed, 12 Mar 2025 11:14:54 +0100
Message-ID: <20250312101455.99631-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

The following changes since commit 825b96dbcee23d134b691fc75618b59c5f53da32:

  Merge tag 'migration-20250310-pull-request' of https://gitlab.com/farosas/qemu into staging (2025-03-11 09:32:07 +0800)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20250312

for you to fetch changes up to 7f2a5272ff3893ef412c093aae66b7ed34ab3dfc:

  hw/sd/sdhci: Remove need for SDHCI_VENDOR_IMX definition (2025-03-12 11:11:42 +0100)

Since v1:
- Fixed typo in last patch subject (Zoltan)

----------------------------------------------------------------
Misc HW patches

- Set correct values for MPC8569E's eSDHC (Zoltan)
- Emulate Ricoh RS5C372 RTC device (Bernhard)
- Array overflow fixes in SMSC91C111 netdev (Peter)
- Fix typo in Xen HVM (Philippe)
- Move graphic height/width/depth globals to their own file (Philippe)
- Introduce qemu_arch_available() helper (Philippe)
- Check fw_cfg's ACPI availability at runtime (Philippe)
- Remove virtio-mem dependency on CONFIG_DEVICES (Philippe)
- Sort HyperV SYNDBG API definitions (Pierrick)
- Remove need for SDHCI_VENDOR_FSL definition (Philippe)

----------------------------------------------------------------

BALATON Zoltan (1):
  hw/sd/sdhci: Set reset value of interrupt registers

Bernhard Beschow (1):
  hw/rtc: Add Ricoh RS5C372 RTC emulation

Peter Maydell (4):
  hw/net/smc91c111: Sanitize packet numbers
  hw/net/smc91c111: Sanitize packet length on tx
  hw/net/smc91c111: Use MAX_PACKET_SIZE instead of magic numbers
  hw/net/smc91c111: Don't allow data register access to overrun buffer

Philippe Mathieu-Daudé (7):
  hw/xen/hvm: Fix Aarch64 typo
  system: Extract target-specific globals to their own compilation unit
  system: Replace arch_type global by qemu_arch_available() helper
  hw/acpi: Introduce acpi_builtin() helper
  hw/i386/fw_cfg: Check ACPI availability with acpi_builtin()
  hw/virtio/virtio-mem: Remove CONFIG_DEVICES include
  hw/sd/sdhci: Remove need for SDHCI_VENDOR_IMX definition

Pierrick Bouvier (1):
  hw/hyperv/hyperv-proto: Move SYNDBG definitions from target/i386

 MAINTAINERS                      |   2 +
 include/hw/acpi/acpi.h           |   3 +
 include/hw/hyperv/hyperv-proto.h |  12 ++
 include/hw/sd/sdhci.h            |   2 +-
 include/hw/xen/arch_hvm.h        |   2 +-
 include/system/arch_init.h       |   2 +-
 target/i386/kvm/hyperv-proto.h   |  12 --
 hw/acpi/acpi-stub.c              |   8 ++
 hw/acpi/core.c                   |   5 +
 hw/arm/fsl-imx25.c               |   2 -
 hw/arm/fsl-imx6.c                |   2 -
 hw/arm/fsl-imx6ul.c              |   2 -
 hw/arm/fsl-imx7.c                |   2 -
 hw/arm/fsl-imx8mp.c              |   2 -
 hw/i386/fw_cfg.c                 |   8 +-
 hw/net/smc91c111.c               | 148 ++++++++++++++++---
 hw/ppc/e500.c                    |   1 +
 hw/rtc/rs5c372.c                 | 236 +++++++++++++++++++++++++++++++
 hw/scsi/scsi-disk.c              |   2 +-
 hw/sd/sdhci.c                    |  18 ++-
 hw/virtio/virtio-mem.c           |   6 +-
 system/arch_init.c               |  19 +--
 system/globals-target.c          |  24 ++++
 system/qdev-monitor.c            |   4 +-
 system/vl.c                      |   6 +-
 tests/qtest/rs5c372-test.c       |  43 ++++++
 hw/rtc/Kconfig                   |   5 +
 hw/rtc/meson.build               |   1 +
 hw/rtc/trace-events              |   4 +
 system/meson.build               |   1 +
 tests/qtest/meson.build          |   1 +
 31 files changed, 503 insertions(+), 82 deletions(-)
 create mode 100644 hw/rtc/rs5c372.c
 create mode 100644 system/globals-target.c
 create mode 100644 tests/qtest/rs5c372-test.c

-- 
2.47.1


