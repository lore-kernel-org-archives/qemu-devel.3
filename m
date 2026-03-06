Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D49FCB61B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXZ2-0005k4-AS; Fri, 06 Mar 2026 10:58:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyXZ0-0005jS-UX
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:58:06 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyXYx-0003ev-TH
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:58:06 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439c6fc2910so2350496f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772812682; x=1773417482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=XFIqeLuL8fh/c1ssMPpHVC47hu1eR6uHLLaJCJv/kko=;
 b=wL0sPFJH6/gR0q7GasOHFiD7yWSfH8V0hh1xlWf6tbyetwD6Ar8m0VO+cac631c40G
 YMLjHTT5kEVfV9qhQqIFAUqRBX2f/SGwc0WJBmx5rMjIAhlTjvs+nD1eHzrfd/tM30mK
 Fkc2DWpB6CyZWhljZAS50LZBDrN/+KeYSeLxPJnXYlXkAMj+4UQn0c8C0BTiviy1R7QA
 4INc9ChkAcPXk9r/3Jy9ksn6/lC5W9M0ktSs3+fw286WULIw0fN97OOitSqj1YZgMjW5
 dnQz4IywZl9ZQi8idvWBwRDIZ6v+ZEahyxaLn1hObgAuYBUMd+w23U5AvKAdsu2dySAT
 7WSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772812682; x=1773417482;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XFIqeLuL8fh/c1ssMPpHVC47hu1eR6uHLLaJCJv/kko=;
 b=pcQ39Tt+AJk2f9wbNDnY1hv+pDeOrT8Ur/TXJd36e1kgCWMSi4TR2zIBz6gUUOz3/O
 erS7Ab3wObGhn1TkPsBc6gzxv/AwrhDJwrKUt5C5Is4p1cKnkRO7rFR/qfzJG5r2r9FC
 ysJ6ZRS/4Adzx0Mbr5EYofSvSM3+puVPcqBdW3BPMvaaUrWJqrGfZX2nGGugwgM9Qjr2
 hMYAv11yWV74z0JHQ6haIn9CWSqDjwSXfR1mCLN9L0ofExbyOXYOZZfHkC0ib0x2YMPl
 +MndbPzZh1R7Au/m3Uw8Cqa+21FL0WxFkSWrzGZw3A/KkWFphyTpt18yV1/2KZJbGTJW
 GBzg==
X-Gm-Message-State: AOJu0Yx2ku5uN0rwHxCITPM9bFStmH93UaGLHbT6OGk8VnGfsXLHNtoc
 Jfhm5WoNM04+eCq5QGatZsLpT95/c7P75E2hAGAD3Z2AWijqEh56MRmlmcztHA0ODLm4+Va9/00
 HxHga
X-Gm-Gg: ATEYQzwy9FQPTff/tFTrcYlRF8jnJUWlvKPhBgsz5akjQstKVNElY8pJshX2dm0CPmL
 jnNr5W9UcjAtVdgXmxLbpyFHQVNdpAsVxX3GgQkWJyKLqv2UIG/1JxS1Bc8PKluygWJ1ndjcq8g
 F+qkrcBw+7WV2RbO6UaZU5aBBY4jE4bTO+Gwavbo/jd6OlyN+E7eKEeM26o4ng7J2zifQ6xwTnW
 Djc18l1Q/Xsb6fbJowaGaX4syuvib5kZuL3LfChS3TBvOsLs+w5vliQ7IJ7k0P6PMdK/DYUy7G/
 z3hmN28k0MT/4uGip+vHu+kxePSZ+6I80jvmLzG6fTOe8SxUpOlJWSxW59BLbZUxRD4uNnDRtTr
 bXj4ahxJgpbKZ501ATuHY6dX6ahE5Ce3sCwK0Wk2DlZ8rG6JbxDmak8or7Ru1FNh6hmI34kNX62
 tA4zgVomNyI+vZla+1X49WcFcskUZlQYcqKCcxRxFxiPuX2rYVDuzcPgMF68exEg0tYAzzQAPka
 2jJkciflfdZkm3XuKK7ePBgV8uwHcM=
