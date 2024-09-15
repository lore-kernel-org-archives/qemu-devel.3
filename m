Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBBFC3ABA0
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 16:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sproD-0002Q8-1D; Sun, 15 Sep 2024 12:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1spro8-0002Ne-Jv
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 12:09:05 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1spro6-0006N5-Is
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 12:09:04 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71798a15ce5so3193410b3a.0
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 09:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1726416541; x=1727021341;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3OFIU38UikYUB3gdX1kGRi1xc6HOThSaI+9KQA5Kl24=;
 b=E1MknaFWdOHgPEXWVTxM9xhxEqDY0vszdnpt1Xv4inupOTWoY4UTr+OcmLac/IWkNZ
 9NEaobQuKbVlnrPOZWQ2EayG5ZnHojtLBhOU5B5gLVrQRVSOfEAnmvr3vqe6HaNhZfO5
 NvH/GTpW7nGC8MV791deA6zRc/XVSVE/0QuXSn9FWE/ihE2cSFGlbYq+nZFfsenciPmY
 k/m+KAnSzE1gbioBq5ZBvM7E2iaeZ0oU1LWsoXFcuMGAB3YQ579cFPyT5UvegF7j10Dr
 c2gkv9ZSem9ZHilMZc/Z5J9LkcXRTMImZr+3tCROb4gO613bNichvjpMStUVNItxh4p0
 9a9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726416541; x=1727021341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3OFIU38UikYUB3gdX1kGRi1xc6HOThSaI+9KQA5Kl24=;
 b=DwEJHUYCzXvesf/Fr8XHmUgrnt4QJwxlMr91X2zt/REmkkI1qIj8WbBKBHK3eh1yJL
 aUcYX079sm8GdSDqbId9F73Xps3kQd9Fd76RN/utcJGUSieZFWLEVOvvzgD5KXxz1y0e
 dMXRRviE/oAbOybQJ3xBKRmoawt3pQX0TXFG53A2jZxX7gOnfGzyMkV9EFF/GvF5fIh8
 In1f8awWqCKlF0+SlU55ID50Wz0k8dLIGKp65uFwq5t0CP+1FYonhLYqt4yJQMiMLUJi
 C1DWWi1NjWWJ0Z629ReIi4wEYcZ1kBl2p7ZogTtoNF5oxQ4zRBHCWgKhgYRiBmMfH1nn
 98Fg==
X-Gm-Message-State: AOJu0YzuDk8/VfgPdoqcByskqxT0CrzD5HQM9oqKkm1yiJsT4H7c/kxS
 zDRUXJaYzLYFnDMSaOSSrEjWcNoLO3V/JiWb1w3vDJz0M9v6uO/IqKYNK75e97VDGwnUGLrwRcq
 a0kIpXQ==
X-Google-Smtp-Source: AGHT+IFh1U2MKNLDcaCu/t2xOiFeWPrezQ5sXg+TZK8gPYm0NLZ5WFpOfOsKQwyzvP6FtmXLKAh5pg==
X-Received: by 2002:a05:6a20:e605:b0:1cf:1228:c175 with SMTP id
 adf61e73a8af0-1cf755c76eamr18380582637.8.1726416540322; 
 Sun, 15 Sep 2024 09:09:00 -0700 (PDT)
Received: from localhost.localdomain ([118.114.94.247])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71944bb5967sm2344795b3a.182.2024.09.15.09.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2024 09:09:00 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v1 1/7] migration: Introduce structs for background sync
Date: Mon, 16 Sep 2024 00:08:44 +0800
Message-Id: <531750c8d7b6c09f877b5f335a60fab402c168be.1726390098.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1726390098.git.yong.huang@smartx.com>
References: <cover.1726390098.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

shadow_bmap, iter_bmap and iter_dirty_pages are introduced
to satisfy the need for background sync.

Meanwhile, introduce enumeration of sync method.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 include/exec/ramblock.h | 45 +++++++++++++++++++++++++++++++++++++++++
 migration/ram.c         |  6 ++++++
 2 files changed, 51 insertions(+)

diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
index 0babd105c0..0e327bc0ae 100644
--- a/include/exec/ramblock.h
+++ b/include/exec/ramblock.h
@@ -24,6 +24,30 @@
 #include "qemu/rcu.h"
 #include "exec/ramlist.h"
 
+/* Possible bits for cpu_physical_memory_sync_dirty_bitmap */
+
+/*
+ * The old-fashioned sync, which is, in turn, used for CPU
+ * throttle and memory transfer.
+ */
+#define RAMBLOCK_SYN_LEGACY_ITER   (1U << 0)
+
+/*
+ * The modern sync, which is, in turn, used for CPU throttle
+ * and memory transfer.
+ */
+#define RAMBLOCK_SYN_MODERN_ITER   (1U << 1)
+
+/* The modern sync, which is used for CPU throttle only */
+#define RAMBLOCK_SYN_MODERN_BACKGROUND    (1U << 2)
+
+#define RAMBLOCK_SYN_MASK  (0x7)
+
+typedef enum RAMBlockSynMode {
+    RAMBLOCK_SYN_LEGACY, /* Old-fashined mode */
+    RAMBLOCK_SYN_MODERN, /* Background-sync-supported mode */
+} RAMBlockSynMode;
+
 struct RAMBlock {
     struct rcu_head rcu;
     struct MemoryRegion *mr;
@@ -89,6 +113,27 @@ struct RAMBlock {
      * could not have been valid on the source.
      */
     ram_addr_t postcopy_length;
+
+    /*
+     * Used to backup the bmap during background sync to see whether any dirty
+     * pages were sent during that time.
+     */
+    unsigned long *shadow_bmap;
+
+    /*
+     * The bitmap "bmap," which was initially used for both sync and memory
+     * transfer, will be replaced by two bitmaps: the previously used "bmap"
+     * and the recently added "iter_bmap." Only the memory transfer is
+     * conducted with the previously used "bmap"; the recently added
+     * "iter_bmap" is utilized for dirty bitmap sync.
+     */
+    unsigned long *iter_bmap;
+
+    /* Number of new dirty pages during iteration */
+    uint64_t iter_dirty_pages;
+
+    /* If background sync has shown up during iteration */
+    bool background_sync_shown_up;
 };
 #endif
 #endif
diff --git a/migration/ram.c b/migration/ram.c
index 67ca3d5d51..f29faa82d6 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2362,6 +2362,10 @@ static void ram_bitmaps_destroy(void)
         block->bmap = NULL;
         g_free(block->file_bmap);
         block->file_bmap = NULL;
+        g_free(block->shadow_bmap);
+        block->shadow_bmap = NULL;
+        g_free(block->iter_bmap);
+        block->iter_bmap = NULL;
     }
 }
 
@@ -2753,6 +2757,8 @@ static void ram_list_init_bitmaps(void)
             }
             block->clear_bmap_shift = shift;
             block->clear_bmap = bitmap_new(clear_bmap_size(pages, shift));
+            block->shadow_bmap = bitmap_new(pages);
+            block->iter_bmap = bitmap_new(pages);
         }
     }
 }
-- 
2.39.1


