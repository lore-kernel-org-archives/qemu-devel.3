Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9299ECAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 12:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v27qC-00089n-Ga; Fri, 26 Sep 2025 08:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v27q1-00083J-Gp; Fri, 26 Sep 2025 08:46:15 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v27pg-0006Yb-0h; Fri, 26 Sep 2025 08:46:03 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AB128157F48;
 Fri, 26 Sep 2025 15:45:39 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1B2C1290F06;
 Fri, 26 Sep 2025 15:45:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.5 00/38] Patch Round-up for stable 10.0.5,
 freeze on 2025-10-06
Date: Fri, 26 Sep 2025 15:45:00 +0300
Message-ID: <qemu-stable-10.0.5-20250926154509@cover.tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following patches are queued for QEMU stable v10.0.5:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-10.0

Patch freeze is 2025-10-06, and the release is planned for 2025-10-08:

  https://wiki.qemu.org/Planning/10.0

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 256df51e7272 WANG Rui:
   target/loongarch: Add CRC feature flag and use it to gate CRC instructions
02 96e7448c1f82 WANG Rui:
   target/loongarch: Guard 64-bit-only insn translation with TRANS64 macro
03 38dd513263d8 Thomas Huth:
   ui/vnc: Fix crash when specifying [vnc] without id in the config file
04 1e343714bfc0 John Snow:
   python: backport 'kick event queue on legacy event_pull()'
05 f9d2e0a3bd7b John Snow:
   python: backport 'drop Python3.6 workarounds'
06 0408b8d7a086 John Snow:
   python: backport 'Use @asynciocontextmanager'
07 fcaeeb7653d2 John Snow:
   python: backport 'qmp-shell-wrap: handle missing binary gracefully'
08 fd0ed46d4eff John Snow:
   python: backport 'qmp-tui: Do not crash if optional dependencies are not 
   met'
09 5d99044d09db John Snow:
   python: backport 'Remove deprecated get_event_loop calls'
10 85f223e5b031 John Snow:
   python: backport 'avoid creating additional event loops per thread'
11 82c7cb93c750 Daniel P. Berrangé:
   iotests: drop compat for old version context manager
12 6ccb48ffc19f Daniel P. Berrangé:
   python: ensure QEMUQtestProtocol closes its socket
13 d4d0ebfcc926 Daniel P. Berrangé:
   iotests/147: ensure temporary sockets are closed before exiting
14 2b2fb25c2aaf Daniel P. Berrangé:
   iotests/151: ensure subprocesses are cleaned up
15 9a494d835386 Daniel P. Berrangé:
   iotests/check: always enable all python warnings
16 a11d1847d5ef Alex Bennée:
   .gitmodules: move u-boot mirrors to qemu-project-mirrors
17 8b182b6600 Michael Tokarev:
   tests/docker/dockerfiles/python.docker: pull fedora:40 image instead of 
   fedora:latest
18 eb8f7292e131 Paolo Bonzini:
   ci: run RISC-V cross jobs by default
19 6b3fad084fc4 Paolo Bonzini:
   rust: hpet: fix new warning
20 aaf042299acf Stéphane Graber:
   hw/usb/network: Remove hardcoded 0x40 prefix in STRING_ETHADDR response
21 0516f4b70264 Xiaoyao Li:
   i386/cpu: Enable SMM cpu address space under KVM
22 591f817d819f Xiaoyao Li:
   target/i386: Define enum X86ASIdx for x86's address spaces
23 4c8f69b94839 Xiaoyao Li:
   multiboot: Fix the split lock
24 db05b0d21ec1 Paolo Bonzini:
   linux-user: avoid -Werror=int-in-bool-context
25 b7cd0a1821ad Richard Henderson:
   target/sparc: Allow TRANS macro with no extra arguments
26 b6cdd6c60505 Richard Henderson:
   target/sparc: Loosen decode of STBAR for v8
27 49d669ccf33a Richard Henderson:
   target/sparc: Loosen decode of RDY for v7
28 a0345f628394 Richard Henderson:
   target/sparc: Loosen decode of RDPSR for v7
29 dc9678cc9725 Richard Henderson:
   target/sparc: Loosen decode of RDWIM for v7
30 6ff52f9dee06 Richard Henderson:
   target/sparc: Loosen decode of RDTBR for v7
31 df663ac0a4e5 Richard Henderson:
   target/sparc: Relax decode of rs2_or_imm for v7
32 e4a1b308b27c Peter Maydell:
   hw/pci-host/dino: Don't call pci_register_root_bus() in init
33 76d2b8d42adb Peter Maydell:
   hw/pci-host/astro: Don't call pci_regsiter_root_bus() in init
34 a50347a4145f WANG Rui:
   tcg/optimize: Fix folding of vector bitsel
35 fd34f56fe886 Peter Maydell:
   .gitlab-ci.d/buildtest.yml: Unset CI_COMMIT_DESCRIPTION for htags
36 4f1ebc7712a7 Thomas Huth:
   tests: Fix "make check-functional" for targets without thorough tests
37 03fe6659803f Richard Henderson:
   accel/tcg: Properly unlink a TB linked to itself
38 e13e1195db8a Richard Henderson:
   tests/tcg/multiarch: Add tb-link test

