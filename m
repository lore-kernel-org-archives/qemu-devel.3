Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50810C71130
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 19:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYrWR-0003CB-S3; Mon, 07 Jul 2025 15:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uYrWA-0002v1-C1; Mon, 07 Jul 2025 15:28:46 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uYrW7-0004yD-CG; Mon, 07 Jul 2025 15:28:45 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3BD1B55C170;
 Mon, 07 Jul 2025 21:28:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id MYCfXSN-muic; Mon,  7 Jul 2025 21:28:37 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C278255BC02; Mon, 07 Jul 2025 21:28:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BFE39745682;
 Mon, 07 Jul 2025 21:28:37 +0200 (CEST)
Date: Mon, 7 Jul 2025 21:28:37 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-block@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org
Subject: Re: [RFC PATCH-for-10.1 v6 00/14] target-info: Add more API for
 VirtIO cleanups & introduce ARM macros
In-Reply-To: <20250707172009.3884-1-philmd@linaro.org>
Message-ID: <ad9997da-1372-1edf-0aa9-5fc4d1e82c41@eik.bme.hu>
References: <20250707172009.3884-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-816273641-1751916517=:98682"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-816273641-1751916517=:98682
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 7 Jul 2025, Philippe Mathieu-Daudé wrote:
> Rather than re-spinning the whole "single-binary: Make hw/arm/
> common" series, restrict to the API additions, but include
> examples of their usefulness (hundreds of virtio objects
> removed from default Linux build).
> Time passed since I context-switched out of this work so I'm
> not sure the DEFINE_MACHINE_WITH_INTERFACES() implementation
> is in the form Zoltan asked.

I've sent the patch here:
https://patchew.org/QEMU/cover.1751494995.git.balaton@eik.bme.hu/3c2aa5b895adbb5244b643a6672603d65dce4298.1751494995.git.balaton@eik.bme.hu/
that will hopefully be merged before the freeze so you can rebase on that.

Regards,
BALATON Zoltan

> Philippe Mathieu-Daudé (14):
>  target/qmp: Use target_cpu_type()
>  qemu/target-info: Factor target_arch() out
>  qemu/target-info: Add %target_arch field to TargetInfo
>  qemu/target-info: Introduce target_base_arch()
>  qemu/target-info: Add target_endian_mode()
>  qemu: Convert target_words_bigendian() to TargetInfo API
>  gdbstub/helpers: Replace TARGET_BIG_ENDIAN -> target_big_endian()
>  qemu: Declare all load/store helpert in 'qemu/bswap.h'
>  hw/virtio: Build various files once
>  hw/core/null-machine: Define machine as generic QOM type
>  hw/arm: Register TYPE_TARGET_ARM/AARCH64_MACHINE QOM interfaces
>  hw/core: Allow ARM/Aarch64 binaries to use the 'none' machine
>  hw/boards: Introduce DEFINE_MACHINE_WITH_INTERFACES() macro
>  hw/arm: Add DEFINE_MACHINE_[ARM_]AARCH64() macros
>
> meson.build                           |  1 +
> include/exec/tswap.h                  | 83 +--------------------------
> include/gdbstub/helpers.h             | 15 ++---
> include/hw/arm/machines-qom.h         | 31 ++++++++++
> include/hw/boards.h                   |  6 +-
> include/qemu/bswap.h                  | 73 +++++++++++++++++++++++
> include/qemu/target-info-impl.h       |  8 ++-
> include/qemu/target-info-qapi.h       | 36 ++++++++++++
> include/qemu/target-info.h            | 10 +++-
> include/system/memory.h               |  1 -
> include/user/abitypes.h               |  1 -
> target/ppc/mmu-hash64.h               |  2 -
> cpu-target.c                          |  7 ---
> hw/acpi/bios-linker-loader.c          |  2 -
> hw/arm/allwinner-r40.c                |  1 -
> hw/arm/boot.c                         |  2 +
> hw/arm/npcm7xx.c                      |  2 +-
> hw/block/hd-geometry.c                |  1 -
> hw/char/riscv_htif.c                  |  1 -
> hw/core/cpu-system.c                  |  2 +-
> hw/core/machine-qmp-cmds.c            |  8 +--
> hw/core/null-machine.c                | 20 ++++++-
> hw/cxl/cxl-events.c                   |  2 -
> hw/display/artist.c                   |  1 +
> hw/display/ati.c                      |  1 +
> hw/display/vga.c                      |  2 +-
> hw/net/can/ctucan_core.c              |  1 -
> hw/net/lan9118.c                      |  1 +
> hw/net/rtl8139.c                      |  1 +
> hw/net/vmxnet3.c                      |  1 -
> hw/pci-host/gt64120.c                 |  1 +
> hw/pci-host/pnv_phb3.c                |  1 +
> hw/pci-host/pnv_phb4.c                |  1 +
> hw/pci-host/ppce500.c                 |  1 -
> hw/pci-host/sh_pci.c                  |  1 -
> hw/s390x/s390-pci-inst.c              |  1 +
> hw/sensor/lsm303dlhc_mag.c            |  1 -
> hw/smbios/smbios.c                    |  1 +
> hw/vfio/migration-multifd.c           |  1 -
> hw/virtio/virtio-config-io.c          |  1 -
> hw/virtio/virtio-pci.c                |  1 +
> hw/virtio/virtio.c                    |  2 +-
> hw/vmapple/virtio-blk.c               |  1 -
> system/memory.c                       |  1 +
> system/qtest.c                        |  1 +
> target-info-qom.c                     | 24 ++++++++
> target-info-stub.c                    |  3 +
> target-info.c                         | 33 +++++++++++
> target/arm/arm-qmp-cmds.c             |  3 +-
> target/arm/cpu.c                      |  1 -
> target/arm/machine.c                  | 12 ++++
> target/i386/tcg/system/excp_helper.c  |  1 -
> target/i386/xsave_helper.c            |  1 -
> target/loongarch/loongarch-qmp-cmds.c |  3 +-
> target/mips/system/mips-qmp-cmds.c    |  3 +-
> target/riscv/vector_helper.c          |  1 -
> tests/tcg/plugins/mem.c               |  1 +
> hw/block/meson.build                  |  6 +-
> hw/virtio/meson.build                 | 20 ++++---
> 59 files changed, 302 insertions(+), 149 deletions(-)
> create mode 100644 include/hw/arm/machines-qom.h
> create mode 100644 include/qemu/target-info-qapi.h
> create mode 100644 target-info-qom.c
>
>
--3866299591-816273641-1751916517=:98682--

