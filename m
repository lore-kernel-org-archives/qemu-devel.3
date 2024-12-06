Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E86E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 22:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJh7S-0004Nn-6t; Fri, 06 Dec 2024 17:48:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJh7Q-0004ND-V1
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 17:48:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJh7P-0002Qb-AK
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 17:48:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733525294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VcILogkNzClRSFChag2j5EOuO0zmv9yeRvDNl/B1JUw=;
 b=U3h+qZb6mhYeV1kt/DEyTV/JndJEjhH+1IcTHrOTUn786CXDRel2ilMTbklGE3+WQwCV4b
 1WUlrVj/GH2pJKJSI9orYS3eOsV6yhvwqS04i64SxNBfl3ZQuooDXuuWK7FV4WzSGiRrM2
 njeZ9UFERSDbWt74apCybBuahS8TTNg=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-Z6qYBrHZPQWJ2T50a1OJ1g-1; Fri, 06 Dec 2024 17:48:13 -0500
X-MC-Unique: Z6qYBrHZPQWJ2T50a1OJ1g-1
X-Mimecast-MFC-AGG-ID: Z6qYBrHZPQWJ2T50a1OJ1g
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-84181157edbso247549939f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 14:48:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733525292; x=1734130092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VcILogkNzClRSFChag2j5EOuO0zmv9yeRvDNl/B1JUw=;
 b=AqaFB92Wwd0Eu+UarxdsSaT00KshPXWX+4FIk9fZbQEHaFOK+euBh378i4Xrg06ia4
 cYUGnsr+l5hbdBxfPv/PfEGPM9hvKF7N27x7tTIhJkkaoZFgO4FRQFdIlzeNHk50XhTk
 KF7X3rE1Agi2Nyt7TSFMYE3NvAHIfyC9enTrOC7Pdamy1pS7ZUf4xMZbk/YOsjc8ep2S
 1eBWImJRJdwhAXRGI79wj9NH5L3j6wzxwxD0uT/LTCboNRb2MnFtHkftBRcUjXEXHIuB
 3Ovmgby2kPKzPUSko10R46bantGDf6NZkCfOlpgX7nwGaUbBIh7Mtelx0lxqn4RMuxPt
 1nrQ==
X-Gm-Message-State: AOJu0Yx8e0az0BtBkbt+17qQCIrGXHYnS5rfjSZCU1MCChLE5NaIM7/9
 vIL9VOzHqbWSMpQXPaoqh3cLrHZnu2RZPiKP6iKvWciliSqPCTkL0eWtgX1AJD/+Uubm/aRSz7P
 enRKnWxDaaC2lwxvFiuFUHtoUs1KZsGOuDR/1TdjkHYtNsgXuryKMgv4c6HSyaXoNc+b5ufbEJi
 LObEi6dW36H7exP5Hkgm+Z2fE5jxx+3muehA==
X-Gm-Gg: ASbGncvzhpuqCLZglqul+rT0JA473HA0zYKN7TeSaquXuOYFDw2AEBYynANyWYIGvvT
 Bl1A6StiqqWZtxtlPdpNGUukb2IJ2xc2RjebFd0XkipAPRYonN6Rvwa3DyPlhPm00Rv10n4dZUW
 nkEqmIf8yx6BXOi43ErZadMU7digWz9P2TKIpBBgXs7o2bFy9zbDhP3OWUEZ74FeNaveIFwE2n1
 oDpYoJyLqc5eRQyTVPsugHr2Bi/jUJn2YL4WjI+mhdUFRiIIaAb2x4bp42Z/6KzzTWHxh7oybqx
 ZCzrdmJJKZo+uqyUxyMCemgWmg==
X-Received: by 2002:a05:6602:6002:b0:83a:c0ba:73c6 with SMTP id
 ca18e2360f4ac-8447e2bcd22mr522332139f.11.1733525292312; 
 Fri, 06 Dec 2024 14:48:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFp4Tw4BsBCUsKd2ABGGRFGlSO7HAA1Q8gQ0DYuA69AGs+18LqF/peLiZcN/ssGfJOr20bvNQ==
