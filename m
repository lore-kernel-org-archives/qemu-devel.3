Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF9AC5DF6E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 17:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvexA-0007yu-6P; Sun, 16 Aug 2026 13:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wvex7-0007wi-5J
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 13:47:21 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wvex5-00038I-Hi
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 13:47:20 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2ce98cb8165so23846025ad.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 10:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786902438; x=1787507238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JVtBu3i+dc1YRdmQqvlpomuP7fHbCI5Ze5cjl4kS9Ks=;
 b=duTjiICmNuxs6vuj8VhVwAhKFcDY7Xhxewzjha1tHvrU+8dgEHNYyYJtyryHVIwCcY
 poYy9aVaVi7wOm8kzAQt5JxJPC/DsIoJO5UZWG9aVaiaL0sIsWGBuFtZGOAXuFV/be5P
 LIoUm98i1fIUulBRPkNCaU01rNepSipp2dp6FbZfa3PZleCl+qTtewTclHGuYnlXHoyf
 nllOVdKxkIt5MybnKRNQM3cYLnFkI5WaKJMNwsnKZzl4r9WH6OGeZdZjyII+IBYi5XAW
 HA+spBd2c1UFVgb5d0QyXNoM3CbEX5syixlnWmmMuMM9KLBwQ4jD52WC06EAn9n/oz/g
 oRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786902438; x=1787507238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JVtBu3i+dc1YRdmQqvlpomuP7fHbCI5Ze5cjl4kS9Ks=;
 b=nLH+15nmHP5HPw2BlSKCeBihRnuiiMjIPqqTxkddG57We0ElCmhnb2OlkCmeJZfLE9
 21oMEOGQn6HB1gXwVokaL+EYTonEgs3AGORnQvl6rX6MD4KlpNbUTV/QYpjedy8/0Ocs
 3iLjOXdHG//vwdZywEBRfPQBucVzWTcxfVbPl06toNX/DWQYrqr3UaJezQRckviUdFxF
 S7mOrxd8x3eZ9cm1AUC7EKRnTmYUb4VEq0acejao0Bxlgoi/1Na4mEy6MRhqUUdhnFMR
 POKEFFDa7bnSDadyoiJsDYM8w9zHVDoH2LBCRu3aSm6oIMFY0ZpEIrUh57GUKmjRdS08
 tbIA==
X-Gm-Message-State: AOJu0Ywk3ZFpDKIF9c1Ccbgf8l0t0rf/9VKOydcWlWwx6tKpYSHPpX/R
 58DYzBrBmm3bPJ86PPuNl3rYm3HONsf99riZtYUQvqzhA0nQTZ+4eB+ucNYrC/XD
X-Gm-Gg: AR+sD121wcbHRQgcuYm5VNJGZ6jjoGWccq/fQ465XDErzI+PXS3KDTKjW3ZMyJwWdWU
 u1TQzVib8Ye9EFHfbtxVw1bvmaP7wRJC4+VMp62vikpGGkkKHiYOuu51G3Qz0xOdrszpMFDNEGL
 ECEbPtvXKU5TID6ZsdzQXLy25q6DgneSdsNmCXwaetbyNSr8wZV1KWKtkw55uPlHmcduTo0HzN/
 VjVIzmewvRF7GidKclNVGEQ+IRiZYYREOVkNSzrlP6j3SKdAUn8BiIhwPCnHWMBTyyBp8RNWGYE
 9Qs/1qsLnE9lGMuKP/htkbHIH+NM1H1NVMYzNZ4pcz4xUWBB8cOgHcCc2AdB+TKrJK3RH/kUMg3
 dxG/9es9w4b0Vm1OgRXM8PF9ApbXbzISm4t+MBqaARQHmvYcP2qzDLSJmobkSvVfrEko8m7R3cm
 X6OgN8V6VUAZr2Wc7bKXMyGfteRWzyexqeXatVgRhRUouPvWDZFL+ee9MsxG1ZNpWJ9HCcXv0yd
 zDhT63KhW/E0rnwd5INrWQR4DyHorMm5uf9Dg==
X-Received: by 2002:a17:902:f551:b0:2ce:a6a4:451b with SMTP id
 d9443c01a7336-2d37f7647a3mr233048125ad.11.1786902437872; 
 Sun, 16 Aug 2026 10:47:17 -0700 (PDT)
Received: from setun ([223.228.54.80]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320ead105a9sm28343674eec.31.2026.08.16.10.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 10:47:17 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v5 04/11] migration: Use file_bmap for RAMBlock during
 incoming file load
Date: Sun, 16 Aug 2026 23:16:24 +0530
Message-ID: <20260816174631.1547811-5-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816174631.1547811-1-aadeshveer07@gmail.com>
References: <20260816174631.1547811-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pl1-x636.google.com
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
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
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
2.55.0


