Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E54D49219
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 12:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD1AG-0003UJ-Ib; Mon, 18 Nov 2024 07:47:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD1AE-0003Si-Sj
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:47:34 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD1AC-0005Pw-VF
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:47:34 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4315baa51d8so27000355e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 04:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731934051; x=1732538851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2gvzG87mZ1DQ2Kjs6nzKGtjxs99fZsVPRk+MyRMt3sI=;
 b=uYEBMIHEMQEEIdZ5D3rDFeJWfwsbprukgS6QlltSEYXJgdBIpESIQ4a8PD7HiTNJHE
 CDlBLEboT2jrbBrPHz0kiJK5UdKIbZXKqAaln35j7jbEuEcpAEP0ofgpWcUAa47pNrpU
 d0ZYP0ZUQNxhWw8OvlT3iEIpGpvwjL2eN7QX/oU8JzdiG+mIqnvGxTVBpEPyA57d6TkE
 8NZmJWpylfUIRcyYeBzNe93eUmPuYs++uIylCMHykMYBaAqhfPpSYgrfVguwRUzIRcnH
 8QC+ZyhAT31WO1cIrQNAsODEMjDDLtP2HhHsj1fsbsQs0caJSyY9HzMoJ8u4Ifua+Af7
 rODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731934051; x=1732538851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2gvzG87mZ1DQ2Kjs6nzKGtjxs99fZsVPRk+MyRMt3sI=;
 b=wdLJT4PKevbFq2fRniej1YjTSiNP07WghEOXyySF+Es35aQft6iUToH9xTvYivJTf1
 uRjGo2kNOgGwGK6+guTs374y6gbVOtvHrzsJP10Bf7Xl/4YTu4Uo+aeSTS1sAWV540pU
 YsVFvmY7ArNrhxlSR8tD4AX+4DrS7JAQNXabeLTutz7C0Jsyvhir++8GsMcAYuxX01T/
 WrjIiUpcgBy6oV7HSswaHojcIuF1XfkLGxFkW/njv/TNF8p5s61+6g7F7xv33IFDe8eG
 WDRT++OuoDzcxFkbQzccpv3SqqgIzulhE3VlVS57PxxQSdpwTQKvlMRzFMkjhumJKsj7
 Dnzg==
X-Gm-Message-State: AOJu0Yx7a5YsaJEhtEmalwzbRYeGaKUX3wQSiDqWUmXXDVce0vFopoIL
 khJBJZyQd2kKxIMkDry/AvXvZ+FVBV/ognvXTl0yHcpuWd6Hqn3lqtQeqBm9WpP0Sy85ehxNyQ0
 0
X-Google-Smtp-Source: AGHT+IHnBk5jlKkZZA6gUPUoeIe8kEIw1QAz4R0/iOc0cus7Roe+z/LDvWCVBdqEqtZa7LzESyrZCg==
X-Received: by 2002:a05:600c:3ba7:b0:42c:b52b:4335 with SMTP id
 5b1f17b1804b1-432df725265mr118347755e9.10.1731934051088; 
 Mon, 18 Nov 2024 04:47:31 -0800 (PST)
Received: from localhost.localdomain ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da244cb6sm161586485e9.0.2024.11.18.04.47.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Nov 2024 04:47:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/15] tests/qtest/migration: Fix indentations
Date: Mon, 18 Nov 2024 13:46:35 +0100
Message-ID: <20241118124643.6958-9-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241118124643.6958-1-philmd@linaro.org>
References: <20241118124643.6958-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

Select all the code and hit tab. I'll be moving functions around quite
a lot in the next patches, so make sure all indentation is correct
now.

