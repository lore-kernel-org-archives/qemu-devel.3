Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E7EC25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 04:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGtMG-0002JQ-9r; Tue, 11 Jun 2024 00:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sGtME-0002Ig-Bi; Tue, 11 Jun 2024 00:43:42 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sGtMC-00011e-1r; Tue, 11 Jun 2024 00:43:41 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2F5A16F40A;
 Tue, 11 Jun 2024 07:44:36 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1444CE4D06;
 Tue, 11 Jun 2024 07:43:35 +0300 (MSK)
Received: (nullmailer pid 1238387 invoked by uid 1000);
 Tue, 11 Jun 2024 04:43:31 -0000
Subject: [ANNOUNCE] QEMU 7.2.12 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Jun 2024 07:43:31 +0300
Message-Id: <1718081011.770468.1238382.nullmailer@tls.msk.ru>
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

The QEMU v7.2.12 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-7.2.12.tar.xz
  https://download.qemu.org/qemu-7.2.12.tar.xz.sig (signature)

v7.2.12 is now tagged in the official qemu.git repository, and the
stable-7.2 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-7.2

There are 29 changes since the previous v7.2.11 release.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-7.2-hash master-hash Author Name: Commmit-Subject):

f48ba9b085 Michael Tokarev:
 Update version for 7.2.12 release
6f62fc9ff3 78f932ea1f lanyanzhi:
 target/loongarch: fix a wrong print in cpu dump
61687b3b43 2e701e6785 Bernhard Beschow:
 ui/sdl2: Allow host to power down screen
082940a5a1 da7c95920d Xinyu Li:
 target/i386: fix SSE and SSE2 feature check
9aca1a84de 7604bbc2d8 Paolo Bonzini:
 target/i386: fix xsave.flat from kvm-unit-tests
81ca6c2c9b 915758c537 Alistair Francis:
 disas/riscv: Decode all of the pmpcfg and pmpaddr CSRs
b73e3712a3 c76b121840 yang.zhang:
 hw/intc/riscv_aplic: APLICs should add child earlier than realize
e08fbea661 daf9748ac0 Marcin Juszkiewicz:
 target/arm: Disable SVE extensions when SVE is disabled
eed21e9574 daafa78b29 Andrey Shumilin:
 hw/intc/arm_gic: Fix handling of NS view of GICC_APR<n>
c6fe98fe79 19ed42e8ad Zenghui Yu:
 hvf: arm: Fix encodings for ID_AA64PFR1_EL1 and debug System registers
07f686009f 36fa7c686e Richard Henderson:
 gitlab: Update msys2-64bit runner tags
f417712ef1 f0f0136abb Paolo Bonzini:
 target/i386: no single-step exception after MOV or POP SS
9abcd968e7 8225bff7c5 Paolo Bonzini:
 target/i386: disable jmp_opt if EFLAGS.RF is 1
ddc13a3c42 84d4b72854 donsheng:
 target-i386: hyper-v: Correct kvm_hv_handle_exit return value
5ec422a958 e4e62514e3 Dongwon Kim:
 ui/gtk: Check if fence_fd is equal to or greater than 0
659835d24b 37e9141501 hikalium:
 ui/gtk: Fix mouse/motion event scaling issue with GTK display backend
e6000bd7c7 40a3ec7b5f Paolo Bonzini:
 target/i386: rdpkru/wrpkru are no-prefix instructions
76b96c053f 41c685dc59 Paolo Bonzini:
 target/i386: fix operand size for DATA16 REX.W POPCNT
2b8be9cffb e6578f1f68 Mattias Nissler:
 hw/remote/vfio-user: Fix config space access byte order
41e052fc05 6a5a63f74b Ruihan Li:
 target/i386: Give IRQs a chance when resetting HF_INHIBIT_IRQ_MASK
2e3e5138d6 eb656a60fd Philippe Mathieu-Daud=C3=A9:
 hw/arm/npcm7xx: Store derivative OTP fuse key in little endian
a004dfabea 4b00855f0e Alexandra Diupina:
 hw/dmax/xlnx_dpdma: fix handling of address_extension descriptor fields
9a005e30f5 a88a04906b Thomas Huth:
 .gitlab-ci.d/cirrus.yml: Shorten the runtime of the macOS and FreeBSD jobs
e00c9b4758 dcc5c018c7 Peter Maydell:
 tests/avocado: update sunxi kernel from armbian to 6.6.16
39a0961d0a 06479dbf3d Li Zhijian:
 backends/cryptodev-builtin: Fix local_error leaks
f7b46e82ce 4fa333e08d Eric Blake:
 nbd/server: Mark negotiation functions as coroutine_fn
a0823c2766 ae6d91a7e9 Zhu Yangyang:
 nbd/server: do not poll within a coroutine context
51cc8762a0 04f6fb897a Michael Tokarev:
 linux-user: do_setsockopt: fix SOL_ALG.ALG_SET_KEY
6ea6863f21 7bc1286b81 Palmer Dabbelt:
 gitlab/opensbi: Move to docker:stable
861fca8ce0 690ceb7193 Philippe Mathieu-Daud=C3=A9:
 gitlab-ci: Remove job building EDK2 firmware binaries

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEe3O61ovnosKJMUsicBtPaxppPlkFAmZn1fMACgkQcBtPaxpp
PlkL/wf/f6KAhQKrxLJu0e76xxMzJrTDTmXW3wHKq3K9blOamBfohNAEIc6d0Haf
HQj02beu+Nw1KvnHRdr0ycXU3KkJyywpC1BivohZCmS2uLgEdIXkfcMiZfBlcKdb
5amLWMXFUz1Agbq3Ks9FIbPv6SdmMgsq/wbQlwJX0cpQhIvxuuj+8U9FBH5el2Hp
THF5As0+1vMJVxk3G5ZihdjsG+Pv36zcwJsOPQpqg/exalicSkKUfFfsaoXlsmVG
FUqds548p40tSVGPmdVhIyRwMEEBWYPO8lAcz9pcy9Kosy6l7QcjLqTDJb08on06
hZYlU9zRkcW6ZTYvEfeIKulbnqpFwA=3D=3D
=3DVJj7
-----END PGP SIGNATURE-----

