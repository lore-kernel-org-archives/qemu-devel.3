Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABE5D10380
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 21:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t45QO-0005hN-4K; Thu, 24 Oct 2024 17:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t45QL-0005fL-5D
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 17:31:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t45QJ-0005Zg-Lx
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 17:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729805475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vte9HPiXE32VhwFKsE2SGPglzqTAs5Z4orbp/UZZ2ec=;
 b=FvaLUDRBiXJRl8ITv5yw7iRjHH2dfWuUPK1qVqALa8fPwiTQi7y+iKKiFolc49LWEIDKoz
 fNQVdQ5iVpEEchlwkwMdyL2rZCYu0olnvmMDb97OQn95JhSkvo90r1e4f7k68wt4pBTbyN
 Rc0/hSjNCwXHFtoft6YnO+q5qCAhDK0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-U5Q76G8nP8-8Tjuft_Q-9g-1; Thu, 24 Oct 2024 17:31:13 -0400
X-MC-Unique: U5Q76G8nP8-8Tjuft_Q-9g-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7ac9b08cb77so207102185a.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 14:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729805473; x=1730410273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vte9HPiXE32VhwFKsE2SGPglzqTAs5Z4orbp/UZZ2ec=;
 b=PZclegvjxGBR1k+u4FSBBP9f0Y14oP32LrT7722FGpcYcxHwRa7Ri+2CFApMyorxJS
 DaWy2IGbCqEwZfbJNMK9iRae7HZffktA5Ac3PxiTBPXrpRcTgqwqZqxsON5DDjh/4xQ6
 pZdaaOnr9zC9uHY3tEKNauAGnrvA6uwwjxGKBWoaBspC0HhIY7bUcPdWlByg84Hn36tK
 zgpRyBykPBZYqsv0QbCmYlFp3J46U2YsYJ59ONe2wri3sVGUGV1LLjgYtDaM+mHoDryz
 Fz5sxEki1L7/gaF3gcH4TfcZFMZrXklu2cY5h8t9aw/lggPLRsCyf2IRxPYSxuAotq6A
 RGtQ==
X-Gm-Message-State: AOJu0YzadpGvYyUBxccNtQDDDh/mES3YMTorcPlaO7hObSpPYjgJDbm/
 N9t+0h9BLze627YvXEuewJGq4HECtKb3yBmJ7+402pXN2TydDi9+0R9GD+8YbOOH2/kBIxnBjdj
 aM8LZF0ikjVJuLxAXCLps3jp7wSThVItHg8wlsZkB9Rem7FA6y80buw6aJz0pIoE0gop4VGWAtP
 mIyoRHqLI7vqD2t9bpQPPGFuwB5YNHSV8Vsw==
X-Received: by 2002:ac8:5a52:0:b0:457:cab4:6e4a with SMTP id
 d75a77b69052e-4611471f04dmr108164791cf.37.1729805472866; 
 Thu, 24 Oct 2024 14:31:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQOcNK9ZtKvtLWG7+ZNpte+LVc/3X0MTpv+8D7V2VzBaT08OCRfXpMgl0wZJdfENNshehb4A==
X-Received: by 2002:ac8:5a52:0:b0:457:cab4:6e4a with SMTP id
 d75a77b69052e-4611471f04dmr108164411cf.37.1729805472410; 
 Thu, 24 Oct 2024 14:31:12 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460d3c3a434sm55465091cf.19.2024.10.24.14.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 14:31:11 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v3 7/8] migration: Unexport migration_is_active()
Date: Thu, 24 Oct 2024 17:30:55 -0400
Message-ID: <20241024213056.1395400-8-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241024213056.1395400-1-peterx@redhat.com>
References: <20241024213056.1395400-1-peterx@redhat.com>
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

We have two outside users of this API, so it's exported.

Is it really necessary?  Does it matter whether it must be
ACTIVE/POSTCOPY_ACTIVE/DEVICE?  I guess no.

The external user is trying to detect whether migration is running or not,
as simple as that.

To make the migration_is*() APIs even shorter, let's use
migration_is_running() for outside worlds.

Internally there're actually three places that literally needs
migration_is_active() rather than running().  Keep that an internal helper.

After this patch, we finally only export one helper that allows external
world to try detect migration status, which is migration_is_running().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h | 1 -
 migration/migration.h    | 1 +
 hw/vfio/common.c         | 4 ++--
 system/dirtylimit.c      | 3 +--
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index ad1e25826a..c0e23fdac9 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -53,7 +53,6 @@ void dump_vmstate_json_to_file(FILE *out_fp);
 void migration_object_init(void);
 void migration_shutdown(void);
 
-bool migration_is_active(void);
 bool migration_is_running(void);
 bool migration_thread_is_self(void);
 
diff --git a/migration/migration.h b/migration/migration.h
index 0956e9274b..9fa26ab06a 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -492,6 +492,7 @@ int migration_call_notifiers(MigrationState *s, MigrationEventType type,
 
 int migrate_init(MigrationState *s, Error **errp);
 bool migration_is_blocked(Error **errp);
+bool migration_is_active(void);
 /* True if outgoing migration has entered postcopy phase */
 bool migration_in_postcopy(void);
 bool migration_postcopy_is_alive(MigrationStatus state);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index cc72282c71..7eb99ebd4d 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -174,7 +174,7 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
 {
     VFIODevice *vbasedev;
 
-    if (!migration_is_active()) {
+    if (!migration_is_running()) {
         return false;
     }
 
@@ -219,7 +219,7 @@ vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer)
 {
     VFIODevice *vbasedev;
 
-    if (!migration_is_active()) {
+    if (!migration_is_running()) {
         return false;
     }
 
diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index ab20da34bb..d7a855c603 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -80,8 +80,7 @@ static void vcpu_dirty_rate_stat_collect(void)
     int i = 0;
     int64_t period = DIRTYLIMIT_CALC_TIME_MS;
 
-    if (migrate_dirty_limit() &&
-        migration_is_active()) {
+    if (migrate_dirty_limit() && migration_is_running()) {
         period = migrate_vcpu_dirty_limit_period();
     }
 
-- 
2.45.0


