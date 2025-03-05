Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F274EC282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdwm-0001Ir-6D; Tue, 04 Mar 2025 20:53:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdwl-0001IO-0P
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:53:19 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdwi-0008Jb-Re
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:53:18 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso2319995ad.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139595; x=1741744395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qgX/n0piG4DRG+20BxbFUYvF8sAC4yVFH9CcmbgKov8=;
 b=XeWhn0JNUtHF2NdlivqlW4UH4wK9uvJCUXhA93oCKQs3e0OwclkWvbQQPqqSr6eY+A
 Uwqd1AXWNmt3f1AEzUATnYr7G+yAOkXsXJsovHlvLIWHiHA+5Jt3vJZx4Yklfskxhjrm
 2lgEy/lxX+8+n0qhZAB9fVABB4Rq6MS+EElCDB8JtoOEzaURWQMj39BrNygoiqhKrTJw
 /CQbmbSH0MVWQm89UWLnrWp1uAsI1dB/yxM2ZubNdImr2fkFKNzNd+FO4uXYZXEZsfZ1
 +i1Mt/GyF/RdxUzMBL0TeQj3isT0YDNdjdghd5+aSU6b4AAR3ZGxGKtbuXro2Jne71DD
 mH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139595; x=1741744395;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qgX/n0piG4DRG+20BxbFUYvF8sAC4yVFH9CcmbgKov8=;
 b=ZmM9Bt3aTIGgaPlvMwkPqmMK/EE6Mklrj1BmadR7KdiCTchuPeGvWxG+24QzbedmNt
 RTV67lK1rxWva/8qPBoDF58UdcQfzqrYEjiKaZ29DBdh/LwQ+egfNEA7rzOLqZiGnw5h
 a/2g3ydkObxefxgn4giDtJd/3DLDMEC016rVxmqKwteGGm5wkZOzlmm6xO/94pRKOVaO
 uruXPuHLLSoyAvXMXzF2VHemY1y+eTlpZ/mmMw4knnyWIrLclwlPPiFMx3EKmdxTRutJ
 tB6JqwkAVlPzb/h9MwKH/a+P0Yxr7hTgQSgJQGG1u+H5NYAN/NeY6VIV5igbnbq9yiMZ
 EDZg==
X-Gm-Message-State: AOJu0YyxVWG3BYM3BGkd2/V7UeKDFQkAOX86Z7o1ykEKr+U1Smxcpdsi
 hW0hTlYo32b+QAHBOj+0VwAAo9yG6SSua71j3+0sdrCMPcDgbOOoqogUQlb3y4U=
X-Gm-Gg: ASbGnctxrBkC9mWJYH+eBD/k1ilal54lX15mCwbIAotGyVmjQ+OAFSKRS8zJwOcOKGs
 rLlSNkmHLyqUYbW7+2xxErxX3HRpv4aDkzlwSw2bDnp1gPYRv9tYE48hMcgAgcS5jJMO1ylfa8w
 IFBCDyBgu9FKGGrGHAONgj1s/dGVJD91QJxpqVmJWb1yoImfK1mjfZruQm9d9vGSxeIXqcpvTr/
 YBffJVFufQQ3dBio422QgI9hp93UiEF2z8js20JGlkMrs10qzEcWpjmxSlkRcKhI1jM/gMyJ7Pg
 7qokhay35kLLHglICk8KgAbIi/GIqtLs8i/y6fhSY1WkVhYKHbvrilThn3Xb+HO4YGn3qOLr0fc
 HlUe1kZhpYtQ/Bemz8o0dFsNbvddIeHU7hb7rNdBAaEDMUjkjGO8=
X-Google-Smtp-Source: AGHT+IGv3d3QvXHag+X+QsxGo2TZp0zO2kBh/PVhxwW1e/PBwLSoL2jJ5SPYRQddEvOBWElN2guDUw==
X-Received: by 2002:a17:903:2451:b0:220:fffc:7296 with SMTP id
 d9443c01a7336-223f1d26c99mr22313755ad.6.1741139594573; 
 Tue, 04 Mar 2025 17:53:14 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.53.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:53:13 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/59] riscv-to-apply queue
Date: Wed,  5 Mar 2025 11:52:08 +1000
Message-ID: <20250305015307.1463560-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
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

The following changes since commit 661c2e1ab29cd9c4d268ae3f44712e8d421c0e56:

  scripts/checkpatch: Fix a typo (2025-03-04 09:30:26 +0800)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20250305-1

