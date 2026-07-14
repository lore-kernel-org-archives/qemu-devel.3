Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1480FC44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 14:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjdwq-0006OK-Ue; Tue, 14 Jul 2026 10:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wjdwp-0006KU-DY
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:17:23 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wjdwn-0002e2-7M
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:17:23 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2ccf2360620so8196605ad.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784038640; x=1784643440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HGHpwp6tqTCl74NPIsgt9M/weDmjWAglJt/Lx4OhHJk=;
 b=AnG9IFywakp7d2PVKePaaZnpS/BoBUt44nzUlPxzXnOg3QRYFxQtalaFqk88yjmGxI
 pPS0EyqrxLsqj1lOCZOYoODFSnFW0U9HGmf1Imi4ZWM6LdHOKSh7dBFPNq0s/+fA4gRM
 UJiAaBdBVM6aRbp9RZZF4cptmHpTFE9UP0NJHXDtn/M8BdLK63PA7rBXeAr/vp0gZFJ9
 /7C+GTpS1KVD4M4hYfMm31mG5KYlrOyxTU6IaofI4HkY/YDh+8gLfHPg3j9XBMEeqTCS
 Rqc1hi78u6c4Z6//Jgqdc1arVCG/gSBkWxeC4bKAukxMnzSNO59+r7R0gJUBfUpdSvS5
 Qo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784038640; x=1784643440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HGHpwp6tqTCl74NPIsgt9M/weDmjWAglJt/Lx4OhHJk=;
 b=OiIWWhbd+sh5PBy7xopWjbwxvFNpI+CFViSYIV/NkJAgqspDTZu5F4WK9r1v086hmk
 VJ8umvF9dDDIVKRx7NY2X1MMRfFoIOtMKNwUb404gh6jAymJq6nzJPEA2uVjEw15JOSa
 1TmlnSZC1eMPgWqNzol4m9hB2dCANOoiOk3LH8fFSiFmaOuI3O3KvLEAcFy5vQxvCRGP
 CE1ecgjE6s/vT6orPquReL2EZpIES4zF+UTl6oyikXfXBwk1GCSBUH718RCwhGnvakC1
 +sL4fvK0tLUWgcq47z/HG/Oh4hZ2k0w9VhLffVlZ29RrlTIExdvzrQmyamwXhebOtbgV
 n9yQ==
X-Gm-Message-State: AOJu0Yx9Tyd9qID3jpVDZokiKA7aQ8I84SuIPzd2TXZK9A5CiB/jvavJ
 meRGDkRjFOSftia+uyhLGfGhtiEE9KBdYUO1xlP2lRq9ffUzJvBq2/pF1bAaG39M
X-Gm-Gg: AfdE7cnfDm9LUQHmOkrRx6PVdVwox951WGgi2FOwbk6dFJgnZjhH1ojmXiEsm/rdjF/
 taFs4Y1527L++6AOYFv02sq+7JFDAyvrsCpzoU6blmZ/wz1mGRwAZ5kUbTojpweILhvRViXicdT
 D/xjJO4IVr9w8A73ubIuzCpGYrXuE26d7KF6prjeXF6BmnqPlRWT+afZ4BTLYVwb851W+LC85tM
 jBjetSbEZL6Jib4XLiG0etTnv3mEtRpsNFzOL01KN3UxPMCyTVZYpE8IEOED12IVk4g3CtrdI6W
 +If9XchU5wHBna0shiZ8gEs+AIPvbG37jDV8eDBVq760k9MOB2EuXyxL8KDBT3dAGj4C3KWtMQH
 NIAQv7Djfdtv6RJTtxkJHf9qugLp8nRI0iBKUoVu22T7IJKpnYeNKep/7ccMHul2z1IIC6jKO1R
 DoGnVxGteYrsPzd3oqQUVZJqUjGsag9Ex35jH8x24BJw==
X-Received: by 2002:a17:90b:58f0:b0:387:e0db:bc23 with SMTP id
 98e67ed59e1d1-38dc77b82bemr13324655a91.35.1784038639701; 
 Tue, 14 Jul 2026 07:17:19 -0700 (PDT)
Received: from setun ([2405:201:502b:3014:cc0c:536:1b1e:6def])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118ee6091dsm97329733eec.14.2026.07.14.07.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 07:17:19 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PATCH v3 09/11] migration/tests: remove capability conflict test
 postcopy-ram+mapped-ram
Date: Tue, 14 Jul 2026 19:45:45 +0530
Message-ID: <20260714141547.1268000-10-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714141547.1268000-1-aadeshveer07@gmail.com>
References: <20260714141547.1268000-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pl1-x629.google.com
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

A smoke test exercising this feature has been added further in this
series.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
---
 migration/options.c                | 14 ++++++--
 tests/qtest/migration/misc-tests.c | 52 ------------------------------
 2 files changed, 12 insertions(+), 54 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 5cbfd29099..d61a10f1c4 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -727,10 +727,20 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
                        "Mapped-ram migration is incompatible with xbzrle");
             return false;
         }
+    }
 
-        if (new_caps[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
+    if (new_caps[MIGRATION_CAPABILITY_MAPPED_RAM] &&
+        new_caps[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
+        if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
             error_setg(errp,
-                       "Mapped-ram migration is incompatible with postcopy");
+                       "Multifd is not supported with fast snapshot load");
+            return false;
+        }
+
+        if (new_caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT]) {
+            error_setg(
+                errp,
+                "Postcopy Preempt is incompatible with fast snapshot load");
             return false;
         }
     }
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
-- 
2.55.0


