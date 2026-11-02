Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB93606AB80
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cDnqjBwy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNvXn-0007E7-QB; Mon, 02 Nov 2026 12:10:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNvXi-0007DE-8x
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 12:09:59 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNvXb-0006DX-5Q
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 12:09:55 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so27852255e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 09:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793639389; x=1794244189; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=00Q5m+cUZhB0RQVtiB35gdb/eBYRKm0EMesJ5KcvDHU=;
 b=cDnqjBwyF1o7tX+zXoXfp1A0ZDlcz5WZYQ3RuIRB6SmUWr8BLSYvfFqTjmyTjIQNVG
 v9+3JpY8QLVcay2Z6gJwEywmEKTxwZMQyxUFldyO/DBxuRn8AqGjFaCMkJZkQ6rifyMj
 SCm673KCJGKxp6KHPVLg5fJg2Y+XgOGQdb1VwXGemtPbkihvV+QwZU7KHJ5Bo1BZrdQT
 FL4mD9eb4KtyyF2YknQxhKd+Luk56LvIQb2DiLwDJQCpdsYIJTE4mYp5Qo7giG8sqVlS
 s1Hc7QDW5rIK/a/gq2sTLai2WBctGS6bHzD04fNu1tWDj4cc7GVMov6mT0Wygc7guM7/
 wVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793639389; x=1794244189;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=00Q5m+cUZhB0RQVtiB35gdb/eBYRKm0EMesJ5KcvDHU=;
 b=xbl6xv4mi/XNOuzcUHAiu0yKvxAMSGf10PxzrdQOmZclKMnAIoxNRu74kVVVqT5bqZ
 lwuAJU5Fhl3dSHTYgdymS4EQbTP/Oks28fOSYwU3G1HkZd74J+GYCiQxCpKGvlMFKlyv
 Oi74t+SVFob7Hd9xgsFAqmgcXzpuxlpkgP4IFB4M70mQioQ3jp6gNQICQAZ+p6sOmqa7
 ojznsbVBhQ46yjHSquLp9aO4H9d/DG99Wb5Ap0UEBngFVhFkjplVafvLMRlIZEtZ/9BO
 kfbpKtJPla7Yg/wNGyMNfE/lISrVEl6HAEQeaRu7XxsTHY7jTgB4pT4vBGck3U6Pp0GT
 UWPg==
X-Gm-Message-State: AFq9FYIqTSpS4K9JQO4FA2hOOFVNAQ+NHH98Vb6O2m2EUOu4fGM2p7bA
 gZsOl3y+/mqFCpZZHuETQWQApveYBf8iXQJmJFnnHRPEIIfwd9VYHbqYYuaiy//NEhTDe/x5AoC
 GTKd2//o=
X-Gm-Gg: AYBFou3MJ0H/j2qajzFxkTkFKem2RieeZt+y3q8VwT8u8WW8zsRiD17I2bY/rRiUBRh
 cGbpmFNN3ha4j6UmoxZTT61soorEG8kr5BSvxws2EDVn1PmvW4qEDa+xcWW72i9tMtx4x7OcO+c
 HfAiLTdBfz5PfrHFDh65gD3V6wAUjWdEIsV7mHxhCizMAvyt1cc82fjowz9LfhqHz/ge/k1M6qs
 9N0Y9qBcXLp+IIMgArBgwM3UqUmhuhf+kEwMxqETYKvr730GO6nuNNIBKjhyBMt64DiIjsUca1K
 0RGpMb4/iDy6ft1vIEkIx2UdrEGoroq5ddYOnW+cSkJIWMfTMQXj3ZOZN31yCI8O5iVTV0w2etB
 TUo47T6WrGm1/FvwJJnzAG6hpId0JVty4EBh3fZIOznBopEOotklzovLNE4bSULITpCVr8AKWMg
 8SOzqukMPGtSNBe3TX5wkGGRZsErgGDYAcvBs8c72yhqvDCuD9tdEMdw6fiUatuBM80sK9pkikv
 7vpe0weJOnIAYnfWk57yw2DIcn+nA5UJ7y7Va2xtbuAFJC0+n2THWg0PMlaJIJClrrV2QTlH2hc
 z2D4PKpez7Y2crK53/jq0AZ6QF/s5w0NevvkdQwkCqYMJfGhuYtKg3Kw9mmBekmpkGASLofFamN
 1wfVgZxNb/uKluRJEmHKPghbZkkFzM5isyuA=
