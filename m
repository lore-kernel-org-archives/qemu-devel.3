Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB12C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 15:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzcTC-0007Jt-2U; Thu, 27 Aug 2026 11:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wzcTA-0007JR-8k; Thu, 27 Aug 2026 11:56:48 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wzcT5-00050B-TV; Thu, 27 Aug 2026 11:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787846185; bh=oRSBYewOcN82G7UvvARTDVUy5O/0J93g30Q2ujpCUUw=;
 h=From:To:Cc:Subject:Date;
 b=W+g7hj4TiCSkBWR/nDvKIglziMzqwo7XS2u9NO8hbuKOo4fYO5lebCIeLzvBC9p/B
 JDwyGZ7Fj2312rzg/E3e+eqKoA1qmz3JjyYMptcvMW2ixuaFEozGBO9Rdgw9RR6xB5
 NFlNcQ9hyViRHB6sfPEF0NGIcigWiyZGn4M7XnLGoxc9xCdiqpn3ZeAksOYtJqFzRe
 3RQVh1yhvemkSwv26/3pizkz3BCD3kVtRjoSMnjX0kcQqefhfySmU3Ml9M6WpXUq8j
 3Gk5p5DpXRMlrxVmFXchNLae4M0u80F5ZZF4Kb+M6MfYkNqgiU8RiE/1BCqtR962LY
 xt40rtza/3kag==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DFC0F1CF28C;
 Thu, 27 Aug 2026 18:56:25 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 17685419488;
 Thu, 27 Aug 2026 18:56:29 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 472C536393; Thu, 27 Aug 2026 18:55:53 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [ANNOUNCE] QEMU 10.0.13 Stable released
Date: Thu, 27 Aug 2026 18:55:45 +0300
Message-ID: <20260827155547.639034-1-mjt@tls.msk.ru>
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

The QEMU v10.0.13 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-10.0.13.tar.xz
  https://download.qemu.org/qemu-10.0.13.tar.xz.sig (signature)

v10.0.13 is now tagged in the official qemu.git repository, and the
stable-10.0 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-10.0

There are 166 changes since the previous v10.0.12 release.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-10.0-hash master-hash Author Name: Commmit-Subject):

98f88efe8f0 Michael Tokarev:
 Update version for 10.0.13 release
da39104d0e0 85d38315fd Christian S. Lima:
 target/riscv/tcg: sret in virtual user mode raises virtual instruction exception
6ed2e04412a e68cc2e5cd wangyang:
 target/riscv: enforce even register constraints for Zdinx fcvt pairs
7e93e6c4f94 af1e669cef wangyang:
 target/riscv: reject FMV.X.W/FMV.W.X under Zfinx
173828812d0 12289f2f9a wangyang:
 target/riscv: honor zicbo* envcfg gating in linux-user mode
1d9ee023d3b ecbd3a031f Richard Henderson:
 disas/riscv: Fix typo in th.lbib format
887d8094394 d610e55c83 Richard Henderson:
 disas/riscv: Fix isa decoding of rev8
70b7da31387 d4151cf267 Richard Henderson:
 disas/riscv: Fix rv32 encoding of zext.h
98a52852925 bd1ee9ab3c A-Shehab:
 target/riscv: allow menvcfg/henvcfg LPE and SSE bits on RV32
43b8553eea4 aa51eec004 Andrew Jones:
 hw/riscv/riscv-iommu: preserve requested perm in spa_fetch()
115408816e8 f16fd27b3f Andrew Jones:
 hw/riscv/riscv-iommu: fix U-bit check to apply only to leaf S/VS-stage PTEs
86e9c7fabf0 00cec77a7f TANG Tiancheng:
 disas/riscv: Decode unsigned vector immediates as unsigned
9a52c85175c 7899d3c6bd TANG Tiancheng:
 disas/riscv: Use signed type for vector immediates
d430c9cbfdc 7a8454ef29 TANG Tiancheng:
 disas/riscv: Fix 6-bit immediate extraction
e9661304329 6985cfc875 TANG Tiancheng:
 disas/riscv: Fix th.srri decoding
