Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A036C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 22:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK2KE-0004j5-Lt; Tue, 27 May 2025 17:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK2KA-0004ic-32
 for qemu-devel@nongnu.org; Tue, 27 May 2025 17:59:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK2K8-00086u-9m
 for qemu-devel@nongnu.org; Tue, 27 May 2025 17:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748383143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yIlAgqOWKOqSEUzDQT/GOunQvqeaHzoRg1BUuH85Fug=;
 b=SPpKQ/nOn6sU1pwJL/vULcoqB0UdOTZhpjNchGU5TIbEHxNHe4vksJWJ3xkOFtAJt9XHtp
 cVttbhcFwSX97hHA84gUwvz592BfSYMXO34OJlUpDDqn+pd1fB0vINFIVn7OHY4U23tger
 WMqOEl/MMN0TS6ZEGpsx0ujRRffc2lM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-NZXDOMC3MnSH6DmW4n2-0w-1; Tue, 27 May 2025 17:59:02 -0400
X-MC-Unique: NZXDOMC3MnSH6DmW4n2-0w-1
X-Mimecast-MFC-AGG-ID: NZXDOMC3MnSH6DmW4n2-0w_1748383142
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4767e6b4596so64825991cf.2
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 14:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748383141; x=1748987941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yIlAgqOWKOqSEUzDQT/GOunQvqeaHzoRg1BUuH85Fug=;
 b=fjZDuz7/mE9Xc5523jjbVDf5Bk9XI7rlqJYextPQ9H5RMG8TpjcyhmdRACr5u6D4bE
 y3t13Y7S8ejsruDPFxKmwDggI3gX57SvQWhW3AKFDhLRftKCQT/Va0M1Zag1drsugIfD
 fRQwOwWnF9DW2RDkY1l53xNkxkYuByWT+CwyLH6YaAo2Ixx0YtgTgjNZ3mzhKyWbDyoJ
 GsV66Q8AyuWjM4tyIaI7yf6FVwTcy2P+lw/gUaX/LwH9Xw0wo8mjn7ZcyHH+q4xUyxvY
 MXtS05puBdz4DgoOpZZu5Lm0ygNAeK0EPxDgH2w/YKYUNhL5fTtQaUO+QUdcl18Nm3XN
 OX3g==
X-Gm-Message-State: AOJu0YxJ5RMcQBvPUP7PL4rtcASBZaBT+PlJv1tmvBxMtv1XiLswcYd4
 dPb5P0gUMK6OFz8/+2yaF71XDgdddaJbZjoveBGjWKCKmzGGCgjBVuXEI5rhDu4Pgcv8ACPFMyt
 r2w+Q0w97az1W4FxLG8U8Q4O2lwRqrKqP3IkZ3TgperJu9f/1xbJdc+jfK+25FYrMmulhgjjq6u
 z7f0nHWidL2qPY0Yw+n3h0095KcCvGlYIS4UaHlg==
X-Gm-Gg: ASbGncuCV9/HRvbJRgHZHE9jvdP8plMJl7okmLsLEDoTC0pLBX7mDStQ30TWvf7RHXl
 sB2+5xE571Yjs1EOtbfGvxiFGaSmWo1MLKvF7Jbo8mOUezHlczOLy4PvdDEDTvUkONv21u2c1Vp
 4l+uJqQtFhWYTemFxTgQpnvAwGtpoV4utIVxloumJSuw2wL3GQTa+gMLmd/yMXt47JIEOdNsYDn
 2rAR/DHynoUxbrY0TQQ+Fy60TcloReYHEBH8c29SuLYMi70oCB+8sjYwFYFcpY+ldOIW9V+8dZM
X-Received: by 2002:a05:622a:4a0e:b0:477:e4e:9186 with SMTP id
 d75a77b69052e-49f46056ff6mr286997351cf.11.1748383141279; 
 Tue, 27 May 2025 14:59:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvzgMi9lDKAaWu3e72Hl5Q1R15+d2Avli3uTMykXtQcTjXBk33uup36pkQFIxdUb8SZnZcWw==
X-Received: by 2002:a05:622a:4a0e:b0:477:e4e:9186 with SMTP id
 d75a77b69052e-49f46056ff6mr286996941cf.11.1748383140813; 
 Tue, 27 May 2025 14:59:00 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fabe4f27cdsm914516d6.49.2025.05.27.14.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 14:59:00 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 05/11] migration: Drop save_live_complete_postcopy hook
