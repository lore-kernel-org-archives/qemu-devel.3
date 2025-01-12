Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64428E7719E
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6H2-0007Rf-Ed; Sun, 12 Jan 2025 17:17:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Gz-0007RX-AL
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:17:33 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Gw-0006NC-Vy
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:17:32 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385df53e559so2972148f8f.3
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720248; x=1737325048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HecOCzho42RDvgF2Yr6swmRIF2egLAkd5DHR0npebwY=;
 b=HMkyevbl5xUfrAticbIV/S80yYy+rPgFY1b5kwxMQtD8jq5MHWf0U0hlzmhjFWBuLJ
 Iy0KpTtKj2oNaepcwEmDcIXx4V7ANBTWlcWMoE+C0Xk+I+K+cxsUUjYn5m1Sre/xMpGm
 c3WOF5cZiHv53Yaou8t4W8h2zyWOzCjWWCs46t3ECQrWSEiJlQNnGGfZpUN202QXn3dR
 Pm4z+QUwA1aZ9tV5p177d6G8CBfIrurfZuw0GZC4YsZdsgAtRsQlYQmnJBNeo6zfixoz
 xiRtweKZaZKTvLtBYaDM8WhNIXR2nXzD/CB8aiEy8j0cFWQwiddrGSyT4aPFw26EKZSO
 f+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720248; x=1737325048;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HecOCzho42RDvgF2Yr6swmRIF2egLAkd5DHR0npebwY=;
 b=qKXQgCXVg7vacqYH3yAt0dVQxw1TuQ62Av+92rHnKvB5J8mhizQct7Rez4c7FldXzZ
 ZKOisEO7tYpy0/b8ySBikxrDuLNjDqXwfV3i77g7hD+qzm/0ubEJc/UvP7ThizluSoqF
 1jP9V+z/mPpLgSWYM9tM6vo2lKK+gk++2fNcn8ukLhRzLVgwHzhcMCJ3PdtEJms4iYgL
 ORW2gYuJra5/unfzcm1pnL8DmjcEX8J2NNY3PLY6J1xIPnDFBAR5NLbKjb1G8IWtYyIa
 qm1tPo4NcLdV5ng3gXDHuqgQQASUnxwyB2KWtSQFRBT6i59TZzFYrf6ZORMXeS8x9LQC
 Bq+A==
X-Gm-Message-State: AOJu0YxM3lZIPruN8gzZegjx7kBk4IP+UN9iVcYx6bWKq5QeIGZBGtoK
 Lnb7GRNESkMKp7nptTMjn5bFaIP8gRYO/I2DPQQHOx/t8PUjYcZZTnYzd862+MNkPXweH86UMsG
 mQu4=
X-Gm-Gg: ASbGncv++kiPEThEPmRzEgSQUJCJF4TG3C2E/ihljsvHJMpehCZ255skOIDYBBwvxIt
 09ewK3zep5wpS2EkjQGB4VMuBwsD1spoCqQjKn176TDKTRUDREkTER/q+Yl7/x/heCasU4hxi4M
 BrgvRLcdKi3g5/0gE7elzTVRa2PhIwCrOiAg2+engS5IOaDNnRTd8SzJ3CwLznOYDl2VAV44LEX
 Y81Q9PNGE+Z5ouyD42wJCKb1byAoEC2DdkFelYokxqHYaQL2bDoA4Kh0EbCFN4IgJPSj1M2n/R+
 E8C9wvBw+IaYQlFrnnF36xZYi/jajv4=
X-Google-Smtp-Source: AGHT+IGYfQ/L3x6MTLzZ45Jz8ovEvK7Ci6iibnOnYpRXZVJfWV75FdPAinkoU5WWhTh5ug0esl7ImQ==
X-Received: by 2002:a05:6000:1846:b0:385:fae7:fe50 with SMTP id
 ffacd0b85a97d-38a8730fc56mr15246311f8f.42.1736720248364; 
 Sun, 12 Jan 2025 14:17:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38c697sm10779665f8f.52.2025.01.12.14.17.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:17:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/49] Misc HW patches for 2025-01-12
Date: Sun, 12 Jan 2025 23:16:36 +0100
Message-ID: <20250112221726.30206-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

