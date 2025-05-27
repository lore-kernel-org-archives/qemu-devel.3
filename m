Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E565C5B542
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 22:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK2KE-0004j1-2F; Tue, 27 May 2025 17:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK2KB-0004ip-IJ
 for qemu-devel@nongnu.org; Tue, 27 May 2025 17:59:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK2K9-00087F-Vi
 for qemu-devel@nongnu.org; Tue, 27 May 2025 17:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748383145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rF2PSs6USBeJMuUguzOMonpG6ikjGwbjJXliQR0arrg=;
 b=ImfMu2jOUyfCp4pnvCEtO9pi8hvBrcleBp0188c6+aQ1afrGdSvRHldujMgAPaDn8UTuXH
 QGu8OvWMRy2fMDS3ZvHVm7ixo5k3xs99xJVs1K9P6VQg2rE3uLo2gBTBuN5d0uZeQVMfTh
 K6JErlWgeAzOF0DvS+6S8ynYkVPlwJU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-EaEcmh-cNIKKfYPmgYR6cw-1; Tue, 27 May 2025 17:59:04 -0400
X-MC-Unique: EaEcmh-cNIKKfYPmgYR6cw-1
X-Mimecast-MFC-AGG-ID: EaEcmh-cNIKKfYPmgYR6cw_1748383143
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6faa63b1e32so5369466d6.0
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 14:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748383143; x=1748987943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rF2PSs6USBeJMuUguzOMonpG6ikjGwbjJXliQR0arrg=;
 b=d0LKEi/MN520ZMLIZmtFpAh+AJBeKPZ/NIoPrMMrLkdn7qSY5a1l9s0zILaEY6sGTA
 52PstMEwUmMniJINmFuzBLBOc1SCYXTFygrwbj2vITRpqjD3UAH4tD230Vd8ioSvWil3
 ndtmfM8KHIcJcVXFp/H6FG7De6cQ4l5RkQYYT0FbUdv3NJGG1xyH8qdqN1hrvfViR8EU
 Jeqys/DmNQ14/j4lQKuHQkSVR/L30plMBbj+nry020y3IoybMUXF0LCdZgmP6/l7TysU
 baUnKblsE7rra9dI1LyH1G88hHtJjKQOGpwJh9rLur7cdJFvBFJiM1JHYJFpHZiKgeo1
 HXaw==
X-Gm-Message-State: AOJu0YxSwNxriROFb+5Yp/7DMx/E8UY1fV/5BUbp8C+/fLCZPNCnkB/u
 Kq+AVi9OM4PaRiw8lNr2RZqz/F45lyBsR/y1axnzXZLd4VDIgTCrw6zFoCwUc4DYxXwsts2Bv/8
 elQNw0DPys4Ts5hAMF//uixGgvbJn2CwWx0prc26dTb/zeiuK00ao1gcP6rWbwb+PmEiqPfXCaj
 gScKqWnvBzrVPxYWoRitHHJCMHT2hVA4MpMl6xRw==
X-Gm-Gg: ASbGncsBJapS0lyQw3fnoIiaaNfIKWp2fLLjDd6K318tNN29nE8lQQE7nPYWFW2TRB/
 OGhPKwziJk9nE9M/2gm0EQdag6k8asa8mwnfMw1h3NZo9OLuL1vFGQdqtW+caXtc3Li5bSAZAj4
 8niS7+9yn3ZQrtWFz5Y7MVdlnzvPpNvo3hu7PFHh9pZWgVKi1AI4sbU6PeD+Z+1W9jsmj8ndH9Q
 ISZduz1S1yIc93GSBgGKPWohq6XAMUL5GKGh1Px8QEfCqv9gZnXdUv6+FeXkkg5PgWJHTkNp0F0
X-Received: by 2002:ad4:5d65:0:b0:6fa:b467:aa67 with SMTP id
 6a1803df08f44-6fab9ed8dd3mr37696146d6.20.1748383142845; 
 Tue, 27 May 2025 14:59:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8SoVaEMlGK+fQi+3yt3m9dO4UDt0f6WLopkzE/J/rNrC/TU5lxdeAVtJ2i/sLyTiMz3KzjQ==
X-Received: by 2002:ad4:5d65:0:b0:6fa:b467:aa67 with SMTP id
 6a1803df08f44-6fab9ed8dd3mr37695816d6.20.1748383142424; 
 Tue, 27 May 2025 14:59:02 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fabe4f27cdsm914516d6.49.2025.05.27.14.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 14:59:01 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 06/11] migration: Rename save_live_complete_precopy to
 save_complete
Date: Tue, 27 May 2025 17:58:45 -0400
Message-ID: <20250527215850.1271072-7-peterx@redhat.com>
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

Now after merging the precopy and postcopy version of complete() hook,
rename the precopy version from save_live_complete_precopy() to
save_complete().

Dropping the "live" when at it, because it's in most cases not live when
happening (in precopy).

