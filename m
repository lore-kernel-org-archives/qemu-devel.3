Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D472ED1266D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 08:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQhmC-0008FW-FJ; Wed, 03 Dec 2025 02:59:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQhm7-0008Cv-Lt; Wed, 03 Dec 2025 02:59:47 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQhm3-0006C6-MF; Wed, 03 Dec 2025 02:59:47 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CFAF617075E;
 Wed, 03 Dec 2025 10:59:21 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9DF2532B485;
 Wed, 03 Dec 2025 10:59:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 v2 000/116] Patch Round-up for stable 10.0.7,
 freeze on 2025-12-01 (actually on 2025-12-03, frozen)
Date: Wed,  3 Dec 2025 10:59:01 +0300
Message-ID: <qemu-stable-10.0.7-20251203105830@cover.tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

The following patches are queued for QEMU stable v10.0.7:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-10.0

Patch freeze was 2025-12-01, and the release was planned for 2025-12-03;
however, both dates were moved by 2 days:

  https://wiki.qemu.org/Planning/10.0

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* 77dc9d662f80 Peter Maydell:
   tests/tcg/multiarch/linux/linux-test: Don't try to test atime update
02* 0c6d6d79a5cb Dongwon Kim:
   ui/gtk-gl-area: Remove extra draw call in refresh
03* 270b28681e36 Thomas Huth:
   hw/ppc/e500: Check for compatible CPU type instead of aborting ungracefully
04* 3f462d79a080 Peter Maydell:
   target/arm: Fix reads of CNTFRQ_EL0 in linux-user mode
05* e41139eaad1d Zejun Zhao:
   hw/riscv: Correct mmu-type property of sifive_u harts in device tree
06* 5e3e066e4ac8 Jialong Yang:
   aplic: fix mask for smsiaddrcfgh
07* 86b8c3821496 Daniel Henrique Barboza:
   target/riscv/kvm: add senvcfg CSR
08* 775ac57e0a54 Daniel Henrique Barboza:
   target/riscv/kvm: read/write KVM regs via env size
09* 8ab99a05f34b Daniel Henrique Barboza:
   target/riscv/kvm: add scounteren CSR
10* 2a21cbee47a1 Daniel Henrique Barboza:
   target/riscv/kvm: fix env->priv setting in reset_regs_csr()
11* 06e01941ffca Daniel Henrique Barboza:
   target/riscv: fix riscv_cpu_sirq_pending() mask
12* 2c147611cf56 Daniel P. Berrangé:
   io: release active GSource in TLS channel finalizer
13* 322c3c4f3abe Daniel P. Berrangé:
   io: move websock resource release to close method
14* b7a1f2ca45c7 Daniel P. Berrangé:
   io: fix use after free in websocket handshake code
15* 3995fc238e05 Daniel P. Berrangé:
   crypto: stop requiring "key encipherment" usage in x509 certs
16* 6910f04aa646 Fiona Ebner:
   hw/scsi: avoid deadlock upon TMF request cancelling with VirtIO
17* 1a8ffd6172f3 Peter Maydell:
   target/hppa: Set FPCR exception flag bits for non-trapped exceptions
18* 575264e9083b Akihiko Odaki:
   nw/nvram/ds1225y: Fix nvram MemoryRegion owner
19* fb722e1dc2d8 Helge Deller:
   hw/hppa: Fix interrupt of LASI parallel port
20* 36ec1a829a07 Mark Cave-Ayland:
   esp.c: fix esp_cdb_ready() FIFO wraparound limit calculation
21* e9d02b59316f Mark Cave-Ayland:
   qtest/am53c974-test: add additional test for cmdfifo overflow
22* 7c7089321670 Bastian Blank:
   linux-user: Use correct type for FIBMAP and FIGETBSZ emulation
23* 0db2de22fcbf Peter Maydell:
   linux-user: permit sendto() with NULL buf and 0 len
24* d5e1d2dea11b Paolo Bonzini:
   target/i386: clear CPU_INTERRUPT_SIPI for all accelerators
25* d1193481dee6 peng guo:
   hw/i386/pc: Avoid overlap between CXL window and PCI 64bit BARs in QEMU 
   10.0.x
26* 639a29422754 Xiaoyao Li:
   i386/kvm/cpu: Init SMM cpu address space for hotplugged CPUs
27* 6eda39a87f4f Daniel P. Berrangé:
   block: remove 'detached-header' option from opts after use
28* c86488abaf01 Daniel P. Berrangé:
   block: fix luks 'amend' when run in coroutine
29* ad97769e9dcf Richard W.M. Jones:
   block/curl.c: Fix CURLOPT_VERBOSE parameter type
30* 524fc77d2322 Sean Anderson:
   gdbstub: Fix %s formatting
31* a04c5ba543c1 Edgar E. Iglesias:
   target/microblaze: Remove unused arg from check_divz()
32* 0e46b4d1f13b Edgar E. Iglesias:
   target/microblaze: div: Break out raise_divzero()
