Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCF9FEC0FC
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w57fo-0003Nv-41; Tue, 24 Mar 2026 15:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w57fm-0003N3-PV
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:44:18 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w57fl-0008GL-4W
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:44:18 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DB3E24D217;
 Tue, 24 Mar 2026 19:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774381433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ijgwsSEpVbXrAjpHcIRFYxo7WBxDWTudU7OG4QHJ3AQ=;
 b=KK/Wsw8nbioLcQYApLSm9S3lANG8PgNU4dJ6s8M9CSGbCk1uuXt1QiBNlNGSHZq1XM6FV+
 IE3R+pT+x7PnV3U/4a6p1gYKZQY5y6bVjnJm3UMO5ezxrjOg+f8QPJFhoLlUqQHI/R7ch+
 u1irXW4j6TBcVcwQPw4FPLOv8h+WBzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774381433;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ijgwsSEpVbXrAjpHcIRFYxo7WBxDWTudU7OG4QHJ3AQ=;
 b=jK1wwOn9VzlTE8+Yutb/mw+hg0HecGqRmukR9r38aPbSQhprMMU9NvlF8XWLCc8jEkYRdN
 P1+pXKwJRkf/9RCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774381433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ijgwsSEpVbXrAjpHcIRFYxo7WBxDWTudU7OG4QHJ3AQ=;
 b=KK/Wsw8nbioLcQYApLSm9S3lANG8PgNU4dJ6s8M9CSGbCk1uuXt1QiBNlNGSHZq1XM6FV+
 IE3R+pT+x7PnV3U/4a6p1gYKZQY5y6bVjnJm3UMO5ezxrjOg+f8QPJFhoLlUqQHI/R7ch+
 u1irXW4j6TBcVcwQPw4FPLOv8h+WBzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774381433;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ijgwsSEpVbXrAjpHcIRFYxo7WBxDWTudU7OG4QHJ3AQ=;
 b=jK1wwOn9VzlTE8+Yutb/mw+hg0HecGqRmukR9r38aPbSQhprMMU9NvlF8XWLCc8jEkYRdN
 P1+pXKwJRkf/9RCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B207A43FE4;
 Tue, 24 Mar 2026 19:43:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aOoeIHjpwmlkMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 24 Mar 2026 19:43:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [RFC PATCH v1 11/17] vmstate: Introduce vmstate_first
Date: Tue, 24 Mar 2026 16:43:26 -0300
Message-ID: <20260324194333.30004-12-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260324194333.30004-1-farosas@suse.de>
References: <20260324194333.30004-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The vmstate_save|load_vmsd[_v] functions do a bit of juggling of
pointers to allocate/dereference arrays. Introduce a getter for the
first field. Take field->flags into consideration and also allocate
memory when necessary.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
maybe we can soon have an iterator
---
 migration/vmstate.c | 67 +++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 29 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 85e63305f6..ab7c6fa4ab 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -100,23 +100,31 @@ static int vmstate_size(void *opaque, const VMStateField *field)
     return size;
 }
 
-static void *vmstate_handle_alloc(void *ptr, const VMStateField *field,
-                                 int size, int n_elems)
+static void *vmstate_handle_alloc(void **ptr, int size, int n_elems)
 {
-    void *new = ptr;
+    size *= n_elems;
+    if (size) {
+        *ptr = g_malloc(size);
+    }
+
+    return *ptr;
+}
+
+static void *vmstate_first(void *opaque, const VMStateField *field,
+                           int size, int n, bool alloc)
+{
+    void **first = opaque + field->offset;
+
+    if (alloc) {
+        return vmstate_handle_alloc(first, size, n);
+    }
 
     if (field->flags & VMS_POINTER) {
-        if (field->flags & VMS_ALLOC) {
-            size *= n_elems;
-            if (size) {
-                new = g_malloc(size);
-                *(void **)ptr = new;
-            }
-        }
-        assert(new || !n_elems || !size);
-        return *(void **)ptr;
+        assert(first || !n || !size);
+        return *first;
     }
-    return new;
+
+    return first;
 }
 
 static bool vmstate_ptr_marker_load(QEMUFile *f, bool *load_field,
@@ -251,11 +259,12 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
         trace_vmstate_load_state_field(vmsd->name, field->name, exists);
 
         if (exists) {
-            void *first_elem = opaque + field->offset;
+            void *head;
             int i, n_elems = vmstate_n_elems(opaque, field);
             int size = vmstate_size(opaque, field);
 
-            first_elem = vmstate_handle_alloc(first_elem, field, size, n_elems);
+            head = vmstate_first(opaque, field, size, n_elems,
+                                 field->flags & VMS_ALLOC);
 
             for (i = 0; i < n_elems; i++) {
                 /* If we will process the load of field? */
@@ -264,7 +273,7 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
                 void *curr_elem;
 
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
-                    void **array_elem = (void **)first_elem + i;
+                    void **array_elem = (void **)head + i;
                     bool use_dynamic_array =
                         field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC;
                     bool use_marker_field;
@@ -290,13 +299,13 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
                              * need the object size, not entry size of the
                              * array.
                              */
-                            curr_elem = g_malloc0(field->size);
-                            /* Remember to update the root pointer! */
-                            *(void **)array_elem = curr_elem;
+                            assert(!curr_elem);
+                            curr_elem = vmstate_handle_alloc(array_elem,
+                                                             field->size, 1);
                         }
                     }
                 } else {
-                    curr_elem = first_elem + size * i;
+                    curr_elem = head + size * i;
                 }
 
                 if (load_field) {
@@ -627,28 +636,26 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
 
     while (field->name) {
         if (vmstate_field_exists(vmsd, field, opaque, version_id)) {
-            void *first_elem = opaque + field->offset;
+            void *head;
             int i, n_elems = vmstate_n_elems(opaque, field);
             int size = vmstate_size(opaque, field);
             bool is_null_prev = false;
             bool use_vmdesc = true;
 
             trace_vmstate_save_state_loop(vmsd->name, field->name, n_elems);
-            if (field->flags & VMS_POINTER) {
-                first_elem = *(void **)first_elem;
-                assert(first_elem || !n_elems || !size);
-            }
+            head = vmstate_first(opaque, field, size, n_elems, false);
 
             for (i = 0; i < n_elems; i++) {
                 bool save_field = true;
-                void *curr_elem = first_elem + size * i;
+                void *curr_elem;
                 int max_elems = n_elems - i;
 
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
                     bool use_marker_field, is_null, use_dynamic_array;
+                    void **array_elem = (void **)head + i;
 
-                    assert(curr_elem);
-                    curr_elem = *(void **)curr_elem;
+                    assert(array_elem);
+                    curr_elem = *array_elem;
 
                     is_null = !curr_elem;
 
@@ -681,7 +688,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                             use_vmdesc = true;
 
                             for (int j = i + 1; j < n_elems; j++) {
-                                void *elem = *(void **)(first_elem + size * j);
+                                void *elem = *(void **)(head + size * j);
                                 bool elem_is_null = !elem;
 
                                 if (is_null != elem_is_null) {
@@ -706,6 +713,8 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
 
                         save_field = !!curr_elem;
                     }
+                } else {
+                    curr_elem = head + size * i;
                 }
 
                 if (save_field) {
-- 
2.51.0


