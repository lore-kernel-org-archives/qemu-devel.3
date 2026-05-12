Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4894CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 20:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMtsR-0000tY-4R; Tue, 12 May 2026 16:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMtsQ-0000tF-0E
 for qemu-devel@nongnu.org; Tue, 12 May 2026 16:38:50 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMtsN-000430-Ul
 for qemu-devel@nongnu.org; Tue, 12 May 2026 16:38:49 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso66953765e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 13:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778618325; x=1779223125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=f1P8fcaHl4pnSJeBMmgExu7nW2uITrJbyyRATLpdVPg=;
 b=Qs5VuhaaPrPNp1f1ejntfndv5LpjCPLmlUI2ZiQREleL8OYxL3UAu80FXPV4M/iRBd
 q1Y8KltSqIFHkLdEIqZWl6YRudBoNoXy7F/otFEERzmkKiD4JPCNeCkas9GYEpCP8yUv
 Vqn4MXv1Eh3OB+FPhav65ObVb27y/ovWEQWU1sVjh2C1bi3IfTVMoRDS05+UBzXlEWIn
 k/5UlGC4xzhBIrci//lDGGVSWEHMEU2R81IbaHnS4IA51C49G855h2llRXvGsAqax4ze
 EmKzXPWfwKnqzN9uNmToDS9Lojz90uLXkCZEWFGVe3hqQxUnDmQQYGxGp6UJVCn2VTe+
 JI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778618325; x=1779223125;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f1P8fcaHl4pnSJeBMmgExu7nW2uITrJbyyRATLpdVPg=;
 b=NLkkdmxw8tYNLZcKpsLH0JeLF1AlstIr2+sGv7+tYR0pPuvmNTKCsT9AAt99ZX4XUJ
 iLgFZ9lN3YmbFZFNl1q6CK6s9LZ/o1Xb6TUNGodgmnNHYcYsedyNbfkQdLaONZEEMEHC
 P1rPpNFERI5Br3Vn8V0xrC38ntEMU6vp00Ap6lOxzLQI9nfNKEMpactmJ1KWTI65iNSu
 quhHgES1/OwzfdtU81VdAqe+uB5YqkVUV6OyOJNo9gdXJo9mOBtowv8WMvoR+6ueCLie
 +bOWHm2Ldz/E8v1BugZxWWu6kdVWemnd3Ybko6biXMObmtvV9+LDMo4xV3bPra2DkBHf
 OchA==
X-Gm-Message-State: AOJu0Ywx7DntF5kaG4v6I3mV8+bmYqgsVJg+9R558rj76sn0VqUOtXJ2
 v+InVKeaaBaN7glmkugMPXTFhGmkvO0H+fkUtLJF4+smeGpCqKff3CIEFD5DMb/ajqK43KXfQOA
 Ox/ah6EM=
X-Gm-Gg: Acq92OFc0pF0v/TyBtFOisPlowlsqmLWkyq7pB9xHNfTDROmzxQp9ng7IgOTuu+dks8
 akFb27IpSyQdSYI3H3SQZcM32YqZGxSaPnNLLL4dmdBz31GuvaaMQGz+lQ+ADddiJC9cogExaw2
 /0n7T5SDyejorLng6vACx9IluXxZkEJ/CrGo18BqVF6VfuoMBHKCy+YzYAN+p1w2YNq/q42sNUV
 j/FRn8wgr40GRkXvkt7LbnR/ie0xfJbmHP+EgdgnFgMLxNfqsyg9geR8iNeYJhcHZCS3VFQA1rE
 rH0Ipuuuu4HkrUvmsI9GvWL+pXRBZh2fgMWKJZ/qWVUE8xjnmSbjHD5C/slutNmpPRttHIGOuaK
 cIy7W3qu3XHNpJlifWkCYYbEMg06tqGJwh6iD0UbbWvFENyn0LeZQT5ATPrD9BwbLrOVaSsg6tk
 l1akQbOpkIYCxz3X11RLgcoygzvZy+/1q55+1Vu/Mii3k6hErjiDzB/58WkEASN61/8aINmZMR
X-Received: by 2002:a05:600c:1990:b0:48a:53cb:8604 with SMTP id
 5b1f17b1804b1-48fc9966d5cmr6150995e9.14.1778618325254; 
 Tue, 12 May 2026 13:38:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f438890sm30272585e9.23.2026.05.12.13.38.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 May 2026 13:38:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/41] Misc HW patches for 2026-05-12
