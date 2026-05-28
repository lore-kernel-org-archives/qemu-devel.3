Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F6DCD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 06:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSU4c-0008JV-EP; Thu, 28 May 2026 02:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wSU4Y-0008IO-7d; Thu, 28 May 2026 02:18:26 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wSU4V-0007E3-SO; Thu, 28 May 2026 02:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779949094; bh=Husla0RlBjw6jb1JS8SiWMWtBDsleIM7IC16KKJFy14=;
 h=Subject:From:To:Cc:Date;
 b=WOcPMJhY3ih1aLL5bW+f4UR2BGOzND8q2sjhhAwA3OoAM+TQ1n/nSkX+cgqqD2xvr
 ck9AOOVjBZUNRt2wB5XRpzbMfKJd90awZJbyXRGR3RX6+hu/4ZTO1MsWr1Cr9g+iyl
 Ur2oc7tmxR1tM4Y+EaaOBL5MK9ouJXvzO6QtWt2n4wbME5GmfXnPQ5+a0B7dsuic2p
 VYC1Sm/XQLuhWWe0mmZl8VZ4gjchsC6hmz2O/MG4ZN2wWSkYx5HqFPiGsH60TcT6BS
 JYmsZJkmrIs+RBBfO9BzVG+1L3WorMBakYGUIzczR8JXbYrkoy6agKwSctD8/Nxcri
 WDeWYyUV7ssHA==
Received: from think4mjt.localdomain (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by isrv.corpit.ru (Postfix) with ESMTP id 1CC931B1F33;
 Thu, 28 May 2026 09:18:14 +0300 (MSK)
Received: by think4mjt.localdomain (Postfix, from userid 1000)
 id CEE521691A9; Thu, 28 May 2026 09:18:20 +0300 (MSK)
Subject: [ANNOUNCE] QEMU 11.0.1 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260528061820.CEE521691A9@think4mjt.localdomain>
Date: Thu, 28 May 2026 09:18:20 +0300 (MSK)
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, MIME_QP_LONG_LINE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi everyone,

The QEMU v11.0.1 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-11.0.1.tar.xz
  https://download.qemu.org/qemu-11.0.1.tar.xz.sig (signature)

v11.0.1 is now tagged in the official qemu.git repository, and the
stable-11.0 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-11.0

There are 91 changes since the previous v11.0.0 release.
This release, among other things, fixes multiple vulnerabilities in the UEFI
code (CVE-2026-8341, CVE-2026-41435, CVE-2026-41436, CVE-2026-41437,
CVE-2026-41438, CVE-2026-41439, CVE-2026-41440), and an issue in virtio-gpu
(CVE-2026-6502).

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-11.0-hash master-hash Author Name: Commmit-Subject):

6e9a825c1d Michael Tokarev:
 Update version for 11.0.1 release
fddafa15a9 e3082ab3b3 Denis V. Lunev:
 block/graph-lock: fix missed wakeup in bdrv_graph_co_rdunlock()
438e152ad4 f0d9ccd46c Kevin Wolf:
 commit: Drain nodes across all of bdrv_commit()
a8efa05637 f27aea1896 Kevin Wolf:
 block: Add more defaults to DEFAULT_BLOCK_CONF
16db6a23fe a1310cc628 Kevin Wolf:
 block: Create DEFAULT_BLOCK_CONF macro
a56f665743 2fa24e9755 Kevin Wolf:
 ide-test: Test reset during TRIM
ba4f1c1f87 92854c9c75 Kevin Wolf:
 ide-test: Factor out wait_dma_completion()
5044ebfad8 c1c71a7e16 Kevin Wolf:
 ide: Clean up ide_trim_co_entry() to be idiomatic coroutine code
6e5b03431b 095c08a7ba Kevin Wolf:
 ide: Minimal fix for deadlock between TRIM and drain
854bf73918 53074ba033 Kevin Wolf:
 block: Add flags parameter to blk_*_pdiscard()
e25d83015b 34a6763776 Kevin Wolf:
 block: Add blk_co_start/end_request() and BDRV_REQ_NO_QUEUE
f44edf3d88 d5e4090177 Kevin Wolf:
 blkdebug: Add 'delay-ns' option
4a3684ef68 9ac5aa7227 Matt Turner:
 linux-user/sh4: Fix setup_sigtramp to match Linux kernel trampoline pattern
4b7971a1cb c3176e6457 Matt Turner:
 linux-user/sh4: Fix target_ucontext tuc_link field type
ac7b9fabf2 6b5aef7cac Helge Deller:
 linux-user: Fix AT_EXECFN in AUXV for symlinked programs
4719d2b9cc 2293d8b4bd Klaus Jensen:
 hw/nvme: fix admin cq msix setup
3b98370b55 a86024eb2d Scott J. Goldman:
 target/arm/hvf: Fix WFI halting to stop idle vCPU spinning
