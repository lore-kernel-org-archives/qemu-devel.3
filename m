Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D00CC531D0
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 05:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnUpa-0004q9-OM; Sat, 25 Jul 2026 01:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wnUpY-0004pp-8x; Sat, 25 Jul 2026 01:21:48 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wnUpU-0007h3-8z; Sat, 25 Jul 2026 01:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784956875; bh=2T6lwUsAuRmHlfLUChdpSQ3b+NdnDtoeP+xvZ70ZPoA=;
 h=From:To:Cc:Subject:Date;
 b=odAA/gJYmL1EbJO21PO5QxmTMfh88GnCcUrY/olDEMCpjks/R33qk75/BAJX19QtT
 6ht8QXExdtszBomt+uRsBgdHGM2fQBzB7jt5xa0CQ58gm+dTiJFnpLi2VY5tySUCMm
 mLMZPaV7voovE+SQiHxMS56ucT9N3+PHp9cIqwCPp98bH/MgQsuoQWfCXcFe2zSAHO
 3v2kENjq86kENz8gBk4reUHMNwIDW5VqllS0NfMUpnvZiFqA3uQjOkRM/vUBAcPX4Y
 hn72ngOO8q8kGmqFldzUYaapv8ZU4bra77RNnwiT61kMUmRZluIsV6UxAcTHl+cHF0
 wmWsyVVEbQc0w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A49561C4979;
 Sat, 25 Jul 2026 08:21:15 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3F9C63F4C84;
 Sat, 25 Jul 2026 08:21:38 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id DA1CE185F3; Sat, 25 Jul 2026 08:21:27 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-stable@nongnu.org
Subject: [ANNOUNCE] QEMU 10.0.12 Stable released
Date: Sat, 25 Jul 2026 08:21:12 +0300
Message-ID: <20260725052118.1228597-1-mjt@tls.msk.ru>
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

The QEMU v10.0.12 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-10.0.12.tar.xz
  https://download.qemu.org/qemu-10.0.12.tar.xz.sig (signature)

v10.0.12 is now tagged in the official qemu.git repository, and the
stable-10.0 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-10.0

There are 122 changes since the previous v10.0.11 release, including
numerous security fixes.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-10.0-hash master-hash Author Name: Commmit-Subject):

0a6a1c7d02e Michael Tokarev:
 Update version for 10.0.12 release
86db40ecc25 c257745248 Haotian Jiang:
 hw/audio/intel-hda: restrict all DMA engine paths to memories
0a875069806 94c510a5dc Bin Meng:
 hw/net/cadence: Return current Cadence GEM queue pointers
04463714280 2142689d92 Philippe Mathieu-Daudé:
 hw/misc/applesmc: Fix a typo setting MSSD key
d8d2b589203 fe68e4b47b Marc-André Lureau:
 replay: fix use of uninitialized pointer on error
ce41859ef0d 9f436938c5 Marc-André Lureau:
 hw/display/qxl: validate monitors_config heads[] in phys2virt
91d5b334d75 b1e73b2ddb Peter Maydell:
 net: Correct padding check in qemu_receive_packet()
433c3af2137 8392734722 Jay Chang:
 hw/net/xilinx_axienet: Fix PHY register 17 link status reporting
b0411a1747a cc479aa897 Thomas Huth:
 hw/usb/hcd-xhci-sysbus: Fix OOB heap access in xhci_sysbus_intr_raise()
d998e2e0996 4daeaa2fe0 Thomas Huth:
 hw/usb/hcd-xhci: Fix guest-triggerable assert() in xhci_find_stream()
6970b91d905 a002485bfe Marc-André Lureau:
 usbredir: fix infinite loop and SIGFPE with zero max_packet_size
e3da91c8597 9bf52d056a Marc-André Lureau:
 usbredir: fix use-after-free on buffered bulk packet overflow
15b917f70f7 ba54d7e66e Xiangfeng Cai:
 tests/qtest: add xhci-pci unplug finalize regression test
12356ead784 054ef33f67 Xiangfeng Cai:
 hw/usb/hcd-xhci-pci: break host link cycle so device_finalize() runs on unplug
22aac2d4016 12d8ee9d53 Feifan Qian:
 hw/usb/xhci: clamp interval exponent to avoid UB shift in xhci_init_epctx()
f555fc3e213 78420b59f0 Alex Bennée:
 accel/tcg: move jit thread manipulation into do_tb_phys_invalidate
44e2f8e7362 f1af81ba2a Akihiko Odaki:
 hw/display/virtio-gpu: Check pixman_image_create_bits() results
92383edfb61 e99488c5d4 Marc-André Lureau:
 hw/display/virtio-gpu: handle migration iov allocation failure
93f5926ebc4 8720061c6d Marc-André Lureau:
 hw/display/virtio-gpu: cap submit_3d command buffer allocation