Add parentheses around some expressions to preserve readability.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <20241113194630.3385-2-farosas@suse.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/migration-helpers.c |  4 +--
 tests/qtest/migration-test.c    | 59 ++++++++++++++++++---------------
 2 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 0025933883..3f8ba7fa8e 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -140,8 +140,8 @@ static void migrate_set_ports(QTestState *to, QList *channel_list)
         if (qdict_haskey(addrdict, "port") &&
             qdict_haskey(addr, "port") &&
             (strcmp(qdict_get_str(addrdict, "port"), "0") == 0)) {
-                addr_port = qdict_get_str(addr, "port");
-                qdict_put_str(addrdict, "port", addr_port);
+            addr_port = qdict_get_str(addr, "port");
+            qdict_put_str(addrdict, "port", addr_port);
         }
     }
 
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index e6a2803e71..74d3000198 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -113,8 +113,8 @@ static bool ufd_version_check(void)
     }
     uffd_feature_thread_id = api_struct.features & UFFD_FEATURE_THREAD_ID;
 
-    ioctl_mask = 1ULL << _UFFDIO_REGISTER |
-                 1ULL << _UFFDIO_UNREGISTER;
+    ioctl_mask = (1ULL << _UFFDIO_REGISTER |
+                  1ULL << _UFFDIO_UNREGISTER);
     if ((api_struct.ioctls & ioctl_mask) != ioctl_mask) {
         g_test_message("Skipping test: Missing userfault feature");
         return false;
@@ -423,7 +423,7 @@ static void migrate_set_parameter_str(QTestState *who, const char *parameter,
 }
 
 static long long migrate_get_parameter_bool(QTestState *who,
-                                           const char *parameter)
+                                            const char *parameter)
 {
     QDict *rsp;
     int result;
@@ -436,7 +436,7 @@ static long long migrate_get_parameter_bool(QTestState *who,
 }
 
 static void migrate_check_parameter_bool(QTestState *who, const char *parameter,
-                                        int value)
+                                         int value)
 {
     int result;
 
@@ -445,7 +445,7 @@ static void migrate_check_parameter_bool(QTestState *who, const char *parameter,
 }
 
 static void migrate_set_parameter_bool(QTestState *who, const char *parameter,
-                                      int value)
+                                       int value)
 {
     qtest_qmp_assert_success(who,
                              "{ 'execute': 'migrate-set-parameters',"
@@ -1384,8 +1384,10 @@ static void test_postcopy_preempt_tls_psk(void)
 static void wait_for_postcopy_status(QTestState *one, const char *status)
 {
     wait_for_migration_status(one, status,
-                              (const char * []) { "failed", "active",
-                                                  "completed", NULL });
+                              (const char * []) {
+                                  "failed", "active",
+                                  "completed", NULL
+                              });
 }
 
 static void postcopy_recover_fail(QTestState *from, QTestState *to,
@@ -2575,15 +2577,17 @@ static void test_migrate_fd_finish_hook(QTestState *from,
     /* Test closing fds */
     /* We assume, that QEMU removes named fd from its list,
      * so this should fail */
-    rsp = qtest_qmp(from, "{ 'execute': 'closefd',"
-                          "  'arguments': { 'fdname': 'fd-mig' }}");
+    rsp = qtest_qmp(from,
+                    "{ 'execute': 'closefd',"
+                    "  'arguments': { 'fdname': 'fd-mig' }}");
     g_assert_true(qdict_haskey(rsp, "error"));
     error_desc = qdict_get_str(qdict_get_qdict(rsp, "error"), "desc");
     g_assert_cmpstr(error_desc, ==, "File descriptor named 'fd-mig' not found");
     qobject_unref(rsp);
 
-    rsp = qtest_qmp(to, "{ 'execute': 'closefd',"
-                        "  'arguments': { 'fdname': 'fd-mig' }}");
+    rsp = qtest_qmp(to,
+                    "{ 'execute': 'closefd',"
+                    "  'arguments': { 'fdname': 'fd-mig' }}");
     g_assert_true(qdict_haskey(rsp, "error"));
     error_desc = qdict_get_str(qdict_get_qdict(rsp, "error"), "desc");
     g_assert_cmpstr(error_desc, ==, "File descriptor named 'fd-mig' not found");
@@ -2741,11 +2745,11 @@ static void test_validate_uri_channels_both_set(void)
         },
         .listen_uri = "defer",
         .connect_uri = "tcp:127.0.0.1:0",
-        .connect_channels = "[ { 'channel-type': 'main',"
-                            "    'addr': { 'transport': 'socket',"
-                            "              'type': 'inet',"
-                            "              'host': '127.0.0.1',"
-                            "              'port': '0' } } ]",
+        .connect_channels = ("[ { ""'channel-type': 'main',"
+                             "    'addr': { 'transport': 'socket',"
+                             "              'type': 'inet',"
+                             "              'host': '127.0.0.1',"
+                             "              'port': '0' } } ]"),
     };
 
     do_test_validate_uri_channel(&args);
@@ -2967,7 +2971,7 @@ test_migrate_precopy_tcp_multifd_qatzip_start(QTestState *from,
 #ifdef CONFIG_QPL
 static void *
 test_migrate_precopy_tcp_multifd_qpl_start(QTestState *from,
-                                            QTestState *to)
+                                           QTestState *to)
 {
     return test_migrate_precopy_tcp_multifd_start_common(from, to, "qpl");
 }
@@ -3032,11 +3036,11 @@ static void test_multifd_tcp_channels_none(void)
         .listen_uri = "defer",
         .start_hook = test_migrate_precopy_tcp_multifd_start,
         .live = true,
-        .connect_channels = "[ { 'channel-type': 'main',"
-                            "    'addr': { 'transport': 'socket',"
-                            "              'type': 'inet',"
-                            "              'host': '127.0.0.1',"
-                            "              'port': '0' } } ]",
+        .connect_channels = ("[ { 'channel-type': 'main',"
+                             "    'addr': { 'transport': 'socket',"
+                             "              'type': 'inet',"
+                             "              'host': '127.0.0.1',"
+                             "              'port': '0' } } ]"),
     };
     test_precopy_common(&args);
 }
