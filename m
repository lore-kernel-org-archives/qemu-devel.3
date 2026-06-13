Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C13ECD8CA8
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYV5G-0001MI-1S; Sat, 13 Jun 2026 16:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV5D-0001Ls-33; Sat, 13 Jun 2026 16:35:59 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV4z-0002uJ-5Y; Sat, 13 Jun 2026 16:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781382923; bh=pP+NNl6rNjzEe/0vunuhKi8fxJy1If6GaU/f7XnPjLY=;
 h=From:To:Cc:Subject:Date;
 b=noZkdNjyrRza2CJTn/lwhNJfmUXsWwKXamm9PBZLdrY5dfvnosVeezRYPlRYX2LhE
 osH6aVjqtnx5OJE7FPoeHP9rf35+f2DZZYVHtJWYklK+hYd/NJ8B/z+DPCal1NuNH+
 4Ak7luoF8hpulIcPp6pFffxqBcmNFkyHwZ5fS3UnOktQSSqllQ0N++jv9qtEceRf54
 wNr9b3zxd3J1LUATGNyLvvPVxveoVPTcpIhmDYhRnaCC863fxHFnWDfohakpFONGYS
 WumvAnPOzX9LMNqHoxR3oqLDIsmP/6uab5ukbCrKOb6+1mxUtWml4FPvdgKUyC6kZz
 WOqWYmWgazfZw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A1DE91B6EDA;
 Sat, 13 Jun 2026 23:35:23 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 14E163CE92C;
 Sat, 13 Jun 2026 23:35:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 00/72] Patch Round-up for stable 11.0.2,
 freeze on 2026-06-23
Date: Sat, 13 Jun 2026 23:34:26 +0300
Message-ID: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

The following patches are queued for QEMU stable v11.0.2:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-11.0

Patch freeze is 2026-06-23, and the release is planned for 2026-06-25:

  https://wiki.qemu.org/Planning/11.0

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 27b127d7348a Daniel P. Berrangé:
   crypto: fix client side anonymous TLS credentials
02 f0433a8bc4ac Frank Chang:
   target/riscv: Update MISA.C for Zc* extensions
03 613bb1949fff Frank Chang:
   target/riscv: Update MISA.X for non-standard extensions
04 fcbd93e96be2 Andrew Jones:
   hw/riscv/riscv-iommu: Fix Svnapot 64KB pages
05 249483623242 Zishun Yi:
   target/riscv: Allow mseccfg access based on ext_zicfilp
06 caf3bef5f01e Anton Blanchard:
   target/riscv: rvv: Handle source overlap of vector widening reduction 
   instructions
07 e07077a76607 Frank Chang:
   hw/char: Check interrupt after txctrl register is written
08 a0946caf1d9e Abhigyan Kumar:
   target/riscv: Fix medeleg[11] read-only zero bit for M-mode ECALL
09 612f22c19db8 Zishun Yi:
   target/riscv/pmp: Fix integer overflow in TOR and NA4 address computation
10 eccb1d694025 Zishun Yi:
   target/riscv: Add mseccfg to VMStateDescription
11 27f9566dcd98 Alistair Francis:
   target/riscv: Update the local interrupt mask
12 8158a74f0a0d Zishun Yi:
   target/riscv: clear mseccfg on reset for all dependent extensions
13 53cc9747ed7c Daniel Henrique Barboza:
   target/riscv/csr.c: fix read of pmpaddr(0-63) CSRs
14 02284108376a Portia Stephens:
   target/riscv: Make hpmcounterh return the upper 32-bits
15 dd3a906d3505 Matt Turner:
   linux-user/mips64: fix elf_core_copy_regs register layout in core files
16 6033df08e93d Matt Turner:
   linux-user/mips64: fix mipsn32 elf_core_copy_regs entry width
17 ae18df638fb4 Daniel P. Berrangé:
   ui/vnc: fix OOB read access in VNC SASL mechname array
18 c3c6226fa481 Daniel P. Berrangé:
   ui/vnc: fix OOB write in VNC stats array
19 46ee49034d26 Daniel P. Berrangé:
   ui/vnc: fix OOB write in lossy rect worker code
20 d0c7b82d3a89 Daniel P. Berrangé:
   ui/vnc: fix OOB read updating VNC update frequency stats
21 e56b4bbff1df Heechan Kang:
   ui: fix validation of VNC extended clipboard data length
22 5297a0fc6531 Paolo Bonzini:
   lsi53c895a: fix use-after-free of cancelled request
23 4494dec8c2bf Paolo Bonzini:
   lsi53c895a: clear tag byte when processing messages
24 153dc2fa7bbe Paolo Bonzini:
   apic: fix delivery bitmask with modified xAPIC ids
25 4b6c088c88cc Jinjie Ruan:
   mc146818rtc: Fix get_guest_rtc_ns() overflow bug
26 6864bec553b2 Denis V. Lunev:
   block/linux-aio: bound ioq_submit() recursion depth
27 446050c4dfe4 Peter Maydell:
   target/arm: SVE2 FMAXP, FMINP must honour AH=1
28 aa42300f86d1 Peter Maydell:
   target/arm: Use FPST_A64_F16 for SVE FCVTLT_hs
29 23ece2805f9a Peter Maydell:
   target/arm: Set correct fp flags for FLOGB when FPCR.AH = 1
