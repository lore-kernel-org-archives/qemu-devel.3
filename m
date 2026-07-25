Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58755C531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 05:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnUqR-00052B-Qy; Sat, 25 Jul 2026 01:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wnUq6-0004y0-ID; Sat, 25 Jul 2026 01:22:24 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wnUq2-0007i6-KD; Sat, 25 Jul 2026 01:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784956913; bh=z2MqqNnJF7a/m68ep9aYOLVQFskbzF7UJzokVQ+wfuY=;
 h=From:To:Cc:Subject:Date;
 b=u9Fv7skzwvdjWXI11t6xAbvD/DGYOpdFHgyUowsM0ntEHvAwF/M20sLotcHRBw3Vi
 Pd+TVV8Ks0Kv8gya4rX2B7sFK0nz5EfoMt2Ioq/H2d0aCCK5Np7sBG19n4f9r01kzn
 e/lFMYFujzWTR53AsAiqzeo1WR0sSJk+iZphlveygWgiQzFNjCGRH/q6f37nhtruRf
 8jV9cj+9XKg8mQtJDgMVTjLMfCzKf/CwqmFx6oKLlazZDfhO5ftj8aAhN8bkipXkw4
 VGVUWlvF6TBI3CCKD0oKUcwcszt9pDAFC+tYrh51Ia4s5o2skUsPDy6xREIU7Yfz1o
 uqSPmPsY7T9FQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B98761C497A;
 Sat, 25 Jul 2026 08:21:53 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 562533F4C85;
 Sat, 25 Jul 2026 08:22:16 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 0178B185F5; Sat, 25 Jul 2026 08:22:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-stable@nongnu.org
Subject: [ANNOUNCE] QEMU 11.0.3 Stable released
Date: Sat, 25 Jul 2026 08:21:52 +0300
Message-ID: <20260725052155.1228635-1-mjt@tls.msk.ru>
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
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
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

The QEMU v11.0.3 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-11.0.3.tar.xz
  https://download.qemu.org/qemu-11.0.3.tar.xz.sig (signature)

v11.0.3 is now tagged in the official qemu.git repository, and the
stable-11.0 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-11.0

There are 129 changes since the previous v11.0.2 release, including
multiple security fixes.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-11.0-hash master-hash Author Name: Commmit-Subject):

aeec49e8170 Michael Tokarev:
 Update version for 11.0.3 release
43a9a542617 c2804566f6 Alex Bennée:
 target/arm: do not clear halting reason in has_work helper
aefafd403bd 6fd2fcdc61 Alex Bennée:
 target/arm: teach arm_cpu_has_work about halting reasons
d0fc8415343 c257745248 Haotian Jiang:
 hw/audio/intel-hda: restrict all DMA engine paths to memories
6944c6b8615 94c510a5dc Bin Meng:
 hw/net/cadence: Return current Cadence GEM queue pointers
64749657fef 2142689d92 Philippe Mathieu-Daudé:
 hw/misc/applesmc: Fix a typo setting MSSD key
d605d2769b5 fe68e4b47b Marc-André Lureau:
 replay: fix use of uninitialized pointer on error
f34830aa817 9f436938c5 Marc-André Lureau:
 hw/display/qxl: validate monitors_config heads[] in phys2virt
ee17866605a b1e73b2ddb Peter Maydell:
 net: Correct padding check in qemu_receive_packet()
9e4f8a8cbbc 8392734722 Jay Chang:
 hw/net/xilinx_axienet: Fix PHY register 17 link status reporting
2a5bc4de0f5 cc479aa897 Thomas Huth:
 hw/usb/hcd-xhci-sysbus: Fix OOB heap access in xhci_sysbus_intr_raise()
46ab8d7b90a 4daeaa2fe0 Thomas Huth:
 hw/usb/hcd-xhci: Fix guest-triggerable assert() in xhci_find_stream()
1e54185745b a002485bfe Marc-André Lureau:
 usbredir: fix infinite loop and SIGFPE with zero max_packet_size