7467c162c0b 6075444c5a Marc-André Lureau:
 ui/vnc: validate SetPixelFormat field ranges
6c2f9592dec e650e4fe0f Marc-André Lureau:
 ui/vnc: fix out-of-bounds write in lossy refresh dirty marking
e8b412c25ce 53f0d87db7 Akihiko Odaki:
 ui/gtk: Narrow DMA-BUF critical section
c4b40c409b7 82b4d693d5 Marc-André Lureau:
 ui/input-barrier: fix off-by-one in keycode bounds check
9f26aa37d8e fb71c895d7 Marc-André Lureau:
 ui/vnc: validate color shifts in SetPixelFormat
5ab666fda9d 3543c2b855 Marc-André Lureau:
 ui/vnc: fix OOB write in vnc_refresh_lossy_rect
980a37f1613 5257259428 Thomas Huth:
 hw/usb/hcd-xhci: Turn guest-triggerable abort() into qemu_log_mask()
927d2c4d9c5 98e5a8eb4f Thomas Huth:
 hw/usb/hcd-ohci: Make sure that ohci_service_ed_list() cannot loop forever
fab6f73b1e6 564c4d7e99 Marc-André Lureau:
 hw/display/virtio-gpu: fix dmabuf_fd leak on remap failure
59977464213 ecc569639a Miao Wang:
 hw/scsi/vmw_pvscsi: add a comment to explain the endianness
e7ae1d7135f 5a811329bd Miao Wang:
 hw/scsi/vmw_pvscsi: translate data endianness
6a8031021b0 76dbe26fd6 Dmitry Pimenov:
 hw/sparc64/niagara: use int64_t for vdisk size to avoid truncation
159b84e3a51 a3cc0069e1 Marc-André Lureau:
 hw/display/qxl: fix TOCTOU in cursor chunk data_size handling
f1e15c49c7a 5157ceb10c Haotian Jiang:
 hw/misc/ivshmem: clear chardev handlers before freeing peers
d3996f2887e 7a2e863f9d Matt Turner:
 linux-user/alpha: populate AT_HWCAP from env->amask
0366a61683b 9db18ed063 Matt Turner:
 linux-user/alpha: add coredump support
d63cdcf24b2 33bece0fa1 Eric Farman:
 s390x/css: firm up handling of chained TIC CCWs
d278f15e4f4 20701190e0 Christian Borntraeger:
 s390x/sclp: prevent re-reading the sclp header
2278aa7c769 d39ac36fe2 Philippe Mathieu-Daudé:
 hw/s390x/sclp: Do not ignore address_space_read/write() errors
519c573646d 0d4e15e8f8 Philippe Mathieu-Daudé:
 hw/s390x/sclp: Replace [cpu_physical_memory -> address_space]_r/w()
d4ba78d6dc0 3c27494434 Peter Maydell:
 hw/misc/stm32_rcc: Correct offset-to-irq calculation
0e9da86f9ee 2ac2cf0483 Peter Maydell:
 hw/display/sm501: Don't allow guest to set ram size larger than it is
728ba0a0a4f 422734d5fc Peter Maydell:
 hw/display/sm501: Avoid overflow problems in bounds check calculations
1c21d7c9b72 b378a1bd86 Peter Maydell:
 hw/display/sm501: Catch bad coordinates for RTL operations
b6dd635ec78 2c6fae7d7d Peter Maydell:
 hw/usb/dev-wacom: Don't write off end of buffer
d02fed22834 4571c79c57 Peter Maydell:
 hw/net/vmxnet3: Correct bounds check on tx queue index
37e00807546 79cabc6cb7 Richard Henderson:
 target/arm: Be more defensive for invalid tlbi_aa64_get_range
872c54a20d3 a47e3c26b1 Peter Maydell:
 linux-user: Validate guest-passed dm_ioctl data_size
086d43a06f2 ec7d324287 Heinrich Schuchardt:
 tests: update SPCR loongarch64 and riscv64 test data
53826e2e670 15c73b0f17 Heinrich Schuchardt:
 hw/acpi: correct field sequence in SPCR table
12f0bf324cf 18a5220990 Heinrich Schuchardt:
 tests: allow differences in SPCR
0d5950ff2a7 c7e6185454 Alistair Francis:
 hw/pci/pcie_doe: Check mailbox length for overflows
b82a9699bef c497ef6739 Akihiko Odaki:
 hw/riscv/riscv-iommu: Fix MemoryRegion owner
eab76d5bd4e ce7fb32827 Daniel Henrique Barboza:
 hw/riscv/riscv-iommu.c: set ftype and iova in riscv_iommu_ctx()
b3554b5bda7 15406cc593 Frank Chang:
 hw/riscv: riscv-iommu: Don't look up DDT cache in Off and Bare modes
