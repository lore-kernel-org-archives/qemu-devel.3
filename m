Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9825C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2026 08:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdOPl-0005xY-DQ; Sat, 27 Jun 2026 04:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wdOPg-0005uE-7Q; Sat, 27 Jun 2026 04:29:20 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wdOPc-0005OE-PB; Sat, 27 Jun 2026 04:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782548942; bh=SKTLuUQHdpuILY0tGVNsVl4KdptysQHh5vg6V3aBW8U=;
 h=Subject:From:To:Cc:Date;
 b=LkU5cBu0belzbnWlv9Zx2cvh1HFCysflZ25AwiblDt5z7QqefECaQlr+j9BiVGrKN
 svqLm/KC4gjkn3trmC6BV4ipYQLXbejVLRvAWFa8ct56o8NCBBt4Y91Vq/MfheWjEz
 HpUURJgHd6+Ff1L2+3TfMedQB/dPoHVaiGJVcx2ZYwcA3pH+bVuxrrc62/Xj6jz6G6
 sOK3xRjVtd2R8nbNYQp6s+KAF5WV8Qb4kktD+89ia8UPS5+D5BV9AMdxw9fj8X1Q7R
 LCIO/DPoYyD7FuoSiozWRXH39PSc+IqB3ex2a7vycMbhi0rlU784jw6C0XaJNh1Ks2
 5HHc9nvyazViw==
Received: from think4mjt.localdomain (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by isrv.corpit.ru (Postfix) with ESMTP id 227EA1BB82D;
 Sat, 27 Jun 2026 11:29:02 +0300 (MSK)
Received: by think4mjt.localdomain (Postfix, from userid 1000)
 id 181C717AB6B; Sat, 27 Jun 2026 11:29:13 +0300 (MSK)
Subject: [ANNOUNCE] QEMU 11.0.2 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260627082913.181C717AB6B@think4mjt.localdomain>
Date: Sat, 27 Jun 2026 11:29:13 +0300 (MSK)
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

The QEMU v11.0.2 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-11.0.2.tar.xz
  https://download.qemu.org/qemu-11.0.2.tar.xz.sig (signature)

v11.0.2 is now tagged in the official qemu.git repository, and the
stable-11.0 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-11.0

There are 107 changes since the previous v11.0.1 release.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-11.0-hash master-hash Author Name: Commmit-Subject):

e545d8bb9d Michael Tokarev:
 Update version for 11.0.2 release
1a212f09df 156e536a7b Akshit Yadav:
 linux-user: Fix AT_PHDR when program headers are relocated into their own segment
eb6e366ec9 c7209c5671 Aditya Gupta:
 hw/pci: Replace assert with bounds check and return
2fbc7d3258 2181097812 Aditya Gupta:
 ppc/pnv_phb3: Error out on invalid config access
a35a6ea811 54e08dbe8f Matt Turner:
 linux-user/xtensa: fix unlock of uninitialized frame pointer on sigreturn
325a52f543 6858e3a71c Matt Turner:
 linux-user/xtensa: save/restore FP registers across signal delivery
0e656ebb28 7e859bacea Matt Turner:
 target/xtensa: add cpu_set_fcr/fsr helpers to sync fp_status
271af539f5 06fd39e426 Scott J. Goldman:
 target/arm/hvf: Stop pre-allocating cpreg_vmstate arrays
2fea261575 490a3e1867 Ryan Zhang:
 ui/sdl2: Set GL ES profile before creating initial GL context
45ebaadb27 6157908503 Akihiko Odaki:
 ui/sdl2: Explicitly specify EGL platform
a7f9127b59 08750e31fc Christian Schoenebeck:
 hw/9pfs: reject . and .. in Twstat rename
00737c895c 7f5445e7e4 Christian Schoenebeck:
 hw/9pfs: fix abort due to illegal name with Twstat rename
91ac276542 88d39a2937 Mathias Krause:
 gdbstub: Update x86 control register bits
77e8e0a3ae e38d0afade Paolo Bonzini:
 target/i386: apply mod to immediate count of an RCL/RCR operation
41d5a45d24 d6601a7e1c Gerd Hoffmann:
 hw/uefi: fix parse_hexstr
