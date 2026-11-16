Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F93606A330
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=W1jvB75v
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSuef-0003w4-5B; Mon, 16 Nov 2026 06:13:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueE-0003ox-Sc
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:19 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueB-00027a-HM
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:18 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48b001cd92bso2171627f8f.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827585; x=1795432385; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BQZH83pGI0NUwr8J+u5YuKDAe1Rvia0DQvV6C5badPg=;
 b=W1jvB75v9Qbz+oBMAxJympkTFVuIoGvUG0hoLr10wMbbiommP9cHkgaCgXyUNMqeJ3
 ++zix0bu9LPjIx5VHfyXjwWbWbvvagGnujD4EcydIo4V7BND4M/oLq+NgsmkZZ6dZuDy
 UIk2aFqSrkHHNw65c85B6nleY1VycAxK9v3Iei6/leNRupR06xrJs3yNUnoM11oLoXrz
 oR2zIq3l5cmyMMb42nOw90sg7i7YzA7NF99RKDptWsVfH2X0Ug2m7LUHnnCIg0lge7zM
 fRvCb6BcXevCEDxa1sUJyuRC3a/0IkyiIyu6ObYS6JprgO9QdqJIdmiQzVGkJzeHiopX
 XrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827585; x=1795432385;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BQZH83pGI0NUwr8J+u5YuKDAe1Rvia0DQvV6C5badPg=;
 b=eHprfDtcPEgEZmn2QEGklq+DlazQLJPJ1KHK1r3PgNHaGFwb2QBMTWGxfvieyEQz9c
 2AYVrKmhRX2O5GKCsnPGRFMqLD98TlIbMSEzroySJBdrG6xaQ6g/iWL7v0ifGfKlHdeT
 GBexoCDkMc1r/esk1qDeWpb3M75q3hqDdLNqtiD01qGcAes8fk/Lg1MWut49XjAJrUe5
 dngngAJ3E8SecGF3wEKO/XjEz8SNqd/vBZNT8L6vNKKM9UsFwAQdg7HYMPrmV399yfmm
 3eqf1q2XNuNZrtNOkBRMLsOrLjZfRDDFaw2eyGS0YOxIJC/K0wJxKsLfSZ1S1BGDGCTt
 N7Ew==
X-Gm-Message-State: APuU4Z+cWwDjOFqYiJvQLCRos9TpHadxsbF5H7/fY5GJETgshFdhQCTL
 ewghs1G5WlI/leEoiYaGvBNPzzsAHhSkrJWkkuYGUeF5cpA8CqB36HSoA8CQnjLSDpb1Xwxmjjw
 svek9gZs=
X-Gm-Gg: AZFdTZelsPA7vOQPLkZYp2/T3rgzNpqdFrkFMxmlzFbQ08WOLzYf4wB5xZyXHOYNfrU
 kfc83j/Hhg+TWLC1JCATiagVIOEz3IqebCGGdy/qymotkS7a2O1ym6D2yWpKRq+LSmGxHFNTLUG
 Nvk1YomChEWUOZZd/iHwby1IXfHOZqTqaPlRGrvC1s8IxvEQPHIBrxXdPPtUZoqdC4k6YMb5dxz
 QDs8Xto9O10Bfm0hjsjwa4R20r3sQeqC37NXB4Pl9cdYdaDLPdVqfK31e6nWi+P7WaiGHvgiF82
 JddbK0VEu6qHmzEpef34CFGEPMV1f4awKPgVcIKmpuF1rhbY+1jM1208KVmmDEy0V8y+tjAyQPH
 1lOormTHJ3n5RhTATiDolv/zQ5zMQfu2hP6OvcULIzxBqeCMA/4KMHQwhzdW6lQyHJa1todr/HK
 51WzjzGjXvXXStVMydRCjYTv8ayHroqceUlNk3+qPrf8lqLDREl+gkJrumtrzR31VUJZiJ2DD2P
 seQ5P4KnNa3OLEhCBUu59DtheS3cWNQoO1LgleFkFDwswxHlU95fmDyivMrA5MHU/m4zPfrVeSu
 w0bbv96RFVu/URYGH6KKrjkkjV+i6Eug6JgbT3Fa1zFfDeBl3Nt1QiLN6V0M+u6R+Bmpk3zoRw0
 Bf4ukJEVGln8ZncrGSKUQv2QI5ERzl+S1aA==
