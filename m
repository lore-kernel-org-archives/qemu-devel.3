Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F196C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOnj-0003qM-VQ; Tue, 23 Apr 2024 18:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmm-0001eX-6R
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmj-0006EH-Mp
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713911924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EUtHlfX2nTFHPruBjJiUdQOS24ntEf+LIZAnj555ALk=;
 b=DHRzp4iKLXFh3F8C6afiBR9EWZED+u+eJr2lV4mjo/GFErAtVGRXw6/lEAswVmNiP5dYJe
 ZzHWOppv3yLPxFuGh9eQz0EdEn1Y8y41VNBYvo5NSBLGGLL3rDYUpAeSp9q4JKDUu4e7f+
 EL7UwqOxii0ABPm5raVHlSCo9LQc7/I=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-1gAGtEN3PuS_zQOMv0hkXQ-1; Tue, 23 Apr 2024 18:38:42 -0400
X-MC-Unique: 1gAGtEN3PuS_zQOMv0hkXQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6a05ab06d96so15361296d6.3
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713911921; x=1714516721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EUtHlfX2nTFHPruBjJiUdQOS24ntEf+LIZAnj555ALk=;
 b=fLnuN6yei91Lc2ewm4vqLNeRpy42YTiASK/K85N15Iv1C+MuNY2k9X+I1m/nDpPOh0
 BkELlKTj1avvLxs9vqCSUAObUCI4Kz0CVa4t24WJvAc5u1CMkE2R95BpoheJn+uo/qxb
 VR2qNImDIu4rWwo105X1K7g4ndGSjzdR0I/aC6VJIpFqIP75fKesDyS9Zpj9W/6PXBvj
 geh5SobbD4/Ih0uJsBruJfyJshzeGacYh0FB1DOhTKIZRM/lMtZbQS7jl62ylXCYQ0Xv
 pJIiA/Ov59o68CQR6PFh8RW2gixIIjh977jstwAbBJO53UbS14Lr1dpIu+pfOwNzmlLe
 6mPA==
X-Gm-Message-State: AOJu0YyOJ0c9joFlcWYFngIvw8PcnV/6CtVfw16M5xPXUzXz6P7CoEQ4
 jkoNxeTzCpcKeWrEuIHjy33YtyfdqthGsnCqZqAOgjlsBYnPB5fLMBCZ7YRMctKw+aKn+y3UKsv
 FTm7kyBcSdleYpII8K5Luk47NEFzzFskqZqqxuaDxYyhCvhX82x4TqTe6/uU/374ayWXy+Zg96/
 P5tUVkWOCAaqw0TK+wls1xZaMQy9hCKCPprg==
X-Received: by 2002:a05:620a:29c7:b0:790:78ef:23fd with SMTP id
 s7-20020a05620a29c700b0079078ef23fdmr952312qkp.5.1713911920842; 
 Tue, 23 Apr 2024 15:38:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTFwIg+p39b16Ms2Mxe48XK5vjb7LRAsoaWfpJxYbpSY1ZSGdBTPfRRm4ceZv4Okodw4ApWg==
X-Received: by 2002:a05:620a:29c7:b0:790:78ef:23fd with SMTP id
 s7-20020a05620a29c700b0079078ef23fdmr952281qkp.5.1713911920094; 
 Tue, 23 Apr 2024 15:38:40 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c21-20020a05620a11b500b0078d67886632sm5647726qkk.37.2024.04.23.15.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 15:38:39 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [PULL 20/26] memory: Add Error** argument to the global_dirty_log
 routines
Date: Tue, 23 Apr 2024 18:38:07 -0400
Message-ID: <20240423223813.3237060-21-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423223813.3237060-1-peterx@redhat.com>
References: <20240423223813.3237060-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Cédric Le Goater <clg@redhat.com>

Now that the log_global*() handlers take an Error** parameter and
return a bool, do the same for memory_global_dirty_log_start() and
memory_global_dirty_log_stop(). The error is reported in the callers
for now and it will be propagated in the call stack in the next
changes.

To be noted a functional change in ram_init_bitmaps(), if the dirty
pages logger fails to start, there is no need to synchronize the dirty
pages bitmaps. colo_incoming_start_dirty_log() could be modified in a
similar way.

Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Paul Durrant <paul@xen.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hyman Huang <yong.huang@smartx.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Acked-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20240320064911.545001-12-clg@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/memory.h |  5 ++++-
 hw/i386/xen/xen-hvm.c |  2 +-
 migration/dirtyrate.c | 13 +++++++++++--
 migration/ram.c       | 23 +++++++++++++++++++++--
 system/memory.c       | 11 +++++------
 5 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 5555567bc4..c129ee6db7 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2570,8 +2570,11 @@ void memory_listener_unregister(MemoryListener *listener);
  * memory_global_dirty_log_start: begin dirty logging for all regions
  *
  * @flags: purpose of starting dirty log, migration or dirty rate
+ * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * Return: true on success, else false setting @errp with error.
  */
