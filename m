Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEC9C71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 14:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ55d-0004Mw-9X; Fri, 13 Jun 2025 10:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ55c-0004Mn-4O
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:09:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ55a-0001dL-6O
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749823741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FGb3RLqEsP5Ser5SoCct0WTAVrJhRlNVodLholPOw40=;
 b=eAYoja65AkHtADJB9M10OcjMQWBwaZodVXTVYSG/oau6XOB4L8zLeQZecre8GQilmkIn5+
 Gady+gwhE0WPe0B9C+ZsSMTEv9STigqsLfBs9v8tL49zMbxwO6tJ6yTPUeJcrGY6lUk7oB
 Cfnw87tS4Mkj8XoA46gsdpWEB59bHvc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-hZ8xyk3SMQij7tWrIrV5uQ-1; Fri, 13 Jun 2025 10:08:19 -0400
X-MC-Unique: hZ8xyk3SMQij7tWrIrV5uQ-1
X-Mimecast-MFC-AGG-ID: hZ8xyk3SMQij7tWrIrV5uQ_1749823699
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4a6f2dbdf84so33872951cf.0
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 07:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749823699; x=1750428499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FGb3RLqEsP5Ser5SoCct0WTAVrJhRlNVodLholPOw40=;
 b=HLeBd+kTT0fRQwQ2DKKL/0KJ2J1RfrCnIp28sNoHnfKd/Zy9vHV+XcIIlfW5usLMG/
 9RvDapUYL/etjdLyi0WAHW1MlSdJoH2dZDHnhFmrfnrf4XZaiME5QtbJ+IqL/trmcgUM
 J0GLjeoOu4m2Ub/BIbSd6fAX9mtY5MncLSDiCs4miWZd0H+XZEcHkD0UMYhQx11mva+G
 sXAXihDPTLBoLqm/qink8YtYG/V2RZAfqx+yHilpNhCDJUGKao9HxpvL8RlA7uUcoQzq
 nPEkloYugJE/c6UwN009BemPq1jSTCcfHb7GhntjwdrEHpG4ripcHS088CxSIY/aMf4w
 RsNA==
X-Gm-Message-State: AOJu0YweMchYywTDo0+ClMNpL36akp+O9WJsG1h9YlsCzgz04chC2NMh
 vhXHAHfPIQMSHOp3srhGJf3YAw85qrFGQAYQ67Z0lDzl83n9KCAdHe+Z26iIFv3t3okVFijXizb
 Vp/rXNO+eQ/hNq52vxUqQlQmW+72qEJEEbvN3IEWD1gqtdAy8cn/o69lm3pliuj8I/qO5M/tS75
 QRDA//e+ReOMWn1lOoLz36yOMgPFgnQuW3H63Apw==
X-Gm-Gg: ASbGnctm8Av3dzWL0d4tHr+I0Rfef+AkVCf9vKHpwRgevCFcFzQB6cHMZwWeLFijYuB
 PZrsfDPTSiaPspJJhCwWef6Q1dvsIIMG7eV3R9LGhvlal6dNdO624oMP7PpNZjgtquGS/HUhKh6
 Xrduj1NYvP0V08hK6w9Kis70VbbTFFGSAkE62zNuMExFvcuO5WroHreiFA1mv2YU/DGV/k4yeEh
 YU84wUKuoh2FY185859yGPJT/GPhoqUBIjmTKJUJqEr6tddL+LSU5LMETb21cKYksR5l6XHWEiJ
 YWkwaK03jCA=
X-Received: by 2002:a05:622a:192a:b0:4a5:9825:d6fe with SMTP id
 d75a77b69052e-4a72feeaa74mr47516421cf.26.1749823693684; 
 Fri, 13 Jun 2025 07:08:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsyUpFJY1Scjjk67ECNgdO3g9GJQECDGhCy9CTkJdCMceRIW2x4nx4cQcUsf1r0IKQkXiZBA==
X-Received: by 2002:a05:622a:192a:b0:4a5:9825:d6fe with SMTP id
 d75a77b69052e-4a72feeaa74mr47515781cf.26.1749823693162; 
 Fri, 13 Jun 2025 07:08:13 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a52a1ddsm17384111cf.81.2025.06.13.07.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 07:08:12 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v3 06/11] migration: Rename save_live_complete_precopy to
 save_complete
Date: Fri, 13 Jun 2025 10:07:56 -0400
Message-ID: <20250613140801.474264-7-peterx@redhat.com>
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
index 3e20f8608a..454e914b56 100644
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