30 ab89d02dac6f GuoHan Zhao:
   vfio-user: reject zero DMA page size capability
31 497b5c5b05ac GuoHan Zhao:
   vfio-user: reject zero migration page size capability
32 e6c47bebdf86 Chenyi Qiang:
   vfio/container: Restrict dma_map_file() to shared RAM or RAM devices
33 f12e7ba6f438 Richard Henderson:
   target/arm: Enable REVD for SVE2.1
34 bb957530471c Peter Maydell:
   target/arm: Don't assert if 64-bit EL2 AT insn sees a Domain fault
35 ca33de98447c Peter Maydell:
   target/arm: SME BFCVT, BFCVTN have "Alternate BFloat16 behaviors"
36 8526b7d6b67b Peter Maydell:
   hw/net/rocker_of_dpa: Check group ID pointers are not NULL
37 71d027cfee85 Peter Maydell:
   hw/net/rocker_of_dpa: Avoid unaligned accesses in _of_dpa_flow_match()
38 3f50dd46664b Matt Turner:
   linux-user/ppc: restore fp_status from FPSCR on sigreturn
39 84b920ccb5ee Matt Turner:
   linux-user/mips: save/restore FCSR across signal delivery
40 6bf4c0295ccc Matt Turner:
   linux-user/sh4: preserve T/M/Q bits across signal delivery
41 a740f17ed0fb Matt Turner:
   linux-user/sh4: restore FP rounding mode on sigreturn
42 2762cd51ee03 Matt Turner:
   linux-user/s390x: restore fpu_status rounding mode from FPC on sigreturn
43 abb0cc02fb56 Christian Schoenebeck:
   hw/9pfs: add NULL check in v9fs_path_is_ancestor()
44 dbaf84e148b0 Christian Schoenebeck:
   hw/9pfs: change V9fsPath.size to size_t and v9fs_path_sprintf() return 
   type
45 54dd352c5926 Christian Schoenebeck:
   hw/9pfs: add error handling to v9fs_fix_path()
46 3802c0e755a5 Christian Schoenebeck:
   hw/9pfs: let callers of v9fs_path_sprintf() and v9fs_fix_path() handle 
   errors
47 be33c56898f8 Christian Schoenebeck:
   tests/qtest/libqos: add qvirtqueue_reset_pool() for descriptor pool reset
48 198627807a6b Christian Schoenebeck:
   tests/9pfs: add deep absolute path test
49 5a8da7e979f1 sin99xx:
   9pfs: fix missing rename lock in v9fs_co_readdir_many (CVE-2026-48004)
50 c131ae56c13f Denis V. Lunev:
   util/envlist: fix prefix-match in envlist_unsetenv() name lookup
51 05221c600a5f Denis V. Lunev:
   tests/unit: add test-envlist covering setenv/unsetenv name matching
52 984b192bdf37 Alex Bennée:
   ci: drop cirrus MacOS build
53 7684e7813290 Alex Bennée:
   gitlab: add initial MacOS 15 on gitlab runner
54 4023f38b50a4 Stefan Hajnoczi:
   gitlab: remove x64-freebsd-14-build Cirrus job
55 29c042c6e9d4 Stefan Hajnoczi:
   lcitool: remove Cirrus CI support
56 1f1ccb6f3c48 Alexandra Winter:
   target/s390x: Make container ids in SysIB_15x 1-based
57 442f727b8beb Farhan Ali:
   s390x/pci: Fix interrupt forwarding disable for interpreted devices
58 2d3dc20d9d71 Jithu Joseph:
   hw/i3c: fix CMD/data FIFO depth reset values to match real silicon
59 b4e28c304bc5 Fiona Ebner:
   block/io: fallback to bounce buffer if BLKZEROOUT is not supported 
   because of alignment
60 aeea0c2804c4 Stefan Hajnoczi:
   virtio-blk: add missing VIRTIO_BLK_T_SCSI_CMD size check (CVE-2026-48914)
61 7f8466e2ce62 Kevin Wolf:
   qemu-io: Add 'aio_discard' command
62 b8bfb1478d61 Kevin Wolf:
   qcow2: Fix corruption on discard during write with COW
63 389f5bcc744d Kevin Wolf:
   iotests/046: Test that discard/write_zeroes wait for dependencies
64 1d47eb689835 Thomas Lamprecht:
   qcow2: Fix data loss on zero write with detect-zeroes=unmap
65 817cc2d045d2 Fiona Ebner:
   block/export/fuse: use struct fuse_init_in
66 d1664a4058b2 Fiona Ebner:
   block/export/fuse: set FUSE_DIRECT_IO_ALLOW_MMAP flag to fix regression
67 ba20257d9b45 Fiona Ebner:
   iotests: test shared mmap for fuse export
68 7e573b660fef Fabiano Rosas:
   qed: Don't try to flush during incoming migration
69 163f9a4e0651 Munkhbaatar Enkhbaatar:
   hw/usb/hcd-ohci: Clean up USBPacket before freeing ISO TD packet
70 a6a1f92d5a23 Richard Henderson:
   fpu: Handle all rounding modes in partsN_uncanon_normal
71 767c32fe6983 Xinhui Yang:
   linux-user: implement fsmount(2) series of syscalls
72 6e0aa9f6c731 Xinhui Yang:
   linux-user/strace: add fsmount series of syscalls

