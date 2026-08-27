Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA22C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 15:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzcTE-0007Jy-AB; Thu, 27 Aug 2026 11:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wzcTA-0007JQ-7z; Thu, 27 Aug 2026 11:56:48 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wzcT5-00050e-Sz; Thu, 27 Aug 2026 11:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787846192; bh=G3RjBRPUAtlo07mcYrKMiRh9ml6VdU1wJI/w17tlDZQ=;
 h=From:To:Cc:Subject:Date;
 b=nnj9ViidBVHi6NDU1rvk1m/LsP0csmXMYskt5qHHHdLUKOOiCvfIKrcOeQdF48zpf
 ED53rJNHHX7QaNOzLnw5ekjmOgfMCwJZ8jIlDYbUWjXI4i+yDr6JpRBHoOxq73xlyZ
 ZRwZtrV64oXq4Xk14SymdFVN3TBuuCFltq/BTU36E4RYjkhCve7aMQdARacTqMmeb2
 2EJqy6HKst2XVaxalB6yicto6mygTK5xXsdsfCgmocRHDDolPXFePGKJ4ON84+nl0R
 ZuRnBxextCQOW4F4LJ6KbqvPE2qPcpQKoQNRoaXOyMvvT/Wk1ykqM5IMVxwJBfi5Jh
 vLtmziyfU2n7g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EFADE1CF28D;
 Thu, 27 Aug 2026 18:56:32 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 34CB0419489;
 Thu, 27 Aug 2026 18:56:36 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 6B9B336395; Thu, 27 Aug 2026 18:56:00 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [ANNOUNCE] QEMU 11.0.4 Stable released
Date: Thu, 27 Aug 2026 18:55:58 +0300
Message-ID: <20260827155559.639055-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi everyone,

The QEMU v11.0.4 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-11.0.4.tar.xz
  https://download.qemu.org/qemu-11.0.4.tar.xz.sig (signature)

v11.0.4 is now tagged in the official qemu.git repository, and the
stable-11.0 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-11.0

There are 196 changes since the previous v11.0.3 release.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-11.0-hash master-hash Author Name: Commmit-Subject):

81fd11739e6 Michael Tokarev:
 Update version for 11.0.4 release
e767da3b7f7 85d38315fd Christian S. Lima:
 target/riscv/tcg: sret in virtual user mode raises virtual instruction exception
f955f66d429 e68cc2e5cd wangyang:
 target/riscv: enforce even register constraints for Zdinx fcvt pairs
ba17cb74998 af1e669cef wangyang:
 target/riscv: reject FMV.X.W/FMV.W.X under Zfinx
64fb691086a 12289f2f9a wangyang:
 target/riscv: honor zicbo* envcfg gating in linux-user mode
9c2302d8cf6 ecbd3a031f Richard Henderson:
 disas/riscv: Fix typo in th.lbib format
ad6eae6ce15 d610e55c83 Richard Henderson:
 disas/riscv: Fix isa decoding of rev8
db79e3b031f d4151cf267 Richard Henderson:
 disas/riscv: Fix rv32 encoding of zext.h
6b736980a75 bd1ee9ab3c A-Shehab:
 target/riscv: allow menvcfg/henvcfg LPE and SSE bits on RV32
2d26ef700db aa51eec004 Andrew Jones:
 hw/riscv/riscv-iommu: preserve requested perm in spa_fetch()
a9200e29e38 f16fd27b3f Andrew Jones:
 hw/riscv/riscv-iommu: fix U-bit check to apply only to leaf S/VS-stage PTEs
3ba73ef1296 00cec77a7f TANG Tiancheng:
 disas/riscv: Decode unsigned vector immediates as unsigned
b9e89544eab 7899d3c6bd TANG Tiancheng:
 disas/riscv: Use signed type for vector immediates
4f07934c4e6 7a8454ef29 TANG Tiancheng:
 disas/riscv: Fix 6-bit immediate extraction
b346ba5889b 6985cfc875 TANG Tiancheng:
 disas/riscv: Fix th.srri decoding
