Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9FEC54E49
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 18:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhD5t-0001e1-BA; Mon, 04 Mar 2024 13:31:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rhD5r-0001dL-1u; Mon, 04 Mar 2024 13:31:19 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rhD5o-00031B-7h; Mon, 04 Mar 2024 13:31:18 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3C16352E13;
 Mon,  4 Mar 2024 21:31:58 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E93828FD07;
 Mon,  4 Mar 2024 21:31:11 +0300 (MSK)
Received: (nullmailer pid 1474419 invoked by uid 1000);
 Mon, 04 Mar 2024 18:31:11 -0000
Subject: [ANNOUNCE] QEMU 7.2.10 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Date: Mon, 04 Mar 2024 21:31:11 +0300
Message-Id: <1709577071.606034.1474414.nullmailer@tls.msk.ru>
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

The QEMU v7.2.10 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-7.2.10.tar.xz
  https://download.qemu.org/qemu-7.2.10.tar.xz.sig (signature)

v7.2.10 is now tagged in the official qemu.git repository, and the
stable-7.2 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-7.2?ref_type=heads

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-7.2-hash master-hash Author Name: Commmit-Subject):

eee83fae9d Michael Tokarev:
 Update version for 7.2.10 release
0ee0f9d822 2196157404 Paolo Bonzini:
 target/i386: the sgx_epc_get_section stub is reachable
90b1b8e0d6 b6903cbe3a Peter Maydell:
 tests/unit/test-blockjob: Disable complete_in_standby test
b0ed25ee07 f2e57851b8 Thomas Huth:
 tests/qtest/display-vga-test: Add proper checks if a device is available
73bf928177 abe2c4bdb6 Eric Auger:
 test-vmstate: fix bad GTree usage, use-after-free
72e2a24638 f0cb6828ae Thomas Huth:
 tests/unit/test-util-sockets: Remove temporary file after test
8dd9165e7c 5e02a4fdeb Benjamin David Lunt:
 hw/usb/bus.c: PCAP adding 0xA in Windows version
9b89d02d8b a8bf9de2f4 Daniel P. Berrangé:
 gitlab: force allow use of pip in Cirrus jobs
4934f922ac 151b7dba39 Alex Bennée:
 tests/vm: avoid re-building the VM images all the time
2bd4d27aa5 8467ac75b3 Alex Bennée:
 tests/vm: update openbsd image to 7.4
1165d9601d b5a9de3259 Paolo Bonzini:
 target/i386: leave the A20 bit set in the final NPT walk
91ad0d26e1 a28fe7dc19 Paolo Bonzini:
 target/i386: remove unnecessary/wrong application of the A20 mask
1c15f97b4f b1661801c1 Paolo Bonzini:
 target/i386: Fix physical address truncation
5eba614159 d09c79010f Paolo Bonzini:
 target/i386: check validity of VMCB addresses
6156ca0da1 68fb78d7d5 Paolo Bonzini:
 target/i386: mask high bits of CR3 in 32-bit mode
77f7beb8cf 4d28d57c9f Jessica Clarke:
 pl031: Update last RTCLR value on write in case it's read back
d3c3bc7a9c d2b5bb860e Klaus Jensen:
 hw/nvme: fix invalid endian conversion
a15b7df35b 2cc0e449d1 Nicholas Piggin:
 target/ppc: Fix lxv/stxv MSR facility check
1bdf3f4ba0 5cd3ae4903 Peter Maydell:
 .gitlab-ci.d/windows.yml: Drop msys2-32bit job
7f368bccd6 185311130f Tianlan Zhou:
 system/vl: Update description for input grab key
181d92d034 4a20ac400f Tianlan Zhou:
 docs/system: Update description for input grab key
b3edbda64a d676119075 Akihiko Odaki:
 audio: Depend on dbus_display1_dep
c172136ea3 1222070e77 Marc-André Lureau:
 meson: ensure dbus-display generated code is built before other units
086850aa80 95b08fee8f Tianlan Zhou:
 ui/console: Fix console resize with placeholder surface
ee316aafa5 9c41658261 Fiona Ebner:
 ui/clipboard: add asserts for update and request
d8d6e6b904 405484b29f Fiona Ebner:
 ui/clipboard: mark type as not available when there is no data
7e86bd83fd 4cba838896 Daniel P. Berrangé:
 ui: reject extended clipboard message if not activated
373c7193dc 99d0dcd7f1 Ziqiao Kong:
 target/i386: Generate an illegal opcode exception on cmp instructions with lock prefix
