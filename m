Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0E8CCA471
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 05:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6inH-0007j8-Rt; Thu, 09 Oct 2025 01:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v6inA-0007hh-36; Thu, 09 Oct 2025 01:02:16 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v6in6-0000es-Cj; Thu, 09 Oct 2025 01:02:15 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B12F715BBDA;
 Thu, 09 Oct 2025 08:01:56 +0300 (MSK)
Received: from tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with SMTP id 1D48129BF9E;
 Thu,  9 Oct 2025 08:02:06 +0300 (MSK)
Received: (nullmailer pid 643527 invoked by uid 1000);
 Thu, 09 Oct 2025 05:02:05 -0000
Subject: [ANNOUNCE] QEMU 10.0.5 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Oct 2025 08:02:05 +0300
Message-Id: <1759986125.676506.643525.nullmailer@tls.msk.ru>
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, MIME_QP_LONG_LINE=0.001,
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

The QEMU v10.0.5 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-10.0.5.tar.xz
  https://download.qemu.org/qemu-10.0.5.tar.xz.sig (signature)

v10.0.5 is now tagged in the official qemu.git repository, and the
stable-10.0 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-10.0

There are 58 changes since the previous v10.0.4 release.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-10.0-hash master-hash Author Name: Commmit-Subject):

918d584db4 Michael Tokarev:
 Update version for 10.0.5 release
835b1232d1 01e2b1bc27 Thomas Huth:
 tests/functional/test_aarch64_sbsaref_freebsd: Fix the URL of the ISO image
08974df583 3b1cf40dd6 Thomas Huth:
 tests/functional/test_ppc_bamboo: Replace broken link with working assets
9d061df678 300a87c502 Peter Maydell:
 physmem: Destroy all CPU AddressSpaces on unrealize
470f16d517 041600e23f Peter Xu:
 memory: New AS helper to serialize destroy+free
a231fb6d11 9e7bfda490 Peter Maydell:
 include/system/memory.h: Clarify address_space_destroy() behaviour
da22a22323 725a9e5f78 Juraj Marcin:
 migration: Fix state transition in postcopy_start() error handling
d2c69cbfb0 be50ff3a73 Max Chou:
 target/riscv: rvv: Modify minimum VLEN according to enabled vector extensions
81c7f085ae ae4a37f578 Max Chou:
 target/riscv: rvv: Replace checking V by checking Zve32x
10ed1e211c b25133d38f vhaudiquet:
 target/riscv: Fix endianness swap on compressed instructions
4dc7ff7996 15abfced80 Guo Ren (Alibaba DAMO Academy):
 hw/riscv/riscv-iommu: Fixup PDT Nested Walk
9bed57fb2e a86d3352ab Vladimir Isaev:
 target/riscv: do not use translator_ldl in opcode_at
79509912dd cebaf7434b stove:
 target/riscv: use riscv_csrr in riscv_csr_read
2148c7c00d 191df34617 Frank Chang:
 hw/char: sifive_uart: Raise IRQ according to the Tx/Rx watermark thresholds
1698236268 da14767b35 Andrea Bolognani:
 docs/interop/firmware: Add riscv64 to FirmwareArchitecture
c81d81c7a1 4f7528295b Andrew Jones:
 hw/riscv/riscv-iommu: Fix MSI table size limit
409f506518 9163424c50 Thomas Huth:
 ui/icons/qemu.svg: Add metadata information (author, license) to the logo
b4feb2ec85 e7ecb533ee Mohamed Akram:
 ui/spice: Fix abort on macOS
3a2ed64b6d 6285eebd3a Harsh Prateek Bora:
 ppc/spapr: init lrdr-capapcity phys with ram size if maxmem not provided
9b3789017d f5738aedc2 Fabian Vogt:
 hw/intc/xics: Add missing call to register vmstate_icp_server
746269eaae d0af3cd027 Peter Maydell:
 hw/usb/hcd-uhci: don't assert for SETUP to non-0 endpoint
a0c98ef864 e13e1195db Richard Henderson:
 tests/tcg/multiarch: Add tb-link test
3e55f8282a 03fe665980 Richard Henderson:
 accel/tcg: Properly unlink a TB linked to itself
71f198239f 4f1ebc7712 Thomas Huth:
 tests: Fix "make check-functional" for targets without thorough tests