63af2c074bd ebef6685a1 Abhigyan Kumar:
 target/riscv: use SXL instead of MXL for read_sstatus
c7e251a6f82 4a884ba94b Max Chou:
 target/riscv: Fix PC sync in trans_sspopchk for CFI exception handling
3db78feef2a eea4de1bd8 Chinmay Rath:
 hw/watchdog: Add lower bound check for watchdogNumber
fdb2889b9ec b4f6f672a3 Richard Henderson:
 tcg: Export tcg_gen_ussub_i{32,64,tl}
79f94552ac8 f5d2d8532f Richard Henderson:
 tcg: Defer tb_flush when initial thread region alloc fails
50e9e77e743 fcdbc78ad4 Richard Henderson:
 tcg: Return success from tcg_region_alloc
2e94ddf2b39 e131c28b6e Richard Henderson:
 tcg: Return success from tcg_region_alloc__locked
a31d1e6c518 215a4fc08f Jan Mercl:
 target/loongarch: check FPE before reading fcc in bceqz/bcnez
1622b2fba74 501187d0bc Paolo Bonzini:
 meson: make linker warnings non-fatal on Linux
6a8c5e7d272 eb3f7fe382 Paolo Bonzini:
 serial: clear transmit retry callback on unrealize
ea2475aa978 380b959618 Andrey Polivoda:
 target/i386: decode opcode extensions group 3 /1 as TEST
07e8f29d18e 36f634fe4a Andrey Polivoda:
 target/i386: allow transition to virtual-8086 mode only if CPL == 0 and CPU is not in long mode
b610e0ad00d 3589cd995b Craaijo, Jos:
 target/i386: fix long mode segment override prefix decoding
c3a10e2b596 ce0ee66044 Simon Scherer:
 target/i386: fix incorrect decoding of EXTRQ_i
959f3bf9f84 0924d9d3db Simon Scherer:
 target/i386: Clear OF, SF, and AF for fcomi/fucomi
10091dffbf6 397ef415ca Peter Maydell:
 target/i386: Use correct type for get_float_exception_flags() values
77ad6491326 5fe5160614 Richard Henderson:
 tcg/optimize: Fix s_mask computation for shifts
6063234ab50 3181e53c13 Richard Henderson:
 tcg/optimize: INDEX_op_mul is commutative
81ce9b1a30b 260d49d8e2 Alex Bennée:
 hw/elf_ops: defend against weird elf headers
81049fce55d 6dab35f549 Stefan Hajnoczi:
 hw/nvme: add SPDM_SOCKET Kconfig dependency
f29e19e1352 60d010f66f Bin Guo:
 hw/block/pflash_cfi01: Restore ROMD mode after migration
3c817cabbe5 f3a10c1c45 Peter Maydell:
 hw/net/rtl8139: Send whole of vlan-tagged packet when doing loopback
ec3fd5a9271 59fc7b747d Peter Maydell:
 hw/net/rtl8139: Fix handling of VLAN tags on incoming short packets
a75cb250aa1 be1ee6a8f6 Denis V. Lunev:
 tests/qtest/ahci: regression test for ATAPI read vs. drain
a4fe89c8c85 12289dc700 Denis V. Lunev:
 hw/ide/atapi: read the whole elementary transfer asynchronously
552253b6f6a 31f13e71af Denis V. Lunev:
 tests/qtest/ahci: cover raw (2352-byte) ATAPI CD reads
3512396d8a7 de86ef3dfd Denis V. Lunev:
 tests/qtest/libqos/ahci: support raw (2352-byte) READ CD
d5472fa8627 502dbdfd96 Denis V. Lunev:
 tests/qtest/ide-test: cover raw (2352-byte) ATAPI CD reads
42448d9e4fb fe543c2d78 Denis V. Lunev:
 tests/qtest/ide-test: add a multi-sector ATAPI DMA read test
1f7d218724a ebec7c7322 Denis V. Lunev:
 tests/qtest/ide-test: parametrize the ATAPI CD-ROM read test
