Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B787010F2853
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6AMK-0001et-VR; Fri, 27 Mar 2026 12:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hayatake396@gmail.com>)
 id 1w6ALB-0008PY-QU
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:47:26 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hayatake396@gmail.com>)
 id 1w6ALA-0003ud-76
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:47:21 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2b23f90f53aso2008005ad.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 09:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774630037; x=1775234837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TRfByYCpn86twtxLhTV/UoyYvSEX6nSqqLo6mXvw1ao=;
 b=M9Lo5rlN8ACyLGVixcSAPv+uvB71urKlNEbuDOyEgJmL+yZZceCzLpM7bYRS8hJEaC
 KKT7VeMrrdL4MufQFhOxt/vO176rLy8o7MgfPYvLKYBxvIwOtkK+g7vAZercM/AUwTfU
 7/RkF8iYuO+luG6yiLve7VG6XLyQWV2uPpX3Uod/CmqiUMDsX4JM4YAIB3QQv5tmIWpi
 8VQcPyDUkq2aWnm8Nu9Zu15oqzSSVdEHxpCAA8AAmkbzwyDF6Y9Hzk/5ylhOObi7qOur
 PMo/ZNUFzS3AR0jhiGfDIcB74yNHFT52vsfNkej0HqkMH+WtHR0FA2RD7lbbHoa3sE7N
 04Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774630037; x=1775234837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TRfByYCpn86twtxLhTV/UoyYvSEX6nSqqLo6mXvw1ao=;
 b=AC7fLR+bZEKfF7TNUuZacf0CYxv3TAEaqm/iU0GKC+V85xRwNTn4aIRshPQco9Wi6J
 6GS0avnMH7x3r76MrIAkR6zHKvPF+OWAbbSRRA+si8Pr1k12tuq6eWh4/yAadrWda0qV
 /aBpfCjmMHoTE6KM/zn467avFAU1GasIj1cN/dF6RizG3H9MlyooytVTi9tMFvsy9gEb
 dS22gCKeKQpPonG4sUbIFAYAlC66MuAgVODrlbwRJJWh/U7izWIp/p/nzw8FOGTPkCmd
 NRAiKxEipHvyUewHvTnTBi4CY64v4Be1IsXE0iDvQrgTxaHljtLVRUnZukLQfl/hjX1X
 Kf1A==
X-Gm-Message-State: AOJu0Yz9R0JbgJsiVo1PiRfYqMzzIZVLF2Ro7Yc+f53lutBse463Rrx4
 cPcsZLwHQqV05MdvZS17KZ7i/TmaC2d5oUewsJ7HJdu5qwUQkwQ6lb2Mbjbgdg==
X-Gm-Gg: ATEYQzyA0C27ZdnloSBypqYwBzeF7qFfwkFn1OlSd5cpaE2yebl/zRntX0w9hQzd3Pa
 nMQm3K7m+cJDCtQt0qkWd1jNqPULsut0wIcyfN/cbtgC3rpqH+BZiSDh338wldKQZ2DjnUT0DHR
 TMDV77KkMRPQ1uZo0FMCqTQJ4mn3vNZ4eTxj/7jLANXrlW8t/diZRd38W/avaep0r3gXnwv3+Ob
 aopNQA2Ve1N/MXBY8ncgOH005pSc8H0r1+qIY0YOTvkpjEx+rtX/vi6DUIQHhXvG48t2398puUd
 h4cf1qW6nxt6nbaJpf7ooAaMRleJhUO/0zT/Ox0rjOKN5mEishxAURGi5Psc+Z4/KSP4bJ1SIva
 RoLis/mc+FoBVQrtMSgNGrE3UNeAR1dqi/j+y9YoaN/P7Pp3CQ68FFLAI7qx+d3L2s8caWFzm8j
 t8lhz+HgahDi8/XBi9SqPsSaPb3o5UjB5o96VaptnEMwkKKWij0uUqtvRLaUB/T/6TKnsWiWUje
 5Cn1HztzDBLDQ1jSfZCJZ8kTHnKaoM98J1RjBPQf5QC
X-Received: by 2002:a17:902:db01:b0:2ae:c795:6b4a with SMTP id
 d9443c01a7336-2b0cdc203c5mr38543705ad.11.1774630037141; 
 Fri, 27 Mar 2026 09:47:17 -0700 (PDT)
