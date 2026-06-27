Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92149C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2026 08:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdOPX-0005tt-MX; Sat, 27 Jun 2026 04:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wdOPW-0005t4-1B; Sat, 27 Jun 2026 04:29:10 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wdOPT-0005NM-Ph; Sat, 27 Jun 2026 04:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782548935; bh=gP/OeEKd/Kucy9Iy9Q3fhr+2t8VDw+G/+GrEnhboiQE=;
 h=Subject:From:To:Cc:Date;
 b=BRNkWmoCKXhTxRD/yONfbmeXOTDa5e2jUAxCPoDuCN5cosR2LbFYbCntNizIdo5iL
 4WyKfDbmyvRSo0+uIs4vSh/jHR4kGSLAmUC9Mj3W4QJHkxQ8y2ba75fViAo7/y1bld
 1umQsZNJcGFDcQEu/nPX5yR6CgoHZzuRfMBL1X6bZngmN0d7dLLdPZ9slcCfMK4F12
 3/thgFSj5SvyEI8ZSw2JPv2lPrWxLSg3td8ydStGt7xBOHQqgfsBfI0oEKk8jtvA1m
 bMfuUYK/HDY6LYLBqZz6BH8KRIDin/qE2bODI8Q8+X3ZY5eHGfI7HAMfOQK0WivarP
 O6q7yqQ2niLUw==
Received: from think4mjt.localdomain (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by isrv.corpit.ru (Postfix) with ESMTP id 18F471BB82C;
 Sat, 27 Jun 2026 11:28:55 +0300 (MSK)
Received: by think4mjt.localdomain (Postfix, from userid 1000)
 id 0891A17AB69; Sat, 27 Jun 2026 11:29:06 +0300 (MSK)
Subject: [ANNOUNCE] QEMU 10.2.4 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260627082906.0891A17AB69@think4mjt.localdomain>
Date: Sat, 27 Jun 2026 11:29:06 +0300 (MSK)
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

The QEMU v10.2.4 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-10.2.4.tar.xz
  https://download.qemu.org/qemu-10.2.4.tar.xz.sig (signature)

v10.2.4 is now tagged in the official qemu.git repository, and the
stable-10.2 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-10.2

This is expected to be the last release in 10.2.x series.

There are 94 changes since the previous v10.2.3 release.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-10.2-hash master-hash Author Name: Commmit-Subject):

3e0bcba1ca Michael Tokarev:
 Update version for 10.2.4 release
dd0ee6af65 156e536a7b Akshit Yadav:
 linux-user: Fix AT_PHDR when program headers are relocated into their own segment
c4bd8d7569 c7209c5671 Aditya Gupta:
 hw/pci: Replace assert with bounds check and return
7f9d07e217 2181097812 Aditya Gupta:
 ppc/pnv_phb3: Error out on invalid config access
bceecd60f4 54e08dbe8f Matt Turner:
 linux-user/xtensa: fix unlock of uninitialized frame pointer on sigreturn
be5b3bcab8 6858e3a71c Matt Turner:
 linux-user/xtensa: save/restore FP registers across signal delivery
35959a2e1f 7e859bacea Matt Turner:
 target/xtensa: add cpu_set_fcr/fsr helpers to sync fp_status
5ce8ce8ae1 490a3e1867 Ryan Zhang:
 ui/sdl2: Set GL ES profile before creating initial GL context
97455be941 08750e31fc Christian Schoenebeck:
 hw/9pfs: reject . and .. in Twstat rename
13fb032376 7f5445e7e4 Christian Schoenebeck:
 hw/9pfs: fix abort due to illegal name with Twstat rename
1f6b545bf2 88d39a2937 Mathias Krause:
 gdbstub: Update x86 control register bits
2eccca8141 e38d0afade Paolo Bonzini:
 target/i386: apply mod to immediate count of an RCL/RCR operation
c9e9794efe d6601a7e1c Gerd Hoffmann:
 hw/uefi: fix parse_hexstr
da1bd55372 9f550a0b63 Abhigyan Kumar:
 target/riscv: mask vxrm csrw write to the low 2 bits
58276e92dd 758dce9c98 Daniel Henrique Barboza:
 disas/riscv.c: fix inst_length()
38f9b1ab7e 601c8494c6 Daniel Henrique Barboza:
 target/riscv/tcg: disable svnapot if satp_mode < sv39
7ff877d4a5 8e090ecfa9 Daniel Henrique Barboza:
 target/riscv/cpu_helper.c: add PMA access fault
ef2c884673 3e33da68f1 Daniel Henrique Barboza:
 target/riscv/cpu_helper.c: fault with reserved PTE.PBMT val
70c4653d40 d6c5855c76 Daniel Henrique Barboza:
 target/riscv/insn_trans/trans_rvzicbo.c.inc: save opcode before helpers
d293278f68 9273cda722 Daniel Henrique Barboza:
 disas/riscv.c: add 'cbo' insns to disassembler
4686ecc71a ddfd33f196 Daniel Henrique Barboza:
 target/riscv/csr.c: fix mstatus.UXL reserved value
