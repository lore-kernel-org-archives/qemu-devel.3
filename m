Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1D1C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 20:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUYB4-0002xf-Nv; Mon, 29 Jan 2024 15:24:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rUYB1-0002wk-F1; Mon, 29 Jan 2024 15:24:20 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rUYAy-0008Kg-As; Mon, 29 Jan 2024 15:24:18 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id ECC9748733;
 Mon, 29 Jan 2024 23:25:07 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8E0866E60C;
 Mon, 29 Jan 2024 23:24:14 +0300 (MSK)
Received: (nullmailer pid 1289104 invoked by uid 1000);
 Mon, 29 Jan 2024 20:24:14 -0000
Subject: [ANNOUNCE] QEMU 8.2.1 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Date: Mon, 29 Jan 2024 23:24:14 +0300
Message-Id: <1706559854.271610.1289098.nullmailer@tls.msk.ru>
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

The QEMU v8.2.1 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-8.2.1.tar.xz
  https://download.qemu.org/qemu-8.2.1.tar.xz.sig (signature)

v8.2.1 is now tagged in the official qemu.git repository, and the
stable-8.2 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-8.2?ref_type=heads

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-8.2-hash master-hash Author Name: Commmit-Subject):

f48c205fb4 Michael Tokarev:
 Update version for 8.2.1 release
45b3ce5e83 ee0a2e3c9d Peter Maydell:
 target/arm: Fix incorrect aa64_tidcp1 feature check
570e624426 6fffc83785 Peter Maydell:
 target/arm: Fix A64 scalar SQSHRN and SQRSHRN
553e53b442 604927e357 Max Filippov:
 target/xtensa: fix OOB TLB entry access
ce34d02f91 e8a12fe31f Daniel P. Berrangé:
 qtest: bump aspeed_smc-test timeout to 6 minutes
f389309d29 effd60c878 Stefan Hajnoczi:
 monitor: only run coroutine commands in qemu_aio_context
823892d19f 9ee2dd4c22 Stefan Hajnoczi:
 iotests: port 141 to Python for reliable QMP testing
d7a64c4517 da62b507a2 Stefan Hajnoczi:
 iotests: add filter_qmp_generated_node_ids()
cf70966523 a9c8ea9547 Ari Sundholm:
 block/blklogwrites: Fix a bug when logging "write zeroes" operations.
939a09575f 2220e8189f Jason Wang:
 virtio-net: correctly copy vnet header when flushing TX
6f6492ab07 9f6523e8e4 Joseph Burt:
 tcg/arm: Fix SIGILL in tcg_out_qemu_st_direct
1e0f028de7 1b21fe27e7 Richard Henderson:
 linux-user/riscv: Adjust vdso signal frame cfa offsets
8bdd3abcf1 6d913158b5 Robbin Ehn:
 linux-user: Fixed cpu restore with pc 0 on SIGBUS
99dd4a1563 8a9be79924 Fiona Ebner:
 block/io: clear BDRV_BLOCK_RECURSE flag after recursing in bdrv_co_block_status
f413f9fcc9 d9945ccda0 Akihiko Odaki:
 coroutine-ucontext: Save fake stack for pooled coroutine
005d7236db c1ddc18f37 Richard Henderson:
 tcg/s390x: Fix encoding of VRIc, VRSa, VRSc insns
ef74024b76 Paolo Bonzini:
 accel/tcg: Revert mapping of PCREL translation block to multiple virtual addresses
5e4e438f9d 7ef4c41e91 Ani Sinha:
 acpi/tests/avocado/bits: wait for 200 seconds for SHUTDOWN event from bits VM
003d0c7eb4 68c691ca99 Matthew Rosato:
 s390x/pci: drive ISM reset from subsystem reset
c2985e38d8 30e35258e2 Matthew Rosato:
 s390x/pci: refresh fh before disabling aif
9d6dd12b1d 07b2c8e034 Matthew Rosato:
 s390x/pci: avoid double enable/disable of aif
164e6f7d66 c2d7de557d Mark Cave-Ayland:
 hw/scsi/esp-pci: set DMA_STAT_BCMBLT when BLAST command issued
06a28b783b 1e8e6644e0 Mark Cave-Ayland:
 hw/scsi/esp-pci: synchronise setting of DMA_STAT_DONE with ESP completion interrupt
d8e0533c94 6b41417d93 Mark Cave-Ayland:
 hw/scsi/esp-pci: generate PCI interrupt from separate ESP and PCI sources
2d81285db1 84a6835e00 Mark Cave-Ayland:
 hw/scsi/esp-pci: use correct address register for PCI DMA transfers
3f675950df 44ce1b5d2f Nick Briggs:
 migration/rdma: define htonll/ntohll only if not predefined
1fc277a0e8 284a7ee2e2 Gerd Hoffmann:
 hw/pflash: implement update buffer for block writes
143d230d51 5dd58358a5 Gerd Hoffmann:
 hw/pflash: use ldn_{be,le}_p and stn_{be,le}_p
731783ff1e 3b14a555fd Gerd Hoffmann:
 hw/pflash: refactor pflash_data_write()
a4daea6f9f 484aecf2d3 Philippe Mathieu-Daudé:
 backends/cryptodev: Do not ignore throttle/backends Errors
c46f68bd7d 729ba8e933 Paolo Bonzini:
 target/i386: pcrel: store low bits of physical address in data[0]
652c34cbb2 2926eab896 guoguangyao:
 target/i386: fix incorrect EIP in PC-relative translation blocks
6e8e580e39 a58506b748 Richard Henderson:
 target/i386: Do not re-compute new pc with CF_PCREL
72dd722370 410c2a4d75 Anastasia Belova:
 load_elf: fix iterator's type for elf file processing
