Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820B2D10F5F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 15:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOHkC-0002Lj-OZ; Wed, 26 Nov 2025 10:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pzmarzly0@gmail.com>)
 id 1vOHk4-00024z-Og
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 10:47:40 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pzmarzly0@gmail.com>)
 id 1vOHk2-00089W-7T
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 10:47:39 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47789cd2083so40653715e9.2
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 07:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764172056; x=1764776856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qLca+SjWpTyHxDEhKAsHhI0VNOBtyR6cwHKmxcrWQyI=;
 b=gIyrDyle/XnHuowiopHvylFiAbR1ZfWbjZU1HGJaPZcCCsi8edS1G3ZIK5kXXaxC3w
 eC34ALvgAxdYn8aDoe6vufgWArWzfQFj6+jdzXzfk4CXUPO3WK4jgZWAKRwzzNTt29ho
 Vi4o1+C491gOyIgK0RaqYsJCmTKuwosXZtgU1Pp9VN10Q2ZZrDwVq+WmpkCGY8x3bWl+
 EEULd/pnl0RCTGBaVEI0JX5kM18Q4mqgARH0DSToh2fzB5JIrmCuw9SPqJ7iZ2lrWpHU
 en7oMS9K8aSKB9pkORkJhmvgIDMk4KvuPlDg/QHfvIK40ZLJdlau8xSUEZyzhF+NAXQf
 Sz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764172056; x=1764776856;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qLca+SjWpTyHxDEhKAsHhI0VNOBtyR6cwHKmxcrWQyI=;
 b=WzE/Ak0j/CNivBhoV7y5a0VoQUey1hbbN4IIW9mWOwrAhvRsqRtTfpxJxYDQzr8QGh
 z0xBbbhY4/8/h77Xe4PQGVxQniMi+GK+ym6osDzMxpY6cC8zsG1Cy6l0ilDLzoGxg99n
 3ZvYFjVQGo2JGj+9se1OH2MoCRyL2L5JFBfHKK4RC7BA4I5rRBVILeiFnQLCVEkGyREE
 KZPrZConzWCf6fLBh53zc4Ok4snfNbB3qQ/cHzestW7rBEXkBHKBgvFAGojvI++l0wF/
 r6h6yHrVmse2svLbNlDjkCzKBLgX92V2p2eCkPuXKnzoF3OziI3iOsftdgVXIRxrINDn
 atZA==
X-Gm-Message-State: AOJu0Yw8RX6Oa3NWwM4GSjYgyOtRBxjL1Q2j+sOaCnC3Xhn4ahIfxq2z
 1i/cMCQxx3zKEbLlLBdTFpFlaGu3TZ4uMWzCqdOskIRGoBRLnTs2cPSBB9DnxZEPlrc=
X-Gm-Gg: ASbGncvxcBjmMRCdkhDp9FApAl9hrcxXhQO2wTpjpT20q25LQXD9XZPZYtlhUelCt7E
 ZLfuYCZN2hi1dSEXp5XrE1XMc3wFME/uVZLkg6epBAS2xKsNAttPsv2SADxM91dq5ISBtzm6LF1
 83bSn3xdFKV9CmAL4S39mv8u6TFka1jtkJRMhuE6DyhJd7gRXrpRG3Cz6CqUtpVxyysA/wvsZ9U
 Oxnt8wPVRFfqE6za1ymMAn+sfbozGvsGi5zZC5ZhnEEqA+ShAftRM1ik940cgZAcFkB4yxQJEJb
 F9xgmAhhZu2sGmrj5kQ4ibo0jWEj9vJmW4HYLQbq6r2QDDxozQMXnzHvCn8zv9hup9TrRP8+PJC
 +qkfdXz5baiYwvIR/YOUtXlu2UQ0AhTiv1Or4OnrNXYYWwhDQWVB3tpikEy9RexZrF1bxP5Zjoe
 diihD1Ims=
X-Google-Smtp-Source: AGHT+IHcS17YkmaeovVgvpVmEo9rL2qNdsYed+BczwsYBIKtRaphi6psCwEpaVfW30U/+7rxWgBEbw==
X-Received: by 2002:a05:600c:19ca:b0:477:a978:3a7b with SMTP id
 5b1f17b1804b1-477c1143073mr189621965e9.22.1764172055872; 
 Wed, 26 Nov 2025 07:47:35 -0800 (PST)
