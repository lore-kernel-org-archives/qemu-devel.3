Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE007C07E8E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzgZj-0000oA-OF; Wed, 24 Apr 2024 13:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rzgZe-0000ni-Hu; Wed, 24 Apr 2024 13:38:28 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rzgZc-0003pd-28; Wed, 24 Apr 2024 13:38:26 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0BA6761822;
 Wed, 24 Apr 2024 20:38:28 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 849C4BE619;
 Wed, 24 Apr 2024 20:38:20 +0300 (MSK)
Received: (nullmailer pid 1218037 invoked by uid 1000);
 Wed, 24 Apr 2024 17:38:15 -0000
Subject: [ANNOUNCE] QEMU 7.2.11 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Date: Wed, 24 Apr 2024 20:38:15 +0300
Message-Id: <1713980295.669157.1218032.nullmailer@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi everyone,

The QEMU v7.2.11 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-7.2.11.tar.xz
  https://download.qemu.org/qemu-7.2.11.tar.xz.sig (signature)

v7.2.11 is now tagged in the official qemu.git repository, and the
stable-7.2 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-7.2

There are 59 changes since the previous v7.2.10 release.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-7.2-hash master-hash Author Name: Commmit-Subject):

c6fe0f315c Michael Tokarev:
 Update version for 7.2.11 release
ab4a60c1b7 c4f91d7b7b Harsh Prateek Bora:
 ppc/spapr: Initialize max_cpus limit to SPAPR_IRQ_NR_IPIS.
3f481e3305 2df5c1f5b0 Harsh Prateek Bora:
 ppc/spapr: Introduce SPAPR_IRQ_NR_IPIS to refer IRQ range for CPU IPIs.
4741ae6b8e b754cb2dcd Zack Buhman:
 target/sh4: add missing CHECK_NOT_DELAY_SLOT
2429cb7a9f 9e4b27ca6b Philippe Mathieu-Daudé:
 hw/sd/sdhci: Do not update TRNMOD when Command Inhibit (DAT) is set
f3130798d4 a45223467e Philippe Mathieu-Daudé:
 hw/net/lan9118: Replace magic '2048' value by MIL_TXFIFO_SIZE definition
cd7beea4a4 ad766d603f Philippe Mathieu-Daudé:
 hw/net/lan9118: Fix overflow in MIL TX FIFO
734314d8ce eaf2bd2953 Philippe Mathieu-Daudé:
 backends/cryptodev: Do not abort for invalid session ID
9b7bc39890 fc09ff2979 Philippe Mathieu-Daudé:
 hw/misc/applesmc: Fix memory leak in reset() handler
8394be7faa d39fdfff34 Philippe Mathieu-Daudé:
 hw/block/nand: Fix out-of-bound access in NAND block buffer
9ca7801c6a 2e3e09b368 Philippe Mathieu-Daudé:
 hw/block/nand: Have blk_load() take unsigned offset and return boolean
caeb4489b7 7a86544f28 Philippe Mathieu-Daudé:
 hw/block/nand: Factor nand_load_iolen() method out
d5c41e4491 aa88f99c87 Yuquan Wang:
 qemu-options: Fix CXL Fixed Memory Window interleave-granularity typo
7aaf5f7778 f4729ec39a Philippe Mathieu-Daudé:
 hw/virtio/virtio-crypto: Protect from DMA re-entrancy bugs
e7c2df3fd7 b4295bff25 Philippe Mathieu-Daudé:
 hw/char/virtio-serial-bus: Protect from DMA re-entrancy bugs
6d37a30815 ba28e0ff4d Philippe Mathieu-Daudé:
 hw/display/virtio-gpu: Protect from DMA re-entrancy bugs
e070e5e674 ec0504b989 Philippe Mathieu-Daudé:
 hw/virtio: Introduce virtio_bh_new_guarded() helper
d6e7ec1f8e f0907ff4ca Richard Henderson:
 linux-user: Fix waitid return of siginfo_t and rusage
b198998b7f e25fe886b8 Richard Henderson:
 tcg/optimize: Do not attempt to constant fold neg_vec
fd01f5a847 2d9a31b3c2 Wafer:
 hw/virtio: Fix packed virtqueue flush used_idx
227d9450b5 4c54f5bc8e Yajun Wu:
 hw/net/virtio-net: fix qemu set used ring flag even vhost started
393b7ab067 44e25fbc19 Peter Maydell:
 hw/intc/arm_gicv3: ICC_HPPIR* return SPURIOUS if int group is disabled
eebb7fb506 1d2f2b35bc Michael Tokarev:
 gitlab-ci/cirrus: switch from 'master' to 'latest'
6fca92c9d1 4a3aa11e1f Richard Henderson:
 target/hppa: Clear psw_n for BE on use_nullify_skip path
162c54b7c1 2911e9b95f Richard Henderson:
 tcg/optimize: Fix sign_mask for logical right-shift
493b1cc785 1c188fc8cb Akihiko Odaki:
 virtio-net: Fix vhost virtqueue notifiers for RSS
70b0e142e6 a158c63b3b Yao Xingtao:
 monitor/hmp-cmds-target: Append a space in error message in gpa2hva()
