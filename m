Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8E0CCA471
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 05:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6inK-0007jb-RW; Thu, 09 Oct 2025 01:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v6inE-0007iK-0j; Thu, 09 Oct 2025 01:02:20 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v6inB-0000fK-5T; Thu, 09 Oct 2025 01:02:19 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0178815BBDB;
 Thu, 09 Oct 2025 08:02:03 +0300 (MSK)
Received: from tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with SMTP id 927CA29BF9F;
 Thu,  9 Oct 2025 08:02:13 +0300 (MSK)
Received: (nullmailer pid 643715 invoked by uid 1000);
 Thu, 09 Oct 2025 05:02:12 -0000
Subject: [ANNOUNCE] QEMU 7.2.21 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Oct 2025 08:02:12 +0300
Message-Id: <1759986132.197469.643713.nullmailer@tls.msk.ru>
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The QEMU v7.2.21 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-7.2.21.tar.xz
  https://download.qemu.org/qemu-7.2.21.tar.xz.sig (signature)

v7.2.21 is now tagged in the official qemu.git repository, and the
stable-7.2 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-7.2

There are 18 changes since the previous v7.2.20 release.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-7.2-hash master-hash Author Name: Commmit-Subject):

ee4e62749d Michael Tokarev:
 Update version for 7.2.21 release
5555f73de0 9163424c50 Thomas Huth:
 ui/icons/qemu.svg: Add metadata information (author, license) to the logo
2ef88536a9 d0af3cd027 Peter Maydell:
 hw/usb/hcd-uhci: don't assert for SETUP to non-0 endpoint
942285428f e13e1195db Richard Henderson:
 tests/tcg/multiarch: Add tb-link test
6da5cadbda 03fe665980 Richard Henderson:
 accel/tcg: Properly unlink a TB linked to itself
e1cbca064e 4c8f69b948 Xiaoyao Li:
 multiboot: Fix the split lock
c7cb4f1e82 bd4c0ef409 Marc-André Lureau:
 python/qemu/machine: use socketpair() for QMP by default
68a48e69e5 603a3bad4b Marc-André Lureau:
 python/qmp/legacy: make QEMUMonitorProtocol accept a socket
6490f73fc0 a3cfea92e2 Marc-André Lureau:
 python/qmp/protocol: add open_with_socket()
df40520775 f9922937d1 Peter Delevoryas:
 python/machine: Fix AF_UNIX path too long on macOS
a1499a8a94 Michael Tokarev:
 use fedora:37 for python container instead of :latest
5279a162ff aaf042299a Stéphane Graber:
 hw/usb/network: Remove hardcoded 0x40 prefix in STRING_ETHADDR response
dd7f47e71b ae4b01b349 Richard W.M. Jones:
 tests: Ensure TAP version is printed before other messages
1e2fdfc71b dee66bc969 Fabiano Rosas:
 tests/qtest: Do not run lsi53c895a test if device is not present
cdfff7682c c9a1ea9c52 Markus Armbruster:
 Revert "tests/qtest: use qos_printf instead of g_test_message"
b9579f1ceb f72fc16910 Yuxue Liu:
 vhost-user-test: no set non-blocking for cal fd less than 0.
9beb7e011e 3ee7f21ed2 Paolo Bonzini:
 tests: vhost-user-test: release mutex on protocol violation
2f8da7ed97 a11d1847d5 Alex Bennée:
 .gitmodules: move u-boot mirrors to qemu-project-mirrors
055b45334a 3c3c233677 David Hubbard:
 hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT


