Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948A9C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0US8-0004O9-Ny; Thu, 03 Apr 2025 19:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0US6-0004Nn-16
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:58:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0US3-0002P5-SZ
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:58:29 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so10042005e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724706; x=1744329506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=m8iJ/OcuqmCG4PWk4V4uwr/6V05cUR6OFiELOu5Xl3k=;
 b=RgN1QNLUeWtaQpGteIbDYdsDVQP2zuIG58xI0dGGWC6ek4dmW3ibvqUS95OvH7CxlJ
 uPL/39oVMmd8B/F2P5Tr+fsDBvb26VLIcQ9j1ODSJznZ3KkyXKACVcESjloSpecGVlwd
 zDwGwvuVkwtHxbAMnUUj7UFItoQwVa9CEYG+k4tzewpJxY7ynKsVq2VPst9GT1hBMbsE
 enopPwfT3E2KKPMonRFjZTTJvld8mDrSsWaj89kvju+1FZf3wKAc4Sm1ORb2QTVCLZri
 YkN7RnngW45CELR9sIqGG7O+qFddY5We8Y+9DpqQc+Ilu/7dpiO6UneooAlWBs3O8EZb
 DUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724706; x=1744329506;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m8iJ/OcuqmCG4PWk4V4uwr/6V05cUR6OFiELOu5Xl3k=;
 b=p3s7+daxBMmXW+dBjr495XrubgeWFbWedgPRLIACPhvskhzmgq6/JJhvMShIixlI1P
 SsyZrO9RiiM91cgCAAdo/yczPrdDg9uR7Ro43jL1oLzYZfJ3bRnZSpiUKnz7cDiBBlzl
 Ox1QIvFGOhk6f4z12d3TN1SBfPSbYukDPNuStbyrgSKt+G4uGNd4CFVjtbKAMnOSfmJL
 NBVJk+qAlKeA6w5AuqsD6uS7dlFpoo66RzcAac4u4XdNaW5WETsqCup7QcqWD8vExzOY
 iDVYZjKaWKc2ZgWS7ksVv9ZJ2RDNzS42eSr32jK7P2Pux0a7ZW8B+ml4BSTts93QghOd
 9GBg==
X-Gm-Message-State: AOJu0YxiIbbXsXVHDqjgj2fPqqot9kvG5hqeT74EwdE8Akj04mM1Hmpk
 gdGUHlZFSTUbODF9Oxgg3nE1A2ebjkt9hN4AsxNNkyEVFaKETP7yKiePRn+V7dtciYAU+AnIQRS
 V
X-Gm-Gg: ASbGnctqcfgPGOXTfR71S0ZMAht1WWemXyl22K5zBafV6tsI+UQViusk7esPq6Ng8nX
 CyI4Q6jmGijWovtxzlPlf3ZaSlVc6FaXYE6ouuaq3mL5dDMrVYfbnmp2gMARO+nUYJlr626xHT/
 nnTZdiMXWSH5/cIF/s/5m4qbW9TAM3JzcBZ5x3NpaI/kBbSJP6wN3i1VGEFYR7bDCE77cs4jTWN
 xyaTLEvE5PsanX8HXq+Ph3EfJi8JdTzn45ymOrkurTS1qgb5oVSNJF++gjJIx3aF953slEaDt2N
 oDAzr5jrWsXhALD5LywINF/VXf2XNXQDVnjw67qztnr2uIkGba6mTuFz4dPWmHWQ0OGxeYTvimd
 NOY3aDHz9KLuiwz1KOWM=
X-Google-Smtp-Source: AGHT+IEnspoWg3KK8imldwHfqGG3jiWBONBZZ+AxPZgAxtUxO/PMX2UmRCxx4XvZnSlhelfC3QzpBQ==
X-Received: by 2002:a05:600c:198b:b0:43c:f1b8:16ad with SMTP id
 5b1f17b1804b1-43ecfa0572cmr9234125e9.30.1743724705739; 
 Thu, 03 Apr 2025 16:58:25 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec17b1352sm33729525e9.37.2025.04.03.16.58.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:58:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 00/39] single-binary: Make hw/arm/ common
