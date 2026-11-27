Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97AA606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=GlKOjj56
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWouu-0002qv-NX; Fri, 27 Nov 2026 00:54:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWous-0002qP-Dz; Fri, 27 Nov 2026 00:54:38 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWouo-0007Sd-MV; Fri, 27 Nov 2026 00:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758862; bh=04EslIeeuLm+AzjgWEp8c/lXWcGsKhql4ZesuWVG6K8=;
 h=From:To:Cc:Subject:Date;
 b=GlKOjj56D/Uxm/dYXjSmMVY6fW+WajUYuodSS9NpUYGz1qzFdemZUgF9149h6NtlI
 feTHn9EN+TR5YGudyS/SM5/jsPfson+juGoztpht7EexcKnsEiyVKURD+sy1A079S1
 YXAkbPmbGUE3SkfyUUSgfNd5L6Yod7uWOMqeIJ0l8A7gocpEn/cEzDd6D9r7Yc07Sl
 LiqktUjHrmjec3NXKgeNKbj5BAPay87fggdpCZMezQ+nj+jG79MeODN+t3+OffBQWC
 csy5Th2HN7MMTjXCFClNap3fDxPE5Qcqc0mjsgAFJvVDxT/Z9aDBi6SQyiZ5KTh0Qb
 uXMk/5mDBb4SQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B1C661EA2C2;
 Fri, 27 Nov 2026 08:54:22 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 08DDF469900;
 Fri, 27 Nov 2026 08:54:22 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id EE0C5CF20C; Fri, 27 Nov 2026 08:54:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 000/140] Patch Round-up for stable 10.0.16,
 freeze on 2026-11-26 (frozen)
Date: Fri, 27 Nov 2026 08:52:45 +0300
Message-ID: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following patches are queued for QEMU stable v10.0.16:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-10.0

Patch freeze is 2026-11-26 (frozen), and the release is planned for 2026-11-28:

  https://wiki.qemu.org/Planning/10.0

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* 349a5fa831b7 Collin Walling:
   target/s390x: externalize feat dependency array
02* 5aff5b12b713 Collin Walling:
   target/s390x: mark feats dependent on deprecated feats as deprecated
03* c341f8ce205f Peter Maydell:
   linux-user/loongarch64: In extframe_alloc, align before subtracting 
   sctx_info size
04* 24f4453789bd Omar Elghoul:
   s390x/pci: reclaim DMA slots upon IOMMU disable
05* 2b1b98f00332 Peter Maydell:
   linux-user: Use QemuSemaphore to wait for clone child thread
06* 9c20897e50f4 Tan Chi:
   hw/riscv/riscv-iommu: fix entry leak with ioatc-limit=0
07* 0b76df366bfd Nikhil Kumar Singh:
   hw/pci-host/pnv_phb4: fix guest-triggerable abort on 8-byte config access
08* c278e6dc1abc Bernhard Beschow:
   hw/watchdog/wdt_imx2: Preserve own locked bits in WCR
09* 328d4c566a03 Bernhard Beschow:
   hw/watchdog/wdt_imx2: Fix handling of write one once WCR bits
10* 98d21eef2c38 Bernhard Beschow:
   hw/watchdog/wdt_imx2: Clear WDT lock on reset
11* b26d4302a897 Peter Maydell:
   hw/net/cadence_gem: Check guest-provided queue numbers in screening 
   registers
12* 91a551871ff Junjie Cao:
   hw/cxl: free the CCI background timer on Type-3 reset and exit
13* 4992210c8445 Daejun Park:
   hw/ufs: Fail SCSI commands that move data without a PRDT
14* ad2f77a00b4a Daejun Park:
   hw/ufs: Pass SYNCHRONIZE CACHE(16) to scsi-hd as SYNCHRONIZE CACHE(10)
15* f9e0f4d949a0 Daejun Park:
   hw/ufs: Check the PRDT size against the transfer length of the CDB
