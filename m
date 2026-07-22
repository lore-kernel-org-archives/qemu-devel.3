Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F078C44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWLR-00028S-JB; Wed, 22 Jul 2026 08:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWLP-000289-Im; Wed, 22 Jul 2026 08:46:39 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWLL-0001aJ-PA; Wed, 22 Jul 2026 08:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724374; bh=ssCVLhuINZRoxChTKS9gAtk9ONIobCbkOnxJ7LV8RGg=;
 h=From:To:Cc:Subject:Date;
 b=Vf7kLdAW4l3SincoZR7PWY8CySKZ8CiOsPZlkHFbfQhgSRLtkShfrhwPcjaciTCAf
 qFQZrxfJfUCdVXshJFssfsbsJhzTxNpTIGus1HcF/Gr5nTD0uJsTuO1UKL0yKn0dVW
 HFcIxrQV2afNVyRuMKYAR8rp8EDx3SHmz9yX3YCEVgG+2/VBfZqX4Gv9cvaM5UsXNn
 r+Yhug/1OM/PfS5wfZxaZajzzOg4eGSM5syJtX8/XEeB+ujqu2S9iqQx7fnZu1MHMe
 R+QTBM/8RwgVRyFpx18Rr3+IFNm8iRmyo5+fk3Nl182rNMkQ/oLA8blKAWlL3wX4oI
 wkbnJp8UoVdow==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 915311C3AF4;
 Wed, 22 Jul 2026 15:46:14 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D5BC43F374E;
 Wed, 22 Jul 2026 15:46:31 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A0B0F17ED1; Wed, 22 Jul 2026 15:46:22 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 v2 000/122] Patch Round-up for stable 10.0.12,
 freeze on 2026-07-22 (frozen)
Date: Wed, 22 Jul 2026 15:45:24 +0300
Message-ID: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v10.0.12:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-10.0

Patch freeze is 2026-07-22 (frozen), and the release is planned for 2026-07-24:

  https://wiki.qemu.org/Planning/10.0

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* 27f6d5ba9c97 Marc-André Lureau:
   ui/gtk: fix bad widget realize on non-GFX VC
02* a57e4612b61d Christian Borntraeger:
   s390x/kvm: clamp stsi 3.2.2 size
03* f2bb367d2b26 Greg Kurz:
   9pfs: Don't use file descriptors in core code
04* 4f82ce8cd94f Greg Kurz:
   9pfs: local : Introduce local_fid_fd() helper
05* a1c0e5a73740 Christian Schoenebeck:
   hw/9pfs: add msize_limit transport callback
06* 4a1a2fa4d351 Christian Schoenebeck:
   9pfs/virtio: implement msize_limit callback
07* 815d1799c3d3 Christian Schoenebeck:
   9pfs/xen: implement msize_limit callback
08* bb5ab96e35a1 Christian Schoenebeck:
   hw/9pfs: cap negotiated msize to transport limit
09* 4b615eaa1be4 Christian Schoenebeck:
   hw/9pfs: add response_buffer_size transport callback
10* 12bcbdca8ae9 Christian Schoenebeck:
   9pfs/virtio: implement response_buffer_size callback
11* 69c8f5e6946f Christian Schoenebeck:
   9pfs/xen: implement response_buffer_size callback
12* 64c6c7e0df72 Christian Schoenebeck:
   hw/9pfs: cap Treaddir allocation (CVE-2026-9238)
13* 693b296b176d Christian Schoenebeck:
   hw/9pfs: add xattr FID limit to prevent memory exhaustion
14* e6116a81f04c Christian Schoenebeck:
   hw/9pfs: add max_xattr option
15* 44cb540d2d07 Christian Schoenebeck:
   qemu-options: document 9pfs max_xattr option
16* 54b8f64c422d Christian Schoenebeck:
   tests/9p: add Tread / Rread test client functions
17* c46150530b3d Christian Schoenebeck:
   tests/9p: add Tclunk / Rclunk test client functions
18* 7664feb26fef Christian Schoenebeck:
   tests/9p: add Txattrcreate / Rxattrcreate test client functions
19* 0e3085ddc7fb Christian Schoenebeck:
   hw/9pfs: enable xattr (mockup) support for synth fs driver
20* 7e42d569a68a Christian Schoenebeck:
   hw/9pfs: add xattr count query interface to fs synth driver
