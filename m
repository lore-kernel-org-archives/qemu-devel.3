Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE61EC41513
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 04:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGtMj-0002Nj-P7; Tue, 11 Jun 2024 00:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sGtMh-0002Mn-JV; Tue, 11 Jun 2024 00:44:11 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sGtMf-00017N-H2; Tue, 11 Jun 2024 00:44:11 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E6A146F40B;
 Tue, 11 Jun 2024 07:45:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E15BBE4D07;
 Tue, 11 Jun 2024 07:44:07 +0300 (MSK)
Received: (nullmailer pid 1238610 invoked by uid 1000);
 Tue, 11 Jun 2024 04:44:07 -0000
Subject: [ANNOUNCE] QEMU 8.2.5 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Jun 2024 07:44:07 +0300
Message-Id: <1718081047.648425.1238605.nullmailer@tls.msk.ru>
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

The QEMU v8.2.5 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-8.2.5.tar.xz
  https://download.qemu.org/qemu-8.2.5.tar.xz.sig (signature)

v8.2.5 is now tagged in the official qemu.git repository, and the
stable-8.2 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-8.2

There are 45 changes since the previous v8.2.4 release.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-8.2-hash master-hash Author Name: Commmit-Subject):

909772f0a5 Michael Tokarev:
 Update version for 8.2.5 release
6feae1d0dd 78f932ea1f lanyanzhi:
 target/loongarch: fix a wrong print in cpu dump
af008b379c 2e701e6785 Bernhard Beschow:
 ui/sdl2: Allow host to power down screen
276ec925a7 da7c95920d Xinyu Li:
 target/i386: fix SSE and SSE2 feature check
d84afebcee 7604bbc2d8 Paolo Bonzini:
 target/i386: fix xsave.flat from kvm-unit-tests
2891807479 915758c537 Alistair Francis:
 disas/riscv: Decode all of the pmpcfg and pmpaddr CSRs
ae5edeb084 190b867f28 Yong-Xuan Wang:
 target/riscv/kvm.c: Fix the hart bit setting of AIA
935be461eb c5eb8d6336 Alistair Francis:
 target/riscv: rvzicbo: Fixup CBO extension register calculation
37d6c6e495 6c9a344247 Alexei Filippov:
 target/riscv: do not set mtval2 for non guest-page faults
6da92af4f9 68e7c86927 Daniel Henrique Barboza:
 target/riscv: prioritize pmp errors in raise_mmu_exception()
0f9578497c 93cb52b7a3 Max Chou:
 target/riscv: rvv: Remove redudant SEW checking for vector fp narrow/widen=
 instructions
c4173e4caf 692f33a3ab Max Chou:
 target/riscv: rvv: Check single width operator for vfncvt.rod.f.f.w
d813f356ad 7a999d4dd7 Max Chou:
 target/riscv: rvv: Check single width operator for vector fp widen instruc=
tions
749907f857 17b713c080 Max Chou:
 target/riscv: rvv: Fix Zvfhmin checking for vfwcvt.f.f.v and vfncvt.f.f.w =
instructions
4cba687b86 ff33b7a969 Yangyu Chen:
 target/riscv/cpu.c: fix Zvkb extension config
ec182b1045 75115d880c Huang Tao:
 target/riscv: Fix the element agnostic function problem
cf7143fdb7 1215d45b2a Daniel Henrique Barboza:
 target/riscv/kvm: tolerate KVM disable ext errors
cd1228a80e c76b121840 yang.zhang:
 hw/intc/riscv_aplic: APLICs should add child earlier than realize
b9b2f3bbab a73c993780 Eric Blake:
 iotests: test NBD+TLS+iothread
9a6143a73e 199e84de1c Eric Blake:
 qio: Inherit follow_coroutine_ctx across TLS
71c7036b18 daf9748ac0 Marcin Juszkiewicz:
 target/arm: Disable SVE extensions when SVE is disabled
3f470980b4 daafa78b29 Andrey Shumilin:
 hw/intc/arm_gic: Fix handling of NS view of GICC_APR<n>