Date: Tue, 27 May 2025 17:58:44 -0400
Message-ID: <20250527215850.1271072-6-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527215850.1271072-1-peterx@redhat.com>
References: <20250527215850.1271072-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The hook is only defined in two vmstate users ("ram" and "block dirty
bitmap"), meanwhile both of them define the hook exactly the same as the
precopy version.  Hence, this postcopy version isn't needed.

No functional change intended.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/register.h   | 24 ++++++++----------------
 migration/block-dirty-bitmap.c |  1 -
 migration/ram.c                |  1 -
 migration/savevm.c             |  9 ++++-----
 4 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index b79dc81b8d..e022195785 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -77,26 +77,18 @@ typedef struct SaveVMHandlers {
      */
     void (*save_cleanup)(void *opaque);
 
-    /**
-     * @save_live_complete_postcopy
-     *
-     * Called at the end of postcopy for all postcopyable devices.
-     *
-     * @f: QEMUFile where to send the data
-     * @opaque: data pointer passed to register_savevm_live()
-     *
-     * Returns zero to indicate success and negative for error
-     */
-    int (*save_live_complete_postcopy)(QEMUFile *f, void *opaque);
-
     /**
      * @save_live_complete_precopy
      *
      * Transmits the last section for the device containing any
-     * remaining data at the end of a precopy phase. When postcopy is
-     * enabled, devices that support postcopy will skip this step,
-     * where the final data will be flushed at the end of postcopy via
-     * @save_live_complete_postcopy instead.
+     * remaining data at the end phase of migration.
+     *
+     * For precopy, this will be invoked _during_ the switchover phase
+     * after source VM is stopped.
+     *
+     * For postcopy, this will be invoked _after_ the switchover phase
+     * (except some very unusual cases, like PMEM ramblocks), while
+     * destination VM can be running.
      *
      * @f: QEMUFile where to send the data
      * @opaque: data pointer passed to register_savevm_live()
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index f2c352d4a7..6ee3c32a76 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -1248,7 +1248,6 @@ static bool dirty_bitmap_has_postcopy(void *opaque)
 
 static SaveVMHandlers savevm_dirty_bitmap_handlers = {
     .save_setup = dirty_bitmap_save_setup,
-    .save_live_complete_postcopy = dirty_bitmap_save_complete,
     .save_live_complete_precopy = dirty_bitmap_save_complete,
     .has_postcopy = dirty_bitmap_has_postcopy,
     .state_pending_exact = dirty_bitmap_state_pending,
diff --git a/migration/ram.c b/migration/ram.c
index fd8d83b63c..8b43b9e1e8 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4545,7 +4545,6 @@ void postcopy_preempt_shutdown_file(MigrationState *s)
 static SaveVMHandlers savevm_ram_handlers = {
     .save_setup = ram_save_setup,
     .save_live_iterate = ram_save_iterate,
-    .save_live_complete_postcopy = ram_save_complete,
     .save_live_complete_precopy = ram_save_complete,
     .has_postcopy = ram_has_postcopy,
     .state_pending_exact = ram_state_pending_exact,
diff --git a/migration/savevm.c b/migration/savevm.c
index 006514c3e3..26d32eb5a7 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1485,9 +1485,8 @@ bool should_send_vmdesc(void)
 }
 
 /*
- * Calls the save_live_complete_postcopy methods
- * causing the last few pages to be sent immediately and doing any associated
- * cleanup.
+ * Complete saving any postcopy-able devices.
+ *
  * Note postcopy also calls qemu_savevm_state_complete_precopy to complete
  * all the other devices, but that happens at the point we switch to postcopy.
  */
@@ -1497,7 +1496,7 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
     int ret;
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
-        if (!se->ops || !se->ops->save_live_complete_postcopy) {
+        if (!se->ops || !se->ops->save_live_complete_precopy) {
             continue;
         }
         if (se->ops->is_active) {
@@ -1510,7 +1509,7 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
         qemu_put_byte(f, QEMU_VM_SECTION_END);
         qemu_put_be32(f, se->section_id);
 
-        ret = se->ops->save_live_complete_postcopy(f, se->opaque);
+        ret = se->ops->save_live_complete_precopy(f, se->opaque);
         trace_savevm_section_end(se->idstr, se->section_id, ret);
         save_section_footer(f, se);
         if (ret < 0) {
-- 
2.49.0


