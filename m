Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4CBE7FDE0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 22:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn2Vq-0005zf-Dr; Mon, 02 Feb 2026 17:35:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vn2Vn-0005vc-JA
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:35:15 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vn2Vl-0007l5-9K
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:35:15 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9C95F5969F6;
 Mon, 02 Feb 2026 23:35:09 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id z3Ct3Vuun3SZ; Mon,  2 Feb 2026 23:35:07 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2E2D75969F3; Mon, 02 Feb 2026 23:35:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2A6285969F2;
 Mon, 02 Feb 2026 23:35:07 +0100 (CET)
Date: Mon, 2 Feb 2026 23:35:07 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/16] Misc HW & Memory API patches for 2026-02-02
In-Reply-To: <20260202212019.94205-1-philmd@linaro.org>
Message-ID: <7795aaf6-74dd-cbd8-d825-a6cfa0d068bb@eik.bme.hu>
References: <20260202212019.94205-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1353027304-1770071707=:53350"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1353027304-1770071707=:53350
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 2 Feb 2026, Philippe Mathieu-Daudé wrote:
> The following changes since commit 587f4a1805c83a4e1d59dd43cb14e0a834843d1d:
>
>  python: fix msys64 wheel directory specification (2026-02-02 16:46:40 +1000)
>
> are available in the Git repository at:
>
>  https://github.com/philmd/qemu.git tags/hw-misc-20260202
>
> for you to fetch changes up to d8316b64dfbb4fdb706f20c3b42fd9bcf70b0cdc:
>
>  monitor: Reduce target-specific methods (2026-02-02 22:14:51 +0100)
>
> Ignoring this checkpatch.pl error:
>
>  ERROR: unnecessary whitespace before a quoted newline
>  #85: FILE: tests/unit/test-cutils.c:3685:
>  +            "s is \n";
>
> ----------------------------------------------------------------
> Misc HW & memory API patches
>
> - Add unit test for qemu_hexdump()
> - Remove legacy native endianness API uses on the Alpha target
> - Remove unused memory_region_init_rom_device_nomigrate()
> - Fix use-after-free in NvmeNamespace "bootindex" suffix
> - Correct documentation of SCSI Rotation Rate field
> - Make iotlb_to_section() work with non-CPU AddressSpaces
> - Reduce few monitor target-specific methods
> ----------------------------------------------------------------
>
> Akihiko Odaki (1):
>  hw/nvme: Fix bootindex suffix use-after-free
>
> Alberto Garcia (1):
>  hw/ide, scsi-disk: Fix typo on the rotation_rate documentation
>
> BALATON Zoltan (2):
>  memory: Remove memory_region_init_rom_device_nomigrate()
>  memory: Add internal memory_region_set_ops helper function

Thanks. You could have also picked up (rtl8139: Remove ineffective 
parameter) and meanwhile Mark gave R-b to (hw/display/{cg3,tcx}: Do not 
use memory_region_init_rom_nomigrate()) so that could also be merged.

Regards,
BALATON Zoltan

> Jim Shu (3):
>  accel/tcg: Send the CPUTLBEntryFull struct into io_prepare()
>  accel/tcg: Fix iotlb_to_section() for different AddressSpace
>  system/physmem: Remove the assertion of page-aligned section number
>
> Philippe Mathieu-Daudé (8):
>  target/alpha: Use explicit little-endian LD/ST API
>  target/alpha: Inline translator_ldl()
>  configs/targets: Forbid Alpha to use legacy native endianness APIs
>  target/alpha: Replace legacy ld_phys() -> address_space_ld()
>  target/i386: Include missing 'svm.h' header in 'sev.h'
>  monitor: Reduce target-specific declarations
>  monitor: Add hmp_cmds_for_target() helper
>  monitor: Reduce target-specific methods
>
> Vladimir Sementsov-Ogievskiy (1):
>  tests/unit: add unit test for qemu_hexdump()
>
> docs/devel/memory.rst                         |  1 -
> configs/targets/alpha-linux-user.mak          |  2 +
> configs/targets/alpha-softmmu.mak             |  2 +
> .../memory-region-housekeeping.cocci          |  8 ---
> hw/nvme/nvme.h                                |  1 +
> include/accel/tcg/iommu.h                     | 15 -----
> include/exec/cputlb.h                         |  4 +-
> include/hw/core/cpu.h                         | 17 ++---
> include/hw/ide/ide-dev.h                      |  2 +-
> include/hw/misc/mos6522.h                     |  2 -
> include/monitor/hmp-target.h                  | 14 ----
> include/monitor/hmp.h                         | 13 ++++
> include/system/memory.h                       | 27 --------
> monitor/monitor-internal.h                    |  9 ++-
> target/i386/sev.h                             |  2 +
> accel/tcg/cputlb.c                            | 32 +++++----
> hw/i386/sgx-stub.c                            |  1 +
> hw/i386/sgx.c                                 |  1 +
> hw/nvme/ns.c                                  |  7 +-
> hw/scsi/scsi-disk.c                           |  2 +-
> monitor/hmp-cmds.c                            |  1 +
> monitor/hmp-target.c                          | 66 ++-----------------
> monitor/hmp.c                                 | 63 +++++++++++++++++-
> system/memory.c                               | 56 +++++++---------
> system/physmem.c                              | 31 ---------
> target/alpha/helper.c                         | 28 ++++----
> target/alpha/translate.c                      |  2 +-
> target/i386/cpu-apic.c                        |  1 +
> target/i386/sev-system-stub.c                 |  1 +
> target/i386/sev.c                             |  1 +
> target/m68k/monitor.c                         |  1 +
> target/riscv/monitor.c                        |  1 +
> tests/unit/test-cutils.c                      | 66 +++++++++++++++++++
> util/meson.build                              |  2 +-
> 34 files changed, 239 insertions(+), 243 deletions(-)
>
>
--3866299591-1353027304-1770071707=:53350--

