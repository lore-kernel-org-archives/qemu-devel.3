Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3ACC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 23:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUxrE-0000ph-98; Tue, 30 Jan 2024 18:49:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rUxrC-0000pQ-Nn
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 18:49:34 -0500
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rUxrA-0003aZ-IT
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 18:49:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706658572; x=1738194572;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=bb/3yJcemveiuLaTpVp3K/Yfk9j4pt1mh8V2LegPHPE=;
 b=WFnrWlakIX8YZdPD/tqXckZ80vN8vySu+pckwN59+2Dxnl/FaS+ZUTNQ
 c/ZyIoBtQohweTPVuMxyojQyBgbu98YwKpjiD8HxQnDdS0HzP8NFEpsMR
 3J7ZJvFOjYezfoqNxhClu/nWB9/o/E26F8aqU5CeoPZ/bHXAxleBDZTh5
 iirvGLUhuLZpL1pQ+ZQE7xChvWeuadrE5Lag9v/R1DWYE11ksYh+idvXq
 6+jjm9qu8SX2XYqe2KwbuCz/BCJeiWtvEhZ3IhX/tTp8vKPPVvM4RfggU
 9zpiCbVGGAjjkAQjtBk0fMm9TDPWO7GPd3y6u6PjjMRjKNHmpFM2mfkeO A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="393887940"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; d="scan'208";a="393887940"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2024 15:49:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="737919635"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; d="scan'208";a="737919635"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orsmga003.jf.intel.com with ESMTP; 30 Jan 2024 15:49:23 -0800
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] ui/gtk: set the ui size to 0 when invisible
Date: Tue, 30 Jan 2024 15:48:39 -0800
Message-Id: <20240130234840.53122-3-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130234840.53122-1-dongwon.kim@intel.com>
References: <20240130234840.53122-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Dongwon Kim <dongwon.kim@intel.com>

UI size is set to 0 when the VC is invisible, which will prevent
the further scanout update by notifying the guest that the display
is not in active state. Then it is restored to the original size
whenever the VC becomes visible again.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 02eb667d8a..651ed3492f 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1314,10 +1314,12 @@ static void gd_menu_switch_vc(GtkMenuItem *item, void *opaque)
     GtkDisplayState *s = opaque;
     VirtualConsole *vc;
     GtkNotebook *nb = GTK_NOTEBOOK(s->notebook);
+    GdkWindow *window;
     gint page;
 
     vc = gd_vc_find_current(s);
     vc->gfx.visible = false;
+    gd_set_ui_size(vc, 0, 0);
 
     vc = gd_vc_find_by_menu(s);
     gtk_release_modifiers(s);
@@ -1325,6 +1327,9 @@ static void gd_menu_switch_vc(GtkMenuItem *item, void *opaque)
         page = gtk_notebook_page_num(nb, vc->tab_item);
         gtk_notebook_set_current_page(nb, page);
         gtk_widget_grab_focus(vc->focus);
+        window = gtk_widget_get_window(vc->gfx.drawing_area);
+        gd_set_ui_size(vc, gdk_window_get_width(window),
+                       gdk_window_get_height(window));
         vc->gfx.visible = true;
     }
 }
@@ -1356,6 +1361,7 @@ static gboolean gd_tab_window_close(GtkWidget *widget, GdkEvent *event,
     GtkDisplayState *s = vc->s;
 
     vc->gfx.visible = false;
+    gd_set_ui_size(vc, 0, 0);
     gtk_widget_set_sensitive(vc->menu_item, true);
     gd_widget_reparent(vc->window, s->notebook, vc->tab_item);
     gtk_notebook_set_tab_label_text(GTK_NOTEBOOK(s->notebook),
@@ -1391,6 +1397,7 @@ static gboolean gd_win_grab(void *opaque)
 static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
 {
     GtkDisplayState *s = opaque;
+    GdkWindow *window;
     VirtualConsole *vc = gd_vc_find_current(s);
 
     if (vc->type == GD_VC_GFX &&
@@ -1429,6 +1436,10 @@ static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
         gd_update_geometry_hints(vc);
         gd_update_caption(s);
     }
+
+    window = gtk_widget_get_window(vc->gfx.drawing_area);
+    gd_set_ui_size(vc, gdk_window_get_width(window),
+                   gdk_window_get_height(window));
     vc->gfx.visible = true;
 }
 
@@ -1753,7 +1764,9 @@ static gboolean gd_configure(GtkWidget *widget,
 {
     VirtualConsole *vc = opaque;
 
-    gd_set_ui_size(vc, cfg->width, cfg->height);
+    if (vc->gfx.visible) {
+        gd_set_ui_size(vc, cfg->width, cfg->height);
+    }
     return FALSE;
 }
 
-- 
2.34.1