63c1ac41b83 46099d9900 Thomas Huth:
 hw/net/vmxnet3: Do not abort if guest provides bad interrupt numbers
e29e287eac7 15700a66ec Thomas Huth:
 hw/usb/dev-uas: Don't abort if guest provided an undersized buffer for status
5a7483c4bf9 80776c4df9 Bin Guo:
 hw/intc/loongarch_pch_pic: Validate htmsi_vector before indexing parent_irq
6ada4c71b76 cf45083edc Peter Xu:
 migration/multifd: Replace assert() with error_setg() in recv paths
801d45408c9 ac7fa2e9d4 Peter Xu:
 migration/multifd: Validate next_packet_size in zlib/zstd recv
5df635dd89b e79ea44726 Ilya Leoshkevich:
 tests/tcg/s390x: Test STCKF condition code on a faulting store
0898214098f 2c32c273da Ilya Leoshkevich:
 target/s390x/tcg: Set STCK/STCKF condition code after the store
27ad1a030fa Michael Tokarev:
 pc-bios/s390-ccw.img: update s390x bios
f91127e8cd2 a3856a7ba4 Joshua Daley:
 pc-bios/s390-ccw: bound zipl menu strlen and replace VLA in zipl_print_entry
e061304f905 33909d4ebd Joshua Daley:
 pc-bios/s390-ccw: bounds-check zipl menu entry index before array write
dd5901f9b4d a9f1e84c6b Joshua Daley:
 pc-bios/s390-ccw: fix out-of-bounds read in iso_get_file_size()
bde79516870 df607fd056 Joshua Daley:
 s390x/ipl: validate num_comp against iplb length before iterating
869b11b96a5 4e994ebb01 Christian Borntraeger:
 hw/char/sclpconsole-lm: avoid guest triggerable assert
34b082cfc3e aa5d03bc93 Ilya Leoshkevich:
 tests/tcg/s390x: Test DR overflow (INT64_MIN / -1)
51507d8f5a1 0103cb1cd1 Ilya Leoshkevich:
 target/s390x: Fix DR/D INT64_MIN / -1 host crash
1e242d79169 abe1d893f4 Ilya Leoshkevich:
 tests/tcg/s390x: Test PRNO TRNG interruptibility
d10e8e513f4 aae77f5ddd Ilya Leoshkevich:
 target/s390x: Make PRNO TRNG interruptible
850a8f88380 fcc2699d41 Philippe Mathieu-Daudé:
 target/s390x: Have MSA helper pass a mmu_idx argument
0c39ed64d8b 6440880ed3 Philippe Mathieu-Daudé:
 hw/arm/aspeed: Add missing Kconfig dependencies on required components
5601de8a9f5 4713988da1 Matt Turner:
 linux-user: implement mount_setattr(2)
8caef5b9df5 f7ad7b1f8c Mikulas Patocka:
 linux-user/sh4: Fix crashes on signal delivery in conditional delay slot
e716c5805e8 668d571bf0 Mikulas Patocka:
 linux-user/sh4: Initialize the FPSCR register on signal
3115c72123a bc4681990b Mikulas Patocka:
 linux-user/sh4: Deliver SIGILL on invalid instruction
9587d2b3723 9232220004 Stefan Hajnoczi:
 gitlab: disable provenance attestations to work around CI bug
a2fe3086870 7a34f7b879 Klaus Jensen:
 hw/nvme: fix leak on copy ranges
2ce095a19a5 86f938333e Minwoo Im:
 hw/nvme: cancel inflight requests on controller reset
b83365ab1c6 849ea354dd Minwoo Im:
 hw/nvme: factor out nvme_sq_cancel_inflight()
19f842b08ec 1d5e53df16 Minwoo Im:
 hw/nvme: drop AER requests without aiocb in nvme_del_sq()
d1c4c67a972 5ce01c9238 Bin Guo:
 hw/display/virtio-gpu: Unmap DMA regions on reset
62bc6128f91 d513c644b8 Akihiko Odaki:
 hw/display/virtio-gpu: Always reject invalid scanout bounds
