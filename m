Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E290F506D4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 13:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w28NO-0003FX-MB; Mon, 16 Mar 2026 09:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w28Mu-0002gw-Od; Mon, 16 Mar 2026 09:52:32 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w28Ms-0000C2-1W; Mon, 16 Mar 2026 09:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773669140; bh=wS8CP7s1L4u2ReotuHTA5nBb4whssF8gkgew2ONOtfw=;
 h=From:To:Cc:Subject:Date;
 b=MgOwzBZ+uLeWhfpfMqX8Kr6h6MpNECEw+xuKLrEYNIsg3JnBVCEQoFeCacIoH7kpO
 zG48kmEseumX+RiVsPmyMdBH1M5qMQnoOO4/IXKo20hW3ZBExm6DVzPc+RTL1alaS3
 zOwDmmxmW73AVHdXRAzjNgsFKZrjQCfToSUsJr9T6DW2NuMRFkx4PPOJpeinodMh66
 lCspftNdrWjnAVpRYxfO8rzZZ8/E6hqSJCaIRmeFy2Ga2uarof8pJ/AALbhfGeG1SL
 ac1l/keCP73F7NLbMxHN3MhuFHLgDP3GQppau8LPKgAZe67fJpcmZW2V+jhNoBPLHK
 qZwOu+fhlsIbw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B461B193EF6;
 Mon, 16 Mar 2026 16:52:20 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4C97C38093E;
 Mon, 16 Mar 2026 16:52:24 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.2 v2 00/55/02] Patch Round-up for stable 10.2.2,
 freeze on 2026-03-15 (frozen)
Date: Mon, 16 Mar 2026 16:52:20 +0300
Message-ID: <qemu-stable-10.2.2-20260316164931@cover.tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following patches are queued for QEMU stable v10.2.2:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-10.2

Patch freeze is 2026-03-15, and the release is planned for 2026-03-17:

  https://wiki.qemu.org/Planning/10.2

This review/release cycle is a bit shorter than usual, because
of a few security fixes accumulated in there.

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* 00ebc44514a6 Jaehoon Kim:
   s390x/pci: Fix endianness for zPCI BAR values.
02* b0353beebb0c Mohamed Mediouni:
   plugins: fix cross-build using LLVM for Windows targets
03* 4a7b1bd18d2e Fiona Ebner:
   block/mirror: check range when setting zero bitmap for sync write
04* 267d7ae99a1d Fiona Ebner:
   iotests: test active mirror with unaligned, small write zeroes op
05* e44a26ba9402 John Snow:
   python: drop uses of pkg_resources
06* 90fabd5ddace Alex Bradbury:
   contrib/plugins/hotblocks: Correctly free sorted counts list
07* 1c1e45fcd662 Alex Bradbury:
   contrib/plugins/hotblocks: Fix off by one error in iteration of sorted 
   blocks
08* e777f6ab9140 Alex Bradbury:
   contrib/plugins/hotblocks: Print uint64_t with PRIu64 rather than PRId64
09* e4ed74c9aef6 Alex Bradbury:
   docs/about/emulation: Add documentation for hotblocks plugin arguments
10* c2c5beec42bf Jamin Lin:
   hw/i2c/aspeed_i2c: Fix out-of-bounds read in I2C MMIO handlers
11* 42eab40a12f1 Peter Maydell:
   target/arm: Account for SME in aarch64_sve_narrow_vq() assertion
12* ee5bf0962ed6 Peter Maydell:
   target/arm: Fix feature check in DO_SVE2_RRX, DO_SVE2_RRX_TB
13* 433097a22421 Peter Maydell:
   target/arm/tcg: Allow SVE RAX1 in SME2p1 streaming mode
14* aeb3c147fc4a Peter Maydell:
   target/arm: Don't let 'sme=on' downgrade SME
15* 16786eb7bf86 Helge Deller:
   hw/hppa: Add BMC on 64-bit machines only
16* b2a279094c3b Akihiko Odaki:
   virtio-gpu-virgl: Add virtio-gpu-virgl-hostmem-region type
17* 34238f078a04 Manos Pitsidianakis:
   virtio-snd: remove TODO comments
18* 61679d7dcfa2 Manos Pitsidianakis:
   virtio-snd: handle 5.14.6.2 for PCM_INFO properly
19* bcb53328aa70 Manos Pitsidianakis:
   virtio-snd: fix max_size bounds check in input cb