6eee3411e83 ca7bac51e0 Chengbo Gao:
 hw/riscv/riscv-iommu: Avoid caching PCI device IDs
5cf7ba472d3 6d2b9d542f Daniel Henrique Barboza:
 hw/riscv/riscv-iommu: forbid GATE/SADE if caps.AMO_HWADD is zero
3bc064e3ba0 79616dd6e4 Daniel Henrique Barboza:
 hw/riscv/riscv-iommu.c: update ioval2 when faulting in spa_fetch()
95f716f1212 bf274c5429 Daniel Henrique Barboza:
 hw/riscv/riscv-iommu.c: check for misaligned IOHGATP_PPN
14d78104783 58e801f74e Daniel Henrique Barboza:
 hw/riscv/riscv-iommu-sys.c: record fault on IOMMU-generated MSI write
d57c84d0106 11486349ad Daniel Henrique Barboza:
 hw/riscv/riscv-iommu.c: check reserved MSI PTE basic bits
d974cdb61ee 9158c900ab Daniel Henrique Barboza:
 hw/riscv/riscv-iommu.c: fault for non-user PTE in G_STAGE
5952919d777 b795ea0ba4 Daniel Henrique Barboza:
 hw/riscv/riscv-iommu.c: fault when !PTE_U and no priv access
37388042d8a c1d5ec3a2f Daniel Henrique Barboza:
 hw/riscv/riscv-iommu.c: check for reserved PTE bits
12422e1f449 b18e3f0e2d Daniel Henrique Barboza:
 hw/riscv/riscv-iommu.c: fix fault type for spa_fetch() faults
4493fb4d1b3 90aacd5bc4 Jia Jia:
 hw/ufs: avoid double unref of wrapped scsi-hd
f63a90b82e3 614a52cf54 Randy Schifflin:
 target/sh4: fixup tcg for sh4 fipr/ftrv instructions
d0b6f70a90a c56ebd64b8 Richard Henderson:
 tcg/loongarch64: Fix cmp_vec with TCG_COND_NE
c7832b42810 911f7328e9 Richard Henderson:
 tcg/loongarch64: Improve constraints for TCG_CT_CONST_VCMP
cd365f30852 a079836005 Richard Henderson:
 tcg/loongarch64: Fix vec_val computation in tcg_target_const_match
f51b0292ad1 e03b7dac65 Ilya Leoshkevich:
 accel/tcg: Make PageFlagsNodes' start and last immutable
ff4ef54ebce b79a9b6e5b Richard Henderson:
 accel/tcg: Use TLB_FORCE_SLOW not TLB_MMIO for user-only plugins
fd9f6eaa54a 9e41b5d22a Sanjeeva Yerrapureddy:
 hw/net: fix e1000e/igb ip_len inflation by Ethernet minimum-frame padding
789a2335618 7913b3b946 hemanshu.khilari.foss:
 hw/core/qdev-clock: Fix potential null pointer dereference
a2001d0efdc e03463812e lizhaoxin04:
 vdpa: fix use-after-free of vqs in vhost_vdpa_device_unrealize
3e8ac84f9d1 0e51b71c7b Thomas Huth:
 hw/display/qxl: Fix mono cursor validation that can read past a cursor chunk
43bfc32cb73 831a13665a Peter Maydell:
 hw/scsi/mptsas: Reset doorbell state on reset
7fb6ffe10a9 03071f99a3 Peter Maydell:
 hw/dma/i8257: Return zeroes for read_memory in verify mode
e2392269592 cb7bc10385 Denis V. Lunev:
 tests/qtest/ahci: test ATAPI read completing after engine restart
39327c6b1a8 d9f78431d8 Denis V. Lunev:
 hw/ide/ahci: cancel in-flight buffered reads on command engine restart
09dcdbae048 42f599172a Torin Carey:
 hw/misc/edu: restrict dma access to dma buffer
b9056d47fbc 22f2da06a8 Eric Farman:
 s390x/css: limit number of CHPIDs in description
04e0a1376ed 386268daea Matthew Rosato:
 s390x/ioinst: Require strict length and format for SEI CHSC handler
a40c0d97915 b8c8ec1d75 Matthew Rosato:
 s390x/pci: Shrink RPCIT ranges to registered window
d580823dde1 2d709a70c7 Matthew Rosato:
 s390x/pci: Tighten region detection for BAR read/write
f4116bc4cb6 d88cd8f557 Christian Borntraeger:
 s390x/sclp: reject invalid write event data headers
f5f603e1f9e 034baf047f Keith Busch:
 hw/nvme: ensure sgl forward progress
cd1a6a2f9c8 ec917cd499 Jesper Wendel Devantier:
 hw/nvme: fix FDP set FDP events