e834aa7a8ff 5a9fa8b582 Zephyr Li:
 target/riscv: do not count ECALL in minstret
636aaeddfea ebef6685a1 Abhigyan Kumar:
 target/riscv: use SXL instead of MXL for read_sstatus
e9c8fea019e 4a884ba94b Max Chou:
 target/riscv: Fix PC sync in trans_sspopchk for CFI exception handling
590059ce894 eea4de1bd8 Chinmay Rath:
 hw/watchdog: Add lower bound check for watchdogNumber
e039f07e069 3295370010 Richard Henderson:
 tests/tcg/aarch64: Add regression test for whilewr/whilerw
dab7a9f3a10 bab972a2b0 Richard Henderson:
 target/arm: Fix SVE2 WHILEWR/WHILERW zero diff boundary case
dd9a7a263c7 b4f6f672a3 Richard Henderson:
 tcg: Export tcg_gen_ussub_i{32,64,tl}
6a07b9b0ebc f5d2d8532f Richard Henderson:
 tcg: Defer tb_flush when initial thread region alloc fails
b82150b616c fcdbc78ad4 Richard Henderson:
 tcg: Return success from tcg_region_alloc
d7ed8d8971e e131c28b6e Richard Henderson:
 tcg: Return success from tcg_region_alloc__locked
9004e1cdaba 215a4fc08f Jan Mercl:
 target/loongarch: check FPE before reading fcc in bceqz/bcnez
dcbe835ed0a 501187d0bc Paolo Bonzini:
 meson: make linker warnings non-fatal on Linux
d1f8bfb5bc3 eb3f7fe382 Paolo Bonzini:
 serial: clear transmit retry callback on unrealize
3d59577e1e6 380b959618 Andrey Polivoda:
 target/i386: decode opcode extensions group 3 /1 as TEST
09f1b3a8f8c 36f634fe4a Andrey Polivoda:
 target/i386: allow transition to virtual-8086 mode only if CPL == 0 and CPU is not in long mode
54ecc9306f3 3589cd995b Craaijo, Jos:
 target/i386: fix long mode segment override prefix decoding
0eb312a3449 ce0ee66044 Simon Scherer:
 target/i386: fix incorrect decoding of EXTRQ_i
261274dda10 0924d9d3db Simon Scherer:
 target/i386: Clear OF, SF, and AF for fcomi/fucomi
2bb6cda4396 784b7f28e2 Ilya Chichkov:
 accel/tcg: Allow overlapping reads in record_save
1d8d9c6acfc 5fe5160614 Richard Henderson:
 tcg/optimize: Fix s_mask computation for shifts
ecf1185a605 3181e53c13 Richard Henderson:
 tcg/optimize: INDEX_op_mul is commutative
91a6f9225eb 260d49d8e2 Alex Bennée:
 hw/elf_ops: defend against weird elf headers
2a214c79fbb 6dab35f549 Stefan Hajnoczi:
 hw/nvme: add SPDM_SOCKET Kconfig dependency
630467ed199 60d010f66f Bin Guo:
 hw/block/pflash_cfi01: Restore ROMD mode after migration
d8df7c2eafc f3a10c1c45 Peter Maydell:
 hw/net/rtl8139: Send whole of vlan-tagged packet when doing loopback
ef94017650c 59fc7b747d Peter Maydell:
 hw/net/rtl8139: Fix handling of VLAN tags on incoming short packets
3c617ac8e2a 6ccf1e73fc Dario Faggioli:
 hw/i386/pc: xen: reinstate the "xenfv" machine alias
512ae0f2f83 be1ee6a8f6 Denis V. Lunev:
 tests/qtest/ahci: regression test for ATAPI read vs. drain
95e5737a65e 12289dc700 Denis V. Lunev:
 hw/ide/atapi: read the whole elementary transfer asynchronously
c97d8c3e772 31f13e71af Denis V. Lunev:
 tests/qtest/ahci: cover raw (2352-byte) ATAPI CD reads
0bfdf224223 de86ef3dfd Denis V. Lunev:
 tests/qtest/libqos/ahci: support raw (2352-byte) READ CD
