Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C75F506D2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 13:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w28Ls-0001lT-A4; Mon, 16 Mar 2026 09:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w28Lj-0001kw-Ll; Mon, 16 Mar 2026 09:51:16 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w28Lf-0008Vp-U3; Mon, 16 Mar 2026 09:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773669061; bh=d6w02XGfFCcsvF1zlnD333tW5nL2tJ5ScAbAvrhiw/E=;
 h=From:To:Cc:Subject:Date;
 b=t56irjXclmwCV4lkEaol17QRBKwfAH6yMs/KahX1Hu3xc/D/e4hXvJGOzZNL4HE4Z
 S41RdcsIV3ChLOYs3lGKGNukI0M60406h+p/Ddq7wORG+3GaxBpczF2p1I1pOW1Qg9
 amS7MbBEux101JFyImdyK6gCCs+OuPyTL1tM5VVixTRvwdcBPsAI001wZcx8jEYDjF
 lKlmG8g090Bbm+ySt066uKZeAC0aUv4huve1eEeuIvJXCJEPdPUYGDT1XKYKJfnSS1
 VNdN5pC/ZoLYEHd+xRZIuTs13lLKKivmschTEFQ5LI8TlVhaPiJwWMOOLjfrOyAS42
 gpIVDqmcYYn2A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 38F89193EED;
 Mon, 16 Mar 2026 16:51:01 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C30E7380937;
 Mon, 16 Mar 2026 16:51:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.9 v2 00/46] Patch Round-up for stable 10.0.9,
 freeze on 2026-03-15 (frozen)
Date: Mon, 16 Mar 2026 16:50:42 +0300
Message-ID: <qemu-stable-10.0.9-20260316164926@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v10.0.9:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-10.0

Patch freeze is 2026-03-15, and the release is planned for 2026-03-17:

  https://wiki.qemu.org/Planning/10.0

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
03* e44a26ba9402 John Snow:
   python: drop uses of pkg_resources
04* 01499add2ae6 Kohei Tokunaga:
   contrib/plugins: Fix type conflict of GLib function pointers
05* 90fabd5ddace Alex Bradbury:
   contrib/plugins/hotblocks: Correctly free sorted counts list
06* 1c1e45fcd662 Alex Bradbury:
   contrib/plugins/hotblocks: Fix off by one error in iteration of sorted 
   blocks
07* e777f6ab9140 Alex Bradbury:
   contrib/plugins/hotblocks: Print uint64_t with PRIu64 rather than PRId64
08* e4ed74c9aef6 Alex Bradbury:
   docs/about/emulation: Add documentation for hotblocks plugin arguments
09* c2c5beec42bf Jamin Lin:
   hw/i2c/aspeed_i2c: Fix out-of-bounds read in I2C MMIO handlers
10* c48d0471beb0 Richard Henderson:
   target/arm: Introduce ARMCPU.sme_max_vq
11* 42eab40a12f1 Peter Maydell:
   target/arm: Account for SME in aarch64_sve_narrow_vq() assertion
12* ee5bf0962ed6 Peter Maydell:
   target/arm: Fix feature check in DO_SVE2_RRX, DO_SVE2_RRX_TB
13* b2a279094c3b Akihiko Odaki:
   virtio-gpu-virgl: Add virtio-gpu-virgl-hostmem-region type
14* 34238f078a04 Manos Pitsidianakis:
   virtio-snd: remove TODO comments
15* 61679d7dcfa2 Manos Pitsidianakis:
   virtio-snd: handle 5.14.6.2 for PCM_INFO properly
16* bcb53328aa70 Manos Pitsidianakis:
   virtio-snd: fix max_size bounds check in input cb
17* 7994203bb1b8 Manos Pitsidianakis:
   virtio-snd: tighten read amount in in_cb
18* 8608ed356ef9 Kuan-Wei Chiu:
   hw/misc/virt_ctrl: Fix incorrect trace event in read operation
19* 669683cf1414 Weixie Cui:
   hw/ssi/xilinx_spips: Reset TX FIFO in reset
20* 662fd548a027 Alex Bennée:
   target/arm: set the correct TI bits for WFIT traps
21* c96f6d2398a9 Richie Buturla:
   hw/9pfs: fix data race in v9fs_mark_fids_unreclaim()
22* b72d15f47cbd Christian Schoenebeck:
   hw/9pfs: fix missing EOPNOTSUPP on Twstat and Trenameat for fs synth 
   driver
23* e2d4646a0268 John Snow:
   tests/docker: upgrade most non-lcitool debian tests to debian 13
24* 48c8916aec43 Josh Poimboeuf:
   hw/i386/vmmouse: Fix hypercall clobbers
25* 529e5e764307 Bernhard Beschow:
   target/i386/hvf/x86_mmu: Fix compiler warning
26* 403d3a5f4a2d Daniel P. Berrangé:
   io: separate freeing of tasks from marking them as complete
27* d39d0f3acdd7 Daniel P. Berrangé:
   io: fix cleanup for TLS I/O source data on cancellation
28* 9545c059f77e Daniel P. Berrangé:
   io: fix cleanup for websock I/O source data on cancellation
29* d8e19f8042dc Peter Maydell:
   hw/net/smc91c111: Don't allow negative-length packets
30* cfda94eddb6c Halil Oktay (oblivionsage):
   block/vmdk: fix OOB read in vmdk_read_extent()
31* 6f7b0a23a6ea Antoine Damhet:
   block/curl: fix concurrent completion handling
32* 0f51f9c3420b Kevin Wolf:
   mirror: Fix missed dirty bitmap writes during startup
33* d4816177654d Dmitry Guryanov:
   block/throttle-groups: fix deadlock with iolimits and muliple iothreads
34* 544ddbb6373d Kevin Wolf:
   block: Never drop BLOCK_IO_ERROR with action=stop for rate limiting
35* 1d6610099bd7 Hanna Czenczek:
   block/nfs: Do not enter coroutine from CB
36* 235f9b36383e Dmitry Osipenko:
   virtio-gpu: Ensure BHs are invoked only from main-loop thread
37* 6595a8d5d17e Peter Maydell:
   hw/net/xilinx_ethlite: Check for oversized TX packets
38* f2813e13fe91 Bingwu Zhang:
   linux-user: Deal with mmap where start > reserved_va
39* e8e7d1f97785 Bingwu Zhang:
   bsd-user: Deal with mmap where start > reserved_va
40* c865b6bce5d0 Bingwu Zhang:
   tests/tcg/multiarch/test-mmap: Check mmaps beyond reserved_va
41* 6a1221614fd9 Andreas Schwab:
   linux-user: fix TIOCGSID ioctl
42* 550391c7134d Peter Maydell:
   hw/net/npcm_gmac: Catch accesses off the end of the register array
43* 2d877bc02a3b rail5:
   target/loongarch: Preserve PTE permission bits in LDPTE
44 db2325f79481 rail5:
   target/loongarch: Avoid recursive PNX exception on CSR_BADI fetch
45* a3fcbca0ef64 Hanna Czenczek:
   fuse: Copy write buffer content before polling
46 4f28b87fdd24 Paolo Bonzini:
   hyperv/syndbg: check length returned by cpu_physical_memory_map()

(commit(s) marked with * were in previous series and are not resent)

