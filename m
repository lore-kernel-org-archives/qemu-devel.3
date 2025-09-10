Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2DECA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 05:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwD8D-0005G1-7j; Wed, 10 Sep 2025 01:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uwD87-0005F5-8u; Wed, 10 Sep 2025 01:12:27 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uwD7y-0004OU-Fu; Wed, 10 Sep 2025 01:12:25 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3EA09151F64;
 Wed, 10 Sep 2025 08:12:07 +0300 (MSK)
Received: from tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with SMTP id 782C027B8D7;
 Wed, 10 Sep 2025 08:12:13 +0300 (MSK)
Received: (nullmailer pid 441879 invoked by uid 1000);
 Wed, 10 Sep 2025 05:12:12 -0000
Subject: [ANNOUNCE] QEMU 10.0.4 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Sep 2025 08:12:12 +0300
Message-Id: <1757481132.347544.441874.nullmailer@tls.msk.ru>
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

The QEMU v10.0.4 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-10.0.4.tar.xz
  https://download.qemu.org/qemu-10.0.4.tar.xz.sig (signature)

v10.0.4 is now tagged in the official qemu.git repository, and the
stable-10.0 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-10.0

There are 81 changes since the previous v10.0.3 release.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-10.0-hash master-hash Author Name: Commmit-Subject):

80949aa0e3 Michael Tokarev:
 Update version for 10.0.4 release
11a3a50ce3 606978500c Michael Tokarev:
 block/curl: fix curl internal handles handling
46b5717924 3284d1c07c Peter Maydell:
 hw/gpio/pca9554: Avoid leak in pca9554_set_pin()
43af067317 46d03bb23d Aditya Gupta:
 hw/ppc: Fix build error with CONFIG_POWERNV disabled
d742fcb279 1f82ca7234 Denis Rastyogin:
 target/mips: fix TLB huge page check to use 64-bit shift
3f4a16362b 51c3aebfda Philippe Mathieu-Daudé:
 linux-user/mips: Select M14Kc CPU to run microMIPS binaries
3b723a3518 7a09b3cc70 Philippe Mathieu-Daudé:
 linux-user/mips: Select 74Kf CPU to run MIPS16e binaries
1d61b14684 14ab44b96d Philippe Mathieu-Daudé:
 elf: Add EF_MIPS_ARCH_ASE definitions
de5fcb105a 8e4649cac9 Laurent Vivier:
 e1000e: Prevent crash from legacy interrupt firing after MSI-X enable
27fb18a8c5 c9a1ea9c52 Markus Armbruster:
 Revert "tests/qtest: use qos_printf instead of g_test_message"
5c3d05db41 ec14a3de62 Markus Armbruster:
 vfio scsi ui: Error-check qio_channel_socket_connect_sync() the same way
21bd5bc0c3 b2e4534a2c Markus Armbruster:
 i386/kvm/vmsr_energy: Plug memory leak on failure to connect socket
cb58ff30c5 28c5d27dd4 minglei.liu:
 qga: Fix truncated output handling in guest-exec status reporting
e6ac36818a edf3780a7d Kostiantyn Kostiuk:
 qga-vss: Write hex value of error in log
91803e42cf 85ff0e956b Kostiantyn Kostiuk:
 qga/installer: Remove QGA VSS if QGA installation failed
5fdba4d41d 2e27650bdd Peter Maydell:
 hw/arm/stm32f205_soc: Don't leak TYPE_OR_IRQ objects
3b0c3dc9ea 1748c0d592 Richard Henderson:
 qemu/atomic: Finish renaming atomic128-cas.h headers
65ce8bd819 5ffd387e9e Peter Maydell:
 scripts/kernel-doc: Avoid new Perl precedence warning
842918ee3c 186db6a73b Smail AIDER:
 target/arm: Trap PMCR when MDCR_EL2.TPMCR is set
aeb1bc0d21 376cdd7e9c Steve Sistare:
 hw/intc/arm_gicv3_kvm: preserve pending interrupts during cpr
