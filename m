Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C7AC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 06:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uep9B-0004RO-8B; Thu, 24 Jul 2025 02:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uep90-0004NA-G2; Thu, 24 Jul 2025 02:09:36 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uep8x-0007C5-Nv; Thu, 24 Jul 2025 02:09:30 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B8F5B139BA0;
 Thu, 24 Jul 2025 09:09:22 +0300 (MSK)
Received: from tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with SMTP id 1960724EA6F;
 Thu, 24 Jul 2025 08:58:04 +0300 (MSK)
Received: (nullmailer pid 226975 invoked by uid 1000);
 Thu, 24 Jul 2025 05:58:04 -0000
Subject: [ANNOUNCE] QEMU 10.0.3 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Jul 2025 08:58:04 +0300
Message-Id: <1753336684.713829.226974.nullmailer@tls.msk.ru>
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The QEMU v10.0.3 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-10.0.3.tar.xz
  https://download.qemu.org/qemu-10.0.3.tar.xz.sig (signature)

v10.0.3 is now tagged in the official qemu.git repository, and the
stable-10.0 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-10.0

There are 70 changes since the previous v10.0.2 release.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-10.0-hash master-hash Author Name: Commmit-Subject):

66d21643c2 Michael Tokarev:
 Update version for 10.0.3 release
a5ac9803d5 e6da704b71 Zenghui Yu:
 hvf: arm: Emulate ICC_RPR_EL1 accesses properly
3341f5cd5c 655659a74a Peter Maydell:
 target/arm: Correct encoding of Debug Communications Channel registers
08fa61a365 3ac6daa9e1 Daniel P. Berrangé:
 ui: fix setting client_endian field defaults
9561a8c140 871a6e5b33 Peter Maydell:
 hw/net/npcm_gmac.c: Send the right data for second packet in a row
24778b1c7e d3a24134e3 Paolo Bonzini:
 target/i386: do not expose ARCH_CAPABILITIES on AMD CPU
82517381c5 5d21ee453a Zhao Liu:
 i386/cpu: Honor maximum value for CPUID.8000001DH.EAX[25:14]
1822478999 3e86124e7c Qian Wen:
 i386/cpu: Fix overflow of cache topology fields in CPUID.04H
d097553158 a62fef5829 Michael Tokarev:
 i386/cpu: Fix cpu number overflow in CPUID.01H.EBX[23:16]
2df7954daa aef22331b5 Akihiko Odaki:
 ui/vnc: Do not copy z_stream
12e88c0c6c 9f749129e2 David Hildenbrand:
 vhost: Fix used memslot tracking when destroying a vhost device
2533500b4a a598090eba Cole Robinson:
 roms: re-remove execute bit from hppa-firmware*
e50ca171e2 d402da1360 Kevin Wolf:
 file-posix: Fix aio=threads performance regression after enablign FUA
787a817cd5 5788929e05 Ethan Milon:
 amd_iommu: Fix truncation of oldval in amdvi_writeq
fc1ad5124f 5959b641c9 Alejandro Jimenez:
 amd_iommu: Remove duplicated definitions
90c635c926 67d3077ee4 Alejandro Jimenez:
 amd_iommu: Fix the calculation for Device Table size
18e70a46c3 123cf4bdd3 Alejandro Jimenez:
 amd_iommu: Fix mask to retrieve Interrupt Table Root Pointer from DTE
caaa648508 108e10ff69 Alejandro Jimenez:
 amd_iommu: Fix masks for various IOMMU MMIO Registers
d1ea4a1b0e ff3dcb3bf6 Alejandro Jimenez:
 amd_iommu: Update bitmasks representing DTE reserved fields
1ca9d2e0c2 c63b8d1425 Alejandro Jimenez:
 amd_iommu: Fix Device ID decoding for INVALIDATE_IOTLB_PAGES command
10a9eedc20 091c7d7924 Alejandro Jimenez:
 amd_iommu: Fix Miscellaneous Information Register 0 encoding
f272f318c0 adda0ad56b Akihiko Odaki:
 virtio-net: Add queues for RSS during migration
6624ff3972 110d0fa2d4 Anastasia Belova:
 net: fix buffer overflow in af_xdp_umem_create()
a655b6548f f180e367fc Thomas Huth:
 accel/kvm: Adjust the note about the minimum required kernel version
c49db93c36 d6390204c6 Peter Maydell:
 linux-user: Use qemu_set_cloexec() to mark pidfd as FD_CLOEXEC
b4ead90726 983899eab4 Chaney, Ben:
 migration: Don't sync volatile memory after migration completes
a4e31f5d8e e4e839b2ee Geoffrey Thomas:
 linux-user: Hold the fd-trans lock across fork
1759558915 c4828cb850 Peter Maydell:
 linux-user: Check for EFAULT failure in nanosleep
1714828a56 6a3e132a1b Peter Maydell:
 linux-user: Implement fchmodat2 syscall
676bc0f4a7 930180f3b9 Bernhard Beschow:
 hw/arm/fsl-imx8mp: Wire VIRQ and VFIQ
fe000c4648 c563cd7e61 Peter Maydell:
 target/arm: Don't enforce NSE,NS check for EL3->EL3 returns
