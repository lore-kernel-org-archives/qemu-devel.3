Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78947106FD87
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vtQ-0000Za-Jl; Fri, 13 Mar 2026 02:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vtO-0000ZL-PI
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:21:02 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vtM-0006ii-Ix
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:21:02 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48534b59cf3so15972705e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773382857; x=1773987657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=As2C1Q7IiAGYRvOu9fH4LK4fE+KRniODuiUqW5R4EqQ=;
 b=rT8SZXk8C3JADrc+I79bvOgQpJI0b2dx1znfkW9gSUJ/MLmtkQtpjuBY945M1+bIhT
 ouShJYHMM2NMU3USFBPOFcd9b7xrBWmSCUMNvkBNx4Wq5z+VBrxhXLAnk6cr8H0WLO+r
 FsXruLfenGwff+ND10ucQsYocQlKA7T751eabKllyn3kraX46ep3vdDiv9KKlVbZcGVD
 T3V6ILSh0X9Zmz3bP2nL4tTATZNgyx0CzbuASWnuiv0qpfSBQMb7pri3yNAAfJRTs4Tm
 WM/cJ7SHkRrW6wii0sJwWTnuYpLaBPyLUZkBC1W81x+aF8Bd7qLd8bcKoInLbE3LB7Y3
 SPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773382857; x=1773987657;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=As2C1Q7IiAGYRvOu9fH4LK4fE+KRniODuiUqW5R4EqQ=;
 b=JKjWKENFX5H5EbC0F1HGbISnofEFW8gK7e4fzmDWxXGec5Ux9a/DdrrBryVfScWtSz
 cUlAResDMbZ+ABbcWvkCyhrwA+hmotPJJ7TKSOT19Ash4VrRg/jcGSBwoGDUSL1xtGwE
 D1VotCxEG5dmYHiNx8UuQC2PqiN7N+5lEsVY8/InRCjPEkVlWy5DOhtWtk6rv9vzk/sC
 79bM76oXefMDTXdbZEgQeRXpte2cL37QmOwPCzqLwZHo+VteUAaP2R9StL5TzOqEFJ43
 insN1zqs4NAKUdGl7Numi0xsB6mGwe5R01wfSzkKTZER72SHNP7mg7PlzfxmA9t9e1WP
 STkQ==
X-Gm-Message-State: AOJu0YzcL1jBsb/3nhSYxYVi1mmu3wBxrMgsKeq89Q0LBW0WFgWqvCsc
 NLisBV12hG/luEzJEWLsp6/rthmy4nELXsfX5J1WQJ8lSmhgfZmrrpWoiOUTWg54VhcNAZl1Zue
 U5s5Wdtw=
X-Gm-Gg: ATEYQzyxLAM4mK1CKRubgeeLoXZl5tT/dOF4so/P2As5ttlKGNVhnqndt+kTPQD2YDX
 VRZ9ihmgUYig5SEPnxfYBmc/nZKZ1/O8mu3dhH9/SiWgGABazWtBLf7x/5FzhEnabWpYzsY7/6h
 TnwGpKqwfAeDLB9CZXvru6mgqOR1pvZFMkm6Vpxig7AGXZ7pL8U2YFA/1YFVnfsCwWkoZ0IpZBw
 VH/pi305bYSOgJcVKj3ffmeJIIhhFl0bc2BvoSN9GVdAdfreGiDNujhvTyN5Frzu0K7eCxelysO
 kXVUJ+1DtpnUZlH9XCAa6i0IeDRSyLtJaacj0we+cFjctPSgJucyXodcZktX/duHGnlhKql/jG7
 /jo4HeOrqchn8/6zhy0uCFUZo5E5Ng+YBKn97KQzI4/mzQi3k0crUKxxiAb9+xPwCjkWe/FPJi1
 CGCb7eOAbv/w7LI8XMxIYHsV2Fkba/dn/NEUF3SfISEJu3HIkNUx7BScAP3dZwkqVpx0jx7aXTt
 1FJOg==
X-Received: by 2002:a05:600c:4f8f:b0:485:3423:727d with SMTP id
 5b1f17b1804b1-4855670c095mr30380965e9.26.1773382857405; 
 Thu, 12 Mar 2026 23:20:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b5e9179sm180651835e9.3.2026.03.12.23.20.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:20:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 00/38] target/cpu: Do not include 'exec/cpu-defs.h' anymore
Date: Fri, 13 Mar 2026 07:20:16 +0100
Message-ID: <20260313062055.2188-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Pierrick noticed [*] "exec/cpu-defs.h" isn't really used by
each target "cpu.h". However various source files rely on it
(or actually a small subset of it: "exec/target_long.h").