99853f2012d 1f24066fc8 Ankur Saini:
 virtio-gpu: reject requests with short/truncated control headers
164693d4a6c b8ef970532 Marc-André Lureau:
 hw/display/virtio-gpu: fix offset wraparound in scanout_blob_to_fb
87c23a73b50 a113e0c53f Marc-André Lureau:
 vhost-user-gpu: fix integer overflow in buffer allocation
178be91bc31 95687639e6 Marc-André Lureau:
 hw/display/vga: fix panning_buf OOB after text/graphics switch
ebbbcc6676c 241095547a Marc-André Lureau:
 hw/display/virtio-gpu: validate blob iov size
9c49f53da1c e554413bd2 Denis V. Lunev:
 coroutine: fix lost wakeup in qemu_co_sleep_wake()
f7098a207fe 43e4791d99 Denis V. Lunev:
 iotests: run the test pool with the 'fork' start method
f48fe4de003 fe0f9e3ab2 Denis V. Lunev:
 qcow2: do not try to clear the dirty bit on a read-only node
297dfb27f87 370882d086 Stefan Hajnoczi:
 dmg: reject inconsistent UDRW chunk sector count and length (CVE-2026-65928)
c594e1bc609 ab7b872f0c Stefan Hajnoczi:
 dmg: refuse to open files with no chunks
6751ce42def 0c43f801c0 Stefan Hajnoczi:
 dmg: fix out-of-bounds load in search_chunk() (CVE-2026-65929)
54f14a62888 842c89281a Denis V. Lunev:
 tests/unit: add reproducer for BlockAcctStats histogram locking race
3c11eda8eef 16f94ef4c6 Denis V. Lunev:
 block/qapi: take stats->lock when reading BlockAcctStats for query-blockstats
438b9588d9c 5b0ba385a0 Denis V. Lunev:
 block/accounting: take stats->lock in latency histogram setters
8ef3c30bb79 a55402d5c3 Kevin Wolf:
 block: Fix crash after setting latency historygram with single bin
495559c7b62 0d3db94a88 malike:
 block/cloop: fix integer overflow in total_sectors calculation
c384e99d2b6 518a4aa01b no92:
 linux-user: fix incorrect msg_l[sr]pid members of target_msqid_ds
dc6fd6425ea 9e3df3019d Helge Deller:
 linux-user: Fix msqid_ds struct wrt 32-bit big endian architectures
0a469169c04 6e5ca34f38 Daniel Paziyski:
 hw/nvme: fix assertion failure on subregion removal
e62d05dec01 c39e05af43 Klaus Jensen:
 hw/nvme: fix unintentional integer overflow in shift
a78d8b6f710 df67805ee9 Klaus Jensen:
 hw/nvme: fix cross-namespace copy dif buffer overflow
7b71b19a4ea a5cff318f0 Michael S. Tsirkin:
 virtio-mmio: fix QUEUE_NUM_MAX
5fea1787545 a5f8d33682 Peter Maydell:
 hw/display/exynos4210_fimd: Clamp windows to screen size
51fb2a0fb95 7dd1e22188 Peter Maydell:
 hw/display/exynos4210_fimd: Pass width to draw_line functions
c32bf57079a 4f635bddf5 Peter Maydell:
 hw/display/exynos4210_fimd: Factor out finding screen width/height
02dc7bbad65 c4580a3a6d botszhuang:
 hw/i2c/bcm2835_i2c: Correct CLKT register offset
604daf92021 db3abd36e4 Laurent Vivier:
 linux-user/sh4: allow full 32-bit address space
7b8b1093bbd d8813fdc4b Mark Cave-Ayland:
 target/sparc: set reg window data structures currently after vmstate load
57db3c5afe1 1e5efe6d93 Laurent Vivier:
 hw/net/igb: recalculate rx_desc_len on migration load
2041a2aacb3 b395a655ae Laurent Vivier:
 hw/net/e1000e: recalculate rx_desc_len on migration load
52b2ce09612 aba80ad9d8 Matt Turner:
 linux-user: fix guards for the fsmount(2) syscall series
