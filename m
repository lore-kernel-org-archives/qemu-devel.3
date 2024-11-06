Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46A2D59F55
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 17:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8jXX-0004va-Lg; Wed, 06 Nov 2024 12:09:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t8jXW-0004uz-IV
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:09:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t8jXU-0004at-Ox
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730912992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jQiE6B+i4wOhWnyBzw/aT6WlDWMA/Uga4tWnZwA1P28=;
 b=ic4E45+1Q3rwjdxl4embOaBgCv4tQsD1t0czh1GGA88kJ5gPP6tNLa585pGuWUr4OesBgd
 Q7MKXBqwBju9Ay4ioowajj9oUUbAZZsxXQYdtth2gdtDtD5FO23vgIEOC2fpV6KisYrnC9
 rGaMpWEMwqj+rLaQqVXMwSzYT84U5zI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-46-d2LUX4gaMQyaGqTMJ8QWTA-1; Wed,
 06 Nov 2024 12:09:50 -0500
X-MC-Unique: d2LUX4gaMQyaGqTMJ8QWTA-1
X-Mimecast-MFC-AGG-ID: d2LUX4gaMQyaGqTMJ8QWTA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73EF1195608A; Wed,  6 Nov 2024 17:09:49 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C784E19541A5; Wed,  6 Nov 2024 17:09:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] tests/functional: Bump timeouts of functional tests
Date: Wed,  6 Nov 2024 18:09:46 +0100
Message-ID: <20241106170946.990731-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When building QEMU with "--enable-debug" and running the tests
in parallel with "make -j$(nproc) check-functional", many tests are
still timing out due to our conservative timeout settings. Bump
the timeouts of the problematic tests and also increase the default
timeout to 90 seconds (from 60 seconds) to be on the safe side.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/meson.build | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index d5296bff8b..3561f987a6 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -11,24 +11,26 @@ endif
 
 # Timeouts for individual tests that can be slow e.g. with debugging enabled
 test_timeouts = {
-  'aarch64_raspi4' : 120,
+  'aarch64_raspi4' : 480,
   'aarch64_sbsaref' : 600,
-  'aarch64_virt' : 360,
-  'acpi_bits' : 240,
+  'aarch64_virt' : 720,
+  'acpi_bits' : 420,
   'arm_aspeed' : 600,
-  'arm_bpim2u' : 360,
+  'arm_bpim2u' : 500,
+  'arm_collie' : 180,
   'arm_orangepi' : 540,
   'arm_raspi2' : 120,
-  'arm_tuxrun' : 120,
+  'arm_tuxrun' : 240,
   'arm_sx1' : 360,
   'mips_malta' : 120,
   'netdev_ethtool' : 180,
   'ppc_40p' : 240,
   'ppc64_hv' : 1000,
-  'ppc64_powernv' : 240,
-  'ppc64_pseries' : 240,
-  'ppc64_tuxrun' : 240,
-  's390x_ccw_virtio' : 240,
+  'ppc64_powernv' : 480,
+  'ppc64_pseries' : 480,
+  'ppc64_tuxrun' : 420,
+  'riscv64_tuxrun' : 120,
+  's390x_ccw_virtio' : 420,
 }
 
 tests_generic_system = [
@@ -273,8 +275,8 @@ foreach speed : ['quick', 'thorough']
            env: test_env,
            args: [testpath],
            protocol: 'tap',
-           timeout: test_timeouts.get(test, 60),
-           priority: test_timeouts.get(test, 60),
+           timeout: test_timeouts.get(test, 90),
+           priority: test_timeouts.get(test, 90),
            suite: suites)
     endforeach
   endforeach
-- 
2.47.0


