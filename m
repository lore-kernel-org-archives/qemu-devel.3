Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 593A7F506D2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 13:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w28NE-0002qD-PD; Mon, 16 Mar 2026 09:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w28Mm-0002Sz-Sa; Mon, 16 Mar 2026 09:52:20 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w28Mi-0000A8-2J; Mon, 16 Mar 2026 09:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773669130; bh=WT1jl25OLC5QOXXh5u1YFIkjHx+fFWVtIRgfX52ci3s=;
 h=From:To:Cc:Subject:Date;
 b=QDqkqCUTmNmuxo69dw22kPzAjS5qE5geGXq3JudJfosT7BJ6ToBwyzS+VBxC5HvUP
 4QuTrLu47awVhIQzU32YnqG2IX4IqaYMbAoup02EiLRg3wT2n/TivGj2wNS3edy8TE
 zVuEOzvsfKj10GcKWvEdfsAKc9anylBNWUFHhtgeAyI8k+nZL90YO6Ev527Ks0uBW+
 5iZ+K5HFlKCA01KSZHe1K63tggjjgjSNSYyxs6ofdhbE2PlQlBdhgG5eCSliA0jElG
 W2rlmYf4lDi3US9avVuYDFFz80tDrjrZ9qfh+HXImOEz4rUC+7sYXTJxp9fItfI4Os
 z9BYNdhvIMW3w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B7C4A193EF2;
 Mon, 16 Mar 2026 16:52:10 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4F1F938093B;
 Mon, 16 Mar 2026 16:52:14 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.5 v2 00/48/02] Patch Round-up for stable 10.1.5,
 freeze on 2026-03-15 (frozen)
Date: Mon, 16 Mar 2026 16:52:02 +0300
Message-ID: <qemu-stable-10.1.5-20260316164929@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v10.1.5:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-10.1

Patch freeze is 2026-03-15, and the release is planned for 2026-03-17:

  https://wiki.qemu.org/Planning/10.1

This review/release cycle is a bit shorter than usual, because
of a few security fixes accumulated in there.

This release supposed to be the last one in 10.1.x series.

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
15* b2a279094c3b Akihiko Odaki:
   virtio-gpu-virgl: Add virtio-gpu-virgl-hostmem-region type
16* 34238f078a04 Manos Pitsidianakis:
   virtio-snd: remove TODO comments
17* 61679d7dcfa2 Manos Pitsidianakis:
   virtio-snd: handle 5.14.6.2 for PCM_INFO properly
18* bcb53328aa70 Manos Pitsidianakis:
   virtio-snd: fix max_size bounds check in input cb
19* 7994203bb1b8 Manos Pitsidianakis:
   virtio-snd: tighten read amount in in_cb
20* 8608ed356ef9 Kuan-Wei Chiu:
   hw/misc/virt_ctrl: Fix incorrect trace event in read operation
21* 669683cf1414 Weixie Cui:
   hw/ssi/xilinx_spips: Reset TX FIFO in reset
22* 662fd548a027 Alex Bennée:
   target/arm: set the correct TI bits for WFIT traps
23* c96f6d2398a9 Richie Buturla:
   hw/9pfs: fix data race in v9fs_mark_fids_unreclaim()
24* b72d15f47cbd Christian Schoenebeck:
   hw/9pfs: fix missing EOPNOTSUPP on Twstat and Trenameat for fs synth 
   driver
25* 48c8916aec43 Josh Poimboeuf:
   hw/i386/vmmouse: Fix hypercall clobbers
26* c86bca1671e9 Bernhard Beschow:
   target/i386/emulate/x86_decode: Fix compiler warning
27* 529e5e764307 Bernhard Beschow:
   target/i386/hvf/x86_mmu: Fix compiler warning
28* 163cd0ae1182 Daniel P. Berrangé:
   io: separate freeing of tasks from marking them as complete
29* d39d0f3acdd7 Daniel P. Berrangé:
   io: fix cleanup for TLS I/O source data on cancellation
30* 9545c059f77e Daniel P. Berrangé:
   io: fix cleanup for websock I/O source data on cancellation
31* d8e19f8042dc Peter Maydell:
   hw/net/smc91c111: Don't allow negative-length packets
32* cfda94eddb6c Halil Oktay (oblivionsage):
   block/vmdk: fix OOB read in vmdk_read_extent()
33* 6f7b0a23a6ea Antoine Damhet:
   block/curl: fix concurrent completion handling
34* 0f51f9c3420b Kevin Wolf:
   mirror: Fix missed dirty bitmap writes during startup
35* d4816177654d Dmitry Guryanov:
   block/throttle-groups: fix deadlock with iolimits and muliple iothreads
36* 544ddbb6373d Kevin Wolf:
   block: Never drop BLOCK_IO_ERROR with action=stop for rate limiting
37* 1d6610099bd7 Hanna Czenczek:
   block/nfs: Do not enter coroutine from CB
38* 235f9b36383e Dmitry Osipenko:
   virtio-gpu: Ensure BHs are invoked only from main-loop thread
39* 6595a8d5d17e Peter Maydell:
   hw/net/xilinx_ethlite: Check for oversized TX packets
40* f2813e13fe91 Bingwu Zhang:
   linux-user: Deal with mmap where start > reserved_va
41* e8e7d1f97785 Bingwu Zhang:
   bsd-user: Deal with mmap where start > reserved_va
42* c865b6bce5d0 Bingwu Zhang:
   tests/tcg/multiarch/test-mmap: Check mmaps beyond reserved_va
43* 6a1221614fd9 Andreas Schwab:
   linux-user: fix TIOCGSID ioctl
44* 550391c7134d Peter Maydell:
   hw/net/npcm_gmac: Catch accesses off the end of the register array
45* 2d877bc02a3b rail5:
   target/loongarch: Preserve PTE permission bits in LDPTE
46 db2325f79481 rail5:
   target/loongarch: Avoid recursive PNX exception on CSR_BADI fetch
47* a3fcbca0ef64 Hanna Czenczek:
   fuse: Copy write buffer content before polling
48 4f28b87fdd24 Paolo Bonzini:
   hyperv/syndbg: check length returned by cpu_physical_memory_map()

(commit(s) marked with * were in previous series and are not resent)

