Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07AF6CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcFmd-0004gW-9j; Wed, 24 Jun 2026 01:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFmX-0004cW-Kf; Wed, 24 Jun 2026 01:04:14 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFmU-0005DV-Fy; Wed, 24 Jun 2026 01:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782277439; bh=uyt8ug/PhxSrfKWHFywka70sF6sd1Ft9xqnOp6RmscQ=;
 h=From:To:Cc:Subject:Date;
 b=Cdo3Kb4K7XSZ7JBP4+BH6iWMUEHV8Qac5SR+CgtR0cspZpyRhRrJe/fVDHCGzkQe+
 ALg6I4B9UfuBckZNGclju4SRGDyqdlAhCRL1vLNyYhum0Hnf5d8zLIJpnzupNq7+yi
 QW4rEc/UEzLQBTQWYzQlKdonz0H5kF4sUc0aRyn5WguVF/eaOnVbFnUXhWBonIQxy4
 ep9F+169WR5NGEY2Or0t5q5GmnSEm0jZydNfCJEJ/+6G8WCw/2tFixtBLjrpOL+zKr
 F+HtZbJRWMS8JcbN14vfZJOQFKc9ZqqbofETckHdrKinTfkRnC7B/tgb22ye0C9OW0
 lbMN85RF+GYRQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A1E151BA62B;
 Wed, 24 Jun 2026 08:03:59 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7CE623DDAB6;
 Wed, 24 Jun 2026 08:04:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.11 v2 00/86] Patch Round-up for stable 10.0.11,
 freeze on 2026-06-23 (frozen)
Date: Wed, 24 Jun 2026 08:02:27 +0300
Message-ID: <qemu-stable-10.0.11-20260624080222@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v10.0.11:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-10.0

Patch freeze is 2026-06-23 (frozen), and the release is planned for 2026-06-25:

  https://wiki.qemu.org/Planning/10.0

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* f0433a8bc4ac Frank Chang:
   target/riscv: Update MISA.C for Zc* extensions
02* 613bb1949fff Frank Chang:
   target/riscv: Update MISA.X for non-standard extensions
03* fcbd93e96be2 Andrew Jones:
   hw/riscv/riscv-iommu: Fix Svnapot 64KB pages
04* 249483623242 Zishun Yi:
   target/riscv: Allow mseccfg access based on ext_zicfilp
05* 61240e3a06dc Florian Lugou:
   hw/char: sifive_uart: Avoid infinite delay of async xmit function
06* e6051fa61b9f Frank Chang:
   hw/char: sifive_uart: Implement txctrl.txen and rxctrl.rxen
07* a0946caf1d9e Abhigyan Kumar:
   target/riscv: Fix medeleg[11] read-only zero bit for M-mode ECALL
08* 612f22c19db8 Zishun Yi:
   target/riscv/pmp: Fix integer overflow in TOR and NA4 address computation
09* b0daaa172a1c TANG Tiancheng:
   target/riscv: Save stimer and vstimer in CPU vmstate
10* eccb1d694025 Zishun Yi:
   target/riscv: Add mseccfg to VMStateDescription
11* 27f9566dcd98 Alistair Francis:
   target/riscv: Update the local interrupt mask
12* 8158a74f0a0d Zishun Yi:
   target/riscv: clear mseccfg on reset for all dependent extensions
13* ae18df638fb4 Daniel P. Berrangé:
   ui/vnc: fix OOB read access in VNC SASL mechname array
14* c3c6226fa481 Daniel P. Berrangé:
   ui/vnc: fix OOB write in VNC stats array
15* 46ee49034d26 Daniel P. Berrangé:
   ui/vnc: fix OOB write in lossy rect worker code
16* d0c7b82d3a89 Daniel P. Berrangé:
   ui/vnc: fix OOB read updating VNC update frequency stats
17* e56b4bbff1df Heechan Kang:
   ui: fix validation of VNC extended clipboard data length
18* 5297a0fc6531 Paolo Bonzini:
   lsi53c895a: fix use-after-free of cancelled request
19* 4494dec8c2bf Paolo Bonzini:
   lsi53c895a: clear tag byte when processing messages
20* 153dc2fa7bbe Paolo Bonzini:
   apic: fix delivery bitmask with modified xAPIC ids
