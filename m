Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00847C79FAA
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4ChZ-0003hh-Gi; Wed, 09 Sep 2026 03:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1x4ChY-0003hK-AS
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 03:26:36 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1x4ChV-0003GE-Pn
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 03:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788938793; x=1820474793;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2nQRgJ96Wj/b4Cc4pxS27IMcBkPrEosZA9dSSEpQJdA=;
 b=V4snvsbw0CWSHTV6qkfWd2BZ/8KjCPA6NPFXhilidMkUQuj2zxQQuTms
 4Wo+DjlKMzslUGMPiOAhVHJectXN0W5MOKyeSA7oj43Mracq7vm5Jro/l
 A4LWThNbg9RtCj+PqgP4R0K74yKpnPq1ZSZDFWDLdPtYpXP9cjc0ndg5X
 6OvK1xEFE29s/uGxu9a5GkjbvMDHsWvC3wdKd1rtJ5ybXjuF9zJ0Y8Vt+
 vmM1K+xQ7jUpUgXuI0tbG4XV47dkLECB/7vRd5cpqoyYcb++6875R1RMm
 Br61W0H75cvbFw449/5d5pdIoqizc0N/VKPj2xWHzhdCzJTpb198A9Xeg A==;
X-CSE-ConnectionGUID: CmCJbBU0RkWBARRLnTAl7Q==
X-CSE-MsgGUID: W3Z44bOEQYSpI6cJUXsb5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="91866434"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="91866434"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 00:25:51 -0700
X-CSE-ConnectionGUID: nTZJlChgQTq5Z3BfHywDEw==
X-CSE-MsgGUID: MQOKGCSESkOQCqXo/ltUuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="270744556"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.80.113.172])
 by orviesa008.jf.intel.com with ESMTP; 09 Sep 2026 00:25:51 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2] ui/gtk: Handle empty notebook state in menu handlers
Date: Wed, 29 Jul 2026 14:44:56 -0700
Message-Id: <20260729214456.3350-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Dongwon Kim <dongwon.kim@intel.com>

When all virtual console tabs are detached (untabified) from the main
window, the notebook contains no active pages, causing
gtk_notebook_get_current_page() to return -1.

Because gtk_notebook_page_num() also returns -1 for any detached VC,
gd_vc_find_by_page(s, -1) mistakenly matches the first detached
console. As a result, gd_vc_find_current() incorrectly returns
a detached VC instead of NULL. Menu actions executed on the empty main
window then unintentionally operate on that detached VC.

Fix this by having gd_vc_find_current() explicitly check for page < 0
and return NULL when the notebook has no active page. In addition, add
NULL checks for the current VC across relevant UI menu callbacks so
actions are properly bypassed or reset when no console tab is focused
in the main window.

Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 7078d89d67..0b5139ef31 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -184,6 +184,11 @@ static VirtualConsole *gd_vc_find_current(GtkDisplayState *s)
     gint page;
 
     page = gtk_notebook_get_current_page(GTK_NOTEBOOK(s->notebook));
+
+    if (page < 0) {
+        return NULL;
+    }
+
     return gd_vc_find_by_page(s, page);
 }
 
@@ -1462,7 +1467,10 @@ static void gd_menu_show_tabs(GtkMenuItem *item, void *opaque)
     } else {
         gtk_notebook_set_show_tabs(GTK_NOTEBOOK(s->notebook), FALSE);
     }
-    gd_update_windowsize(vc);
+
+    if (vc) {
+        gd_update_windowsize(vc);
+    }
 }
 
 static int gd_vc_notebook_pos(GtkDisplayState *s, VirtualConsole *target)
@@ -1535,6 +1543,10 @@ static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
     GtkDisplayState *s = opaque;
     VirtualConsole *vc = gd_vc_find_current(s);
 
+    if (!vc) {
+        return;
+    }
+
     if (vc->type == GD_VC_GFX &&
         qemu_console_is_graphic(vc->gfx.dcl.con)) {
         gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->grab_item),
@@ -1588,7 +1600,10 @@ static void gd_menu_show_menubar(GtkMenuItem *item, void *opaque)
     } else {
         gtk_widget_hide(s->menu_bar);
     }
-    gd_update_windowsize(vc);
+
+    if (vc) {
+        gd_update_windowsize(vc);
+    }
 }
 
 static void gd_accel_show_menubar(void *opaque)
