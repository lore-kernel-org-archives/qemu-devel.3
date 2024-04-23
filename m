Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40B4C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOna-000376-CK; Tue, 23 Apr 2024 18:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmc-0001Tj-Ga
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmV-000669-Dp
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713911908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7YBtqmlY+NFnoq1aZZtk8n211ngcrE4I+4c0f4YUndA=;
 b=Zw443XKl+xsod8SsBYyhV9Mt5ig905GnmDnTRfTC+2DM7QNJtjK0Y3Qu79eMcyxorwPorv
 BisK8JfB6d5pOFoFM5e59aEmyi0TN9gc4waLP1OucYEUXmku0J3qwlZ9QssBnyWyP/zlic
 xxYVsgVuyx1B3Jy5qCEASV8ySRMCtfY=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-2Yqw60elPe6Oo8yegC2ZTw-1; Tue, 23 Apr 2024 18:38:27 -0400
X-MC-Unique: 2Yqw60elPe6Oo8yegC2ZTw-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3c73b31c4e4so1330812b6e.3
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713911906; x=1714516706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7YBtqmlY+NFnoq1aZZtk8n211ngcrE4I+4c0f4YUndA=;
 b=Ky7fd/4mvXgZqmi4eqNcqnXA4HjblQsbBfGZGErlrFaI6+BsL7/34A29uU/ua9cxDU
 SxC3gXa4Dxqj99q9qanbl0bkMIdxS1foW/nmDCaOkR1wbFeJs5sBHdoK4kSOJQNZO7gY
 eGji52h9Us66AkcFDu7FoIRe1XNBfEbmMNZx5hvUPUWACfWp+XIx7gdaQSCEo/HrtT5l
 MRTC4eEqhh0KbJ2sMGqF5qX/9uhp3+ZdwT1nmBFK00LMrkhIE+kUOtmDVSrc5gO4OJjQ
 tVBsq5OEJ2ax8O1w8DFVRYug7DWHAoQBJ4gK7Mqj6OA/q/x8s+gLEPBj1ZO+C6YpkUkF
 J9Vw==
X-Gm-Message-State: AOJu0YyYTzoG1nN/z/sX7Uo2H+fG8SiPrVKhgzIsJF8qFVrmW7Q7i8Gu
 QJs0Or326I//Owd4Qlc6+0vfmfAERJUpshty7tW6LbPb684u5WhonTZuJvd5NPby4Y77wvyg03O
 8aKl5O5k13DIFLmw1GW5Ha5fnNxuJesMG4EgqN+J1uq7f0QQ9GT66GIBhlM3NZ98tLp2VHQ+RHO
 r3Axudez94+6IzdVnvJ1uNuziF5s4423Q+Uw==
X-Received: by 2002:a05:6808:201e:b0:3c5:f29a:5fda with SMTP id
 q30-20020a056808201e00b003c5f29a5fdamr851808oiw.3.1713911906327; 
 Tue, 23 Apr 2024 15:38:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvQW0QIYEIj8dI3RVrReAv2lJhR1VntR+Vi58JbKU1rhtP9kUEMMR9ZwyIMSZEG9m4wu+0sg==
X-Received: by 2002:a05:6808:201e:b0:3c5:f29a:5fda with SMTP id
 q30-20020a056808201e00b003c5f29a5fdamr851769oiw.3.1713911905666; 
 Tue, 23 Apr 2024 15:38:25 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c21-20020a05620a11b500b0078d67886632sm5647726qkk.37.2024.04.23.15.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 15:38:25 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Het Gala <het.gala@nutanix.com>
Subject: [PULL 06/26] tests/qtest/migration: Add channels parameter in
 migrate_qmp
Date: Tue, 23 Apr 2024 18:37:53 -0400
Message-ID: <20240423223813.3237060-7-peterx@redhat.com>
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

