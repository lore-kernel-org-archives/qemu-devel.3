Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96FDC4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 03:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s20vV-0003hW-3S; Tue, 30 Apr 2024 23:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1s20vT-0003hG-Nn
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 23:46:35 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1s20vQ-0001o2-QH
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 23:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714535192; x=1746071192;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=WS8qD5SPYu1hOTahbrL1UD5TvXtq5h2Os4YX6aEILew=;
 b=QB3AAiQ+pCw8St04QXNvw6sQRtZ7fUO363MOo3lS+/nCE+Slfsx/Jpiz
 ZYi6L2z+PXPFVytmjnoggZou7n7jTkFbgV+gwu9lfck6geaxxG07rAeBZ
 xUt//67P+txvqFmUWfTriDkndglCZpftATX0X0dmI6Zn8v5l7R/FysYsK
 TPezARAW6N74GzRfXL8c4ySvsWYkptz75Uh9Ig55nD8GRGcUW+r5MRg7N
 QX5jnWu5zVhotZUV3v4kpVebTFzLfsV/DjpMhnKCeH4TfhSwFT4+MMpU7
 A/n83AevZBjlv3FwaboDjqlzkkH1jvkEgxUdS1ALxHQzo0yQgWx+wVGn4 Q==;
X-CSE-ConnectionGUID: z/IyXFy/Q52eVy/a2n/V6w==
X-CSE-MsgGUID: 435/vRqzRNq9Lb2dXncJyA==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="21669422"
X-IronPort-AV: E=Sophos;i="6.07,244,1708416000"; d="scan'208";a="21669422"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2024 20:46:29 -0700
X-CSE-ConnectionGUID: 8k+VWQGMQOOL55ghsjztWg==
X-CSE-MsgGUID: hJ+gZqTwSjuWVHjdYxgV0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,244,1708416000"; d="scan'208";a="26701143"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orviesa009.jf.intel.com with ESMTP; 30 Apr 2024 20:46:29 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
	marcandre.lureau@redhat.com
Subject: [PATCH] ui/gtk: Explicitly set the default size of new window when
 untabifying
Date: Tue, 30 Apr 2024 20:41:33 -0700
Message-Id: <20240501034133.167321-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When untabifying, the default size of the new window was inadvertently
set to the size smaller than quarter of the primary window size due
to lack of explicit configuration. This commit addresses the issue by
ensuring that the size of untabified windows is set to match the surface
size.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index 810d7fc796..269b8207d7 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1395,6 +1395,9 @@ static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
     if (!vc->window) {
         gtk_widget_set_sensitive(vc->menu_item, false);
         vc->window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
+        gtk_window_set_default_size(GTK_WINDOW(vc->window),
+                                    surface_width(vc->gfx.ds),
+                                    surface_height(vc->gfx.ds));
 #if defined(CONFIG_OPENGL)
         if (vc->gfx.esurface) {
             eglDestroySurface(qemu_egl_display, vc->gfx.esurface);
-- 
2.34.1