92d24d31fd4 8cbcf75793 Peter Maydell:
 hw/net/xilinx_axienet: Don't write checksums off end of packet
7edb13aa24e 8268d216a0 Cédric Le Goater:
 linux-user: Guard local FUTEX_CMD_MASK definition
71d427b4f66 6682ea3391 Stefan Hajnoczi:
 virtio: avoid packed vring virtio_queue_empty() infinite loops (CVE-2026-16457)
6a4def76fb5 70074cc48f Laurent Vivier:
 backends/rng: cap request size to avoid oversized allocation
1f0495f4a32 0be94d8d9c Laurent Vivier:
 hw/virtio-rng: Fix host use-after-free (CVE-2026-50624)
d54713a8429 df12999cc8 Laurent Vivier:
 hw/net/virtio-net: Protect from DMA re-entrancy bugs
66a782695f1 0691bb257a Clément MATHIEU--DRIF:
 intel_iommu: Check address mask before using it in pasid-based iotlb invalidation
02303154fa9 292902ae4e Haotian Jiang:
 hw/cxl: fix OOB access in cxl_doe_cdat_rsp via entry_handle
2fefc2c1581 421f45d03f GuoHan Zhao:
 hw/virtio/vdpa-dev: pass set_config buffer to vhost backend
897a30d37b9 e07c67584c Peter Maydell:
 hw/pci-host/q35.c: Avoid early return in mch_write_config()
23b1719c1c1 a90fcf0080 Peter Maydell:
 hw/pci-host/q35.c: Factor out creation of SMRAM MRs
2f1d36f1464 7ea56dcc94 Peter Maydell:
 hw/pci-host/q35.c: Always initialize smram-region even if SMM disabled
668a284eee4 67550d65b4 Michael S. Tsirkin:
 virtio-iommu: fix OOM due to unbounded call_rcu
bac345a99dc 733a98a552 Michael S. Tsirkin:
 libvduse: validate vq size
1de3b086966 b9d248dfac Michael S. Tsirkin:
 libvhost-user: fix heap overflow in vu_check_queue_inflights
a458d49618f bf21298c08 Michael S. Tsirkin:
 libvhost-user: validate last_batch_head in vu_check_queue_inflights
18149332cf8 5cc182ba39 Michael S. Tsirkin:
 virtio-pmem: wait for flush requests on unrealize
84e205c8ce6 cf89b769cd Michael S. Tsirkin:
 vhost-user: assert nregions within limit
5e5c355c1b4 665c854390 Michael S. Tsirkin:
 virtio: fail early on bad config_len in migration
23def8a8ac7 f404bf0e65 Michael S. Tsirkin:
 virtio-scsi: fix SCSIRequest leak on a bad request
aa4f75da9ee 27806d2ddb Michael S. Tsirkin:
 vhost: do not crash on ring map failure
b0d42601c17 6dbdc271f5 Laurent Vivier:
 hw/virtio: reject zero-length packed indirect descriptor table
ec31478bd89 758ef96a2d Michael S. Tsirkin:
 libvhost-user: protect against OOB vring queue access
da3e8591f3d fbdfdbb992 Michael S. Tsirkin:
 libvhost-user: protect against OOB writes in vu_set_inflight_fd
871fa84ac5c 7724885620 Michael S. Tsirkin:
 virtio-net: fix short frame OOB read in receive_filter()
1557a939630 52c7bb369b Michael S. Tsirkin:
 virtio-net: fix OOB read in RSC receive path
9192226b8b4 5c9ef661a6 Akihiko Odaki:
 hw/display/virtio-gpu: Block Rutabaga migration
205891ca944 5322889f07 Marc-André Lureau:
 rutabaga: improve error handling, fix potential crash during init
daeca1cbc8c 4ae1c5c7d6 Akihiko Odaki:
 hw/display/virtio-gpu: Initialize blob mapping for ATTACH_BACKING
7584f134c73 0fa3e1823b Akihiko Odaki:
 hw/display/virtio-gpu: Fix empty blob discrimination