1b1ce90d17 18645f1957 Daniel Henrique Barboza:
 target/riscv/csr.c: do not allow mstatus MPV/GVA writes
e46cde90a8 109856754c Daniel Henrique Barboza:
 target/riscv/tcg: disable svpbmt if satp_mode < sv39
2b8147e719 d85a4ec06a Daniel Henrique Barboza:
 target/riscv/cpu_helper.c: allow LOAD_ADDR_MIS promotion to AMO fault
99685f9b0f eceff0982f Eugenio Pérez:
 virtio: Allow to fill a whole virtqueue in order
15e63b7baf 291aa70ad2 Alejandro Jimenez:
 amd_iommu: Reject non-decreasing NextLevel in fetch_pte()
ad734bea5f 786550e2d3 Alejandro Jimenez:
 amd_iommu: Follow root pointer before page walk and use 1-based levels
8dd516fb8d 9f1b6d013d Stefano Garzarella:
 libvduse: fix buffer overflow in vduse_queue_read_indirect_desc()
b57a0a6074 85805ee887 Stefano Garzarella:
 libvhost-user: fix buffer overflow in virtqueue_read_indirect_desc()
e95df98116 8a1c09cbd3 Costas Argyris:
 tests/qtest: Add amd-iommu command buffer head wrap test
8257e296a2 3c98e446af Alejandro Jimenez:
 amd_iommu: Update command buffer head ptr in MMIO region after wraparound
8f534ac546 3097d54016 Paolo Bonzini:
 amd_iommu: restrict command buffer head/tail ranges to ring size
6b9a3169c9 fb4c08147b Dominique Martinet:
 linux-user: add preadv2/preadv2
991a955c0f ae84c738e4 Thomas Huth:
 system/rtc: Fix a possible year-2038 integer overflow problem
c66b045e8e 6e0aa9f6c7 Xinhui Yang:
 linux-user/strace: add fsmount series of syscalls
bb78f2e214 767c32fe69 Xinhui Yang:
 linux-user: implement fsmount(2) series of syscalls
60a842b7b0 a6a1f92d5a Richard Henderson:
 fpu: Handle all rounding modes in partsN_uncanon_normal
20610cb4e2 163f9a4e06 Munkhbaatar Enkhbaatar:
 hw/usb/hcd-ohci: Clean up USBPacket before freeing ISO TD packet
e8bd35dc12 7e573b660f Fabiano Rosas:
 qed: Don't try to flush during incoming migration
a2658ebea8 1d47eb6898 Thomas Lamprecht:
 qcow2: Fix data loss on zero write with detect-zeroes=unmap
e8007fd576 389f5bcc74 Kevin Wolf:
 iotests/046: Test that discard/write_zeroes wait for dependencies
d85e00dd03 b8bfb1478d Kevin Wolf:
 qcow2: Fix corruption on discard during write with COW
b5d9c7b920 7f8466e2ce Kevin Wolf:
 qemu-io: Add 'aio_discard' command
4868c7e2b0 aeea0c2804 Stefan Hajnoczi:
 virtio-blk: add missing VIRTIO_BLK_T_SCSI_CMD size check (CVE-2026-48914)
60d7dc1e4c b4e28c304b Fiona Ebner:
 block/io: fallback to bounce buffer if BLKZEROOUT is not supported because of alignment
cfcd162a25 442f727b8b Farhan Ali:
 s390x/pci: Fix interrupt forwarding disable for interpreted devices
6988973554 1f1ccb6f3c Alexandra Winter:
 target/s390x: Make container ids in SysIB_15x 1-based
75186d2898 05221c600a Denis V. Lunev:
 tests/unit: add test-envlist covering setenv/unsetenv name matching
f133678a7e c131ae56c1 Denis V. Lunev:
 util/envlist: fix prefix-match in envlist_unsetenv() name lookup
1b39738f3b 5a8da7e979 sin99xx:
 9pfs: fix missing rename lock in v9fs_co_readdir_many (CVE-2026-48004)
4e004b7333 198627807a Christian Schoenebeck:
 tests/9pfs: add deep absolute path test
ae1239bebe be33c56898 Christian Schoenebeck:
 tests/qtest/libqos: add qvirtqueue_reset_pool() for descriptor pool reset
ec47de83c8 3802c0e755 Christian Schoenebeck:
 hw/9pfs: let callers of v9fs_path_sprintf() and v9fs_fix_path() handle errors
3d5a395596 54dd352c59 Christian Schoenebeck:
 hw/9pfs: add error handling to v9fs_fix_path()
98281c6c7b dbaf84e148 Christian Schoenebeck:
 hw/9pfs: change V9fsPath.size to size_t and v9fs_path_sprintf() return type
ac34777326 abb0cc02fb Christian Schoenebeck:
 hw/9pfs: add NULL check in v9fs_path_is_ancestor()
9b521ab4f8 2762cd51ee Matt Turner:
 linux-user/s390x: restore fpu_status rounding mode from FPC on sigreturn
