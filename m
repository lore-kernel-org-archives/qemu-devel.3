Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16522CFC504
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd98-0006bD-E3; Fri, 21 Nov 2025 21:14:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMd8c-0006F6-AX; Fri, 21 Nov 2025 21:14:10 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMd7y-000561-Sn; Fri, 21 Nov 2025 21:14:06 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6D48916C6D8;
 Fri, 21 Nov 2025 16:51:53 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C6B9732194F;
 Fri, 21 Nov 2025 16:52:01 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 00/76] Patch Round-up for stable 10.1.3,
 freeze on 2025-12-01
Date: Fri, 21 Nov 2025 16:50:38 +0300
Message-ID: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The following patches are queued for QEMU stable v10.1.3:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-10.1

Patch freeze is 2025-12-01, and the release is planned for 2025-12-03:

  https://wiki.qemu.org/Planning/10.1

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 27ea28a0b369 Richard Henderson:
   tcg/arm: Fix tgen_deposit
02 77dc9d662f80 Peter Maydell:
   tests/tcg/multiarch/linux/linux-test: Don't try to test atime update
03 270b28681e36 Thomas Huth:
   hw/ppc/e500: Check for compatible CPU type instead of aborting 
   ungracefully
04 aaca725884b5 John Levon:
   vfio: rename field to "num_initial_regions"
05 ecbe424a63c9 John Levon:
   vfio: only check region info cache for initial regions
06 3f462d79a080 Peter Maydell:
   target/arm: Fix reads of CNTFRQ_EL0 in linux-user mode
07 e41139eaad1d Zejun Zhao:
   hw/riscv: Correct mmu-type property of sifive_u harts in device tree
08 5e3e066e4ac8 Jialong Yang:
   aplic: fix mask for smsiaddrcfgh
09 2a21cbee47a1 Daniel Henrique Barboza:
   target/riscv/kvm: fix env->priv setting in reset_regs_csr()
10 06e01941ffca Daniel Henrique Barboza:
   target/riscv: fix riscv_cpu_sirq_pending() mask
11 2c147611cf56 Daniel P. Berrangé:
   io: release active GSource in TLS channel finalizer
12 322c3c4f3abe Daniel P. Berrangé:
   io: move websock resource release to close method
13 b7a1f2ca45c7 Daniel P. Berrangé:
   io: fix use after free in websocket handshake code
14 3995fc238e05 Daniel P. Berrangé:
   crypto: stop requiring "key encipherment" usage in x509 certs
15 6910f04aa646 Fiona Ebner:
   hw/scsi: avoid deadlock upon TMF request cancelling with VirtIO
16 1a8ffd6172f3 Peter Maydell:
   target/hppa: Set FPCR exception flag bits for non-trapped exceptions
17 fb722e1dc2d8 Helge Deller:
   hw/hppa: Fix interrupt of LASI parallel port
18 36ec1a829a07 Mark Cave-Ayland:
   esp.c: fix esp_cdb_ready() FIFO wraparound limit calculation
19 e9d02b59316f Mark Cave-Ayland:
   qtest/am53c974-test: add additional test for cmdfifo overflow
20 7c7089321670 Bastian Blank:
   linux-user: Use correct type for FIBMAP and FIGETBSZ emulation
21 0db2de22fcbf Peter Maydell:
   linux-user: permit sendto() with NULL buf and 0 len
22 d5e1d2dea11b Paolo Bonzini:
   target/i386: clear CPU_INTERRUPT_SIPI for all accelerators
23 d1193481dee6 peng guo:
   hw/i386/pc: Avoid overlap between CXL window and PCI 64bit BARs in QEMU
24 639a29422754 Xiaoyao Li:
   i386/kvm/cpu: Init SMM cpu address space for hotplugged CPUs
25 6eda39a87f4f Daniel P. Berrangé:
   block: remove 'detached-header' option from opts after use
26 c86488abaf01 Daniel P. Berrangé:
   block: fix luks 'amend' when run in coroutine
27 ad97769e9dcf Richard W.M. Jones:
   block/curl.c: Fix CURLOPT_VERBOSE parameter type
28 524fc77d2322 Sean Anderson:
   gdbstub: Fix %s formatting
29 a04c5ba543c1 Edgar E. Iglesias:
   target/microblaze: Remove unused arg from check_divz()
30 0e46b4d1f13b Edgar E. Iglesias:
   target/microblaze: div: Break out raise_divzero()
31 cfc1d54251d3 Edgar E. Iglesias:
   target/microblaze: Handle signed division overflows
32 df7e9243d540 Ilya Leoshkevich:
   target/s390x: Fix missing interrupts for small CKC values
33 dacfec5157fb Ilya Leoshkevich:
   target/s390x: Fix missing clock-comparator interrupts after reset
34 fc976a67ded4 Ilya Leoshkevich:
   target/s390x: Use address generation for register branch targets
