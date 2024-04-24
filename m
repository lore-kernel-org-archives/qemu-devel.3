Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9271DC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzgai-0001MR-LH; Wed, 24 Apr 2024 13:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rzgaL-0001KB-Ke; Wed, 24 Apr 2024 13:39:11 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rzgaH-0003uX-7I; Wed, 24 Apr 2024 13:39:07 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 135CA61824;
 Wed, 24 Apr 2024 20:39:10 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B9C31BE61C;
 Wed, 24 Apr 2024 20:39:02 +0300 (MSK)
Received: (nullmailer pid 1218348 invoked by uid 1000);
 Wed, 24 Apr 2024 17:39:01 -0000
Subject: [ANNOUNCE] QEMU 8.2.3 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Date: Wed, 24 Apr 2024 20:39:01 +0300
Message-Id: <1713980341.971368.1218343.nullmailer@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi everyone,

The QEMU v8.2.3 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-8.2.3.tar.xz
  https://download.qemu.org/qemu-8.2.3.tar.xz.sig (signature)

v8.2.3 is now tagged in the official qemu.git repository, and the
stable-8.2 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-8.2

There are 116 changes since the previous v8.2.2 release.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-8.2-hash master-hash Author Name: Commmit-Subject):

8216663a5c Michael Tokarev:
 Update version for 8.2.3 release
51da750063 c4f91d7b7b Harsh Prateek Bora:
 ppc/spapr: Initialize max_cpus limit to SPAPR_IRQ_NR_IPIS.
c513ee1b91 2df5c1f5b0 Harsh Prateek Bora:
 ppc/spapr: Introduce SPAPR_IRQ_NR_IPIS to refer IRQ range for CPU IPIs.
1a78b89bcf 6e4aceba20 BALATON Zoltan:
 hw/pci-host/ppc440_pcix: Do not expose a bridge device on PCI bus
dd784cb65d f33274265a BALATON Zoltan:
 hw/isa/vt82c686: Keep track of PIRQ/PINT pins separately
fcbb086ae5 2ce6cff94d Cindy Lu:
 virtio-pci: fix use of a released vector
6e29509abc 4ef1f559f2 Richard Henderson:
 linux-user/x86_64: Handle the vsyscall page in open_self_maps_{2,4}
e2dfadfd07 dcb0a1ac03 Philippe Mathieu-Daudé:
 hw/audio/virtio-snd: Remove unused assignment
1cfe45956e 83ddb3dbba Philippe Mathieu-Daudé:
 hw/net/net_tx_pkt: Fix overrun in update_sctp_checksum()
35a67d2aa8 9e4b27ca6b Philippe Mathieu-Daudé:
 hw/sd/sdhci: Do not update TRNMOD when Command Inhibit (DAT) is set
9666bd2b79 ad766d603f Philippe Mathieu-Daudé:
 hw/net/lan9118: Fix overflow in MIL TX FIFO
4e6240e184 a45223467e Philippe Mathieu-Daudé:
 hw/net/lan9118: Replace magic '2048' value by MIL_TXFIFO_SIZE definition
516bdbc234 eaf2bd2953 Philippe Mathieu-Daudé:
 backends/cryptodev: Do not abort for invalid session ID
1c5005c450 fc09ff2979 Philippe Mathieu-Daudé:
 hw/misc/applesmc: Fix memory leak in reset() handler
6e7e387b79 d39fdfff34 Philippe Mathieu-Daudé:
 hw/block/nand: Fix out-of-bound access in NAND block buffer
ab995895ad 2e3e09b368 Philippe Mathieu-Daudé:
 hw/block/nand: Have blk_load() take unsigned offset and return boolean
15b41461ea 7a86544f28 Philippe Mathieu-Daudé:
 hw/block/nand: Factor nand_load_iolen() method out
5d53ff200b aa88f99c87 Yuquan Wang:
 qemu-options: Fix CXL Fixed Memory Window interleave-granularity typo
4f01537ced f4729ec39a Philippe Mathieu-Daudé:
 hw/virtio/virtio-crypto: Protect from DMA re-entrancy bugs
fbeb0a160c b4295bff25 Philippe Mathieu-Daudé:
 hw/char/virtio-serial-bus: Protect from DMA re-entrancy bugs
1b2a52712b ba28e0ff4d Philippe Mathieu-Daudé:
 hw/display/virtio-gpu: Protect from DMA re-entrancy bugs
