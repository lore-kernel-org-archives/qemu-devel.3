Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92457ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfLM-0001la-N8; Mon, 09 Sep 2024 10:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snfLK-0001eP-S4
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:26:14 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snfLH-0004UB-Bl
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:26:13 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5dc93fa5639so2879682eaf.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 07:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1725891970; x=1726496770;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aPNIJP+CkLZPeSwpwgFasxHEV3wc4ZaUYexML1Q2BSA=;
 b=nndygecnZpNB50Rj95YihLhkJ2yXjVZ+8WGP5YiXQQdM3pDmDvvtmfgywwMWhuSZMf
 ynyKMnCB538AaxYm9Sf03dThai1/JDdBRgdwaRJwmFQ+fZk232aJtmtoleojia2JprJs
 xiuK7x8a5VStcWdWOfTaxRJdyHpUGxjEWCyUTAnk5Y4qQuhB/pw/Le8vkE4ZFmGxLMMk
 mszRS63Z3ONFeLHUBgwPKJE59BJrANsYgIIRhT1RF5T4rADZzgAZNW9nzpgiJ3YsKkeX
 gXE4E0oUvAAY3HoPpfgrMgZlzuugG+/DYUpVWykjg87eXgN1rbZKiHbdAUUnSlc0EuuU
 X1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725891970; x=1726496770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aPNIJP+CkLZPeSwpwgFasxHEV3wc4ZaUYexML1Q2BSA=;
 b=veDnLt1iQsu5gjfL9f3sTqlO1d1d0RlLKmAKYbO6iCGQeLDLE5RU/E3cievCdRXkoD
 2SZ0uGCgN9MPl1KF1Blj2y5BNSlzf7sMrsLClO0mQmnDZSoOnltiSgk5PD8bM4wE19Hi
 lIVkjJVr5V6U2BlEBwB31ISPuJQux2BWTlxDPqUR0vT3AatN61MFQlcjdIdAvxMf1wo4
 M2dAyFmTgBnmA2MSQ064FhwDHbEvrSBTDYxBoBcvhNbKrq9ImrmgcjTm+i6hXDODdX7Z
 VXImNw8z6kv2ib+wTAXOaegmk6MxQwi84FXMdjBH4GFTnvx1x5RpykvfWiMRrPbCs0JV
 oczw==
X-Gm-Message-State: AOJu0YzoCFR/7HgN+J982+s+TAys+gah3H0I1GLKNhxi6yv51bbXAO3N
 9jaBimfHplnI2LaTyr8rZd9/bw2mdvQE0km8FxhiuKtprO1OCYSB5M1YEKr7VbrfhMTv9OkFo4/
 yicK8Sg==
X-Google-Smtp-Source: AGHT+IEkrl+X9ifbamlulLDf67X9wSQX0DpcdQ4pAKb5XgSdoM7LmyAxtVILMUIEMoR/Bg7JbPwL+w==
X-Received: by 2002:a05:6870:961a:b0:270:1295:af54 with SMTP id
 586e51a60fabf-27b82ee80a9mr13207260fac.28.1725891969248; 
 Mon, 09 Sep 2024 07:26:09 -0700 (PDT)
