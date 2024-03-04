Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED52AC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 12:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh7Rc-0008Eg-0P; Mon, 04 Mar 2024 07:29:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mkh8=KK=redhat.com=clg@ozlabs.org>)
 id 1rh7RZ-0008DV-BI
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:29:21 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mkh8=KK=redhat.com=clg@ozlabs.org>)
 id 1rh7RX-0004a6-Ks
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:29:21 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TpJ0Y49Lnz4wyp;
 Mon,  4 Mar 2024 23:29:17 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TpJ0V52wsz4wqN;
 Mon,  4 Mar 2024 23:29:14 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 07/26] migration: Remove SaveStateHandler and
 LoadStateHandler typedefs
Date: Mon,  4 Mar 2024 13:28:25 +0100
Message-ID: <20240304122844.1888308-8-clg@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304122844.1888308-1-clg@redhat.com>
References: <20240304122844.1888308-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=mkh8=KK=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

They are only used once.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/migration/register.h | 4 ++--
 include/qemu/typedefs.h      | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index 9ab1f79512c605f0c88a45b560c57486fa054441..2e6a7d766e62f64940086b7b511249c9ff21fa62 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -18,7 +18,7 @@
 
 typedef struct SaveVMHandlers {
     /* This runs inside the BQL.  */
-    SaveStateHandler *save_state;
+    void (*save_state)(QEMUFile *f, void *opaque);
 
     /*
      * save_prepare is called early, even before migration starts, and can be
@@ -71,7 +71,7 @@ typedef struct SaveVMHandlers {
     /* This calculate the exact remaining data to transfer */
     void (*state_pending_exact)(void *opaque, uint64_t *must_precopy,
                                 uint64_t *can_postcopy);
-    LoadStateHandler *load_state;
+    int (*load_state)(QEMUFile *f, void *opaque, int version_id);
     int (*load_setup)(QEMUFile *f, void *opaque);
     int (*load_cleanup)(void *opaque);
     /* Called when postcopy migration wants to resume from failure */
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index a028dba4d0b67e87165f9f1a4e960e9e6b94477c..50c277cf0b467f782ba526041b2663207bf70945 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -151,8 +151,6 @@ typedef struct IRQState *qemu_irq;
 /*
  * Function types
  */
-typedef void SaveStateHandler(QEMUFile *f, void *opaque);
-typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
 typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
 
 #endif /* QEMU_TYPEDEFS_H */
-- 
2.44.0


