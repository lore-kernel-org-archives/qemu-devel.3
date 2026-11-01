Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17DC606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Wz0PYrMX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNUM0-0008OM-NA; Sun, 01 Nov 2026 07:08:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNULA-0007yB-NU
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 07:07:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNUL8-0003ZO-AC
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 07:07:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793534829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l/375a3o4YLUEW1l0JNH7TRFDdxyVBwwcIpMT8kjB3Q=;
 b=Wz0PYrMXKK0p1WeU6UcQUsgYIJjafjQF/3CtK3o3n7VqcFJ3YT4JQyT92Dm1Qb54BrhvpL
 oFYMNzW4jUHljanuAJz/yfqbGZU7uaaTqbcfecZbIVWlMqHMStnt/ZC15tWZ1CfwnxKOE1
 NPyaBICJbDEPuTlbuxoJQ0FYzeTMfBw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-9tJ7zWjRP_2Sl_fLczEgkA-1; Sun,
 01 Nov 2026 07:07:08 -0500
X-MC-Unique: 9tJ7zWjRP_2Sl_fLczEgkA-1
X-Mimecast-MFC-AGG-ID: 9tJ7zWjRP_2Sl_fLczEgkA_1793534827
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA5801955EB6; Sun,  1 Nov 2026 12:07:06 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 01CED767; Sun,  1 Nov 2026 12:07:05 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 01 Nov 2026 16:06:40 +0400
Subject: [GIT PULL 7/9] tests/qtest/dbus-display-test: check the Scanout
 after a text resize
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261101-ui-v1-7-8af305cef69a@redhat.com>
References: <20261101-ui-v1-0-8af305cef69a@redhat.com>
In-Reply-To: <20261101-ui-v1-0-8af305cef69a@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=9447;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ONZjfxb2NI/Wr58uV8sHbvuGCMynCkNblInquWksFi8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq5ytOhNUkhvnGafSTAMMpy1qCI9dp2Pp7Qw5bL
 ZgQtECb772JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaucrTgAKCRDa6OEJdZac
 5YuFD/93iRK9xJfylIM7izDTcrrdBDknz01+mqXnEWrNc5dG6k5fOsYuyhTMjGD1Y5xtLjoVxGD
 4QOOHQ8KfxtVYvVUn3RqQ+0YFttm56/bp/qC9EuIRoS25adzmVUgmnd4WnVnhBPol4t+hauUWhB
 wAH2u+2yOvl01P6MBYwBOtYDNcItA+UI7/1+VR17IgASWhXnMZ0vf+TowmD865dsUTmT5U/fSF+
 tLdhJY92/X7KgDIOrek28/wrjnc5JagVxOu2R9nJ/9fF+PAINEkNxKrFLL612fKMqSc4yUocqzy
 iYjpdHvmNVR+RW/Nfktv+8GOIGbKuizczRXOqU7HVPdF1S02IcBTVVnBkRupid2RVT1LlXYxkpO
 UjvQwEp+xcoOJnmFTOVePeGCoiOh9fUnNqcFRZPv0CSc40F3xdOsIm/VqcJ51qTf5awcmTiZ400
 8MLF8SRuWKOjAzO06e6S7s8Ja1YGrAWXFvBkNhHmIAA0LhAcPn4LxIPDeTefj8tIAM3Vr8RLgZ4
 dBQV1ubcFlOo6M24eeX+VQuBwazk45zkL68Rf8fbR8EVk+fQsUPt0i05It5+NFBXYLMeSZhRdvr
 JxvDrpGLjGgVNtWBMlz5zK3p8Q1ZFyiqms1xBNgiwc2oEmesLnwrmAUSHiIGkqE09Y+AZXUaPFe
 9Z5j9i+A2VlUy7Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Christian Quante <christian@quante.one>

Set up an 80x25 VGA text mode, change the character height from 16 to
12 lines as the Windows NT 4.0 setup does, and check that the first
message the listener gets after the change is a Scanout of the new size
(720x396), not an Update.

The registration of the listener moves from test_dbus_display_console()
to test_dbus_console_register(), so that both tests can use it, and the
listener now also handles Update.

The test waits until no message has come for some time, so the cursor
is put outside the screen: vga_draw_text() redraws the character under
the cursor at every refresh, also when the cursor is off.

Signed-off-by: Christian Quante <christian@quante.one>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261022134335.12241-3-christian@quante.one>
---
 tests/qtest/dbus-display-test.c | 162 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 148 insertions(+), 14 deletions(-)

