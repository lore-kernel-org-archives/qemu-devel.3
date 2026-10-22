Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486C7606A32F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 19:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kLiDSy5N
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJydv-0005MD-9E; Thu, 22 Oct 2026 15:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1xJydZ-0005DY-4C
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 15:39:41 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1xJydV-0002eH-8v
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 15:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792697977; x=1824233977;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WqOWzvrW7tGRdboN2WFbumhemB3Ixj/nAYPc3HPjbnU=;
 b=kLiDSy5NVZRRLvcc1Cxd2tALmrGGl/nrVIksqiD5KIuGcwQuLYAdWX5r
 Ho765wWUImGK+asKu9YE9KbtnNvzbjALpq0OqSTSQnnJBgyXm4XwT+ocn
 uYN/OzCY+bnadEju9l++GPp/2PULqOZxj3b+xRXG189eDENzlssHEXxNA
 AK5RGeJm1tKMR6Fn870nPSyrTfJ/h5B5Yft9UIcnhO0nmNJv8rlrE6sEF
 ib9JZdB7S3YexrtXPkKZ7aWuSbKSiC3pyex7Ly1bbGnZUUwk+OuoBX7D5
 XtNuionyCRJItdULUs2ADjZCprJdiR8LyJA0Gl/T/LFH89Oz1In/jsOdS A==;
X-CSE-ConnectionGUID: 87KNOmH/S3CUlpRc8ENs+g==
X-CSE-MsgGUID: ehxdDa0+QbSiPi/mIQkGYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1563784"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1563784"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 12:39:28 -0700
X-CSE-ConnectionGUID: 5GPjs7vhSpWk6c79JdnFFg==
X-CSE-MsgGUID: z1+FFpw+SeWhQi5nEaPTJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3530579"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.80.113.172])
 by orviesa006.jf.intel.com with ESMTP; 22 Oct 2026 12:39:27 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Subject: [PATCH 2/3] ui/gtk: Register "Grab Input" shortcut to accel_group
Date: Thu, 22 Oct 2026 12:39:43 -0700
Message-Id: <20261022193944.19266-3-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022193944.19266-1-dongwon.kim@intel.com>
References: <20261022193944.19266-1-dongwon.kim@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
2.43.0