f37412622d fd34f56fe8 Peter Maydell:
 .gitlab-ci.d/buildtest.yml: Unset CI_COMMIT_DESCRIPTION for htags
1207071390 a50347a414 WANG Rui:
 tcg/optimize: Fix folding of vector bitsel
837030e11c 76d2b8d42a Peter Maydell:
 hw/pci-host/astro: Don't call pci_regsiter_root_bus() in init
212d9c0fd5 e4a1b308b2 Peter Maydell:
 hw/pci-host/dino: Don't call pci_register_root_bus() in init
5d6c277b49 df663ac0a4 Richard Henderson:
 target/sparc: Relax decode of rs2_or_imm for v7
b22876f27d 6ff52f9dee Richard Henderson:
 target/sparc: Loosen decode of RDTBR for v7
84505fd162 dc9678cc97 Richard Henderson:
 target/sparc: Loosen decode of RDWIM for v7
731df89ac0 a0345f6283 Richard Henderson:
 target/sparc: Loosen decode of RDPSR for v7
6951dd0821 49d669ccf3 Richard Henderson:
 target/sparc: Loosen decode of RDY for v7
ce6e2f1174 b6cdd6c605 Richard Henderson:
 target/sparc: Loosen decode of STBAR for v8
adc2c22439 b7cd0a1821 Richard Henderson:
 target/sparc: Allow TRANS macro with no extra arguments
0ce28801d3 db05b0d21e Paolo Bonzini:
 linux-user: avoid -Werror=int-in-bool-context
819d59ae38 4c8f69b948 Xiaoyao Li:
 multiboot: Fix the split lock
15170fbd2b 591f817d81 Xiaoyao Li:
 target/i386: Define enum X86ASIdx for x86's address spaces
232d5c6275 0516f4b702 Xiaoyao Li:
 i386/cpu: Enable SMM cpu address space under KVM
4474802b0c aaf042299a Stéphane Graber:
 hw/usb/network: Remove hardcoded 0x40 prefix in STRING_ETHADDR response
2fbab04cbd 6b3fad084f Paolo Bonzini:
 rust: hpet: fix new warning
6cd9548f1f eb8f7292e1 Paolo Bonzini:
 ci: run RISC-V cross jobs by default
8b182b6600 Michael Tokarev:
 tests/docker/dockerfiles/python.docker: pull fedora:40 image instead of fedora:latest
971efd8bf9 a11d1847d5 Alex Bennée:
 .gitmodules: move u-boot mirrors to qemu-project-mirrors
bb94b10551 9a494d8353 Daniel P. Berrangé:
 iotests/check: always enable all python warnings
38bef9dd05 2b2fb25c2a Daniel P. Berrangé:
 iotests/151: ensure subprocesses are cleaned up
8b594a84dd d4d0ebfcc9 Daniel P. Berrangé:
 iotests/147: ensure temporary sockets are closed before exiting
058820db78 6ccb48ffc1 Daniel P. Berrangé:
 python: ensure QEMUQtestProtocol closes its socket
90dd727503 82c7cb93c7 Daniel P. Berrangé:
 iotests: drop compat for old version context manager
00b265c018 85f223e5b0 John Snow:
 python: backport 'avoid creating additional event loops per thread'
b3725ab92d 5d99044d09 John Snow:
 python: backport 'Remove deprecated get_event_loop calls'
fd043dfa26 fd0ed46d4e John Snow:
 python: backport 'qmp-tui: Do not crash if optional dependencies are not met'
d997c7ca7d fcaeeb7653 John Snow:
 python: backport 'qmp-shell-wrap: handle missing binary gracefully'
83b8187abb 0408b8d7a0 John Snow:
 python: backport 'Use @asynciocontextmanager'
ce44e28ed8 f9d2e0a3bd John Snow:
 python: backport 'drop Python3.6 workarounds'
ca3bc6e0a1 1e343714bf John Snow:
 python: backport 'kick event queue on legacy event_pull()'
d3f77be407 38dd513263 Thomas Huth:
 ui/vnc: Fix crash when specifying [vnc] without id in the config file
5d383e0e3e 96e7448c1f WANG Rui:
 target/loongarch: Guard 64-bit-only insn translation with TRANS64 macro
5db9867076 256df51e72 WANG Rui:
 target/loongarch: Add CRC feature flag and use it to gate CRC instructions


