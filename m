Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9267BECE58B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 20:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snkjy-0000Fg-Nr; Mon, 09 Sep 2024 16:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snkjw-00004v-7B
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 16:12:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snkjt-00050S-LF
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 16:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725912716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8crV/ycQb1WW3+BtmyCL6RoebnxZjRylOFrGpe4gHdU=;
 b=ipT8s8jBABZGlQCva6UnvuFJ6DCwSBnf9lOjOCL3spZXEn7n6HzhB4Iybce+i4Zbe7Njw8
 zl4V7ECOfa9wilE7JntW466PAuafz30TLtNl3oht2tupBAmbY9GYm2tPZYBnHM6OhkRZ3w
 ewY7XXEqCleEmEnTR9p5gvZgey8DWL0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-mpDzQOiBOuWPyxC8_rq5xQ-1; Mon, 09 Sep 2024 16:11:54 -0400
X-MC-Unique: mpDzQOiBOuWPyxC8_rq5xQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-45798aa2bacso76109881cf.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 13:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725912714; x=1726517514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8crV/ycQb1WW3+BtmyCL6RoebnxZjRylOFrGpe4gHdU=;
 b=SXyFYsJlQ9x7H3Qx2JMgDps0Bjse88mZhYJTlYz3aPrNVZHDRMr+caCP7HhhAWbdYa
 3xFKer/MKJbnP3jnGo7dfzBTtNuH7pBn5ooNU1677MDupYA8Y6wg13jiCyX5Dgo5m/rK
 uVVsWznWpsxSpeD7ErJ2GI8VsKbYW01rs0UtiLt9aoqkQj6iFcrK6jfbAjECDJVPnhW9
 w3eP1BZzuH5yVuZyRBufK02caSXSLKdUI39gfUoshXCP39F2XN5nbXmXAt0KMqvstqCX
 +tgtXUVC07ZFvFgWZknYMctBp/8IaR0Y97WKiS7aDGv/8GwmkkgmKrxX5yqpWmSI45/G
 F37Q==
X-Gm-Message-State: AOJu0YwbYxTW1IcMNa96QvWTx5GHiCKnsxdMNQz2Az5adt0JrqcKdXTT
 wOHNuesyVPATwLxFS3Bg+OhR2kYT1xw5fx4EEneRemCaQa65XfFtOx+DIUnB4J9Ta7beY8TL3Kw
 XswjcYSG5Vi0Wxt76TD+JtO1SvESefVTpREf8u/xsSx2uf79aH0ZaCKCh807hENIPE31tJLpKMA
 EcPK2ngiFMSSIirDpJ+Ux2m4FaeY3DSL7bEg==
X-Received: by 2002:a05:622a:64f:b0:458:2894:9870 with SMTP id
 d75a77b69052e-45828949c51mr83205741cf.10.1725912713701; 
 Mon, 09 Sep 2024 13:11:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcsa3tazYtKBEE6ZNofjJygtvH5SjHMnXo3i9kpBbCjJMj7Cub5GJrFW6Ef0H8m+mxVLZAew==
X-Received: by 2002:a05:622a:64f:b0:458:2894:9870 with SMTP id
 d75a77b69052e-45828949c51mr83205091cf.10.1725912713171; 
 Mon, 09 Sep 2024 13:11:53 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822f93978sm22838561cf.83.2024.09.09.13.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 13:11:52 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/9] softmmu/physmem: fix memory leak in dirty_memory_extend()
Date: Mon,  9 Sep 2024 16:11:40 -0400
Message-ID: <20240909201147.3761639-3-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240909201147.3761639-1-peterx@redhat.com>
References: <20240909201147.3761639-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: David Hildenbrand <david@redhat.com>

As reported by Peter, we might be leaking memory when removing the
highest RAMBlock (in the weird ram_addr_t space), and adding a new one.

We will fail to realize that we already allocated bitmaps for more
dirty memory blocks, and effectively discard the pointers to them.

Fix it by getting rid of last_ram_page() and by remembering the number
of dirty memory blocks that have been allocated already.

While at it, let's use "unsigned int" for the number of blocks, which
should be sufficient until we reach ~32 exabytes.

