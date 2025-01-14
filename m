Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97EC2E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 23:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXq2N-0004Bg-G9; Tue, 14 Jan 2025 18:09:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq27-0003qS-B9
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:09:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq25-0004IM-GN
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:09:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736896152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=irKgyuwlTgCopG55dQ+ETYiKtWcHjCzYi9viy9UqP5I=;
 b=W9RY3KorhVghtmo4Xw8+RNrKBJu7+XZ7Y5mPRTQ8bh10H8NcUwqJpwcuBUOwQ7MJXS3ItA
 ZlB2TrBP5ZsI2YZd35cqEAHmKi7G+JwPnNcfmPCxtt6Q1LQ7tV3RgezHRRepeGsH/5EmqZ
 Dyy4IBhDhcrizhjgkVIZ7YiIo7lNIRU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-VpB0c27yPpOt808-YVBATQ-1; Tue, 14 Jan 2025 18:08:06 -0500
X-MC-Unique: VpB0c27yPpOt808-YVBATQ-1
X-Mimecast-MFC-AGG-ID: VpB0c27yPpOt808-YVBATQ
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b6f3b93f5cso59843085a.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 15:08:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736896085; x=1737500885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=irKgyuwlTgCopG55dQ+ETYiKtWcHjCzYi9viy9UqP5I=;
 b=X6UKw5FiwoKwHkGHBPVnZmz94Pq1h0OAWdwb4x1SE21tjRNum55vWOp7g7v6+pV4vP
 uuS2dNTmQNJbStC+BM8F0h1owY5R/7GidOxhSCzJsQ5KhqHn7owZ5XyTMNKhytdasbRv
 /RIQ4YNdYhG33yVtoPzQ+OJdVP19zVIprqPJwoQqRTg3wjZSDDJeE+FQll7ClBeA4SXw
 0pHtQwsTSUft7AZQDaV3amlbRAUELJlu5ML0oZ5SrMoKpaFR0lSDphEHns8vIpeszfbZ
 MUEm4qJz+vJ0vfGWsnTrdPnwkyCKpKe6n/NhzofjV/Z5++j/6LuOKLZ128IQSX0Lm4ev
 Fxsg==
X-Gm-Message-State: AOJu0YyDeQA6cv+wdvqN1R2oeais3dUwOuD9/EA2J1QisaMCbjWDqRyw
 PFEpspTaKBnA/s8iiPAxn+IaS+HaHSybJiyged6C5qb+CLqA9fRFWpMelrHvkjLp3wGrf5no/9/
 zp0OiL4uQAN23CLlyhfbzozpDvo6fpRmqsbn8fACBX0sRNmXdisSR0y7c9kRAsmhrjdtRFw1RId
 k/WylfdjHATclmaOorYNFVZhE0eKmKVeZPRg==
X-Gm-Gg: ASbGnctRVO4lBimVOVnIKAlA8hTTdwUWHP/gxoqK6ur+dMJplnc09ixJcP20Ke/M3/H
 hH+EwNkUUMDM4nGlIoA/LzQBtZNrtwFTJAZUOXfWBU/y3wbuUgRpu5uHItR2r4vHtFkKwQNcVLr
 Rx+xoW/+SaNENtq/UrIJToubAJhFyPzpzf46xOP+cXL9HbO4fck2mvkQ7n9AucUG4a6bFoQB4tr
 HkW/VD+q8j/1LtgjomhnSoni9L+XoDnqABFNtjtq6t/0UzXmSgNdMvBfpivVjXk6tTqjNrXcIzO
 QBU+cOaxYe8aAjpM4UKTfMMp1t/S1Sw7
X-Received: by 2002:ad4:5d68:0:b0:6d8:893b:2a13 with SMTP id
 6a1803df08f44-6e192acacb8mr14123026d6.0.1736896085162; 
 Tue, 14 Jan 2025 15:08:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsMXaZrSKXmWGtmuQ5k0JobhExFbGUbgkJjmQTuJfxe4fV5xRDGJdJhXw52VxqYhCAMd8OuQ==
X-Received: by 2002:ad4:5d68:0:b0:6d8:893b:2a13 with SMTP id
 6a1803df08f44-6e192acacb8mr14122736d6.0.1736896084835; 
 Tue, 14 Jan 2025 15:08:04 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c873cd1b0sm59268971cf.49.2025.01.14.15.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 15:08:03 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 09/16] migration: Drop cached migration state in
 migration_maybe_pause()
