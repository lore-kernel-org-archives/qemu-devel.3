Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34FAC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 18:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD7Sp-0004KS-EJ; Fri, 31 May 2024 14:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sD7So-0004K7-DB
 for qemu-devel@nongnu.org; Fri, 31 May 2024 14:58:54 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sD7Sl-0002c3-I4
 for qemu-devel@nongnu.org; Fri, 31 May 2024 14:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717181931; x=1748717931;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=0jRuG99r3weW55HC+j9O07i4Eg0aFlyoqe0lac2duko=;
 b=P7+Rm3iFU+n1rdmFLXFyCwAdthoUI6w8slmWpVYaf7KbH8KTbrP78tff
 2mEJeaOvoYXFHlUTJY9PlNDvWG9tnQ3fpCpxTIiruxZ/KpaxhYEsTSuWo
 Dq2q+MTMjVwgemyP+wGOksWy8qEUYdQTl0Sq6J7IJLuUJ9K5wMckGhUwY
 ow3OftOnARNGXhf15as0LaOzGPvIX1qs4qbzRX1rjBflP5hNh7f+VVqzt
 bBxLNqJvJ0yTQCDVeLVlPLF/RtkY7rfgWOR5Aba//ZFLA5jK4Xvv4rj8j
 4Erd90oLirS08Z/v1z9+WU1S/Qzyb8MMuLvAbEmOEEViPrRav+pdLaS5T g==;
X-CSE-ConnectionGUID: 2vOKQRP5T8aHz42j6/D8SQ==
X-CSE-MsgGUID: 1SaEk3F2S5iW6n0i5XppXg==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13965363"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; d="scan'208";a="13965363"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2024 11:58:44 -0700
X-CSE-ConnectionGUID: lfY4CEsSSAGMVXepbUTf8w==
X-CSE-MsgGUID: EaINb3qNTNqtDSXmeMPTRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; d="scan'208";a="67442165"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by fmviesa001.fm.intel.com with ESMTP; 31 May 2024 11:58:44 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v2 2/2] ui/gtk: Add a new parameter to assign
 connectors/monitors
Date: Fri, 31 May 2024 11:58:04 -0700
Message-Id: <20240531185804.119557-3-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531185804.119557-1-dongwon.kim@intel.com>
References: <20240531185804.119557-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Vivek Kasireddy <vivek.kasireddy@intel.com>

The new parameter named "connector" can be used to assign physical
monitors/connectors to individual GFX VCs such that when the monitor
is connected or hot-plugged, the associated GTK window would be
moved to it. If the monitor is disconnected or unplugged, the
associated GTK window would be hidden and a relevant disconnect
event would be sent to the Guest.

One usage example is here:

    -display gtk,gl=on,connectors=DP-1:eDP-1:HDMI-2...

With this, the first graphic virtual console will be placed on DP-1
display, second on eDP-1 and the third on HDMI-2.

v2: Connectors is now in a string format that includes all connector
    names separated with a colon (previously it was a linked list)

    Code refactoring

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 qapi/ui.json     |  25 ++++-
 include/ui/gtk.h |   1 +
 ui/gtk.c         | 250 +++++++++++++++++++++++++++++++++++++++++++++++
 qemu-options.hx  |   4 +
 4 files changed, 279 insertions(+), 1 deletion(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index f610bce118..46ed9e76fc 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1335,13 +1335,36 @@
 # @show-menubar: Display the main window menubar.  Defaults to "on".
 #     (Since 8.0)
 #
+# @connectors: A list of physical monitor/connector names where the
+#     GTK windows containing the respective GFX VCs (virtual consoles)
+#     are to be placed. The connector names should be provided as
+#     a string, with each name separated by a colon
+#     (e.g., DP-1:DP-2:HDMI-1:HDMI-2). Each connector name in the
+#     string will be used as a label for each VC in order.
+#     VCs can be skipped by leaving an empty spot between colons
+#     (e.g., DP-1::HDMI-2). If a connector name is not provided for
+#     a VC, that VC will not be placed on any physical display and
+#     the guest will see it as disconnected. If a valid connector name
+#     is provided for a VC but its display cable is not plugged in
+#     when the guest is launched, the VC will not be displayed initially.
+#     It will appear on the display when the cable is plugged in
+#     (hot-plug). If the cable is disconnected, the VC will be hidden
+#     and the guest will see its virtual display as disconnected.
+#     Multiple VCs can share the same connector name. In this case,
+#     all VCs with that name will be displayed on the same physical
+#     monitor. However, a single VC cannot have multiple connector
+#     names.
+#
+#     (Since 9.1)
+#
 # Since: 2.12
 ##
 { 'struct'  : 'DisplayGTK',
   'data'    : { '*grab-on-hover' : 'bool',
                 '*zoom-to-fit'   : 'bool',
                 '*show-tabs'     : 'bool',
-                '*show-menubar'  : 'bool'  } }
+                '*show-menubar'  : 'bool',
+                '*connectors'    : 'str' } }
 
 ##
 # @DisplayEGLHeadless:
diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index aa3d637029..3f78ee5996 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -83,6 +83,7 @@ typedef struct VirtualConsole {
     GtkWidget *menu_item;
     GtkWidget *tab_item;
     GtkWidget *focus;
+    GdkMonitor *monitor;
     VirtualConsoleType type;
     union {
         VirtualGfxConsole gfx;
diff --git a/ui/gtk.c b/ui/gtk.c
index 3bc84090c8..dc356e1dcf 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -38,6 +38,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "qemu/option.h"
 
 #include "ui/console.h"
 #include "ui/gtk.h"
@@ -1446,6 +1447,248 @@ static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
     }
 }
 
+static void gd_ui_mon_enable(VirtualConsole *vc)
+{
+    GdkWindow *window = gtk_widget_get_window(vc->gfx.drawing_area);
+    QemuUIInfo info;
+
+    if (!dpy_ui_info_supported(vc->gfx.dcl.con)) {
+        return;
+    }
+
+    info = *dpy_get_ui_info(vc->gfx.dcl.con);
+    info.width = gdk_window_get_width(window);
+    info.height = gdk_window_get_height(window);
+    dpy_set_ui_info(vc->gfx.dcl.con, &info, false);
+}
+
+static void gd_ui_mon_disable(VirtualConsole *vc)
+{
+    QemuUIInfo info;
+
+    if (!dpy_ui_info_supported(vc->gfx.dcl.con)) {
+        return;
+    }
+
+    info = *dpy_get_ui_info(vc->gfx.dcl.con);
+    info.width = 0;
+    info.height = 0;
+    dpy_set_ui_info(vc->gfx.dcl.con, &info, false);
+}
+
+static void gd_window_show_on_monitor(GdkDisplay *dpy, VirtualConsole *vc,
+                                      gint monitor_num)
+{
+    GtkDisplayState *s = vc->s;
+    GdkMonitor *monitor = gdk_display_get_monitor(dpy, monitor_num);
+    GdkRectangle geometry;
+    if (!vc->window) {
+        gd_tab_window_create(vc);
+    }
+
+    gdk_window_show(gtk_widget_get_window(vc->window));
+    gd_update_windowsize(vc);
+    gdk_monitor_get_geometry(monitor, &geometry);
+
+    gtk_window_move(GTK_WINDOW(vc->window), geometry.x, geometry.y);
+
+    if (s->opts->has_full_screen && s->opts->full_screen) {
+        gtk_widget_set_size_request(vc->gfx.drawing_area, -1, -1);
+        gtk_window_fullscreen(GTK_WINDOW(vc->window));
+    } else if ((s->window == vc->window) && s->full_screen) {
+        gd_menu_show_tabs(GTK_MENU_ITEM(s->show_tabs_item), s);
+        if (gtk_check_menu_item_get_active(
+                    GTK_CHECK_MENU_ITEM(s->show_menubar_item))) {
+            gtk_widget_show(s->menu_bar);
+        }
+        s->full_screen = false;
+    }
+
+    vc->monitor = monitor;
+    gd_ui_mon_enable(vc);
+    gd_update_cursor(vc);
+}
+
+static int gd_monitor_lookup(GdkDisplay *dpy, char *label)
+{
+    GdkMonitor *monitor;
+    int total_monitors = gdk_display_get_n_monitors(dpy);
+    const char *model;
+    int i;
+
+    for (i = 0; i < total_monitors; i++) {
+        monitor = gdk_display_get_monitor(dpy, i);
+        model = gdk_monitor_get_model(monitor);
+        if (!model) {
+            g_warning("retrieving connector name using\n"
+                      "gdk_monitor_get_model isn't supported\n"
+                      "please do not use connectors param in\n"
+                      "current environment\n");
+            return -1;
+        }
+
+        if (monitor && !g_strcmp0(model, label)) {
+            return i;
+        }
+    }
+    return -1;
+}
+
+static gboolean gd_vc_is_misplaced(GdkDisplay *dpy, GdkMonitor *monitor,
+                                   VirtualConsole *vc)
+{
+    GdkWindow *window = gtk_widget_get_window(vc->gfx.drawing_area);
+    GdkMonitor *mon = gdk_display_get_monitor_at_window(dpy, window);
+    const char *model = gdk_monitor_get_model(monitor);
+
+    if (!vc->monitor) {
+        if (!g_strcmp0(model, vc->label)) {
+            return TRUE;
+        }
+    } else {
+        if (mon && mon != vc->monitor) {
+            return TRUE;
+        }
+    }
+    return FALSE;
+}
+
+static void gd_vc_windows_reposition(GdkDisplay *dpy, GtkDisplayState *s)
+{
+    VirtualConsole *vc;
+    GdkMonitor *monitor;
+    gint monitor_num;
+    int i;
+
+    for (i = 0; i < s->nb_vcs; i++) {
+        vc = &s->vc[i];
+        if (vc->label) {
+            monitor_num = gd_monitor_lookup(dpy, vc->label);
+            if (monitor_num >= 0) {
+                monitor = gdk_display_get_monitor(dpy, monitor_num);
+                if (gd_vc_is_misplaced(dpy, monitor, vc)) {
+                    gd_window_show_on_monitor(dpy, vc, monitor_num);
+                }
+            } else if (vc->monitor) {
+                vc->monitor = NULL;
+                gd_ui_mon_disable(vc);
+
+                /* if window exist, hide it */
+                if (vc->window) {
+                    gdk_window_hide(gtk_widget_get_window(vc->window));
+                }
+            }
+        }
+    }
+}
+
+static void gd_monitors_reset_timer(void *opaque)
+{
+    GtkDisplayState *s = opaque;
+    GdkDisplay *dpy = gdk_display_get_default();
+
+    gd_vc_windows_reposition(dpy, s);
+}
+
+static void gd_monitors_changed(GdkScreen *scr, void *opaque)
+{
+    GtkDisplayState *s = opaque;
+    QEMUTimer *mon_reset_timer;
+
+    /* This timer setup ensures the compositor finishes placing
+     * all QEMU windows after a display hot plug event
+     * before QEMU rearranges the windows based on connectors
+     * setting.
+     */
+    mon_reset_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
+                                   gd_monitors_reset_timer, s);
+    timer_mod(mon_reset_timer,
+              qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + 2000);
+}
+
+static VirtualConsole *gd_next_gfx_vc(GtkDisplayState *s)
+{
+    VirtualConsole *vc;
+    int i;
+
+    for (i = 0; i < s->nb_vcs; i++) {
+        vc = &s->vc[i];
+        if (vc->type == GD_VC_GFX &&
+            qemu_console_is_graphic(vc->gfx.dcl.con) &&
+            !vc->label) {
+            return vc;
+        }
+    }
+    return NULL;
+}
+
+static void gd_vc_free_labels(GtkDisplayState *s)
+{
+    VirtualConsole *vc;
+    int i;
+
+    for (i = 0; i < s->nb_vcs; i++) {
+        vc = &s->vc[i];
+        if (vc->type == GD_VC_GFX &&
+            qemu_console_is_graphic(vc->gfx.dcl.con)) {
+            g_free(vc->label);
+            vc->label = NULL;
+        }
+    }
+}
+
+static void gd_connectors_init(GdkDisplay *dpy, GtkDisplayState *s)
+{
+    VirtualConsole *vc;
+    gint monitor_num;
+    gboolean first_vc = TRUE;
+    char *conn = s->opts->u.gtk.connectors;
+    char *this, *ptr;
+
+    gtk_notebook_set_show_tabs(GTK_NOTEBOOK(s->notebook), FALSE);
+    gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->grab_item),
+                                   FALSE);
+    gd_vc_free_labels(s);
+
+    ptr = conn;
+
+    while (ptr < conn + strlen(conn)) {
+        this = strchr(ptr, ':');
+
+        vc = gd_next_gfx_vc(s);
+        if (!vc) {
+            break;
+        }
+        if (first_vc) {
+            vc->window = s->window;
+            first_vc = FALSE;
+        }
+
+        if (this == NULL) {
+            vc->label = g_strdup(ptr);
+        } else {
+            vc->label = g_strndup(ptr, this - ptr);
+        }
+
+        monitor_num = gd_monitor_lookup(dpy, vc->label);
+        if (monitor_num >= 0) {
+            gd_window_show_on_monitor(dpy, vc, monitor_num);
+        } else {
+            gd_ui_mon_disable(vc);
+
+            if (vc->window) {
+                gdk_window_hide(gtk_widget_get_window(vc->window));
+            }
+        }
+
+        if (this == NULL) {
+            break;
+        } else {
+            ptr = this + 1;
+        }
+    }
+}
+
 static void gd_menu_show_menubar(GtkMenuItem *item, void *opaque)
 {
     GtkDisplayState *s = opaque;
@@ -2102,6 +2345,10 @@ static void gd_connect_signals(GtkDisplayState *s)
                      G_CALLBACK(gd_menu_grab_input), s);
     g_signal_connect(s->notebook, "switch-page",
                      G_CALLBACK(gd_change_page), s);