e13578488d f91563d011 Joel Stanley:
 linux-user: Add strace for rseq
579a0cc0e6 c12cbaa007 Zero Tang:
 i386/tcg/svm: fix incorrect canonicalization
e2d0c64a0f ab85146ac4 Paolo Bonzini:
 python: mkvenv: fix messages printed by mkvenv
91d33dce76 040237436f Gerd Hoffmann:
 hw/uefi: open json file in binary mode
9d76ee396c fc8ee8fe58 Gerd Hoffmann:
 hw/uefi: check access for first variable
4103fd124a 88e5a28d5a Gerd Hoffmann:
 hw/uefi: return success for notifications
34391a8861 f757d9d90d Mauro Matteo Cascella:
 hw/uefi: clear uefi-vars buffer in uefi_vars_write callback
5a7973fcd3 6ad034e712 Sv. Lockal:
 mkvenv: Support pip 25.2
4cc833ec3f e262646e12 Philippe Mathieu-Daudé:
 hw/sd/ssi-sd: Return noise (dummy byte) when no card connected
6a86e6e5bf c0df98ab1f Werner Fink:
 qemu-iotests: Ignore indentation in Killed messages
d1a5c0c7a6 4af976ef39 Kevin Wolf:
 rbd: Fix .bdrv_get_specific_info implementation
879915e183 53493c1f83 Keith Busch:
 hw/nvme: cap MDTS value for internal limitation
ac392d3f79 bc0c24fdb1 Klaus Jensen:
 hw/nvme: revert CMIC behavior
5837747ed1 31b737b19d Klaus Jensen:
 hw/nvme: fix namespace attachment
84e7c6e65c e66644c48e WANG Rui:
 target/loongarch: Fix [X]VLDI raising exception incorrectly
5fada99144 c7ac771ee7 William Hu:
 ui/curses: Fix infinite loop on windows
031afc0e2e d4720a7faf Glenn Miles:
 ppc/xive2: Fix treatment of PIPR in CPPR update
ed3edfa8d1 8d37317618 Glenn Miles:
 ppc/xive2: Fix irq preempted by lower priority group irq
985062f820 576830428e Michael Kowal:
 ppc/xive2: Reset Generation Flipped bit on END Cache Watch
8502e9cc71 bde8c148bb Nicholas Piggin:
 ppc/xive: Fix PHYS NSR ring matching
535d046410 d1023a296c Nicholas Piggin:
 ppc/xive2: fix context push calculation of IPB priority
f5cca00c8d e8cf73b849 Michael Kowal:
 ppc/xive2: Remote VSDs need to match on forwarding address
74f7aeb63f f16697292a Glenn Miles:
 ppc/xive2: Fix calculation of END queue sizes
2a053c029f f0aab77941 Nicholas Piggin:
 ppc/xive: Report access size in XIVE TM operation error logs
c3ab24397d 301fbbaf03 Nicholas Piggin:
 ppc/xive: Fix xive trace event output
e08986228b 4e5d58969e Zhao Liu:
 target/i386/cpu: Move addressable ID encoding out of compat property in CPUID[0x1]
2de769fe0b a62fef5829 Qian Wen:
 i386/cpu: Fix cpu number overflow in CPUID.01H.EBX[23:16]
53f100eeec f985a1195b Chuang Xu:
 i386/cpu: Fix number of addressable IDs field for CPUID.01H.EBX[23:16]
3d26cb65c2 e68ec29809 Xiaoyao Li:
 i386/cpu: Move adjustment of CPUID_EXT_PDCM before feature_dependencies[] check
d973766e10 Michael Tokarev:
 Revert "i386/cpu: Fix cpu number overflow in CPUID.01H.EBX[23:16]"
d5170775cb b217d987a3 Michael Tokarev:
 qga: correctly write to /sys/power/state on linux
34d8aed39a 0311a6edb9 Peter Maydell:
 scripts/make-release: Go back to cloning all the EDK2 submodules