@@ -3668,7 +3672,8 @@ static void test_migrate_dirty_limit(void)
     throttle_us_per_full = 0;
     while (throttle_us_per_full == 0) {
         throttle_us_per_full =
-        read_migrate_property_int(from, "dirty-limit-throttle-time-per-round");
+            read_migrate_property_int(from,
+                                      "dirty-limit-throttle-time-per-round");
         usleep(100);
         g_assert_false(src_state.stop_seen);
     }
@@ -3680,7 +3685,8 @@ static void test_migrate_dirty_limit(void)
     /* Check if dirty limit throttle switched off, set timeout 1ms */
     do {
         throttle_us_per_full =
-        read_migrate_property_int(from, "dirty-limit-throttle-time-per-round");
+            read_migrate_property_int(from,
+                                      "dirty-limit-throttle-time-per-round");
         usleep(100);
         g_assert_false(src_state.stop_seen);
     } while (throttle_us_per_full != 0 && --max_try_count);
@@ -3709,7 +3715,8 @@ static void test_migrate_dirty_limit(void)
     throttle_us_per_full = 0;
     while (throttle_us_per_full == 0) {
         throttle_us_per_full =
-        read_migrate_property_int(from, "dirty-limit-throttle-time-per-round");
+            read_migrate_property_int(from,
+                                      "dirty-limit-throttle-time-per-round");
         usleep(100);
         g_assert_false(src_state.stop_seen);
     }
@@ -3989,7 +3996,7 @@ int main(int argc, char **argv)
 #endif
 #ifdef CONFIG_QATZIP
     migration_test_add("/migration/multifd/tcp/plain/qatzip",
-                test_multifd_tcp_qatzip);
+                       test_multifd_tcp_qatzip);
 #endif
 #ifdef CONFIG_QPL
     migration_test_add("/migration/multifd/tcp/plain/qpl",
-- 
2.45.2