No functional change intended.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/register.h   | 4 ++--
 hw/ppc/spapr.c                 | 2 +-
 hw/s390x/s390-stattrib.c       | 2 +-
 hw/vfio/migration.c            | 2 +-
 migration/block-dirty-bitmap.c | 2 +-
 migration/ram.c                | 2 +-
 migration/savevm.c             | 8 ++++----
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index e022195785..0510534515 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -78,7 +78,7 @@ typedef struct SaveVMHandlers {
     void (*save_cleanup)(void *opaque);
 
     /**
-     * @save_live_complete_precopy
+     * @save_complete
      *
      * Transmits the last section for the device containing any
      * remaining data at the end phase of migration.
@@ -95,7 +95,7 @@ typedef struct SaveVMHandlers {
      *
      * Returns zero to indicate success and negative for error
      */
-    int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
+    int (*save_complete)(QEMUFile *f, void *opaque);
 
     /**
      * @save_live_complete_precopy_thread (invoked in a separate thread)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 702f774cda..c5d30f2ebd 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2518,7 +2518,7 @@ static void htab_save_cleanup(void *opaque)
 static SaveVMHandlers savevm_htab_handlers = {
     .save_setup = htab_save_setup,
     .save_live_iterate = htab_save_iterate,
-    .save_live_complete_precopy = htab_save_complete,
+    .save_complete = htab_save_complete,
     .save_cleanup = htab_save_cleanup,
     .load_state = htab_load,
 };
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index f74cf32636..13a678a803 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -338,7 +338,7 @@ static const TypeInfo qemu_s390_stattrib_info = {
 static SaveVMHandlers savevm_s390_stattrib_handlers = {
     .save_setup = cmma_save_setup,
     .save_live_iterate = cmma_save_iterate,
-    .save_live_complete_precopy = cmma_save_complete,
+    .save_complete = cmma_save_complete,
     .state_pending_exact = cmma_state_pending,
     .state_pending_estimate = cmma_state_pending,
     .save_cleanup = cmma_save_cleanup,
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index b76697bd1a..33a71f8999 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -824,7 +824,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
     .state_pending_exact = vfio_state_pending_exact,
     .is_active_iterate = vfio_is_active_iterate,
     .save_live_iterate = vfio_save_iterate,
-    .save_live_complete_precopy = vfio_save_complete_precopy,
+    .save_complete = vfio_save_complete_precopy,
     .save_state = vfio_save_state,
     .load_setup = vfio_load_setup,
     .load_cleanup = vfio_load_cleanup,
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 6ee3c32a76..a061aad817 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -1248,7 +1248,7 @@ static bool dirty_bitmap_has_postcopy(void *opaque)
 
 static SaveVMHandlers savevm_dirty_bitmap_handlers = {
     .save_setup = dirty_bitmap_save_setup,
-    .save_live_complete_precopy = dirty_bitmap_save_complete,
+    .save_complete = dirty_bitmap_save_complete,
     .has_postcopy = dirty_bitmap_has_postcopy,
     .state_pending_exact = dirty_bitmap_state_pending,
     .state_pending_estimate = dirty_bitmap_state_pending,
diff --git a/migration/ram.c b/migration/ram.c
index 8b43b9e1e8..ed380ac86f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4545,7 +4545,7 @@ void postcopy_preempt_shutdown_file(MigrationState *s)
 static SaveVMHandlers savevm_ram_handlers = {
     .save_setup = ram_save_setup,
     .save_live_iterate = ram_save_iterate,
-    .save_live_complete_precopy = ram_save_complete,
+    .save_complete = ram_save_complete,
     .has_postcopy = ram_has_postcopy,
     .state_pending_exact = ram_state_pending_exact,
     .state_pending_estimate = ram_state_pending_estimate,
diff --git a/migration/savevm.c b/migration/savevm.c
index 26d32eb5a7..311f2a4c61 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1496,7 +1496,7 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
     int ret;
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
-        if (!se->ops || !se->ops->save_live_complete_precopy) {
+        if (!se->ops || !se->ops->save_complete) {
             continue;
         }
         if (se->ops->is_active) {
@@ -1509,7 +1509,7 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
         qemu_put_byte(f, QEMU_VM_SECTION_END);
         qemu_put_be32(f, se->section_id);
 
-        ret = se->ops->save_live_complete_precopy(f, se->opaque);
+        ret = se->ops->save_complete(f, se->opaque);
         trace_savevm_section_end(se->idstr, se->section_id, ret);
         save_section_footer(f, se);
         if (ret < 0) {
@@ -1583,7 +1583,7 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
         if (!se->ops ||
             (in_postcopy && se->ops->has_postcopy &&
              se->ops->has_postcopy(se->opaque)) ||
-            !se->ops->save_live_complete_precopy) {
+            !se->ops->save_complete) {
             continue;
         }
 
@@ -1598,7 +1598,7 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
 
         save_section_header(f, se, QEMU_VM_SECTION_END);
 
-        ret = se->ops->save_live_complete_precopy(f, se->opaque);
+        ret = se->ops->save_complete(f, se->opaque);
         trace_savevm_section_end(se->idstr, se->section_id, ret);
         save_section_footer(f, se);
         if (ret < 0) {
-- 
2.49.0


