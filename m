Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBEFC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 18:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhD5x-0001gI-WB; Mon, 04 Mar 2024 13:31:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rhD5v-0001ev-Gv; Mon, 04 Mar 2024 13:31:23 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rhD5s-00032e-JI; Mon, 04 Mar 2024 13:31:23 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 57B4B52E14;
 Mon,  4 Mar 2024 21:32:04 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1ED968FD08;
 Mon,  4 Mar 2024 21:31:18 +0300 (MSK)
Received: (nullmailer pid 1474601 invoked by uid 1000);
 Mon, 04 Mar 2024 18:31:17 -0000
Subject: [ANNOUNCE] QEMU 8.2.2 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Date: Mon, 04 Mar 2024 21:31:17 +0300
Message-Id: <1709577077.783602.1474596.nullmailer@tls.msk.ru>
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi everyone,

The QEMU v8.2.2 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-8.2.2.tar.xz
  https://download.qemu.org/qemu-8.2.2.tar.xz.sig (signature)

v8.2.2 is now tagged in the official qemu.git repository, and the
stable-8.2 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-8.2?ref_type=heads

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-8.2-hash master-hash Author Name: Commmit-Subject):

11aa0b1ff1 Michael Tokarev:
 Update version for 8.2.2 release
21214699c2 462945cd22 Thomas Huth:
 chardev/char-socket: Fix TLS io channels sending too much data to the backend
2a97c05796 f0cb6828ae Thomas Huth:
 tests/unit/test-util-sockets: Remove temporary file after test
e6ce551c75 5e02a4fdeb Benjamin David Lunt:
 hw/usb/bus.c: PCAP adding 0xA in Windows version
829bb27765 8bd3f84d1f Thomas Huth:
 hw/intc/Kconfig: Fix GIC settings when using "--without-default-devices"
0e33e4e78e a8bf9de2f4 Daniel P. Berrangé:
 gitlab: force allow use of pip in Cirrus jobs
6c14f93182 151b7dba39 Alex Bennée:
 tests/vm: avoid re-building the VM images all the time
36d50b4bde 8467ac75b3 Alex Bennée:
 tests/vm: update openbsd image to 7.4
decafac46b b5a9de3259 Paolo Bonzini:
 target/i386: leave the A20 bit set in the final NPT walk
6801a20ebd a28fe7dc19 Paolo Bonzini:
 target/i386: remove unnecessary/wrong application of the A20 mask
a28b6b4e74 b1661801c1 Paolo Bonzini:
 target/i386: Fix physical address truncation
5c4091fe07 d09c79010f Paolo Bonzini:
 target/i386: check validity of VMCB addresses
6ed8211379 68fb78d7d5 Paolo Bonzini:
 target/i386: mask high bits of CR3 in 32-bit mode
a0fb839d0a 4d28d57c9f Jessica Clarke:
 pl031: Update last RTCLR value on write in case it's read back
e4e36e65c9 d2b5bb860e Klaus Jensen:
 hw/nvme: fix invalid endian conversion
8c86c88cd5 658178c3d4 Gerd Hoffmann:
 update edk2 binaries to edk2-stable202402
cc98bd4f10 9c996f3d11 Gerd Hoffmann:
 update edk2 submodule to edk2-stable202402
131ed62955 c8fd9667e5 Nicholas Piggin:
 target/ppc: Fix crash on machine check caused by ifetch
175bdedfa9 2cc0e449d1 Nicholas Piggin:
 target/ppc: Fix lxv/stxv MSR facility check
01aa603fb1 5cd3ae4903 Peter Maydell:
 .gitlab-ci.d/windows.yml: Drop msys2-32bit job
aafe8c0d12 185311130f Tianlan Zhou:
 system/vl: Update description for input grab key
2da2e679d6 4a20ac400f Tianlan Zhou:
 docs/system: Update description for input grab key
56ee4a67cb 04b86ccb5d Thomas Huth:
 hw/hppa/Kconfig: Fix building with "configure --without-default-devices"
814f887430 186acfbaf7 Akihiko Odaki:
 tests/qtest: Depend on dbus_display1_dep
fb22ee75b2 7aee57df93 Akihiko Odaki:
 meson: Explicitly specify dbus-display1.h dependency