X-Received: by 2002:a05:6000:1863:b0:48d:ee35:b3fe with SMTP id
 ffacd0b85a97d-49c6d45308fmr25356924f8f.8.1794827585582; 
 Mon, 16 Nov 2026 03:13:05 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/33] target-arm queue
Date: Mon, 16 Nov 2026 11:12:30 +0000
Message-ID: <20261116111303.1692832-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi; this is quite a large pullreq, but it's all bug fixes aimed at
rc1 (both arm-specific and otherwise).  Notably, there are a set of
patches in here which fix various problems with handling of packets
in the net/ code.

thanks
-- PMM

The following changes since commit e9fa1f66f0d47c74b6766e1b8b87ad7c2a9394d5:

  Merge tag 'pull-nbd-2026-11-10-v2' of https://gitlab.com/ebblake/qemu into staging (2026-11-13 08:44:16 -0700)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20261116

for you to fetch changes up to 7d8fc59308ce20661515555855af4e01ac9bab77:

  hw/arm/virt-acpi-build: test vms->acpi_dev before building HEST (2026-11-16 11:09:47 +0000)

----------------------------------------------------------------
target/arm queue:
 * hw/ssi/stm32f2xx_spi: avoid transferring data on DR reads
 * hw/arm/bcm2838: Route SPI0 interrupt to GIC
 * hw/intc/arm_gicv5: Various minor bug fixes
 * hw/core/qdev-properties-system.c: Don't leak str in set_drive_helper()
 * hw/watchdog/wdt_imx2: Set vmstate minimum_version_id to 1
 * include/hw/core/ptimer.h: Fix 'version' argument of VMSTATE_PTIMER
 * net: Tighten various size/offset checks in packet parsing functions
 * net: Pad short packets regardless of network backend
 * hw/net/eepro100: fix use-after-free on reset after hot-unplug
 * hw/arm: Deprecate Nuvoton quanta-gsj board model
 * Revert ".dir-locals: include QEMU code in PYTHONPATH"
 * docs/about/deprecated: Add missing "since" marker for OABI/NWFPE
 * docs/about/deprecated: Fix heading level for AF_ALG heading
 * hw/net: cadence: Honor subword lanes in the GEM registers
 * hw/arm/virt-acpi-build: test vms->acpi_dev before building HEST

----------------------------------------------------------------
Akihiko Odaki (4):
      net/eth.c: Check for undersized L2 headers in eth_get_protocols()
      net/eth.c: In eth_get_protocols(), don't report TCP data offset off end of packet
      net/eth.c: In eth_parse_ipv6_hdr(), fix check of input size
      net/eth.c: Move the Routing Header Hdr Ext Len check

Alex Bennée (1):
      Revert ".dir-locals: include QEMU code in PYTHONPATH"

Bin Meng (1):
      hw/net: cadence: Honor subword lanes in the GEM registers

Hanyu (1):
      hw/arm/bcm2838: Route SPI0 interrupt to GIC

Manuele Conti (1):
      hw/ssi/stm32f2xx_spi: avoid transferring data on DR reads

