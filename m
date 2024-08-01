Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD8AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 12:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZV26-0000Lm-Rj; Thu, 01 Aug 2024 08:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sZV1x-0008VV-Da
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:35:42 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sZV1v-0000qz-Br
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:35:41 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EFF531FB4E;
 Thu,  1 Aug 2024 12:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722515738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IGOQXHelFrYd1CF0QtFnL++hhRTSduYUcoZHP849jTY=;
 b=GrFJtfAsuRsKGQXMGU7bh6WvCy853rPw078QG7rRBXYnDLtwyNt81TRNyPO4j8B4VquSYr
 mpRUwhmCTfs/nofbf/zZITdcgl/P28M/soknbmKzZLWVJN9OxNuIxfKWIwHrclZwXXmeAc
 Utd1FGBs06jTausd3fiAPMVetqwXsG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722515738;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IGOQXHelFrYd1CF0QtFnL++hhRTSduYUcoZHP849jTY=;
 b=ZeoFGU2hr1XJX++74GAyFLydwT5oMz3gBgfzQDJ8SQnazVIF5D8dtAAhWokDcKTdOPQXvM
 wW0uxzP1sj/XQyCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cPy3qveI;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4mZGPc9y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722515737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IGOQXHelFrYd1CF0QtFnL++hhRTSduYUcoZHP849jTY=;
 b=cPy3qveIbc2QiFxE4xarszbhc/FxMkTlXa/TpKuTV6Nk1QeZvkB+cpBWIPJ3Rk4M1LZu5c
 KavyeqoJbTOZWuJasAl+TOAPNsy6e9MtRYSNVt5uAr9iwiT+RDgdmd0cBMe+t/vpteVzKx
 9ZcF/WveJ8L9Bet9Ntk0lxxe4TzLU98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722515737;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IGOQXHelFrYd1CF0QtFnL++hhRTSduYUcoZHP849jTY=;
 b=4mZGPc9yBSLAYfXXGJpO2a+w0bSnAtqB49EyhhYB8h2x6xe31rJi2+HHUMhYHSw2LEqz0w
 5a/eg8EB/QVqptAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4A4313946;
 Thu,  1 Aug 2024 12:35:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iGKJIhiBq2YEYAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 01 Aug 2024 12:35:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v3 11/14] migration/multifd: Replace multifd_send_state->pages
 with client data
Date: Thu,  1 Aug 2024 09:35:13 -0300
Message-Id: <20240801123516.4498-12-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240801123516.4498-1-farosas@suse.de>
References: <20240801123516.4498-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.81 / 50.00];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EFF531FB4E
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Multifd currently has a simple scheduling mechanism that distributes
work to the various channels by keeping storage space within each
channel and an extra space that is given to the client. Each time the
client fills the space with data and calls into multifd, that space is
given to the next idle channel and a free storage space is taken from
the channel and given to client for the next iteration.

