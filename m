Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9BBEE0203
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vagwn-0004Sh-3i; Tue, 30 Dec 2025 16:08:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagwl-0004Re-JV
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:08:03 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagwj-0002Az-F8
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:08:03 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-47bdbc90dcaso64167985e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767128879; x=1767733679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/8a9txETZsIGRArhrqD1LIVGpeabi/5aw9YN5bJf928=;
 b=mQKu+94l3H48uYtoX6vfGdZkSjoTP+vuVZGjyGY31ED0lRef98G9v+FhsdVoegGEtI
 2BuYanHiE53UOWi/ilXVEJb7fGzthJq993c8/e/t+/eWzQcKfc8B69yJF+2mT5P1KXSV
 sg1QTV7UeGQDqIam8Y+h6Qe+5bUguhbGMKyd39xNUM6MzYykxjaP+10kMsb3DqI2jwvs
 rmq3rOb1CO1MEPcRQi+CumdX062qmcU3a2d9oAl+16n6ZD1eOlfRXp9Do7Hj152H1kJn
 CtphG963SVuVzJMCTR1YGUrQNpPRx/AgCsotrvNUXn8SagWvMJPUGtiI93Z3DJ0uvgZi
 3yIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767128879; x=1767733679;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/8a9txETZsIGRArhrqD1LIVGpeabi/5aw9YN5bJf928=;
 b=vFPOBcWYdM6LS5vfzQTehFO+BWRul5xN6LaE0ZHxNUqFOAEEcUYr18tKHXXrcsd8q1
 Lm+U2rDEyNr1DxKNwvNMOduG1nA5aWCuavCRdzRtEAQTaeIsT0Wk1l1OWWJ2dO+YhBJn
 no0oTNRSgFiR9WTi+gGZOjlPkxizS9AW5i/ITrRJfck7tBtshpM8iCUz83KEedjYOBtD
 stUOGR1YIRjHEKZU7/sn6yKRgVU2fO47m879Y9nMV9QuxPhJAQS9JqxWAzoDMNXJ/8eY
 kZ5OOOSdsD58B1tiuQxFcPfOdmKmqfTSx/BZdAVRqfEeL2Nr/kuNGtGxHN8d5fYl6QPB
 9a6Q==
X-Gm-Message-State: AOJu0YxDlRhe1dqHJ+L5LrF3+TeeJyhLU/OtSM92dLeQ3wEqE+iIwE7z
 yaoI/uLavvufCxcvCt6/wBeP4H5o1v7ZU861GU19+b6iH21grnJKT5ZNkH3AbooqpyY/lPx97wS
 4l3pH/yc=
X-Gm-Gg: AY/fxX5jkYmF6dHo6qjU4ttHykKv6XpoY65LTm7rUoezm9rCnWGHArKx7pbjPbhMj5p
 JGbwJpMWn5KTR8O+veapMsQvWD1rr59HG8iNbLvnyKCLV41DR14E2i9qSmCuDdBI0WI/rvUOVdV
 iByJNrA+nb+++c9253/hhsY+8gBJFMFWhqYsDFWNJiS2ApbvL7mZYg+ZTy8i0kVCOBEDObsWaF+
 Pn7feENnKm7zcPhtGHaGDHlav7pQjnmFdI8IRUY6PMriULeOqyNwyxtM0YCntTMSR4vWyJyCSmj
 SBjPyCAy8Ty/+jB6FTfTmFfCZU+alaitF1W035MLxfM4NiOPZOmUjKW6YlZ/PcanT0IiMD6vCqq
 XsDZFQeaq7cb6VhN2RmWCb5jVLqpzRyUxSpYQWNeJlZHVCXF/bsTJZD5MZlRu66QcxBwL2WZzge
 hIRy46QfuwlzTKQjgRITKjg+AI/HKG/2mGisdtFR5iLRgxmTA96DEcLg8mdipB
X-Google-Smtp-Source: AGHT+IF9vc+gDpjZfCcZ1zc6lVfBmII0OfP5mcKD9H9ONso9DDD2EuBNYIi94G50xvCHNNgfXvgajg==
X-Received: by 2002:a05:600c:1f84:b0:477:7c7d:d9b7 with SMTP id
 5b1f17b1804b1-47d3884cfdemr295190255e9.33.1767128879345; 
 Tue, 30 Dec 2025 13:07:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2a94sm70817998f8f.43.2025.12.30.13.07.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:07:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/34] Misc HW patches for 2025-12-30
Date: Tue, 30 Dec 2025 22:07:22 +0100
Message-ID: <20251230210757.13803-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

The following changes since commit 942b0d378a1de9649085ad6db5306d5b8cef3591:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2025-12-29 09:10:40 +1100)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20251230

for you to fetch changes up to 4bd2b65e524836fef274fd169db804a2efce8836:

  MAINTAINERS: Change email and status of TriCore (2025-12-30 20:38:41 +0100)

----------------------------------------------------------------
Misc HW patches

- Remove few target_ulong uses
- Make human monitor non-target specific
- Better name for TrustZone Peripheral Protection Controller memory regions
- Do not expose DEVICE_NATIVE_ENDIAN on Rust
- Remove address_space_stl_notdirty() and stl_phys_notdirty()
- Allow to restrict targets to legacy ldst_phys() API
- Fix MinGW-w64 link failure due to ConvertStringToBSTR()
- Header cleanups
- MAINTAINERS updates
----------------------------------------------------------------

Alano Song (1):
  hw/i2c/imx: Fix trace func name error

Alex Bennée (1):
  hw/misc: make the tz-ppc-port names more useful

Anton Johansson (1):
  hw/riscv: Treat kernel_start_addr as vaddr

Bastian Koppelmann (1):
  MAINTAINERS: Change email and status of TriCore

