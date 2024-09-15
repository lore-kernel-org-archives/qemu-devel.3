Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764ABC3ABA1
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 16:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sproM-00031d-5N; Sun, 15 Sep 2024 12:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sproJ-0002sV-Pf
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 12:09:15 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sproH-0006P3-QN
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 12:09:15 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-717934728adso2743027b3a.2
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 09:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1726416552; x=1727021352;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i5g6CmFxoxPUE5mXYvXg3z4LzjNCvav86tcPdIXvVHo=;
 b=gqI1n1AZXkYScqS5zInpAyXQysUlph4zpIOySUl9eKF4gpA2k2n13eGQHtQpeKVjOy
 /gEQG2b9CK0+In8FuACUwh+VrxcJQkMNV1n1eeKVlgIpBA9uhbxfAdx6pqIWn8bT6xNl
 MqCYMGMe5fTYUftOecfBdBY21Uax9nVgTIDBHdvsystQ7qZhgk33BrDZqrbReYzPXppu
 tKcASraLofywuGX3//56iZWAI8ovN2b00Jwnzfm6AYKtmHVfgEzo1I+DN43nkw/AaODJ
 c88ZAoZ+5hyaFGasb4NKBqSFZnD8eYzQZaP0ARb7S3jtLo0Xocg0evVQvFluc3Mh8V2l
 ePww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726416552; x=1727021352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i5g6CmFxoxPUE5mXYvXg3z4LzjNCvav86tcPdIXvVHo=;
 b=cEPDngfRqlOL/2AnoLQJccxgLwMqqn7xnrL7Uo0s5R4mq0yIr6W+ZnmB7WTWm6JPKY
 UbGRlRj522d4LYLc27NGfcowlTbF76d5sSCXciF+qp/nej0kRyt3b6kIjv6CDNcDpjcD
 QElaSB7ft/U0rZwDLdUe3cqOHI4W0SUlM24NYCi/3sbUmXvTmhLt2tADaPTJUDWtUFn+
 gsOOy8Jz7jkmQAaei2vyqpwFFmbZbQasJzZx3ltZgQiAPy0NTECqHBbD39BzwxeF+rDX
 GHx6o4wUZodRoYU7u0vtfx5yh1pYAMkLdKRuyd261ZPIBctThHza+oxlNiu1EJAdSZ07
 4CNg==
X-Gm-Message-State: AOJu0Yxc4zOLLNOPAnDrJEKdN2V4KmgO/9Hqh40RzQPprCZLc61ZhMdU
 Vqp4KMLTS7dwcFdEPaO+ZcZF4+6MFQ70QVKtQFJA3XW9myUGCJGdWwOY7gPsZZYw4fJ8p7KAPuF
 RLZx+AA==
X-Google-Smtp-Source: AGHT+IGOubS0qQwcM949ApoEklLQVYHXrT33G57vSY5G+WB3aG7GvQzHiNgrf0Yw0nHjjfj27waYrA==
X-Received: by 2002:a05:6a00:2352:b0:714:3831:ec91 with SMTP id
 d2e1a72fcca58-71926213e47mr18367228b3a.25.1726416551092; 
 Sun, 15 Sep 2024 09:09:11 -0700 (PDT)
Received: from localhost.localdomain ([118.114.94.247])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71944bb5967sm2344795b3a.182.2024.09.15.09.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2024 09:09:10 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v1 4/7] migration: Implment background sync watcher
Date: Mon, 16 Sep 2024 00:08:47 +0800
Message-Id: <4c105e23be9a2d1a6be71e6abf9c938a4d091dfc.1726390099.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1726390098.git.yong.huang@smartx.com>
References: <cover.1726390098.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x42b.google.com
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

The background sync watcher is used to detect that if the
iteration lasts a long time, if so, trigger the background
sync.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 migration/ram.c        | 110 +++++++++++++++++++++++++++++++++++++++++
 migration/ram.h        |   3 ++
 migration/trace-events |   3 ++
 3 files changed, 116 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index ca5a1b5f16..799eaa0382 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -416,6 +416,11 @@ struct RAMState {
      * RAM migration.
      */
     unsigned int postcopy_bmap_sync_requested;
+
+    /* Background throttle information */
+    bool background_sync_running;
+    QemuThread background_sync_thread;
+    QemuSemaphore quit_sem;
 };
 typedef struct RAMState RAMState;
 
@@ -1125,6 +1130,111 @@ static void migration_bitmap_sync(RAMState *rs,
     }
 }
 
