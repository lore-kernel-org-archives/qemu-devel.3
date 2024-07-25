Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9ACC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8AK-000884-8J; Thu, 25 Jul 2024 19:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8AG-00083Y-MX
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:29 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8AD-0005IM-Ig
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:28 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3cabac56b38so272419b6e.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 16:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721951184; x=1722555984;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SDZzuXELxmPUp8CRA1PEnvou4xImrqnLEUuFAGJuXPU=;
 b=EFtobRxfOmM5zQS9+ySv4fv8VhQ413N8EyMoQ4etU+ymiKRyMGE3eadGR4z8PB2zIb
 JLwQRR/LGIMsYymG5oe2QJWKr+iIR3xrRdH3G4uDoaWI3S3lRE4HWF54Weg+rD5xHh76
 dZ/ST51Eskmx8bcnnnf4DOsmRIbbrdHGYBac3B//1X8hvSH8GKbTTvFhLhsMAKeKRnR0
 2+cX91jkMja2pRGarmyoXlUreaWK8tEyXfwXdLicjQ4f/E3d2iP5eRyvHwg4U6RMe7Dw
 Il4EIIBAUWT6UjD7OL6JK/s79qEgKMSwVG7nJgO3/0LedznyfvRJHo3stVp2MY593pZS
 XFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951184; x=1722555984;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SDZzuXELxmPUp8CRA1PEnvou4xImrqnLEUuFAGJuXPU=;
 b=l+PCsb8HqzmzwHunwRztN2Gra+qZLm7iWYgrpVdUJU9sQotJILVoesEMjH5Xt03ax8
 1VpSiTv6YljdnXkyOFFwbD8ZljjXsFFmUTrD1dHV7EpEaHzFxAAbQGUwA/y2QCFOwABO
 IIf/c5BX/UKgQD5p+cKuVSnjcsjda9M0afd4Y+hFKPDfTo2WnLL5N3L9wuIgkB1bFTqH
 VVaorXSJc6UXK8DojvvyF6yGV4924rogHqIIt8FdE3UIKexVw2Kqw6NyQa+55O+iYmY8
 eQExXhjBhUg8Cr68oZqiCeeUZyOctg2snyNHQI3mpz0edkYNyag4Jh2iKPP9EduVwR4w
 2N8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb5BQxGg59WM+VVvvoztMDyNmKJ/KUtRzk9O4hLgao6JxJWD9Jb0GxHGyoOW+sFKdkNL+mVnqkOqPypgV/XoE3l9Hy6nw=
X-Gm-Message-State: AOJu0Ywv/rfP2h+20rPVbvDDbRM6C1nIpmd3MVaV6YrdKhOls8wrhbXs
 Mc+HnZHsRVif/tSN2R9+q0YUraOUHewvijsJ1rFemjOG0SlJHrtsXJ5ItohadNh7ifZV6NFOtiL
 E
X-Google-Smtp-Source: AGHT+IFLsp+54jujpfagFV6LTppRhI5N3siXys7sb0xTGO6OiBCSiK6lJe2a6x4B+rLrybgFNV5p3w==
X-Received: by 2002:a05:6808:300f:b0:3da:bc74:e9d3 with SMTP id
 5614622812f47-3db10f5a0ebmr5391981b6e.17.1721951183691; 
 Thu, 25 Jul 2024 16:46:23 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead8128d0sm1647565b3a.118.2024.07.25.16.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:46:23 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH 00/24] riscv support for control flow integrity extensions
Date: Thu, 25 Jul 2024 16:45:49 -0700
Message-ID: <20240725234614.3850142-1-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=debug@rivosinc.com; helo=mail-oi1-x234.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Control flow integrity extensions (`zicfilp` and `zicfiss`) [1] for risc-v
are ratified. `zicfilp` protects forward control flow i.e. indirect function
call sites while `zicfiss` protects return control flow i.e. return from
functions which have spilled return addresses on stack.

This patchset is based on recent master with patch series from LIU (alibaba)
[4] which enables `zimop` and `zcmop` support in qemu. `zicfiss` has a dependency
on `zimop` and `zcmop`.

zicfilp
-------

On a very high level `zicfilp` extends risc-v architecture by introducing a
landing pad instruction `lpad` which must be target for every indirect branch
except when
       - rs1 == x1 || x5 (a return from a function)
       - rs1 == x7 (sw guarded branch)

If `lpad` is not present, cpu will raise software check exception (cause=18)
, introduced in privileged spec version 1.13. To track `expected landing pad`
state on every indirect branch, a new state is introduced in cpu `elp` short
for expected landing pad status and can be spilled into *status register if
a trap occurs between indirect branch and target instruction. `lpad` instr
is carved out of HINT space `auipc rd` with `rd==x0` and can have 20 bit
immediate (label_20bit) encoded in it. After an indirect branch lands on
`lpad` instruction, cpu performs following checks:

  -- If label_20bit == 0, no further check are performed.
  -- If label_20bit != 0, cpu evaluates (label_20bit == x7_upper_20bit)
     If above expression is evaluated to be false, cpu raises sw check
     exception.

