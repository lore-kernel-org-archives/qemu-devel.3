Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DF3C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 16:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAtSW-0007j5-Vr; Fri, 02 May 2025 12:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAtST-0007dk-8X
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:41:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAtSP-0006Ql-Ov
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746204109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9pnkzXpeaKPG6Ox9+z33hGrFEPUQdEVIPBVoCdXCEVQ=;
 b=UQc1qnqsSQzvwr5B1hgoShjKwZuhZdkIJZGGA2e5gPIGijEy3WsEW88J7mTBWWrpZvNfpn
 jZAA/48ouNriu86zu9qe9XU5Qq9yTfh3aEax4B5nY/wwoHrIKKvP6AC1VngSnmX2VX+7Uj
 HgNUlooMmc4SJic9cvbwQNBV6cr8CSE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-g2yz11KcOW-IzCRSkEPpAA-1; Fri, 02 May 2025 12:41:48 -0400
X-MC-Unique: g2yz11KcOW-IzCRSkEPpAA-1
X-Mimecast-MFC-AGG-ID: g2yz11KcOW-IzCRSkEPpAA_1746204107
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c0a3ff7e81so395713485a.3
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 09:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746204107; x=1746808907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9pnkzXpeaKPG6Ox9+z33hGrFEPUQdEVIPBVoCdXCEVQ=;
 b=MqCpjJNMbCfYlCwPD+KwpFDwhNd0CYKlbChEtF5YpcVZ1gFRIDMKLkhX3XdMJ7s+Wd
 bKtEYH5aBF7WpUwFJVFDqN6JxhhseV91iTwJTyGn4FpvrXSFwSVy+hnxdgYAtOg+omGo
 qvBwy7iLWo0FoRSoApiZoDC2OYawFTdDXJpLQWxbA1psbthwPL5Ydcp2gkl5BWasemO6
 Hp55COcqbx6FoLAWf/Dwf1Wnfj2Bn/RU/+pJWl/VvYbqAFSg3DkNON6CX0P4Pj9jRqcF
 CVES4r9dXfYp0/NJVIAoiUtnHSF65gEQFBtPwLa/BBzRlChfEwm2gTL9pAMLn3vf714M
 EvLw==
X-Gm-Message-State: AOJu0Yy8fkTjRBkTry63TTDOPl//iDAFp+a3mXhAsilJGjtta4+4dK3M
 VEHcPnOXlN7ZIyOEvQ7oqtNCI4VHNQ+Bcqy3iwaxYIHu8/VXCFWQ3Ah7ZrUeil0R8Qn//lMljJK
 h1jZUrxnj4/hStQUQTv4Sw+bDF5ekqFIhI1RFGApRKC7rozTppanX3e/+mfi4z1zNLfXJmJA7aD
 u+H7draWbu1ksNusq3RRNIm1BlduwW2Nh/Yw==
X-Gm-Gg: ASbGncuvOW+9tZDvClxRZGm219me6Fylc5nR6u5IKyPEHAVQAsYpAv1OoZ+WBph+StX
 uQAPQ6i1MxgJEjZiwtowuwunF5qFKV9/5947hrzxT9YVL2Lv+viwXQm58elymsalJjSGQ9gs4C+
 N9sZUTdSfvs5XobyaTRdTwC8GEEZty8Y2QdbfcSo345JqXjvL1EocrDMItDVzsQ2+mu2kHLJx/O
 YIXFmlJ9urvdBrLkCyFs9A158A564YDrkl16tuNHnz1xe7UkHjSDuB+IgU6vbrk5D/XAVKauiJf
X-Received: by 2002:a05:620a:3708:b0:7c7:a614:7214 with SMTP id
 af79cd13be357-7cad5b2e1d3mr561914985a.5.1746204106800; 
 Fri, 02 May 2025 09:41:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXXM/AI0yfy6HMeUvntalKHhg4ddS4pVx2PIBD/QE9ccJru6qYOey9GYC+BvKDBJ6iSxLNHA==
X-Received: by 2002:a05:620a:3708:b0:7c7:a614:7214 with SMTP id
 af79cd13be357-7cad5b2e1d3mr561910885a.5.1746204106392; 
 Fri, 02 May 2025 09:41:46 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cad23d1c8dsm203108385a.60.2025.05.02.09.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 09:41:45 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PULL 01/14] migration: check RDMA and capabilities are compatible on
 both sides
