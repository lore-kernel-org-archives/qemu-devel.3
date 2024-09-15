Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC2AC3ABA0
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 16:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sproR-0003Dt-Av; Sun, 15 Sep 2024 12:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sproM-00033w-LI
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 12:09:18 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sproL-0006PX-2g
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 12:09:18 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-718e285544fso1966191b3a.1
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 09:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1726416555; x=1727021355;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bQRFeU81jcoENLpfNtd5Au7rCLXiDo8NwDyNJcevB8Q=;
 b=asqfHek8p83xx66MaWOxWub16DpVVGlpBeGKdYOJhyQfUBofwyUueI2FMtzfWB7I8o
 3Q+QEz4jRae5mY5NbR0YgfavKPmRj+GLuO0MJezS6cQ42oNtnfJV0FfPOTj0yZ17Ze8O
 C52tGXnAdwnkfK9sMhsFEAy7cxZWUSWjPLD+7EeWcule9PVjB+qE1jE2uq7OKc0jp9I7
 kJVu9/8OQs5HiCBsYnwMf9hSoBOnPR2F5xEePJR+Rl8hxVVmk16mF4aE3Dl0zWQduAKf
 sYAyy25TBwx8i68/WZYOk0ls86Dexht9x0D4yanI/ELBWVy0/6xBWxXNo+9EBLMONiN3
 jjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726416555; x=1727021355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bQRFeU81jcoENLpfNtd5Au7rCLXiDo8NwDyNJcevB8Q=;
 b=xVfVBBThNPA8OndyotvRrJjK4h6X/NeTfTsEHB/wNU39AqrxtHufdC02ev9LUVJ7ov
 vApwPp0ObOaHvEihFxQKrtxi2mh8UX4tQAF1u03K/QO2TmW093PRRDGaSjCBFa/RVrRN
 h44MXKHvf8v/RQSRD+G8St+XXNwPQHY7ITOscNhy+V70tZndQGOLTPf690ekIM3H1J8h
 8LCdYFtEX6ym2eOkolHv5ffhzpoFeOWZnZNItphmtcZuSyUTVydMtNbmafJKgA0HH8pM
 Sqh6P2wVZ4A1DfFUuit3Tbyf5bCSun1kzWln4GRte2hMIHqMnL2eErfJhQ8bYAvm28j0
 T91A==
X-Gm-Message-State: AOJu0Yz+H61wdDaYsxCkAmM4cHy9juJ/cyxYBmPSvG+Gf+rNu8TPTJ2t
 3FFVcFJ8J5FoRGTULK0KVD3DIUv6XOciC7pRfPSXsKJtO5Wd1SJrvYxVqFltcSq1Ys/dTWuRe3x
 GZmVEDA==
X-Google-Smtp-Source: AGHT+IG0e0TCV+nv2O3GJ2JNvVUMgF7RXhLFswJCVRXgnavSu6kqBOUL+WqWbDn24u846J6GkiPd3A==
X-Received: by 2002:a05:6a00:1ad3:b0:717:88b6:6b1e with SMTP id
 d2e1a72fcca58-71936adf416mr13975811b3a.18.1726416554838; 
 Sun, 15 Sep 2024 09:09:14 -0700 (PDT)
Received: from localhost.localdomain ([118.114.94.247])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71944bb5967sm2344795b3a.182.2024.09.15.09.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2024 09:09:14 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v1 5/7] migration: Support background dirty bitmap sync and
 throttle
Date: Mon, 16 Sep 2024 00:08:48 +0800
Message-Id: <d74bc4ffb073c886bc566e7d771910db844cec1b.1726390099.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1726390098.git.yong.huang@smartx.com>
References: <cover.1726390098.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

When VM is configured with huge memory, the current throttle logic
doesn't look like to scale, because migration_trigger_throttle()
is only called for each iteration, so it won't be invoked for a long
time if one iteration can take a long time.

The background sync and throttle aim to fix the above issue by
synchronizing the remote dirty bitmap and triggering the throttle
once detect that iteration lasts a long time.

