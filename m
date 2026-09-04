Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17FCC79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MLL-0005Pd-WA; Fri, 04 Sep 2026 01:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MLF-0005Or-RT
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:19:57 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MLD-00011Z-Qd
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:19:57 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8525efa7274so455274b3a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499194; x=1789103994; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RJKMNA+98QgWNuaqPbNTx/0n/jT6sUbvnoR23PAiSM8=;
 b=fery/rrhguB7ixE6VdXBMw+iOIh4+P7Ss2L5GhtVnnCdkewfcPxG8LxQqypbB2L4Vt
 YeaPlMPFffzYq7K2dyW8DX2NUjDM46TCsICotkReqIPevsp9PCf5sTyN6UBWxfZ3smLr
 1BKPbfQS8wTFh8uaJy0ljrGaa9xnp6cCrv8uLNzLk6Uw/3nPuBsl2i0xcD8lm7+yE35J
 pBpNx69cXOtw/SDMg4LCgJLp4g1oYGGXlRvTBm3LExhqJz4fPRvjTm960lyTsK2r1tl3
 D5T4iQsex830ZuRDpQ63/i+1F3ZxnXUOXFyMbCAw2Xo13V/W6ly6dKUlo9fILDkkM5/Z
 doXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499194; x=1789103994;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RJKMNA+98QgWNuaqPbNTx/0n/jT6sUbvnoR23PAiSM8=;
 b=ISHEMwpAoDOu+LZ3hKufcv4Jyx3mANKK05mhrcveeeRwTbh8f8eKmnsjHQl2K/YQ87
 nGZLcKKD8idlxp1uzTLnJX9LpPMc+FtBDjwwasTr3IAOH/Bnr7Ua7MRzgRSIPErT+SWq
 9NK2MpnCnu95XGoIfpW2ASQUNKEPAuQ6odvE/ZAYDg7J4RMkbjgRS5ugvSpcCWxaYgZE
 q+p30RmpW39A2rkSpPbcs49N24Ei6sBvEko/nd1nYUDNdQtr0s37+IaGGixWP8r2apEQ
 Ddwkak2kyugHxlwgGWUgWr/wIzaMZ0m0hsr7I9iCsGnAIqCABWnrqbpD5kSepvusqeAt
 vRgw==
X-Gm-Message-State: AFuF++nIkYAoeOr4LX6OiSmQMw9Z5BoNKXMMtvO/RaKsp60APmOhFrVb
 wsWAGO7Mh1blJ8iDTdYZEuEEN6I2F+PtezIPXgwusochL/EPR3YQ3p6AjFzfeA==
X-Gm-Gg: AYBFou1XJxyi+2dPgvPpKKGZzDYyMSCFozTEMpAkWtF/WYAULEnNBG8ABng8fc+d4So
 cJbWeqExfUyIKAFKjjvLbe16yemJnctjsxN8BUFciur+5HcbSgub7pMwRCAre9Rsz/YB9CdbFzd
 oUIbdMu55sC1nZkAc8o9DjcCdItjNDWqzfNQhccFBNk3ONQHxbUTet9eGCMvc3Kd33rJCceiYBs
 TbVEQf/aLms2X6j9QUOrLvgiatkCHZ5T/8JTttHq0OQkiwAcMKh8HQTHJfLlimREoVRMpOaS+Ol
 CZYLKcCEjeB7sd4c2rwFUSh3xZ58g+FEAhIZQma4eLxpJVLzFu2XuXnFRy6hpJK9NXTUytKQhSR
 62S9BrNi9uJ2TiaqufHaiQqBtja5+x9XKC/c0t9mEwLHlLHDWJSifit2hKhwjnkZhdM+DLoGcFd
 2iO7Kc5i+KWCIVc5jTRzdbQPmgheZfQZ4OHbREnG7HAkO/xfDayqd6G2jy8AEv7H3JcyyB7/6iu
 Hjy0w==
X-Received: by 2002:a05:6a21:9d84:b0:3d3:af85:eb98 with SMTP id
 adf61e73a8af0-3da3a16a579mr5741145637.26.1788499193834; 
 Thu, 03 Sep 2026 22:19:53 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:19:53 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/47] riscv-to-apply queue
Date: Fri,  4 Sep 2026 15:18:56 +1000
Message-ID: <20260904051943.799041-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Alistair Francis <alistair.francis@wdc.com>

