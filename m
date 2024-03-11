Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBC5C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjnh3-00010D-5B; Mon, 11 Mar 2024 18:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngk-0000gn-5t
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngi-0004BH-BN
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=THTiTAxd6rgV7ReJUkExaQ2OYvOSoENOQBQ/zZOVMUs=;
 b=TVzaSacUucR1PNoEnEFWm1QF4yZNr90LkxeSwiR8F8bydrugV5ZETk+jOUDFFcfUJYF5Un
 KuyfInDUIcy+UR/gJy0r0C7xp1qvfeoTpVuzLDy2q5FDf3Veh+usxuN/AGDvs65xu4PRqF
 7dtPvcwJON7FHvD4o+BZnXPNq7mjRyo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-3VfiriHIN8OyYG9e9C8crg-1; Mon, 11 Mar 2024 18:00:01 -0400
X-MC-Unique: 3VfiriHIN8OyYG9e9C8crg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-690d3f5af86so4505906d6.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 15:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194401; x=1710799201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=THTiTAxd6rgV7ReJUkExaQ2OYvOSoENOQBQ/zZOVMUs=;
 b=O42KEbYoHtwZlier/D5NVFTOVC5teVD/qzhCq9P9Vo4LWHrfz7n6zyiWGNwbTag9Fk
 aC8tqmHvoNx5217ZtP9V7YxGJNRDgovYMMJocKtXEdXUukI6lwWJ5s3JmfE/CSKQ4PiJ
 SDXD4hQPCs+Pr+5gISTwgxABz1ToWxAJIRXc6vU+uRMo1kBxdDsi5iAdnX3ImbJWyGVQ
 ke/LqtgvZfqyumOSqkdFQbxPwywVHzFRdtUZjy6QflkXlZah91wWdfMUVgJQ9ZfFGO7F
 lUHyRVZyKInQVv6qgo4Pk94akXIirlkFkT9N4ehmHyj2Fq/GizHQx1UQx/8iLx6hXqjO
 y09Q==
X-Gm-Message-State: AOJu0Yxrhz72w/7zfmqxqXiUBp4TXSqIKTCIhSJ7tnfF3Ihks0D+GpgE
 Bkxz/V6Geal3j+a6v1Q61RJnRRRIPHmnhuOB/vyD8c+jknjporEgMCiVOLVTcnjNfKqYp8cyc9k
 HWo8Hh/46sN0QDCAT5a7eBlSp2tT2HQxFGHtH6NWMIFSFiA2rbQxHoi+sPFl7qrCOldjyrmYrOo
 KiCtQMoGCi1ibY6V6aT7voUmQru+vb6H7W8w==
X-Received: by 2002:a0c:fa91:0:b0:690:d74d:7e6d with SMTP id
 o17-20020a0cfa91000000b00690d74d7e6dmr3081281qvn.3.1710194400901; 
 Mon, 11 Mar 2024 15:00:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3DZYbMlwaBNcEenBSc9RXyxg2cLRlFPSBH6poWmfNscAFHMLO5ucsnw4NdmHcP2yPlqheeQ==
X-Received: by 2002:a0c:fa91:0:b0:690:d74d:7e6d with SMTP id
 o17-20020a0cfa91000000b00690d74d7e6dmr3081256qvn.3.1710194400388; 
 Mon, 11 Mar 2024 15:00:00 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.14.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 14:59:59 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 22/34] migration: migration_thread_is_self
Date: Mon, 11 Mar 2024 17:59:13 -0400
Message-ID: <20240311215925.40618-23-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311215925.40618-1-peterx@redhat.com>
References: <20240311215925.40618-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Define and export migration_thread_is_self to eliminate a dependency
on MigrationState.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Link: https://lore.kernel.org/r/1710179338-294359-7-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h | 1 +
 migration/migration.c    | 7 +++++++
 system/dirtylimit.c      | 5 +----
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 7526977de6..c4b5416357 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -61,6 +61,7 @@ void migration_object_init(void);
 void migration_shutdown(void);
 bool migration_is_idle(void);
 bool migration_is_active(void);
+bool migration_thread_is_self(void);
 bool migration_is_setup_or_active(void);
 bool migrate_mode_is_cpr(MigrationState *);
 
diff --git a/migration/migration.c b/migration/migration.c
index 546ba86c63..afe72af0b1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1647,6 +1647,13 @@ bool migration_is_active(void)
             s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
 }
 
+bool migration_thread_is_self(void)
+{
+    MigrationState *s = current_migration;
+
+    return qemu_thread_is_self(&s->thread);
+}
+
 bool migrate_mode_is_cpr(MigrationState *s)
 {
     return s->parameters.mode == MIG_MODE_CPR_REBOOT;
diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index b0afaa0776..ab20da34bb 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -25,7 +25,6 @@
 #include "sysemu/kvm.h"
 #include "trace.h"
 #include "migration/misc.h"
-#include "migration/migration.h"
 
 /*
  * Dirtylimit stop working if dirty page rate error
@@ -448,10 +447,8 @@ static void dirtylimit_cleanup(void)
  */
 static bool dirtylimit_is_allowed(void)
 {
-    MigrationState *ms = migrate_get_current();
-
     if (migration_is_running() &&
-        (!qemu_thread_is_self(&ms->thread)) &&
+        !migration_thread_is_self() &&
         migrate_dirty_limit() &&
         dirtylimit_in_service()) {
         return false;
-- 
2.44.0


