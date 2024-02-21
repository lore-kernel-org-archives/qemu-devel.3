Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D507FC5475B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 07:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rchBD-0002w4-Ok; Wed, 21 Feb 2024 02:38:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rchBB-0002vq-GV
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 02:38:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rchB9-0002wU-TQ
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 02:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708501086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=md61yzbDX5UKqYzpS2rG8JYtLm7r4/2PEJov3Rf3o4s=;
 b=HW9Uqmz23tGSbtHOHEWMgynxX01ciDzRnDiNYrROu9nkULwBzDHJN59/sC1YxNws9NXR7f
 Q3N4sCG0jJmtpkoTJS0lXk7KwEbA7jBLeXUc1i2ePWzqpJ9Drq656cBoKHw89DuUZqmF9J
 IpDntexp2/XPwI3GJfDVCOiJrUuNdh0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-L4QHwi_yPxOQ6GE8qSh13A-1; Wed,
 21 Feb 2024 02:38:03 -0500
X-MC-Unique: L4QHwi_yPxOQ6GE8qSh13A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9AE2729AB3E9
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 07:38:03 +0000 (UTC)
Received: from localhost (unknown [10.39.208.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3199E111E40C;
 Wed, 21 Feb 2024 07:38:01 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] tests: skip dbus-display tests that need a console
Date: Wed, 21 Feb 2024 11:37:59 +0400
Message-ID: <20240221073759.171443-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

When compiling with "configure --without-default-devices", the
dbus-display-test fails since it implicitly assumes that the
machine comes with a default console.

There doesn't seem to be an easy way to figure this during build time,
so skip the tests requiring the Console interface at runtime.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/dbus-display-test.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/dbus-display-test.c b/tests/qtest/dbus-display-test.c
index 21edaa1e32..0390bdcb41 100644
--- a/tests/qtest/dbus-display-test.c
+++ b/tests/qtest/dbus-display-test.c
@@ -135,6 +135,13 @@ test_dbus_console_registered(GObject *source_object,
         NULL,
 #endif
         res, &err);
+
+    if (g_error_matches(err, G_DBUS_ERROR, G_DBUS_ERROR_UNKNOWN_METHOD)) {
+        g_test_skip("The VM doesn't have a console!");
+        g_main_loop_quit(test->loop);
+        return;
+    }
+
     g_assert_no_error(err);
 
     test->listener_conn = g_thread_join(test->thread);
@@ -156,7 +163,7 @@ test_dbus_display_console(void)
     g_autoptr(GMainLoop) loop = NULL;
     QTestState *qts = NULL;
     int pair[2];
-    TestDBusConsoleRegister test;
+    TestDBusConsoleRegister test = { 0, };
 #ifdef WIN32
     WSAPROTOCOL_INFOW info;
     g_autoptr(GVariant) listener = NULL;
@@ -245,7 +252,6 @@ test_dbus_display_keyboard(void)
             &err));
     g_assert_no_error(err);
 
-
     g_assert_cmpint(qtest_inb(qts, 0x64) & 0x1, ==, 0);
     g_assert_cmpint(qtest_inb(qts, 0x60), ==, 0);
 
@@ -256,6 +262,12 @@ test_dbus_display_keyboard(void)
         -1,
         NULL,
         &err);
+    if (g_error_matches(err, G_DBUS_ERROR, G_DBUS_ERROR_UNKNOWN_METHOD)) {
+        g_test_skip("The VM doesn't have a console!");
+        qtest_quit(qts);
+        return;
+    }
+
     g_assert_no_error(err);
 
     /* may be should wait for interrupt? */
-- 
2.43.2


