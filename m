Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A552C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 08:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSYru-00051F-Lk; Wed, 24 Jan 2024 03:44:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rSYrs-00050p-QG
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 03:44:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rSYrr-0004SK-2h
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 03:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706085857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZNycpv/35bInP5X+d7NNEDSKt9P3VVr7cQG7MeiSSmI=;
 b=gem4TK6JKPYhS/TYbCZ1yEpDIT7JQj8FR/H4U9EPLYKeRn6/YVMwWFqe0rdqnPGOIUmp6n
 r90EPMG6ztljKGfePe/1vNjrwK6MevIyt9RU//JV2GBlSyDMalBU5aHQMsm+I7c8OIS1dR
 nW+56w0medorV7dyrsYkk0x2R59Kxco=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-YvITum6xO123K11pICznew-1; Wed,
 24 Jan 2024 03:44:14 -0500
X-MC-Unique: YvITum6xO123K11pICznew-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51CB21C0BA4B;
 Wed, 24 Jan 2024 08:44:14 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 72407492BC6;
 Wed, 24 Jan 2024 08:44:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] tests/qtest: Bump timeouts of boot_sector_test()-based tests
 to 610 seconds
Date: Wed, 24 Jan 2024 09:44:12 +0100
Message-ID: <20240124084412.465638-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We're still seeing timeouts in qtests that use a TCG payload with TCI
on a slow k8s runner:

 https://gitlab.com/qemu-project/qemu/-/jobs/5990992722

So we should bump the timeout of cdrom-test to see whether that
fixes the issue.
Now, cdrom-test, as bios-tables-test, pxe-test and vmgenid-test use
the boot_sector_test() function for running a TCG payload. That
function already uses an internal timeout of 600 seconds with
the remark that the test could be slow with TCI.
Thus from the outer meson test runner side, we should not use less
than 600 seconds as timeout values for these tests. Let's bump them
on the meson side to 610 seconds so that the tests themselves can
run with their internal 600 seconds timeout and have some additional
seconds on top for reporting the outcome.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/meson.build | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index d22aec6734..84a055a7d9 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -1,16 +1,18 @@
 slow_qtests = {
   'aspeed_smc-test': 360,
-  'bios-tables-test' : 540,
+  'bios-tables-test' : 610,
+  'cdrom-test' : 610,
   'device-introspect-test' : 720,
   'migration-test' : 480,
   'npcm7xx_pwm-test': 300,
   'npcm7xx_watchdog_timer-test': 120,
   'qom-test' : 900,
   'test-hmp' : 240,
-  'pxe-test': 600,
+  'pxe-test': 610,
   'prom-env-test': 360,
   'boot-serial-test': 360,
   'qos-test': 120,
+  'vmgenid-test': 610,
 }
 
 qtests_generic = [
-- 
2.43.0