2e1645ac6a 7c7a9f578e Lorenz Brun:
 hw/scsi/scsi-generic: Fix io_timeout property not applying
610db167da 1590154ee4 Song Gao:
 target/loongarch: Fix qemu-system-loongarch64 assert failed with the option '-d int'
e9e41446c2 7fd226b047 Tao Su:
 target/i386: Revert monitor_puts() in do_inject_x86_mce()
a6fc9a234b 2cc68629a6 Paolo Bonzini:
 target/i386: fix direction of "32-bit MMU" test
ad003650d5 90f641531c Paolo Bonzini:
 target/i386: use separate MMU indexes for 32-bit accesses
6332f3c12f 5f97afe254 Paolo Bonzini:
 target/i386: introduce function to query MMU indices
e4b23890b3 55f7c6a5f2 Peter Maydell:
 tests: Raise timeouts for bufferiszero and crypto-tlscredsx509
9405029750 63b18312d1 Kevin Wolf:
 tests/unit: Bump test-replication timeout to 60 seconds
4f048b771d e1b363e328 Thomas Huth:
 tests/unit: Bump test-crypto-block test timeout to 5 minutes
dcb9a64d22 c45f8f1aef Thomas Huth:
 tests/unit: Bump test-aio-multithread test timeout to 2 minutes
e1e9d74f57 2e128776dc Cédric Le Goater:
 migration: Skip only empty block devices
04b3d34d5c 74e2845c5f Jonathan Cameron:
 hmat acpi: Fix out of bounds access due to missing use of indirection
309051ac40 6081b4243c Akihiko Odaki:
 pcie_sriov: Validate NumVFs
3f7892be24 91bb64a8d2 Akihiko Odaki:
 hw/nvme: Use pcie_sriov_num_vfs()
e00b062da7 31180dbdca Akihiko Odaki:
 pcie: Introduce pcie_sriov_num_vfs
0b7ccfd1d2 fa905f65c5 Klaus Jensen:
 hw/nvme: add machine compatibility parameter to enable msix exclusive bar
6a5d6849d1 ee7bda4d38 Klaus Jensen:
 hw/nvme: generalize the mbar size helper
424e6209e5 4f0a4a3d58 Minwoo Im:
 hw/nvme: separate 'serial' property for VFs
5c3889be15 973f76cf77 Klaus Jensen:
 hw/nvme: cleanup error reporting in nvme_init_pci()
201c9701f5 784fd35387 Klaus Jensen:
 hw/nvme: clean up confusing use of errp/local_err
edb47553b0 6a5287ce80 Nick Briggs:
 Avoid unaligned fetch in ladr_match()
df052d6c1c 4cadf10234 Laurent Vivier:
 e1000e: fix link state on resume
f1efd85486 9bc9e95119 Michael Tokarev:
 make-release: switch to .xz format by default
eeb5699176 9876359990 Sven Schnelle:
 hw/scsi/lsi53c895a: add timer to scripts processing
275436de62 8b09b7fe47 Sven Schnelle:
 hw/scsi/lsi53c895a: add missing decrement of reentrancy counter
c57a6fca39 a9198b3132 Sven Schnelle:
 hw/scsi/lsi53c895a: stop script on phase mismatch
e55ec34d3e 012b170173 Dmitrii Gavrilov:
 system/qdev-monitor: move drain_call_rcu call under if (!dev) in qmp_device_add()
ce252563f2 fd7f95f23d Peter Maydell:
 hw/rtc/sun4v-rtc: Relicense to GPLv2-or-later
518c3dfdfb 1f51573f79 Richard Henderson:
 target/arm: Fix SME full tile indexing
13cf40e594 3dc2afeab2 Peter Maydell:
 tests/tcg/aarch64/sysregs.c: Use S syntax for id_aa64zfr0_el1 and id_aa64smfr0_el1
4002b76c1c bc6bd20ee3 Zhuojia Shen:
 target/arm: align exposed ID registers with Linux
331c0fa584 f5af80271a David Parsons:
 ui/cocoa: Fix window clipping on macOS 14
aba89ef725 9ea920dc28 Daniel P. Berrangé:
 gitlab: update FreeBSD Cirrus CI image to 13.3

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEe3O61ovnosKJMUsicBtPaxppPlkFAmYpQ4cACgkQcBtPaxpp
Pll8kAf+MeKgCUxiFH6bZlQJsPocdQxZ75INmg2RUCmcw0VDNflUMbbwb801Giqu
MA/00HcdrErszg1saAVxv+HPdY7ErLZm5eC6IeUDJKvuS+T4TxYrPB+bFX60Q5Dr
5XuQgJrAhDnXrPXq59XOYP9Pt8fU27khi8WXE7razOms4mwZuBC/gM8sYT+Jqmfi
XI+JUJoOeEel4SwjtldHbR34G5AOub8In/4DALh4+LPoIZkMBXGN4Ndbvt83CoSr
95lke9+hzT5HYLtws3MlTkYxTNj4pIeCX6gsOiiSxRhEMjuglcDneGaDBpOJR5z1
s00pQVsQ6Smusz25LPJaGAxOwLV8yw==
=gNMO
-----END PGP SIGNATURE-----