504cac4de45 502dbdfd96 Denis V. Lunev:
 tests/qtest/ide-test: cover raw (2352-byte) ATAPI CD reads
ec515ffc91f fe543c2d78 Denis V. Lunev:
 tests/qtest/ide-test: add a multi-sector ATAPI DMA read test
59a98c1a851 ebec7c7322 Denis V. Lunev:
 tests/qtest/ide-test: parametrize the ATAPI CD-ROM read test
fe571c85b53 46099d9900 Thomas Huth:
 hw/net/vmxnet3: Do not abort if guest provides bad interrupt numbers
152133bc95b 15700a66ec Thomas Huth:
 hw/usb/dev-uas: Don't abort if guest provided an undersized buffer for status
3a667a73dc6 80776c4df9 Bin Guo:
 hw/intc/loongarch_pch_pic: Validate htmsi_vector before indexing parent_irq
e74465399c7 cf45083edc Peter Xu:
 migration/multifd: Replace assert() with error_setg() in recv paths
ed29da46510 ac7fa2e9d4 Peter Xu:
 migration/multifd: Validate next_packet_size in zlib/zstd recv
cee43005e59 e79ea44726 Ilya Leoshkevich:
 tests/tcg/s390x: Test STCKF condition code on a faulting store
d58f0cd6dda 2c32c273da Ilya Leoshkevich:
 target/s390x/tcg: Set STCK/STCKF condition code after the store
d4de8675bee 9b3d68edb2 Eric Farman:
 pc-bios/s390-ccw.img: update s390x bios
af37d507816 c4d9412cdd Jared Rossi:
 pc-bios/s390-ccw: Fix off-by-one errors with loadparm and boot entries
89962b71020 a3856a7ba4 Joshua Daley:
 pc-bios/s390-ccw: bound zipl menu strlen and replace VLA in zipl_print_entry
db6c8e44bb8 33909d4ebd Joshua Daley:
 pc-bios/s390-ccw: bounds-check zipl menu entry index before array write
fbdde3ad4f9 a9f1e84c6b Joshua Daley:
 pc-bios/s390-ccw: fix out-of-bounds read in iso_get_file_size()
5ea8d06b8f3 f4b7ae0a9e Cornelia Huck:
 pc-bios/s390-ccw.img: update s390x bios
5fd01514d9f d047364380 Jared Rossi:
 pc-bios/s390-ccw: write IPLB location for non-net virtio devices
dad81c83828 e26dafb207 Jared Rossi:
 pc-bios/s390-ccw: Verify virtio support when booting from virtio PCI device on s390x
46628e3ad3a 084feb9098 Zhuoying Cai:
 pc-bios/s390-ccw: Add per-queue notification offset for multi-queue virtio configurations
a8c650d6048 730173107a Jared Rossi:
 pc-bios/s390-ccw/virtio.c: Fix missing break for PCI notifications
3c92e2ceb6a c12bb74fd5 Zhuoying Cai:
 pc-bios/s390-ccw: Refactor byte swapping
53a13f1c1bb df607fd056 Joshua Daley:
 s390x/ipl: validate num_comp against iplb length before iterating
1475b002db5 4e994ebb01 Christian Borntraeger:
 hw/char/sclpconsole-lm: avoid guest triggerable assert
adcd32e362e aa5d03bc93 Ilya Leoshkevich:
 tests/tcg/s390x: Test DR overflow (INT64_MIN / -1)
0a79a4b79a8 0103cb1cd1 Ilya Leoshkevich:
 target/s390x: Fix DR/D INT64_MIN / -1 host crash
47dd00a2e71 abe1d893f4 Ilya Leoshkevich:
 tests/tcg/s390x: Test PRNO TRNG interruptibility
c21e8a0bc39 aae77f5ddd Ilya Leoshkevich:
 target/s390x: Make PRNO TRNG interruptible
e1a569b5e4a fcc2699d41 Philippe Mathieu-Daudé:
 target/s390x: Have MSA helper pass a mmu_idx argument
cc75f8cde4f 6440880ed3 Philippe Mathieu-Daudé:
 hw/arm/aspeed: Add missing Kconfig dependencies on required components