0970313b05 19ed42e8ad Zenghui Yu:
 hvf: arm: Fix encodings for ID_AA64PFR1_EL1 and debug System registers
8965709b86 b563959b90 Daniel P. Berrang=C3=A9:
 gitlab: use 'setarch -R' to workaround tsan bug
3b36dd0005 c53f7a1078 Daniel P. Berrang=C3=A9:
 gitlab: use $MAKE instead of 'make'
fc88204b82 bad7a2759c Daniel P. Berrang=C3=A9:
 dockerfiles: add 'MAKE' env variable to remaining containers
ca0799624e 36fa7c686e Richard Henderson:
 gitlab: Update msys2-64bit runner tags
52031d6be5 f0f0136abb Paolo Bonzini:
 target/i386: no single-step exception after MOV or POP SS
c6171d524d 8225bff7c5 Paolo Bonzini:
 target/i386: disable jmp_opt if EFLAGS.RF is 1
93fa768d40 6204af704a Jiaxun Yang:
 hw/loongarch/virt: Fix FDT memory node address width
d679c82488 b11f981452 Song Gao:
 hw/loongarch: Fix fdt memory node wrong 'reg'
e3a2aa9542 9710401276 Fiona Ebner:
 hw/core/machine: move compatibility flags for VirtIO-net USO to machine 8.1
9b98ab7d3d 84d4b72854 donsheng:
 target-i386: hyper-v: Correct kvm_hv_handle_exit return value
90e023f2bc c9290dfebf Richard Henderson:
 tcg/loongarch64: Fill out tcg_out_{ld,st} for vector regs
355527b646 e4e62514e3 Dongwon Kim:
 ui/gtk: Check if fence_fd is equal to or greater than 0
f44d2398d8 37e9141501 hikalium:
 ui/gtk: Fix mouse/motion event scaling issue with GTK display backend
05bfa963df 371d60dfdb Thomas Huth:
 configure: Fix error message when C compiler is not working
19a931f207 23b1f53c2c Paolo Bonzini:
 configure: quote -D options that are passed through to meson
2b95625643 fe01af5d47 Paolo Bonzini:
 target/i386: fix feature dependency for WAITPKG
1cc3cb96b8 40a3ec7b5f Paolo Bonzini:
 target/i386: rdpkru/wrpkru are no-prefix instructions
eb761b4ee5 41c685dc59 Paolo Bonzini:
 target/i386: fix operand size for DATA16 REX.W POPCNT
7d7b770bde e6578f1f68 Mattias Nissler:
 hw/remote/vfio-user: Fix config space access byte order
7dbebba4a5 54c52ec719 Song Gao:
 hw/loongarch/virt: Fix memory leak
819f92ec3e 9157dccc7e Richard Henderson:
 target/sparc: Fix FMUL8x16
d3da3d02a0 7b616f36de Richard Henderson:
 target/sparc: Fix FEXPAND
50ed4f856a 6a5a63f74b Ruihan Li:
 target/i386: Give IRQs a chance when resetting HF_INHIBIT_IRQ_MASK

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEe3O61ovnosKJMUsicBtPaxppPlkFAmZn1hcACgkQcBtPaxpp
PlkVpgf/cUOCAQ/6jSrAc9zV7vdQizE0m5YG1sNssjRfxwSTnQGjKrkAyOolvYtQ
17OBw2elu8DeLGtGaFLiA84r6cXLLxoreG29DL/YbMe9MOcACyEfsEsRevuigcY4
r03rgl5cu+HMENxInqc/nlrW8eyAD66SoP83LWEKP9107lGjOkiyKVb83DUSmAum
8MJSMK7TE1AhejfIAq28ER+kuTLim6buDteN2FVE97Q+NbNn/3vaNIiooPSE4FSw
hxhKaEGLwAsUMhuRyEw6Sk7IcbcIHJW75AsNtFSfKdQITE61JDjrpTkDDE49KNrX
SHm/6nP+whGy0oQN/pyvfFpwwgJgmw=3D=3D
=3Dyf/9
-----END PGP SIGNATURE-----