Date: Fri,  2 May 2025 12:41:28 -0400
Message-ID: <20250502164141.747202-2-peterx@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250502164141.747202-1-peterx@redhat.com>
References: <20250502164141.747202-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Li Zhijian <lizhijian@fujitsu.com>

Depending on the order of starting RDMA and setting capability,
they can be categorized into the following scenarios:
Source:
 S1: [set capabilities] -> [Start RDMA outgoing]
Destination:
 D1: [set capabilities] -> [Start RDMA incoming]
 D2: [Start RDMA incoming] -> [set capabilities]

Previously, compatibility between RDMA and capabilities was verified only
in scenario D1, potentially causing migration failures in other situations.

For scenarios S1 and D1, we can seamlessly incorporate
migration_transport_compatible() to address compatibility between
channels and capabilities vs transport.

For scenario D2, ensure compatibility within migrate_caps_check().

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Message-ID: <20250305062825.772629-3-lizhijian@fujitsu.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.h   |  1 +
 migration/migration.c | 30 ++++++++++++++++++++----------
 migration/options.c   | 21 +++++++++++++++++++++
 3 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/migration/options.h b/migration/options.h
index 762be4e641..82d839709e 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -57,6 +57,7 @@ bool migrate_tls(void);
 
 /* capabilities helpers */
 
+bool migrate_rdma_caps_check(bool *caps, Error **errp);
 bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp);
 
 /* parameters */
diff --git a/migration/migration.c b/migration/migration.c
index 55ec4bfab6..54fce997aa 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -259,6 +259,24 @@ migration_channels_and_transport_compatible(MigrationAddress *addr,
     return true;
 }
 
+static bool
+migration_capabilities_and_transport_compatible(MigrationAddress *addr,
+                                                Error **errp)
+{
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+        return migrate_rdma_caps_check(migrate_get_current()->capabilities,
+                                       errp);
+    }
+
+    return true;
+}
+
+static bool migration_transport_compatible(MigrationAddress *addr, Error **errp)
+{
+    return migration_channels_and_transport_compatible(addr, errp) &&
+           migration_capabilities_and_transport_compatible(addr, errp);
+}
+
 static gint page_request_addr_cmp(gconstpointer ap, gconstpointer bp)
 {
     uintptr_t a = (uintptr_t) ap, b = (uintptr_t) bp;
@@ -750,7 +768,7 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
     }
 
     /* transport mechanism not suitable for migration? */
-    if (!migration_channels_and_transport_compatible(addr, errp)) {
+    if (!migration_transport_compatible(addr, errp)) {
         return;
     }
 
@@ -769,14 +787,6 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
         }
 #ifdef CONFIG_RDMA
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
-        if (migrate_xbzrle()) {
-            error_setg(errp, "RDMA and XBZRLE can't be used together");
-            return;
-        }
-        if (migrate_multifd()) {
-            error_setg(errp, "RDMA and multifd can't be used together");
-            return;
-        }
         rdma_start_incoming_migration(&addr->u.rdma, errp);
 #endif
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
@@ -2208,7 +2218,7 @@ void qmp_migrate(const char *uri, bool has_channels,
     }
 
     /* transport mechanism not suitable for migration? */
-    if (!migration_channels_and_transport_compatible(addr, errp)) {
+    if (!migration_transport_compatible(addr, errp)) {
         return;
     }
 
diff --git a/migration/options.c b/migration/options.c
index b0ac2ea408..1f3602839d 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -448,6 +448,20 @@ static bool migrate_incoming_started(void)
     return !!migration_incoming_get_current()->transport_data;
 }
 
+bool migrate_rdma_caps_check(bool *caps, Error **errp)
+{
+    if (caps[MIGRATION_CAPABILITY_XBZRLE]) {
+        error_setg(errp, "RDMA and XBZRLE can't be used together");
+        return false;
+    }
+    if (caps[MIGRATION_CAPABILITY_MULTIFD]) {
+        error_setg(errp, "RDMA and multifd can't be used together");
+        return false;
+    }
+
+    return true;
+}
+
 /**
  * @migration_caps_check - check capability compatibility
  *
@@ -611,6 +625,13 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
         }
     }
 
+    /*
+     * On destination side, check the cases that capability is being set
+     * after incoming thread has started.
+     */
+    if (migrate_rdma() && !migrate_rdma_caps_check(new_caps, errp)) {
+        return false;
+    }
     return true;
 }
 
-- 
2.48.1


