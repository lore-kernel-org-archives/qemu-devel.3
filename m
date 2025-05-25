Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E58C54F30
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 09:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJ7qL-000496-Sq; Sun, 25 May 2025 05:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJ7qK-00048T-8g; Sun, 25 May 2025 05:40:32 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJ7qI-0004Gg-3s; Sun, 25 May 2025 05:40:31 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CCCD1124DC6;
 Sun, 25 May 2025 12:40:24 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B076B215EF8;
 Sun, 25 May 2025 12:40:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.18 v2 00/21] Patch Round-up for stable 7.2.18,
 freeze on 2025-05-24 (frozen)
Date: Sun, 25 May 2025 12:40:19 +0300
Message-Id: <qemu-stable-7.2.18-20250525111620@cover.tls.msk.ru>
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

Please respond here or CC qemu-stable@nongnu.org on any patches
you think shouldn't be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* 14fb6dbbc50f Michael Tokarev:
   Makefile: "make dist" generates a .xz, not .bz2
02* 2542d5cf471a Heinrich Schuchardt:
   hw/rtc/goldfish: keep time offset when resetting
03* 04e99f9eb792 Philippe Mathieu-Daudé:
   hw/pci-host/designware: Fix ATU_UPPER_TARGET register access
04* 070a500cc0da Richard Henderson:
   target/avr: Fix buffer read in avr_print_insn
05* fca2817fdcb0 Richard Henderson:
   target/mips: Revert TARGET_PAGE_BITS_VARY
06* d89b9899babc Richard Henderson:
   target/mips: Require even maskbits in update_pagemask
07* 256ba7715b10 Richard Henderson:
   target/mips: Simplify and fix update_pagemask
08* c0b32426ce56 Marco Cavenati:
   migration: fix SEEK_CUR offset calculation in qio_channel_block_seek
09* c17ad4b11bd2 Akihiko Odaki:
   virtio-net: Fix num_buffers for version 1
10* a7a05f5f6a40 Daan De Meyer:
   smbios: Fix buffer overrun when using path= option
11* c07cd110a182 Pierrick Bouvier:
   plugins/loader: fix deadlock when resetting/uninstalling a plugin
12* 94a159f3dc73 Paolo Bonzini:
   target/i386/hvf: fix lflags_to_rflags
13* 6b661b7ed7cd Richard Henderson:
   target/avr: Improve decode of LDS, STS
14* 8ed7c0b6488a Peter Maydell:
   target/arm: Don't assert() for ISB/SB inside IT block
15* eba837a31b95 Bernhard Beschow:
   hw/gpio/imx_gpio: Fix interpretation of GDIR polarity
16* 54e54e594bc8 Bernhard Beschow:
   hw/i2c/imx: Always set interrupt status bit if interrupt condition occurs
17* 61da38db70af Christian Schoenebeck:
   9pfs: fix concurrent v9fs_reclaim_fd() calls
18* 89f7b4da7662 Christian Schoenebeck:
   9pfs: fix FD leak and reduce latency of v9fs_reclaim_fd()
19 0caed25cd171 Akihiko Odaki:
   virtio: Call set_features during reset
20 22b448ccc661 Icenowy Zheng:
   common-user/host/riscv: use tail pseudoinstruction for calling tail
21 7f2131c35c17 Zhao Liu:
   qapi/misc-target: Fix the doc to distinguish query-sgx and 
   query-sgx-capabilities

(commit(s) marked with * were in previous series and are not resent)

