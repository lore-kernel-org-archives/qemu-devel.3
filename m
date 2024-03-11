Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BB1C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjnhV-0001Sf-J3; Mon, 11 Mar 2024 18:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngk-0000gm-4t
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngh-000447-L5
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=My+6bHty8prCf1V92v4bay7C2hPg69ejSYnm4kkNJ50=;
 b=DbI9kwObc0wS6UiRwfEPd4wl3qUQnnzuPwGUKeR/LDtXUlPu80n5DsLbgfH4tFzPo0ce4m
 5hNP9+4As5ns4giuFeFjdRXEpYI9ateJujn9lXeFvKReYsEv6HaDpbNtYtMu0YlkTCntqf
 CMsHDLKYFKjuVM5BAkmNctgrMMRGO8o=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-BHY_1c6QNnSM13GRgehFwA-1; Mon, 11 Mar 2024 17:59:59 -0400
X-MC-Unique: BHY_1c6QNnSM13GRgehFwA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-690ca03e758so5295996d6.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 14:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194398; x=1710799198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=My+6bHty8prCf1V92v4bay7C2hPg69ejSYnm4kkNJ50=;
 b=gKi+OUY2ZlftVUhmzQNrzUTRH5z5z10WOaP69NKXPDYFy3zu0LTHgbjM4hjzLEzq5W
 uyUYsURZHdHQeCrHNuMdNCTNXU7b8xbyU4QKZPM3DnxSGiCl5LldsRYNGFYZujz4NVZw
 j0AZ3xLeKX62yOY4G9xaCDTkOPYiqYEtIsLsFiqX2we+cNqJ5+E6TSbYOFAgNgxmJFAj
 1VtYk1tB/saPtSD1+VSEQocUnpjjC9zBhAK1yqa5pqkq0EXpQ04shMq6wbUqgG58gN0T
 a3n15jURqkJUxwQmJ2FXZjvgQJI6TEy73AVZzXqGRYUnB9v7Q/6N5PHtEszjp/Bqop2B
 qxVw==
X-Gm-Message-State: AOJu0Yx05YTuXGq4msgdRijq8fXpvcdVo44IDu+1MCVoi1NUQbmJO5Oc
 laPJ7ysXMY5VJh55yOzyxZYv3lXryE7f5xpwQliqTHzgs73v8f/NFhrdipFDPHjH3ytGTlw4aWQ
 lHkwJVeXjPfQxK0Yxkb9btmRFa46swoIYSUvBJrC90qI1lgSJnM5V2A233PmqFd5oJMvGIoDR88
 HBHb9VFUFsAkM7QOKibnw9epJWQXwWEzF0RA==
X-Received: by 2002:a05:6214:1743:b0:690:27a:e6 with SMTP id
 dc3-20020a056214174300b00690027a00e6mr121707qvb.5.1710194397858; 
 Mon, 11 Mar 2024 14:59:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0huibPPrn6O+kiT2A5mcPgGGW7Whb6o71OmfewDwGL68vUJ7Oz6hHhOZOxsAWP3Z3efhtSg==
X-Received: by 2002:a05:6214:1743:b0:690:27a:e6 with SMTP id
 dc3-20020a056214174300b00690027a00e6mr121685qvb.5.1710194397421; 
 Mon, 11 Mar 2024 14:59:57 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.14.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 14:59:56 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 20/34] migration: export migration_is_running