33* cfc1d54251d3 Edgar E. Iglesias:
   target/microblaze: Handle signed division overflows
34* df7e9243d540 Ilya Leoshkevich:
   target/s390x: Fix missing interrupts for small CKC values
35* dacfec5157fb Ilya Leoshkevich:
   target/s390x: Fix missing clock-comparator interrupts after reset
36* fc976a67ded4 Ilya Leoshkevich:
   target/s390x: Use address generation for register branch targets
37* 0408c61e27ac Ilya Leoshkevich:
   tests/tcg/s390x: Test SET CLOCK COMPARATOR
38* 75e2cb144191 Xiaoyao Li:
   hostmem/shm: Allow shm memory backend serve as shared memory for coco-VMs
39* 4f503afc7eb5 Peter Maydell:
   target/x86: Correctly handle invalid 0x0f 0xc7 0xxx insns
40* fde5930cc371 Albert Esteve:
   vhost-user: fix shared object lookup handler logic
41* 3e6ad83f209e Shameer Kolothum:
   tests/qtest/bios-tables-test: Prepare for _DSM change in the DSDT table
42* 325aa2d86a20 Eric Auger:
   hw/pci-host/gpex-acpi: Fix _DSM function 0 support return value
43* ccf166d89dcf Shameer Kolothum:
   tests/qtest/bios-tables-test: Update DSDT blobs after GPEX _DSM change
44* f00bcc833790 Akihiko Odaki:
   qemu-img: Fix amend option parse error handling
45* 909852ba6b4a Alberto Garcia:
   qemu-img rebase: don't exceed IO_BUF_SIZE in one operation
46* 4c91719a6a78 Alberto Garcia:
   tests/qemu-iotest: fix iotest 024 with qed images
47* 59506e59e0f0 Eric Blake:
   qio: Add trace points to net_listener
48* 6e03d5cdc991 Eric Blake:
   qio: Unwatch before notify in QIONetListener
49* b5676493a08b Eric Blake:
   qio: Remember context of qio_net_listener_set_client_func_full
50* 9d86181874ab Eric Blake:
   qio: Protect NetListener callback with mutex
51* 6da0c9828194 Peter Maydell:
   hw/net/e1000e_core: Don't advance desc_offset for NULL buffer RX 
   descriptors
52* 9d946d56a2ac Peter Maydell:
   hw/net/e1000e_core: Correct rx oversize packet checks
53* bab496a18358 Peter Maydell:
   hw/net/e1000e_core: Adjust e1000e_write_payload_frag_to_rx_buffers() 
   assert
54* a01344d9d780 Peter Maydell:
   net: pad packets to minimum length in qemu_receive_packet()
55* f52db7f34242 Peter Maydell:
   hw/display/xlnx_dp.c: Don't abort on AUX FIFO overrun/underrun
56* 032333eba77b Peter Maydell:
   hw/display/xlnx_dp: Don't abort for unsupported graphics formats
57* 5fc50b4ec841 Peter Maydell:
   hw/misc/npcm_clk: Don't divide by zero when calculating frequency
58* 71365ee43312 Vincent Vanlaer:
   block: get type of block allocation in commit_run
59* 23743ab282af Vincent Vanlaer:
   block: move commit_run loop to separate function
60* 0648c76ad198 Vincent Vanlaer:
   block: refactor error handling of commit_iteration
61* 6f3199f99600 Vincent Vanlaer:
   block: allow commit to unmap zero blocks
62* 68aba2a93503 Vincent Vanlaer:
   block: add test non-active commit with zeroed data
63* 863449cc8ec7 Alex Bennée:
   tests: move test_xen assets to share.linaro.org
64* dfaf3695b20d Alex Bennée:
   tests: move test_virt assets to share.linaro.org
65* 5ff8d1fac98b Alex Bennée:
   tests: move test_netdev_ethtool to share.linaro.org
66* 533b5ac2d6a8 Alex Bennée:
   tests: move test_kvm_xen to share.linaro.org
67* 497d3e87ce2d Alex Bennée:
   tests: move test_virt_gpu to share.linaro.org
68* 89d22536d1a1 Hanna Czenczek:
   rbd: Run co BH CB in the coroutine’s AioContext
69* deb35c129b85 Hanna Czenczek:
   nfs: Run co BH CB in the coroutine’s AioContext
70* 53d5c7ffac7b Hanna Czenczek:
   curl: Fix coroutine waking
71* 7a501bbd5194 Hanna Czenczek:
   nvme: Kick and check completions in BDS context
72* 0f142cbd919f Hanna Czenczek:
   nvme: Fix coroutine waking
73* 9b9ee60c07f5 Hanna Czenczek:
   block/io: Take reqs_lock for tracked_requests
74* 124ab930ba38 Daniel P. Berrangé:
   tests/functional: fix formatting of exception args
75* 335da23abec8 Daniel P. Berrangé:
   tests/functional: handle URLError when fetching assets
