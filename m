Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66ADC47DDB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTwzw-0004db-II; Sat, 27 Jan 2024 23:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTwzu-0004Xd-QO
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:42:22 -0500
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTwzs-0004Ej-J1
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:42:22 -0500
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-68196a09e2eso14917746d6.3
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706416939; x=1707021739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=q1jwjqm7l9h5DBFAY4dReFeQ1iAcBWZLYF0/hKu249Q=;
 b=Ol0goO2T3F838U12aICxCm/0ANAYRkVDpYSFhxVp/fowWC+nfpb5JUgjtuHDQ0QF8y
 VES3OvslGY9XJf+IRBaGSYQQoOO1krUHXllGQ9bZosmA8KoMhl8FwbRdFHl7w1VHrDRX
 gfig2mpDexR/I7qRNZRVi3Xq7wgeIoL24jcOSdNxbSgXJfiw6inXpLYe35CfqAbfOZPJ
 pbZQkN6m1FSwMmLJOJ6lH84s63o/muh/cSm61bY4P7iwm2imajhwGyiglbt97YQtXqGO
 fk+5R7hm+1DPSGCru8JItaistZN5YGKnV2qWlQEYCwYIw9pzFux7SpCJoVmDOT/j2/MX
 9I5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706416939; x=1707021739;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q1jwjqm7l9h5DBFAY4dReFeQ1iAcBWZLYF0/hKu249Q=;
 b=uwBj/goODgX1KK6sYoCBS7lEeCatjyhFl02oVEa43GTUcPWoZqa2gNbbycU2MzCP2I
 sE0EuoOOUeNu0OVaLGenXSJjBA+cB07BiDfyvgfwR8/e03ze+IiWe10DiciRLfo60z3L
 5k5QMowRIwa3EKSTqQTc5eww9tAOd1qssBlP8pYgcZhG5tH4Ofa3C+z+kWITEwbIc2p+
 jD1itzamvRsgoCCn5KmimnFNemE+4IPcV2zXPbFc52Ne46PFcY2zzqwfd666Q+LMxrbP
 josWYZAHcozjBWyYvdXO1iKdkPWFBGFbSK8F9TjE3z4yY1Qq1iegUgPNJ7gJI1D8a+M+
 xBBw==
X-Gm-Message-State: AOJu0YxVEnVpWBZV35BGnTeggnpHUaqozwo4u+oz0r6471oWoHgcFCOA
 qOu1eYHIA+wBh3aocCN6MgLiw1xuVWBp9sCpAJxJZZw+Jyuguj0bAh5xoamHnGETADqJyRrqGmn
 p+p7Heg==
X-Google-Smtp-Source: AGHT+IGMnRCqzlT116PwdOK9KhZj35iIsRjtIqu8qN8rJ6eNoQoap57ZzjD+AFlrTTuPRdzGSZiY2A==
X-Received: by 2002:ad4:5ec8:0:b0:680:c76b:2bd4 with SMTP id
 jm8-20020ad45ec8000000b00680c76b2bd4mr4088401qvb.131.1706416939200; 
 Sat, 27 Jan 2024 20:42:19 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.42.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:42:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/33] tcg patch queue, pre-pull
Date: Sun, 28 Jan 2024 14:41:40 +1000
Message-Id: <20240128044213.316480-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Collect some patch sets, cherry-pick from others, with a few
changes of my own.  Patches that lack review:

  26-include-qemu-Add-TCGCPUOps-typedef-to-typedefs.h.patch
  27-target-loongarch-Constify-loongarch_tcg_ops.patch
  28-accel-tcg-Use-CPUState.cc-instead-of-CPU_GET_CLASS-i.patch
  31-accel-tcg-Inline-need_replay_interrupt.patch


r~


Anton Johansson (11):
  include/exec: Move vaddr defines to separate file
  hw/core: Include vaddr.h from cpu.h
  target: Use vaddr in gen_intermediate_code
  include/exec: Use vaddr in DisasContextBase for virtual addresses
  include/exec: typedef abi_ptr to vaddr
  target: Uninline cpu_mmu_index()
  target: Uninline cpu_get_tb_cpu_state()
  include/exec: Move PAGE_* macros to common header
  include/exec: Move cpu_*()/cpu_env() to common header
  include/hw/core: Move do_interrupt in TCGCPUOps
  include/hw/core: Remove i386 conditional on fake_user_interrupt

