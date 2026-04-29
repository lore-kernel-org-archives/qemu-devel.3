Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94ADFF8873
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwqN-0000wB-NU; Wed, 29 Apr 2026 00:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwqM-0000vh-TT
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:48:14 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwqK-00085K-P7
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:48:14 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2b2503753efso125112355ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438091; x=1778042891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pw/7xQB2WLUf+Xnc+nEPBhVxjL65zMCXkBpOO3m5mMY=;
 b=Hv76f2gZz/Y2/hIdN65rhgdGF7fyruvE5qSgvbaWpVML3sLcyBYifpBZOhIaf9Mj+e
 fyl5cI/x5t1J2FvcsFEt8CpKduFvUCZL72Q6zFFb/+ISnonHKrhKSzId+if7zVMozVXS
 1DieGzSvKvD4B2dJoNDlnka6S+rLKrfIon4h1u+dN5ba96uRKNBRxLJtEyJ5msSmc92W
 pz7fdFxSZ0D+smJzkEnATJf+XClwDwHiSRvv7YmBJ5qQhu3TYnTK1gwu4EryyWvNzdvI
 nbSrEoBW7KagqArONRj63lZdZx2rbsbffvoeStkuxFhmiOfPxPlFW1o27N8uTubO3ha3
 5Ubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438091; x=1778042891;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pw/7xQB2WLUf+Xnc+nEPBhVxjL65zMCXkBpOO3m5mMY=;
 b=e13cx9mzQs4RAzHxoa7A+ST6fbC73g4C5IAz7ZMyczjGQPYnV003H3MT5sTTpk8AeC
 t8Tuxr7uCcTsP8al1Ml23NJ4smFIuogGxXnzU85rWI8P2H2dj+tYYBOrcgL48siGuFuH
 a8UQaqPQggA5yQMOaCQ+lAXQJ6XDOktjFAA7zgJCLI6zvrGjutk8hZu3Y4r6A8t3ziAT
 Lrp4NlfgNca6v2stThsx2Off6woWkWVRtjBSmsMYpTj0L1v2dhzWK027j7VaqRdHMk8c
 Cj9lnt3PcX8rT2Ta4YxNepHjuwq82Hk6TQ6Dhz55jr9qXbog0RIxpPO4sBr7KO4N6Btw
 BAGw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+PraicwmgpoTovUZgZTmXN+0gBfdSU/W/Vj3/YT1z32hgi3a4CygV4WkQjonLz2MaOz8d5JXotGEBB@nongnu.org
X-Gm-Message-State: AOJu0YzShUGyNWHsnBXqQSzu+KQ2CBVyQXPCHIwHDSZko/AUMdPPQV+W
 N1VdvZDlWtyCmW5UBsRqrqtLAoSAiOdFHWHWIDwRsxfpu/jc9RF7KXnk
X-Gm-Gg: AeBDiesdLWzUFYqR4mBEngfvZdGcr271UvOEJLDaPOUFUSFnsXnxCwhCCZtFt1UMLVY
 eQ1y5T/QlIVzSbmPl4wDVeat6zLkZ89qcZp2+DK7uUzykbsIJiLw/NA7Odk55lcf+on4AsPX0rQ
 OkP0WXomu6/s28GO/vpY/bQ6VGI6pl6OMngcmmgT07VIiKCTWPwtDOA5cOTrQIs6VQbZuxpIy2v
 xl0h5uxKnQ5i4vGX4Rfj5865a3m0aUvkX3XgLEWPXpFdrXF8gnGy3vbthiVFic5mMMYcjNyV52n
 6CpwEAGjsbTaIPsqZ4nF7oaUEbcCyNmMjHgn0QYqP98G9eyPJl5EC/RuI2K0hBzkkI5afZCo9cF
 oRp+IiNH+M2O1+5QrO7ynA9KOdEIDMnKCpJ992zriJEGLkT3BgHB2F89n4+wTiWTlZpyyAPvrbu
 atETBPBQqPjVZXVaEexc8upuLo4/WfnaqGzw2i+VNM2pOTRjlpOSeI
X-Received: by 2002:a17:902:f546:b0:2b2:81aa:f6ba with SMTP id
 d9443c01a7336-2b97c4aa838mr60717285ad.26.1777438091056; 
 Tue, 28 Apr 2026 21:48:11 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:48:10 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/51] riscv-to-apply queue
Date: Wed, 29 Apr 2026 14:47:01 +1000
Message-ID: <20260429044752.4176397-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
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

The following changes since commit 759c456b1d22fe4083c8b384da27d3f56fd53f82:

  Merge tag 'linux-user-next-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-04-27 12:57:33 -0400)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20260429-1