5c535004b9 cd9f752fee Alex Richardson:
 target/arm: add support for 64-bit PMCCNTR in AArch32 mode
47994cdde5 13ed972b4c Jamin Lin:
 hw/ssi/aspeed_smc: Fix incorrect FMC_WDT2 register read on AST1030
e62a4440ef 97b3d732af Vacha Bhavsar:
 target/arm: Fix handling of setting SVE registers from gdb
8d7488649b 35cca0f95f Vacha Bhavsar:
 target/arm: Fix big-endian handling of NEON gdb remote debugging
e62c6da886 b10bd4bd17 Zenghui Yu:
 hw/intc/arm_gicv3_kvm: Write all 1's to clear enable/active
1a1e232062 a7842d9406 Sairaj Kodilkar:
 hw/i386/amd_iommu: Move IOAPIC memory region initialization to the end
b15585a9b7 e8145dcd31 David Woodhouse:
 intel_iommu: Allow both Status Write and Interrupt Flag in QI wait
df7dff296b cad9aa6fbd Akihiko Odaki:
 pcie_sriov: Fix configuration and state synchronization
54ec54c39d 6071d13c6a Akihiko Odaki:
 virtio-net: Fix VLAN filter table reset timing
2832a33e20 d63c388dad Hanna Czenczek:
 vhost: Do not abort on log-stop error
dc087a9859 c1997099dc Hanna Czenczek:
 vhost: Do not abort on log-start error
f8af005037 6fcf5ebafa Jonah Palmer:
 virtio: fix off-by-one and invalid access in virtqueue_ordered_fill
d6b2796a28 caab7ac835 Bibo Mao:
 target/loongarch: Fix valid virtual address checking
93890300d8 86bc3a0abf Jay Chang:
 target/riscv: Restrict midelegh access to S-mode harts
f45d7aaf67 e443ba0336 Jay Chang:
 target/riscv: Restrict mideleg/medeleg/medelegh access to S-mode harts
3c28bee827 b6f1244678 Yang Jialong:
 intc/riscv_aplic: Fix target register read when source is inactive
94c441fe10 77707bfdf8 Vac Chen:
 target/riscv: Fix pmp range wraparound on zero
423a91255c 30ef718423 Xu Lu:
 target/riscv: Fix exception type when VU accesses supervisor CSRs
093997ee90 16aa7771af Daniel Henrique Barboza:
 target/riscv: do not call GETPC() in check_ret_from_m_mode()
d1baf44157 e111ffe48b Daniel Henrique Barboza:
 linux-user/strace.list: add riscv_hwprobe entry
5a2e67526f 653a75a9d7 Michael Tokarev:
 roms/Makefile: fix npcmNxx_bootrom build rules
58741ac6ef 2865bf1c57 Pierrick Bouvier:
 system/physmem: fix use-after-free with dispatch
eb1adad5f4 2bfcd27e00 Luc Michel:
 hw/net/cadence_gem: fix register mask initialization
3891ba6581 e895095c78 Philippe Mathieu-Daudé:
 target/mips: Only update MVPControl.EVP bit if executed by master VPE
2da4045a3c 8d6c7de1cc Alex Bennée:
 docs/user: clarify user-mode expects the same OS
309f46d077 99870aff90 Peter Maydell:
 linux-user/aarch64: Support TPIDR2_MAGIC signal frame record
7764278a30 3cdd990aa9 Peter Maydell:
 linux-user/aarch64: Clear TPIDR2_EL0 when delivering signals
3b5ea01387 feea87cd6b Paolo Bonzini:
 target/i386: fix width of third operand of VINSERTx128
4d7cc3805a b8882becd5 Michael Tokarev:
 hw/display/qxl-render.c: fix qxl_unpack_chunks() chunk size calculation
ddedb92861 e74aad9f81 Peter Maydell:
 host-utils: Drop workaround for buggy Apple Clang __builtin_subcll()


