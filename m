Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433D2C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 22:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK3pl-0001tU-1C; Wed, 19 Jun 2024 18:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sK3pi-0001sw-OB
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 18:31:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sK3ph-0008Qr-8w
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 18:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718836272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=19AZ/BFvRgTzFKO3dCG34bGOqdNgmbaJrAQjFDpmRek=;
 b=HLX8+Ye2sGO41sLRQp9BZVG8PEZ+eB6ns3Cq+tpGRsd/OuMBjnoB0G2KOfNSpT/gMhus0x
 CzKvYNcNJT2ZrW+wDDsucf9KW270wNkGmH3ULY13RO1K8OaweFFdLl8SpbKRZslDrINrta
 GUPcdlCV12JwMiqxL3Jq8tF9vrrcPVw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-OHX9OYWkOOS7pGLBFgX2nw-1; Wed, 19 Jun 2024 18:31:09 -0400
X-MC-Unique: OHX9OYWkOOS7pGLBFgX2nw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6b50433ada9so922816d6.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 15:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718836268; x=1719441068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=19AZ/BFvRgTzFKO3dCG34bGOqdNgmbaJrAQjFDpmRek=;
 b=H+Xvaumf+bZ4VVWt+OuED0VUbGpxHHRFc/kNR/zZDIuRl+MeXyVcHLswiuagIyIcaE
 wVAJ5bKcjY912wZIjwS1MJVWteoZM/NDWNG9VKiKUt240ZFEuKXNt+6ONwNFYYFB0c+/
 KlRVc9iEcJTgMWwVO+kROxh7dwYtCVmRObf5BIERKoftGxBgLXhmMpfRI8VhWvyMfHkE
 oInTXrJSqDuL2YQJ6IzkpiNrt3u/KrEtcSJhdC0qZK3DW6wNsF+cAeFBbTmt6gr3nmHc
 4O8/0azaWPSqCXL9ZYJNE0UxP9BTUZRF9FNDY8pNQiCC5Is168tAYKRCyZxyqC5k4h1m
 WI4g==
X-Gm-Message-State: AOJu0YySZN/Yr8xqsqH/al6oO+ipYFNIcvdJfKNYKBQ0gRIw/ev4W2OZ
 57YZ3D16Gq4PXT78rdoCV/8uu3eggOxP3O/kEnxKHoGI5lDwkXLb+5BRdiTgvsLzyLCnJUi6GFa
 xLdqevTkR9v7LRcgw6hox8SS6MMi6u+ohRMgVRhAfPpY6y0geauNlEbcPSWDn4972e8pPPMuaCy
 forSwDv/pIIpVKSz0mWL56pZC84Li89RAAyw==
X-Received: by 2002:ad4:5ecc:0:b0:6aa:3158:e8c9 with SMTP id
 6a1803df08f44-6b501d24869mr40330086d6.0.1718836268485; 
 Wed, 19 Jun 2024 15:31:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbT5Xa4fdcxcAxZMlK8ui5n+/xVTbpenhsUJTEu2pPUTECIW0TZrdq59HkL7SgaJ9c7wyyBQ==
X-Received: by 2002:ad4:5ecc:0:b0:6aa:3158:e8c9 with SMTP id
 6a1803df08f44-6b501d24869mr40329746d6.0.1718836267746; 
 Wed, 19 Jun 2024 15:31:07 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b2a5c466bfsm80844256d6.68.2024.06.19.15.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 15:31:06 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Bandan Das <bdas@redhat.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Fabiano Rosas <farosas@suse.de>,
 Jiri Denemark <jdenemar@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Eric Blake <eblake@redhat.com>, peterx@redhat.com
Subject: [PATCH v3 09/11] tests/migration-tests: migration_event_wait()
Date: Wed, 19 Jun 2024 18:30:44 -0400
Message-ID: <20240619223046.1798968-10-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240619223046.1798968-1-peterx@redhat.com>
References: <20240619223046.1798968-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Introduce a small helper to wait for a migration event, generalized from
the incoming migration path.  Make the helper easier to use by allowing it
to keep waiting until the expected event is received.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-helpers.h |  2 ++
 tests/qtest/migration-helpers.c | 31 ++++++++++++++++++++++---------
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 50095fca4a..72dba369fb 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -63,4 +63,6 @@ static inline bool probe_o_direct_support(const char *tmpfs)
 }
 #endif
 void migration_test_add(const char *path, void (*fn)(void));
+void migration_event_wait(QTestState *s, const char *target);
+
 #endif /* MIGRATION_HELPERS_H */
diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 2ca4425d71..84f49db85e 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -249,7 +249,7 @@ void migrate_set_capability(QTestState *who, const char *capability,
 void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
 {
     va_list ap;
-    QDict *args, *rsp, *data;
+    QDict *args, *rsp;
 
     va_start(ap, fmt);
     args = qdict_from_vjsonf_nofail(fmt, ap);
@@ -272,14 +272,7 @@ void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
     g_assert(qdict_haskey(rsp, "return"));
     qobject_unref(rsp);
 
-    rsp = qtest_qmp_eventwait_ref(to, "MIGRATION");
-    g_assert(qdict_haskey(rsp, "data"));
-
-    data = qdict_get_qdict(rsp, "data");
-    g_assert(qdict_haskey(data, "status"));
-    g_assert_cmpstr(qdict_get_str(data, "status"), ==, "setup");
-
-    qobject_unref(rsp);
+    migration_event_wait(to, "setup");
 }
 
 /*
@@ -518,3 +511,23 @@ bool probe_o_direct_support(const char *tmpfs)
     return true;
 }
 #endif
+
+/*
+ * Wait for a "MIGRATION" event.  This is what Libvirt uses to track
+ * migration status changes.
+ */
+void migration_event_wait(QTestState *s, const char *target)
+{
+    QDict *response, *data;
+    const char *status;
+    bool found;
+
+    do {
+        response = qtest_qmp_eventwait_ref(s, "MIGRATION");
+        data = qdict_get_qdict(response, "data");
+        g_assert(data);
+        status = qdict_get_str(data, "status");
+        found = (strcmp(status, target) == 0);
+        qobject_unref(response);
+    } while (!found);
+}
-- 
2.45.0


