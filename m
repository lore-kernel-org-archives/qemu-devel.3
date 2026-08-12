Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774EBC5CFEE
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8bt-0003Lw-Jp; Wed, 12 Aug 2026 09:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8bq-0003LY-BQ; Wed, 12 Aug 2026 09:03:06 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8bm-0004Dx-3O; Wed, 12 Aug 2026 09:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539766; bh=dKlQ71OtDybuqv6ruZ0JZztF13NAyMNBQYVinzFp5hc=;
 h=From:To:Cc:Subject:Date;
 b=pzOms+9r5qgcrMK7g6KewJBEiekFt/Qvds54p9G7BP4P/PFLlu5TXQMhsZGZCWE34
 HE50IN8huMbnbNKUTc5DhUZVkNgYZrycUkkHbA+F6zLdQj0m4NAdfL46Pi34wy1jeM
 c2EAF+rY+gI9PKUyBnhXRulEpjqygijTuKBRqOcXuJQh4KZM86+ZEi5LpWqrt45QpQ
 PubpraukQtWIb8WIGWQR4cvAr6HPOn/iviEXcp4CNVWjyrFP16kcnYn/ZiikMEGdXk
 FQYr9KNs5rne3oFmqBfc2WrBoTvhfiCeMf3I1xMcXeSMb1AC/7TY/wheb5yYPc69u1
 qtFf/KvpXhRWQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 520621CA47F;
 Wed, 12 Aug 2026 16:02:46 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 85BC6409B62;
 Wed, 12 Aug 2026 16:02:57 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 16A1E2F894; Wed, 12 Aug 2026 16:02:33 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 000/102] Patch Round-up for stable 10.0.13,
 freeze on 2026-08-24
Date: Wed, 12 Aug 2026 16:00:35 +0300
Message-ID: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v10.0.13:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-10.0

Patch freeze is 2026-08-24, and the release is planned for 2026-08-26:

  https://wiki.qemu.org/Planning/10.0

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 702216619e2a Gerd Hoffmann:
   hw/uefi: add sanity check
02 ff5a9eb13c86 Gerd Hoffmann:
   hw/uefi: remove debug function
03 647ba95eda5a Gerd Hoffmann:
   hw/uefi: check lower limit for signature list size
04 8e0ddb4a6ebd Gerd Hoffmann:
   hw/uefi: account variable policy entries against storage size
05 acba2d78176d Gerd Hoffmann:
   hw/uefi: add post_load checks
06 bd9b3c50f458 Gerd Hoffmann:
   hw/uefi: make SetupMode read-only
07 c822ecd80661 Mario Casquero:
   vfio/pci: Initialize rom_read_failed in vfio_pci_load_rom()
08 256229e8f9b9 Tomita Moeko:
   vfio/igd: Clear saved BDSM in legacy VBIOS ROM at load time
09 dff528657fc1 Denis V. Lunev:
   vfio/pci: don't narrow a failed config read to a plausible value
10 86abb10256a5 Denis V. Lunev:
   vfio/pci: reject invalid PCI_INTERRUPT_PIN values
11 51aa3f3e0577 Andrey Polivoda:
   target/i386: helper_sysret(): Check that RCX contains a canonical address 
   when emulating an Intel CPU
12 d149a11c6c82 Paolo Bonzini:
   scsi-disk: protect against guest sending truncated data for MODE SELECT 
   commands
13 e2da3d92744d Paolo Bonzini:
   scsi-disk: fix off by one in assertion
14 443e02410695 Artem Nasonov:
   hw/ide: replace assert with proper error handling
15 f604b807a55a Thomas Huth:
   hw/display/vmware_vga: Don't allow guest to trigger long running loop in 
   host
16 a0414545a212 Christian Schoenebeck:
   hw/9pfs: fix O_TRUNC bypass on read-only export
17 210701c82e30 Jia Jia:
   hw/9pfs/virtio: drain in-flight PDUs before virtio-9p unrealize
18 1de8aea061b9 Christian Schoenebeck:
   hw/9pfs/xen: drain in-flight PDUs before xen-9p disconnect
19 b7520c9a5912 Thomas Huth:
   hw/usb/dev-uas: Fix guest-triggerable heap OOB access
20 9b899ddb2706 Thomas Huth:
   hw/ide/core: Fix possible crash via NULL pointer in ide_cancel_dma_sync()
21 68809288c7e5 Thomas Huth:
   hw/usb/core: Avoid possible assert() in do_parameter() --> 
   usb_packet_copy()
22 92abc3c51ebb Thomas Huth:
   hw/usb/hcd-xhci: Check return value of xhci_xfer_create_sgl() for errors
23 861372428b05 Marc-André Lureau:
   hw/display/virtio-gpu: validate stride against width on scanout