Received: from lab-kiba-ocxma-dut-01.. (191.68.231.218.rev.ocx2915.net.
 [218.231.68.191]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc87e6cfsm65143225ad.39.2026.03.27.09.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:47:16 -0700 (PDT)
From: Takeru Hayasaka <hayatake396@gmail.com>
To: qemu-devel@nongnu.org
Cc: hayatake396@gmail.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com
Subject: [PATCH v2] tests/qtest/migration: Add mapped-ram/postcopy validation
 test
Date: Fri, 27 Mar 2026 16:46:58 +0000
Message-ID: <20260327164705.1990226-1-hayatake396@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CADFiAc+uCn1diKbpHGJ9yBUJbzaCEwSdmd3mF-42_SeZngqRVQ@mail.gmail.com>
References: <CADFiAc+uCn1diKbpHGJ9yBUJbzaCEwSdmd3mF-42_SeZngqRVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=hayatake396@gmail.com; helo=mail-pl1-x62f.google.com
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

The migration capability checks reject enabling postcopy-ram together
with mapped-ram, but there is no qtest covering this incompatibility.

Add a validation test that verifies QMP rejects the combination in
both capability ordering cases and returns the expected error.

This keeps the existing capability boundary covered without changing
migration behavior.

Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
---
Built with:
  ./configure --target-list=x86_64-softmmu --disable-werror
  ninja -C build tests/qtest/migration-test qemu-system-x86_64

Tested with:
  QTEST_QEMU_BINARY=./build/qemu-system-x86_64 \
  ./build/tests/qtest/migration-test --full \
  -p /x86_64/migration/validate_caps/mapped_ram_postcopy

 v2:
   - Rename do_test_validate_capability_pair to validate_caps_pair
   - Move migrate_start/migrate_end to caller for VM reuse
   - Set only_source to skip target VM
   - Generalize test using migration_test_add_suffix pattern
---
 tests/qtest/migration/misc-tests.c | 50 ++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 196f1ca84287..4131e7b0614d 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -215,6 +215,53 @@ static void do_test_validate_uri_channel(MigrateCommon *args)
     migrate_end(from, to, false);
 }
 
+static void validate_caps_pair(QTestState *from,
+                               const char *first_capability,
+                               const char *second_capability,
+                               const char *expected_error)
+{
+    QDict *rsp;
+    const char *error_desc;
+
+    migrate_set_capability(from, first_capability, true);
+
+    rsp = qtest_qmp_assert_failure_ref(
+        from,
+        "{ 'execute': 'migrate-set-capabilities',"
+        "  'arguments': { 'capabilities': [ { "
+        "      'capability': %s, 'state': true } ] } }",
+        second_capability);
+
+    error_desc = qdict_get_str(rsp, "desc");
+    g_assert_cmpstr(error_desc, ==, expected_error);
+    qobject_unref(rsp);
+
+    migrate_set_capability(from, first_capability, false);
+}
+
+static void test_validate_caps_pair(char *test_path, MigrateCommon *args)
+{
+    g_autofree char *cap_pair = g_path_get_basename(test_path);
+    QTestState *from, *to;
+
+    args->start.hide_stderr = true;
+    args->start.only_source = true;
+
+    if (migrate_start(&from, &to, "defer", &args->start)) {
+        return;
+    }
+
+    if (g_str_equal(cap_pair, "mapped_ram_postcopy")) {
+        const char *error =
+            "Mapped-ram migration is incompatible with postcopy";
+
+        validate_caps_pair(from, "mapped-ram", "postcopy-ram", error);
+        validate_caps_pair(from, "postcopy-ram", "mapped-ram", error);
+    }
+
+    qtest_quit(from);
+}
+
 static void test_validate_uri_channels_both_set(char *name, MigrateCommon *args)
 {
     args->listen_uri = "defer",
@@ -276,4 +323,7 @@ void migration_test_add_misc(MigrationTestEnv *env)
                        test_validate_uri_channels_both_set);
     migration_test_add("/migration/validate_uri/channels/none_set",
                        test_validate_uri_channels_none_set);
+    migration_test_add_suffix("/migration/validate_caps/",
+                              "mapped_ram_postcopy",
+                              test_validate_caps_pair);
 }
-- 
2.43.0


