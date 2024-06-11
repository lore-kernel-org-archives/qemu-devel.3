Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3ABEC25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 04:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGtMp-0002Qr-Sa; Tue, 11 Jun 2024 00:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sGtMn-0002QE-UW; Tue, 11 Jun 2024 00:44:17 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sGtMl-00018s-Bo; Tue, 11 Jun 2024 00:44:17 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B99A76F40C;
 Tue, 11 Jun 2024 07:45:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B4A4AE4D08;
 Tue, 11 Jun 2024 07:44:13 +0300 (MSK)
Received: (nullmailer pid 1238763 invoked by uid 1000);
 Tue, 11 Jun 2024 04:44:13 -0000
Subject: [ANNOUNCE] QEMU 9.0.1 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Jun 2024 07:44:13 +0300
Message-Id: <1718081053.366429.1238758.nullmailer@tls.msk.ru>
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

The QEMU v9.0.1 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-9.0.1.tar.xz
  https://download.qemu.org/qemu-9.0.1.tar.xz.sig (signature)

v9.0.1 is now tagged in the official qemu.git repository, and the
stable-9.0 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-9.0

There are 71 changes since the previous v9.0.0 release.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-9.0-hash master-hash Author Name: Commmit-Subject):

60b4f3aff4 Michael Tokarev:
 Update version for 9.0.1 release
2d673c3cdc 78f932ea1f lanyanzhi:
 target/loongarch: fix a wrong print in cpu dump
453a7c4f9b 2e701e6785 Bernhard Beschow:
 ui/sdl2: Allow host to power down screen
3fe67740ca 40a23ef643 Marc-Andr=C3=A9 Lureau:
 virtio-gpu: fix v2 migration
e44389b0ac da7c95920d Xinyu Li:
 target/i386: fix SSE and SSE2 feature check
0ab2229daa 7604bbc2d8 Paolo Bonzini:
 target/i386: fix xsave.flat from kvm-unit-tests
9075bc0bdd 915758c537 Alistair Francis:
 disas/riscv: Decode all of the pmpcfg and pmpaddr CSRs
8746327f4b 583edc4efb Daniel Henrique Barboza:
 riscv, gdbstub.c: fix reg_width in ricsv_gen_dynamic_vector_feature()
e532fdb0eb 190b867f28 Yong-Xuan Wang:
 target/riscv/kvm.c: Fix the hart bit setting of AIA
fb1be88084 c5eb8d6336 Alistair Francis:
 target/riscv: rvzicbo: Fixup CBO extension register calculation
a58758c5df 6c9a344247 Alexei Filippov:
 target/riscv: do not set mtval2 for non guest-page faults
ab2d6e7412 68e7c86927 Daniel Henrique Barboza:
 target/riscv: prioritize pmp errors in raise_mmu_exception()
3ee5f0e313 93cb52b7a3 Max Chou:
 target/riscv: rvv: Remove redudant SEW checking for vector fp narrow/widen=
 instructions
9f9cd6b7f9 692f33a3ab Max Chou:
 target/riscv: rvv: Check single width operator for vfncvt.rod.f.f.w
a0ea75e019 7a999d4dd7 Max Chou:
 target/riscv: rvv: Check single width operator for vector fp widen instruc=
tions
f3bea9603b 17b713c080 Max Chou:
 target/riscv: rvv: Fix Zvfhmin checking for vfwcvt.f.f.v and vfncvt.f.f.w =
instructions
3f4ab4b158 ff33b7a969 Yangyu Chen:
 target/riscv/cpu.c: fix Zvkb extension config
af1e2cdc57 75115d880c Huang Tao:
 target/riscv: Fix the element agnostic function problem
2dcc48b38b 1215d45b2a Daniel Henrique Barboza:
 target/riscv/kvm: tolerate KVM disable ext errors
2ae8e12964 86997772fa Andrew Jones:
 target/riscv/kvm: Fix exposure of Zkr