Received: from localhost.localdomain ([118.114.94.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-718e58b2a88sm3561164b3a.46.2024.09.09.07.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 07:26:08 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH RESEND RFC 05/10] migration: Introduce util functions for
 periodic CPU throttle
Date: Mon,  9 Sep 2024 22:25:38 +0800
Message-Id: <26d4e848d67b14ebeb9a3e0667688056a65df4b4.1725891841.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1725891841.git.yong.huang@smartx.com>
References: <cover.1725891841.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=yong.huang@smartx.com; helo=mail-oo1-xc2c.google.com
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

Provide useful utilities to manage the periodic_throttle_thread's
lifespan. Additionally, to set up sync mode, provide
periodic_throttle_setup.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 migration/ram.c        | 98 +++++++++++++++++++++++++++++++++++++++++-
 migration/ram.h        |  4 ++
 migration/trace-events |  3 ++
 3 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 23471c9e5a..d9d8ed0fda 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -416,6 +416,10 @@ struct RAMState {
      * RAM migration.
      */
     unsigned int postcopy_bmap_sync_requested;
+
+    /* Periodic throttle information */
+    bool throttle_running;
+    QemuThread throttle_thread;
 };
 typedef struct RAMState RAMState;
 
@@ -1075,7 +1079,13 @@ static void migration_bitmap_sync(RAMState *rs,
     RAMBlock *block;
     int64_t end_time;
 
-    if (!periodic) {
+    if (periodic) {
+        /* Be careful that we don't synchronize too often */
+        int64_t curr_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+        if (curr_time < rs->time_last_bitmap_sync + 1000) {
+            return;
+        }
+    } else {
         stat64_add(&mig_stats.iteration_count, 1);
     }
 
@@ -1121,6 +1131,92 @@ static void migration_bitmap_sync(RAMState *rs,
     }
 }
 
+static void *periodic_throttle_thread(void *opaque)
+{
+    RAMState *rs = opaque;
+    bool skip_sleep = false;
+    int sleep_duration = migrate_periodic_throttle_interval();
+
+    rcu_register_thread();
+
+    while (qatomic_read(&rs->throttle_running)) {
+        int64_t curr_time;
+        /*
+         * The first iteration copies all memory anyhow and has no
+         * effect on guest performance, therefore omit it to avoid
+         * paying extra for the sync penalty.
+         */
+        if (stat64_get(&mig_stats.iteration_count) <= 1) {
+            continue;
+        }
+
+        if (!skip_sleep) {
+            sleep(sleep_duration);
+        }
+
+        /* Be careful that we don't synchronize too often */
+        curr_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+        if (curr_time > rs->time_last_bitmap_sync + 1000) {
+            bql_lock();
+            trace_migration_periodic_throttle();
+            WITH_RCU_READ_LOCK_GUARD() {
+                migration_bitmap_sync(rs, false, true);
+            }
+            bql_unlock();
+            skip_sleep = false;
+        } else {
+            skip_sleep = true;
+        }
+    }
+
+    rcu_unregister_thread();
+
+    return NULL;
+}
+
+void periodic_throttle_start(void)
+{
+    RAMState *rs = ram_state;
+
+    if (!rs) {
+        return;
+    }
+
+    if (qatomic_read(&rs->throttle_running)) {
+        return;
+    }
+
+    trace_migration_periodic_throttle_start();
+
+    qatomic_set(&rs->throttle_running, 1);
+    qemu_thread_create(&rs->throttle_thread,
+                       NULL, periodic_throttle_thread,
+                       rs, QEMU_THREAD_JOINABLE);
+}
+
+void periodic_throttle_stop(void)
+{
+    RAMState *rs = ram_state;
+
+    if (!rs) {
+        return;
+    }
+
+    if (!qatomic_read(&rs->throttle_running)) {
+        return;
+    }
+
+    trace_migration_periodic_throttle_stop();
+
+    qatomic_set(&rs->throttle_running, 0);
+    qemu_thread_join(&rs->throttle_thread);
+}
+
+void periodic_throttle_setup(bool enable)
+{
+    sync_mode = enable ? RAMBLOCK_SYN_MODERN : RAMBLOCK_SYN_LEGACY;
+}
+
 static void migration_bitmap_sync_precopy(RAMState *rs, bool last_stage)
 {
     Error *local_err = NULL;
diff --git a/migration/ram.h b/migration/ram.h
index bc0318b834..f7c7b2e7ad 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -93,4 +93,8 @@ void ram_write_tracking_prepare(void);
 int ram_write_tracking_start(void);
 void ram_write_tracking_stop(void);
 
+/* Periodic throttle */
+void periodic_throttle_start(void);
+void periodic_throttle_stop(void);
+void periodic_throttle_setup(bool enable);
 #endif
diff --git a/migration/trace-events b/migration/trace-events
index c65902f042..5b9db57c8f 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -95,6 +95,9 @@ get_queued_page_not_dirty(const char *block_name, uint64_t tmp_offset, unsigned
 migration_bitmap_sync_start(void) ""
 migration_bitmap_sync_end(uint64_t dirty_pages) "dirty_pages %" PRIu64
 migration_bitmap_clear_dirty(char *str, uint64_t start, uint64_t size, unsigned long page) "rb %s start 0x%"PRIx64" size 0x%"PRIx64" page 0x%lx"
+migration_periodic_throttle(void) ""
+migration_periodic_throttle_start(void) ""
+migration_periodic_throttle_stop(void) ""
 migration_throttle(void) ""
 migration_dirty_limit_guest(int64_t dirtyrate) "guest dirty page rate limit %" PRIi64 " MB/s"
 ram_discard_range(const char *rbname, uint64_t start, size_t len) "%s: start: %" PRIx64 " %zx"
-- 
2.39.1