21* df8825554366 Christian Schoenebeck:
   tests/9p: increase P9_MAX_SIZE for test client
22* 84525ece6817 Christian Schoenebeck:
   tests/9p: add virtio_9p_add_synth_driver_args() test client function
23* 0e1085819e44 Christian Schoenebeck:
   tests/9p: add 3 xattr FID limit test cases (synth fs driver)
24* 04a62cdfe873 Christian Schoenebeck:
   tests/9p: add 3 xattr FID limit test cases (local fs driver)
25* 32cae47c332f Christian Schoenebeck:
   hw/9pfs: fix invalid union access by v9fs_co_fsync()
26* c3aa2491cd2c Christian Schoenebeck:
   hw/9pfs: fix invalid union access by v9fs_co_fstat()
27* 75893c058b21 Christian Schoenebeck:
   hw/9pfs/local: harden local_fid_fd() on FID types
28* fa2cf7488379 Inochi Amaoto:
   target/riscv: Check PMP before updating PTE
29* fdfcd98f6656 Qingwei Hu:
   hw/riscv/virt-acpi-build: Fix RINTC PLIC context ID for KVM
30* 46d96da13098 ZhengXiang Qin:
   target/riscv: avoid abort when reading vtype before env->xl is set
31* dcd028517749 SeungJu Cheon:
   target/riscv: Apply UXL WARL handling to vsstatus
32* 64ce9ac18757 Daniel Henrique Barboza:
   hw/riscv/riscv-iommu.c: always fault with SADE=0 and A=0
33* 36b37f849480 Laurent Vivier:
   hw/char/virtio-serial-bus: fix guest-triggerable OOM in control_out()
34* 32a90850e1e4 Junjie Cao:
   virtio-net: validate RSS indirections_len in post_load
35* bc22c7e4187a Feifan Qian:
   hw/net/fsl_etsec: validate FCB offsets in process_tx_fcb()
36* 62b425bec3d5 Alex Bennée:
   hw/arm: use cortex-a9 mpcore base for CBAR on npcm7xx machines
37* ec917cd49918 Jesper Wendel Devantier:
   hw/nvme: fix FDP set FDP events
38* 034baf047fe1 Keith Busch:
   hw/nvme: ensure sgl forward progress
39* d88cd8f5570f Christian Borntraeger:
   s390x/sclp: reject invalid write event data headers
40* 2d709a70c757 Matthew Rosato:
   s390x/pci: Tighten region detection for BAR read/write
41* b8c8ec1d7526 Matthew Rosato:
   s390x/pci: Shrink RPCIT ranges to registered window
42* 386268daea86 Matthew Rosato:
   s390x/ioinst: Require strict length and format for SEI CHSC handler
43* 22f2da06a8b2 Eric Farman:
   s390x/css: limit number of CHPIDs in description
44* 42f599172ae0 Torin Carey:
   hw/misc/edu: restrict dma access to dma buffer
45* d9f78431d8eb Denis V. Lunev:
   hw/ide/ahci: cancel in-flight buffered reads on command engine restart
46* cb7bc10385f3 Denis V. Lunev:
   tests/qtest/ahci: test ATAPI read completing after engine restart
47* 03071f99a3e1 Peter Maydell:
   hw/dma/i8257: Return zeroes for read_memory in verify mode
48* 831a13665ab1 Peter Maydell:
   hw/scsi/mptsas: Reset doorbell state on reset
49* 0e51b71c7b77 Thomas Huth:
   hw/display/qxl: Fix mono cursor validation that can read past a cursor 
   chunk
50* e03463812e74 lizhaoxin04:
   vdpa: fix use-after-free of vqs in vhost_vdpa_device_unrealize
51* 7913b3b9463f hemanshu.khilari.foss:
   hw/core/qdev-clock: Fix potential null pointer dereference
52* 9e41b5d22aeb Sanjeeva Yerrapureddy:
   hw/net: fix e1000e/igb ip_len inflation by Ethernet minimum-frame padding
53* b79a9b6e5b56 Richard Henderson:
   accel/tcg: Use TLB_FORCE_SLOW not TLB_MMIO for user-only plugins
54* e03b7dac65d9 Ilya Leoshkevich:
   accel/tcg: Make PageFlagsNodes' start and last immutable
55* a079836005fb Richard Henderson:
   tcg/loongarch64: Fix vec_val computation in tcg_target_const_match