This means we always need (#multifd_channels + 1) memory slots to
operate multifd.

This is fine, except that the presence of this one extra memory slot
doesn't allow different types of payloads to be processed at the same
time in different channels, i.e. the data type of
multifd_send_state->pages needs to be the same as p->pages.

For each new data type different from MultiFDPage_t that is to be
handled, this logic would need to be duplicated by adding new fields
to multifd_send_state, to the channels and to multifd_send_pages().

Fix this situation by moving the extra slot into the client and using
only the generic type MultiFDSendData in the multifd core.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 79 ++++++++++++++++++++++++++-------------------
 migration/multifd.h |  3 ++
 migration/ram.c     |  2 ++
 3 files changed, 50 insertions(+), 34 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index ec6dcb9999..1c16879495 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -49,7 +49,6 @@ typedef struct {
 
 struct {
     MultiFDSendParams *params;
-    MultiFDSendData *data;
     /*
      * Global number of generated multifd packets.
      *
@@ -97,6 +96,8 @@ struct {
     MultiFDMethods *ops;
 } *multifd_recv_state;
 
+static MultiFDSendData *multifd_ram_send;
+
 static size_t multifd_ram_payload_size(void)
 {
     uint32_t n = multifd_ram_page_count();
@@ -130,6 +131,17 @@ static MultiFDSendData *multifd_send_data_alloc(void)
     return g_malloc0(size_minus_payload + max_payload_size);
 }
 
+void multifd_ram_save_setup(void)
+{
+    multifd_ram_send = multifd_send_data_alloc();
+}
+
+void multifd_ram_save_cleanup(void)
+{
+    g_free(multifd_ram_send);
+    multifd_ram_send = NULL;
+}
+
 static bool multifd_use_packets(void)
 {
     return !migrate_mapped_ram();
@@ -617,25 +629,20 @@ static void multifd_send_kick_main(MultiFDSendParams *p)
 }
 
 /*
- * How we use multifd_send_state->pages and channel->pages?
+ * multifd_send() works by exchanging the MultiFDSendData object
+ * provided by the caller with an unused MultiFDSendData object from
+ * the next channel that is found to be idle.
  *
- * We create a pages for each channel, and a main one.  Each time that
- * we need to send a batch of pages we interchange the ones between
- * multifd_send_state and the channel that is sending it.  There are
- * two reasons for that:
- *    - to not have to do so many mallocs during migration
- *    - to make easier to know what to free at the end of migration
+ * The channel owns the data until it finishes transmitting and the
+ * caller owns the empty object until it fills it with data and calls
+ * this function again. No locking necessary.
  *
- * This way we always know who is the owner of each "pages" struct,
- * and we don't need any locking.  It belongs to the migration thread
- * or to the channel thread.  Switching is safe because the migration
- * thread is using the channel mutex when changing it, and the channel
- * have to had finish with its own, otherwise pending_job can't be
- * false.
+ * Switching is safe because both the migration thread and the channel
+ * thread have barriers in place to serialize access.
  *
  * Returns true if succeed, false otherwise.
  */
-static bool multifd_send_pages(void)
+static bool multifd_send(MultiFDSendData **send_data)
 {
     int i;
     static int next_channel;
@@ -676,11 +683,16 @@ static bool multifd_send_pages(void)
      */
     smp_mb_acquire();
 
-    assert(!p->data->u.ram.num);
+    assert(multifd_payload_empty(p->data));
 
-    tmp = multifd_send_state->data;
-    multifd_send_state->data = p->data;
+    /*
+     * Swap the pointers. The channel gets the client data for
+     * transferring and the client gets back an unused data slot.
+     */
+    tmp = *send_data;
+    *send_data = p->data;
     p->data = tmp;
+
     /*
      * Making sure p->data is setup before marking pending_job=true. Pairs
      * with the qatomic_load_acquire() in multifd_send_thread().
@@ -712,7 +724,12 @@ bool multifd_queue_page(RAMBlock *block, ram_addr_t offset)
     MultiFDPages_t *pages;
 
 retry:
-    pages = &multifd_send_state->data->u.ram;
+    pages = &multifd_ram_send->u.ram;
+
+    if (multifd_payload_empty(multifd_ram_send)) {
+        multifd_pages_reset(pages);
+        multifd_set_payload_type(multifd_ram_send, MULTIFD_PAYLOAD_RAM);
+    }
 
     /* If the queue is empty, we can already enqueue now */
     if (multifd_queue_empty(pages)) {
@@ -730,7 +747,7 @@ retry:
      * After flush, always retry.
      */
     if (pages->block != block || multifd_queue_full(pages)) {
-        if (!multifd_send_pages()) {
+        if (!multifd_send(&multifd_ram_send)) {
             return false;
         }
         goto retry;
@@ -860,8 +877,6 @@ static void multifd_send_cleanup_state(void)
     qemu_sem_destroy(&multifd_send_state->channels_ready);
     g_free(multifd_send_state->params);
     multifd_send_state->params = NULL;
-    g_free(multifd_send_state->data);
-    multifd_send_state->data = NULL;
     g_free(multifd_send_state);
     multifd_send_state = NULL;
 }
@@ -910,15 +925,14 @@ int multifd_send_sync_main(void)
 {
     int i;
     bool flush_zero_copy;
-    MultiFDPages_t *pages;
 
     if (!migrate_multifd()) {
         return 0;
     }
-    pages = &multifd_send_state->data->u.ram;
-    if (pages->num) {
-        if (!multifd_send_pages()) {
-            error_report("%s: multifd_send_pages fail", __func__);
+
+    if (!multifd_payload_empty(multifd_ram_send)) {
+        if (!multifd_send(&multifd_ram_send)) {
+            error_report("%s: multifd_send fail", __func__);
             return -1;
         }
     }
@@ -992,13 +1006,11 @@ static void *multifd_send_thread(void *opaque)
 
         /*
          * Read pending_job flag before p->data.  Pairs with the
-         * qatomic_store_release() in multifd_send_pages().
+         * qatomic_store_release() in multifd_send().
          */
         if (qatomic_load_acquire(&p->pending_job)) {
-            MultiFDPages_t *pages = &p->data->u.ram;
-
             p->iovs_num = 0;
-            assert(pages->num);
+            assert(!multifd_payload_empty(p->data));
 
             ret = multifd_send_state->ops->send_prepare(p, &local_err);
             if (ret != 0) {
@@ -1021,13 +1033,13 @@ static void *multifd_send_thread(void *opaque)
             stat64_add(&mig_stats.multifd_bytes,
                        p->next_packet_size + p->packet_len);
 
-            multifd_pages_reset(pages);
             p->next_packet_size = 0;
+            multifd_set_payload_type(p->data, MULTIFD_PAYLOAD_NONE);
 
             /*
              * Making sure p->data is published before saying "we're
              * free".  Pairs with the smp_mb_acquire() in
-             * multifd_send_pages().
+             * multifd_send().
              */
             qatomic_store_release(&p->pending_job, false);
         } else {
@@ -1220,7 +1232,6 @@ bool multifd_send_setup(void)
     thread_count = migrate_multifd_channels();
     multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
     multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
-    multifd_send_state->data = multifd_send_data_alloc();
     qemu_sem_init(&multifd_send_state->channels_created, 0);
     qemu_sem_init(&multifd_send_state->channels_ready, 0);
     qatomic_set(&multifd_send_state->exiting, 0);
diff --git a/migration/multifd.h b/migration/multifd.h
index c2ba4cad13..e3d0120837 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -275,4 +275,7 @@ static inline uint32_t multifd_ram_page_count(void)
 {
     return MULTIFD_PACKET_SIZE / qemu_target_page_size();
 }
+
+void multifd_ram_save_setup(void);
+void multifd_ram_save_cleanup(void);
 #endif
diff --git a/migration/ram.c b/migration/ram.c
index edec1a2d07..1815b2557b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2387,6 +2387,7 @@ static void ram_save_cleanup(void *opaque)
     ram_bitmaps_destroy();
 
     xbzrle_cleanup();
+    multifd_ram_save_cleanup();
     ram_state_cleanup(rsp);
     g_free(migration_ops);
     migration_ops = NULL;
@@ -3058,6 +3059,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
     migration_ops = g_malloc0(sizeof(MigrationOps));
 
     if (migrate_multifd()) {
+        multifd_ram_save_setup();
         migration_ops->ram_save_target_page = ram_save_target_page_multifd;
     } else {
         migration_ops->ram_save_target_page = ram_save_target_page_legacy;
-- 
2.35.3