for you to fetch changes up to 4d82676cfc6e14099d0e529445a5ee520752ebe5:

  target/riscv: rvv: Handle mask/source overlap of vector reduction instructions (2026-04-29 14:25:06 +1000)

----------------------------------------------------------------
RISC-V PR for 11.1.

* Use standard EN_PRI bit for PRI IOMMU
* Add draft RISC-V Zbr ext as xbr0p93
* Forbid to use legacy native endianness API
* Fix irq_overflow_left residual value bug in IOMMU
* Add IPSR.PMIP RW1C support to IOMMU
* Use kvm timer frequency when kvm enabled
* Fix stale ptshift and base on page walk restart
* Fix heap OOB in ACLINT MTIMER multi-socket
* Reject RISC-V HTIF invalid signature ranges
* Fix RV32 henvcfg/stateen CSR handling
* Add Zvfbfa extension support
* Allow fractional LMUL on vector SHA instructions
* Add Tenstorrent mvendorid
* Warn if a ELF format file is loaded as a binary
* Initialize riscv_excp_names[] and riscv_intr_names[] using designated initializer
* Mask xepc[0] only when Zc* extension is enabled
* Generate access fault if sc comparison fails
* Don't OR mip.SEIP when mvien is one
* Use ELEN for Fractional LMUL check
* Fix Zjpm implementation
* Handle mask/source overlap of vector reduction instructions

----------------------------------------------------------------
Alistair Francis (3):
      target/riscv: Generate access fault if sc comparison fails
      target/riscv: Don't OR mip.SEIP when mvien is one
      target/riscv: Use ELEN for Fractional LMUL check

Anton Blanchard (2):
      target/riscv: rvv: Allow fractional LMUL on vector SHA instructions
      target/riscv: rvv: Handle mask/source overlap of vector reduction instructions

Bruno Sa (2):
      target/riscv: preserve RV32 henvcfgh on henvcfg writes
      target/riscv: fix RV32 stateen CSR handling

Djordje Todorovic (1):
      target/riscv: Use MO_LE for instruction fetch

Emmanuel Blot (3):
      util: export CRC32[C] lookup tables
      target/riscv: add draft RISC-V Zbr ext as xbr0p93
      disas: diassemble RISC-V xlrbr (crc32) instructions

Frank Chang (7):
      target/riscv: Initialize riscv_excp_names[] and riscv_intr_names[] using designated initializer
      target/riscv: Mask xepc[0] only when Zc* extension is enabled
      target/riscv: Add a helper to return the current effective priv mode
      target/riscv: Fix pointer masking PMM field selection logic
      target/riscv: Fix pointer masking for virtual-machine load/store insns
      target/riscv: Rename riscv_pm_get_virt_pmm() to riscv_pm_get_vm_ldst_pmm()
      target/riscv: Fix pointer masking translation mode check bug

Frédéric Pétrot (2):
      target/riscv: Make LQ and SQ use 128-bit ld/st
      target/riscv: Remove MTTCG check for x-rv128 CPU model

Jay Chang (3):
      hw/riscv/riscv-iommu: Use standard EN_PRI bit for PRI
      hw/riscv/riscv-iommu-hpm: Fix irq_overflow_left residual value bug
      hw/riscv/riscv-iommu: Add IPSR.PMIP RW1C support

Joel Stanley (1):
      target/riscv: tt-ascalon: Add Tenstorrent mvendorid

Max Chou (9):
      target/riscv: Add cfg properties for Zvfbfa extensions
      target/riscv: Add the Zvfbfa extension implied rule
      target/riscv: rvv: Add new VTYPE CSR field - altfmt
      target/riscv: rvv: Introduce reset_ill_vtype to reset illegal vtype CSR
      target/riscv: Use the tb->cs_base as the extend tb flags
      target/riscv: Introduce altfmt into DisasContext
      target/riscv: Introduce BF16 canonical NaN for Zvfbfa extension
      target/riscv: rvv: Support Zvfbfa vector bf16 operations
      target/riscv: Expose Zvfbfa extension as a cpu property

Munkhbaatar Enkhbaatar (1):
      riscv_htif: reject invalid signature ranges (end <= begin)

Nicholas Piggin (1):
      hw/riscv/boot: Warn if a ELF format file is loaded as a binary

