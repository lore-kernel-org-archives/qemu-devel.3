Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17ADC54E41
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 09:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgiDZ-0001Qw-O0; Sun, 03 Mar 2024 04:33:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rgiDX-0001Pw-JS; Sun, 03 Mar 2024 04:33:11 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rgiDV-0006TQ-4R; Sun, 03 Mar 2024 04:33:11 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F3DCC527CC;
 Sun,  3 Mar 2024 12:33:47 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 758828E8C8;
 Sun,  3 Mar 2024 12:33:04 +0300 (MSK)
Received: (nullmailer pid 1357002 invoked by uid 1000);
 Sun, 03 Mar 2024 09:33:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.2 v3 00/82] Patch Round-up for stable 8.2.2,
 freeze on 2024-03-02 (frozen)
Date: Sun,  3 Mar 2024 12:32:56 +0300
Message-Id: <qemu-stable-8.2.2-20240303104213@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v8.2.2:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-8.2

Patch freeze is 2024-03-02, and the release is planned for 2024-03-04:

  https://wiki.qemu.org/Planning/8.2

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* 918f620d30a9 Markus Armbruster:
   migration: Plug memory leak on HMP migrate error path
02* 27eb8499edb2 Fabiano Rosas:
   migration: Fix use-after-free of migration state object
03* d2b668fca565 Cédric Le Goater:
   vfio/pci: Clear MSI-X IRQ index always
04* 57fd4b4e1075 Het Gala:
   Make 'uri' optional for migrate QAPI
05* db101376af52 Yihuan Pan:
   qemu-docs: Update options for graphical frontends
06* 615eaeab3d31 Richard W.M. Jones:
   block/blkio: Make s->mem_region_alignment be 64 bits
07* f670be1aad33 Jan Klötzke:
   target/arm: fix exception syndrome for AArch32 bkpt insn
08* d2019a9d0c34 Peter Maydell:
   system/vl.c: Fix handling of '-serial none -serial something'
09* 747bfaf3a9d2 Peter Maydell:
   qemu-options.hx: Improve -serial option documentation
10* 185e3fdf8d10 Peter Maydell:
   target/arm: Reinstate "vfp" property on AArch32 CPUs
11* 8a7315202033 Guenter Roeck:
   pci-host: designware: Limit value range of iATU viewport register
12* 45bf0e7aa648 Richard Henderson:
   tcg/loongarch64: Set vector registers call clobbered
13* 6400be014f80 Richard Henderson:
   linux-user/aarch64: Add padding before __kernel_rt_sigreturn
14* 8b09b7fe4708 Sven Schnelle:
   hw/scsi/lsi53c895a: add missing decrement of reentrancy counter
15* c645bac4e06b Daniel P. Berrangé:
   iotests: fix leak of tmpdir in dry-run mode
16* 7d2faf0ce2cc Daniel P. Berrangé:
   iotests: give tempdir an identifying name
17* c42c3833e0cf Hanna Czenczek:
   virtio-scsi: Attach event vq notifier with no_poll
18* 5bdbaebcce18 Hanna Czenczek:
   virtio: Re-enable notifications after drain
19* bfa36802d170 Stefan Hajnoczi:
   virtio-blk: avoid using ioeventfd state in irqfd conditional
20* 3205bebd4fc6 Avihai Horon:
   migration: Fix logic of channels and transport compatibility check
21* 1a49762c07d0 Daniel Henrique Barboza:
   hw/riscv/virt-acpi-build.c: fix leak in build_rhct()
22* 7485508341f4 Fabiano Rosas:
   tests/docker: Add sqlite3 module to openSUSE Leap container
23* 15cc10336249 Paolo Bonzini:
   configure: run plugin TCG tests again
24* cd8a35b913c2 Akihiko Odaki:
   hw/smbios: Fix OEM strings table option validation
25* 196578c9d051 Akihiko Odaki:
   hw/smbios: Fix port connector option validation
26* 9b60a3ed5569 Sven Schnelle:
   hw/net/tulip: add chip status register values
27* c0e688153f29 Richard Henderson:
   tcg: Increase width of temp_subindex
28* e41f1825b437 Richard Henderson:
   tcg/arm: Fix goto_tb for large translation blocks
29* aa05bd9ef407 Andrey Ignatov:
   vhost-user.rst: Fix vring address description
30* c62926f730d0 Ira Weiny:
   cxl/cdat: Handle cdat table build errors
31* 64fdad5e6758 Ira Weiny:
   cxl/cdat: Fix header sum value in CDAT checksum
32* f7509f462c78 Hyeonggon Yoo:
   hw/cxl/device: read from register values in mdev_reg_read()
33* 729d45a6af06 Li Zhijian:
   hw/cxl: Pass CXLComponentState to cache_mem_ops
34* 574b64aa6754 Dmitry Osipenko:
   virtio-gpu: Correct virgl_renderer_resource_get_info() error check
35* 9a457383ce9d Zhenzhong Duan:
   virtio_iommu: Clear IOMMUPciBus pointer cache when system reset
36* 8a6b3f4dc95a Zhenzhong Duan:
   smmu: Clear SMMUPciBus pointer cache when system reset
37* 14ec4ff3e429 Jonathan Cameron:
   tests/acpi: Allow update of DSDT.cxl
38* d9ae5802f656 Jonathan Cameron:
   hw/i386: Fix _STA return value for ACPI0017
