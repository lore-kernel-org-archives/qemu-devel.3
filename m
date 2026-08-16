Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1401CC5DF79
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 17:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvexX-0008KO-2P; Sun, 16 Aug 2026 13:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wvexW-0008Jn-5s
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 13:47:46 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wvexT-0003Bp-TU
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 13:47:45 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c966b9ee9cbso1612455a12.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 10:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786902462; x=1787507262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1+Vxxqg8bJXz5F4kdjoTIRovNakDkVXZUTh8g/hecLM=;
 b=h5hhbDpsrM/QHyGRxfh2jCyAV/o3jPidl7K6W+QtXmMKHL/rT3wT6gqNGL/U3pNNSG
 yUvTY6St47iUy2GggOjCuOyQsRl3NlsnS7U+Tsj0uZvMiJEs0JiE6BlkvkvkYVkltiim
 9QTxT4JHjn8PqMsNZCcKLLHal71S2vcNyJGMQHK3EzBx61tJRz2sRI0U0bzNbfm5QXD4
 cW9ySKDaqC9/U0DJpBdQuT+yhfKJdXYyRvqNuwEayJ6kOhrgis8Tm9qFZspFa8TnkHJU
 PHOxytKzagBk0MEzFbAhrFYPQy7RwC2qcqQ2N6AowR20a8YiXmNBzb+yNEh1EjOG61wX
 DKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786902462; x=1787507262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1+Vxxqg8bJXz5F4kdjoTIRovNakDkVXZUTh8g/hecLM=;
 b=LTmyA7jg5t/FXOBjUDejsPYWvBrGbiPYH7Ei2EKGFBFGPzvUsPEypJ/xU3WIJ8HnQh
 ztgasWW1THIusNHGfd+bKIuw3cRHut8kq52ipf+yfTX8EPVHzTrZ4c1qAAUOSnaLt7PR
 ZlsU8yPuzIp36ezIR6EdjMrJn+Qr4lmId8q3H/A8n9N5crdEjUVcz7cGmYUBUyE6MRq3
 asirP7So98l2YHdfFgt1CGuZaCfcVDs5SL+K5OIGUN5D8lf0fKoOxGmuriYrEwWef5of
 ok+pvLD0gAnKJlwE7qas17g8FfEqfyk1EZuLYdjs3r4CDigM1IS/DOcRpcPcTgpu5SPu
 lkQA==
X-Gm-Message-State: AOJu0YxR8FhtxhZkUAV17I1UA13ZCaLK1Mxfox0fknkARDMZftPgFwN0
 5k6UJmCnsjUfu3M3/O+Kz4DkeRRxhcax1eeCMemNOkKVIwGArqUJxJxs9Ebbaw==
X-Gm-Gg: AR+sD128+7OT4nUCzugBe9eFdvDOGnEAsZ94KBHoPZ9p9G+8ReBOzj+FyhsinJjFCUY
 ww38c+MIe9NGzNigCRvPVoLvWJIDhWBcOpV9xAfegvJEf4MPD6gyzaup4e9h4R7Ya0Rm3I3LsLC
 RnYxzK+kR9FW3oRhXWnRnl6w6iQfS/7ZIYsvZ3cb/z2WCOy3WtIbUgekpV4KWn034XQb3dB2UbT
 ZB90P5EZSW2ftZldJthMt8s9GnIzSuOoRQF/4Xq9/HaVTLlL3bsEs1SXlLoKZhC0BJWKbLPfAHF
 Em9HVqBdEzq/lYcadsUAdq5InWI32ihMhF2QkFV30wzPk2kRBWPLLyhmXnDZ907JfmyI5SxuELW
 rH4Gaca8B6qZy2/RyK9Ma5n2iH5I6fGnD8Sm/SucJt4KvP3+m22yqiEQJCMsn17vteSuze6iNWf
 GYrjY5AEpxadROIUPIlsgByVaccdqkFzP2LaIajCF54fEOzdLJS7VyFIGf3Fpjy9CeRLsDHSjaW
 A5MTO4oPwW5vl0=