Ilya Leoshkevich (8):
  linux-user: Allow gdbstub to ignore page protection
  tests/tcg: Factor out gdbstub test functions
  tests/tcg: Add the PROT_NONE gdbstub test
  target: Make qemu_target_page_mask() available for *-user
  accel/tcg: Make use of qemu_target_page_mask() in perf.c
  tcg: Make tb_cflags() usable from target-agnostic code
  accel/tcg: Remove #ifdef TARGET_I386 from perf.c
  accel/tcg: Move perf and debuginfo support to tcg/

Paolo Bonzini (1):
  cpu-exec: simplify jump cache management

Philippe Mathieu-Daudé (9):
  accel/tcg/cpu-exec: Use RCU_READ_LOCK_GUARD
  accel/tcg: Rename tcg_ss[] -> tcg_specific_ss[] in meson
  accel/tcg: Rename tcg_cpus_destroy() -> tcg_cpu_destroy()
  accel/tcg: Rename tcg_cpus_exec() -> tcg_cpu_exec()
  accel/tcg: Un-inline icount_exit_request() for clarity
  accel/tcg: Introduce TCGCPUOps::need_replay_interrupt() handler
  target/i386: Extract x86_need_replay_interrupt() from accel/tcg/
  accel/tcg: Introduce TCGCPUOps::cpu_exec_halt() handler
  target/i386: Extract x86_cpu_exec_halt() from accel/tcg/

