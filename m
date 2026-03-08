Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C780EEA8543
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMht-0007d1-V7; Sun, 08 Mar 2026 18:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMhs-0007cm-GH
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:34:40 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMhq-000335-8U
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:34:40 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48535a0ef86so5942365e9.1
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009276; x=1773614076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=1qc7AiwDaEuVHA8/ltZEaeyUqyVUosXnfK9Ez2WFOOw=;
 b=P/6mEOKFWo21zDlJGlYZ+TJH0FZd0FevuqXK1tSHwn+MXOHa7old2hHCFwDwZ04Tex
 KchUPmS1zRqpQlgKUi+2aFWXrJ4W4SQp+E5Yb5qcpnbJfSgPmQob1i8+gAAvn+2svICj
 JpAdFFcVme9ME2GOuyuZfZp+5VRxanV+i/A3rt22Uo/8zNjNsY6JNlEqRtFctaC2bxBW
 OPyuEv8As0tEIIJ+lYUjeTRM3uJg/85U+1fOY5BP0MKrXDBvqgNEg0b8fYo3IYOW1Cf7
 KsPdtUwvfn5SPxffGntupbgSXdqkDfoBtOr16XyqlMOW+CXQF3h9EMVMlSG9SwCzKWj2
 14rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009276; x=1773614076;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1qc7AiwDaEuVHA8/ltZEaeyUqyVUosXnfK9Ez2WFOOw=;
 b=J4sjPXYRciDUbYRcBVOe66vKl56XZuB7WwrNGmq0w0ZV06GiI/iHSX79uar8biIAd6
 jXMlS0gGSEvGdCq95JlvD4vqjZLb7/R65zLhBpQKlt8spNttv5kNH0Q+dHLICgD8qQg1
 F5G5kz3MG80tAP7UYowTFnRUBDV1m4bllcb4CcaTkA3GWxJ8i6TS2J/Ff38fTtKw/C51
 PB8NE+u5zkZtXtCrU9oHKCfwM0DSN8OjF8dpAnN7fdui+7YHE0AI/pI33Uuty39Vcz7x
 narIbwU6gfUspFyPtexPog9i6I2tfjoafK1XKfmBlfE9pq530pdFW6xhW35kFNgVV91H
 OYCA==
X-Gm-Message-State: AOJu0YzjGZiQlPyEeSj0ex4gdb8i9+tV1Tfx2YGjwyYxASjeDBFfUXLo
 J9pwzKznAUsR1A7ckpk+eHBZ97E+zTB9gR6lqzMQZ6u+HwKZKh3UlTszCZ6nzhmb3oCsxM8ejY0
 vJQszjeI=
X-Gm-Gg: ATEYQzy5MOm51J7Svr3kFnp4gkryVhYxHKpmf7yCqD8FunThFldsyf5NVVREJJvvBdT
 rwBgKtT154VihtfaEePKc0pYVsMC/gI8DlUswtFpARXB72b/ystlipOPOYvxLAng1vCPnuwEvlS
 SJHDnRvVUsV7zePfsj/Jpmt6vsnI7X6ThoIpbr8sFfdNKsiQ3GjAI02WOd1Q3vWrA2f+28fJu4g
 vSWa8m8JvoVclMd4cEhhWxRjsiE3XYYZycveziwvD2rmU8OF+sGvV7QtJc777ycEeGZ4YD9jlSD
 fQgLJeZGi6K0VQCndkwtiFFt8ykM5nPwle1FSOv7w7fvoojb+MbzIkuJTafA560NIgl5cxji1Fo
 4Fmr3QiYrs9qA0s25qIt7APBPz3RAtE93ZDc/MCVoCOOMmmEnDcg2vh2wFVmwwYkxORbJVA8enj
 55AuElf7Uz0FF1bcALQN7Qy4Wm/JqtBjHDcWqetaAyOhOEZhlMDB3xAh4rMjtQ2WCADYBaUXpt6
 oFYnQ==
X-Received: by 2002:a05:600c:3b0c:b0:477:7bca:8b34 with SMTP id
 5b1f17b1804b1-48526918923mr150647015e9.6.1773009275724; 
 Sun, 08 Mar 2026 15:34:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48539e574b5sm59978685e9.8.2026.03.08.15.34.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:34:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/49] Misc HW patches for 2026-03-08
Date: Sun,  8 Mar 2026 23:33:44 +0100
Message-ID: <20260308223433.25503-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