X-Received: by 2002:a05:6a21:3281:b0:3cc:56be:a559 with SMTP id
 adf61e73a8af0-3cc71fa8c5dmr18377457637.23.1786902462022; 
 Sun, 16 Aug 2026 10:47:42 -0700 (PDT)
Received: from setun ([223.228.54.80]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320ead105a9sm28343674eec.31.2026.08.16.10.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 10:47:41 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PATCH v5 09/11] migration: update capability conflict test for
 postcopy-ram+mapped-ram
Date: Sun, 16 Aug 2026 23:16:29 +0530
Message-ID: <20260816174631.1547811-10-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816174631.1547811-1-aadeshveer07@gmail.com>
References: <20260816174631.1547811-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Remove the test test_validate_caps_pair, which asserted postcopy-ram
and mapped-ram capabilities cannot be active together. The new fast
snapshot load feature is exactly this pair of capabilities active
together, with the following patches in this series, this combination
will now supported and be functional.

Remove the capability check that rejected mapped-ram and postcopy-ram
being set simultaneously, as this combination now corresponds to fast
snapshot load.

Add a capability check against setting multifd when configured for fast
snapshot load as it is not supported yet. Also add capability check
against setting postcopy-preempt as it is incompatible.

Add infrastructure to check postcopy_notifier_list being empty in
capaility checking to block vhost-user with fast snapshot load as it is
not supported.

Add a check to bail in migrate_prepare to prevent unexpected usage when
fast snapshot load is enabled.

A smoke test exercising this feature has been added further in this
series.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
---
 include/qemu/notify.h              |  2 ++
 migration/migration.c              |  6 ++++
 migration/options.c                | 20 ++++++++++--
 migration/postcopy-ram.c           |  5 +++
 migration/postcopy-ram.h           |  1 +
 tests/qtest/migration/misc-tests.c | 52 ------------------------------
 util/notify.c                      |  5 +++
 7 files changed, 37 insertions(+), 54 deletions(-)

diff --git a/include/qemu/notify.h b/include/qemu/notify.h
index abf18dbf59..666d13f727 100644
--- a/include/qemu/notify.h
+++ b/include/qemu/notify.h
@@ -75,4 +75,6 @@ void notifier_with_return_remove(NotifierWithReturn *notifier);
 int notifier_with_return_list_notify(NotifierWithReturnList *list,
                                      void *data, Error **errp);
 
+bool notifier_with_return_list_empty(NotifierWithReturnList *list);
+
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index e9c4eee6b9..8f50dd1c53 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2040,6 +2040,12 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
             error_setg(errp, "Cannot use compression with mapped-ram");
             return false;
         }
+
+        if (migrate_postcopy_ram()) {
+            error_setg(errp, "Cannot migrate with fast snapshot load "
+                             "enabled(mapped-ram + postcopy-ram)");
+            return false;
+        }
     }
 
     if (migrate_mode_is_cpr()) {
diff --git a/migration/options.c b/migration/options.c
index 5cbfd29099..4f8cc5fd6e 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -727,10 +727,26 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
                        "Mapped-ram migration is incompatible with xbzrle");
             return false;
         }
+    }
+
+    if (new_caps[MIGRATION_CAPABILITY_MAPPED_RAM] &&
+        new_caps[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
+        if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
+            error_setg(errp,
+                       "Multifd is not supported with fast snapshot load");
+            return false;
+        }
+
+        if (new_caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT]) {
+            error_setg(
+                errp,
+                "Postcopy Preempt is incompatible with fast snapshot load");
+            return false;
+        }
 
-        if (new_caps[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
+        if (!postcopy_notifier_list_empty()) {
             error_setg(errp,
-                       "Mapped-ram migration is incompatible with postcopy");
+                       "vhost-user is not supported with fast snapshot load");
             return false;
         }
     }
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 1f37dc1399..11500152c7 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -82,6 +82,11 @@ int postcopy_notify(enum PostcopyNotifyReason reason, Error **errp)
                                             &pnd, errp);
 }
 
