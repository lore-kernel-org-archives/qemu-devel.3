Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAF9C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNY4-0001E3-FZ; Mon, 24 Aug 2026 01:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNXl-0001Bb-UJ
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:48:28 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNXg-0001d7-OG
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:48:25 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2cacb8416a1so25879235ad.1
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550495; x=1788155295; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yguHmMo+RWJPbQUNjFMKxdXtosiYs3OJLIg4c7psMLQ=;
 b=JN3wQU07K3VYZhLZLEL2ujvR1ZFohZgKoyRGOJohc42JyAk4ii5zcffZXna7nRNPgL
 W8lwaYFtxFijwk5Tm5npkkKDtFZjJWdPnxiZqImiM/H/H3OmLWAGYZazobDFblmE91jw
 RqMP/oY2M2QhCY01CfMGzYady8vdrIn85xMLk3YamWEcJKx8g/QrB9hZGeJNjAnsVoB8
 oo9yPEB3uEXOK2TnXPowS9JNAQ3bp1P91GXYaTwMnwzbAU3UdjFMDTNeJhSrUqVpyrXo
 +zWMizf8zd8lQPooG6Of7/BFVEF7sY9s8gS9Q79JcWlTKQQlvS1LuacIFZAiYArgBFdR
 foBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550495; x=1788155295;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yguHmMo+RWJPbQUNjFMKxdXtosiYs3OJLIg4c7psMLQ=;
 b=OyLO1q/SznHHQLvfmsNoEWNSwq1a2rNvKhc4edaLsz5Kb025WNjZJluzu0uML6NYWW
 rRSHO3HQmHzz97Tp2cOmhTsd2ZsvJUFD827DOtZc31TsovHjOWxpDvMneOo9k9tMwe8q
 qaquApgjVr4X1hjBMQtJ8293dtjdlw5SGqh5oxXyh8lEm3mS8E0u1V+Ql5bT9pf/u/nY
 eoC/L3Av737MhV2Wg6cGQa7kml7Xs3zaXVgUwHr4GSvJ6qWfS8yzf7L8cM5My4UfauKC
 cWX768VPZ8kyObZIE/AaB2BLHSZVwGtjGB+65X/OfUmQOWWiDXtlXRK+pM9bE68qlEXL
 oq7Q==
X-Gm-Message-State: AFuF++nTLtRzDFYlDl+bpEMV0oITTfZIQ4AK/obEzWGBtdpT4HByKzv2
 ISjf8QlsnWh+rrjAC832VnICA8BbcW76RZl6rppzLQ0gXEOlEafxWfWkGq95XA==
X-Gm-Gg: AR+sD10cGv/l7vtyLm3gOXGn1FWVpuelC99WlgSkiUleDr+RifY6eQTsgBbvgRP9UGt
 HzcyRafdypVimjX/XvGnTRTT5U9CzmDK9ht/ZI+NbSXEp9f4y5adHfZTQrh5gBON/pXAzyvQII/
 5mkSrrxJUiVNSv6FvEpg65BrDBilpXAEEuI6wgM6dhhqSD35K2AlxmvA0TKsPqM7Scn5jcY2TsH
 rS4iTMclLHVFrwntxB3/n8poAl/ujGQH0rFRWX/LlWWqNd+eHWU/45NW8VCCNteQxogzC/d4vcO
 8Mfc7Spz6jx9aoDCDudT5qmbcbs795amBbS1zIXB7SNsQFAlWg5dtbxQ5Sqb/RQVsMIZ32PCuoF
 qeMH0SGgT6EtCw/76YGOHrf6xK97X6b+t2mj1KyLuMwM0mxirlciz8lEYebInRVNcbdvyuvmsva
 4bYwURA0+NqqFCtyrJQVzaZclTBy2+8RnnQcapRn8doYIgBn8NS2UyP1xX3JdhaleKxZ8Gaxizo
 +ccmQ==
X-Received: by 2002:a17:90b:1b0b:b0:37f:e1b6:4c7d with SMTP id
 98e67ed59e1d1-395c35ac458mr37952106a91.6.1787550495419; 
 Sun, 23 Aug 2026 22:48:15 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.48.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:48:14 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 00/96] riscv-to-apply queue
Date: Mon, 24 Aug 2026 15:46:30 +1000
Message-ID: <20260824054806.2790041-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
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