6229fbcef1f 9bf52d056a Marc-André Lureau:
 usbredir: fix use-after-free on buffered bulk packet overflow
99a1c3b6368 ba54d7e66e Xiangfeng Cai:
 tests/qtest: add xhci-pci unplug finalize regression test
e9423caa278 054ef33f67 Xiangfeng Cai:
 hw/usb/hcd-xhci-pci: break host link cycle so device_finalize() runs on unplug
4612a7d02ba 12d8ee9d53 Feifan Qian:
 hw/usb/xhci: clamp interval exponent to avoid UB shift in xhci_init_epctx()
df91e7249b6 78420b59f0 Alex Bennée:
 accel/tcg: move jit thread manipulation into do_tb_phys_invalidate
cb1b5319cb5 f1af81ba2a Akihiko Odaki:
 hw/display/virtio-gpu: Check pixman_image_create_bits() results
4403b3db640 e99488c5d4 Marc-André Lureau:
 hw/display/virtio-gpu: handle migration iov allocation failure
7e6c76474e5 8720061c6d Marc-André Lureau:
 hw/display/virtio-gpu: cap submit_3d command buffer allocation
147e214e9cb 6075444c5a Marc-André Lureau:
 ui/vnc: validate SetPixelFormat field ranges
24767bcf0fd e650e4fe0f Marc-André Lureau:
 ui/vnc: fix out-of-bounds write in lossy refresh dirty marking
8cfd68c4b23 53f0d87db7 Akihiko Odaki:
 ui/gtk: Narrow DMA-BUF critical section
f145c5d2e05 82b4d693d5 Marc-André Lureau:
 ui/input-barrier: fix off-by-one in keycode bounds check
17c60da3e83 fb71c895d7 Marc-André Lureau:
 ui/vnc: validate color shifts in SetPixelFormat
738927b263c 3543c2b855 Marc-André Lureau:
 ui/vnc: fix OOB write in vnc_refresh_lossy_rect
76295c4f3e0 504f2bad93 Rohitashv Kumar:
 net: only advertise passt in netdev help when CONFIG_PASST
c548cb660d1 5257259428 Thomas Huth:
 hw/usb/hcd-xhci: Turn guest-triggerable abort() into qemu_log_mask()
abf441a5806 98e5a8eb4f Thomas Huth:
 hw/usb/hcd-ohci: Make sure that ohci_service_ed_list() cannot loop forever
ea4f6fb68bc 564c4d7e99 Marc-André Lureau:
 hw/display/virtio-gpu: fix dmabuf_fd leak on remap failure
f3248e1e191 ecc569639a Miao Wang:
 hw/scsi/vmw_pvscsi: add a comment to explain the endianness
7ea8410cabc 5a811329bd Miao Wang:
 hw/scsi/vmw_pvscsi: translate data endianness
772c0f54d8b 76dbe26fd6 Dmitry Pimenov:
 hw/sparc64/niagara: use int64_t for vdisk size to avoid truncation
3f247bed37f a3cc0069e1 Marc-André Lureau:
 hw/display/qxl: fix TOCTOU in cursor chunk data_size handling
e1fb4489818 5157ceb10c Haotian Jiang:
 hw/misc/ivshmem: clear chardev handlers before freeing peers
892ccda45a0 7a2e863f9d Matt Turner:
 linux-user/alpha: populate AT_HWCAP from env->amask
952ada91171 9db18ed063 Matt Turner:
 linux-user/alpha: add coredump support
9e3e2bdd71f 33bece0fa1 Eric Farman:
 s390x/css: firm up handling of chained TIC CCWs
adc0ac7c3bd 8a116a2853 Christian Borntraeger:
 s390x/sclpcpi: check event length field before reading from buffer
f0777ba872f 20701190e0 Christian Borntraeger:
 s390x/sclp: prevent re-reading the sclp header
ab8a4c1145a 3c27494434 Peter Maydell:
 hw/misc/stm32_rcc: Correct offset-to-irq calculation