24 9c724426f519 Akihiko Odaki:
   hw/display/virtio-gpu: reject strides exceeding INT_MAX
25 76dcc0832c5c Akihiko Odaki:
   hw/display/virtio-gpu: Remove the bytes_pp field
26 1c1232c2ee07 Marc-André Lureau:
   hw/display/vhost-user-gpu: validate message payload sizes
27 efa7244b2a0b Marc-André Lureau:
   ui/vnc: remove redundant rows computation
28 4727cc883b7e Haotian Jiang:
   hw/display/qxl: unregister vm_change_state handler and BHs
29 b28778131fad Marc-André Lureau:
   net/colo: fix g_hash_table_destroy assertion on uninitialized filter
30 415f2759d7b3 Marc-André Lureau:
   target/i386/sev: fix MemoryRegion reference leaks in gpa2hva callers
31 8ac0a1c7b98e Haotian Jiang:
   virtio-gpu: fix NULL deref in rutabaga set_scanout
32 0fa3e1823b9b Akihiko Odaki:
   hw/display/virtio-gpu: Fix empty blob discrimination
33 4ae1c5c7d6f3 Akihiko Odaki:
   hw/display/virtio-gpu: Initialize blob mapping for ATTACH_BACKING
34 5322889f07b5 Marc-André Lureau:
   rutabaga: improve error handling, fix potential crash during init
35 5c9ef661a60a Akihiko Odaki:
   hw/display/virtio-gpu: Block Rutabaga migration
36 52c7bb369b23 Michael S. Tsirkin:
   virtio-net: fix OOB read in RSC receive path
37 772488562053 Michael S. Tsirkin:
   virtio-net: fix short frame OOB read in receive_filter()
38 fbdfdbb9920c Michael S. Tsirkin:
   libvhost-user: protect against OOB writes in vu_set_inflight_fd
39 758ef96a2dba Michael S. Tsirkin:
   libvhost-user: protect against OOB vring queue access
40 6dbdc271f56b Laurent Vivier:
   hw/virtio: reject zero-length packed indirect descriptor table
41 27806d2ddba2 Michael S. Tsirkin:
   vhost: do not crash on ring map failure
42 f404bf0e6504 Michael S. Tsirkin:
   virtio-scsi: fix SCSIRequest leak on a bad request
43 665c854390e0 Michael S. Tsirkin:
   virtio: fail early on bad config_len in migration
44 cf89b769cdd1 Michael S. Tsirkin:
   vhost-user: assert nregions within limit
45 5cc182ba39a3 Michael S. Tsirkin:
   virtio-pmem: wait for flush requests on unrealize
46 bf21298c082c Michael S. Tsirkin:
   libvhost-user: validate last_batch_head in vu_check_queue_inflights
47 b9d248dfaca5 Michael S. Tsirkin:
   libvhost-user: fix heap overflow in vu_check_queue_inflights
48 733a98a552e4 Michael S. Tsirkin:
   libvduse: validate vq size
49 67550d65b4bf Michael S. Tsirkin:
   virtio-iommu: fix OOM due to unbounded call_rcu
50 7ea56dcc9406 Peter Maydell:
   hw/pci-host/q35.c: Always initialize smram-region even if SMM disabled
51 a90fcf0080da Peter Maydell:
   hw/pci-host/q35.c: Factor out creation of SMRAM MRs
52 e07c67584c69 Peter Maydell:
   hw/pci-host/q35.c: Avoid early return in mch_write_config()
53 421f45d03f32 GuoHan Zhao:
   hw/virtio/vdpa-dev: pass set_config buffer to vhost backend
54 292902ae4e93 Haotian Jiang:
   hw/cxl: fix OOB access in cxl_doe_cdat_rsp via entry_handle
55 0691bb257a7c Clément MATHIEU--DRIF:
   intel_iommu: Check address mask before using it in pasid-based iotlb 
   invalidation
56 df12999cc813 Laurent Vivier:
   hw/net/virtio-net: Protect from DMA re-entrancy bugs
57 0be94d8d9c28 Laurent Vivier:
   hw/virtio-rng: Fix host use-after-free (CVE-2026-50624)
58 70074cc48f45 Laurent Vivier:
   backends/rng: cap request size to avoid oversized allocation
59 6682ea339127 Stefan Hajnoczi:
   virtio: avoid packed vring virtio_queue_empty() infinite loops 
   (CVE-2026-16457)
60 8268d216a004 Cédric Le Goater:
   linux-user: Guard local FUTEX_CMD_MASK definition
61 8cbcf7579355 Peter Maydell:
   hw/net/xilinx_axienet: Don't write checksums off end of packet
62 aba80ad9d853 Matt Turner:
   linux-user: fix guards for the fsmount(2) syscall series
