Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD93C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 16:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOfDP-0000Ak-Sg; Mon, 09 Jun 2025 12:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOfDO-00006N-3U
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:19:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOfDM-0004Uo-49
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749485951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T6ZiNs2bgrN2dGehujOdvcshHA/0Ols9u+/LIQfENg0=;
 b=L0220/VRlMrT0yUOdtCDQNLpkabQxzxcN2b2A7KbXNxoXOTGGjopNVOUZwa4nh2kqGkStu
 DVkR/iCh4tYHSZ+nHdYu2eFrVGL9b7H/aR3Tsyii3Q/aF2/J6yWpqhPNV7Dv/gfyd0lw1J
 NS2MV2PefCXYkaAczbWDtWxvdAf7bvE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-pqN-4fL8Or26qGWnpxHZiA-1; Mon, 09 Jun 2025 12:19:10 -0400
X-MC-Unique: pqN-4fL8Or26qGWnpxHZiA-1
X-Mimecast-MFC-AGG-ID: pqN-4fL8Or26qGWnpxHZiA_1749485950
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6fad1f7f175so77168456d6.1
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 09:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749485949; x=1750090749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T6ZiNs2bgrN2dGehujOdvcshHA/0Ols9u+/LIQfENg0=;
 b=NNJ2SJ+qE6thFjyEcKByQDAcdkwtQ5kiKOqPwMAcK9+zHpxK5Sn3QyNErwYUb/UP1B
 k5pgQ8JIuta2EAUJLPnC5pMPuGCiezohHyC0ydmvtO5Sr5iEoOPXERV1wcGzzbPK/Kuk
 0XnA53d/Yg38HvSAZtVWU7a1EwTeVBogSwogVEo1oZuTQqcRKEIxhQYbJFKsbuignTiX
 rXLA/yqQ7/eOdc1qwteJDQ+KqdYi17HvGfyalVsH3zuruhIRUfUtVg0oWWghjAoPZ+GQ
 awfvXcN95PVwQNXCk6tA9dMvaJSzGFN0Sa+nHlmu55ll2XsF4HS4l+nwHLm4PIWAnIcQ
 WlZw==
X-Gm-Message-State: AOJu0YzlROJx7UP39jmFjeW0W6wOnAGdmc8f8UF+Ya/+iE79xB9uPGdd
 bT34+LsSHUc2d2EQMLMXDs1VU8tH/ttlwkZ23eFV3EJsDC56fO6KbXDYsALem0ubDqSSb4MMb9s
 EvIr/lk2DVvFAYgUAyVUWea3knZLxDYfAtFFm4kYEiYOD8hyjwZyec6vFUo/J0J91RnT68lGWlm
 OgS5hP1SojvDKO+LN3r/C0Vq9pVa889sWVY8kJPw==
X-Gm-Gg: ASbGncv6MJueXGTkCxjQ7BEwJiFABhw6ni+/+BqX+a3JF0SE1Nv0xeDSMJoG1+sXVJX
 QWI3glnOZPUScAfXNPtDU4DAcfNGsHw0+Dv5Cftnq59yeg0/3VnxXjDMv4V+1Aao5Drwpmg19Yr
 jkZO0JdMblRz1y7NruXtrQkDMIIAzE0gKlMoTre4GWFt/lynA9uvPtsMxwdU1KTvaiLEK8HGPgt
 Za134IEWXZb3JCQfbfRmUADbGHFxPlvfRulKMihIhYvIFNy+IcOi4M2RBfgcOfag3/FM/we50yh
 Zrw=
X-Received: by 2002:a05:6214:258c:b0:6fa:f59f:f349 with SMTP id
 6a1803df08f44-6fb2395ffa3mr1973206d6.10.1749485949244; 
 Mon, 09 Jun 2025 09:19:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpRSwIUU2Efg/nXmnddzEdx3XMbZeLoql8rlEuZOZOxFK85+5nmFzXHeZieTvJnPG+JjM8tg==
X-Received: by 2002:a05:6214:258c:b0:6fa:f59f:f349 with SMTP id
 6a1803df08f44-6fb2395ffa3mr1972456d6.10.1749485948578; 
 Mon, 09 Jun 2025 09:19:08 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09ab95c1sm53420546d6.15.2025.06.09.09.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 09:19:07 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 07/11] migration: qemu_savevm_complete*() helpers
Date: Mon,  9 Jun 2025 12:18:51 -0400
Message-ID: <20250609161855.6603-8-peterx@redhat.com>
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

Since we use the same save_complete() hook for both precopy and postcopy,
add a set of helpers to invoke the hook() to dedup the code.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 78 ++++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 34 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 7dba367d33..1efb7199c0 100644
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


