Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF156C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 10:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Mrs-0007Go-IK; Thu, 17 Apr 2025 06:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u5Mrl-0007EX-AX
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:53:09 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u5Mri-0003F2-Q8
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:53:09 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-736b98acaadso558571b3a.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 03:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744887184; x=1745491984; darn=nongnu.org;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lzKpgeqR4fqb0La7VqTwMdcnh2eNwttopn7tCkVVrIE=;
 b=dZ7pB5r/2UbCwJdGXh49fgl1LU8AJpLQHwYQs+9etDSLj6iNMsludWtny7sMReyyEq
 Ko0h+9Mx2nDZxVVroec3EZ/aOFYU2WBrZRxmjRNIeYvhpWmKP9+KSNkXYOLsOIdVvpyO
 wisnzzjzK3gwmTkrUSuCWwCBYIzYbpcS/ca0ytnEiVNkToq9JWOwkAM1otRaeNG62IvN
 nfi9PkpES3ToMKX4kV7vDVTE4hG9etHTniJH/l3G2dPlGh1nv14+QAjB1S1tyYtJ2Ovd
 lmdqLTKtmCvjqdT0ocpDoKscWpsKzUyxheGDoctJqZbQxWLMEVVtxkHfaqXVYTIEqFtc
 MWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744887184; x=1745491984;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lzKpgeqR4fqb0La7VqTwMdcnh2eNwttopn7tCkVVrIE=;
 b=oaLVGq9YtZladtDUYGp5drk9p1kuWZTOWDpng1bC8B5y3uurXJ0ztEHVhoH9dm4N38
 yZHaI4TvTszev6k2vrO4v67hdoDfuzh94FbXujYbZRMH9i4K5kR26bOZed0MlDj3l9Kt
 V5gx8sIIJpaf3Ycjl6V7Te+lJDCKxXSSZ1Cxwmiup1DkT/ijbYIJ/QAG1f5a/BUgjuzS
 aDK7MjKImkVuUFofsYp/GKf2DfTjLFUmu8lEfY0JZbOlpjRPZhpu4D55c795yq2h1fJo
 GaCa+vdm7plNyh1PAxHBuJpYEyohUEGJ/5J5RwJjhgwObXqgj5UYarCWkyJka8aKRHSR
 v86w==
X-Gm-Message-State: AOJu0Yxa/uf7dHTX4ANF+LplNx+d6pnFiqJiECl2lC9FPtHlnEBmAhAB
 B0jIy8bW3p1wXxVzxTquABvPSJr7ax0Rk4/9v5iK8bOknOQCc7nnEVwE/tjvPhDSKm0+mw9hDMx
 1LoyxTDzmboOeOHvxbaNBkxrypE3qwLmr9i/uVzxHXD2w9V4HkuEE+MBOSyCPP6nczsJxt9i7bn
 7itEf+PzOVkHbATDPKXReKSEebWqVo1haxMA==
X-Gm-Gg: ASbGncv3gHaZ3s8QMsm0pFhZpWBJGjolOlVaR4dNT9A3ZM56Hs/z0h3ZUbZgFwQYhwa
 tBQKFsDpzQEfmBUeq7QuAX2xolwWLEH9MJBErOrCVjmOESENceuLFS8+2H5oVCOVPErlaES+fWh
 s762ujmyUaOntZdg6uGJrZInRdkVeRe0c8H03N88eVLrgGx165Lcpen3IpU5R1tMPx3QYw0XX7a
 +za50noQuhtRunhBj4tmv1SghJ9CffV/JwTiNmaREckP4QugS9oH4mN8sqbB9hMLGvh+Dzlwrer
 dBPNToVNgPTJIl046ziC9Q20GAX5yxErozYyQ/CZz4hp01SOfPHLb+v4qBPpNIc=
X-Google-Smtp-Source: AGHT+IHrzDlXhc6gVN4UXa/drR+YxSgFVwbZ5+Vwfao1KqvjZdbfyBoQ7EM7kjdi3Fc/RgAIJUlzVw==
X-Received: by 2002:a05:6a21:3181:b0:1f5:790c:947 with SMTP id
 adf61e73a8af0-203b3ee3a10mr7187435637.19.1744887183942; 
 Thu, 17 Apr 2025 03:53:03 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230ddaasm12366251b3a.138.2025.04.17.03.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 03:53:03 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v2 00/18] Implements RISC-V WorldGuard extension v0.4
Date: Thu, 17 Apr 2025 18:52:31 +0800
Message-Id: <20250417105249.18232-1-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This patchset implements Smwg/Smwgd/Sswg CPU extension and wgChecker
device defined in WorldGuard spec v0.4.

The WG v0.4 spec could be found here:
https://lists.riscv.org/g/security/attachment/711/0/worldguard_rvia_spec-v0.4.pdf