39* b24a981b9f1c Jonathan Cameron:
   tests/acpi: Update DSDT.cxl to reflect change _STA return value.
40* 681dfc0d5529 Richard Henderson:
   linux-user/aarch64: Choose SYNC as the preferred MTE mode
41* 64c6e7444dff Richard Henderson:
   target/arm: Fix nregs computation in do_{ld,st}_zpa
42* b12a7671b609 Richard Henderson:
   target/arm: Adjust and validate mtedesc sizem1
43* 96fcc9982b4a Richard Henderson:
   target/arm: Split out make_svemte_desc
44* 623507ccfcfe Richard Henderson:
   target/arm: Handle mte in do_ldrq, do_ldro
45* 855f94eca80c Richard Henderson:
   target/arm: Fix SVE/SME gross MTE suppression checks
46* ac1d88e9e7ca Peter Maydell:
   target/arm: Don't get MDCR_EL2 in pmu_counter_enabled() before checking 
   ARM_FEATURE_PMU
47* cc29c12ec629 Kevin Wolf:
   iotests: Make 144 deterministic again
48* 8e31b744fdf2 Peter Maydell:
   .gitlab-ci/windows.yml: Don't install libusb or spice packages on 32-bit
49* 81f5cad3858f Xiaoyao Li:
   i386/cpu: Clear FEAT_XSAVE_XSS_LO/HI leafs when CPUID_EXT_XSAVE is not 
   available
50* a11a365159b9 Xiaoyao Li:
   i386/cpu: Mask with XCR0/XSS mask for FEAT_XSAVE_XCR0_HI and 
   FEAT_XSAVE_XSS_HI leafs
51* 10f92799af8b Xiaoyao Li:
   i386/cpuid: Decrease cpuid_i when skipping CPUID leaf 1F
52* 0729857c7075 Xiaoyao Li:
   i386/cpuid: Move leaf 7 to correct group
53* 99d0dcd7f102 Ziqiao Kong:
   target/i386: Generate an illegal opcode exception on cmp instructions 
   with lock prefix
54* 4cba8388968b Daniel P. Berrangé:
   ui: reject extended clipboard message if not activated
55* 405484b29f65 Fiona Ebner:
   ui/clipboard: mark type as not available when there is no data
56* 9c416582611b Fiona Ebner:
   ui/clipboard: add asserts for update and request
57* 95b08fee8f68 Tianlan Zhou:
   ui/console: Fix console resize with placeholder surface
58* d67611907590 Akihiko Odaki:
   audio: Depend on dbus_display1_dep
59* 7aee57df930d Akihiko Odaki:
   meson: Explicitly specify dbus-display1.h dependency
60* 186acfbaf7f3 Akihiko Odaki:
   tests/qtest: Depend on dbus_display1_dep
61* 04b86ccb5dc8 Thomas Huth:
   hw/hppa/Kconfig: Fix building with "configure --without-default-devices"
62* 4a20ac400ff0 Tianlan Zhou:
   docs/system: Update description for input grab key
63* 185311130f54 Tianlan Zhou:
   system/vl: Update description for input grab key
64* 5cd3ae4903e3 Peter Maydell:
   .gitlab-ci.d/windows.yml: Drop msys2-32bit job
65* 2cc0e449d173 Nicholas Piggin:
   target/ppc: Fix lxv/stxv MSR facility check
66* c8fd9667e597 Nicholas Piggin:
   target/ppc: Fix crash on machine check caused by ifetch
67* 9c996f3d11f8 Gerd Hoffmann:
   update edk2 submodule to edk2-stable202402
68* 658178c3d4e9 Gerd Hoffmann:
   update edk2 binaries to edk2-stable202402
69* d2b5bb860e6c Klaus Jensen:
   hw/nvme: fix invalid endian conversion
70* 4d28d57c9f2e Jessica Clarke:
   pl031: Update last RTCLR value on write in case it's read back
71* 68fb78d7d572 Paolo Bonzini:
   target/i386: mask high bits of CR3 in 32-bit mode
72* d09c79010ffd Paolo Bonzini:
   target/i386: check validity of VMCB addresses
73* b1661801c184 Paolo Bonzini:
   target/i386: Fix physical address truncation
74* a28fe7dc1939 Paolo Bonzini:
   target/i386: remove unnecessary/wrong application of the A20 mask
75* b5a9de3259f4 Paolo Bonzini:
   target/i386: leave the A20 bit set in the final NPT walk
76* 8467ac75b3b7 Alex Bennée:
   tests/vm: update openbsd image to 7.4
77* 151b7dba391f Alex Bennée:
   tests/vm: avoid re-building the VM images all the time
78* a8bf9de2f4f3 Daniel P. Berrangé:
   gitlab: force allow use of pip in Cirrus jobs
79 8bd3f84d1f6f Thomas Huth:
   hw/intc/Kconfig: Fix GIC settings when using "--without-default-devices"
80 5e02a4fdebc4 Benjamin David Lunt:
   hw/usb/bus.c: PCAP adding 0xA in Windows version
81 f0cb6828ae34 Thomas Huth:
   tests/unit/test-util-sockets: Remove temporary file after test
82 462945cd22d2 Thomas Huth:
   chardev/char-socket: Fix TLS io channels sending too much data to the 
   backend

(commit(s) marked with * were in previous series and are not resent)