diff --git a/tests/qtest/dbus-display-test.c b/tests/qtest/dbus-display-test.c
index 7838ce7323f4..eb81b9ca0531 100644
--- a/tests/qtest/dbus-display-test.c
+++ b/tests/qtest/dbus-display-test.c
@@ -94,8 +94,26 @@ typedef struct TestDBusConsoleRegister {
     GDBusConnection *listener_conn;
     GDBusObjectManagerServer *server;
     bool with_map;
+    /* Scanout and Update calls received, and the first one after @watch */
+    guint messages;
+    bool watch;
+    const char *first;
+    guint first_width;
+    guint first_height;
 } TestDBusConsoleRegister;
 
+static void test_dbus_console_seen(TestDBusConsoleRegister *test,
+                                   const char *method,
+                                   guint width, guint height)
+{
+    test->messages++;
+    if (test->watch && !test->first) {
+        test->first = method;
+        test->first_width = width;
+        test->first_height = height;
+    }
+}
+
 static gboolean listener_handle_scanout(
     QemuDBusDisplay1Listener *object,
     GDBusMethodInvocation *invocation,
@@ -106,6 +124,7 @@ static gboolean listener_handle_scanout(
     GVariant *arg_data,
     TestDBusConsoleRegister *test)
 {
+    test_dbus_console_seen(test, "Scanout", arg_width, arg_height);
     qemu_dbus_display1_listener_complete_scanout(object, invocation);
 
     if (!test->with_map) {
@@ -115,6 +134,24 @@ static gboolean listener_handle_scanout(
     return DBUS_METHOD_INVOCATION_HANDLED;
 }
 
+static gboolean listener_handle_update(
+    QemuDBusDisplay1Listener *object,
+    GDBusMethodInvocation *invocation,
+    gint arg_x,
+    gint arg_y,
+    gint arg_width,
+    gint arg_height,
+    guint arg_stride,
+    guint arg_pixman_format,
+    GVariant *arg_data,
+    TestDBusConsoleRegister *test)
+{
+    test_dbus_console_seen(test, "Update", arg_width, arg_height);
+    qemu_dbus_display1_listener_complete_update(object, invocation);
+
+    return DBUS_METHOD_INVOCATION_HANDLED;
+}
+
 #ifndef WIN32
 static gboolean listener_handle_scanout_map(
     QemuDBusDisplay1ListenerUnixMap *object,
@@ -164,6 +201,7 @@ test_dbus_console_setup_listener(TestDBusConsoleRegister *test, bool with_map)
         qemu_dbus_display1_listener_skeleton_new());
     g_object_connect(iface,
                      "signal::handle-scanout", listener_handle_scanout, test,
+                     "signal::handle-update", listener_handle_update, test,
                      NULL);
     g_dbus_object_skeleton_add_interface(listener,
                                          G_DBUS_INTERFACE_SKELETON(iface));
@@ -227,15 +265,12 @@ test_dbus_p2p_server_setup_thread(gpointer data)
 }
 
 static void
-test_dbus_display_console(const void* data)
+test_dbus_console_register(QTestState *qts, GDBusConnection *conn,
+                           TestDBusConsoleRegister *test)
 {
     g_autoptr(GError) err = NULL;
-    g_autoptr(GDBusConnection) conn = NULL;
     g_autoptr(QemuDBusDisplay1ConsoleProxy) console = NULL;
-    g_autoptr(GMainLoop) loop = NULL;
-    QTestState *qts = NULL;
     int pair[2];
-    TestDBusConsoleRegister test = { 0, .with_map = GPOINTER_TO_INT(data) };
 #ifdef WIN32
     WSAPROTOCOL_INFOW info;
     g_autoptr(GVariant) listener = NULL;
@@ -244,8 +279,6 @@ test_dbus_display_console(const void* data)
     int idx;
 #endif
 
-    test_setup(&qts, &conn);
-
     g_assert_cmpint(qemu_socketpair(AF_UNIX, SOCK_STREAM, 0, pair), ==, 0);
 #ifndef WIN32
     fd_list = g_unix_fd_list_new();
@@ -262,9 +295,9 @@ test_dbus_display_console(const void* data)
             &err));
     g_assert_no_error(err);
 
-    test.loop = loop = g_main_loop_new(NULL, FALSE);
-    test.thread = g_thread_new(NULL, test_dbus_p2p_server_setup_thread,
-                               GINT_TO_POINTER(pair[0]));
+    test->loop = g_main_loop_new(NULL, FALSE);
+    test->thread = g_thread_new(NULL, test_dbus_p2p_server_setup_thread,
+                                GINT_TO_POINTER(pair[0]));
 
 #ifdef WIN32
     if (WSADuplicateSocketW(_get_osfhandle(pair[1]),
@@ -295,12 +328,111 @@ test_dbus_display_console(const void* data)
 #endif
         NULL,
         test_dbus_console_registered,
-        &test);
+        test);
 
-    g_main_loop_run(loop);
+    g_main_loop_run(test->loop);
+}
 
