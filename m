Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CC7C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 07:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBUj0-0007ks-09; Mon, 27 May 2024 03:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBUin-0007eT-Ns; Mon, 27 May 2024 03:24:42 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBUik-0006AO-Gp; Mon, 27 May 2024 03:24:41 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CB4D36A4BD;
 Mon, 27 May 2024 10:25:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 12539D845A;
 Mon, 27 May 2024 10:24:35 +0300 (MSK)
Received: (nullmailer pid 52867 invoked by uid 1000);
 Mon, 27 May 2024 07:24:35 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, "Roth,
 Michael" <Michael.Roth@amd.com>
Subject: [Stable-8.2.5 00/21] Patch Round-up for stable 8.2.5,
 freeze on 2024-06-07
Date: Mon, 27 May 2024 10:24:10 +0300
Message-Id: <qemu-stable-8.2.5-20240527072014@cover.tls.msk.ru>
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

Patch freeze is 2024-06-07, and the release is planned for 2024-06-09:

  https://wiki.qemu.org/Planning/8.2

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 6a5a63f74ba5 Ruihan Li:
   target/i386: Give IRQs a chance when resetting HF_INHIBIT_IRQ_MASK
02 7b616f36de0b Richard Henderson:
   target/sparc: Fix FEXPAND
03 9157dccc7e71 Richard Henderson:
   target/sparc: Fix FMUL8x16
04 54c52ec719fb Song Gao:
   hw/loongarch/virt: Fix memory leak
05 e6578f1f68a0 Mattias Nissler:
   hw/remote/vfio-user: Fix config space access byte order
06 41c685dc59bb Paolo Bonzini:
   target/i386: fix operand size for DATA16 REX.W POPCNT
07 40a3ec7b5ffd Paolo Bonzini:
   target/i386: rdpkru/wrpkru are no-prefix instructions
08 fe01af5d47d4 Paolo Bonzini:
   target/i386: fix feature dependency for WAITPKG
09 23b1f53c2c89 Paolo Bonzini:
   configure: quote -D options that are passed through to meson
10 371d60dfdb47 Thomas Huth:
   configure: Fix error message when C compiler is not working
11 37e91415018d hikalium:
   ui/gtk: Fix mouse/motion event scaling issue with GTK display backend
12 e4e62514e3cc Dongwon Kim:
   ui/gtk: Check if fence_fd is equal to or greater than 0
13 c9290dfebfdb Richard Henderson:
   tcg/loongarch64: Fill out tcg_out_{ld,st} for vector regs
14 84d4b7285486 donsheng:
   target-i386: hyper-v: Correct kvm_hv_handle_exit return value
15 9710401276a0 Fiona Ebner:
   hw/core/machine: move compatibility flags for VirtIO-net USO to machine 
   8.1
16 0eb285c3627b Song Gao:
   target/loongarch/kvm: Fix VM recovery from disk failures
17 b11f9814526b Song Gao:
   hw/loongarch: Fix fdt memory node wrong 'reg'
18 6204af704a07 Jiaxun Yang:
   hw/loongarch/virt: Fix FDT memory node address width
19 bad7a2759c69 Daniel P. Berrangé:
   dockerfiles: add 'MAKE' env variable to remaining containers
20 8225bff7c5db Paolo Bonzini:
   target/i386: disable jmp_opt if EFLAGS.RF is 1
21 f0f0136abba6 Paolo Bonzini:
   target/i386: no single-step exception after MOV or POP SS