This is a trade-off between synchronization overhead and CPU throttle
impact.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 migration/migration.c        | 12 +++++++++++
 tests/qtest/migration-test.c | 39 ++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 055d527ff6..af8b22fa15 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1416,6 +1416,7 @@ static void migrate_fd_cleanup(MigrationState *s)
 
         trace_migrate_fd_cleanup();
         bql_unlock();
+        migration_background_sync_cleanup();
         if (s->migration_thread_running) {
             qemu_thread_join(&s->thread);
             s->migration_thread_running = false;
@@ -3263,6 +3264,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
 
     if ((!pending_size || pending_size < s->threshold_size) && can_switchover) {
         trace_migration_thread_low_pending(pending_size);
+        migration_background_sync_cleanup();
         migration_completion(s);
         return MIG_ITERATE_BREAK;
     }
@@ -3508,6 +3510,16 @@ static void *migration_thread(void *opaque)
     ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
     bql_unlock();
 
+    if (!migrate_dirty_limit()) {
+        /*
+         * Initiate the background sync watcher in order to guarantee
+         * that the CPU throttling acts appropriately. Dirty Limit
+         * doesn't use CPU throttle to make guest down, so ignore that
+         * case.
+         */
+        migration_background_sync_setup();
+    }
+
     qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
                                MIGRATION_STATUS_ACTIVE);
 
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b796a90cad..e0e94d26be 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -281,6 +281,11 @@ static uint64_t get_migration_pass(QTestState *who)
     return read_ram_property_int(who, "iteration-count");
 }
 
+static uint64_t get_dirty_sync_count(QTestState *who)
+{
+    return read_ram_property_int(who, "dirty-sync-count");
+}
+
 static void read_blocktime(QTestState *who)
 {
     QDict *rsp_return;
@@ -468,6 +473,12 @@ static void migrate_ensure_converge(QTestState *who)
     migrate_set_parameter_int(who, "downtime-limit", 30 * 1000);
 }
 
+static void migrate_ensure_iteration_last_long(QTestState *who)
+{
+    /* Set 10Byte/s bandwidth limit to make the iteration last long enough */
+    migrate_set_parameter_int(who, "max-bandwidth", 10);
+}
+
 /*
  * Our goal is to ensure that we run a single full migration
  * iteration, and also dirty memory, ensuring that at least
@@ -2791,6 +2802,10 @@ static void test_migrate_auto_converge(void)
      * so we need to decrease a bandwidth.
      */
     const int64_t init_pct = 5, inc_pct = 25, max_pct = 95;
+    uint64_t prev_iter_cnt = 0, iter_cnt;
+    uint64_t iter_cnt_changes = 0;
+    uint64_t prev_dirty_sync_cnt = 0, dirty_sync_cnt;
+    uint64_t dirty_sync_cnt_changes = 0;
 
     if (test_migrate_start(&from, &to, uri, &args)) {
         return;
@@ -2827,6 +2842,30 @@ static void test_migrate_auto_converge(void)
     } while (true);
     /* The first percentage of throttling should be at least init_pct */
     g_assert_cmpint(percentage, >=, init_pct);
+
+    /* Make sure the iteration take a long time enough */
+    migrate_ensure_iteration_last_long(from);
+
+    /*
+     * End the loop when the dirty sync count or iteration count changes.
+     */
+    while (iter_cnt_changes < 2 && dirty_sync_cnt_changes < 2) {
+        usleep(1000 * 1000);
+        iter_cnt = get_migration_pass(from);
+        iter_cnt_changes += (iter_cnt != prev_iter_cnt);
+        prev_iter_cnt = iter_cnt;
+
+        dirty_sync_cnt = get_dirty_sync_count(from);
+        dirty_sync_cnt_changes += (dirty_sync_cnt != prev_dirty_sync_cnt);
+        prev_dirty_sync_cnt = dirty_sync_cnt;
+    }
+
+    /*
+     * The dirty sync count must have changed because we are in the same
+     * iteration.
+     */
+    g_assert_cmpint(iter_cnt_changes , < , dirty_sync_cnt_changes);
+
     /* Now, when we tested that throttling works, let it converge */
     migrate_ensure_converge(from);
 
-- 
2.39.1


