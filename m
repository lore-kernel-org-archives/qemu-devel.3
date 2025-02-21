Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589E9C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 17:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlX9x-0000me-5k; Fri, 21 Feb 2025 12:49:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tlX9u-0000lv-KK; Fri, 21 Feb 2025 12:49:54 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tlX9s-0001aN-JJ; Fri, 21 Feb 2025 12:49:54 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5C14AEFB63;
 Fri, 21 Feb 2025 20:49:29 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 10F601BB57F;
 Fri, 21 Feb 2025 20:49:49 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 0309553F79; Fri, 21 Feb 2025 20:49:49 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.2 00/14] Patch Round-up for stable 9.2.2,
 freeze on 2025-02-23
Date: Fri, 21 Feb 2025 20:49:30 +0300
Message-Id: <qemu-stable-9.2.2-20250221204240@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v9.2.2:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-9.2

Patch freeze is 2025-02-23, and the release is planned for 2025-02-24:

  https://wiki.qemu.org/Planning/9.2

This is a short-cycle release to fix issues with the uploaded 9.2.1
tarball - due to some caching on the site and two versions of the
9.2.1 tarball, there are some issues with signature verification.
Since there were a few important patches already queued up, so I'm
including these too.

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 131c58469f6f Paolo Bonzini:
   rust: add --rust-target option for bindgen
02 23ea425c14d3 Fabiano Rosas:
   block: Fix leak in send_qmp_error_event
03 107c551de0d7 Peter Krempa:
   block-backend: Fix argument order when calling 
   'qapi_event_send_block_io_error()'
04 27a8d899c7a1 Khem Raj:
   linux-user: Do not define struct sched_attr if libc headers do
05 1e3d4d9a1a32 Laurent Vivier:
   qmp: update vhost-user protocol feature maps
06 66a1b4991c32 Thomas Huth:
   gitlab-ci.d/cirrus: Update the FreeBSD job to v14.2
07 7b3d5b84cbd7 Zhenzhong Duan:
   vfio/iommufd: Fix SIGSEV in iommufd_cdev_attach()
08 4dafba778aa3 Volker Rümelin:
   ui/sdl2: reenable the SDL2 Windows keyboard hook procedure
09 b79b05d1a06a Michael Roth:
   make-release: don't rely on $CWD when excluding subproject directories
10 937df81af675 Peter Maydell:
   hw/net/smc91c111: Ignore attempt to pop from empty RX fifo
11 4b7b20a3b72c Fabiano Rosas:
   elfload: Fix alignment when unmapping excess reservation
12 807c3ebd1e3f Mikael Szreder:
   target/sparc: Fix register selection for all F*TOx and FxTO* instructions
13 7a74e468089a Mikael Szreder:
   target/sparc: Fix gdbstub incorrectly handling registers f32-f62
14 f141caa270af Michael Tokarev:
   net/slirp: libslirp 4.9.0 compatibility