63 b395a655ae0e Laurent Vivier:
   hw/net/e1000e: recalculate rx_desc_len on migration load
64 1e5efe6d9370 Laurent Vivier:
   hw/net/igb: recalculate rx_desc_len on migration load
65 d8813fdc4bdf Mark Cave-Ayland:
   target/sparc: set reg window data structures currently after vmstate load
66 db3abd36e4c7 Laurent Vivier:
   linux-user/sh4: allow full 32-bit address space
67 c4580a3a6d1c botszhuang:
   hw/i2c/bcm2835_i2c: Correct CLKT register offset
68 4f635bddf50c Peter Maydell:
   hw/display/exynos4210_fimd: Factor out finding screen width/height
69 7dd1e2218835 Peter Maydell:
   hw/display/exynos4210_fimd: Pass width to draw_line functions
70 a5f8d33682be Peter Maydell:
   hw/display/exynos4210_fimd: Clamp windows to screen size
71 a5cff318f06c Michael S. Tsirkin:
   virtio-mmio: fix QUEUE_NUM_MAX
72 df67805ee9b1 Klaus Jensen:
   hw/nvme: fix cross-namespace copy dif buffer overflow
73 c39e05af439a Klaus Jensen:
   hw/nvme: fix unintentional integer overflow in shift
74 6e5ca34f3870 Daniel Paziyski:
   hw/nvme: fix assertion failure on subregion removal
75 9e3df3019d21 Helge Deller:
   linux-user: Fix msqid_ds struct wrt 32-bit big endian architectures
76 518a4aa01b88 no92:
   linux-user: fix incorrect msg_l[sr]pid members of target_msqid_ds
77 0d3db94a8866 malike:
   block/cloop: fix integer overflow in total_sectors calculation
78 a55402d5c3a8 Kevin Wolf:
   block: Fix crash after setting latency historygram with single bin
79 5b0ba385a024 Denis V. Lunev:
   block/accounting: take stats->lock in latency histogram setters
80 16f94ef4c6ce Denis V. Lunev:
   block/qapi: take stats->lock when reading BlockAcctStats for 
   query-blockstats
81 842c89281a20 Denis V. Lunev:
   tests/unit: add reproducer for BlockAcctStats histogram locking race
82 0c43f801c0d7 Stefan Hajnoczi:
   dmg: fix out-of-bounds load in search_chunk() (CVE-2026-65929)
83 ab7b872f0c38 Stefan Hajnoczi:
   dmg: refuse to open files with no chunks
84 370882d08695 Stefan Hajnoczi:
   dmg: reject inconsistent UDRW chunk sector count and length 
   (CVE-2026-65928)
85 fe0f9e3ab2a8 Denis V. Lunev:
   qcow2: do not try to clear the dirty bit on a read-only node
86 43e4791d99ab Denis V. Lunev:
   iotests: run the test pool with the 'fork' start method
87 e554413bd2b4 Denis V. Lunev:
   coroutine: fix lost wakeup in qemu_co_sleep_wake()
88 241095547a5d Marc-André Lureau:
   hw/display/virtio-gpu: validate blob iov size
89 95687639e647 Marc-André Lureau:
   hw/display/vga: fix panning_buf OOB after text/graphics switch
90 a113e0c53fb5 Marc-André Lureau:
   vhost-user-gpu: fix integer overflow in buffer allocation
91 b8ef970532c3 Marc-André Lureau:
   hw/display/virtio-gpu: fix offset wraparound in scanout_blob_to_fb
92 1f24066fc88d Ankur Saini:
   virtio-gpu: reject requests with short/truncated control headers
93 d513c644b893 Akihiko Odaki:
   hw/display/virtio-gpu: Always reject invalid scanout bounds
94 5ce01c92389a Bin Guo:
   hw/display/virtio-gpu: Unmap DMA regions on reset
95 1d5e53df1674 Minwoo Im:
   hw/nvme: drop AER requests without aiocb in nvme_del_sq()
96 849ea354ddc1 Minwoo Im:
   hw/nvme: factor out nvme_sq_cancel_inflight()
97 86f938333e2f Minwoo Im:
   hw/nvme: cancel inflight requests on controller reset
98 7a34f7b8794b Klaus Jensen:
   hw/nvme: fix leak on copy ranges
99 923222000443 Stefan Hajnoczi:
   gitlab: disable provenance attestations to work around CI bug
100 bc4681990bb6 Mikulas Patocka:
   linux-user/sh4: Deliver SIGILL on invalid instruction
101 668d571bf0c2 Mikulas Patocka:
   linux-user/sh4: Initialize the FPSCR register on signal
102 f7ad7b1f8c81 Mikulas Patocka:
   linux-user/sh4: Fix crashes on signal delivery in conditional delay slot

