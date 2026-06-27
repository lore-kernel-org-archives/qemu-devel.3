Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8345C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2026 08:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdONW-0005EL-T3; Sat, 27 Jun 2026 04:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wdONT-0005Du-RJ; Sat, 27 Jun 2026 04:27:03 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wdONP-00053Q-Oj; Sat, 27 Jun 2026 04:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782548795; bh=Bip1NCwiSO4vpBEnicIUTHNOy5oWTTSsL+KnR60wlaQ=;
 h=Subject:From:To:Cc:Date;
 b=WZfxvUrHu3YaVqzULC60L9ZRU6YYZSsFM+tiKL48R8xzfGhhHtDpXQ6Lv1JVI3LRC
 OAIZokhsnqFB1dAWOUD4z/ms8ejpiqgXsLjQ0qRuK2pbUf2693QLRIwPkDzMwFkE40
 tGqleP9jtnHn5kmsXAwP1VsSv/u23N56W5JgqRldkc3gbRVzl3bANpVk1/1ZQ4DaCh
 wcQwqL/Egdndkmq/XEFaY0+CiuMPARr6bep8ygyPwoLcRfdmlrrT7XXZdSsNnDyudB
 2D8lcWCKbADgvpt9Q2OLch52s+FtSXpzoNpTsbXj1AYA9Ssn9Bfk3kPkGwtDsV7I48
 Ff89U6a66ok4Q==
Received: from think4mjt.localdomain (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by isrv.corpit.ru (Postfix) with ESMTP id EE98D1BB827;
 Sat, 27 Jun 2026 11:26:35 +0300 (MSK)
Received: by think4mjt.localdomain (Postfix, from userid 1000)
 id D825717AB67; Sat, 27 Jun 2026 11:26:46 +0300 (MSK)
Subject: [ANNOUNCE] QEMU 10.0.11 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260627082646.D825717AB67@think4mjt.localdomain>
Date: Sat, 27 Jun 2026 11:26:46 +0300 (MSK)
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

The QEMU v10.0.11 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-10.0.11.tar.xz
  https://download.qemu.org/qemu-10.0.11.tar.xz.sig (signature)

v10.0.11 is now tagged in the official qemu.git repository, and the
stable-10.0 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-10.0

There are 85 changes since the previous v10.0.10 release.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-10.0-hash master-hash Author Name: Commmit-Subject):

e3ad0582fd Michael Tokarev:
 Update version for 10.0.11 release
a34cc9750b 156e536a7b Akshit Yadav:
 linux-user: Fix AT_PHDR when program headers are relocated into their own segment
d55463da56 c7209c5671 Aditya Gupta:
 hw/pci: Replace assert with bounds check and return
d088b316c6 2181097812 Aditya Gupta:
 ppc/pnv_phb3: Error out on invalid config access
aec8aff4ef 54e08dbe8f Matt Turner:
 linux-user/xtensa: fix unlock of uninitialized frame pointer on sigreturn
07e6aa22bf 6858e3a71c Matt Turner:
 linux-user/xtensa: save/restore FP registers across signal delivery
2c11498d44 7e859bacea Matt Turner:
 target/xtensa: add cpu_set_fcr/fsr helpers to sync fp_status
c5333ef57b 490a3e1867 Ryan Zhang:
 ui/sdl2: Set GL ES profile before creating initial GL context
90d713b15b 08750e31fc Christian Schoenebeck:
 hw/9pfs: reject . and .. in Twstat rename
02a1f7835e 7f5445e7e4 Christian Schoenebeck:
 hw/9pfs: fix abort due to illegal name with Twstat rename
b7e3ea6eb3 88d39a2937 Mathias Krause:
 gdbstub: Update x86 control register bits
5f0e74c93d e38d0afade Paolo Bonzini:
 target/i386: apply mod to immediate count of an RCL/RCR operation
6e7d0ddfc2 d6601a7e1c Gerd Hoffmann:
 hw/uefi: fix parse_hexstr
e73255f1db 9f550a0b63 Abhigyan Kumar:
 target/riscv: mask vxrm csrw write to the low 2 bits
21ca98189e 758dce9c98 Daniel Henrique Barboza:
 disas/riscv.c: fix inst_length()
6464782893 8e090ecfa9 Daniel Henrique Barboza:
 target/riscv/cpu_helper.c: add PMA access fault
4463191962 3e33da68f1 Daniel Henrique Barboza:
 target/riscv/cpu_helper.c: fault with reserved PTE.PBMT val
9ad7b15c49 d6c5855c76 Daniel Henrique Barboza:
 target/riscv/insn_trans/trans_rvzicbo.c.inc: save opcode before helpers
