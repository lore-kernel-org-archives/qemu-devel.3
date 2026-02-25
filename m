Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C707FD45F9
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO5E-0004f5-7i; Wed, 25 Feb 2026 18:14:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO5C-0004ef-7U
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:14:18 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO59-0002Vr-Sp
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:14:17 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4836f4cbe0bso2475135e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061253; x=1772666053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=hZnEGIFl12hT2OlC6r2VumuBAWMZ+G3yxjNIeBgfndo=;
 b=LAJd2TF91SIhm35RVtQC3qQ3X/oavCJRvq+UMS5ROGauEQwbrmirRh0G3dcfSB++vm
 no+oonugJiEnUFT9gm0e1FQUSWQt0CurHmg9nZDX8dHZSQ0GNmiLUdWUXnib1H3xCWDs
 8P2ry4nCBjKvEYc1xwsWPqKnA2Q8GuDJBneGdR3gEHVamXPd/wMgqhhtE4mSVwWDXhf9
 JIf3Y9o7YC4ZDPxQ5la1hi+5p0GDmMKusCj8Yp6ScvMUS+9K8EKvTtXnK9BhhPX/SGnJ
 7K7asZvFelKJ8u5FJVCMaqtpPoc9omHuluSIx5emAHmuQHs6TU3QnZ2H6CCIertVGF1o
 myfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061253; x=1772666053;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hZnEGIFl12hT2OlC6r2VumuBAWMZ+G3yxjNIeBgfndo=;
 b=e3JE9UfgTbr8XOgIX0bE6CqavqwFPYmnHE90kZT10YwYl77Tyai+cnNCKJn0J2v0Dx
 p6GZc3rFMlkq20JSKqt1SGSDUZpfLKDbJHHnmVMCFA8FngwwqnrSMx46Fx+h5zdk+WPa
 XJsc9bKZ6RzuetSfGh+LOr8A+3r0rf8Ykuyj4CvABgG8tC1fw9gjisjXZ9MJHOQ+ZXHf
 IRfaEhXPUKbaxw6ICGWbu7uV13Tow9LRc6MIPfoZPEJPHUPbEkNABf5hFrIO0K1bj6wy
 brU/HeOVXnyqUuG55lg0qZDj1Rgvn4sTIUpSztpr4donaQn2JU0LVfFt5m9eE9HapvUp
 UCfQ==
X-Gm-Message-State: AOJu0YzO2sjQuSJKuWIaeVoG60sK3W53CvmT2a6geLzQMkrBga3MukxK
 ThTd6U7pGPvqKPPpXpLUFaEWC+tL2EbGlbRyJgngYfxQURzGHxGpcw5VQOQLANqYsYY5hZXG89C
 c/7XXTZk=
X-Gm-Gg: ATEYQzy+rYHoG1FGdFPOb2KhsvZMuT6HAssn0FM81szQPJTnDbqw0te4iO55nIK861w
 oqXSqWoSGuSdlFyxX+zrwvLuKBc0Qs8MOOR/tyzhwGs545taoY+gHhG76k5drraXpf7ZKSVxSFZ
 dcgvXngMml4toSL3OfqvSarxq6ZLsiucsG5iLMpucMX74uXsftC+lWndTEy0Tgi9J0/sItn89uy
 mNciRM+jd7CxmhpIO20IW72KnDKYBCpQ8lXaRlnf8OpmmX/3XVFKAeDnbiBABFIhBBP/vmTdtlc
 xYJIyS0TLh7PyzHzrpjvPyI1NxofntAJk0LW5tEhXsFo1C64bLQSTHigMfJtq2Y1VLj/Ms//uFA
 aWOpELDV/rDE5n7sLbKtTHRoj8HnnYHyvttOsvZvY+V/VqxXjk0bHkUukbzri04gOvm/zzWRWKr
 BFOraY0HE60eM7bTBi2wnkrrTfQNTcsw0Rl8SF58NbKgdqhMfNQ3FCY398ggMjm74LfWy69P+v
X-Received: by 2002:a05:600c:1d1b:b0:483:64b4:79da with SMTP id
 5b1f17b1804b1-483c3df0066mr1026475e9.26.1772061253417; 
 Wed, 25 Feb 2026 15:14:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd70e6c9sm78141795e9.8.2026.02.25.15.14.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:14:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/70] Single binary patches for 2026-02-26
