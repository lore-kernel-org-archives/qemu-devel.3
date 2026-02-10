Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47A2EA8118
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpoA1-0001vV-5J; Tue, 10 Feb 2026 08:52:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoA0-0001vN-0x
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:12 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpo9x-0006J1-MQ
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:11 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso47908735e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 05:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770731528; x=1771336328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=aQ4WeJ9IbD7bTj5Ch+D+QcbzqcLv42b3SWREFU9bIok=;
 b=bhvwkV9fZrdCEKHEswdyPWo01QVaBqyUSRRMKQjcRndfK3l7uf5n9f1p6Es01C2UTZ
 xQuZa3YN34L+/sl325GAxfEpi/GaG8upMCWSchNshkeKqWu+anDPXlf3bOzC7FaefXjo
 kOEmz8CB9oJtb/3k13yMJzXuaJsbwvh6npkdE0r4zoEeiBd39er7ov9Zyz4SeSw9tKp4
 A/UHrZKZGT8NrcV/MQqvjYRqucBY9zrbKriMUqnrfrZeqFmN9maYrUsXjyq4JwHaI2ae
 ZQzEAFYSycS1H9be1i6dBAwSag0Np5vT2+PuJ3d6GQwCqWETK178AImIOpSBVsICTYyr
 sXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770731528; x=1771336328;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aQ4WeJ9IbD7bTj5Ch+D+QcbzqcLv42b3SWREFU9bIok=;
 b=Xy8WvGlKr2jnoDGp5rOmeAZ1cITu0p0ItpXePAYqt2lKr7k7k6bjnTSsqWVhZfQWq3
 /OwkTerzlxJr/iIQhZ+QWg+fs9dIAl7Q+41K+G/oJ75XvBq0iRi0BmAnZVTw5WUD9Dhh
 lED8x56HAS9T4RjEiR4fISMXsY4mEhvGi5Woy2sjdYNZFLLqcydFEnQwEwtyPBIMvE32
 kc3BDX5C8qsJGajCrssU3NAl0B+uV9MWlNkx2BQVF4DL1WSrL3e7gQShDI9m6SdDZI10
 /IRYR+1p+NutYYynggg4PZFyT75Mjh23drQARbvcnhkYi4+p5DHTAo+4ZRlU1SBu4USB
 3pKw==
X-Gm-Message-State: AOJu0YxFLyUvGzJRG3n81tUDs7jdNeKjYBN41XpTuwXfpJw75okq9K7v
 HupBrG/IznlwIXo8C5XrpuwzybBeuaXXVusPXReddUN8vj/zRMhAS93qXZ8DIK1eRI4IPjpuTIk
 seksr
X-Gm-Gg: AZuq6aKt1zsZMUSWzudy1SgTHSJWkJjPuO7fOTeDXA3qtEdz+hNjY4Z+umTuefQXVKY
 DFGboIxTfLHKidTXQ1gX9p5YJX23wdqH+QvSC1suNju+f90nwmmHBXnJQpRQhxBcQKHrIwtCcba
 x5dpXDNIaqMHUetqrHRcSv8PXjVZTMQ0vrXG7n3cAb4FUhFw99zz7P6rBSUpifFyPq9ZHx1RQg8
 rvzqXpFcQcU4kCr1LPIg2eVPpsDelhfiWTqO6djh4PNL5SyLt3rzUN12YFPRDYt+022qrlf23Fv
 43GbBuLK11gIs4OukTpRPqhYOzVgS2ZHPhjVGKL0TalUhGbLf4jEj+x9a/8if2MrsJ/xy0XGPxX
 pVJi+oBBek3K2+gexfpnc13WMHj+EatQL9S3uc+eUd31c8YKhB/SaGgHOBWhfz5WnkqkxJ4tDBO
 +4WNC1xrty5EkzXdpLcaOzXq7O71oE6oyBr/hUzo74NRH05d15aH2lr0QxKHaRNk/N8xSA+DF6P
 NCQfSMrfGuzTRF31qGI/pPMRlOBOc4=
X-Received: by 2002:a05:600c:8489:b0:47d:3ffa:5f03 with SMTP id
 5b1f17b1804b1-483202161b8mr243511655e9.21.1770731527916; 
 Tue, 10 Feb 2026 05:52:07 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d77f9sm64344875e9.3.2026.02.10.05.52.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 05:52:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/26] target-arm queue
Date: Tue, 10 Feb 2026 13:51:40 +0000
Message-ID: <20260210135206.229528-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
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

The following changes since commit 0b91040d23dc8820724a60c811223b777f3bc6b7:

  Merge tag 'pull-loongarch-20260210' of https://github.com/gaosong715/qemu into staging (2026-02-10 09:12:38 +0000)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260210

for you to fetch changes up to a2834b853d9e0f3e193671ab1f20b27329a02ece:

  target/arm: implement FEAT_E2H0 (2026-02-10 12:52:39 +0000)

----------------------------------------------------------------
target-arm queue:
 * Add whpx accelerator support for the virt board
 * Implement FEAT_E2H0
 * Implement WFE, SEV and SEVONPEND for Cortex-M

----------------------------------------------------------------
Alex Bennée (1):
      target/arm: implement FEAT_E2H0

Ashish Anand (1):
      target/arm: Implement WFE, SEV and SEVONPEND for Cortex-M

Eric Auger (1):
      hw/arm/virt: Rename arm_virt_compat into arm_virt_compat_defaults

