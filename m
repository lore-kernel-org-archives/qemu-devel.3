Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1015AC5B56A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 21:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtXdt-0000BO-1J; Fri, 20 Feb 2026 16:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtXdq-00009d-9T
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 16:02:26 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtXdl-0002iI-R2
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 16:02:25 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 0D207C0232;
 Sat, 21 Feb 2026 00:02:18 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:87::1:2c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id G2kijG5A6qM0-hIrVorsE; Sat, 21 Feb 2026 00:02:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771621337;
 bh=0mU3Lt9yun/tgb14TQih/S8+mRE1OnhCCTlMxN7auVQ=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=itfhKWwHZsv8lOaO11W+EykDIf3a/FAi5naHBKFQCx8jlwSa2x4USf4ZkzTgGecy/
 FIKVjJBxqTMZLYUWHA5hRwy46NJ4RR2EMLV6wfTZ2DZPL9rHLbtInUbMv64sn6BEHt
 Y9xjYUmHDCt0LuN2JyvsJsnUbHt8Wb4VwjIedfLo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v2 02/16] migration: make vmstate_save_state_v() static
Date: Sat, 21 Feb 2026 00:02:00 +0300
Message-ID: <20260220210214.800050-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220210214.800050-1-vsementsov@yandex-team.ru>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It's used only in vmstate.c.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/migration/vmstate.h |  3 ---
 migration/vmstate.c         | 19 ++++++++++---------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 89f9f49d20..3695afd483 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1234,9 +1234,6 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, int version_id, Error **errp);
 int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, JSONWriter *vmdesc, Error **errp);
-int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
-                         void *opaque, JSONWriter *vmdesc,
-                         int version_id, Error **errp);
 
 bool vmstate_section_needed(const VMStateDescription *vmsd, void *opaque);
 
diff --git a/migration/vmstate.c b/migration/vmstate.c
index fccd030dfd..651c3fe011 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -420,15 +420,9 @@ bool vmstate_section_needed(const VMStateDescription *vmsd, void *opaque)
     return true;
 }
 
-
-int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
-                       void *opaque, JSONWriter *vmdesc_id, Error **errp)
-{
-    return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->version_id, errp);
-}
-
-int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
-                         void *opaque, JSONWriter *vmdesc, int version_id, Error **errp)
+static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
+                                void *opaque, JSONWriter *vmdesc,
+                                int version_id, Error **errp)
 {
     ERRP_GUARD();
     int ret = 0;
@@ -608,6 +602,13 @@ vmstate_get_subsection(const VMStateDescription * const *sub,
     return NULL;
 }
 
+int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
+                       void *opaque, JSONWriter *vmdesc_id, Error **errp)
+{
+    return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->version_id,
+                                errp);
+}
+
 static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
                                    void *opaque, Error **errp)
 {
-- 
2.52.0


