Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FB2C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 08:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsdVt-00047g-BU; Thu, 13 Mar 2025 04:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tsdVq-00046j-Kw
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 04:01:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tsdVo-0007hw-RR
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 04:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741852912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ATyNnDPsrP4Cvhq799JxC4uMKbimzZ7xGTbdv4QkV4M=;
 b=UTU3H7bAUSdLP6AhnHvibTgzIZEPJpIYCikC5VpxCq+4flzTMlWsUx6qbvmjxHVjvYTBHF
 HMpN70z5mkLtKc/Wm4RXDx3YEncKVWw1H7MaM+OTbQmNTcMkolH1SI1LX9NfywusNUh7XG
 AZjbn5PZTAuHFH5nFW7nJYmDwh9ySAg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-nqnHzOu-Moqm4bG-D3lSRA-1; Thu,
 13 Mar 2025 04:01:50 -0400
X-MC-Unique: nqnHzOu-Moqm4bG-D3lSRA-1
X-Mimecast-MFC-AGG-ID: nqnHzOu-Moqm4bG-D3lSRA_1741852909
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84C1C195609E
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 08:01:49 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AA32E1955D85; Thu, 13 Mar 2025 08:01:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 4/8] docs/system: Fix the information on how to run certain
 functional tests
Date: Thu, 13 Mar 2025 09:01:28 +0100
Message-ID: <20250313080132.1467625-5-thuth@redhat.com>
In-Reply-To: <20250313080132.1467625-1-thuth@redhat.com>
References: <20250313080132.1467625-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

The tests have been converted to the functional framework, so
we should not talk about Avocado here anymore.

Fixes: f7d6b772200 ("tests/functional: Convert BananaPi tests to the functional framework")
Fixes: 380f7268b7b ("tests/functional: Convert the OrangePi tests to the functional framework")
Fixes: 4c0a2df81c9 ("tests/functional: Convert some tests that download files via fetch_asset()")
Message-ID: <20250311160847.388670-1-thuth@redhat.com>
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


