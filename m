Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C057FC3ABDD
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 19:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFHNc-0006vD-Ba; Wed, 14 May 2025 15:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFHLU-0004A5-5z; Wed, 14 May 2025 15:00:52 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFHLR-0007FF-Rt; Wed, 14 May 2025 15:00:47 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DF6B9121D8A;
 Wed, 14 May 2025 22:00:31 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E4F0120BA7C;
 Wed, 14 May 2025 22:00:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.1 00/23] Patch Round-up for stable 10.0.1,
 freeze on 2025-05-24
Date: Wed, 14 May 2025 22:00:12 +0300
Message-Id: <qemu-stable-10.0.1-20250514114019@cover.tls.msk.ru>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

The following patches are queued for QEMU stable v10.0.1:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-10.0

Patch freeze is 2025-05-24, and the release is planned for 2025-05-26:

  https://wiki.qemu.org/Planning/10.0

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 280712b78781 Ewan Hai:
   target/i386: Fix model number of Zhaoxin YongFeng vCPU template
02 f6b5f71f0452 Maciej S. Szmigiero:
   target/i386: Reset parked vCPUs together with the online ones
03 94a159f3dc73 Paolo Bonzini:
   target/i386/hvf: fix lflags_to_rflags
04 6b661b7ed7cd Richard Henderson:
   target/avr: Improve decode of LDS, STS
05 d5f241834be1 Philippe Mathieu-Daudé:
   hw/core: Get default_cpu_type calling machine_class_default_cpu_type()
06 56a9f0d4c4a4 Peter Maydell:
   hw/core/cpu: gdb_arch_name string should not be freed
07 d4a785ba30ce Hauke Mehrtens:
   target/mips: Fix MIPS16e translation
08 563cd698dffb Akihiko Odaki:
   meson: Use has_header_symbol() to check getcpu()
09 6804b89fb531 Akihiko Odaki:
   meson: Remove CONFIG_STATX and CONFIG_STATX_MNT_ID
10 797150d69d2e Akihiko Odaki:
   meson: Share common C source prefixes
11 a5b30be53453 Akihiko Odaki:
   meson: Use osdep_prefix for strchrnul()
12 9401f91b9b0c Richard Henderson:
   accel/tcg: Don't use TARGET_LONG_BITS in decode_sleb128
13 97cdd1b0a7a0 Tim Lee:
   hw/arm/npcm8xx_boards: Correct valid_cpu_types setting of NPCM8XX SoC
14 8ed7c0b6488a Peter Maydell:
   target/arm: Don't assert() for ISB/SB inside IT block
15 82707dd4f076 Peter Maydell:
   docs: Don't define duplicate label in qemu-block-drivers.rst.inc
16 eba837a31b95 Bernhard Beschow:
   hw/gpio/imx_gpio: Fix interpretation of GDIR polarity
17 e54ef98c8a80 Paolo Bonzini:
   target/i386: do not trigger IRQ shadow for LSS
18 1e94ddc68544 Paolo Bonzini:
   target/i386: do not block singlestep for STI
19 a4b20f737cda Aleksandr Partanen:
   xen: mapcache: Fix finding matching entry
20 88fb705600a3 Edgar E. Iglesias:
   xen: mapcache: Split mapcache_grants by ro and rw
21 54e54e594bc8 Bernhard Beschow:
   hw/i2c/imx: Always set interrupt status bit if interrupt condition occurs
22 61da38db70af Christian Schoenebeck:
   9pfs: fix concurrent v9fs_reclaim_fd() calls
23 89f7b4da7662 Christian Schoenebeck:
   9pfs: fix FD leak and reduce latency of v9fs_reclaim_fd()