80fd822559 9f550a0b63 Abhigyan Kumar:
 target/riscv: mask vxrm csrw write to the low 2 bits
a74e04e798 758dce9c98 Daniel Henrique Barboza:
 disas/riscv.c: fix inst_length()
b70e1f3995 601c8494c6 Daniel Henrique Barboza:
 target/riscv/tcg: disable svnapot if satp_mode < sv39
d7f41618b9 8e090ecfa9 Daniel Henrique Barboza:
 target/riscv/cpu_helper.c: add PMA access fault
c261475005 3e33da68f1 Daniel Henrique Barboza:
 target/riscv/cpu_helper.c: fault with reserved PTE.PBMT val
2ba95623e1 d6c5855c76 Daniel Henrique Barboza:
 target/riscv/insn_trans/trans_rvzicbo.c.inc: save opcode before helpers
49ee7bf6dc 9273cda722 Daniel Henrique Barboza:
 disas/riscv.c: add 'cbo' insns to disassembler
343cb3cf68 ddfd33f196 Daniel Henrique Barboza:
 target/riscv/csr.c: fix mstatus.UXL reserved value
260bdfef90 18645f1957 Daniel Henrique Barboza:
 target/riscv/csr.c: do not allow mstatus MPV/GVA writes
244000e2d5 109856754c Daniel Henrique Barboza:
 target/riscv/tcg: disable svpbmt if satp_mode < sv39
8f9caaab91 d85a4ec06a Daniel Henrique Barboza:
 target/riscv/cpu_helper.c: allow LOAD_ADDR_MIS promotion to AMO fault
205f7b9d8d eceff0982f Eugenio Pérez:
 virtio: Allow to fill a whole virtqueue in order
24666f2b91 291aa70ad2 Alejandro Jimenez:
 amd_iommu: Reject non-decreasing NextLevel in fetch_pte()
52908f2cc1 786550e2d3 Alejandro Jimenez:
 amd_iommu: Follow root pointer before page walk and use 1-based levels
cb326591b3 9f1b6d013d Stefano Garzarella:
 libvduse: fix buffer overflow in vduse_queue_read_indirect_desc()
92d7bb038e 85805ee887 Stefano Garzarella:
 libvhost-user: fix buffer overflow in virtqueue_read_indirect_desc()
36d1385019 8a1c09cbd3 Costas Argyris:
 tests/qtest: Add amd-iommu command buffer head wrap test
7d07b86a62 3c98e446af Alejandro Jimenez:
 amd_iommu: Update command buffer head ptr in MMIO region after wraparound
1aea3c267d 3097d54016 Paolo Bonzini:
 amd_iommu: restrict command buffer head/tail ranges to ring size
ad16d5938d fb4c08147b Dominique Martinet:
 linux-user: add preadv2/preadv2
0528c5b23f ae84c738e4 Thomas Huth:
 system/rtc: Fix a possible year-2038 integer overflow problem
7e6f47e08c 6e0aa9f6c7 Xinhui Yang:
 linux-user/strace: add fsmount series of syscalls
ee1ac6a68f 767c32fe69 Xinhui Yang:
 linux-user: implement fsmount(2) series of syscalls
f80b72b4a5 a6a1f92d5a Richard Henderson:
 fpu: Handle all rounding modes in partsN_uncanon_normal
3ab9adb3cb 163f9a4e06 Munkhbaatar Enkhbaatar:
 hw/usb/hcd-ohci: Clean up USBPacket before freeing ISO TD packet
b29be616b8 7e573b660f Fabiano Rosas:
 qed: Don't try to flush during incoming migration
e9a930bb27 ba20257d9b Fiona Ebner:
 iotests: test shared mmap for fuse export
636c8430cc d1664a4058 Fiona Ebner:
 block/export/fuse: set FUSE_DIRECT_IO_ALLOW_MMAP flag to fix regression
2ae11f5049 817cc2d045 Fiona Ebner:
 block/export/fuse: use struct fuse_init_in
d7fca23e0a 1d47eb6898 Thomas Lamprecht:
 qcow2: Fix data loss on zero write with detect-zeroes=unmap
