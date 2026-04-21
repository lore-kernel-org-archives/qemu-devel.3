Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81AE9F55805
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3jV-0000OR-F5; Tue, 21 Apr 2026 01:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wF3jQ-0000IY-DC
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:33:08 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wF3jN-0004NP-2u
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:33:07 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3567e2b4159so2538492a91.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776749583; x=1777354383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=0L1oFgljCzgChUmedIob21XTf/49qrHpk7BblYbXNKY=;
 b=CajuKtjee3TTCW5Y3HLMM9WRwXntNoth5p6R2ouzo9GDxxMCoYeYZYosXGmsv7GxCK
 3/5LD7tRrlmvPEiWefm/hg/ee0eV1APu8wiIoBl92mtY1qA1P4OcP5Djfk92n/3xaTNf
 G57zyQBWWQHDkkZ7O4rZuAsNhYEKZkwTB5JNx77UmR76fzAwsGNW810yQy+820tp7uw9
 W/no3KB12aUgqgJwVMkmbEuRGvsXYuARIS0lRX91bkSTjB/COwiXh41w7ehEovH+Hhfo
 M9TCsasjpFGkPzBuOEuHYAp3cwyJUw2UGehd93q9c87UcaficHeEiT1ofyFHi+E7tTWb
 iGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776749583; x=1777354383;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0L1oFgljCzgChUmedIob21XTf/49qrHpk7BblYbXNKY=;
 b=rLJISMyBwF2cng9D1KJaZUS1IgbacTUoNyGMUYU6OMIFpg0nraZGc2tNrutKkuLJ+G
 UNuq5zryxUKlpB0ZFMKMtg64FnL36VWT41pyEX+FxXmN1hI+7xVBVzv/Ga5vmhDVj0Qd
 gZ5V5diKNeZSQfqbjzYXJMzhLy82ptpvfscVJI45jZOjCR95Wr7/nlVTVmi7urmMBhLj
 E+xENbbyEpZ58nrHipRx9W64iqzv7CAXokYJNA9zvrQcUQsJPx8xCEpiv+rSrO0aU1j+
 b2OoR3QM7FMjUsLJ3dSNKjIMOvie/qfkrsN7Y19NhGIcmrXYnrDnYNxZB6zixV91BSr5
 nbHw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/UmkeEvhaMF6nTEP7hbb1+MLo6G0rBIyYP8cMAIj14PUZ1hJHGdjoW4+sfg/UEaGV6Q4KSIeXi0d+K@nongnu.org
X-Gm-Message-State: AOJu0Yz7tRMYZEg68iZ+3VP5fwItW2Ei80FCnn6042MRQV/3T9HZduRJ
 9zkKO+3Y0YqIZKpqew/mPvMDg8OzGS2wLUzQKUMQYRKRUEOdtn6B7Fkv
X-Gm-Gg: AeBDievyBMPn5l+WkOJilx9B5Oc4/P4fTxW9jnKM7FfY6YupajwtSU8De6Znc3Uj3r2
 E9kfLgi9WHItO3wF0c7aCCu/64MCEEomrTOVyKzqDKEHWO4nkEpv46WdLKyXxS+MTfwfQuyyJtV
 cfIMl5xzaR7UTF0Sx2TPW28oe7Y0jNlJT2a+tOllD/Uo/xxFc0l7C/MATqnt/a3Ee/mtZ+ZFhZb
 adEE1i1esTiH67sGWnKuIai/mBrESIiCWsrGKH+s/Aa+PW4eBe2GxcwJw7ElH/ZtQ+BSI5aPwWl
 uKCUkHceeSydPQyIBUQn6CoyDeHDL4s6O6bcJBdfHoOWA0CZKarEYn3BikESJsURz2dVIKYwevn
 XeqO2WMu7TG3vbUhaj2z/4DG4SAIP429XTm2kT1i3fHfWxxm1ItxuWKNQltBLsn1SYf1W7Vj1B/
 BJa93XCcmZkiAtkTn7qyfTNbcu7Q/OEcsKPfiYPNuvobTPhQfuaztoxq5wYZ9OidDf4gy2DIAoM
 otbhOwLwssI6xxy3hWl+Ula3NADcYWPMR5OAg==
X-Received: by 2002:a17:90b:37cb:b0:35f:d56d:1c45 with SMTP id
 98e67ed59e1d1-3614041bc7cmr15391553a91.12.1776749582831; 
 Mon, 20 Apr 2026 22:33:02 -0700 (PDT)
