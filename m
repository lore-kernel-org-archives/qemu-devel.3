Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A589FCD0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 05:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2j69-0007EX-Jw; Wed, 18 Mar 2026 01:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w2j67-0007ED-K4; Wed, 18 Mar 2026 01:05:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w2j64-0001d6-LH; Wed, 18 Mar 2026 01:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773810322; bh=hsR9QmynP+YZQ3ZtugYJni5zflUjUiwitj1wiRxI6o8=;
 h=Subject:From:To:Cc:Date;
 b=J1kt4ifHsXQKgzL2w7dqGHygrZC/ShCHkghEUOpWxRYdanQ3c4+sp9CfACsT8NbNE
 EZCczEnDCeEW2sYkLmQJCyiiJXWZsriYDlTNHbr3fY8Okx5W1fnhciv9MeQmoQuiAN
 YVlXcg528QwR7HDxImfH1TIKA2rjtL+eh0iBzVlMPblw9CgesdRgXQcBcZEMv3oOWA
 qDpn+go70AOyp7aji+yAWXgGscLLzcQei8tLbQfvZbonTe4WGHgRK5WDTDOwNx1EJA
 6UmAhBUPSsbv6H2HtpyTQCWdxoGctFWoRQCsx2ssrKbEjWBcGRGMYkVlZn/tKt14lh
 rHyGjBjW5TeZw==
Received: from think4mjt.localdomain (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by isrv.corpit.ru (Postfix) with ESMTP id 738DF194914;
 Wed, 18 Mar 2026 08:05:22 +0300 (MSK)
Received: by think4mjt.localdomain (Postfix, from userid 1000)
 id 815C313DFF7; Wed, 18 Mar 2026 07:56:08 +0300 (MSK)
Subject: [ANNOUNCE] QEMU 10.1.5 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260318045608.815C313DFF7@think4mjt.localdomain>
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

The QEMU v10.1.5 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-10.1.5.tar.xz
  https://download.qemu.org/qemu-10.1.5.tar.xz.sig (signature)

v10.1.5 is now tagged in the official qemu.git repository, and the
stable-10.1 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-10.1

There are 48 changes since the previous v10.1.4 release.

v10.0.5 is supposed to be the last release in 10.1.x series.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-10.1-hash master-hash Author Name: Commmit-Subject):

29e39cbdfe Michael Tokarev:
 Update version for 10.1.5 release
82600ca407 4f28b87fdd Paolo Bonzini:
 hyperv/syndbg: check length returned by cpu_physical_memory_map()
561ddd82ea a3fcbca0ef Hanna Czenczek:
 fuse: Copy write buffer content before polling
730e6cb554 db2325f794 rail5:
 target/loongarch: Avoid recursive PNX exception on CSR_BADI fetch
3a7b0cd6a6 2d877bc02a rail5:
 target/loongarch: Preserve PTE permission bits in LDPTE
92a24cdbcc 550391c713 Peter Maydell:
 hw/net/npcm_gmac: Catch accesses off the end of the register array
3308cb1fce 6a1221614f Andreas Schwab:
 linux-user: fix TIOCGSID ioctl
aa3b7cc939 c865b6bce5 Bingwu Zhang:
 tests/tcg/multiarch/test-mmap: Check mmaps beyond reserved_va
99dbd039e0 e8e7d1f977 Bingwu Zhang:
 bsd-user: Deal with mmap where start > reserved_va
58c5c5ea2b f2813e13fe Bingwu Zhang:
 linux-user: Deal with mmap where start > reserved_va
42215ee624 6595a8d5d1 Peter Maydell:
 hw/net/xilinx_ethlite: Check for oversized TX packets
071884b988 235f9b3638 Dmitry Osipenko:
 virtio-gpu: Ensure BHs are invoked only from main-loop thread
2c91665828 1d6610099b Hanna Czenczek:
 block/nfs: Do not enter coroutine from CB
66bfa88bfc 544ddbb637 Kevin Wolf:
 block: Never drop BLOCK_IO_ERROR with action=stop for rate limiting
ec1411defe d481617765 Dmitry Guryanov:
 block/throttle-groups: fix deadlock with iolimits and muliple iothreads
14bd27514a 0f51f9c342 Kevin Wolf:
 mirror: Fix missed dirty bitmap writes during startup
98bad9ea1f 6f7b0a23a6 Antoine Damhet:
 block/curl: fix concurrent completion handling