7596703755 389f5bcc74 Kevin Wolf:
 iotests/046: Test that discard/write_zeroes wait for dependencies
7534bb105b b8bfb1478d Kevin Wolf:
 qcow2: Fix corruption on discard during write with COW
5ea9da3a01 7f8466e2ce Kevin Wolf:
 qemu-io: Add 'aio_discard' command
f5e2c6906c aeea0c2804 Stefan Hajnoczi:
 virtio-blk: add missing VIRTIO_BLK_T_SCSI_CMD size check (CVE-2026-48914)
a27aa952a5 b4e28c304b Fiona Ebner:
 block/io: fallback to bounce buffer if BLKZEROOUT is not supported because of alignment
55b445a534 2d3dc20d9d Jithu Joseph:
 hw/i3c: fix CMD/data FIFO depth reset values to match real silicon
54d1f797ea 442f727b8b Farhan Ali:
 s390x/pci: Fix interrupt forwarding disable for interpreted devices
a8a7e13c24 1f1ccb6f3c Alexandra Winter:
 target/s390x: Make container ids in SysIB_15x 1-based
ca66c7ab2b 29c042c6e9 Stefan Hajnoczi:
 lcitool: remove Cirrus CI support
250ae60686 4023f38b50 Stefan Hajnoczi:
 gitlab: remove x64-freebsd-14-build Cirrus job
0cf6b8d5f3 7684e78132 Alex Bennée:
 gitlab: add initial MacOS 15 on gitlab runner
e56949d599 984b192bdf Alex Bennée:
 ci: drop cirrus MacOS build
a1bf8c5f97 05221c600a Denis V. Lunev:
 tests/unit: add test-envlist covering setenv/unsetenv name matching
ad43a20289 c131ae56c1 Denis V. Lunev:
 util/envlist: fix prefix-match in envlist_unsetenv() name lookup
c394949ff2 5a8da7e979 sin99xx:
 9pfs: fix missing rename lock in v9fs_co_readdir_many (CVE-2026-48004)
c81813227f 198627807a Christian Schoenebeck:
 tests/9pfs: add deep absolute path test
a967be3368 be33c56898 Christian Schoenebeck:
 tests/qtest/libqos: add qvirtqueue_reset_pool() for descriptor pool reset
689a3360b9 3802c0e755 Christian Schoenebeck:
 hw/9pfs: let callers of v9fs_path_sprintf() and v9fs_fix_path() handle errors
ae45e8f2d7 54dd352c59 Christian Schoenebeck:
 hw/9pfs: add error handling to v9fs_fix_path()
8ceeaa588d dbaf84e148 Christian Schoenebeck:
 hw/9pfs: change V9fsPath.size to size_t and v9fs_path_sprintf() return type
e1ffb20025 abb0cc02fb Christian Schoenebeck:
 hw/9pfs: add NULL check in v9fs_path_is_ancestor()
7a8e4361f7 2762cd51ee Matt Turner:
 linux-user/s390x: restore fpu_status rounding mode from FPC on sigreturn
568f82fbe4 a740f17ed0 Matt Turner:
 linux-user/sh4: restore FP rounding mode on sigreturn
07aca8fcdb 6bf4c0295c Matt Turner:
 linux-user/sh4: preserve T/M/Q bits across signal delivery
defa1f394b 84b920ccb5 Matt Turner:
 linux-user/mips: save/restore FCSR across signal delivery
f4806650a2 3f50dd4666 Matt Turner:
 linux-user/ppc: restore fp_status from FPSCR on sigreturn
a615c04ebc 71d027cfee Peter Maydell:
 hw/net/rocker_of_dpa: Avoid unaligned accesses in _of_dpa_flow_match()
e752dc57a1 8526b7d6b6 Peter Maydell:
 hw/net/rocker_of_dpa: Check group ID pointers are not NULL
5d69b29970 ca33de9844 Peter Maydell:
 target/arm: SME BFCVT, BFCVTN have "Alternate BFloat16 behaviors"
cc117d60ca bb95753047 Peter Maydell:
 target/arm: Don't assert if 64-bit EL2 AT insn sees a Domain fault
66e27eebb6 f12e7ba6f4 Richard Henderson:
 target/arm: Enable REVD for SVE2.1
