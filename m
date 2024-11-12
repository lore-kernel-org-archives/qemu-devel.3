Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7766D32D9A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 12:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tApbj-00074o-HT; Tue, 12 Nov 2024 07:02:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1tApbh-00074V-3N
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 07:02:53 -0500
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1tApbe-0003Hu-Gl
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 07:02:52 -0500
From: Dmitry Frolov <frolov@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1731412964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=wFSeX9PegwQP/p/rHDp87H15TRZYjD9k+0I5NZVcbTo=;
 b=tsFqPeow2sqwOPXmDAIrHolyFNfZIF2benYG4KhPrbwQDrFRkp36ZxSpTBvby3ZOKUG/1A
 MVbeiZ8v25AUQysYi3Jms/Yjxj8qnXzuj8PDrmdf0tkcjwPI+zSUulmTYKPSAjdq2deYI/
 Aq+JDL30FYA9ItNHE3Q6NR7QyDlLJqs=
To: farosas@suse.de,
	lvivier@redhat.com
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org,
 Dmitry Frolov <frolov@swemel.ru>
Subject: [PATCH] tests/qtest: increase timeouts
Date: Tue, 12 Nov 2024 15:00:31 +0300
Message-ID: <20241112120100.176492-2-frolov@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

More time for some tests needed when qemu is built with
"--enable-asan --enable-ubsan"

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
---
 tests/qtest/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index aa93e98418..ead2207f9c 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -5,7 +5,7 @@ slow_qtests = {
   'cdrom-test' : 610,
   'device-introspect-test' : 720,
   'ide-test' : 120,
-  'migration-test' : 480,
+  'migration-test' : 600,
   'npcm7xx_pwm-test': 300,
   'npcm7xx_watchdog_timer-test': 120,
   'qmp-cmd-test' : 120,
@@ -15,7 +15,7 @@ slow_qtests = {
   'pxe-test': 610,
   'prom-env-test': 360,
   'boot-serial-test': 360,
-  'qos-test': 120,
+  'qos-test': 240,
   'vmgenid-test': 610,
 }
 
-- 
2.43.0