This series first includes the missing headers that were
indirectly pulled via "cpu.h" -> "exec/cpu-defs.h", then
remove it for each target "cpu.h".

As another cleanup we use the full path to target "cpu.h".

[*] v1: https://lore.kernel.org/qemu-devel/20260312224702.1608408-2-pierrick.bouvier@linaro.org/

Philippe Mathieu-Daudé (37):
  target/arm: Remove target_ulong use in hvf_handle_psci_call()
  target/ppc: Replace TARGET_PAGE_BITS -> qemu_target_page_bits()
  hw/s390x/vfio: Replace TARGET_PAGE_BITS -> qemu_target_page_bits()
  monitor/hmp: : Include missing 'exec/target_long.h' header
  target-info: Include 'exec/cpu-defs.h' explicitly
  target/xtensa: Restrict inclusion of 'exec/cpu-defs.h' header
  target/hexagon: Include missing 'exec/target_long.h' header
  target/hppa: Include missing 'exec/target_long.h' header
  target/i386: Include missing 'exec/target_long.h' header
  target/m68k: Include missing 'exec/target_long.h' header
  target/mips: Include missing 'exec/target_long.h' header
  target/ppc: Include missing 'exec/target_long.h' header
  target/riscv: Include missing 'exec/target_long.h' header
  target/sparc: Include missing 'exec/target_long.h' header
  system/kvm_xen: Include missing 'exec/target_page.h' header
  hw/misc/cpc: Include missing 'hw/core/cpu.h' header
  target/s390x/tcg: Include missing '*cpu.h' headers
  exec/helper-head: Include missing 'exec/target_long.h' header
  target/cpu: Do not include 'exec/cpu-defs.h' anymore
  hw/alpha: Include full path to target 'cpu.h' header
  hw/arm: Include full path to target 'cpu.h' header
  hw/avr: Include full path to target 'cpu.h' header
  hw/hppa: Include full path to target 'cpu.h' header
  hw/i386: Include full path to target 'cpu.h' header
  hw/m68k: Include full path to target 'cpu.h' header
  hw/microblaze: Include full path to target 'cpu.h' header
  hw/mips: Include full path to target 'cpu.h' header
  hw/or1k: Include full path to target 'cpu.h' header
  hw/ppc: Include full path to target 'cpu.h' header
  hw/riscv: Include full path to target 'cpu.h' header
  hw/s390x: Include full path to target 'cpu.h' header
  hw/sh4: Include full path to target 'cpu.h' header
  hw/sparc: Include full path to target 'cpu.h' header
  hw/tricore: Include full path to target 'cpu.h' header
  hw/xtensa: Include full path to target 'cpu.h' header
  hw/avr: Build as common unit files
  hw/misc: Build 'mac_via' as common unit file