Bin Guo (1):
  meson: Optimize summary_info about directories

Bin Meng (1):
  hw/sd: Remove unused header includes in ssi-sd.c

Nguyen Dinh Phi (2):
  qga/vss-win32: Fix ConvertStringToBSTR redefinition with newer MinGW
  util: Move qemu_ftruncate64 from block/file-win32.c to oslib-win32.c

Osama Abdelkader (1):
  hw/core: remove duplicate include

Philippe Mathieu-Daudé (24):
  monitor/hmp: Replace target_ulong -> vaddr in hmp_gva2gpa()
  monitor/hmp: Make memory_dump() @is_physical argument a boolean
  monitor/hmp: Use plain uint64_t @addr argument in memory_dump()
  monitor/hmp: Remove target_long uses in memory_dump()
  monitor/hmp: Inline ld[uw,l,q]_p() calls in memory_dump()
  monitor/hmp: Fix coding style in hmp-cmds-target.c
  monitor/hmp: Merge hmp-cmds-target.c within hmp-cmds.c
  hw/arm/Kconfig: Have FSL_IMX6UL SoC select IMX_USBPHY
  hw/net/opencores: Clarify MMIO read/write handlers expect 32-bit access
  hw/char/serial: Let compiler pick serial_mm_ops[] array length
  hw/misc/pvpanic: Expose MMIO interface as little-endian
  hw/timer/hpet: Mark implementation as being little-endian
  hw/char/pl011: Mark implementation as being little-endian
  rust/system: Stop exposing bogus DEVICE_NATIVE_ENDIAN symbol
  target/hexagon: Include missing 'cpu.h' header in 'internal.h'
  target/i386: Remove x86_stl_phys_notdirty() leftover
  target/sparc: Update MMU page table using stl_phys()
  hw/arm: Avoid address_space_stl_notdirty() when generating bootloader
  system/memory: Remove address_space_stl_notdirty and stl_phys_notdirty
  system/memory: Allow restricting legacy ldst_phys() API usage
  configs/targets: Mark targets not using legacy ldst_phys() API
  hw/virtio: Remove unused ldst_phys() helpers
  hw/virtio: Reduce virtio_lduw/stw_phys_cached() scope
  configs/targets: Mark targets not using legacy ldst_phys() API

Stefan Hajnoczi (1):
  MAINTAINERS: remove old email for Bandan Das

 MAINTAINERS                              |   5 +-
 configs/targets/avr-softmmu.mak          |   1 +
 configs/targets/microblaze-softmmu.mak   |   1 +
 configs/targets/microblazeel-softmmu.mak |   1 +
 configs/targets/mips-softmmu.mak         |   1 +
 configs/targets/mips64-softmmu.mak       |   1 +
 configs/targets/mips64el-softmmu.mak     |   1 +
 configs/targets/mipsel-softmmu.mak       |   1 +
 configs/targets/or1k-softmmu.mak         |   1 +
 configs/targets/riscv32-softmmu.mak      |   1 +
 configs/targets/riscv64-softmmu.mak      |   1 +
 configs/targets/rx-softmmu.mak           |   1 +
 configs/targets/sh4-softmmu.mak          |   1 +
 configs/targets/sh4eb-softmmu.mak        |   1 +
 configs/targets/sparc64-softmmu.mak      |   1 +
 configs/targets/tricore-softmmu.mak      |   1 +
 configs/targets/xtensa-softmmu.mak       |   1 +
 configs/targets/xtensaeb-softmmu.mak     |   1 +
 meson.build                              |  13 +
 include/hw/riscv/boot.h                  |   6 +-
 include/hw/virtio/virtio-access.h        | 106 -------
 include/system/memory.h                  |   8 +-
 target/hexagon/internal.h                |   2 +-
 target/i386/cpu.h                        |   1 -
 include/system/memory_ldst.h.inc         |   2 -
 block/file-win32.c                       |  32 --
 hw/arm/aspeed.c                          |   4 +-
 hw/arm/boot.c                            |   8 +-
 hw/char/pl011.c                          |   2 +-
 hw/char/serial-mm.c                      |   2 +-
 hw/i2c/imx_i2c.c                         |   4 +-
 hw/misc/pvpanic.c                        |   1 +
 hw/misc/tz-ppc.c                         |   4 +-
 hw/net/opencores_eth.c                   |  15 +-
 hw/riscv/boot.c                          |   6 +-
 hw/riscv/microchip_pfsoc.c               |   3 +-
 hw/riscv/sifive_u.c                      |   3 +-
 hw/riscv/spike.c                         |   2 +-
 hw/riscv/virt.c                          |   3 +-
 hw/sd/ssi-sd.c                           |   4 -
 hw/timer/hpet.c                          |   2 +-
 hw/virtio/virtio.c                       |  21 ++
 monitor/hmp-cmds-target.c                | 381 -----------------------
 monitor/hmp-cmds.c                       | 354 +++++++++++++++++++++
 system/vl.c                              |   1 -
 target/i386/helper.c                     |  10 -
 target/sparc/mmu_helper.c                |   2 +-
 util/oslib-win32.c                       |  33 ++
 system/memory_ldst.c.inc                 |  39 ---
 hw/arm/Kconfig                           |   1 +
 hw/usb/Kconfig                           |   1 -
 monitor/meson.build                      |   2 +-
 qga/vss-win32/install.cpp                |   2 +
 rust/hw/char/pl011/src/device.rs         |   2 +-
 rust/hw/timer/hpet/src/device.rs         |   2 +-
 rust/system/src/memory.rs                |   6 -
 scripts/make-config-poison.sh            |   1 +
 57 files changed, 487 insertions(+), 626 deletions(-)
 delete mode 100644 monitor/hmp-cmds-target.c

-- 
2.52.0