Date: Fri,  4 Apr 2025 01:57:42 +0200
Message-ID: <20250403235821.9909-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Hi,

At this point this series is mostly a draft for Pierrick.

After introducing the generic TargetInfo API [*], we implement
the ARM variants, then use the API to remove target-specific code,
allowing to eventually remove the target-specific arm_ss[] source
set in meson.build, having all objects in arm_common_ss[].
Various header cleanups are necessary before getting there.

Regards,

Phil.

Available here, based on tcg-next:
https://gitlab.com/philmd/qemu/-/tags/single-binary-hw-arm-rfc-v1

[*] https://lore.kernel.org/qemu-devel/20250403234914.9154-1-philmd@linaro.org/

Philippe Mathieu-Daudé (39):
  target/arm: Implement per-binary TargetInfo structures
  target/arm: Register TYPE_BINARY_QEMU_SYSTEM_ARM/AARCH64 interfaces
  target/arm: Filter CPU types for binary
  hw/arm: Filter machine types for binary
  hw/arm/aspeed: Filter machine types for binary
  hw/arm/aspeed: Build objects once
  hw/arm/raspi: Filter machine types for binary
  hw/arm/raspi: Build objects once
  target/arm/cpregs: Include missing 'target/arm/cpu.h' header
  hw/arm/boot: Include missing 'system/memory.h' header
  hw/arm: Use full "target/arm/cpu.h" path to include target's "cpu.h"
  target/arm/cpu-features: Include missing 'cpu.h' header
  target/arm/qmp: Include missing 'cpu.h' header
  target/arm/kvm: Include missing 'cpu-qom.h' header
  target/arm/hvf: Include missing 'cpu-qom.h' header
  hw/arm: Remove unnecessary 'cpu.h' header
  target/arm: Restrict inclusion of 'multiprocessing.h'
  target/arm: Move some definitions from 'cpu.h' to 'multiprocessing.h'
  hw/arm: Include missing 'target/arm/gtimer.h' header
  target/arm: Extract PSCI definitions to 'psci.h'
  target/arm: Extract feature definitions to 'cpu_has_feature.h' header
  target/arm: Add arm_cpu_has_feature() helper
  hw/arm/realview: Replace arm_feature() -> arm_cpu_has_feature()
  hw/arm/virt-acpi: Replace arm_feature() -> arm_cpu_has_feature()
  hw/arm: Build virt-acpi-build.c once
  system/hvf: Avoid including 'cpu.h'
  system/hvf: Expose hvf_enabled() to common code
  exec: Do not poison hardware accelerators
  hw/arm: Build sbsa-ref.c once
  target/arm: Replace target_ulong -> hwaddr in ARMMMUFaultInfo
  target/arm: Replace target_ulong -> uint64_t for HWBreakpoint
  target/arm: Replace target_ulong -> vaddr for CPUWatchpoint
  hw/core/machine: Allow dynamic registration of valid CPU types
  hw/arm/virt: Register valid CPU types dynamically
  hw/arm/virt: Replace TARGET_AARCH64 -> target_long_bits()
  target/arm: Expose Aarch64 helpers indistinctly
  hw/arm: Build virt.c once
  hw/arm: Move xen files to arm_common_ss[]
  hw/arm/meson: Remove arm_ss[] source set

 MAINTAINERS                              |  1 +
 meson.build                              |  1 +
 include/exec/poison.h                    |  4 --
 include/hw/arm/boot.h                    |  3 +-
 include/hw/arm/digic.h                   |  2 +-
 include/hw/arm/fsl-imx6.h                |  2 +-
 include/hw/arm/fsl-imx6ul.h              |  2 +-
 include/hw/arm/fsl-imx7.h                |  2 +-
 include/hw/arm/fsl-imx8mp.h              |  2 +-
 include/hw/boards.h                      |  8 +++
 include/qemu/target_info-qom.h           | 20 ++++++
 include/system/hvf.h                     | 17 ++++--
 include/system/hvf_int.h                 |  2 +
 target/arm/cpregs.h                      |  1 +
 target/arm/cpu-features.h                |  1 +
 target/arm/cpu.h                         | 78 +-----------------------
 target/arm/cpu_has_feature.h             | 67 ++++++++++++++++++++
 target/arm/hvf_arm.h                     |  2 +-
 target/arm/internals.h                   | 22 +++----
 target/arm/kvm_arm.h                     |  1 +
 target/arm/multiprocessing.h             | 18 ++++++
 target/arm/psci.h                        | 18 ++++++
 accel/stubs/hvf-stub.c                   | 12 ++++
 hw/arm/aspeed.c                          | 30 ++++++---
 hw/arm/aspeed_ast2600.c                  |  1 +
 hw/arm/aspeed_ast27x0.c                  |  2 +
 hw/arm/b-l475e-iot01a.c                  |  1 +
 hw/arm/bananapi_m2u.c                    |  1 +
 hw/arm/bcm2836.c                         |  4 --
 hw/arm/bcm2838.c                         |  1 +
 hw/arm/boot.c                            |  2 +
 hw/arm/collie.c                          |  1 +
 hw/arm/exynos4210.c                      |  3 +-
 hw/arm/exynos4_boards.c                  |  1 +
 hw/arm/fby35.c                           |  1 +
 hw/arm/fsl-imx8mp.c                      |  1 +
 hw/arm/highbank.c                        |  4 +-
 hw/arm/imx8mp-evk.c                      |  1 +
 hw/arm/mcimx6ul-evk.c                    |  1 +
 hw/arm/mcimx7d-sabre.c                   |  1 +
 hw/arm/microbit.c                        |  1 +
 hw/arm/mps2-tz.c                         |  4 ++
 hw/arm/mps2.c                            |  4 ++
 hw/arm/mps3r.c                           |  3 +-
 hw/arm/musca.c                           |  2 +
 hw/arm/npcm8xx.c                         |  2 +
 hw/arm/omap_sx1.c                        |  2 +
 hw/arm/orangepi.c                        |  1 +
 hw/arm/raspi.c                           |  9 +--
 hw/arm/raspi4b.c                         |  1 +
 hw/arm/realview.c                        | 14 +++--
 hw/arm/sbsa-ref.c                        |  3 +
 hw/arm/smmuv3.c                          |  1 -
 hw/arm/stellaris.c                       |  3 +
 hw/arm/versatilepb.c                     |  1 +
 hw/arm/vexpress.c                        |  2 +
 hw/arm/virt-acpi-build.c                 |  4 +-
 hw/arm/virt.c                            | 44 +++++++------
 hw/arm/xilinx_zynq.c                     |  1 +
 hw/arm/xlnx-versal-virt.c                |  2 +
 hw/arm/xlnx-zcu102.c                     |  2 +
 hw/core/machine.c                        | 28 +++++++++
 hw/vmapple/vmapple.c                     |  3 +
 target/arm/arm-qmp-cmds.c                |  1 +
 target/arm/cpu.c                         | 10 +++
 target/arm/cpu64.c                       |  2 +
 target/arm/helper.c                      |  1 +
 target/arm/hvf/hvf.c                     |  1 +
 target/arm/hyp_gdbstub.c                 | 14 ++---
 target/arm/kvm.c                         |  1 +
 target/arm/target_info-aarch64-softmmu.c | 24 ++++++++
 target/arm/target_info-arm-softmmu.c     | 24 ++++++++
 target/arm/tcg/op_helper.c               |  2 +
 target/arm/tcg/psci.c                    |  1 +
 target_info-qom.c                        |  8 +++
 accel/stubs/meson.build                  |  1 +
 hw/arm/meson.build                       | 22 ++++---
 scripts/make-config-poison.sh            |  4 ++
 target/arm/meson.build                   |  5 ++
 79 files changed, 429 insertions(+), 171 deletions(-)
 create mode 100644 target/arm/cpu_has_feature.h
 create mode 100644 target/arm/psci.h
 create mode 100644 accel/stubs/hvf-stub.c
 create mode 100644 target/arm/target_info-aarch64-softmmu.c
 create mode 100644 target/arm/target_info-arm-softmmu.c

-- 
2.47.1


