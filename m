Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96153FCD0AA
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 04:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ixB-0005QP-Ed; Wed, 18 Mar 2026 00:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w2ix8-0005Pp-Az; Wed, 18 Mar 2026 00:56:18 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w2ix3-0004P3-F9; Wed, 18 Mar 2026 00:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773809762; bh=5QDJkDSdT5hTcB062Ake5ZdqvaVs08oV1CiKUE5BbEM=;
 h=Subject:From:To:Cc:Date;
 b=pau4YsWVv8eOMdiw121pMnSMuxtQHvzldbhVff370ObaIsyHZOV98iiDUedK1HW+A
 jLjn20rTOQMkckBx94dtR2irJs5Fj5YAljtfNb2HQKtOErdMxE3GBPJ/yK/Zrk8DDg
 0TEArE91Zk/r2WX1d2qb+Z2a5/p45jX49niV+O8TF+f058AaJNSjWP0gJHtoWwRnc+
 N+l2IIqHo7+IhW24Twax9Lq8/3O4X4m0Y+NMC/1KoA5DJ9FtxdcjQGiKO/1MY3gAhh
 hBWfsaZS2WBJttOy77+3NPi4B9Kb9efd1AqmTt2foPdZekn/Ndfm2BPr/Sv4vJI5Ib
 2Q4pXaA8Jw60g==
Received: from think4mjt.localdomain (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by isrv.corpit.ru (Postfix) with ESMTP id 1D41A194909;
 Wed, 18 Mar 2026 07:56:02 +0300 (MSK)
Received: by think4mjt.localdomain (Postfix, from userid 1000)
 id 8332313DFF9; Wed, 18 Mar 2026 07:56:08 +0300 (MSK)
Subject: [ANNOUNCE] QEMU 10.2.2 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260318045608.8332313DFF9@think4mjt.localdomain>
Date: Wed, 18 Mar 2026 07:56:08 +0300 (MSK)
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, MIME_QP_LONG_LINE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The QEMU v10.2.2 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-10.2.2.tar.xz
  https://download.qemu.org/qemu-10.2.2.tar.xz.sig (signature)

v10.2.2 is now tagged in the official qemu.git repository, and the
stable-10.2 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-10.2

There are 55 changes since the previous v10.2.1 release.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-10.2-hash master-hash Author Name: Commmit-Subject):

f8ed81651e Michael Tokarev:
 Update version for 10.2.2 release
0103b23cb7 1b80f1009d Fiona Ebner:
 target/i386: add compat for migrating error code
85af4e9370 4f28b87fdd Paolo Bonzini:
 hyperv/syndbg: check length returned by cpu_physical_memory_map()
3e7e7cf05a a3fcbca0ef Hanna Czenczek:
 fuse: Copy write buffer content before polling
8b3b97dae5 2d877bc02a rail5:
 target/loongarch: Preserve PTE permission bits in LDPTE
477d1f3c59 db2325f794 rail5:
 target/loongarch: Avoid recursive PNX exception on CSR_BADI fetch
f07f64c3d8 1e3e1d51e2 Peter Maydell:
 hw: Make qdev_get_printable_name() consistently return freeable string
a69152d257 550391c713 Peter Maydell:
 hw/net/npcm_gmac: Catch accesses off the end of the register array
6f6bdf3763 6a1221614f Andreas Schwab:
 linux-user: fix TIOCGSID ioctl
2481744d96 c865b6bce5 Bingwu Zhang:
 tests/tcg/multiarch/test-mmap: Check mmaps beyond reserved_va
ed18bbbc11 e8e7d1f977 Bingwu Zhang:
 bsd-user: Deal with mmap where start > reserved_va
82d83d29bd f2813e13fe Bingwu Zhang:
 linux-user: Deal with mmap where start > reserved_va
d9dfd5f425 6595a8d5d1 Peter Maydell:
 hw/net/xilinx_ethlite: Check for oversized TX packets
0c5199e52b 235f9b3638 Dmitry Osipenko:
 virtio-gpu: Ensure BHs are invoked only from main-loop thread
a40b3f664c 961fcc0f22 Jens Axboe:
 fdmon-io_uring: check CQ ring directly in gsource_check
f9b1537744 2ae361ef1d Jens Axboe:
 aio-posix: notify main loop when SQEs are queued
8b851e5bb1 1d6610099b Hanna Czenczek:
 block/nfs: Do not enter coroutine from CB
ca8b13eb04 544ddbb637 Kevin Wolf:
 block: Never drop BLOCK_IO_ERROR with action=stop for rate limiting
43e60c88f1 d481617765 Dmitry Guryanov:
 block/throttle-groups: fix deadlock with iolimits and muliple iothreads
61f14858c1 0f51f9c342 Kevin Wolf:
 mirror: Fix missed dirty bitmap writes during startup
