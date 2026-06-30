Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44836C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weThe-0004vz-HK; Tue, 30 Jun 2026 04:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1weThc-0004vl-IF
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 04:20:20 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1weThZ-0003Kd-BA
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 04:20:18 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2c8c30492a0so35672345ad.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 01:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782807616; x=1783412416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h246oOnwhMfIwpoInL9ueM4/KFf2GZfScnXDka7dbNo=;
 b=KlWWpkdTAU85+6Z8i2o6Psq3AJSwwQIfyyb7Fo4uXrx+V1zM3+GCrPVeobW43gdUc8
 CE/S25bMKIsUxMuKb2XOMM0v8v47vkX6acqJHKVJltf1nQSliTNWPDhGe2kxQrGike29
 5jaXH05YkVBuKnBLGYFDGLFCE/sDlVMA1DbyZ0S8hRNDWyc7KcTKCShtqwUjJ9YalCdc
 qxWOjEWmRZ0LWB8cxWnSnUgXo2ZCV8f7/WLLGWxh0C+RLA77jV8IyO/d74Ol1xezigIk
 Cd9GOswwjIn18ebNq7mSWIW3zOW8wp+ZSPf6AATNNxXSaGaQDFGpY6t27mykdfMSG0Ho
 OSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782807616; x=1783412416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h246oOnwhMfIwpoInL9ueM4/KFf2GZfScnXDka7dbNo=;
 b=NwO3X3ZAuRKJTPwRQbA2tOOZJZgdTPb1Q9VYr/eqtjQ9xz6YuT+F+f30dQQeG2wcNr
 Wgjp5M32AqWeFP5H4+FhX55WOp2yEKn/mzQS3PZ3RupTqDN+RQTur7EoGOT2nA6G0pjg
 JP06huawCitfDvly8foUxl+zPcLti3r4hfs/nQvmq29cvbdx0LEFcyiRDTLNRkgfh/pO
 o5UlCT+bX0swAnIm6p+eY/5t1vuHtu7MptqEcdibpTqgh2Hc2LhALYc6kDuN0x2yMGIw
 qOya+dAqFgdgCXaA70pUWsXS5IM2ysnzW8SwKrYIjAknwklGotXdVowd6MZ06hnLZtLI
 LNvA==
X-Gm-Message-State: AOJu0YwczuvEZrYlUC2Htkk0t9AoPYPUO9gI9aGd9umiYbV0dUKX4VZK
 BaWd7yJ4FApXIP/frpz/6r4qKhTo1EaVFU748On/vQeYqiYNZAyEaMU3mc5i8I4w
X-Gm-Gg: AfdE7ckm1GKC+6s/BYpu9Pq20kuD3vbFR3voTU4XntGp1pJJmzMdpiNHqbIEAgIpv/e
 KToBm+ZxfSNFfepsNnNCNNOAHrAKPOpHQrMGeXlbq+uQrcunKXQzWZoYEP92/occ+OMklbFkJ0a
 jdcndFF6Y59Q22ims2K/jTbewC22WpVZBgEPlf7WeuyVQ1F0bN4Mpd4kYyqJ69ddYos2OCaXV43
 q4RMmbagrdzm3+jVgnWZ181oww4yNnOYL+l/BiGxwbdsfcZXDDrl/iRAoDBKykQiSN8BarAEx6D
 72YLb4ZQvkkmb9IUOfHNsC37NJwUlAAUBuWch8syANR/JnKLPVcH6xqcSyVVdNbgDv8gTRg6p+f
 tq6r9eP/d/lFwVPjg9W3tkBnfK1OnRQXPsOkccJv2ToL+BPQJMj+m6qaTzQsVbO2E+A/94xrSM0
 t/m6vS+OAqpdUQ+j6ADwG3f2xyjHHF43WeUgr9ubbDIPY=
X-Received: by 2002:a17:902:e550:b0:2c9:b1ed:eb5d with SMTP id
 d9443c01a7336-2ca2ed46d69mr20322655ad.47.1782807615882; 
 Tue, 30 Jun 2026 01:20:15 -0700 (PDT)
Received: from setun ([2401:4900:a344:dc6e:573c:3e9:c03e:731a])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca4f2a71dbsm1284615ad.50.2026.06.30.01.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 01:20:15 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [RFC PATCH v2 1/7] migration/tests: remove capability conflict test
 postcopy-ram+mapped-ram
Date: Tue, 30 Jun 2026 13:49:34 +0530
Message-ID: <20260630081940.611092-2-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630081940.611092-1-aadeshveer07@gmail.com>
References: <20260630081940.611092-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pl1-x62e.google.com
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

No replacement test for fast snapshot load is included in this RFC. A
test exercising the full save/load flow will be added in a follow-up.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
---
 migration/options.c                |  6 ----
 tests/qtest/migration/misc-tests.c | 52 ------------------------------
 2 files changed, 58 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 5cbfd29099..16583651ac 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -727,12 +727,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
                        "Mapped-ram migration is incompatible with xbzrle");
             return false;
         }
-
-        if (new_caps[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
-            error_setg(errp,
-                       "Mapped-ram migration is incompatible with postcopy");
-            return false;
-        }
     }
 
     /*
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
2.54.0