for you to fetch changes up to 4db19d5b21e058e6eb3474b6be470d1184afaa9e:

  target/riscv/kvm: add missing KVM CSRs (2025-03-04 15:42:54 +1000)

----------------------------------------------------------------
Third RISC-V PR for 10.0

* CSR coverity fixes
* Fix unexpected behavior of vector reduction instructions when vl is 0
* Fix incorrect vlen comparison in prop_vlen_set
* Throw debug exception before page fault
* Remove redundant "hart_idx" masking from APLIC
* Add support for Control Transfer Records Ext
* Remove redundant struct members from the IOMMU
* Remove duplicate definitions from the IOMMU
* Fix tick_offset migration for Goldfish RTC
* Add serial alias in virt machine DTB
* Remove Bin Meng from RISC-V maintainers
* Add support for Control Transfer Records Ext
* Log guest errors when reserved bits are set in PTEs
* Add missing Sdtrig disas CSRs
* Correct the hpmevent sscofpmf mask
* Mask upper sscofpmf bits during validation
* Remove warnings about Smdbltrp/Smrnmi being disabled
* Respect mseccfg.RLB bit for TOR mode PMP entry
* Update KVM support to Linux 6.14-rc3
* IOMMU HPM support
* Support Sscofpmf/Svade/Svadu/Smnpm/Ssnpm extensions in KVM
* Add --ignore-family option to binfmt
* Refinement for AIA with KVM acceleration
* Reset time changes for KVM

----------------------------------------------------------------
Alistair Francis (1):
      MAINTAINERS: Remove Bin Meng from RISC-V maintainers

Andrea Bolognani (3):
      binfmt: Shuffle things around
      binfmt: Normalize host CPU architecture
      binfmt: Add --ignore-family option

Atish Patra (2):
      target/riscv: Fix the hpmevent mask
      target/riscv: Mask out upper sscofpmf bits during validation

Clément Léger (1):
      target/riscv: remove warnings about Smdbltrp/Smrnmi being disabled

Daniel Henrique Barboza (22):
      target/riscv/csr.c: fix deadcode in rmw_xireg()
      target/riscv/csr.c: fix 'ret' deadcode in rmw_xireg()
      target/riscv/csr.c: fix deadcode in rmw_xiregi()
      target/riscv/csr.c: fix deadcode in aia_smode32()
      target/riscv/cpu_helper.c: fix bad_shift in riscv_cpu_interrupt()
      target/riscv/debug.c: use wp size = 4 for 32-bit CPUs
      target/riscv: throw debug exception before page fault
      target/riscv: add ssu64xl
      target/riscv: use RVB in RVA22U64
      target/riscv: add profile u_parent and s_parent
      target/riscv: change priv_ver check in validate_profile()
      target/riscv: add RVA23U64 profile
      target/riscv: add RVA23S64 profile
      linux-headers: Update to Linux v6.14-rc3
      target/riscv/cpu.c: create flag for ziccrse
      target/riscv/kvm: add extensions after 6.14-rc3 update
      hw/riscv/riscv-iommu.h: add missing headers
      hw/riscv: add IOMMU HPM trace events
      docs/specs/riscv-iommu.rst: add HPM support info
      target/riscv/cpu: remove unneeded !kvm_enabled() check
      target/riscv/kvm: add kvm_riscv_reset_regs_csr()
      target/riscv/kvm: add missing KVM CSRs

Huang Borong (1):
      hw/intc/riscv_aplic: Remove redundant "hart_idx" masking

Jason Chien (2):
      hw/riscv/riscv-iommu: Remove redundant struct members
      hw/riscv/riscv-iommu-bits: Remove duplicate definitions

Max Chou (2):
      target/riscv: rvv: Fix unexpected behavior of vector reduction instructions when vl is 0
      target/riscv: rvv: Fix incorrect vlen comparison in prop_vlen_set

Quan Zhou (1):
      target/riscv/kvm: Add some exts support

Rajnesh Kanwal (7):
      target/riscv: Remove obsolete sfence.vm instruction
      target/riscv: Add Control Transfer Records CSR definitions.
      target/riscv: Add support for Control Transfer Records extension CSRs.
      target/riscv: Add support to record CTR entries.
      target/riscv: Add CTR sctrclr instruction.
      target/riscv: machine: Add Control Transfer Record state description
      target/riscv: Add support to access ctrsource, ctrtarget, ctrdata regs.

Rob Bradford (3):
      disas/riscv: Fix minor whitespace issues
      disas/riscv: Add missing Sdtrig CSRs
      target/riscv: Respect mseccfg.RLB bit for TOR mode PMP entry