X-Received: by 2002:a05:600c:a45:b0:4a1:da58:1ee with SMTP id
 5b1f17b1804b1-4ac1932b43amr252949335e9.31.1793639389183; 
 Mon, 02 Nov 2026 09:09:49 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm23569818f8f.6.2026.11.02.09.09.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 09:09:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/46] target-arm queue
Date: Mon,  2 Nov 2026 17:09:47 +0000
Message-ID: <20261102170947.1427046-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi; here's the target-arm queue for softfreeze.

v2 changes: drop the hvf patch which broke the macos CI jobs.

-- PMM

The following changes since commit 56afd82bd4db9688f1c1c9d0e2ea163b8cde3283:

  Merge tag 'qemu-sparc-20261101' of https://github.com/mcayland/qemu into staging (2026-11-01 08:37:48 -0800)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20261102-1

for you to fetch changes up to cbad21fae0c451b1e2e50bb503d7af121454b698:

  target/arm: fix bcm2835 migration issue (2026-11-02 17:07:15 +0000)

----------------------------------------------------------------
target-arm queue:
 * raspi4b: Implement PCI and GENET ethernet device
 * target/arm: Initialize SMCR_EL1.EZT0 for linux-user
 * hw/dma/xlnx_dpdma: Don't allow DMA off end of host buffers
 * target/arm: For linux-user, prioritize PC misalignment fault over insn abort
 * net/tap: Avoid "close(-1)" in net_init_tap() error path
 * hvf: arm: save/restore SME state only when SME on
 * hvf: arm: advertise ID_AA64PFR0_EL1.GIC correctly
 * target/arm: Refactoring preparatory to ID register configurability
 * target/arm/cpu64: Define cpreg migration tolerance for PMMIR_EL1
 * gicv5: minor cleanups and bugfixes
 * target/arm: hold bql when SEV sets the event_register
 * target/arm: fix bcm2835 migration issue

----------------------------------------------------------------
Alex Bennée (3):
      target/arm: hold bql when SEV sets the event_register
      target/arm: don't pass env to the sev helper
      target/arm: fix bcm2835 migration issue

Eric Auger (10):
      target/arm/cpu-sysregs.h.inc: Sort by name alphabetical order
      target/arm: Move REVIDR into isar.idregs[] storage
      target/arm: Move MIDR into isar.idregs[] storage
      target/arm: Enforce MPIDR into isar.idregs[] storage
      target/arm/kvm: Pass an error handle to kvm_arm_init_cpreg_list
      target/kvm: Pass an Error handle to kvm_arch_init_vcpu
      target/arm/kvm: Introduce kvm_arm_vcpu_prepare_init_features helper
      hw/arm/virt: Make sure virt_get_caches() keeps on reading CLIDR_EL1 as 0
      target/arm: Directly store cpu probe failure error
      target/arm/kvm: Improve error handling on scratch vcpu probe

Marcelo Manzo (8):
      hw/arm/bcm2838_pcie: add BCM2838 PCIe Root Complex
      hw/arm/bcm2838_pcie: add BCM2838 PCIe host
      hw/arm/bcm2838: enable BCM2838 PCIe host bridge
      hw/net/bcm2838_genet: add GENET stub device
      hw/net/bcm2838_genet: add migration state
      hw/arm/bcm2838: enable BCM2838 GENET controller
      docs/system/arm/raspi: move PCIe/GENET from missing to implemented
      tests/functional/aarch64: add raspi4b GENET networking test

Mohamed Mediouni (3):
      hvf: arm: save/restore SME state only when SME on
      hvf: arm: remove broken ID_AA64PFR0_EL1.GIC sync
      hvf: arm: advertise ID_AA64PFR0_EL1.GIC

Peter Maydell (10):
      hw/dma/xlnx_dpdma: Don't allow DMA off end of host buffers
      target/arm: For linux-user, prioritize PC misalignment fault over insn abort
      net/tap: Avoid "close(-1)" in net_init_tap() error path
      hw/intc/arm_gicv5: Ignore low bits in IRS_IST_BASER.ADDR
      hw/intc/arm_gicv5: Ignore low bits in L1_ISTE.L2_ADDR
      hw/intc/arm_gicv5: Regularize spacing in config_readl() switch
      target/arm: GICv5 cpuif: Use arm_cpu_set_irq() to set IRQ/FIQ status
      hw/intc/arm_gicv5: Pass CPU index to CPU interface
      hw/intc/arm_gicv5: Pass cpuidx rather than iaffid in gicv5_get_hppi()
      hw/intc/arm_gicv5: Relax QEMU_GICV5_MIN_LPI_ID_BITS to 0