Received: from localhost ([109.76.183.78]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479052daee3sm43234345e9.12.2025.11.26.07.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 07:47:35 -0800 (PST)
From: Pawel Zmarzly <pzmarzly0@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de
Subject: [PATCH] migration: Fix writing mapped_ram + ignore_shared snapshots
Date: Wed, 26 Nov 2025 15:47:34 +0000
Message-ID: <20251126154734.940066-1-pzmarzly0@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=pzmarzly0@gmail.com; helo=mail-wm1-x32d.google.com
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

Currently if you set these flags and have any shared memory object, saving
a snapshot will fail with:

    Failed to write bitmap to file: Unable to write to file: Bad address

We need to skip writing RAMBlocks that are backed by shared objects.

Also, we should mark these RAMBlocks as skipped, so the snapshot format stays
readable to tools that later don't know QEMU's command line (for example
scripts/analyze-migration.py). I used bitmap_offset=0 pages_offset=0 for this.

This minor change to snapshot format should be safe, as offset=0 should not
have ever been possible.

Signed-off-by: Pawel Zmarzly <pzmarzly0@gmail.com>
---
This requires my previous patch "migration: fix parsing snapshots with
x-ignore-shared flag". To make things easier, you can see the stack at
https://gitlab.com/pzmarzly/qemu/-/commits/pzmarzly?ref_type=heads
---
 migration/ram.c | 51 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 7d024b88b5..8063522a14 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3042,28 +3042,36 @@ static void mapped_ram_setup_ramblock(QEMUFile *file, RAMBlock *block)
     header = g_new0(MappedRamHeader, 1);
     header_size = sizeof(MappedRamHeader);
 
-    num_pages = block->used_length >> TARGET_PAGE_BITS;
-    bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
-
-    /*
-     * Save the file offsets of where the bitmap and the pages should
-     * go as they are written at the end of migration and during the
-     * iterative phase, respectively.
-     */
-    block->bitmap_offset = qemu_get_offset(file) + header_size;
-    block->pages_offset = ROUND_UP(block->bitmap_offset +
-                                   bitmap_size,
-                                   MAPPED_RAM_FILE_OFFSET_ALIGNMENT);
-
     header->version = cpu_to_be32(MAPPED_RAM_HDR_VERSION);
     header->page_size = cpu_to_be64(TARGET_PAGE_SIZE);
-    header->bitmap_offset = cpu_to_be64(block->bitmap_offset);
-    header->pages_offset = cpu_to_be64(block->pages_offset);
+
+    if (migrate_ram_is_ignored(block)) {
+        header->bitmap_offset = 0;
+        header->pages_offset = 0;
+    } else {
+        num_pages = block->used_length >> TARGET_PAGE_BITS;
+        bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
+
+        /*
+         * Save the file offsets of where the bitmap and the pages should
+         * go as they are written at the end of migration and during the
+         * iterative phase, respectively.
+         */
+        block->bitmap_offset = qemu_get_offset(file) + header_size;
+        block->pages_offset = ROUND_UP(block->bitmap_offset +
+                                       bitmap_size,
+                                       MAPPED_RAM_FILE_OFFSET_ALIGNMENT);
+
+        header->bitmap_offset = cpu_to_be64(block->bitmap_offset);
+        header->pages_offset = cpu_to_be64(block->pages_offset);
+    }
 
     qemu_put_buffer(file, (uint8_t *) header, header_size);
 
-    /* prepare offset for next ramblock */
-    qemu_set_offset(file, block->pages_offset + block->used_length, SEEK_SET);
+    if (!migrate_ram_is_ignored(block)) {
+        /* leave space for block data */
+        qemu_set_offset(file, block->pages_offset + block->used_length, SEEK_SET);
+    }
 }
 
 static bool mapped_ram_read_header(QEMUFile *file, MappedRamHeader *header,
@@ -3146,7 +3154,6 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
             if (migrate_ignore_shared()) {
                 qemu_put_be64(f, block->mr->addr);
             }
-
             if (migrate_mapped_ram()) {
                 mapped_ram_setup_ramblock(f, block);
             }
@@ -3217,6 +3224,10 @@ static void ram_save_file_bmap(QEMUFile *f)
     RAMBlock *block;
 
     RAMBLOCK_FOREACH_MIGRATABLE(block) {
+        if (migrate_ram_is_ignored(block)) {
+            continue;
+        }
+
         long num_pages = block->used_length >> TARGET_PAGE_BITS;
         long bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
 
@@ -4162,6 +4173,10 @@ static void parse_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
         return;
     }
 
+    if (migrate_ignore_shared() && header.bitmap_offset == 0 && header.pages_offset == 0) {
+        return;
+    }
+
     block->pages_offset = header.pages_offset;
 
     /*
-- 
2.52.0

