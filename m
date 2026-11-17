Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C425160A6F4F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=loVEcato;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xqyQON1R;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MyDd7ksL;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/xwSD3em
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTKEr-0007e1-LP; Tue, 17 Nov 2026 09:32:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1xTKEq-0007dj-5a; Tue, 17 Nov 2026 09:32:48 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1xTKEn-00042K-Qg; Tue, 17 Nov 2026 09:32:47 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CE8FB22311;
 Tue, 17 Nov 2026 14:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794925964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G/ZErue8AsC6VlgD7OA3rBeSvKsJAVD60f9x4gvoZpk=;
 b=loVEcato7F9/wBM8yVXIqH+Cl59GY1hMJ+alp3qkLHxOINtg6KM/ZlZQCFkSLC356+6ZGg
 scvF/6wxjC+XJEnlzDV5CruDgBQkOD+mHnQ4Y2/OdXnQeEy3j6eJWK0sXtjJu0dyKdztqS
 BnTNOee2GW4v+l9/dQ4IrAJ+O8uaNgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794925964;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G/ZErue8AsC6VlgD7OA3rBeSvKsJAVD60f9x4gvoZpk=;
 b=xqyQON1RLnKLYGbNN8cXoZhxi+Dp1NRtQoAWgvglcJv2aWtNy3BorAzNtg36m89XlL89VU
 5QBp9iOtK+UN14Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794925963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G/ZErue8AsC6VlgD7OA3rBeSvKsJAVD60f9x4gvoZpk=;
 b=MyDd7ksLOcKasmppK2ohPOAD2Y1QvVLmhnomUQ9WRVS76+7rHLE9kvrNEbwmu5+HPnFU+5
 ZtOsKBd3Ux3QAdEJYXX15q6F42O23Cf7QSRNkcIseDgPViIccPvXRBbSSWgYwBeqo+S7HZ
 1TM1fEii0rSHvfg+cBRDWwYj8DxCKzQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794925963;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G/ZErue8AsC6VlgD7OA3rBeSvKsJAVD60f9x4gvoZpk=;
 b=/xwSD3emlD/nnM8PUwZ2gHOaRZgUE0+vZZftRqBGj/oh+YColoLoTQWGZCM7+UqoGz89wX
 brem1Fc5vfd4a9BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA44113302;
 Tue, 17 Nov 2026 14:32:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lN5qDIRl/GpRQAAAD6G6ig:T4
 (envelope-from <farosas@suse.de>); Tue, 17 Nov 2026 14:32:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 3/3] migration/block-dirty-bitmap: don't hold the load lock
 across stream reads
Date: Tue, 17 Nov 2026 11:32:33 -0300
Message-ID: <20261117143234.1794926-4-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117143234.1794926-1-farosas@suse.de>
References: <20261117143234.1794926-1-farosas@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-11.80 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -11.80
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Denis V. Lunev" <den@openvz.org>

dirty_bitmap_load() takes dbm_state.load.lock for each chunk and holds
it while it reads the chunk from the migration stream.

In precopy the load runs in the incoming migration coroutine, which
yields in qemu_fill_buffer() while it waits for data, still holding
the lock. A quit on the destination at that point never completes:
migration_shutdown() calls dirty_bitmap_mig_cancel_incoming(), which
takes the same lock in the same main thread.

In postcopy the load runs in the listen thread, and the main thread
takes the lock in dirty_bitmap_mig_before_vm_start(), called from
loadvm_postcopy_handle_run_bh(), and in migration_shutdown(). The main
loop then waits until the source sends the next chunk.

Read each chunk into a DBMLoadChunk first and take the lock only to
resolve the names and apply the chunk. The lock protects the bitmaps
list and the resolved node and bitmap, which the main thread uses. The
flags and alias strings read from the stream are only touched by the
code doing the load.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Eric Blake <eblake@redhat.com>
Cc: John Snow <jsnow@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: qemu-block@nongnu.org
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/block-dirty-bitmap.c | 222 +++++++++++++++++++--------------
 1 file changed, 130 insertions(+), 92 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 35623379eb6..14e5a984e47 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -796,12 +796,22 @@ static void dirty_bitmap_state_pending(void *opaque, MigPendingData *data,
     data->postcopy_bytes += pending;
 }
 
