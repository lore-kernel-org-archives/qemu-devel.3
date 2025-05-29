Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38569C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 06:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKWbR-00021L-E5; Thu, 29 May 2025 02:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uKWbP-00020X-CW; Thu, 29 May 2025 02:18:55 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uKWbM-0006mL-TH; Thu, 29 May 2025 02:18:55 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9828E1260B1;
 Thu, 29 May 2025 09:18:40 +0300 (MSK)
Received: from localhost (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with SMTP id EFB39218BB2;
 Thu, 29 May 2025 09:18:47 +0300 (MSK)
Received: (nullmailer pid 12134 invoked by uid 1000);
 Thu, 29 May 2025 06:18:47 -0000
Subject: [ANNOUNCE] QEMU 7.2.18 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 May 2025 09:18:47 +0300
Message-Id: <1748499527.952110.12133.nullmailer@localhost>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, MIME_QP_LONG_LINE=0.001,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The QEMU v7.2.18 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-7.2.18.tar.xz
  https://download.qemu.org/qemu-7.2.18.tar.xz.sig (signature)

v7.2.18 is now tagged in the official qemu.git repository, and the
stable-7.2 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-7.2

There are 21 changes since the previous v7.2.17 release.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-7.2-hash master-hash Author Name: Commmit-Subject):

ceb3cba94b Michael Tokarev:
 Update version for 7.2.18 release
700e6e768a 7f2131c35c Zhao Liu:
 qapi/misc-target: Fix the doc to distinguish query-sgx and query-sgx-capabilities
5fee5c6822 22b448ccc6 Icenowy Zheng:
 common-user/host/riscv: use tail pseudoinstruction for calling tail
ce14316152 0caed25cd1 Akihiko Odaki:
 virtio: Call set_features during reset
cf303fefc9 89f7b4da76 Christian Schoenebeck:
 9pfs: fix FD leak and reduce latency of v9fs_reclaim_fd()
75cc804bc7 61da38db70 Christian Schoenebeck:
 9pfs: fix concurrent v9fs_reclaim_fd() calls
95dacfb157 54e54e594b Bernhard Beschow:
 hw/i2c/imx: Always set interrupt status bit if interrupt condition occurs
7e2ff77f73 eba837a31b Bernhard Beschow:
 hw/gpio/imx_gpio: Fix interpretation of GDIR polarity
5f2fd50a76 8ed7c0b648 Peter Maydell:
 target/arm: Don't assert() for ISB/SB inside IT block
927d897393 6b661b7ed7 Richard Henderson:
 target/avr: Improve decode of LDS, STS
b401e48860 94a159f3dc Paolo Bonzini:
 target/i386/hvf: fix lflags_to_rflags
d2d2524b48 c07cd110a1 Pierrick Bouvier:
 plugins/loader: fix deadlock when resetting/uninstalling a plugin
eafb095ea4 a7a05f5f6a Daan De Meyer:
 smbios: Fix buffer overrun when using path= option
cefd67f254 c17ad4b11b Akihiko Odaki:
 virtio-net: Fix num_buffers for version 1
d34c201195 c0b32426ce Marco Cavenati:
 migration: fix SEEK_CUR offset calculation in qio_channel_block_seek
a527d31074 256ba7715b Richard Henderson:
 target/mips: Simplify and fix update_pagemask
c3fdfe81ab d89b9899ba Richard Henderson:
 target/mips: Require even maskbits in update_pagemask
a00f7d4426 fca2817fdc Richard Henderson:
 target/mips: Revert TARGET_PAGE_BITS_VARY
5361f8136d 070a500cc0 Richard Henderson:
 target/avr: Fix buffer read in avr_print_insn
f8a0d81f0e 04e99f9eb7 Philippe Mathieu-Daudé:
 hw/pci-host/designware: Fix ATU_UPPER_TARGET register access
ce9a1b9e51 2542d5cf47 Heinrich Schuchardt:
 hw/rtc/goldfish: keep time offset when resetting
4ce6d9351b 14fb6dbbc5 Michael Tokarev:
 Makefile: "make dist" generates a .xz, not .bz2