Alter migrate_qmp() to allow use of channels parameter, but only
fill the uri with correct port number if there are no channels.
Here we don't want to allow the wrong cases of having both or
none (ex: migrate_qmp_fail).

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240312202634.63349-7-het.gala@nutanix.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-helpers.h |  4 ++--
 tests/qtest/migration-helpers.c | 22 +++++++++++++---------
 tests/qtest/migration-test.c    | 28 ++++++++++++++--------------
 3 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 4e664148a5..1339835698 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -25,9 +25,9 @@ typedef struct QTestMigrationState {
 bool migrate_watch_for_events(QTestState *who, const char *name,
                               QDict *event, void *opaque);
 
-G_GNUC_PRINTF(4, 5)
+G_GNUC_PRINTF(5, 6)
 void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
-                 const char *fmt, ...);
+                 const char *channels, const char *fmt, ...);
 
 G_GNUC_PRINTF(3, 4)
 void migrate_incoming_qmp(QTestState *who, const char *uri,
diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index a330ef9c7f..3b72cad6c1 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -133,10 +133,6 @@ static void migrate_set_ports(QTestState *to, QList *channel_list)
     QListEntry *entry;
     const char *addr_port = NULL;
 
-    if (channel_list == NULL) {
-        return;
-    }
-
     addr = migrate_get_connect_qdict(to);
 
     QLIST_FOREACH_ENTRY(channel_list, entry) {
@@ -208,11 +204,10 @@ void migrate_qmp_fail(QTestState *who, const char *uri,
  * qobject_from_jsonf_nofail()) with "uri": @uri spliced in.
  */
 void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
-                 const char *fmt, ...)
+                 const char *channels, const char *fmt, ...)
 {
     va_list ap;
     QDict *args;
-    QList *channel_list = NULL;
     g_autofree char *connect_uri = NULL;
 
     va_start(ap, fmt);
@@ -220,11 +215,20 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
     va_end(ap);
 
     g_assert(!qdict_haskey(args, "uri"));
-    if (!uri) {
+    if (uri) {
+        qdict_put_str(args, "uri", uri);
+    } else if (!channels) {
         connect_uri = migrate_get_connect_uri(to);
+        qdict_put_str(args, "uri", connect_uri);
+    }
+
+    g_assert(!qdict_haskey(args, "channels"));
+    if (channels) {
+        QObject *channels_obj = qobject_from_json(channels, &error_abort);
+        QList *channel_list = qobject_to(QList, channels_obj);
+        migrate_set_ports(to, channel_list);
+        qdict_put_obj(args, "channels", channels_obj);
     }
-    migrate_set_ports(to, channel_list);
-    qdict_put_str(args, "uri", uri ? uri : connect_uri);
 
     qtest_qmp_assert_success(who,
                              "{ 'execute': 'migrate', 'arguments': %p}", args);
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 763ff27f33..af5e7dc6d6 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1301,7 +1301,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     wait_for_serial("src_serial");
     wait_for_suspend(from, &src_state);
 
-    migrate_qmp(from, to, NULL, "{}");
+    migrate_qmp(from, to, NULL, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -1451,7 +1451,7 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to)
     g_assert_cmpint(ret, ==, 1);
 
     migrate_recover(to, "fd:fd-mig");
-    migrate_qmp(from, to, "fd:fd-mig", "{'resume': true}");
+    migrate_qmp(from, to, "fd:fd-mig", NULL, "{'resume': true}");
 
     /*
      * Make sure both QEMU instances will go into RECOVER stage, then test
@@ -1539,7 +1539,7 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
      * Try to rebuild the migration channel using the resume flag and
      * the newly created channel
      */
-    migrate_qmp(from, to, uri, "{'resume': true}");
+    migrate_qmp(from, to, uri, NULL, "{'resume': true}");
 
     /* Restore the postcopy bandwidth to unlimited */
     migrate_set_parameter_int(from, "max-postcopy-bandwidth", 0);
@@ -1620,7 +1620,7 @@ static void test_baddest(void)
     if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
         return;
     }
-    migrate_qmp(from, to, "tcp:127.0.0.1:0", "{}");
+    migrate_qmp(from, to, "tcp:127.0.0.1:0", NULL, "{}");
     wait_for_migration_fail(from, false);
     test_migrate_end(from, to, false);
 }
@@ -1659,7 +1659,7 @@ static void test_analyze_script(void)
     uri = g_strdup_printf("exec:cat > %s", file);
 
     migrate_ensure_converge(from);
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, uri, NULL, "{}");
     wait_for_migration_complete(from);
 
     pid = fork();
@@ -1721,7 +1721,7 @@ static void test_precopy_common(MigrateCommon *args)
         goto finish;
     }
 
-    migrate_qmp(from, to, args->connect_uri, "{}");
+    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
 
     if (args->result != MIG_TEST_SUCCEED) {
         bool allow_active = args->result == MIG_TEST_FAIL;
@@ -1816,7 +1816,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
         goto finish;
     }
 
-    migrate_qmp(from, to, args->connect_uri, "{}");
+    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
     wait_for_migration_complete(from);
 
     /*
@@ -1972,7 +1972,7 @@ static void test_ignore_shared(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, uri, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -2511,7 +2511,7 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, uri, NULL, "{}");
 
     if (should_fail) {
         qtest_set_expected_status(to, EXIT_FAILURE);
@@ -2614,7 +2614,7 @@ static void test_migrate_auto_converge(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, uri, NULL, "{}");
 
     /* Wait for throttling begins */
     percentage = 0;
@@ -2980,7 +2980,7 @@ static void test_multifd_tcp_cancel(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, to, NULL, "{}");
+    migrate_qmp(from, to, NULL, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -3009,7 +3009,7 @@ static void test_multifd_tcp_cancel(void)
 
     migrate_ensure_non_converge(from);
 
-    migrate_qmp(from, to2, NULL, "{}");
+    migrate_qmp(from, to2, NULL, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to2);
 
@@ -3342,7 +3342,7 @@ static void test_migrate_dirty_limit(void)
     migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
 
     /* Start migrate */
-    migrate_qmp(from, to, args.connect_uri, "{}");
+    migrate_qmp(from, to, args.connect_uri, NULL, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
@@ -3383,7 +3383,7 @@ static void test_migrate_dirty_limit(void)
     }
 
     /* Start migrate */
-    migrate_qmp(from, to, args.connect_uri, "{}");
+    migrate_qmp(from, to, args.connect_uri, NULL, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
-- 
2.44.0