-void memory_global_dirty_log_start(unsigned int flags);
+bool memory_global_dirty_log_start(unsigned int flags, Error **errp);
 
 /**
  * memory_global_dirty_log_stop: end dirty logging for all regions
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index f6e9a1bc86..006d219ad5 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -669,7 +669,7 @@ void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
 void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
 {
     if (enable) {
-        memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION);
+        memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION, errp);
     } else {
         memory_global_dirty_log_stop(GLOBAL_DIRTY_MIGRATION);
     }
diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 1d2e85746f..d02d70b7b4 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -90,9 +90,15 @@ static int64_t do_calculate_dirtyrate(DirtyPageRecord dirty_pages,
 
 void global_dirty_log_change(unsigned int flag, bool start)
 {
+    Error *local_err = NULL;
+    bool ret;
+
     bql_lock();
     if (start) {
-        memory_global_dirty_log_start(flag);
+        ret = memory_global_dirty_log_start(flag, &local_err);
+        if (!ret) {
+            error_report_err(local_err);
+        }
     } else {
         memory_global_dirty_log_stop(flag);
     }
@@ -608,9 +614,12 @@ static void calculate_dirtyrate_dirty_bitmap(struct DirtyRateConfig config)
 {
     int64_t start_time;
     DirtyPageRecord dirty_pages;
+    Error *local_err = NULL;
 
     bql_lock();
-    memory_global_dirty_log_start(GLOBAL_DIRTY_DIRTY_RATE);
+    if (!memory_global_dirty_log_start(GLOBAL_DIRTY_DIRTY_RATE, &local_err)) {
+        error_report_err(local_err);
+    }
 
     /*
      * 1'round of log sync may return all 1 bits with
diff --git a/migration/ram.c b/migration/ram.c
index f0bd71438a..bade3e9281 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2862,18 +2862,32 @@ static void migration_bitmap_clear_discarded_pages(RAMState *rs)
 
 static void ram_init_bitmaps(RAMState *rs)
 {
+    Error *local_err = NULL;
+    bool ret = true;
+
     qemu_mutex_lock_ramlist();
 
     WITH_RCU_READ_LOCK_GUARD() {
         ram_list_init_bitmaps();
         /* We don't use dirty log with background snapshots */
         if (!migrate_background_snapshot()) {
-            memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION);
+            ret = memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION,
+                                                &local_err);
+            if (!ret) {
+                error_report_err(local_err);
+                goto out_unlock;
+            }
             migration_bitmap_sync_precopy(rs, false);
         }
     }
+out_unlock:
     qemu_mutex_unlock_ramlist();
 
+    if (!ret) {
+        ram_bitmaps_destroy();
+        return;
+    }
+
     /*
      * After an eventual first bitmap sync, fixup the initial bitmap
      * containing all 1s to exclude any discarded pages from migration.
@@ -3665,6 +3679,8 @@ int colo_init_ram_cache(void)
 void colo_incoming_start_dirty_log(void)
 {
     RAMBlock *block = NULL;
+    Error *local_err = NULL;
+
     /* For memory_global_dirty_log_start below. */
     bql_lock();
     qemu_mutex_lock_ramlist();
@@ -3676,7 +3692,10 @@ void colo_incoming_start_dirty_log(void)
             /* Discard this dirty bitmap record */
             bitmap_zero(block->bmap, block->max_length >> TARGET_PAGE_BITS);
         }
-        memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION);
+        if (!memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION,
+                                           &local_err)) {
+            error_report_err(local_err);
+        }
     }
     ram_state->migration_dirty_pages = 0;
     qemu_mutex_unlock_ramlist();
diff --git a/system/memory.c b/system/memory.c
index 86d6c33180..c02c1d4bed 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2937,10 +2937,9 @@ err:
     return false;
 }
 
-void memory_global_dirty_log_start(unsigned int flags)
+bool memory_global_dirty_log_start(unsigned int flags, Error **errp)
 {
     unsigned int old_flags;
-    Error *local_err = NULL;
 
     assert(flags && !(flags & (~GLOBAL_DIRTY_MASK)));
 
@@ -2952,7 +2951,7 @@ void memory_global_dirty_log_start(unsigned int flags)
 
     flags &= ~global_dirty_tracking;
     if (!flags) {
-        return;
+        return true;
     }
 
     old_flags = global_dirty_tracking;
@@ -2960,17 +2959,17 @@ void memory_global_dirty_log_start(unsigned int flags)
     trace_global_dirty_changed(global_dirty_tracking);
 
     if (!old_flags) {
-        if (!memory_global_dirty_log_do_start(&local_err)) {
+        if (!memory_global_dirty_log_do_start(errp)) {
             global_dirty_tracking &= ~flags;
             trace_global_dirty_changed(global_dirty_tracking);
-            error_report_err(local_err);
-            return;
+            return false;
         }
 
         memory_region_transaction_begin();
         memory_region_update_pending = true;
         memory_region_transaction_commit();
     }
+    return true;
 }
 
 static void memory_global_dirty_log_do_stop(unsigned int flags)
-- 
2.44.0