Philippe Mathieu-Daudé (12):
      target/riscv: Use explicit little-endian LD/ST API
      target/riscv: Explode MO_TExx -> MO_TE | MO_xx (again)
      target/riscv: Conceal MO_ALIGN|MO_TE within load_acquire / store_release
      target/riscv: Factor tiny ldn() helper in gdbstub
      target/riscv: Simplify riscv_cpu_gdb_write_register()
      target/riscv: Expose mo_endian_env()
      target/riscv: Have gdbstub consider CPU endianness
      target/riscv: Replace MO_TE by mo_endian (MIPS extension)
      target/riscv: Replace MO_TE by mo_endian (Zilsd extension)
      target/riscv: Replace MO_TE by mo_endian (Zalasr extension)
      target/riscv: Replace MO_TE -> MO_LE
      configs/targets: Forbid RISC-V to use legacy native endianness APIs

Sebastián Alba Vives (2):
      target/riscv: fix stale ptshift and base on page walk restart
      hw/intc: fix heap OOB in ACLINT MTIMER multi-socket

Yicong Yang (1):
      hw/riscv/virt-acpi-build.c: Use kvm timer frequency when kvm enabled

Yong-Xuan Wang (1):
      target/riscv: fix address masking

 MAINTAINERS                                  |   5 +-
 configs/targets/riscv32-linux-user.mak       |   1 +
 configs/targets/riscv32-softmmu.mak          |   1 +
 configs/targets/riscv64-bsd-user.mak         |   1 +
 configs/targets/riscv64-linux-user.mak       |   1 +
 configs/targets/riscv64-softmmu.mak          |   1 +
 disas/riscv-xlrbr.h                          |  19 +
 hw/riscv/riscv-iommu-bits.h                  |   1 +
 include/exec/translation-block.h             |   1 +
 include/qemu/crc32.h                         |  14 +
 include/qemu/crc32c.h                        |   1 +
 target/riscv/cpu.h                           |  48 +-
 target/riscv/cpu_cfg.h                       |   1 +
 target/riscv/cpu_vendorid.h                  |   2 +
 target/riscv/helper.h                        |  65 ++
 target/riscv/internals.h                     |  33 +-
 target/riscv/cpu_cfg_fields.h.inc            |   2 +
 target/riscv/xlrbr.decode                    |  30 +
 disas/riscv-xlrbr.c                          |  79 +++
 disas/riscv.c                                |   2 +
 hw/char/riscv_htif.c                         |   6 +
 hw/intc/riscv_aclint.c                       |  10 +-
 hw/riscv/boot.c                              |  23 +-
 hw/riscv/riscv-iommu-hpm.c                   |   1 +
 hw/riscv/riscv-iommu.c                       |  11 +-
 hw/riscv/virt-acpi-build.c                   |   7 +-
 target/riscv/bitmanip_helper.c               |  20 +
 target/riscv/cpu.c                           | 110 +--
 target/riscv/cpu_helper.c                    | 119 +++-
 target/riscv/csr.c                           | 135 +++-
 target/riscv/gdbstub.c                       |  42 +-
 target/riscv/op_helper.c                     |  28 +-
 target/riscv/tcg/tcg-cpu.c                   |  29 +-
 target/riscv/translate.c                     |  24 +-
 target/riscv/vector_helper.c                 | 398 ++++++++++-
 util/crc32.c                                 |  81 +++
 util/crc32c.c                                |   4 +-
 target/riscv/insn_trans/trans_rva.c.inc      |   6 +
 target/riscv/insn_trans/trans_rvi.c.inc      |  32 +-
 target/riscv/insn_trans/trans_rvv.c.inc      | 990 +++++++++++++++++----------
 target/riscv/insn_trans/trans_rvvk.c.inc     |   3 +-
 target/riscv/insn_trans/trans_rvzalasr.c.inc |  18 +-
 target/riscv/insn_trans/trans_xlrbr.c.inc    |  45 ++
 target/riscv/insn_trans/trans_xmips.c.inc    |  24 +-
 target/riscv/insn_trans/trans_zilsd.c.inc    |   4 +-
 disas/meson.build                            |   3 +-
 target/riscv/meson.build                     |   1 +
 tests/tcg/riscv64/Makefile.softmmu-target    |   5 +
 tests/tcg/riscv64/test-crc32.S               |  64 ++
 util/meson.build                             |   1 +
 50 files changed, 1922 insertions(+), 630 deletions(-)
 create mode 100644 disas/riscv-xlrbr.h
 create mode 100644 include/qemu/crc32.h
 create mode 100644 target/riscv/xlrbr.decode
 create mode 100644 disas/riscv-xlrbr.c
 create mode 100644 util/crc32.c
 create mode 100644 target/riscv/insn_trans/trans_xlrbr.c.inc
 create mode 100644 tests/tcg/riscv64/test-crc32.S