The following changes since commit eea8fe61b8be8f3016e522e6af24924a0266ca95:

  Merge tag 'igvm-20260821-pull-request' of https://gitlab.com/kraxel/qemu into staging (2026-08-21 10:39:31 -0700)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20260824-1

for you to fetch changes up to 85d38315fd19cda7fcfec5350f27cdfa15742600:

  target/riscv/tcg: sret in virtual user mode raises virtual instruction exception (2026-08-24 13:01:48 +1000)

----------------------------------------------------------------
RISC-V PR for 11.1

* Fix IMSIC CSR write and add tests
* Parametrise debug trigger number
* Add 'svbare' satp-mode
* Fix RINTC PLIC context ID for KVM
* Avoid abort when reading vtype before env->xl is set
* Skip reset for KVM irqchip
* Skip FP/Vector sync on KVM_PUT_RUNTIME_STATE
* More FDT cleanups (PLIC)
* Make FCTL.BE in IOMMU read only 0
* Check DC.TC reserved bits in IOMMU
* Apply UXL WARL handling to vsstatus
* Set cmd_ill IOFENCE.C if rsvp bits are set in IOMMU
* Set RISCV_IOMMU_FQ_HDR_PV appropriately
* Report QEMU CPU archid as 42
* Check PMP before updating PTE
* Add the Tenstorrent Atlantis machine

----------------------------------------------------------------
A-Shehab (1):
      target/riscv: allow menvcfg/henvcfg LPE and SSE bits on RV32

Abhigyan Kumar (1):
      target/riscv: use SXL instead of MXL for read_sstatus

Andrew Jones (2):
      hw/riscv/riscv-iommu: fix U-bit check to apply only to leaf S/VS-stage PTEs
      hw/riscv/riscv-iommu: preserve requested perm in spa_fetch()

Chao Liu (1):
      tests/qtest: remove trace output from k230 watchdog test

Christian S. Lima (1):
      target/riscv/tcg: sret in virtual user mode raises virtual instruction exception

Frank Chang (7):
      target/riscv: Add Zicclsm CPU option and enable it for the eligible CPUs
      hw/riscv: sifive_u: Align ROM reset vector data
      target/riscv: Support raising misaligned exceptions for scalar loads/stores
      target/riscv: Support raising misaligned exceptions for floating-point loads/stores
      target/riscv: Support raising misaligned exceptions for vector loads/stores
      target/riscv: Expose Zicclsm as a CPU property and update RVA22U64 profile
      tests/tcg/riscv64: Add test for Zicclsm

Frédéric Pétrot (2):
      target/riscv: Fix sstatus update in rv128
      target/riscv: Allow UXL to be 3 in mstatus on rv128

Ivan Efremov (2):
      target/riscv: Fix seed CSR sign extension
      tests/qtest: Add seed CSR zero extension test

Joel Stanley (1):
      target/riscv: Restore register dump zero padding

Junze Cao (3):
      hw/misc: Add K230 DDR controller and PHY models
      hw/riscv: Connect K230 DDR controller and PHY models
      tests/qtest: Add K230 DDR controller tests

Max Chou (1):
      target/riscv: Fix PC sync in trans_sspopchk for CFI exception handling

