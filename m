Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC08D2E009
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 02:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3QpL-0001Ya-0h; Tue, 22 Oct 2024 22:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t3QpF-0001Xq-Gn
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 22:10:17 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t3QpB-0007dr-E4
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 22:10:15 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3e600add5dcso2357593b6e.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 19:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729649411; x=1730254211;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hb2OkrkcHnno8Skwipf6IKRUV4pB/qnGZMYm94e+N8U=;
 b=OJqfoMp69tzYYmeXrFVtJ2SL/96+Ub4lCRXrnyZRflKYjIViUmSU4Oh4V+rsO7N/rW
 lwfVsWTFw8Ckt24du4ZCW5KTQAEJorw2juQ0H95lbWJnUz1LX974EbDR79uDy7Gq/lGJ
 bhYqAZaf+CzS72X5v5LoItNxdfle61lA7NW/3/gjmNY9NwNeMiftrAO9RbNYsY97rseR
 t3pNWC3VrgGSGdVNJv5ApH1fRhDt8Asg3nTlV/0iOJ4XGYup61IzHiVwWtTT++Sjc4aW
 WQKXtYwdcrjG8YzW4tFYzhSXHsm3uCZvwuGW6yu2Qn+DRX8eMCuDM9+OSClmyEblXw5s
 0gbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729649411; x=1730254211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hb2OkrkcHnno8Skwipf6IKRUV4pB/qnGZMYm94e+N8U=;
 b=gb+9ZMtuN2/1p5juPQ09a5q08s0Ahx33ngDZhJ/AK2rJkyXzYGEx5guL5wBmUChzy0
 VNO54cxB118UKGfKIim4ff6iLKs21f+9SLUm2uaonIoLiOl7ADVRscvXyoJ17bsv3Puj
 Xfq3Rk+niv2P/vbu+/iVmFmXdLAMGj0UyhmR1tx0XiMWoJ86+6MkOTu42pR7DMdnFEsO
 bmoQYcXZraEGYsigYxPDVILyTmB09LmFBgpD4YRj7ZqulHD78D4y6/YjAnvx3rZDHgtl
 p0O6QYkSzVrMLYDgE4OABclGYBncGz8oF7RFOKuY4OB/rn4lA4rp9EXPMXzgVWr+isio
 5zew==
X-Gm-Message-State: AOJu0YwKVy3L8pvctBOvebdrl54j1RAgoYHD4yLGQf01Fuv/iYOAx8sH
 /DAWsMP0UPKKXYIA9UwJ+9syzlPMRF5iBDDEeKGHrTYuuq5kNB3ixMsXryWMasGViBw3yNhpPC8
 FQ8wBnA==
X-Google-Smtp-Source: AGHT+IH8o55cPEB9JfYynoU0C7q9SflAqczFJsFZ4FJvgvttwPgkKnI7DsNlsuXAxjm5HWLn18fHEg==
X-Received: by 2002:a05:6808:23c8:b0:3e6:1356:ad5e with SMTP id
 5614622812f47-3e624500ac4mr1076410b6e.13.1729649410173; 
 Tue, 22 Oct 2024 19:10:10 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([103.172.41.198])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7eaeab5839dsm5861849a12.47.2024.10.22.19.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 19:10:09 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH RFC 2/2] migration: Avoid doing RAMBlock dirty sync in the
 initial iteration
Date: Wed, 23 Oct 2024 10:09:51 +0800
Message-Id: <76f0ea57ac7f4c2a68203d17fec1c34bb3d16a4a.1729648695.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1729648695.git.yong.huang@smartx.com>
References: <cover.1729648695.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=yong.huang@smartx.com; helo=mail-oi1-x235.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

KVM always returns 1 when userspace retrieves a dirty bitmap for
the first time when KVM_DIRTY_LOG_INITIALLY_SET is enabled; in such
scenario, the RAMBlock dirty sync of the initial iteration can be
skipped.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 migration/cpu-throttle.c |  3 ++-
 migration/ram.c          | 30 +++++++++++++++++++++++++++---
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c
index 342681cdd4..06e3b1be78 100644
--- a/migration/cpu-throttle.c
+++ b/migration/cpu-throttle.c
@@ -27,6 +27,7 @@
 #include "hw/core/cpu.h"
 #include "qemu/main-loop.h"
 #include "sysemu/cpus.h"
+#include "sysemu/kvm.h"
 #include "cpu-throttle.h"
 #include "migration.h"
 #include "migration-stats.h"
@@ -141,7 +142,7 @@ void cpu_throttle_dirty_sync_timer_tick(void *opaque)
      * effect on guest performance, therefore omit it to avoid
      * paying extra for the sync penalty.
      */
-    if (sync_cnt <= 1) {
+    if (sync_cnt <= (kvm_dirty_log_manual_enabled() ? 0 : 1)) {
         goto end;
     }
 
diff --git a/migration/ram.c b/migration/ram.c
index d284f63854..b312ebd69d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2718,7 +2718,7 @@ static void ram_list_init_bitmaps(void)
 {
     MigrationState *ms = migrate_get_current();
     RAMBlock *block;
-    unsigned long pages;
+    unsigned long pages, clear_bmap_pages;
     uint8_t shift;
 
     /* Skip setting bitmap if there is no RAM */
@@ -2736,6 +2736,7 @@ static void ram_list_init_bitmaps(void)
 
         RAMBLOCK_FOREACH_NOT_IGNORED(block) {
             pages = block->max_length >> TARGET_PAGE_BITS;
+            clear_bmap_pages = clear_bmap_size(pages, shift);
             /*
              * The initial dirty bitmap for migration must be set with all
              * ones to make sure we'll migrate every guest RAM page to
@@ -2751,7 +2752,17 @@ static void ram_list_init_bitmaps(void)
                 block->file_bmap = bitmap_new(pages);
             }
             block->clear_bmap_shift = shift;
-            block->clear_bmap = bitmap_new(clear_bmap_size(pages, shift));
+            block->clear_bmap = bitmap_new(clear_bmap_pages);
+            /*
+             * Set the clear bitmap by default to enable dirty logging.
+             *
+             * Note that with KVM_DIRTY_LOG_INITIALLY_SET, dirty logging
+             * will be enabled gradually in small chunks using
+             * KVM_CLEAR_DIRTY_LOG
+             */
+            if (kvm_dirty_log_manual_enabled()) {
+                bitmap_set(block->clear_bmap, 0, clear_bmap_pages);
+            }
         }
     }
 }
@@ -2771,6 +2782,7 @@ static void migration_bitmap_clear_discarded_pages(RAMState *rs)
 
 static bool ram_init_bitmaps(RAMState *rs, Error **errp)
 {
+    Error *local_err = NULL;
     bool ret = true;
 
     qemu_mutex_lock_ramlist();
@@ -2783,7 +2795,19 @@ static bool ram_init_bitmaps(RAMState *rs, Error **errp)
             if (!ret) {
                 goto out_unlock;
             }
-            migration_bitmap_sync_precopy(false);
+
+            if (kvm_dirty_log_manual_enabled()) {
+                /*
+                 * Bypass the RAMBlock dirty sync and still publish a
+                 * notification.
+                 */
+                if (precopy_notify(PRECOPY_NOTIFY_AFTER_BITMAP_SYNC,
+                            &local_err)) {
+                    error_report_err(local_err);
+                }
+            } else {
+                migration_bitmap_sync_precopy(false);
+            }
         }
     }
 out_unlock:
-- 
2.27.0


