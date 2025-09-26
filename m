Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35C4CAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 08:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v23Xf-0006v7-3a; Fri, 26 Sep 2025 04:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23XZ-0006tw-3X; Fri, 26 Sep 2025 04:10:53 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23XP-0008WG-GI; Fri, 26 Sep 2025 04:10:51 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AA875157D48;
 Fri, 26 Sep 2025 11:10:30 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id BE7E3290C2C;
 Fri, 26 Sep 2025 11:10:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.1 00/60] Patch Round-up for stable 10.1.1,
 freeze on 2025-10-06
Date: Fri, 26 Sep 2025 11:09:28 +0300
Message-ID: <qemu-stable-10.1.1-20250926101857@cover.tls.msk.ru>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The following patches are queued for QEMU stable v10.1.1:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-10.1

Patch freeze is 2025-10-06, and the release is planned for 2025-10-08:

  https://wiki.qemu.org/Planning/10.1

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 ab85146ac4c6 Paolo Bonzini:
   python: mkvenv: fix messages printed by mkvenv
02 c12cbaa007c9 Zero Tang:
   i386/tcg/svm: fix incorrect canonicalization
03 f91563d011a0 Joel Stanley:
   linux-user: Add strace for rseq
04 36fb9796662e Gustavo Romero:
   tests/functional: Fix reverse_debugging asset precaching
05 376cdd7e9c94 Steve Sistare:
   hw/intc/arm_gicv3_kvm: preserve pending interrupts during cpr
06 186db6a73bc5 Smail AIDER:
   target/arm: Trap PMCR when MDCR_EL2.TPMCR is set
07 5ffd387e9e0f Peter Maydell:
   scripts/kernel-doc: Avoid new Perl precedence warning
08 1748c0d59228 Richard Henderson:
   qemu/atomic: Finish renaming atomic128-cas.h headers
09 2e27650bddd3 Peter Maydell:
   hw/arm/stm32f205_soc: Don't leak TYPE_OR_IRQ objects
10 85ff0e956bf2 Kostiantyn Kostiuk:
   qga/installer: Remove QGA VSS if QGA installation failed
11 edf3780a7dad Kostiantyn Kostiuk:
   qga-vss: Write hex value of error in log
12 28c5d27dd4dc minglei.liu:
   qga: Fix truncated output handling in guest-exec status reporting
13 b2e4534a2c9c Markus Armbruster:
   i386/kvm/vmsr_energy: Plug memory leak on failure to connect socket
14 ec14a3de622a Markus Armbruster:
   vfio scsi ui: Error-check qio_channel_socket_connect_sync() the same way
15 c9a1ea9c52e6 Markus Armbruster:
   Revert "tests/qtest: use qos_printf instead of g_test_message"
16 8e4649cac9bc Laurent Vivier:
   e1000e: Prevent crash from legacy interrupt firing after MSI-X enable
17 14ab44b96d5b Philippe Mathieu-Daudé:
   elf: Add EF_MIPS_ARCH_ASE definitions
18 7a09b3cc70ab Philippe Mathieu-Daudé:
   linux-user/mips: Select 74Kf CPU to run MIPS16e binaries
19 51c3aebfda64 Philippe Mathieu-Daudé:
   linux-user/mips: Select M14Kc CPU to run microMIPS binaries
20 1f82ca723478 Denis Rastyogin:
   target/mips: fix TLB huge page check to use 64-bit shift
21 46d03bb23dde Aditya Gupta:
   hw/ppc: Fix build error with CONFIG_POWERNV disabled
22 3284d1c07cfd Peter Maydell:
   hw/gpio/pca9554: Avoid leak in pca9554_set_pin()
23 ac6b124180f7 Peter Maydell:
   hw/char/max78000_uart: Destroy FIFO on deinit
24 606978500c3d Michael Tokarev:
   block/curl: fix curl internal handles handling
25 96e7448c1f82 WANG Rui:
   target/loongarch: Guard 64-bit-only insn translation with TRANS64 macro
