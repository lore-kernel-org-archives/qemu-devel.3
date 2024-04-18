Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE8DC05023
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 20:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXxw-0001Vx-C5; Thu, 18 Apr 2024 16:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxXxn-0001UO-O8; Thu, 18 Apr 2024 16:02:33 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxXxl-0005Fq-HD; Thu, 18 Apr 2024 16:02:31 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2DBB95FE08;
 Thu, 18 Apr 2024 23:02:27 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 87E58B93EE;
 Thu, 18 Apr 2024 23:02:24 +0300 (MSK)
Received: (nullmailer pid 952837 invoked by uid 1000);
 Thu, 18 Apr 2024 20:02:24 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.11 v2 00/59] Patch Round-up for stable 7.2.11,
 freeze on 2024-04-20
Date: Thu, 18 Apr 2024 23:02:01 +0300
Message-Id: <qemu-stable-7.2.11-20240418230159@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v7.2.11:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-7.2

Patch freeze is 2024-04-20, and the release is planned for 2024-04-22:

  https://wiki.qemu.org/Planning/7.2

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* 9ea920dc2825 Daniel P. Berrangé:
   gitlab: update FreeBSD Cirrus CI image to 13.3
02* f5af80271aad David Parsons:
   ui/cocoa: Fix window clipping on macOS 14
03* bc6bd20ee353 Zhuojia Shen:
   target/arm: align exposed ID registers with Linux
04* 3dc2afeab296 Peter Maydell:
   tests/tcg/aarch64/sysregs.c: Use S syntax for id_aa64zfr0_el1 and 
   id_aa64smfr0_el1
05* 1f51573f7925 Richard Henderson:
   target/arm: Fix SME full tile indexing
06* fd7f95f23d6f Peter Maydell:
   hw/rtc/sun4v-rtc: Relicense to GPLv2-or-later
07* 012b170173bc Dmitrii Gavrilov:
   system/qdev-monitor: move drain_call_rcu call under if (!dev) in 
   qmp_device_add()
08* a9198b3132d8 Sven Schnelle:
   hw/scsi/lsi53c895a: stop script on phase mismatch
09* 8b09b7fe4708 Sven Schnelle:
   hw/scsi/lsi53c895a: add missing decrement of reentrancy counter
10* 9876359990dd Sven Schnelle:
   hw/scsi/lsi53c895a: add timer to scripts processing
11* 9bc9e9511944 Michael Tokarev:
   make-release: switch to .xz format by default
12* 4cadf1023498 Laurent Vivier:
   e1000e: fix link state on resume
13* 6a5287ce8047 Nick Briggs:
   Avoid unaligned fetch in ladr_match()
14* 784fd35387e9 Klaus Jensen:
   hw/nvme: clean up confusing use of errp/local_err
15* 973f76cf7743 Klaus Jensen:
   hw/nvme: cleanup error reporting in nvme_init_pci()
16* 4f0a4a3d5854 Minwoo Im:
   hw/nvme: separate 'serial' property for VFs
17* ee7bda4d38cd Klaus Jensen:
   hw/nvme: generalize the mbar size helper
18* fa905f65c554 Klaus Jensen:
   hw/nvme: add machine compatibility parameter to enable msix exclusive bar
19* 31180dbdca28 Akihiko Odaki:
   pcie: Introduce pcie_sriov_num_vfs
20* 91bb64a8d201 Akihiko Odaki:
   hw/nvme: Use pcie_sriov_num_vfs()
21* 6081b4243cd6 Akihiko Odaki:
   pcie_sriov: Validate NumVFs
22* 74e2845c5f95 Jonathan Cameron:
   hmat acpi: Fix out of bounds access due to missing use of indirection
23* 2e128776dc56 Cédric Le Goater:
   migration: Skip only empty block devices
24* c45f8f1aef35 Thomas Huth:
   tests/unit: Bump test-aio-multithread test timeout to 2 minutes
25* e1b363e328d5 Thomas Huth:
   tests/unit: Bump test-crypto-block test timeout to 5 minutes
26* 63b18312d14a Kevin Wolf:
   tests/unit: Bump test-replication timeout to 60 seconds
27* 55f7c6a5f2bd Peter Maydell:
   tests: Raise timeouts for bufferiszero and crypto-tlscredsx509