3c819d9717 0729857c70 Xiaoyao Li:
 i386/cpuid: Move leaf 7 to correct group
46f701c44d 10f92799af Xiaoyao Li:
 i386/cpuid: Decrease cpuid_i when skipping CPUID leaf 1F
f18b018907 a11a365159 Xiaoyao Li:
 i386/cpu: Mask with XCR0/XSS mask for FEAT_XSAVE_XCR0_HI and FEAT_XSAVE_XSS_HI leafs
14109f6353 81f5cad385 Xiaoyao Li:
 i386/cpu: Clear FEAT_XSAVE_XSS_LO/HI leafs when CPUID_EXT_XSAVE is not available
fc39dc294c cc29c12ec6 Kevin Wolf:
 iotests: Make 144 deterministic again
688450c4a7 ac1d88e9e7 Peter Maydell:
 target/arm: Don't get MDCR_EL2 in pmu_counter_enabled() before checking ARM_FEATURE_PMU
3b0d905812 855f94eca8 Richard Henderson:
 target/arm: Fix SVE/SME gross MTE suppression checks
a978855bfc 64c6e7444d Richard Henderson:
 target/arm: Fix nregs computation in do_{ld,st}_zpa
bbeeed7102 681dfc0d55 Richard Henderson:
 linux-user/aarch64: Choose SYNC as the preferred MTE mode
4971891b37 b24a981b9f Jonathan Cameron:
 tests/acpi: Update DSDT.cxl to reflect change _STA return value.
3b88637c8c d9ae5802f6 Jonathan Cameron:
 hw/i386: Fix _STA return value for ACPI0017
b8c6b783c3 14ec4ff3e4 Jonathan Cameron:
 tests/acpi: Allow update of DSDT.cxl
3004edca48 8a6b3f4dc9 Zhenzhong Duan:
 smmu: Clear SMMUPciBus pointer cache when system reset
10981da022 9a457383ce Zhenzhong Duan:
 virtio_iommu: Clear IOMMUPciBus pointer cache when system reset
4bfbb4ed9a 729d45a6af Li Zhijian:
 hw/cxl: Pass CXLComponentState to cache_mem_ops
b5246140de 64fdad5e67 Ira Weiny:
 cxl/cdat: Fix header sum value in CDAT checksum
eccd94458b c62926f730 Ira Weiny:
 cxl/cdat: Handle cdat table build errors
2112a217dc aa05bd9ef4 Andrey Ignatov:
 vhost-user.rst: Fix vring address description
0fd604b02a 196578c9d0 Akihiko Odaki:
 hw/smbios: Fix port connector option validation
258293b564 cd8a35b913 Akihiko Odaki:
 hw/smbios: Fix OEM strings table option validation
2884514b98 8a73152020 Guenter Roeck:
 pci-host: designware: Limit value range of iATU viewport register
f039059e0a 747bfaf3a9 Peter Maydell:
 qemu-options.hx: Improve -serial option documentation
597a9a2b4b d2019a9d0c Peter Maydell:
 system/vl.c: Fix handling of '-serial none -serial something'
d9b2dc2ffa f670be1aad Jan Klötzke:
 target/arm: fix exception syndrome for AArch32 bkpt insn
c49842381a 615eaeab3d Richard W.M. Jones:
 block/blkio: Make s->mem_region_alignment be 64 bits
ce979ef754 db101376af Yihuan Pan:
 qemu-docs: Update options for graphical frontends
18c776ecf6 27eb8499ed Fabiano Rosas:
 migration: Fix use-after-free of migration state object

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEe3O61ovnosKJMUsicBtPaxppPlkFAmXmE28ACgkQcBtPaxpp
PlmAzQf/VyR8Hk3rLFq3np2i6bpwoQgNkoNLpTr+zrPTVf5akn113/G8LZ3Y9695
UqFC3Y9rfXmCBz41znASyzxE3P6ABZzlNlsRUAFArYgXj61jxHMYeigGppsHNX8E
XHle9MwAMw8HJCDlH+ntbztFeNixVEKfPaN597DKHf9YBHbvhi4umFP96PGNvY+m
tCfqkX13JefDzF/6UahLzqLYdv037NCH4wU6a0UeInRj6o6XHaE0iRvlQyvWK3ER
hNUvhDeAtD1Ich+nhjs2XTRlspHsiGFaj8QcdDQHaljD+h+wiEwoTVUXVkXuIXIk
pvLarm38D5j4nsHSUsFwokJfc+TJTw==
=bP0M
-----END PGP SIGNATURE-----