de0050591e8 8ac0a1c7b9 Haotian Jiang:
 virtio-gpu: fix NULL deref in rutabaga set_scanout
7eadaa525df 415f2759d7 Marc-André Lureau:
 target/i386/sev: fix MemoryRegion reference leaks in gpa2hva callers
6bbc85518b9 b28778131f Marc-André Lureau:
 net/colo: fix g_hash_table_destroy assertion on uninitialized filter
072fa66b87b 4727cc883b Haotian Jiang:
 hw/display/qxl: unregister vm_change_state handler and BHs
7298fe8026e efa7244b2a Marc-André Lureau:
 ui/vnc: remove redundant rows computation
dcb04460399 1c1232c2ee Marc-André Lureau:
 hw/display/vhost-user-gpu: validate message payload sizes
b607ee0a7e2 76dcc0832c Akihiko Odaki:
 hw/display/virtio-gpu: Remove the bytes_pp field
376049bacd7 9c724426f5 Akihiko Odaki:
 hw/display/virtio-gpu: reject strides exceeding INT_MAX
d2dfdbfc844 861372428b Marc-André Lureau:
 hw/display/virtio-gpu: validate stride against width on scanout
ecd169e1fce 92abc3c51e Thomas Huth:
 hw/usb/hcd-xhci: Check return value of xhci_xfer_create_sgl() for errors
e55fc6c3d7b 68809288c7 Thomas Huth:
 hw/usb/core: Avoid possible assert() in do_parameter() --> usb_packet_copy()
e4fba038646 9b899ddb27 Thomas Huth:
 hw/ide/core: Fix possible crash via NULL pointer in ide_cancel_dma_sync()
70f0ecebe2a b7520c9a59 Thomas Huth:
 hw/usb/dev-uas: Fix guest-triggerable heap OOB access
db654d53ca0 1de8aea061 Christian Schoenebeck:
 hw/9pfs/xen: drain in-flight PDUs before xen-9p disconnect
30a339d5372 210701c82e Jia Jia:
 hw/9pfs/virtio: drain in-flight PDUs before virtio-9p unrealize
f3503f83b11 a0414545a2 Christian Schoenebeck:
 hw/9pfs: fix O_TRUNC bypass on read-only export
539e6916bf7 f604b807a5 Thomas Huth:
 hw/display/vmware_vga: Don't allow guest to trigger long running loop in host
f177253910c 443e024106 Artem Nasonov:
 hw/ide: replace assert with proper error handling
2ea2afb3adf e2da3d9274 Paolo Bonzini:
 scsi-disk: fix off by one in assertion
9ba7cf44d29 d149a11c6c Paolo Bonzini:
 scsi-disk: protect against guest sending truncated data for MODE SELECT commands
509b626fa56 51aa3f3e05 Andrey Polivoda:
 target/i386: helper_sysret(): Check that RCX contains a canonical address when emulating an Intel CPU
a811638876d 86abb10256 Denis V. Lunev:
 vfio/pci: reject invalid PCI_INTERRUPT_PIN values
1f4b9e3d325 dff528657f Denis V. Lunev:
 vfio/pci: don't narrow a failed config read to a plausible value
8a712f64ceb 256229e8f9 Tomita Moeko:
 vfio/igd: Clear saved BDSM in legacy VBIOS ROM at load time
859d7d45e80 c822ecd806 Mario Casquero:
 vfio/pci: Initialize rom_read_failed in vfio_pci_load_rom()
41b69c97f2a bd9b3c50f4 Gerd Hoffmann:
 hw/uefi: make SetupMode read-only
357f93aa196 acba2d7817 Gerd Hoffmann:
 hw/uefi: add post_load checks
ab569162a9d 8e0ddb4a6e Gerd Hoffmann:
 hw/uefi: account variable policy entries against storage size
6b58f19f9f3 647ba95eda Gerd Hoffmann:
 hw/uefi: check lower limit for signature list size
4e90ee285ce ff5a9eb13c Gerd Hoffmann:
 hw/uefi: remove debug function
0073c71f51d 702216619e Gerd Hoffmann:
 hw/uefi: add sanity check