1766b9360c d676119075 Akihiko Odaki:
 audio: Depend on dbus_display1_dep
2e5c9d5462 95b08fee8f Tianlan Zhou:
 ui/console: Fix console resize with placeholder surface
7ff0d4d184 9c41658261 Fiona Ebner:
 ui/clipboard: add asserts for update and request
480a6adc83 405484b29f Fiona Ebner:
 ui/clipboard: mark type as not available when there is no data
4fd56da337 4cba838896 Daniel P. Berrangé:
 ui: reject extended clipboard message if not activated
0b30735d38 99d0dcd7f1 Ziqiao Kong:
 target/i386: Generate an illegal opcode exception on cmp instructions with lock prefix
f5dddb856c 0729857c70 Xiaoyao Li:
 i386/cpuid: Move leaf 7 to correct group
e8d27721cb 10f92799af Xiaoyao Li:
 i386/cpuid: Decrease cpuid_i when skipping CPUID leaf 1F
72c4ef9da0 a11a365159 Xiaoyao Li:
 i386/cpu: Mask with XCR0/XSS mask for FEAT_XSAVE_XCR0_HI and FEAT_XSAVE_XSS_HI leafs
0766f137f5 81f5cad385 Xiaoyao Li:
 i386/cpu: Clear FEAT_XSAVE_XSS_LO/HI leafs when CPUID_EXT_XSAVE is not available
4d9dc117ea 8e31b744fd Peter Maydell:
 .gitlab-ci/windows.yml: Don't install libusb or spice packages on 32-bit
d5bc76fa20 cc29c12ec6 Kevin Wolf:
 iotests: Make 144 deterministic again
f030e96d27 ac1d88e9e7 Peter Maydell:
 target/arm: Don't get MDCR_EL2 in pmu_counter_enabled() before checking ARM_FEATURE_PMU
429c11c726 855f94eca8 Richard Henderson:
 target/arm: Fix SVE/SME gross MTE suppression checks
2d1a29e3b2 623507ccfc Richard Henderson:
 target/arm: Handle mte in do_ldrq, do_ldro
da804717a5 96fcc9982b Richard Henderson:
 target/arm: Split out make_svemte_desc
8da74af970 b12a7671b6 Richard Henderson:
 target/arm: Adjust and validate mtedesc sizem1
5e6e09baa5 64c6e7444d Richard Henderson:
 target/arm: Fix nregs computation in do_{ld,st}_zpa
7950913ece 681dfc0d55 Richard Henderson:
 linux-user/aarch64: Choose SYNC as the preferred MTE mode
803f1e70ec b24a981b9f Jonathan Cameron:
 tests/acpi: Update DSDT.cxl to reflect change _STA return value.
02d9979ba8 d9ae5802f6 Jonathan Cameron:
 hw/i386: Fix _STA return value for ACPI0017
47df9ca585 14ec4ff3e4 Jonathan Cameron:
 tests/acpi: Allow update of DSDT.cxl
d4157195bd 8a6b3f4dc9 Zhenzhong Duan:
 smmu: Clear SMMUPciBus pointer cache when system reset
721c3ceaef 9a457383ce Zhenzhong Duan:
 virtio_iommu: Clear IOMMUPciBus pointer cache when system reset
1c38c8a24a 574b64aa67 Dmitry Osipenko:
 virtio-gpu: Correct virgl_renderer_resource_get_info() error check
bbe51d6ea3 729d45a6af Li Zhijian:
 hw/cxl: Pass CXLComponentState to cache_mem_ops
bdd3159ad7 f7509f462c Hyeonggon Yoo:
 hw/cxl/device: read from register values in mdev_reg_read()
9d8a2a8aaf 64fdad5e67 Ira Weiny:
 cxl/cdat: Fix header sum value in CDAT checksum
8997083118 c62926f730 Ira Weiny:
 cxl/cdat: Handle cdat table build errors
17ae7ebedc aa05bd9ef4 Andrey Ignatov:
 vhost-user.rst: Fix vring address description
181e548715 e41f1825b4 Richard Henderson:
 tcg/arm: Fix goto_tb for large translation blocks
e5f105655c c0e688153f Richard Henderson:
 tcg: Increase width of temp_subindex
