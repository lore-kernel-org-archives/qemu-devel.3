Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F416EE6B66
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTdM-00054F-Ao; Fri, 06 Feb 2026 16:45:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTdI-00052k-Op
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:44:57 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTdE-0002MG-KL
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:44:54 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4806fbc6bf3so13108095e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414291; x=1771019091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xmjSZwxzHgCNVFyqrbhs7oWwI4Ve5NrXhd+RcuBzBI8=;
 b=PGGtWYQ+sy0Va4V4xhwC5vL+mGL4q/HJ94NDx/Hlszcy+vdzP9lN7Ep8+xNEOgKZOG
 6VtrzolEPx6KjCWNsE+bHjtyVuQFYAF/hU8EJIbPSI4S0BsHiw/YT9tP/4uhdqgXsCRo
 s+4d2vaijSZz789ozR7saRGcdhnZ32olz+TG4BdbV1anTPVa3/oU49/dGyq7LCIZmfDD
 N7OmLELJ7pHhp1LXLJ88+XdjeOfADTS7KQSTSaSeCLvtyxWsF+8GkLVMmgJAQvk2Vnr+
 1xZ+69wwr+z86/AlPcDLmT1mg75nHcoaOhcRK6gZL+ejmWufvyH1P4ktPwNsBYmAYRaj
 YFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414291; x=1771019091;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xmjSZwxzHgCNVFyqrbhs7oWwI4Ve5NrXhd+RcuBzBI8=;
 b=K8BufcJnNDhkRGpQ4L1oMsBkhrHdazqqnggxSByWWC27k/yQr0FOUK0xqyHT8XDWqa
 JDtQTHzU44wtONKwiWsOAMSIw3iSZ+++1FPz/p5HSjE6TSTiRg+zS+JmGnqMXnCFdt+H
 rr3BPO+cGt/pLi8q8XWWaC9EOyoZrzGj9rgslR0P0zksVPosggbwzpYZ+QZsL2FvD9Up
 +LacjBulk/hGIppr2Nfc3fNhEdAfrpfoEWDNUhv7zVws8cz10U9dAJbAndBNYHc0PiBP
 MOmNMyYG8t4xXNxBVL8BPzDTPv1pcfqjFvx1+bi7HAYB5IEPUYmrLaeNNXqAmku7DcFK
 nA7w==
X-Gm-Message-State: AOJu0YyjDjwTSGolyayjm5ANvK1xJ8FMxM9nlNHNDkPhlzFB7vToAhB+
 Xm/FzXHpZFC7f4MGOhoMTnGR5wj0/sZqM4y8G8D0u0hhnAztIjSERxtJlBpXBAJ6CeVdmg4hHdW
 j2rKhbwo=
X-Gm-Gg: AZuq6aIHdkjpaFqQwUwmw67lPlvzbJG4er8WUizDSDvMNwFhs1BB31xmVMhnNWk7Ta1
 pZfuNxuV2OSlQdvVjsCZ6V845UhAp0vAFCSojUAlgJ/7dXhl32BHRdWQfSDcuEykQsV6RDp1CsR
 +SDFcOgdosLlIrreNs2c438GX7IiENH/B8JMG/ju5yhwjD9wDB1m9EO09dab/5mpw6btkPsq75R
 s6vZvEguSYkk3mDATzdF9fFe0bpRZOaYGsrjtFgFKzLv4zPsR+32O+j3Rb7AnMClykLOjGGAQiC
 0SbpyDGP0dTYmc4zQaCxC6q4TVzB0DvdwEdodl3ztDYBK+w7O4rpgisHv/OdXUEKHQMEK3Lql6v
 sQuAhZZsOe5UeYMgxRewaUOSh7ySjmt1b4vI+/xUNgV+K5ljlYy1XOGFG8OfAfTfRhrrYdvC/Et
 nSqgyjvAZtQxSVsL8fgoTVs1dktqikZRazjQZazG4xYlPOtFlSGrZDuc99E/oN
X-Received: by 2002:a5d:52cf:0:b0:436:173c:b8e3 with SMTP id
 ffacd0b85a97d-436293865d9mr4963957f8f.29.1770414290444; 
 Fri, 06 Feb 2026 13:44:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296bd1c9sm8012014f8f.15.2026.02.06.13.44.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 13:44:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PULL 00/30] Single binary patches for 2026-02-06
Date: Fri,  6 Feb 2026 22:44:18 +0100
Message-ID: <20260206214448.22008-1-philmd@linaro.org>
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

