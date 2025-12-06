Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029D8D339BC
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Dec 2025 16:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRutR-0007Ao-0M; Sat, 06 Dec 2025 11:12:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vRutH-0007AE-Ee; Sat, 06 Dec 2025 11:12:14 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vRutC-0003pw-EJ; Sat, 06 Dec 2025 11:12:09 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 94365171B50;
 Sat, 06 Dec 2025 19:12:01 +0300 (MSK)
Received: from tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with SMTP id 95B2832DF48;
 Sat, 06 Dec 2025 19:12:04 +0300 (MSK)
Received: (nullmailer pid 2700544 invoked by uid 1000);
 Sat, 06 Dec 2025 16:12:04 -0000
Subject: [ANNOUNCE] QEMU 10.0.7 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Dec 2025 19:12:04 +0300
Message-Id: <1765037524.347582.2700543.nullmailer@tls.msk.ru>
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

The QEMU v10.0.7 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-10.0.7.tar.xz
  https://download.qemu.org/qemu-10.0.7.tar.xz.sig (signature)

v10.0.7 is now tagged in the official qemu.git repository, and the
stable-10.0 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-10.0

There are 116 changes since the previous v10.0.6 release.

The amount of changes is rather large this time.  The diffstat summary,
compared to the previous 10.0.6 release, is:

 170 files changed, 1965 insertions(+), 3083 deletions(-)

However, a large portion of changes are in the testing framework -- just
tests/ changes diffstat summary is:

 76 files changed, 1082 insertions(+), 1913 deletions(-)

so it is more than half of the total changes.

I picked up tests/ changes from the qemu master branch is in order
to be able to keep testing this and future 10.0.x releases, - it
does not change the actual qemu binaries, but helps to ensure the
release is working properly.

There's a security fix in this release as well:

 CVE-2025-11234 use after free in websocket handshake code

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-10.0-hash master-hash Author Name: Commmit-Subject):

561f025ae2 Michael Tokarev:
 Update version for 10.0.7 release
ed6a627f85 88be119fb1 Markus Armbruster:
 kvm: Fix kvm_vm_ioctl() and kvm_device_ioctl() return value
95b0af630f ebb625262c Peter Maydell:
 docs/devel: Update URL for make-pullreq script
06793a36b7 7248dab3c9 Harald van Dijk:
 target/arm: Fix assert on BRA.
88c28f9f9c 57756aa01f Cédric Le Goater:
 hw/aspeed/{xdma, rtc, sdhci}: Fix endianness to DEVICE_LITTLE_ENDIAN
475563823c 98ee8aa92e Peter Xu:
 hw/core/machine: Provide a description for aux-ram-share property
58c32325f2 ef44cc0a76 Peter Maydell:
 hw/pci: Make msix_init take a uint32_t for nentries
eb3e5de450 Fiona Ebner:
 block/io_uring: avoid potentially getting stuck after resubmit at the end of ioq_submit()
9d496598da 8eeaa706ba Kevin Wolf:
 block-backend: Fix race when resuming queued requests
b3c10df2e2 4c1646e23f AlanoSong@163.com:
 ui/vnc: Fix qemu abort when query vnc info
1978079d2a 303f604935 Philippe Mathieu-Daudé:
 chardev/char-pty: Do not ignore chr_write() failures
f4fa2d06dd 579be921f5 Peter Maydell:
 hw/display/exynos4210_fimd: Account for zero length in fimd_update_memory_section()
35819127d1 4a934d284d Peter Maydell:
 hw/arm/armv7m: Disable reentrancy guard for v7m_sysreg_ns_ops MRs
f78cda72cb 510d5c61ad Jamin Lin:
 hw/arm/aspeed: Fix missing SPI IRQ connection causing DMA interrupt failure
c41f52f5d7 0b5bf4ea76 Li Zhijian:
 migration: Fix transition to COLO state from precopy
20a7e4d3e7 5fbcbf76a1 Jack Wang:
 qmp: Fix a typo for a USO feature
62f897b7d3 12c6b61530 Thomas Huth:
 MAINTAINERS: Add functional tests that are not covered yet
bb09656bdf 99fb9256b7 Thomas Huth:
 tests/functional: Remove unnecessary import statements