281fea01d6 9b60a3ed55 Sven Schnelle:
 hw/net/tulip: add chip status register values
9ab476c3de 196578c9d0 Akihiko Odaki:
 hw/smbios: Fix port connector option validation
d6e07d5916 cd8a35b913 Akihiko Odaki:
 hw/smbios: Fix OEM strings table option validation
6eeeb87331 15cc103362 Paolo Bonzini:
 configure: run plugin TCG tests again
cefca32a24 7485508341 Fabiano Rosas:
 tests/docker: Add sqlite3 module to openSUSE Leap container
eca4e19914 1a49762c07 Daniel Henrique Barboza:
 hw/riscv/virt-acpi-build.c: fix leak in build_rhct()
76c172ffbe 3205bebd4f Avihai Horon:
 migration: Fix logic of channels and transport compatibility check
c36d4d3cee bfa36802d1 Stefan Hajnoczi:
 virtio-blk: avoid using ioeventfd state in irqfd conditional
00e50cb429 5bdbaebcce Hanna Czenczek:
 virtio: Re-enable notifications after drain
feb2073c86 c42c3833e0 Hanna Czenczek:
 virtio-scsi: Attach event vq notifier with no_poll
84c54eaeff 7d2faf0ce2 Daniel P. Berrangé:
 iotests: give tempdir an identifying name
88555e3607 c645bac4e0 Daniel P. Berrangé:
 iotests: fix leak of tmpdir in dry-run mode
bbfcb0f7bc 8b09b7fe47 Sven Schnelle:
 hw/scsi/lsi53c895a: add missing decrement of reentrancy counter
3a970decfe 6400be014f Richard Henderson:
 linux-user/aarch64: Add padding before __kernel_rt_sigreturn
8b7750c66f 45bf0e7aa6 Richard Henderson:
 tcg/loongarch64: Set vector registers call clobbered
5f5e30229e 8a73152020 Guenter Roeck:
 pci-host: designware: Limit value range of iATU viewport register
de6992d390 185e3fdf8d Peter Maydell:
 target/arm: Reinstate "vfp" property on AArch32 CPUs
2d0530abe2 747bfaf3a9 Peter Maydell:
 qemu-options.hx: Improve -serial option documentation
e2a12fa4e7 d2019a9d0c Peter Maydell:
 system/vl.c: Fix handling of '-serial none -serial something'
35a60a20f0 f670be1aad Jan Klötzke:
 target/arm: fix exception syndrome for AArch32 bkpt insn
b91715588a 615eaeab3d Richard W.M. Jones:
 block/blkio: Make s->mem_region_alignment be 64 bits
84c9704b8e db101376af Yihuan Pan:
 qemu-docs: Update options for graphical frontends
3837e6dd1e 57fd4b4e10 Het Gala:
 Make 'uri' optional for migrate QAPI
b79a2ef0d4 d2b668fca5 Cédric Le Goater:
 vfio/pci: Clear MSI-X IRQ index always
106aa13c5b 27eb8499ed Fabiano Rosas:
 migration: Fix use-after-free of migration state object
e589e5ade7 918f620d30 Markus Armbruster:
 migration: Plug memory leak on HMP migrate error path

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEe3O61ovnosKJMUsicBtPaxppPlkFAmXmE3YACgkQcBtPaxpp
PlnWdQgAi+dbrt1N+N3vEgE3R9M1Q4RLnWWVCW470icQaSyW8SgQG3U4f5d7CSdE
yoY/N5W2x3QpQQVRQLpAgfSBgdiMZA93wXoZ+rbUABphSafKhAfzKZGkFzMmneuD
52nanW9jL5xvui+UOJaZAeTgU/3k207xwo84Y3Ahm+2uSgItHdPOGb3odKpbmpSJ
V2bZ3EvN4ztCpdImNOzn+27HwZYiiiU1Vubg+D8s0IvmbvAn2k6uteOIOxUBjFfm
f/dUZ+FAdZ/VQlL9H2nKYIr4zSSx93vKeytZ+z0NGztG/an0uANkeAn269acs8aK
DdZK3BXAr8VTCxL8bbMUQ7K4TQujxg==
=BZfD
-----END PGP SIGNATURE-----

