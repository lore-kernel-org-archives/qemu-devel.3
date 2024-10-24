Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0160D10388
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 21:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t45QQ-0005iX-Ek; Thu, 24 Oct 2024 17:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t45QN-0005hR-Kt
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 17:31:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t45QL-0005aF-Tz
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 17:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729805477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bJXamzqrq7AiFagiu9llJXewSi82uD7Ymbaq7adW03I=;
 b=MlqG7o+lyGN0PsuB1WNl4cAgQmJJgVcLXHcBZx7jlIGj84MZLadn0xuawu/1Boj6tCIMy5
 tnoMXg5PwvCKOtivMhM3YwFiToA81vMw1FYQwjXsybYh+sq4zBu7Xudml96x98J7KPAHH+
 /9tS0ApUtMztd77uUStjkp/o0hZFzgo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-o7G2DmmTMo-ADXYSKrWmPw-1; Thu, 24 Oct 2024 17:31:15 -0400
X-MC-Unique: o7G2DmmTMo-ADXYSKrWmPw-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-460b07774a7so21584551cf.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 14:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729805474; x=1730410274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bJXamzqrq7AiFagiu9llJXewSi82uD7Ymbaq7adW03I=;
 b=Kdq4VnNmjgZkXc8WsrLQZEbiKl+UMHYnjN8rXW+XlyuiOu35rPBnbEHvms8SMsWunm
 nwzXm2JpXcjfqW/zvt+bJ5l6gPjjLQQP96INzDi6wCwcMnE03wEAkkxkcJdxY2SJNGwb
 UZ0qq88puM1Jtgwy6NlVwH0gEFwuoNmPpo5KYI5t+xwbH+/qovMPDlIQhj2kJHWQQh6Z
 Z2Onyv2UqQht1gTtsF4D4qfBgQ6gEHQkHvGfo9KN+Y7PdVDuWhbwQacOgdCjeRFly9t1
 eZIi7rM1rnfB3TgJ9JJSocE/nP04weKE3qzWcO8KQA/GyG3mIF+OjbRq9PUwwy2XhHCY
 yt1Q==
X-Gm-Message-State: AOJu0Yy6a6EKnPYDg/r5X+lVdve3ZI7dM1BjqGxBtTOKNradCctoIRGE
 xXU9ST/Lh7vjX83YELZ4QXmxDyj7QTUlw7r4rso6I4yxA/f/kJyCz5yuS4I3+052MpZGRpbqb0k
 AonPZ/J5D7748lnFIAvOYB12MTE047JnSZu5ixDb17IRt/1tZtOaPtnfXd+bCZcdF65oPg9DBrb
 Jtmv+NSd3DqvOC9UFg0qpqBttoxlzpoxU4OA==
X-Received: by 2002:a05:622a:30b:b0:460:9a7c:8dd0 with SMTP id
 d75a77b69052e-46114745ea3mr102531841cf.55.1729805474459; 
 Thu, 24 Oct 2024 14:31:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWRcFG/xreUGKLjkXNCc+1IMxAXwaEE4kuCf0QBvjEHQYqdQt1NC5dwVPkayPhJzgdunfPJg==
X-Received: by 2002:a05:622a:30b:b0:460:9a7c:8dd0 with SMTP id
 d75a77b69052e-46114745ea3mr102531551cf.55.1729805474084; 
 Thu, 24 Oct 2024 14:31:14 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460d3c3a434sm55465091cf.19.2024.10.24.14.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 14:31:13 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v3 8/8] migration: Protect updates to current_migration with a
 mutex
Date: Thu, 24 Oct 2024 17:30:56 -0400
Message-ID: <20241024213056.1395400-9-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241024213056.1395400-1-peterx@redhat.com>
References: <20241024213056.1395400-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Introduce migration_mutex, protecting concurrent updates to
current_migration.

In reality, most of the exported migration functions are safe to access
migration objects on capabilities, etc., e.g. many of the code is invoked
within migration thread via different hooks (e.g., precopy notifier,
vmstate handler hooks, etc.).