eb546a3f49 ec0504b989 Philippe Mathieu-Daudé:
 hw/virtio: Introduce virtio_bh_new_guarded() helper
390da29ce5 5888357942 Keith Packard:
 target/m68k: Map FPU exceptions to FPSR register
0764b8a8e3 b754cb2dcd Zack Buhman:
 target/sh4: add missing CHECK_NOT_DELAY_SLOT
733511728a 7227c0cd50 Zack Buhman:
 target/sh4: Fix mac.w with saturation enabled
77e03229ca c97e8977dc Zack Buhman:
 target/sh4: Fix mac.l with saturation enabled
7fc1bcb65f 7d95db5e78 Richard Henderson:
 target/sh4: Merge mach and macl into a union
be88ed87a6 b0f2f2976b Zack Buhman:
 target/sh4: mac.w: memory accesses are 16-bit words
c02844b8e8 f0907ff4ca Richard Henderson:
 linux-user: Fix waitid return of siginfo_t and rusage
196601e759 e25fe886b8 Richard Henderson:
 tcg/optimize: Do not attempt to constant fold neg_vec
20cd0c8655 731655f87f Manos Pitsidianakis:
 virtio-snd: rewrite invalid tx/rx message handling
627aa460ba a45f09935c Zheyu Ma:
 virtio-snd: Enhance error handling for invalid transfers
cd461c8445 6ae72f609a lyx634449800:
 vdpa-dev: Fix the issue of device status not updating when configuration interruption is triggered
b57b102a81 2d9a31b3c2 Wafer:
 hw/virtio: Fix packed virtqueue flush used_idx
f7a1ff69ba 19b254e86a Peter Maydell:
 target/arm: Use correct SecuritySpace for AArch64 AT ops at EL3
6983d1657d 7afbdada7e Wei Wang:
 migration/postcopy: ensure preempt channel is ready before loading states
46f03be3ed bbdf902366 Zheyu Ma:
 block/virtio-blk: Fix memory leak from virtio_blk_zone_report
9c2b8194ac 4c54f5bc8e Yajun Wu:
 hw/net/virtio-net: fix qemu set used ring flag even vhost started
e961fa43e9 fbe5ac5671 Peter Maydell:
 target/arm: take HSTR traps of cp15 accesses to EL2, not EL1
2702763548 44e25fbc19 Peter Maydell:
 hw/intc/arm_gicv3: ICC_HPPIR* return SPURIOUS if int group is disabled
2befb8a9c7 1d2f2b35bc Michael Tokarev:
 gitlab-ci/cirrus: switch from 'master' to 'latest'
3168476965 d0ad271a76 Avihai Horon:
 migration/postcopy: Ensure postcopy_start() sets errp if it fails
35fface50f 4a3aa11e1f Richard Henderson:
 target/hppa: Clear psw_n for BE on use_nullify_skip path
3cdfd68e4e 2911e9b95f Richard Henderson:
 tcg/optimize: Fix sign_mask for logical right-shift
d3e9e0fb29 89a8de364b Akihiko Odaki:
 hw/net/net_tx_pkt: Fix virtio header without checksum offloading
12e4886108 1c188fc8cb Akihiko Odaki:
 virtio-net: Fix vhost virtqueue notifiers for RSS
1e4ec0958e 385e575cd5 Yong-Xuan Wang:
 target/riscv/kvm: fix timebase-frequency when using KVM acceleration
38f36fc568 e06adebb08 Irina Ryapolova:
 target/riscv: Fix mode in riscv_tlb_fill
dc2abb61af c9b07fe14d Max Chou:
 target/riscv: rvv: Remove the dependency of Zvfbfmin to Zfbfmin
6c49ccaaba 078189b327 Frank Chang:
 hw/intc: Update APLIC IDC after claiming iforce register
b7ff2c5600 0a11629c91 Daniel Henrique Barboza:
 target/riscv/vector_helper.c: optimize loops in ldst helpers
c4ed8c5610 df4252b2ec Daniel Henrique Barboza:
 target/riscv/vector_helpers: do early exit when vstart >= vl
43ca6c1a9b 7e53e3ddf6 Daniel Henrique Barboza:
 target/riscv: always clear vstart in whole vec move insns
693ceca987 768e7b329c Daniel Henrique Barboza:
 target/riscv/vector_helper.c: fix 'vmvr_v' memcpy endianess
