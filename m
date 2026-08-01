Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C095CC55171
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 02:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpzc3-0002Ps-09; Fri, 31 Jul 2026 22:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wpzbv-0002GP-JN
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 22:38:04 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wpzbt-0002Yq-Jr
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 22:38:03 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2cc891373e0so17094425ad.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 19:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785551880; x=1786156680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XRnm5RmBx7iEg/dNO7tKTfWv8DxHd4baJ5mHfXaMt9I=;
 b=E4F7uzko+XAMFS8YaGudJx6FcpkJCDOtHKPXxmqZnkTDUJAgOgHajIm3yr2sLj8oG9
 4JbPGOpFYphcVRphkdJ3ebC4ggTOEhNb0yibDS0rFKrtkui0l5/gTK8zrTDryyqC4RWZ
 WJ3KnU6brzJHLQFmyEC55kU7024pH843ft4iFHrtSBhJPGFY2WDAhVXzwwE7ezYSLEPx
 pnuk5cmUAJEExHBtfpVtEwUyee5bd+wMQVS2veV16ljwm/5EnEy/uMxEJhyEZHMcRRuF
 XERQ4WwVOsFgF+KijZikEle9AHN2QEuu8E1/Kiw7MeMedZnE14O76/LsHDVIEAiSgIqt
 bzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785551880; x=1786156680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XRnm5RmBx7iEg/dNO7tKTfWv8DxHd4baJ5mHfXaMt9I=;
 b=Q5+dkVzAbvxxDAXWqHnOK2uSisv8SyVZRXJB7sW/k5doe1WftAt2db6R+63BBhlh7z
 cAk8Ot1bMBaNKAmS3HRGf8F4EUUEKmRj/uA/b/Tctv+VabmYX1QLWpnqCm6dQeYRTHHJ
 ebpZhETxywBkd9Ob3ghpKsVKkNJ/TB+lmWAk4o4TrrmRcPApGNH+OhHhma8a2xkkXRLJ
 Dg6vWzqx3KhIQ0LGKurB8u9wuFenquzuREJeG2t039DptCKD8q02O/9UKcQRvqJN8SNs
 1sz3sywHs0dNtbiyRgOqKx8syfawMQHY09HR8hxgtEyaVyOeZqSh8vHmSxXm9PPxvumx
 kAfg==
X-Gm-Message-State: AOJu0YzKwd1ungPe6gR2u6XiadxHcoCqz9LpuQZ9JLI1AFRyjPr9o6uE
 Z1ZXJU/sS1U3F6tbWGa8yQ/lR6Ccpwt0z0U12tomWccNPJMW727qDkHuk0wsUUxj
X-Gm-Gg: AR+sD10oF/R2gqpPU6UZuxaZ6G83l5buHS9mtqNyFp+49NegeuE2L4FzW1snL0ElhXf
 cOKbdUx9wjGRrz/Gjn1N+xPUm2veaJS2qbFWg8Imtpk0xQ8fZZBs6x0W5F4gHiC8Lu92SUzGpjD
 9Wp5QxxGW0mumVw8ajB9aVGtnWIH21gcjHdLIALisrTak2QzHsOlmHqXQhnHQDBC7Ak5PWPY+iN
 jPsZv8r5+eYe02WCEK98p6jwDDmhZOHO736nOmT1Hge7C8lp5pMunx6W6VMmmyuRHvlePXerZJa
 /PBH+J/odWm6OdLj7wSgOwzOM9hCQuW7cDdO7L40ngwoZLqZchVuTNXm7ORFmwkxm2k4/axFTLC
 gDUcxDxx1DzH+Qn2BJfo5XFUuXWG/kHTx+OjORsNoREIhlL7d2FdRgv29b79vRGjNjlZoqOgarD
 mt4Ir4WkqLADCuo3rEfx4YFrImH3ve48rA8pmwk6FTdfm0hbiB/P4XyyDY5zXMnY6ktmFXKN4Ty
 VbpMwjAarAPgAR/6Q==
X-Received: by 2002:a05:6a21:1bc2:b0:3c3:abd4:ac74 with SMTP id
 adf61e73a8af0-3c92a8400eamr1916424637.39.1785551880301; 
 Fri, 31 Jul 2026 19:38:00 -0700 (PDT)
Received: from setun ([223.228.61.127]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e47dsm15678889eec.3.2026.07.31.19.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 19:37:59 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PATCH v4 09/11] migration: update capability conflict test for
 postcopy-ram+mapped-ram
Date: Sat,  1 Aug 2026 08:06:26 +0530
Message-ID: <20260801023628.22665-10-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260801023628.22665-1-aadeshveer07@gmail.com>
References: <20260801023628.22665-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pl1-x635.google.com
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

A smoke test exercising this feature has been added further in this
series.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
---
 include/qemu/notify.h              |  2 ++
 migration/options.c                | 20 ++++++++++--
 migration/postcopy-ram.c           |  5 +++
 migration/postcopy-ram.h           |  1 +
 tests/qtest/migration/misc-tests.c | 52 ------------------------------
 util/notify.c                      |  5 +++
 6 files changed, 31 insertions(+), 54 deletions(-)

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
index 8bfe04523a..e01ac628f5 100644
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