The following changes since commit 1ae4271ab8dbfbf5dc28b36baa7f3fd5fd2215e1:

  Merge tag 'pull-11.0-virtio-gpu-updates-060326-1' of https://gitlab.com/stsquad/qemu into staging (2026-03-07 11:22:16 +0000)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20260308

for you to fetch changes up to 27c64fa59d1b14c4656908e1dfca49482a96df61:

  hw/char: Drop disable property of Diva GSP card (2026-03-08 23:11:14 +0100)

Following checkpatch errors ignored (first spurious, other ones pre-existing):

ERROR: "foo * bar" should be "foo *bar"
#40: FILE: hw/display/ati_2d.c:60:
+                                                    + dst_y * surface_stride(ds),

ERROR: switch and case should be at the same indent
#27: FILE: hw/net/xilinx_axienet.c:143:
     switch (regnum) {
+        case 2:
+        case 3:

ERROR: braces {} are necessary for all arms of this statement
#43: FILE: hw/char/serial.c:164:
+        if (s->lcr & UART_LCR_EPS)
[...]
         else
[...]

----------------------------------------------------------------
Misc HW patches

- Remove versioned machines released in QEMU 3.0
- Build various stubs and ACPI objects once
- Pair of bug fixes in ATI VGA model
- Cleanups in 16550A UART model
- Clarify PA-RISC CPU models (adding the PA-8500)
- Various memory leaks / overflows fixed
- MAINTAINERS updates
----------------------------------------------------------------

Akihiko Odaki (1):
  ui/cocoa: Do not automatically zoom for HiDPI

Anton Johansson (3):
  hppa: Introduce HPPACPUDef
  hppa: Get physical address space bits from HPPACPUDef
  hppa: Use 44 bit physical addresses for PA-8700

BALATON Zoltan (1):
  ati-vga: Allow setting EDID parameters directly

Bernhard Beschow (11):
  hw/arm/Kconfig: Fix serial selection for NPCM8XX
  hw/char/{diva-gsp, serial-pci-multi}: Fix deinitialization order
  hw/arm/aspeed_ast27x0-{ssp, tsp}: Do not access SerialMM internals
    directly
  util/fifo8: Make all read-only methods const-correct
  hw/char/serial: Remove explicit cast from void pointer
  hw/char/serial: Prefer fifo8 methods over open-coding
  hw/char/serial: Reuse fifo8_num_used()
  hw/char/serial: Remove unhelpful comment
  hw/char/serial: Add constants for Line Control Register
  hw/char/serial: Remove redundant reset
  hw/char/serial: Avoid implicit conversion when tracing

Chad Jablonski (8):
  ati-vga: Fix framebuffer mapping by using hardware-correct aperture
    sizes
  ati-vga: Fix DST_PITCH and SRC_PITCH reads
  ati-vga: Read aliased values from DP_GUI_MASTER_CNTL
  ati-vga: Latch src and dst pitch and offset on master_cntl default
  ati-vga: Implement foreground and background color register writes
  ati-vga: Add scissor clipping register support
  ati-vga: Remove dst_x/y updates after blit
  ati-vga: Consolidate dirty region tracking in ati_2d_blt

Daniel P. Berrangé (1):
  hw/i386: drop unused PC_CPU_MODEL_IDS macro

David Hamilton (1):
  hw/misc/ivshmem-pci: Handle error from
    kvm_irqchip_add_irqfd_notifier_gsi()

Gerd Hoffmann (1):
  hw/uefi: add variable digest to vmstate

Helge Deller (2):
  hw/hppa: Avoid leaking a diva-gsp device
  hw/char: Drop disable property of Diva GSP card

Jim MacArthur (1):
  hw/net/xilinx_axienet: Prevent writes to PHY Identification registers

Peter Maydell (2):
  hw/net/xilinx_ethlite: Check for oversized TX packets
  hw/m68k/mcf_intc: Use qdev input gpios for input IRQs

Philippe Mathieu-Daudé (15):
  hw/i386/pc: Remove deprecated pc-q35-3.0 and pc-i440fx-3.0 machines
  hw/i386/pc: Remove pc_compat_3_0[] array
  target/i386/kvm: Remove X86CPU::hyperv_synic_kvm_only field
  hw/core/machine: Remove the hw_compat_3_0[] array
  meson: Include various directories providing stubs before libqemuutil
  hw/acpi: Move acpi_send_event() function out of acpi_interface.c
  hw/acpi: Move qbus_build_aml() function out of acpi_interface.c
  hw/acpi: Always link QOM interfaces with system binaries
  hw/nvram: Build fw_cfg-acpi.c once
  hw/acpi: Build stubs once
  hw/net: Build stubs once
  hw/*: Build stubs once
  semihosting: Build stubs once
  hw/s390x/s390-pci-vfio: Avoid including CONFIG_DEVICES in hw/ header
  audio/jack: Fix use of qemu_thread_set_name() on macOS

Thomas Huth (2):
  MAINTAINERS: Replace @tuxfamily.org address
  MAINTAINERS: Update the maintainer for the CHRP NVRAM section

 MAINTAINERS                                   |  10 +-
 meson.build                                   |  16 +--
 hw/display/ati_int.h                          |  16 ++-
 hw/display/ati_regs.h                         |   7 +
 include/hw/acpi/acpi.h                        |   1 +
 include/hw/acpi/acpi_dev_interface.h          |   2 -
 include/hw/core/boards.h                      |   3 -
 include/hw/i386/pc.h                          |   3 -
 include/hw/m68k/mcf.h                         |   5 +-
 include/hw/pci-host/astro.h                   |   2 +
 include/hw/s390x/s390-pci-vfio.h              |  20 ---
 include/qemu/fifo8.h                          |  10 +-
 target/hppa/cpu-qom.h                         |   8 +-
 target/hppa/cpu.h                             |  35 ++++-
 target/i386/cpu.h                             |   1 -
 audio/jackaudio.c                             |   2 +-
 hw/acpi/acpi_interface.c                      |  19 ---
 hw/acpi/aml-build.c                           |  11 ++
 hw/acpi/core.c                                |  10 ++
 hw/arm/aspeed_ast27x0-ssp.c                   |   7 +-
 hw/arm/aspeed_ast27x0-tsp.c                   |   7 +-
 hw/char/diva-gsp.c                            |   9 +-
 hw/char/serial-pci-multi.c                    |   2 +-
 hw/char/serial.c                              |  47 +++----
 hw/core/machine.c                             |   3 -
 hw/display/ati.c                              | 126 ++++++++++++++++--
 hw/display/ati_2d.c                           |  60 ++++-----
 hw/hppa/machine.c                             |  55 ++++----
 hw/i386/pc.c                                  |  16 ---
 hw/i386/pc_piix.c                             |   9 --
 hw/i386/pc_q35.c                              |   9 --
 hw/m68k/mcf5208.c                             |  24 ++--
 hw/m68k/mcf_intc.c                            |   8 +-
 hw/misc/ivshmem-pci.c                         |  13 +-
 .../rocker/{qmp-norocker.c => rocker-stubs.c} |   0
 hw/net/xilinx_axienet.c                       |   4 +
 hw/net/xilinx_ethlite.c                       |  12 +-
 hw/pci-host/astro.c                           |   8 +-
 hw/s390x/s390-pci-vfio-stubs.c                |  32 +++++
 hw/uefi/var-service-vars.c                    |  37 +++++
 linux-user/hppa/elfload.c                     |   2 +-
 target/hppa/cpu.c                             |  55 ++++++--
 target/hppa/mem_helper.c                      |  39 ++----
 target/i386/cpu.c                             |   2 -
 target/i386/kvm/kvm.c                         |  15 +--
 tests/qtest/machine-none-test.c               |   2 +-
 util/fifo8.c                                  |  10 +-
 hw/acpi/meson.build                           |  28 ++--
 hw/arm/Kconfig                                |   2 +-
 hw/char/trace-events                          |   4 +-
 hw/cxl/meson.build                            |   4 +-
 hw/i386/kvm/meson.build                       |   5 +-
 hw/mem/meson.build                            |   4 +-
 hw/net/meson.build                            |   3 +-
 hw/net/trace-events                           |   1 +
 hw/nvram/meson.build                          |   4 +-
 hw/pci/meson.build                            |   2 +-
 hw/s390x/meson.build                          |   1 +
 hw/smbios/meson.build                         |  10 +-
 hw/usb/meson.build                            |   3 +-
 hw/virtio/meson.build                         |   9 +-
 semihosting/meson.build                       |   9 +-
 tests/functional/hppa/test_seabios.py         |   4 +-
 ui/cocoa.m                                    |   9 +-
 64 files changed, 538 insertions(+), 358 deletions(-)
 rename hw/net/rocker/{qmp-norocker.c => rocker-stubs.c} (100%)
 create mode 100644 hw/s390x/s390-pci-vfio-stubs.c

-- 
2.53.0


