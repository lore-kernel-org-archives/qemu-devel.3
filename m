Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D68BD5CCB9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 15:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6B51-0003Zk-1S; Wed, 30 Oct 2024 11:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B4z-0003Y3-Gd
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:57:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B4y-0007mg-1S
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730303871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VZ5QodDwv3ORch5PcuAUwF6k+gefMHdTNqxMB123ETI=;
 b=gOlpkz5Ya4USrMwPs3OavJcJOGlUwDD88IhxFPJRq0g3W9UuHGdAgWU7kUSPfnvXKEjxWE
 EDAto0ZUYHR+HIlXmKtLQb0Py249mfRzpBgG46k5iqxz0HUoQJE2YJhUnHfTjC7Jekvk6t
 ILyKoCd2MiBni+jzEkI5UuEo72TDjDY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-8A_QMoIfO9yxYq788YYSqw-1; Wed, 30 Oct 2024 11:57:50 -0400
X-MC-Unique: 8A_QMoIfO9yxYq788YYSqw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6cbebfc1725so186466d6.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 08:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730303869; x=1730908669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VZ5QodDwv3ORch5PcuAUwF6k+gefMHdTNqxMB123ETI=;
 b=pvUdrdh6vSs3K7bcFeYfJt1hng8CzxeW1WIvDatvx+yNbNNix0zxzSI+m6b2hzpGpe
 ZoA+NdOhSoZ+BJKTeyYVD+eyKOJ1dM8tcphUkTld7WDy75RBF1r/9UE+IYkZlJTO314Y
 S6zZTqUjFrLV5YHtgtNMXDX85+DqPT5SLvz1GSakV/GvEulTFI9CYy2XA0Ue+iF15km1
 IEDrzqx6S8XasWTd34nb8kXoXNv3XTEhELz0hpT83O7fmjQD7KHSosbBubIZq1hEwwKR
 iNPDS2hD3n0bgblzziptmmlAm1tGHzadEhpwuJvRGvmYkoW/kXjHgwKDkdwbfTtJt19f
 P8sA==
X-Gm-Message-State: AOJu0YzHP4/8cWWT/eO8RRq4xR0NC2tUVR5lhl8iFjGg6EZkCX8Qh7RN
 C8lOwhelvQBACZUEnEvDTp8hnT56BkS2SFKLSWp/8VuXn3NfN+I1/uhMqb37wULrGM+S37ib2B7
 f5v1PvwRy2njPqxzDoQWHI2p9m4R1ztAiaD6KCZ5SqV0yRXbBgCzuj6lOoRo/EBFPQoWHMw2ycx
 7arqqdSfUFO096ZkaoqZwK4oAAYGO2Rdah1Q==
X-Received: by 2002:a05:6214:53c4:b0:6cd:7a2e:4611 with SMTP id
 6a1803df08f44-6d18586cb75mr289116286d6.47.1730303869026; 
 Wed, 30 Oct 2024 08:57:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/wv7qlh6f7/e5ugfrqDXUMEEq5p/T3MBZIEc4Xt3a/cFaMRDBYx6M7SOUO4AMpF4erNSNfA==
X-Received: by 2002:a05:6214:53c4:b0:6cd:7a2e:4611 with SMTP id
 6a1803df08f44-6d18586cb75mr289115996d6.47.1730303868674; 
 Wed, 30 Oct 2024 08:57:48 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d19c57c1ffsm22802276d6.89.2024.10.30.08.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 08:57:47 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Hyman Huang <yong.huang@smartx.com>, Peter Xu <peterx@redhat.com>
Subject: [PULL 07/18] migration: Remove "rs" parameter in
 migration_bitmap_sync_precopy
Date: Wed, 30 Oct 2024 11:57:23 -0400
Message-ID: <20241030155734.2141398-8-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241030155734.2141398-1-peterx@redhat.com>
References: <20241030155734.2141398-1-peterx@redhat.com>
MIME-Version: 1.0
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

From: Hyman Huang <yong.huang@smartx.com>

The global static variable ram_state in fact is referred to by the
"rs" parameter in migration_bitmap_sync_precopy. For ease of calling
by the callees, use the global variable directly in
migration_bitmap_sync_precopy and remove "rs" parameter.

The migration_bitmap_sync_precopy will be exported in the next commit.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/283c335d61463bf477160da91b24da45cdaf3e43.1729146786.git.yong.huang@smartx.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 54d352b152..9b5b350405 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1088,9 +1088,10 @@ static void migration_bitmap_sync(RAMState *rs, bool last_stage)
     }
 }
 
-static void migration_bitmap_sync_precopy(RAMState *rs, bool last_stage)
+static void migration_bitmap_sync_precopy(bool last_stage)
 {
     Error *local_err = NULL;
+    assert(ram_state);
 
     /*
      * The current notifier usage is just an optimization to migration, so we
@@ -1101,7 +1102,7 @@ static void migration_bitmap_sync_precopy(RAMState *rs, bool last_stage)
         local_err = NULL;
     }
 
-    migration_bitmap_sync(rs, last_stage);
+    migration_bitmap_sync(ram_state, last_stage);
 
     if (precopy_notify(PRECOPY_NOTIFY_AFTER_BITMAP_SYNC, &local_err)) {
         error_report_err(local_err);
@@ -2782,7 +2783,7 @@ static bool ram_init_bitmaps(RAMState *rs, Error **errp)
             if (!ret) {
                 goto out_unlock;
             }
-            migration_bitmap_sync_precopy(rs, false);
+            migration_bitmap_sync_precopy(false);
         }
     }
 out_unlock:
@@ -3248,7 +3249,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
 
     WITH_RCU_READ_LOCK_GUARD() {
         if (!migration_in_postcopy()) {
-            migration_bitmap_sync_precopy(rs, true);
+            migration_bitmap_sync_precopy(true);
         }
 
         ret = rdma_registration_start(f, RAM_CONTROL_FINISH);
@@ -3330,7 +3331,7 @@ static void ram_state_pending_exact(void *opaque, uint64_t *must_precopy,
     if (!migration_in_postcopy()) {
         bql_lock();
         WITH_RCU_READ_LOCK_GUARD() {
-            migration_bitmap_sync_precopy(rs, false);
+            migration_bitmap_sync_precopy(false);
         }
         bql_unlock();
     }
-- 
2.45.0