f86bdd57931 2fad751ed6 Philippe Mathieu-Daudé:
 hw/arm/aspeed: Add missing PCI_EXPRESS -> PCIE_PORT Kconfig dependency
4f59a1e326f 4713988da1 Matt Turner:
 linux-user: implement mount_setattr(2)
ad5a836c2f7 01b4e06b52 Saul Freedman:
 target/i386/kvm: Fix CET SSP MSR read feature check
b166b45cfde f7ad7b1f8c Mikulas Patocka:
 linux-user/sh4: Fix crashes on signal delivery in conditional delay slot
233cb7ee55d 668d571bf0 Mikulas Patocka:
 linux-user/sh4: Initialize the FPSCR register on signal
ad6a3d022b4 bc4681990b Mikulas Patocka:
 linux-user/sh4: Deliver SIGILL on invalid instruction
96265892b33 9232220004 Stefan Hajnoczi:
 gitlab: disable provenance attestations to work around CI bug
24bb8a2719d 784768f7fa Alejandro Jimenez:
 amd_iommu: Return int from page walk status helpers
d0ac3783cfa 7a34f7b879 Klaus Jensen:
 hw/nvme: fix leak on copy ranges
1d575943b94 86f938333e Minwoo Im:
 hw/nvme: cancel inflight requests on controller reset
0023981b054 849ea354dd Minwoo Im:
 hw/nvme: factor out nvme_sq_cancel_inflight()
48bc08944e6 1d5e53df16 Minwoo Im:
 hw/nvme: drop AER requests without aiocb in nvme_del_sq()
e8b22607d7a 5ce01c9238 Bin Guo:
 hw/display/virtio-gpu: Unmap DMA regions on reset
9d09a0fd80e d513c644b8 Akihiko Odaki:
 hw/display/virtio-gpu: Always reject invalid scanout bounds
5fbd2fe1cc5 1f24066fc8 Ankur Saini:
 virtio-gpu: reject requests with short/truncated control headers
6f5cba74e85 b8ef970532 Marc-André Lureau:
 hw/display/virtio-gpu: fix offset wraparound in scanout_blob_to_fb
7cd760867bd a113e0c53f Marc-André Lureau:
 vhost-user-gpu: fix integer overflow in buffer allocation
3ecb483c4c7 95687639e6 Marc-André Lureau:
 hw/display/vga: fix panning_buf OOB after text/graphics switch
d056eea8540 241095547a Marc-André Lureau:
 hw/display/virtio-gpu: validate blob iov size
c7dc1648943 7d06bbb2d9 Fiona Ebner:
 iotests: test O_TRUNC behavior for fuse exports
46e3697a025 b9ad1c4396 Fiona Ebner:
 block/export/fuse: fix regression with O_TRUNC when export is not growable
f4b15ce5087 e554413bd2 Denis V. Lunev:
 coroutine: fix lost wakeup in qemu_co_sleep_wake()
7bb02fb77c2 43e4791d99 Denis V. Lunev:
 iotests: run the test pool with the 'fork' start method
56e0d35e956 fe0f9e3ab2 Denis V. Lunev:
 qcow2: do not try to clear the dirty bit on a read-only node
e00b9c9193d 370882d086 Stefan Hajnoczi:
 dmg: reject inconsistent UDRW chunk sector count and length (CVE-2026-65928)
4f17fe4f390 ab7b872f0c Stefan Hajnoczi:
 dmg: refuse to open files with no chunks
ffe6640f445 0c43f801c0 Stefan Hajnoczi:
 dmg: fix out-of-bounds load in search_chunk() (CVE-2026-65929)
0a1a8ffc13c 842c89281a Denis V. Lunev:
 tests/unit: add reproducer for BlockAcctStats histogram locking race
66990cd5749 16f94ef4c6 Denis V. Lunev:
 block/qapi: take stats->lock when reading BlockAcctStats for query-blockstats
bcc5e811b3a 5b0ba385a0 Denis V. Lunev:
 block/accounting: take stats->lock in latency histogram setters