Philippe Mathieu-Daudé (1):
      target/arm: Initialize SMCR_EL1.EZT0 for linux-user

Sebastian Ott (2):
      target/arm/cpu64: fix typos in kvm_arm_set_cpreg_mig_tolerances()
      target/arm/cpu64: Define cpreg migration tolerance for PMMIR_EL1

Sergey Kambalin (9):
      hw/net/bcm2838_genet: add GENET register structs, part 1/4
      hw/net/bcm2838_genet: add GENET register structs, part 2/4
      hw/net/bcm2838_genet: add GENET register structs, part 3/4
      hw/net/bcm2838_genet: add GENET register structs, part 4/4
      hw/net/bcm2838_genet: add GENET register access macros
      hw/net/bcm2838_genet: implement GENET register ops
      hw/net/bcm2838_genet: implement GENET MDIO
      hw/net/bcm2838_genet: implement GENET TX path
      hw/net/bcm2838_genet: implement GENET RX path

 docs/system/arm/raspi.rst               |    6 +-
 include/hw/arm/bcm2838_pcie.h           |   73 ++
 include/hw/arm/bcm2838_peripherals.h    |    7 +
 include/hw/dma/xlnx_dpdma.h             |    5 +-
 include/hw/intc/arm_gicv5.h             |    1 +
 include/hw/intc/arm_gicv5_common.h      |    2 +-
 include/hw/intc/arm_gicv5_stream.h      |   10 +-
 include/hw/net/bcm2838_genet.h          |  455 ++++++++++++
 include/system/kvm.h                    |    2 +-
 linux-user/arm/target_proc.h            |   13 +-
 target/arm/cpu.h                        |   25 +-
 target/arm/internals.h                  |   14 +
 target/arm/kvm_arm.h                    |    3 +-
 target/arm/tcg/helper-defs.h            |    2 +-
 target/arm/cpu-sysregs.h.inc            |   49 +-
 accel/kvm/kvm-all.c                     |   15 +-
 hw/arm/bcm2838.c                        |   13 +
 hw/arm/bcm2838_pcie.c                   |  313 ++++++++
 hw/arm/bcm2838_peripherals.c            |   46 ++
 hw/arm/raspi4b.c                        |   19 -
 hw/arm/virt.c                           |   15 +
 hw/display/bcm2835_fb.c                 |   11 +
 hw/display/xlnx_dp.c                    |   30 +-
 hw/dma/xlnx_dpdma.c                     |   13 +-
 hw/intc/arm_gicv5.c                     |   54 +-
 hw/intc/arm_gicv5_common.c              |    2 +-
 hw/intc/armv7m_nvic.c                   |    4 +-
 hw/net/bcm2838_genet.c                  | 1185 +++++++++++++++++++++++++++++++
 net/tap.c                               |    4 +-
 system/cpus.c                           |    2 +-
 target/arm/cpu-max.c                    |    4 +-
 target/arm/cpu.c                        |   57 +-
 target/arm/cpu64.c                      |   18 +-
 target/arm/helper.c                     |   29 +-
 target/arm/hvf/hvf.c                    |   26 +-
 target/arm/kvm.c                        |  119 ++--
 target/arm/tcg/cpu-v7m.c                |   18 +-
 target/arm/tcg/cpu32.c                  |   37 +-
 target/arm/tcg/cpu64.c                  |   42 +-
 target/arm/tcg/gicv5-cpuif.c            |   41 +-
 target/arm/tcg/op_helper.c              |    7 +-
 target/arm/tcg/tlb_helper.c             |    4 +
 target/arm/tcg/translate-a64.c          |    2 +-
 target/arm/tcg/translate.c              |    2 +-
 target/arm/whpx/whpx-all.c              |    9 +-
 target/i386/kvm/kvm.c                   |   22 +-
 target/loongarch/kvm/kvm.c              |   27 +-
 target/ppc/kvm.c                        |   10 +-
 target/riscv/kvm/kvm-cpu.c              |    6 +-
 target/s390x/kvm/kvm.c                  |    2 +-
 hw/arm/meson.build                      |    4 +-
 hw/arm/trace-events                     |    4 +
 hw/net/meson.build                      |    2 +
 hw/net/trace-events                     |   16 +
 tests/functional/aarch64/test_raspi4.py |   31 +
 55 files changed, 2616 insertions(+), 316 deletions(-)
 create mode 100644 include/hw/arm/bcm2838_pcie.h
 create mode 100644 include/hw/net/bcm2838_genet.h
 create mode 100644 hw/arm/bcm2838_pcie.c
 create mode 100644 hw/net/bcm2838_genet.c

