Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D760C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 15:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBxgr-0005g9-1C; Mon, 05 May 2025 11:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uBxgp-0005fP-80
 for qemu-devel@nongnu.org; Mon, 05 May 2025 11:25:07 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uBxgm-0000a0-Bv
 for qemu-devel@nongnu.org; Mon, 05 May 2025 11:25:06 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e5c7d6b96fso8445192a12.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 08:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746458702; x=1747063502; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cqpgkJEQuG44aBgrUdUh7xADengRTixbxPrRkQfeC+U=;
 b=fV1SwGkwrYJATSv5rXpjdkmhOi+KQ2REuM6I/lwDOVv0qtvgWaB8VGb29tuEklDg2X
 G9B9nspAw6SInNAT51FXu8mcjcIsNc9fbn3CLnUHy6NSaP/jrnm9QGBNoBxy7A1W0n6r
 xKHR4+XpUnHtY2ajC9Kw3yMONGngI1skUzGfhP1bFAkNIX9VsxQseBnmrpNQ6oujks6r
 RyPM/DRUW1q4WsuyCdAeJtjzbXTwwJY11skaHeTsxkSaptgU13loZbATnVCsSJwldkad
 UgEMfH/z6owtuodjl6ABFgzY4aNDykHTMcuQ+V48BQ4oVm5VYBtOV8eZOOX03GRW+dH5
 vplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746458702; x=1747063502;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cqpgkJEQuG44aBgrUdUh7xADengRTixbxPrRkQfeC+U=;
 b=Ghgspd7gw0uDEjICe8eFRRfMOr+LMhzzauMnFYxygXWdqeGb9kyCel4YUD4bzK7Xiw
 Bh6XookxM7uQtj0W4f8tlKbT4D4D0dIjrDuEum2PXq0F4KtWAgV8eUN0/viDUDmVo0LX
 R6FlUE05RwoWScMz99Za+eybIVcL9HuParvzWkbk28z12iO2zBxaFnFNEQYgHddKmV9Y
 m+8CbD644Mg4RHfwr+uN7xCOSbug6hsbLtiEHABojgVlPFayHGoTnC9XWX3oScrBY+VU
 iWsS693A3IclkJnzikBFpLNfh9ZSHSwDwPximzwf9bwu30ecJ19EpNosqLxKeita9kLD
 jxUg==
X-Gm-Message-State: AOJu0YwUqjfD4Z8JQBTzt4ORIkWd3vqamteG7I5YQ03PF/jXo2dM74Kq
 n/zfcls53wNssJx+Qte1lsZuLmx3gFmAkptiHGwlG6zFxOcbwaeF8AAwBwzD9RHOT0ClLO9++iT
 kYXB6q5OYDNzDGs7TfnosWGxTEZc=
X-Gm-Gg: ASbGncu9rdEUw3pm99pDdXPwIS7nWY8w3viTL64uL9KTCYm9LHp7U6Ad5YGt/5RLYq6
 hoRs/WZpq1nJd2p6aAcuMtMLXCdbnfXkb9QX/FJMWacncMbgZ116Wa5ktBaTCXRGHPEpNxS5x5T
 bwzUOwtTtMkp0ErRZpRQs4
X-Google-Smtp-Source: AGHT+IEC7P++reNlHRUacgQaeuhkVXZBj2923eGInMM4RndaNCwfSh3ApXGAJaz0QYhMMIMtx+AzH7sZ90DdIz1uiIs=
X-Received: by 2002:a05:6402:13d1:b0:5f7:f55a:e5c8 with SMTP id
 4fb4d7f45d1cf-5fab05c131emr5779419a12.21.1746458702183; Mon, 05 May 2025
 08:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 5 May 2025 11:24:49 -0400
