Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6741DCEBF72
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 20:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svMYZ-0004so-7F; Mon, 30 Sep 2024 15:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svMXw-00044c-UM
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:59:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svMXp-00040A-VN
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727726337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K0KTK9vQGWewvOY3cSlTOqfE9A0WK5IwRE3a47FyV7w=;
 b=UJw+dllhEVFGBo33uqVpGh4DeSDSccHAthwoYUeQFTQNMx11RazfTwqRpr90GiyCx3s6Hd
 CZrglxZ2fTlMzKcACdoaxUaqUfCuWp4uF2QOzkFwftqPVZFotJT+ELi5NBxbdUJpmeafG2
 II6nNXT0u/0lqwLILgD+b5kvFYbVQvQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-EU_C1ZyGMQqdCaoV_loPCw-1; Mon, 30 Sep 2024 15:58:55 -0400
X-MC-Unique: EU_C1ZyGMQqdCaoV_loPCw-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-458657ce53aso81887981cf.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 12:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727726332; x=1728331132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K0KTK9vQGWewvOY3cSlTOqfE9A0WK5IwRE3a47FyV7w=;
 b=YtBJ9jH/6gRaoTbcpZAAha7epivDf6QiTPVH2JyJW1lbn2L+GIxvy7gNYIk1azbjut
 2yyWRzPLcb3dq0eT+cTK7agZLMEnLNmSNM1oeUuVRFKajjyy35fo2/qFNtJ1MAG/TP5L
 talgmKFcDM9DfWtsHTv1nY5qxA3gl207Y0ewb2RaWaQpOalB2j95GAgceZI0KqwTd9gT
 B9pyncfdoKsR3e6+ENzWKqJ36uaoTSlaD0IIVhug4Tr8QThkTgMvmb05Cg6dgDC3l07D
 MfZsNcvOGseErCbJoYHU34OxQP+umocbSmtM80DBoQV7ucltgRcCV8IiuVngqquTky0F
 EVZA==
X-Gm-Message-State: AOJu0YyYiXDNipCBAeiNmMNDGR8hfMfqbT75TKcSxCV5E+35wfQyG0wZ
 um6QWMeyGQ6hAoV75VQinPoFy1YsIl5NBsB6i5vejB/QwgayZjH+GBM5jLNBfulP8yPymGDO5ea
 Eodg4GRUVqfDW2HiIuDj/jx7B2NQtsXhj7VHCf4iXkbeLq87bD87+DIFfKxnzVH98NlavUzheig
 +thfzGE8CiHhu9TsR+Pw++/XNeyh9fWEvOuA==
X-Received: by 2002:a05:622a:144c:b0:458:5fd0:964c with SMTP id
 d75a77b69052e-45c9f31955amr203760581cf.50.1727726332489; 
 Mon, 30 Sep 2024 12:58:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1ietuHwWWS0bbq2F/1PbII+kQ9eUVBriZz3SMMbWS/0Qod2lXONQ3ih789dvVEXAmsYO86Q==
X-Received: by 2002:a05:622a:144c:b0:458:5fd0:964c with SMTP id
 d75a77b69052e-45c9f31955amr203760291cf.50.1727726332105; 
 Mon, 30 Sep 2024 12:58:52 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f28e481sm38879371cf.16.2024.09.30.12.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 12:58:50 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 3/7] migration: Remove thread_id in migration_threads_add()
Date: Mon, 30 Sep 2024 15:58:33 -0400
Message-ID: <20240930195837.825728-4-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240930195837.825728-1-peterx@redhat.com>
References: <20240930195837.825728-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

It always fetches the ID of the curren thread, so there's no point passing
it over.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/threadinfo.h | 2 +-
 migration/migration.c  | 3 +--
 migration/multifd.c    | 2 +-
 migration/threadinfo.c | 5 +++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/migration/threadinfo.h b/migration/threadinfo.h
index 2f356ff312..d0e4ab0aa3 100644
--- a/migration/threadinfo.h
+++ b/migration/threadinfo.h
@@ -21,5 +21,5 @@ struct MigrationThread {
     QLIST_ENTRY(MigrationThread) node;
 };
 
-MigrationThread *migration_threads_add(const char *name, int thread_id);
+MigrationThread *migration_threads_add(const char *name);
 void migration_threads_remove(MigrationThread *info);
diff --git a/migration/migration.c b/migration/migration.c
index 813c45ad04..1ddcf54a70 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3467,8 +3467,7 @@ static void *migration_thread(void *opaque)
     Error *local_err = NULL;
     int ret;
 
-    thread = migration_threads_add(MIGRATION_THREAD_SRC_MAIN,
-                                   qemu_get_thread_id());
+    thread = migration_threads_add(MIGRATION_THREAD_SRC_MAIN);
 
     rcu_register_thread();
 
diff --git a/migration/multifd.c b/migration/multifd.c
index 697fe86fdf..04db886c7e 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -575,7 +575,7 @@ static void *multifd_send_thread(void *opaque)
     int ret = 0;
     bool use_packets = multifd_use_packets();
 
-    thread = migration_threads_add(p->name, qemu_get_thread_id());
+    thread = migration_threads_add(p->name);
 
     trace_multifd_send_thread_start(p->id);
     rcu_register_thread();
diff --git a/migration/threadinfo.c b/migration/threadinfo.c
index 262990dd75..8069413091 100644
--- a/migration/threadinfo.c
+++ b/migration/threadinfo.c
@@ -23,11 +23,12 @@ static void __attribute__((constructor)) migration_threads_init(void)
     qemu_mutex_init(&migration_threads_lock);
 }
 
-MigrationThread *migration_threads_add(const char *name, int thread_id)
+MigrationThread *migration_threads_add(const char *name)
 {
     MigrationThread *thread =  g_new0(MigrationThread, 1);
+
     thread->name = name;
-    thread->thread_id = thread_id;
+    thread->thread_id = qemu_get_thread_id();
 
     WITH_QEMU_LOCK_GUARD(&migration_threads_lock) {
         QLIST_INSERT_HEAD(&migration_threads, thread, node);
-- 
2.45.0