25328ef3d4a 0d3db94a88 malike:
 block/cloop: fix integer overflow in total_sectors calculation
825fc40463e f498c21b35 Tycho Andersen (AMD):
 hw/vfio: Fix liveness check in vfio_connect_kvm_msi_virq()
dbce8546a5a c25f69595a Richard Henderson:
 target/i386: Update cc_op for SAHF
7f930cdffd4 702252a0db Richard Henderson:
 target/arm: Fix b16b16 feature test for SME2 BFCLAMP, BFMAX, BFMIN
d04834a02b0 8d0ac5933a Richard Henderson:
 linux-user/aarch64: Fix SHADOW_STACK_SET_TOKEN
39a13683648 518a4aa01b no92:
 linux-user: fix incorrect msg_l[sr]pid members of target_msqid_ds
ef1f7e377cd 9e3df3019d Helge Deller:
 linux-user: Fix msqid_ds struct wrt 32-bit big endian architectures
43e6085bfac 6e5ca34f38 Daniel Paziyski:
 hw/nvme: fix assertion failure on subregion removal
d9741fbf090 c39e05af43 Klaus Jensen:
 hw/nvme: fix unintentional integer overflow in shift
dc03ab53bb6 df67805ee9 Klaus Jensen:
 hw/nvme: fix cross-namespace copy dif buffer overflow
d387cf4079d a5cff318f0 Michael S. Tsirkin:
 virtio-mmio: fix QUEUE_NUM_MAX
1e8ccea5d05 a5f8d33682 Peter Maydell:
 hw/display/exynos4210_fimd: Clamp windows to screen size
af9ac42080d 7dd1e22188 Peter Maydell:
 hw/display/exynos4210_fimd: Pass width to draw_line functions
9627cddf822 4f635bddf5 Peter Maydell:
 hw/display/exynos4210_fimd: Factor out finding screen width/height
b40fb500699 c4580a3a6d botszhuang:
 hw/i2c/bcm2835_i2c: Correct CLKT register offset
045b7bb96d9 db3abd36e4 Laurent Vivier:
 linux-user/sh4: allow full 32-bit address space
d9643e962e0 d8813fdc4b Mark Cave-Ayland:
 target/sparc: set reg window data structures currently after vmstate load
a73328af6aa 1e5efe6d93 Laurent Vivier:
 hw/net/igb: recalculate rx_desc_len on migration load
97c72e47f4f b395a655ae Laurent Vivier:
 hw/net/e1000e: recalculate rx_desc_len on migration load
3ff00ce1ce4 11ed6b9213 Bernhard Beschow:
 hw/sd/sdhci: Extract uSDHC-specific quirk
21e76fdd859 aba80ad9d8 Matt Turner:
 linux-user: fix guards for the fsmount(2) syscall series
9c55a5f70e6 8cbcf75793 Peter Maydell:
 hw/net/xilinx_axienet: Don't write checksums off end of packet
cc8ee2a8d0f 8268d216a0 Cédric Le Goater:
 linux-user: Guard local FUTEX_CMD_MASK definition
19b648e8ef5 6682ea3391 Stefan Hajnoczi:
 virtio: avoid packed vring virtio_queue_empty() infinite loops (CVE-2026-16457)
836e79c82a5 70074cc48f Laurent Vivier:
 backends/rng: cap request size to avoid oversized allocation
88a0e5e45b4 0be94d8d9c Laurent Vivier:
 hw/virtio-rng: Fix host use-after-free (CVE-2026-50624)
5b105521527 df12999cc8 Laurent Vivier:
 hw/net/virtio-net: Protect from DMA re-entrancy bugs
74980cfc271 0691bb257a Clément MATHIEU--DRIF:
 intel_iommu: Check address mask before using it in pasid-based iotlb invalidation
8206f43a752 292902ae4e Haotian Jiang:
 hw/cxl: fix OOB access in cxl_doe_cdat_rsp via entry_handle
15e6ec85d87 421f45d03f GuoHan Zhao:
 hw/virtio/vdpa-dev: pass set_config buffer to vhost backend