X-Gm-Features: ATxdqUEhuoDMw7_VKPNcvdLMaT7ZGk5nwpa-W1y1Q2EX5DKePeAHzn5qnwFRhBs
Message-ID: <CAJSP0QV_anbmEZtHp=jjh_Rjg4zmn47L1VP8zgG6Ov1tDEBZ-Q@mail.gmail.com>
Subject: Re: [PULL 00/59] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, May 1, 2025 at 5:22=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 5134cf9b5d3aee4475fe7e1c1c11b093731073=
cf:
>
>   Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into=
 staging (2025-04-30 13:34:44 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20250501
>
> for you to fetch changes up to 839129a8f8848d13d44364ca9cb6c042df589c75:
>
>   accel/tcg: Build user-exec.c once (2025-05-01 14:15:49 -0700)
>
> ----------------------------------------------------------------
> include: Remove 'exec/exec-all.h'
> accel/tcg: Build tb-maint.c twice
> accel/tcg: Build cpu-exec.c twice
> accel/tcg: Build translate-all.c twice
> accel/tcg: Build tcg-all.c twice
> accel/tcg: Build cputlb.c once
> accel/tcg: Build user-exec.c once
>
> ----------------------------------------------------------------
> Philippe Mathieu-Daud=C3=A9 (10):
>       include/exec: Include missing headers in exec-all.h
>       target/riscv: Include missing 'accel/tcg/getpc.h' in csr.c
>       accel/tcg: Include 'accel/tcg/getpc.h' in 'exec/helper-proto'
>       physmem: Move TCG IOTLB methods around
>       physmem: Restrict TCG IOTLB code to TCG accel
>       accel/tcg: Extract probe API out of 'exec/exec-all.h'
>       include: Remove 'exec/exec-all.h'
>       system/vl: Filter machine list available for a particular target bi=
nary
>       qemu/target_info: Add %target_cpu_type field to TargetInfo
>       qemu: Introduce target_long_bits()
>
> Richard Henderson (49):
>       accel/tcg: Add CPUState argument to page_unprotect
>       accel/tcg: Add CPUState argument to tb_invalidate_phys_page_unwind
>       accel/tcg: Add CPUState arg to tb_invalidate_phys_page_range__locke=
d
>       accel/tcg: Merge tb_invalidate_phys_range{__locked}
>       accel/tcg: Add CPUState arg to tb_invalidate_phys_range
>       accel/tcg: Add CPUState arg to tb_invalidate_phys_range_fast
>       accel/tcg: Convert TARGET_HAS_PRECISE_SMC to TCGCPUOps.precise_smc
>       accel/tcg: Simplify CPU_TLB_DYN_MAX_BITS
>       accel/tcg: Simplify L1_MAP_ADDR_SPACE_BITS
>       accel/tcg: Merge internal-target.h into internal-common.h
>       accel/tcg: Reduce scope of tb_phys_invalidate, tb_set_jmp_target
>       accel/tcg: Use vaddr for walk_memory_regions callback
>       accel/tcg: Use vaddr in user/page-protection.h
>       include/exec: Move tb_invalidate_phys_range to translation-block.h
>       accel/tcg: Compile tb-maint.c twice
>       accel/tcg: Remove #error for non-tcg in getpc.h
>       accel/tcg: Generalize fake_user_interrupt test
>       accel/tcg: Unconditionally use CPU_DUMP_CCOP in log_cpu_exec
>       accel/tcg: Introduce TCGCPUOps.cpu_exec_reset
>       target/i386: Split out x86_cpu_exec_reset
>       accel/tcg: Hoist cpu_get_tb_cpu_state decl to accl/tcg/cpu-ops.h
>       target/arm: Move cpu_get_tb_cpu_state to hflags.c
>       target/arm: Unexport assert_hflags_rebuild_correctly
>       target/riscv: Move cpu_get_tb_cpu_state to tcg-cpu.c
>       accel/tcg: Return TCGTBCPUState from cpu_get_tb_cpu_state
>       accel/tcg: Move cpu_get_tb_cpu_state to TCGCPUOps
>       accel/tcg: Pass TCGTBCPUState to tb_lookup
>       accel/tcg: Pass TCGTBCPUState to tb_htable_lookup
>       accel/tcg: Use TCGTBCPUState in struct tb_desc
>       accel/tcg: Pass TCGTBCPUState to tb_gen_code
>       accel/tcg: Split out accel/tcg/helper-retaddr.h
>       accel/tcg: Compile cpu-exec.c twice
>       tcg: Define INSN_START_WORDS as constant 3
>       accel/tcg: Don't use TARGET_LONG_BITS in decode_sleb128
>       accel/tcg: Use target_long_bits() in translate-all.c
>       accel/tcg: Build translate-all.c twice
>       accel/tcg: Build tcg-all.c twice
>       accel/tcg: Use vaddr in cpu_loop.h

Please check the following CI failure:

../bsd-user/signal.c:1033:6: error: conflicting types for
'cpu_loop_exit_sigsegv'
1033 | void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
| ^
/tmp/cirrus-ci-build/include/user/cpu_loop.h:60:17: note: previous
declaration is here
60 | G_NORETURN void cpu_loop_exit_sigsegv(CPUState *cpu, vaddr addr,
| ^
../bsd-user/signal.c:1049:6: error: conflicting types for 'cpu_loop_exit_si=
gbus'
1049 | void cpu_loop_exit_sigbus(CPUState *cpu, target_ulong addr,
| ^
/tmp/cirrus-ci-build/include/user/cpu_loop.h:74:17: note: previous
declaration is here
74 | G_NORETURN void cpu_loop_exit_sigbus(CPUState *cpu, vaddr addr,
| ^

https://gitlab.com/qemu-project/qemu/-/jobs/9931080893#L4953

>       accel/tcg: Move user-only tlb_vaddr_to_host out of line
>       accel/tcg: Move tlb_vaddr_to_host declaration to probe.h
>       accel/tcg: Use target_long_bits() in cputlb.c
>       accel/tcg: Use vaddr for plugin_{load,store}_cb
>       accel/tcg: Build cputlb.c once
>       include/user: Convert GUEST_ADDR_MAX to a variable
>       include/user: Use vaddr in guest-host.h
>       accel/tcg: Move TARGET_TAGGED_ADDRESSES to TCGCPUOps.untagged_addr
>       accel/tcg: Remove TARGET_PAGE_DATA_SIZE
>       accel/tcg: Avoid abi_ptr in user-exec.c
>       accel/tcg: Build user-exec.c once
>
>  accel/tcg/internal-common.h                    |  37 +++++-
>  accel/tcg/internal-target.h                    |  46 -------
>  accel/tcg/tb-hash.h                            |   3 +-
>  accel/tcg/tb-internal.h                        |   8 +-
>  accel/tcg/tlb-bounds.h                         |  21 +---
>  bsd-user/qemu.h                                |   1 -
>  include/accel/tcg/cpu-ldst.h                   |  58 ---------
>  include/accel/tcg/cpu-ops.h                    |  23 ++++
>  include/accel/tcg/getpc.h                      |   4 -
>  include/accel/tcg/helper-retaddr.h             |  43 +++++++
>  include/accel/tcg/iommu.h                      |  41 +++++++
>  include/{exec/exec-all.h =3D> accel/tcg/probe.h} |  67 +++-------
>  include/accel/tcg/tb-cpu-state.h               |  18 +++
>  include/exec/helper-proto-common.h             |   2 +
>  include/exec/poison.h                          |   1 -
>  include/exec/translation-block.h               |   4 +
>  include/qemu/target-info-impl.h                |   6 +
>  include/qemu/target-info.h                     |  15 +++
>  include/system/ram_addr.h                      |   1 -
>  include/tcg/insn-start-words.h                 |  11 +-
>  include/tcg/tcg-op.h                           |  17 ++-
>  include/tcg/tcg-opc.h                          |   3 +-
>  include/tcg/tcg.h                              |  12 +-
>  include/user/cpu_loop.h                        |  12 +-
>  include/user/guest-host.h                      |  49 +++-----
>  include/user/page-protection.h                 |  30 +++--
>  linux-user/user-internals.h                    |   1 -
>  target/alpha/cpu.h                             |  11 --
>  target/arm/cpu-param.h                         |   7 +-
>  target/arm/cpu.h                               |  39 +-----
>  target/arm/internals.h                         |   4 +-
>  target/arm/tcg/translate.h                     |   1 -
>  target/avr/cpu.h                               |  18 ---
>  target/hexagon/cpu.h                           |  15 ---
>  target/hexagon/mmvec/macros.h                  |   1 +
>  target/hppa/cpu.h                              |   3 -
>  target/i386/cpu.h                              |  18 ---
>  target/i386/tcg/helper-tcg.h                   |   1 -
>  target/loongarch/cpu.h                         |  12 --
>  target/m68k/cpu.h                              |  16 ---
>  target/microblaze/cpu.h                        |   8 --
>  target/mips/cpu.h                              |   9 --
>  target/openrisc/cpu.h                          |  10 --
>  target/ppc/cpu.h                               |  13 --
>  target/ppc/internal.h                          |   3 +
>  target/riscv/cpu.h                             |   3 -
>  target/rx/cpu.h                                |   9 --
>  target/s390x/cpu.h                             |  11 --
>  target/sh4/cpu.h                               |  15 ---
>  target/sparc/cpu.h                             |   3 -
>  target/tricore/cpu.h                           |  12 --
>  target/xtensa/cpu.h                            |  68 ----------
>  accel/hvf/hvf-accel-ops.c                      |   1 -
>  accel/tcg/cpu-exec.c                           | 164 ++++++++++---------=
------
>  accel/tcg/cputlb.c                             |  34 ++---
>  accel/tcg/tb-maint.c                           | 100 ++++++---------
>  accel/tcg/tcg-all.c                            |   6 +-
>  accel/tcg/translate-all.c                      |  95 +++++---------
>  accel/tcg/user-exec.c                          | 145 ++++++++++++-------=
---
>  bsd-user/main.c                                |   9 +-
>  hw/ppc/spapr_nested.c                          |   1 -
>  hw/riscv/riscv-iommu-sys.c                     |   1 -
>  hw/sh4/sh7750.c                                |   1 -
>  linux-user/elfload.c                           |  21 ++--
>  linux-user/main.c                              |   9 +-
>  linux-user/signal.c                            |   4 +-
>  linux-user/syscall.c                           |   8 +-
>  semihosting/uaccess.c                          |   2 +-
>  system/physmem.c                               |  58 +++++----
>  system/vl.c                                    |   3 +-
>  target-info-stub.c                             |   9 +-
>  target-info.c                                  |  15 +++
>  target/alpha/cpu.c                             |  18 ++-
>  target/alpha/fpu_helper.c                      |   1 -
>  target/alpha/int_helper.c                      |   1 -
>  target/alpha/mem_helper.c                      |   1 -
>  target/alpha/translate.c                       |   1 -
>  target/alpha/vax_helper.c                      |   1 -
>  target/arm/cpu.c                               |  30 ++++-
>  target/arm/debug_helper.c                      |   1 -
>  target/arm/helper.c                            | 113 +----------------
>  target/arm/ptw.c                               |   2 +-
>  target/arm/tcg-stubs.c                         |   4 -
>  target/arm/tcg/cpu-v7m.c                       |   2 +
>  target/arm/tcg/helper-a64.c                    |   3 +-
>  target/arm/tcg/hflags.c                        | 117 +++++++++++++++++-
>  target/arm/tcg/m_helper.c                      |   1 -
>  target/arm/tcg/mte_helper.c                    |   6 +-
>  target/arm/tcg/mve_helper.c                    |   1 -
>  target/arm/tcg/op_helper.c                     |   2 +-
>  target/arm/tcg/pauth_helper.c                  |   1 -
>  target/arm/tcg/sme_helper.c                    |   2 +-
>  target/arm/tcg/sve_helper.c                    |   3 +-
>  target/arm/tcg/tlb_helper.c                    |   1 -
>  target/arm/tcg/translate-a64.c                 |   1 -
>  target/avr/cpu.c                               |  21 +++-
>  target/avr/helper.c                            |   1 -
>  target/avr/translate.c                         |   1 -
>  target/hexagon/cpu.c                           |  21 +++-
>  target/hexagon/op_helper.c                     |   2 +-
>  target/hppa/cpu.c                              |  16 +--
>  target/hppa/fpu_helper.c                       |   1 -
>  target/hppa/helper.c                           |   1 -
>  target/hppa/mem_helper.c                       |   2 +-
>  target/hppa/op_helper.c                        |   2 +-
>  target/hppa/sys_helper.c                       |   1 -
>  target/hppa/translate.c                        |   1 -
>  target/i386/helper.c                           |   2 +-
>  target/i386/tcg/access.c                       |   2 +-
>  target/i386/tcg/excp_helper.c                  |   1 -
>  target/i386/tcg/int_helper.c                   |   1 -
>  target/i386/tcg/mem_helper.c                   |   1 -
>  target/i386/tcg/mpx_helper.c                   |   1 -
>  target/i386/tcg/seg_helper.c                   |   2 +-
>  target/i386/tcg/system/bpt_helper.c            |   1 -
>  target/i386/tcg/system/excp_helper.c           |   1 +
>  target/i386/tcg/tcg-cpu.c                      |  34 ++++-
>  target/i386/tcg/translate.c                    |   1 -
>  target/i386/tcg/user/excp_helper.c             |   1 -
>  target/i386/tcg/user/seg_helper.c              |   1 -
>  target/loongarch/cpu.c                         |  20 ++-
>  target/loongarch/tcg/fpu_helper.c              |   1 -
>  target/loongarch/tcg/iocsr_helper.c            |   1 -
>  target/loongarch/tcg/op_helper.c               |   1 -
>  target/loongarch/tcg/tlb_helper.c              |   1 -
>  target/loongarch/tcg/vec_helper.c              |   1 -
>  target/m68k/cpu.c                              |  24 +++-
>  target/m68k/fpu_helper.c                       |   1 -
>  target/m68k/helper.c                           |   1 -
>  target/m68k/op_helper.c                        |   1 -
>  target/m68k/translate.c                        |   1 -
>  target/microblaze/cpu.c                        |  17 ++-
>  target/microblaze/op_helper.c                  |   1 -
>  target/microblaze/translate.c                  |   1 -
>  target/mips/cpu.c                              |  14 ++-
>  target/mips/system/physaddr.c                  |   1 -
>  target/mips/tcg/exception.c                    |   1 -
>  target/mips/tcg/fpu_helper.c                   |   1 -
>  target/mips/tcg/ldst_helper.c                  |   1 -
>  target/mips/tcg/msa_helper.c                   |   2 +-
>  target/mips/tcg/op_helper.c                    |   1 -
>  target/mips/tcg/system/special_helper.c        |   1 -
>  target/mips/tcg/system/tlb_helper.c            |   1 -
>  target/openrisc/cpu.c                          |  18 ++-
>  target/openrisc/exception.c                    |   1 -
>  target/openrisc/exception_helper.c             |   1 -
>  target/openrisc/fpu_helper.c                   |   1 -
>  target/openrisc/interrupt.c                    |   1 -
>  target/openrisc/interrupt_helper.c             |   1 -
>  target/openrisc/sys_helper.c                   |   3 +-
>  target/openrisc/translate.c                    |   1 -
>  target/ppc/cpu_init.c                          |   3 +-
>  target/ppc/excp_helper.c                       |   1 -
>  target/ppc/fpu_helper.c                        |   1 -
>  target/ppc/helper_regs.c                       |  19 ++-
>  target/ppc/machine.c                           |   1 -
>  target/ppc/mem_helper.c                        |   3 +-
>  target/ppc/misc_helper.c                       |   1 -
>  target/ppc/mmu-hash32.c                        |   1 -
>  target/ppc/mmu-hash64.c                        |   1 -
>  target/ppc/mmu-radix64.c                       |   1 -
>  target/ppc/mmu_common.c                        |   1 -
>  target/ppc/mmu_helper.c                        |   1 -
>  target/ppc/power8-pmu.c                        |   1 -
>  target/ppc/tcg-excp_helper.c                   |   1 -
>  target/ppc/timebase_helper.c                   |   1 -
>  target/ppc/translate.c                         |   1 -
>  target/ppc/user_only_helper.c                  |   1 -
>  target/riscv/cpu.c                             |   1 -
>  target/riscv/cpu_helper.c                      |  98 ---------------
>  target/riscv/crypto_helper.c                   |   1 -
>  target/riscv/csr.c                             |   2 +-
>  target/riscv/debug.c                           |   1 -
>  target/riscv/fpu_helper.c                      |   1 -
>  target/riscv/m128_helper.c                     |   1 -
>  target/riscv/op_helper.c                       |   2 +-
>  target/riscv/tcg/tcg-cpu.c                     | 101 ++++++++++++++-
>  target/riscv/translate.c                       |   1 -
>  target/riscv/vcrypto_helper.c                  |   1 -
>  target/riscv/vector_helper.c                   |   2 +-
>  target/riscv/zce_helper.c                      |   1 -
>  target/rx/cpu.c                                |  16 ++-
>  target/rx/op_helper.c                          |   1 -
>  target/rx/translate.c                          |   1 -
>  target/s390x/cpu.c                             |  18 ++-
>  target/s390x/interrupt.c                       |   1 -
>  target/s390x/mmu_helper.c                      |   1 -
>  target/s390x/sigp.c                            |   1 -
>  target/s390x/tcg/cc_helper.c                   |   1 -
>  target/s390x/tcg/crypto_helper.c               |   1 -
>  target/s390x/tcg/excp_helper.c                 |   1 -
>  target/s390x/tcg/fpu_helper.c                  |   1 -
>  target/s390x/tcg/int_helper.c                  |   1 -
>  target/s390x/tcg/mem_helper.c                  |   3 +-
>  target/s390x/tcg/misc_helper.c                 |   1 -
>  target/s390x/tcg/translate.c                   |   1 -
>  target/s390x/tcg/vec_fpu_helper.c              |   1 -
>  target/s390x/tcg/vec_helper.c                  |   1 -
>  target/sh4/cpu.c                               |  29 ++++-
>  target/sh4/helper.c                            |   1 -
>  target/sh4/op_helper.c                         |   1 -
>  target/sh4/translate.c                         |   1 -
>  target/sparc/cpu.c                             |  20 +--
>  target/sparc/fop_helper.c                      |   1 -
>  target/sparc/helper.c                          |   1 -
>  target/sparc/ldst_helper.c                     |   1 -
>  target/sparc/machine.c                         |   1 -
>  target/sparc/translate.c                       |   1 -
>  target/sparc/win_helper.c                      |   1 -
>  target/tricore/cpu.c                           |  16 ++-
>  target/tricore/op_helper.c                     |   1 -
>  target/tricore/translate.c                     |   1 -
>  target/xtensa/cpu.c                            |  79 +++++++++++-
>  target/xtensa/dbg_helper.c                     |   1 -
>  target/xtensa/exc_helper.c                     |   1 -
>  target/xtensa/fpu_helper.c                     |   1 -
>  target/xtensa/mmu_helper.c                     |   2 +-
>  target/xtensa/op_helper.c                      |   1 -
>  target/xtensa/translate.c                      |   1 -
>  target/xtensa/win_helper.c                     |   1 -
>  tcg/perf.c                                     |   5 +-
>  tcg/tcg.c                                      |  12 +-
>  MAINTAINERS                                    |   3 +-
>  accel/tcg/ldst_common.c.inc                    |   4 +-
>  accel/tcg/meson.build                          |  20 +--
>  225 files changed, 1230 insertions(+), 1364 deletions(-)
>  delete mode 100644 accel/tcg/internal-target.h
>  create mode 100644 include/accel/tcg/helper-retaddr.h
>  create mode 100644 include/accel/tcg/iommu.h
>  rename include/{exec/exec-all.h =3D> accel/tcg/probe.h} (64%)
>  create mode 100644 include/accel/tcg/tb-cpu-state.h
>

