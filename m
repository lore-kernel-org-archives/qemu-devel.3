Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51279C71151
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 14:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ54w-00048m-8D; Fri, 13 Jun 2025 10:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ54t-00048Y-J9
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:08:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ54r-0001Ut-Nm
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749823696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wNEbeFV94Epe1QBIO3JwY23G4Fsb18RrXYM96D8g5bs=;
 b=Sa3/HdJX7DeGgTl6tE3/DtrB/ulykVu8FERL5F9Vj/ffEts8oz9tTLKryblYdyJfluXPf+
 f9n1MEDDfodXWk/kKL4UjoyrreTC54amxbktRvnLBWN7hmLod+ePpIg9sRtoBplCSIGtIm
 KH/cR3wiFYWbRL/X3nkvcWyAL1u2zBk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-PBV-rfLLOIGI771rSrS-xQ-1; Fri, 13 Jun 2025 10:08:15 -0400
X-MC-Unique: PBV-rfLLOIGI771rSrS-xQ-1
X-Mimecast-MFC-AGG-ID: PBV-rfLLOIGI771rSrS-xQ_1749823695
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-478f78ff9beso65197831cf.1
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 07:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749823695; x=1750428495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wNEbeFV94Epe1QBIO3JwY23G4Fsb18RrXYM96D8g5bs=;
 b=gYccYAFayWB1bTRsIcIgzejJz0oHOzxTbKa80O0CksECEuNkgNJo9Khx9WqO1R/0Ty
 i2D1zbX9x+TeM1Ulf/wzmQ54YGibtqCCRfzYe+fIOGRCNdAzi9VheaVh5tJXv05vkUnT
 jm+x7YNeml04Mvy1ASPd6tEnFw4hXG4C9FPxMKCuyKaPhWaCvsTS6Msh62Gi0oje2UzS
 pU3qpn5vo4tksVujbLT0/J6PGzy+XjOijyT6kSwb2W2945ChPQ8fNU3kxwmjCIcqgUhw
 0/y+KB5dBd57a9uYWS3yhdMXdAEniIfwE5kHRG4b8pCY6iw4EmVWEaktcfergEMlPMuu
 ezZw==
X-Gm-Message-State: AOJu0YzkhkbhsgfuxoZ3BcjHvhEnrKcQr4A5Fy1RqJGGfTAk1P0NVd81
 bAVx7F6TIo32BP60VyT6iwAT3cGu3VnVMQDuuAG5Yw8/2GNqIrXLGhlwmmF+YLlFHyJd1Z2vnGi
 1AC53kb4wAvxVCVskfqXLYM0hKaztcXl+4M0dyNa5Mv6E7nTeZ7yuyRw9rRO/FmhOzpGl9DqAim
 KRDyku2TTSLsxz4I8zi+XUbpIxXNg8mBLMDo5uqQ==
X-Gm-Gg: ASbGnct0bezgcujrvdYLy63WT7NkK10KNCFGO5GS/scYujBdqjVAF16lLMicNgUxy72
 tjzbycQ+HH78Iv7KFW0GdQtwQZNm8oO0ZsGYK3wcj8HGveQrDgM5HIUik7gFQL+yxnad/H2a4kO
 8pSGUi6wTsy42TMEAP2GH7bixFT/9ISRPXiONtG4CZgamHzFQ/J1j1cJmbA0Dv4r9jbSUzH1tsw
 ixVwOobqL0UrpGc5/v6rGLGrxyYCTi5YfQCpTnnc13fLjNpefNPrna1u/NXK465yo4RzFEfaKaH
 2yBIkfcogvg=
X-Received: by 2002:a05:622a:4204:b0:4a5:a5fb:d3fa with SMTP id
 d75a77b69052e-4a72ff9ca02mr58271641cf.47.1749823694712; 
 Fri, 13 Jun 2025 07:08:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdTXSdWvYGu76Xy4iiERQGxuqGg8I0PqZeNSGkYwY2v5y2oNa2z+HLdxRhzm4hX91aaCZg2g==
X-Received: by 2002:a05:622a:4204:b0:4a5:a5fb:d3fa with SMTP id
 d75a77b69052e-4a72ff9ca02mr58271021cf.47.1749823694188; 
 Fri, 13 Jun 2025 07:08:14 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a52a1ddsm17384111cf.81.2025.06.13.07.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 07:08:13 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v3 07/11] migration: qemu_savevm_complete*() helpers