Peter Maydell (23):
      hw/intc/arm_gicv5: Use cached IRS_IST_BASER.VALID state
      hw/intc/arm_gicv5: Free memory in finalize
      target/arm: Only allow GICv5 on CPUs without AArch32 at EL1..3
      hw/intc/arm_gicv5: Use correct type for value in lpi_cache_get_hppi()
      hw/core/qdev-properties-system.c: Don't leak str in set_drive_helper()
      hw/watchdog/wdt_imx2: Set vmstate minimum_version_id to 1
      include/hw/core/ptimer.h: Fix 'version' argument of VMSTATE_PTIMER
      hw/net/net_rx_pkt: Handle bogus l4hdr_off when validating SCTP checksum
      net/eth.c: Check for undersized IPv4 headers in eth_get_protocols()
      net/eth.c: In eth_get_protocols(), don't report SCTP header off end of packet
      net/eth.c: Harden _eth_tcp_has_data() against short lengths
      net/eth.c: Tighten size checks in eth_get_l3_proto()
      include/net/eth.h: Make eth_get_l2_hdr_length_iov() check protocol
      hw/net/net_tx_pkt: Sanity check GSO headers in net_tx_pkt_build_vheader()
      hw/net/net_tx_pkt: Sanity check virt hdr len in net_tx_tcp_fragment_init
      hw/net/net_tx_pkt: Sanity check L2+L3 header len in net_tx_pkt_parse_headers()
      hw/net/net_rx_pkt: Check for overflow in _net_rx_pkt_calc_l4_csum()
      tests/qtest: Make netfilter tests accept padded ethernet packets
      net: Pad short packets consistently regardless of backend
      net: Remove padding code from net backends
      hw/arm: Deprecate Nuvoton quanta-gsj board model
      docs/about/deprecated: Add missing "since" marker for OABI/NWFPE
      docs/about/deprecated: Fix heading level for AF_ALG heading

Ren Yanyi (1):
      hw/arm/virt-acpi-build: test vms->acpi_dev before building HEST

Stefan Weil (1):
      hw/net/eepro100: fix use-after-free on reset after hot-unplug

 MAINTAINERS                          |   1 +
 docs/about/deprecated.rst            |  16 +++-
 include/hw/arm/bcm2835_peripherals.h |   1 +
 include/hw/arm/bcm2838_peripherals.h |   1 +
 include/hw/core/ptimer.h             |   2 +-
 include/net/eth.h                    |  26 ++++++-
 include/net/net.h                    |   3 +-
 target/arm/cpu-features.h            |   8 ++
 hw/arm/bcm2835_peripherals.c         |  14 +++-
 hw/arm/bcm2838.c                     |   4 +
 hw/arm/npcm7xx_boards.c              |   1 +
 hw/arm/virt-acpi-build.c             |  25 +++---
 hw/core/qdev-properties-system.c     |   5 +-
 hw/dma/xlnx_csu_dma.c                |   4 +-
 hw/intc/arm_gicv5.c                  |  20 +++--
 hw/intc/arm_gicv5_common.c           |   3 +
 hw/net/cadence_gem.c                 |  55 +++++++++-----
 hw/net/eepro100.c                    |  13 +++-
 hw/net/net_rx_pkt.c                  |  22 ++++--
 hw/net/net_tx_pkt.c                  |  20 ++++-
 hw/ssi/stm32f2xx_spi.c               |   1 -
 hw/watchdog/k230_wdt.c               |   2 +
 hw/watchdog/wdt_imx2.c               |   1 +
 net/eth.c                            | 143 +++++++++++++++++++++++++++++------
 net/net.c                            |  32 +++++++-
 net/slirp.c                          |   9 ---
 net/tap-win32.c                      |  15 +---
 net/tap.c                            |  11 +--
 target/arm/cpu.c                     |  37 ++-------
 tests/qtest/stm32f2xx-spi-test.c     |  50 ++++++++++++
 tests/qtest/test-filter-buffer.c     |   4 +-
 tests/qtest/test-filter-mirror.c     |   4 +-
 tests/qtest/test-filter-redirector.c |   4 +-
 .dir-locals.el                       |   8 +-
 net/vmnet-common.m                   |  11 ---
 tests/qtest/meson.build              |   2 +
 36 files changed, 399 insertions(+), 179 deletions(-)
 create mode 100644 tests/qtest/stm32f2xx-spi-test.c