872377f264 4bda8224fa Helge Deller:
 target/hppa: Update SeaBIOS-hppa to version 15
067aa95c47 31efbe72c6 Helge Deller:
 target/hppa: Fix IOR and ISR on error in probe
abf489be5a 910ada0225 Helge Deller:
 target/hppa: Fix IOR and ISR on unaligned access trap
4b3064ec90 3824e0d643 Helge Deller:
 target/hppa: Export function hppa_set_ior_and_isr()
27cdd0ce47 5915b67013 Helge Deller:
 target/hppa: Avoid accessing %gr0 when raising exception
0f5fb24fd7 ed35afcb33 Helge Deller:
 hw/hppa: Move software power button address back into PDC
aeee512d17 6ce18d5306 Helge Deller:
 target/hppa: Fix PDC address translation on PA2.0 with PSW.W=0
ad70198043 3b57c15f02 Helge Deller:
 hw/pci-host/astro: Add missing astro & elroy registers for NetBSD
4e68f4124f d8a3220005 Helge Deller:
 hw/hppa/machine: Disable default devices with --nodefaults option
de64580f07 92039f61af Helge Deller:
 hw/hppa/machine: Allow up to 3840 MB total memory
35623388b0 b16a45bc5e Alex Bennée:
 readthodocs: fully specify a build environment
32ade2abef 52a21689cd Peter Maydell:
 .gitlab-ci.d/buildtest.yml: Work around htags bug when environment is large
08b37c90e6 e358a25a97 Ilya Leoshkevich:
 target/s390x: Fix LAE setting a wrong access register
0b27f20d6a c98873ee4a Samuel Tardieu:
 tests/qtest/virtio-ccw: Fix device presence checking
2dd8fdfe49 704f7cad51 Gerd Hoffmann:
 tests/acpi: disallow tests/data/acpi/virt/SSDT.memhp changes
19144a80c9 55abfc1ffb Gerd Hoffmann:
 tests/acpi: update expected data files
02b01b3925 5058720151 Gerd Hoffmann:
 edk2: update binaries to git snapshot
3b1b25cdaa 6f79fa5f09 Gerd Hoffmann:
 edk2: update build config, set PcdUninstallMemAttrProtocol = TRUE.
62aef3312e c366741258 Gerd Hoffmann:
 edk2: update to git snapshot
4e875df3b6 ca8b0cc8e9 Gerd Hoffmann:
 tests/acpi: allow tests/data/acpi/virt/SSDT.memhp changes
9ee4603a86 1d513e06d9 Natanael Copa:
 util: fix build with musl libc on ppc64le
b881910859 ca5bed07d0 Richard Henderson:
 tcg/ppc: Use new registers for LQ destination
a68fc9dbde 82a65e3188 Peter Maydell:
 hw/intc/arm_gicv3_cpuif: handle LPIs in in the list registers
ae59465866 9353b6da43 Volker Rümelin:
 hw/vfio: fix iteration over global VFIODevice list
5f64bed67c 213ae3ffda Cédric Le Goater:
 vfio/container: Replace basename with g_path_get_basename
0bf355e6ca 2c5107e1b4 Max Erenberg:
 edu: fix DMA range upper bound check
6e3cfd598c 0c7ffc9771 Bin Meng:
 hw/net: cadence_gem: Fix MDIO_OP_xxx values
5713d6dd76 09a36158c2 Michael Tokarev:
 audio/audio.c: remove trailing newline in error_setg
0965e5eda5 4ad87cd4b2 Michael Tokarev:
 chardev/char.c: fix "abstract device type" error message
882950efd2 5cb0e7abe1 Xu Lu:
 target/riscv: Fix mcycle/minstret increment behavior
7b57e6d434 25145a7d77 Pavel Pisa:
 hw/net/can/sja1000: fix bug for single acceptance filter and standard frame
e649de10d5 2196157404 Paolo Bonzini:
 target/i386: the sgx_epc_get_section stub is reachable
bb28ee11c2 007531586a Paolo Bonzini:
 configure: use a native non-cross compiler for linux-user
a331dc62ad 9d5b42beb6 Elen Avan:
 include/ui/rect.h: fix qemu_rect_init() mis-assignment
7d6a2ce8cf d424db2354 Natanael Copa:
 target/riscv/kvm: do not use non-portable strerrorname_np()
11b0730d60 bb6e2511eb Kevin Wolf:
 iotests: Basic tests for internal snapshots
64537ff11f 5a7f21efaf Kevin Wolf:
 vl: Improve error message for conflicting -incoming and -loadvm
e2e01b3a77 d3007d348a Kevin Wolf:
 block: Fix crash when loading snapshot on inactive node

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEe3O61ovnosKJMUsicBtPaxppPlkFAmW4CW4ACgkQcBtPaxpp
PlnAnAgAnbenGCN+SPT60sGGHrztS7sdCSxvF3ZFsJCKMse2jwtid+vx+b3kyhTy
X/4MGtIL4628icE5X9yEHW1gFYt/K0BlJv71I/yUUqlXif0qtuosDzAR1KRjXQ2R
phBFyUcIxpvEv2CZEIXjbqk/wYZxnbnLxHs+ZcI4+xHuMg6Z66+u6GS47VEkvWVb
YyfznfUW7COte6QPJ/QswUMKYKPbFWVNIBtFChtAL32GgwlAWS2CY51fRIvpzFtD
hoM7SjpSXsIzVbItiCRJ3nobGCB2XMfYqFMiL7/LbBUYph5j3F6MABzHOfGzTt66
4PX83ZmILAia53gMvl/N1PpLQsAmvA==
=kPM7
-----END PGP SIGNATURE-----