The following changes since commit 99e54ab5e7a6efc945af6d5661842155d1f3fc7a:

  Merge tag 'hw-misc-20260903' of https://github.com/philmd/qemu into staging (2026-09-03 16:43:24 +0100)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20260904

for you to fetch changes up to b23a62773a7856299cbb3782e64968b6a92c792f:

  hw/riscv/atlantis: Map the SoC through a memory container (2026-09-04 10:30:14 +1000)

----------------------------------------------------------------
RISC-V PR for 11.2

* Add initial sdext support
* Make RISCVBootInfo const where possible
* Use hwaddr for virt IMSIC device tree address
* Avoid unnecessary removal of test scratch files
* Document Atlantis QEMU-only I2C device tree nodes
* Make s-mode IMSIC stride explicit
* Correct dasm for cbo and lq
* Add tests for rv128 [ms]status
* Code duplication work in preperation for riscv-server-ref
* Fix user option hash table leaks
* Preserve vl on element-zero fault
* Prevent abrupt abortion on unassigned value write to tdata
* Socify Atlantis

----------------------------------------------------------------
Abhigyan Kumar (1):
      target/riscv: prevent abrupt abortion on unassigned value write to tdata

Daniel Henrique Barboza (20):
      target/riscv: split 'debug' and 'sdtrig' flags
      target/riscv/tcg/debug.c: add Debug 1.0 'pending' bit
      target/riscv/tcg/debug: adjust 'timing' bit for Debug 1.0
      target/riscv/tcg/debug: set tinfo version if sdtrig enabled
      docs/specs: add RISC-V CPU Debug support info
      hw/riscv/fdt-common: prepend helpers with "riscv_"
      hw/riscv/fdt-common, virt.c: add riscv_create_fdt_flash()
      hw/riscv/fdt-common, virt.c: add riscv_create_fdt_syscon()
      hw/riscv/fdt-common, virt.c: add riscv_create_fdt_riscv_iommu_sys()
      hw/riscv/fdt_common, virt.c: add riscv_create_fdt_pcie()
      hw/riscv/fdt_common, virt.c: add riscv_create_fdt_imsic()
      hw/riscv/fdt_common, virt.c: add riscv_create_fdt_socket_aplic()
      hw/riscv/virt.c: fix aclint soc/mtimer nodename
      hw/riscv/fdt-common, virt.c: add riscv_create_fdt_socket_aclint()
      hw/riscv/fdt-common, virt.c: add riscv_create_fdt_uart()
      hw/riscv/fdt-common, virt.c: add riscv_create_fdt_rtc()
      hw/riscv/device-common, virt.c: add riscv_create_platform_bus()
      hw/riscv/device-common, virt.c: add flash helpers
      hw/riscv/device-common, virt.c: add riscv_gpex_pcie_init()
      hw/riscv/riscv-iommu-sys.c, virt.c: add riscv_create_iommu_sys()

Frédéric Pétrot (2):
      disas/riscv.c: Correct dasm for cbo and lq
      tests/tcg/riscv64: Add tests for rv128 [ms]status

Joel Stanley (21):
      hw/riscv/boot: Make RISCVBootInfo const where possible
      hw/riscv/virt: Use hwaddr for IMSIC device tree address
      tests/functional: Avoid unnecessary removal of scratch files
      hw/riscv/atlantis: Document QEMU-only I2C device tree nodes
      hw/riscv: Make s-mode IMSIC stride explicit
      hw/riscv/aia: Check for invalid IMSIC configs
      hw/riscv/aia: Take a MemoryRegion for the created devices
      hw/intc/riscv_aclint: Take a MemoryRegion for the created devices
      hw/intc/riscv_imsic: Take a MemoryRegion for the created device
      hw/intc/riscv_aplic: Take a MemoryRegion for the created device
      hw/intc/sifive_plic: Take a MemoryRegion for the created device
      hw/riscv/cps: Map interrupt controllers in SoC container
      hw/riscv/atlantis: Make UART unimp region a SoC device
      hw/riscv/atlantis: Remove unused fdt_size
      hw/riscv/atlantis: Rename hart array 'soc' to 'cpus'
      hw/riscv/atlantis: Rework device tree creation
      hw/riscv/atlantis: Use local reference for system memory
      hw/riscv/atlantis: Decouple RAM size from MachineState
      hw/riscv/atlantis: Make TTAtlantisState own memory containers
      hw/riscv/atlantis: Extract an Atlantis SoC device
      hw/riscv/atlantis: Map the SoC through a memory container

