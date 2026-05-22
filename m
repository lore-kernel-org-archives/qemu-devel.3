Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62F9CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXn6-0005DL-8y; Fri, 22 May 2026 17:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXn3-0004tH-Uq; Fri, 22 May 2026 17:52:21 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXn2-0004G0-7l; Fri, 22 May 2026 17:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779486561; bh=mGFrnJsQruWew9Mlige4612ivSGUgZqccxWubq5PBMA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HDNG9lv/cFRW4Uwxl2BLj3TH1Ya3o6RdE7y4EJV/N2DPyy+aIciLgqZbfi+R5pWnS
 DhuhdN/51AGdW90nZa6sPsO7yJH/gzZ5gllAxgJJjPIdhcCt//aSO+aCwDwn+ITUWX
 ssIZ9xXEa4/c6Y0IMPI8bpiyA26NplVYXzJL9PLNvciIi5ycn0+I3bxYR2DyQPKIoU
 7JvAoyeBfQn3fLoPPJXimkqs7c29tkeJLOcK7sQYZ/AKMg8rvA75QPAjq4s75iAjE8
 6nR5KghE9H6NQHY/VehgJQoAQm8EYz3IM9rIb0hoMNSufW0DynSopSk1sjw53bxEyl
 P8JqU9o68EIzw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 29B881AFB79;
 Sat, 23 May 2026 00:49:21 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4EC1C3B71C8;
 Sat, 23 May 2026 00:49:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 131/149] tests/functional/qemu_test/asset.py: Don't
 use setxattr when it doesn't exist
Date: Sat, 23 May 2026 00:49:03 +0300
Message-ID: <20260522214923.807017-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

The Python os.setxattr() API is Linux-specific, so trying to use
it on other OSes triggers a failure:

  File "/Users/pm215/src/qemu/tests/functional/qemu_test/asset.py",
line 227, in fetch
    os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
    ^^^^^^^^^^^
AttributeError: module 'os' has no attribute 'setxattr'

Since we only set the attributes here for informational
purposes, skip them when os.setxattr() isn't available.

Cc: qemu-stable@nongnu.org
Fixes: 9903217a4ed013 ("tests/functional: add a module for handling asset download & caching")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <th.huth+qemu@posteo.eu>
Message-id: 20260501115506.3792110-1-peter.maydell@linaro.org
(cherry picked from commit 039b057c09c6a9742b91b8f29604651ba3fdb558)
(Mjt: context fixup for 10.2.x)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index bae40765ce..ef0dff921d 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -207,11 +207,14 @@ def fetch(self):
             raise AssetError(self, "Download retries exceeded", transient=True)
 
         try:
-            # Set these just for informational purposes
-            os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
-                        self.url.encode('utf8'))
-            os.setxattr(str(tmp_cache_file), "user.qemu-asset-hash",
-                        self.hash.encode('utf8'))
+            # Set these just for informational purposes. Note that
+            # setxattr is Linux-only; as this is only informational
+            # we can simply skip it on other platforms.
+            if hasattr(os, "setxattr"):
+                os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
+                            self.url.encode('utf8'))
+                os.setxattr(str(tmp_cache_file), "user.qemu-asset-hash",
+                            self.hash.encode('utf8'))
         except Exception as e:
             self.log.debug("Unable to set xattr on %s: %s", tmp_cache_file, e)
 
-- 
2.47.3


