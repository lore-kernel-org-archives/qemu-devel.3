Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF833C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 16:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts2Fy-00062u-Tg; Tue, 11 Mar 2025 12:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ts2AC-0003qk-At
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:09:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ts2A9-0007kz-3K
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741709339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jauVAgJt6R+xKUcwcGJdbVnQD7EugeCzqBL0u+vfS0M=;
 b=BS31nO4quR4GEg4UvKNUcm7UpGajVO8CwJ8NFbU9CpL2aTYM475wl4jkcC9slatdiRQPR0
 FU5zJ46OqUwjxCVrSCFoX9j7F1VwcUAxSz6i58PnckpI1zEKN6dYuuWwjwsERYThHnatAU
 vUBKlHQu2A9gIoiXIhB0rCPFjlirZ6w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-3N3Dud5yPq-u-bJGFXxpVw-1; Tue,
 11 Mar 2025 12:08:55 -0400
X-MC-Unique: 3N3Dud5yPq-u-bJGFXxpVw-1
X-Mimecast-MFC-AGG-ID: 3N3Dud5yPq-u-bJGFXxpVw_1741709334
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F15E7180AF59; Tue, 11 Mar 2025 16:08:53 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.32])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 33DA91956094; Tue, 11 Mar 2025 16:08:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Niek Linnenbank <nieklinnenbank@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, qemu-arm@nongnu.org
Subject: [PATCH] docs/system: Fix the information on how to run certain
 functional tests
Date: Tue, 11 Mar 2025 17:08:47 +0100
Message-ID: <20250311160847.388670-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The tests have been converted to the functional framework, so
we should not talk about Avocado here anymore.

Fixes: f7d6b772200 ("tests/functional: Convert BananaPi tests to the functional framework")
Fixes: 380f7268b7b ("tests/functional: Convert the OrangePi tests to the functional framework")
Fixes: 4c0a2df81c9 ("tests/functional: Convert some tests that download files via fetch_asset()")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/system/arm/bananapi_m2u.rst | 5 ++---
 docs/system/arm/orangepi.rst     | 6 +++---
 docs/system/devices/igb.rst      | 4 ++--
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/docs/system/arm/bananapi_m2u.rst b/docs/system/arm/bananapi_m2u.rst
index 587b4886553..d30db8d04c3 100644
--- a/docs/system/arm/bananapi_m2u.rst
+++ b/docs/system/arm/bananapi_m2u.rst
@@ -135,6 +135,5 @@ provide the following command:
 .. code-block:: bash
 
   $ cd qemu-build-dir
-  $ AVOCADO_ALLOW_LARGE_STORAGE=yes tests/venv/bin/avocado \
-    --verbose --show=app,console run -t machine:bpim2u \
-    ../tests/avocado/boot_linux_console.py
+  $ QEMU_TEST_ALLOW_LARGE_STORAGE=1 \
+    meson test --suite thorough func-arm-arm_bpim2u
diff --git a/docs/system/arm/orangepi.rst b/docs/system/arm/orangepi.rst
index db87e81fec4..8b9448ca7b0 100644
--- a/docs/system/arm/orangepi.rst
+++ b/docs/system/arm/orangepi.rst
@@ -257,9 +257,9 @@ Orange Pi PC integration tests
 
 The Orange Pi PC machine has several integration tests included.
 To run the whole set of tests, build QEMU from source and simply
-provide the following command:
+provide the following command from the build directory:
 
 .. code-block:: bash
 
-  $ AVOCADO_ALLOW_LARGE_STORAGE=yes avocado --show=app,console run \
-     -t machine:orangepi-pc tests/avocado/boot_linux_console.py
+  $ QEMU_TEST_ALLOW_LARGE_STORAGE=1 \
+    meson test --suite thorough func-arm-arm_orangepi
diff --git a/docs/system/devices/igb.rst b/docs/system/devices/igb.rst
index 04e79dfe549..9145af5c757 100644
--- a/docs/system/devices/igb.rst
+++ b/docs/system/devices/igb.rst
@@ -57,11 +57,11 @@ directory:
   meson test qtest-x86_64/qos-test
 
 ethtool can test register accesses, interrupts, etc. It is automated as an
-Avocado test and can be ran with the following command:
+functional test and can be ran with the following command:
 
 .. code:: shell
 
-  make check-avocado AVOCADO_TESTS=tests/avocado/netdev-ethtool.py
+  meson test --suite thorough func-x86_64-netdev_ethtool
 
 References
 ==========
-- 
2.48.1


