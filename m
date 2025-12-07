Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F523D2CE17
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Dec 2025 07:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vS90D-0008Dp-VU; Sun, 07 Dec 2025 02:16:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vS909-0008Cj-SP; Sun, 07 Dec 2025 02:16:14 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vS907-0007YS-2m; Sun, 07 Dec 2025 02:16:13 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E5F14171DBE;
 Sun, 07 Dec 2025 10:15:53 +0300 (MSK)
Received: from tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with SMTP id 1ED4432E3C7;
 Sun, 07 Dec 2025 10:15:58 +0300 (MSK)
Received: (nullmailer pid 2720031 invoked by uid 1000);
 Sun, 07 Dec 2025 07:15:57 -0000
Subject: [ANNOUNCE] QEMU 10.1.3 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Dec 2025 10:15:57 +0300
Message-Id: <1765091757.917767.2720030.nullmailer@tls.msk.ru>
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, MIME_QP_LONG_LINE=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

The QEMU v10.1.3 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-10.1.3.tar.xz
  https://download.qemu.org/qemu-10.1.3.tar.xz.sig (signature)

v10.1.3 is now tagged in the official qemu.git repository, and the
stable-10.1 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-10.1

There are 96 changes since the previous v10.1.2 release, including
the fix for CVE-2025-11234 (use after free in websocket handshake code).

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-10.1-hash master-hash Author Name: Commmit-Subject):

93be9e6bd4 Michael Tokarev:
 Update version for 10.1.3 release
c5ef886100 88be119fb1 Markus Armbruster:
 kvm: Fix kvm_vm_ioctl() and kvm_device_ioctl() return value
ac93de3800 ebb625262c Peter Maydell:
 docs/devel: Update URL for make-pullreq script
8ecf9dd274 7248dab3c9 Harald van Dijk:
 target/arm: Fix assert on BRA.
30b8ad835e 57756aa01f Cédric Le Goater:
 hw/aspeed/{xdma, rtc, sdhci}: Fix endianness to DEVICE_LITTLE_ENDIAN
19018a95f6 98ee8aa92e Peter Xu:
 hw/core/machine: Provide a description for aux-ram-share property
b8f4fee6b4 ef44cc0a76 Peter Maydell:
 hw/pci: Make msix_init take a uint32_t for nentries
2bb0153cd8 Fiona Ebner:
 block/io_uring: avoid potentially getting stuck after resubmit at the end of ioq_submit()
872893185e 59a1cf0cd3 Stefan Hajnoczi:
 iotests: add Linux loop device image creation test
df502b9f18 d704a13d2c Stefan Hajnoczi:
 block: use pwrite_zeroes_alignment when writing first sector
092b82b6aa 98e788b91a Stefan Hajnoczi:
 file-posix: populate pwrite_zeroes_alignment
db6d367899 8eeaa706ba Kevin Wolf:
 block-backend: Fix race when resuming queued requests
13aae93f72 4c1646e23f AlanoSong@163.com:
 ui/vnc: Fix qemu abort when query vnc info
7191572f62 303f604935 Philippe Mathieu-Daudé:
 chardev/char-pty: Do not ignore chr_write() failures
1545d807bb 4be62d3117 Marc-André Lureau:
 ui/vdagent: fix windows agent regression
2bbb702dc6 579be921f5 Peter Maydell:
 hw/display/exynos4210_fimd: Account for zero length in fimd_update_memory_section()
74ef23cd70 4a934d284d Peter Maydell:
 hw/arm/armv7m: Disable reentrancy guard for v7m_sysreg_ns_ops MRs
2e384f3a40 510d5c61ad Jamin Lin:
 hw/arm/aspeed: Fix missing SPI IRQ connection causing DMA interrupt failure
fb7d253875 cacd8fb08d Nabih Estefan:
 hw/arm/ast27x0: Fix typo in LTPI address
db3d5ee5cc 0b5bf4ea76 Li Zhijian:
 migration: Fix transition to COLO state from precopy
299644d028 5fbcbf76a1 Jack Wang:
 qmp: Fix a typo for a USO feature
d16a8a8e70 106d766c9d Paolo Bonzini:
 target/i386: fix stack size when delivering real mode interrupts
bb9a9bac9e 9c3afb9d9b Paolo Bonzini:
 target/i386: svm: fix sign extension of exit code
49540ef636 ebb46ba6a4 Paolo Bonzini:
 target/i386/tcg: validate segment registers
61a2fd4027 ebd9ea2947 Peter Maydell:
 target/i386: Mark VPERMILPS as not valid with prefix 0