20* 7994203bb1b8 Manos Pitsidianakis:
   virtio-snd: tighten read amount in in_cb
21* 8608ed356ef9 Kuan-Wei Chiu:
   hw/misc/virt_ctrl: Fix incorrect trace event in read operation
22* 669683cf1414 Weixie Cui:
   hw/ssi/xilinx_spips: Reset TX FIFO in reset
23* 662fd548a027 Alex Bennée:
   target/arm: set the correct TI bits for WFIT traps
24* c96f6d2398a9 Richie Buturla:
   hw/9pfs: fix data race in v9fs_mark_fids_unreclaim()
25* b72d15f47cbd Christian Schoenebeck:
   hw/9pfs: fix missing EOPNOTSUPP on Twstat and Trenameat for fs synth 
   driver
26* 48c8916aec43 Josh Poimboeuf:
   hw/i386/vmmouse: Fix hypercall clobbers
27* c86bca1671e9 Bernhard Beschow:
   target/i386/emulate/x86_decode: Fix compiler warning
28* 529e5e764307 Bernhard Beschow:
   target/i386/hvf/x86_mmu: Fix compiler warning
29* 1b93832f5592 Bernhard Beschow:
   target/i386/emulate/x86_decode: Actually use stream in 
   decode_instruction_stream()
30* 78c6b6010ce7 Peter Maydell:
   target/ppc/translate: Fix TCG debug assert translating CLRBWIBC
31* 163cd0ae1182 Daniel P. Berrangé:
   io: separate freeing of tasks from marking them as complete
32* d39d0f3acdd7 Daniel P. Berrangé:
   io: fix cleanup for TLS I/O source data on cancellation
33* 9545c059f77e Daniel P. Berrangé:
   io: fix cleanup for websock I/O source data on cancellation
34* d8e19f8042dc Peter Maydell:
   hw/net/smc91c111: Don't allow negative-length packets
35* cfda94eddb6c Halil Oktay (oblivionsage):
   block/vmdk: fix OOB read in vmdk_read_extent()
36* 6f7b0a23a6ea Antoine Damhet:
   block/curl: fix concurrent completion handling
37* 0f51f9c3420b Kevin Wolf:
   mirror: Fix missed dirty bitmap writes during startup
38* d4816177654d Dmitry Guryanov:
   block/throttle-groups: fix deadlock with iolimits and muliple iothreads
39* 544ddbb6373d Kevin Wolf:
   block: Never drop BLOCK_IO_ERROR with action=stop for rate limiting
40* 1d6610099bd7 Hanna Czenczek:
   block/nfs: Do not enter coroutine from CB
41* 2ae361ef1d7d Jens Axboe:
   aio-posix: notify main loop when SQEs are queued
42* 961fcc0f2276 Jens Axboe:
   fdmon-io_uring: check CQ ring directly in gsource_check
43* 235f9b36383e Dmitry Osipenko:
   virtio-gpu: Ensure BHs are invoked only from main-loop thread
44* 6595a8d5d17e Peter Maydell:
   hw/net/xilinx_ethlite: Check for oversized TX packets
45* f2813e13fe91 Bingwu Zhang:
   linux-user: Deal with mmap where start > reserved_va
46* e8e7d1f97785 Bingwu Zhang:
   bsd-user: Deal with mmap where start > reserved_va
47* c865b6bce5d0 Bingwu Zhang:
   tests/tcg/multiarch/test-mmap: Check mmaps beyond reserved_va
48* 6a1221614fd9 Andreas Schwab:
   linux-user: fix TIOCGSID ioctl
49* 550391c7134d Peter Maydell:
   hw/net/npcm_gmac: Catch accesses off the end of the register array
50* 1e3e1d51e20e Peter Maydell:
   hw: Make qdev_get_printable_name() consistently return freeable string
51* db2325f79481 rail5:
   target/loongarch: Avoid recursive PNX exception on CSR_BADI fetch
52* 2d877bc02a3b rail5:
   target/loongarch: Preserve PTE permission bits in LDPTE
53* a3fcbca0ef64 Hanna Czenczek:
   fuse: Copy write buffer content before polling
54 4f28b87fdd24 Paolo Bonzini:
   hyperv/syndbg: check length returned by cpu_physical_memory_map()
55 1b80f1009dca Fiona Ebner:
   target/i386: add compat for migrating error code

(commit(s) marked with * were in previous series and are not resent)

