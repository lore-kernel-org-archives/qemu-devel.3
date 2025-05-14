Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6654CC3ABD9
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFBfa-0000AQ-UN; Wed, 14 May 2025 08:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBfK-0008I3-Hi; Wed, 14 May 2025 08:56:59 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBfI-0007h4-88; Wed, 14 May 2025 08:56:54 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8EA40121AC0;
 Wed, 14 May 2025 15:56:30 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3731C20B838;
 Wed, 14 May 2025 15:56:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.18 00/18] Patch Round-up for stable 7.2.18,
 freeze on 2025-05-24
Date: Wed, 14 May 2025 15:56:06 +0300
Message-Id: <qemu-stable-7.2.18-20250514114012@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v7.2.18:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-7.2

Patch freeze is 2025-05-24, and the release is planned for 2025-05-26:

  https://wiki.qemu.org/Planning/7.2

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 14fb6dbbc50f Michael Tokarev:
   Makefile: "make dist" generates a .xz, not .bz2
02 2542d5cf471a Heinrich Schuchardt:
   hw/rtc/goldfish: keep time offset when resetting
03 04e99f9eb792 Philippe Mathieu-Daudé:
   hw/pci-host/designware: Fix ATU_UPPER_TARGET register access
04 070a500cc0da Richard Henderson:
   target/avr: Fix buffer read in avr_print_insn
05 fca2817fdcb0 Richard Henderson:
   target/mips: Revert TARGET_PAGE_BITS_VARY
06 d89b9899babc Richard Henderson:
   target/mips: Require even maskbits in update_pagemask
07 256ba7715b10 Richard Henderson:
   target/mips: Simplify and fix update_pagemask
08 c0b32426ce56 Marco Cavenati:
   migration: fix SEEK_CUR offset calculation in qio_channel_block_seek
09 c17ad4b11bd2 Akihiko Odaki:
   virtio-net: Fix num_buffers for version 1
10 a7a05f5f6a40 Daan De Meyer:
   smbios: Fix buffer overrun when using path= option
11 c07cd110a182 Pierrick Bouvier:
   plugins/loader: fix deadlock when resetting/uninstalling a plugin
12 94a159f3dc73 Paolo Bonzini:
   target/i386/hvf: fix lflags_to_rflags
13 6b661b7ed7cd Richard Henderson:
   target/avr: Improve decode of LDS, STS
14 8ed7c0b6488a Peter Maydell:
   target/arm: Don't assert() for ISB/SB inside IT block
15 eba837a31b95 Bernhard Beschow:
   hw/gpio/imx_gpio: Fix interpretation of GDIR polarity
16 54e54e594bc8 Bernhard Beschow:
   hw/i2c/imx: Always set interrupt status bit if interrupt condition occurs
17 61da38db70af Christian Schoenebeck:
   9pfs: fix concurrent v9fs_reclaim_fd() calls
18 89f7b4da7662 Christian Schoenebeck:
   9pfs: fix FD leak and reduce latency of v9fs_reclaim_fd()

