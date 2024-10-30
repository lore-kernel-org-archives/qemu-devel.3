Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F1CD5CCB9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 16:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6B5D-0003h6-B8; Wed, 30 Oct 2024 11:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B5A-0003bp-5P
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:58:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B58-0007od-Bl
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730303881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cLfiSEdO7zeQicFYxz5aA6Flw78+vUf5BF/rB2HZ8uE=;
 b=fxD32OF6DQMt8ac6XUR6qdc+H3iCMaUhO83QIlVqx6tzPo/LHVJ/LYTHZuL9weYG3Nkjcr
 KEv2ky9Q8/WFNULbv1fwVDs/3An7i2Mal20CgQV+SkNSnvcPcHtxtWkDsAHYjmzTB/Wjip
 5eglqBMZqmxx6pifEACxrgVlvE8J7gs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-9WnRrbLHPciuzWBsv2gFJg-1; Wed, 30 Oct 2024 11:58:00 -0400
X-MC-Unique: 9WnRrbLHPciuzWBsv2gFJg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b163e0a5ecso1036095685a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 08:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730303878; x=1730908678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cLfiSEdO7zeQicFYxz5aA6Flw78+vUf5BF/rB2HZ8uE=;
 b=iTzhXnMF/Dh0fEGj8iyoI6otKgLtBh0/jFF27Fm5g5q/9jo/o4XQUCyldWvOFmfL/P
 CcCtlR+x/zJ3ecqPvARhmZPz+LTBi/V0azzUZzGXr2RMvoorbUhvar0ZTdoX/Kd35dtZ
 0Xp/nSo3HjxZs+KHG1GNH+cvMLvUWtzTiv4g62dNnbTT+PPogRlDG3bhk1esfqqAR7PC
 VTWx/TchtTQR9i8bWeD6chfYai97O2uH6OT/azo8++umCJ2A6nxxILtByjkOjGWJf4oY
 2RYwUAZ8Qrowwk9Z8DpRJaNhUqkP3zguWXKBHu6z9SmClQ9AN6vouXVp9WwTtQcyZtrv
 7bfA==
X-Gm-Message-State: AOJu0YximiXYEysT/rpDKQdi3KYqRrZB+xmENA9ZUmi9j7LPWSkdPR7n
 C/HlztAVHmlt5yJ5xB6uDjrMNmVZ3uC5gRu+OpaT/HeVpbuzCEU++hLkiWqqWke3A+WAgMp04kX
 nrs/8SoDBX5v8NAJ3nYG7Jl8Nylxmzvs64Nfvdtgjhx9Be34DQisYvSHlo57QAKsgaB+h4vSgYz
 PuiWTOr04gPbyY0WbItEAUlDQUQ2+c7BkjfQ==
X-Received: by 2002:a05:6214:3d8f:b0:6cc:41cf:a361 with SMTP id
 6a1803df08f44-6d18584fee5mr265291426d6.42.1730303877940; 
 Wed, 30 Oct 2024 08:57:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd0y6ew+0xHx0kyMUV4NyNX7osYVZH+5M6Tc3LWpbf1uzV0roF40RKB2HFvYeFSuVCOPAQGg==
X-Received: by 2002:a05:6214:3d8f:b0:6cc:41cf:a361 with SMTP id
 6a1803df08f44-6d18584fee5mr265291096d6.42.1730303877542; 
 Wed, 30 Oct 2024 08:57:57 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d19c57c1ffsm22802276d6.89.2024.10.30.08.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 08:57:56 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 12/18] migration: Take migration object refcount earlier for
 threads
Date: Wed, 30 Oct 2024 11:57:28 -0400
Message-ID: <20241030155734.2141398-13-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241030155734.2141398-1-peterx@redhat.com>
References: <20241030155734.2141398-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Both migration thread or background snapshot thread will take a refcount of
the migration object at the entrace of the thread function.

That makes sense, because it protects the object from being freed by the
main thread in migration_shutdown() later, but it might still race with it
if the thread is scheduled too late.  Consider the case right after
pthread_create() happened, VM shuts down with the object released, but
right after that the migration thread finally got created, referencing
MigrationState* in the opaque pointer which is already freed.

The only 100% safe way to make sure it won't get freed is taking the
refcount right before the thread is created, meanwhile when BQL is held.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20241024213056.1395400-2-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index bcb735869b..de80d64dda 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3488,7 +3488,6 @@ static void *migration_thread(void *opaque)
 
     rcu_register_thread();
 
-    object_ref(OBJECT(s));
     update_iteration_initial_status(s);
 
     if (!multifd_send_setup()) {
@@ -3626,7 +3625,6 @@ static void *bg_migration_thread(void *opaque)
     int ret;
 
     rcu_register_thread();
-    object_ref(OBJECT(s));
 
     migration_rate_set(RATE_LIMIT_DISABLED);
 
@@ -3838,6 +3836,14 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         }
     }
 
+    /*
+     * Take a refcount to make sure the migration object won't get freed by
+     * the main thread already in migration_shutdown().
+     *
+     * The refcount will be released at the end of the thread function.
+     */
+    object_ref(OBJECT(s));
+
     if (migrate_background_snapshot()) {
         qemu_thread_create(&s->thread, MIGRATION_THREAD_SNAPSHOT,
                 bg_migration_thread, s, QEMU_THREAD_JOINABLE);
-- 
2.45.0


