Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDB2CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSIc-0007Jy-Ns; Wed, 10 Apr 2024 03:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSIY-0007FW-Iw; Wed, 10 Apr 2024 03:23:10 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSIW-0003pS-AN; Wed, 10 Apr 2024 03:23:10 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 667C15D66F;
 Wed, 10 Apr 2024 10:25:02 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 06C6CB02B0;
 Wed, 10 Apr 2024 10:23:04 +0300 (MSK)
Received: (nullmailer pid 4191642 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:03 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 00/87] Patch Round-up for stable 8.2.3,
 freeze on 2024-04-20
Date: Wed, 10 Apr 2024 10:21:33 +0300
Message-Id: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v8.2.3:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-8.2

Patch freeze is 2024-04-20, and the release is planned for 2024-04-22:

  https://wiki.qemu.org/Planning/8.2

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 eae7509be9 Michael Tokarev:
   Revert "configure: run plugin TCG tests again"
02 15cc10336249 Paolo Bonzini:
   configure: run plugin TCG tests again
03 7f89fdf8ebe6 Richard Henderson:
   tcg/aarch64: Apple does not align __int128_t in even registers
04 b816e1b5ba58 Richard Henderson:
   linux-user: Remove pgb_dynamic alignment assertion
05 9ea920dc2825 Daniel P. Berrangé:
   gitlab: update FreeBSD Cirrus CI image to 13.3
06 f5af80271aad David Parsons:
   ui/cocoa: Fix window clipping on macOS 14
07 d572bcb22201 Richard Henderson:
   target/arm: Fix 32-bit SMOPA
08 fd7f95f23d6f Peter Maydell:
   hw/rtc/sun4v-rtc: Relicense to GPLv2-or-later
09 012b170173bc Dmitrii Gavrilov:
   system/qdev-monitor: move drain_call_rcu call under if (!dev) in 
   qmp_device_add()
10 a9198b3132d8 Sven Schnelle:
   hw/scsi/lsi53c895a: stop script on phase mismatch
11 9876359990dd Sven Schnelle:
   hw/scsi/lsi53c895a: add timer to scripts processing
12 9bc9e9511944 Michael Tokarev:
   make-release: switch to .xz format by default
13 69f7b00d057f Yu Zhang:
   migration/rdma: Fix a memory issue for migration
14 65c2ab808571 Laurent Vivier:
   igb: fix link state on resume
15 4cadf1023498 Laurent Vivier:
   e1000e: fix link state on resume
16 6a5287ce8047 Nick Briggs:
   Avoid unaligned fetch in ladr_match()
17 9253d8306226 Peng Fan:
   xen: Drop out of coroutine context xen_invalidate_map_cache_entry
18 4f0a4a3d5854 Minwoo Im:
   hw/nvme: separate 'serial' property for VFs
19 8c78015a55d8 Klaus Jensen:
   hw/nvme: fix invalid check on mcl
20 ee7bda4d38cd Klaus Jensen:
   hw/nvme: generalize the mbar size helper
21 fa905f65c554 Klaus Jensen:
   hw/nvme: add machine compatibility parameter to enable msix exclusive bar
22 91bb64a8d201 Akihiko Odaki:
   hw/nvme: Use pcie_sriov_num_vfs()
23 6081b4243cd6 Akihiko Odaki:
   pcie_sriov: Validate NumVFs
24 74e2845c5f95 Jonathan Cameron:
   hmat acpi: Fix out of bounds access due to missing use of indirection
25 633487df8d30 Volker Rümelin:
   hw/audio/virtio-sound: return correct command response size
26 2e128776dc56 Cédric Le Goater:
   migration: Skip only empty block devices
27 ae5a40e85811 Kevin Wolf:
   mirror: Don't call job_pause_point() under graph lock
28 f816310d0c32 Stefan Hajnoczi:
   nbd/server: only traverse NBDExport->clients from main loop thread
29 7075d235114b Stefan Hajnoczi:
   nbd/server: introduce NBDClient->lock to protect fields
30 9c707525cbb1 Kevin Wolf:
   nbd/server: Fix race in draining the export
31 e8fce34eccf6 Kevin Wolf:
   iotests: Add test for reset/AioContext switches with NBD exports
32 c45f8f1aef35 Thomas Huth:
   tests/unit: Bump test-aio-multithread test timeout to 2 minutes
33 e1b363e328d5 Thomas Huth:
   tests/unit: Bump test-crypto-block test timeout to 5 minutes
34 63b18312d14a Kevin Wolf:
   tests/unit: Bump test-replication timeout to 60 seconds
35 5f97afe2543f Paolo Bonzini:
   target/i386: introduce function to query MMU indices
36 90f641531c78 Paolo Bonzini:
   target/i386: use separate MMU indexes for 32-bit accesses
37 2cc68629a6fc Paolo Bonzini:
   target/i386: fix direction of "32-bit MMU" test
38 e8ee827ffdb8 Daniel P. Berrangé:
   Revert "chardev/char-socket: Fix TLS io channels sending too much data to 
   the backend"
39 d4069a84a338 Marc-André Lureau:
   ui: compile dbus-display1.c with -fPIC as necessary
40 7fd226b04746 Tao Su:
   target/i386: Revert monitor_puts() in do_inject_x86_mce()
41 72bace2d13cb Richard Henderson:
   target/hppa: Fix assemble_16 insns for wide mode
42 4768c28edd40 Richard Henderson:
   target/hppa: Fix assemble_11a insns for wide mode
