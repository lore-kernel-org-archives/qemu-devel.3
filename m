Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A947FC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvupJ-0000Vh-GL; Mon, 17 Aug 2026 06:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvupH-0000UR-8O; Mon, 17 Aug 2026 06:44:19 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvupD-0003g1-Lw; Mon, 17 Aug 2026 06:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786963430; bh=TMEXF/oINyy/nfrTu+l2O+RX4hWJsfh8Z1j4ljgDNoI=;
 h=From:To:Cc:Subject:Date;
 b=o04n/CBibIzIGA/6WigeebbHoxqXUpIsk+2rjYTcXzpbcxA0E9yii097sZHq48lwy
 Px7vkAvpOkM2FFstYXRGNyQwix4Q73NOgQ+RlcO+0VOZ6WpRnh1PNct2LSf93bJjz2
 dlNJ/Uz74GADtGCerMgfHKEbe4QTCjLvvGQL0wKCk32W+3fVa7YhwvQcMWkWRVL5az
 At2jFPGVCuG4BmjFcSWI8BxzgQ5p+mKihuHa73HqPkPNqevrmjRd96doLV01qg3RHO
 kxBIPeN3YWOxjI/Zlhm0EIx4ucepgerty2hnN3CaYo09Y3bk3WSOP/s6qs7A6NuUXj
 bHZx9Xopm7uxg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 531601CBB65;
 Mon, 17 Aug 2026 13:43:50 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3FE3040D1EF;
 Mon, 17 Aug 2026 13:44:11 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D555830E42; Mon, 17 Aug 2026 13:43:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 v2 000/161] Patch Round-up for stable 11.0.4,
 freeze on 2026-08-24
Date: Mon, 17 Aug 2026 13:42:34 +0300
Message-ID: <qemu-stable-11.0.4-20260817125055@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v11.0.4:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-11.0

Patch freeze is 2026-08-24, and the release is planned for 2026-08-26:

  https://wiki.qemu.org/Planning/11.0

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* 702216619e2a Gerd Hoffmann:
   hw/uefi: add sanity check
02* ff5a9eb13c86 Gerd Hoffmann:
   hw/uefi: remove debug function
03* 647ba95eda5a Gerd Hoffmann:
   hw/uefi: check lower limit for signature list size
04* 8e0ddb4a6ebd Gerd Hoffmann:
   hw/uefi: account variable policy entries against storage size
05* acba2d78176d Gerd Hoffmann:
   hw/uefi: add post_load checks
06* bd9b3c50f458 Gerd Hoffmann:
   hw/uefi: make SetupMode read-only
07* 15ebb1ec8c06 Luc Michel:
   meson.build: re-add explicit gcrypt/nettle request check
08* c822ecd80661 Mario Casquero:
   vfio/pci: Initialize rom_read_failed in vfio_pci_load_rom()
09* 256229e8f9b9 Tomita Moeko:
   vfio/igd: Clear saved BDSM in legacy VBIOS ROM at load time
10* 4b2e6505d59b Cédric Le Goater:
   vfio/region: Clarify dma-buf failure messages
11* dff528657fc1 Denis V. Lunev:
   vfio/pci: don't narrow a failed config read to a plausible value
12* 86abb10256a5 Denis V. Lunev:
   vfio/pci: reject invalid PCI_INTERRUPT_PIN values
13* f6a321c94b21 Thanos Makatos:
   vfio-user: vfio_user_get_region_info: prevent buffer overflow
14* 152f7dd3b04f Thanos Makatos:
   vfio-user: vfio_user_get_region_info: respect max_xfer_size
15* 3966a4258b59 Thanos Makatos:
   vfio-user: vfio_user_get_region_info: reject unreasonably short struct
16* 6a51aab908e0 Thanos Makatos:
   vfio-user: vfio_user_get_region_info: prevent excessive malloc
17* 20b3a363fa8c Thanos Makatos:
   vfio-user: vfio_user_device_io_get_region_info: fix capability check
18* 51aa3f3e0577 Andrey Polivoda:
   target/i386: helper_sysret(): Check that RCX contains a canonical address 
   when emulating an Intel CPU
19* d149a11c6c82 Paolo Bonzini:
   scsi-disk: protect against guest sending truncated data for MODE SELECT 
   commands
20* e2da3d92744d Paolo Bonzini:
   scsi-disk: fix off by one in assertion
21* 443e02410695 Artem Nasonov:
   hw/ide: replace assert with proper error handling