To enable WG in QEMU, pass "wg=on" as machine parameter to virt machine.
It enables both WG CPU CSRs to apply WID of CPU and wgCheckers on
the DRAM, FLASH, and UART to protect these resources.

This patchset contains 5 parts:

1. Commit  1 ~ 2: Bugfix of IOMMUMemoryRegion
2. Commit  3 ~ 4: Extend IOMMUMemoryRegion and MemTxAttr for WG support
3. Commit  5 ~ 13: Add WG global device and CPU extensions
4. Commit 14 ~ 17: Add WG checker device
5. Commit 18: Add WG support to the virt machine

QEMU code can be found at [1]

[1] https://github.com/cwshu/qemu/tree/riscv-wg-v2

Changed since v1:
- Remove the assertion of 4k sections limitation. Remove
  iotlb_to_section() and rename 'xlat_section' to 'xlat'.
- Fix RST issue and typo in virt machine doc

Changed since RFCv1:
- Rebase to latest QEMU (v10.0.0-rc3)
- Add the description of HW config and CPU option of WG in the
  virt machine documentation
- Expose CPU options of WG after WG CPU code has been implemented
- Change 'mwid' and 'mwidlist' options to experimental options
- Change 'world_id' to unsigned int type + bit field.

Jim Shu (18):
  accel/tcg: Store section pointer in CPUTLBEntryFull
  system/physmem: Remove the assertion of page-aligned section number
  accel/tcg: memory access from CPU will pass access_type to IOMMU
  exec: Add RISC-V WorldGuard WID to MemTxAttrs
  hw/misc: riscv_worldguard: Add RISC-V WorldGuard global config
  target/riscv: Add CPU options of WorldGuard CPU extension
  target/riscv: Add hard-coded CPU state of WG extension
  target/riscv: Add defines for WorldGuard CSRs
  target/riscv: Allow global WG config to set WG CPU callbacks
  target/riscv: Implement WorldGuard CSRs
  target/riscv: Add WID to MemTxAttrs of CPU memory transactions
  target/riscv: Expose CPU options of WorldGuard
  hw/misc: riscv_worldguard: Add API to enable WG extension of CPU
  hw/misc: riscv_wgchecker: Implement RISC-V WorldGuard Checker
  hw/misc: riscv_wgchecker: Implement wgchecker slot registers
  hw/misc: riscv_wgchecker: Implement correct block-access behavior
  hw/misc: riscv_wgchecker: Check the slot settings in translate
  hw/riscv: virt: Add WorldGuard support

 accel/tcg/cputlb.c                   |   49 +-
 docs/system/riscv/virt.rst           |   20 +
 hw/misc/Kconfig                      |    3 +
 hw/misc/meson.build                  |    1 +
 hw/misc/riscv_wgchecker.c            | 1160 ++++++++++++++++++++++++++
 hw/misc/riscv_worldguard.c           |  272 ++++++
 hw/misc/trace-events                 |    9 +
 hw/riscv/Kconfig                     |    1 +
 hw/riscv/virt.c                      |  163 +++-
 include/exec/cputlb.h                |   13 +-
 include/exec/exec-all.h              |   18 +-
 include/exec/memattrs.h              |    8 +-
 include/hw/core/cpu.h                |   12 +-
 include/hw/misc/riscv_worldguard.h   |  123 +++
 include/hw/riscv/virt.h              |   15 +-
 system/physmem.c                     |   39 +-
 target/alpha/helper.c                |    2 +-
 target/avr/helper.c                  |    2 +-
 target/hppa/mem_helper.c             |    1 -
 target/i386/tcg/system/excp_helper.c |    3 +-
 target/loongarch/tcg/tlb_helper.c    |    2 +-
 target/m68k/helper.c                 |   10 +-
 target/microblaze/helper.c           |    8 +-
 target/mips/tcg/system/tlb_helper.c  |    4 +-
 target/openrisc/mmu.c                |    2 +-
 target/ppc/mmu_helper.c              |    2 +-
 target/riscv/cpu.c                   |   17 +-
 target/riscv/cpu.h                   |   12 +
 target/riscv/cpu_bits.h              |    5 +
 target/riscv/cpu_cfg.h               |    5 +
 target/riscv/cpu_helper.c            |   69 +-
 target/riscv/csr.c                   |  107 +++
 target/riscv/tcg/tcg-cpu.c           |   11 +
 target/rx/cpu.c                      |    3 +-
 target/s390x/tcg/excp_helper.c       |    2 +-
 target/sh4/helper.c                  |    2 +-
 target/sparc/mmu_helper.c            |    6 +-
 target/tricore/helper.c              |    2 +-
 target/xtensa/helper.c               |    3 +-
 39 files changed, 2074 insertions(+), 112 deletions(-)
 create mode 100644 hw/misc/riscv_wgchecker.c
 create mode 100644 hw/misc/riscv_worldguard.c
 create mode 100644 include/hw/misc/riscv_worldguard.h

-- 
2.17.1


