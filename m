Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5643CCAC5B0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Sep 2025 09:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2QqR-00041e-V8; Sat, 27 Sep 2025 05:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v2QqM-00041M-Bk; Sat, 27 Sep 2025 05:03:51 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v2Qpr-0006nq-RQ; Sat, 27 Sep 2025 05:03:47 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 07F1A158555;
 Sat, 27 Sep 2025 12:03:02 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id DB484291572;
 Sat, 27 Sep 2025 12:03:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.21 00/16] Patch Round-up for stable 7.2.21,
 freeze on 2025-10-06
Date: Sat, 27 Sep 2025 12:02:44 +0300
Message-ID: <qemu-stable-7.2.21-20250927105809@cover.tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

The following patches are queued for QEMU stable v7.2.21:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-7.2

Patch freeze is 2025-10-06, and the release is planned for 2025-10-08:

  https://wiki.qemu.org/Planning/7.2

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 3c3c233677d4 David Hubbard:
   hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
02 a11d1847d5ef Alex Bennée:
   .gitmodules: move u-boot mirrors to qemu-project-mirrors
03 3ee7f21ed292 Paolo Bonzini:
   tests: vhost-user-test: release mutex on protocol violation
04 f72fc16910c8 Yuxue Liu:
   vhost-user-test: no set non-blocking for cal fd less than 0.
05 c9a1ea9c52e6 Markus Armbruster:
   Revert "tests/qtest: use qos_printf instead of g_test_message"
06 dee66bc9691a Fabiano Rosas:
   tests/qtest: Do not run lsi53c895a test if device is not present
07 ae4b01b34979 Richard W.M. Jones:
   tests: Ensure TAP version is printed before other messages
08 aaf042299acf Stéphane Graber:
   hw/usb/network: Remove hardcoded 0x40 prefix in STRING_ETHADDR response
09 a1499a8a94 Michael Tokarev:
   use fedora:37 for python container instead of :latest
10 f9922937d173 Peter Delevoryas:
   python/machine: Fix AF_UNIX path too long on macOS
11 a3cfea92e203 Marc-André Lureau:
   python/qmp/protocol: add open_with_socket()
12 603a3bad4b9a Marc-André Lureau:
   python/qmp/legacy: make QEMUMonitorProtocol accept a socket
13 bd4c0ef40914 Marc-André Lureau:
   python/qemu/machine: use socketpair() for QMP by default
14 4c8f69b94839 Xiaoyao Li:
   multiboot: Fix the split lock
15 03fe6659803f Richard Henderson:
   accel/tcg: Properly unlink a TB linked to itself
16 e13e1195db8a Richard Henderson:
   tests/tcg/multiarch: Add tb-link test