22* f604b807a55a Thomas Huth:
   hw/display/vmware_vga: Don't allow guest to trigger long running loop in 
   host
23* a0414545a212 Christian Schoenebeck:
   hw/9pfs: fix O_TRUNC bypass on read-only export
24* 210701c82e30 Jia Jia:
   hw/9pfs/virtio: drain in-flight PDUs before virtio-9p unrealize
25* 1de8aea061b9 Christian Schoenebeck:
   hw/9pfs/xen: drain in-flight PDUs before xen-9p disconnect
26* b71a179148ff Feifan Qian:
   hw/cxl: Validate Set Feature payload bounds
27* b7520c9a5912 Thomas Huth:
   hw/usb/dev-uas: Fix guest-triggerable heap OOB access
28* 9b899ddb2706 Thomas Huth:
   hw/ide/core: Fix possible crash via NULL pointer in ide_cancel_dma_sync()
29* 68809288c7e5 Thomas Huth:
   hw/usb/core: Avoid possible assert() in do_parameter() --> 
   usb_packet_copy()
30* 92abc3c51ebb Thomas Huth:
   hw/usb/hcd-xhci: Check return value of xhci_xfer_create_sgl() for errors
31* 861372428b05 Marc-André Lureau:
   hw/display/virtio-gpu: validate stride against width on scanout
32* 9c724426f519 Akihiko Odaki:
   hw/display/virtio-gpu: reject strides exceeding INT_MAX
33* 76dcc0832c5c Akihiko Odaki:
   hw/display/virtio-gpu: Remove the bytes_pp field
34* 1c1232c2ee07 Marc-André Lureau:
   hw/display/vhost-user-gpu: validate message payload sizes
35* efa7244b2a0b Marc-André Lureau:
   ui/vnc: remove redundant rows computation
36* 4727cc883b7e Haotian Jiang:
   hw/display/qxl: unregister vm_change_state handler and BHs
37* b28778131fad Marc-André Lureau:
   net/colo: fix g_hash_table_destroy assertion on uninitialized filter
38* 415f2759d7b3 Marc-André Lureau:
   target/i386/sev: fix MemoryRegion reference leaks in gpa2hva callers
39* 8ac0a1c7b98e Haotian Jiang:
   virtio-gpu: fix NULL deref in rutabaga set_scanout
40* 0fa3e1823b9b Akihiko Odaki:
   hw/display/virtio-gpu: Fix empty blob discrimination
41* 4ae1c5c7d6f3 Akihiko Odaki:
   hw/display/virtio-gpu: Initialize blob mapping for ATTACH_BACKING
42* 8dc8449a678f Akihiko Odaki:
   hw/display/virtio-gpu: Avoid leaking migration blocker
43* 555d0a1eba20 Marc-André Lureau:
   hw/display/virtio-gpu: drop redundant node->value NULL checks
44* 5c9ef661a60a Akihiko Odaki:
   hw/display/virtio-gpu: Block Rutabaga migration
45* a6e0519ea8ed Michael S. Tsirkin:
   virtio: use masked features with set_features_ex
46* 52c7bb369b23 Michael S. Tsirkin:
   virtio-net: fix OOB read in RSC receive path
47* 772488562053 Michael S. Tsirkin:
   virtio-net: fix short frame OOB read in receive_filter()
48* fbdfdbb9920c Michael S. Tsirkin:
   libvhost-user: protect against OOB writes in vu_set_inflight_fd
49* 758ef96a2dba Michael S. Tsirkin:
   libvhost-user: protect against OOB vring queue access
50* 6dbdc271f56b Laurent Vivier:
   hw/virtio: reject zero-length packed indirect descriptor table
51* 27806d2ddba2 Michael S. Tsirkin:
   vhost: do not crash on ring map failure
52* f404bf0e6504 Michael S. Tsirkin:
   virtio-scsi: fix SCSIRequest leak on a bad request
53* 665c854390e0 Michael S. Tsirkin:
   virtio: fail early on bad config_len in migration
54* cf89b769cdd1 Michael S. Tsirkin:
   vhost-user: assert nregions within limit
55* 5cc182ba39a3 Michael S. Tsirkin:
   virtio-pmem: wait for flush requests on unrealize
56* bf21298c082c Michael S. Tsirkin:
   libvhost-user: validate last_batch_head in vu_check_queue_inflights
