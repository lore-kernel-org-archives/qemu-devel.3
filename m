Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D7BD637B0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 19:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBJKr-0006sh-Km; Wed, 13 Nov 2024 14:47:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tBJKi-0006c4-9b
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 14:47:23 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tBJKd-0003Bm-Sg
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 14:47:20 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A994521109;
 Wed, 13 Nov 2024 19:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731527234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JEgi4d5DbgKRrZ7itCDu0CGCLckhFYPLpH1rwzXSaXc=;
 b=E0ZrqpaKN+9qC8ADrJJusT4i7GaWLX4sjYXjnUWAMapHYNPMhgGsMjDbOS717evxBTZFjM
 pC5zYpsjHZavaB9942CuqAZkSOfy8TUBLIZY0EmJBUw100CqD8Tj4YXg5BOJ7xe+ZOudpr
 EQ6s4EqsQBtgVmdM1tkUh7dCmo5rZT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731527234;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JEgi4d5DbgKRrZ7itCDu0CGCLckhFYPLpH1rwzXSaXc=;
 b=74GghHxXKmy5Kzo9EcJIHrxJ1+mp9xw5zMy5sW7siCnMFEv+e9GJStn5Ni2rY8NamI8fAP
 YNfQPZjakYBbbBDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=E0ZrqpaK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=74GghHxX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731527234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JEgi4d5DbgKRrZ7itCDu0CGCLckhFYPLpH1rwzXSaXc=;
 b=E0ZrqpaKN+9qC8ADrJJusT4i7GaWLX4sjYXjnUWAMapHYNPMhgGsMjDbOS717evxBTZFjM
 pC5zYpsjHZavaB9942CuqAZkSOfy8TUBLIZY0EmJBUw100CqD8Tj4YXg5BOJ7xe+ZOudpr
 EQ6s4EqsQBtgVmdM1tkUh7dCmo5rZT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731527234;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JEgi4d5DbgKRrZ7itCDu0CGCLckhFYPLpH1rwzXSaXc=;
 b=74GghHxXKmy5Kzo9EcJIHrxJ1+mp9xw5zMy5sW7siCnMFEv+e9GJStn5Ni2rY8NamI8fAP
 YNfQPZjakYBbbBDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89EC913301;
 Wed, 13 Nov 2024 19:47:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MBqsE0ACNWfLcQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 13 Nov 2024 19:47:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 16/22] tests/qtest/migration: Split precopy tests
Date: Wed, 13 Nov 2024 16:46:24 -0300
Message-Id: <20241113194630.3385-17-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241113194630.3385-1-farosas@suse.de>
References: <20241113194630.3385-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A994521109
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 R_RATELIMIT(0.00)[to_ip_from(RL6tyf6sue6knz55rs3us8rsc3)];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:email, suse.de:dkim, suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Split the precopy tests from migration-test.c. This is the largest
group of tests and the more difficult one to break into smaller
groups, so move all of it.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/meson.build                |    1 +
 tests/qtest/migration-test.c           |  970 +----------------------
 tests/qtest/migration/precopy-tests.c  | 1007 ++++++++++++++++++++++++
 tests/qtest/migration/test-framework.h |    1 +
 4 files changed, 1011 insertions(+), 968 deletions(-)
 create mode 100644 tests/qtest/migration/precopy-tests.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index ba07ca89bb..c1dcc67363 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -337,6 +337,7 @@ migration_files = [files(
   'migration/migration-util.c',
   'migration/compression-tests.c',
   'migration/file-tests.c',
+  'migration/precopy-tests.c',
   'migration/postcopy-tests.c',
 )]
 
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 4138a2ebd8..fa2fd0c672 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -27,12 +27,6 @@
 #include "migration/migration-qmp.h"
 #include "migration/migration-util.h"
 
-/*
- * Dirtylimit stop working if dirty page rate error
- * value less than DIRTYLIMIT_TOLERANCE_RANGE
- */
-#define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
-
 #define ANALYZE_SCRIPT "scripts/analyze-migration.py"
 
 #if defined(__linux__)
@@ -113,70 +107,6 @@ static void test_analyze_script(void)
 }
 #endif
 
-static void test_precopy_unix_plain(void)
-{
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    MigrateCommon args = {
-        .listen_uri = uri,
-        .connect_uri = uri,
-        /*
-         * The simplest use case of precopy, covering smoke tests of
-         * get-dirty-log dirty tracking.
-         */
-        .live = true,
-    };
-
-    test_precopy_common(&args);
-}
-
-static void test_precopy_unix_suspend_live(void)
-{
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    MigrateCommon args = {
-        .listen_uri = uri,
-        .connect_uri = uri,
-        /*
-         * despite being live, the test is fast because the src
-         * suspends immediately.
-         */
-        .live = true,
-        .start.suspend_me = true,
-    };
-
-    test_precopy_common(&args);
-}
-
-static void test_precopy_unix_suspend_notlive(void)
-{
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    MigrateCommon args = {
-        .listen_uri = uri,
-        .connect_uri = uri,
-        .start.suspend_me = true,
-    };
-
-    test_precopy_common(&args);
-}
-
-static void test_precopy_unix_dirty_ring(void)
-{
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    MigrateCommon args = {
-        .start = {
-            .use_dirty_ring = true,
-        },
-        .listen_uri = uri,
-        .connect_uri = uri,
-        /*
-         * Besides the precopy/unix basic test, cover dirty ring interface
-         * rather than get-dirty-log.
-         */
-        .live = true,
-    };
-
-    test_precopy_common(&args);
-}
-
 #if 0
 /* Currently upset on aarch64 TCG */
 static void test_ignore_shared(void)
@@ -240,149 +170,6 @@ static void test_mode_reboot(void)
     test_file_common(&args, true);
 }
 
-static void test_precopy_tcp_plain(void)
-{
-    MigrateCommon args = {
-        .listen_uri = "tcp:127.0.0.1:0",
-    };
-
-    test_precopy_common(&args);
-}
-
-static void *migrate_hook_start_switchover_ack(QTestState *from, QTestState *to)
-{
-
-    migrate_set_capability(from, "return-path", true);
-    migrate_set_capability(to, "return-path", true);
-
-    migrate_set_capability(from, "switchover-ack", true);
-    migrate_set_capability(to, "switchover-ack", true);
-
-    return NULL;
-}
-
-static void test_precopy_tcp_switchover_ack(void)
-{
-    MigrateCommon args = {
-        .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = migrate_hook_start_switchover_ack,
-        /*
-         * Source VM must be running in order to consider the switchover ACK
-         * when deciding to do switchover or not.
-         */
-        .live = true,
-    };
-
-    test_precopy_common(&args);
-}
-
-#ifndef _WIN32
-static void *migrate_hook_start_fd(QTestState *from,
-                                   QTestState *to)
-{
-    int ret;
-    int pair[2];
-
-    /* Create two connected sockets for migration */
-    ret = qemu_socketpair(PF_LOCAL, SOCK_STREAM, 0, pair);
-    g_assert_cmpint(ret, ==, 0);
-
-    /* Send the 1st socket to the target */
-    qtest_qmp_fds_assert_success(to, &pair[0], 1,
-                                 "{ 'execute': 'getfd',"
-                                 "  'arguments': { 'fdname': 'fd-mig' }}");
-    close(pair[0]);
-
-    /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to, "fd:fd-mig", "{}");
-
-    /* Send the 2nd socket to the target */
-    qtest_qmp_fds_assert_success(from, &pair[1], 1,
-                                 "{ 'execute': 'getfd',"
-                                 "  'arguments': { 'fdname': 'fd-mig' }}");
-    close(pair[1]);
-
-    return NULL;
-}
-
-static void migrate_hook_end_fd(QTestState *from,
-                                QTestState *to,
-                                void *opaque)
-{
-    QDict *rsp;
-    const char *error_desc;
-
-    /* Test closing fds */
-    /* We assume, that QEMU removes named fd from its list,
-     * so this should fail */
-    rsp = qtest_qmp(from,
-                    "{ 'execute': 'closefd',"
-                    "  'arguments': { 'fdname': 'fd-mig' }}");
-    g_assert_true(qdict_haskey(rsp, "error"));
-    error_desc = qdict_get_str(qdict_get_qdict(rsp, "error"), "desc");
-    g_assert_cmpstr(error_desc, ==, "File descriptor named 'fd-mig' not found");
-    qobject_unref(rsp);
-
-    rsp = qtest_qmp(to,
-                    "{ 'execute': 'closefd',"
-                    "  'arguments': { 'fdname': 'fd-mig' }}");
-    g_assert_true(qdict_haskey(rsp, "error"));
-    error_desc = qdict_get_str(qdict_get_qdict(rsp, "error"), "desc");
-    g_assert_cmpstr(error_desc, ==, "File descriptor named 'fd-mig' not found");
-    qobject_unref(rsp);
-}
-
-static void test_precopy_fd_socket(void)
-{
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .connect_uri = "fd:fd-mig",
-        .start_hook = migrate_hook_start_fd,
-        .end_hook = migrate_hook_end_fd,
-    };
-    test_precopy_common(&args);
-}
-
-static void *migrate_precopy_fd_file_start(QTestState *from, QTestState *to)
-{
-    g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
-    int src_flags = O_CREAT | O_RDWR;
-    int dst_flags = O_CREAT | O_RDWR;
-    int fds[2];
-
-    fds[0] = open(file, src_flags, 0660);
-    assert(fds[0] != -1);
-
-    fds[1] = open(file, dst_flags, 0660);
-    assert(fds[1] != -1);
-
-
-    qtest_qmp_fds_assert_success(to, &fds[0], 1,
-                                 "{ 'execute': 'getfd',"
-                                 "  'arguments': { 'fdname': 'fd-mig' }}");
-
-    qtest_qmp_fds_assert_success(from, &fds[1], 1,
-                                 "{ 'execute': 'getfd',"
-                                 "  'arguments': { 'fdname': 'fd-mig' }}");
-
-    close(fds[0]);
-    close(fds[1]);
-
-    return NULL;
-}
-
-static void test_precopy_fd_file(void)
-{
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .connect_uri = "fd:fd-mig",
-        .start_hook = migrate_precopy_fd_file_start,
-        .end_hook = migrate_hook_end_fd,
-    };
-    test_file_common(&args, true);
-}
-#endif /* _WIN32 */
-
 static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