76* a344e22917f4 Yannick Voßen:
   hw/dma/zynq-devcfg: Fix register memory
77* 9c3b76a0d406 Philippe Mathieu-Daudé:
   hw/southbridge/lasi: Correct LasiState parent
78* ebd9ea2947d8 Peter Maydell:
   target/i386: Mark VPERMILPS as not valid with prefix 0
79* ebb46ba6a4a2 Paolo Bonzini:
   target/i386/tcg: validate segment registers
80* 9c3afb9d9b92 Paolo Bonzini:
   target/i386: svm: fix sign extension of exit code
81* 106d766c9d5b Paolo Bonzini:
   target/i386: fix stack size when delivering real mode interrupts
82 4e3823c68cc5 Cornelia Huck:
   tests/functional/test_vnc: skip test if no crypto backend available
83 22baa5f340d4 Thomas Huth:
   gitlab-ci: Remove the avocado tests from the CI pipelines
84 bc65ae696104 Thomas Huth:
   tests/functional: Move the check for the parameters from avocado to 
   functional
85 951ededf12a8 Thomas Huth:
   tests/functional: Convert reverse_debugging tests to the functional 
   framework
86 0e756f404d73 Thomas Huth:
   tests/functional: Convert the i386 replay avocado test
87 574f71bc1f22 Thomas Huth:
   tests/avocado: Remove the LinuxKernelTest class
88 42a87f0ce7aa Thomas Huth:
   tests/functional: Convert the 32-bit big endian Wheezy mips test
89 689a8b56a6f3 Thomas Huth:
   tests/functional: Convert the 32-bit little endian Wheezy mips test
90 8e3461c3a6fc Thomas Huth:
   tests/functional: Convert the 64-bit little endian Wheezy mips test
91 f79592f427d7 Thomas Huth:
   tests/functional: Convert the 64-bit big endian Wheezy mips test
92 e83aee9c6a0f Thomas Huth:
   tests/avocado: Remove the boot_linux.py tests
93 7fecdb0acd99 Thomas Huth:
   tests/functional: Use the tuxrun kernel for the x86 replay test
94 a820caf8444c Thomas Huth:
   tests/functional: Use the tuxrun kernel for the aarch64 replay test
95 5c2bae2155b1 Thomas Huth:
   tests/functional: Convert the SMMU test to the functional framework
96 f8c548441759 Thomas Huth:
   gitlab-ci: Update QEMU_JOB_AVOCADO and QEMU_CI_AVOCADO_TESTING
97 5748e4641509 Thomas Huth:
   docs/devel/testing: Dissolve the ci-definitions.rst.inc file
98 52e9ed6d3ac4 Thomas Huth:
   Remove the remainders of the Avocado tests
99 858640eaee9f Thomas Huth:
   tests/functional: Remove semicolons at the end of lines
100 99fb9256b761 Thomas Huth:
   tests/functional: Remove unnecessary import statements
101 12c6b6153063 Thomas Huth:
   MAINTAINERS: Add functional tests that are not covered yet
102 5fbcbf76a19a Jack Wang:
   qmp: Fix a typo for a USO feature
103 0b5bf4ea7620 Li Zhijian:
   migration: Fix transition to COLO state from precopy
104 510d5c61ad3e Jamin Lin:
   hw/arm/aspeed: Fix missing SPI IRQ connection causing DMA interrupt 
   failure
105 4a934d284dfa Peter Maydell:
   hw/arm/armv7m: Disable reentrancy guard for v7m_sysreg_ns_ops MRs
106 579be921f509 Peter Maydell:
   hw/display/exynos4210_fimd: Account for zero length in 
   fimd_update_memory_section()
107 303f6049358e Philippe Mathieu-Daudé:
   chardev/char-pty: Do not ignore chr_write() failures
108 4c1646e23f76 AlanoSong@163.com:
   ui/vnc: Fix qemu abort when query vnc info
109 8eeaa706ba73 Kevin Wolf:
   block-backend: Fix race when resuming queued requests
110 eb3e5de450 Fiona Ebner:
   block/io_uring: avoid potentially getting stuck after resubmit at the end 
   of ioq_submit()
111 ef44cc0a7624 Peter Maydell:
   hw/pci: Make msix_init take a uint32_t for nentries
112 98ee8aa92e93 Peter Xu:
   hw/core/machine: Provide a description for aux-ram-share property
113 57756aa01fe5 Cédric Le Goater:
   hw/aspeed/{xdma, rtc, sdhci}: Fix endianness to DEVICE_LITTLE_ENDIAN
114 7248dab3c9d7 Harald van Dijk:
   target/arm: Fix assert on BRA.
115 ebb625262c7f Peter Maydell:
   docs/devel: Update URL for make-pullreq script
116 88be119fb19b Markus Armbruster:
   kvm: Fix kvm_vm_ioctl() and kvm_device_ioctl() return value

(commit(s) marked with * were in previous series and are not resent)

