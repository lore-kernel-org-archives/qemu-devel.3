Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C53CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 05:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6inB-0007i8-V3; Thu, 09 Oct 2025 01:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v6in7-0007hO-4s; Thu, 09 Oct 2025 01:02:13 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v6in2-0000eG-Fe; Thu, 09 Oct 2025 01:02:12 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E24CE15BBD9;
 Thu, 09 Oct 2025 08:01:48 +0300 (MSK)
Received: from tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with SMTP id 67A6029BF9D;
 Thu,  9 Oct 2025 08:01:59 +0300 (MSK)
Received: (nullmailer pid 643266 invoked by uid 1000);
 Thu, 09 Oct 2025 05:01:57 -0000
Subject: [ANNOUNCE] QEMU 10.1.1 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Oct 2025 08:01:57 +0300
Message-Id: <1759986117.949087.643264.nullmailer@tls.msk.ru>
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

Hi everyone,

The QEMU v10.1.1 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-10.1.1.tar.xz
  https://download.qemu.org/qemu-10.1.1.tar.xz.sig (signature)

v10.1.1 is now tagged in the official qemu.git repository, and the
stable-10.1 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-10.1

There are 81 changes since the previous v10.1.0 release.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-10.1-hash master-hash Author Name: Commmit-Subject):

339768517a Michael Tokarev:
 Update version for 10.1.1 release
677d73bde7 769acb2a1e Thomas Huth:
 tests/functional/aarch64: Fix assets of test_hotplug_pci
7bd98c65e0 300a87c502 Peter Maydell:
 physmem: Destroy all CPU AddressSpaces on unrealize
ded5c62454 041600e23f Peter Xu:
 memory: New AS helper to serialize destroy+free
977ffc7abc 9e7bfda490 Peter Maydell:
 include/system/memory.h: Clarify address_space_destroy() behaviour
109f336448 725a9e5f78 Juraj Marcin:
 migration: Fix state transition in postcopy_start() error handling
d7f661905b be50ff3a73 Max Chou:
 target/riscv: rvv: Modify minimum VLEN according to enabled vector extensions
8650b5597a ae4a37f578 Max Chou:
 target/riscv: rvv: Replace checking V by checking Zve32x
e3641f4ecf b25133d38f vhaudiquet:
 target/riscv: Fix endianness swap on compressed instructions
b01f2eccf2 15abfced80 Guo Ren (Alibaba DAMO Academy):
 hw/riscv/riscv-iommu: Fixup PDT Nested Walk
c65d1a6b13 a86d3352ab Vladimir Isaev:
 target/riscv: do not use translator_ldl in opcode_at
7c7694d73c cebaf7434b stove:
 target/riscv: use riscv_csrr in riscv_csr_read
0be25ffa79 191df34617 Frank Chang:
 hw/char: sifive_uart: Raise IRQ according to the Tx/Rx watermark thresholds
c25be2649c da14767b35 Andrea Bolognani:
 docs/interop/firmware: Add riscv64 to FirmwareArchitecture
e93d2c5fdd 4f7528295b Andrew Jones:
 hw/riscv/riscv-iommu: Fix MSI table size limit
f3b84ec247 9163424c50 Thomas Huth:
 ui/icons/qemu.svg: Add metadata information (author, license) to the logo
ecc1aef81e 62fd247a24 Marc-André Lureau:
 ui/spice: fix crash when disabling GL scanout on
daa07cbe01 e7ecb533ee Mohamed Akram:
 ui/spice: Fix abort on macOS
e60467febb 6285eebd3a Harsh Prateek Bora:
 ppc/spapr: init lrdr-capapcity phys with ram size if maxmem not provided
f906aa2e33 f5738aedc2 Fabian Vogt:
 hw/intc/xics: Add missing call to register vmstate_icp_server
2d1b1bad05 4ccca2cc05 Laurent Vivier:
 net/passt: Fix build failure due to missing GIO dependency