3a728dde5df 2ac2cf0483 Peter Maydell:
 hw/display/sm501: Don't allow guest to set ram size larger than it is
c597c1c76a9 422734d5fc Peter Maydell:
 hw/display/sm501: Avoid overflow problems in bounds check calculations
e68642b206f b378a1bd86 Peter Maydell:
 hw/display/sm501: Catch bad coordinates for RTL operations
758d4cdb27a 2c6fae7d7d Peter Maydell:
 hw/usb/dev-wacom: Don't write off end of buffer
a615c572084 4571c79c57 Peter Maydell:
 hw/net/vmxnet3: Correct bounds check on tx queue index
a1c61f93282 79cabc6cb7 Richard Henderson:
 target/arm: Be more defensive for invalid tlbi_aa64_get_range
64226416c62 a47e3c26b1 Peter Maydell:
 linux-user: Validate guest-passed dm_ioctl data_size
6c586f357ed ec7d324287 Heinrich Schuchardt:
 tests: update SPCR loongarch64 and riscv64 test data
695018a6061 15c73b0f17 Heinrich Schuchardt:
 hw/acpi: correct field sequence in SPCR table
9899e0f351c 18a5220990 Heinrich Schuchardt:
 tests: allow differences in SPCR
9156f2b9581 c7e6185454 Alistair Francis:
 hw/pci/pcie_doe: Check mailbox length for overflows
3fc91129858 ce7fb32827 Daniel Henrique Barboza:
 hw/riscv/riscv-iommu.c: set ftype and iova in riscv_iommu_ctx()
49e8463e6c4 ca7bac51e0 Chengbo Gao:
 hw/riscv/riscv-iommu: Avoid caching PCI device IDs
a6b03518538 6d2b9d542f Daniel Henrique Barboza:
 hw/riscv/riscv-iommu: forbid GATE/SADE if caps.AMO_HWADD is zero
2e8fa5ed86d 79616dd6e4 Daniel Henrique Barboza:
 hw/riscv/riscv-iommu.c: update ioval2 when faulting in spa_fetch()
4f5e2c7715d bf274c5429 Daniel Henrique Barboza:
 hw/riscv/riscv-iommu.c: check for misaligned IOHGATP_PPN
79e21b2fab2 58e801f74e Daniel Henrique Barboza:
 hw/riscv/riscv-iommu-sys.c: record fault on IOMMU-generated MSI write
d05327400fa 11486349ad Daniel Henrique Barboza:
 hw/riscv/riscv-iommu.c: check reserved MSI PTE basic bits
3dfa835d445 9158c900ab Daniel Henrique Barboza:
 hw/riscv/riscv-iommu.c: fault for non-user PTE in G_STAGE
ca4a88e4ae1 b795ea0ba4 Daniel Henrique Barboza:
 hw/riscv/riscv-iommu.c: fault when !PTE_U and no priv access
76edd819449 c1d5ec3a2f Daniel Henrique Barboza:
 hw/riscv/riscv-iommu.c: check for reserved PTE bits
f6f4d1a1873 b18e3f0e2d Daniel Henrique Barboza:
 hw/riscv/riscv-iommu.c: fix fault type for spa_fetch() faults
a90c0920117 90aacd5bc4 Jia Jia:
 hw/ufs: avoid double unref of wrapped scsi-hd
94f798317d8 4952681a5f yujun:
 crypto/x509-utils: fix gnutls error code in crt_init failure path
f6427df1752 614a52cf54 Randy Schifflin:
 target/sh4: fixup tcg for sh4 fipr/ftrv instructions
ca7bfa27b7b c56ebd64b8 Richard Henderson:
 tcg/loongarch64: Fix cmp_vec with TCG_COND_NE
3b0195a9197 e03b7dac65 Ilya Leoshkevich:
 accel/tcg: Make PageFlagsNodes' start and last immutable
497273cecfb b79a9b6e5b Richard Henderson:
 accel/tcg: Use TLB_FORCE_SLOW not TLB_MMIO for user-only plugins