Date: Tue, 14 Jan 2025 18:07:39 -0500
Message-ID: <20250114230746.3268797-10-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250114230746.3268797-1-peterx@redhat.com>
References: <20250114230746.3268797-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.794,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

I can't see why we must cache the state now after we avoided possible
CANCEL race: that's the only thing I can think of that can modify the
migration state concurrently with the migration thread itself.  Make all
the state updates to happen always, then we don't need to cache the state
anymore.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 5c688059de..5850c90c9f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -102,9 +102,7 @@ static MigrationIncomingState *current_incoming;
 static GSList *migration_blockers[MIG_MODE__MAX];
 
 static bool migration_object_check(MigrationState *ms, Error **errp);
-static int migration_maybe_pause(MigrationState *s,
-                                 int *current_active_state,
-                                 int new_state);
+static int migration_maybe_pause(MigrationState *s, int new_state);
 static void migrate_fd_cancel(MigrationState *s);
 static bool close_return_path_on_source(MigrationState *s);
 static void migration_completion_end(MigrationState *s);
@@ -2502,7 +2500,6 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     int ret;
     QIOChannelBuffer *bioc;
     QEMUFile *fb;
-    int cur_state = MIGRATION_STATUS_ACTIVE;
 
     /*
      * Now we're 100% sure to switch to postcopy, so JSON writer won't be
@@ -2537,8 +2534,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
         goto fail;
     }
 
-    ret = migration_maybe_pause(ms, &cur_state,
-                                MIGRATION_STATUS_POSTCOPY_ACTIVE);
+    ret = migration_maybe_pause(ms, MIGRATION_STATUS_POSTCOPY_ACTIVE);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "%s: Failed in migration_maybe_pause()",
                          __func__);
@@ -2676,9 +2672,7 @@ fail:
  * migrate_pause_before_switchover called with the BQL locked
  * Returns: 0 on success
  */
-static int migration_maybe_pause(MigrationState *s,
-                                 int *current_active_state,
-                                 int new_state)
+static int migration_maybe_pause(MigrationState *s, int new_state)
 {
     if (!migrate_pause_before_switchover()) {
         return 0;
@@ -2701,21 +2695,19 @@ static int migration_maybe_pause(MigrationState *s,
      * wait for the 'pause_sem' semaphore.
      */
     if (s->state != MIGRATION_STATUS_CANCELLING) {
-        migrate_set_state(&s->state, *current_active_state,
+        migrate_set_state(&s->state, s->state,
                           MIGRATION_STATUS_PRE_SWITCHOVER);
         bql_unlock();
         qemu_sem_wait(&s->pause_sem);
         bql_lock();
         migrate_set_state(&s->state, MIGRATION_STATUS_PRE_SWITCHOVER,
                           new_state);
-        *current_active_state = new_state;
     }
 
     return s->state == new_state ? 0 : -EINVAL;
 }
 
-static int migration_completion_precopy(MigrationState *s,
-                                        int *current_active_state)
+static int migration_completion_precopy(MigrationState *s)
 {
     int ret;
 
@@ -2728,8 +2720,7 @@ static int migration_completion_precopy(MigrationState *s,
         }
     }
 
-    ret = migration_maybe_pause(s, current_active_state,
-                                MIGRATION_STATUS_DEVICE);
+    ret = migration_maybe_pause(s, MIGRATION_STATUS_DEVICE);
     if (ret < 0) {
         goto out_unlock;
     }
@@ -2782,11 +2773,10 @@ static void migration_completion_postcopy(MigrationState *s)
 static void migration_completion(MigrationState *s)
 {
     int ret = 0;
-    int current_active_state = s->state;
     Error *local_err = NULL;
 
     if (s->state == MIGRATION_STATUS_ACTIVE) {
-        ret = migration_completion_precopy(s, &current_active_state);
+        ret = migration_completion_precopy(s);
     } else if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
         migration_completion_postcopy(s);
     } else {
@@ -2826,8 +2816,7 @@ fail:
         error_free(local_err);
     }
 
-    migrate_set_state(&s->state, current_active_state,
-                      MIGRATION_STATUS_FAILED);
+    migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
 }
 
 /**
-- 
2.47.0