Software can implement more finer-grained control flow using label mechanism
defined in `zicfilp` by ensuring x7 has appropriate label setup prior to
indirect call and thus further restraining call sites target locations.

zicfiss
-------

On a very high level `zicfiss` extends risc-v architecture by providing a
separate stack (called shadow stack) to store return addresses. Shadow stack
can be protected using a reserved PTE encoding (PTE.W=1, PTE.R=0, PTE.X=0).
Only shadow stack instructions can perform stores on shadow stack memory while
regular stores on such memory result in access faults. Shadow stack memory can
be read by regular load instructions. A new unprivileged csr `CSR_SSP` is
introduced which holds pointer to shadow stack for the execution environment.
To store return addresses on shadow stack, `sspush x1/x5` instruction is added.
`sspopchk x1/x5` instruction pops from top of shadow stack and compares it with
`x1/x5` and if there is a mismatch, cpu raises a software check exception.

riscv-gnu-toolchain changes [2] are required to test these changes on qemu-user
or on full blown linux guest using qemu-system. In order to test under qemu-system,
one will require relevant linux changes as well. I've tested linux (6.8) based on
current patches [3] and booted a rootfs compiled with cfi enabled toolchain to shell.
There're still some work going on to make it work with VDSO and multi-label scheme.
But none of those work is gate for these patches.

I would like to express my sincere thanks to all the community members in helping out.
Special shout out and acknowledgement to kito cheng, andy chiu, jim shu and jesse huang
from SiFive.

[1] - https://github.com/riscv/riscv-cfi
[2] - https://github.com/sifive/riscv-gnu-toolchain/tree/cfi-dev
[3] - https://lore.kernel.org/all/20240403234054.2020347-1-debug@rivosinc.com/
[4] - https://lore.kernel.org/all/20240709113652.1239-1-zhiwei_liu@linux.alibaba.com/#t


Deepak Gupta (24):
  target/riscv: Add zicfilp extension
  target/riscv: Introduce elp state and enabling controls for zicfilp
  target/riscv: save and restore elp state on priv transitions
  target/riscv: additional code information for sw check
  target/riscv: tracking indirect branches (fcfi) for zicfilp
  target/riscv: zicfilp `lpad` impl and branch tracking
  disas/riscv: enabled `lpad` disassembly
  linux-user/syscall: introduce prctl for indirect branch tracking
  linux-user/riscv: implement indirect branch tracking prctls
  target/riscv: Add zicfiss extension
  target/riscv: introduce ssp and enabling controls for zicfiss
  target/riscv: tb flag for shadow stack  instructions
  target/riscv: implement zicfiss instructions
  target/riscv: compressed encodings for sspush and sspopchk
  target/riscv: mmu changes for zicfiss shadow stack protection
  target/riscv: shadow stack mmu index for shadow stack instructions
  linux-user/syscall: introduce prctl for shadow stack enable/disable
  linux-user/riscv: setup/teardown zicfiss shadow stack for qemu-user
  disas/riscv: enable disassembly for zicfiss instructions
  disas/riscv: enable disassembly for compressed sspush/sspopchk
  target/riscv: add trace-hooks for each case of sw-check exception
  linux-user: permit RISC-V CFI dynamic entry in VDSO
  linux-user: Add RISC-V zicfilp support in VDSO
  linux-user/riscv: Adding zicfiss/lp extension in hwprobe syscall

 disas/riscv.c                           |  71 +++++++++-
 disas/riscv.h                           |   4 +
 linux-user/gen-vdso-elfn.c.inc          |   7 +
 linux-user/riscv/cpu_loop.c             |  50 +++++++
 linux-user/riscv/target_cpu.h           |   7 +
 linux-user/riscv/target_prctl.h         |  70 ++++++++++
 linux-user/riscv/vdso-64.so             | Bin 3944 -> 4128 bytes
 linux-user/riscv/vdso.S                 |  50 +++++++
 linux-user/syscall.c                    |  40 ++++++
 target/riscv/cpu.c                      |  21 +++
 target/riscv/cpu.h                      |  28 ++++
 target/riscv/cpu_bits.h                 |  23 ++++
 target/riscv/cpu_cfg.h                  |   2 +
 target/riscv/cpu_helper.c               | 166 +++++++++++++++++++++++-
 target/riscv/cpu_user.h                 |   1 +
 target/riscv/csr.c                      | 106 +++++++++++++++
 target/riscv/helper.h                   |   6 +
 target/riscv/insn16.decode              |   4 +
 target/riscv/insn32.decode              |  23 +++-
 target/riscv/insn_trans/trans_rva.c.inc |  55 ++++++++
 target/riscv/insn_trans/trans_rvi.c.inc |  52 ++++++++
 target/riscv/internals.h                |   4 +
 target/riscv/op_helper.c                |  63 +++++++++
 target/riscv/pmp.c                      |   5 +
 target/riscv/pmp.h                      |   3 +-
 target/riscv/tcg/tcg-cpu.c              |  20 +++
 target/riscv/trace-events               |   6 +
 target/riscv/translate.c                |  80 ++++++++++++
 28 files changed, 959 insertions(+), 8 deletions(-)

-- 
2.44.0


