Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4756DC5B542
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 22:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK2KL-0004kw-Ug; Tue, 27 May 2025 17:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK2KC-0004j0-La
 for qemu-devel@nongnu.org; Tue, 27 May 2025 17:59:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK2KB-00087U-0E
 for qemu-devel@nongnu.org; Tue, 27 May 2025 17:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748383146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Itx6jMeOoeSf+G3Cpg/QB5b5z4qMFbEfWVbumqBdGUo=;
 b=cmSXJYYnudrCeXJZMZO8VAOOgAzKVd/oc+n5rbnd3MvleVEg5GLlkkiVozUwXxPqWmZhrl
 OrydLaoC8ZYOUywPH1p40pIJOUiowkSyGeORd9+LYH7+DIQXclxKonxqwXYmv35wLI7uJh
 IarC0/ptMWTjJ00wHSLftUEUzER38Hw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-ITpDp3xePfSiLp6jdPWxhw-1; Tue, 27 May 2025 17:59:05 -0400
X-MC-Unique: ITpDp3xePfSiLp6jdPWxhw-1
X-Mimecast-MFC-AGG-ID: ITpDp3xePfSiLp6jdPWxhw_1748383145
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6faac462e12so51357966d6.0
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 14:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748383144; x=1748987944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Itx6jMeOoeSf+G3Cpg/QB5b5z4qMFbEfWVbumqBdGUo=;
 b=ZDUnYOgm0bfMBfA2zh3URWsEDWRDA7TpcvidoZpCqw/kYYrgFiTj9/qk2xB44hU+32
 3yiKQK81UYJDnrgfI8my/YKB/MfjArbzFhQzyCAFZcxyatquCegFdCcB9SdiT+FrcPrk
 Hy5RPD52ytrW3lqMMYo2b/eZxBQIw/90J/NtWDAcukM040z6ywndxVl+18uCWCk+9611
 vlzS1RS8IAnvDtbHf5vNQBfaMyYIWDtjPNAoK1RLhbIiqyaxHr3BTmfQ9Qfn2mEsEO5M
 NIWmaXEIgPhs2MjTUDoeXLSSHWNre3yFmjQluKLQpHEsl6V6wK0qY90UGJ6TsLtVa3l5
 Lucw==
X-Gm-Message-State: AOJu0YztTgP0mcb2OC6+GdEgT4lYvxerX6njAy+a3U+ABzOq/kIXSg0f
 1HLq1fxXr3DfR2OyW3P8+MIag/YvvvkWGj5xWFRFY/1Tqkk8Ix0NhP8bJzvQKqi15CzhUCQOC0F
 K7fNq3pLG96ll/tfrZGVVCmAKrO/vYWpG7nYAE+H9k3hF+pHAOxVlOzLMYbrYJi9H/LeJ1PiPs1
 ht41XMzvC56evI7rP/wkSdqgv6ulfyUM2BXkApug==
X-Gm-Gg: ASbGnctpM9hfnbt2XMRcreHaZXrRkpUHQv10JzzTRxxYBgFDOTJQfpUYQQsYneNPxmn
 KNj9kMkWlI6xXUub/uYDz4hx44jLAwdwa+ZYMIMKjiJsdyhbB2lCHe/Z2tCYm8Nr5em+FBphW/U
 XFECK7ZvMn4DWvTmN2jk4UPDXD1XBBdsC+ac7YwFebKxuhRiJgeZsP45KQbsgFpfhzZNH/3JM8C
 QliF5EInZP7vRxFtN1ZrhmA2VuBN3w7phRiLzfTQk2jjNYaHyb6627vhWyj8FKi/5rjRtnZqr+o
X-Received: by 2002:a05:6214:764:b0:6e4:2dcb:33c8 with SMTP id
 6a1803df08f44-6fa9d287827mr228097466d6.29.1748383144481; 
 Tue, 27 May 2025 14:59:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVZ4kfQN/R9cDiBjgTSWMZllJAJCtQzg2bjTSRquysbpYKBmPrnUG4emDld1qm7HsClXY7wA==
X-Received: by 2002:a05:6214:764:b0:6e4:2dcb:33c8 with SMTP id
 6a1803df08f44-6fa9d287827mr228096946d6.29.1748383144009; 
 Tue, 27 May 2025 14:59:04 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fabe4f27cdsm914516d6.49.2025.05.27.14.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 14:59:02 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 07/11] migration: qemu_savevm_complete*() helpers
Date: Tue, 27 May 2025 17:58:46 -0400
Message-ID: <20250527215850.1271072-8-peterx@redhat.com>
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

Since we use the same save_complete() hook for both precopy and postcopy,
add a set of helpers to invoke the hook() to dedup the code.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 78 ++++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 34 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 311f2a4c61..936e59b41d 100644
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


