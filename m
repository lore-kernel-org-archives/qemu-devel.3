Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9C8C55171
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 02:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpzbf-0001JB-QK; Fri, 31 Jul 2026 22:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wpzbX-0001GA-2H
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 22:37:42 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wpzbV-0002Wq-FO
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 22:37:38 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-38e347638adso2033474a91.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 19:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785551856; x=1786156656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jIq/nRQkJTnpXSZRT4CeyLWFSbzz88Q5sMkArBGv8Ns=;
 b=KvEZNJant1LIhYkCCRn5h7FyLclfNDFmwQZt3FFB2/PmGsq20DEfpECNayNv1pLKkG
 ELSbZ9RyhJQ7nTH/Va9y/MGSOs36TbAXgSYQkMLrAFmwWZEi/Ey2NYMMhMi0UaFcULfB
 4p/2KsTsXZ+ztCYHkG9GvVTkzzyo3zJ4CMlM/5guwoG3g6N/QqVuUgWEqIBiJvOhg3wz
 XRQszd5HY5pSYLNHWuHzpN8HGKFEyxhADjLgXTobRzw1YMfYONF91INmbSBwqs00d78g
 jz+UDIrmn6+56JsNGQ4FP1xJQWTTn0knzq13luPFJeIENyHk1+ZvOiYnz7/sRUpRITIG
 PpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785551856; x=1786156656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jIq/nRQkJTnpXSZRT4CeyLWFSbzz88Q5sMkArBGv8Ns=;
 b=G+iIZ/hZ8RQsIq9/kagXGTPFCv6LT82c/nk3lSr5TRzP2HETT/ZrZM1KKNV5dP4P2j
 ImlvO2Y3Z4WYfJh96X/EWKGwfzAGHXYJtP/09b/LeSC3GitgSeZ4ddthrQtIcc0xQAdp
 jciG14meARsnQUnDFJtwg9gaPRT4mFANK7DQQQkr66pOrPwgL/1hIkvS7kLzkioBqABX
 l5XrOWlVUxotI0X5Cm5fk4eRYRBO2OSOxj9GxPDQKZHdFMD/cDYD/RJaPgfOxisW8yWU
 QwFjL5wrYuPoFNpyqaG7opHmorRhWh2QJjkQIRsfg33KITfQ+663TQXMbZ1KoYYUBpbr
 +SHg==
X-Gm-Message-State: AOJu0Yzxb4i39LiVKmhq/l0stM/X6Aa1ElUgF7ZyOYMLMithG7kkgvQP
 Szrf6QRcYy6YIUTw4uZtuSJGf8moW1n6nRl1kmE3is/JY/tRP1wwhId8LcdaOLPb
X-Gm-Gg: AR+sD10ECzZJGYsr+wqiL2zkYIUl87yCq/UEo2CjWK+1IzLRVz/Mb80wNlXK/E9Wz9K
 Ca6X6QZIpPE21p+qqLhsW6h9YxsUIj8/pTrs9d5dOH24qN3q13WfmjAsBhPbYGBX1+YGQVYgiEF
 i3ViQxuDDvhhXPluaP6ludGrvzW9A/1ReQwi6m4fxamzxPYFsP+9Rqle5/HGBzLaUow3eBMfedu
 Q2iCZUxOL/s1/6L+jWm5NwZKeH7mZ3i/b5JoQysxBDMoNrqYwW/z0lf3i7hLLIQ357180qtAUsg
 hy8agwnGoj//mFmqgfAN4qB1hdgwJg3QwddL1AbfQEmjedRO+AGYtS0OU4Vq7JmErLpU3T+w+sp
 /yZwQiU4nc4cGKlQ7WCb4roWdiZ47LRYdbDLsTfiGF+Lx2aTbcNO2Yg1RcGsmiPM2k5fYUslHkN
 WtbrNp6tTkEOdFA5tDHM3S+vUmNSYbPPEkJCPS132j6MmTN+vft3IlbDq/byeGe5uVKL9aHFxbb
 on/PMiwAlz1UzUr
X-Received: by 2002:a17:90b:534e:b0:38e:2aa8:60d0 with SMTP id
 98e67ed59e1d1-38fbc598d19mr2111431a91.37.1785551855887; 
 Fri, 31 Jul 2026 19:37:35 -0700 (PDT)
Received: from setun ([223.228.61.127]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e47dsm15678889eec.3.2026.07.31.19.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 19:37:35 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PATCH v4 04/11] migration: Use file_bmap for RAMBlock during
 incoming file load
Date: Sat,  1 Aug 2026 08:06:21 +0530
Message-ID: <20260801023628.22665-5-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260801023628.22665-1-aadeshveer07@gmail.com>
References: <20260801023628.22665-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pj1-x1032.google.com
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


