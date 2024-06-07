Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CF3C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 22:32:59 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFf1V-0007vc-HT; Fri, 07 Jun 2024 15:13:13 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf1T-0007ue-IY; Fri, 07 Jun 2024 15:13:11 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf1R-0001j5-Ku; Fri, 07 Jun 2024 15:13:11 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C67266E53C;
 Fri,  7 Jun 2024 22:14:02 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id F1DA7E2739;
 Fri,  7 Jun 2024 22:13:07 +0300 (MSK)
Received: (nullmailer pid 528685 invoked by uid 1000);
 Fri, 07 Jun 2024 19:13:07 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, "Roth,
 Michael" <Michael.Roth@amd.com>
Subject: [Stable-8.2.5 00/45] Patch Round-up for stable 8.2.5,
 frozen on 2024-06-07
Date: Fri,  7 Jun 2024 22:12:39 +0300
Message-Id: <qemu-stable-8.2.5-20240607221227@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v8.2.5:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-8.2

Patch freeze is 2024-06-07 (frozen), and the release is planned for 2024-06-09:

  https://wiki.qemu.org/Planning/8.2

Please respond here or CC qemu-stable@nongnu.org for any additional notes
about the planned release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* 6a5a63f74ba5 Ruihan Li:
   target/i386: Give IRQs a chance when resetting HF_INHIBIT_IRQ_MASK
02* 7b616f36de0b Richard Henderson:
   target/sparc: Fix FEXPAND
03* 9157dccc7e71 Richard Henderson:
   target/sparc: Fix FMUL8x16
04* 54c52ec719fb Song Gao:
   hw/loongarch/virt: Fix memory leak
05* e6578f1f68a0 Mattias Nissler:
   hw/remote/vfio-user: Fix config space access byte order
06* 41c685dc59bb Paolo Bonzini:
   target/i386: fix operand size for DATA16 REX.W POPCNT
07* 40a3ec7b5ffd Paolo Bonzini:
   target/i386: rdpkru/wrpkru are no-prefix instructions
08* fe01af5d47d4 Paolo Bonzini:
   target/i386: fix feature dependency for WAITPKG
09* 23b1f53c2c89 Paolo Bonzini:
   configure: quote -D options that are passed through to meson
10* 371d60dfdb47 Thomas Huth:
   configure: Fix error message when C compiler is not working
11* 37e91415018d hikalium:
   ui/gtk: Fix mouse/motion event scaling issue with GTK display backend
12* e4e62514e3cc Dongwon Kim:
   ui/gtk: Check if fence_fd is equal to or greater than 0
13* c9290dfebfdb Richard Henderson:
   tcg/loongarch64: Fill out tcg_out_{ld,st} for vector regs
14* 84d4b7285486 donsheng:
   target-i386: hyper-v: Correct kvm_hv_handle_exit return value
15* 9710401276a0 Fiona Ebner:
   hw/core/machine: move compatibility flags for VirtIO-net USO to machine 
   8.1
16* b11f9814526b Song Gao:
   hw/loongarch: Fix fdt memory node wrong 'reg'
17* 6204af704a07 Jiaxun Yang:
   hw/loongarch/virt: Fix FDT memory node address width
18* 8225bff7c5db Paolo Bonzini:
   target/i386: disable jmp_opt if EFLAGS.RF is 1
19* f0f0136abba6 Paolo Bonzini:
   target/i386: no single-step exception after MOV or POP SS
20 36fa7c686e9e Richard Henderson:
   gitlab: Update msys2-64bit runner tags
21* bad7a2759c69 Daniel P. Berrangé:
   dockerfiles: add 'MAKE' env variable to remaining containers
22 c53f7a107879 Daniel P. Berrangé:
   gitlab: use $MAKE instead of 'make'
23 b563959b906d Daniel P. Berrangé:
   gitlab: use 'setarch -R' to workaround tsan bug
24 19ed42e8adc8 Zenghui Yu:
   hvf: arm: Fix encodings for ID_AA64PFR1_EL1 and debug System registers
25 daafa78b2972 Andrey Shumilin:
   hw/intc/arm_gic: Fix handling of NS view of GICC_APR<n>
26 daf9748ac002 Marcin Juszkiewicz:
   target/arm: Disable SVE extensions when SVE is disabled
27 199e84de1c90 Eric Blake:
   qio: Inherit follow_coroutine_ctx across TLS
28 a73c99378022 Eric Blake:
   iotests: test NBD+TLS+iothread
29 c76b121840c6 yang.zhang:
   hw/intc/riscv_aplic: APLICs should add child earlier than realize
30 1215d45b2aa9 Daniel Henrique Barboza:
   target/riscv/kvm: tolerate KVM disable ext errors
31 75115d880c6d Huang Tao:
   target/riscv: Fix the element agnostic function problem
32 ff33b7a9699e Yangyu Chen:
   target/riscv/cpu.c: fix Zvkb extension config
33 17b713c0806e Max Chou:
   target/riscv: rvv: Fix Zvfhmin checking for vfwcvt.f.f.v and vfncvt.f.f.w 
   instructions
34 7a999d4dd704 Max Chou:
   target/riscv: rvv: Check single width operator for vector fp widen 
   instructions
35 692f33a3abca Max Chou:
   target/riscv: rvv: Check single width operator for vfncvt.rod.f.f.w
36 93cb52b7a3cc Max Chou:
   target/riscv: rvv: Remove redudant SEW checking for vector fp 
   narrow/widen instructions
37 68e7c86927af Daniel Henrique Barboza:
   target/riscv: prioritize pmp errors in raise_mmu_exception()
38 6c9a34424713 Alexei Filippov:
   target/riscv: do not set mtval2 for non guest-page faults
39 c5eb8d633674 Alistair Francis:
   target/riscv: rvzicbo: Fixup CBO extension register calculation
40 190b867f28cb Yong-Xuan Wang:
   target/riscv/kvm.c: Fix the hart bit setting of AIA
41 915758c537b5 Alistair Francis:
   disas/riscv: Decode all of the pmpcfg and pmpaddr CSRs
42 7604bbc2d87d Paolo Bonzini:
   target/i386: fix xsave.flat from kvm-unit-tests
43 da7c95920d02 Xinyu Li:
   target/i386: fix SSE and SSE2 feature check
44 2e701e6785cd Bernhard Beschow:
   ui/sdl2: Allow host to power down screen
45 78f932ea1f7b lanyanzhi:
   target/loongarch: fix a wrong print in cpu dump

(commit(s) marked with * were in previous series and are not resent)

