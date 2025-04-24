Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E71C369D5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u84wc-0004SJ-Uu; Thu, 24 Apr 2025 18:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84wZ-0004S6-3k
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:21:20 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84wW-0000vb-W1
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:21:18 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3914aba1ce4so1204517f8f.2
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745533274; x=1746138074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hc9oFBxQbOXJtIL/AdITLWvLaB7iAJbD619rbLcK/kM=;
 b=lbuthDVdTwO3wt/djKKvgVfLZsZfgsIKJ2GMvELufManExaHpGkO9tlSdWBvdMJXEF
 uW3pjFoh1/uOmW6cFaFA+7fDmxqXdTSK4dBtjS1xjltBe7VropC6u/yhiggxGrdtyTxA
 E89wRGzO7ml7dklMgEOkdBqv6YcU1ZAqDG1rPt0M7h2Hiup8AW+hAYKMnFsZvoCvw8DY
 PbafD8FXP/KTI+paEOssX4Bbr9JlJsd7DWE2ePrp5fl8SHk0G8Bj66wguAEcf1W+44wI
 FvxAuk/puPeLVzos0XItX5Gq3y9RVqVS1BCcUvqYgJB4kzxYLNamlZUiSxgzlAg2p1ab
 qzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745533274; x=1746138074;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hc9oFBxQbOXJtIL/AdITLWvLaB7iAJbD619rbLcK/kM=;
 b=da9ldnuGKmAgph9hoo7QbnJDF4MOfvtWd6y615m56lKvRMO9wO5cFbeYlc+vHnryiY
 33ytycTRmNUa7X2T+JIx4SPJQ4BcLi6P/9TJ26x5VBKG5LazXX+9l07X27EFapdNWXz9
 mYtH0jl5PPU1FULlTe81J7syEc/xJfR38tccTr5YqyIL08PKLmMRauSFPMaNlIjJmgd0
 Yo4MBvPPFE9GjnOe8q8xZG/MfW15l0r8feaJxDG2Hc1df/H2q7os+JBZ9wqth7/UYEEt
 AzjxAkMnqCUN6/MUhbpOz3UKvjqvl4SAWL6FNJxlKaCraVLCUHDQVeYNpmUkR1bRhljJ
 uQOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmj4XQtzZL8xZG1+ixL6oyg1Xv4DUnOkJWtTzznQXksQ8U+pZcoQQL/9TnjPWT60JTVCOtIPkOnaqx@nongnu.org
X-Gm-Message-State: AOJu0YzgGOaIdlJ8IlP55cLVom02XR+fG7Rl6nxQheH8A3xoyZPlsaDF
 kmezOJXwFMlDh3YEPyrzlIEZyLAT+1f6PamOxEWwjXFxlTk0nIE3syKCcvc1pqM=
X-Gm-Gg: ASbGncv7qGE6PXPBIj+auVG2nxpFFzkhO5OU6X8qSbkyzS8xJgDHqziUfMRhmBhIGBj
 xfrfbNrPGfwvz+NAbouf3vpMrr1QVwX5MD6+FxigBwyFcMYjYpi9kHFTqK46lwTmBT56knhjZwy
 Utet3yh6STj47HtUm8iSCoby+kStJfq5Vt8ejYfZvlKjgeEtnL8NfWmoRXwiwf9nnqaBxj+F+5V
 OXa0znq2XSEHFNza3vModXa584+jxN2cOhckFm055ytRTfAXInNn1XgEptECWFPWFvRLJ3L74TV
 EStJl5vehc6ZTeqyjwvBDZfwy5sKETCmB8kjIk8HcYNtWjCutmfnSz3lgr+qKd8skPlLRX0axxR
 5vurhMuwMItEvk2/kabTgAvbCPQ==
X-Google-Smtp-Source: AGHT+IGlZJmnEhRlvc/fU9hPcLYHrUFYC+aitAFtqHUeozSl6cJkzT8IHwyzMYgDCus8Q6n7MdPafg==
X-Received: by 2002:a5d:47cc:0:b0:39f:9f:a177 with SMTP id
 ffacd0b85a97d-3a072a99d31mr612092f8f.17.1745533274258; 
 Thu, 24 Apr 2025 15:21:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ccb8e1sm516449f8f.59.2025.04.24.15.21.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 15:21:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v5 00/21] single-binary: Make hw/arm/ common
Date: Fri, 25 Apr 2025 00:20:51 +0200
Message-ID: <20250424222112.36194-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Since v4:
- Add DEFINE_MACHINE_WITH_INTERFACES (Zoltan)
- Use GPtrArray for get_valid_cpu_type (Richard)
- Define InterfaceInfo[] arrays (Richard)
- Collect R-b tags

Since v3:
- QAPI structure renamed as QemuTargetInfo
- MachineClass::get_valid_cpu_types() runtime
- target_aarch64() checking SysEmuTarget value
- Remove CONFIG_TCG #ifdef'ry in hw/arm/

Since v2:
- More comments from Pierrick addressed
- Use GList to register valid CPUs list
- Remove all TARGET_AARCH64 uses in hw/arm/

Since v1:
- Dropped unrelated / irrelevant patches
- Addressed Pierrick comments
- Added R-b tag
- Only considering machines, not CPUs.

Available here, based on my pending patch queue:
https://gitlab.com/philmd/qemu/-/tags/single-binary-hw-arm-rfc-v5