112d01ce9f 858640eaee Thomas Huth:
 tests/functional: Remove semicolons at the end of lines
cf4b882ed3 52e9ed6d3a Thomas Huth:
 Remove the remainders of the Avocado tests
0818105ab6 5748e46415 Thomas Huth:
 docs/devel/testing: Dissolve the ci-definitions.rst.inc file
bb4444ba8f f8c5484417 Thomas Huth:
 gitlab-ci: Update QEMU_JOB_AVOCADO and QEMU_CI_AVOCADO_TESTING
eb45f72de0 5c2bae2155 Thomas Huth:
 tests/functional: Convert the SMMU test to the functional framework
26267e726d a820caf844 Thomas Huth:
 tests/functional: Use the tuxrun kernel for the aarch64 replay test
43d94f4c41 7fecdb0acd Thomas Huth:
 tests/functional: Use the tuxrun kernel for the x86 replay test
d50027a984 e83aee9c6a Thomas Huth:
 tests/avocado: Remove the boot_linux.py tests
0236373fa6 f79592f427 Thomas Huth:
 tests/functional: Convert the 64-bit big endian Wheezy mips test
9821c1cb60 8e3461c3a6 Thomas Huth:
 tests/functional: Convert the 64-bit little endian Wheezy mips test
902fc01dc2 689a8b56a6 Thomas Huth:
 tests/functional: Convert the 32-bit little endian Wheezy mips test
ebfa6996dc 42a87f0ce7 Thomas Huth:
 tests/functional: Convert the 32-bit big endian Wheezy mips test
f95d41b486 574f71bc1f Thomas Huth:
 tests/avocado: Remove the LinuxKernelTest class
27cfc5ea42 0e756f404d Thomas Huth:
 tests/functional: Convert the i386 replay avocado test
c4747e3beb 951ededf12 Thomas Huth:
 tests/functional: Convert reverse_debugging tests to the functional framework
1c491b7186 bc65ae6961 Thomas Huth:
 tests/functional: Move the check for the parameters from avocado to functional
d18488775f 22baa5f340 Thomas Huth:
 gitlab-ci: Remove the avocado tests from the CI pipelines
83aeacaafa 4e3823c68c Cornelia Huck:
 tests/functional/test_vnc: skip test if no crypto backend available
e3f70ada90 106d766c9d Paolo Bonzini:
 target/i386: fix stack size when delivering real mode interrupts
9898237cf2 9c3afb9d9b Paolo Bonzini:
 target/i386: svm: fix sign extension of exit code
fdda67ec29 ebb46ba6a4 Paolo Bonzini:
 target/i386/tcg: validate segment registers
1a854ae15f ebd9ea2947 Peter Maydell:
 target/i386: Mark VPERMILPS as not valid with prefix 0
ec87d57a17 9c3b76a0d4 Philippe Mathieu-Daudé:
 hw/southbridge/lasi: Correct LasiState parent
3873acda93 a344e22917 Yannick Voßen:
 hw/dma/zynq-devcfg: Fix register memory
abd554bafe 335da23abe Daniel P. Berrangé:
 tests/functional: handle URLError when fetching assets
5dfc7d7cc6 124ab930ba Daniel P. Berrangé:
 tests/functional: fix formatting of exception args
da9a175f36 9b9ee60c07 Hanna Czenczek:
 block/io: Take reqs_lock for tracked_requests
361bd4a6c8 0f142cbd91 Hanna Czenczek:
 nvme: Fix coroutine waking
ca02694bbc 7a501bbd51 Hanna Czenczek:
 nvme: Kick and check completions in BDS context
03778618b1 53d5c7ffac Hanna Czenczek:
 curl: Fix coroutine waking
aa2ec06680 deb35c129b Hanna Czenczek:
 nfs: Run co BH CB in the coroutine’s AioContext
23f0865f1b 89d22536d1 Hanna Czenczek:
 rbd: Run co BH CB in the coroutine’s AioContext
f44086c811 497d3e87ce Alex Bennée:
 tests: move test_virt_gpu to share.linaro.org
7a4c4725ab 533b5ac2d6 Alex Bennée:
 tests: move test_kvm_xen to share.linaro.org
