Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61129D10388
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 21:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t45QO-0005ht-Qy; Thu, 24 Oct 2024 17:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t45QK-0005fD-T8
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 17:31:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t45QJ-0005ZT-1z
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 17:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729805473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/6xFER4Y5so64URVhMy+JgrIVvXPCbxhauceydNM1kE=;
 b=aEUkbczaE/9ZbE1sFFayZ2r0Hsg/rJ6zYpd4rh4oDDsSytHG7DCLpfWulUJxqg/CIojFkP
 8BjgO7Hwa/of/3sh2XLPX1Cu4rHUt6vidwA1DfZVg/XJ2/aIibqniWrpJ10UK4AVWyZ0FL
 qmPQT+jlxh+p905l35PPj0YhpOs4A7U=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-ZPrxl4qHM9yPLOi-VXapIw-1; Thu, 24 Oct 2024 17:31:12 -0400
X-MC-Unique: ZPrxl4qHM9yPLOi-VXapIw-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-460dd31b4c1so20493181cf.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 14:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729805471; x=1730410271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/6xFER4Y5so64URVhMy+JgrIVvXPCbxhauceydNM1kE=;
 b=mBQr6GrKkYfAF85STJSNzERqIC39harh9+tCMjccrYsBxRKBW5cs5EiDheNEDWzXgo
 7iu7kx3UK12GE6LDfVkptZduy1rhtRbyxt3tA39xgt24IRw4fMwrsS1HSHYbbm8GryE4
 StWACVE2HSFU520u/S/NTIh+L4Oeh7+9u1tUDVD4D0GKvrJXdvf65oK8IM2p4++6JXIc
 mtzq55VLdm0VOM0dO0Q3AKY6sLjikx04cbuAN6uwaviLY6cXHLrxyU4mMbwvfr9CZz14
 Hw3vQyQ5wTmq/I9wBVaT//0gh6FyP8omxLQ7SQUYjHqB7S54o97KUxkrGJDomRacbozp
 OdGA==
X-Gm-Message-State: AOJu0Yx4G0N1tN5fLC/vrksG9VX7F7F1QYlRjGKiEWU1Tmac/TZ7uE2C
 GwvAQqkxYsjpCg3vGQNETaeJScVH1aNx+z/g7sFy/62fXZiWfBK8wLH5qyTAuCa96hqrtNrUyRy
 0AhgJSPXAWunpWgE7dqWqTPSGPeiwj19K87Crev31V8VcP/UEblkXqZSw8INJaEBZatQT7Smniv
 bq5K8nFsMQPxUTzp+gKBB1vxuSv4AUbCSu8g==
X-Received: by 2002:ac8:58d4:0:b0:460:42f7:fa3f with SMTP id
 d75a77b69052e-461145b938fmr109750001cf.19.1729805470827; 
 Thu, 24 Oct 2024 14:31:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3m0nKmt3RafhxwjJOPF+IsczbS53HQlvyevm7dIpOkCCIx4ascOxYgpbvG4H7ywL2aAz2vA==
X-Received: by 2002:ac8:58d4:0:b0:460:42f7:fa3f with SMTP id
 d75a77b69052e-461145b938fmr109749621cf.19.1729805470431; 
 Thu, 24 Oct 2024 14:31:10 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460d3c3a434sm55465091cf.19.2024.10.24.14.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 14:31:09 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v3 6/8] migration: Drop migration_is_device()
Date: Thu, 24 Oct 2024 17:30:54 -0400
Message-ID: <20241024213056.1395400-7-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241024213056.1395400-1-peterx@redhat.com>
References: <20241024213056.1395400-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
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

This only checks the DEVICE stage, which is a very special stage, and only
checked together with ACTIVE+POSTCOPY_ACTIVE.

It's debatable why this needs a separate helper just to be exported.
Theoretically speaking, DEVICE stage is also part of ACTIVE stage, where
we're reaching the switchover phase but waiting for some external
operation, during which VM stopped but migration is definitely active.

Report DEVICE as active too, then we can drop migration_is_device().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h |  1 -
 hw/vfio/common.c         |  2 +-
 migration/migration.c    | 19 +++++++++----------
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 804eb23c06..ad1e25826a 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -54,7 +54,6 @@ void migration_object_init(void);
 void migration_shutdown(void);
 
 bool migration_is_active(void);
-bool migration_is_device(void);
 bool migration_is_running(void);
 bool migration_thread_is_self(void);
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index dcef44fe55..cc72282c71 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -174,7 +174,7 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
 {
     VFIODevice *vbasedev;
 
-    if (!migration_is_active() && !migration_is_device()) {
+    if (!migration_is_active()) {
         return false;
     }
 
diff --git a/migration/migration.c b/migration/migration.c
index f86c709699..127b01734d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1638,17 +1638,16 @@ bool migration_in_bg_snapshot(void)
 
 bool migration_is_active(void)
 {
-    MigrationState *s = current_migration;
-
-    return (s->state == MIGRATION_STATUS_ACTIVE ||
-            s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
-}
+    MigrationStatus state = current_migration->state;
 
-bool migration_is_device(void)
-{
-    MigrationState *s = current_migration;
-
-    return s->state == MIGRATION_STATUS_DEVICE;
+    switch (state) {
+    case MIGRATION_STATUS_ACTIVE:
+    case MIGRATION_STATUS_POSTCOPY_ACTIVE:
+    case MIGRATION_STATUS_DEVICE:
+        return true;
+    default:
+        return false;
+    }
 }
 
 bool migration_thread_is_self(void)
-- 
2.45.0