21* 4b6c088c88cc Jinjie Ruan:
   mc146818rtc: Fix get_guest_rtc_ns() overflow bug
22* 6864bec553b2 Denis V. Lunev:
   block/linux-aio: bound ioq_submit() recursion depth
23* 446050c4dfe4 Peter Maydell:
   target/arm: SVE2 FMAXP, FMINP must honour AH=1
24* aa42300f86d1 Peter Maydell:
   target/arm: Use FPST_A64_F16 for SVE FCVTLT_hs
25* 23ece2805f9a Peter Maydell:
   target/arm: Set correct fp flags for FLOGB when FPCR.AH = 1
26* bb957530471c Peter Maydell:
   target/arm: Don't assert if 64-bit EL2 AT insn sees a Domain fault
27* 8526b7d6b67b Peter Maydell:
   hw/net/rocker_of_dpa: Check group ID pointers are not NULL
28* 71d027cfee85 Peter Maydell:
   hw/net/rocker_of_dpa: Avoid unaligned accesses in _of_dpa_flow_match()
29* 3f50dd46664b Matt Turner:
   linux-user/ppc: restore fp_status from FPSCR on sigreturn
30* 84b920ccb5ee Matt Turner:
   linux-user/mips: save/restore FCSR across signal delivery
31* 6bf4c0295ccc Matt Turner:
   linux-user/sh4: preserve T/M/Q bits across signal delivery
32* a740f17ed0fb Matt Turner:
   linux-user/sh4: restore FP rounding mode on sigreturn
33* 2762cd51ee03 Matt Turner:
   linux-user/s390x: restore fpu_status rounding mode from FPC on sigreturn
34* 44f51c1a3cf4 Sean Wei:
   hw/9pfs: move G_GNUC_PRINTF to header
35* abb0cc02fb56 Christian Schoenebeck:
   hw/9pfs: add NULL check in v9fs_path_is_ancestor()
36* dbaf84e148b0 Christian Schoenebeck:
   hw/9pfs: change V9fsPath.size to size_t and v9fs_path_sprintf() return 
   type
37* 54dd352c5926 Christian Schoenebeck:
   hw/9pfs: add error handling to v9fs_fix_path()
38* 3802c0e755a5 Christian Schoenebeck:
   hw/9pfs: let callers of v9fs_path_sprintf() and v9fs_fix_path() handle 
   errors
39* be33c56898f8 Christian Schoenebeck:
   tests/qtest/libqos: add qvirtqueue_reset_pool() for descriptor pool reset
40* 198627807a6b Christian Schoenebeck:
   tests/9pfs: add deep absolute path test
41* 5a8da7e979f1 sin99xx:
   9pfs: fix missing rename lock in v9fs_co_readdir_many (CVE-2026-48004)
42* c131ae56c13f Denis V. Lunev:
   util/envlist: fix prefix-match in envlist_unsetenv() name lookup
43* 05221c600a5f Denis V. Lunev:
   tests/unit: add test-envlist covering setenv/unsetenv name matching
44* 1f1ccb6f3c48 Alexandra Winter:
   target/s390x: Make container ids in SysIB_15x 1-based
45* 442f727b8beb Farhan Ali:
   s390x/pci: Fix interrupt forwarding disable for interpreted devices
46* b4e28c304bc5 Fiona Ebner:
   block/io: fallback to bounce buffer if BLKZEROOUT is not supported 
   because of alignment
47* aeea0c2804c4 Stefan Hajnoczi:
   virtio-blk: add missing VIRTIO_BLK_T_SCSI_CMD size check (CVE-2026-48914)
48* 7f8466e2ce62 Kevin Wolf:
   qemu-io: Add 'aio_discard' command
49* b8bfb1478d61 Kevin Wolf:
   qcow2: Fix corruption on discard during write with COW
50* 389f5bcc744d Kevin Wolf:
   iotests/046: Test that discard/write_zeroes wait for dependencies
51* 1d47eb689835 Thomas Lamprecht:
   qcow2: Fix data loss on zero write with detect-zeroes=unmap
52* 7e573b660fef Fabiano Rosas:
   qed: Don't try to flush during incoming migration