57* b9d248dfaca5 Michael S. Tsirkin:
   libvhost-user: fix heap overflow in vu_check_queue_inflights
58* 733a98a552e4 Michael S. Tsirkin:
   libvduse: validate vq size
59* 67550d65b4bf Michael S. Tsirkin:
   virtio-iommu: fix OOM due to unbounded call_rcu
60* 7ea56dcc9406 Peter Maydell:
   hw/pci-host/q35.c: Always initialize smram-region even if SMM disabled
61* a90fcf0080da Peter Maydell:
   hw/pci-host/q35.c: Factor out creation of SMRAM MRs
62* e07c67584c69 Peter Maydell:
   hw/pci-host/q35.c: Avoid early return in mch_write_config()
63* 421f45d03f32 GuoHan Zhao:
   hw/virtio/vdpa-dev: pass set_config buffer to vhost backend
64* 292902ae4e93 Haotian Jiang:
   hw/cxl: fix OOB access in cxl_doe_cdat_rsp via entry_handle
65* 0691bb257a7c Clément MATHIEU--DRIF:
   intel_iommu: Check address mask before using it in pasid-based iotlb 
   invalidation
66* df12999cc813 Laurent Vivier:
   hw/net/virtio-net: Protect from DMA re-entrancy bugs
67* 0be94d8d9c28 Laurent Vivier:
   hw/virtio-rng: Fix host use-after-free (CVE-2026-50624)
68* 70074cc48f45 Laurent Vivier:
   backends/rng: cap request size to avoid oversized allocation
69* 6682ea339127 Stefan Hajnoczi:
   virtio: avoid packed vring virtio_queue_empty() infinite loops 
   (CVE-2026-16457)
70* 8268d216a004 Cédric Le Goater:
   linux-user: Guard local FUTEX_CMD_MASK definition
71* 8cbcf7579355 Peter Maydell:
   hw/net/xilinx_axienet: Don't write checksums off end of packet
72* aba80ad9d853 Matt Turner:
   linux-user: fix guards for the fsmount(2) syscall series
73* 11ed6b92130a Bernhard Beschow:
   hw/sd/sdhci: Extract uSDHC-specific quirk
74* b395a655ae0e Laurent Vivier:
   hw/net/e1000e: recalculate rx_desc_len on migration load
75* 1e5efe6d9370 Laurent Vivier:
   hw/net/igb: recalculate rx_desc_len on migration load
76* d8813fdc4bdf Mark Cave-Ayland:
   target/sparc: set reg window data structures currently after vmstate load
77* db3abd36e4c7 Laurent Vivier:
   linux-user/sh4: allow full 32-bit address space
78* c4580a3a6d1c botszhuang:
   hw/i2c/bcm2835_i2c: Correct CLKT register offset
79* 4f635bddf50c Peter Maydell:
   hw/display/exynos4210_fimd: Factor out finding screen width/height
80* 7dd1e2218835 Peter Maydell:
   hw/display/exynos4210_fimd: Pass width to draw_line functions
81* a5f8d33682be Peter Maydell:
   hw/display/exynos4210_fimd: Clamp windows to screen size
82* a5cff318f06c Michael S. Tsirkin:
   virtio-mmio: fix QUEUE_NUM_MAX
83* df67805ee9b1 Klaus Jensen:
   hw/nvme: fix cross-namespace copy dif buffer overflow
84* c39e05af439a Klaus Jensen:
   hw/nvme: fix unintentional integer overflow in shift
85* 6e5ca34f3870 Daniel Paziyski:
   hw/nvme: fix assertion failure on subregion removal
86* 9e3df3019d21 Helge Deller:
   linux-user: Fix msqid_ds struct wrt 32-bit big endian architectures
87* 518a4aa01b88 no92:
   linux-user: fix incorrect msg_l[sr]pid members of target_msqid_ds
88* 8d0ac5933aa3 Richard Henderson:
   linux-user/aarch64: Fix SHADOW_STACK_SET_TOKEN
89* 702252a0dbc3 Richard Henderson:
   target/arm: Fix b16b16 feature test for SME2 BFCLAMP, BFMAX, BFMIN
90* c25f69595ad0 Richard Henderson:
   target/i386: Update cc_op for SAHF
91* f498c21b3595 Tycho Andersen (AMD):
   hw/vfio: Fix liveness check in vfio_connect_kvm_msi_virq()
92* 0d3db94a8866 malike:
   block/cloop: fix integer overflow in total_sectors calculation
