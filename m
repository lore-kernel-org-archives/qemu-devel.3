Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46332FCD0A7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 04:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ixD-0005QT-8Q; Wed, 18 Mar 2026 00:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w2ix8-0005Px-GU; Wed, 18 Mar 2026 00:56:18 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w2ix3-0004P2-F9; Wed, 18 Mar 2026 00:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773809762; bh=jYXjqyNAnElG5xMKDKYotLWD0u+BkLjwEjooV8ewSaA=;
 h=Subject:From:To:Cc:Date;
 b=Z+tAGXkaUqKt3FEr8ncsNmTG4Ibh4sdrnckhamV9c8au9YAlF4++aXl39e+Er2fFF
 UjfJoreyBDd3uV6vkpNF66cB5hjZS1N7eo/l2w7DLTn3xF3vK8B7g2oyrUPcZKQYew
 JMlSPPvOf49gZbksu42Z7dWxbD4yQcEw5s7z+bocvAo5s+++wAh6CeNgjNTqXfoD+Z
 Gcn0svoX09jAY8ey9YElQ4eQOIx38jb0fHwroU9yx6n9BVk8jPjxMd34RPrpPA3UVl
 MZ91EdTQJrKjckstV6Qqc0H2P+jC3xaD7mbisRV5RuD6IVziURXstKmmumrYiSkFjr
 JaOGzNhzET7EA==
Received: from think4mjt.localdomain (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by isrv.corpit.ru (Postfix) with ESMTP id 1D1CF194908;
 Wed, 18 Mar 2026 07:56:02 +0300 (MSK)
Received: by think4mjt.localdomain (Postfix, from userid 1000)
 id 7E1B513DFF6; Wed, 18 Mar 2026 07:56:08 +0300 (MSK)
Subject: [ANNOUNCE] QEMU 10.0.9 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260318045608.7E1B513DFF6@think4mjt.localdomain>
Date: Wed, 18 Mar 2026 07:56:08 +0300 (MSK)
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

Hi everyone,

The QEMU v10.0.9 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-10.0.9.tar.xz
  https://download.qemu.org/qemu-10.0.9.tar.xz.sig (signature)

v10.0.9 is now tagged in the official qemu.git repository, and the
stable-10.0 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-10.0

There are 46 changes since the previous v10.0.8 release.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-10.0-hash master-hash Author Name: Commmit-Subject):

59fa90c015 Michael Tokarev:
 Update version for 10.0.9 release
903addd92f 4f28b87fdd Paolo Bonzini:
 hyperv/syndbg: check length returned by cpu_physical_memory_map()
d7137ba31a a3fcbca0ef Hanna Czenczek:
 fuse: Copy write buffer content before polling
9c0b60fab6 db2325f794 rail5:
 target/loongarch: Avoid recursive PNX exception on CSR_BADI fetch
c380287199 2d877bc02a rail5:
 target/loongarch: Preserve PTE permission bits in LDPTE
a0e2c27ba1 550391c713 Peter Maydell:
 hw/net/npcm_gmac: Catch accesses off the end of the register array
f4ee237880 6a1221614f Andreas Schwab:
 linux-user: fix TIOCGSID ioctl
6b37b5e763 c865b6bce5 Bingwu Zhang:
 tests/tcg/multiarch/test-mmap: Check mmaps beyond reserved_va
bfc1246081 e8e7d1f977 Bingwu Zhang:
 bsd-user: Deal with mmap where start > reserved_va
5f0ed40240 f2813e13fe Bingwu Zhang:
 linux-user: Deal with mmap where start > reserved_va
3f0b4ed5b0 6595a8d5d1 Peter Maydell:
 hw/net/xilinx_ethlite: Check for oversized TX packets
0f58b60bdb 235f9b3638 Dmitry Osipenko:
 virtio-gpu: Ensure BHs are invoked only from main-loop thread
deb60fe8f5 1d6610099b Hanna Czenczek:
 block/nfs: Do not enter coroutine from CB
88fa9778d7 544ddbb637 Kevin Wolf:
 block: Never drop BLOCK_IO_ERROR with action=stop for rate limiting
8b6c82b404 d481617765 Dmitry Guryanov:
 block/throttle-groups: fix deadlock with iolimits and muliple iothreads