cae6ddfd7e 0f1d6606c2 Mark Cave-Ayland:
 target/i386: fix TB exit logic in gen_movl_seg() when writing to SS
005184da9d bf020eaa67 Richard Henderson:
 target/arm: Fix bfdotadd_ebf vs nan selection
9a98db505f cfc688c00a Richard Henderson:
 target/arm: Fix f16_dotadd vs nan selection
9af1de0c4b 3801c5b75f Richard Henderson:
 target/arm: Fix PSEL size operands to tcg_gen_gvec_ands
c76ec8d575 e6ffd009c7 Richard Henderson:
 target/arm: Fix 128-bit element ZIP, UZP, TRN
0e5f0d87f8 b4b2e070f4 Richard Henderson:
 target/arm: Fix sve_access_check for SME
83b48a500f f9b0f69304 Richard Henderson:
 target/arm: Fix SME vs AdvSIMD exception priority
b8f48f4033 78e3781541 Kevin Wolf:
 hw/s390x/ccw-device: Fix memory leak in loadparm setter
fb9bad329c 1fa2ffdbec Yiwei Zhang:
 virtio-gpu: support context init multiple timeline
5df7910a23 a412575837 Philippe Mathieu-Daudé:
 target/arm: Correct KVM & HVF dtb_compatible value
ed4bad29e7 9a3bf0e0ab Solomon Tan:
 target/arm: Make RETA[AB] UNDEF when pauth is not implemented
22909a1397 0d0fc3f465 Richard Henderson:
 tcg: Fix constant propagation in tcg_reg_alloc_dup
46cdfdfe92 c2a2e1ad2a Song Gao:
 target/loongarch: fix vldi/xvldi raise wrong error
fdd20285ae e7788da986 Song Gao:
 target/loongarch: add check for fcond
3cf25f4c71 5ad2b1f443 J. Neuschäfer:
 linux-user/arm: Fix return value of SYS_cacheflush
b7da1f5f5d cd38e638c4 Peter Maydell:
 hw/arm/mps2: Configure the AN500 CPU with 16 MPU regions
436b3dd8cc e372214e66 Ethan Chen:
 qemu-options.hx: Fix reversed description of icount sleep behavior
c902fc66c9 f5ec751ee7 Shameer Kolothum:
 hw/arm/virt: Check bypass iommu is not set for iommu-map DT property
6276ce6d70 9c55c03c05 Bibo Mao:
 hw/loongarch/virt: Fix big endian support with MCFG table
ab96ea4b4d eef2dd03f9 Fiona Ebner:
 hw/core/qdev-properties-system: Add missing return in set_drive_helper()
d8e6f3f885 2e88718745 Stefan Hajnoczi:
 iotests: fix 240
9f80e4707c 0b901459a8 Xin Li (Intel):
 target/i386: Remove FRED dependency on WRMSRNS
92d08b3c0d d009f26a54 Volker Rümelin:
 hw/audio/asc: fix SIGSEGV in asc_realize()
6b12cb6edc ccb4fec0e5 Volker Rümelin:
 audio: fix size calculation in AUD_get_buffer_size_out()
47ddae806b 5ddd6c8dc8 Volker Rümelin:
 audio: fix SIGSEGV in AUD_get_buffer_size_out()
c3e1181baf 0f178860df Vasant Hegde:
 hw/i386/amd_iommu: Fix xtsup when vcpus < 255
8399ccb480 31753d5a33 Sairaj Kodilkar:
 hw/i386/amd_iommu: Fix device setup failure when PT is on.
325d039d25 0b006153b7 Bernhard Beschow:
 hw/i386/pc_piix: Fix RTC ISA IRQ wiring of isapc machine
21f86e2951 a9403bfcd9 Huaitong Han:
 vhost: Don't set vring call if guest notifier is unused
1702044371 e6bc01777e Guenter Roeck:
 hw/arm: Add missing psci_conduit to NPCM8XX SoC boot info
9238fd846d 63d3209092 Daniel P. Berrangé:
 ui/vnc: fix tight palette pixel encoding for 8/16-bpp formats
531cbd8e26 7009744285 Daniel P. Berrangé:
 ui/vnc: take account of client byte order in pixman format
a610978bc5 7ed96710e8 Daniel P. Berrangé:
 ui/vnc.c: replace big endian flag with byte order value
613f05a4c6 30aa105640 Weifeng Liu:
 ui/sdl: Consider scaling in mouse event handling
a5a805068a 8fb072472c Weifeng Liu:
 ui/gtk: Update scales in fixed-scale mode when rendering GL area
43fecc5dde a196654481 Weifeng Liu:
 gtk/ui: Introduce helper gd_update_scale
91fec603bd 3a6b314409 Weifeng Liu:
 ui/gtk: Use consistent naming for variables in different coordinates
6eea0cd511 9498e2f7e1 Weifeng Liu:
 ui/gtk: Document scale and coordinate handling
80a03b51b2 e6941ac106 Jamin Lin:
 hw/arm/aspeed_ast27x0: Fix RAM size detection failure on BE hosts
c9afc732e2 fb8e59abbe Jamin Lin:
 hw/misc/aspeed_hace: Ensure HASH_IRQ is always set to prevent firmware hang