Rodrigo Dias Correa (1):
      goldfish_rtc: Fix tick_offset migration

Tomasz Jeznach (8):
      hw/riscv/riscv-iommu-bits.h: HPM bits
      hw/riscv/riscv-iommu: add riscv-iommu-hpm file
      hw/riscv/riscv-iommu: add riscv_iommu_hpm_incr_ctr()
      hw/riscv/riscv-iommu: instantiate hpm_timer
      hw/riscv/riscv-iommu: add IOCOUNTINH mmio writes
      hw/riscv/riscv-iommu: add IOHPMCYCLES mmio write
      hw/riscv/riscv-iommu: add hpm events mmio write
      hw/riscv/riscv-iommu.c: add RISCV_IOMMU_CAP_HPM cap

Vasilis Liaskovitis (1):
      hw/riscv/virt: Add serial alias in DTB

Yong-Xuan Wang (3):
      hw/intc/imsic: refine the IMSIC realize
      hw/intc/aplic: refine the APLIC realize
      hw/intc/aplic: refine kvm_msicfgaddr

julia (1):
      target/riscv: log guest errors when reserved bits are set in PTEs

 MAINTAINERS                                        |   5 +-
 docs/specs/riscv-iommu.rst                         |   2 +
 hw/riscv/riscv-iommu-bits.h                        |  69 +++-
 hw/riscv/riscv-iommu-hpm.h                         |  33 ++
 hw/riscv/riscv-iommu.h                             |  32 +-
 include/standard-headers/linux/ethtool.h           |   4 +
 include/standard-headers/linux/fuse.h              |  76 +++-
 include/standard-headers/linux/input-event-codes.h |   1 +
 include/standard-headers/linux/pci_regs.h          |  16 +-
 include/standard-headers/linux/virtio_pci.h        |  14 +
 linux-headers/asm-arm64/kvm.h                      |   3 -
 linux-headers/asm-loongarch/kvm_para.h             |   1 +
 linux-headers/asm-riscv/kvm.h                      |   7 +-
 linux-headers/asm-x86/kvm.h                        |   1 +
 linux-headers/linux/iommufd.h                      |  35 +-
 linux-headers/linux/kvm.h                          |   8 +-
 linux-headers/linux/stddef.h                       |  13 +-
 linux-headers/linux/vduse.h                        |   2 +-
 target/riscv/cpu-qom.h                             |   2 +
 target/riscv/cpu.h                                 |  16 +-
 target/riscv/cpu_bits.h                            | 150 +++++++-
 target/riscv/cpu_cfg.h                             |   5 +
 target/riscv/helper.h                              |   2 +
 target/riscv/insn32.decode                         |   2 +-
 disas/riscv.c                                      |  16 +-
 hw/intc/riscv_aplic.c                              |  74 ++--
 hw/intc/riscv_imsic.c                              |  47 +--
 hw/riscv/riscv-iommu-hpm.c                         | 381 +++++++++++++++++++++
 hw/riscv/riscv-iommu.c                             | 131 ++++++-
 hw/riscv/virt.c                                    |   3 +
 hw/rtc/goldfish_rtc.c                              |  43 +--
 target/riscv/cpu.c                                 | 115 ++++++-
 target/riscv/cpu_helper.c                          | 315 ++++++++++++++++-
 target/riscv/csr.c                                 | 318 +++++++++++++++--
 target/riscv/debug.c                               |   6 +-
 target/riscv/kvm/kvm-cpu.c                         |  40 ++-
 target/riscv/machine.c                             |  25 ++
 target/riscv/op_helper.c                           |  48 +++
 target/riscv/pmp.c                                 |   2 +-
 target/riscv/pmu.c                                 |   2 +-
 target/riscv/tcg/tcg-cpu.c                         |  58 +++-
 target/riscv/translate.c                           |  46 +++
 target/riscv/vector_helper.c                       |   8 +-
 target/riscv/insn_trans/trans_privileged.c.inc     |  18 +-
 target/riscv/insn_trans/trans_rvi.c.inc            |  75 ++++
 target/riscv/insn_trans/trans_rvzce.c.inc          |  21 ++
 hw/riscv/meson.build                               |   3 +-
 hw/riscv/trace-events                              |   5 +
 scripts/qemu-binfmt-conf.sh                        |  78 +++--
 tests/data/acpi/riscv64/virt/RHCT                  | Bin 390 -> 400 bytes
 50 files changed, 2106 insertions(+), 271 deletions(-)
 create mode 100644 hw/riscv/riscv-iommu-hpm.h
 create mode 100644 hw/riscv/riscv-iommu-hpm.c

