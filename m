Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761A6C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjnh3-00010R-4x; Mon, 11 Mar 2024 18:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjnge-0000Yy-LN
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngc-00043N-Ue
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L9tqjm6MQlYl8InOWvUGruPRPvJCqkW54MwUESfEeMw=;
 b=K9CgTU25Q2wdlJSYYNPC8BmVA0QEFDfLI/4TXPPtaXux2DhCMQDAfjtWWgfpct6w21BRcU
 zfkd3CP74EkulcaWIkpOj5hWH26OW963ZEelaL9jHtehuM2IPdIo4yLO0c8DzAGBgvjh30
 3AdVfZpgaYnXBLnYz+KnIiIVPIqulZU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-yMOVwB8UNxeCBfzcSb0YLw-1; Mon, 11 Mar 2024 17:59:56 -0400
X-MC-Unique: yMOVwB8UNxeCBfzcSb0YLw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-690b5ad0e61so15723876d6.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 14:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194396; x=1710799196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L9tqjm6MQlYl8InOWvUGruPRPvJCqkW54MwUESfEeMw=;
 b=MkboWhdhsM1+2RxR+JOOhkfLigEmBxBozLRTpiY+/qBRQTHQ6AsmonOF0A5iqXl9/J
 M90iSHvxB+OVT50Kn4QyWerRldNRU+bKyzv58fMcfQdVuUxWjo2liv79hcVk9MB2Hsza
 LvMYU0Casc09K2RadXlv0J5MXgajdFLyo5M2x75ZOVIW3Bshqi3QBWBL84JRWH8ayBlw
 mqC9r/sDhYpAstvcJHgI/Ml/3ETF1fRizW2bXTg9VACRdUL23931DAFTR4Fmjh2RxWZO
 6dnNIHD+5ZuDpkfcR8949ixbDBaJZ2q5gD0Q/Ains9iNqLpOvdP5bOXRfYtE6b9XQPui
 3CLg==
X-Gm-Message-State: AOJu0YxCQRWw/TUrptLSioKPvb80iIsP5pyY06LR1SRMt9oZliQtWBz1
 BNvfWHUyKE2ASpSHaqVys8YoywO2MBEJpe8RWh99/F6P+/EdmsWPNB4PQSi1eaIshfPPClNwpDj
 84zuBXYMacXKmIEiuUZVwDHhlVLcTaF6S1zSphRANpgfxi9BMlR7ibXqUWt8EHcpKgg9q42mvLR
 tpWFnOx3YsNvdadfkv0VDBB0QL3W7YenRB0A==
X-Received: by 2002:a05:6214:1903:b0:68f:5d43:5e94 with SMTP id
 er3-20020a056214190300b0068f5d435e94mr7642141qvb.6.1710194396081; 
 Mon, 11 Mar 2024 14:59:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdb58FTINcFo/TyBnyBN4wza3Lw0FmwS44hJGnus24rZHw2UHWKIiW52EfVqFpw1ctBQBXyw==
X-Received: by 2002:a05:6214:1903:b0:68f:5d43:5e94 with SMTP id
 er3-20020a056214190300b0068f5d435e94mr7642114qvb.6.1710194395554; 
 Mon, 11 Mar 2024 14:59:55 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.14.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 14:59:53 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 19/34] migration: export migration_is_active
Date: Mon, 11 Mar 2024 17:59:10 -0400
Message-ID: <20240311215925.40618-20-peterx@redhat.com>
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

Delete the MigrationState parameter from migration_is_active so it
can be exported and used without including migration.h.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Link: https://lore.kernel.org/r/1710179338-294359-4-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h |  2 +-
 hw/vfio/common.c         |  4 ++--
 migration/migration.c    | 10 ++++++----
 system/dirtylimit.c      |  2 +-
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 79cff6224e..e1f1bf853e 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -60,7 +60,7 @@ void dump_vmstate_json_to_file(FILE *out_fp);
 void migration_object_init(void);
 void migration_shutdown(void);
 bool migration_is_idle(void);
-bool migration_is_active(MigrationState *);
+bool migration_is_active(void);
 bool migration_is_setup_or_active(void);
 bool migrate_mode_is_cpr(MigrationState *);
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 896eab8103..2dbbf62e15 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -182,7 +182,7 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
     VFIODevice *vbasedev;
     MigrationState *ms = migrate_get_current();
 
-    if (ms->state != MIGRATION_STATUS_ACTIVE &&
+    if (!migration_is_active() &&
         ms->state != MIGRATION_STATUS_DEVICE) {
         return false;
     }
@@ -225,7 +225,7 @@ vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer)
 {
     VFIODevice *vbasedev;
 
-    if (!migration_is_active(migrate_get_current())) {
+    if (!migration_is_active()) {
         return false;
     }
 
diff --git a/migration/migration.c b/migration/migration.c
index af21403bad..17859cbaee 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1406,7 +1406,7 @@ static void migrate_fd_cleanup(MigrationState *s)
         qemu_fclose(tmp);
     }
 
-    assert(!migration_is_active(s));
+    assert(!migration_is_active());
 
     if (s->state == MIGRATION_STATUS_CANCELLING) {
         migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
@@ -1637,8 +1637,10 @@ bool migration_is_idle(void)
     return false;
 }
 
-bool migration_is_active(MigrationState *s)
+bool migration_is_active(void)
 {
+    MigrationState *s = current_migration;
+
     return (s->state == MIGRATION_STATUS_ACTIVE ||
             s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
 }
@@ -3461,7 +3463,7 @@ static void *migration_thread(void *opaque)
 
     trace_migration_thread_setup_complete();
 
-    while (migration_is_active(s)) {
+    while (migration_is_active()) {
         if (urgent || !migration_rate_exceeded(s->to_dst_file)) {
             MigIterateState iter_state = migration_iteration_run(s);
             if (iter_state == MIG_ITERATE_SKIP) {
@@ -3607,7 +3609,7 @@ static void *bg_migration_thread(void *opaque)
     migration_bh_schedule(bg_migration_vm_start_bh, s);
     bql_unlock();
 
-    while (migration_is_active(s)) {
+    while (migration_is_active()) {
         MigIterateState iter_state = bg_migration_iteration_run(s);
         if (iter_state == MIG_ITERATE_SKIP) {
             continue;
diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index 774ff44f79..051e0311c1 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -83,7 +83,7 @@ static void vcpu_dirty_rate_stat_collect(void)
     int64_t period = DIRTYLIMIT_CALC_TIME_MS;
 
     if (migrate_dirty_limit() &&
-        migration_is_active(s)) {
+        migration_is_active()) {
         period = s->parameters.x_vcpu_dirty_limit_period;
     }
 
-- 
2.44.0