26 86bca4040231 Thomas Huth:
   hw/intc/loongarch_pch_pic: Fix ubsan warning and endianness issue
27 1b5062188124 John Levon:
   hw/vfio-user: add x-pci-class-code
28 38dd513263d8 Thomas Huth:
   ui/vnc: Fix crash when specifying [vnc] without id in the config file
29 1e343714bfc0 John Snow:
   python: backport 'kick event queue on legacy event_pull()'
30 f9d2e0a3bd7b John Snow:
   python: backport 'drop Python3.6 workarounds'
31 0408b8d7a086 John Snow:
   python: backport 'Use @asynciocontextmanager'
32 fcaeeb7653d2 John Snow:
   python: backport 'qmp-shell-wrap: handle missing binary gracefully'
33 fd0ed46d4eff John Snow:
   python: backport 'qmp-tui: Do not crash if optional dependencies are not met'
34 5d99044d09db John Snow:
   python: backport 'Remove deprecated get_event_loop calls'
35 85f223e5b031 John Snow:
   python: backport 'avoid creating additional event loops per thread'
36 82c7cb93c750 Daniel P. Berrangé:
   iotests: drop compat for old version context manager
37 6ccb48ffc19f Daniel P. Berrangé:
   python: ensure QEMUQtestProtocol closes its socket
38 d4d0ebfcc926 Daniel P. Berrangé:
   iotests/147: ensure temporary sockets are closed before exiting
39 2b2fb25c2aaf Daniel P. Berrangé:
   iotests/151: ensure subprocesses are cleaned up
40 9a494d835386 Daniel P. Berrangé:
   iotests/check: always enable all python warnings
41 a11d1847d5ef Alex Bennée:
   .gitmodules: move u-boot mirrors to qemu-project-mirrors
42 aaf042299acf Stéphane Graber:
   hw/usb/network: Remove hardcoded 0x40 prefix in STRING_ETHADDR response
43 0516f4b70264 Xiaoyao Li:
   i386/cpu: Enable SMM cpu address space under KVM
44 591f817d819f Xiaoyao Li:
   target/i386: Define enum X86ASIdx for x86's address spaces
45 4c8f69b94839 Xiaoyao Li:
   multiboot: Fix the split lock
46 db05b0d21ec1 Paolo Bonzini:
   linux-user: avoid -Werror=int-in-bool-context
47 b7cd0a1821ad Richard Henderson:
   target/sparc: Allow TRANS macro with no extra arguments
48 b6cdd6c60505 Richard Henderson:
   target/sparc: Loosen decode of STBAR for v8
49 49d669ccf33a Richard Henderson:
   target/sparc: Loosen decode of RDY for v7
50 a0345f628394 Richard Henderson:
   target/sparc: Loosen decode of RDPSR for v7
51 dc9678cc9725 Richard Henderson:
   target/sparc: Loosen decode of RDWIM for v7
52 6ff52f9dee06 Richard Henderson:
   target/sparc: Loosen decode of RDTBR for v7
53 df663ac0a4e5 Richard Henderson:
   target/sparc: Relax decode of rs2_or_imm for v7
54 e4a1b308b27c Peter Maydell:
   hw/pci-host/dino: Don't call pci_register_root_bus() in init
55 76d2b8d42adb Peter Maydell:
   hw/pci-host/astro: Don't call pci_regsiter_root_bus() in init
56 a50347a4145f WANG Rui:
   tcg/optimize: Fix folding of vector bitsel
57 fd34f56fe886 Peter Maydell:
   .gitlab-ci.d/buildtest.yml: Unset CI_COMMIT_DESCRIPTION for htags
58 4f1ebc7712a7 Thomas Huth:
   tests: Fix "make check-functional" for targets without thorough tests
59 03fe6659803f Richard Henderson:
   accel/tcg: Properly unlink a TB linked to itself
60 e13e1195db8a Richard Henderson:
   tests/tcg/multiarch: Add tb-link test

