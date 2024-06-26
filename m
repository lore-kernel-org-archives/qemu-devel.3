Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73649C2BBCA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 03:00:08 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMGZZ-0002Qh-1F; Tue, 25 Jun 2024 20:31:47 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sMGZI-0002Pw-Mr
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 20:31:24 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sMGYY-00057H-Il
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 20:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719361839; x=1750897839;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=tCWf9Ded02uZKg7enBRwrRrvysh18GPrddTIrYhqoUk=;
 b=Ud5u+DXb/3j0gVdPEy0Dc0pazkBS6iXQDVi7DXthemNd21I8kOXoiQin
 JK745uvLA/3Rbn9hUAtHlV3zzwFBul1kKc632ie3C54RVL/6A1Lw4kVdG
 OuzdhOwtTNTnCgZQXXwSvzAgM0XSCrhKDhTZKrECBMmdbpxjwgAg10B4i
 Vvs5ZBNDdFxU7IQqZZEION7RPo9XEMN4mVrCKAxNEEQxfzh7eubqU+lST
 Ho3+AwYrJTAQn/GEHvXAc2oi1ULkk+2rCpwRYB2j/YNLXhTkG+uriafSk
 D/+DkbPw7s8gMTnBxtm6xAB5bfjqq5MGyN3Q1v2Nuu/OJVo/RtoUwPuPw g==;
X-CSE-ConnectionGUID: cRy5Wo/VSWuwyDGkjKpbYw==
X-CSE-MsgGUID: jbIPoqRiSPaBqQy8R5yD+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="38922351"
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; d="scan'208";a="38922351"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2024 17:09:42 -0700
X-CSE-ConnectionGUID: h0yq391ARp+QRxqe/gvPcg==
X-CSE-MsgGUID: 9lNf7HgbQNi9ufBOmvKLHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; d="scan'208";a="43889055"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by fmviesa009.fm.intel.com with ESMTP; 25 Jun 2024 17:09:42 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH] ui/gtk: Negative Page number is not valid
Date: Tue, 25 Jun 2024 17:08:35 -0700
Message-Id: <20240626000835.248538-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Negative page number means the page with that number does not
belong to the notebook so it shouldn't be used as a valid page
number in gd_vc_find_by_page. This function should just return
null in such case.

This change, however, will cause a segfault during detaching
/untabifying process in gtk_release_modifiers because the
current VC's page number suddenly becomes '-1' as soon as
the VC is detached, which makes gd_vc_find_by_page return
null. So gtk_release_modifiers should do the null check on
VC returned from gd_vc_find_by_page.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 93b13b7a30..1f8523fd81 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -164,7 +164,7 @@ static VirtualConsole *gd_vc_find_by_page(GtkDisplayState *s, gint page)
     for (i = 0; i < s->nb_vcs; i++) {
         vc = &s->vc[i];
         p = gtk_notebook_page_num(GTK_NOTEBOOK(s->notebook), vc->tab_item);
-        if (p == page) {
+        if (p > -1 && p == page) {
             return vc;
         }
     }
@@ -357,7 +357,7 @@ static void gtk_release_modifiers(GtkDisplayState *s)
 {
     VirtualConsole *vc = gd_vc_find_current(s);
 
-    if (vc->type != GD_VC_GFX ||
+    if (!vc || vc->type != GD_VC_GFX ||
         !qemu_console_is_graphic(vc->gfx.dcl.con)) {
         return;
     }
-- 
2.34.1