09e8e27750 9273cda722 Daniel Henrique Barboza:
 disas/riscv.c: add 'cbo' insns to disassembler
e7efb2fa07 ddfd33f196 Daniel Henrique Barboza:
 target/riscv/csr.c: fix mstatus.UXL reserved value
7c9787408a 18645f1957 Daniel Henrique Barboza:
 target/riscv/csr.c: do not allow mstatus MPV/GVA writes
81073858e6 d85a4ec06a Daniel Henrique Barboza:
 target/riscv/cpu_helper.c: allow LOAD_ADDR_MIS promotion to AMO fault
6e676a01bb eceff0982f Eugenio Pérez:
 virtio: Allow to fill a whole virtqueue in order
5aee2ee368 9f1b6d013d Stefano Garzarella:
 libvduse: fix buffer overflow in vduse_queue_read_indirect_desc()
b55b909db6 85805ee887 Stefano Garzarella:
 libvhost-user: fix buffer overflow in virtqueue_read_indirect_desc()
6d4d9b69de 8a1c09cbd3 Costas Argyris:
 tests/qtest: Add amd-iommu command buffer head wrap test
aa6fc45019 3c98e446af Alejandro Jimenez:
 amd_iommu: Update command buffer head ptr in MMIO region after wraparound
57a8fe8c3d 3097d54016 Paolo Bonzini:
 amd_iommu: restrict command buffer head/tail ranges to ring size
b5c8e7d291 fb4c08147b Dominique Martinet:
 linux-user: add preadv2/preadv2
16df89d95f ae84c738e4 Thomas Huth:
 system/rtc: Fix a possible year-2038 integer overflow problem
f5e02d6a30 6e0aa9f6c7 Xinhui Yang:
 linux-user/strace: add fsmount series of syscalls
ec4c92057b 767c32fe69 Xinhui Yang:
 linux-user: implement fsmount(2) series of syscalls
31710e350a a6a1f92d5a Richard Henderson:
 fpu: Handle all rounding modes in partsN_uncanon_normal
e5b0b727a5 163f9a4e06 Munkhbaatar Enkhbaatar:
 hw/usb/hcd-ohci: Clean up USBPacket before freeing ISO TD packet
4c0acec503 7e573b660f Fabiano Rosas:
 qed: Don't try to flush during incoming migration
ae4c0e5730 1d47eb6898 Thomas Lamprecht:
 qcow2: Fix data loss on zero write with detect-zeroes=unmap
e60fa4a9f5 389f5bcc74 Kevin Wolf:
 iotests/046: Test that discard/write_zeroes wait for dependencies
9c3d7bf39f b8bfb1478d Kevin Wolf:
 qcow2: Fix corruption on discard during write with COW
827192607b 7f8466e2ce Kevin Wolf:
 qemu-io: Add 'aio_discard' command
d2e7fd9fe2 aeea0c2804 Stefan Hajnoczi:
 virtio-blk: add missing VIRTIO_BLK_T_SCSI_CMD size check (CVE-2026-48914)
01abfc1ae1 b4e28c304b Fiona Ebner:
 block/io: fallback to bounce buffer if BLKZEROOUT is not supported because of alignment
34cbeb27ff 442f727b8b Farhan Ali:
 s390x/pci: Fix interrupt forwarding disable for interpreted devices
e9f0c22c6a 1f1ccb6f3c Alexandra Winter:
 target/s390x: Make container ids in SysIB_15x 1-based
3c03b50076 05221c600a Denis V. Lunev:
 tests/unit: add test-envlist covering setenv/unsetenv name matching
69a43064dc c131ae56c1 Denis V. Lunev:
 util/envlist: fix prefix-match in envlist_unsetenv() name lookup
e9cd45327e 5a8da7e979 sin99xx:
 9pfs: fix missing rename lock in v9fs_co_readdir_many (CVE-2026-48004)
7e35875428 198627807a Christian Schoenebeck:
 tests/9pfs: add deep absolute path test
c56c4b8d1c be33c56898 Christian Schoenebeck:
 tests/qtest/libqos: add qvirtqueue_reset_pool() for descriptor pool reset
a336841626 3802c0e755 Christian Schoenebeck:
 hw/9pfs: let callers of v9fs_path_sprintf() and v9fs_fix_path() handle errors
a71e1a8cd1 54dd352c59 Christian Schoenebeck:
 hw/9pfs: add error handling to v9fs_fix_path()
658deac8cc dbaf84e148 Christian Schoenebeck:
 hw/9pfs: change V9fsPath.size to size_t and v9fs_path_sprintf() return type