Richard Henderson (4):
  include/qemu: Add TCGCPUOps typedef to typedefs.h
  target/loongarch: Constify loongarch_tcg_ops
  accel/tcg: Use CPUState.cc instead of CPU_GET_CLASS in cpu-exec.c
  accel/tcg: Inline need_replay_interrupt

 accel/tcg/tb-jmp-cache.h                      |   8 +-
 accel/tcg/tcg-accel-ops.h                     |   4 +-
 include/exec/cpu-all.h                        |  49 ----
 include/exec/cpu-common.h                     |  82 ++++++-
 include/exec/cpu_ldst.h                       |   4 +-
 include/exec/exec-all.h                       |   6 -
 include/exec/translation-block.h              |   6 +
 include/exec/translator.h                     |   8 +-
 include/exec/vaddr.h                          |  18 ++
 include/hw/core/cpu.h                         |   7 +-
 include/hw/core/tcg-cpu-ops.h                 |  19 +-
 include/qemu/typedefs.h                       |   1 +
 {accel => include}/tcg/debuginfo.h            |   4 +-
 {accel => include}/tcg/perf.h                 |   4 +-
 target/alpha/cpu.h                            |  20 --
 target/arm/cpu.h                              |  16 --
 target/avr/cpu.h                              |  25 --
 target/cris/cpu.h                             |  14 --
 target/hexagon/cpu.h                          |  21 --
 target/hppa/cpu.h                             |  55 -----
 target/i386/cpu.h                             |  21 --
 target/i386/tcg/helper-tcg.h                  |   2 +
 target/loongarch/cpu.h                        |  24 --
 target/m68k/cpu.h                             |  20 --
 target/microblaze/cpu.h                       |  23 --
 target/mips/cpu.h                             |  14 --
 target/mips/tcg/translate.h                   |   3 +-
 target/nios2/cpu.h                            |  18 --
 target/openrisc/cpu.h                         |  22 --
 target/ppc/cpu.h                              |  21 --
 target/riscv/cpu.h                            |   6 -
 target/rx/cpu.h                               |  14 --
 target/s390x/cpu.h                            |  55 -----
 target/sh4/cpu.h                              |  25 --
 target/sparc/cpu.h                            |  61 -----
 target/tricore/cpu.h                          |  17 --
 target/xtensa/cpu.h                           |  73 ------
 accel/tcg/cpu-exec.c                          | 223 ++++++++----------
 accel/tcg/tcg-accel-ops-mttcg.c               |   4 +-
 accel/tcg/tcg-accel-ops-rr.c                  |   4 +-
 accel/tcg/tcg-accel-ops.c                     |   4 +-
 accel/tcg/translate-all.c                     |   2 +-
 bsd-user/signal.c                             |   4 +-
 cpu-target.c                                  |  76 ++++--
 hw/core/loader.c                              |   2 +-
 linux-user/elfload.c                          |   2 +-
 linux-user/exit.c                             |   2 +-
 linux-user/main.c                             |   2 +-
 linux-user/signal.c                           |   4 +-
 system/physmem.c                              |   5 -
 system/vl.c                                   |   2 +-
 target/alpha/cpu.c                            |  21 +-
 target/alpha/translate.c                      |   2 +-
 target/arm/cpu.c                              |   7 +-
 target/arm/tcg/cpu32.c                        |   2 +-
 target/arm/tcg/translate.c                    |   2 +-
 target/avr/cpu.c                              |  25 +-
 target/avr/translate.c                        |   2 +-
 target/cris/cpu.c                             |  18 +-
 target/cris/translate.c                       |   2 +-
 target/hexagon/cpu.c                          |  23 +-
 target/hexagon/translate.c                    |   5 +-
 target/hppa/cpu.c                             |  57 ++++-
 target/hppa/translate.c                       |   2 +-
 target/i386/cpu.c                             |  21 ++
 target/i386/tcg/sysemu/seg_helper.c           |  23 ++
 target/i386/tcg/tcg-cpu.c                     |   4 +-
 target/i386/tcg/translate.c                   |   2 +-
 target/loongarch/cpu.c                        |  26 +-
 target/loongarch/tcg/translate.c              |   2 +-
 target/m68k/cpu.c                             |  23 +-
 target/m68k/translate.c                       |   4 +-
 target/microblaze/cpu.c                       |  25 +-
 target/microblaze/translate.c                 |   2 +-
 target/mips/cpu.c                             |  16 +-
 target/mips/tcg/translate.c                   |  14 +-
 target/nios2/cpu.c                            |  20 +-
 target/nios2/translate.c                      |   2 +-
 target/openrisc/cpu.c                         |  24 +-
 target/openrisc/translate.c                   |   2 +-
 target/ppc/cpu.c                              |   9 +
 target/ppc/cpu_init.c                         |   2 +-
 target/ppc/helper_regs.c                      |  17 +-
 target/ppc/translate.c                        |   2 +-
 target/riscv/cpu_helper.c                     |   2 +-
 target/riscv/tcg/tcg-cpu.c                    |   2 +-
 target/riscv/translate.c                      |   2 +-
 target/rx/cpu.c                               |  16 +-
 target/rx/translate.c                         |   2 +-
 target/s390x/cpu.c                            |  55 ++++-
 target/s390x/tcg/translate.c                  |   2 +-
 target/sh4/cpu.c                              |  30 ++-
 target/sh4/translate.c                        |   2 +-
 target/sparc/cpu.c                            |  63 ++++-
 target/sparc/translate.c                      |   2 +-
 target/target-common.c                        |  10 +
 target/tricore/cpu.c                          |  19 +-
 target/tricore/translate.c                    |   2 +-
 target/xtensa/cpu.c                           |  74 +++++-
 target/xtensa/translate.c                     |   2 +-
 {accel/tcg => tcg}/debuginfo.c                |   3 +-
 {accel/tcg => tcg}/perf.c                     |  14 +-
 tcg/tcg.c                                     |   2 +-
 tests/tcg/multiarch/prot-none.c               |  40 ++++
 accel/tcg/meson.build                         |  16 +-
 target/meson.build                            |   2 +
 tcg/meson.build                               |   5 +
 tests/guest-debug/run-test.py                 |   7 +-
 tests/guest-debug/test_gdbstub.py             |  56 +++++
 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py   |  34 +--
 tests/tcg/aarch64/gdbstub/test-sve.py         |  33 +--
 tests/tcg/multiarch/Makefile.target           |   9 +-
 tests/tcg/multiarch/gdbstub/interrupt.py      |  47 +---
 tests/tcg/multiarch/gdbstub/memory.py         |  39 +--
 tests/tcg/multiarch/gdbstub/prot-none.py      |  22 ++
 tests/tcg/multiarch/gdbstub/registers.py      |  41 +---
 tests/tcg/multiarch/gdbstub/sha1.py           |  38 +--
 .../multiarch/gdbstub/test-proc-mappings.py   |  39 +--
 .../multiarch/gdbstub/test-qxfer-auxv-read.py |  37 +--
 .../gdbstub/test-thread-breakpoint.py         |  37 +--
 tests/tcg/s390x/gdbstub/test-signals-s390x.py |  42 +---
 tests/tcg/s390x/gdbstub/test-svc.py           |  39 +--
 122 files changed, 1117 insertions(+), 1304 deletions(-)
 create mode 100644 include/exec/vaddr.h
 rename {accel => include}/tcg/debuginfo.h (96%)
 rename {accel => include}/tcg/perf.h (95%)
 create mode 100644 target/target-common.c
 rename {accel/tcg => tcg}/debuginfo.c (98%)
 rename {accel/tcg => tcg}/perf.c (97%)
 create mode 100644 tests/tcg/multiarch/prot-none.c
 create mode 100644 tests/guest-debug/test_gdbstub.py
 create mode 100644 tests/tcg/multiarch/gdbstub/prot-none.py

-- 
2.34.1