X-Received: by 2002:a05:6602:6002:b0:83a:c0ba:73c6 with SMTP id
 ca18e2360f4ac-8447e2bcd22mr522330039f.11.1733525291908; 
 Fri, 06 Dec 2024 14:48:11 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a5bd28sm125601439f.38.2024.12.06.14.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 14:48:11 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, peterx@redhat.com,
 Avihai Horon <avihaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 6/7] migration/multifd: Cleanup src flushes on condition
 check
Date: Fri,  6 Dec 2024 17:47:54 -0500
Message-ID: <20241206224755.1108686-7-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206224755.1108686-1-peterx@redhat.com>
References: <20241206224755.1108686-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

The src flush condition check is over complicated, and it's getting more
out of control if postcopy will be involved.

In general, we have two modes to do the sync: legacy or modern ways.
Legacy uses per-section flush, modern uses per-round flush.

Mapped-ram always uses the modern, which is per-round.

Introduce two helpers, which can greatly simplify the code, and hopefully
make it readable again.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h        |  2 ++
 migration/multifd-nocomp.c | 42 ++++++++++++++++++++++++++++++++++++++
 migration/ram.c            | 10 +++------
 3 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index 0fef431f6b..bd785b9873 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -355,6 +355,8 @@ static inline uint32_t multifd_ram_page_count(void)
 void multifd_ram_save_setup(void);
 void multifd_ram_save_cleanup(void);
 int multifd_ram_flush_and_sync(QEMUFile *f);
+bool multifd_ram_sync_per_round(void);
+bool multifd_ram_sync_per_section(void);
 size_t multifd_ram_payload_size(void);
 void multifd_ram_fill_packet(MultiFDSendParams *p);
 int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp);
diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 58372db0f4..c1f686c0ce 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -344,6 +344,48 @@ retry:
     return true;
 }
 
+/*
+ * We have two modes for multifd flushes:
+ *
+ * - Per-section mode: this is the legacy way to flush, it requires one
+ *   MULTIFD_FLAG_SYNC message for each RAM_SAVE_FLAG_EOS.
+ *
+ * - Per-round mode: this is the modern way to flush, it requires one
+ *   MULTIFD_FLAG_SYNC message only for each round of RAM scan.  Normally
+ *   it's paired with a new RAM_SAVE_FLAG_MULTIFD_FLUSH message in network
+ *   based migrations.
+ *
+ * One thing to mention is mapped-ram always use the modern way to sync.
+ */
+
+/* Do we need a per-section multifd flush (legacy way)? */
+bool multifd_ram_sync_per_section(void)
+{
+    if (!migrate_multifd()) {
+        return false;
+    }
+
+    if (migrate_mapped_ram()) {
+        return false;
+    }
+
+    return migrate_multifd_flush_after_each_section();
+}
+
+/* Do we need a per-round multifd flush (modern way)? */
+bool multifd_ram_sync_per_round(void)
+{
+    if (!migrate_multifd()) {
+        return false;
+    }
+
+    if (migrate_mapped_ram()) {
+        return true;
+    }
+
+    return !migrate_multifd_flush_after_each_section();
+}
+
 int multifd_ram_flush_and_sync(QEMUFile *f)
 {
     MultiFDSyncReq req;
diff --git a/migration/ram.c b/migration/ram.c
index 154ff5abd4..5d4bdefe69 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1302,9 +1302,7 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
         pss->page = 0;
         pss->block = QLIST_NEXT_RCU(pss->block, next);
         if (!pss->block) {
-            if (migrate_multifd() &&
-                (!migrate_multifd_flush_after_each_section() ||
-                 migrate_mapped_ram())) {
+            if (multifd_ram_sync_per_round()) {
                 QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
                 int ret = multifd_ram_flush_and_sync(f);
                 if (ret < 0) {
@@ -3178,8 +3176,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
 
 out:
     if (ret >= 0 && migration_is_running()) {
-        if (migrate_multifd() && migrate_multifd_flush_after_each_section() &&
-            !migrate_mapped_ram()) {
+        if (multifd_ram_sync_per_section()) {
             ret = multifd_ram_flush_and_sync(f);
             if (ret < 0) {
                 return ret;
@@ -3252,8 +3249,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         }
     }
 
-    if (migrate_multifd() &&
-        migrate_multifd_flush_after_each_section()) {
+    if (multifd_ram_sync_per_section()) {
         /*
          * Only the old dest QEMU will need this sync, because each EOS
          * will require one SYNC message on each channel.
-- 
2.47.0