2e7506ed2f 0f51f9c342 Kevin Wolf:
 mirror: Fix missed dirty bitmap writes during startup
9d1e1e042f 6f7b0a23a6 Antoine Damhet:
 block/curl: fix concurrent completion handling
37ff880a12 cfda94eddb Halil Oktay (oblivionsage):
 block/vmdk: fix OOB read in vmdk_read_extent()
de94c727b3 d8e19f8042 Peter Maydell:
 hw/net/smc91c111: Don't allow negative-length packets
cf9887af19 9545c059f7 Daniel P. Berrangé:
 io: fix cleanup for websock I/O source data on cancellation
1b63062f57 d39d0f3acd Daniel P. Berrangé:
 io: fix cleanup for TLS I/O source data on cancellation
d9c46fdb86 403d3a5f4a Daniel P. Berrangé:
 io: separate freeing of tasks from marking them as complete
046dceb6b2 529e5e7643 Bernhard Beschow:
 target/i386/hvf/x86_mmu: Fix compiler warning
c25da457f6 48c8916aec Josh Poimboeuf:
 hw/i386/vmmouse: Fix hypercall clobbers
5cf57c2542 e2d4646a02 John Snow:
 tests/docker: upgrade most non-lcitool debian tests to debian 13
fc421e7f53 b72d15f47c Christian Schoenebeck:
 hw/9pfs: fix missing EOPNOTSUPP on Twstat and Trenameat for fs synth driver
1086e14378 c96f6d2398 Richie Buturla:
 hw/9pfs: fix data race in v9fs_mark_fids_unreclaim()
f66a51f58e 662fd548a0 Alex Bennée:
 target/arm: set the correct TI bits for WFIT traps
0610b05277 669683cf14 Weixie Cui:
 hw/ssi/xilinx_spips: Reset TX FIFO in reset
119df7f80d 8608ed356e Kuan-Wei Chiu:
 hw/misc/virt_ctrl: Fix incorrect trace event in read operation
c081363741 7994203bb1 Manos Pitsidianakis:
 virtio-snd: tighten read amount in in_cb
d5f91db549 bcb53328aa Manos Pitsidianakis:
 virtio-snd: fix max_size bounds check in input cb
83e9328eaa 61679d7dcf Manos Pitsidianakis:
 virtio-snd: handle 5.14.6.2 for PCM_INFO properly
9961cd8b75 34238f078a Manos Pitsidianakis:
 virtio-snd: remove TODO comments
b99e2f4b00 b2a279094c Akihiko Odaki:
 virtio-gpu-virgl: Add virtio-gpu-virgl-hostmem-region type
3ccce65acf ee5bf0962e Peter Maydell:
 target/arm: Fix feature check in DO_SVE2_RRX, DO_SVE2_RRX_TB
05271d6e00 42eab40a12 Peter Maydell:
 target/arm: Account for SME in aarch64_sve_narrow_vq() assertion
477d3254d9 c48d0471be Richard Henderson:
 target/arm: Introduce ARMCPU.sme_max_vq
88a2009671 c2c5beec42 Jamin Lin:
 hw/i2c/aspeed_i2c: Fix out-of-bounds read in I2C MMIO handlers
c8fd0885e6 e4ed74c9ae Alex Bradbury:
 docs/about/emulation: Add documentation for hotblocks plugin arguments
c46cb59808 e777f6ab91 Alex Bradbury:
 contrib/plugins/hotblocks: Print uint64_t with PRIu64 rather than PRId64
5a9c4ce21f 1c1e45fcd6 Alex Bradbury:
 contrib/plugins/hotblocks: Fix off by one error in iteration of sorted blocks
3e1f764b7e 90fabd5dda Alex Bradbury:
 contrib/plugins/hotblocks: Correctly free sorted counts list
1be22bca46 01499add2a Kohei Tokunaga:
 contrib/plugins: Fix type conflict of GLib function pointers
4a16697b62 e44a26ba94 John Snow:
 python: drop uses of pkg_resources
7af6ee465e b0353beebb Mohamed Mediouni:
 plugins: fix cross-build using LLVM for Windows targets
9c2fa4a996 00ebc44514 Jaehoon Kim:
 s390x/pci: Fix endianness for zPCI BAR values.


