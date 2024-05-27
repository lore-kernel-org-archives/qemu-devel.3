Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40400C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 08:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBVe7-000392-Tp; Mon, 27 May 2024 04:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBVc2-0000v8-3L; Mon, 27 May 2024 04:21:54 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBVbz-0000gs-VB; Mon, 27 May 2024 04:21:45 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9DDAF6A55C;
 Mon, 27 May 2024 11:22:12 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B9852D84FA;
 Mon, 27 May 2024 11:21:38 +0300 (MSK)
Received: (nullmailer pid 66349 invoked by uid 1000);
 Mon, 27 May 2024 08:21:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, "Roth,
 Michael" <Michael.Roth@amd.com>
Subject: [Stable-9.0.1 00/44] Patch Round-up for stable 9.0.1,
 freeze on 2024-06-07
Date: Mon, 27 May 2024 11:20:51 +0300
Message-Id: <qemu-stable-9.0.1-20240527112053@cover.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

The following patches are queued for QEMU stable v9.0.1:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-9.0

Patch freeze is 2024-06-07, and the release is planned for 2024-06-09:

  https://wiki.qemu.org/Planning/9.0

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 2cc637f1ea08 Li Zhijian:
   migration/colo: Fix bdrv_graph_rdlock_main_loop: Assertion 
   `!qemu_in_coroutine()' failed.
02 04f6fb897a5a Michael Tokarev:
   linux-user: do_setsockopt: fix SOL_ALG.ALG_SET_KEY
03 838f82468a12 Zhao Liu:
   docs: i386: pc: Update maximum CPU numbers for PC Q35
04 ae6d91a7e9b7 Zhu Yangyang:
   nbd/server: do not poll within a coroutine context
05 4fa333e08dd9 Eric Blake:
   nbd/server: Mark negotiation functions as coroutine_fn
06 06479dbf3d7d Li Zhijian:
   backends/cryptodev-builtin: Fix local_error leaks
07 0cbb322f70e8 Michael Tokarev:
   target/loongarch/cpu.c: typo fix: expection
08 e4426353175f Daniel Henrique Barboza:
   target/riscv/kvm: remove sneaky strerrorname_np() instance
09 7b19a3554d2d Richard Henderson:
   target/arm: Restrict translation disabled alignment check to VMSA
10 dcc5c018c7e6 Peter Maydell:
   tests/avocado: update sunxi kernel from armbian to 6.6.16
11 a88a04906b96 Thomas Huth:
   .gitlab-ci.d/cirrus.yml: Shorten the runtime of the macOS and FreeBSD jobs
12 f2c8aeb1afef Jeuk Kim:
   hw/ufs: Fix buffer overflow bug
13 4b00855f0ee2 Alexandra Diupina:
   hw/dmax/xlnx_dpdma: fix handling of address_extension descriptor fields
14 eb656a60fd93 Philippe Mathieu-Daudé:
   hw/arm/npcm7xx: Store derivative OTP fuse key in little endian
15 c365e6b07057 Philippe Mathieu-Daudé:
   target/sh4: Fix ADDV opcode
16 e88a856efd1d Philippe Mathieu-Daudé:
   target/sh4: Fix SUBV opcode
17 e096d370ad87 Philippe Mathieu-Daudé:
   plugins: Update stale comment
18 6a5a63f74ba5 Ruihan Li:
   target/i386: Give IRQs a chance when resetting HF_INHIBIT_IRQ_MASK
19 7b616f36de0b Richard Henderson:
   target/sparc: Fix FEXPAND
20 9157dccc7e71 Richard Henderson:
   target/sparc: Fix FMUL8x16
21 a859602c746b Richard Henderson:
   target/sparc: Fix FMUL8x16A{U,L}
22 be8998e046c2 Richard Henderson:
   target/sparc: Fix FMULD8*X16
23 d3ef26afde77 Richard Henderson:
   target/sparc: Fix FPMERGE
24 ca51921158e3 Richard Henderson:
   target/sh4: Update DisasContextBase.insn_start
25 54c52ec719fb Song Gao:
   hw/loongarch/virt: Fix memory leak
26 e6578f1f68a0 Mattias Nissler:
   hw/remote/vfio-user: Fix config space access byte order
27 41c685dc59bb Paolo Bonzini:
   target/i386: fix operand size for DATA16 REX.W POPCNT
28 40a3ec7b5ffd Paolo Bonzini:
   target/i386: rdpkru/wrpkru are no-prefix instructions
29 fe01af5d47d4 Paolo Bonzini:
   target/i386: fix feature dependency for WAITPKG
30 23b1f53c2c89 Paolo Bonzini:
   configure: quote -D options that are passed through to meson
31 371d60dfdb47 Thomas Huth:
   configure: Fix error message when C compiler is not working
32 37e91415018d hikalium:
   ui/gtk: Fix mouse/motion event scaling issue with GTK display backend
33 e4e62514e3cc Dongwon Kim:
   ui/gtk: Check if fence_fd is equal to or greater than 0
34 c9290dfebfdb Richard Henderson:
   tcg/loongarch64: Fill out tcg_out_{ld,st} for vector regs
35 2563be6317fa Gerd Hoffmann:
   hw/pflash: fix block write start
36 84d4b7285486 donsheng:
   target-i386: hyper-v: Correct kvm_hv_handle_exit return value
37 9710401276a0 Fiona Ebner:
   hw/core/machine: move compatibility flags for VirtIO-net USO to machine 8.1
38 07c0866103d4 Song Gao:
   target/loongarch/kvm: fpu save the vreg registers high 192bit
39 b11f9814526b Song Gao:
   hw/loongarch: Fix fdt memory node wrong 'reg'
40 6204af704a07 Jiaxun Yang:
   hw/loongarch/virt: Fix FDT memory node address width
41 bad7a2759c69 Daniel P. Berrangé:
   dockerfiles: add 'MAKE' env variable to remaining containers
42 8225bff7c5db Paolo Bonzini:
   target/i386: disable jmp_opt if EFLAGS.RF is 1
43 f0f0136abba6 Paolo Bonzini:
   target/i386: no single-step exception after MOV or POP SS
44 36fa7c686e9e Richard Henderson:
   gitlab: Update msys2-64bit runner tags