53* 163f9a4e0651 Munkhbaatar Enkhbaatar:
   hw/usb/hcd-ohci: Clean up USBPacket before freeing ISO TD packet
54* a6a1f92d5a23 Richard Henderson:
   fpu: Handle all rounding modes in partsN_uncanon_normal
55* 767c32fe6983 Xinhui Yang:
   linux-user: implement fsmount(2) series of syscalls
56* 6e0aa9f6c731 Xinhui Yang:
   linux-user/strace: add fsmount series of syscalls
57 ae84c738e403 Thomas Huth:
   system/rtc: Fix a possible year-2038 integer overflow problem
58 fb4c08147ba7 Dominique Martinet:
   linux-user: add preadv2/preadv2
59 3097d54016ea Paolo Bonzini:
   amd_iommu: restrict command buffer head/tail ranges to ring size
60 3c98e446af82 Alejandro Jimenez:
   amd_iommu: Update command buffer head ptr in MMIO region after wraparound
61 8a1c09cbd3fe Costas Argyris:
   tests/qtest: Add amd-iommu command buffer head wrap test
62 85805ee887be Stefano Garzarella:
   libvhost-user: fix buffer overflow in virtqueue_read_indirect_desc()
63 9f1b6d013d42 Stefano Garzarella:
   libvduse: fix buffer overflow in vduse_queue_read_indirect_desc()
64 eceff0982f97 Eugenio Pérez:
   virtio: Allow to fill a whole virtqueue in order
65 d85a4ec06a65 Daniel Henrique Barboza:
   target/riscv/cpu_helper.c: allow LOAD_ADDR_MIS promotion to AMO fault
66 18645f195789 Daniel Henrique Barboza:
   target/riscv/csr.c: do not allow mstatus MPV/GVA writes
67 ddfd33f19658 Daniel Henrique Barboza:
   target/riscv/csr.c: fix mstatus.UXL reserved value
68 9273cda72293 Daniel Henrique Barboza:
   disas/riscv.c: add 'cbo' insns to disassembler
69 d6c5855c76b2 Daniel Henrique Barboza:
   target/riscv/insn_trans/trans_rvzicbo.c.inc: save opcode before helpers
70 3e33da68f1db Daniel Henrique Barboza:
   target/riscv/cpu_helper.c: fault with reserved PTE.PBMT val
71 8e090ecfa9e5 Daniel Henrique Barboza:
   target/riscv/cpu_helper.c: add PMA access fault
72 758dce9c98af Daniel Henrique Barboza:
   disas/riscv.c: fix inst_length()
73 9f550a0b6306 Abhigyan Kumar:
   target/riscv: mask vxrm csrw write to the low 2 bits
74 d6601a7e1c24 Gerd Hoffmann:
   hw/uefi: fix parse_hexstr
75 e38d0afade7c Paolo Bonzini:
   target/i386: apply mod to immediate count of an RCL/RCR operation
76 88d39a2937eb Mathias Krause:
   gdbstub: Update x86 control register bits
77 7f5445e7e405 Christian Schoenebeck:
   hw/9pfs: fix abort due to illegal name with Twstat rename
78 08750e31fcdc Christian Schoenebeck:
   hw/9pfs: reject . and .. in Twstat rename
79 116db2986b11 Christian Schoenebeck:
   hw/9pfs: consolidate name validation with check_name()
80 490a3e1867f0 Ryan Zhang:
   ui/sdl2: Set GL ES profile before creating initial GL context
81 7e859bacea09 Matt Turner:
   target/xtensa: add cpu_set_fcr/fsr helpers to sync fp_status
82 6858e3a71cc4 Matt Turner:
   linux-user/xtensa: save/restore FP registers across signal delivery
83 54e08dbe8f2a Matt Turner:
   linux-user/xtensa: fix unlock of uninitialized frame pointer on sigreturn
84 218109781209 Aditya Gupta:
   ppc/pnv_phb3: Error out on invalid config access
85 c7209c567181 Aditya Gupta:
   hw/pci: Replace assert with bounds check and return
86 156e536a7b97 Akshit Yadav:
   linux-user: Fix AT_PHDR when program headers are relocated into their own 
   segment

(commit(s) marked with * were in previous series and are not resent)

