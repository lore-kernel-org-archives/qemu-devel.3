Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B469C27C53
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 00:08:48 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFf0x-0004PY-W7; Fri, 07 Jun 2024 15:12:41 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf0s-0004Oq-Gj; Fri, 07 Jun 2024 15:12:34 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf0q-0001dz-6j; Fri, 07 Jun 2024 15:12:34 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9235A6E52D;
 Fri,  7 Jun 2024 22:13:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C23D9E272D;
 Fri,  7 Jun 2024 22:12:19 +0300 (MSK)
Received: (nullmailer pid 528227 invoked by uid 1000);
 Fri, 07 Jun 2024 19:12:19 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.12 00/29] Patch Round-up for stable 7.2.12,
 frozen at 2024-06-07
Date: Fri,  7 Jun 2024 22:12:02 +0300
Message-Id: <qemu-stable-7.2.12-20240607221018@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v7.2.12:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-7.2

Patch freeze is 2024-06-07 (frozen), and the release is planned for 2024-06-09:

  https://wiki.qemu.org/Planning/7.2

Please respond here or CC qemu-stable@nongnu.org on any additional notes
about the planning release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* 690ceb71936f Philippe Mathieu-Daudé:
   gitlab-ci: Remove job building EDK2 firmware binaries
02* 7bc1286b81d4 Palmer Dabbelt:
   gitlab/opensbi: Move to docker:stable
03* 04f6fb897a5a Michael Tokarev:
   linux-user: do_setsockopt: fix SOL_ALG.ALG_SET_KEY
04* ae6d91a7e9b7 Zhu Yangyang:
   nbd/server: do not poll within a coroutine context
05* 4fa333e08dd9 Eric Blake:
   nbd/server: Mark negotiation functions as coroutine_fn
06* 06479dbf3d7d Li Zhijian:
   backends/cryptodev-builtin: Fix local_error leaks
07* dcc5c018c7e6 Peter Maydell:
   tests/avocado: update sunxi kernel from armbian to 6.6.16
08* a88a04906b96 Thomas Huth:
   .gitlab-ci.d/cirrus.yml: Shorten the runtime of the macOS and FreeBSD jobs
09* 4b00855f0ee2 Alexandra Diupina:
   hw/dmax/xlnx_dpdma: fix handling of address_extension descriptor fields
10* eb656a60fd93 Philippe Mathieu-Daudé:
   hw/arm/npcm7xx: Store derivative OTP fuse key in little endian
11* 6a5a63f74ba5 Ruihan Li:
   target/i386: Give IRQs a chance when resetting HF_INHIBIT_IRQ_MASK
12* e6578f1f68a0 Mattias Nissler:
   hw/remote/vfio-user: Fix config space access byte order
13* 41c685dc59bb Paolo Bonzini:
   target/i386: fix operand size for DATA16 REX.W POPCNT
14* 40a3ec7b5ffd Paolo Bonzini:
   target/i386: rdpkru/wrpkru are no-prefix instructions
15* 37e91415018d hikalium:
   ui/gtk: Fix mouse/motion event scaling issue with GTK display backend
16* e4e62514e3cc Dongwon Kim:
   ui/gtk: Check if fence_fd is equal to or greater than 0
17* 84d4b7285486 donsheng:
   target-i386: hyper-v: Correct kvm_hv_handle_exit return value
18* 8225bff7c5db Paolo Bonzini:
   target/i386: disable jmp_opt if EFLAGS.RF is 1
19* f0f0136abba6 Paolo Bonzini:
   target/i386: no single-step exception after MOV or POP SS
20 36fa7c686e9e Richard Henderson:
   gitlab: Update msys2-64bit runner tags
21 19ed42e8adc8 Zenghui Yu:
   hvf: arm: Fix encodings for ID_AA64PFR1_EL1 and debug System registers
22 daafa78b2972 Andrey Shumilin:
   hw/intc/arm_gic: Fix handling of NS view of GICC_APR<n>
23 daf9748ac002 Marcin Juszkiewicz:
   target/arm: Disable SVE extensions when SVE is disabled
24 c76b121840c6 yang.zhang:
   hw/intc/riscv_aplic: APLICs should add child earlier than realize
25 915758c537b5 Alistair Francis:
   disas/riscv: Decode all of the pmpcfg and pmpaddr CSRs
26 7604bbc2d87d Paolo Bonzini:
   target/i386: fix xsave.flat from kvm-unit-tests
27 da7c95920d02 Xinyu Li:
   target/i386: fix SSE and SSE2 feature check
28 2e701e6785cd Bernhard Beschow:
   ui/sdl2: Allow host to power down screen
29 78f932ea1f7b lanyanzhi:
   target/loongarch: fix a wrong print in cpu dump

(commit(s) marked with * were in previous series and are not resent)