Date: Fri, 13 Jun 2025 10:07:57 -0400
Message-ID: <20250613140801.474264-8-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613140801.474264-1-peterx@redhat.com>
References: <20250613140801.474264-1-peterx@redhat.com>
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

Since we use the same save_complete() hook for both precopy and postcopy,
add a set of helpers to invoke the hook() to dedup the code.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 78 ++++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 34 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 454e914b56..c4fd5f5a5b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1484,6 +1484,38 @@ bool should_send_vmdesc(void)
     return !machine->suppress_vmdesc;
 }
 
+static bool qemu_savevm_complete_exists(SaveStateEntry *se)
+{
+    return se->ops && se->ops->save_complete;
+}
+
+/*
+ * Invoke the ->save_complete() if necessary.
+ * Returns: 0 if skip the current SE or succeeded, <0 if error happened.
+ */
+static int qemu_savevm_complete(SaveStateEntry *se, QEMUFile *f)
+{
+    int ret;
+
+    if (se->ops->is_active) {
+        if (!se->ops->is_active(se->opaque)) {
+            return 0;
+        }
+    }
+
+    trace_savevm_section_start(se->idstr, se->section_id);
+    save_section_header(f, se, QEMU_VM_SECTION_END);
+    ret = se->ops->save_complete(f, se->opaque);
+    trace_savevm_section_end(se->idstr, se->section_id, ret);
+    save_section_footer(f, se);
+
+    if (ret < 0) {
+        qemu_file_set_error(f, ret);
+    }
+
+    return ret;
+}
+
 /*
  * Complete saving any postcopy-able devices.
  *
@@ -1493,27 +1525,13 @@ bool should_send_vmdesc(void)
 void qemu_savevm_state_complete_postcopy(QEMUFile *f)
 {
     SaveStateEntry *se;
-    int ret;
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
-        if (!se->ops || !se->ops->save_complete) {
+        if (!qemu_savevm_complete_exists(se)) {
             continue;
         }
-        if (se->ops->is_active) {
-            if (!se->ops->is_active(se->opaque)) {
-                continue;
-            }
-        }
-        trace_savevm_section_start(se->idstr, se->section_id);
-        /* Section type */
-        qemu_put_byte(f, QEMU_VM_SECTION_END);
-        qemu_put_be32(f, se->section_id);
 
-        ret = se->ops->save_complete(f, se->opaque);
-        trace_savevm_section_end(se->idstr, se->section_id, ret);
-        save_section_footer(f, se);
-        if (ret < 0) {
-            qemu_file_set_error(f, ret);
+        if (qemu_savevm_complete(se, f) < 0) {
             return;
         }
     }
@@ -1559,7 +1577,6 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
 {
     int64_t start_ts_each, end_ts_each;
     SaveStateEntry *se;
-    int ret;
     bool multifd_device_state = multifd_device_state_supported();
 
     if (multifd_device_state) {
@@ -1580,32 +1597,25 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
     }
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
-        if (!se->ops ||
-            (in_postcopy && se->ops->has_postcopy &&
-             se->ops->has_postcopy(se->opaque)) ||
-            !se->ops->save_complete) {
+        if (!qemu_savevm_complete_exists(se)) {
             continue;
         }
 
-        if (se->ops->is_active) {
-            if (!se->ops->is_active(se->opaque)) {
-                continue;
-            }
+        if (in_postcopy && se->ops->has_postcopy &&
+            se->ops->has_postcopy(se->opaque)) {
+            /*
+             * If postcopy will start soon, and if the SE supports
+             * postcopy, then we can skip the SE for the postcopy phase.
+             */
+            continue;
         }
 
         start_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
-        trace_savevm_section_start(se->idstr, se->section_id);
-
-        save_section_header(f, se, QEMU_VM_SECTION_END);
-
-        ret = se->ops->save_complete(f, se->opaque);
-        trace_savevm_section_end(se->idstr, se->section_id, ret);
-        save_section_footer(f, se);
-        if (ret < 0) {
-            qemu_file_set_error(f, ret);
+        if (qemu_savevm_complete(se, f) < 0) {
             goto ret_fail_abort_threads;
         }
         end_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
+
         trace_vmstate_downtime_save("iterable", se->idstr, se->instance_id,
                                     end_ts_each - start_ts_each);
     }
-- 
2.49.0