The following changes since commit 3214bec13d8d4c40f707d21d8350d04e4123ae97:

  Merge tag 'migration-20250110-pull-request' of https://gitlab.com/farosas/qemu into staging (2025-01-10 13:39:19 -0500)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20250112

for you to fetch changes up to 4a0031691596bd81c5949cf4632a6d178f8c2fe5:

  Add a b4 configuration file (2025-01-12 23:06:29 +0100)

----------------------------------------------------------------
Misc HW patches queue

- Silent unuseful DTC warnings (Philippe)
- Add few QOM parentship relations (Philippe)
- Rework XilinX EthLite RAM buffers (Philippe)
- Convert vmcoreinfo to 3-phase reset (Philippe)
- Convert HPPA CPUs to 3-phase reset (Helge)
- Fix UFS endianness issue (Keoseong)
- Introduce pci_set_enabled (Akihiko)
- Clarify Enclave and Firecracker relationship (Alexander)
- Set SDHCI DMA interrupt status bit in correct place (Bernhard)
- Fix leak in cryptodev-vhost-user backend (Gabriel)
- Use USB XHCI ring 0 when mapping is not supported (Phil)
- Convert DPRINTF to trace events (Nikita, Bernhard)
- Remove &first_cpu in TriCore machine (Philippe)
- Checkpatch style cleanups (Bibo)
- MAINTAINERS updates (Marcin, Gustavo, Akihiko)
- Add default configuration for b4 tool (Jiaxun)

----------------------------------------------------------------

Akihiko Odaki (2):
  hw/pci: Rename has_power to enabled
  MAINTAINERS: Update path to coreaudio.m

Alexander Graf (1):
  docs/nitro-enclave: Clarify Enclave and Firecracker relationship

Bernhard Beschow (7):
  hw/sd/sdhci: Set SDHC_NIS_DMA bit when appropriate
  hw/timer/imx_gpt: Remove unused define
  tests/qtest/libqos: Reuse TYPE_IMX_I2C define
  hw/misc/imx6_src: Convert DPRINTF() to trace events
  hw/char/imx_serial: Turn some DPRINTF() statements into trace events
  hw/i2c/imx_i2c: Convert DPRINTF() to trace events
  hw/gpio/imx_gpio: Turn DPRINTF() into trace events

Bibo Mao (1):
  hw/loongarch/virt: Checkpatch cleanup

Gabriel Barrantes (1):
  backends/cryptodev-vhost-user: Fix local_error leaks

Gustavo Romero (1):
  MAINTAINERS: Add me as the maintainer for ivshmem-flat

Helge Deller (4):
  target/hppa: Convert hppa_cpu_init() to ResetHold handler
  hw/hppa: Reset vCPUs calling resettable_reset()
  target/hppa: Set PC on vCPU reset
  target/hppa: Speed up hppa_is_pa20()

Jiaxun Yang (1):
  Add a b4 configuration file

Keoseong Park (1):
  hw/ufs: Adjust value to match CPU's endian format

Marcin Juszkiewicz (1):
  MAINTAINERS: remove myself from sbsa-ref

Nikita Shubin (1):
  hw/char/stm32f2xx_usart: replace print with trace

Phil Dennis-Jordan (1):
  hw/usb/hcd-xhci-pci: Use event ring 0 if mapping unsupported