35 0408c61e27ac Ilya Leoshkevich:
   tests/tcg/s390x: Test SET CLOCK COMPARATOR
36 8922a758b292 Chenyi Qiang:
   ram-block-attributes: fix interaction with hugetlb memory backends
37 75e2cb144191 Xiaoyao Li:
   hostmem/shm: Allow shm memory backend serve as shared memory for coco-VMs
38 4f503afc7eb5 Peter Maydell:
   target/x86: Correctly handle invalid 0x0f 0xc7 0xxx insns
39 fde5930cc371 Albert Esteve:
   vhost-user: fix shared object lookup handler logic
40 3e6ad83f209e Shameer Kolothum:
   tests/qtest/bios-tables-test: Prepare for _DSM change in the DSDT table
41 325aa2d86a20 Eric Auger:
   hw/pci-host/gpex-acpi: Fix _DSM function 0 support return value
42 ccf166d89dcf Shameer Kolothum:
   tests/qtest/bios-tables-test: Update DSDT blobs after GPEX _DSM change
43 f00bcc833790 Akihiko Odaki:
   qemu-img: Fix amend option parse error handling
44 909852ba6b4a Alberto Garcia:
   qemu-img rebase: don't exceed IO_BUF_SIZE in one operation
45 4c91719a6a78 Alberto Garcia:
   tests/qemu-iotest: fix iotest 024 with qed images
46 59506e59e0f0 Eric Blake:
   qio: Add trace points to net_listener
47 6e03d5cdc991 Eric Blake:
   qio: Unwatch before notify in QIONetListener
48 b5676493a08b Eric Blake:
   qio: Remember context of qio_net_listener_set_client_func_full
49 9d86181874ab Eric Blake:
   qio: Protect NetListener callback with mutex
50 6da0c9828194 Peter Maydell:
   hw/net/e1000e_core: Don't advance desc_offset for NULL buffer RX 
   descriptors
51 9d946d56a2ac Peter Maydell:
   hw/net/e1000e_core: Correct rx oversize packet checks
52 bab496a18358 Peter Maydell:
   hw/net/e1000e_core: Adjust e1000e_write_payload_frag_to_rx_buffers() 
   assert
53 a01344d9d780 Peter Maydell:
   net: pad packets to minimum length in qemu_receive_packet()
54 f52db7f34242 Peter Maydell:
   hw/display/xlnx_dp.c: Don't abort on AUX FIFO overrun/underrun
55 032333eba77b Peter Maydell:
   hw/display/xlnx_dp: Don't abort for unsupported graphics formats
56 5fc50b4ec841 Peter Maydell:
   hw/misc/npcm_clk: Don't divide by zero when calculating frequency
57 863449cc8ec7 Alex Bennée:
   tests: move test_xen assets to share.linaro.org
58 dfaf3695b20d Alex Bennée:
   tests: move test_virt assets to share.linaro.org
59 5ff8d1fac98b Alex Bennée:
   tests: move test_netdev_ethtool to share.linaro.org
60 533b5ac2d6a8 Alex Bennée:
   tests: move test_kvm_xen to share.linaro.org
61 ced9f2ffc20d Alex Bennée:
   tests: move test_kvm to share.linaro.org
62 497d3e87ce2d Alex Bennée:
   tests: move test_virt_gpu to share.linaro.org
63 89d22536d1a1 Hanna Czenczek:
   rbd: Run co BH CB in the coroutine’s AioContext
64 deb35c129b85 Hanna Czenczek:
   nfs: Run co BH CB in the coroutine’s AioContext
65 53d5c7ffac7b Hanna Czenczek:
   curl: Fix coroutine waking
66 7a501bbd5194 Hanna Czenczek:
   nvme: Kick and check completions in BDS context
67 0f142cbd919f Hanna Czenczek:
   nvme: Fix coroutine waking
68 9b9ee60c07f5 Hanna Czenczek:
   block/io: Take reqs_lock for tracked_requests
69 124ab930ba38 Daniel P. Berrangé:
   tests/functional: fix formatting of exception args
70 335da23abec8 Daniel P. Berrangé:
   tests/functional: handle URLError when fetching assets
71 a344e22917f4 Yannick Voßen:
   hw/dma/zynq-devcfg: Fix register memory
72 9c3b76a0d406 Philippe Mathieu-Daudé:
   hw/southbridge/lasi: Correct LasiState parent
73 ebd9ea2947d8 Peter Maydell:
   target/i386: Mark VPERMILPS as not valid with prefix 0
74 ebb46ba6a4a2 Paolo Bonzini:
   target/i386/tcg: validate segment registers
75 9c3afb9d9b92 Paolo Bonzini:
   target/i386: svm: fix sign extension of exit code
76 106d766c9d5b Paolo Bonzini:
   target/i386: fix stack size when delivering real mode interrupts