591680962fe e07c67584c Peter Maydell:
 hw/pci-host/q35.c: Avoid early return in mch_write_config()
6524df871f8 a90fcf0080 Peter Maydell:
 hw/pci-host/q35.c: Factor out creation of SMRAM MRs
5de61f2a305 7ea56dcc94 Peter Maydell:
 hw/pci-host/q35.c: Always initialize smram-region even if SMM disabled
4fae00413eb 67550d65b4 Michael S. Tsirkin:
 virtio-iommu: fix OOM due to unbounded call_rcu
6680c561240 733a98a552 Michael S. Tsirkin:
 libvduse: validate vq size
82520d77595 b9d248dfac Michael S. Tsirkin:
 libvhost-user: fix heap overflow in vu_check_queue_inflights
d8779bc2b73 bf21298c08 Michael S. Tsirkin:
 libvhost-user: validate last_batch_head in vu_check_queue_inflights
a7f027cff81 5cc182ba39 Michael S. Tsirkin:
 virtio-pmem: wait for flush requests on unrealize
081343aea46 cf89b769cd Michael S. Tsirkin:
 vhost-user: assert nregions within limit
5b7bb17c693 665c854390 Michael S. Tsirkin:
 virtio: fail early on bad config_len in migration
a4abe1f1fa6 f404bf0e65 Michael S. Tsirkin:
 virtio-scsi: fix SCSIRequest leak on a bad request
69022e85feb 27806d2ddb Michael S. Tsirkin:
 vhost: do not crash on ring map failure
c38cd43649f 6dbdc271f5 Laurent Vivier:
 hw/virtio: reject zero-length packed indirect descriptor table
b69350dc10f 758ef96a2d Michael S. Tsirkin:
 libvhost-user: protect against OOB vring queue access
82d018920ab fbdfdbb992 Michael S. Tsirkin:
 libvhost-user: protect against OOB writes in vu_set_inflight_fd
c159357f8c3 7724885620 Michael S. Tsirkin:
 virtio-net: fix short frame OOB read in receive_filter()
9a06bb17256 52c7bb369b Michael S. Tsirkin:
 virtio-net: fix OOB read in RSC receive path
f348425fdda a6e0519ea8 Michael S. Tsirkin:
 virtio: use masked features with set_features_ex
d76b9fb125c 5c9ef661a6 Akihiko Odaki:
 hw/display/virtio-gpu: Block Rutabaga migration
f90c5028017 555d0a1eba Marc-André Lureau:
 hw/display/virtio-gpu: drop redundant node->value NULL checks
3e6cdc204e3 8dc8449a67 Akihiko Odaki:
 hw/display/virtio-gpu: Avoid leaking migration blocker
2335b8dfad2 4ae1c5c7d6 Akihiko Odaki:
 hw/display/virtio-gpu: Initialize blob mapping for ATTACH_BACKING
2f0668dfec8 0fa3e1823b Akihiko Odaki:
 hw/display/virtio-gpu: Fix empty blob discrimination
3afcee6c792 8ac0a1c7b9 Haotian Jiang:
 virtio-gpu: fix NULL deref in rutabaga set_scanout
ec3eafde505 415f2759d7 Marc-André Lureau:
 target/i386/sev: fix MemoryRegion reference leaks in gpa2hva callers
9f556c406db b28778131f Marc-André Lureau:
 net/colo: fix g_hash_table_destroy assertion on uninitialized filter
95b9a1bf26f 4727cc883b Haotian Jiang:
 hw/display/qxl: unregister vm_change_state handler and BHs
2166a50c694 efa7244b2a Marc-André Lureau:
 ui/vnc: remove redundant rows computation
79036ad728f 1c1232c2ee Marc-André Lureau:
 hw/display/vhost-user-gpu: validate message payload sizes
3c9dd218f71 76dcc0832c Akihiko Odaki:
 hw/display/virtio-gpu: Remove the bytes_pp field
eaee99e3b00 9c724426f5 Akihiko Odaki:
 hw/display/virtio-gpu: reject strides exceeding INT_MAX