16* e0c80f0b9ca5 Keith Monahan:
   target/hppa: Use 32-bit load of PSW in rsm and ssm
17* 2a2fc7ea6c72 Stefan Hajnoczi:
   qed: fix incorrect denominator in qed_bytes_to_clusters() 
   (CVE-2026-118594)
18* 03efcb7cfdef Oleksij Samorukov:
   qga: set FreeBSD virtio-serial channel to raw mode
19* e91d320a5bbc Farhan Ali:
   s390x/pci: Free FMB timer on zPCI device unplug
20* b71287f00782 Farhan Ali:
   s390x/pci: Change reset method from legacy to resettable exit
21* c8b6ce2fa6d6 Peter Maydell:
   hw/dma/xlnx_dpdma: Don't allow DMA off end of host buffers
22* 753e24f55f0f Peter Maydell:
   target/arm: For linux-user, prioritize PC misalignment fault over insn 
   abort
23* ab46596975c5 Junjie Cao:
   usb-host: reset the open retry count after a successful open
24* 8b604732242e Junjie Cao:
   hw/usb/hcd-xhci: fail Address Device when the DCBAA entry is unreadable
25* 213c716c5873 Junjie Cao:
   tests/qtest/usb-hcd-xhci: test Address Device with an unreadable DCBAA
26* 9f94fd68c89b Paolo Bonzini:
   target/i386/tcg: reject VEX.NP for MMX instructions
27* 41d5e37e0e20 Philippe Mathieu-Daudé:
   hw/virtio/vhost: Replace legacy cpu_physical_memory_*map() calls
28* 558084367e90 Vladimir Sementsov-Ogievskiy:
   vhost: make vhost_memory_unmap() null-safe
29* c85f42703df6 Vladimir Sementsov-Ogievskiy:
   vhost: vhost_virtqueue_start(): fix failure path
30* 060ef8cac115 Vladimir Sementsov-Ogievskiy:
   vhost: simplify calls to vhost_memory_unmap()
31* 60abdf60d505 Vladimir Sementsov-Ogievskiy:
   vhost: move vrings mapping to the top of vhost_virtqueue_start()
32* 4801e50cf1af Vladimir Sementsov-Ogievskiy:
   vhost: vhost_virtqueue_start(): drop extra local variables
33* 4e61c89262aa Vladimir Sementsov-Ogievskiy:
   vhost: final refactoring of vhost vrings map/unmap
34* 94c862925d3c Bibo Mao:
   target/loongarch: Fix memory access address with fldle
35* fa9e186ab673 Michael S. Tsirkin:
   virtio-net: validate IHL in virtio_net_rsc_extract_unit4 before use
36* 7eacd04f49b9 Manos Pitsidianakis:
   target/arm/ptw: check XN for ARMv6 in get_S1prot()
37* e7666745773f Ferdinand Schober:
   arm/cpu: fix GIC v3 flag for a64fx
38* 2527d738072b Manos Pitsidianakis:
   hw/intc/arm_gic: move num-priority-bits check
39* 43523008040e Manos Pitsidianakis:
   hw/intc/arm_gic: do not hardcode GICv2 minimum binary point
40* 47ecb8004103 Chris Copeland:
   target/arm: Clear the local monitor on AArch32 (v8) exception returns
41* bf67d56f282c Anton Johansson:
   target/riscv: Fix CPU state access on big-endian hosts
42* fdf80a4f5162 Peter Maydell:
   block/vmdk: Avoid assertion if image file has no extents
43* fe2cbdda07c2 Peter Maydell:
   block/vmdk: Avoid reading off the end of descriptor memory
44* 53c06d5239b4 Peter Maydell:
   block/vmdk: Use larger types for byte counts in vmdk_read_extent()
45* 09153b7e5f8f Peter Maydell:
   block/vmdk: Reject a zero cluster_sectors parameter