The following changes since commit cd5a79dc98e3087e7658e643bdbbb0baec77ac8a:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2026-02-05 13:54:50 +0000)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/single-binary-20260206

for you to fetch changes up to 5cab4bafbb8c635c7db6ae1cff8660f83b547c02:

  target-info: Statically initialize target_arch (2026-02-06 22:37:54 +0100)

----------------------------------------------------------------
Various patches related to single binary effort:

- Reduce RISC-V Boston tests
- Prohibit target_ulong / TARGET_PAGE_SIZE uses on s390x target
- Build target/arm/arm-qmp-cmds once
- Forbid legacy native endianness & ld/st_phys APIs on SPARC targets
- Forbid legacy ld/st_phys APIs on x86 targets
- Rename OpenRISC -> or1k
- Avoid QAPI parsing in target_arch()
----------------------------------------------------------------

Ignored spurious warning:

  21/30 Checking commit 7e0fc4f0953b (target/or1k: Rename from openrisc)
  WARNING: Does new file 'linux-user/or1k/meson.build' need 'SPDX-License-Identifier'?
  total: 0 errors, 1 warnings, 127 lines checked

Daniel Henrique Barboza (1):
  riscv64/test_boston.py: fix intermitent test timeout

Philippe Mathieu-Daudé (19):
  target/s390x: Use address_space_ldl_be() in read_table_entry()
  target/s390x: Rename get_phys_page_debug() @vaddr argument as @v_addr
  target/s390x: Replace %target_ulong -> %vaddr where appropriate
  target/s390x: Replace %target_ulong -> %hwaddr where appropriate
  target/s390x: Un-inline KVM Protected Virtualization stubs
  target/s390x: Add more unreachable KVM stubs
  target/s390x: Build system units in common source set
  target/s390x: Expand TCGv type as 64-bit target
  target/s390x: Expand tcg_gen_qemu_ld/st_tl() as 64-bit target
  target/s390x: Expand tcg_global_mem_new() -> tcg_global_mem_new_i64()
  target/sparc: Remove dubious swapping in LD_code() helper
  target/sparc: Replace MO_TE -> MO_BE
  configs/targets: Forbid SPARC to use legacy native endianness APIs
  target/sparc: Replace legacy st_phys() -> address_space_st()
  configs/targets: Restrict legacy ldst_phys() API on 32-bit SPARC
    target
  target/i386: Use explicit little-endian LD/ST API
  hw/intc: Mark x86-specific [IO]APIC peripherals as little-endian
  hw/intc/ioapic: Replace legacy st_phys() -> address_space_st()
  configs/targets: Restrict the legacy ldst_phys() API on x86 targets

Pierrick Bouvier (1):
  target/arm/arm-qmp-cmds.c: make compilation unit common

