Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53311C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 19:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdbHD-0008Cq-FR; Fri, 23 Feb 2024 14:32:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rdawL-0005ox-8N
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:10:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rdaw3-0005BV-Cq
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:10:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708715414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BbapVeWMgszox2EGK6ZOE8IV1r7Xf9US24FSdNFPj68=;
 b=Mp2QKafTPKg1huzYx4Czc32Tr655IjUZNYnuEunbO5U3vMBDDhJTEII2de7MbgCun6rhXN
 EshOh5Oy7zFH3D1ano5xpaf45yBLtzsRd0r+RX2ojT/rWm97S+iVNsiLxhCVz1GT/NxeR8
 KIp5e/D2dI+DR/9KAcWA/uRx+6n7iqM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-XQpq2JpjMauUcTjCSE2n8g-1; Fri,
 23 Feb 2024 14:10:11 -0500
X-MC-Unique: XQpq2JpjMauUcTjCSE2n8g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4952C38562D1;
 Fri, 23 Feb 2024 19:10:11 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B18268CED;
 Fri, 23 Feb 2024 19:10:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 04/11] tests: skip dbus-display tests that need a console
Date: Fri, 23 Feb 2024 20:09:56 +0100
Message-ID: <20240223191003.6268-5-thuth@redhat.com>
In-Reply-To: <20240223191003.6268-1-thuth@redhat.com>
References: <20240223191003.6268-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Message-ID: <20240221073759.171443-1-marcandre.lureau@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
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