95abfb8549b 9e41b5d22a Sanjeeva Yerrapureddy:
 hw/net: fix e1000e/igb ip_len inflation by Ethernet minimum-frame padding
794e1c85fb3 b9a3b329d0 Stefan Hajnoczi:
 scsi: register again after PREEMPT without reservation
2ff4a9cacde 15a202656c Stefan Hajnoczi:
 scsi: always send valid PREEMPT TYPE field
802316b77f1 15c57ac351 Stefan Hajnoczi:
 scsi: adjust error_prepend() formatting
ca92663d7a3 7913b3b946 hemanshu.khilari.foss:
 hw/core/qdev-clock: Fix potential null pointer dereference
e42263941e3 8addbdb793 Nathan Chen:
 hw/arm/smmuv3: Update ATC invalidation check
8e546d82c97 e03463812e lizhaoxin04:
 vdpa: fix use-after-free of vqs in vhost_vdpa_device_unrealize
1a1ab5c233b dbc0ed5622 no92:
 intel_iommu: Correctly set pt bit in extended capability register
2cd92501d83 0e51b71c7b Thomas Huth:
 hw/display/qxl: Fix mono cursor validation that can read past a cursor chunk
7ec5e3141ea 831a13665a Peter Maydell:
 hw/scsi/mptsas: Reset doorbell state on reset
f6415f583a9 03071f99a3 Peter Maydell:
 hw/dma/i8257: Return zeroes for read_memory in verify mode
8a0f9ce3b32 cb7bc10385 Denis V. Lunev:
 tests/qtest/ahci: test ATAPI read completing after engine restart
79bdb9078e6 d9f78431d8 Denis V. Lunev:
 hw/ide/ahci: cancel in-flight buffered reads on command engine restart
af3338cb606 90f8e5c307 Junjie Cao:
 hw/display/ati: guard against zero bpp in ati_host_data_flush
8387fa09792 3565faa0ac Junjie Cao:
 hw/display/ati: reset host_data.next in write handler after flush
abb42519267 42f599172a Torin Carey:
 hw/misc/edu: restrict dma access to dma buffer
1a02d1d0c81 e819c126a8 Miao Wang:
 target/loongarch: Enable TARGET_PAGE_BITS_VARY for loongarch64 user-only
d34e721577e 22f2da06a8 Eric Farman:
 s390x/css: limit number of CHPIDs in description
1e397bc2e6f 386268daea Matthew Rosato:
 s390x/ioinst: Require strict length and format for SEI CHSC handler
fe98d317b1a b8c8ec1d75 Matthew Rosato:
 s390x/pci: Shrink RPCIT ranges to registered window
f4d46fb0900 2d709a70c7 Matthew Rosato:
 s390x/pci: Tighten region detection for BAR read/write
cfde0a53f26 d88cd8f557 Christian Borntraeger:
 s390x/sclp: reject invalid write event data headers
514eee6c4cc 034baf047f Keith Busch:
 hw/nvme: ensure sgl forward progress
0add8af2f0e ec917cd499 Jesper Wendel Devantier:
 hw/nvme: fix FDP set FDP events
b3676f72469 62b425bec3 Alex Bennée:
 hw/arm: use cortex-a9 mpcore base for CBAR on npcm7xx machines
47db3ee014b d77a93ca4b Oliver Upton:
 target/arm: Only evaluate SCR_EL3.PIEN if ARM_FEATURE_EL3 is present
db11e34db81 bc22c7e418 Feifan Qian:
 hw/net/fsl_etsec: validate FCB offsets in process_tx_fcb()
0d228637f8a 32a90850e1 Junjie Cao:
 virtio-net: validate RSS indirections_len in post_load
7fd7448e682 36b37f8494 Laurent Vivier:
 hw/char/virtio-serial-bus: fix guest-triggerable OOM in control_out()
1bfd63d6d06 64ce9ac187 Daniel Henrique Barboza:
 hw/riscv/riscv-iommu.c: always fault with SADE=0 and A=0