@@ -505,708 +292,6 @@ static void test_validate_uri_channels_none_set(void)
     do_test_validate_uri_channel(&args);
 }
 
-/*
- * The way auto_converge works, we need to do too many passes to
- * run this test.  Auto_converge logic is only run once every
- * three iterations, so:
- *
- * - 3 iterations without auto_converge enabled
- * - 3 iterations with pct = 5
- * - 3 iterations with pct = 30
- * - 3 iterations with pct = 55
- * - 3 iterations with pct = 80
- * - 3 iterations with pct = 95 (max(95, 80 + 25))
- *
- * To make things even worse, we need to run the initial stage at
- * 3MB/s so we enter autoconverge even when host is (over)loaded.
- */
-static void test_auto_converge(void)
-{
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    MigrateStart args = {};
-    QTestState *from, *to;
-    int64_t percentage;
-
-    /*
-     * We want the test to be stable and as fast as possible.
-     * E.g., with 1Gb/s bandwidth migration may pass without throttling,
-     * so we need to decrease a bandwidth.
-     */
-    const int64_t init_pct = 5, inc_pct = 25, max_pct = 95;
-    uint64_t prev_dirty_sync_cnt, dirty_sync_cnt;
-    int max_try_count, hit = 0;
-
-    if (migrate_start(&from, &to, uri, &args)) {
-        return;
-    }
-
-    migrate_set_capability(from, "auto-converge", true);
-    migrate_set_parameter_int(from, "cpu-throttle-initial", init_pct);
-    migrate_set_parameter_int(from, "cpu-throttle-increment", inc_pct);
-    migrate_set_parameter_int(from, "max-cpu-throttle", max_pct);
-
-    /*
-     * Set the initial parameters so that the migration could not converge
-     * without throttling.
-     */
-    migrate_ensure_non_converge(from);
-
-    /* To check remaining size after precopy */
-    migrate_set_capability(from, "pause-before-switchover", true);
-
-    /* Wait for the first serial output from the source */
-    wait_for_serial("src_serial");
-
-    migrate_qmp(from, to, uri, NULL, "{}");
-
-    /* Wait for throttling begins */
-    percentage = 0;
-    do {
-        percentage = read_migrate_property_int(from, "cpu-throttle-percentage");
-        if (percentage != 0) {
-            break;
-        }
-        usleep(20);
-        g_assert_false(get_src()->stop_seen);
-    } while (true);
-    /* The first percentage of throttling should be at least init_pct */
-    g_assert_cmpint(percentage, >=, init_pct);
-
-    /*
-     * End the loop when the dirty sync count greater than 1.
-     */
-    while ((dirty_sync_cnt = get_migration_pass(from)) < 2) {
-        usleep(1000 * 1000);
-    }
-
-    prev_dirty_sync_cnt = dirty_sync_cnt;
-
-    /*
-     * The RAMBlock dirty sync count must changes in 5 seconds, here we set
-     * the timeout to 10 seconds to ensure it changes.
-     *
-     * Note that migrate_ensure_non_converge set the max-bandwidth to 3MB/s,
-     * while the qtest mem is >= 100MB, one iteration takes at least 33s (100/3)
-     * to complete; this ensures that the RAMBlock dirty sync occurs.
-     */
-    max_try_count = 10;
-    while (--max_try_count) {
-        dirty_sync_cnt = get_migration_pass(from);
-        if (dirty_sync_cnt != prev_dirty_sync_cnt) {
-            hit = 1;
-            break;
-        }
-        prev_dirty_sync_cnt = dirty_sync_cnt;
-        sleep(1);
-    }
-    g_assert_cmpint(hit, ==, 1);
-
-    /* Now, when we tested that throttling works, let it converge */
-    migrate_ensure_converge(from);
-
-    /*
-     * Wait for pre-switchover status to check last throttle percentage
-     * and remaining. These values will be zeroed later
-     */
-    wait_for_migration_status(from, "pre-switchover", NULL);
-
-    /* The final percentage of throttling shouldn't be greater than max_pct */
-    percentage = read_migrate_property_int(from, "cpu-throttle-percentage");
-    g_assert_cmpint(percentage, <=, max_pct);
-    migrate_continue(from, "pre-switchover");
-
-    qtest_qmp_eventwait(to, "RESUME");
-
-    wait_for_serial("dest_serial");
-    wait_for_migration_complete(from);
-
-    migrate_end(from, to, true);
-}
-
-static void *
-migrate_hook_start_precopy_tcp_multifd(QTestState *from,
-                                       QTestState *to)
-{
-    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
-}
-
-static void *
-migrate_hook_start_precopy_tcp_multifd_zero_page_legacy(QTestState *from,
-                                                        QTestState *to)
-{
-    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
-    migrate_set_parameter_str(from, "zero-page-detection", "legacy");
-    return NULL;
-}
-
-static void *
-test_migration_precopy_tcp_multifd_no_zero_page_start(QTestState *from,
-                                                      QTestState *to)
-{
-    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
-    migrate_set_parameter_str(from, "zero-page-detection", "none");
-    return NULL;
-}
-
-static void test_multifd_tcp_uri_none(void)
-{
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_precopy_tcp_multifd,
-        /*
-         * Multifd is more complicated than most of the features, it
-         * directly takes guest page buffers when sending, make sure
-         * everything will work alright even if guest page is changing.
-         */
-        .live = true,
-    };
-    test_precopy_common(&args);
-}
-
-static void test_multifd_tcp_zero_page_legacy(void)
-{
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_precopy_tcp_multifd_zero_page_legacy,
-        /*
-         * Multifd is more complicated than most of the features, it
-         * directly takes guest page buffers when sending, make sure
-         * everything will work alright even if guest page is changing.
-         */
-        .live = true,
-    };
-    test_precopy_common(&args);
-}
-
-static void test_multifd_tcp_no_zero_page(void)
-{
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .start_hook = test_migration_precopy_tcp_multifd_no_zero_page_start,
-        /*
-         * Multifd is more complicated than most of the features, it
-         * directly takes guest page buffers when sending, make sure
-         * everything will work alright even if guest page is changing.
-         */
-        .live = true,
-    };
-    test_precopy_common(&args);
-}
-
-static void test_multifd_tcp_channels_none(void)
-{
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_precopy_tcp_multifd,
-        .live = true,
-        .connect_channels = ("[ { 'channel-type': 'main',"
-                             "    'addr': { 'transport': 'socket',"
-                             "              'type': 'inet',"
-                             "              'host': '127.0.0.1',"
-                             "              'port': '0' } } ]"),
-    };
-    test_precopy_common(&args);
-}
-
-/*
- * This test does:
- *  source               target
- *                       migrate_incoming
- *     migrate
- *     migrate_cancel
- *                       launch another target
- *     migrate
- *
- *  And see that it works
- */
-static void test_multifd_tcp_cancel(void)
-{
-    MigrateStart args = {
-        .hide_stderr = true,
-    };
-    QTestState *from, *to, *to2;
-
-    if (migrate_start(&from, &to, "defer", &args)) {
-        return;
-    }
-
-    migrate_ensure_non_converge(from);
-    migrate_prepare_for_dirty_mem(from);
-
-    migrate_set_parameter_int(from, "multifd-channels", 16);
-    migrate_set_parameter_int(to, "multifd-channels", 16);
-
-    migrate_set_capability(from, "multifd", true);
-    migrate_set_capability(to, "multifd", true);
-
-    /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
-
-    /* Wait for the first serial output from the source */
-    wait_for_serial("src_serial");
-
-    migrate_qmp(from, to, NULL, NULL, "{}");
-
-    migrate_wait_for_dirty_mem(from, to);
-
-    migrate_cancel(from);
-
-    /* Make sure QEMU process "to" exited */
-    qtest_set_expected_status(to, EXIT_FAILURE);
-    qtest_wait_qemu(to);
-    qtest_quit(to);
-
-    /*
-     * Ensure the source QEMU finishes its cancellation process before we
-     * proceed with the setup of the next migration. The migrate_start()
-     * function and others might want to interact with the source in a way that
-     * is not possible while the migration is not canceled properly. For
-     * example, setting migration capabilities when the migration is still
-     * running leads to an error.
-     */
-    wait_for_migration_status(from, "cancelled", NULL);
-
-    args = (MigrateStart){
-        .only_target = true,
-    };
-
-    if (migrate_start(&from, &to2, "defer", &args)) {
-        return;
-    }
-
-    migrate_set_parameter_int(to2, "multifd-channels", 16);
-
-    migrate_set_capability(to2, "multifd", true);
-
-    /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to2, "tcp:127.0.0.1:0", "{}");
-
-    migrate_ensure_non_converge(from);
-
-    migrate_qmp(from, to2, NULL, NULL, "{}");
-
-    migrate_wait_for_dirty_mem(from, to2);
-
-    migrate_ensure_converge(from);
-
-    wait_for_stop(from, get_src());
-    qtest_qmp_eventwait(to2, "RESUME");
-
-    wait_for_serial("dest_serial");
-    wait_for_migration_complete(from);
-    migrate_end(from, to2, true);
-}
-
-static void calc_dirty_rate(QTestState *who, uint64_t calc_time)
-{
-    qtest_qmp_assert_success(who,
-                             "{ 'execute': 'calc-dirty-rate',"
-                             "'arguments': { "
-                             "'calc-time': %" PRIu64 ","
-                             "'mode': 'dirty-ring' }}",
-                             calc_time);
-}
-
-static QDict *query_dirty_rate(QTestState *who)
-{
-    return qtest_qmp_assert_success_ref(who,
-                                        "{ 'execute': 'query-dirty-rate' }");
-}
-
-static void dirtylimit_set_all(QTestState *who, uint64_t dirtyrate)
-{
-    qtest_qmp_assert_success(who,
-                             "{ 'execute': 'set-vcpu-dirty-limit',"
-                             "'arguments': { "
-                             "'dirty-rate': %" PRIu64 " } }",
-                             dirtyrate);
-}
-
-static void cancel_vcpu_dirty_limit(QTestState *who)
-{
-    qtest_qmp_assert_success(who,
-                             "{ 'execute': 'cancel-vcpu-dirty-limit' }");
-}
-
-static QDict *query_vcpu_dirty_limit(QTestState *who)
-{
-    QDict *rsp;
-
-    rsp = qtest_qmp(who, "{ 'execute': 'query-vcpu-dirty-limit' }");
-    g_assert(!qdict_haskey(rsp, "error"));
-    g_assert(qdict_haskey(rsp, "return"));
-
-    return rsp;
-}
-
-static bool calc_dirtyrate_ready(QTestState *who)
-{
-    QDict *rsp_return;
-    const char *status;
-    bool ready;
-
-    rsp_return = query_dirty_rate(who);
-    g_assert(rsp_return);
-
-    status = qdict_get_str(rsp_return, "status");
-    g_assert(status);
-    ready = g_strcmp0(status, "measuring");
-    qobject_unref(rsp_return);
-
-    return ready;
-}
-
-static void wait_for_calc_dirtyrate_complete(QTestState *who,
-                                             int64_t time_s)
-{
-    int max_try_count = 10000;
-    usleep(time_s * 1000000);
-
-    while (!calc_dirtyrate_ready(who) && max_try_count--) {
-        usleep(1000);
-    }
-
-    /*
-     * Set the timeout with 10 s(max_try_count * 1000us),
-     * if dirtyrate measurement not complete, fail test.
-     */
-    g_assert_cmpint(max_try_count, !=, 0);
-}
-
-static int64_t get_dirty_rate(QTestState *who)
-{
-    QDict *rsp_return;
-    const char *status;
-    QList *rates;
-    const QListEntry *entry;
-    QDict *rate;
-    int64_t dirtyrate;
-
-    rsp_return = query_dirty_rate(who);
-    g_assert(rsp_return);
-
-    status = qdict_get_str(rsp_return, "status");
-    g_assert(status);
-    g_assert_cmpstr(status, ==, "measured");
-
-    rates = qdict_get_qlist(rsp_return, "vcpu-dirty-rate");
-    g_assert(rates && !qlist_empty(rates));
-
-    entry = qlist_first(rates);
-    g_assert(entry);
-
-    rate = qobject_to(QDict, qlist_entry_obj(entry));
-    g_assert(rate);
-
-    dirtyrate = qdict_get_try_int(rate, "dirty-rate", -1);
-
-    qobject_unref(rsp_return);
-    return dirtyrate;
-}
-
-static int64_t get_limit_rate(QTestState *who)
-{
-    QDict *rsp_return;
-    QList *rates;
-    const QListEntry *entry;
-    QDict *rate;
-    int64_t dirtyrate;
-
-    rsp_return = query_vcpu_dirty_limit(who);
-    g_assert(rsp_return);
-
-    rates = qdict_get_qlist(rsp_return, "return");
-    g_assert(rates && !qlist_empty(rates));
-
-    entry = qlist_first(rates);
-    g_assert(entry);
-
-    rate = qobject_to(QDict, qlist_entry_obj(entry));
-    g_assert(rate);
-
-    dirtyrate = qdict_get_try_int(rate, "limit-rate", -1);
-
-    qobject_unref(rsp_return);
-    return dirtyrate;
-}
-
-static QTestState *dirtylimit_start_vm(void)
-{
-    QTestState *vm = NULL;
-    g_autofree gchar *cmd = NULL;
-    const char *bootpath;
-
-    bootpath = bootfile_create(qtest_get_arch(), tmpfs, false);
-    cmd = g_strdup_printf("-accel kvm,dirty-ring-size=4096 "
-                          "-name dirtylimit-test,debug-threads=on "
-                          "-m 150M -smp 1 "
-                          "-serial file:%s/vm_serial "
-                          "-drive file=%s,format=raw ",
-                          tmpfs, bootpath);
-
-    vm = qtest_init(cmd);
-    return vm;
-}
-
-static void dirtylimit_stop_vm(QTestState *vm)
-{
-    g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, "vm_serial");
-
-    qtest_quit(vm);
-    unlink(path);
-}
-
-static void test_vcpu_dirty_limit(void)
-{
-    QTestState *vm;
-    int64_t origin_rate;
-    int64_t quota_rate;
-    int64_t rate ;
-    int max_try_count = 20;
-    int hit = 0;
-
-    /* Start vm for vcpu dirtylimit test */
-    vm = dirtylimit_start_vm();
-
-    /* Wait for the first serial output from the vm*/
-    wait_for_serial("vm_serial");
-
-    /* Do dirtyrate measurement with calc time equals 1s */
-    calc_dirty_rate(vm, 1);
-
-    /* Sleep calc time and wait for calc dirtyrate complete */
-    wait_for_calc_dirtyrate_complete(vm, 1);
-
-    /* Query original dirty page rate */
-    origin_rate = get_dirty_rate(vm);
-
-    /* VM booted from bootsect should dirty memory steadily */
-    assert(origin_rate != 0);
-
-    /* Setup quota dirty page rate at half of origin */
-    quota_rate = origin_rate / 2;
-
-    /* Set dirtylimit */
-    dirtylimit_set_all(vm, quota_rate);
-
-    /*
-     * Check if set-vcpu-dirty-limit and query-vcpu-dirty-limit
-     * works literally
-     */
-    g_assert_cmpint(quota_rate, ==, get_limit_rate(vm));
-
-    /* Sleep a bit to check if it take effect */
-    usleep(2000000);
-
-    /*
-     * Check if dirtylimit take effect realistically, set the
-     * timeout with 20 s(max_try_count * 1s), if dirtylimit
-     * doesn't take effect, fail test.
-     */
-    while (--max_try_count) {
-        calc_dirty_rate(vm, 1);
-        wait_for_calc_dirtyrate_complete(vm, 1);
-        rate = get_dirty_rate(vm);
-
-        /*
-         * Assume hitting if current rate is less
-         * than quota rate (within accepting error)
-         */
-        if (rate < (quota_rate + DIRTYLIMIT_TOLERANCE_RANGE)) {
-            hit = 1;
-            break;
-        }
-    }
-
-    g_assert_cmpint(hit, ==, 1);
-
-    hit = 0;
-    max_try_count = 20;
-
-    /* Check if dirtylimit cancellation take effect */
-    cancel_vcpu_dirty_limit(vm);
-    while (--max_try_count) {
-        calc_dirty_rate(vm, 1);
-        wait_for_calc_dirtyrate_complete(vm, 1);
-        rate = get_dirty_rate(vm);
-
-        /*
-         * Assume dirtylimit be canceled if current rate is
-         * greater than quota rate (within accepting error)
-         */
-        if (rate > (quota_rate + DIRTYLIMIT_TOLERANCE_RANGE)) {
-            hit = 1;
-            break;
-        }
-    }
-
-    g_assert_cmpint(hit, ==, 1);
-    dirtylimit_stop_vm(vm);
-}
-
-static void migrate_dirty_limit_wait_showup(QTestState *from,
-                                            const int64_t period,
-                                            const int64_t value)
-{
-    /* Enable dirty limit capability */
-    migrate_set_capability(from, "dirty-limit", true);
-
-    /* Set dirty limit parameters */
-    migrate_set_parameter_int(from, "x-vcpu-dirty-limit-period", period);
-    migrate_set_parameter_int(from, "vcpu-dirty-limit", value);
-
-    /* Make sure migrate can't converge */
-    migrate_ensure_non_converge(from);
-
-    /* To check limit rate after precopy */
-    migrate_set_capability(from, "pause-before-switchover", true);
-
-    /* Wait for the serial output from the source */
-    wait_for_serial("src_serial");
-}
-
-/*
- * This test does:
- *  source                          destination
- *  start vm
- *                                  start incoming vm
- *  migrate
- *  wait dirty limit to begin
- *  cancel migrate
- *  cancellation check
- *                                  restart incoming vm
- *  migrate
- *  wait dirty limit to begin
- *  wait pre-switchover event
- *  convergence condition check
- *
- * And see if dirty limit migration works correctly.
- * This test case involves many passes, so it runs in slow mode only.
- */
-static void test_dirty_limit(void)
-{
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    QTestState *from, *to;
-    int64_t remaining;
-    uint64_t throttle_us_per_full;
-    /*
-     * We want the test to be stable and as fast as possible.
-     * E.g., with 1Gb/s bandwidth migration may pass without dirty limit,
-     * so we need to decrease a bandwidth.
-     */
-    const int64_t dirtylimit_period = 1000, dirtylimit_value = 50;
-    const int64_t max_bandwidth = 400000000; /* ~400Mb/s */
-    const int64_t downtime_limit = 250; /* 250ms */
-    /*
-     * We migrate through unix-socket (> 500Mb/s).
-     * Thus, expected migration speed ~= bandwidth limit (< 500Mb/s).
-     * So, we can predict expected_threshold
-     */
-    const int64_t expected_threshold = max_bandwidth * downtime_limit / 1000;
-    int max_try_count = 10;
-    MigrateCommon args = {
-        .start = {
-            .hide_stderr = true,
-            .use_dirty_ring = true,
-        },
-        .listen_uri = uri,
-        .connect_uri = uri,
-    };
-
-    /* Start src, dst vm */
-    if (migrate_start(&from, &to, args.listen_uri, &args.start)) {
-        return;
-    }
-
-    /* Prepare for dirty limit migration and wait src vm show up */
-    migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
-
-    /* Start migrate */
-    migrate_qmp(from, to, args.connect_uri, NULL, "{}");
-
-    /* Wait for dirty limit throttle begin */
-    throttle_us_per_full = 0;
-    while (throttle_us_per_full == 0) {
-        throttle_us_per_full =
-            read_migrate_property_int(from,
-                                      "dirty-limit-throttle-time-per-round");
-        usleep(100);
-        g_assert_false(get_src()->stop_seen);
-    }
-
-    /* Now cancel migrate and wait for dirty limit throttle switch off */
-    migrate_cancel(from);
-    wait_for_migration_status(from, "cancelled", NULL);
-
-    /* Check if dirty limit throttle switched off, set timeout 1ms */
-    do {
-        throttle_us_per_full =
-            read_migrate_property_int(from,
-                                      "dirty-limit-throttle-time-per-round");
-        usleep(100);
-        g_assert_false(get_src()->stop_seen);
-    } while (throttle_us_per_full != 0 && --max_try_count);
-
-    /* Assert dirty limit is not in service */
-    g_assert_cmpint(throttle_us_per_full, ==, 0);
-
-    args = (MigrateCommon) {
-        .start = {
-            .only_target = true,
-            .use_dirty_ring = true,
-        },
-        .listen_uri = uri,
-        .connect_uri = uri,
-    };
-
-    /* Restart dst vm, src vm already show up so we needn't wait anymore */
-    if (migrate_start(&from, &to, args.listen_uri, &args.start)) {
-        return;
-    }
-
-    /* Start migrate */
-    migrate_qmp(from, to, args.connect_uri, NULL, "{}");
-
-    /* Wait for dirty limit throttle begin */
-    throttle_us_per_full = 0;
-    while (throttle_us_per_full == 0) {
-        throttle_us_per_full =
-            read_migrate_property_int(from,
-                                      "dirty-limit-throttle-time-per-round");
-        usleep(100);
-        g_assert_false(get_src()->stop_seen);
-    }
-
-    /*
-     * The dirty limit rate should equals the return value of
-     * query-vcpu-dirty-limit if dirty limit cap set
-     */
-    g_assert_cmpint(dirtylimit_value, ==, get_limit_rate(from));
-
-    /* Now, we have tested if dirty limit works, let it converge */
-    migrate_set_parameter_int(from, "downtime-limit", downtime_limit);
-    migrate_set_parameter_int(from, "max-bandwidth", max_bandwidth);
-
-    /*
-     * Wait for pre-switchover status to check if migration
-     * satisfy the convergence condition
-     */
-    wait_for_migration_status(from, "pre-switchover", NULL);
-
-    remaining = read_ram_property_int(from, "remaining");
-    g_assert_cmpint(remaining, <,
-                    (expected_threshold + expected_threshold / 100));
-
-    migrate_continue(from, "pre-switchover");
-
-    qtest_qmp_eventwait(to, "RESUME");
-
-    wait_for_serial("dest_serial");
-    wait_for_migration_complete(from);
-
-    migrate_end(from, to, true);
-}
-
 int main(int argc, char **argv)
 {
     MigrationTestEnv *env;
@@ -1222,21 +307,13 @@ int main(int argc, char **argv)
     migration_test_add_compression(env);
     migration_test_add_postcopy(env);
     migration_test_add_file(env);
+    migration_test_add_precopy(env);
 
     migration_test_add("/migration/bad_dest", test_baddest);
 #ifndef _WIN32
     migration_test_add("/migration/analyze-script", test_analyze_script);
 #endif
 
-    if (env->is_x86) {
-        migration_test_add("/migration/precopy/unix/suspend/live",
-                           test_precopy_unix_suspend_live);
-        migration_test_add("/migration/precopy/unix/suspend/notlive",
-                           test_precopy_unix_suspend_notlive);
-    }
-
-    migration_test_add("/migration/precopy/unix/plain",
-                       test_precopy_unix_plain);
     /*
      * Our CI system has problems with shared memory.
      * Don't run this test until we find a workaround.
@@ -1245,18 +322,8 @@ int main(int argc, char **argv)
         migration_test_add("/migration/mode/reboot", test_mode_reboot);
     }
 
-    migration_test_add("/migration/precopy/tcp/plain", test_precopy_tcp_plain);
-
-    migration_test_add("/migration/precopy/tcp/plain/switchover-ack",
-                       test_precopy_tcp_switchover_ack);
-
     /* migration_test_add("/migration/ignore_shared", test_ignore_shared); */
-#ifndef _WIN32
-    migration_test_add("/migration/precopy/fd/tcp",
-                       test_precopy_fd_socket);
-    migration_test_add("/migration/precopy/fd/file",
-                       test_precopy_fd_file);
-#endif
+
     migration_test_add("/migration/validate_uuid", test_validate_uuid);
     migration_test_add("/migration/validate_uuid_error",
                        test_validate_uuid_error);
@@ -1268,39 +335,6 @@ int main(int argc, char **argv)
                        test_validate_uri_channels_both_set);
     migration_test_add("/migration/validate_uri/channels/none_set",
                        test_validate_uri_channels_none_set);
