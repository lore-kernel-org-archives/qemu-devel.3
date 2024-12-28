Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99EAE77188
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2024 12:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRVeq-0007XO-BB; Sat, 28 Dec 2024 07:11:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tRVeG-0007TU-HY; Sat, 28 Dec 2024 07:10:30 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tRVeC-0001oE-If; Sat, 28 Dec 2024 07:10:26 -0500
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by isrv.corpit.ru (Postfix) with ESMTP id EB194CC84E;
 Sat, 28 Dec 2024 15:09:39 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 520564616A; Sat, 28 Dec 2024 14:54:46 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 07/11] docs: Replace 'since' -> 'removed in' in
 removed-features.rst
Date: Sat, 28 Dec 2024 14:54:42 +0300
Message-Id: <20241228115446.2478706-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241228115446.2478706-1-mjt@tls.msk.ru>
References: <20241228115446.2478706-1-mjt@tls.msk.ru>
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/about/removed-features.rst | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index e3a87f3f55..cb1388049a 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -403,13 +403,13 @@ Sound card devices should be created using ``-device`` or ``-audio``.
 The exception is ``pcspk`` which can be activated using ``-machine
 pcspk-audiodev=<name>``.
 
-``-watchdog`` (since 7.2)
-'''''''''''''''''''''''''
+``-watchdog`` (removed in 7.2)
+''''''''''''''''''''''''''''''
 
 Use ``-device`` instead.
 
-Hexadecimal sizes with scaling multipliers (since 8.0)
-''''''''''''''''''''''''''''''''''''''''''''''''''''''
+Hexadecimal sizes with scaling multipliers (removed in 8.0)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 Input parameters that take a size value should only use a size suffix
 (such as 'k' or 'M') when the base is written in decimal, and not when
@@ -510,15 +510,15 @@ than zero.
 
 Removed along with the ``compression`` migration capability.
 
-``-device virtio-blk,scsi=on|off`` (since 9.1)
-''''''''''''''''''''''''''''''''''''''''''''''
+``-device virtio-blk,scsi=on|off`` (removed in 9.1)
+'''''''''''''''''''''''''''''''''''''''''''''''''''
 
 The virtio-blk SCSI passthrough feature is a legacy VIRTIO feature.  VIRTIO 1.0
 and later do not support it because the virtio-scsi device was introduced for
 full SCSI support.  Use virtio-scsi instead when SCSI passthrough is required.
 
-``-fsdev proxy`` and ``-virtfs proxy`` (since 9.2)
-''''''''''''''''''''''''''''''''''''''''''''''''''
+``-fsdev proxy`` and ``-virtfs proxy`` (removed in 9.2)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 The 9p ``proxy`` filesystem backend driver was originally developed to
 enhance security by dispatching low level filesystem operations from 9p
@@ -532,8 +532,8 @@ security model option, or switch to ``virtiofs``.   The virtiofs daemon
 ``virtiofsd`` uses vhost to eliminate the high latency costs of the 9p
 ``proxy`` backend.
 
-``-portrait`` and ``-rotate`` (since 9.2)
-'''''''''''''''''''''''''''''''''''''''''
+``-portrait`` and ``-rotate`` (removed in 9.2)
+''''''''''''''''''''''''''''''''''''''''''''''
 
 The ``-portrait`` and ``-rotate`` options were documented as only
 working with the PXA LCD device, and all the machine types using
-- 
2.39.5