dfae27159d d0af3cd027 Peter Maydell:
 hw/usb/hcd-uhci: don't assert for SETUP to non-0 endpoint
562020faa2 e13e1195db Richard Henderson:
 tests/tcg/multiarch: Add tb-link test
daf8f84e74 03fe665980 Richard Henderson:
 accel/tcg: Properly unlink a TB linked to itself
ed37926cfb 4f1ebc7712 Thomas Huth:
 tests: Fix "make check-functional" for targets without thorough tests
f4eeb2f48d fd34f56fe8 Peter Maydell:
 .gitlab-ci.d/buildtest.yml: Unset CI_COMMIT_DESCRIPTION for htags
903045d724 a50347a414 WANG Rui:
 tcg/optimize: Fix folding of vector bitsel
bbb31acea9 76d2b8d42a Peter Maydell:
 hw/pci-host/astro: Don't call pci_regsiter_root_bus() in init
975d8f329e e4a1b308b2 Peter Maydell:
 hw/pci-host/dino: Don't call pci_register_root_bus() in init
431d064c8e df663ac0a4 Richard Henderson:
 target/sparc: Relax decode of rs2_or_imm for v7
5f51aa7f60 6ff52f9dee Richard Henderson:
 target/sparc: Loosen decode of RDTBR for v7
e574af4a5a dc9678cc97 Richard Henderson:
 target/sparc: Loosen decode of RDWIM for v7
ba5f5ae5b2 a0345f6283 Richard Henderson:
 target/sparc: Loosen decode of RDPSR for v7
7c48b47055 49d669ccf3 Richard Henderson:
 target/sparc: Loosen decode of RDY for v7
dd93f80d02 b6cdd6c605 Richard Henderson:
 target/sparc: Loosen decode of STBAR for v8
307f5bb43f b7cd0a1821 Richard Henderson:
 target/sparc: Allow TRANS macro with no extra arguments
4e95da0305 db05b0d21e Paolo Bonzini:
 linux-user: avoid -Werror=int-in-bool-context
e460ac0c14 4c8f69b948 Xiaoyao Li:
 multiboot: Fix the split lock
46cda5823b 591f817d81 Xiaoyao Li:
 target/i386: Define enum X86ASIdx for x86's address spaces
6130ab24d0 0516f4b702 Xiaoyao Li:
 i386/cpu: Enable SMM cpu address space under KVM
88006572b4 aaf042299a Stéphane Graber:
 hw/usb/network: Remove hardcoded 0x40 prefix in STRING_ETHADDR response
dfaeca306b a11d1847d5 Alex Bennée:
 .gitmodules: move u-boot mirrors to qemu-project-mirrors
dd6c96219c 9a494d8353 Daniel P. Berrangé:
 iotests/check: always enable all python warnings
a1e094db8b 2b2fb25c2a Daniel P. Berrangé:
 iotests/151: ensure subprocesses are cleaned up
de9b387a5b d4d0ebfcc9 Daniel P. Berrangé:
 iotests/147: ensure temporary sockets are closed before exiting
6a59e3c5b0 6ccb48ffc1 Daniel P. Berrangé:
 python: ensure QEMUQtestProtocol closes its socket
8d7385b2a7 82c7cb93c7 Daniel P. Berrangé:
 iotests: drop compat for old version context manager
7c9d65f9e4 85f223e5b0 John Snow:
 python: backport 'avoid creating additional event loops per thread'
1034cd169c 5d99044d09 John Snow:
 python: backport 'Remove deprecated get_event_loop calls'
67d9347194 fd0ed46d4e John Snow:
 python: backport 'qmp-tui: Do not crash if optional dependencies are not met'
677a4e9d54 fcaeeb7653 John Snow:
 python: backport 'qmp-shell-wrap: handle missing binary gracefully'
5f39565103 0408b8d7a0 John Snow:
 python: backport 'Use @asynciocontextmanager'