420e10994e 039b057c09 Peter Maydell:
 tests/functional/qemu_test/asset.py: Don't use setxattr when it doesn't exist
c752106ad8 4e8ac6857f Peter Maydell:
 hw/remote/machine.c: Mark x-remote machine as OK for AArch64 and AArch32
157ffbec17 a163fc1f86 Peter Maydell:
 meson.build: Add -fzero-init-padding-bits=all
c4009746a0 0129c62650 Peter Maydell:
 tests/qtest/iommu-smmuv3-test: Skip if no TCG GICv3 device present
1feb9d6a77 6197c11dd5 Chad Jablonski:
 ati-vga: fix ati_set_dirty address calculation
b0138ca68c a824f3531a Peter Maydell:
 hw/i2c/microbit_i2c: Don't index off end of twi_read_sequence[]
8a1c8e6ac0 c6aa2d0ac1 Cédric Le Goater:
 aspeed/hace: Prevent total_req_len overflow
ed260dcebc 534a52755b Cédric Le Goater:
 aspeed/hace: Fix out-of-bounds read in has_padding()
2f35979b2e ff36712da5 Kane Chen:
 hw/misc/aspeed_sbc: Add bounds checking for OTP write operations
5252f197ac 27d14251b9 Peter Maydell:
 hw/display/cirrus_vga: Fix packed-24 color-expansion transparent copies
7041b86a3c aefeecb413 Peter Maydell:
 hw/display/cirrus_vga: Fix packed-24 color-expansion transparent pattern fills
9eae322cfe 042dbcff83 Jeuk Kim:
 hw/ufs: Zero reserved bytes in REPORT LUNS response header
ee06b266e0 619c2da19a Jeuk Kim:
 hw/ufs: Keep MCQ SQs alive while requests are outstanding
5afb510a90 4a909c00b9 Jeuk Kim:
 hw/ufs: Reject zero-depth MCQ queues
5708138f82 283d921e77 Jeuk Kim:
 hw/ufs: Guard MCQ CQ accesses against missing queues
1abdb1cf4a 332ea29787 Jeuk Kim:
 hw/ufs: Validate MCQ SQ references before use
f7a6489b50 b4ec2e8dae Fabiano Rosas:
 tests/functional: Make socat wait longer in migration exec test
6a15005290 b33fd8ab1c Gerd Hoffmann:
 hw/uefi: check auth.hdr_length minimum size
4139cf452f b4680c02b8 Gerd Hoffmann:
 hw/uefi: avoid possibly unaligned variable_auth_2 struct field access
02b593d4dc 22b7b222d8 Gerd Hoffmann:
 hw/uefi: verify data size before accessing it in wrap_pkcs7
2c4c582f3f c45b460d16 Gerd Hoffmann:
 hw/uefi: add name_size check to uefi_vars_mm_lock_variable()
5c358eabe6 5247b3034c Gerd Hoffmann:
 hw/uefi: fix ucs2 string helper functions
023f87ab68 94d9a8b2c9 Gerd Hoffmann:
 hw/uefi: verify pio_xfer_offset before calculating buffer checksum
4c6e8882e4 f252769a23 Gerd Hoffmann:
 hw/uefi: fix buffer overruns
9baeca885a 18b664c900 Peter Maydell:
 hw/misc/bcm2835_rng: Specify valid memory access sizes
a7a21ed905 f443b68763 Peter Maydell:
 target/arm: Report IL=0 for Thumb 16-bit BKPT insn
1d45337ad5 41c417290d Philippe Mathieu-Daudé:
 target/microblaze: Fix endianness used to disassemble
7e96799ae4 455a6167f2 Peter Xu:
 migration: Fix low possibility downtime violation
ac0379ca04 f77a7cec9f Fabiano Rosas:
 migration: Use QAPI_CLONE_MEMBERS in migrate_params_test_apply
09704f9ad0 f35f0f1ca1 liugan1:
 hw/intc/arm_gicv3: Fix NS write to ICC_AP1Rn_EL1 when prebits < 7
f6ea8ca7ff a7f27d6903 宋文武:
 hw/net/allwinner-sun8i-emac: Flush queued packets when rx is enabled
d1b461131f 774e6f5c15 Vivien LEGER:
 hw/ppc/e500: fix bus-frequency property hardcoded to zero in CPU FDT node
a1b948a640 1aee8067fc kiki:
 hw/intc/xics: Add a check for an invalid server id
ac0c2898d8 9667bf3249 Helge Deller:
 linux-user: Translate errno in IP_RECVERR and IPV6_RECVERR
54ffa51e9e 08dc3e240f Helge Deller:
 linux-user: Allow getsockopt() with NULL optval address
855a3577eb 9fb681792d Helge Deller:
 linux-user: Flush errors by using exit() instead of _exit() in error path
95d1444532 dcb6e96257 Helge Deller:
 linux-user: Add missing CDROM ioctls
9623f7904d 5dcc64828d Alistair Francis:
 target/riscv: Use ELEN for Fractional LMUL check