Received: from donnager-debian.. ([203.221.103.1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36141898ebasm12472308a91.7.2026.04.20.22.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:33:01 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Michael Ellerman <mpe@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 00/13]  hw/riscv: Add the Tenstorrent Atlantis machine
Date: Tue, 21 Apr 2026 15:31:25 +1000
Message-ID: <20260421053140.752059-1-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

v3 brings the atlantis work back into one patch set following review and
off-list discussion with Alistair. There have been a bunch of
improvements made since the last posting:

  - Narrow the AIA refactor, virt-specific code stays in virt.c rather
    than moving to aia.c
  - riscv_boot_info_init must be called before
    riscv_find_and_load_firmware in sifive_u
  - Fix fw_cfg_init_mem_dma API change in the Atlantis machine
  - Fix create_fdt_pmu copying RISCVCPUs by value
  - Fix memory leaks in PCIe DT string allocation
  - Fix functional test file paths and remove unused import
  - Add trace events to the DesignWare I2C driver
  - Add device tree clock to I2C integration
  - Remove unused MachineState argument from halting payload helper
  - Remove unused platform_bus from Atlantis machine
  - Use HWADDR_PRIX consistently

Original cover letter:

Introducing Tenstorrent Atlantis!

 The Tenstorrent Atlantis platform is a collaboration between Tenstorrent
 and CoreLab Technology. It is based on the Atlantis SoC, which includes
 the Ascalon-X CPU and other IP from Tenstorrent and CoreLab Technology.

 The Tenstorrent Ascalon-X is a high performance 64-bit RVA23 compliant
 RISC-V CPU.

This initial series adds the base machine support including:

 - AIA (Advanced Interrupt Architecture) support
 - PCIe controller and DesignWare I2C integration
 - Serial console and device tree generation
 - Functional tests for OpenSBI+Linux boot

Chris Rauer (1):
  hw/i2c: Add designware i2c controller

Joel Stanley (5):
  hw/riscv/virt: Move AIA initialisation to helper file
  hw/riscv/aia: Provide number of irq sources
  hw/riscv: Add Tenstorrent Atlantis machine
  hw/riscv/atlantis: Integrate i2c buses
  hw/riscv/atlantis: Add some i2c peripherals

Nicholas Piggin (7):
  hw/riscv/boot: Describe discontiguous memory in boot_info
  hw/riscv/boot: Account for discontiguous memory when loading firmware
  hw/riscv/boot: Provide a simple halting payload
  target/riscv: tt-ascalon: Enable Zkr extension
  target/riscv: tt-ascalon: Add Svadu extension
  hw/riscv/atlantis: Add PCIe controller
  tests/functional/riscv64: Add tt-atlantis tests

 MAINTAINERS                                  |  20 +
 docs/system/riscv/tt_atlantis.rst            |  38 +
 docs/system/target-riscv.rst                 |   1 +
 hw/riscv/aia.h                               |  25 +
 include/hw/i2c/designware_i2c.h              | 101 ++
 include/hw/riscv/boot.h                      |  13 +-
 include/hw/riscv/tt_atlantis.h               |  92 ++
 include/hw/riscv/virt.h                      |   2 +-
 hw/i2c/designware_i2c.c                      | 818 ++++++++++++++++
 hw/riscv/aia.c                               |  93 ++
 hw/riscv/boot.c                              |  49 +-
 hw/riscv/microchip_pfsoc.c                   |   6 +-
 hw/riscv/opentitan.c                         |   6 +-
 hw/riscv/shakti_c.c                          |   6 +-
 hw/riscv/sifive_u.c                          |   6 +-
 hw/riscv/spike.c                             |   6 +-
 hw/riscv/tt_atlantis.c                       | 932 +++++++++++++++++++
 hw/riscv/virt-acpi-build.c                   |  27 +-
 hw/riscv/virt.c                              |  96 +-
 hw/riscv/xiangshan_kmh.c                     |   6 +-
 target/riscv/cpu.c                           |   2 +-
 hw/i2c/Kconfig                               |   4 +
 hw/i2c/meson.build                           |   1 +
 hw/i2c/trace-events                          |   4 +
 hw/riscv/Kconfig                             |  20 +
 hw/riscv/meson.build                         |   3 +-
 tests/functional/riscv64/meson.build         |   1 +
 tests/functional/riscv64/test_opensbi.py     |   4 +
 tests/functional/riscv64/test_tt_atlantis.py |  63 ++
 29 files changed, 2337 insertions(+), 108 deletions(-)
 create mode 100644 docs/system/riscv/tt_atlantis.rst
 create mode 100644 hw/riscv/aia.h
 create mode 100644 include/hw/i2c/designware_i2c.h
 create mode 100644 include/hw/riscv/tt_atlantis.h
 create mode 100644 hw/i2c/designware_i2c.c
 create mode 100644 hw/riscv/aia.c
 create mode 100644 hw/riscv/tt_atlantis.c
 create mode 100755 tests/functional/riscv64/test_tt_atlantis.py

-- 
2.47.3


