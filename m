Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F1ECD98F3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 03:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa3Jq-0008BZ-RC; Wed, 17 Jun 2026 23:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wa3Jo-0008BR-CH
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 23:21:28 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wa3Jm-0002Ji-QS
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 23:21:28 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c8897045525so281699a12.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 20:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781752885; x=1782357685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=goi3dasaBf+1cFBZYCdvkL7YmSmIDj5gtvrwJACDgTs=;
 b=Fpa9EmktUCZe7x2pDysjXixklxaN+Qzm/Dp3Wmr2eCT61rlqCaL0NwD8VwlJ4LMScg
 DjiT2mQhCr1G1BRjzYzNhlm8cDUm0X73uUX5wDK1o54+6PpM7g2m+UdFIUzZ/OvgXqJm
 6lP4s+s3a5YiDZgz0S7KxBZd1b1nloU5EUeiFhKosU6LelpOUtrFfDBmf2/X716ygD8f
 888tQ9cWpcn0l678pfX9ZbKbjYErnO4qdLw6neQGAdilSC0gwuf0wSTjVT+KO/qSw3qW
 zeIx0pzChG984LEr5evJJRmxu7s8lIu9jhSlBrH80LwG3g3srfE77uNPPmeSHQd7gtGZ
 7Vnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781752885; x=1782357685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=goi3dasaBf+1cFBZYCdvkL7YmSmIDj5gtvrwJACDgTs=;
 b=dbAlAFsT8imPr08UHZdPX9oPKZmteyNHgIrsYCEm41IudmRSq71CpaUlgnykHoHTg7
 PLIXhSyPCW0N1r06EDMHKcedenH3zJ3QIgKi78TCjTMd+ieUZxm8YGXgKJbEt0XjYQHz
 j/Ho7K9mrn86idkeLOqH1ZiSRjPguD32EPnVKrCSl1Nn4A64yBre+IKc/vMVPyJJoRXE
 H2ucY/H8MFjYQfK1Wygh6/inKqhtKCcadmCPjLRJGje8+m/ofsabgZBZafVLGqiNjNAX
 OWknt4RSCrhv8/lPaFsttbFkLdrRCxY0LRhCqyRLit72Nas3HqcOqQ0KsTKMexI/JC9I
 RhhA==
X-Gm-Message-State: AOJu0YxWh3yQrZu8wg19tXBnNoXnrdKX54zGL507ZXo/oGcAhIWX4ouJ
 9vEGMbVi1CLAqgPJawb36l/nn4LpDaP0uUNWXUEqF2S5BqUg928dR0LN8ogJqFze
X-Gm-Gg: Acq92OF+ixEgj34wItevva1YSJ3hf3mhtyjsWgdu9Cx4IjLWFI2AinoD1UoT4ElB+Zm
 PifkM+Dz5dZBN5JWBmLna0EfodysPGKrBR6Ru56Neak4gL8nKE+Om4mVmi6QbqZL3hgFIdjXycD
 o46LAMkQAVjwdc5VXagNITPVEe34NQDsZZOsXtXbpQOikRXslZz7ekv8BHmfXwELYWLO1zoMNss
 V4SrdiXyDQn9VJ9PmhBW2ThPeJKKs5i/HgtjKOVw+ROApzz2IqsbOfsGBTYLZV1vVo9YLRzkImW
 jAAHf+Xl9kXJ1uzpPTuNw8MeDWWg04EZg/YP24OlyRW/OxbzAVkjInfFhwfHqw5BMawy7OYNVQy
 VbImXMGhGa/oajcWsc5lcgMWSyxmMfJPNO03tJl5HFL3I9DfdxkJeimVaHzKbeIPtUWqOOwgWYf
 4S5UdOe8M1UnGEj6wEkEfJF8bfzvF41nAp/E4GlKNqWQ==
X-Received: by 2002:a05:6a21:1645:b0:398:90e5:a9b9 with SMTP id
 adf61e73a8af0-3b8be9aead5mr7505071637.27.1781752885499; 
 Wed, 17 Jun 2026 20:21:25 -0700 (PDT)
Received: from setun ([2405:201:502b:3014:cc0c:536:1b1e:6def])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c88c6c2b2easm1534623a12.27.2026.06.17.20.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 20:21:25 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [RFC PATCH 5/5] migration/tests: remove capability conflict test
 postcopy-ram+mapped-ram
Date: Thu, 18 Jun 2026 08:50:10 +0530
Message-ID: <20260618032010.88755-6-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618032010.88755-1-aadeshveer07@gmail.com>
References: <20260618032010.88755-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pg1-x536.google.com
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
together, with the previous patches in this series, this combination
is now supported and functional.

No replacement test for fast snapshot load is included in this RFC. A
test exercising the full save/load flow will be added in a follow-up.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
---
 tests/qtest/migration/misc-tests.c | 52 ------------------------------
 1 file changed, 52 deletions(-)

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