43 46174e140d27 Richard Henderson:
   target/hppa: Fix assemble_12a insns for wide mode
44 c3ea1996a14d Sven Schnelle:
   target/hppa: ldcw,s uses static shift of 3
45 d37fad0ae5bd Sven Schnelle:
   target/hppa: fix shrp for wide mode
46 ae157fc25053 Sven Schnelle:
   target/hppa: fix access_id check
47 ad1fdacd1b93 Sven Schnelle:
   target/hppa: exit tb on flush cache instructions
48 b5e0b3a53c98 Sven Schnelle:
   target/hppa: mask privilege bits in mfia
49 518d2f4300e5 Sven Schnelle:
   target/hppa: fix do_stdby_e()
50 77642f92c0b7 Song Gao:
   target/loongarch: Fix qemu-loongarch64 hang when executing 'll.d $t0, 
   $t0, 0'
51 eb844330bd36 Thomas Huth:
   docs/conf.py: Remove usage of distutils
52 1590154ee437 Song Gao:
   target/loongarch: Fix qemu-system-loongarch64 assert failed with the 
   option '-d int'
53 272fba9779af Ido Plat:
   target/s390x: Use mutable temporary value for op_ts
54 2c66de61f88d Kevin Wolf:
   vdpa-dev: Fix initialisation order to restore VDUSE compatibility
55 3f934817c82c Stefan Reiter:
   block/io: accept NULL qiov in bdrv_pad_request
56 f6d38c9f6dae Fiona Ebner:
   block-backend: fix edge case in bdrv_next() where BDS associated to BB 
   changes
57 bac09b093ebb Fiona Ebner:
   block-backend: fix edge case in bdrv_next_cleanup() where BDS associated 
   to BB changes
58 12d7b3bbd333 Fiona Ebner:
   iotests: add test for stream job with an unaligned prefetch read
59 9dab7bbb017d Gregory Price:
   target/i386/tcg: Enable page walking from MMIO memory
60 7c7a9f578e4f Lorenz Brun:
   hw/scsi/scsi-generic: Fix io_timeout property not applying
61 a158c63b3ba1 Yao Xingtao:
   monitor/hmp-cmds-target: Append a space in error message in gpa2hva()
62 d3646e31ce6d Daniel Henrique Barboza:
   target/riscv/vector_helper.c: set vstart = 0 in GEN_VEXT_VSLIDEUP_VX()
63 0848f7c18ef5 Daniel Henrique Barboza:
   trans_rvv.c.inc: set vstart = 0 in int scalar move insns
64 768e7b329c0b Daniel Henrique Barboza:
   target/riscv/vector_helper.c: fix 'vmvr_v' memcpy endianess
65 7e53e3ddf6df Daniel Henrique Barboza:
   target/riscv: always clear vstart in whole vec move insns
66 df4252b2ecaf Daniel Henrique Barboza:
   target/riscv/vector_helpers: do early exit when vstart >= vl
67 0a11629c915f Daniel Henrique Barboza:
   target/riscv/vector_helper.c: optimize loops in ldst helpers
68 078189b327ae Frank Chang:
   hw/intc: Update APLIC IDC after claiming iforce register
69 c9b07fe14d35 Max Chou:
   target/riscv: rvv: Remove the dependency of Zvfbfmin to Zfbfmin
70 e06adebb0832 Irina Ryapolova:
   target/riscv: Fix mode in riscv_tlb_fill
71 385e575cd5ab Yong-Xuan Wang:
   target/riscv/kvm: fix timebase-frequency when using KVM acceleration
72 1c188fc8cbff Akihiko Odaki:
   virtio-net: Fix vhost virtqueue notifiers for RSS
73 89a8de364b51 Akihiko Odaki:
   hw/net/net_tx_pkt: Fix virtio header without checksum offloading
74 2911e9b95f3b Richard Henderson:
   tcg/optimize: Fix sign_mask for logical right-shift
75 4a3aa11e1fb2 Richard Henderson:
   target/hppa: Clear psw_n for BE on use_nullify_skip path
76 d0ad271a7613 Avihai Horon:
   migration/postcopy: Ensure postcopy_start() sets errp if it fails
77 1d2f2b35bc86 Michael Tokarev:
   gitlab-ci/cirrus: switch from 'master' to 'latest'
78 44e25fbc1900 Peter Maydell:
   hw/intc/arm_gicv3: ICC_HPPIR* return SPURIOUS if int group is disabled
79 fbe5ac5671a9 Peter Maydell:
   target/arm: take HSTR traps of cp15 accesses to EL2, not EL1
80 4c54f5bc8e1d Yajun Wu:
   hw/net/virtio-net: fix qemu set used ring flag even vhost started
81 bbdf9023665f Zheyu Ma:
   block/virtio-blk: Fix memory leak from virtio_blk_zone_report
82 7afbdada7eff Wei Wang:
   migration/postcopy: ensure preempt channel is ready before loading states
83 19b254e86a90 Peter Maydell:
   target/arm: Use correct SecuritySpace for AArch64 AT ops at EL3
84 2d9a31b3c273 Wafer:
   hw/virtio: Fix packed virtqueue flush used_idx
85 6ae72f609a21 lyx634449800:
   vdpa-dev: Fix the issue of device status not updating when configuration 
   interruption is triggered
86 a45f09935c88 Zheyu Ma:
   virtio-snd: Enhance error handling for invalid transfers
87 731655f87f31 Manos Pitsidianakis:
   virtio-snd: rewrite invalid tx/rx message handling