9f0db88ca9 0848f7c18e Daniel Henrique Barboza:
 trans_rvv.c.inc: set vstart = 0 in int scalar move insns
bf26b6acc1 d3646e31ce Daniel Henrique Barboza:
 target/riscv/vector_helper.c: set vstart = 0 in GEN_VEXT_VSLIDEUP_VX()
0041b5a014 a158c63b3b Yao Xingtao:
 monitor/hmp-cmds-target: Append a space in error message in gpa2hva()
783b2fc0a9 7c7a9f578e Lorenz Brun:
 hw/scsi/scsi-generic: Fix io_timeout property not applying
78bebf8692 9dab7bbb01 Gregory Price:
 target/i386/tcg: Enable page walking from MMIO memory
eaa20895b7 12d7b3bbd3 Fiona Ebner:
 iotests: add test for stream job with an unaligned prefetch read
edba203229 bac09b093e Fiona Ebner:
 block-backend: fix edge case in bdrv_next_cleanup() where BDS associated to BB changes
1652e5b97f f6d38c9f6d Fiona Ebner:
 block-backend: fix edge case in bdrv_next() where BDS associated to BB changes
80ccf1e485 3f934817c8 Stefan Reiter:
 block/io: accept NULL qiov in bdrv_pad_request
73d604a4bc 2c66de61f8 Kevin Wolf:
 vdpa-dev: Fix initialisation order to restore VDUSE compatibility
784ebe52bd 272fba9779 Ido Plat:
 target/s390x: Use mutable temporary value for op_ts
ef9b43bb8e 1590154ee4 Song Gao:
 target/loongarch: Fix qemu-system-loongarch64 assert failed with the option '-d int'
358dd25fb0 eb844330bd Thomas Huth:
 docs/conf.py: Remove usage of distutils
5b51920fbd 77642f92c0 Song Gao:
 target/loongarch: Fix qemu-loongarch64 hang when executing 'll.d $t0, $t0, 0'
242370f8bd 518d2f4300 Sven Schnelle:
 target/hppa: fix do_stdby_e()
b0a0ec47ba b5e0b3a53c Sven Schnelle:
 target/hppa: mask privilege bits in mfia
e3b3cff998 ad1fdacd1b Sven Schnelle:
 target/hppa: exit tb on flush cache instructions
4dbeff3d48 ae157fc250 Sven Schnelle:
 target/hppa: fix access_id check
ca52ee4a9b d37fad0ae5 Sven Schnelle:
 target/hppa: fix shrp for wide mode
4a76c5665b c3ea1996a1 Sven Schnelle:
 target/hppa: ldcw,s uses static shift of 3
de74e73d91 46174e140d Richard Henderson:
 target/hppa: Fix assemble_12a insns for wide mode
efbcf7cead 4768c28edd Richard Henderson:
 target/hppa: Fix assemble_11a insns for wide mode
f6f4703c5a 72bace2d13 Richard Henderson:
 target/hppa: Fix assemble_16 insns for wide mode
cf794e4774 7fd226b047 Tao Su:
 target/i386: Revert monitor_puts() in do_inject_x86_mce()
f8fb5928a8 d4069a84a3 Marc-André Lureau:
 ui: compile dbus-display1.c with -fPIC as necessary
de742b16b3 e8ee827ffd Daniel P. Berrangé:
 Revert "chardev/char-socket: Fix TLS io channels sending too much data to the backend"
509525dc67 2cc68629a6 Paolo Bonzini:
 target/i386: fix direction of "32-bit MMU" test
1ced8cd541 90f641531c Paolo Bonzini:
 target/i386: use separate MMU indexes for 32-bit accesses
a85b8ec872 5f97afe254 Paolo Bonzini:
 target/i386: introduce function to query MMU indices
25bdc64b62 63b18312d1 Kevin Wolf:
 tests/unit: Bump test-replication timeout to 60 seconds
96ff214a2a e1b363e328 Thomas Huth:
 tests/unit: Bump test-crypto-block test timeout to 5 minutes
2a1ce7c374 c45f8f1aef Thomas Huth:
 tests/unit: Bump test-aio-multithread test timeout to 2 minutes
ddf4412bf4 e8fce34ecc Kevin Wolf:
 iotests: Add test for reset/AioContext switches with NBD exports
a69a002dcd 9c707525cb Kevin Wolf:
 nbd/server: Fix race in draining the export
13fc21ae3d 7075d23511 Stefan Hajnoczi:
 nbd/server: introduce NBDClient->lock to protect fields
