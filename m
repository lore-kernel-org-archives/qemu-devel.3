Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E198C48BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 08:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rchr4-0001A3-BJ; Wed, 21 Feb 2024 03:21:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rchqw-00015T-5Y; Wed, 21 Feb 2024 03:21:18 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rchqu-0002Aw-IN; Wed, 21 Feb 2024 03:21:17 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 761CC4F3C7;
 Wed, 21 Feb 2024 11:21:20 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 40F51860A6;
 Wed, 21 Feb 2024 11:20:59 +0300 (MSK)
Received: (nullmailer pid 2142013 invoked by uid 1000);
 Wed, 21 Feb 2024 08:20:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.2 09/60] qemu-options.hx: Improve -serial option
 documentation
Date: Wed, 21 Feb 2024 11:19:57 +0300
Message-Id: <20240221082058.2141850-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
References: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

The -serial option documentation is a bit brief about '-serial none'
and '-serial null'. In particular it's not very clear about the
difference between them, and it doesn't mention that it's up to
the machine model whether '-serial none' means "don't create the
serial port" or "don't wire the serial port up to anything".

Expand on these points.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240122163607.459769-3-peter.maydell@linaro.org
(cherry picked from commit 747bfaf3a9d2f3cd51674763dc1f7575100cd200)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/qemu-options.hx b/qemu-options.hx
index 42fd09e4de..b6b4ad9e67 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4118,7 +4118,8 @@ SRST
     This option can be used several times to simulate up to 4 serial
     ports.
 
-    Use ``-serial none`` to disable all serial ports.
+    You can use ``-serial none`` to suppress the creation of default
+    serial devices.
 
     Available character devices are:
 
@@ -4140,10 +4141,17 @@ SRST
         [Linux only] Pseudo TTY (a new PTY is automatically allocated)
 
     ``none``
-        No device is allocated.
+        No device is allocated. Note that for machine types which
+        emulate systems where a serial device is always present in
+        real hardware, this may be equivalent to the ``null`` option,
+        in that the serial device is still present but all output
+        is discarded. For boards where the number of serial ports is
+        truly variable, this suppresses the creation of the device.
 
     ``null``
-        void device
+        A guest will see the UART or serial device as present in the
+        machine, but all output is discarded, and there is no input.
+        Conceptually equivalent to redirecting the output to ``/dev/null``.
 
     ``chardev:id``
         Use a named character device defined with the ``-chardev``
-- 
2.39.2


