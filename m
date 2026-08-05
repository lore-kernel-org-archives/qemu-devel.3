Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479F9C88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 19:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6YPD-0003j6-VN; Tue, 15 Sep 2026 15:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1x6YPB-0003ie-Ah
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 15:01:21 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1x6YP9-0004nc-1T
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 15:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789498879; x=1821034879;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=vgxs/+gkYc+2Hzuz8/8g9dXNPOT6DyjXFCtjN6fu0Us=;
 b=Tstj8eZvT53vZD5eNTGGWo/6rnDI/LX4QCUnQnG7suzFLsBrGnl7tTkf
 r0H1ZFLCJP7QmAZil73sHahzpvRq9W0jhjICCL2HXzegD2VBEubxRIYSD
 TbJWKbXaLohuVaqqcchY66yOv3ZiuouCpTdFawq0OrwC+cLMh4B1J5Dgv
 nKpUHj7HDgWXXHGVFR9KJEftd5yQkTa5N9+11VyP3xlXKWtspJGD1AlF/
 EbV9bUNq4CxPudr2/3IZUzC0j32ra4oYU3m4oHNFMgq6gTHKF6wIXWiD7
 woKrzrn2ozTpJ/+HtViqaK1azBNTN1//C7KhN5gipVKyEDiWCiqDO1A9/ w==;
X-CSE-ConnectionGUID: lev7JtJsTfmLTvIfYRtscA==
X-CSE-MsgGUID: whD1NtF2SDuQR+kuXoYT5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101222063"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="101222063"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 12:01:16 -0700
X-CSE-ConnectionGUID: MDSz/16xQoeoKedYQYEUzQ==
X-CSE-MsgGUID: RoWMm/FpSEe5utVrATWu5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1506442"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.80.113.172])
 by fmviesa013.fm.intel.com with ESMTP; 15 Sep 2026 12:01:17 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH] ui/gtk: Enable fullscreen and zoom hotkeys for detached
 windows
Date: Wed,  5 Aug 2026 02:20:16 -0700
Message-Id: <20260805092017.21028-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
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

Currently, the fullscreen toggle hotkey (Ctrl+Alt+f by default) and zoom
hotkeys (Ctrl+Alt++, Ctrl+Alt+-, Ctrl+Alt+0) only function for the main
QEMU window. When a VC is detached (untabified), it loses these capabilities.

Implement toggle helpers, gd_win_full_screen and zoom helpers
(gd_win_zoom_in, gd_win_zoom_out, gd_win_zoom_fixed) and connect them
to the detached window's accelerator group in gd_menu_untabify.

