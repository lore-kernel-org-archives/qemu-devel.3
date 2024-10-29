Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5081D74940
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 21:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5ta1-0002Sd-Q5; Tue, 29 Oct 2024 17:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5tZp-0002Op-Gn
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 17:16:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5tZo-0007dW-1y
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 17:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730236590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nIsEGl5Q0LBUrispxqDInl3LntXkgTEgoJOrk5dnpfs=;
 b=a4uj1VvyWX0p0tF6XMoJy6x646KoSjZYn7dbLESKq0y+zvQmIEROcEprLbFhApboO5uhcf
 LtuToIUKmnactBYIfeILHlz7C+NrV54M2lTZ3QTmRe3FtrPOW7KgHMBK7hfHKuC7peg2Zg
 dmKWp4jN/UoeN7s9WhTj3bhmHflo5vU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-x5h4FlbQMoyxTPVvXRaSug-1; Tue, 29 Oct 2024 17:16:28 -0400
X-MC-Unique: x5h4FlbQMoyxTPVvXRaSug-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-460b07774a7so128433051cf.2
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 14:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730236587; x=1730841387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nIsEGl5Q0LBUrispxqDInl3LntXkgTEgoJOrk5dnpfs=;
 b=jEm17crmCDO1uVXKwbBcEzM4FNWoNBKC99vGSL4VIPcZUNDgkKTdxVxDvAec4lRk2U
 1q9sSvBgU0xT3aI7xwqOg2sl/GB9Xb1nKBNPPVtHxh7YBkXfCxVxW9y/4mPGGhBGyTKA
 HinjyjemQ6a6QProwvBUlN645oYe21cxYNoleNBEsXm4REfW1RDsdpjZ5ME9MIjeuqY+
 8A20q/H3nXZH7ruy7ETQEnxdM6iUUJJrECos5AzP3MCsxRglYr92qreZWaOrDKf+IeXq
 LCDUrVt5p8PjR87UId9vSC6BQsnHjIhC8kBwyDBfwtbbg9P6CPymLNXJs8UXOSBkCnhn
 QGpw==
X-Gm-Message-State: AOJu0YzjkvUpLxA1tBs+VUlY6G0ZUVF4bFGypa5IjakV+uZITuSv6kTo
 kyXDDNnnGR2fIalipOkn4ZD/uyhGVOze9HYkYRneK//bPjYkVqt5r/GuHnnRCdLTzb4tWIf/K1O
 nac7TFQ42GuIvTgmDNaaLW5caXpk2KwOrkgm97edIilEOwJG+5Lf8xWyfYptCfe6ZXUrSLhf1Kp
 YnCoENyzV+6Fahj7nfeCscT2cTKjfjQYOqBQ==
X-Received: by 2002:a05:622a:1896:b0:461:11b:d22d with SMTP id
 d75a77b69052e-461717c6eebmr12288581cf.54.1730236587273; 
 Tue, 29 Oct 2024 14:16:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESJb6kh6IVqr8qStiAr4LASjj3zrStCPSYzub9j4zoi08upMUxJCbk/8yAQ8dpaPX23AZR6Q==
X-Received: by 2002:a05:622a:1896:b0:461:11b:d22d with SMTP id
 d75a77b69052e-461717c6eebmr12288261cf.54.1730236586840; 
 Tue, 29 Oct 2024 14:16:26 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46132292c97sm48481691cf.49.2024.10.29.14.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 14:16:25 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH RFC v2 7/7] migration: Reset current_migration properly
Date: Tue, 29 Oct 2024 17:16:07 -0400
Message-ID: <20241029211607.2114845-8-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241029211607.2114845-1-peterx@redhat.com>
References: <20241029211607.2114845-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

current_migration is never reset, even if the migration object is freed
already.  It means anyone references that can trigger UAF and it'll be hard
to debug.

Properly clear the pointer now.  So far the only place to do is via its own
finalize(), which means QEMU is releasing the last refcount and right
before freeing the object memory.  Meanwhile, QEMU won't know who holds the
last refcount, so it can't reset the variable manually / explicitly.

To make it more readable, also initialize the variable in the
instance_init() so it's very well paired at least.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index f4456f7142..70b9ef8228 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -233,9 +233,11 @@ static int migration_stop_vm(MigrationState *s, RunState state)
 
 void migration_object_init(void)
 {
-    /* This can only be called once. */
-    assert(!current_migration);
-    current_migration = MIGRATION_OBJ(object_new(TYPE_MIGRATION));
+    /* This creates the singleton migration object */
+    object_new(TYPE_MIGRATION);
+
+    /* This should be set now when initialize the singleton object */
+    assert(current_migration);
 
     /*
      * Init the migrate incoming object as well no matter whether
@@ -3864,12 +3866,27 @@ static void migration_instance_finalize(Object *obj)
     qemu_sem_destroy(&ms->rp_state.rp_pong_acks);
     qemu_sem_destroy(&ms->postcopy_qemufile_src_sem);
     error_free(ms->error);
+
+    /*
+     * We know we only have one instance of migration, and when reaching
+     * here it means migration object is going away.  Clear the global
+     * reference to reflect that.
+     */
+    current_migration = NULL;
 }
 
 static void migration_instance_init(Object *obj)
 {
     MigrationState *ms = MIGRATION_OBJ(obj);
 
+    /*
+     * There can only be one migration object globally. Keep a record of
+     * the pointer in current_migration, which will be reset after the
+     * object finalize().
+     */
+    assert(!current_migration);
+    current_migration = ms;
+
     ms->state = MIGRATION_STATUS_NONE;
     ms->mbps = -1;
     ms->pages_per_second = -1;
-- 
2.45.0