-    /*
-     * See explanation why this test is slow on function definition
-     */
-    if (g_test_slow()) {
-        migration_test_add("/migration/auto_converge",
-                           test_auto_converge);
-        if (g_str_equal(env->arch, "x86_64") &&
-            env->has_kvm && env->has_dirty_ring) {
-            migration_test_add("/dirty_limit",
-                               test_dirty_limit);
-        }
-    }
-    migration_test_add("/migration/multifd/tcp/uri/plain/none",
-                       test_multifd_tcp_uri_none);
-    migration_test_add("/migration/multifd/tcp/channels/plain/none",
-                       test_multifd_tcp_channels_none);
-    migration_test_add("/migration/multifd/tcp/plain/zero-page/legacy",
-                       test_multifd_tcp_zero_page_legacy);
-    migration_test_add("/migration/multifd/tcp/plain/zero-page/none",
-                       test_multifd_tcp_no_zero_page);
-    migration_test_add("/migration/multifd/tcp/plain/cancel",
-                       test_multifd_tcp_cancel);
-
-    if (g_str_equal(env->arch, "x86_64") &&
-        env->has_kvm && env->has_dirty_ring) {
-
-        migration_test_add("/migration/dirty_ring",
-                           test_precopy_unix_dirty_ring);
-        if (qtest_has_machine("pc") && g_test_slow()) {
-            migration_test_add("/migration/vcpu_dirty_limit",
-                               test_vcpu_dirty_limit);
-        }
-    }
 
     ret = g_test_run();
 
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
new file mode 100644
index 0000000000..c7c802f812
--- /dev/null
+++ b/tests/qtest/migration/precopy-tests.c
@@ -0,0 +1,1007 @@
+/*
+ * QTest testcase for precopy migration
+ *
+ * Copyright (c) 2016-2018 Red Hat, Inc. and/or its affiliates
+ *   based on the vhost-user-test.c that is:
+ *      Copyright (c) 2014 Virtual Open Systems Sarl.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "chardev/char.h"
+#include "crypto/tlscredspsk.h"
+#include "libqtest.h"
+#include "migration/bootfile.h"
+#include "migration/migration-qmp.h"
+#include "migration/migration-util.h"
+#include "migration/test-framework.h"
+#include "ppc-util.h"
+#include "qapi/qmp/qlist.h"
+#include "qemu/module.h"
+#include "qemu/option.h"
+#include "qemu/range.h"
+#include "qemu/sockets.h"
+
+
+/*
+ * Dirtylimit stop working if dirty page rate error
+ * value less than DIRTYLIMIT_TOLERANCE_RANGE
+ */
+#define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
+
+static char *tmpfs;
+
+static void test_precopy_unix_plain(void)
+{
+    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    MigrateCommon args = {
+        .listen_uri = uri,
+        .connect_uri = uri,
+        /*
+         * The simplest use case of precopy, covering smoke tests of
+         * get-dirty-log dirty tracking.
+         */
+        .live = true,
+    };
+
+    test_precopy_common(&args);
+}
+
+static void test_precopy_unix_suspend_live(void)
+{
+    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    MigrateCommon args = {
+        .listen_uri = uri,
+        .connect_uri = uri,
+        /*
+         * despite being live, the test is fast because the src
+         * suspends immediately.
+         */
+        .live = true,
+        .start.suspend_me = true,
+    };
+
+    test_precopy_common(&args);
+}
+
+static void test_precopy_unix_suspend_notlive(void)
+{
+    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    MigrateCommon args = {
+        .listen_uri = uri,
+        .connect_uri = uri,
+        .start.suspend_me = true,
+    };
+
+    test_precopy_common(&args);
+}
+
+static void test_precopy_unix_dirty_ring(void)
+{
+    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    MigrateCommon args = {
+        .start = {
+            .use_dirty_ring = true,
+        },
+        .listen_uri = uri,
+        .connect_uri = uri,
+        /*
+         * Besides the precopy/unix basic test, cover dirty ring interface
+         * rather than get-dirty-log.
+         */
+        .live = true,
+    };
+
+    test_precopy_common(&args);
+}
+
+static void test_precopy_tcp_plain(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "tcp:127.0.0.1:0",
+    };
+
+    test_precopy_common(&args);
+}
+
+static void *migrate_hook_start_switchover_ack(QTestState *from, QTestState *to)
+{
+
+    migrate_set_capability(from, "return-path", true);
+    migrate_set_capability(to, "return-path", true);
+
+    migrate_set_capability(from, "switchover-ack", true);
+    migrate_set_capability(to, "switchover-ack", true);
+
+    return NULL;
+}
+
+static void test_precopy_tcp_switchover_ack(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "tcp:127.0.0.1:0",
+        .start_hook = migrate_hook_start_switchover_ack,
+        /*
+         * Source VM must be running in order to consider the switchover ACK
+         * when deciding to do switchover or not.
+         */
+        .live = true,
+    };
+
+    test_precopy_common(&args);
+}
+
+#ifndef _WIN32
+static void *migrate_hook_start_fd(QTestState *from,
+                                   QTestState *to)
+{
+    int ret;
+    int pair[2];
+
+    /* Create two connected sockets for migration */
+    ret = qemu_socketpair(PF_LOCAL, SOCK_STREAM, 0, pair);
+    g_assert_cmpint(ret, ==, 0);
+
+    /* Send the 1st socket to the target */
+    qtest_qmp_fds_assert_success(to, &pair[0], 1,
+                                 "{ 'execute': 'getfd',"
+                                 "  'arguments': { 'fdname': 'fd-mig' }}");
+    close(pair[0]);
+
+    /* Start incoming migration from the 1st socket */
+    migrate_incoming_qmp(to, "fd:fd-mig", "{}");
+
+    /* Send the 2nd socket to the target */
+    qtest_qmp_fds_assert_success(from, &pair[1], 1,
+                                 "{ 'execute': 'getfd',"
+                                 "  'arguments': { 'fdname': 'fd-mig' }}");
+    close(pair[1]);
+
+    return NULL;
+}
+
+static void migrate_hook_end_fd(QTestState *from,
+                                QTestState *to,
+                                void *opaque)
+{
+    QDict *rsp;
+    const char *error_desc;
+
+    /* Test closing fds */
+    /*
+     * We assume, that QEMU removes named fd from its list,
+     * so this should fail.
+     */
+    rsp = qtest_qmp(from,
+                    "{ 'execute': 'closefd',"
+                    "  'arguments': { 'fdname': 'fd-mig' }}");
+    g_assert_true(qdict_haskey(rsp, "error"));
+    error_desc = qdict_get_str(qdict_get_qdict(rsp, "error"), "desc");
+    g_assert_cmpstr(error_desc, ==, "File descriptor named 'fd-mig' not found");
+    qobject_unref(rsp);
+
+    rsp = qtest_qmp(to,
+                    "{ 'execute': 'closefd',"
+                    "  'arguments': { 'fdname': 'fd-mig' }}");
+    g_assert_true(qdict_haskey(rsp, "error"));
+    error_desc = qdict_get_str(qdict_get_qdict(rsp, "error"), "desc");
+    g_assert_cmpstr(error_desc, ==, "File descriptor named 'fd-mig' not found");
+    qobject_unref(rsp);
+}
+
+static void test_precopy_fd_socket(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .connect_uri = "fd:fd-mig",
+        .start_hook = migrate_hook_start_fd,
+        .end_hook = migrate_hook_end_fd,
+    };
+    test_precopy_common(&args);
+}
+
+static void *migrate_hook_start_precopy_fd_file(QTestState *from,
+                                                QTestState *to)
+{
+    g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
+    int src_flags = O_CREAT | O_RDWR;
+    int dst_flags = O_CREAT | O_RDWR;
+    int fds[2];
+
+    fds[0] = open(file, src_flags, 0660);
+    assert(fds[0] != -1);
+
+    fds[1] = open(file, dst_flags, 0660);
+    assert(fds[1] != -1);
+
+
+    qtest_qmp_fds_assert_success(to, &fds[0], 1,
+                                 "{ 'execute': 'getfd',"
+                                 "  'arguments': { 'fdname': 'fd-mig' }}");
+
+    qtest_qmp_fds_assert_success(from, &fds[1], 1,
+                                 "{ 'execute': 'getfd',"
+                                 "  'arguments': { 'fdname': 'fd-mig' }}");
+
+    close(fds[0]);
+    close(fds[1]);
+
+    return NULL;
+}
+
+static void test_precopy_fd_file(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .connect_uri = "fd:fd-mig",
+        .start_hook = migrate_hook_start_precopy_fd_file,
+        .end_hook = migrate_hook_end_fd,
+    };
+    test_file_common(&args, true);
+}
+#endif /* _WIN32 */
+
+/*
+ * The way auto_converge works, we need to do too many passes to
+ * run this test.  Auto_converge logic is only run once every
+ * three iterations, so:
+ *
+ * - 3 iterations without auto_converge enabled
+ * - 3 iterations with pct = 5
+ * - 3 iterations with pct = 30
+ * - 3 iterations with pct = 55
+ * - 3 iterations with pct = 80
+ * - 3 iterations with pct = 95 (max(95, 80 + 25))
+ *
+ * To make things even worse, we need to run the initial stage at
+ * 3MB/s so we enter autoconverge even when host is (over)loaded.
+ */
+static void test_auto_converge(void)
+{
+    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    MigrateStart args = {};
+    QTestState *from, *to;
+    int64_t percentage;
+
+    /*
+     * We want the test to be stable and as fast as possible.
+     * E.g., with 1Gb/s bandwidth migration may pass without throttling,
+     * so we need to decrease a bandwidth.
+     */
+    const int64_t init_pct = 5, inc_pct = 25, max_pct = 95;
+    uint64_t prev_dirty_sync_cnt, dirty_sync_cnt;
+    int max_try_count, hit = 0;
+
+    if (migrate_start(&from, &to, uri, &args)) {
+        return;
+    }
+
+    migrate_set_capability(from, "auto-converge", true);
+    migrate_set_parameter_int(from, "cpu-throttle-initial", init_pct);
+    migrate_set_parameter_int(from, "cpu-throttle-increment", inc_pct);
+    migrate_set_parameter_int(from, "max-cpu-throttle", max_pct);
+
+    /*
+     * Set the initial parameters so that the migration could not converge
+     * without throttling.
+     */
+    migrate_ensure_non_converge(from);
+
+    /* To check remaining size after precopy */
+    migrate_set_capability(from, "pause-before-switchover", true);
+
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    migrate_qmp(from, to, uri, NULL, "{}");
+
+    /* Wait for throttling begins */
+    percentage = 0;
+    do {
+        percentage = read_migrate_property_int(from, "cpu-throttle-percentage");
+        if (percentage != 0) {
+            break;
+        }
+        usleep(20);
+        g_assert_false(get_src()->stop_seen);
+    } while (true);
+    /* The first percentage of throttling should be at least init_pct */
+    g_assert_cmpint(percentage, >=, init_pct);
+
+    /*
+     * End the loop when the dirty sync count greater than 1.
+     */
+    while ((dirty_sync_cnt = get_migration_pass(from)) < 2) {
+        usleep(1000 * 1000);
+    }
+
+    prev_dirty_sync_cnt = dirty_sync_cnt;
+
+    /*
+     * The RAMBlock dirty sync count must changes in 5 seconds, here we set
+     * the timeout to 10 seconds to ensure it changes.
+     *
+     * Note that migrate_ensure_non_converge set the max-bandwidth to 3MB/s,
+     * while the qtest mem is >= 100MB, one iteration takes at least 33s (100/3)
+     * to complete; this ensures that the RAMBlock dirty sync occurs.
+     */
+    max_try_count = 10;
+    while (--max_try_count) {
+        dirty_sync_cnt = get_migration_pass(from);
+        if (dirty_sync_cnt != prev_dirty_sync_cnt) {
+            hit = 1;
+            break;
+        }
+        prev_dirty_sync_cnt = dirty_sync_cnt;
+        sleep(1);
+    }
+    g_assert_cmpint(hit, ==, 1);
+
+    /* Now, when we tested that throttling works, let it converge */
+    migrate_ensure_converge(from);
+
+    /*
+     * Wait for pre-switchover status to check last throttle percentage
+     * and remaining. These values will be zeroed later
+     */
+    wait_for_migration_status(from, "pre-switchover", NULL);
+
+    /* The final percentage of throttling shouldn't be greater than max_pct */
+    percentage = read_migrate_property_int(from, "cpu-throttle-percentage");
+    g_assert_cmpint(percentage, <=, max_pct);
+    migrate_continue(from, "pre-switchover");
+
+    qtest_qmp_eventwait(to, "RESUME");
+
+    wait_for_serial("dest_serial");
+    wait_for_migration_complete(from);
+
+    migrate_end(from, to, true);
+}
+
+static void *
+migrate_hook_start_precopy_tcp_multifd(QTestState *from,
+                                       QTestState *to)
+{
+    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
+}
+
+static void *
+migrate_hook_start_precopy_tcp_multifd_zero_page_legacy(QTestState *from,
+                                                        QTestState *to)
+{
+    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
+    migrate_set_parameter_str(from, "zero-page-detection", "legacy");
+    return NULL;
+}
+
+static void *
+test_migration_precopy_tcp_multifd_no_zero_page_start(QTestState *from,
+                                                      QTestState *to)
+{
+    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
+    migrate_set_parameter_str(from, "zero-page-detection", "none");
+    return NULL;
+}
+
+static void test_multifd_tcp_uri_none(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = migrate_hook_start_precopy_tcp_multifd,
+        /*
+         * Multifd is more complicated than most of the features, it
+         * directly takes guest page buffers when sending, make sure
+         * everything will work alright even if guest page is changing.
+         */
+        .live = true,
+    };
+    test_precopy_common(&args);
+}
+
+static void test_multifd_tcp_zero_page_legacy(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = migrate_hook_start_precopy_tcp_multifd_zero_page_legacy,
+        /*
+         * Multifd is more complicated than most of the features, it
+         * directly takes guest page buffers when sending, make sure
+         * everything will work alright even if guest page is changing.
+         */
+        .live = true,
+    };
+    test_precopy_common(&args);
+}
+
+static void test_multifd_tcp_no_zero_page(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = test_migration_precopy_tcp_multifd_no_zero_page_start,
+        /*
+         * Multifd is more complicated than most of the features, it
+         * directly takes guest page buffers when sending, make sure
+         * everything will work alright even if guest page is changing.
+         */
+        .live = true,
+    };
+    test_precopy_common(&args);
+}
+
+static void test_multifd_tcp_channels_none(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = migrate_hook_start_precopy_tcp_multifd,
+        .live = true,
+        .connect_channels = ("[ { 'channel-type': 'main',"
+                             "    'addr': { 'transport': 'socket',"
+                             "              'type': 'inet',"
+                             "              'host': '127.0.0.1',"
+                             "              'port': '0' } } ]"),
+    };
+    test_precopy_common(&args);
+}
+
+/*
+ * This test does:
+ *  source               target
+ *                       migrate_incoming
+ *     migrate
+ *     migrate_cancel
+ *                       launch another target
+ *     migrate
+ *
+ *  And see that it works
+ */
+static void test_multifd_tcp_cancel(void)
+{
+    MigrateStart args = {
+        .hide_stderr = true,
+    };
+    QTestState *from, *to, *to2;
+
+    if (migrate_start(&from, &to, "defer", &args)) {
+        return;
+    }
+
+    migrate_ensure_non_converge(from);
+    migrate_prepare_for_dirty_mem(from);
+
+    migrate_set_parameter_int(from, "multifd-channels", 16);
+    migrate_set_parameter_int(to, "multifd-channels", 16);
+
+    migrate_set_capability(from, "multifd", true);
+    migrate_set_capability(to, "multifd", true);
+
+    /* Start incoming migration from the 1st socket */
+    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
+
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    migrate_qmp(from, to, NULL, NULL, "{}");
+
+    migrate_wait_for_dirty_mem(from, to);
+
+    migrate_cancel(from);
+
+    /* Make sure QEMU process "to" exited */
+    qtest_set_expected_status(to, EXIT_FAILURE);
+    qtest_wait_qemu(to);
+    qtest_quit(to);
+
+    /*
+     * Ensure the source QEMU finishes its cancellation process before we
+     * proceed with the setup of the next migration. The migrate_start()
+     * function and others might want to interact with the source in a way that
+     * is not possible while the migration is not canceled properly. For
+     * example, setting migration capabilities when the migration is still
+     * running leads to an error.
+     */
+    wait_for_migration_status(from, "cancelled", NULL);
+
+    args = (MigrateStart){
+        .only_target = true,
+    };
+
+    if (migrate_start(&from, &to2, "defer", &args)) {
+        return;
+    }
+
+    migrate_set_parameter_int(to2, "multifd-channels", 16);
+
+    migrate_set_capability(to2, "multifd", true);
+
+    /* Start incoming migration from the 1st socket */
+    migrate_incoming_qmp(to2, "tcp:127.0.0.1:0", "{}");
+
+    migrate_ensure_non_converge(from);
+
+    migrate_qmp(from, to2, NULL, NULL, "{}");
+
+    migrate_wait_for_dirty_mem(from, to2);
+
+    migrate_ensure_converge(from);
+
+    wait_for_stop(from, get_src());
+    qtest_qmp_eventwait(to2, "RESUME");
+
+    wait_for_serial("dest_serial");
+    wait_for_migration_complete(from);
+    migrate_end(from, to2, true);
+}
+
+static void calc_dirty_rate(QTestState *who, uint64_t calc_time)
+{
+    qtest_qmp_assert_success(who,
+                             "{ 'execute': 'calc-dirty-rate',"
+                             "'arguments': { "
+                             "'calc-time': %" PRIu64 ","
+                             "'mode': 'dirty-ring' }}",
+                             calc_time);
+}
+
+static QDict *query_dirty_rate(QTestState *who)
+{
+    return qtest_qmp_assert_success_ref(who,
+                                        "{ 'execute': 'query-dirty-rate' }");
+}
+
+static void dirtylimit_set_all(QTestState *who, uint64_t dirtyrate)
+{
+    qtest_qmp_assert_success(who,
+                             "{ 'execute': 'set-vcpu-dirty-limit',"
+                             "'arguments': { "
+                             "'dirty-rate': %" PRIu64 " } }",
+                             dirtyrate);
+}
+
+static void cancel_vcpu_dirty_limit(QTestState *who)
+{
+    qtest_qmp_assert_success(who,
+                             "{ 'execute': 'cancel-vcpu-dirty-limit' }");
+}
+
+static QDict *query_vcpu_dirty_limit(QTestState *who)
+{
+    QDict *rsp;
+
+    rsp = qtest_qmp(who, "{ 'execute': 'query-vcpu-dirty-limit' }");
+    g_assert(!qdict_haskey(rsp, "error"));
+    g_assert(qdict_haskey(rsp, "return"));
+
+    return rsp;
+}
+
+static bool calc_dirtyrate_ready(QTestState *who)
+{
+    QDict *rsp_return;
+    const char *status;
+    bool ready;
+
+    rsp_return = query_dirty_rate(who);
+    g_assert(rsp_return);
+
+    status = qdict_get_str(rsp_return, "status");
+    g_assert(status);
+    ready = g_strcmp0(status, "measuring");
+    qobject_unref(rsp_return);
+
+    return ready;
+}
+
+static void wait_for_calc_dirtyrate_complete(QTestState *who,
+                                             int64_t time_s)
+{
+    int max_try_count = 10000;
+    usleep(time_s * 1000000);
+
+    while (!calc_dirtyrate_ready(who) && max_try_count--) {
+        usleep(1000);
+    }
+
+    /*
+     * Set the timeout with 10 s(max_try_count * 1000us),
+     * if dirtyrate measurement not complete, fail test.
+     */
+    g_assert_cmpint(max_try_count, !=, 0);
+}
+
+static int64_t get_dirty_rate(QTestState *who)
+{
+    QDict *rsp_return;
+    const char *status;
+    QList *rates;
+    const QListEntry *entry;
+    QDict *rate;
+    int64_t dirtyrate;
+
+    rsp_return = query_dirty_rate(who);
+    g_assert(rsp_return);
+
+    status = qdict_get_str(rsp_return, "status");
+    g_assert(status);
+    g_assert_cmpstr(status, ==, "measured");
+
+    rates = qdict_get_qlist(rsp_return, "vcpu-dirty-rate");
+    g_assert(rates && !qlist_empty(rates));
+
+    entry = qlist_first(rates);
+    g_assert(entry);
+
+    rate = qobject_to(QDict, qlist_entry_obj(entry));
+    g_assert(rate);
+
+    dirtyrate = qdict_get_try_int(rate, "dirty-rate", -1);
+
+    qobject_unref(rsp_return);
+    return dirtyrate;
+}
+
+static int64_t get_limit_rate(QTestState *who)
+{
+    QDict *rsp_return;
+    QList *rates;
+    const QListEntry *entry;
+    QDict *rate;
+    int64_t dirtyrate;
+
+    rsp_return = query_vcpu_dirty_limit(who);
+    g_assert(rsp_return);
+
+    rates = qdict_get_qlist(rsp_return, "return");
+    g_assert(rates && !qlist_empty(rates));
+
+    entry = qlist_first(rates);
+    g_assert(entry);
+
+    rate = qobject_to(QDict, qlist_entry_obj(entry));
+    g_assert(rate);
+
+    dirtyrate = qdict_get_try_int(rate, "limit-rate", -1);
+
+    qobject_unref(rsp_return);
+    return dirtyrate;
+}
+
+static QTestState *dirtylimit_start_vm(void)
+{
+    QTestState *vm = NULL;
+    g_autofree gchar *cmd = NULL;
+    const char *bootpath;
+
+    bootpath = bootfile_create(qtest_get_arch(), tmpfs, false);
+    cmd = g_strdup_printf("-accel kvm,dirty-ring-size=4096 "
+                          "-name dirtylimit-test,debug-threads=on "
+                          "-m 150M -smp 1 "
+                          "-serial file:%s/vm_serial "
+                          "-drive file=%s,format=raw ",
+                          tmpfs, bootpath);
+
+    vm = qtest_init(cmd);
+    return vm;
+}
+
+static void dirtylimit_stop_vm(QTestState *vm)
+{
+    g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, "vm_serial");
+
+    qtest_quit(vm);
+    unlink(path);
+}
+
+static void test_vcpu_dirty_limit(void)
+{
+    QTestState *vm;
+    int64_t origin_rate;
+    int64_t quota_rate;
+    int64_t rate ;
+    int max_try_count = 20;
+    int hit = 0;
+
+    /* Start vm for vcpu dirtylimit test */
+    vm = dirtylimit_start_vm();
+
+    /* Wait for the first serial output from the vm*/
+    wait_for_serial("vm_serial");
+
+    /* Do dirtyrate measurement with calc time equals 1s */
+    calc_dirty_rate(vm, 1);
+
+    /* Sleep calc time and wait for calc dirtyrate complete */
+    wait_for_calc_dirtyrate_complete(vm, 1);
+
+    /* Query original dirty page rate */
+    origin_rate = get_dirty_rate(vm);
+
+    /* VM booted from bootsect should dirty memory steadily */
+    assert(origin_rate != 0);
+
+    /* Setup quota dirty page rate at half of origin */
+    quota_rate = origin_rate / 2;
+
+    /* Set dirtylimit */
+    dirtylimit_set_all(vm, quota_rate);
+
+    /*
+     * Check if set-vcpu-dirty-limit and query-vcpu-dirty-limit
+     * works literally
+     */
+    g_assert_cmpint(quota_rate, ==, get_limit_rate(vm));
+
+    /* Sleep a bit to check if it take effect */
+    usleep(2000000);
+
+    /*
+     * Check if dirtylimit take effect realistically, set the
+     * timeout with 20 s(max_try_count * 1s), if dirtylimit
+     * doesn't take effect, fail test.
+     */
+    while (--max_try_count) {
+        calc_dirty_rate(vm, 1);
+        wait_for_calc_dirtyrate_complete(vm, 1);
+        rate = get_dirty_rate(vm);
+
+        /*
+         * Assume hitting if current rate is less
+         * than quota rate (within accepting error)
+         */
+        if (rate < (quota_rate + DIRTYLIMIT_TOLERANCE_RANGE)) {
+            hit = 1;
+            break;
+        }
+    }
+
+    g_assert_cmpint(hit, ==, 1);
+
+    hit = 0;
+    max_try_count = 20;
+
+    /* Check if dirtylimit cancellation take effect */
+    cancel_vcpu_dirty_limit(vm);
+    while (--max_try_count) {
+        calc_dirty_rate(vm, 1);
+        wait_for_calc_dirtyrate_complete(vm, 1);
+        rate = get_dirty_rate(vm);
+
+        /*
+         * Assume dirtylimit be canceled if current rate is
+         * greater than quota rate (within accepting error)
+         */
+        if (rate > (quota_rate + DIRTYLIMIT_TOLERANCE_RANGE)) {
+            hit = 1;
+            break;
+        }
+    }
+
+    g_assert_cmpint(hit, ==, 1);
+    dirtylimit_stop_vm(vm);
+}
+
+static void migrate_dirty_limit_wait_showup(QTestState *from,
+                                            const int64_t period,
+                                            const int64_t value)
+{
+    /* Enable dirty limit capability */
+    migrate_set_capability(from, "dirty-limit", true);
+
+    /* Set dirty limit parameters */
+    migrate_set_parameter_int(from, "x-vcpu-dirty-limit-period", period);
+    migrate_set_parameter_int(from, "vcpu-dirty-limit", value);
+
+    /* Make sure migrate can't converge */
+    migrate_ensure_non_converge(from);
+
+    /* To check limit rate after precopy */
+    migrate_set_capability(from, "pause-before-switchover", true);
+
+    /* Wait for the serial output from the source */
+    wait_for_serial("src_serial");
+}
+
+/*
+ * This test does:
+ *  source                          destination
+ *  start vm
+ *                                  start incoming vm
+ *  migrate
+ *  wait dirty limit to begin
+ *  cancel migrate
+ *  cancellation check
+ *                                  restart incoming vm
+ *  migrate
+ *  wait dirty limit to begin
+ *  wait pre-switchover event
+ *  convergence condition check
+ *
+ * And see if dirty limit migration works correctly.
+ * This test case involves many passes, so it runs in slow mode only.
+ */
+static void test_dirty_limit(void)
+{
+    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    QTestState *from, *to;
+    int64_t remaining;
+    uint64_t throttle_us_per_full;
+    /*
+     * We want the test to be stable and as fast as possible.
+     * E.g., with 1Gb/s bandwidth migration may pass without dirty limit,
+     * so we need to decrease a bandwidth.
+     */
+    const int64_t dirtylimit_period = 1000, dirtylimit_value = 50;
+    const int64_t max_bandwidth = 400000000; /* ~400Mb/s */
+    const int64_t downtime_limit = 250; /* 250ms */
+    /*
+     * We migrate through unix-socket (> 500Mb/s).
+     * Thus, expected migration speed ~= bandwidth limit (< 500Mb/s).
+     * So, we can predict expected_threshold
+     */
+    const int64_t expected_threshold = max_bandwidth * downtime_limit / 1000;
+    int max_try_count = 10;
+    MigrateCommon args = {
+        .start = {
+            .hide_stderr = true,
+            .use_dirty_ring = true,
+        },
+        .listen_uri = uri,
+        .connect_uri = uri,
+    };
+
+    /* Start src, dst vm */
+    if (migrate_start(&from, &to, args.listen_uri, &args.start)) {
+        return;
+    }
+
+    /* Prepare for dirty limit migration and wait src vm show up */
+    migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
+
+    /* Start migrate */
+    migrate_qmp(from, to, args.connect_uri, NULL, "{}");
+
+    /* Wait for dirty limit throttle begin */
+    throttle_us_per_full = 0;
+    while (throttle_us_per_full == 0) {
+        throttle_us_per_full =
+            read_migrate_property_int(from,
+                                      "dirty-limit-throttle-time-per-round");
+        usleep(100);
+        g_assert_false(get_src()->stop_seen);
+    }
+
+    /* Now cancel migrate and wait for dirty limit throttle switch off */
+    migrate_cancel(from);
+    wait_for_migration_status(from, "cancelled", NULL);
+
+    /* Check if dirty limit throttle switched off, set timeout 1ms */
+    do {
+        throttle_us_per_full =
+            read_migrate_property_int(from,
+                                      "dirty-limit-throttle-time-per-round");
+        usleep(100);
+        g_assert_false(get_src()->stop_seen);
+    } while (throttle_us_per_full != 0 && --max_try_count);
+
+    /* Assert dirty limit is not in service */
+    g_assert_cmpint(throttle_us_per_full, ==, 0);
+
+    args = (MigrateCommon) {
+        .start = {
+            .only_target = true,
+            .use_dirty_ring = true,
+        },
+        .listen_uri = uri,
+        .connect_uri = uri,
+    };
+
+    /* Restart dst vm, src vm already show up so we needn't wait anymore */
+    if (migrate_start(&from, &to, args.listen_uri, &args.start)) {
+        return;
+    }
+
+    /* Start migrate */
+    migrate_qmp(from, to, args.connect_uri, NULL, "{}");
+
+    /* Wait for dirty limit throttle begin */
+    throttle_us_per_full = 0;
+    while (throttle_us_per_full == 0) {
+        throttle_us_per_full =
+            read_migrate_property_int(from,
+                                      "dirty-limit-throttle-time-per-round");
+        usleep(100);
+        g_assert_false(get_src()->stop_seen);
+    }
+
+    /*
+     * The dirty limit rate should equals the return value of
+     * query-vcpu-dirty-limit if dirty limit cap set
+     */
+    g_assert_cmpint(dirtylimit_value, ==, get_limit_rate(from));
+
+    /* Now, we have tested if dirty limit works, let it converge */
+    migrate_set_parameter_int(from, "downtime-limit", downtime_limit);
+    migrate_set_parameter_int(from, "max-bandwidth", max_bandwidth);
+
+    /*
+     * Wait for pre-switchover status to check if migration
+     * satisfy the convergence condition
+     */
+    wait_for_migration_status(from, "pre-switchover", NULL);
+
+    remaining = read_ram_property_int(from, "remaining");
+    g_assert_cmpint(remaining, <,
+                    (expected_threshold + expected_threshold / 100));
+
+    migrate_continue(from, "pre-switchover");
+
+    qtest_qmp_eventwait(to, "RESUME");
+
+    wait_for_serial("dest_serial");
+    wait_for_migration_complete(from);
+
+    migrate_end(from, to, true);
+}
+
+void migration_test_add_precopy(MigrationTestEnv *env)
+{
+    tmpfs = env->tmpfs;
+
+    if (env->is_x86) {
+        migration_test_add("/migration/precopy/unix/suspend/live",
+                           test_precopy_unix_suspend_live);
+        migration_test_add("/migration/precopy/unix/suspend/notlive",
+                           test_precopy_unix_suspend_notlive);
+    }
+
+    migration_test_add("/migration/precopy/unix/plain",
+                       test_precopy_unix_plain);
+
+    migration_test_add("/migration/precopy/tcp/plain", test_precopy_tcp_plain);
+
+    migration_test_add("/migration/precopy/tcp/plain/switchover-ack",
+                       test_precopy_tcp_switchover_ack);
+
+#ifndef _WIN32
+    migration_test_add("/migration/precopy/fd/tcp",
+                       test_precopy_fd_socket);
+    migration_test_add("/migration/precopy/fd/file",
+                       test_precopy_fd_file);
+#endif
+
+    /*
+     * See explanation why this test is slow on function definition
+     */
+    if (g_test_slow()) {
+        migration_test_add("/migration/auto_converge",
+                           test_auto_converge);
+        if (g_str_equal(env->arch, "x86_64") &&
+            env->has_kvm && env->has_dirty_ring) {
+            migration_test_add("/dirty_limit",
+                               test_dirty_limit);
+        }
+    }
+    migration_test_add("/migration/multifd/tcp/uri/plain/none",
+                       test_multifd_tcp_uri_none);
+    migration_test_add("/migration/multifd/tcp/channels/plain/none",
+                       test_multifd_tcp_channels_none);
+    migration_test_add("/migration/multifd/tcp/plain/zero-page/legacy",
+                       test_multifd_tcp_zero_page_legacy);
+    migration_test_add("/migration/multifd/tcp/plain/zero-page/none",
+                       test_multifd_tcp_no_zero_page);
+    migration_test_add("/migration/multifd/tcp/plain/cancel",
+                       test_multifd_tcp_cancel);
+    if (g_str_equal(env->arch, "x86_64")
+        && env->has_kvm && env->has_dirty_ring) {
+
+        migration_test_add("/migration/dirty_ring",
+                           test_precopy_unix_dirty_ring);
+        if (qtest_has_machine("pc") && g_test_slow()) {
+            migration_test_add("/migration/vcpu_dirty_limit",
+                               test_vcpu_dirty_limit);
+        }
+    }
+}
diff --git a/tests/qtest/migration/test-framework.h b/tests/qtest/migration/test-framework.h
index 59f9da18ed..4571326028 100644
--- a/tests/qtest/migration/test-framework.h
+++ b/tests/qtest/migration/test-framework.h
@@ -221,5 +221,6 @@ static inline void migration_test_add_tls(MigrationTestEnv *env) {};
 void migration_test_add_compression(MigrationTestEnv *env);
 void migration_test_add_postcopy(MigrationTestEnv *env);
 void migration_test_add_file(MigrationTestEnv *env);
+void migration_test_add_precopy(MigrationTestEnv *env);
 
 #endif /* TEST_FRAMEWORK_H */
-- 
2.35.3