2ae284c52e8 62b425bec3 Alex Bennée:
 hw/arm: use cortex-a9 mpcore base for CBAR on npcm7xx machines
3425f5396f2 bc22c7e418 Feifan Qian:
 hw/net/fsl_etsec: validate FCB offsets in process_tx_fcb()
105e518277a 32a90850e1 Junjie Cao:
 virtio-net: validate RSS indirections_len in post_load
8afd46704e4 36b37f8494 Laurent Vivier:
 hw/char/virtio-serial-bus: fix guest-triggerable OOM in control_out()
d8f216a7032 64ce9ac187 Daniel Henrique Barboza:
 hw/riscv/riscv-iommu.c: always fault with SADE=0 and A=0
c239e12ec56 dcd0285177 SeungJu Cheon:
 target/riscv: Apply UXL WARL handling to vsstatus
3dcae5226ad 46d96da130 ZhengXiang Qin:
 target/riscv: avoid abort when reading vtype before env->xl is set
1af169451eb fdfcd98f66 Qingwei Hu:
 hw/riscv/virt-acpi-build: Fix RINTC PLIC context ID for KVM
0c6a12b9e4b fa2cf74883 Inochi Amaoto:
 target/riscv: Check PMP before updating PTE
dbe1907c543 75893c058b Christian Schoenebeck:
 hw/9pfs/local: harden local_fid_fd() on FID types
29f1f4b3ab2 c3aa2491cd Christian Schoenebeck:
 hw/9pfs: fix invalid union access by v9fs_co_fstat()
54f705e422b 32cae47c33 Christian Schoenebeck:
 hw/9pfs: fix invalid union access by v9fs_co_fsync()
b59ee536a35 04a62cdfe8 Christian Schoenebeck:
 tests/9p: add 3 xattr FID limit test cases (local fs driver)
865fc2874f7 0e1085819e Christian Schoenebeck:
 tests/9p: add 3 xattr FID limit test cases (synth fs driver)
d94e27ac4df 84525ece68 Christian Schoenebeck:
 tests/9p: add virtio_9p_add_synth_driver_args() test client function
92375047a34 df88255543 Christian Schoenebeck:
 tests/9p: increase P9_MAX_SIZE for test client
2842b9eeb52 7e42d569a6 Christian Schoenebeck:
 hw/9pfs: add xattr count query interface to fs synth driver
d7370cf8805 0e3085ddc7 Christian Schoenebeck:
 hw/9pfs: enable xattr (mockup) support for synth fs driver
cd5a7275096 7664feb26f Christian Schoenebeck:
 tests/9p: add Txattrcreate / Rxattrcreate test client functions
7fd23f05c27 c46150530b Christian Schoenebeck:
 tests/9p: add Tclunk / Rclunk test client functions
f443a27e86f 54b8f64c42 Christian Schoenebeck:
 tests/9p: add Tread / Rread test client functions
5b33debb831 44cb540d2d Christian Schoenebeck:
 qemu-options: document 9pfs max_xattr option
c6ead5d4fa3 e6116a81f0 Christian Schoenebeck:
 hw/9pfs: add max_xattr option
4f9e9601d0e 693b296b17 Christian Schoenebeck:
 hw/9pfs: add xattr FID limit to prevent memory exhaustion
169537e616a 64c6c7e0df Christian Schoenebeck:
 hw/9pfs: cap Treaddir allocation (CVE-2026-9238)
8221af89aff 69c8f5e694 Christian Schoenebeck:
 9pfs/xen: implement response_buffer_size callback
7e493da0155 12bcbdca8a Christian Schoenebeck:
 9pfs/virtio: implement response_buffer_size callback
6505b0d95ff 4b615eaa1b Christian Schoenebeck:
 hw/9pfs: add response_buffer_size transport callback
b5c5d5767f2 bb5ab96e35 Christian Schoenebeck:
 hw/9pfs: cap negotiated msize to transport limit
6e3f13e9cd1 815d1799c3 Christian Schoenebeck:
 9pfs/xen: implement msize_limit callback
116cd8d0356 4a1a2fa4d3 Christian Schoenebeck:
 9pfs/virtio: implement msize_limit callback
ea8487ec437 a1c0e5a737 Christian Schoenebeck:
 hw/9pfs: add msize_limit transport callback
29070a13e7c 4f82ce8cd9 Greg Kurz:
 9pfs: local : Introduce local_fid_fd() helper
c84ebaa6b2c f2bb367d2b Greg Kurz:
 9pfs: Don't use file descriptors in core code
b5c0ca965b6 a57e4612b6 Christian Borntraeger:
 s390x/kvm: clamp stsi 3.2.2 size
6bbc297819f 27f6d5ba9c Marc-André Lureau:
 ui/gtk: fix bad widget realize on non-GFX VC


