Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A4FC02187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 23:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXq0x-0001rI-Ks; Tue, 14 Jan 2025 18:08:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq0w-0001qo-2K
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:08:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq0u-00043U-J0
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:08:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736896079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=enSH5rlxcTb/KVObjDkc8rdqQsMxW2lwvt88NiL40BA=;
 b=GAcoavBNhXWu+QhAEk3OA8U+KU0Oil0CyIkPDkmXnM2jfneo3n51NKsUc0RAGXNly17ZBb
 lH3JjyBSrC2WK+RfzcBXGiukww90hyl5j2Sb0M9xF3tH6I00xIvBVcy+NdqAAh2gX3/QFw
 wUPiB+nw40h4S6nfRCCizAEfeTQgsHs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-mSHRlySrNpWY4uCGChMGjQ-1; Tue, 14 Jan 2025 18:07:56 -0500
X-MC-Unique: mSHRlySrNpWY4uCGChMGjQ-1
X-Mimecast-MFC-AGG-ID: mSHRlySrNpWY4uCGChMGjQ
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-46c83bc370bso5734481cf.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 15:07:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736896075; x=1737500875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=enSH5rlxcTb/KVObjDkc8rdqQsMxW2lwvt88NiL40BA=;
 b=eJ4hrB0mkkSvDiNr9PeOTxN/sgDZ5UZLFH0bGZV5c3uBDvg4NY0zrgnnD0RYAlPvxB
 S6wFILW9ICaraf0AOByTVZxP2VdzLjnWKmt6N8NxyP9Zt6G+pPuyQwENorqQLxy8JArb
 9dbyrNpGU8iiJafISRNw4GcPvWHk8/UBnTvHeu2d3aKrblzkFQ1n/27qqtZ9P7IsdTMi
 2TZuJTW7X3y2+3K0PcAFh1G19fdqI6/wp53xqMMhRLu0JToM1yXl5Z44rnFuJsB+0nGh
 VrFh86+PWc8BTreeVZgIKLZAQBwmrMAI+JCpPWC0GDaNTVEU6YccwKLOEOFPnGp5FPWM
 Inxg==
X-Gm-Message-State: AOJu0YwW04rEHCpyz1Q3zTq3bDGC0RP9ITI5T963OG+vN27kAiYI1GXb
 JHHj99Nc5NLfJ8bTa5JatCb4JLrPzT8HI1iYSBjzEPYO3VReHklP6DT2WdzSygri55JpGMaEUyz
 9RGf82Tpn+gmKgB1L2bduxq5cmtUXGkldjt5Ve6lFICY0bC6ckJRkkwD8LbRMe26x0lNaEC7V84
 3ATE9Af2QXQs2zcO0AmIc2+TnRF+bhNqkFcg==
X-Gm-Gg: ASbGncuk/2NyA6xZ7V9jc8d7XgO/rypddPq1mu/d3KjeRqo2G+mCpsiaf3gqsJP00x0
 BR8YLv8FklZCg7GSIQxRkPT23PvGFy4Xw9jrrFtzYjXdsu6OWb15zcMJBdOWDkVQwzEMdKCdlKz
 Gp3+IysS+/FsZrnm/eA3bTh8q5lM5ILgbErsCvdAOrbnWlwHF0HOAHx/a/kifKRc/X/rFJfbeh1
 5boaMODwHt8z3MvUjdsmlMH91sR6Oz1vjxyhIoTBVHXo/C+2FfyvUqXZJeR2uH6Chkpy0zPf8tn
 TuUv+YAdYsuX6tsHdiw4221/3UQMBPl9
X-Received: by 2002:a05:622a:5a07:b0:467:85f9:2a6c with SMTP id
 d75a77b69052e-46df569e6f0mr14053131cf.10.1736896074904; 
 Tue, 14 Jan 2025 15:07:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6CnqlXk+V6YEg6yK9um5/g0qtpiIkDWbqOmkTL2DWXP+7th4OYi4UEewIWCI4VCGYIcO3MQ==
X-Received: by 2002:a05:622a:5a07:b0:467:85f9:2a6c with SMTP id
 d75a77b69052e-46df569e6f0mr14052811cf.10.1736896074572; 
 Tue, 14 Jan 2025 15:07:54 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c873cd1b0sm59268971cf.49.2025.01.14.15.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 15:07:53 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 03/16] migration: Optimize postcopy on downtime by avoiding
 JSON writer
Date: Tue, 14 Jan 2025 18:07:33 -0500
Message-ID: <20250114230746.3268797-4-peterx@redhat.com>
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

postcopy_start() is the entry function that postcopy is destined to start.
It also means QEMU source will not dump VM description, aka, the JSON
writer is garbage now.

We can leave that to be cleaned up when migration completes, however when
with the JSON writer object being present, vmstate_save() will still try to
construct the JSON objects for the VM descriptions, even though it'll never
be used later if it's postcopy.

To save those cycles, release the JSON writer earlier for postcopy. Then
vmstate_save() later will be smart enough to skip the JSON object
constructions completely.  It can logically reduce downtime because all
such JSON constructions happen during postcopy blackout.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index bad7b39293..0eb28e850d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1397,6 +1397,11 @@ void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
     }
 }
 
+static void migration_cleanup_json_writer(MigrationState *s)
+{
+    g_clear_pointer(&s->vmdesc, json_writer_free);
+}
+
 static void migrate_fd_cleanup(MigrationState *s)
 {
     MigrationEventType type;
@@ -1404,11 +1409,11 @@ static void migrate_fd_cleanup(MigrationState *s)
 
     trace_migrate_fd_cleanup();
 
+    migration_cleanup_json_writer(s);
+
     g_free(s->hostname);
     s->hostname = NULL;
 
-    g_clear_pointer(&s->vmdesc, json_writer_free);
-
     qemu_savevm_state_cleanup();
 
     close_return_path_on_source(s);
@@ -2501,6 +2506,14 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     uint64_t bandwidth = migrate_max_postcopy_bandwidth();
     int cur_state = MIGRATION_STATUS_ACTIVE;
 
+    /*
+     * Now we're 100% sure to switch to postcopy, so JSON writer won't be
+     * useful anymore.  Free the resources early if it is there.  Clearing
+     * the vmdesc also means any follow up vmstate_save()s will start to
+     * skip all JSON operations, which can shrink postcopy downtime.
+     */
+    migration_cleanup_json_writer(ms);
+
     if (migrate_postcopy_preempt()) {
         migration_wait_main_channel(ms);
         if (postcopy_preempt_establish_channel(ms)) {
-- 
2.47.0


