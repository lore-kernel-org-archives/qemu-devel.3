Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5660AC71136
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 14:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ54r-00047k-NQ; Fri, 13 Jun 2025 10:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ54q-00047I-0F
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:08:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ54o-0001Tr-8o
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749823693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NKIjGXzbdqec1RdAiV0GytaZxUNeq+dQYEYp0p5xAUA=;
 b=bV/8h6+zA4xCZ325aqdZ+GwdHWIApfwjTS6y5V4RsLDpCGBIMZrpsHvUUgt03W572OgDQb
 Kgrandi1FyLBTkr7vbkOKiJZEs23qAFj8gSfL/V6T1xazZJhuWLKYpTMf9EoaoBovO7nOQ
 xnJFnrjcnkX8g5Zvrs14Dww0OYFT2PA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-TmeG_qZcPiK6hfwPjBmbzg-1; Fri, 13 Jun 2025 10:08:12 -0400
X-MC-Unique: TmeG_qZcPiK6hfwPjBmbzg-1
X-Mimecast-MFC-AGG-ID: TmeG_qZcPiK6hfwPjBmbzg_1749823692
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6fb3654112fso35289496d6.3
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 07:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749823691; x=1750428491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NKIjGXzbdqec1RdAiV0GytaZxUNeq+dQYEYp0p5xAUA=;
 b=WKm+dAt8BGEDTH60IEABjIyJUHnPDcC+zNgYRvDyHLFTM9oi4qJjEMVn9AqwCNsgT5
 ZeMVvGfkClSnjBvJirieBypEbooYpMMLYYf0lbvliXU2satW+QtKu8DCYz3pSvxwlXDP
 P0wveG9Ri7OGU7oSudvbyDBlCIPY0eXbUNIEnZTMLWacVWrkKeOJNiz16l2mbJnbVPiy
 PSXIUAqBC18Tk0nnYuObTB6/Pb8eUVkIRAwLpl8z4JxlHW1i7UmiH4LwUf7iVSsoL4UL
 klQC01IXkddMLRxuOrotdIDu8w89BHWczxsyWRFdc3NMUj8TVqUngs5dl6298h6zarT1
 D/JA==
X-Gm-Message-State: AOJu0Yzy7R2WALja4+XlgfQphrTn7nLb7Jlgf+D0JBogy0uZDeQk/H1V
 TQGmUAs8RaEmsPY/PX0MeEutZqvp+bs2nWBy2Cx4gQXEvXBSu1EEbCia6bOv/wECCFkPoeq1KoR
 Y/vH5vnCPWwIT+1SuQ73qE+MrzN68s7FwU4o0HdzDwx2NSpMJYb45DFiyYl4CGKWURR+P81gHeU
 r5DUnL8bB9o7268LZz2kPC8w3VlwaZOMgW7sIqWQ==
X-Gm-Gg: ASbGncuV/tkIh4+ujcrP+fa+QxBAin1FGq4E9g1BrmTfhi+6urMkTimb4XFpee55Ukq
 7RI8f6HgiLeTCDCQcXopRrGlAWJxqe5NOK/VrWqR0c3wlaude2Mlk+vhQ13l0yTYataKT+RRVyx
 DrLWrNd/AHxAB6CbHGF3wJA2674MuZ2DhI7x6opJ0nV6DyR3h9jV5iCn6E9xyMiWMhwTXGaxydH
 tLYX0lBSYGaL0pFMgwjV5z5i9mJyzbZZc5KFyQ82Ja4+o8eTGqTqLlXuhYa/lX9jEG29s5TTd2b
 whLHPsqU/oU=
X-Received: by 2002:a05:622a:488e:b0:494:b3eb:a4b9 with SMTP id
 d75a77b69052e-4a72ff36944mr50200681cf.51.1749823691498; 
 Fri, 13 Jun 2025 07:08:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9XGCpV9hvmABABAKMewX48tIED31Mb9Yg/2vjsWPFVKfsTWtg0OU9Uf4Xhbj3yEtFJTaSPg==
X-Received: by 2002:a05:622a:488e:b0:494:b3eb:a4b9 with SMTP id
 d75a77b69052e-4a72ff36944mr50200051cf.51.1749823690765; 
 Fri, 13 Jun 2025 07:08:10 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a52a1ddsm17384111cf.81.2025.06.13.07.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 07:08:09 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v3 05/11] migration: Drop save_live_complete_postcopy hook
Date: Fri, 13 Jun 2025 10:07:55 -0400
Message-ID: <20250613140801.474264-6-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613140801.474264-1-peterx@redhat.com>
References: <20250613140801.474264-1-peterx@redhat.com>
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
index bb04a4520d..3e20f8608a 100644
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