Richard Henderson (52):
      disas/riscv: Move operand extractors earlier in file
      disas/riscv: Reduce rv_insn to uint32_t
      disas/riscv: Tidy dec initialization in disasm_inst
      disas/riscv: Pass rv_opcode_data pointer to decode_inst_operands
      disas/riscv: Pass rv_opcode_data pointer to/from decode_inst_decompress
      disas/riscv: Pass rv_opcode_data pointer to/from decode_inst_lift_pseudo
      disas/riscv: Pass rv_opcode_data pointer to format_inst
      disas/riscv: Tidy disasm_inst main loop
      disas/riscv: Set dec->opcode_data in decode function
      disas/riscv: Drop explicit zero of rv_opcode_data fields
      disas/riscv: Drop useless const in structures
      disas/riscv: Drop codec from rv_decode
      disas/riscv: Handle c.addi4spn imm != 0 during decode
      disas/riscv: Simplify c.addi
      disas/riscv: Handle c.lui imm != 0 during decode
      disas/riscv: Handle c.{srli,srai} imm during decode
      disas/riscv: Handle c.slli imm != 0 during decode
      disas/riscv: Do not recognize c.{addw, subw} with rv32
      disas/riscv: Remove rvcd_imm_nz
      disas/riscv: Unify decomp_rv{32,64,128}
      disas/riscv: Drop always true branch pseudos
      disas/riscv: Handle aliases of csrrw during decode
      disas/riscv: Handle aliases of csrrs during decode
      disas/riscv: Handle aliases of csrrwi during decode
      disas/riscv: Break pseudo loop for jal and jalr
      disas/riscv: Allow decode_inst_lift_pseudo to loop
      disas/riscv: Handle decompression via decode_inst_lift_pseudo
      disas/riscv: Drop format from DECOMP insns
      disas/riscv: Tidy rv_comp_data terminators
      disas/riscv: Chain "ret" pseudo off "jr" pseudo
      disas/riscv: Chain "nop" pseudo off "mv" pseudo
      disas/riscv: Use rv_codec_illegal for pseudos
      disas/riscv: Simplify some insn decompressions
      disas/riscv: Store op pointer in rv_comp_data
      disas/riscv: Return rv_opcode_data pointer from decoders
      disas/riscv: Skip post-processing of illegal insns
      disas/riscv: Reject all of OP-32 and OP-IMM-32 for RV32
      disas/riscv: Fix rv32 encoding of zext.h
      disas/riscv: Fix isa decoding of rev8
      disas/riscv: Fix typo in th.lbib format
      disas/riscv: Split ventana_opcode_data
      disas/riscv: Split xlrbr_opcode_data
      disas/riscv: Split xthead_opcode_data
      disas/riscv: Move rv_op_illegal to riscv.c
      disas/riscv: Split out riscv-op.c.inc
      disas/riscv: Merge all mop.r.n to one pattern
      disas/riscv: Merge all mop.rr.n to one pattern
      disas/riscv: Merge all c.mop.n to one pattern
      disas/riscv: Tidy decode of c.mop.n
      disas/riscv: Tidy decode of mop.r.n and mop.rr.n
      disas/riscv: Split rvi_opcode_data
      disas/riscv: Sort riscv-op.c.inc

TANG Tiancheng (5):
      disas/riscv: Fix th.srri decoding
      disas/riscv: Fix 6-bit immediate extraction
      disas/riscv: Use signed type for vector immediates
      disas/riscv: Decode unsigned vector immediates as unsigned
      disas/riscv: Use extract helpers for operand fields

Tao Ding (6):
      hw/dma: add K230 gsdma
      hw/riscv: k230: add gsdma in K230 board
      tests/qtest: add test for K230 gsdma
      hw/riscv: k230: add decomp gzip in K230 board
      tests/qtest: add test for K230 decomp gzip
      hw/riscv: k230: add a noc stub region in K230 board

Vladimir Isaev (2):
      riscv: csr: do not drop C bit on misa write
      tests/tcg/riscv64: add misa write test

Xie Bo (2):
      target/riscv/kvm: Synchronize privilege mode
      target/riscv/kvm: Preserve MP state across migration

Xu Liu (1):
      target/riscv: Make Zcmt JVT loads endian-aware

Yanfeng Liu (1):
      riscv/virt: Add optional UART1

Zeng Chi (1):
      target/riscv: Fix memory leak in riscv_trigger_unrealize()

Zephyr Li (1):
      target/riscv: do not count ECALL in minstret