Philippe Mathieu-Daudé (21):
  qapi: Rename TargetInfo structure as QemuTargetInfo
  qemu: Convert target_name() to TargetInfo API
  system/vl: Filter machine list available for a particular target
    binary
  hw/core/null-machine: Define machine as generic QOM type
  hw/arm: Register TYPE_TARGET_ARM/AARCH64_MACHINE QOM interfaces
  hw/core: Allow ARM/Aarch64 binaries to use the 'none' machine
  hw/boards: Introduce DEFINE_MACHINE_WITH_INTERFACES() macro
  hw/arm: Add DEFINE_MACHINE_[ARM_]AARCH64() macros
  hw/arm: Filter machine types for qemu-system-arm/aarch64 binaries
  meson: Prepare to accept per-binary TargetInfo structure
    implementation
  config/target: Implement per-binary TargetInfo structure (ARM,
    AARCH64)
  hw/arm/aspeed: Build objects once
  hw/arm/raspi: Build objects once
  hw/core/machine: Allow dynamic registration of valid CPU types
  hw/arm/virt: Register valid CPU types dynamically
  hw/arm/virt: Check accelerator availability at runtime
  qemu/target_info: Add %target_arch field to TargetInfo
  qemu/target_info: Add target_aarch64() helper
  hw/arm/virt: Replace TARGET_AARCH64 -> target_aarch64()
  hw/core: Introduce MachineClass::get_default_cpu_type() helper
  hw/arm/virt: Get default CPU type at runtime

 MAINTAINERS                       |  8 ++++
 meson.build                       | 11 +++++
 qapi/machine.json                 | 10 ++---
 include/hw/arm/machines-qom.h     | 31 +++++++++++++
 include/hw/boards.h               | 16 ++++++-
 include/hw/core/cpu.h             |  2 -
 include/qemu/target-info-impl.h   | 31 +++++++++++++
 include/qemu/target-info.h        | 34 ++++++++++++++
 configs/targets/aarch64-softmmu.c | 23 ++++++++++
 configs/targets/arm-softmmu.c     | 23 ++++++++++
 cpu-target.c                      |  5 ---
 hw/arm/aspeed.c                   | 31 ++++++++++---
 hw/arm/b-l475e-iot01a.c           |  2 +
 hw/arm/bananapi_m2u.c             |  3 +-
 hw/arm/bcm2836.c                  |  4 --
 hw/arm/collie.c                   |  2 +
 hw/arm/cubieboard.c               |  3 +-
 hw/arm/digic_boards.c             |  3 +-
 hw/arm/exynos4_boards.c           |  3 ++
 hw/arm/fby35.c                    |  2 +
 hw/arm/highbank.c                 |  3 ++
 hw/arm/imx25_pdk.c                |  3 +-
 hw/arm/imx8mp-evk.c               |  4 +-
 hw/arm/integratorcp.c             |  3 +-
 hw/arm/kzm.c                      |  3 +-
 hw/arm/mcimx6ul-evk.c             |  4 +-
 hw/arm/mcimx7d-sabre.c            |  4 +-
 hw/arm/microbit.c                 |  2 +
 hw/arm/mps2-tz.c                  |  5 +++
 hw/arm/mps2.c                     |  5 +++
 hw/arm/mps3r.c                    |  2 +
 hw/arm/msf2-som.c                 |  3 +-
 hw/arm/musca.c                    |  3 ++
 hw/arm/musicpal.c                 |  3 +-
 hw/arm/netduino2.c                |  3 +-
 hw/arm/netduinoplus2.c            |  3 +-
 hw/arm/npcm7xx_boards.c           |  6 +++
 hw/arm/npcm8xx_boards.c           |  2 +
 hw/arm/olimex-stm32-h405.c        |  3 +-
 hw/arm/omap_sx1.c                 |  3 ++
 hw/arm/orangepi.c                 |  3 +-
 hw/arm/raspi.c                    | 10 +++--
 hw/arm/raspi4b.c                  |  2 +
 hw/arm/realview.c                 |  5 +++
 hw/arm/sabrelite.c                |  3 +-
 hw/arm/sbsa-ref.c                 |  2 +
 hw/arm/stellaris.c                |  3 ++
 hw/arm/stm32vldiscovery.c         |  3 +-
 hw/arm/versatilepb.c              |  3 ++
 hw/arm/vexpress.c                 |  3 ++
 hw/arm/virt.c                     | 74 ++++++++++++++++++-------------
 hw/arm/xilinx_zynq.c              |  2 +
 hw/arm/xlnx-versal-virt.c         |  2 +
 hw/arm/xlnx-zcu102.c              |  2 +
 hw/core/machine-qmp-cmds.c        |  5 ++-
 hw/core/machine.c                 | 36 +++++++++++++++
 hw/core/null-machine.c            | 20 ++++++++-
 plugins/loader.c                  |  2 +-
 system/vl.c                       |  7 +--
 target-info-qom.c                 | 24 ++++++++++
 target-info-stub.c                | 22 +++++++++
 target-info.c                     | 26 +++++++++++
 target/arm/machine.c              | 12 +++++
 configs/targets/meson.build       |  5 +++
 hw/arm/meson.build                | 12 +++--
 65 files changed, 513 insertions(+), 89 deletions(-)
 create mode 100644 include/hw/arm/machines-qom.h
 create mode 100644 include/qemu/target-info-impl.h
 create mode 100644 include/qemu/target-info.h
 create mode 100644 configs/targets/aarch64-softmmu.c
 create mode 100644 configs/targets/arm-softmmu.c
 create mode 100644 target-info-qom.c
 create mode 100644 target-info-stub.c
 create mode 100644 target-info.c
 create mode 100644 configs/targets/meson.build

-- 
2.47.1


