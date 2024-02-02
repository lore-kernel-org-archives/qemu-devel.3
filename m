Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9132C48295
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 16:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVwYY-0001kQ-9i; Fri, 02 Feb 2024 11:38:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+836f8942eaadfea8137c+7467+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rVwYX-0001k2-0T
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 11:38:21 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+836f8942eaadfea8137c+7467+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rVwYI-0001YP-SA
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 11:38:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=yRiD8Qlk372+ZFme0AMNy/sLNCBp3tPRv6qgSu2Rq2E=; b=DnyShdKqPXjoYjRJDn9jsboprK
 n8Kvyi1a5fp95l8/iNV/J3rR7SHey64l40/59TyY2jUI5ZoFS5jFluuTjWc6B2E158b/cqYIEfACb
 Jo/iso6RAHkGTXdl1P7xnZxTUjJQAL9bqzju2T6TCg/Lft/QeGA0qTlttpYO6/8+Gsqq9Z6K0I8Cw
 BbV/Cqq2kQpSqVvW3cwdz/EP/m1wdhYHPWDaeq9ekT1CQaRwGMI5rzrOwTMmh5vnOTcQT32m+PTK0
 K5HDPJLYpHQkhjt61NgCs9POHOOGBGFhLe6pjbmjuwZKrpmtkA1m9GQATI1tpZqT8D1NxQCXj6ap2
 wiY5n4eg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1rVwYE-00000001Y1L-0jgo; Fri, 02 Feb 2024 16:38:03 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rVwYD-00000003pu2-16Jg;
 Fri, 02 Feb 2024 16:38:01 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: [PULL v2 00/47] nic-config-2 queue
Date: Fri,  2 Feb 2024 16:38:00 +0000
Message-ID: <20240202163801.914495-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+836f8942eaadfea8137c+7467+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: David Woodhouse <dwmw@amazon.co.uk>

The following changes since commit c3709fde5955d13f6d4f86ab46ef3cc2288ca65e:

  Merge tag 'pull-aspeed-20240201' of https://github.com/legoater/qemu into staging (2024-02-01 14:42:11 +0000)

are available in the Git repository at:

  git://git.infradead.org/users/dwmw2/qemu.git tags/pull-nic-config-2-20240202

for you to fetch changes up to e8c5c4525cbbd7207c085732cfd1e67d8f3d662a:

  net: make nb_nics and nd_table[] static in net/net.c (2024-02-02 16:23:48 +0000)

----------------------------------------------------------------
Rework matching of network devices to -nic options (v2)