Richard Henderson (9):
  target/or1k: Rename from openrisc
  include/hw/or1k: Rename from openrisc
  hw/or1k: Rename from openrisc
  tests/tcg/or1k: Rename from openrisc
  docs/system/or1k: Rename from openrisc
  hw/or1k: Rename or1k-sim.c from openrisc_sim.c
  qapi: Add hexagon to SysEmuTarget
  meson: Add TARGET_ARCH to config_target_data
  target-info: Statically initialize target_arch

 MAINTAINERS                                   |  14 +-
 .../{openrisc => or1k}/cpu-features.rst       |   0
 docs/system/{openrisc => or1k}/emulation.rst  |   0
 docs/system/{openrisc => or1k}/or1k-sim.rst   |   0
 docs/system/{openrisc => or1k}/virt.rst       |   0
 .../{target-openrisc.rst => target-or1k.rst}  |   8 +-
 docs/system/targets.rst                       |   2 +-
 configs/targets/i386-softmmu.mak              |   1 +
 configs/targets/or1k-linux-user.mak           |   2 +-
 configs/targets/or1k-softmmu.mak              |   2 +-
 configs/targets/sparc-linux-user.mak          |   1 +
 configs/targets/sparc-softmmu.mak             |   2 +
 configs/targets/sparc32plus-linux-user.mak    |   1 +
 configs/targets/sparc64-linux-user.mak        |   1 +
 configs/targets/sparc64-softmmu.mak           |   1 +
 configs/targets/x86_64-softmmu.mak            |   1 +
 meson.build                                   |   4 +-
 qapi/machine.json                             |   4 +-
 include/exec/poison.h                         |   2 +-
 include/hw/{openrisc => or1k}/boot.h          |   6 +-
 include/system/arch_init.h                    |   2 +-
 include/user/abitypes.h                       |   2 +-
 linux-user/{openrisc => or1k}/sockbits.h      |   0
 linux-user/{openrisc => or1k}/target_cpu.h    |   0
 linux-user/{openrisc => or1k}/target_elf.h    |   0
 .../{openrisc => or1k}/target_errno_defs.h    |   0
 linux-user/{openrisc => or1k}/target_fcntl.h  |   0
 linux-user/{openrisc => or1k}/target_mman.h   |   0
 linux-user/{openrisc => or1k}/target_prctl.h  |   0
 linux-user/{openrisc => or1k}/target_proc.h   |   0
 linux-user/{openrisc => or1k}/target_ptrace.h |   0
 .../{openrisc => or1k}/target_resource.h      |   0
 linux-user/{openrisc => or1k}/target_signal.h |   0
 .../{openrisc => or1k}/target_structs.h       |   0
 .../{openrisc => or1k}/target_syscall.h       |   0
 linux-user/{openrisc => or1k}/termbits.h      |   0
 linux-user/syscall_defs.h                     |   4 +-
 target/arm/kvm_arm.h                          |   3 +
 target/{openrisc => or1k}/cpu-param.h         |   0
 target/{openrisc => or1k}/cpu-qom.h           |   0
 target/{openrisc => or1k}/cpu.h               |   0
 target/{openrisc => or1k}/exception.h         |   0
 target/{openrisc => or1k}/helper.h            |   0
 target/s390x/kvm/pv.h                         |  27 ---
 target/s390x/s390x-internal.h                 |  14 +-
 target/{openrisc => or1k}/insns.decode        |   0
 hw/intc/apic.c                                |   2 +-
 hw/intc/ioapic.c                              |   5 +-
 hw/{openrisc => or1k}/boot.c                  |   2 +-
 hw/{openrisc => or1k}/cputimer.c              |   0
 .../openrisc_sim.c => or1k/or1k-sim.c}        |   2 +-
 hw/{openrisc => or1k}/virt.c                  |   2 +-
 linux-user/{openrisc => or1k}/cpu_loop.c      |   0
 linux-user/{openrisc => or1k}/elfload.c       |   0
 linux-user/{openrisc => or1k}/signal.c        |   0
 system/qdev-monitor.c                         |   2 +-
 target-info-stub.c                            |   2 +-
 target-info.c                                 |   8 +-
 target/arm/arm-qmp-cmds.c                     |  27 +--
 target/arm/kvm-stub.c                         |   5 +
 target/arm/kvm.c                              |  21 +++
 target/i386/helper.c                          |  12 +-
 target/i386/tcg/system/misc_helper.c          |  16 +-
 target/{openrisc => or1k}/cpu.c               |   0
 target/{openrisc => or1k}/disas.c             |   0
 target/{openrisc => or1k}/exception.c         |   0
 target/{openrisc => or1k}/exception_helper.c  |   0
 target/{openrisc => or1k}/fpu_helper.c        |   0
 target/{openrisc => or1k}/gdbstub.c           |   0
 target/{openrisc => or1k}/interrupt.c         |   0
 target/{openrisc => or1k}/interrupt_helper.c  |   0
 target/{openrisc => or1k}/machine.c           |   0
 target/{openrisc => or1k}/mmu.c               |   0
 target/{openrisc => or1k}/sys_helper.c        |   0
 target/{openrisc => or1k}/translate.c         |   0
 target/s390x/helper.c                         |  10 +-
 target/s390x/kvm/stubs.c                      | 170 +++++++++++++++++-
 target/s390x/mmu_helper.c                     |  33 ++--
 target/s390x/tcg/excp_helper.c                |   3 +-
 target/s390x/tcg/translate.c                  |  66 +++----
 target/sparc/ldst_helper.c                    |   9 -
 target/sparc/mmu_helper.c                     |   4 +-
 target/sparc/translate.c                      |  58 +++---
 tests/tcg/{openrisc => or1k}/test_add.c       |   0
 tests/tcg/{openrisc => or1k}/test_addc.c      |   0
 tests/tcg/{openrisc => or1k}/test_addi.c      |   0
 tests/tcg/{openrisc => or1k}/test_addic.c     |   0
 tests/tcg/{openrisc => or1k}/test_and_or.c    |   0
 tests/tcg/{openrisc => or1k}/test_bf.c        |   0
 tests/tcg/{openrisc => or1k}/test_bnf.c       |   0
 tests/tcg/{openrisc => or1k}/test_div.c       |   0
 tests/tcg/{openrisc => or1k}/test_divu.c      |   0
 tests/tcg/{openrisc => or1k}/test_extx.c      |   0
 tests/tcg/{openrisc => or1k}/test_fx.c        |   0
 tests/tcg/{openrisc => or1k}/test_j.c         |   0
 tests/tcg/{openrisc => or1k}/test_jal.c       |   0
 tests/tcg/{openrisc => or1k}/test_lf_add.c    |   0
 tests/tcg/{openrisc => or1k}/test_lf_div.c    |   0
 tests/tcg/{openrisc => or1k}/test_lf_eqs.c    |   0
 tests/tcg/{openrisc => or1k}/test_lf_ges.c    |   0
 tests/tcg/{openrisc => or1k}/test_lf_gts.c    |   0
 tests/tcg/{openrisc => or1k}/test_lf_les.c    |   0
 tests/tcg/{openrisc => or1k}/test_lf_lts.c    |   0
 tests/tcg/{openrisc => or1k}/test_lf_mul.c    |   0
 tests/tcg/{openrisc => or1k}/test_lf_nes.c    |   0
 tests/tcg/{openrisc => or1k}/test_lf_rem.c    |   0
 tests/tcg/{openrisc => or1k}/test_lf_sub.c    |   0
 tests/tcg/{openrisc => or1k}/test_logic.c     |   0
 tests/tcg/{openrisc => or1k}/test_lx.c        |   0
 tests/tcg/{openrisc => or1k}/test_movhi.c     |   0
 tests/tcg/{openrisc => or1k}/test_mul.c       |   0
 tests/tcg/{openrisc => or1k}/test_muli.c      |   0
 tests/tcg/{openrisc => or1k}/test_mulu.c      |   0
 tests/tcg/{openrisc => or1k}/test_sfeq.c      |   0
 tests/tcg/{openrisc => or1k}/test_sfeqi.c     |   0
 tests/tcg/{openrisc => or1k}/test_sfges.c     |   0
 tests/tcg/{openrisc => or1k}/test_sfgesi.c    |   0
 tests/tcg/{openrisc => or1k}/test_sfgeu.c     |   0
 tests/tcg/{openrisc => or1k}/test_sfgeui.c    |   0
 tests/tcg/{openrisc => or1k}/test_sfgts.c     |   0
 tests/tcg/{openrisc => or1k}/test_sfgtsi.c    |   0
 tests/tcg/{openrisc => or1k}/test_sfgtu.c     |   0
 tests/tcg/{openrisc => or1k}/test_sfgtui.c    |   0
 tests/tcg/{openrisc => or1k}/test_sfles.c     |   0
 tests/tcg/{openrisc => or1k}/test_sflesi.c    |   0
 tests/tcg/{openrisc => or1k}/test_sfleu.c     |   0
 tests/tcg/{openrisc => or1k}/test_sfleui.c    |   0
 tests/tcg/{openrisc => or1k}/test_sflts.c     |   0
 tests/tcg/{openrisc => or1k}/test_sfltsi.c    |   0
 tests/tcg/{openrisc => or1k}/test_sfltu.c     |   0
 tests/tcg/{openrisc => or1k}/test_sfltui.c    |   0
 tests/tcg/{openrisc => or1k}/test_sfne.c      |   0
 tests/tcg/{openrisc => or1k}/test_sfnei.c     |   0
 tests/tcg/{openrisc => or1k}/test_sub.c       |   0
 hw/Kconfig                                    |   2 +-
 hw/meson.build                                |   2 +-
 hw/{openrisc => or1k}/Kconfig                 |   4 +-
 hw/{openrisc => or1k}/meson.build             |   4 +-
 linux-user/meson.build                        |   2 +-
 linux-user/openrisc/meson.build               |   5 -
 linux-user/or1k/meson.build                   |   5 +
 linux-user/{openrisc => or1k}/syscall.tbl     |   0
 linux-user/{openrisc => or1k}/syscallhdr.sh   |   0
 target/Kconfig                                |   2 +-
 target/arm/meson.build                        |   2 +-
 target/meson.build                            |   2 +-
 target/{openrisc => or1k}/Kconfig             |   2 +-
 target/{openrisc => or1k}/meson.build         |   4 +-
 target/s390x/meson.build                      |   8 +-
 target/s390x/tcg/meson.build                  |   2 +-
 tests/functional/riscv64/test_boston.py       |  19 --
 tests/tcg/{openrisc => or1k}/Makefile         |   0
 152 files changed, 382 insertions(+), 246 deletions(-)
 rename docs/system/{openrisc => or1k}/cpu-features.rst (100%)
 rename docs/system/{openrisc => or1k}/emulation.rst (100%)
 rename docs/system/{openrisc => or1k}/or1k-sim.rst (100%)
 rename docs/system/{openrisc => or1k}/virt.rst (100%)
 rename docs/system/{target-openrisc.rst => target-or1k.rst} (96%)
 rename include/hw/{openrisc => or1k}/boot.h (93%)
 rename linux-user/{openrisc => or1k}/sockbits.h (100%)
 rename linux-user/{openrisc => or1k}/target_cpu.h (100%)
 rename linux-user/{openrisc => or1k}/target_elf.h (100%)
 rename linux-user/{openrisc => or1k}/target_errno_defs.h (100%)
 rename linux-user/{openrisc => or1k}/target_fcntl.h (100%)
 rename linux-user/{openrisc => or1k}/target_mman.h (100%)
 rename linux-user/{openrisc => or1k}/target_prctl.h (100%)
 rename linux-user/{openrisc => or1k}/target_proc.h (100%)
 rename linux-user/{openrisc => or1k}/target_ptrace.h (100%)
 rename linux-user/{openrisc => or1k}/target_resource.h (100%)
 rename linux-user/{openrisc => or1k}/target_signal.h (100%)
 rename linux-user/{openrisc => or1k}/target_structs.h (100%)
 rename linux-user/{openrisc => or1k}/target_syscall.h (100%)
 rename linux-user/{openrisc => or1k}/termbits.h (100%)
 rename target/{openrisc => or1k}/cpu-param.h (100%)
 rename target/{openrisc => or1k}/cpu-qom.h (100%)
 rename target/{openrisc => or1k}/cpu.h (100%)
 rename target/{openrisc => or1k}/exception.h (100%)
 rename target/{openrisc => or1k}/helper.h (100%)
 rename target/{openrisc => or1k}/insns.decode (100%)
 rename hw/{openrisc => or1k}/boot.c (99%)
 rename hw/{openrisc => or1k}/cputimer.c (100%)
 rename hw/{openrisc/openrisc_sim.c => or1k/or1k-sim.c} (99%)
 rename hw/{openrisc => or1k}/virt.c (99%)
 rename linux-user/{openrisc => or1k}/cpu_loop.c (100%)
 rename linux-user/{openrisc => or1k}/elfload.c (100%)
 rename linux-user/{openrisc => or1k}/signal.c (100%)
 rename target/{openrisc => or1k}/cpu.c (100%)
 rename target/{openrisc => or1k}/disas.c (100%)
 rename target/{openrisc => or1k}/exception.c (100%)
 rename target/{openrisc => or1k}/exception_helper.c (100%)
 rename target/{openrisc => or1k}/fpu_helper.c (100%)
 rename target/{openrisc => or1k}/gdbstub.c (100%)
 rename target/{openrisc => or1k}/interrupt.c (100%)
 rename target/{openrisc => or1k}/interrupt_helper.c (100%)
 rename target/{openrisc => or1k}/machine.c (100%)
 rename target/{openrisc => or1k}/mmu.c (100%)
 rename target/{openrisc => or1k}/sys_helper.c (100%)
 rename target/{openrisc => or1k}/translate.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_add.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_addc.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_addi.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_addic.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_and_or.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_bf.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_bnf.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_div.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_divu.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_extx.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_fx.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_j.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_jal.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_add.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_div.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_eqs.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_ges.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_gts.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_les.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_lts.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_mul.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_nes.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_rem.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_sub.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_logic.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lx.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_movhi.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_mul.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_muli.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_mulu.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfeq.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfeqi.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfges.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfgesi.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfgeu.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfgeui.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfgts.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfgtsi.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfgtu.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfgtui.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfles.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sflesi.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfleu.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfleui.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sflts.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfltsi.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfltu.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfltui.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfne.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfnei.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sub.c (100%)
 rename hw/{openrisc => or1k}/Kconfig (89%)
 rename hw/{openrisc => or1k}/meson.build (60%)
 delete mode 100644 linux-user/openrisc/meson.build
 create mode 100644 linux-user/or1k/meson.build
 rename linux-user/{openrisc => or1k}/syscall.tbl (100%)
 rename linux-user/{openrisc => or1k}/syscallhdr.sh (100%)
 rename target/{openrisc => or1k}/Kconfig (76%)
 rename target/{openrisc => or1k}/meson.build (79%)
 rename tests/tcg/{openrisc => or1k}/Makefile (100%)

-- 
2.52.0


