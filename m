Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AF7C19F4F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qgh-0006Ui-Gh; Tue, 30 Apr 2024 12:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgJ-00062K-Of
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:50:16 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgH-00060m-OY
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:50:15 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-51b09c3a111so8378050e87.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714495810; x=1715100610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O5hYPezHo/zUw5sp2oiFt2YbldZcwf6wRos1WLmtnWI=;
 b=Rm11UI1BoWEfe7ajRuKPHBfO0W1fP1WNjyAwjfC+isJhCxxiXxRWlAkoOAT/IrnJoj
 xyTs6SQNuRu32rov3hCe31OzYzVykwGlnveO3El0ksE3It1r7/BgibkZjLdBk3KbnbyG
 mpUibJi4Awc+HhaXiNNkE+AfQb7mVQsxElpyfAhR1fmz045xHlq7nuoAapXjnmPrWGfJ
 dsXg3Ruzns6GQ+1R7t1T+pTsl5+1UB0wzAgHOeqW0hfkZpxP7ZEWGPlTGASNM01XiwrK
 sX14kjbjh0wgeJB/LHHlNQS/mKB39TKHwnRJF8ZonLOHK11TxxzgiYmFa6DpJSNghRO3
 JZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495810; x=1715100610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O5hYPezHo/zUw5sp2oiFt2YbldZcwf6wRos1WLmtnWI=;
 b=qQz741ISNpQzAq2Kg7+/C3lLrlBZi+iSTmBxzBKZKCf16b97q/ohgzebxG0Bh8rmGF
 gxgNppNo4oeOnR7w8hk1QZrHTUvKuMU7ekwBM9CbdjnZVRrChGsJ45tLI9Tbm89TyNtu
 UCuamSyipbn+5Jz1jL04ykIWxfjwRyo3PpnFAiqtaMlEwokbWBVj5bBV8ha0qr0aX8W8
 9oYRCXjaVJTkr4bKz1QiQ93lMj/tx6EKwL7pkPNEhqc8DFca7DAP8vLFRRUrXVFZ5GYe
 T8W2G/u+XftPj7gXGUTN1fiY8nT/8UsgvNVpFEUycr0v5E4EjQ4PLt5AlGHB7c/k9qIp
 a+PA==
X-Gm-Message-State: AOJu0Yz5jFWAYjNdBLZCZRGrwXx6JO9UK+bb8jcF9rKwkhrTkjX1Iim9
 oLmyGHJu5hhuGlWqfhfDqpJOyrQh2rxt9zrIBEPctK7hbe4MUGuJl1MiUMpV
X-Google-Smtp-Source: AGHT+IEu2vlNQZuUjLrZbAElRgF9mqW1BA23HN64n4+WENNqRodrErKRabxZXDwUC9luBsb2kGGndA==
X-Received: by 2002:a05:6512:3f21:b0:51d:8159:598 with SMTP id
 y33-20020a0565123f2100b0051d81590598mr35777lfa.19.1714495809996; 
 Tue, 30 Apr 2024 09:50:09 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 k8-20020a192d08000000b0051ac9a297aasm4096722lfj.141.2024.04.30.09.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:50:08 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 Vikram Garhwal <vikram.garhwal@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 01/17] softmmu: let qemu_map_ram_ptr() use
 qemu_ram_ptr_length()
Date: Tue, 30 Apr 2024 18:49:23 +0200
Message-Id: <20240430164939.925307-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240430164939.925307-1-edgar.iglesias@gmail.com>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Juergen Gross <jgross@suse.com>

qemu_map_ram_ptr() and qemu_ram_ptr_length() share quite some code, so
modify qemu_ram_ptr_length() a little bit and use it for
qemu_map_ram_ptr(), too.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 system/physmem.c | 56 ++++++++++++++++++++----------------------------
 1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 1a81c226ba..f114b972a5 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2188,43 +2188,17 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t length)
 }
 #endif /* !_WIN32 */
 
-/* Return a host pointer to ram allocated with qemu_ram_alloc.
- * This should not be used for general purpose DMA.  Use address_space_map
- * or address_space_rw instead. For local memory (e.g. video ram) that the
- * device owns, use memory_region_get_ram_ptr.
- *
- * Called within RCU critical section.
- */
-void *qemu_map_ram_ptr(RAMBlock *block, ram_addr_t addr)
-{
-    if (block == NULL) {
-        block = qemu_get_ram_block(addr);
-        addr -= block->offset;
-    }
-
-    if (xen_enabled() && block->host == NULL) {
-        /* We need to check if the requested address is in the RAM
-         * because we don't want to map the entire memory in QEMU.
-         * In that case just map until the end of the page.
-         */
-        if (block->offset == 0) {
-            return xen_map_cache(addr, 0, 0, false);
-        }
-
-        block->host = xen_map_cache(block->offset, block->max_length, 1, false);
-    }
-    return ramblock_ptr(block, addr);
-}
-
-/* Return a host pointer to guest's ram. Similar to qemu_map_ram_ptr
- * but takes a size argument.
+/*
+ * Return a host pointer to guest's ram.
  *
  * Called within RCU critical section.
  */
 static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
                                  hwaddr *size, bool lock)
 {
-    if (*size == 0) {
+    hwaddr len = 0;
+
+    if (size && *size == 0) {
         return NULL;
     }
 
@@ -2232,7 +2206,10 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
         block = qemu_get_ram_block(addr);
         addr -= block->offset;
     }
-    *size = MIN(*size, block->max_length - addr);
+    if (size) {
+        *size = MIN(*size, block->max_length - addr);
+        len = *size;
+    }
 
     if (xen_enabled() && block->host == NULL) {
         /* We need to check if the requested address is in the RAM
@@ -2240,7 +2217,7 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
          * In that case just map the requested area.
          */
         if (block->offset == 0) {
-            return xen_map_cache(addr, *size, lock, lock);
+            return xen_map_cache(addr, len, lock, lock);
         }
 
         block->host = xen_map_cache(block->offset, block->max_length, 1, lock);
@@ -2249,6 +2226,19 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
     return ramblock_ptr(block, addr);
 }
 
+/*
+ * Return a host pointer to ram allocated with qemu_ram_alloc.
+ * This should not be used for general purpose DMA.  Use address_space_map
+ * or address_space_rw instead. For local memory (e.g. video ram) that the
+ * device owns, use memory_region_get_ram_ptr.
+ *
+ * Called within RCU critical section.
+ */
+void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr)
+{
+    return qemu_ram_ptr_length(ram_block, addr, NULL, false);
+}
+
 /* Return the offset of a hostpointer within a ramblock */
 ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host)
 {
-- 
2.40.1