Date: Thu, 26 Feb 2026 00:13:00 +0100
Message-ID: <20260225231411.96482-1-philmd@linaro.org>
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

The following changes since commit 6593154e7d65f61d8f9dbeb98224731b7137c53e:

  Merge tag 'python-pull-request' of https://gitlab.com/jsnow/qemu into staging (2026-02-24 18:41:04 +0000)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/single-binary-20260226

for you to fetch changes up to c87bf20b072ebd26f2c4ff68f802ef0d69f72a46:

  page-vary: Build migration_legacy_page_bits as common code (2026-02-26 00:12:12 +0100)

----------------------------------------------------------------
Various patches related to single binary effort:

- Remove TARGET_PHYS_ADDR_SPACE_BITS definition
- Remove MonitorDef register entries already provided by gdbstub XML
- Remove gdbstub ldtul*() macros
- Build various gdbstub.c files once
- Make qemu_arch_available() and page-vary common code
----------------------------------------------------------------

Alex Bennée (1):
  target/m68k: clean-up includes in cpu.c

Anton Johansson (7):
  target/hppa: Define PA[20|1X] physical address space size
  hw/hppa: Use hppa_abs_to_phys_pa1x()
  target/i386: Drop physical address range checks
  target/loongarch: Introduce loongarch_palen_mask()
  hw/loongarch: Use loongarch_palen_mask()
  hw/riscv: Set IOMMU PAS via property
  exec: Drop TARGET_PHYS_ADDR_SPACE_BITS

Daniel P. Berrangé (1):
  meson: don't access 'cxx' object without checking cpp lang

Philippe Mathieu-Daudé (56):
  target/ppc: Move user_only_helper.c to target_user_arch[] source set
  target/ppc: Remove PPC_DEBUG_SPR left-over comment
  target/i386: Inline GDB_FORCE_64 definition
  target/avr: Fix typo in gdb-xml feature name
  target/alpha: Document gdbstub register indexes
  target/riscv: Extract monitor-related code to monitor.c
  target/ppc: Fix CPUClass::gdb_num_core_regs value
  target/ppc: Remove dead code depending on USE_APPLE_GDB
  gdbstub: Make generated compound literal array size explicit
  gdbstub: Always infer gdb_num_core_regs when using XML file
  target/sparc: Introduce sparc_cpu_register_gdb_regs() stub
  target/sparc: Restore 'gdb-xml/sparc64-cp0.xml'
  target/sparc: Restore 'gdb-xml/sparc64-fpu.xml'
  target/sparc: Restore 'gdb-xml/sparc64-cpu.xml'
  target/sparc: Expose gdbstub registers to sparc32plus target
  target/sparc: Expose gdbstub registers to sparc32 targets
  monitor/hmp: Handle gdb-xml exposed registers via gdb_get_register()
  target/sparc: Remove MonitorDef register entries available via gdbstub
  target/i386: Remove MonitorDef register entries available via gdbstub
  target/m68k: Remove MonitorDef register entries available via gdbstub
  target/ppc: Remove MonitorDef register entries available via gdbstub
  target/ppc: Extract monitor-related code to monitor.c
  target/or1k: Use XML register definitions from GDB
  target/riscv: Remove empty target_monitor_defs() symbol
  target/sparc: Factor sparc_cpu_gdb_write_register() out
  target/ppc: Replace ldtul_p() -> ldn_p()
  target/mips: Replace ldtul_p() -> ldn_p()
  target/riscv: Replace ldtul_p() -> ldn_p()
  target/riscv: Remove unnecessary target_ulong type uses
  target/i386: Replace ldtul_p() -> ldn_p()
  target/i386: Expand 64-bit definitions when TARGET_LONG_BITS == 64
  gdbstub: Remove ldtul*() macros
  target/alpha: Expand gdb_get_regl() -> gdb_get_reg64()
  target/hexagon: Expand gdb_get_regl() -> gdb_get_reg32()
  target/rx: Expand gdb_get_regl() -> gdb_get_reg32()
  target/sh4: Expand gdb_get_regl() -> gdb_get_reg32()
  target/sparc: Expand gdb_get_regl() in gdb_get_rega()
  gdbstub/helpers: Convert gdb_get_regl() macro to inlined helper
  target/microblaze: Build 'gdbstub.c' once for system binaries
  target/sh4: Build 'monitor.c' once for system binaries
  target/sh4: Build 'gdbstub.c' once for system binaries
  target/or1k: Rename 'openrisc' -> 'or1k' in meson.build
  target/or1k: Build 'gdbstub.c' once for system single binary
  target/alpha: Build 'gdbstub.c' once for system single binary
  target/avr: Build 'gdbstub.c' once for system single binary
  target/loongarch: Build 'gdbstub.c' once for system single binary
  target/m68k: Build 'gdbstub.c' once for system single binary
  target/rx: Build 'gdbstub.c' once for system single binary
  target/s390x: Build 'gdbstub.c' once for system single binary
  target/tricore: Build 'gdbstub.c' once for system single binary
  qemu: Document qemu_arch_available() method
  qemu/target_info: Add target_s390x() helper
  hw/scsi/disk: Prefer target_s390x() over qemu_arch_available()
  system: Make qemu_arch_available() common code
  system: Reduce 'arch_init.h' scope
  page-vary: Expose TARGET_PAGE_BITS_MIN definition