936b32f639 175afdb0d1 Alistair Francis:
 target/riscv: Don't OR mip.SEIP when mvien is one
cbe17d7158 d107b74807 Alistair Francis:
 target/riscv: Generate access fault if sc comparison fails
69051eae69 14808578cc Munkhbaatar Enkhbaatar:
 riscv_htif: reject invalid signature ranges (end <= begin)
29e28b4845 d5b33fc180 Sebastián Alba Vives:
 hw/intc: fix heap OOB in ACLINT MTIMER multi-socket
7c74dcaa74 b2e874bfec Sebastián Alba Vives:
 target/riscv: fix stale ptshift and base on page walk restart
7f8e33765c 4cb2f91773 Yicong Yang:
 hw/riscv/virt-acpi-build.c: Use kvm timer frequency when kvm enabled
4d7eea2208 57abf6b1d5 Luc Michel:
 hw/core/register: add register_array_get_owner
ad0a9ac68f b8c2426157 Daniel P. Berrangé:
 util: fix use of pthread_get_name_np on OpenBSD
152148d99f 9e7734ead1 Helge Deller:
 linux-user: Flush errors by using exit() instead of _exit() in error path
55cd56c340 e2af3eadc0 Helge Deller:
 linux-user: Use abi_int for imr_ifindex in ip_mreqn struct
fb45f3fa70 b03a6ac6fa Helge Deller:
 linux-user: Fix CLONE_PARENT_SETTID when using fork-like clone
46c448b734 07c7decaa5 Helge Deller:
 linux-user: Add getsockopt() for SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
65632719e0 edb4588309 Helge Deller:
 linux-user: Add setsockopt() for SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
f814bacf30 8b60ed8354 Helge Deller:
 linux-user: Define SO_TIMESTAMP*_NEW and SO_RCVTIMEIO_NEW
c313116493 4c681ba3b8 James Hilliard:
 linux-user/mips: sync k0 TLS for EF_MIPS_MACH_OCTEON userlands
ee343bd577 1730e6f33f Alistair Francis:
 linux-user/strace: Use pointer type for read and write values
8bbc215d36 784f1dde90 Richard Henderson:
 linux-user/arm/nwfpe: Use thread-local storage for qemufpa
8094e5266f c8ea175900 Richard Henderson:
 linux-user/arm/nwfpe: Replace user_registers with current_cpu
e3c738c933 93484c768f Gyorgy Tamasi:
 linux-user: Don't define target_stat64 struct for loongarch64
5666ae83e4 029f10e852 Yixin Wei:
 linux-user: fix off-by-one in host_to_target_for_each_rtattr()
6a1a12f2fb 654dce6c52 Matt Turner:
 linux-user/ppc: Fix ppc64 rt_sigframe stack offset
18577776c8 3ab47a47d7 Thomas Huth:
 hw/sh4/sh7750: Remove forgotten abort() in the MM_ITLB_DATA handler
4bf9eb3f09 c0306d2b8f Thomas Huth:
 hw/misc: Fix the valid access size to the avr-power device
08fd68d58f 0990cc8b28 Junjie Cao:
 ati-vga: fix unsigned integer overflow in cursor bounds checks
5f9eb150ab d41ce10d0f Vladimir Sementsov-Ogievskiy:
 migration: vmstate_save_state_v: fix double error_setg
0ed63c35e8 30fad722ce Alex Bennée:
 hw/display: don't accidentally autofree existing virgl resources
674221887f 7077c83f71 Anthony Roberts:
 ui/sdl2: Fix assumption of EGL presence at runtime
e08ba49327 79bc177186 Stepan Popov:
 meson: add missing semicolon in pthread_condattr_setclock test
44cf0611b0 76ad26dd17 Paolo Bonzini:
 target/i386/tcg: fix decoding of MOVBE and CRC32 in 16-bit mode
80e8d7f683 7d6231dfb5 Magnus Kulke:
 target/i386/mshv: Fix segment regression in MMIO emu
03de9b1154 c906c23370 rickgcn:
 hw: i386: vapic: restore IRQ polling for non-kernel irqchip backends
4052595a93 3eae91a8b9 Simon Scherer:
 target/i386: fix missing PF_INSTR in SIGSEGV context
0f82275c22 87e1226e6f Marc-André Lureau:
 target/i386: fix strList leak in x86_cpu_get_unavailable_features
7d78c44577 027ad866bd Pierrick Bouvier:
 target/arm/tcg/translate.c: remove MO_TE usage
a7bd89ffdf 181fdf8a7e Marc-André Lureau:
 ui/console-vc: fix off-by-one in CSI J 2 (clear entire screen)
67e82da858 52cf667ed2 GuoHan Zhao:
 ui/spice-app: detect runtime directory creation failures
3e0ac2885e 7437b3eab6 Werner de Carne:
 serial COM: windows serial COM PollingFunc don't sleep