+/*
+ * Iteration lasting more than five seconds is undesirable;
+ * launch a background dirty bitmap sync.
+ */
+#define MIGRATION_MAX_ITERATION_DURATION  5
+
+static void *migration_background_sync_watcher(void *opaque)
+{
+    RAMState *rs = opaque;
+    uint64_t iter_cnt, prev_iter_cnt = 2;
+    bool iter_cnt_unchanged = false;
+    int max_pct = migrate_max_cpu_throttle();
+
+    trace_migration_background_sync_watcher_start();
+    rcu_register_thread();
+
+    while (qatomic_read(&rs->background_sync_running)) {
+        int cur_pct = cpu_throttle_get_percentage();
+        if ((cur_pct == max_pct) || (!migration_is_active())) {
+            break;
+        }
+
+        if (qemu_sem_timedwait(&rs->quit_sem, 1000) == 0) {
+            /* We were woken by background_sync_cleanup, quit */
+            break;
+        }
+
+        /*
+         * The first iteration copies all memory anyhow and has no
+         * effect on guest performance, therefore omit it to avoid
+         * paying extra for the sync penalty.
+         */
+        iter_cnt = stat64_get(&mig_stats.iteration_count);
+        if (iter_cnt <= 1) {
+            continue;
+        }
+
+        iter_cnt_unchanged = (iter_cnt == prev_iter_cnt);
+        prev_iter_cnt = iter_cnt;
+
+        if (iter_cnt_unchanged) {
+            int64_t curr_time, iter_duration;
+
+            curr_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+            iter_duration = curr_time - rs->time_last_bitmap_sync;
+
+            if (iter_duration >
+                    MIGRATION_MAX_ITERATION_DURATION * 1000) {
+                sync_mode = RAMBLOCK_SYN_MODERN;
+                bql_lock();
+                trace_migration_background_sync();
+                WITH_RCU_READ_LOCK_GUARD() {
+                    migration_bitmap_sync(rs, false, true);
+                }
+                bql_unlock();
+            }
+        }
+    }
+
+    qatomic_set(&rs->background_sync_running, 0);
+
+    rcu_unregister_thread();
+    trace_migration_background_sync_watcher_end();
+
+    return NULL;
+}
+
+void migration_background_sync_setup(void)
+{
+    RAMState *rs = ram_state;
+
+    if (!rs) {
+        return;
+    }
+
+    if (qatomic_read(&rs->background_sync_running)) {
+        return;
+    }
+
+    qemu_sem_init(&rs->quit_sem, 0);
+    qatomic_set(&rs->background_sync_running, 1);
+
+    qemu_thread_create(&rs->background_sync_thread,
+                       NULL, migration_background_sync_watcher,
+                       rs, QEMU_THREAD_JOINABLE);
+}
+
+void migration_background_sync_cleanup(void)
+{
+    RAMState *rs = ram_state;
+
+    if (!rs) {
+        return;
+    }
+
+    if (!qatomic_read(&rs->background_sync_running)) {
+        return;
+    }
+
+    qatomic_set(&rs->background_sync_running, 0);
+    qemu_sem_post(&rs->quit_sem);
+    qemu_thread_join(&rs->background_sync_thread);
+    qemu_sem_destroy(&rs->quit_sem);
+}
+
 static void migration_bitmap_sync_precopy(RAMState *rs, bool last_stage)
 {
     Error *local_err = NULL;
diff --git a/migration/ram.h b/migration/ram.h
index bc0318b834..0315d22a66 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -93,4 +93,7 @@ void ram_write_tracking_prepare(void);
 int ram_write_tracking_start(void);
 void ram_write_tracking_stop(void);
 
+/* Migration background sync */
+void migration_background_sync_setup(void);
+void migration_background_sync_cleanup(void);
 #endif
diff --git a/migration/trace-events b/migration/trace-events
index c65902f042..4f95f9fe14 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -92,6 +92,9 @@ qemu_file_fclose(void) ""
 # ram.c
 get_queued_page(const char *block_name, uint64_t tmp_offset, unsigned long page_abs) "%s/0x%" PRIx64 " page_abs=0x%lx"
 get_queued_page_not_dirty(const char *block_name, uint64_t tmp_offset, unsigned long page_abs) "%s/0x%" PRIx64 " page_abs=0x%lx"
+migration_background_sync(void) ""
+migration_background_sync_watcher_start(void) ""
+migration_background_sync_watcher_end(void) ""
 migration_bitmap_sync_start(void) ""
 migration_bitmap_sync_end(uint64_t dirty_pages) "dirty_pages %" PRIu64
 migration_bitmap_clear_dirty(char *str, uint64_t start, uint64_t size, unsigned long page) "rb %s start 0x%"PRIx64" size 0x%"PRIx64" page 0x%lx"
-- 
2.39.1