Date: Tue, 12 May 2026 22:38:41 +0200
Message-ID: <20260512203842.4863-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

The following changes since commit 5e61afe211e82a9af15a8794a0bd29bb574e953b:

  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-05-11 10:49:53 -0400)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20260512

for you to fetch changes up to 23af8ed3c4633f965bc47c6a84971301a07a8d55:

  scripts: strip leading './' when searching MAINTAINERS file (2026-05-12 22:35:54 +0200)

----------------------------------------------------------------
Misc HW patches

- More ATI VGA fixes
- Add support for pre-setting RPMB authentication key on eMMC cards
- Fix VDPA on big-endian hosts
- Handle sub-page granularity in cpu_memory_rw_debug()
- Fix leak in pca955x_set_led()
- Mark IPv6 header structure as packed
- MAINTAINERS updates
----------------------------------------------------------------

Chad Jablonski (1):
  ati-vga: fix ati_set_dirty address calculation

Christian Speich (3):
  hw/sd: Switch read/write primitive to buf+len
  hw/sd/sd: Allow multi-byte read/write for generic paths
  hw/sd: Update trace events for buf+len data

Daniel P. Berrangé (1):
  scripts: strip leading './' when searching MAINTAINERS file

Jan Kiszka (2):
  scripts: mkemmc.sh: Fix output pollution on missing images
  hw/sd/sdcard: Add support for pre-setting the authentication key

Konstantin Shkolnyy (1):
  vdpa: Allow VDPA to work on big-endian machine

Magnus Kulke (1):
  MAINTAINERS: Add Doru Blânzeanu as MSHV reviewer

Marc-André Lureau (1):
  hw/gpio/pca9552: fix state_str leak in pca955x_set_led

Mauro Carvalho Chehab (1):
  MAINTAINERS: update HEST maintainership entries

Peter Maydell (29):
  hw/display/cirrus_vga: Fix packed-24 color-expansion transparent
    pattern fills
  hw/display/cirrus_vga: Fix packed-24 color-expansion transparent
    copies
  hw/i386/vapic: Cope with non-page-aligned return from
    cpu_get_phys_page_debug()
  target/riscv: Make get_phys_page_debug handle non-page-aligned addrs
  target/alpha: Make get_phys_page_debug handle non-page-aligned addrs
  target/microblaze: Make get_phys_page_attrs_debug handle
    non-page-aligned addrs
  target/sparc: Make get_phys_page_debug handle non-page-aligned addrs
  target/x86: Make get_phys_page_attrs_debug handle non-page-aligned
    addrs
  target/s390x: Make get_phys_page_debug handle non-page-aligned addrs
  target/ppc: Make get_phys_page_debug handle non-page-aligned addrs
  target: Rename get_phys_page_debug to get_phys_addr_debug
  target: Rename cpu_get_phys_page_{,attrs_}debug
  hw/core: Update docs for get_phys_addr_{attrs_, }debug
  target/arm: Rename arm_cpu_get_phys_page()
  monitor: hmp_gva2gpa: Don't page-align cpu_get_phys_addr_debug() arg
    and return
  plugins/api.c: Trust cpu_get_phys_addr_debug() return address
  hw/core: Implement new cpu_translate_for_debug()
  hw/core: Implement cpu_get_phys_addr_attrs_debug() with
    cpu_translate_for_debug()
  target/arm: Implement translate_for_debug
  system/physmem: Use translate_for_debug() in cpu_memory_rw_debug()
  hw/i386/vapic.c: Use cpu_translate_for_debug()
  target/sparc: Use cpu_translate_for_debug()
  hw/xtensa: Use cpu_translate_for_debug()
  target/xtensa/xtensa-semi: Use cpu_translate_for_debug()
  monitor/hmp-cmds: Use cpu_translate_for_debug()
  plugins/api.c: Use cpu_translate_for_debug()
  Remove cpu_get_phys_addr_debug() and cpu_get_phys_addr_attrs_debug()
  hw/i2c/microbit_i2c: Don't index off end of twi_read_sequence[]
  net: mark struct ip6_header as QEMU_PACKED