bbfdddd74e 5ff8d1fac9 Alex Bennée:
 tests: move test_netdev_ethtool to share.linaro.org
28c399a160 dfaf3695b2 Alex Bennée:
 tests: move test_virt assets to share.linaro.org
91da2fc0f0 863449cc8e Alex Bennée:
 tests: move test_xen assets to share.linaro.org
b0a1f27e21 68aba2a935 Vincent Vanlaer:
 block: add test non-active commit with zeroed data
65c2376abe 6f3199f996 Vincent Vanlaer:
 block: allow commit to unmap zero blocks
4867965a59 0648c76ad1 Vincent Vanlaer:
 block: refactor error handling of commit_iteration
140b484355 23743ab282 Vincent Vanlaer:
 block: move commit_run loop to separate function
d5fb3f5409 71365ee433 Vincent Vanlaer:
 block: get type of block allocation in commit_run
6d2449eab8 5fc50b4ec8 Peter Maydell:
 hw/misc/npcm_clk: Don't divide by zero when calculating frequency
7030471ef5 032333eba7 Peter Maydell:
 hw/display/xlnx_dp: Don't abort for unsupported graphics formats
c0d4545f71 f52db7f342 Peter Maydell:
 hw/display/xlnx_dp.c: Don't abort on AUX FIFO overrun/underrun
134f0c5854 a01344d9d7 Peter Maydell:
 net: pad packets to minimum length in qemu_receive_packet()
a1dc98ef72 bab496a183 Peter Maydell:
 hw/net/e1000e_core: Adjust e1000e_write_payload_frag_to_rx_buffers() assert
61f8acd3e6 9d946d56a2 Peter Maydell:
 hw/net/e1000e_core: Correct rx oversize packet checks
f6d2af610a 6da0c98281 Peter Maydell:
 hw/net/e1000e_core: Don't advance desc_offset for NULL buffer RX descriptors
ec2f4f9cae 9d86181874 Eric Blake:
 qio: Protect NetListener callback with mutex
62b43d94d2 b5676493a0 Eric Blake:
 qio: Remember context of qio_net_listener_set_client_func_full
4cb5b13ecd 6e03d5cdc9 Eric Blake:
 qio: Unwatch before notify in QIONetListener
a413e6481d 59506e59e0 Eric Blake:
 qio: Add trace points to net_listener
f1fa65427c 4c91719a6a Alberto Garcia:
 tests/qemu-iotest: fix iotest 024 with qed images
cf17374ef5 909852ba6b Alberto Garcia:
 qemu-img rebase: don't exceed IO_BUF_SIZE in one operation
17a9b67d67 f00bcc8337 Akihiko Odaki:
 qemu-img: Fix amend option parse error handling
ac9e3c263c ccf166d89d Shameer Kolothum:
 tests/qtest/bios-tables-test: Update DSDT blobs after GPEX _DSM change
f55373aa79 325aa2d86a Eric Auger:
 hw/pci-host/gpex-acpi: Fix _DSM function 0 support return value
df5d79b9e3 3e6ad83f20 Shameer Kolothum:
 tests/qtest/bios-tables-test: Prepare for _DSM change in the DSDT table
363114a4a0 fde5930cc3 Albert Esteve:
 vhost-user: fix shared object lookup handler logic
08176f24dc 4f503afc7e Peter Maydell:
 target/x86: Correctly handle invalid 0x0f 0xc7 0xxx insns
a1cb6b62b5 75e2cb1441 Xiaoyao Li:
 hostmem/shm: Allow shm memory backend serve as shared memory for coco-VMs
2b035829cb 0408c61e27 Ilya Leoshkevich:
 tests/tcg/s390x: Test SET CLOCK COMPARATOR
e46498aa6e fc976a67de Ilya Leoshkevich:
 target/s390x: Use address generation for register branch targets
8e51fc3b42 dacfec5157 Ilya Leoshkevich:
 target/s390x: Fix missing clock-comparator interrupts after reset
de2f4352d3 df7e9243d5 Ilya Leoshkevich:
 target/s390x: Fix missing interrupts for small CKC values
b848b1c85b cfc1d54251 Edgar E. Iglesias:
 target/microblaze: Handle signed division overflows