28* 5f97afe2543f Paolo Bonzini:
   target/i386: introduce function to query MMU indices
29* 90f641531c78 Paolo Bonzini:
   target/i386: use separate MMU indexes for 32-bit accesses
30* 2cc68629a6fc Paolo Bonzini:
   target/i386: fix direction of "32-bit MMU" test
31* 7fd226b04746 Tao Su:
   target/i386: Revert monitor_puts() in do_inject_x86_mce()
32* 1590154ee437 Song Gao:
   target/loongarch: Fix qemu-system-loongarch64 assert failed with the 
   option '-d int'
33* 7c7a9f578e4f Lorenz Brun:
   hw/scsi/scsi-generic: Fix io_timeout property not applying
34* a158c63b3ba1 Yao Xingtao:
   monitor/hmp-cmds-target: Append a space in error message in gpa2hva()
35* 1c188fc8cbff Akihiko Odaki:
   virtio-net: Fix vhost virtqueue notifiers for RSS
36* 2911e9b95f3b Richard Henderson:
   tcg/optimize: Fix sign_mask for logical right-shift
37* 4a3aa11e1fb2 Richard Henderson:
   target/hppa: Clear psw_n for BE on use_nullify_skip path
38* 1d2f2b35bc86 Michael Tokarev:
   gitlab-ci/cirrus: switch from 'master' to 'latest'
39* 44e25fbc1900 Peter Maydell:
   hw/intc/arm_gicv3: ICC_HPPIR* return SPURIOUS if int group is disabled
40* 4c54f5bc8e1d Yajun Wu:
   hw/net/virtio-net: fix qemu set used ring flag even vhost started
41* 2d9a31b3c273 Wafer:
   hw/virtio: Fix packed virtqueue flush used_idx
42 e25fe886b89a Richard Henderson:
   tcg/optimize: Do not attempt to constant fold neg_vec
43 f0907ff4cae7 Richard Henderson:
   linux-user: Fix waitid return of siginfo_t and rusage
44 ec0504b989ca Philippe Mathieu-Daudé:
   hw/virtio: Introduce virtio_bh_new_guarded() helper
45 ba28e0ff4d95 Philippe Mathieu-Daudé:
   hw/display/virtio-gpu: Protect from DMA re-entrancy bugs
46 b4295bff25f7 Philippe Mathieu-Daudé:
   hw/char/virtio-serial-bus: Protect from DMA re-entrancy bugs
47 f4729ec39ad9 Philippe Mathieu-Daudé:
   hw/virtio/virtio-crypto: Protect from DMA re-entrancy bugs
48 aa88f99c87c0 Yuquan Wang:
   qemu-options: Fix CXL Fixed Memory Window interleave-granularity typo
49 7a86544f286d Philippe Mathieu-Daudé:
   hw/block/nand: Factor nand_load_iolen() method out
50 2e3e09b36800 Philippe Mathieu-Daudé:
   hw/block/nand: Have blk_load() take unsigned offset and return boolean
51 d39fdfff348f Philippe Mathieu-Daudé:
   hw/block/nand: Fix out-of-bound access in NAND block buffer
52 fc09ff2979de Philippe Mathieu-Daudé:
   hw/misc/applesmc: Fix memory leak in reset() handler
53 eaf2bd29538d Philippe Mathieu-Daudé:
   backends/cryptodev: Do not abort for invalid session ID
54 ad766d603f39 Philippe Mathieu-Daudé:
   hw/net/lan9118: Fix overflow in MIL TX FIFO
55 a45223467e4e Philippe Mathieu-Daudé:
   hw/net/lan9118: Replace magic '2048' value by MIL_TXFIFO_SIZE definition
56 9e4b27ca6bf4 Philippe Mathieu-Daudé:
   hw/sd/sdhci: Do not update TRNMOD when Command Inhibit (DAT) is set
57 b754cb2dcde2 Zack Buhman:
   target/sh4: add missing CHECK_NOT_DELAY_SLOT
58 2df5c1f5b014 Harsh Prateek Bora:
   ppc/spapr: Introduce SPAPR_IRQ_NR_IPIS to refer IRQ range for CPU IPIs.
59 c4f91d7b7be7 Harsh Prateek Bora:
   ppc/spapr: Initialize max_cpus limit to SPAPR_IRQ_NR_IPIS.

(commit(s) marked with * were in previous series and are not resent)

