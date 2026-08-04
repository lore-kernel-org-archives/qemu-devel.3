Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEB8C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 18:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6BkW-0003Sr-1H; Mon, 14 Sep 2026 14:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1x6BkU-0003Q8-9v
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:49:50 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1x6BkS-0006OL-Df
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789411788; x=1820947788;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=yFQLxgwQ+9ObOYfSqSOfBTk3zp8jq+0s3RvLzzWwmbg=;
 b=VXmYGMEBhzVD6Z9cgAjns7Cs7p/fEY5xs7yO9pHcSexRhaRfOdGUWha/
 FFG0A5VXqRdRTXo6ygDGW5tjjJExzH6/MC0LRf4PRkD0rKHju0US0LQr9
 tfH08BKki7C6xBfjb5mZ9iKMg2Z4LtnIpMDh5fOTCgWwXRYfAeBbTecPY
 tmwNUPg0joPPxOdFLk9onka2THIH4GYGR0LYa9lEZkXWEQCsoZLt5v3QP
 zqb1fn6GU8t4Y+SplGmLTHXP1GDB5WvYPGM1uWNHM1pFQF+2jd37FcSb4
 uHpI/8/MV0A35yebC5AMByf/4OaGAMqVfUhNksODdlIhQO9u9JiEx9kHC w==;
X-CSE-ConnectionGUID: pFf3rh/OQwCBl/Zvk/BoYQ==
X-CSE-MsgGUID: bDlJlmbJTLCDOv5wtPJ0nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="88908982"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="88908982"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 11:49:45 -0700
X-CSE-ConnectionGUID: Co4b3DbuQKisB+7/zErjXg==
X-CSE-MsgGUID: E9g0oGfqQfG7HwFCd7V23g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="310994084"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.80.113.172])
 by orviesa001.jf.intel.com with ESMTP; 14 Sep 2026 11:49:45 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] ui/gtk: enable fullscreen hotkey for detached windows
Date: Tue,  4 Aug 2026 02:08:46 -0700
Message-Id: <20260804090847.18871-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18;
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

Currently, the fullscreen toggle hotkey (Ctrl+Alt+f by default) only
functions for the main QEMU window. When a Virtual Console (VC) is
detached into its own separate window (untabified), it loses this
capability.

Implement a toggle helper, gd_win_fullscreen, and connect it to
the 'f' accelerator when a detached window is created in
gd_menu_untabify. This allows individual detached windows to be
toggled fullscreen independently.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk.c | 46 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index a723c8215d..3c9720a330 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1556,6 +1556,42 @@ static gboolean gd_win_grab(void *opaque)
     return TRUE;
 }
 
+static void gd_win_fullscreen(void *opaque)
+{
+    VirtualConsole *vc = opaque;
+    GtkDisplayState *s = vc->s;
+    GdkWindow *window;
+    GdkWindowState state;
+
+    if (!vc->window || !gtk_widget_get_realized(vc->window)) {
+        return;
+    }
+
+    window = gtk_widget_get_window(vc->window);
+    if (!window) {
+        return;
+    }
+
+    state = gdk_window_get_state(window);
+
+    if (state & GDK_WINDOW_STATE_FULLSCREEN) {
+        gtk_window_unfullscreen(GTK_WINDOW(vc->window));
+
+        if (vc->type == GD_VC_GFX) {
+            if (!s->free_scale) {
+                vc->gfx.scale_x = 1.0;
+                vc->gfx.scale_y = 1.0;
+            }
+            gd_update_windowsize(vc);
+        }
+    } else {
+        if (vc->type == GD_VC_GFX) {
+            gtk_widget_set_size_request(vc->gfx.drawing_area, -1, -1);
+        }
+        gtk_window_fullscreen(GTK_WINDOW(vc->window));
+    }
+}
+
 static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
 {
     GtkDisplayState *s = opaque;
@@ -1590,9 +1626,13 @@ static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
             GtkAccelGroup *ag = gtk_accel_group_new();
             gtk_window_add_accel_group(GTK_WINDOW(vc->window), ag);
 
-            GClosure *cb = g_cclosure_new_swap(G_CALLBACK(gd_win_grab),
-                                               vc, NULL);
-            gtk_accel_group_connect(ag, GDK_KEY_g, HOTKEY_MODIFIERS, 0, cb);
+            GClosure *cb_grab = g_cclosure_new_swap(G_CALLBACK(gd_win_grab),
+                                                    vc, NULL);
+            gtk_accel_group_connect(ag, GDK_KEY_g, HOTKEY_MODIFIERS, 0, cb_grab);
+            GClosure *cb_fullscreen = g_cclosure_new_swap(
+                                             G_CALLBACK(gd_win_fullscreen),
+                                             vc, NULL);
+            gtk_accel_group_connect(ag, GDK_KEY_f, HOTKEY_MODIFIERS, 0, cb_fullscreen);
         }
 
         gd_rebuild_vc_menu(s);
-- 
2.43.0