56* 911f7328e9e9 Richard Henderson:
   tcg/loongarch64: Improve constraints for TCG_CT_CONST_VCMP
57* c56ebd64b82a Richard Henderson:
   tcg/loongarch64: Fix cmp_vec with TCG_COND_NE
58* 614a52cf549e Randy Schifflin:
   target/sh4: fixup tcg for sh4 fipr/ftrv instructions
59* 90aacd5bc405 Jia Jia:
   hw/ufs: avoid double unref of wrapped scsi-hd
60* b18e3f0e2d0f Daniel Henrique Barboza:
   hw/riscv/riscv-iommu.c: fix fault type for spa_fetch() faults
61* c1d5ec3a2f4b Daniel Henrique Barboza:
   hw/riscv/riscv-iommu.c: check for reserved PTE bits
62 b795ea0ba471 Daniel Henrique Barboza:
   hw/riscv/riscv-iommu.c: fault when !PTE_U and no priv access
63* 9158c900ab30 Daniel Henrique Barboza:
   hw/riscv/riscv-iommu.c: fault for non-user PTE in G_STAGE
64* 11486349ad9b Daniel Henrique Barboza:
   hw/riscv/riscv-iommu.c: check reserved MSI PTE basic bits
65* 58e801f74e6a Daniel Henrique Barboza:
   hw/riscv/riscv-iommu-sys.c: record fault on IOMMU-generated MSI write
66* bf274c54295c Daniel Henrique Barboza:
   hw/riscv/riscv-iommu.c: check for misaligned IOHGATP_PPN
67* 79616dd6e499 Daniel Henrique Barboza:
   hw/riscv/riscv-iommu.c: update ioval2 when faulting in spa_fetch()
68* 6d2b9d542fe2 Daniel Henrique Barboza:
   hw/riscv/riscv-iommu: forbid GATE/SADE if caps.AMO_HWADD is zero
69* ca7bac51e04f Chengbo Gao:
   hw/riscv/riscv-iommu: Avoid caching PCI device IDs
70* 15406cc593a7 Frank Chang:
   hw/riscv: riscv-iommu: Don't look up DDT cache in Off and Bare modes
71* ce7fb3282756 Daniel Henrique Barboza:
   hw/riscv/riscv-iommu.c: set ftype and iova in riscv_iommu_ctx()
72* c497ef6739cf Akihiko Odaki:
   hw/riscv/riscv-iommu: Fix MemoryRegion owner
73* c7e61854544b Alistair Francis:
   hw/pci/pcie_doe: Check mailbox length for overflows
74* 18a522099090 Heinrich Schuchardt:
   tests: allow differences in SPCR
75* 15c73b0f17d2 Heinrich Schuchardt:
   hw/acpi: correct field sequence in SPCR table
76* ec7d32428757 Heinrich Schuchardt:
   tests: update SPCR loongarch64 and riscv64 test data
77 a47e3c26b1a0 Peter Maydell:
   linux-user: Validate guest-passed dm_ioctl data_size
78 79cabc6cb7fb Richard Henderson:
   target/arm: Be more defensive for invalid tlbi_aa64_get_range
79 4571c79c57ca Peter Maydell:
   hw/net/vmxnet3: Correct bounds check on tx queue index
80 2c6fae7d7da8 Peter Maydell:
   hw/usb/dev-wacom: Don't write off end of buffer
81 b378a1bd86b4 Peter Maydell:
   hw/display/sm501: Catch bad coordinates for RTL operations
82 422734d5fc2b Peter Maydell:
   hw/display/sm501: Avoid overflow problems in bounds check calculations
83 2ac2cf0483d0 Peter Maydell:
   hw/display/sm501: Don't allow guest to set ram size larger than it is
84 3c2749443429 Peter Maydell:
   hw/misc/stm32_rcc: Correct offset-to-irq calculation
85 0d4e15e8f80e Philippe Mathieu-Daudé:
   hw/s390x/sclp: Replace [cpu_physical_memory -> address_space]_r/w()
86 d39ac36fe298 Philippe Mathieu-Daudé:
   hw/s390x/sclp: Do not ignore address_space_read/write() errors
87 20701190e023 Christian Borntraeger:
   s390x/sclp: prevent re-reading the sclp header
88 33bece0fa121 Eric Farman:
   s390x/css: firm up handling of chained TIC CCWs