aee1039c61 f816310d0c Stefan Hajnoczi:
 nbd/server: only traverse NBDExport->clients from main loop thread
0d835791f0 ae5a40e858 Kevin Wolf:
 mirror: Don't call job_pause_point() under graph lock
8996768ebc 2e128776dc Cédric Le Goater:
 migration: Skip only empty block devices
7820b9b7a0 633487df8d Volker Rümelin:
 hw/audio/virtio-sound: return correct command response size
b5c6660ea6 74e2845c5f Jonathan Cameron:
 hmat acpi: Fix out of bounds access due to missing use of indirection
313e746958 6081b4243c Akihiko Odaki:
 pcie_sriov: Validate NumVFs
98f3488c1b 91bb64a8d2 Akihiko Odaki:
 hw/nvme: Use pcie_sriov_num_vfs()
3097bcbf37 fa905f65c5 Klaus Jensen:
 hw/nvme: add machine compatibility parameter to enable msix exclusive bar
273111ca71 ee7bda4d38 Klaus Jensen:
 hw/nvme: generalize the mbar size helper
389f6655ca 8c78015a55 Klaus Jensen:
 hw/nvme: fix invalid check on mcl
2d281e030d 4f0a4a3d58 Minwoo Im:
 hw/nvme: separate 'serial' property for VFs
35ca0f7cbc 9253d83062 Peng Fan:
 xen: Drop out of coroutine context xen_invalidate_map_cache_entry
31e20693ea 6a5287ce80 Nick Briggs:
 Avoid unaligned fetch in ladr_match()
0ba8be81f8 4cadf10234 Laurent Vivier:
 e1000e: fix link state on resume
c440c89ecb 65c2ab8085 Laurent Vivier:
 igb: fix link state on resume
6ad78a085e 69f7b00d05 Yu Zhang:
 migration/rdma: Fix a memory issue for migration
8f1eb52422 9bc9e95119 Michael Tokarev:
 make-release: switch to .xz format by default
5ae5473e2e 9876359990 Sven Schnelle:
 hw/scsi/lsi53c895a: add timer to scripts processing
37a8b9205f a9198b3132 Sven Schnelle:
 hw/scsi/lsi53c895a: stop script on phase mismatch
5dc46b3ff8 012b170173 Dmitrii Gavrilov:
 system/qdev-monitor: move drain_call_rcu call under if (!dev) in qmp_device_add()
4db93405e5 fd7f95f23d Peter Maydell:
 hw/rtc/sun4v-rtc: Relicense to GPLv2-or-later
f0ae5d6d5f d572bcb222 Richard Henderson:
 target/arm: Fix 32-bit SMOPA
81c0ebf107 f5af80271a David Parsons:
 ui/cocoa: Fix window clipping on macOS 14
94b544f127 9ea920dc28 Daniel P. Berrangé:
 gitlab: update FreeBSD Cirrus CI image to 13.3
420a8d8735 b816e1b5ba Richard Henderson:
 linux-user: Remove pgb_dynamic alignment assertion
151d593c7d 7f89fdf8eb Richard Henderson:
 tcg/aarch64: Apple does not align __int128_t in even registers
16f1f95ebd 15cc103362 Paolo Bonzini:
 configure: run plugin TCG tests again
eae7509be9 Michael Tokarev:
 Revert "configure: run plugin TCG tests again"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEe3O61ovnosKJMUsicBtPaxppPlkFAmYpQ7YACgkQcBtPaxpp
PlkZkAf+PhUZk8YRn+Q4QvYvMtrrm9Nl/OGXLtAR7RvaE9q5YLJwo1hPj4RMMkB8
ENWdlhbjdHvXqdI0KhVmlhpnsYkQgIldrzKhKXFiLhxl0UkPRwo8rdtOeSD+ssO1
iS547mguzaWxenCEWECNDsBbjcfHrAYmkFUPeonVbQYJYywVJLMkyBhgVageYxuK
aGrCcPaw01SwUTnMLnMLlNV8nKxtzd5sGdTIu3/UTKcqeYMEl/OhQSryxY6fIo3z
PmLMItSPLjcA5uttHI+NmQ/6tV2+CEXB/OzuULPAPfoEdH5tvqRgZjJYHHIfavaj
0+YIlV8FBLbCZGWqri9Gp+kDIwYnXQ==
=HwO7
-----END PGP SIGNATURE-----