+bool postcopy_notifier_list_empty(void)
+{
+    return notifier_with_return_list_empty(&postcopy_notifier_list);
+}
+
 /*
  * NOTE: this routine is not thread safe, we can't call it concurrently. But it
  * should be good enough for migration's purposes.
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index c58a60bc8a..edba7b0240 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -136,6 +136,7 @@ void postcopy_add_notifier(NotifierWithReturn *nn);
 void postcopy_remove_notifier(NotifierWithReturn *n);
 /* Call the notifier list set by postcopy_add_start_notifier */
 int postcopy_notify(enum PostcopyNotifyReason reason, Error **errp);
+bool postcopy_notifier_list_empty(void);
 
 void postcopy_thread_create(MigrationIncomingState *mis,
                             QemuThread *thread, const char *name,
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index ec6d438cdc..4e0deb7f18 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -201,55 +201,6 @@ static void do_test_validate_uri_channel(MigrateCommon *args)
     migrate_end(from, to, false);
 }
 
-static void validate_caps_pair(QTestState *from,
-                               const char *first_capability,
-                               const char *second_capability,
-                               const char *expected_error)
-{
-    QDict *rsp;
-    const char *error_desc;
-
-    migrate_set_capability(from, first_capability, true);
-
-    rsp = qtest_qmp_assert_failure_ref(
-        from,
-        "{ 'execute': 'migrate-set-capabilities',"
-        "  'arguments': { 'capabilities': [ { "
-        "      'capability': %s, 'state': true } ] } }",
-        second_capability);
-
-    error_desc = qdict_get_str(rsp, "desc");
-    g_assert_cmpstr(error_desc, ==, expected_error);
-    qobject_unref(rsp);
-
-    migrate_set_capability(from, first_capability, false);
-}
-
-static void test_validate_caps_pair(char *test_path, MigrateCommon *args)
-{
-    g_autofree char *serial_path = g_strconcat(tmpfs, "/src_serial", NULL);
-    g_autofree char *cap_pair = g_path_get_basename(test_path);
-    QTestState *from, *to;
-
-    args->start.hide_stderr = true;
-    args->start.only_source = true;
-
-    if (migrate_start(&from, &to, &args->start)) {
-        return;
-    }
-
-    if (g_str_equal(cap_pair, "mapped_ram_postcopy")) {
-        const char *error =
-            "Mapped-ram migration is incompatible with postcopy";
-
-        validate_caps_pair(from, "mapped-ram", "postcopy-ram", error);
-        validate_caps_pair(from, "postcopy-ram", "mapped-ram", error);
-    }
-
-    qtest_quit(from);
-    unlink(serial_path);
-}
-
 static void test_validate_uri_channels_both_set(char *name, MigrateCommon *args)
 {
     args->uri = "tcp:127.0.0.1:0",
@@ -309,7 +260,4 @@ void migration_test_add_misc(MigrationTestEnv *env)
                        test_validate_uri_channels_both_set);
     migration_test_add("/migration/validate_uri/channels/none_set",
                        test_validate_uri_channels_none_set);
-    migration_test_add_suffix("/migration/validate_caps/",
-                              "mapped_ram_postcopy",
-                              test_validate_caps_pair);
 }
diff --git a/util/notify.c b/util/notify.c
index c6e158ffb3..8d2657e411 100644
--- a/util/notify.c
+++ b/util/notify.c
@@ -75,3 +75,8 @@ int notifier_with_return_list_notify(NotifierWithReturnList *list, void *data,
     }
     return ret;
 }
+
+bool notifier_with_return_list_empty(NotifierWithReturnList *list)
+{
+    return QLIST_EMPTY(&list->notifiers);
+}
-- 
2.55.0