So literally the mutex so far only makes sure below two APIs that are prone
to accessing freed current_migration:

        migration_is_running()
        migration_file_set_error()

Then we'll need to take the mutex too when init/free the migration object.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h |  3 +++
 migration/migration.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/migration/migration.h b/migration/migration.h
index 9fa26ab06a..05edcf0c49 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -473,6 +473,9 @@ struct MigrationState {
     bool rdma_migration;
 };
 
+extern QemuMutex migration_mutex;
+#define  QEMU_MIGRATION_LOCK_GUARD()  QEMU_LOCK_GUARD(&migration_mutex)
+
 void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
                        MigrationStatus new_state);
 
diff --git a/migration/migration.c b/migration/migration.c
index 127b01734d..ef044968df 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -97,6 +97,14 @@ enum mig_rp_message_type {
    migrations at once.  For now we don't need to add
    dynamic creation of migration */
 
+/*
+ * Protects current_migration below.  Must be hold when using migration
+ * exported functions unless the caller knows it won't get freed.  For
+ * example, when in the context of migration_thread() it's safe to access
+ * current_migration without the mutex, because the thread holds one extra
+ * refcount of the object, so it literally pins the object in-memory.
+ */
+QemuMutex migration_mutex;
 static MigrationState *current_migration;
 static MigrationIncomingState *current_incoming;
 
@@ -110,6 +118,17 @@ static void migrate_fd_cancel(MigrationState *s);
 static bool close_return_path_on_source(MigrationState *s);
 static void migration_completion_end(MigrationState *s);
 
+/*
+ * This is explicitly done without migration_object_init(), because it may
+ * start to use this lock already when instance_init() of the object.  The
+ * mutex is alive for the whole lifecycle of QEMU, so it's always usable
+ * and never destroyed.
+ */
+static void __attribute__((constructor)) migration_mutex_init(void)
+{
+    qemu_mutex_init(&migration_mutex);
+}
+
 static void migration_downtime_start(MigrationState *s)
 {
     trace_vmstate_downtime_checkpoint("src-downtime-start");
@@ -336,6 +355,14 @@ void migration_shutdown(void)
      * stop the migration using this structure
      */
     migration_cancel(NULL);
+    /*
+     * Release the refcount from the main thread.  It means it can be freed
+     * here if migration thread is not running.
+     *
+     * NOTE: we don't need QEMU_MIGRATION_LOCK_GUARD() on this access
+     * because we're sure there's one refcount.  The lock will be taken in
+     * finalize() if it triggers, so we can't take it here anyway.
+     */
     object_unref(OBJECT(current_migration));
 
     /*
@@ -1118,8 +1145,14 @@ void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value)
 
 bool migration_is_running(void)
 {
+    QEMU_MIGRATION_LOCK_GUARD();
+
     MigrationState *s = current_migration;
 
+    if (!s) {
+        return false;
+    }
+
     switch (s->state) {
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
@@ -3029,8 +3062,14 @@ static MigThrError postcopy_pause(MigrationState *s)
 
 void migration_file_set_error(int ret, Error *err)
 {
+    QEMU_MIGRATION_LOCK_GUARD();
+
     MigrationState *s = current_migration;
 
+    if (!s) {
+        return;
+    }
+
     WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
         if (s->to_dst_file) {
             qemu_file_set_error_obj(s->to_dst_file, ret, err);
@@ -3835,6 +3874,8 @@ static void migration_instance_finalize(Object *obj)
 {
     MigrationState *ms = MIGRATION_OBJ(obj);
 
+    QEMU_MIGRATION_LOCK_GUARD();
+
     qemu_mutex_destroy(&ms->error_mutex);
     qemu_mutex_destroy(&ms->qemu_file_lock);
     qemu_sem_destroy(&ms->wait_unplug_sem);
@@ -3858,6 +3899,8 @@ static void migration_instance_init(Object *obj)
 {
     MigrationState *ms = MIGRATION_OBJ(obj);
 
+    QEMU_MIGRATION_LOCK_GUARD();
+
     /*
      * There can only be one migration object globally. Keep a record of
      * the pointer in current_migration, which will be reset after the
-- 
2.45.0