46* 43d614ab3a2d Peter Maydell:
   block/vmdk: Avoid overflowing multiplication in vmdk_open_vmdk4()
47* be9bac072ede Andrey Drobyshev:
   iotests/common.rc: add disk_usage function
48* c49dda7254d4 Eric Blake:
   iotests: Filter out ZFS in several tests
49* 26aae5102312 Andrey Drobyshev:
   iotests/290: add test case to check 'discard-no-unref' option behavior
50* 3fe45543bf42 Andrey Drobyshev:
   qcow2: fix snapshot data corruption with discard-no-unref=on
51* 8f23f50082b2 Andrey Drobyshev:
   iotests/290: add 'discard' and 'write -z -u' case with a snapshot
52* 67198583a1ef Thomas Huth:
   block/vhdx: Prevent out-of-bounds BAT accesses with malicious vhdx files
53* 74e68729ca8e Chinmay Rath:
   spapr-vscsi: clamp adapter info DMA write length to struct size
54* fd2cee4c2e64 Eric Blake:
   docs: Mention security considerations for NBD
55* 9bc9e737a384 Eric Blake:
   iotests: Refactor python NBD server setup
56* 3ec7bb19359c Eric Blake:
   nbd/server: Reject rather than assert on non-compliant BLOCK_STATUS
57* 3e6759157ecb Eric Blake:
   iotests: Add new nbd-robustness test
58* 325b8b75d508 Eric Blake:
   nbd/server: Reject rather than assert on non-compliant 
   NBD_OPT_SET_META_CONTEXT
59* e682c0e57017 Eric Blake:
   iotests: Add another nbd-robustness test
60 fc8bb17e4761 Peter Maydell:
   hw/core/qdev-properties-system.c: Don't leak str in set_drive_helper()
61 7149c66149a5 Peter Maydell:
   hw/net/net_rx_pkt: Handle bogus l4hdr_off when validating SCTP checksum
62 ba4bf5202438 Akihiko Odaki:
   net/eth.c: Check for undersized L2 headers in eth_get_protocols()
63 987f5bc647a2 Peter Maydell:
   net/eth.c: Check for undersized IPv4 headers in eth_get_protocols()
64 c27a586b8bd8 Akihiko Odaki:
   net/eth.c: In eth_get_protocols(), don't report TCP data offset off end 
   of packet
65 a80bcdb2ada5 Peter Maydell:
   net/eth.c: In eth_get_protocols(), don't report SCTP header off end of 
   packet
66 4828fff27b5b Akihiko Odaki:
   net/eth.c: In eth_parse_ipv6_hdr(), fix check of input size
67 34bca6376984 Akihiko Odaki:
   net/eth.c: Move the Routing Header Hdr Ext Len check
68 b5e0b450fc9a Peter Maydell:
   net/eth.c: Harden _eth_tcp_has_data() against short lengths
69 2dd4094cfb25 Peter Maydell:
   net/eth.c: Tighten size checks in eth_get_l3_proto()
70 5251fee208ac Peter Maydell:
   include/net/eth.h: Make eth_get_l2_hdr_length_iov() check protocol
71 bd649f019f4d Peter Maydell:
   hw/net/net_tx_pkt: Sanity check GSO headers in net_tx_pkt_build_vheader()
72 d95e10195aca Peter Maydell:
   hw/net/net_tx_pkt: Sanity check virt hdr len in net_tx_tcp_fragment_init
73 fda35a236c96 Peter Maydell:
   hw/net/net_tx_pkt: Sanity check L2+L3 header len in 
   net_tx_pkt_parse_headers()
74 e4236a7e877b Peter Maydell:
   hw/net/net_rx_pkt: Check for overflow in _net_rx_pkt_calc_l4_csum()
75 f996ee991c1f Peter Maydell:
   tests/qtest: Make netfilter tests accept padded ethernet packets
76 f448e6d9cf0a Peter Maydell:
   net: Pad short packets consistently regardless of backend