----------------------------------------------------------------
David Woodhouse (47):
      net: add qemu_{configure,create}_nic_device(), qemu_find_nic_info()
      net: report list of available models according to platform
      net: add qemu_create_nic_bus_devices()
      hw/pci: add pci_init_nic_devices(), pci_init_nic_in_slot()
      hw/i386/pc: use qemu_get_nic_info() and pci_init_nic_devices()
      hw/xen: use qemu_create_nic_bus_devices() to instantiate Xen NICs
      hw/alpha/dp264: use pci_init_nic_devices()
      hw/arm/sbsa-ref: use pci_init_nic_devices()
      hw/arm/virt: use pci_init_nic_devices()
      hw/hppa: use pci_init_nic_devices()
      hw/loongarch: use pci_init_nic_devices()
      hw/mips/fuloong2e: use pci_init_nic_devices()
      hw/mips/malta: use pci_init_nic_devices()
      hw/mips/loongson3_virt: use pci_init_nic_devices()
      hw/ppc/prep: use pci_init_nic_devices()
      hw/ppc/spapr: use qemu_get_nic_info() and pci_init_nic_devices()
      hw/ppc: use pci_init_nic_devices()
      hw/sh4/r2d: use pci_init_nic_devices()
      hw/sparc64/sun4u: use pci_init_nic_devices()
      hw/xtensa/virt: use pci_init_nic_devices()
      hw/arm/allwinner: use qemu_configure_nic_device()
      hw/arm/aspeed: use qemu_configure_nic_device()
      hw/arm/exynos4: use qemu_create_nic_device()
      hw/arm/fsl: use qemu_configure_nic_device()
      hw/net/smc91c111: use qemu_configure_nic_device()
      hw/net/lan9118: use qemu_configure_nic_device()
      hw/arm/highbank: use qemu_create_nic_device()
      hw/arm/npcm7xx: use qemu_configure_nic_device, allow emc0/emc1 as aliases
      hw/arm/stellaris: use qemu_find_nic_info()
      hw/arm: use qemu_configure_nic_device()
      hw/net/etraxfs-eth: use qemu_configure_nic_device()
      hw/m68k/mcf5208: use qemu_create_nic_device()
      hw/m68k/q800: use qemu_find_nic_info()
      hw/microblaze: use qemu_configure_nic_device()
      hw/mips/mipssim: use qemu_create_nic_device()
      hw/mips/jazz: use qemu_find_nic_info()
      hw/net/lasi_i82596: Re-enable build
      hw/net/lasi_i82596: use qemu_create_nic_device()
      hw/openrisc/openrisc_sim: use qemu_create_nic_device()
      hw/riscv: use qemu_configure_nic_device()
      hw/s390x/s390-virtio-ccw: use qemu_create_nic_device()
      hw/sparc/sun4m: use qemu_find_nic_info()
      hw/xtensa/xtfpga: use qemu_create_nic_device()
      net: remove qemu_check_nic_model()
      hw/pci: remove pci_nic_init_nofail()
      net: remove qemu_show_nic_models(), qemu_find_nic_model()
      net: make nb_nics and nd_table[] static in net/net.c

 hw/alpha/dp264.c                         |   4 +-
 hw/arm/allwinner-a10.c                   |   6 +-
 hw/arm/allwinner-h3.c                    |   6 +-
 hw/arm/allwinner-r40.c                   |  27 +---
 hw/arm/aspeed.c                          |   9 +-
 hw/arm/exynos4_boards.c                  |   6 +-
 hw/arm/fsl-imx25.c                       |   2 +-
 hw/arm/fsl-imx6.c                        |   2 +-
 hw/arm/fsl-imx6ul.c                      |   2 +-
 hw/arm/fsl-imx7.c                        |   2 +-
 hw/arm/gumstix.c                         |   6 +-
 hw/arm/highbank.c                        |  12 +-
 hw/arm/integratorcp.c                    |   5 +-
 hw/arm/kzm.c                             |   4 +-
 hw/arm/mainstone.c                       |   3 +-
 hw/arm/mps2-tz.c                         |   8 +-
 hw/arm/mps2.c                            |   2 +-
 hw/arm/msf2-soc.c                        |   6 +-
 hw/arm/musicpal.c                        |   3 +-
 hw/arm/npcm7xx.c                         |  16 +-
 hw/arm/realview.c                        |  25 ++-
 hw/arm/sbsa-ref.c                        |   4 +-
 hw/arm/stellaris.c                       |  30 +++-
 hw/arm/versatilepb.c                     |  15 +-
 hw/arm/vexpress.c                        |   4 +-
 hw/arm/virt.c                            |   4 +-
 hw/arm/xilinx_zynq.c                     |  11 +-
 hw/arm/xlnx-versal.c                     |   7 +-
 hw/arm/xlnx-zynqmp.c                     |   8 +-
 hw/cris/axis_dev88.c                     |   9 +-
 hw/hppa/machine.c                        |  12 +-
 hw/i386/pc.c                             |  38 +++--
 hw/i386/pc_piix.c                        |   2 +-
 hw/i386/pc_q35.c                         |   2 +-
 hw/loongarch/virt.c                      |   4 +-
 hw/m68k/mcf5208.c                        |  19 +--
 hw/m68k/q800.c                           |  29 ++--
 hw/microblaze/petalogix_ml605_mmu.c      |   3 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c |   3 +-
 hw/mips/fuloong2e.c                      |  16 +-
 hw/mips/jazz.c                           |  15 +-
 hw/mips/loongson3_virt.c                 |   4 +-
 hw/mips/malta.c                          |  15 +-
 hw/mips/mipssim.c                        |  13 +-
 hw/net/etraxfs_eth.c                     |   5 +-
 hw/net/lan9118.c                         |   5 +-
 hw/net/lasi_i82596.c                     |  13 +-
 hw/net/meson.build                       |   2 +-
 hw/net/smc91c111.c                       |   5 +-
 hw/openrisc/openrisc_sim.c               |  18 +--
 hw/pci/pci.c                             |  73 +++------
 hw/ppc/e500.c                            |   4 +-
 hw/ppc/mac_newworld.c                    |   4 +-
 hw/ppc/mac_oldworld.c                    |   4 +-
 hw/ppc/ppc440_bamboo.c                   |  14 +-
 hw/ppc/prep.c                            |   8 +-
 hw/ppc/spapr.c                           |  18 +--
 hw/riscv/microchip_pfsoc.c               |  14 +-
 hw/riscv/sifive_u.c                      |   7 +-
 hw/s390x/s390-virtio-ccw.c               |  11 +-
 hw/sh4/r2d.c                             |   6 +-
 hw/sparc/sun4m.c                         |  20 ++-
 hw/sparc64/sun4u.c                       |  27 +---
 hw/xen/xen-bus.c                         |   6 +-
 hw/xen/xen_devconfig.c                   |  25 ---
 hw/xenpv/xen_machine_pv.c                |   9 --
 hw/xtensa/virt.c                         |   4 +-
 hw/xtensa/xtfpga.c                       |  13 +-
 include/hw/cris/etraxfs.h                |   2 +-
 include/hw/i386/pc.h                     |   4 +-
 include/hw/net/lan9118.h                 |   2 +-
 include/hw/net/lasi_82596.h              |   4 +-
 include/hw/net/ne2000-isa.h              |   2 -
 include/hw/net/smc91c111.h               |   2 +-
 include/hw/pci/pci.h                     |   7 +-
 include/hw/xen/xen-bus.h                 |   2 +-
 include/hw/xen/xen-legacy-backend.h      |   1 -
 include/net/net.h                        |  70 ++++++++-
 net/net.c                                | 253 +++++++++++++++++++++++++------
 system/globals.c                         |   2 -
 tests/qtest/npcm7xx_emc-test.c           |  18 +--
 81 files changed, 547 insertions(+), 560 deletions(-)