8d664e5bc2 c76b121840 yang.zhang:
 hw/intc/riscv_aplic: APLICs should add child earlier than realize
f7ddff7d5b a73c993780 Eric Blake:
 iotests: test NBD+TLS+iothread
a15989d89b 199e84de1c Eric Blake:
 qio: Inherit follow_coroutine_ctx across TLS
1c8a740fad daf9748ac0 Marcin Juszkiewicz:
 target/arm: Disable SVE extensions when SVE is disabled
65b44e55e4 daafa78b29 Andrey Shumilin:
 hw/intc/arm_gic: Fix handling of NS view of GICC_APR<n>
68af25cd8e 19ed42e8ad Zenghui Yu:
 hvf: arm: Fix encodings for ID_AA64PFR1_EL1 and debug System registers
6df1431678 b563959b90 Daniel P. Berrang=C3=A9:
 gitlab: use 'setarch -R' to workaround tsan bug
d488e255be c53f7a1078 Daniel P. Berrang=C3=A9:
 gitlab: use $MAKE instead of 'make'
8fe634f851 bad7a2759c Daniel P. Berrang=C3=A9:
 dockerfiles: add 'MAKE' env variable to remaining containers
fd4afd5a77 36fa7c686e Richard Henderson:
 gitlab: Update msys2-64bit runner tags
2cd8deb0d9 f0f0136abb Paolo Bonzini:
 target/i386: no single-step exception after MOV or POP SS
89ed6d4b6c 8225bff7c5 Paolo Bonzini:
 target/i386: disable jmp_opt if EFLAGS.RF is 1
0854469050 6204af704a Jiaxun Yang:
 hw/loongarch/virt: Fix FDT memory node address width
16b1ecee52 b11f981452 Song Gao:
 hw/loongarch: Fix fdt memory node wrong 'reg'
d27df7187b 07c0866103 Song Gao:
 target/loongarch/kvm: fpu save the vreg registers high 192bit
41558f42b3 9710401276 Fiona Ebner:
 hw/core/machine: move compatibility flags for VirtIO-net USO to machine 8.1
285cef5c39 84d4b72854 donsheng:
 target-i386: hyper-v: Correct kvm_hv_handle_exit return value
2569dec929 2563be6317 Gerd Hoffmann:
 hw/pflash: fix block write start
2965ecc487 c9290dfebf Richard Henderson:
 tcg/loongarch64: Fill out tcg_out_{ld,st} for vector regs
bbfe1d4e8b e4e62514e3 Dongwon Kim:
 ui/gtk: Check if fence_fd is equal to or greater than 0
ba27e71976 37e9141501 hikalium:
 ui/gtk: Fix mouse/motion event scaling issue with GTK display backend
33a17bcbaf 371d60dfdb Thomas Huth:
 configure: Fix error message when C compiler is not working
52d96ce37d 23b1f53c2c Paolo Bonzini:
 configure: quote -D options that are passed through to meson
6cb4afc418 fe01af5d47 Paolo Bonzini:
 target/i386: fix feature dependency for WAITPKG
1e5c6ceb27 40a3ec7b5f Paolo Bonzini:
 target/i386: rdpkru/wrpkru are no-prefix instructions
08eb23e4c9 41c685dc59 Paolo Bonzini:
 target/i386: fix operand size for DATA16 REX.W POPCNT
230b5c968e e6578f1f68 Mattias Nissler:
 hw/remote/vfio-user: Fix config space access byte order
d92179b57e 54c52ec719 Song Gao:
 hw/loongarch/virt: Fix memory leak
f6d315ffdf ca51921158 Richard Henderson:
 target/sh4: Update DisasContextBase.insn_start
6466cf4131 d3ef26afde Richard Henderson:
 target/sparc: Fix FPMERGE
b7f629b431 be8998e046 Richard Henderson:
 target/sparc: Fix FMULD8*X16
