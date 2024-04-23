Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DA5C10F15
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOn3-0001pe-2u; Tue, 23 Apr 2024 18:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmV-0001Qv-KU
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmR-00065v-Oe
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713911907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d8tdYWqm0jGED0Z2NZXkzbiQXY2iDqRN/UMYVn/huvg=;
 b=RfU7p2KWNRSSOGDBptiEz8nsXYFu4is7B801CWCIWJ9WgNyttMXHVj5NlUyT7RM6ZJ329x
 8DL+hB6h2iSdg4MBvZ6xs3i5iKzaB2ZHmFm80G9fMG62qJiWPque0TfXfSvwmDzSKmTAni
 yhbKlXHEOmMtCNJXgvKDJVK0DrvTxNg=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-XOw_T4KnN_yHp9kHVxSwqg-1; Tue, 23 Apr 2024 18:38:25 -0400
X-MC-Unique: XOw_T4KnN_yHp9kHVxSwqg-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6eba7dc8f1dso1414133a34.2
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713911905; x=1714516705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d8tdYWqm0jGED0Z2NZXkzbiQXY2iDqRN/UMYVn/huvg=;
 b=PjuPrMCsmVO+T0aA01EY7PdhK1vnV9BJoaCW5EudylltFQ2i4yHRSq2P+UhqMpx5aI
 WYsMjFhgaADWiXcOd3znE71+Z1PNxlMDivFUqeAq/4Xt3QrFbcKmiTt08wgX5zWudh3M
 N76BLzK5uprXtn586uSmPCJ7XLnTt0N4UzLKx0yZnmMihv4/bfgXulZi+l1hM9gdnpg7
 WQ5GWaIL8T04RLHTSkfM/QD+dX9lhAoB1/AOQHedANVN7jgb30qYxXz9GMPy4ax6oQ11
 D6XoSpFCtslMVrSoszjY7CBsir/8oMuZSAcRsj4TyMvce+DLnyOPpQJUG/R4yxJlHkQP
 F7tA==
X-Gm-Message-State: AOJu0YzGGRzgKQ55AeVKEyZcw3YLC4OeB2XnfIlK1MvINsNT6kBA5hoU
 FtDIqHi9BoedwswlgRRIhm7QhSNN36/y+O7ThLeEEtkUHJK6MJumuGlALbFZrbGlBLTMRqtWvHD
 yrK39EoHCGowSp15v2OJmkxrmjwtu6JDSOKJLXbHrps7qCdmFPjjpDv89BtDJq3S3B9DhgvCv/g
 ZdTKZZS4iF/LDVyqt5YTG7QsU8FnBr6x7xig==
X-Received: by 2002:a05:6830:16c3:b0:6eb:7caf:6d7 with SMTP id
 l3-20020a05683016c300b006eb7caf06d7mr1063843otr.3.1713911904491; 
 Tue, 23 Apr 2024 15:38:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwXyVpCeJe+DWVmMPs+XNWK05GObaz/oteDLoR+HNFEov31XgENwUk3ew42Sd9kT9QyKNUEg==
X-Received: by 2002:a05:6830:16c3:b0:6eb:7caf:6d7 with SMTP id
 l3-20020a05683016c300b006eb7caf06d7mr1063816otr.3.1713911903904; 
 Tue, 23 Apr 2024 15:38:23 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c21-20020a05620a11b500b0078d67886632sm5647726qkk.37.2024.04.23.15.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 15:38:23 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Het Gala <het.gala@nutanix.com>
Subject: [PULL 04/26] tests/qtest/migration: Add channels parameter in
 migrate_qmp_fail
Date: Tue, 23 Apr 2024 18:37:51 -0400
Message-ID: <20240423223813.3237060-5-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423223813.3237060-1-peterx@redhat.com>
References: <20240423223813.3237060-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Het Gala <het.gala@nutanix.com>

Alter migrate_qmp_fail() to allow both uri and channels
independently. For channels, convert string to a Dict.
No dealing with migrate_get_socket_address() here because
we will fail before starting the migration anyway.

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240312202634.63349-5-het.gala@nutanix.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-helpers.h |  5 +++--
 tests/qtest/migration-helpers.c | 13 +++++++++++--
 tests/qtest/migration-test.c    |  4 ++--
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index e16a34c796..4e664148a5 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -33,8 +33,9 @@ G_GNUC_PRINTF(3, 4)
 void migrate_incoming_qmp(QTestState *who, const char *uri,
                           const char *fmt, ...);
 
-G_GNUC_PRINTF(3, 4)
-void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...);
+G_GNUC_PRINTF(4, 5)
+void migrate_qmp_fail(QTestState *who, const char *uri,
+                      const char *channels, const char *fmt, ...);
 
 void migrate_set_capability(QTestState *who, const char *capability,
                             bool value);
diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 8806dc841e..f215f44467 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -100,7 +100,8 @@ bool migrate_watch_for_events(QTestState *who, const char *name,
     return false;
 }
 
-void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
+void migrate_qmp_fail(QTestState *who, const char *uri,
+                      const char *channels, const char *fmt, ...)
 {
     va_list ap;
     QDict *args, *err;
@@ -110,7 +111,15 @@ void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
     va_end(ap);
 
     g_assert(!qdict_haskey(args, "uri"));
-    qdict_put_str(args, "uri", uri);
+    if (uri) {
+        qdict_put_str(args, "uri", uri);
+    }
+
+    g_assert(!qdict_haskey(args, "channels"));
+    if (channels) {
+        QObject *channels_obj = qobject_from_json(channels, &error_abort);
+        qdict_put_obj(args, "channels", channels_obj);
+    }
 
     err = qtest_qmp_assert_failure_ref(
         who, "{ 'execute': 'migrate', 'arguments': %p}", args);
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 0c76fe2615..763ff27f33 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1717,7 +1717,7 @@ static void test_precopy_common(MigrateCommon *args)
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, args->connect_uri, "{}");
+        migrate_qmp_fail(from, args->connect_uri, NULL, "{}");
         goto finish;
     }
 
@@ -1812,7 +1812,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, args->connect_uri, "{}");
+        migrate_qmp_fail(from, args->connect_uri, NULL, "{}");
         goto finish;
     }
 
-- 
2.44.0