+    if (s->opts->u.gtk.connectors) {
+        g_signal_connect(gdk_screen_get_default(), "monitors-changed",
+                         G_CALLBACK(gd_monitors_changed), s);
+    }
 }
 
 static GtkWidget *gd_create_menu_machine(GtkDisplayState *s)
@@ -2489,6 +2736,9 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
         opts->u.gtk.show_tabs) {
         gtk_menu_item_activate(GTK_MENU_ITEM(s->show_tabs_item));
     }
+    if (s->opts->u.gtk.connectors) {
+        gd_connectors_init(window_display, s);
+    }
 #ifdef CONFIG_GTK_CLIPBOARD
     gd_clipboard_init(s);
 #endif /* CONFIG_GTK_CLIPBOARD */
diff --git a/qemu-options.hx b/qemu-options.hx
index 8ca7f34ef0..ebc7181472 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2099,6 +2099,7 @@ DEF("display", HAS_ARG, QEMU_OPTION_display,
     "-display gtk[,full-screen=on|off][,gl=on|off][,grab-on-hover=on|off]\n"
     "            [,show-tabs=on|off][,show-cursor=on|off][,window-close=on|off]\n"
     "            [,show-menubar=on|off][,zoom-to-fit=on|off]\n"
+    "            [,connectors=conn1:conn2:...:connN]]\n"
 #endif
 #if defined(CONFIG_VNC)
     "-display vnc=<display>[,<optargs>]\n"
@@ -2195,6 +2196,9 @@ SRST
         ``zoom-to-fit=on|off`` : Expand video output to the window size,
                                  defaults to "off"
 
+        ``connectors=conn1:conn2...`` : VC to connector mappings to display the VC
+                                        window on a specific monitor
+
     ``curses[,charset=<encoding>]``
         Display video output via curses. For graphics device models
         which support a text mode, QEMU can display this output using a
-- 
2.34.1


