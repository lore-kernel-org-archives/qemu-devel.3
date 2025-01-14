Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5750E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 23:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXq1c-00024p-NK; Tue, 14 Jan 2025 18:08:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq1D-00020K-A3
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:08:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq1B-0004A4-4l
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:08:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736896093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DoRPUxclEIuZm3ns0XxOQfYN1niMrBQ1FrIS1kOLfnY=;
 b=O35wF0HOKpkaRa9S6ntjJmAw1QkM6ugohmqmY0FBshs7u1kC0N48WExrfNDz7dLdqU4WYe
 4BxfA1PQOXp8IYeSxQyJOgojpWGFFFZBxAUEfDYeAQ2ZAJWyQ+rlhIztZB2bnXxNKHXtv2
 oaURtk3r/UoeTaIB82KyefmZNbLaLWI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-wvB-2HlSMe-Aj46pHcUCKA-1; Tue, 14 Jan 2025 18:08:10 -0500
X-MC-Unique: wvB-2HlSMe-Aj46pHcUCKA-1
X-Mimecast-MFC-AGG-ID: wvB-2HlSMe-Aj46pHcUCKA
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-46799aa9755so152604831cf.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 15:08:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736896089; x=1737500889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DoRPUxclEIuZm3ns0XxOQfYN1niMrBQ1FrIS1kOLfnY=;
 b=JDXB0dyIqL7q5YTnwsndBrVJcAnrJCvgQlS7Pw/vrwyofwWo+w9UdDxDjUBEPeYZuJ
 hxAmSDTVBg6wx2t23Md7Zo7I576VvGAHFcagMF8jf4CdeDkqpZ2yvR8TMuCHL6BTqxp7
 P2oDlmw3UPiqx/AZBg7Eo7Emcp3JOkuoU+wX2Hc4BRDD/1yddeoocRsuhFyMEp2UddH8
 KHdAoBlp9FRRUjLWZLqvaD4KtGYdERWKmhLPsyY6tlMks1jNkoHuJwy9vs5w7mLoxUim
 07UtrmJCCPa1Y7FRgoDSM5nG6DLtjX3pADhqacSdhVadDVlak+4qHowwjoyGyqHSXRH3
 I6Zw==
X-Gm-Message-State: AOJu0YwI/O4dS1pQ1ZXVGbm9FfGZ1xWS9h1aNPZ7St/yxx/0aNPN7m3P
 kQu7+jR4sFywfJJfM6CQq4HWv3/IVyGpjs/mtykIpzI6ofC1Sty21MCE6gmJ0PI8l6x4eOOf7v3
 LzagYXMQ2oCYt+X/t342AgUw0PcIM96RInyS5qYuTWYJb7I0Oi3mXgNKx1hJSMypm/CspiUiA5Q
 pGX9Fda5M7KQXLanCimovXLYMRMs7PzCKTcw==
X-Gm-Gg: ASbGncsoGRNpI/+zh9AqV9Ok1LeADov71FtV8ipOz6kQJ9JlFf9ypak6bR6iUdUfq34
 sv+JAbiL1gtiYHDzIpzf1j2UdI6c5Gc6rPxfkCEqFrfjRS+03bnIFlf042/VF5o8P5rofc9thtd
 rQ84rOk2GB25kTV3EPkHFrrthHQWYw0qRTIiur7wIseCzcxC/FAjj9hmExkvsYmSTaCF4yac2oe
 O/sn2uc7VihVbV8Ny51teQIH8NpepSEpny1415OVweUWjCT4Ks1GjdryNK/uIAwz9vzf+HSVyrC
 LZG/fJRWzDsXokFg2eHy3C0f3xImOeOy
X-Received: by 2002:ac8:5955:0:b0:467:8765:51ae with SMTP id
 d75a77b69052e-46c71081664mr419945351cf.39.1736896089058; 
 Tue, 14 Jan 2025 15:08:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGe5AtZZUYYt7+5B5t1idUkM7mY3p3t6lvIidFL8v3ea8e3Qayq9UVqeGl6uV+XIpGLtaKF2g==