Looks like this leak was introduced as we switched from using a single
bitmap_zero_extend() to allocating multiple bitmaps:
bitmap_zero_extend() relies on g_renew() which should have taken care of
this.

Resolves: https://lkml.kernel.org/r/CAFEAcA-k7a+VObGAfCFNygQNfCKL=AfX6A4kScq=VSSK0peqPg@mail.gmail.com
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: 5b82b703b69a ("memory: RCU ram_list.dirty_memory[] for safe RAM hotplug")
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20240828090743.128647-1-david@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/ramlist.h |  1 +
 system/physmem.c       | 35 +++++++++--------------------------
 2 files changed, 10 insertions(+), 26 deletions(-)

diff --git a/include/exec/ramlist.h b/include/exec/ramlist.h
index 2ad2a81acc..d9cfe530be 100644
--- a/include/exec/ramlist.h
+++ b/include/exec/ramlist.h
@@ -50,6 +50,7 @@ typedef struct RAMList {
     /* RCU-enabled, writes protected by the ramlist lock. */
     QLIST_HEAD(, RAMBlock) blocks;
     DirtyMemoryBlocks *dirty_memory[DIRTY_MEMORY_NUM];
+    unsigned int num_dirty_blocks;
     uint32_t version;
     QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
 } RAMList;
diff --git a/system/physmem.c b/system/physmem.c
index 971bfa0855..d71a2b1bbd 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1534,18 +1534,6 @@ static ram_addr_t find_ram_offset(ram_addr_t size)
     return offset;
 }
 
-static unsigned long last_ram_page(void)
-{
-    RAMBlock *block;
-    ram_addr_t last = 0;
-
-    RCU_READ_LOCK_GUARD();
-    RAMBLOCK_FOREACH(block) {
-        last = MAX(last, block->offset + block->max_length);
-    }
-    return last >> TARGET_PAGE_BITS;
-}
-
 static void qemu_ram_setup_dump(void *addr, ram_addr_t size)
 {
     int ret;
@@ -1799,13 +1787,11 @@ void qemu_ram_msync(RAMBlock *block, ram_addr_t start, ram_addr_t length)
 }
 
 /* Called with ram_list.mutex held */
-static void dirty_memory_extend(ram_addr_t old_ram_size,
-                                ram_addr_t new_ram_size)
+static void dirty_memory_extend(ram_addr_t new_ram_size)
 {
-    ram_addr_t old_num_blocks = DIV_ROUND_UP(old_ram_size,
-                                             DIRTY_MEMORY_BLOCK_SIZE);
-    ram_addr_t new_num_blocks = DIV_ROUND_UP(new_ram_size,
-                                             DIRTY_MEMORY_BLOCK_SIZE);
+    unsigned int old_num_blocks = ram_list.num_dirty_blocks;
+    unsigned int new_num_blocks = DIV_ROUND_UP(new_ram_size,
+                                               DIRTY_MEMORY_BLOCK_SIZE);
     int i;
 
     /* Only need to extend if block count increased */
@@ -1837,6 +1823,8 @@ static void dirty_memory_extend(ram_addr_t old_ram_size,
             g_free_rcu(old_blocks, rcu);
         }
     }
+
+    ram_list.num_dirty_blocks = new_num_blocks;
 }
 
 static void ram_block_add(RAMBlock *new_block, Error **errp)
@@ -1846,11 +1834,9 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
     RAMBlock *block;
     RAMBlock *last_block = NULL;
     bool free_on_error = false;
-    ram_addr_t old_ram_size, new_ram_size;
+    ram_addr_t ram_size;
     Error *err = NULL;
 
-    old_ram_size = last_ram_page();
-
     qemu_mutex_lock_ramlist();
     new_block->offset = find_ram_offset(new_block->max_length);
 
@@ -1901,11 +1887,8 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         }
     }
 
-    new_ram_size = MAX(old_ram_size,
-              (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS);
-    if (new_ram_size > old_ram_size) {
-        dirty_memory_extend(old_ram_size, new_ram_size);
-    }
+    ram_size = (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS;
+    dirty_memory_extend(ram_size);
     /* Keep the list sorted from biggest to smallest block.  Unlike QTAILQ,
      * QLIST (which has an RCU-friendly variant) does not have insertion at
      * tail, so save the last element in last_block.
-- 
2.45.0