@@ -1605,7 +1620,7 @@ static void gd_menu_full_screen(GtkMenuItem *item, void *opaque)
     if (!s->full_screen) {
         gtk_notebook_set_show_tabs(GTK_NOTEBOOK(s->notebook), FALSE);
         gtk_widget_hide(s->menu_bar);
-        if (vc->type == GD_VC_GFX) {
+        if (vc && vc->type == GD_VC_GFX) {
             gtk_widget_set_size_request(vc->gfx.drawing_area, -1, -1);
         }
         gtk_window_fullscreen(GTK_WINDOW(s->window));
@@ -1618,14 +1633,16 @@ static void gd_menu_full_screen(GtkMenuItem *item, void *opaque)
             gtk_widget_show(s->menu_bar);
         }
         s->full_screen = FALSE;
-        if (vc->type == GD_VC_GFX) {
+        if (vc && vc->type == GD_VC_GFX) {
             vc->gfx.scale_x = vc->gfx.preferred_scale;
             vc->gfx.scale_y = vc->gfx.preferred_scale;
             gd_update_windowsize(vc);
         }
     }
 
-    gd_update_cursor(vc);
+    if (vc) {
+        gd_update_cursor(vc);
+    }
 }
 
 static void gd_accel_full_screen(void *opaque)
@@ -1639,6 +1656,10 @@ static void gd_menu_zoom_in(GtkMenuItem *item, void *opaque)
     GtkDisplayState *s = opaque;
     VirtualConsole *vc = gd_vc_find_current(s);
 
+    if (!vc) {
+        return;
+    }
+
     gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->zoom_fit_item),
                                    FALSE);
 
@@ -1659,6 +1680,10 @@ static void gd_menu_zoom_out(GtkMenuItem *item, void *opaque)
     GtkDisplayState *s = opaque;
     VirtualConsole *vc = gd_vc_find_current(s);
 
+    if (!vc) {
+        return;
+    }
+
     gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->zoom_fit_item),
                                    FALSE);
 
@@ -1676,6 +1701,10 @@ static void gd_menu_zoom_fixed(GtkMenuItem *item, void *opaque)
     GtkDisplayState *s = opaque;
     VirtualConsole *vc = gd_vc_find_current(s);
 
+    if (!vc) {
+        return;
+    }
+
     vc->gfx.scale_x = vc->gfx.preferred_scale;
     vc->gfx.scale_y = vc->gfx.preferred_scale;
 
@@ -1687,6 +1716,10 @@ static void gd_menu_zoom_fit(GtkMenuItem *item, void *opaque)
     GtkDisplayState *s = opaque;
     VirtualConsole *vc = gd_vc_find_current(s);
 
+    if (!vc) {
+        return;
+    }
+
     if (gtk_check_menu_item_get_active(GTK_CHECK_MENU_ITEM(s->zoom_fit_item))) {
         s->free_scale = TRUE;
     } else {
@@ -1800,6 +1833,11 @@ static void gd_menu_grab_input(GtkMenuItem *item, void *opaque)
     VirtualConsole *vc = gd_vc_find_current(s);
 
     if (gd_is_grab_active(s)) {
+        if (!vc) {
+            gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->grab_item),
+                                           FALSE);
+            return;
+        }
         gd_grab_keyboard(vc, "user-request-main-window");
         gd_grab_pointer(vc, "user-request-main-window");
     } else {
@@ -1807,7 +1845,9 @@ static void gd_menu_grab_input(GtkMenuItem *item, void *opaque)
         gd_ungrab_pointer(s);
     }
 
-    gd_update_cursor(vc);
+    if (vc) {
+        gd_update_cursor(vc);
+    }
 }
 
 static void gd_change_page(GtkNotebook *nb, gpointer arg1, guint arg2,
@@ -1983,6 +2023,10 @@ static void gd_menu_copy(GtkMenuItem *item, void *opaque)
     GtkDisplayState *s = opaque;
     VirtualConsole *vc = gd_vc_find_current(s);
 
+    if (!vc) {
+        return;
+    }
+
 #if VTE_CHECK_VERSION(0, 50, 0)
     vte_terminal_copy_clipboard_format(VTE_TERMINAL(vc->vte.terminal),
                                        VTE_FORMAT_TEXT);
-- 
2.43.0