Pierrick Bouvier (1):
  hw/misc/allwinner-cpucfg.c: make compilation unit common

 hw/avr/boot.h                            |  2 +-
 hw/s390x/ipl.h                           |  2 +-
 hw/s390x/s390-hypercall.h                |  2 +-
 hw/xtensa/xtensa_memory.h                |  2 +-
 include/hw/arm/digic.h                   |  2 +-
 include/hw/arm/fsl-imx6.h                |  2 +-
 include/hw/arm/fsl-imx6ul.h              |  2 +-
 include/hw/arm/fsl-imx7.h                |  2 +-
 include/hw/arm/fsl-imx8mp.h              |  2 +-
 include/hw/i386/apic_internal.h          |  2 +-
 include/hw/intc/mips_gic.h               |  2 +-
 include/hw/ppc/pnv.h                     |  2 +-
 include/hw/ppc/spapr_fadump.h            |  2 +-
 include/hw/ppc/spapr_ovec.h              |  2 +-
 include/monitor/hmp-target.h             |  2 +-
 include/system/kvm_xen.h                 |  2 ++
 target/alpha/cpu.h                       |  1 -
 target/arm/cpu.h                         |  1 -
 target/avr/cpu.h                         |  1 -
 target/hexagon/cpu.h                     |  3 ++-
 target/hexagon/mmvec/mmvec.h             |  3 +++
 target/hppa/cpu.h                        |  2 +-
 target/i386/cpu.h                        |  2 +-
 target/loongarch/cpu.h                   |  1 -
 target/m68k/cpu.h                        |  1 -
 target/microblaze/cpu.h                  |  1 -
 target/mips/cpu.h                        |  2 +-
 target/or1k/cpu.h                        |  1 -
 target/ppc/cpu.h                         |  2 +-
 target/riscv/cpu.h                       |  2 +-
 target/riscv/debug.h                     |  1 +
 target/riscv/pmp.h                       |  1 +
 target/rx/cpu.h                          |  1 -
 target/s390x/cpu.h                       |  1 -
 target/s390x/tcg/tcg_s390x.h             |  3 +++
 target/sh4/cpu.h                         |  1 -
 target/sparc/cpu.h                       |  2 +-
 target/tricore/cpu.h                     |  1 -
 target/xtensa/cpu.h                      |  1 -
 include/exec/helper-head.h.inc           | 15 +++++++--------
 hw/alpha/dp264.c                         |  2 +-
 hw/alpha/typhoon.c                       |  2 +-
 hw/arm/boot.c                            |  2 +-
 hw/arm/exynos4210.c                      |  2 +-
 hw/arm/mps3r.c                           |  2 +-
 hw/arm/omap1.c                           |  2 +-
 hw/arm/realview.c                        |  2 +-
 hw/arm/smmuv3.c                          |  2 +-
 hw/hppa/machine.c                        |  2 +-
 hw/i386/multiboot.c                      |  2 +-
 hw/i386/pc_sysfw_ovmf.c                  |  2 +-
 hw/i386/vmmouse.c                        |  2 +-
 hw/intc/arm_gicv3_cpuif.c                |  2 +-
 hw/intc/arm_gicv3_cpuif_common.c         |  2 +-
 hw/intc/m68k_irqc.c                      |  2 +-
 hw/intc/sh_intc.c                        |  2 +-
 hw/isa/lpc_ich9.c                        |  2 +-
 hw/m68k/an5206.c                         |  2 +-
 hw/m68k/mcf5206.c                        |  2 +-
 hw/m68k/mcf5208.c                        |  2 +-
 hw/m68k/mcf_intc.c                       |  2 +-
 hw/m68k/q800-glue.c                      |  2 +-
 hw/m68k/q800.c                           |  2 +-
 hw/m68k/virt.c                           |  2 +-
 hw/microblaze/boot.c                     |  2 +-
 hw/microblaze/petalogix_ml605_mmu.c      |  2 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  2 +-
 hw/microblaze/xlnx-zynqmp-pmu.c          |  2 +-
 hw/mips/bootloader.c                     |  2 +-
 hw/mips/fuloong2e.c                      |  2 +-
 hw/mips/jazz.c                           |  2 +-
 hw/mips/malta.c                          |  2 +-
 hw/misc/mips_cpc.c                       |  3 ++-
 hw/misc/riscv_cmgcr.c                    |  3 ++-
 hw/misc/riscv_cpc.c                      |  3 ++-
 hw/or1k/boot.c                           |  2 +-
 hw/or1k/cputimer.c                       |  2 +-
 hw/or1k/or1k-sim.c                       |  2 +-
 hw/or1k/virt.c                           |  2 +-
 hw/ppc/mpc8544_guts.c                    |  2 +-
 hw/ppc/mpc8544ds.c                       |  2 +-
 hw/ppc/ppc440_uc.c                       |  2 +-
 hw/ppc/ppc4xx_devs.c                     |  2 +-
 hw/ppc/ppc_booke.c                       |  2 +-
 hw/ppc/prep_systemio.c                   |  2 +-
 hw/ppc/spapr_vhyp_mmu.c                  |  2 +-
 hw/ppc/virtex_ml507.c                    |  2 +-
 hw/riscv/microblaze-v-generic.c          |  2 +-
 hw/s390x/ap-bridge.c                     |  2 +-
 hw/s390x/s390-hypercall.c                |  2 +-
 hw/s390x/s390-pci-vfio.c                 |  3 ++-
 hw/s390x/s390-stattrib.c                 |  2 +-
 hw/s390x/tod-tcg.c                       |  2 +-
 hw/sh4/r2d.c                             |  2 +-
 hw/sparc/leon3.c                         |  2 +-
 hw/sparc/sun4m.c                         |  2 +-
 hw/sparc64/niagara.c                     |  2 +-
 hw/sparc64/sparc64.c                     |  2 +-
 hw/sparc64/sun4u.c                       |  2 +-
 hw/tricore/tricore_testboard.c           |  2 +-
 hw/xtensa/pic_cpu.c                      |  2 +-
 hw/xtensa/xtfpga.c                       |  2 +-
 target-info-stub.c                       |  1 +
 target/arm/hvf/hvf.c                     |  2 +-
 target/m68k/m68k-semi.c                  |  2 +-
 target/ppc/mmu-booke.c                   |  3 ++-
 target/ppc/mmu-hash64.c                  |  3 ++-
 target/ppc/mmu-radix64.c                 |  3 ++-
 target/xtensa/cpu.c                      |  1 +
 hw/misc/meson.build                      |  6 +++---
 hw/timer/meson.build                     |  2 +-
 111 files changed, 120 insertions(+), 113 deletions(-)

-- 
2.53.0


