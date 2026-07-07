Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA46DC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgzJw-0002Mw-NB; Tue, 07 Jul 2026 02:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgzJu-0002Da-LD
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:30:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgzJs-0007Bn-9O
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783405811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AFHGy4tBq00t0R5eWGT8REbeTwBgvPuvolIkuJG4p7g=;
 b=KbkAfrZiYPtuvr8+W/3i5DyeUTitdxJznLMPe+1P752ZTe4XJNIEOysYFyp5Nj8a+4b4P8
 KDev/ly2NUU9zn2ROA5Z3Kd87Gr+YPcLlS+87an1pCRAjN5dKgUTC4ut6j4Mw9eX7KOpod
 eLzVKAffqvkCGMVsVCtNObCUyC0rVss=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-s3GkJHXAMM6IKGEyl61HAw-1; Tue,
 07 Jul 2026 02:30:09 -0400
X-MC-Unique: s3GkJHXAMM6IKGEyl61HAw-1
X-Mimecast-MFC-AGG-ID: s3GkJHXAMM6IKGEyl61HAw_1783405808
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77C571806CA2; Tue,  7 Jul 2026 06:30:08 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.49])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 429A6180065F; Tue,  7 Jul 2026 06:30:06 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 21/27] migration: Fix "switchover" used as a verb in comments
 and docs
Date: Tue,  7 Jul 2026 08:29:14 +0200
Message-ID: <20260707062920.317302-22-clg@redhat.com>
In-Reply-To: <20260707062920.317302-1-clg@redhat.com>
References: <20260707062920.317302-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Avihai Horon <avihaih@nvidia.com>

"Switchover" is a noun; the verb form is "switch over".  Replace all
instances where "switchover" was incorrectly used as a verb in comments
and documentation.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260706085211.13905-17-avihaih@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 qapi/migration.json   | 4 ++--
 migration/migration.h | 6 +++---
 migration/migration.c | 4 ++--
 migration/savevm.c    | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index d2f42c4b0ffd0a9e6bb757b8d105fed89b423537..66bd900465a2d757baf863baa0937a18b4585d2a 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -509,7 +509,7 @@
 #
 # @switchover-ack: If enabled, migration will not stop the source VM
 #     and complete the migration until the destination has
-#     acknowledged that it is OK to switchover.  The acknowledgement
+#     acknowledged that it is OK to switch over.  The acknowledgement
 #     may depend, for example, on some device's data being loaded in
 #     the destination before doing switchover.  This can reduce
 #     downtime if devices that support this capability are present.
@@ -919,7 +919,7 @@
 #     migration can use during switchover phase, in bytes per
 #     second.  **Note:** this does not limit the bandwidth during
 #     switchover, but only for calculations when making decisions to
-#     switchover.  By default, this value is zero, which means QEMU
+#     switch over.  By default, this value is zero, which means QEMU
 #     will estimate the bandwidth automatically.  This can be set
 #     when the estimated value is not accurate, while the user is
 #     able to guarantee such bandwidth is available when switching
diff --git a/migration/migration.h b/migration/migration.h
index 44bce199cd8c3518998ad7204d599566d1ef9ddd..631421c784bc1cee7073ff6ff0011188fc810592 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -496,12 +496,12 @@ struct MigrationState {
      * migration progresses, the devices on the destination acknowledge
      * switchover, decreasing the counter. When the counter reaches zero, a
      * single ACK message is sent to the source via the return path, indicating
-     * that it's OK to switchover.
+     * that it's OK to switch over.
      *
      * In new switchover-ack, the source is the one that keeps track of a
      * pending ACKs counter. As migration progresses, the destination sends ACK
      * message per-device via the return path, which decrements the source
-     * counter. When the counter reaches zero, it's OK to switchover. During
+     * counter. When the counter reaches zero, it's OK to switch over. During
      * precopy, source-side devices may request additional ACKs, which increment
      * the counter again.
      *
@@ -521,7 +521,7 @@ struct MigrationState {
     /*
      * Indicates the number of pending ACKs from the destination. The value may
      * increase or decrease during precopy as new ACKs are requested or
-     * received. When zero is reached, it's OK to switchover. In legacy
+     * received. When zero is reached, it's OK to switch over. In legacy
      * switchover-ack, it's initialized to 1 and decreased to zero upon ACK.
      */
     uint32_t switchover_ack_pending_num;
diff --git a/migration/migration.c b/migration/migration.c
index 7d5acd93c32393c9611731ab153b23f4bbc826a3..9736c14458b9eb87e14ac242e7aff0c6b5bf6900 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3293,7 +3293,7 @@ static bool migration_iteration_next_ready(MigrationState *s,
                                            MigPendingData *pending)
 {
     /*
-     * If the estimated values already suggest us to switchover, mark this
+     * If the estimated values already suggest us to switch over, mark this
      * iteration finished, time to do a slow sync.
      */
     if (pending->total_bytes <= s->threshold_size) {
@@ -3418,7 +3418,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
             migration_iteration_go_next(s, &pending);
         }
 
-        /* Check can switchover after qemu_savevm_query_pending() */
+        /* Check if we can switch over after qemu_savevm_query_pending() */
         can_switchover = migration_can_switchover(s);
 
         /* Should we switch to postcopy now? */
diff --git a/migration/savevm.c b/migration/savevm.c
index bbb8d2b47c6452b228c67cbbdaacc7c333985be7..34dd06f9f732dee7d3c6d0458da8bb67f23d76b4 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2509,7 +2509,7 @@ static int loadvm_postcopy_handle_switchover_start(Error **errp)
 
 /*
  * If legacy switchover-ack is enabled but no device uses it, need to send an
- * ACK to source that it's OK to switchover.
+ * ACK to source that it's OK to switch over.
  */
 static int loadvm_switchover_ack_no_users_legacy(MigrationIncomingState *mis,
                                                  Error **errp)
-- 
2.54.0