-    g_clear_object(&test.server);
-    g_clear_object(&test.listener_conn);
+static void
+test_dbus_console_cleanup(TestDBusConsoleRegister *test)
+{
+    g_clear_object(&test->server);
+    g_clear_object(&test->listener_conn);
+    g_clear_pointer(&test->loop, g_main_loop_unref);
+}
+
+static void
+test_dbus_display_console(const void *data)
+{
+    g_autoptr(GDBusConnection) conn = NULL;
+    QTestState *qts = NULL;
+    TestDBusConsoleRegister test = { 0, .with_map = GPOINTER_TO_INT(data) };
+
+    test_setup(&qts, &conn);
+    test_dbus_console_register(qts, conn, &test);
+
+    test_dbus_console_cleanup(&test);
+    g_clear_object(&conn);
+    qtest_quit(qts);
+}
+
+/* Handle whatever reaches the listener during the next @ms milliseconds. */
+static void
+test_dbus_console_turn(guint ms)
+{
+    gint64 end = g_get_monotonic_time() + ms * G_TIME_SPAN_MILLISECOND;
+
+    while (g_get_monotonic_time() < end) {
+        while (g_main_context_iteration(NULL, FALSE)) {
+        }
+        g_usleep(G_TIME_SPAN_MILLISECOND);
+    }
+}
+
+/* Wait until the picture is still: no Scanout or Update for 200 ms. */
+static void
+test_dbus_console_settle(TestDBusConsoleRegister *test)
+{
+    guint seen;
+    int i;
+
+    for (i = 0; i < 25; i++) {
+        seen = test->messages;
+        test_dbus_console_turn(200);
+        if (test->messages == seen) {
+            return;
+        }
+    }
+    g_assert_not_reached();
+}
+
+static void
+vga_crtc_write(QTestState *qts, uint8_t index, uint8_t value)
+{
+    qtest_outb(qts, 0x3d4, index);
+    qtest_outb(qts, 0x3d5, value);
+}
+
+static void
+test_dbus_display_text_resize(void)
+{
+    g_autoptr(GDBusConnection) conn = NULL;
+    QTestState *qts = NULL;
+    TestDBusConsoleRegister test = { 0 };
+    gint64 end;
+
+    test_setup(&qts, &conn);
+    test_dbus_console_register(qts, conn, &test);
+
+    /* VGA text mode, 80x25 cells of 9x16 pixels: 720x400 */
+    qtest_outb(qts, 0x3c2, 0x67);       /* CRTC at 0x3d4 */
+    vga_crtc_write(qts, 0x01, 0x4f);    /* 80 columns */
+    vga_crtc_write(qts, 0x07, 0x02);    /* bit 8 of the vertical display end */
+    vga_crtc_write(qts, 0x09, 0x0f);    /* 16 scan lines per cell */
+    vga_crtc_write(qts, 0x0e, 0x3f);    /* cursor outside the screen */
+    vga_crtc_write(qts, 0x0f, 0xff);
+    vga_crtc_write(qts, 0x12, 0x8f);    /* 400 scan lines */
+    vga_crtc_write(qts, 0x13, 0x28);    /* 80 characters per row */
+    qtest_inb(qts, 0x3da);              /* attribute controller to index */
+    qtest_outb(qts, 0x3c0, 0x20);       /* display on */
+    test_dbus_console_settle(&test);
+
+    /*
+     * Cells of 9x12 pixels, as the Windows NT 4.0 setup sets: 720x396.
+     * VGA redraws a text mode one row of cells at a time, and the client
+     * has to know the new size before the first row arrives.
+     */
+    test.watch = true;
+    vga_crtc_write(qts, 0x09, 0x0b);
+    end = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
+    while (!test.first && g_get_monotonic_time() < end) {
+        test_dbus_console_turn(10);
+    }
+    g_assert_cmpstr(test.first, ==, "Scanout");
+    g_assert_cmpuint(test.first_width, ==, 720);
+    g_assert_cmpuint(test.first_height, ==, 396);
+
+    test_dbus_console_cleanup(&test);
     g_clear_object(&conn);
     qtest_quit(qts);
 }
@@ -462,6 +594,8 @@ main(int argc, char **argv)
     qtest_add_func("/dbus-display/vm", test_dbus_display_vm);
     qtest_add_data_func("/dbus-display/console", GINT_TO_POINTER(false), test_dbus_display_console);
     qtest_add_data_func("/dbus-display/console/map", GINT_TO_POINTER(true), test_dbus_display_console);
+    qtest_add_func("/dbus-display/console/text-resize",
+                   test_dbus_display_text_resize);
     qtest_add_func("/dbus-display/keyboard", test_dbus_display_keyboard);
     if (qtest_has_machine("q35") && qtest_has_device("bochs-display")) {
         qtest_add_func("/dbus-display/hotplug", test_dbus_display_hotplug);

-- 
2.56.0.116.g6de20f6092dc


