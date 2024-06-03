Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A756C41513
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5go-0003Vq-Pu; Mon, 03 Jun 2024 07:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5gW-0003E2-RJ
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:17:05 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5gQ-00069Q-7X
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:17:04 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f4a0050b9aso26013055ad.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 04:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717413414; x=1718018214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bviNdrwZIbbeeF2mkZrjTDFfpm4CaLZkkoY3cNrHjHk=;
 b=CWPkLEI/Cn56pCcfom2ajTGA7cBn7SGhWINTQrdnCQuIpRsT5Y1p1A3SzR/K06kaee
 SZiJp5HIE0UOKpWx5ISAnBHsqtn+HyqZXpnso0cgc86ZfR0Cs68XUaRIksPlStcfC33c
 E297RazfTK/Qj2Dy3vNtX3xo4BS/DMnn1zsbaTuMQkwP4uoxAiDLLgOWf/0rLSr+N6fE
 kingmmlDJIcya0od1l8QapQf9E86YRax1ZRtXSC9PPPmGB84btYNqF47RgMdzYk/S2PO
 lLuGwJBWPS2HPqs+KCTARu/+iwV9aY3xuA7QJa2oX9DHUmkrscy79+F05HEJQILj4C9H
 Hrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717413414; x=1718018214;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bviNdrwZIbbeeF2mkZrjTDFfpm4CaLZkkoY3cNrHjHk=;
 b=T8R3R+wT0ey+QppQ8kgOHieK59gOzTGoXu1qirVfjiqMgNuDAab9xj9XaBlUaWZdN1
 F047aDxNIuau+lYVqOGuuJcQm09X4TefnbKGkePLyomhZ7xPSqK1ptJMVcv3emWhqmkJ
 aIyGnGI0e/XWEy+z8KfLcAa1TJDcDP4IdusxrTUfzG6ccL7H8acYPMD6Xm4yRlCnWPkq
 nfPScd8mpSYSiwn1KSsTI9VGQOZRhKCIJBbAkwuRQlssexxBseUksUqP9QRrxz8OL0q9
 U23sEK+0eHlZwrDolXkWFkhqzo2/Va+7HA0BS3CvLMANhVmOwRZ9ajauLSF/5zExo2dt
 7WRQ==
X-Gm-Message-State: AOJu0YzqhWqUarRAtO+21YuMzfI+5OvMlDRO7aG2BCajMIj/UZW45lFg
 sYtrPNpcR8qf/prLHTw6HOdpwlQDrpf3U7aHnn2daH83Bm2+iX67fjINmg==
X-Google-Smtp-Source: AGHT+IFPXPQPqF160L5t067HiWVfBIgSunSLRL9o6yOmZxO9fFr8/4mWFBthABidNJhtQpJr6/p5Yw==
X-Received: by 2002:a17:902:d2d2:b0:1f6:8552:c186 with SMTP id
 d9443c01a7336-1f68552c468mr8840575ad.35.1717413413551; 
 Mon, 03 Jun 2024 04:16:53 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323e18c7sm62375435ad.177.2024.06.03.04.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 04:16:53 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 00/27] riscv-to-apply queue
Date: Mon,  3 Jun 2024 21:16:16 +1000
Message-ID: <20240603111643.258712-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The following changes since commit 74abb45dac6979e7ff76172b7f0a24e869405184:

  Merge tag 'pull-target-arm-20240531' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-05-31 11:10:10 -0700)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20240603

for you to fetch changes up to 915758c537b5fe09575291f4acd87e2d377a93de:

  disas/riscv: Decode all of the pmpcfg and pmpaddr CSRs (2024-06-03 11:12:12 +1000)

----------------------------------------------------------------
RISC-V PR for 9.1

* APLICs add child earlier than realize
* Fix exposure of Zkr
* Raise exceptions on wrs.nto
* Implement SBI debug console (DBCN) calls for KVM
* Support 64-bit addresses for initrd
* Change RISCV_EXCP_SEMIHOST exception number to 63
* Tolerate KVM disable ext errors
* Set tval in breakpoints
* Add support for Zve32x extension
* Add support for Zve64x extension
* Relax vector register check in RISCV gdbstub
* Fix the element agnostic Vector function problem
* Fix Zvkb extension config
* Implement dynamic establishment of custom decoder
* Add th.sxstatus CSR emulation
* Fix Zvfhmin checking for vfwcvt.f.f.v and vfncvt.f.f.w instructions
* Check single width operator for vector fp widen instructions
* Check single width operator for vfncvt.rod.f.f.w
* Remove redudant SEW checking for vector fp narrow/widen instructions
* Prioritize pmp errors in raise_mmu_exception()
* Do not set mtval2 for non guest-page faults
* Remove experimental prefix from "B" extension
* Fixup CBO extension register calculation
* Fix the hart bit setting of AIA
* Fix reg_width in ricsv_gen_dynamic_vector_feature()
* Decode all of the pmpcfg and pmpaddr CSRs

