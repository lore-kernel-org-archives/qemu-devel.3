Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A58FC5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 16:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOfDO-000072-HU; Mon, 09 Jun 2025 12:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOfDM-0008TN-1s
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOfDK-0004UT-7q
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749485949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E2XIrWaj9CYKaBSgFOHuJujnQV0+UP1da/Qg7ZHotwM=;
 b=iRcNtdtFA3xo5EZvrLdoZIA68Td1aQ6wWz9KUv97kC8a8Fkeus/3/D0LTpCACnu9m0oLlN
 ikkXWJdPQyS9kK/sQo3bF4OL0R/4cYhWcphayHFoQCDcCmI4IFgGQO9ZxRbSMx776EBmpX
 /MRDFXr6W6TiCztoU7UXGxfgsQGiTSE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-mrFf8H7uNkS7B5Ikl1564A-1; Mon, 09 Jun 2025 12:19:08 -0400
X-MC-Unique: mrFf8H7uNkS7B5Ikl1564A-1
X-Mimecast-MFC-AGG-ID: mrFf8H7uNkS7B5Ikl1564A_1749485948
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4a589edc51aso110240671cf.0
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 09:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749485947; x=1750090747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E2XIrWaj9CYKaBSgFOHuJujnQV0+UP1da/Qg7ZHotwM=;
 b=ZhH7T1ykyDbvboivUPZnJHovMhnFrufq5tIZQxKfXpipMjwlX8Uea7Uo3OfdB+5bJu
 w3ME4VyTCoGBZDgCN4tZOXQOVuGUT/ryyz/dpM6srrGZ6qCcVneL2DSYMxoKLm6VR8ut
 Ibjb+UgnkrlXDJiRbtE6xBBuPYKxbYBXQciFBqPLk4t8AU9DymEzyXYxAYuECyLIk/C+
 U2n6UzDeatzWzq8hW2rnDSpXbhS1XgSwiTN7uevawE8UtHUK5m6f66uZzwN2yDaHTSci
 VDd9By8dNkl6mT063MsW9k9LHIlw4C2pSI4h7w0ERVcfsOty/uSCnV9jhNAvO6cKEFYv
 hLSQ==
X-Gm-Message-State: AOJu0YwPI+sOuUTcmSBTPEVKM4IsG4AZS83YZrIMd8i7tCA3uNuoNTl/
 vtoWKLEFCwA0NBQoWZAije4ynLLbv9/rkZwT7FBUmQYoXj33dvpdAQ4iVHGAsi/kF6Q7Ni/4go0
 5wvtqGm9ra9JlEpAxbIwBa1QO5Stj27ct0k3Q/vAJc515zkYliRczdpsc97jKm0olXJplyMx7H+
 6hhD3os/6kQupioeMw2WvPiAR1aJkzPcHUnYcHIA==
X-Gm-Gg: ASbGncvuI7NCwWHaSLtxFMf+Jgy4oY/by0k8n4UhljlVn1/YiuQTiP7fVVMf9mZ3PbB
 syyAKg7G3kMk2veazCSN0Dc4pmpb5vhWkCQhh5iA2UI5DRI3+F4fBxVhOATWz2biREzzly+yf6i
 24Vr3rAWuX066SeQw+DagjrULqrWQR1FbJYmz/fFygD8XMHDhTos2amasTDLtTr9cFdBp+xDJko
 lgtAq1y21lrGy7YLqcHOFUwh7csIXQjyQ18fole7UO9nL9FQrk4CjuZCo7DfsIvbRpjtzNOE5ky
 xpA=
X-Received: by 2002:a05:6214:20c7:b0:6fa:ce1e:3a4a with SMTP id
 6a1803df08f44-6fb08fc6ec0mr195196896d6.6.1749485947350; 
 Mon, 09 Jun 2025 09:19:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3Li2VPoezz6Q8AEAfKnkYbp58kYo0Z7wiDWd8H64XkJPG1gTnWt2uB8ibeo/qWHffpb8ucg==
X-Received: by 2002:a05:6214:20c7:b0:6fa:ce1e:3a4a with SMTP id
 6a1803df08f44-6fb08fc6ec0mr195196436d6.6.1749485946943; 
 Mon, 09 Jun 2025 09:19:06 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09ab95c1sm53420546d6.15.2025.06.09.09.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 09:19:06 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 06/11] migration: Rename save_live_complete_precopy to
 save_complete
Date: Mon,  9 Jun 2025 12:18:50 -0400
Message-ID: <20250609161855.6603-7-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609161855.6603-1-peterx@redhat.com>
References: <20250609161855.6603-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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
index dfb67bf679..7dba367d33 100644
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


