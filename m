Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2408C43327
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weThv-00055l-BB; Tue, 30 Jun 2026 04:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1weThp-000557-A0
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 04:20:33 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1weThn-0003Qd-Ji
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 04:20:33 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2c8017e981fso21841915ad.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 01:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782807629; x=1783412429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AVLrjiHC0W6KEix/vwle1s6lIKpRUHxOfSyUAhuyMfc=;
 b=gjvcHQVIH53i4iWwuZCycm8+JXAWCJDZyKGdbe8eb8Yv0CE7JeADCPeldN8sAKgwWU
 pU7y0PiHoeRHUI7zc+VH3ZdWqp3ssxbnE7RdnvXsl6+YexLkF+mm9l9absEcZ4rpIVWt
 UoBEdGMXUowMqYFbr/JOGtJCZz9Sm3bGToQcs0oM9w7tqlNjTYuQDm4ZVHu1Reo78aE4
 i4uJCwXHUxVUsV4u5JG8VhJL4/JMAkc7cRlNfnQrChhBaHQhFJe0cyILki0h+tvCBZiC
 eYueTSyVd2zOf3UISHMX5AI6OahQUG/6+kJqewHm5UJJwtYITr77Hw6mWWtrDeWKBbo+
 COXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782807629; x=1783412429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AVLrjiHC0W6KEix/vwle1s6lIKpRUHxOfSyUAhuyMfc=;
 b=ZzNTlTw8xs405FkhyBUPLl7o3HLvdIAle7zfvM6LncfyZmHe4dJbGmGCDg49EalJbn
 qQFPBzcXEve8zySDEqfaF36EWLFh8e+MDFVBJtOkZqU22HTxjTxSnAZcvsrctFBgw6Qp
 LxArmscEAuDrnBDZ0hGAEjACGFL1LAGOJJ7UnrKvN0X77wJz0LkV1UlBE8EXqT+9e9Ba
 pYqR7lR8ZTyMb2Z4qASrFGInWwdl24XpQmGQQVEVXi/Im+W3Ny628yCjJ2JR2/zqAOOE
 P982Uwzo9cqIpvA/zeYTlGVPtY25l/APEANKTg6oK1nWDVySnUjxL2AgJR+ucKFrGFp1
 yr4w==
X-Gm-Message-State: AOJu0Yxs5z30QGgJzTZBtSc1sLMm5WBKupl3oQSCedQ/t197jMrGcff9
 R+8p6qnujgOYsw+EJb0nppdrb8nkEKDHJ8kodyQlKqYMU51BzE/PD0axicqj8laQ
X-Gm-Gg: AfdE7ck/BZHXb/K6NayJuXLLpKW/W1g87fwMqRiySB43/o6Gvts1s0shZSavYcExHqO
 d5UZnqQIRhIlpGDRVWZFbR0n4Uvp9E1byr2RfrDLXNmlBSux8wz+a/B0wePo3uupXQSiD9t9P4H
 eW2lnFFWtKsJQFRCOY8ugdVscyksgMYxp/Ucer4pCdnpmjPHaGc+6oFcuPgmuCrjR035/JEvEPM
 ftvNyAcch6dhdGa1+fu9uHd6gWiXXGJ4kQs2J2v1D3OjTo++tDEvCNJF9bawJbE0bzt6GX2h65M
 J1Pzoo/iX5/i2c7rvaNu3tHAorzyGtx9oHeyh07bnSRGlFaIHIDUTzyZVWOGddKzIZvGPWdg9oi
 Scwc3TvrZQKxTxmlGDcMEG8xJPwXtSxV6BINsNmVgOu6lefflxr37Vj+OkGxYfGTcCwvTJmxa2q
 36nxgGE72hV+ZJqOp9gsnjxXqNKnD0IsK8u78IS7aBBoY=
X-Received: by 2002:a17:903:9cc:b0:2c9:afad:c5f2 with SMTP id
 d9443c01a7336-2ca2ed41bedmr20190025ad.45.1782807629256; 
 Tue, 30 Jun 2026 01:20:29 -0700 (PDT)
Received: from setun ([2401:4900:a344:dc6e:573c:3e9:c03e:731a])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca4f2a71dbsm1284615ad.50.2026.06.30.01.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 01:20:28 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [RFC PATCH v2 3/7] migration: Use file_bmap for RAMBlock during
 incoming file load
Date: Tue, 30 Jun 2026 13:49:36 +0530
Message-ID: <20260630081940.611092-4-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630081940.611092-1-aadeshveer07@gmail.com>
References: <20260630081940.611092-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Replace the temporary bitmap with the existing file_bmap attribute of
the RAMBlock. This acts as a preparatory change for the upcoming fast
snapshot load feature.

Reusing this bitmap allows the destination to track page types during
a postcopy load, enabling faster, direct placement of zero pages.

Since file_bmap is currently only utilized during the migration save
phase, it can be safely repurposed during the load phase without
introducing conflicts.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
---
 migration/ram.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index fc38ffbf8a..4728f14d73 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -252,6 +252,17 @@ int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque)
     return ret;
 }
 
+static void ramblock_file_bmap_init(void)
+{
+    RAMBlock *rb;
+
+    RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
+        assert(!rb->file_bmap);
+        size_t size = rb->max_length >> qemu_target_page_bits();
+        rb->file_bmap = bitmap_new(size);
+    }
+}
+
 static void ramblock_recv_map_init(void)
 {
     RAMBlock *rb;
@@ -3749,6 +3760,9 @@ static int ram_load_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     xbzrle_load_setup();
     ramblock_recv_map_init();
+    if (migrate_mapped_ram()) {
+        ramblock_file_bmap_init();
+    }
 
     return 0;
 }
@@ -3766,8 +3780,8 @@ static int ram_load_cleanup(void *opaque)
     xbzrle_load_cleanup();
 
     RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
-        g_free(rb->receivedmap);
-        rb->receivedmap = NULL;
+        g_clear_pointer(&rb->receivedmap, g_free);
+        g_clear_pointer(&rb->file_bmap, g_free);
     }
 
     return 0;
@@ -4142,11 +4156,18 @@ err:
 static void parse_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
                                       ram_addr_t length, Error **errp)
 {
-    g_autofree unsigned long *bitmap = NULL;
     MappedRamHeader header;
     size_t bitmap_size;
     long num_pages;
 
+    if (length > block->max_length) {
+        error_setg(errp,
+                   "mapped-ram header length %" PRIu64 " exceeds "
+                   "RAMBlock(\"%s\") max_length %" PRIu64,
+                   (uint64_t)length, block->idstr, (uint64_t)block->max_length);
+        return;
+    }
+
     if (!mapped_ram_read_header(f, &header, errp)) {
         return;
     }
@@ -4174,14 +4195,14 @@ static void parse_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
     num_pages = length / header.page_size;
     bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
 
-    bitmap = g_malloc0(bitmap_size);
-    if (qemu_get_buffer_at(f, (uint8_t *)bitmap, bitmap_size,
+    if (qemu_get_buffer_at(f, (uint8_t *)block->file_bmap, bitmap_size,
                            header.bitmap_offset) != bitmap_size) {
         error_setg(errp, "Error reading dirty bitmap");
         return;
     }
 
-    if (!read_ramblock_mapped_ram(f, block, num_pages, bitmap, errp)) {
+    if (!read_ramblock_mapped_ram(f, block, num_pages, block->file_bmap,
+                                  errp)) {
         return;
     }
 
-- 
2.54.0


