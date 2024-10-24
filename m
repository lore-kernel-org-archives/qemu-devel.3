Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA612CE8E99
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 16:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t419R-00040E-En; Thu, 24 Oct 2024 12:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t418i-0003ur-Ao
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 12:56:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t418d-0002xw-Km
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 12:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729789002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3zbHXAQw1fGMrmr4E8SGLR2X4v65QDTd+QipXl5kc8s=;
 b=NCW1YsKM65k+ehHrVkgTPzekEXBAsjC5lBhprKKQ7U39BSuDcyZ7l6WC7o0KkIl33lyn7C
 dpYxH9zjXt6JfXa7yT32wzx6nk9DUk5MDZr63XEDgFAa8YF6+u6RSoxk1naU+QMCQY6qzD
 RauOzjftkiKi1o+S0TWk7rwtfvRji2I=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-s3bjuv3CNLWI8lnBgtWfDA-1; Thu, 24 Oct 2024 12:56:39 -0400
X-MC-Unique: s3bjuv3CNLWI8lnBgtWfDA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6cbeb6075d9so24144256d6.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 09:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729788998; x=1730393798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3zbHXAQw1fGMrmr4E8SGLR2X4v65QDTd+QipXl5kc8s=;
 b=PHgFmCOr8v0qOH8gUuuU0g4GyFp8wn6RimMDmnn/B1+bGSu4Twa2VcnfqzmRaOFkKL
 kYP5QkQoz0KQZ7tX1Qvk08JZwW74lvaJ4zY2zyMwXzoslydiCni0x4HscYwZK+ANF7h5
 ZhvQKKj5cQ80tTOXQwg62+DErP5T3nibKHeO/YXOJK2M8bb/bV7Imqf4ejdIxDZDK/PT
 E2xUc/Q6vXG9LACVfY6jlvGN0s8udHzNvCIzBwvRQVqw0lu6iI8qrxl3Hfk7QsJxcLV4
 aNj1ixASH7VPoLLi+aUeXQW6mOl5D1bBcyMg54cWZPcYWaJZpaH8ujSAbUWfmyAzMttZ
 bLsA==
X-Gm-Message-State: AOJu0Yyq87CvFVUQs90nFgCsDKD7/VJzKNIoucGjAWfhGpRkP7LdCMUl
 MF4CS197mohPGrAviIRHAu9YO5Py5tQXElTYcl78xWfVTWNyMGRMEwZgfhLj7vz8tghHb29Y2IL
 WUrrVwY5IP1cZWxCtgIyR4CACSy81/VxOgvUUiddyunCehqccR4+BXk8sqWnEe/qBWYzJnsOhb4
 ATKpgCagapoDgOS5vWaD/nRFk3+WHYVJtRSw==
X-Received: by 2002:a05:6214:2d43:b0:6cb:e9da:bd4 with SMTP id
 6a1803df08f44-6d07a5fff7cmr43867806d6.5.1729788998172; 
 Thu, 24 Oct 2024 09:56:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7koPn1D5NP5mkRs5TPr43VbcvjnUva8aXN51jCV6jnfnoJHJjFTcvoeya0Hfi/Yh13b7daw==
X-Received: by 2002:a05:6214:2d43:b0:6cb:e9da:bd4 with SMTP id
 6a1803df08f44-6d07a5fff7cmr43867386d6.5.1729788997806; 
 Thu, 24 Oct 2024 09:56:37 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce008aff31sm51871076d6.12.2024.10.24.09.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 09:56:36 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Igor Mammedov <imammedo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 4/4] migration: Reset current_migration properly
Date: Thu, 24 Oct 2024 12:56:27 -0400
Message-ID: <20241024165627.1372621-5-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241024165627.1372621-1-peterx@redhat.com>
References: <20241024165627.1372621-1-peterx@redhat.com>
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

current_migration is never reset, even if the migration object is freed
already.  It means anyone references that can trigger UAF and it'll be hard
to debug.

Properly clear the pointer now, so far the only way to do is via
finalize() as we know there's only one instance of it, meanwhile QEMU won't
know who holds the refcount, so it can't reset the variable manually but
only in finalize().

To make it more readable, also initialize the variable in the
instance_init() so it's very well paired at least.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 1b5285af95..74812ca785 100644
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
@@ -3886,12 +3888,27 @@ static void migration_instance_finalize(Object *obj)
     qemu_sem_destroy(&ms->rp_state.rp_pong_acks);
     qemu_sem_destroy(&ms->postcopy_qemufile_src_sem);
     error_free(ms->error);
+
+    /*
+     * We know we only have one intance of migration, and when reaching
+     * here it means migration object is gone.  Clear the global reference
+     * to reflect that.
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