Philippe Mathieu-Daudé (27):
  pc-bios/meson.build: Silent unuseful DTC warnings
  target: Replace DEVICE(object_new) -> qdev_new()
  hw: Replace DEVICE(object_new) -> qdev_new()
  hw: Add QOM parentship relation with CPUs
  hw/usb: Inline usb_try_new()
  hw/usb: Inline usb_new()
  hw/microblaze: Restrict MemoryRegionOps are implemented as 32-bit
  hw/net/xilinx_ethlite: Map MDIO registers (as unimplemented)
  hw/net/xilinx_ethlite: Introduce txbuf_ptr() helper
  hw/net/xilinx_ethlite: Introduce rxbuf_ptr() helper
  hw/net/xilinx_ethlite: Access TX_GIE register for each port
  hw/net/xilinx_ethlite: Access TX_LEN register for each port
  hw/net/xilinx_ethlite: Access TX_CTRL register for each port
  hw/net/xilinx_ethlite: Map RX_CTRL as MMIO
  hw/net/xilinx_ethlite: Map TX_LEN as MMIO
  hw/net/xilinx_ethlite: Map TX_GIE as MMIO
  hw/net/xilinx_ethlite: Map TX_CTRL as MMIO
  hw/net/xilinx_ethlite: Map the RAM buffer as RAM memory region
  hw/net/xilinx_ethlite: Rename 'mmio' MR as 'container'
  hw/net/xilinx_ethlite: Map RESERVED I/O as unimplemented
  hw/misc/vmcoreinfo: Rename VMCOREINFO_DEVICE -> TYPE_VMCOREINFO
  hw/misc/vmcoreinfo: Convert to three-phase reset interface
  hw/sd/sdhci: Factor sdhci_sdma_transfer() out
  tests/qtest/boot-serial-test: Correct HPPA machine name
  tests: Add functional tests for HPPA machines
  target/hppa: Only set PSW 'M' bit on reset
  hw/tricore/triboard: Remove unnecessary use of &first_cpu

 MAINTAINERS                                |  19 +-
 docs/system/i386/nitro-enclave.rst         |   2 +-
 include/hw/misc/vmcoreinfo.h               |   7 +-
 include/hw/pci/pci.h                       |   1 +
 include/hw/pci/pci_device.h                |   2 +-
 include/hw/usb.h                           |  12 +-
 target/hppa/cpu.h                          |  11 +-
 backends/cryptodev-vhost-user.c            |   3 +-
 hw/arm/musicpal.c                          |   2 +-
 hw/char/imx_serial.c                       |  58 ++--
 hw/char/stm32f2xx_usart.c                  |  49 ++--
 hw/gpio/imx_gpio.c                         |  18 +-
 hw/hppa/machine.c                          |   6 +-
 hw/i2c/imx_i2c.c                           |  21 +-
 hw/i386/x86-common.c                       |   1 +
 hw/intc/xilinx_intc.c                      |   4 +
 hw/loongarch/acpi-build.c                  |   3 +-
 hw/loongarch/boot.c                        |   4 +-
 hw/loongarch/virt.c                        |   8 +-
 hw/microblaze/petalogix_ml605_mmu.c        |   1 +
 hw/microblaze/petalogix_s3adsp1800_mmu.c   |   1 +
 hw/mips/cps.c                              |   1 +
 hw/misc/imx6_src.c                         |  23 +-
 hw/misc/vmcoreinfo.c                       |  14 +-
 hw/net/xilinx_ethlite.c                    | 312 ++++++++++++++-------
 hw/pci/pci.c                               |  17 +-
 hw/pci/pci_host.c                          |   4 +-
 hw/ppc/e500.c                              |   1 +
 hw/ppc/spapr.c                             |   1 +
 hw/sd/sdhci.c                              |  33 ++-
 hw/sparc/sun4m.c                           |   4 +-
 hw/timer/imx_gpt.c                         |   4 -
 hw/timer/xilinx_timer.c                    |   4 +
 hw/tricore/triboard.c                      |   6 +-
 hw/ufs/ufs.c                               |   2 +-
 hw/usb/bus.c                               |   5 +-
 hw/usb/dev-serial.c                        |   2 +-
 hw/usb/hcd-xhci.c                          |   4 +
 target/hppa/cpu.c                          |  22 +-
 target/mips/cpu.c                          |   2 +-
 target/xtensa/cpu.c                        |   2 +-
 tests/qtest/boot-serial-test.c             |   2 -
 tests/qtest/libqos/arm-imx25-pdk-machine.c |   5 +-
 tests/qtest/libqos/i2c-imx.c               |   4 +-
 tests/qtest/ufs-test.c                     |   2 +-
 .b4-config                                 |  14 +
 hw/char/trace-events                       |  11 +
 hw/gpio/trace-events                       |   5 +
 hw/i2c/trace-events                        |   5 +
 hw/misc/trace-events                       |   6 +
 pc-bios/meson.build                        |   3 +-
 tests/functional/meson.build               |   4 +
 tests/functional/test_hppa_seabios.py      |  35 +++
 tests/qtest/meson.build                    |   2 +-
 54 files changed, 518 insertions(+), 276 deletions(-)
 create mode 100644 .b4-config
 create mode 100755 tests/functional/test_hppa_seabios.py

-- 
2.47.1