Philippe Mathieu-Daudé (1):
  MAINTAINERS: Step up to maintain core machine code

 MAINTAINERS                      |  13 +++-
 docs/system/devices/emmc.rst     |  23 ++++++
 hw/display/cirrus_vga_rop2.h     |  52 +++++++++++--
 include/hw/core/cpu.h            |  40 +++++-----
 include/hw/core/sysemu-cpu-ops.h |  39 ++++++++--
 include/hw/sd/sd.h               |  22 ++++--
 include/net/eth.h                |   2 +-
 target/alpha/cpu.h               |   2 +-
 target/arm/cpu.h                 |   3 -
 target/arm/internals.h           |   4 +
 target/avr/cpu.h                 |   2 +-
 target/hppa/cpu.h                |   2 +-
 target/i386/cpu.h                |   2 +-
 target/loongarch/cpu-mmu.h       |   2 +-
 target/m68k/cpu.h                |   2 +-
 target/microblaze/cpu.h          |   2 +-
 target/mips/internal.h           |   2 +-
 target/or1k/cpu.h                |   2 +-
 target/ppc/cpu.h                 |   2 +-
 target/riscv/cpu.h               |   2 +-
 target/rx/cpu.h                  |   2 +-
 target/s390x/s390x-internal.h    |   1 -
 target/sh4/cpu.h                 |   2 +-
 target/sparc/cpu.h               |   2 +-
 target/tricore/cpu.h             |   2 +-
 target/xtensa/cpu.h              |   2 +-
 hw/core/cpu-system.c             |  47 +++++++-----
 hw/display/ati_2d.c              |  24 ++++--
 hw/gpio/pca9552.c                |   2 +-
 hw/i2c/microbit_i2c.c            |   7 +-
 hw/i386/vapic.c                  |  13 ++--
 hw/sd/core.c                     |  53 ++++++++++---
 hw/sd/sd.c                       | 125 +++++++++++++++++++++++--------
 hw/xtensa/sim.c                  |   6 +-
 hw/xtensa/xtfpga.c               |   6 +-
 monitor/hmp-cmds.c               |   8 +-
 net/vhost-vdpa.c                 |   5 +-
 plugins/api.c                    |   8 +-
 system/physmem.c                 |  38 ++++++----
 target/alpha/cpu.c               |   2 +-
 target/alpha/helper.c            |   3 +-
 target/arm/cpu.c                 |   2 +-
 target/arm/ptw.c                 |  39 ++++++----
 target/avr/cpu.c                 |   2 +-
 target/avr/helper.c              |   2 +-
 target/hppa/cpu.c                |   2 +-
 target/hppa/mem_helper.c         |   2 +-
 target/i386/cpu.c                |   2 +-
 target/i386/helper.c             |   4 +-
 target/i386/whpx/whpx-all.c      |   2 +-
 target/loongarch/cpu.c           |   2 +-
 target/loongarch/cpu_helper.c    |   2 +-
 target/m68k/cpu.c                |   2 +-
 target/m68k/helper.c             |   2 +-
 target/microblaze/cpu.c          |   2 +-
 target/microblaze/helper.c       |  11 ++-
 target/mips/cpu.c                |   2 +-
 target/mips/system/physaddr.c    |   2 +-
 target/or1k/cpu.c                |   2 +-
 target/or1k/mmu.c                |   2 +-
 target/ppc/cpu_init.c            |   2 +-
 target/ppc/mmu-hash32.c          |   2 +-
 target/ppc/mmu_common.c          |   4 +-
 target/riscv/cpu.c               |   2 +-
 target/riscv/cpu_helper.c        |   4 +-
 target/rx/cpu.c                  |   2 +-
 target/rx/helper.c               |   2 +-
 target/s390x/cpu-system.c        |   2 +-
 target/s390x/helper.c            |  20 ++---
 target/sh4/cpu.c                 |   2 +-
 target/sh4/helper.c              |   2 +-
 target/sparc/cpu.c               |   2 +-
 target/sparc/mmu_helper.c        |  23 ++++--
 target/tricore/cpu.c             |   2 +-
 target/tricore/helper.c          |   2 +-
 target/xtensa/cpu.c              |   2 +-
 target/xtensa/mmu_helper.c       |   2 +-
 target/xtensa/xtensa-semi.c      |   9 ++-
 hw/sd/trace-events               |   6 +-
 scripts/get_maintainer.pl        |   1 +
 scripts/mkemmc.sh                |   4 +-
 81 files changed, 508 insertions(+), 253 deletions(-)

-- 
2.53.0