wangyang (3):
      target/riscv: honor zicbo* envcfg gating in linux-user mode
      target/riscv: reject FMV.X.W/FMV.W.X under Zfinx
      target/riscv: enforce even register constraints for Zdinx fcvt pairs

 MAINTAINERS                                       |    9 +
 docs/system/riscv/k230.rst                        |    6 +
 docs/system/riscv/virt.rst                        |    5 +-
 disas/riscv-xlrbr.h                               |    4 +-
 disas/riscv-xthead.h                              |   24 +-
 disas/riscv-xventana.h                            |    4 +-
 disas/riscv.h                                     |   47 +-
 include/hw/dma/k230_gsdma.h                       |  130 +
 include/hw/misc/k230_ddr.h                        |   59 +
 include/hw/misc/k230_decomp_gzip.h                |   92 +
 include/hw/riscv/k230.h                           |    9 +
 include/hw/riscv/virt.h                           |    3 +
 target/riscv/cpu.h                                |    4 +
 target/riscv/cpu_bits.h                           |   10 +-
 target/riscv/kvm/kvm_riscv.h                      |    2 +-
 target/riscv/tcg/pmu.h                            |    1 +
 target/riscv/cpu_cfg_fields.h.inc                 |    2 +
 disas/riscv-xlrbr.c                               |   57 +-
 disas/riscv-xthead.c                              |  509 +-
 disas/riscv-xventana.c                            |   23 +-
 disas/riscv.c                                     | 5305 +++++++--------------
 hw/dma/k230_gsdma.c                               |  551 +++
 hw/misc/k230_ddr.c                                |  556 +++
 hw/misc/k230_decomp_gzip.c                        |  511 ++
 hw/riscv/k230.c                                   |   57 +-
 hw/riscv/riscv-iommu.c                            |   64 +-
 hw/riscv/sifive_u.c                               |   11 +-
 hw/riscv/virt-acpi-build.c                        |   12 +-
 hw/riscv/virt.c                                   |   40 +-
 target/riscv/cpu.c                                |   27 +-
 target/riscv/kvm/kvm-cpu.c                        |   62 +-
 target/riscv/machine.c                            |   49 +-
 target/riscv/tcg/csr.c                            |   72 +-
 target/riscv/tcg/debug.c                          |    2 +-
 target/riscv/tcg/op_helper.c                      |   26 +-
 target/riscv/tcg/pmu.c                            |   44 +-
 target/riscv/tcg/vector_helper.c                  |   65 +-
 target/riscv/tcg/zce_helper.c                     |    6 +-
 tests/qtest/k230-ddr-test.c                       |  226 +
 tests/qtest/k230-decomp-gzip-test.c               |  200 +
 tests/qtest/k230-gsdma-test.c                     |  201 +
 tests/qtest/k230-wdt-test.c                       |    2 +-
 tests/qtest/riscv-csr-test.c                      |   26 +
 disas/riscv-op.c.inc                              |  913 ++++
 disas/riscv-xlrbr-op.c.inc                        |    8 +
 disas/riscv-xthead-op.c.inc                       |  125 +
 disas/riscv-xventana-op.c.inc                     |    2 +
 target/riscv/tcg/insn_trans/trans_rvd.c.inc       |    6 +
 target/riscv/tcg/insn_trans/trans_rvf.c.inc       |   12 +-
 target/riscv/tcg/insn_trans/trans_rvi.c.inc       |    6 +
 target/riscv/tcg/insn_trans/trans_rvv.c.inc       |   18 +-
 target/riscv/tcg/insn_trans/trans_rvzfh.c.inc     |    8 +
 target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc |    2 +-
 hw/dma/Kconfig                                    |    3 +
 hw/dma/meson.build                                |    1 +
 hw/dma/trace-events                               |    6 +
 hw/misc/Kconfig                                   |    3 +
 hw/misc/meson.build                               |    2 +
 hw/misc/trace-events                              |    8 +-
 hw/riscv/Kconfig                                  |    2 +
 tests/qtest/meson.build                           |    3 +-
 tests/tcg/riscv64/Makefile.softmmu-target         |   30 +
 tests/tcg/riscv64/test-minstret-ecall.S           |   55 +
 tests/tcg/riscv64/test-misa-w.S                   |   88 +
 tests/tcg/riscv64/test-zicclsm.S                  |  368 ++
 65 files changed, 6481 insertions(+), 4303 deletions(-)
 create mode 100644 include/hw/dma/k230_gsdma.h
 create mode 100644 include/hw/misc/k230_ddr.h
 create mode 100644 include/hw/misc/k230_decomp_gzip.h
 create mode 100644 hw/dma/k230_gsdma.c
 create mode 100644 hw/misc/k230_ddr.c
 create mode 100644 hw/misc/k230_decomp_gzip.c
 create mode 100644 tests/qtest/k230-ddr-test.c
 create mode 100644 tests/qtest/k230-decomp-gzip-test.c
 create mode 100644 tests/qtest/k230-gsdma-test.c
 create mode 100644 disas/riscv-op.c.inc
 create mode 100644 disas/riscv-xlrbr-op.c.inc
 create mode 100644 disas/riscv-xthead-op.c.inc
 create mode 100644 disas/riscv-xventana-op.c.inc
 create mode 100644 tests/tcg/riscv64/test-minstret-ecall.S
 create mode 100644 tests/tcg/riscv64/test-misa-w.S
 create mode 100644 tests/tcg/riscv64/test-zicclsm.S