1ae8a0c19b a740f17ed0 Matt Turner:
 linux-user/sh4: restore FP rounding mode on sigreturn
1c90ba5f94 6bf4c0295c Matt Turner:
 linux-user/sh4: preserve T/M/Q bits across signal delivery
27c8d295c1 84b920ccb5 Matt Turner:
 linux-user/mips: save/restore FCSR across signal delivery
ff0ec45901 3f50dd4666 Matt Turner:
 linux-user/ppc: restore fp_status from FPSCR on sigreturn
73682aabb6 71d027cfee Peter Maydell:
 hw/net/rocker_of_dpa: Avoid unaligned accesses in _of_dpa_flow_match()
2b2473835a 8526b7d6b6 Peter Maydell:
 hw/net/rocker_of_dpa: Check group ID pointers are not NULL
f8d04f4dac ca33de9844 Peter Maydell:
 target/arm: SME BFCVT, BFCVTN have "Alternate BFloat16 behaviors"
1d33b6607d bb95753047 Peter Maydell:
 target/arm: Don't assert if 64-bit EL2 AT insn sees a Domain fault
940dd1a30f f12e7ba6f4 Richard Henderson:
 target/arm: Enable REVD for SVE2.1
72ee171628 e6c47bebdf Chenyi Qiang:
 vfio/container: Restrict dma_map_file() to shared RAM or RAM devices
6215e6cacd 23ece2805f Peter Maydell:
 target/arm: Set correct fp flags for FLOGB when FPCR.AH = 1
2cbc32cf2b aa42300f86 Peter Maydell:
 target/arm: Use FPST_A64_F16 for SVE FCVTLT_hs
75f552089a 446050c4df Peter Maydell:
 target/arm: SVE2 FMAXP, FMINP must honour AH=1
a51b907129 6864bec553 Denis V. Lunev:
 block/linux-aio: bound ioq_submit() recursion depth
87f2e53429 4b6c088c88 Jinjie Ruan:
 mc146818rtc: Fix get_guest_rtc_ns() overflow bug
278e203a55 153dc2fa7b Paolo Bonzini:
 apic: fix delivery bitmask with modified xAPIC ids
81b834f458 4494dec8c2 Paolo Bonzini:
 lsi53c895a: clear tag byte when processing messages
2f69229f8b 5297a0fc65 Paolo Bonzini:
 lsi53c895a: fix use-after-free of cancelled request
5501ddefdd e56b4bbff1 Heechan Kang:
 ui: fix validation of VNC extended clipboard data length
a625c70daf d0c7b82d3a Daniel P. Berrangé:
 ui/vnc: fix OOB read updating VNC update frequency stats
ed14000163 46ee49034d Daniel P. Berrangé:
 ui/vnc: fix OOB write in lossy rect worker code
4f22b8179f c3c6226fa4 Daniel P. Berrangé:
 ui/vnc: fix OOB write in VNC stats array
3b489576ee ae18df638f Daniel P. Berrangé:
 ui/vnc: fix OOB read access in VNC SASL mechname array
d1cd4d92e3 6033df08e9 Matt Turner:
 linux-user/mips64: fix mipsn32 elf_core_copy_regs entry width
62211ae35b dd3a906d35 Matt Turner:
 linux-user/mips64: fix elf_core_copy_regs register layout in core files
c31bf31966 53cc9747ed Daniel Henrique Barboza:
 target/riscv/csr.c: fix read of pmpaddr(0-63) CSRs
145fbcd739 8158a74f0a Zishun Yi:
 target/riscv: clear mseccfg on reset for all dependent extensions
841b65421b 27f9566dcd Alistair Francis:
 target/riscv: Update the local interrupt mask
3831bb79a6 eccb1d6940 Zishun Yi:
 target/riscv: Add mseccfg to VMStateDescription
7c1766af7a 612f22c19d Zishun Yi:
 target/riscv/pmp: Fix integer overflow in TOR and NA4 address computation
69a494b797 a0946caf1d Abhigyan Kumar:
 target/riscv: Fix medeleg[11] read-only zero bit for M-mode ECALL
b946ccbc67 e07077a766 Frank Chang:
 hw/char: Check interrupt after txctrl register is written
e42c35ff87 e6051fa61b Frank Chang:
 hw/char: sifive_uart: Implement txctrl.txen and rxctrl.rxen
eb2bf63c37 caf3bef5f0 Anton Blanchard:
 target/riscv: rvv: Handle source overlap of vector widening reduction instructions
f47f133a69 2494836232 Zishun Yi:
 target/riscv: Allow mseccfg access based on ext_zicfilp
15e4d626eb fcbd93e96b Andrew Jones:
 hw/riscv/riscv-iommu: Fix Svnapot 64KB pages
fd6e3f752c 613bb1949f Frank Chang:
 target/riscv: Update MISA.X for non-standard extensions
11d81cdbb8 f0433a8bc4 Frank Chang:
 target/riscv: Update MISA.C for Zc* extensions