77 e17590ca62cb Stefan Weil:
   hw/net/eepro100: fix use-after-free on reset after hot-unplug
78 e019b94a0bca Markku Ahvenjärvi:
   hw/nvme: prevent cq_pending underflow
79 c5d75e36cd72 Markku Ahvenjärvi:
   hw/nvme: fix missed CQ updates
80 ada720d1e8b7 Markku Ahvenjärvi:
   hw/nvme: clear interrupts on controller reset
81 0b9935a84717 Klaus Jensen:
   hw/nvme: verify source and destination lba size for copy
82 e095e8baaa18 Klaus Jensen:
   hw/nvme: reject fdp.runs smaller than the lba data size
83 f7d61b406445 Klaus Jensen:
   hw/nvme: fix fdp reclaim unit accounting
84 c0080f560362 Klaus Jensen:
   hw/nvme: fix broadcast fdp events handling
85 d472efd0f1f1 Philippe Mathieu-Daudé:
   tcg/riscv64: Fix logical vector immediate matching and emission
86 16e9879ed2ff Philippe Mathieu-Daudé:
   tests/tcg/aarch64: Add vector immediate regression tests
87 09f671d8041f Bin Guo:
   hw/usb/u2f: validate ring buffer indices on migration load
88 224899c3d3be Tommaso Califano:
   hw/usb/dev-mtp: Fix recursive delete of directories
89 69aedf407d94 Tommaso Califano:
   hw/usb/dev-mtp: Check length of class control request
90 fe2a7966db94 Tommaso Califano:
   hw/usb/dev-mtp: Stop processing SendObjectInfo after an error
91 81ce8c16ee54 Chao Liu:
   hw/block/m25p80: fix write enable latch after WRSR2
92 8c40d4495d19 Peng Fan:
   hw/xen: Mark legacy Xen backends as hotpluggable
93 f445ebd9d7fc Eric Auger:
   hw/virtio/virtio-iommu: Fix IOVA address lookup
94 a1c20b516f0a Peter Maydell:
   target/arm: Get HVC UNDEF cases for Secure mode right
95 9567b4d2c38c LIU Zhiwei:
   target/arm: Fix RCsc ordering of store-release instructions
96 5c33a72bdebe LIU Zhiwei:
   target/arm: Fix barrier polarity of A32 LDA load-acquire
97 e777dac72518 malike:
   block/bochs: validate bitmap size and compute extent_blocks after 
   validation
98 95c27a042a78 Thomas Huth:
   block/vhdx-log: Improve sanity checks to avoid OOB accesses with bad 
   images
99 2a4384b4ef01 Thomas Huth:
   block/vhdx: Add alignment checks for region tables
100 d348cc1e52c8 Denis V. Lunev:
   target/i386/kvm: fix latched INIT lost in kvm_put_vcpu_events()
101 4e61c4bb175d Jiang Yuxuan:
   target/i386: raise #DE for INT_MIN / -1 in IDIV helpers
102 40a6c128beeb Zixin Wang:
   target/i386/tcg: treat ENTER's size operand as unsigned
103 75b2b67e6a95 Paolo Bonzini:
   tests/tcg: fix load/restore for test-avx and test-mmx
104 1d0777c4b64e Li RongQing:
   virtio: Reset free_head on shadow virtqueue start
105 b35d34e3ccd1 GuoHan Zhao:
   virtio-crypto: clean up every data queue
106 902c849979ce Thomas Huth:
   hw/virtio/virtio-crypto: Drain in-flight operations before unrealizing 
   (CVE-2026-50625)
107 8a91c8327cc8 Chinmay Rath:
   hw/scsi: validate IU buffer bounds in vscsi_preprocess_desc()
108 369852b536ed Eric Blake:
   nbd: Refactor structured payload interpretation
109 b96bec51a5ee Eric Blake:
   nbd: Pass back offset/length for all structured read replies
110 470888ffb022 Eric Blake:
   nbd/client: Don't leak uninitialized memory on malicious server