+/* Chunk payload, read from the stream without holding DBMLoadState.lock */
+typedef struct DBMLoadChunk {
+    uint32_t granularity;
+    uint8_t start_flags;
+    uint64_t first_byte;
+    uint64_t nr_bytes;
+    uint64_t buf_size;
+    uint8_t *buf;
+} DBMLoadChunk;
+
 /* First occurrence of this bitmap. It should be created if doesn't exist */
-static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
+static int dirty_bitmap_load_start(DBMLoadState *s, DBMLoadChunk *c)
 {
     Error *local_err = NULL;
-    uint32_t granularity = qemu_get_be32(f);
-    uint8_t flags = qemu_get_byte(f);
+    uint32_t granularity = c->granularity;
+    uint8_t flags = c->start_flags;
     LoadBitmapState *b;
     bool persistent;
 
@@ -959,7 +969,7 @@ void dirty_bitmap_mig_cancel_incoming(void)
     qemu_mutex_unlock(&s->lock);
 }
 
-static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
+static void dirty_bitmap_load_complete(DBMLoadState *s)
 {
     GSList *item;
     trace_dirty_bitmap_load_complete();
@@ -990,71 +1000,43 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
     }
 }
 
-static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
+static int dirty_bitmap_load_bits(DBMLoadState *s, DBMLoadChunk *c)
 {
-    uint64_t first_byte = qemu_get_be64(f) << BDRV_SECTOR_BITS;
-    uint64_t nr_bytes = (uint64_t)qemu_get_be32(f) << BDRV_SECTOR_BITS;
-    trace_dirty_bitmap_load_bits_enter(first_byte >> BDRV_SECTOR_BITS,
-                                       nr_bytes >> BDRV_SECTOR_BITS);
+    uint64_t needed_size;
+
+    trace_dirty_bitmap_load_bits_enter(c->first_byte >> BDRV_SECTOR_BITS,
+                                       c->nr_bytes >> BDRV_SECTOR_BITS);
 
     if (s->flags & DIRTY_BITMAP_MIG_FLAG_ZEROES) {
         trace_dirty_bitmap_load_bits_zeroes();
         if (!s->cancelled) {
-            bdrv_dirty_bitmap_deserialize_zeroes(s->bitmap, first_byte,
-                                                 nr_bytes, false);
-        }
-    } else {
-        size_t ret;
-        g_autofree uint8_t *buf = NULL;
-        uint64_t buf_size = qemu_get_be64(f);
-        uint64_t needed_size;
-
-        /*
-         * The actual check for buf_size is done a bit later. We can't do it in
-         * cancelled mode as we don't have the bitmap to check the constraints
-         * (so, we allocate a buffer and read prior to the check). On the other
-         * hand, we shouldn't blindly g_malloc the number from the stream.
-         * Actually one chunk should not be larger than CHUNK_SIZE. Let's allow
-         * a bit larger (which means that bitmap migration will fail anyway and
-         * the whole migration will most probably fail soon due to broken
-         * stream).
-         */
-        if (buf_size > 10 * CHUNK_SIZE) {
-            error_report("Bitmap migration stream buffer allocation request "
-                         "is too large");
-            return -EIO;
-        }
-
-        buf = g_malloc(buf_size);
-        ret = qemu_get_buffer(f, buf, buf_size);
-        if (ret != buf_size) {
-            error_report("Failed to read bitmap bits");
-            return -EIO;
-        }
-
-        if (s->cancelled) {
-            return 0;
+            bdrv_dirty_bitmap_deserialize_zeroes(s->bitmap, c->first_byte,
+                                                 c->nr_bytes, false);
         }
+        return 0;
+    }
 
-        needed_size = bdrv_dirty_bitmap_serialization_size(s->bitmap,
-                                                           first_byte,
-                                                           nr_bytes);
+    if (s->cancelled) {
+        return 0;
+    }
 
-        if (needed_size > buf_size ||
-            buf_size > QEMU_ALIGN_UP(needed_size, 4 * sizeof(long))
-             /* Here used same alignment as in send_bitmap_bits */
-        ) {
-            error_report("Migrated bitmap granularity doesn't "
-                         "match the destination bitmap '%s' granularity",
-                         bdrv_dirty_bitmap_name(s->bitmap));
-            cancel_incoming_locked(s);
-            return 0;
-        }
+    needed_size = bdrv_dirty_bitmap_serialization_size(s->bitmap,
+                                                       c->first_byte,
+                                                       c->nr_bytes);
 
-        bdrv_dirty_bitmap_deserialize_part(s->bitmap, buf, first_byte, nr_bytes,
-                                           false);
+    if (needed_size > c->buf_size ||
+        c->buf_size > QEMU_ALIGN_UP(needed_size, 4 * sizeof(long))
+         /* Here used same alignment as in send_bitmap_bits */
+    ) {
+        error_report("Migrated bitmap granularity doesn't "
+                     "match the destination bitmap '%s' granularity",
+                     bdrv_dirty_bitmap_name(s->bitmap));
+        cancel_incoming_locked(s);
+        return 0;
     }
 
+    bdrv_dirty_bitmap_deserialize_part(s->bitmap, c->buf, c->first_byte,
+                                       c->nr_bytes, false);
     return 0;
 }
 