501d01317e abb0cc02fb Christian Schoenebeck:
 hw/9pfs: add NULL check in v9fs_path_is_ancestor()
fbb903c605 44f51c1a3c Sean Wei:
 hw/9pfs: move G_GNUC_PRINTF to header
1f51ab5eb9 2762cd51ee Matt Turner:
 linux-user/s390x: restore fpu_status rounding mode from FPC on sigreturn
4ccb8c1604 a740f17ed0 Matt Turner:
 linux-user/sh4: restore FP rounding mode on sigreturn
fb08827358 6bf4c0295c Matt Turner:
 linux-user/sh4: preserve T/M/Q bits across signal delivery
bbad51c546 84b920ccb5 Matt Turner:
 linux-user/mips: save/restore FCSR across signal delivery
00335af674 3f50dd4666 Matt Turner:
 linux-user/ppc: restore fp_status from FPSCR on sigreturn
20589a3245 71d027cfee Peter Maydell:
 hw/net/rocker_of_dpa: Avoid unaligned accesses in _of_dpa_flow_match()
c878785913 8526b7d6b6 Peter Maydell:
 hw/net/rocker_of_dpa: Check group ID pointers are not NULL
c0a6758888 bb95753047 Peter Maydell:
 target/arm: Don't assert if 64-bit EL2 AT insn sees a Domain fault
fce3a467a6 23ece2805f Peter Maydell:
 target/arm: Set correct fp flags for FLOGB when FPCR.AH = 1
b3ae9008d0 aa42300f86 Peter Maydell:
 target/arm: Use FPST_A64_F16 for SVE FCVTLT_hs
38930e8fe4 446050c4df Peter Maydell:
 target/arm: SVE2 FMAXP, FMINP must honour AH=1
85692f4bd6 6864bec553 Denis V. Lunev:
 block/linux-aio: bound ioq_submit() recursion depth
f35327446b 4b6c088c88 Jinjie Ruan:
 mc146818rtc: Fix get_guest_rtc_ns() overflow bug
0fc3b3aa63 153dc2fa7b Paolo Bonzini:
 apic: fix delivery bitmask with modified xAPIC ids
efe581a63f 4494dec8c2 Paolo Bonzini:
 lsi53c895a: clear tag byte when processing messages
765c528ef0 5297a0fc65 Paolo Bonzini:
 lsi53c895a: fix use-after-free of cancelled request
527a3e84d6 e56b4bbff1 Heechan Kang:
 ui: fix validation of VNC extended clipboard data length
f0a2a6e87f d0c7b82d3a Daniel P. Berrangé:
 ui/vnc: fix OOB read updating VNC update frequency stats
fa7c684371 46ee49034d Daniel P. Berrangé:
 ui/vnc: fix OOB write in lossy rect worker code
21782c170d c3c6226fa4 Daniel P. Berrangé:
 ui/vnc: fix OOB write in VNC stats array
3e8558b0cb ae18df638f Daniel P. Berrangé:
 ui/vnc: fix OOB read access in VNC SASL mechname array
215f525e0b 8158a74f0a Zishun Yi:
 target/riscv: clear mseccfg on reset for all dependent extensions
9c63647c8d 27f9566dcd Alistair Francis:
 target/riscv: Update the local interrupt mask
8cff79c690 eccb1d6940 Zishun Yi:
 target/riscv: Add mseccfg to VMStateDescription
94fb9c29f2 b0daaa172a TANG Tiancheng:
 target/riscv: Save stimer and vstimer in CPU vmstate
2e8601ac14 612f22c19d Zishun Yi:
 target/riscv/pmp: Fix integer overflow in TOR and NA4 address computation
6622e096de a0946caf1d Abhigyan Kumar:
 target/riscv: Fix medeleg[11] read-only zero bit for M-mode ECALL
b36f00f785 e6051fa61b Frank Chang:
 hw/char: sifive_uart: Implement txctrl.txen and rxctrl.rxen
44725d33b6 61240e3a06 Florian Lugou:
 hw/char: sifive_uart: Avoid infinite delay of async xmit function
2ff5fd4be2 2494836232 Zishun Yi:
 target/riscv: Allow mseccfg access based on ext_zicfilp
3c5cffd170 fcbd93e96b Andrew Jones:
 hw/riscv/riscv-iommu: Fix Svnapot 64KB pages
3a942fbf06 613bb1949f Frank Chang:
 target/riscv: Update MISA.X for non-standard extensions
938e567b49 f0433a8bc4 Frank Chang:
 target/riscv: Update MISA.C for Zc* extensions