Portia Stephens (1):
      hw/riscv: Add property to hart array to allow private memory

TANG Tiancheng (1):
      target/riscv/tcg: fix user option hash table leaks

Zephyr Li (1):
      target/riscv: preserve vl on element-zero fault

 docs/specs/index.rst                      |   1 +
 docs/specs/riscv-debug.rst                |  68 +++
 hw/riscv/aia.h                            |   4 +-
 hw/riscv/riscv-iommu.h                    |   3 +
 include/hw/intc/riscv_aclint.h            |   7 +-
 include/hw/intc/riscv_aplic.h             |   7 +-
 include/hw/intc/riscv_imsic.h             |   3 +-
 include/hw/intc/sifive_plic.h             |   4 +-
 include/hw/riscv/boot.h                   |   6 +-
 include/hw/riscv/device-common.h          |  32 ++
 include/hw/riscv/fdt-common.h             | 146 ++++-
 include/hw/riscv/riscv_hart.h             |   2 +
 include/hw/riscv/tt_atlantis.h            |  32 +-
 include/hw/riscv/virt.h                   |  15 -
 target/riscv/cpu.h                        |   2 +
 target/riscv/tcg/debug.h                  |   6 +-
 target/riscv/cpu_cfg_fields.h.inc         |   1 +
 target/riscv/insn32.decode                |   2 +
 disas/riscv.c                             |  20 +-
 hw/intc/riscv_aclint.c                    |  12 +-
 hw/intc/riscv_aplic.c                     |  10 +-
 hw/intc/riscv_imsic.c                     |   6 +-
 hw/intc/sifive_plic.c                     |   7 +-
 hw/riscv/aia.c                            |  24 +-
 hw/riscv/boot.c                           |   6 +-
 hw/riscv/cps.c                            |  12 +-
 hw/riscv/device-common.c                  | 168 ++++++
 hw/riscv/fdt-common.c                     | 613 ++++++++++++++++++++-
 hw/riscv/k230.c                           |   9 +-
 hw/riscv/microchip_pfsoc.c                |   8 +-
 hw/riscv/riscv-iommu-sys.c                |  25 +
 hw/riscv/riscv_hart.c                     |   8 +
 hw/riscv/shakti_c.c                       |  10 +-
 hw/riscv/sifive_e.c                       |   6 +-
 hw/riscv/sifive_u.c                       |  44 +-
 hw/riscv/spike.c                          |  34 +-
 hw/riscv/tt_atlantis.c                    | 310 +++++++----
 hw/riscv/virt.c                           | 883 +++++-------------------------
 hw/riscv/xiangshan_kmh.c                  |  17 +-
 target/riscv/cpu.c                        |  23 +-
 target/riscv/machine.c                    |   2 +-
 target/riscv/tcg/csr.c                    |   2 +-
 target/riscv/tcg/debug.c                  |  54 +-
 target/riscv/tcg/tcg-cpu.c                |  57 +-
 target/riscv/tcg/vector_helper.c          |  23 +-
 hw/riscv/meson.build                      |   1 +
 tests/functional/arm/test_bpim2u.py       |  11 -
 tests/functional/arm/test_orangepi.py     |   9 -
 tests/functional/riscv64/test_sifive_u.py |   4 -
 tests/tcg/riscv64/Makefile.softmmu-target |  14 +
 tests/tcg/riscv64/test-rv128-mstatus.S    |  67 +++
 tests/tcg/riscv64/test-rv128-sstatus.S    | 108 ++++
 tests/tcg/riscv64/test-vle32ff.S          |  58 ++
 53 files changed, 1906 insertions(+), 1100 deletions(-)
 create mode 100644 docs/specs/riscv-debug.rst
 create mode 100644 include/hw/riscv/device-common.h
 create mode 100644 hw/riscv/device-common.c
 create mode 100644 tests/tcg/riscv64/test-rv128-mstatus.S
 create mode 100644 tests/tcg/riscv64/test-rv128-sstatus.S
 create mode 100644 tests/tcg/riscv64/test-vle32ff.S