----------------------------------------------------------------
Alexei Filippov (1):
      target/riscv: do not set mtval2 for non guest-page faults

Alistair Francis (2):
      target/riscv: rvzicbo: Fixup CBO extension register calculation
      disas/riscv: Decode all of the pmpcfg and pmpaddr CSRs

Andrew Jones (2):
      target/riscv/kvm: Fix exposure of Zkr
      target/riscv: Raise exceptions on wrs.nto

Cheng Yang (1):
      hw/riscv/boot.c: Support 64-bit address for initrd

Christoph Müllner (1):
      riscv: thead: Add th.sxstatus CSR emulation

Clément Léger (1):
      target/riscv: change RISCV_EXCP_SEMIHOST exception number to 63

Daniel Henrique Barboza (6):
      target/riscv/kvm: implement SBI debug console (DBCN) calls
      target/riscv/kvm: tolerate KVM disable ext errors
      target/riscv/debug: set tval=pc in breakpoint exceptions
      trans_privileged.c.inc: set (m|s)tval on ebreak breakpoint
      target/riscv: prioritize pmp errors in raise_mmu_exception()
      riscv, gdbstub.c: fix reg_width in ricsv_gen_dynamic_vector_feature()

Huang Tao (2):
      target/riscv: Fix the element agnostic function problem
      target/riscv: Implement dynamic establishment of custom decoder

Jason Chien (3):
      target/riscv: Add support for Zve32x extension
      target/riscv: Add support for Zve64x extension
      target/riscv: Relax vector register check in RISCV gdbstub

Max Chou (4):
      target/riscv: rvv: Fix Zvfhmin checking for vfwcvt.f.f.v and vfncvt.f.f.w instructions
      target/riscv: rvv: Check single width operator for vector fp widen instructions
      target/riscv: rvv: Check single width operator for vfncvt.rod.f.f.w
      target/riscv: rvv: Remove redudant SEW checking for vector fp narrow/widen instructions

Rob Bradford (1):
      target/riscv: Remove experimental prefix from "B" extension

Yangyu Chen (1):
      target/riscv/cpu.c: fix Zvkb extension config

Yong-Xuan Wang (1):
      target/riscv/kvm.c: Fix the hart bit setting of AIA

yang.zhang (1):
      hw/intc/riscv_aplic: APLICs should add child earlier than realize

 MAINTAINERS                                    |   1 +
 target/riscv/cpu.h                             |   7 ++
 target/riscv/cpu_bits.h                        |   2 +-
 target/riscv/cpu_cfg.h                         |   2 +
 target/riscv/helper.h                          |   1 +
 target/riscv/sbi_ecall_interface.h             |  17 +++
 target/riscv/tcg/tcg-cpu.h                     |  15 +++
 disas/riscv.c                                  |  65 +++++++++-
 hw/intc/riscv_aplic.c                          |   8 +-
 hw/riscv/boot.c                                |   4 +-
 target/riscv/cpu.c                             |  10 +-
 target/riscv/cpu_helper.c                      |  37 +++---
 target/riscv/csr.c                             |  20 +++-
 target/riscv/debug.c                           |   3 +
 target/riscv/gdbstub.c                         |   8 +-
 target/riscv/kvm/kvm-cpu.c                     | 157 ++++++++++++++++++++++++-
 target/riscv/op_helper.c                       |  11 ++
 target/riscv/tcg/tcg-cpu.c                     |  50 +++++---
 target/riscv/th_csr.c                          |  79 +++++++++++++
 target/riscv/translate.c                       |  31 +++--
 target/riscv/vector_internals.c                |  22 ++++
 target/riscv/insn_trans/trans_privileged.c.inc |   2 +
 target/riscv/insn_trans/trans_rvv.c.inc        |  46 +++++---
 target/riscv/insn_trans/trans_rvzawrs.c.inc    |  29 +++--
 target/riscv/insn_trans/trans_rvzicbo.c.inc    |  16 ++-
 target/riscv/meson.build                       |   1 +
 26 files changed, 543 insertions(+), 101 deletions(-)
 create mode 100644 target/riscv/th_csr.c