X-Received: by 2002:ac8:5955:0:b0:467:8765:51ae with SMTP id
 d75a77b69052e-46c71081664mr419944661cf.39.1736896088345; 
 Tue, 14 Jan 2025 15:08:08 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c873cd1b0sm59268971cf.49.2025.01.14.15.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 15:08:07 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 11/16] migration: Notify COMPLETE once for postcopy
Date: Tue, 14 Jan 2025 18:07:41 -0500
Message-ID: <20250114230746.3268797-12-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250114230746.3268797-1-peterx@redhat.com>
References: <20250114230746.3268797-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Postcopy invokes qemu_savevm_state_complete_precopy() twice, that means
it'll invoke COMPLETE notify twice.. also twice the tracepoints that
marking precopy complete.

Move that notification (along with the tracepoint) out to the caller, so
that postcopy will only notify once right at the start of switchover phase
from precopy.  When at it, rename it to suite the file now it locates.

For precopy, there should have no functional change except the tracepoint
has a name change.

For the other two users of qemu_savevm_state_complete_precopy(), namely:
qemu_savevm_state() and qemu_savevm_live_state(): the notifier shouldn't
matter because they're not precopy at all.  Now in these two contexts (aka,
"savevm", and "colo") sometimes the precopy notifiers will still be
invoked, but that's outside the scope of this patch.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c  | 15 +++++++++++++++
 migration/savevm.c     |  7 -------
 migration/trace-events |  2 +-
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index f644a6306b..2c5674c2ae 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -127,6 +127,17 @@ static void migration_downtime_end(MigrationState *s)
     }
 }
 
+static void precopy_notify_complete(void)
+{
+    Error *local_err = NULL;
+
+    if (precopy_notify(PRECOPY_NOTIFY_COMPLETE, &local_err)) {
+        error_report_err(local_err);
+    }
+
+    trace_migration_precopy_complete();
+}
+
 static bool migration_needs_multiple_sockets(void)
 {
     return migrate_multifd() || migrate_postcopy_preempt();
@@ -2549,6 +2560,8 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     /* Switchover phase, switch to unlimited */
     migration_rate_set(RATE_LIMIT_DISABLED);
 
+    precopy_notify_complete();
+
     /*
      * Cause any non-postcopiable, but iterative devices to
      * send out their final data.
@@ -2738,6 +2751,8 @@ static int migration_completion_precopy(MigrationState *s)
 
     migration_rate_set(RATE_LIMIT_DISABLED);
 
+    precopy_notify_complete();
+
     ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false);
 out_unlock:
     bql_unlock();
diff --git a/migration/savevm.c b/migration/savevm.c
index 92e77ca92b..9aef2fa3c9 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1578,15 +1578,8 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
 int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only)
 {
     int ret;
-    Error *local_err = NULL;
     bool in_postcopy = migration_in_postcopy();
 
-    if (precopy_notify(PRECOPY_NOTIFY_COMPLETE, &local_err)) {
-        error_report_err(local_err);
-    }
-
-    trace_savevm_state_complete_precopy();
-
     if (!in_postcopy || iterable_only) {
         ret = qemu_savevm_state_complete_precopy_iterable(f, in_postcopy);
         if (ret) {
diff --git a/migration/trace-events b/migration/trace-events
index b82a1c5e40..ec3c9d0ffe 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -44,7 +44,6 @@ savevm_state_resume_prepare(void) ""
 savevm_state_header(void) ""
 savevm_state_iterate(void) ""
 savevm_state_cleanup(void) ""
-savevm_state_complete_precopy(void) ""
 vmstate_save(const char *idstr, const char *vmsd_name) "%s, %s"
 vmstate_load(const char *idstr, const char *vmsd_name) "%s, %s"
 vmstate_downtime_save(const char *type, const char *idstr, uint32_t instance_id, int64_t downtime) "type=%s idstr=%s instance_id=%d downtime=%"PRIi64
@@ -193,6 +192,7 @@ migrate_transferred(uint64_t transferred, uint64_t time_spent, uint64_t bandwidt
 process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
 process_incoming_migration_co_postcopy_end_main(void) ""
 postcopy_preempt_enabled(bool value) "%d"
+migration_precopy_complete(void) ""
 
 # migration-stats
 migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64_t rdma) "qemu_file %" PRIu64 " multifd %" PRIu64 " RDMA %" PRIu64
-- 
2.47.0