7209324e5e3 dcd0285177 SeungJu Cheon:
 target/riscv: Apply UXL WARL handling to vsstatus
1f4f980e538 46d96da130 ZhengXiang Qin:
 target/riscv: avoid abort when reading vtype before env->xl is set
27f40e77e73 fdfcd98f66 Qingwei Hu:
 hw/riscv/virt-acpi-build: Fix RINTC PLIC context ID for KVM
f08d947863b fa2cf74883 Inochi Amaoto:
 target/riscv: Check PMP before updating PTE
1c1c043fba1 75893c058b Christian Schoenebeck:
 hw/9pfs/local: harden local_fid_fd() on FID types
65132787e61 c3aa2491cd Christian Schoenebeck:
 hw/9pfs: fix invalid union access by v9fs_co_fstat()
11088e1fd04 32cae47c33 Christian Schoenebeck:
 hw/9pfs: fix invalid union access by v9fs_co_fsync()
64579c05353 04a62cdfe8 Christian Schoenebeck:
 tests/9p: add 3 xattr FID limit test cases (local fs driver)
7f949e8d9b4 0e1085819e Christian Schoenebeck:
 tests/9p: add 3 xattr FID limit test cases (synth fs driver)
d1225452cfc 84525ece68 Christian Schoenebeck:
 tests/9p: add virtio_9p_add_synth_driver_args() test client function
d3b894fd0ad df88255543 Christian Schoenebeck:
 tests/9p: increase P9_MAX_SIZE for test client
0067f9b26a0 7e42d569a6 Christian Schoenebeck:
 hw/9pfs: add xattr count query interface to fs synth driver
c25007f4aa3 0e3085ddc7 Christian Schoenebeck:
 hw/9pfs: enable xattr (mockup) support for synth fs driver
643292380c1 7664feb26f Christian Schoenebeck:
 tests/9p: add Txattrcreate / Rxattrcreate test client functions
bcdfdefbef8 c46150530b Christian Schoenebeck:
 tests/9p: add Tclunk / Rclunk test client functions
e0723f32e52 54b8f64c42 Christian Schoenebeck:
 tests/9p: add Tread / Rread test client functions
8fd934f911f 44cb540d2d Christian Schoenebeck:
 qemu-options: document 9pfs max_xattr option
5ab98d34b08 e6116a81f0 Christian Schoenebeck:
 hw/9pfs: add max_xattr option
c57644a542b 693b296b17 Christian Schoenebeck:
 hw/9pfs: add xattr FID limit to prevent memory exhaustion
d2a298f3594 64c6c7e0df Christian Schoenebeck:
 hw/9pfs: cap Treaddir allocation (CVE-2026-9238)
7a656578293 69c8f5e694 Christian Schoenebeck:
 9pfs/xen: implement response_buffer_size callback
f72b438cfbf 12bcbdca8a Christian Schoenebeck:
 9pfs/virtio: implement response_buffer_size callback
c73afc39d6d 4b615eaa1b Christian Schoenebeck:
 hw/9pfs: add response_buffer_size transport callback
9c98cdfed96 bb5ab96e35 Christian Schoenebeck:
 hw/9pfs: cap negotiated msize to transport limit
1c0bbd8aa97 815d1799c3 Christian Schoenebeck:
 9pfs/xen: implement msize_limit callback
cb02324effa 4a1a2fa4d3 Christian Schoenebeck:
 9pfs/virtio: implement msize_limit callback
63a86a2d8c1 a1c0e5a737 Christian Schoenebeck:
 hw/9pfs: add msize_limit transport callback
8672445417c a57e4612b6 Christian Borntraeger:
 s390x/kvm: clamp stsi 3.2.2 size
ec114fa0d42 27f6d5ba9c Marc-André Lureau:
 ui/gtk: fix bad widget realize on non-GFX VC
f8b12be74d2 eef29e060d Emmanuel Blot:
 meson: build macOS signed binary as part of the default target


