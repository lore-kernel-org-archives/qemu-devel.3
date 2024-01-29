Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F096AC47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 19:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUX3D-0002LG-HD; Mon, 29 Jan 2024 14:12:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rUX38-0002HW-9V; Mon, 29 Jan 2024 14:12:06 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rUX36-0000tb-6W; Mon, 29 Jan 2024 14:12:06 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8B89E486A3;
 Mon, 29 Jan 2024 22:12:46 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 31CC76E5BC;
 Mon, 29 Jan 2024 22:11:53 +0300 (MSK)
Received: (nullmailer pid 1285601 invoked by uid 1000);
 Mon, 29 Jan 2024 19:11:53 -0000
Subject: [ANNOUNCE] QEMU 7.2.9 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Date: Mon, 29 Jan 2024 22:11:53 +0300
Message-Id: <1706555513.022507.1285596.nullmailer@tls.msk.ru>
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

The QEMU v7.2.9 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-7.2.9.tar.xz
  https://download.qemu.org/qemu-7.2.9.tar.xz.sig (signature)

v7.2.9 is now tagged in the official qemu.git repository, and the
stable-7.2 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-7.2?ref_type=heads

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-7.2-hash master-hash Author Name: Commmit-Subject):

0c918cb0ab Michael Tokarev:
 Update version for 7.2.9 release
ecc23c6e95 604927e357 Max Filippov:
 target/xtensa: fix OOB TLB entry access
fa020ef10b e8a12fe31f Daniel P. Berrangé:
 qtest: bump aspeed_smc-test timeout to 6 minutes
8ec90598e9 effd60c878 Stefan Hajnoczi:
 monitor: only run coroutine commands in qemu_aio_context
219cea653e 9ee2dd4c22 Stefan Hajnoczi:
 iotests: port 141 to Python for reliable QMP testing
3b53bfd4c8 da62b507a2 Stefan Hajnoczi:
 iotests: add filter_qmp_generated_node_ids()
e9eb53c5fe a9c8ea9547 Ari Sundholm:
 block/blklogwrites: Fix a bug when logging "write zeroes" operations.
415f21c723 2220e8189f Jason Wang:
 virtio-net: correctly copy vnet header when flushing TX
06e11b7589 8a9be79924 Fiona Ebner:
 block/io: clear BDRV_BLOCK_RECURSE flag after recursing in bdrv_co_block_status
b67924a048 Paolo Bonzini:
 accel/tcg: Revert mapping of PCREL translation block to multiple virtual addresses
024e8945fa b16a45bc5e Alex Bennée:
 readthodocs: fully specify a build environment
7837d7e31d c2d7de557d Mark Cave-Ayland:
 hw/scsi/esp-pci: set DMA_STAT_BCMBLT when BLAST command issued
5bdc6b9571 1e8e6644e0 Mark Cave-Ayland:
 hw/scsi/esp-pci: synchronise setting of DMA_STAT_DONE with ESP completion interrupt
fd4e677c79 6b41417d93 Mark Cave-Ayland:
 hw/scsi/esp-pci: generate PCI interrupt from separate ESP and PCI sources
528496a5d4 84a6835e00 Mark Cave-Ayland:
 hw/scsi/esp-pci: use correct address register for PCI DMA transfers
16f6a650a8 284a7ee2e2 Gerd Hoffmann:
 hw/pflash: implement update buffer for block writes
d56cc9b5e5 5dd58358a5 Gerd Hoffmann:
 hw/pflash: use ldn_{be,le}_p and stn_{be,le}_p
06679ac8b5 3b14a555fd Gerd Hoffmann:
 hw/pflash: refactor pflash_data_write()
a290e43f58 729ba8e933 Paolo Bonzini:
 target/i386: pcrel: store low bits of physical address in data[0]
7d6aebaec5 2926eab896 guoguangyao:
 target/i386: fix incorrect EIP in PC-relative translation blocks
6abbb26bbc a58506b748 Richard Henderson:
 target/i386: Do not re-compute new pc with CF_PCREL
15e207b9ed b5e0d5d22f Richard Henderson:
 target/i386: Fix 32-bit wrapping of pc/eip computation
2ad4ebb350 410c2a4d75 Anastasia Belova:
 load_elf: fix iterator's type for elf file processing
c59ce9fef6 52a21689cd Peter Maydell:
 .gitlab-ci.d/buildtest.yml: Work around htags bug when environment is large
9222f3ee43 e358a25a97 Ilya Leoshkevich:
 target/s390x: Fix LAE setting a wrong access register
dbf80fdef8 82a65e3188 Peter Maydell:
 hw/intc/arm_gicv3_cpuif: handle LPIs in in the list registers
c0a2b77dd8 4ad87cd4b2 Michael Tokarev:
 chardev/char.c: fix "abstract device type" error message
0eab8d42e1 5cb0e7abe1 Xu Lu:
 target/riscv: Fix mcycle/minstret increment behavior
c6f64736de bb6e2511eb Kevin Wolf:
 iotests: Basic tests for internal snapshots
ad24078e3f 5a7f21efaf Kevin Wolf:
 vl: Improve error message for conflicting -incoming and -loadvm
-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEe3O61ovnosKJMUsicBtPaxppPlkFAmW3+HkACgkQcBtPaxpp
PlkWwQf/QeSrH0caRZC7NsPAENZtQxVbR8Dkn1swhqWz5RSmJvFhxMTpWTZb3EyV
0Pp3uhgYqr1gX01dJ6+SJcEHBKbwh43SJlSiz1oN2odJL4yozTQruD5d7rsjQHAX
23i+R9y7C1/D/Z2BO9r9NBMr56ugIMMVTq5tdgyjM1qHJOw6X+bcSGzBLIFku/Lm
oDraL5/ciKKRn3FxcVMjgNF2X0jbx0JSEKCUuSNSHfOg/hH1IpRN+xjKJYzY0C47
+vE0wLyzb+mIM8m9acwOgIvubskqyBTaIac34EUmWTwzPtGELn4i2cecHwaV0c4J
4+JiACMe5PPn8vDqDfPVpIVAgT3Rjw==
=tA+Y
-----END PGP SIGNATURE-----