89 9db18ed0631d Matt Turner:
   linux-user/alpha: add coredump support
90 7a2e863f9dd5 Matt Turner:
   linux-user/alpha: populate AT_HWCAP from env->amask
91 5157ceb10ca8 Haotian Jiang:
   hw/misc/ivshmem: clear chardev handlers before freeing peers
92 a3cc0069e151 Marc-André Lureau:
   hw/display/qxl: fix TOCTOU in cursor chunk data_size handling
93 76dbe26fd650 Dmitry Pimenov:
   hw/sparc64/niagara: use int64_t for vdisk size to avoid truncation
94 5a811329bde7 Miao Wang:
   hw/scsi/vmw_pvscsi: translate data endianness
95 ecc569639aeb Miao Wang:
   hw/scsi/vmw_pvscsi: add a comment to explain the endianness
96 564c4d7e99d8 Marc-André Lureau:
   hw/display/virtio-gpu: fix dmabuf_fd leak on remap failure
97 98e5a8eb4fb9 Thomas Huth:
   hw/usb/hcd-ohci: Make sure that ohci_service_ed_list() cannot loop forever
98 5257259428ea Thomas Huth:
   hw/usb/hcd-xhci: Turn guest-triggerable abort() into qemu_log_mask()
99 3543c2b855cc Marc-André Lureau:
   ui/vnc: fix OOB write in vnc_refresh_lossy_rect
100 fb71c895d7ff Marc-André Lureau:
   ui/vnc: validate color shifts in SetPixelFormat
101 82b4d693d522 Marc-André Lureau:
   ui/input-barrier: fix off-by-one in keycode bounds check
102 53f0d87db7b4 Akihiko Odaki:
   ui/gtk: Narrow DMA-BUF critical section
103 e650e4fe0fb3 Marc-André Lureau:
   ui/vnc: fix out-of-bounds write in lossy refresh dirty marking
104 6075444c5a72 Marc-André Lureau:
   ui/vnc: validate SetPixelFormat field ranges
105 8720061c6d34 Marc-André Lureau:
   hw/display/virtio-gpu: cap submit_3d command buffer allocation
106 e99488c5d4a0 Marc-André Lureau:
   hw/display/virtio-gpu: handle migration iov allocation failure
107 f1af81ba2aee Akihiko Odaki:
   hw/display/virtio-gpu: Check pixman_image_create_bits() results
108 78420b59f0fe Alex Bennée:
   accel/tcg: move jit thread manipulation into do_tb_phys_invalidate
109 12d8ee9d5358 Feifan Qian:
   hw/usb/xhci: clamp interval exponent to avoid UB shift in 
   xhci_init_epctx()
110 054ef33f674c Xiangfeng Cai:
   hw/usb/hcd-xhci-pci: break host link cycle so device_finalize() runs on 
   unplug
111 ba54d7e66e25 Xiangfeng Cai:
   tests/qtest: add xhci-pci unplug finalize regression test
112 9bf52d056a03 Marc-André Lureau:
   usbredir: fix use-after-free on buffered bulk packet overflow
113 a002485bfef1 Marc-André Lureau:
   usbredir: fix infinite loop and SIGFPE with zero max_packet_size
114 4daeaa2fe0f9 Thomas Huth:
   hw/usb/hcd-xhci: Fix guest-triggerable assert() in xhci_find_stream()
115 cc479aa89743 Thomas Huth:
   hw/usb/hcd-xhci-sysbus: Fix OOB heap access in xhci_sysbus_intr_raise()
116 83927347227c Jay Chang:
   hw/net/xilinx_axienet: Fix PHY register 17 link status reporting
117 b1e73b2ddbb2 Peter Maydell:
   net: Correct padding check in qemu_receive_packet()
118 9f436938c521 Marc-André Lureau:
   hw/display/qxl: validate monitors_config heads[] in phys2virt
119 fe68e4b47bf5 Marc-André Lureau:
   replay: fix use of uninitialized pointer on error
120 2142689d92ca Philippe Mathieu-Daudé:
   hw/misc/applesmc: Fix a typo setting MSSD key
121 94c510a5dc48 Bin Meng:
   hw/net/cadence: Return current Cadence GEM queue pointers
122 c257745248b0 Haotian Jiang:
   hw/audio/intel-hda: restrict all DMA engine paths to memories

(commit(s) marked with * were in previous series and are not resent)