387cbad145 cfda94eddb Halil Oktay (oblivionsage):
 block/vmdk: fix OOB read in vmdk_read_extent()
8edd9d82a2 d8e19f8042 Peter Maydell:
 hw/net/smc91c111: Don't allow negative-length packets
580ead9cdf 9545c059f7 Daniel P. Berrangé:
 io: fix cleanup for websock I/O source data on cancellation
5151109103 d39d0f3acd Daniel P. Berrangé:
 io: fix cleanup for TLS I/O source data on cancellation
874b1271cb 163cd0ae11 Daniel P. Berrangé:
 io: separate freeing of tasks from marking them as complete
4d5f1c39e3 529e5e7643 Bernhard Beschow:
 target/i386/hvf/x86_mmu: Fix compiler warning
1cdbb79a7b c86bca1671 Bernhard Beschow:
 target/i386/emulate/x86_decode: Fix compiler warning
0936d9a09c 48c8916aec Josh Poimboeuf:
 hw/i386/vmmouse: Fix hypercall clobbers
1c35cde690 b72d15f47c Christian Schoenebeck:
 hw/9pfs: fix missing EOPNOTSUPP on Twstat and Trenameat for fs synth driver
815a59c509 c96f6d2398 Richie Buturla:
 hw/9pfs: fix data race in v9fs_mark_fids_unreclaim()
a9045a734d 662fd548a0 Alex Bennée:
 target/arm: set the correct TI bits for WFIT traps
f0dc5d0905 669683cf14 Weixie Cui:
 hw/ssi/xilinx_spips: Reset TX FIFO in reset
5cdca29f2a 8608ed356e Kuan-Wei Chiu:
 hw/misc/virt_ctrl: Fix incorrect trace event in read operation
f26c7b05a6 7994203bb1 Manos Pitsidianakis:
 virtio-snd: tighten read amount in in_cb
4e6f36d190 bcb53328aa Manos Pitsidianakis:
 virtio-snd: fix max_size bounds check in input cb
e55b8cd5f7 61679d7dcf Manos Pitsidianakis:
 virtio-snd: handle 5.14.6.2 for PCM_INFO properly
7c545ca9e9 34238f078a Manos Pitsidianakis:
 virtio-snd: remove TODO comments
fbf071b77d b2a279094c Akihiko Odaki:
 virtio-gpu-virgl: Add virtio-gpu-virgl-hostmem-region type
cfe35fe60a aeb3c147fc Peter Maydell:
 target/arm: Don't let 'sme=on' downgrade SME
d94bdff3f0 433097a224 Peter Maydell:
 target/arm/tcg: Allow SVE RAX1 in SME2p1 streaming mode
0556e548fa ee5bf0962e Peter Maydell:
 target/arm: Fix feature check in DO_SVE2_RRX, DO_SVE2_RRX_TB
785f81c489 42eab40a12 Peter Maydell:
 target/arm: Account for SME in aarch64_sve_narrow_vq() assertion
0673ca8eeb c2c5beec42 Jamin Lin:
 hw/i2c/aspeed_i2c: Fix out-of-bounds read in I2C MMIO handlers
5dea7447f6 e4ed74c9ae Alex Bradbury:
 docs/about/emulation: Add documentation for hotblocks plugin arguments
16bf2b128a e777f6ab91 Alex Bradbury:
 contrib/plugins/hotblocks: Print uint64_t with PRIu64 rather than PRId64
b1b6d7a426 1c1e45fcd6 Alex Bradbury:
 contrib/plugins/hotblocks: Fix off by one error in iteration of sorted blocks
1d6ad5e8eb 90fabd5dda Alex Bradbury:
 contrib/plugins/hotblocks: Correctly free sorted counts list
2f4c5e98f9 e44a26ba94 John Snow:
 python: drop uses of pkg_resources
827593a8f8 267d7ae99a Fiona Ebner:
 iotests: test active mirror with unaligned, small write zeroes op
dbc5f5cccb 4a7b1bd18d Fiona Ebner:
 block/mirror: check range when setting zero bitmap for sync write
054916f838 b0353beebb Mohamed Mediouni:
 plugins: fix cross-build using LLVM for Windows targets
b0a19c6a06 00ebc44514 Jaehoon Kim:
 s390x/pci: Fix endianness for zPCI BAR values.