93* 5b0ba385a024 Denis V. Lunev:
   block/accounting: take stats->lock in latency histogram setters
94* 16f94ef4c6ce Denis V. Lunev:
   block/qapi: take stats->lock when reading BlockAcctStats for 
   query-blockstats
95* 842c89281a20 Denis V. Lunev:
   tests/unit: add reproducer for BlockAcctStats histogram locking race
96* 0c43f801c0d7 Stefan Hajnoczi:
   dmg: fix out-of-bounds load in search_chunk() (CVE-2026-65929)
97* ab7b872f0c38 Stefan Hajnoczi:
   dmg: refuse to open files with no chunks
98* 370882d08695 Stefan Hajnoczi:
   dmg: reject inconsistent UDRW chunk sector count and length 
   (CVE-2026-65928)
99* fe0f9e3ab2a8 Denis V. Lunev:
   qcow2: do not try to clear the dirty bit on a read-only node
100* 43e4791d99ab Denis V. Lunev:
   iotests: run the test pool with the 'fork' start method
101* e554413bd2b4 Denis V. Lunev:
   coroutine: fix lost wakeup in qemu_co_sleep_wake()
102* b9ad1c4396e7 Fiona Ebner:
   block/export/fuse: fix regression with O_TRUNC when export is not growable
103* 7d06bbb2d9ba Fiona Ebner:
   iotests: test O_TRUNC behavior for fuse exports
104* 241095547a5d Marc-André Lureau:
   hw/display/virtio-gpu: validate blob iov size
105* 95687639e647 Marc-André Lureau:
   hw/display/vga: fix panning_buf OOB after text/graphics switch
106* a113e0c53fb5 Marc-André Lureau:
   vhost-user-gpu: fix integer overflow in buffer allocation
107* b8ef970532c3 Marc-André Lureau:
   hw/display/virtio-gpu: fix offset wraparound in scanout_blob_to_fb
108* 1f24066fc88d Ankur Saini:
   virtio-gpu: reject requests with short/truncated control headers
109* d513c644b893 Akihiko Odaki:
   hw/display/virtio-gpu: Always reject invalid scanout bounds
110* 5ce01c92389a Bin Guo:
   hw/display/virtio-gpu: Unmap DMA regions on reset
111* 1d5e53df1674 Minwoo Im:
   hw/nvme: drop AER requests without aiocb in nvme_del_sq()
112* 849ea354ddc1 Minwoo Im:
   hw/nvme: factor out nvme_sq_cancel_inflight()
113* 86f938333e2f Minwoo Im:
   hw/nvme: cancel inflight requests on controller reset
114* 7a34f7b8794b Klaus Jensen:
   hw/nvme: fix leak on copy ranges
115* 784768f7facc Alejandro Jimenez:
   amd_iommu: Return int from page walk status helpers
116* 923222000443 Stefan Hajnoczi:
   gitlab: disable provenance attestations to work around CI bug
117* bc4681990bb6 Mikulas Patocka:
   linux-user/sh4: Deliver SIGILL on invalid instruction
118* 668d571bf0c2 Mikulas Patocka:
   linux-user/sh4: Initialize the FPSCR register on signal
119* f7ad7b1f8c81 Mikulas Patocka:
   linux-user/sh4: Fix crashes on signal delivery in conditional delay slot
120* 01b4e06b5225 Saul Freedman:
   target/i386/kvm: Fix CET SSP MSR read feature check
121 4713988da1c3 Matt Turner:
   linux-user: implement mount_setattr(2)
122 2fad751ed6b1 Philippe Mathieu-Daudé:
   hw/arm/aspeed: Add missing PCI_EXPRESS -> PCIE_PORT Kconfig dependency
123 6440880ed371 Philippe Mathieu-Daudé:
   hw/arm/aspeed: Add missing Kconfig dependencies on required components
124 fcc2699d41ed Philippe Mathieu-Daudé:
   target/s390x: Have MSA helper pass a mmu_idx argument
125 aae77f5dddef Ilya Leoshkevich:
   target/s390x: Make PRNO TRNG interruptible
126 abe1d893f41d Ilya Leoshkevich:
   tests/tcg/s390x: Test PRNO TRNG interruptibility
127 0103cb1cd175 Ilya Leoshkevich:
   target/s390x: Fix DR/D INT64_MIN / -1 host crash