b6e4902db0 e6c47bebdf Chenyi Qiang:
 vfio/container: Restrict dma_map_file() to shared RAM or RAM devices
8502282188 497b5c5b05 GuoHan Zhao:
 vfio-user: reject zero migration page size capability
b71979a932 ab89d02dac GuoHan Zhao:
 vfio-user: reject zero DMA page size capability
f0a2a8a3b3 23ece2805f Peter Maydell:
 target/arm: Set correct fp flags for FLOGB when FPCR.AH = 1
8f4bc211bd aa42300f86 Peter Maydell:
 target/arm: Use FPST_A64_F16 for SVE FCVTLT_hs
199f2f421a 446050c4df Peter Maydell:
 target/arm: SVE2 FMAXP, FMINP must honour AH=1
a24ef7392c 6864bec553 Denis V. Lunev:
 block/linux-aio: bound ioq_submit() recursion depth
6ccf7cb645 4b6c088c88 Jinjie Ruan:
 mc146818rtc: Fix get_guest_rtc_ns() overflow bug
8fe938347f 153dc2fa7b Paolo Bonzini:
 apic: fix delivery bitmask with modified xAPIC ids
c02143e02c 4494dec8c2 Paolo Bonzini:
 lsi53c895a: clear tag byte when processing messages
936662d8ca 5297a0fc65 Paolo Bonzini:
 lsi53c895a: fix use-after-free of cancelled request
bccd2c7d60 e56b4bbff1 Heechan Kang:
 ui: fix validation of VNC extended clipboard data length
5228799f15 d0c7b82d3a Daniel P. Berrangé:
 ui/vnc: fix OOB read updating VNC update frequency stats
52155a6aff 46ee49034d Daniel P. Berrangé:
 ui/vnc: fix OOB write in lossy rect worker code
00589953cc c3c6226fa4 Daniel P. Berrangé:
 ui/vnc: fix OOB write in VNC stats array
dde0087a1b ae18df638f Daniel P. Berrangé:
 ui/vnc: fix OOB read access in VNC SASL mechname array
6011135032 6033df08e9 Matt Turner:
 linux-user/mips64: fix mipsn32 elf_core_copy_regs entry width
a3b7cb02ba dd3a906d35 Matt Turner:
 linux-user/mips64: fix elf_core_copy_regs register layout in core files
8854550cdf 0228410837 Portia Stephens:
 target/riscv: Make hpmcounterh return the upper 32-bits
5cf3aa87b2 53cc9747ed Daniel Henrique Barboza:
 target/riscv/csr.c: fix read of pmpaddr(0-63) CSRs
d125c17ede 8158a74f0a Zishun Yi:
 target/riscv: clear mseccfg on reset for all dependent extensions
b37104e31a 27f9566dcd Alistair Francis:
 target/riscv: Update the local interrupt mask
c86fc498f7 eccb1d6940 Zishun Yi:
 target/riscv: Add mseccfg to VMStateDescription
a0617f269b 612f22c19d Zishun Yi:
 target/riscv/pmp: Fix integer overflow in TOR and NA4 address computation
0b2ca8a66a a0946caf1d Abhigyan Kumar:
 target/riscv: Fix medeleg[11] read-only zero bit for M-mode ECALL
74ce371e7c e07077a766 Frank Chang:
 hw/char: Check interrupt after txctrl register is written
fb5c86c6a6 caf3bef5f0 Anton Blanchard:
 target/riscv: rvv: Handle source overlap of vector widening reduction instructions
78d5c57083 2494836232 Zishun Yi:
 target/riscv: Allow mseccfg access based on ext_zicfilp
81e9484f4d fcbd93e96b Andrew Jones:
 hw/riscv/riscv-iommu: Fix Svnapot 64KB pages
7e66ab1290 613bb1949f Frank Chang:
 target/riscv: Update MISA.X for non-standard extensions
fa2c8225a3 f0433a8bc4 Frank Chang:
 target/riscv: Update MISA.C for Zc* extensions
b65de8cedb 27b127d734 Daniel P. Berrangé:
 crypto: fix client side anonymous TLS credentials