Mohamed Mediouni (20):
      qtest: hw/arm: virt: skip ACPI test for IORT with GICv2
      hw: arm: virt: rework MSI-X configuration
      tests: data: update AArch64 ACPI tables
      qtest: hw/arm: virt: add ACPI tables for new GICv3 + GICv2m test case
      qtest: hw/arm: virt: add new test case for GICv3 + GICv2m
      docs: arm: update virt machine model description
      whpx: Move around files before introducing AArch64 support
      whpx: reshuffle common code
      whpx: ifdef out winhvemulation on non-x86_64
      whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
      hw, target, accel: whpx: change apic_in_platform to kernel_irqchip
      whpx: add arm64 support
      whpx: change memory management logic
      target/arm: cpu: mark WHPX as supporting PSCI 1.3
      whpx: arm64: clamp down IPA size
      hw/arm, accel/hvf, whpx: unify get_physical_address_range between WHPX and HVF
      whpx: arm64: implement -cpu host
      target/arm: whpx: instantiate GIC early
      whpx: enable arm64 builds
      whpx: arm64: add partition-wide reset on the reboot path

Philippe Mathieu-Daudé (2):
      accel/system: Introduce hwaccel_enabled() helper
      target/arm: Remove entry for "any" from cpu32 arm_tcg_cpus[] list

Sebastian Ott (1):
      target/arm/kvm: add constants for new PSCI versions

 MAINTAINERS                                        |   6 +
 accel/hvf/hvf-all.c                                |   7 +-
 accel/meson.build                                  |   1 +
 accel/stubs/whpx-stub.c                            |   1 +
 accel/whpx/meson.build                             |   7 +
 {target/i386 => accel}/whpx/whpx-accel-ops.c       |   6 +-
 accel/whpx/whpx-common.c                           | 536 +++++++++++
 docs/system/arm/emulation.rst                      |   1 +
 docs/system/arm/virt.rst                           |  24 +-
 hw/arm/virt-acpi-build.c                           |  20 +-
 hw/arm/virt.c                                      | 154 +++-
 hw/i386/x86-cpu.c                                  |   4 +-
 hw/intc/arm_gicv3_common.c                         |   3 +
 hw/intc/arm_gicv3_whpx.c                           | 237 +++++
 hw/intc/armv7m_nvic.c                              |  79 +-
 hw/intc/meson.build                                |   1 +
 include/hw/arm/virt.h                              |   5 +-
 include/hw/core/boards.h                           |   3 +-
 include/hw/intc/arm_gicv3_common.h                 |   3 +
 include/system/hvf_int.h                           |   4 +
 include/system/hw_accel.h                          |  13 +
 .../i386/whpx => include/system}/whpx-accel-ops.h  |   4 +-
 include/system/whpx-all.h                          |  20 +
 include/system/whpx-common.h                       |  26 +
 .../i386/whpx => include/system}/whpx-internal.h   |  16 +-
 include/system/whpx.h                              |   5 +-
 meson.build                                        |  20 +-
 target/arm/cpu-features.h                          |  15 +
 target/arm/cpu.c                                   |   9 +
 target/arm/cpu.h                                   |   7 +
 target/arm/cpu64.c                                 |  17 +-
 target/arm/helper.c                                |  21 +-
 target/arm/hvf-stub.c                              |  20 -
 target/arm/hvf/hvf.c                               |   6 +-
 target/arm/hvf_arm.h                               |   3 -
 target/arm/kvm-consts.h                            |   2 +
 target/arm/machine.c                               |  19 +
 target/arm/meson.build                             |   2 +-
 target/arm/tcg/cpu32.c                             |   3 -
 target/arm/tcg/helper.h                            |   1 +
 target/arm/tcg/m_helper.c                          |   5 +
 target/arm/tcg/op_helper.c                         |  56 +-
 target/arm/tcg/t16.decode                          |   5 +-
 target/arm/tcg/t32.decode                          |   5 +-
 target/arm/tcg/translate.c                         |  29 +-
 target/arm/whpx/meson.build                        |   5 +
 target/arm/whpx/whpx-all.c                         | 994 +++++++++++++++++++++
 target/arm/whpx/whpx-stub.c                        |  15 +
 target/arm/whpx_arm.h                              |  17 +
 target/i386/cpu-apic.c                             |   2 +-
 target/i386/hvf/hvf.c                              |  11 +
 target/i386/whpx/meson.build                       |   1 -
 target/i386/whpx/whpx-all.c                        | 569 +-----------
 target/i386/whpx/whpx-apic.c                       |   2 +-
 tests/data/acpi/aarch64/virt/APIC.msi_gicv2m       | Bin 0 -> 188 bytes
 tests/data/acpi/aarch64/virt/IORT                  | Bin 128 -> 84 bytes
 tests/data/acpi/aarch64/virt/IORT.msi_gicv2m       | Bin 0 -> 172 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev       | Bin 364 -> 260 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy    | Bin 276 -> 192 bytes
 tests/qtest/bios-tables-test.c                     |  21 +
 60 files changed, 2383 insertions(+), 685 deletions(-)
 create mode 100644 accel/whpx/meson.build
 rename {target/i386 => accel}/whpx/whpx-accel-ops.c (96%)
 create mode 100644 accel/whpx/whpx-common.c
 create mode 100644 hw/intc/arm_gicv3_whpx.c
 rename {target/i386/whpx => include/system}/whpx-accel-ops.h (92%)
 create mode 100644 include/system/whpx-all.h
 create mode 100644 include/system/whpx-common.h
 rename {target/i386/whpx => include/system}/whpx-internal.h (95%)
 delete mode 100644 target/arm/hvf-stub.c
 create mode 100644 target/arm/whpx/meson.build
 create mode 100644 target/arm/whpx/whpx-all.c
 create mode 100644 target/arm/whpx/whpx-stub.c
 create mode 100644 target/arm/whpx_arm.h
 create mode 100644 tests/data/acpi/aarch64/virt/APIC.msi_gicv2m
 create mode 100644 tests/data/acpi/aarch64/virt/IORT.msi_gicv2m