128 aa5d03bc9351 Ilya Leoshkevich:
   tests/tcg/s390x: Test DR overflow (INT64_MIN / -1)
129 4e994ebb0144 Christian Borntraeger:
   hw/char/sclpconsole-lm: avoid guest triggerable assert
130 df607fd05604 Joshua Daley:
   s390x/ipl: validate num_comp against iplb length before iterating
131 c12bb74fd57f Zhuoying Cai:
   pc-bios/s390-ccw: Refactor byte swapping
132 730173107a98 Jared Rossi:
   pc-bios/s390-ccw/virtio.c: Fix missing break for PCI notifications
133 084feb909808 Zhuoying Cai:
   pc-bios/s390-ccw: Add per-queue notification offset for multi-queue 
   virtio configurations
134 e26dafb207bc Jared Rossi:
   pc-bios/s390-ccw: Verify virtio support when booting from virtio PCI 
   device on s390x
135 d04736438035 Jared Rossi:
   pc-bios/s390-ccw: write IPLB location for non-net virtio devices
136 f4b7ae0a9ee4 Cornelia Huck:
   pc-bios/s390-ccw.img: update s390x bios
137 a9f1e84c6b82 Joshua Daley:
   pc-bios/s390-ccw: fix out-of-bounds read in iso_get_file_size()
138 33909d4ebd5c Joshua Daley:
   pc-bios/s390-ccw: bounds-check zipl menu entry index before array write
139 a3856a7ba44b Joshua Daley:
   pc-bios/s390-ccw: bound zipl menu strlen and replace VLA in 
   zipl_print_entry
140 c4d9412cdd1c Jared Rossi:
   pc-bios/s390-ccw: Fix off-by-one errors with loadparm and boot entries
141 9b3d68edb24d Eric Farman:
   pc-bios/s390-ccw.img: update s390x bios
142 2c32c273da6d Ilya Leoshkevich:
   target/s390x/tcg: Set STCK/STCKF condition code after the store
143 e79ea4472691 Ilya Leoshkevich:
   tests/tcg/s390x: Test STCKF condition code on a faulting store
144 ac7fa2e9d457 Peter Xu:
   migration/multifd: Validate next_packet_size in zlib/zstd recv
145 cf45083edc2b Peter Xu:
   migration/multifd: Replace assert() with error_setg() in recv paths
146 80776c4df92c Bin Guo:
   hw/intc/loongarch_pch_pic: Validate htmsi_vector before indexing 
   parent_irq
147 15700a66ecb5 Thomas Huth:
   hw/usb/dev-uas: Don't abort if guest provided an undersized buffer for 
   status
148 46099d990055 Thomas Huth:
   hw/net/vmxnet3: Do not abort if guest provides bad interrupt numbers
149 ebec7c732298 Denis V. Lunev:
   tests/qtest/ide-test: parametrize the ATAPI CD-ROM read test
150 fe543c2d787a Denis V. Lunev:
   tests/qtest/ide-test: add a multi-sector ATAPI DMA read test
151 502dbdfd9687 Denis V. Lunev:
   tests/qtest/ide-test: cover raw (2352-byte) ATAPI CD reads
152 de86ef3dfd33 Denis V. Lunev:
   tests/qtest/libqos/ahci: support raw (2352-byte) READ CD
153 31f13e71afd1 Denis V. Lunev:
   tests/qtest/ahci: cover raw (2352-byte) ATAPI CD reads
154 12289dc700d9 Denis V. Lunev:
   hw/ide/atapi: read the whole elementary transfer asynchronously
155 be1ee6a8f6e3 Denis V. Lunev:
   tests/qtest/ahci: regression test for ATAPI read vs. drain
156 6ccf1e73fc65 Dario Faggioli:
   hw/i386/pc: xen: reinstate the "xenfv" machine alias
157 59fc7b747d56 Peter Maydell:
   hw/net/rtl8139: Fix handling of VLAN tags on incoming short packets
158 f3a10c1c4547 Peter Maydell:
   hw/net/rtl8139: Send whole of vlan-tagged packet when doing loopback
159 60d010f66f2a Bin Guo:
   hw/block/pflash_cfi01: Restore ROMD mode after migration
160 6dab35f5492b Stefan Hajnoczi:
   hw/nvme: add SPDM_SOCKET Kconfig dependency
161 260d49d8e283 Alex Bennée:
   hw/elf_ops: defend against weird elf headers

(commit(s) marked with * were in previous series and are not resent)

