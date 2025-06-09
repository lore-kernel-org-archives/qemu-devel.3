Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE66C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 16:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOfDN-00004z-KH; Mon, 09 Jun 2025 12:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOfDL-0008Q7-59
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:19:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOfDJ-0004UI-E8
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749485948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NnxHrY3AJ2xlwMfJ+++pzxNv1sP7IaifMp2sR6DUt4w=;
 b=LqQt5ZI/NDBIORlrqazF147A1CtocWiU2kuR9VBi65SbB/3wEj5gxDGaO9/Izd2fQ0tMjM
 kWTsYtWedEsouhEoVM4CE0dAJ5aNs5iFhkN0SPaCVLeZ2ls1TBdvDekSs4a0BOwWFB5L73
 7xma5ZQSMpVSMzPVNI0x22wPxFJ+o9g=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-kNc7-JLBOoqqQJU6hkdtpg-1; Mon, 09 Jun 2025 12:19:07 -0400
X-MC-Unique: kNc7-JLBOoqqQJU6hkdtpg-1
X-Mimecast-MFC-AGG-ID: kNc7-JLBOoqqQJU6hkdtpg_1749485947
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6fac71417c2so74564106d6.0
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 09:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749485947; x=1750090747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NnxHrY3AJ2xlwMfJ+++pzxNv1sP7IaifMp2sR6DUt4w=;
 b=GfR48ndmMOTddUZaZv9Hoikr0Sh/H5EN9ifqCXdF3NVidfFiHDc74ET8cqJqUrjmFY
 kdskUInFpVx/AYAH6+ZdlCedN7xGx7QXsI+1IT390orvlATco5YZ4xoA2gLMJ6wpxGe9
 kOMemh9HzChmvthXQOboJeEh4+3AZB5C6DH6d9ZXCHwGQVwiBs81qshyyJIwkD+azB6q
 BiN5fj9gSQiYkhxVUg54IEy5ZaoZgCBWouMuey3b22GMf+UlF6tgAcP+iN4GurR72E8D
 h6toGJ8eIynwlMU4zNWlRHBR8MbKNc3vK26GpbeAIjuwYrJbgizYktIfux1WqwEt7vGQ
 yLUw==
X-Gm-Message-State: AOJu0YwIfvgytETQ1bDhuX5oldFiIBpVj7YH4oaStWnmkCLJ92JcjN5j
 tvjx/Gv8OmTej4lvHj5WTFD8C27GCFORAZ2h7gkKtRPkAVVxsOCe6SGlnk5z8xpQtQ+kuhVUHqo
 NSi6IscXNtgQ5PN5PNO1YR+kG4dcuerjkg8WoZ2JQpqMpOQZ+ennZm08iqk35ZUTnlJT6AX25Jz
 oIiU+HsFXRpnZLyPcLGGi5MVK5Dwk2pEiOCYBSEA==
X-Gm-Gg: ASbGnctqZV1A7Onq6OqpVlEazpxHCR+nzxApndAPjnYe3AITjOsceQJdUr5AiIDjhuI
 HBbT6ljV0n975cYPnbd6YVEDHgjjX55fyloqi/TtLy67+O61ASm9o66dPOXwW6XH0YRFqjrWEg7
 dsIwohDEAe9XHiUgN+ezkcma9wZ7O98WJ6/5kda5qXW4KvkuLlgerrZxO5uCh+DGAJmwkDwfVHh
 uQcLq+r7EktQQkkswcf8o9NCP4MlsfSC0F7zcu2mkUJeUrEHVF7GSm/1AhcuOUrpVud3akueVr0
 laNFwUYCv/8rzA==
X-Received: by 2002:a05:6214:2426:b0:6fa:ba15:e8a with SMTP id
 6a1803df08f44-6fb08f528f2mr247163246d6.8.1749485946435; 
 Mon, 09 Jun 2025 09:19:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdR9M9mqDnSkJ0Ov1KR09buxe0cj4YRwBACfz3UNZTaymfuPunJEKUtdyFpauNG2MC8rRDtg==
X-Received: by 2002:a05:6214:2426:b0:6fa:ba15:e8a with SMTP id
 6a1803df08f44-6fb08f528f2mr247162256d6.8.1749485945689; 
 Mon, 09 Jun 2025 09:19:05 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09ab95c1sm53420546d6.15.2025.06.09.09.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 09:19:04 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 05/11] migration: Drop save_live_complete_postcopy hook
Date: Mon,  9 Jun 2025 12:18:49 -0400
Message-ID: <20250609161855.6603-6-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609161855.6603-1-peterx@redhat.com>
References: <20250609161855.6603-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
index 52105dd2f1..dfb67bf679 100644
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