111 2bf4854e7924 Brian Cain:
   linux-user: copy nanosleep's remaining time on EINTR
112 c448f7d21250 Klaus Jensen:
   hw/nvme: report data transfer error on failed dma
113 63c965369686 Klaus Jensen:
   hw/nvme: fix zone descriptor extension allocation overflow
114 86d136c48476 Klaus Jensen:
   hw/nvme: fix open zone zrwa allocation
115 d31a68f013bf Klaus Jensen:
   hw/nvme: bound zrwa flush by the write area and zone write boundary
116 7e203726411b Klaus Jensen:
   hw/nvme: advance zone write pointer only once the write is committed
117 8f18c59c018e WANG Xuerui:
   host/include/loongarch64: Fix build with 128-bit LL/SC enabled
118 31b27c0b645e Barnabás Pőcze:
   linux-user: do not emulate PI futexes given endianness mismatch
119 434b0d52dc8c Peter Maydell:
   net/checksum.c: Correct handling of IP header length
120 811ec415a63c Peter Maydell:
   net/checksum: Correct handling of checksums when IP options present
121 4ffa12178cfb Peter Maydell:
   hw/net/rtl8139: Limit DMA transfers to plain memory
122 9b00833dfd9e Fuad Tabba:
   hw/intc/arm_gicv3_cpuif: Don't count a virtual EOI in EOImode 1
123 fe26463d7b3e Stefan Weil:
   CI: Use mingw-w64-x86_64-curl-winssl instead of mingw-w64-x86_64-curl for 
   Windows build
124 2bfbe39d0fff Thomas Huth:
   gitlab-ci: Switch the msys2 job to use ucrt
125 a814ba092e39 Philippe Mathieu-Daudé:
   hw/sd/sdcard: Do not abort when writing DAT lines on invalid cmd state
126 2a9bd40be705 Harshit Mukhedkar:
   hw/sd/sdcard: Validate migrated blk_len in post_load
127 3ff2400ba1a9 Philippe Mathieu-Daudé:
   hw/sd/sdcard: Reject zero block length (CMD16)
128 3025ea65bd51 Philippe Mathieu-Daudé:
   hw/sd/sdcard: Factor sd_response_size() out
129 b82e7a2a1da5 Philippe Mathieu-Daudé:
   hw/sd/sdbus: Provide buffer size to sdbus_do_command()
130 bbfb3b2b08b4 Philippe Mathieu-Daudé:
   hw/sd/sdhci: Report Auto CMD12 response timeout in error status
131 f2a3eb6bcf80 Denis V. Lunev:
   hw/ide/atapi: fix abort on CD-ROM reads past LBA 2^31
132 fe8c3c714990 Peter Maydell:
   hw/display/vmware_vga: Zero-initialize scratch space
133 0b3a66649912 Peter Maydell:
   hw/display/vmware_vga: Check for bogus FIFO_STOP and FIFO_NEXT values
134 555c5af38c76 Peter Maydell:
   hw/display/vmware_vga: Reject attempts to set resolution outside VRAM size
135 808365500e66 Peter Maydell:
   hw/display/vmware-vga: Check incoming migration width and height
136 0522a9457b07 Philippe Mathieu-Daudé:
   hw/block/pflash_cfi01: Register VM change handler once
137 c12cd67241c7 Philippe Mathieu-Daudé:
   hw/block/pflash_cfi01: Allow zero-count buffer write
138 7dcf2a795503 Philippe Mathieu-Daudé:
   hw/block/pflash_cfi01: Reject out-of-range blk_offset on load
139 c3800302668f Philippe Mathieu-Daudé:
   hw/ppc/amigaone: Invalidate TBs on NVRAM write
140 da70db241dc7 Philippe Mathieu-Daudé:
   target/ppc: Test CF_NO_GOTO_PTR in cflags, not in TB flags

(commit(s) marked with * were in previous series and are not resent)

