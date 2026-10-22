Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD55960A4AC5
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=quante.one header.i=@quante.one header.a=rsa-sha256 header.s=cloudpit header.b=WmsYM1/z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJt5W-0005S6-0m; Thu, 22 Oct 2026 09:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xJt5U-0005Ri-1z
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:44:08 -0400
Received: from nx34.node02.secure-mailgate.com ([192.162.87.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xJt5R-0004YZ-5y
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:44:07 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node02.secure-mailgate.com with esmtps (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <christian@quante.one>)
 id 1xJt5N-0022qp-JD; Thu, 22 Oct 2026 15:44:02 +0200
Received: from Zeuss.fritz.box (p57b2f06c.dip0.t-ipconnect.de [87.178.240.108])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id B09CE281C96;
 Thu, 22 Oct 2026 15:44:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1792676641;
 bh=HAbgcJRIMWvejf+d2eVBi5QNqNG0X6ouyN5oW5RmWCI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WmsYM1/z1I2Yp5i+F1XWHKeOqMpahWYaYihK+iCpONBQkEtiOo+tRFuPcvIdEUMfR
 XkoYSvikrq7Kuv5cDV8brKuNamNSmU8CE9CCH6ihs5ixQp8xtz1Mxq+jHLdAevKtVi
 3DiOdYUPQpMa4aFZlKGaduuLdqvYUgvyf+ziJZqw=
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 2/2] tests/qtest/dbus-display-test: check the Scanout after
 a text resize
Date: Thu, 22 Oct 2026 15:43:33 +0200
Message-ID: <20261022134335.12241-3-christian@quante.one>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022134335.12241-1-christian@quante.one>
References: <20261022134335.12241-1-christian@quante.one>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179267664131.1250912.12079473830258782967@web279.dogado.net>
X-PPP-Vhost: quante.one
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: SB/global_tokens (0.000287407726432)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuXrliPY/UonToGsfsq8ugyJzoCuiKwS65ED
 pautRICfqSu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4ZjA9Ob/CZLcxS4VHLkkqapS5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99RMgoMVb7lebWWPLzvZvEUCPdOtYechJ/ikE1WgRg4cS6A6B6pTstltS07kaQJ8I9sYal0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgm3QTha208ypFqQwBFb
 xm4JX7semJdl8Weuy8+tlMSTQwhoy9D5QZ6a84vJal7pM1XhlAOd290vPXa7Loma0jth+x0iJ0NX
 07iZIeUSWePdS+owFPr4kjXuZPwOU47Z9+u6ffrnBlJ/YqH1yn3Cst2xbkPGIRcDT6rLne4OdACl
 OctV6sNUpLlLzrnCw1TFot2DkCrUkXoFc9xPnGOHdNrvKzHXVbgGS7w2P8nPW3J1xwRaF5dGK1eM
 UkB0FGdiCjIUUBm1A0OeWEadRp7IkjpM+zcdijFnYDwIvvgDwGlGNltqz//gVodr2Bbrpa11KQ1X
 60pfttRUJPEpY+dD8D1vIveD1kaqoOX9s49As8Lf9rIL5hu6PBBmQVXJOgy40oaNgxLGDo2IfSff
 yLpMY4GiERnEqbM7eXcjjx1NgqwoSQEiRQv+PVjjwa+Z5RFCOMQRxM2W6biFbzhekDa7/BtMWlcI
 SpJ6e8JC6wP/8HYDLw28epu/aG1pgqaCRoxNoPbHYZi/RQSVvjLZ9073r2ThsSxXvtcBnutXV2hR
 cyZeMt5qC3RC37WOfcNnA2gZY0tsDJ5OpGajzK+y6qnu2TRmCgWkeniwaIPiNK/dtWTwcPdjzQ6Y
 C7Heg3Xf7O1TOd4AR3bnyxZNhM1OcgqdW/wVtHH2Jl8eCsKWVs21EHNFpMmQSlj1IZHH2YTOuGo7
 uSjxCAheiVMc/Zdx7yWxu+m0xKrS24UQEiEcX0sIf20P9Z24W5FAMBlV4QRE+Zyl9in1H/aAwarQ
 pYDOYx/6JtUO0Mqlhs6pmFPCFjhhN7CA6xKgoHAnJs1I5c9E1S43mq3kM3Qwxv7D9C3QH5nA6BrC
 GpdIe+N1TqSjWPuDI4o4oSgbUYstBS2wVr+z782L/itpmtBVV8AcwDEGcp3bMIDG5wlpy6uLmsAa
 TUOwBUuWxQ==
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com
Received-SPF: pass client-ip=192.162.87.34; envelope-from=christian@quante.one;
 helo=nx34.node02.secure-mailgate.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
---
 tests/qtest/dbus-display-test.c | 162 +++++++++++++++++++++++++++++---
 1 file changed, 148 insertions(+), 14 deletions(-)

diff --git a/tests/qtest/dbus-display-test.c b/tests/qtest/dbus-display-test.c
index 7838ce7323..eb81b9ca05 100644
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
+
+    g_main_loop_run(test->loop);
+}
+
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
 
-    g_main_loop_run(loop);
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
 
-    g_clear_object(&test.server);
-    g_clear_object(&test.listener_conn);
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
2.53.0