X-Received: by 2002:a5d:5f82:0:b0:439:bc2b:cb57 with SMTP id
 ffacd0b85a97d-439da3483bcmr4847576f8f.6.1772812682285; 
 Fri, 06 Mar 2026 07:58:02 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2ba06sm4945487f8f.24.2026.03.06.07.58.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:58:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 00/36] target-arm queue
Date: Fri,  6 Mar 2026 15:58:01 +0000
Message-ID: <20260306155801.2198582-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Dropped almost all of the hvf gicv3 and nested virt series.

-- PMM

The following changes since commit 314ff2e07ddc6163554077d68aed5d76a50b8e3d:

  Merge tag 'pull-request-2026-03-05' of https://gitlab.com/thuth/qemu into staging (2026-03-05 16:58:20 +0000)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260306-2

for you to fetch changes up to 7b6a3c3349e8ccc11c1857abee7fa218bfdf53e1:

  hvf: hvf-all: stop including hvf_arm.h (2026-03-06 13:27:24 +0000)

----------------------------------------------------------------
 * Remove deprecated 'highbank' and 'midway' machines
 * hw/arm: Add missing dependencies for STM32F405 SoC
 * hw/arm/smmuv3-accel: Read and propagate host vIOMMU events
 * Minor MAINTAINERS updates
 * target/arm: Improve logging of migration errors due to system
   register mismatches between source and destination
 * hw/arm/aspeed_gpio: Don't leak string in aspeed_gpio_init()
 * tests/qtest/iommu-smmuv3-test: Free QPCIDevice
 * chardev: Fix various sanitizer detected leaks
 * tests/qtest/test-x86-cpuid-compat: Free allocated memory
 * tests/qtest/qos-test: Plug a couple of leaks
 * hw/arm/smmuv3: Fix various minor bugs
 * hvf/arm: expose FEAT_SME2 to guest if available
 * hvf/arm: drop unneeded includes

----------------------------------------------------------------
CLEMENT MATHIEU--DRIF (1):
      MAINTAINERS: Update Clement Mathieu--Drif's email address

Chisheng Chen (1):
      hw/arm: Add missing dependencies for STM32F405 SoC

Eric Auger (7):
      vmstate: Introduce VMSTATE_VARRAY_INT32_ALLOC
      target/arm/machine: Use VMSTATE_VARRAY_INT32_ALLOC for cpreg arrays
      target/arm/kvm: Export kvm_print_register_name()
      target/arm/kvm: Tweak print_register_name() for arm64 system register
      target/arm/machine: Trace cpreg names which do not match on migration
      target/arm/machine: Trace all register mismatches
      target/arm/machine: Fix detection of unknown incoming cpregs

Fabiano Rosas (5):
      chardev: Fix QIOChannel refcount
      chardev: Don't attempt to unregister yank function more than once
      chardev: Consolidate yank registration
      tests/qtest/test-x86-cpuid-compat: Free allocated memory
      tests/qtest/qos-test: Plug a couple of leaks

Magnus Kulke (1):
      MAINTAINERS: fix magnuskulke email-address

Manos Pitsidianakis (2):
      hvf/arm: handle FEAT_SME2 migration
      hvf/arm: expose FEAT_SME2 to guest if available

Mohamed Mediouni (2):
      hw/arm: virt: remove hvf_arm.h include
      hvf: hvf-all: stop including hvf_arm.h

Nicolin Chen (2):
      backends/iommufd: Introduce iommufd_backend_alloc_veventq
      hw/arm/smmuv3-accel: Allocate vEVENTQ for accelerated SMMUv3 devices

Paul Durrant (1):
      MAINTAINERS: remove myself as a Xen maintainer

Peter Maydell (6):
      system/qtest: Support comments in input commands
      hw/net/smc91c111: Don't allow negative-length packets
      scripts: Move lsan_suppressions.txt out of oss-fuzz subdir
      scripts/lsan_suppressions.txt: Add more leaks
      hw/arm/aspeed_gpio: Don't leak string in aspeed_gpio_init()
      tests/qtest/iommu-smmuv3-test: Free QPCIDevice

