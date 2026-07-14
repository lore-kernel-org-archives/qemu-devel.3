Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24D4C44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 14:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjdwV-00068C-1q; Tue, 14 Jul 2026 10:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wjdwR-00067M-K2
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:17:00 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wjdwP-0002b9-Vl
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:16:59 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-381018b9375so4908146a91.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784038616; x=1784643416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kvprChN59fHuKDQMM7n4kbzrx/TIXJdQx0Uf4S5KvaQ=;
 b=kO6RA/rF3dKlzb2kTwHQj+tXBWTf+I847Z011AvU3i2PTjmWwUR9Nmxi7lJZtJ6cXy
 jIdvn9QWOPUBKCeOiz/D1RpftJ7eotUN3n5XRxf3b+lvAAs9CZSKgyAQlfMbblXaVd5U
 xsmqcav77+pS3hlmh3M/jwcaUd/M8jzYv591wzSWsiGlWlPthzD5U3nkHtr0k6UDQzT4
 8y977uXlw3Sz+yhOwdpTvlpvlDajszcQp8RFp26HWXB79SBIKoS9mnzBG40k2t3m+JkS
 c3ct5Mc+ukyRd6xFBDdCUrZlhLavHg5DP+ZE2Xo+eXaxYFD+boUJKSgl890JE4P4FrNp
 pLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784038616; x=1784643416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kvprChN59fHuKDQMM7n4kbzrx/TIXJdQx0Uf4S5KvaQ=;
 b=WV6uJLf7krt6WmUXob9Gelv8AdK9OXU2D2Is2mjNpyrlVczgsDmnImhJhT7GxGpuZP
 Q28XO7sSFeA47dHKkG/dx1x7gt2gMdgGTFnvbKKoiLyTBcDuep2+VHj5GeB5YD5bPYSK
 mfVyhPYYXZC3QEgp7cUON2tlVK47dwqzBBRa8/wFM3kyr3XosgMHk5mkVMAmN7uvgg+l
 WHpTIjGwb4gek8YR2lU2i//kF5wLHbzmb7hIFHDvYIJqWC/lcB3/AgnPloP2ZMrFx9hM
 D1tUL0+FT6u2rTmLgK/65GKQccr0mGJHt1NRfDfoL6ElnjhhJq01iv1Ahe/DPB4wr4Ds
 ebbg==
X-Gm-Message-State: AOJu0YzuOzG+5vX997n2FK1Rxijvw+HeaqERZc6JF0Q9z09WWqDBDKIA
 XKpSIBQ5WMvhNYiA0KFjjXzMTpqzAamCUkf+CBmPRTGh0z2m18F88O93TlbY9r1A
X-Gm-Gg: AfdE7ckloyM/A10U+6jmIJmoQhkwqo7ITdugZp0V3yUmNBqGQV1JrvtFVcf9uU2OHog
 euFAiTntdaWD9cBU7vigqKMjaam5fQxq2TnHNc7vT457TyYf6xmKwI12zIxvZw2jntrDOOUWOY+
 hihXmREv/2ztdaBrKkDk5vpZmjcU4XvPoW9OIrqT946AhwXcpaqo68phBlJfobQgI2ry55O6IwJ
 E4f9khIJgaYf6aeQJ0lhBZ5f1xVPbULW21EgONxBXj3MAiZ/5ESvxlDoVVBPhRIRBE/QMfLOegy
 +DVzxXHQ0wZMhlk/cvzScUvetkjscFaNLZzkNEmQ8IhO4/SLK4UfwaIvzsa3y1ij4ap9yAhVsB/
 BWRpk35YK1zjPdwRPxZeOSr2RPcifXo83tfRxRDgulpWjq8r477wgi5v8xBwMDJ7S79USgPYdSu
 MGiF3xl33Gys4huiAmGnvvXmhQ43t3EhHtTcMQBqusxA==
X-Received: by 2002:a17:90b:3903:b0:387:df8f:1409 with SMTP id
 98e67ed59e1d1-38dc77d8a8fmr12051304a91.42.1784038616520; 
 Tue, 14 Jul 2026 07:16:56 -0700 (PDT)
Received: from setun ([2405:201:502b:3014:cc0c:536:1b1e:6def])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118ee6091dsm97329733eec.14.2026.07.14.07.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 07:16:55 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PATCH v3 04/11] migration: Use file_bmap for RAMBlock during
 incoming file load
Date: Tue, 14 Jul 2026 19:45:40 +0530
Message-ID: <20260714141547.1268000-5-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714141547.1268000-1-aadeshveer07@gmail.com>
References: <20260714141547.1268000-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pj1-x102f.google.com
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
2.55.0