098f10e9a8 a859602c74 Richard Henderson:
 target/sparc: Fix FMUL8x16A{U,L}
6d027e1bf9 9157dccc7e Richard Henderson:
 target/sparc: Fix FMUL8x16
63a58450a6 7b616f36de Richard Henderson:
 target/sparc: Fix FEXPAND
97ffb29998 6a5a63f74b Ruihan Li:
 target/i386: Give IRQs a chance when resetting HF_INHIBIT_IRQ_MASK
1974871416 e096d370ad Philippe Mathieu-Daud=C3=A9:
 plugins: Update stale comment
30e8861a90 e88a856efd Philippe Mathieu-Daud=C3=A9:
 target/sh4: Fix SUBV opcode
ea86652019 c365e6b070 Philippe Mathieu-Daud=C3=A9:
 target/sh4: Fix ADDV opcode
380703d6a9 eb656a60fd Philippe Mathieu-Daud=C3=A9:
 hw/arm/npcm7xx: Store derivative OTP fuse key in little endian
64378d92df 4b00855f0e Alexandra Diupina:
 hw/dmax/xlnx_dpdma: fix handling of address_extension descriptor fields
1b6e140cd8 f2c8aeb1af Jeuk Kim:
 hw/ufs: Fix buffer overflow bug
0909194edd a88a04906b Thomas Huth:
 .gitlab-ci.d/cirrus.yml: Shorten the runtime of the macOS and FreeBSD jobs
7b50963603 dcc5c018c7 Peter Maydell:
 tests/avocado: update sunxi kernel from armbian to 6.6.16
dde9f0f0b7 7b19a3554d Richard Henderson:
 target/arm: Restrict translation disabled alignment check to VMSA
f90bf4c154 e442635317 Daniel Henrique Barboza:
 target/riscv/kvm: remove sneaky strerrorname_np() instance
068cbf9b94 0cbb322f70 Michael Tokarev:
 target/loongarch/cpu.c: typo fix: expection
b789fae749 06479dbf3d Li Zhijian:
 backends/cryptodev-builtin: Fix local_error leaks
9ae59100b8 4fa333e08d Eric Blake:
 nbd/server: Mark negotiation functions as coroutine_fn
304dc04347 ae6d91a7e9 Zhu Yangyang:
 nbd/server: do not poll within a coroutine context
d6cdc6b29a 838f82468a Zhao Liu:
 docs: i386: pc: Update maximum CPU numbers for PC Q35
2a7c0a16a9 04f6fb897a Michael Tokarev:
 linux-user: do_setsockopt: fix SOL_ALG.ALG_SET_KEY
5433bb5186 2cc637f1ea Li Zhijian:
 migration/colo: Fix bdrv_graph_rdlock_main_loop: Assertion `!qemu_in_corou=
tine()' failed.

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEe3O61ovnosKJMUsicBtPaxppPlkFAmZn1h0ACgkQcBtPaxpp
PlmXqAgAvRgqdOR7iAVLLnVuRQDB7OF028GF0gcktQfQcAra1hzwUCOaJdWnKAy1
0AaETwSpvgf+lLiW+V8TJZgdgG4bDSnYVYcYsTv4cdrQQRoPT2PcO0y3wXXhc5+9
/8nLiSV2iYzGSWHc/fgl7yCJs6tsP7zoAoVA/kGjp1do70/LgvwR1CKS3BRid6e3
W9BiLDSE7od43U5wy0aEjDrZ0xdDndUvVZuUtJKQKiGSx7yEFqotCq7QZY+nnSwj
RvjsDxrUz640r4EEUOrFvMjjyUOQ6JwOZ0PT1SBuRaMRiXHuGSQ7lOrQDilLK9l+
SJt/XbFCa5qUoNjldjDaEw9GwjAPaQ=3D=3D
=3D/+uW
-----END PGP SIGNATURE-----

