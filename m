Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7A8C9EC77
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 12:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfGun-0000AA-A5; Mon, 12 Jan 2026 07:20:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vfGuR-0008Gm-9H
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 07:20:39 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vfGuO-0002eQ-Hm
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 07:20:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=oer5PbYMq+a2BZX11DYCCJry+S77D/LwpPlN/WAAaQw=; b=Qw+hZO45IARpJ7y
 d0nL0tyh8OZGFRq6MojAdSA87VxNQlkQ4LNkUn04X6Y+C/s+9qct4XBGV/eDIggo3v0iotRfI0npy
 t9ff0huPaD2FfsJGAv4vHHTLEIN8v329HFrDM2deRVYgj/jQD1QQuaQoVdj9vcj7rl8q3ghId1G+1
 nI=;
Subject: [PATCH v3 0/7] single-binary: Drop TARGET_PHYS_ADDR_SPACE_BITS
Date: Mon, 12 Jan 2026 13:22:41 +0100
Message-Id: <20260112-phys_addr-v3-0-5f90fdb4015f@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJHnZGkC/02OQQqDMBBFryKzbkpmEpvqqvcopaRm1GxUkhIq4
 t0bLRSX7zPvMQtEDp4j1MUCgZOPfhwyqFMBTW+HjoV3mYEklYhSi6mf49M6F8RLttqwVRK1hXw
 /BW79Z2/dH5l7H99jmPd0wm39VUhWh0pCIUWjrqZVbMgZc8tvnIcOtkSig4blUaOsXZSyFl1F1
 Li/tq7rFwgMTaDWAAAA
X-Change-ID: 20251104-phys_addr-b0f47ea3014a
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Anton Johansson <anjo@rev.ng>, palmer@dabbelt.com, alistair.francis@wdc.com, 
 pbonzini@redhat.com, gaosong@loongson.cn, maobibo@loongson.cn, 
 Brian Cain <brian.cain@oss.qualcomm.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The target macro TARGET_PHYS_ADDR_SPACE_BITS is unused since commit

  2e8fe327eb6 ("accel/tcg: Simplify L1_MAP_ADDR_SPACE_BITS"),

replace the handful of remaining uses with runtime functions or
constants.

For discussion see:

  https://lore.kernel.org/qemu-devel/8f0db5c1-f20b-4b7a-8d6c-76ce7ec7b4e0@linaro.org/

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
Changes in v3:
- Added reviewed-by;
- Widened CC;
- Link to v2: https://lore.kernel.org/qemu-devel/20251215-phys_addr-v2-0-633aa1d922cd@rev.ng

Changes in v2:
- Move alpha_phys_addr_space_bits() to linux-user/alpha/target_proc.h
  (Richard);
- Link to v1: https://lore.kernel.org/qemu-devel/20251209-phys_addr-v1-0-c387f3e72d77@rev.ng

---
Anton Johansson (7):
      target/alpha: Introduce alpha_phys_addr_space_bits()
      target/hppa: Define PA[20|1X] physical address space size
      target/i386: Drop physical address range checks
      target/loongarch: Introduce loongarch_palen_mask()
      hw/loongarch: Use loongarch_palen_mask()
      hw/riscv: Fix IOMMU PAS capability to 56 bits
      Drop TARGET_PHYS_ADDR_SPACE_BITS

 include/exec/cpu-defs.h           |  3 ---
 include/exec/poison.h             |  2 --
 include/hw/loongarch/boot.h       |  3 ++-
 linux-user/alpha/target_proc.h    | 23 ++++++++++++++++++++++-
 target/alpha/cpu-param.h          |  3 ---
 target/arm/cpu-param.h            |  2 --
 target/avr/cpu-param.h            |  1 -
 target/hexagon/cpu-param.h        |  1 -
 target/hppa/cpu-param.h           |  2 --
 target/i386/cpu-param.h           |  2 --
 target/i386/tcg/helper-tcg.h      |  2 --
 target/loongarch/cpu-mmu.h        |  1 +
 target/loongarch/cpu-param.h      |  1 -
 target/loongarch/internals.h      |  1 -
 target/m68k/cpu-param.h           |  1 -
 target/microblaze/cpu-param.h     |  2 --
 target/mips/cpu-param.h           |  2 --
 target/openrisc/cpu-param.h       |  1 -
 target/ppc/cpu-param.h            |  7 -------
 target/riscv/cpu-param.h          |  2 --
 target/rx/cpu-param.h             |  1 -
 target/s390x/cpu-param.h          |  1 -
 target/sh4/cpu-param.h            |  1 -
 target/sparc/cpu-param.h          |  2 --
 target/tricore/cpu-param.h        |  1 -
 target/xtensa/cpu-param.h         |  1 -
 hw/loongarch/boot.c               | 28 ++++++++++++++++------------
 hw/loongarch/virt.c               |  5 ++++-
 hw/riscv/riscv-iommu.c            | 12 +++++++++---
 target/hppa/mem_helper.c          | 23 ++++++++++++++++++-----
 target/i386/cpu.c                 |  9 +++------
 target/i386/kvm/kvm.c             |  3 +--
 target/loongarch/cpu_helper.c     | 14 +++++++++++---
 target/loongarch/tcg/tlb_helper.c | 12 ++++++++----
 34 files changed, 95 insertions(+), 80 deletions(-)