Date: Mon, 11 Mar 2024 17:59:11 -0400
Message-ID: <20240311215925.40618-21-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311215925.40618-1-peterx@redhat.com>
References: <20240311215925.40618-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Delete the MigrationState parameter from migration_is_running and move
it to the public API in misc.h.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Link: https://lore.kernel.org/r/1710179338-294359-5-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h   |  1 +
 migration/migration.h      |  2 --
 migration/migration.c      | 10 ++++++----
 migration/options.c        |  4 ++--
 migration/savevm.c         |  2 +-
 system/dirtylimit.c        |  2 +-
 target/riscv/kvm/kvm-cpu.c |  4 ++--
 7 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index e1f1bf853e..7526977de6 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -106,6 +106,7 @@ int migration_call_notifiers(MigrationState *s, MigrationEventType type,
 bool migration_in_setup(MigrationState *);
 bool migration_has_finished(MigrationState *);
 bool migration_has_failed(MigrationState *);
+bool migration_is_running(void);
 /* ...and after the device transmission */
 /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
 bool migration_in_incoming_postcopy(void);
diff --git a/migration/migration.h b/migration/migration.h
index 736460aa8b..e4983db9c9 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -479,8 +479,6 @@ bool migrate_has_error(MigrationState *s);
 
 void migrate_fd_connect(MigrationState *s, Error *error_in);
 
-bool migration_is_running(int state);
-
 int migrate_init(MigrationState *s, Error **errp);
 bool migration_is_blocked(Error **errp);
 /* True if outgoing migration has entered postcopy phase */
diff --git a/migration/migration.c b/migration/migration.c
index 17859cbaee..546ba86c63 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1103,9 +1103,11 @@ bool migration_is_setup_or_active(void)
     }
 }
 
-bool migration_is_running(int state)
+bool migration_is_running(void)
 {
-    switch (state) {
+    MigrationState *s = current_migration;
+
+    switch (s->state) {
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
@@ -1477,7 +1479,7 @@ static void migrate_fd_cancel(MigrationState *s)
 
     do {
         old_state = s->state;
-        if (!migration_is_running(old_state)) {
+        if (!migration_is_running()) {
             break;
         }
         /* If the migration is paused, kick it out of the pause */
@@ -1962,7 +1964,7 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
         return true;
     }
 
-    if (migration_is_running(s->state)) {
+    if (migration_is_running()) {
         error_setg(errp, QERR_MIGRATION_ACTIVE);
         return false;
     }
diff --git a/migration/options.c b/migration/options.c
index 40eb930940..642cfb00a3 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -681,7 +681,7 @@ bool migrate_cap_set(int cap, bool value, Error **errp)
     MigrationState *s = migrate_get_current();
     bool new_caps[MIGRATION_CAPABILITY__MAX];
 
-    if (migration_is_running(s->state)) {
+    if (migration_is_running()) {
         error_setg(errp, QERR_MIGRATION_ACTIVE);
         return false;
     }
@@ -725,7 +725,7 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
     MigrationCapabilityStatusList *cap;
     bool new_caps[MIGRATION_CAPABILITY__MAX];
 
-    if (migration_is_running(s->state) || migration_in_colo_state()) {
+    if (migration_is_running() || migration_in_colo_state()) {
         error_setg(errp, QERR_MIGRATION_ACTIVE);
         return;
     }
diff --git a/migration/savevm.c b/migration/savevm.c
index 76b57a9888..388d7af7cd 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1706,7 +1706,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
     MigrationState *ms = migrate_get_current();
     MigrationStatus status;
 
-    if (migration_is_running(ms->state)) {
+    if (migration_is_running()) {
         error_setg(errp, QERR_MIGRATION_ACTIVE);
         return -EINVAL;
     }
diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index 051e0311c1..1622bb7426 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -451,7 +451,7 @@ static bool dirtylimit_is_allowed(void)
 {
     MigrationState *ms = migrate_get_current();
 
-    if (migration_is_running(ms->state) &&
+    if (migration_is_running() &&
         (!qemu_thread_is_self(&ms->thread)) &&
         migrate_dirty_limit() &&
         dirtylimit_in_service()) {
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index c7afdb1e81..cda7d78a77 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -44,7 +44,7 @@
 #include "kvm_riscv.h"
 #include "sbi_ecall_interface.h"
 #include "chardev/char-fe.h"
-#include "migration/migration.h"
+#include "migration/misc.h"
 #include "sysemu/runstate.h"
 #include "hw/riscv/numa.h"
 
@@ -729,7 +729,7 @@ static void kvm_riscv_put_regs_timer(CPUState *cs)
      * frequency. Therefore, we should check whether they are the same here
      * during the migration.
      */
-    if (migration_is_running(migrate_get_current()->state)) {
+    if (migration_is_running()) {
         KVM_RISCV_GET_TIMER(cs, frequency, reg);
         if (reg != env->kvm_timer_frequency) {
             error_report("Dst Hosts timer frequency != Src Hosts");
-- 
2.44.0


