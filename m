Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6923C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 20:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6cUm-0004dH-9O; Mon, 13 May 2024 16:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s6cUk-0004cx-3p; Mon, 13 May 2024 16:42:02 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s6cUi-0006XF-1C; Mon, 13 May 2024 16:42:01 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E34A566678;
 Mon, 13 May 2024 23:42:02 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 81EEFCE0A4;
 Mon, 13 May 2024 23:41:54 +0300 (MSK)
Received: (nullmailer pid 1013790 invoked by uid 1000);
 Mon, 13 May 2024 20:41:54 -0000
Subject: [ANNOUNCE] QEMU 8.2.4 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 May 2024 23:41:54 +0300
Message-Id: <1715632914.382233.1013785.nullmailer@tls.msk.ru>
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

The QEMU v8.2.4 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-8.2.4.tar.xz
  https://download.qemu.org/qemu-8.2.4.tar.xz.sig (signature)

v8.2.4 is now tagged in the official qemu.git repository, and the
stable-8.2 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-8.2

There are 16 changes since the previous v8.2.3 release.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-8.2-hash master-hash Author Name: Commmit-Subject):

1332b8dd43 Michael Tokarev:
 Update version for 8.2.4 release
07d46408cb e88a856efd Philippe Mathieu-Daud=C3=A9:
 target/sh4: Fix SUBV opcode
dc5390a0ca c365e6b070 Philippe Mathieu-Daud=C3=A9:
 target/sh4: Fix ADDV opcode
7b4804c965 eb656a60fd Philippe Mathieu-Daud=C3=A9:
 hw/arm/npcm7xx: Store derivative OTP fuse key in little endian
dfcbb9ef24 4b00855f0e Alexandra Diupina:
 hw/dmax/xlnx_dpdma: fix handling of address_extension descriptor fields
d5cf8bed29 f2c8aeb1af Jeuk Kim:
 hw/ufs: Fix buffer overflow bug
5479d911bc a88a04906b Thomas Huth:
 .gitlab-ci.d/cirrus.yml: Shorten the runtime of the macOS and FreeBSD jobs
5b5655fdb7 dcc5c018c7 Peter Maydell:
 tests/avocado: update sunxi kernel from armbian to 6.6.16
7e5f59326d 0cbb322f70 Michael Tokarev:
 target/loongarch/cpu.c: typo fix: expection
f6abce29cc 06479dbf3d Li Zhijian:
 backends/cryptodev-builtin: Fix local_error leaks
37751067b1 4fa333e08d Eric Blake:
 nbd/server: Mark negotiation functions as coroutine_fn
cb4c222add ae6d91a7e9 Zhu Yangyang:
 nbd/server: do not poll within a coroutine context
6fee9efc2e 04f6fb897a Michael Tokarev:
 linux-user: do_setsockopt: fix SOL_ALG.ALG_SET_KEY
55b88e61ed 2cc637f1ea Li Zhijian:
 migration/colo: Fix bdrv_graph_rdlock_main_loop: Assertion `!qemu_in_corou=
tine()' failed.
cbae108098 10f86d1b84 Daniel Henrique Barboza:
 target/riscv/kvm: change timer regs size to u64
125b95d79e 450bd6618f Daniel Henrique Barboza:
 target/riscv/kvm: change KVM_REG_RISCV_FP_D to u64
bbdcc89678 49c211ffca Daniel Henrique Barboza:
 target/riscv/kvm: change KVM_REG_RISCV_FP_F to u32

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEe3O61ovnosKJMUsicBtPaxppPlkFAmZCexIACgkQcBtPaxpp
PlkwiQgAinEkfIr7ShAXPx4L1GrE9S4HbuF4cZrtJqcbSB6XN7v+zSKeWW89iNhX
6/UDcP57ORtincZyhlqzj/MEoOFiUgpEz9pAlJn12QlDZDOFGOD7yISibCKSZVsL
OKPOOH7HB6/koUmKKXij2JAc73G95ZkGrsvPS/ThiQbh89R1wGuarmvO447lgLZx
a4tlGa70hmu3+GGPYRUT4W+TNMvUP/jLj3BHq6PlMSz0cpr/REAsG93h5Bq1axwL
8bDSw2HSX09wE4yp4AalT+ymnphZ7oh3kDniLn/DDjRXmlatSuLJADzK0Q0ksoWm
rPY9ZLDOYaNAd1z29V6k8z2gG1rKtA=3D=3D
=3DiFlq
-----END PGP SIGNATURE-----