@@ -1105,23 +1087,73 @@ static BdrvDirtyBitmap *dirty_bitmap_load_find_bitmap(DBMLoadState *s)
     return NULL;
 }
 
-static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s,
-                                    GHashTable *alias_map)
+static int dirty_bitmap_read_chunk(QEMUFile *f, DBMLoadState *s,
+                                   DBMLoadChunk *c)
 {
-    GHashTable *bitmap_alias_map = NULL;
-    Error *local_err = NULL;
-    bool nothing;
     s->flags = qemu_get_bitmap_flags(f);
     trace_dirty_bitmap_load_header(s->flags);
 
+    if ((s->flags & DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME) &&
+        !qemu_get_counted_string(f, s->node_alias)) {
+        error_report("Unable to read node alias string");
+        return -EINVAL;
+    }
+
+    if ((s->flags & DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME) &&
+        !qemu_get_counted_string(f, s->bitmap_alias)) {
+        error_report("Unable to read bitmap alias string");
+        return -EINVAL;
+    }
+
+    if (s->flags & DIRTY_BITMAP_MIG_FLAG_START) {
+        c->granularity = qemu_get_be32(f);
+        c->start_flags = qemu_get_byte(f);
+    } else if (s->flags & DIRTY_BITMAP_MIG_FLAG_COMPLETE) {
+        /* no payload */
+    } else if (s->flags & DIRTY_BITMAP_MIG_FLAG_BITS) {
+        c->first_byte = qemu_get_be64(f) << BDRV_SECTOR_BITS;
+        c->nr_bytes = (uint64_t)qemu_get_be32(f) << BDRV_SECTOR_BITS;
+
+        if (!(s->flags & DIRTY_BITMAP_MIG_FLAG_ZEROES)) {
+            c->buf_size = qemu_get_be64(f);
+
+            /*
+             * The actual check for buf_size is done when the chunk is
+             * applied. We can't do it in cancelled mode as we don't have the
+             * bitmap to check the constraints (so, we allocate a buffer and
+             * read prior to the check). On the other hand, we shouldn't
+             * blindly g_malloc the number from the stream. Actually one chunk
+             * should not be larger than CHUNK_SIZE. Let's allow a bit larger
+             * (which means that bitmap migration will fail anyway and the
+             * whole migration will most probably fail soon due to broken
+             * stream).
+             */
+            if (c->buf_size > 10 * CHUNK_SIZE) {
+                error_report("Bitmap migration stream buffer allocation "
+                             "request is too large");
+                return -EIO;
+            }
+
+            c->buf = g_malloc(c->buf_size);
+            if (qemu_get_buffer(f, c->buf, c->buf_size) != c->buf_size) {
+                error_report("Failed to read bitmap bits");
+                return -EIO;
+            }
+        }
+    }
+
+    return qemu_file_get_error(f);
+}
+
+static void dirty_bitmap_load_header(DBMLoadState *s, GHashTable *alias_map)
+{
+    GHashTable *bitmap_alias_map = NULL;
+    Error *local_err = NULL;
+    bool nothing;
+
     nothing = s->flags == (s->flags & DIRTY_BITMAP_MIG_FLAG_EOS);
 
     if (s->flags & DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME) {
-        if (!qemu_get_counted_string(f, s->node_alias)) {
-            error_report("Unable to read node alias string");
-            return -EINVAL;
-        }
-
         if (!s->cancelled) {
             if (alias_map) {
                 const AliasMapInnerNode *amin;
@@ -1165,11 +1197,6 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s,
     if (s->flags & DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME) {
         const char *bitmap_name;
 
-        if (!qemu_get_counted_string(f, s->bitmap_alias)) {
-            error_report("Unable to read bitmap alias string");
-            return -EINVAL;
-        }
-
         bitmap_name = s->bitmap_alias;
         if (!s->cancelled && bitmap_alias_map) {
             BitmapMigrationBitmapAlias *bmap_inner;
@@ -1206,7 +1233,23 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s,
         error_report("Error: block device name is not set");
         cancel_incoming_locked(s);
     }
+}
 
+static int dirty_bitmap_apply_chunk(DBMLoadState *s, DBMLoadChunk *c,
+                                    GHashTable *alias_map)
+{
+    dirty_bitmap_load_header(s, alias_map);
+
+    if (s->flags & DIRTY_BITMAP_MIG_FLAG_START) {
+        return dirty_bitmap_load_start(s, c);
+    }
+    if (s->flags & DIRTY_BITMAP_MIG_FLAG_COMPLETE) {
+        dirty_bitmap_load_complete(s);
+        return 0;
+    }
+    if (s->flags & DIRTY_BITMAP_MIG_FLAG_BITS) {
+        return dirty_bitmap_load_bits(s, c);
+    }
     return 0;
 }
 
@@ -1240,28 +1283,23 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
     }
 
     do {
-        QEMU_LOCK_GUARD(&s->lock);
+        DBMLoadChunk c = {};
 
-        ret = dirty_bitmap_load_header(f, s, alias_map);
-        if (ret < 0) {
-            cancel_incoming_locked(s);
-            goto fail;
+        /*
+         * dirty_bitmap_mig_before_vm_start() takes the lock from the main
+         * thread, so never hold it while waiting for the stream.
+         */
+        ret = dirty_bitmap_read_chunk(f, s, &c);
+        WITH_QEMU_LOCK_GUARD(&s->lock) {
+            if (!ret) {
+                ret = dirty_bitmap_apply_chunk(s, &c, alias_map);
+            }
+            if (ret) {
+                cancel_incoming_locked(s);
+            }
         }
-
-        if (s->flags & DIRTY_BITMAP_MIG_FLAG_START) {
-            ret = dirty_bitmap_load_start(f, s);
-        } else if (s->flags & DIRTY_BITMAP_MIG_FLAG_COMPLETE) {
-            dirty_bitmap_load_complete(f, s);
-        } else if (s->flags & DIRTY_BITMAP_MIG_FLAG_BITS) {
-            ret = dirty_bitmap_load_bits(f, s);
-        }
-
-        if (!ret) {
-            ret = qemu_file_get_error(f);
-        }
-
+        g_free(c.buf);
         if (ret) {
-            cancel_incoming_locked(s);
             goto fail;
         }
     } while (!(s->flags & DIRTY_BITMAP_MIG_FLAG_EOS));
-- 
2.53.0


