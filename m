Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE80B606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 04:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Bwy3EUIg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLBzy-0002JW-O6; Mon, 26 Oct 2026 00:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1xLByB-0002DE-C9
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 00:06:00 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1xLBy9-000329-N7
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 00:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792987558; x=1824523558;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=dDJ1sro5kAemuELFanli1ceAFwwLgYt9RNgYhamvZLE=;
 b=Bwy3EUIg/OaH6t2nzF8tqETTVsDeVFy6ATbDPiPXmdGmPjk0Wvhx//TD
 jE8CmnWJMw2YWqmFdVhjYXkqaOtAOKFGusEadPSbBxPw09wi3hEd0hzWi
 MPmEzVWbBwEK/22MWjeuEoUhnvip7Djufki1Z7ph9qTMIRIHpDyFvf8h1
 eYBEdz/JmdPWawFf4nzjUzLDc1CBlMV8z49Pcxuprp2zer08wpA8Z1IQf
 21NOKQ0K4f1KNplWNloeU0p9tPj0S4Du6E2WSNexp1BTL9l1P+tysvVmt
 J8SJEixcxTaMbXVHf1s6ySzycScqhVZP6ZkHGpG3zj1E45uKCK1BkiQYO g==;
X-CSE-ConnectionGUID: 3UaGYAoFTbiXQaHjhP6tTw==
X-CSE-MsgGUID: eC04uVinShGBMe2ahFFGbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1524786"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1524786"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2026 21:05:12 -0700
X-CSE-ConnectionGUID: XeIjFMjZTti1UHd2T+qIOg==
X-CSE-MsgGUID: RttcWnKLT8enOm1ch0rpLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4213617"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com (HELO [127.0.1.1])
 ([10.80.113.172])
 by orviesa009.jf.intel.com with ESMTP; 25 Oct 2026 21:05:13 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
Date: Sun, 25 Oct 2026 21:05:19 -0700
Subject: [PATCH v4 2/3] ui/gtk: Register "Grab Input" shortcut to accel_group
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261025-gtk-ui-v4-v4-2-6cf2b6ffeb55@intel.com>
References: <20261025-gtk-ui-v4-v4-0-6cf2b6ffeb55@intel.com>
In-Reply-To: <20261025-gtk-ui-v4-v4-0-6cf2b6ffeb55@intel.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Dongwon Kim <dongwon.kim@intel.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=198.175.65.9; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 724ede5633..10db77414a 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1971,6 +1971,14 @@ static void gd_menu_grab_input(GtkMenuItem *item, void *opaque)
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
@@ -2684,6 +2692,7 @@ static void gd_create_menu_view(GtkDisplayState *s, DisplayOptions *opts)
 {
     GtkWidget *view_menu;
     GtkWidget *separator;
+    GtkWidget *child;
     QemuConsole *con;
     bool zoom_to_fit = false;
     int vc, i;
@@ -2742,12 +2751,16 @@ static void gd_create_menu_view(GtkDisplayState *s, DisplayOptions *opts)
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
2.34.1