Richard Henderson (5):
  target-info: Add page_bits_{init,vary}
  target-info: Move TARGET_PAGE_BITS sanity check
  page-vary: Build set_preferred_target_page_bits as common code
  page-vary: Build finalize_target_page_bits as common code
  page-vary: Build migration_legacy_page_bits as common code

 MAINTAINERS                                   |   4 +-
 configs/targets/or1k-linux-user.mak           |   1 +
 configs/targets/or1k-softmmu.mak              |   1 +
 configs/targets/sparc-linux-user.mak          |   1 +
 configs/targets/sparc-softmmu.mak             |   1 +
 configs/targets/sparc32plus-linux-user.mak    |   1 +
 configs/targets/sparc64-linux-user.mak        |   2 +-
 configs/targets/sparc64-softmmu.mak           |   2 +-
 meson.build                                   |   6 +-
 hw/riscv/riscv-iommu.h                        |   1 +
 include/exec/cpu-defs.h                       |   3 -
 include/exec/page-vary.h                      |  19 +-
 include/gdbstub/helpers.h                     |  28 +-
 include/hw/core/cpu.h                         |   4 +-
 include/hw/loongarch/boot.h                   |   3 +-
 include/qemu/target-info-impl.h               |   7 +
 include/qemu/target-info.h                    |   7 +
 include/system/arch_init.h                    |  30 --
 system/arch_init.h                            |  50 +++
 target/alpha/cpu-param.h                      |   3 -
 target/arm/cpu-param.h                        |   2 -
 target/avr/cpu-param.h                        |   1 -
 target/hexagon/cpu-param.h                    |   1 -
 target/hppa/cpu-param.h                       |   3 -
 target/hppa/cpu.h                             |   1 +
 target/i386/cpu-param.h                       |   2 -
 target/i386/tcg/helper-tcg.h                  |   2 -
 target/loongarch/cpu-mmu.h                    |   1 +
 target/loongarch/cpu-param.h                  |   1 -
 target/loongarch/internals.h                  |   1 -
 target/m68k/cpu-param.h                       |   1 -
 target/microblaze/cpu-param.h                 |   2 -
 target/mips/cpu-param.h                       |   2 -
 target/or1k/cpu-param.h                       |   1 -
 target/ppc/cpu-param.h                        |   7 -
 target/ppc/cpu.h                              |   2 -
 target/riscv/cpu-param.h                      |   2 -
 target/rx/cpu-param.h                         |   1 -
 target/s390x/cpu-param.h                      |   1 -
 target/sh4/cpu-param.h                        |   1 -
 target/sparc/cpu-param.h                      |   2 -
 target/sparc/cpu.h                            |   1 +
 target/tricore/cpu-param.h                    |   1 -
 target/xtensa/cpu-param.h                     |   1 -
 configs/targets/aarch64-softmmu.c             |   3 +
 configs/targets/arm-softmmu.c                 |   3 +
 gdbstub/gdbstub.c                             |   1 +
 hw/hppa/machine.c                             |   2 +-
 hw/loongarch/boot.c                           |  28 +-
 hw/loongarch/virt.c                           |   5 +-
 hw/riscv/riscv-iommu-pci.c                    |   3 +
 hw/riscv/riscv-iommu.c                        |   8 +-
 hw/riscv/virt.c                               |   7 +
 hw/scsi/scsi-disk.c                           |   4 +-
 monitor/hmp.c                                 |  49 ++-
 page-vary-common.c                            |  44 ++-
 page-vary-system.c                            |  33 ++
 page-vary-target.c                            |  81 -----
 system/arch_init.c                            |   6 +-
 target-info-stub.c                            |  15 +
 target-info.c                                 |   5 +
 target/alpha/cpu.c                            |   1 -
 target/alpha/gdbstub.c                        |  27 +-
 target/hexagon/gdbstub.c                      |  12 +-
 target/hppa/mem_helper.c                      |  32 +-
 target/i386/cpu.c                             |   9 +-
 target/i386/gdbstub.c                         |  23 +-
 target/i386/kvm/kvm.c                         |   3 +-
 target/i386/monitor.c                         |  39 ---
 target/loongarch/cpu_helper.c                 |  15 +-
 target/loongarch/tcg/tlb_helper.c             |  12 +-
 target/m68k/cpu.c                             |  13 +-
 target/m68k/monitor.c                         |  18 -
 target/mips/gdbstub.c                         |  14 +-
 target/or1k/cpu.c                             |   2 +-
 target/ppc/cpu_init.c                         |  10 -
 target/ppc/gdbstub.c                          | 146 +-------
 target/ppc/monitor.c                          |  25 ++
 target/ppc/ppc-qmp-cmds.c                     | 148 +-------
 target/riscv/gdbstub.c                        |  20 +-
 target/riscv/monitor.c                        | 135 ++++++++
 target/riscv/riscv-qmp-cmds.c                 | 150 ---------
 target/rx/gdbstub.c                           |  20 +-
 target/sh4/gdbstub.c                          |  32 +-
 target/sparc/cpu.c                            |   7 +-
 target/sparc/gdbstub.c                        | 317 +++++++++++-------
 target/sparc/monitor.c                        | 107 ------
 gdb-xml/avr-cpu.xml                           |   2 +-
 gdb-xml/or1k-core.xml                         |  65 ++++
 gdb-xml/sparc32-cp0.xml                       |  18 +
 gdb-xml/sparc32-cpu.xml                       |  42 +++
 gdb-xml/sparc32-fpu.xml                       |  42 +++
 gdb-xml/sparc64-cp0.xml                       |  16 +
 gdb-xml/sparc64-cpu.xml                       |  42 +++
 gdb-xml/{sparc64-core.xml => sparc64-fpu.xml} |  44 +--
 scripts/feature_to_c.py                       |   7 +-
 system/meson.build                            |   5 +-
 target/alpha/meson.build                      |  14 +-
 target/avr/meson.build                        |   5 +-
 target/loongarch/meson.build                  |   9 +-
 target/m68k/meson.build                       |   9 +-
 target/microblaze/meson.build                 |  11 +-
 target/or1k/meson.build                       |  23 +-
 target/ppc/meson.build                        |   7 +-
 target/rx/meson.build                         |   6 +-
 target/s390x/meson.build                      |   3 +-
 target/sh4/meson.build                        |  14 +-
 target/tricore/meson.build                    |  10 +-
 108 files changed, 1110 insertions(+), 1132 deletions(-)
 delete mode 100644 include/system/arch_init.h
 create mode 100644 system/arch_init.h
 create mode 100644 page-vary-system.c
 delete mode 100644 page-vary-target.c
 create mode 100644 target/ppc/monitor.c
 create mode 100644 gdb-xml/or1k-core.xml
 create mode 100644 gdb-xml/sparc32-cp0.xml
 create mode 100644 gdb-xml/sparc32-cpu.xml
 create mode 100644 gdb-xml/sparc32-fpu.xml
 create mode 100644 gdb-xml/sparc64-cp0.xml
 create mode 100644 gdb-xml/sparc64-cpu.xml
 rename gdb-xml/{sparc64-core.xml => sparc64-fpu.xml} (59%)

-- 
2.52.0