11589707ec 6f7b0a23a6 Antoine Damhet:
 block/curl: fix concurrent completion handling
86b5130fef cfda94eddb Halil Oktay (oblivionsage):
 block/vmdk: fix OOB read in vmdk_read_extent()
52cb65f9a6 d8e19f8042 Peter Maydell:
 hw/net/smc91c111: Don't allow negative-length packets
e944f36993 9545c059f7 Daniel P. Berrangé:
 io: fix cleanup for websock I/O source data on cancellation
f8943633a9 d39d0f3acd Daniel P. Berrangé:
 io: fix cleanup for TLS I/O source data on cancellation
68e031345a 163cd0ae11 Daniel P. Berrangé:
 io: separate freeing of tasks from marking them as complete
0deef85292 78c6b6010c Peter Maydell:
 target/ppc/translate: Fix TCG debug assert translating CLRBWIBC
438b752c76 1b93832f55 Bernhard Beschow:
 target/i386/emulate/x86_decode: Actually use stream in decode_instruction_stream()
32c1fc948e 529e5e7643 Bernhard Beschow:
 target/i386/hvf/x86_mmu: Fix compiler warning
17ec370a79 c86bca1671 Bernhard Beschow:
 target/i386/emulate/x86_decode: Fix compiler warning
7426a375bc 48c8916aec Josh Poimboeuf:
 hw/i386/vmmouse: Fix hypercall clobbers
f577bc677f b72d15f47c Christian Schoenebeck:
 hw/9pfs: fix missing EOPNOTSUPP on Twstat and Trenameat for fs synth driver
cdafefe5ae c96f6d2398 Richie Buturla:
 hw/9pfs: fix data race in v9fs_mark_fids_unreclaim()
b0560afef6 662fd548a0 Alex Bennée:
 target/arm: set the correct TI bits for WFIT traps
7e64af6463 669683cf14 Weixie Cui:
 hw/ssi/xilinx_spips: Reset TX FIFO in reset
dc9f0565a2 8608ed356e Kuan-Wei Chiu:
 hw/misc/virt_ctrl: Fix incorrect trace event in read operation
2989865251 7994203bb1 Manos Pitsidianakis:
 virtio-snd: tighten read amount in in_cb
a730f98a7a bcb53328aa Manos Pitsidianakis:
 virtio-snd: fix max_size bounds check in input cb
d84fbf241d 61679d7dcf Manos Pitsidianakis:
 virtio-snd: handle 5.14.6.2 for PCM_INFO properly
421123a691 34238f078a Manos Pitsidianakis:
 virtio-snd: remove TODO comments
f402cbe224 b2a279094c Akihiko Odaki:
 virtio-gpu-virgl: Add virtio-gpu-virgl-hostmem-region type
22687ae317 16786eb7bf Helge Deller:
 hw/hppa: Add BMC on 64-bit machines only
5fc003f542 aeb3c147fc Peter Maydell:
 target/arm: Don't let 'sme=on' downgrade SME
aeaff51f58 433097a224 Peter Maydell:
 target/arm/tcg: Allow SVE RAX1 in SME2p1 streaming mode
aa9c49d19e ee5bf0962e Peter Maydell:
 target/arm: Fix feature check in DO_SVE2_RRX, DO_SVE2_RRX_TB
188b8070ce 42eab40a12 Peter Maydell:
 target/arm: Account for SME in aarch64_sve_narrow_vq() assertion
0e311e683f c2c5beec42 Jamin Lin:
 hw/i2c/aspeed_i2c: Fix out-of-bounds read in I2C MMIO handlers
713e807357 e4ed74c9ae Alex Bradbury:
 docs/about/emulation: Add documentation for hotblocks plugin arguments
cb327d638f e777f6ab91 Alex Bradbury:
 contrib/plugins/hotblocks: Print uint64_t with PRIu64 rather than PRId64
8532740333 1c1e45fcd6 Alex Bradbury:
 contrib/plugins/hotblocks: Fix off by one error in iteration of sorted blocks
2729113a79 90fabd5dda Alex Bradbury:
 contrib/plugins/hotblocks: Correctly free sorted counts list
6500ee3d5a e44a26ba94 John Snow:
 python: drop uses of pkg_resources
641cb36c07 267d7ae99a Fiona Ebner:
 iotests: test active mirror with unaligned, small write zeroes op
8d2f7ef7c0 4a7b1bd18d Fiona Ebner:
 block/mirror: check range when setting zero bitmap for sync write
24690bf836 b0353beebb Mohamed Mediouni:
 plugins: fix cross-build using LLVM for Windows targets
2cfc92842a 00ebc44514 Jaehoon Kim:
 s390x/pci: Fix endianness for zPCI BAR values.