4e9b896000 9c3b76a0d4 Philippe Mathieu-Daudé:
 hw/southbridge/lasi: Correct LasiState parent
64f5d4ad31 a344e22917 Yannick Voßen:
 hw/dma/zynq-devcfg: Fix register memory
3362add5da 335da23abe Daniel P. Berrangé:
 tests/functional: handle URLError when fetching assets
3e342e42d8 124ab930ba Daniel P. Berrangé:
 tests/functional: fix formatting of exception args
80d0d15157 9b9ee60c07 Hanna Czenczek:
 block/io: Take reqs_lock for tracked_requests
619c2350fa 0f142cbd91 Hanna Czenczek:
 nvme: Fix coroutine waking
9bcfcb5b95 7a501bbd51 Hanna Czenczek:
 nvme: Kick and check completions in BDS context
8080852616 53d5c7ffac Hanna Czenczek:
 curl: Fix coroutine waking
f9d1e16005 deb35c129b Hanna Czenczek:
 nfs: Run co BH CB in the coroutine’s AioContext
e8e9ed8b11 89d22536d1 Hanna Czenczek:
 rbd: Run co BH CB in the coroutine’s AioContext
9dbc842e9a 497d3e87ce Alex Bennée:
 tests: move test_virt_gpu to share.linaro.org
0633dcb957 ced9f2ffc2 Alex Bennée:
 tests: move test_kvm to share.linaro.org
d54fb6d54d 533b5ac2d6 Alex Bennée:
 tests: move test_kvm_xen to share.linaro.org
75471c8772 5ff8d1fac9 Alex Bennée:
 tests: move test_netdev_ethtool to share.linaro.org
9cac0db512 dfaf3695b2 Alex Bennée:
 tests: move test_virt assets to share.linaro.org
ac6b86eaa5 863449cc8e Alex Bennée:
 tests: move test_xen assets to share.linaro.org
f9c2b17c74 5fc50b4ec8 Peter Maydell:
 hw/misc/npcm_clk: Don't divide by zero when calculating frequency
efe30a21c7 032333eba7 Peter Maydell:
 hw/display/xlnx_dp: Don't abort for unsupported graphics formats
d68f54e1a7 f52db7f342 Peter Maydell:
 hw/display/xlnx_dp.c: Don't abort on AUX FIFO overrun/underrun
467397ea30 a01344d9d7 Peter Maydell:
 net: pad packets to minimum length in qemu_receive_packet()
6642c402f5 bab496a183 Peter Maydell:
 hw/net/e1000e_core: Adjust e1000e_write_payload_frag_to_rx_buffers() assert
26ec74ff67 9d946d56a2 Peter Maydell:
 hw/net/e1000e_core: Correct rx oversize packet checks
cbef0fa9bd 6da0c98281 Peter Maydell:
 hw/net/e1000e_core: Don't advance desc_offset for NULL buffer RX descriptors
63b23ad20c 9d86181874 Eric Blake:
 qio: Protect NetListener callback with mutex
e07535caac b5676493a0 Eric Blake:
 qio: Remember context of qio_net_listener_set_client_func_full
6b716806e8 6e03d5cdc9 Eric Blake:
 qio: Unwatch before notify in QIONetListener
0710635a01 59506e59e0 Eric Blake:
 qio: Add trace points to net_listener
9d45af9d1c 4c91719a6a Alberto Garcia:
 tests/qemu-iotest: fix iotest 024 with qed images
fcffa892ea 909852ba6b Alberto Garcia:
 qemu-img rebase: don't exceed IO_BUF_SIZE in one operation
9ea3833315 f00bcc8337 Akihiko Odaki:
 qemu-img: Fix amend option parse error handling
b294ca85b8 ccf166d89d Shameer Kolothum:
 tests/qtest/bios-tables-test: Update DSDT blobs after GPEX _DSM change
90f5f434bf 325aa2d86a Eric Auger:
 hw/pci-host/gpex-acpi: Fix _DSM function 0 support return value
9a51f0cf9d 3e6ad83f20 Shameer Kolothum:
 tests/qtest/bios-tables-test: Prepare for _DSM change in the DSDT table
5b463530ad fde5930cc3 Albert Esteve:
 vhost-user: fix shared object lookup handler logic
a3c1fc3500 4f503afc7e Peter Maydell:
 target/x86: Correctly handle invalid 0x0f 0xc7 0xxx insns
9f26d3a369 75e2cb1441 Xiaoyao Li:
 hostmem/shm: Allow shm memory backend serve as shared memory for coco-VMs