Shameer Kolothum (3):
      hw/arm/smmuv3-accel: Add viommu free helper
      hw/arm/smmuv3: Introduce a helper function for event propagation
      hw/arm/smmuv3-accel: Read and propagate host vIOMMU events

Tao Tang (3):
      hw/arm/smmuv3-common: Fix incorrect reserved mask for SMMU CR0 register
      hw/arm/smmuv3: Correct SMMUEN field name in CR0
      hw/arm/smmuv3: Fix CFGI_CD handling when stage-1 is unsupported

Thomas Huth (2):
      hw/arm: Remove the deprecated "highbank" and "midway" machines
      hw/net: Remove the xgmac device

 .gitlab-ci.d/buildtest.yml              |   2 +-
 MAINTAINERS                             |  16 +-
 accel/hvf/hvf-all.c                     |   1 -
 backends/iommufd.c                      |  31 +++
 backends/trace-events                   |   1 +
 chardev/char-io.c                       |   5 +
 chardev/char-socket.c                   |  34 +--
 configs/devices/arm-softmmu/default.mak |   1 -
 docs/about/deprecated.rst               |   7 -
 docs/about/removed-features.rst         |   7 +
 docs/system/arm/highbank.rst            |  19 --
 docs/system/target-arm.rst              |   1 -
 hw/arm/Kconfig                          |  21 +-
 hw/arm/highbank.c                       | 404 -----------------------------
 hw/arm/meson.build                      |   1 -
 hw/arm/smmuv3-accel.c                   | 146 ++++++++++-
 hw/arm/smmuv3-accel.h                   |   6 +
 hw/arm/smmuv3-internal.h                |   6 +-
 hw/arm/smmuv3.c                         |  35 ++-
 hw/arm/trace-events                     |   2 +-
 hw/arm/virt.c                           |   1 -
 hw/gpio/aspeed_gpio.c                   |   2 +-
 hw/net/Kconfig                          |   3 -
 hw/net/meson.build                      |   1 -
 hw/net/smc91c111.c                      |  16 +-
 hw/net/xgmac.c                          | 443 --------------------------------
 include/hw/arm/smmuv3-common.h          |   4 +-
 include/migration/vmstate.h             |  10 +
 include/system/iommufd.h                |  14 +
 scripts/coverity-scan/COMPONENTS.md     |   2 +-
 scripts/lsan_suppressions.txt           |  26 ++
 scripts/oss-fuzz/lsan_suppressions.txt  |   5 -
 system/qtest.c                          |   5 +-
 target/arm/helper.c                     |   5 -
 target/arm/hvf/hvf.c                    | 334 ++++++++++++++++++++++--
 target/arm/hvf/hvf_sme_stubs.h          | 172 +++++++++++++
 target/arm/hvf/sysreg.c.inc             |   8 +
 target/arm/hvf_arm.h                    |  41 +++
 target/arm/kvm-stub.c                   |   5 +
 target/arm/kvm.c                        |   9 +-
 target/arm/kvm_arm.h                    |   9 +
 target/arm/machine.c                    | 117 +++++++--
 target/arm/trace-events                 |   3 +
 target/arm/whpx/whpx-all.c              |   7 -
 tests/docker/test-fuzz                  |   2 +-
 tests/qtest/iommu-smmuv3-test.c         |   1 +
 tests/qtest/qos-test.c                  |  36 ++-
 tests/qtest/test-x86-cpuid-compat.c     |   4 +
 48 files changed, 1001 insertions(+), 1030 deletions(-)
 delete mode 100644 docs/system/arm/highbank.rst
 delete mode 100644 hw/arm/highbank.c
 delete mode 100644 hw/net/xgmac.c
 create mode 100644 scripts/lsan_suppressions.txt
 delete mode 100644 scripts/oss-fuzz/lsan_suppressions.txt
 create mode 100644 target/arm/hvf/hvf_sme_stubs.h

