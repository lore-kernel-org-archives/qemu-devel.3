Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B21E10BA421
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 03:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5xe3-0003wR-Ih; Thu, 26 Mar 2026 23:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hayatake396@gmail.com>)
 id 1w5xe2-0003wD-0w
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 23:13:58 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hayatake396@gmail.com>)
 id 1w5xe0-0003ld-9d
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 23:13:57 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-82a62714fe6so681886b3a.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 20:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774581234; x=1775186034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z7ruBpxFpRt6qQVDLU2/yZBKXb7019PTRSUhHNGf8yc=;
 b=DGWZrgznn31wTJLUM4Rq9L4rsnM3TPwRwLkb7XSwa6KVXekvnlrjAftt5CI6PNWEOK
 4G/PiPFKdQVoWQ7OZUmCiGYu7q6sdY2GmazTxHaFQSwOU5IivJ7OZLGvrwLlYlBNr8zx
 AYnZp7omY20Tqf04ChlVYVFkbmsLuQhuUw2qhzsURpcrhczwQIzZY3PEhLuOfP7HZ4/i
 tatr3D0Dt0+fhNc0unpTldbb1UjuvY7ebcO8QQSbZf8UcVmkR9qbiVQWdowK5uNU4+2B
 sdQHNyQQ7h4cCBV/o+fIGxs/oqeHyT5+l/sw+FmE58JFeZxRF+3q52L5MRc0W2bnCkjN
 UySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774581234; x=1775186034;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z7ruBpxFpRt6qQVDLU2/yZBKXb7019PTRSUhHNGf8yc=;
 b=SdASdqB7/szYG/ONRB4ptpRlRUGZ5u2JaXK0n84mWPcFoLfKlVzwLv9h8d2aqfIxMo
 iBdr2sDgHdn9G+ptQ6tSQ/Mp7xDnG73j5yf4VZBbCDKANrEcVBaL9ZX5pfpiG4ErEyyn
 ywHQrP3853r8g9lLsj+6t/v32YhOZW5RSYUOrD2EhKmEd07mrxJyNvbup9Kt1YZgjHEz
 DtUaLlqgskoe2Cezl0Q6/P70qGPn6kmJZViuD795sZs9vVFTvpEDlLJyi6WGBFI5/Uph
 T8pbqdI6jqqiKJCs9Ta8Cd82ME3cZA307hnWcmTaSyetJP9YKmjXCM6/+R2tFbZAnqz0
 PL7A==
X-Gm-Message-State: AOJu0YwIAE2YswAlsNAF2pvX4xazircLg2uVeq8x49DwD2n557wHVZy2
 p3nI8ihDDkPfNnG8h3WMNeu1fUOH0cFeONSIRWXA2nslueKv4y0WZNFlN0R2+pG5
X-Gm-Gg: ATEYQzygd9+g5Ha4oLg0tosAO+3kDNtcEd9Mvpu0+ljkPHE710TxRmo1tfgrCSwhVu4
 zY6NqVi6JNOth/Y0IcilFgwkjT0YvlyDXG/9baZOElMo5mc3uSxtDUSC4w77Ty+8pqLKz0ATUzX
 glQ6/dlRd28iwucM2oh/YiI9hUxoTKmuJwU8lRCde13B6DcSGcdy8MWQ0PywEXIBc+EgXhrBUZq
 q2RNoUIMEK5WCkRUuL0rfWgSQXSeZyt7BrgurSS3VWyTgfAITkE7N/lNIhiJvo9MNpvGGpnQkwf
 VymyshQzONEkOrNR2bBN+vOJqq+Eqy2sUeOVe5LG8v1+WEDl8/jOwxUX9pYfA/Kqbd1dYx0eULF
 1vUPZ3Ill09XgVKx5dhfCAbBMRM5ba7+HkWm3U8psfHYJLIH14PtEmC4hQrVTfOceAAXw+YS2Yo
 Bk2qq3tktk/OFrIBjnc2r7bEnURBv1vvoSnFj1Uanb366XGPAhAwkACZnUWeWlB18CN2D1Bu3Yx
 rPQmZoc/YjeAtvopnuY4sAtAY6k0Hdiai2WxTR1BCCg
X-Received: by 2002:a05:6a00:1acf:b0:827:2dff:7116 with SMTP id
 d2e1a72fcca58-82c968c06b9mr675538b3a.13.1774581233505; 
 Thu, 26 Mar 2026 20:13:53 -0700 (PDT)
Received: from lab-kiba-ocxma-dut-01.. (191.68.231.218.rev.ocx2915.net.
 [218.231.68.191]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c7d20ebe5sm3976455b3a.13.2026.03.26.20.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 20:13:53 -0700 (PDT)
From: Takeru Hayasaka <hayatake396@gmail.com>
To: qemu-devel@nongnu.org
Cc: Takeru Hayasaka <hayatake396@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] tests/qtest/migration: Add mapped-ram/postcopy validation test
Date: Fri, 27 Mar 2026 03:04:01 +0000
Message-ID: <20260327030404.1840571-1-hayatake396@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=hayatake396@gmail.com; helo=mail-pf1-x434.google.com
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
---
 tests/qtest/migration/misc-tests.c | 45 ++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 196f1ca84287..ae247250713b 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -215,6 +215,49 @@ static void do_test_validate_uri_channel(MigrateCommon *args)
     migrate_end(from, to, false);
 }
 
+static void do_test_validate_capability_pair(MigrateCommon *args,
+                                             const char *first_capability,
+                                             const char *second_capability,
+                                             const char *expected_error)
+{
+    QTestState *from, *to;
+    QDict *rsp;
+    const char *error_desc;
+
+    args->start.hide_stderr = true;
+
+    if (migrate_start(&from, &to, "defer", &args->start)) {
+        return;
+    }
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
+    migrate_end(from, to, false);
+}
+
+static void test_validate_caps_mapped_ram_postcopy(char *name,
+                                                   MigrateCommon *args)
+{
+    const char *error =
+        "Mapped-ram migration is incompatible with postcopy";
+
+    do_test_validate_capability_pair(args, "mapped-ram", "postcopy-ram",
+                                     error);
+    do_test_validate_capability_pair(args, "postcopy-ram", "mapped-ram",
+                                     error);
+}
+
 static void test_validate_uri_channels_both_set(char *name, MigrateCommon *args)
 {
     args->listen_uri = "defer",
@@ -276,4 +319,6 @@ void migration_test_add_misc(MigrationTestEnv *env)
                        test_validate_uri_channels_both_set);
     migration_test_add("/migration/validate_uri/channels/none_set",
                        test_validate_uri_channels_none_set);
+    migration_test_add("/migration/validate_caps/mapped_ram_postcopy",
+                       test_validate_caps_mapped_ram_postcopy);
 }
-- 
2.43.0


