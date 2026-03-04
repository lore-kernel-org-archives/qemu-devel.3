Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C97EFCE47
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 21:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxtgy-0004oB-IM; Wed, 04 Mar 2026 16:23:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxtgc-0004k4-Dx
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 16:23:20 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxtgW-0003RH-5s
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 16:23:18 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 35B87807E8;
 Thu, 05 Mar 2026 00:23:08 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:921::1:1b])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 5NwBA90AmW20-pdnkjuNZ; Thu, 05 Mar 2026 00:23:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1772659387;
 bh=PFEo+iWcsM7d09gvIG/H6iFjNFtCgZGUTh1E4nOFOGY=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=bJj68P/yKbJRh+PkqYZJMaREXdVtXSoziOrMmaEV3a+dagjjnl+luyX1+FuB8aVXy
 KgmBBNMEDL+Sae1b0ZEfec4JAEh00KhgZYXGgSu+vFuY4HLkY9SjGF0TGssK6z/fV4
 8Gno69oO8IQAMdzUe+6LH8b/ETd9mh+1ZbnKcfFA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de,
	vsementsov@yandex-team.ru,
	qemu-devel@nongnu.org
Subject: [PATCH v3 02/18] migration: make vmstate_save_state_v() static
Date: Thu,  5 Mar 2026 00:22:46 +0300
Message-ID: <20260304212303.667141-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260304212303.667141-1-vsementsov@yandex-team.ru>
References: <20260304212303.667141-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/migration/vmstate.h |  3 ---
 migration/vmstate.c         | 19 ++++++++++---------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 89f9f49d20a..3695afd483f 100644
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
index fccd030dfd1..651c3fe0115 100644
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


