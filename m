Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C6DC47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 19:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUX4S-0003w3-5M; Mon, 29 Jan 2024 14:13:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rUX4M-0003tx-9m; Mon, 29 Jan 2024 14:13:22 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rUX4J-0001J1-UP; Mon, 29 Jan 2024 14:13:21 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 64842486A8;
 Mon, 29 Jan 2024 22:14:10 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1B4FB6E5BD;
 Mon, 29 Jan 2024 22:13:17 +0300 (MSK)
Received: (nullmailer pid 1285726 invoked by uid 1000);
 Mon, 29 Jan 2024 19:13:16 -0000
Subject: [ANNOUNCE] QEMU 8.1.5 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Date: Mon, 29 Jan 2024 22:13:16 +0300
Message-Id: <1706555596.897651.1285720.nullmailer@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The QEMU v8.1.5 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-8.1.5.tar.xz
  https://download.qemu.org/qemu-8.1.5.tar.xz.sig (signature)

v8.1.5 is now tagged in the official qemu.git repository, and the
stable-8.1 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-8.1?ref_type=heads

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-8.1-hash master-hash Author Name: Commmit-Subject):

20a1b341a0 Michael Tokarev:
 Update version for 8.1.5 release
ccdb4cc209 6fffc83785 Peter Maydell:
 target/arm: Fix A64 scalar SQSHRN and SQRSHRN
b86fa3a4f2 604927e357 Max Filippov:
 target/xtensa: fix OOB TLB entry access
d24dd10143 e8a12fe31f Daniel P. Berrangé:
 qtest: bump aspeed_smc-test timeout to 6 minutes
4b02c718b5 effd60c878 Stefan Hajnoczi:
 monitor: only run coroutine commands in qemu_aio_context
2f5e27eefa 9ee2dd4c22 Stefan Hajnoczi:
 iotests: port 141 to Python for reliable QMP testing
03bc938fbf da62b507a2 Stefan Hajnoczi:
 iotests: add filter_qmp_generated_node_ids()
23a512f418 a9c8ea9547 Ari Sundholm:
 block/blklogwrites: Fix a bug when logging "write zeroes" operations.
dd1d3c8c29 2220e8189f Jason Wang:
 virtio-net: correctly copy vnet header when flushing TX
c173670033 9f6523e8e4 Joseph Burt:
 tcg/arm: Fix SIGILL in tcg_out_qemu_st_direct
76a9da39d4 8a9be79924 Fiona Ebner:
 block/io: clear BDRV_BLOCK_RECURSE flag after recursing in bdrv_co_block_status
4b06bb5826 Paolo Bonzini:
 accel/tcg: Revert mapping of PCREL translation block to multiple virtual addresses
25ff741fe8 b16a45bc5e Alex Bennée:
 readthodocs: fully specify a build environment
72694a69c9 c2d7de557d Mark Cave-Ayland:
 hw/scsi/esp-pci: set DMA_STAT_BCMBLT when BLAST command issued
01db312e3b 1e8e6644e0 Mark Cave-Ayland:
 hw/scsi/esp-pci: synchronise setting of DMA_STAT_DONE with ESP completion interrupt
e8cb126075 6b41417d93 Mark Cave-Ayland:
 hw/scsi/esp-pci: generate PCI interrupt from separate ESP and PCI sources
2cd67d013d 84a6835e00 Mark Cave-Ayland:
 hw/scsi/esp-pci: use correct address register for PCI DMA transfers
2472f8467d 44ce1b5d2f Nick Briggs:
 migration/rdma: define htonll/ntohll only if not predefined
fcc79f2e09 284a7ee2e2 Gerd Hoffmann:
 hw/pflash: implement update buffer for block writes
dd25df302e 5dd58358a5 Gerd Hoffmann:
 hw/pflash: use ldn_{be,le}_p and stn_{be,le}_p
d83b0f64aa 3b14a555fd Gerd Hoffmann:
 hw/pflash: refactor pflash_data_write()
a8988972cd 484aecf2d3 Philippe Mathieu-Daudé:
 backends/cryptodev: Do not ignore throttle/backends Errors
7b03b125ee 729ba8e933 Paolo Bonzini:
 target/i386: pcrel: store low bits of physical address in data[0]
5707858602 2926eab896 guoguangyao:
 target/i386: fix incorrect EIP in PC-relative translation blocks
99e32260ac a58506b748 Richard Henderson:
 target/i386: Do not re-compute new pc with CF_PCREL
357b599028 410c2a4d75 Anastasia Belova:
 load_elf: fix iterator's type for elf file processing
d6488e5186 52a21689cd Peter Maydell:
 .gitlab-ci.d/buildtest.yml: Work around htags bug when environment is large
5e190ed415 e358a25a97 Ilya Leoshkevich:
 target/s390x: Fix LAE setting a wrong access register
f62b55da87 c98873ee4a Samuel Tardieu:
 tests/qtest/virtio-ccw: Fix device presence checking
074b769c0b 1d513e06d9 Natanael Copa:
 util: fix build with musl libc on ppc64le
6eb6bca73f 82a65e3188 Peter Maydell:
 hw/intc/arm_gicv3_cpuif: handle LPIs in in the list registers
97d3be7bca 4ad87cd4b2 Michael Tokarev:
 chardev/char.c: fix "abstract device type" error message
03382b91cb 5cb0e7abe1 Xu Lu:
 target/riscv: Fix mcycle/minstret increment behavior
6c5dda7850 25145a7d77 Pavel Pisa:
 hw/net/can/sja1000: fix bug for single acceptance filter and standard frame
60472f719c bb6e2511eb Kevin Wolf:
 iotests: Basic tests for internal snapshots
4c8315ad50 5a7f21efaf Kevin Wolf:
 vl: Improve error message for conflicting -incoming and -loadvm
-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEe3O61ovnosKJMUsicBtPaxppPlkFAmW3+MwACgkQcBtPaxpp
Plka0Qf7BMlmjRn6lUkNgBryTf8TPWLmDKQo1VF/wUCmSKQuBpwCjr8Xr5rJ9RlS
J7k1W3xaKMH3JUFO9/apigsRUWW+KuLGevu51yFEpXUwfBKJe+uOu3gA3ilG5cs7
RDkcQ+IgeahaELZYZx7IkNGotr1Hn94FGdbJrXsc2o6Uw/FSqzVLgvtvUdp+qKGu
+0CsYSI67x6SnjMNvyyIJQMFRDdWZB+YIyWgXyYI5UweXTpdXKpsKlyqDJj0BNRB
jSKRfiFBDWwi3F3qWRmQFYmkmW8ajvrq6CWdkWdY7coE13QBbE8nH+j0clq0SXLG
GPeLwDDkNIU1t1/6Y35Zr0JfhffZeg==
=KXwl
-----END PGP SIGNATURE-----

