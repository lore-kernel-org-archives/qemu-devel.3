Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537DAC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 02:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBmom-0001rY-Qd; Mon, 27 May 2024 22:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmol-0001r0-GQ
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:44:03 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmoi-0003gX-HY
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:44:02 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f480624d0dso2908735ad.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 19:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716864239; x=1717469039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0au88dFlvu8PVDYQiLNbEib2q/sUA/+eR1SVg3DawLE=;
 b=HIuAGNvfq2WZAlQ9zEdDSINm/92HJpO/BPDetUDgITDG5ZqRiMqe9tSuV9m1ndCJot
 IRa2QzOgxP1lzbTqx/z5CrgxkrgV51nxkNKp49pU6L8DHx444T2QO7YFBguOincBFcI0
 tl5qC+A9FMiCBGcN+qDGlOxvCAcZ/yKWhjwwR6jUuHj//xFo/q/fyfYW6Q2G92P8Tg4D
 MUIx01YgtKYvr/g6lecdEH0R+KAaWApZ6iU989u4jMbt7fV08g9m8soG928anwOuIG32
 5ma9rVj61bbVAm5W1rga96aDK2QMEVcLKPm6KhMsyyzV9twd9WW1OwT2deHu2PhMSuRO
 nFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716864239; x=1717469039;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0au88dFlvu8PVDYQiLNbEib2q/sUA/+eR1SVg3DawLE=;
 b=dj9Orb5LMXSydKdTh4IvLef4wo/CooAZDtMDilHU3UKM1EuFVDksr6GHmyeyR4BAV4
 NtkylTu5MBGUUnN4346uA+k7U7ji6kP+2G3jl82YXfNm67VhueNNazjrmZgNntgdW5YV
 pjrxls79+Pj1pOPSv704nbSerDaemrE9s2jWkkny8jcbRrq5mBgcEr4Hu1VXF2TCKkpi
 5ahlw5+vrlnXPlvNSpnDlLeKarxXoUg+U8sEa+WrnCUOnJT8idDFpmnHF5oeHgk/6eWR
 hRfSeSGZVpC6VDxDixTq/CNmIh/Ik6zUyDmmMI1qSSpWUJRiLCew+hI6N8DweXKQtegw
 etTA==
X-Gm-Message-State: AOJu0Yy+m3wyDM+No7nB+hJCl/PvAiZsd+bZ2Tx0DtXEbJOnnQSXaPG9
 WDbQcn45S2MTIKACcnEvZ5WyKYTEgD46IDugLIftyHYZCL3Fe5FuoIhg7Q==
X-Google-Smtp-Source: AGHT+IFuSJzOKLErLe7S4mi7TAwcqEsU3Lw9rlRRexrkycoohhD84seeiIKgbe1bF8kQ5vMi1EVeEw==
X-Received: by 2002:a17:902:cecd:b0:1f3:4225:bb79 with SMTP id
 d9443c01a7336-1f4486c5624mr170470885ad.2.1716864238607; 
 Mon, 27 May 2024 19:43:58 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c970ca0sm70733225ad.142.2024.05.27.19.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 19:43:57 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/28] riscv-to-apply queue
Date: Tue, 28 May 2024 12:43:00 +1000
Message-ID: <20240528024328.246965-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The following changes since commit ad10b4badc1dd5b28305f9b9f1168cf0aa3ae946:

  Merge tag 'pull-error-2024-05-27' of https://repo.or.cz/qemu/armbru into staging (2024-05-27 06:40:42 -0700)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20240528

for you to fetch changes up to 1806da76cb81088ea026ca3441551782b850e393:

  target/riscv: raise an exception when CSRRS/CSRRC writes a read-only CSR (2024-05-28 12:20:27 +1000)

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
* Raise an exception when CSRRS/CSRRC writes a read-only CSR

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

Yu-Ming Chang (1):
      target/riscv: raise an exception when CSRRS/CSRRC writes a read-only CSR

yang.zhang (1):
      hw/intc/riscv_aplic: APLICs should add child earlier than realize

 MAINTAINERS                                    |   1 +
 target/riscv/cpu.h                             |  11 ++
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
 target/riscv/csr.c                             |  71 +++++++++--
 target/riscv/debug.c                           |   3 +
 target/riscv/gdbstub.c                         |   8 +-
 target/riscv/kvm/kvm-cpu.c                     | 157 ++++++++++++++++++++++++-
 target/riscv/op_helper.c                       |  17 ++-
 target/riscv/tcg/tcg-cpu.c                     |  50 +++++---
 target/riscv/th_csr.c                          |  79 +++++++++++++
 target/riscv/translate.c                       |  31 +++--
 target/riscv/vector_internals.c                |  22 ++++
 target/riscv/insn_trans/trans_privileged.c.inc |   2 +
 target/riscv/insn_trans/trans_rvv.c.inc        |  46 +++++---
 target/riscv/insn_trans/trans_rvzawrs.c.inc    |  29 +++--
 target/riscv/insn_trans/trans_rvzicbo.c.inc    |  16 ++-
 target/riscv/meson.build                       |   1 +
 26 files changed, 596 insertions(+), 109 deletions(-)
 create mode 100644 target/riscv/th_csr.c