f246e6efc7 f9d2e0a3bd John Snow:
 python: backport 'drop Python3.6 workarounds'
e2826959a8 1e343714bf John Snow:
 python: backport 'kick event queue on legacy event_pull()'
571a7414e7 38dd513263 Thomas Huth:
 ui/vnc: Fix crash when specifying [vnc] without id in the config file
4709ca196f 1b50621881 John Levon:
 hw/vfio-user: add x-pci-class-code
c03d5e11ee 86bca40402 Thomas Huth:
 hw/intc/loongarch_pch_pic: Fix ubsan warning and endianness issue
95de88feac 96e7448c1f WANG Rui:
 target/loongarch: Guard 64-bit-only insn translation with TRANS64 macro
1b1d46fef8 606978500c Michael Tokarev:
 block/curl: fix curl internal handles handling
7527e29c06 ac6b124180 Peter Maydell:
 hw/char/max78000_uart: Destroy FIFO on deinit
d1d60d7588 3284d1c07c Peter Maydell:
 hw/gpio/pca9554: Avoid leak in pca9554_set_pin()
4715a0e9e6 46d03bb23d Aditya Gupta:
 hw/ppc: Fix build error with CONFIG_POWERNV disabled
63bfc916de 1f82ca7234 Denis Rastyogin:
 target/mips: fix TLB huge page check to use 64-bit shift
046f1ae6fd 51c3aebfda Philippe Mathieu-Daudé:
 linux-user/mips: Select M14Kc CPU to run microMIPS binaries
a490b66ae4 7a09b3cc70 Philippe Mathieu-Daudé:
 linux-user/mips: Select 74Kf CPU to run MIPS16e binaries
0bb9ee4750 14ab44b96d Philippe Mathieu-Daudé:
 elf: Add EF_MIPS_ARCH_ASE definitions
a84e2e04e8 8e4649cac9 Laurent Vivier:
 e1000e: Prevent crash from legacy interrupt firing after MSI-X enable
b7f2bff3ff c9a1ea9c52 Markus Armbruster:
 Revert "tests/qtest: use qos_printf instead of g_test_message"
2dd52baff2 ec14a3de62 Markus Armbruster:
 vfio scsi ui: Error-check qio_channel_socket_connect_sync() the same way
2a2b6ae097 b2e4534a2c Markus Armbruster:
 i386/kvm/vmsr_energy: Plug memory leak on failure to connect socket
b4048a3d25 28c5d27dd4 minglei.liu:
 qga: Fix truncated output handling in guest-exec status reporting
7f730ad785 edf3780a7d Kostiantyn Kostiuk:
 qga-vss: Write hex value of error in log
f132112273 85ff0e956b Kostiantyn Kostiuk:
 qga/installer: Remove QGA VSS if QGA installation failed
b6fdef9c99 2e27650bdd Peter Maydell:
 hw/arm/stm32f205_soc: Don't leak TYPE_OR_IRQ objects
28682949f2 1748c0d592 Richard Henderson:
 qemu/atomic: Finish renaming atomic128-cas.h headers
067af4f784 5ffd387e9e Peter Maydell:
 scripts/kernel-doc: Avoid new Perl precedence warning
a4f01a0878 186db6a73b Smail AIDER:
 target/arm: Trap PMCR when MDCR_EL2.TPMCR is set
9084479e3b 376cdd7e9c Steve Sistare:
 hw/intc/arm_gicv3_kvm: preserve pending interrupts during cpr
2cba99e9f8 36fb979666 Gustavo Romero:
 tests/functional: Fix reverse_debugging asset precaching
673d54cabf f91563d011 Joel Stanley:
 linux-user: Add strace for rseq
408eeeacb3 c12cbaa007 Zero Tang:
 i386/tcg/svm: fix incorrect canonicalization
a854320fde ab85146ac4 Paolo Bonzini:
 python: mkvenv: fix messages printed by mkvenv