1e9f5deccd 8922a758b2 Chenyi Qiang:
 ram-block-attributes: fix interaction with hugetlb memory backends
22eb797a45 0408c61e27 Ilya Leoshkevich:
 tests/tcg/s390x: Test SET CLOCK COMPARATOR
7f3f07014e fc976a67de Ilya Leoshkevich:
 target/s390x: Use address generation for register branch targets
c35275c2ed dacfec5157 Ilya Leoshkevich:
 target/s390x: Fix missing clock-comparator interrupts after reset
dd1df0fa0c df7e9243d5 Ilya Leoshkevich:
 target/s390x: Fix missing interrupts for small CKC values
b6fd8fa68d cfc1d54251 Edgar E. Iglesias:
 target/microblaze: Handle signed division overflows
d428a048c0 0e46b4d1f1 Edgar E. Iglesias:
 target/microblaze: div: Break out raise_divzero()
5ec7135676 a04c5ba543 Edgar E. Iglesias:
 target/microblaze: Remove unused arg from check_divz()
a8db605f8f 524fc77d23 Sean Anderson:
 gdbstub: Fix %s formatting
45d9db94f4 ad97769e9d Richard W.M. Jones:
 block/curl.c: Fix CURLOPT_VERBOSE parameter type
f6d90041d6 c86488abaf Daniel P. Berrangé:
 block: fix luks 'amend' when run in coroutine
4523ad2438 6eda39a87f Daniel P. Berrangé:
 block: remove 'detached-header' option from opts after use
18d5f261d8 639a294227 Xiaoyao Li:
 i386/kvm/cpu: Init SMM cpu address space for hotplugged CPUs
70c66701f3 d1193481de peng guo:
 hw/i386/pc: Avoid overlap between CXL window and PCI 64bit BARs in QEMU
98107c5d4c d5e1d2dea1 Paolo Bonzini:
 target/i386: clear CPU_INTERRUPT_SIPI for all accelerators
34b92fa32d 0db2de22fc Peter Maydell:
 linux-user: permit sendto() with NULL buf and 0 len
dd26885484 7c70893216 Bastian Blank:
 linux-user: Use correct type for FIBMAP and FIGETBSZ emulation
ba2887244c e9d02b5931 Mark Cave-Ayland:
 qtest/am53c974-test: add additional test for cmdfifo overflow
99b53ecaf8 36ec1a829a Mark Cave-Ayland:
 esp.c: fix esp_cdb_ready() FIFO wraparound limit calculation
072470dfae fb722e1dc2 Helge Deller:
 hw/hppa: Fix interrupt of LASI parallel port
a0c14a76f3 1a8ffd6172 Peter Maydell:
 target/hppa: Set FPCR exception flag bits for non-trapped exceptions
dfd5976810 6910f04aa6 Fiona Ebner:
 hw/scsi: avoid deadlock upon TMF request cancelling with VirtIO
174b99e8d5 3995fc238e Daniel P. Berrangé:
 crypto: stop requiring "key encipherment" usage in x509 certs
a2b7a95350 b7a1f2ca45 Daniel P. Berrangé:
 io: fix use after free in websocket handshake code
ee3321ec21 322c3c4f3a Daniel P. Berrangé:
 io: move websock resource release to close method
2e49baf7ce 2c147611cf Daniel P. Berrangé:
 io: release active GSource in TLS channel finalizer
9423689285 06e01941ff Daniel Henrique Barboza:
 target/riscv: fix riscv_cpu_sirq_pending() mask
eeed470b25 2a21cbee47 Daniel Henrique Barboza:
 target/riscv/kvm: fix env->priv setting in reset_regs_csr()
ea55569b59 5e3e066e4a Jialong Yang:
 aplic: fix mask for smsiaddrcfgh
31aa4bd5bb e41139eaad Zejun Zhao:
 hw/riscv: Correct mmu-type property of sifive_u harts in device tree
dbc57c9124 3f462d79a0 Peter Maydell:
 target/arm: Fix reads of CNTFRQ_EL0 in linux-user mode
e7f3e864cb ecbe424a63 John Levon:
 vfio: only check region info cache for initial regions
395347bdf9 aaca725884 John Levon:
 vfio: rename field to "num_initial_regions"
8ba0034ddf 270b28681e Thomas Huth:
 hw/ppc/e500: Check for compatible CPU type instead of aborting ungracefully
e1cec1c47a 77dc9d662f Peter Maydell:
 tests/tcg/multiarch/linux/linux-test: Don't try to test atime update
79222d2462 27ea28a0b3 Richard Henderson:
 tcg/arm: Fix tgen_deposit


