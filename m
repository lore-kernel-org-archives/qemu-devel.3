Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A4DC982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 20:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8kGs-0004CO-GO; Mon, 21 Sep 2026 16:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1x8kGi-0004BV-K8
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 16:05:43 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1x8kGh-0004xI-2m
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 16:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790021139; x=1821557139;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=+NPZiYa/RikN7zOA/SsRfoYags3Ge2kpmFpJ+5PqWSE=;
 b=kFjVETeNPyINU5TdFf+FppTs4m1p1MES7sWbQPYW5e02pP9GKeRAveeQ
 5s9uuhrNz9mBieHeczQQZFMDf8CGbfQXxMaz4baBGw18EHPC7Cu9kUKQC
 yyOKG6DqyKmWLTjq8D+DNLI9p0EgdQe89PA5PeUO30RI+2PvG+O1xeSPy
 bRgEN2tzlcQGd7gnBuJpQSl2QZK2XDgz2CDZ07nNbO58X2fuJrXc8TbG5
 6TCLCrf9xBNKaJUVRVSznYZi0u0eSdvYkhZYn6ZLuajLn1fgtY6CTZuSJ
 fhPg92jWEDXn8dfxFL0gxRYfIbDNBqaERk9FiWjykJbY93y0JEFCW8sT/ Q==;
X-CSE-ConnectionGUID: Nye7WiOZROWyHtIMtiLMSw==
X-CSE-MsgGUID: U8dFi8n5TlyB1eMkwKgnPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="94399579"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; d="scan'208";a="94399579"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 13:05:30 -0700
X-CSE-ConnectionGUID: GSSJUPS+SWSy1eoWJAIiHQ==
X-CSE-MsgGUID: EtbtK12RRCuQTEV/iRFgDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; d="scan'208";a="272001016"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.80.113.172])
 by fmviesa010.fm.intel.com with ESMTP; 21 Sep 2026 13:05:29 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] ui/gtk: Register "Grab Input" shortcut to accel_group
Date: Tue, 11 Aug 2026 03:24:25 -0700
Message-Id: <20260811102426.35538-3-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811102426.35538-1-dongwon.kim@intel.com>
References: <20260811102426.35538-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12;
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

The "Grab Input" shortcut key currently fails to trigger when the
window is in fullscreen mode because the menubar is hidden, which
disables GtkAccelMap-based shortcuts associated with it.

To ensure the accelerator remains active in fullscreen, connect it
directly to s->accel_group and explicitly set the hotkey display on
the menu item label.

v2: gd_accel_grab_input returns TRUE

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 5427c2f174..f20edc5c5b 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1959,6 +1959,14 @@ static void gd_menu_grab_input(GtkMenuItem *item, void *opaque)
     }
 }
 
+static gboolean gd_accel_grab_input(void *opaque)
+{
+    GtkDisplayState *s = opaque;
+
+    gtk_menu_item_activate(GTK_MENU_ITEM(s->grab_item));
+    return TRUE;
+}
+
 static void gd_change_page(GtkNotebook *nb, gpointer arg1, guint arg2,
                            gpointer data)
 {
@@ -2643,6 +2651,7 @@ static void gd_create_menu_view(GtkDisplayState *s, DisplayOptions *opts)
 {
     GtkWidget *view_menu;
     GtkWidget *separator;
+    GtkWidget *child;
     QemuConsole *con;
     bool zoom_to_fit = false;
     int vc, i;
@@ -2701,12 +2710,16 @@ static void gd_create_menu_view(GtkDisplayState *s, DisplayOptions *opts)
     gtk_menu_shell_append(GTK_MENU_SHELL(view_menu), s->grab_on_hover_item);
 
     s->grab_item = gtk_check_menu_item_new_with_mnemonic(_("_Grab Input"));
-    gtk_menu_item_set_accel_path(GTK_MENU_ITEM(s->grab_item),
-                                 "<QEMU>/View/Grab Input");
-    gtk_accel_map_add_entry("<QEMU>/View/Grab Input", GDK_KEY_g,
-                            HOTKEY_MODIFIERS);
     gtk_menu_shell_append(GTK_MENU_SHELL(view_menu), s->grab_item);
 
+    gtk_accel_group_connect(s->accel_group, GDK_KEY_g, HOTKEY_MODIFIERS, 0,
+                            g_cclosure_new_swap(G_CALLBACK(gd_accel_grab_input),
+                                                s, NULL));
+    child = gtk_bin_get_child(GTK_BIN(s->grab_item));
+    if (GTK_IS_ACCEL_LABEL(child)) {
+        gtk_accel_label_set_accel(GTK_ACCEL_LABEL(child),
+                                  GDK_KEY_g, HOTKEY_MODIFIERS);
+    }
     separator = gtk_separator_menu_item_new();
     gtk_menu_shell_append(GTK_MENU_SHELL(view_menu), separator);
 
-- 
2.43.0