Also remove a leftover debug fprintf in gd_win_grab.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 98 insertions(+), 4 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index a723c8215d..632e302ed7 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1547,7 +1547,6 @@ static gboolean gd_win_grab(void *opaque)
 {
     VirtualConsole *vc = opaque;
 
-    fprintf(stderr, "%s: %s\n", __func__, vc->label);
     if (vc->s->ptr_owner) {
         gd_ungrab_pointer(vc->s);
     } else {
@@ -1556,6 +1555,86 @@ static gboolean gd_win_grab(void *opaque)
     return TRUE;
 }
 
+static gboolean gd_win_full_screen(void *opaque)
+{
+    VirtualConsole *vc = opaque;
+    GdkWindow *window;
+    GdkWindowState state;
+
+    if (!vc->window || !gtk_widget_get_realized(vc->window)) {
+        return TRUE;
+    }
+
+    window = gtk_widget_get_window(vc->window);
+    if (!window) {
+        return TRUE;
+    }
+
+    state = gdk_window_get_state(window);
+
+    if (state & GDK_WINDOW_STATE_FULLSCREEN) {
+        gtk_window_unfullscreen(GTK_WINDOW(vc->window));
+
+        if (vc->type == GD_VC_GFX) {
+            vc->gfx.scale_x = vc->gfx.preferred_scale;
+            vc->gfx.scale_y = vc->gfx.preferred_scale;
+            gd_update_windowsize(vc);
+        }
+    } else {
+        if (vc->type == GD_VC_GFX) {
+            gtk_widget_set_size_request(vc->gfx.drawing_area, -1, -1);
+        }
+        gtk_window_fullscreen(GTK_WINDOW(vc->window));
+    }
+
+    gd_update_cursor(vc);
+    return TRUE;
+}
+
+static gboolean gd_win_zoom_in(void *opaque)
+{
+    VirtualConsole *vc = opaque;
+    GtkDisplayState *s = vc->s;
+
+    gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->zoom_fit_item),
+                                   FALSE);
+
+    vc->gfx.scale_x += VC_SCALE_STEP;
+    vc->gfx.scale_y += VC_SCALE_STEP;
+
+    gd_update_windowsize(vc);
+    return TRUE;
+}
+
+static gboolean gd_win_zoom_out(void *opaque)
+{
+    VirtualConsole *vc = opaque;
+    GtkDisplayState *s = vc->s;
+
+    gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->zoom_fit_item),
+                                   FALSE);
+
+    vc->gfx.scale_x -= VC_SCALE_STEP;
+    vc->gfx.scale_y -= VC_SCALE_STEP;
+
+    vc->gfx.scale_x = MAX(vc->gfx.scale_x, VC_SCALE_MIN);
+    vc->gfx.scale_y = MAX(vc->gfx.scale_y, VC_SCALE_MIN);
+
+    gd_update_windowsize(vc);
+    return TRUE;
+}
+
+static gboolean gd_win_zoom_fixed(void *opaque)
+{
+    VirtualConsole *vc = opaque;
+
+    vc->gfx.scale_x = vc->gfx.preferred_scale;
+    vc->gfx.scale_y = vc->gfx.preferred_scale;
+
+    gd_update_windowsize(vc);
+    return TRUE;
+}
+
 static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
 {
     GtkDisplayState *s = opaque;
@@ -1590,9 +1669,24 @@ static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
             GtkAccelGroup *ag = gtk_accel_group_new();
             gtk_window_add_accel_group(GTK_WINDOW(vc->window), ag);
 
-            GClosure *cb = g_cclosure_new_swap(G_CALLBACK(gd_win_grab),
-                                               vc, NULL);
-            gtk_accel_group_connect(ag, GDK_KEY_g, HOTKEY_MODIFIERS, 0, cb);
+            gtk_accel_group_connect(ag, GDK_KEY_g, HOTKEY_MODIFIERS, 0,
+                    g_cclosure_new_swap(G_CALLBACK(gd_win_grab),
+                                        vc, NULL));
+            gtk_accel_group_connect(ag, GDK_KEY_f, HOTKEY_MODIFIERS, 0,
+                    g_cclosure_new_swap(G_CALLBACK(gd_win_full_screen),
+                                        vc, NULL));
+            gtk_accel_group_connect(ag, GDK_KEY_plus, HOTKEY_MODIFIERS, 0,
+                    g_cclosure_new_swap(G_CALLBACK(gd_win_zoom_in),
+                                        vc, NULL));
+            gtk_accel_group_connect(ag, GDK_KEY_equal, HOTKEY_MODIFIERS, 0,
+                    g_cclosure_new_swap(G_CALLBACK(gd_win_zoom_in),
+                                        vc, NULL));
+            gtk_accel_group_connect(ag, GDK_KEY_minus, HOTKEY_MODIFIERS, 0,
+                    g_cclosure_new_swap(G_CALLBACK(gd_win_zoom_out),
+                                        vc, NULL));
+            gtk_accel_group_connect(ag, GDK_KEY_0, HOTKEY_MODIFIERS, 0,
+                    g_cclosure_new_swap(G_CALLBACK(gd_win_zoom_fixed),
+                                        vc, NULL));
         }
 
         gd_rebuild_vc_menu(s);
-- 
2.43.0