1cfba04ff6 0e46b4d1f1 Edgar E. Iglesias:
 target/microblaze: div: Break out raise_divzero()
3eae402cc0 a04c5ba543 Edgar E. Iglesias:
 target/microblaze: Remove unused arg from check_divz()
e0b76691b7 524fc77d23 Sean Anderson:
 gdbstub: Fix %s formatting
389a2a60b7 ad97769e9d Richard W.M. Jones:
 block/curl.c: Fix CURLOPT_VERBOSE parameter type
374eb96bc9 c86488abaf Daniel P. Berrangé:
 block: fix luks 'amend' when run in coroutine
cf20f1090a 6eda39a87f Daniel P. Berrangé:
 block: remove 'detached-header' option from opts after use
b615e52178 639a294227 Xiaoyao Li:
 i386/kvm/cpu: Init SMM cpu address space for hotplugged CPUs
562995173d d1193481de peng guo:
 hw/i386/pc: Avoid overlap between CXL window and PCI 64bit BARs in QEMU 10.0.x
3e701b273f d5e1d2dea1 Paolo Bonzini:
 target/i386: clear CPU_INTERRUPT_SIPI for all accelerators
e183b35fb6 0db2de22fc Peter Maydell:
 linux-user: permit sendto() with NULL buf and 0 len
36ac2cafaa 7c70893216 Bastian Blank:
 linux-user: Use correct type for FIBMAP and FIGETBSZ emulation
dfc0263373 e9d02b5931 Mark Cave-Ayland:
 qtest/am53c974-test: add additional test for cmdfifo overflow
b5d260d8ae 36ec1a829a Mark Cave-Ayland:
 esp.c: fix esp_cdb_ready() FIFO wraparound limit calculation
4f8b6a983c fb722e1dc2 Helge Deller:
 hw/hppa: Fix interrupt of LASI parallel port
91870d6764 575264e908 Akihiko Odaki:
 nw/nvram/ds1225y: Fix nvram MemoryRegion owner
3560df2c1c 1a8ffd6172 Peter Maydell:
 target/hppa: Set FPCR exception flag bits for non-trapped exceptions
3be85c436c 6910f04aa6 Fiona Ebner:
 hw/scsi: avoid deadlock upon TMF request cancelling with VirtIO
b7fcf2670f 3995fc238e Daniel P. Berrangé:
 crypto: stop requiring "key encipherment" usage in x509 certs
e21ef56b4b b7a1f2ca45 Daniel P. Berrangé:
 io: fix use after free in websocket handshake code
997ac8b076 322c3c4f3a Daniel P. Berrangé:
 io: move websock resource release to close method
a73800ef9b 2c147611cf Daniel P. Berrangé:
 io: release active GSource in TLS channel finalizer
b1317a2384 06e01941ff Daniel Henrique Barboza:
 target/riscv: fix riscv_cpu_sirq_pending() mask
44c571898c 2a21cbee47 Daniel Henrique Barboza:
 target/riscv/kvm: fix env->priv setting in reset_regs_csr()
30f152de6e 8ab99a05f3 Daniel Henrique Barboza:
 target/riscv/kvm: add scounteren CSR
1513fcb75c 775ac57e0a Daniel Henrique Barboza:
 target/riscv/kvm: read/write KVM regs via env size
1a17257fa6 86b8c38214 Daniel Henrique Barboza:
 target/riscv/kvm: add senvcfg CSR
2d6d739ea6 5e3e066e4a Jialong Yang:
 aplic: fix mask for smsiaddrcfgh
3d106818a7 e41139eaad Zejun Zhao:
 hw/riscv: Correct mmu-type property of sifive_u harts in device tree
3905b74add 3f462d79a0 Peter Maydell:
 target/arm: Fix reads of CNTFRQ_EL0 in linux-user mode
d5f47a089a 270b28681e Thomas Huth:
 hw/ppc/e500: Check for compatible CPU type instead of aborting ungracefully
7509d79359 0c6d6d79a5 Dongwon Kim:
 ui/gtk-gl-area: Remove extra draw call in refresh
47e775f0ea 77dc9d662f Peter Maydell:
 tests/tcg/multiarch/linux/linux-test: Don't try to test atime update