37cec1fe0e4 861372428b Marc-André Lureau:
 hw/display/virtio-gpu: validate stride against width on scanout
60f4778fbda 92abc3c51e Thomas Huth:
 hw/usb/hcd-xhci: Check return value of xhci_xfer_create_sgl() for errors
d008459ea65 68809288c7 Thomas Huth:
 hw/usb/core: Avoid possible assert() in do_parameter() --> usb_packet_copy()
05c2605a656 9b899ddb27 Thomas Huth:
 hw/ide/core: Fix possible crash via NULL pointer in ide_cancel_dma_sync()
d83b8c5e247 b7520c9a59 Thomas Huth:
 hw/usb/dev-uas: Fix guest-triggerable heap OOB access
654d5ef55b2 b71a179148 Feifan Qian:
 hw/cxl: Validate Set Feature payload bounds
d72bb51ba91 1de8aea061 Christian Schoenebeck:
 hw/9pfs/xen: drain in-flight PDUs before xen-9p disconnect
9b7cb4252a5 210701c82e Jia Jia:
 hw/9pfs/virtio: drain in-flight PDUs before virtio-9p unrealize
3f7d3513578 a0414545a2 Christian Schoenebeck:
 hw/9pfs: fix O_TRUNC bypass on read-only export
9ac6cd7330b f604b807a5 Thomas Huth:
 hw/display/vmware_vga: Don't allow guest to trigger long running loop in host
5736ebc726c 443e024106 Artem Nasonov:
 hw/ide: replace assert with proper error handling
2486b907aec e2da3d9274 Paolo Bonzini:
 scsi-disk: fix off by one in assertion
9af39f66de1 d149a11c6c Paolo Bonzini:
 scsi-disk: protect against guest sending truncated data for MODE SELECT commands
60e6a7c8bdf 51aa3f3e05 Andrey Polivoda:
 target/i386: helper_sysret(): Check that RCX contains a canonical address when emulating an Intel CPU
7b71f96c484 20b3a363fa Thanos Makatos:
 vfio-user: vfio_user_device_io_get_region_info: fix capability check
7193636606a 6a51aab908 Thanos Makatos:
 vfio-user: vfio_user_get_region_info: prevent excessive malloc
0a560b57126 3966a4258b Thanos Makatos:
 vfio-user: vfio_user_get_region_info: reject unreasonably short struct
c79d1bc36c7 152f7dd3b0 Thanos Makatos:
 vfio-user: vfio_user_get_region_info: respect max_xfer_size
3123b3d4487 f6a321c94b Thanos Makatos:
 vfio-user: vfio_user_get_region_info: prevent buffer overflow
e6db6e105f7 86abb10256 Denis V. Lunev:
 vfio/pci: reject invalid PCI_INTERRUPT_PIN values
7fa2783f08f dff528657f Denis V. Lunev:
 vfio/pci: don't narrow a failed config read to a plausible value
8005daff1fb 4b2e6505d5 Cédric Le Goater:
 vfio/region: Clarify dma-buf failure messages
e39b0986260 256229e8f9 Tomita Moeko:
 vfio/igd: Clear saved BDSM in legacy VBIOS ROM at load time
855772626c4 c822ecd806 Mario Casquero:
 vfio/pci: Initialize rom_read_failed in vfio_pci_load_rom()
4fd09144f17 15ebb1ec8c Luc Michel:
 meson.build: re-add explicit gcrypt/nettle request check
26d21226515 bd9b3c50f4 Gerd Hoffmann:
 hw/uefi: make SetupMode read-only
d91e0141c52 acba2d7817 Gerd Hoffmann:
 hw/uefi: add post_load checks
a7d7f39ddb6 8e0ddb4a6e Gerd Hoffmann:
 hw/uefi: account variable policy entries against storage size
55072518921 647ba95eda Gerd Hoffmann:
 hw/uefi: check lower limit for signature list size
db51779dc44 ff5a9eb13c Gerd Hoffmann:
 hw/uefi: remove debug function
e0397dbe1a2 702216619e Gerd Hoffmann:
 hw/uefi: add sanity check


