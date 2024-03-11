Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE623C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjngb-0000XQ-Ik; Mon, 11 Mar 2024 17:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngV-0000PR-FJ
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngS-00040F-RH
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yRGPg/czG58tLUCGpqFBbCYEw31JuRNr9OOpCiRQjy0=;
 b=ENQRDMj4Ie3GFkd3xiuyrKENvwAyDbTbJGE9TRJJu42zZE15pZIk0oALZWKcrzGt8yVmWJ
 aukyXLZRnSqvn5/zDPMHqFNFW6jO0ju4I9HI178LCCtvdq8dV+SJDzu7Reg2jE3qFtLKEn
 9YKx8hjyVj0+oMyT5rwHDqp28Bd6pf4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-cFrAhoSZNYyDt_qie4EeQg-1; Mon, 11 Mar 2024 17:59:45 -0400
X-MC-Unique: cFrAhoSZNYyDt_qie4EeQg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-690d3f5af86so4505506d6.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 14:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194385; x=1710799185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yRGPg/czG58tLUCGpqFBbCYEw31JuRNr9OOpCiRQjy0=;
 b=W1KvWT2tRY0wWw0nKTNivoH9rluTGl2dnttD38+yCPGFzSC64WbSNPEdfcDfV6Ty87
 pkcUbBHq1ydnYf1mDuUdyP3OgR396y/GbkAJY5WSKBxLcjIhXq2PeC0jOMpFUqQHVqrT
 teJyU4unVwBEm48O2B2GpsM6f1eSN/Jw0kW11zptYs/K25NJJzhf0vo8AJnr4wQ+9+Cg
 PKMAyavqEEKS+APd23nxFau9IV7OsXhImN3o8eTDsnzSENoGb2DU9h1/KNC8fSi7a0oo
 lkisOGK3+Hj8M0QUMtHh8yzDNJmQS4tmHuTh4r3DP7qWAfuL2NfNW8NOJLoku5aUtuu4
 W33A==
X-Gm-Message-State: AOJu0YyOnHx/mTVBsl9/e0Bodin2QmniUFEGZKJaRX2/Od7qHaNnyjfR
 JeyTeTmAkO9v6jKT4kLXZ2Y6EAqxPi1nNgI3x42Br+9QJoE2Tk3h5pKuA7fP3N8HEzizpeC1Q4S
 6JRXMa8Dzh4kKlxKxlx9mcql1j1QdnxSeHYsVEpicD7yk68qZ4MAyTlfwKI60F6hszzhbsNHToI
 1nw6mDWcOQ2Rw7ThWP8O3320CJ7WWr36f3tA==
X-Received: by 2002:ad4:5bec:0:b0:690:e47c:9bee with SMTP id
 k12-20020ad45bec000000b00690e47c9beemr406381qvc.4.1710194384861; 
 Mon, 11 Mar 2024 14:59:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmNZoMikAaOW0gfJu6qy88OFt8U8twruAvieSn9O7B5S8Qzesk6AuVk9ZsOoQsvcC7OVnGCg==
X-Received: by 2002:ad4:5bec:0:b0:690:e47c:9bee with SMTP id
 k12-20020ad45bec000000b00690e47c9beemr406360qvc.4.1710194384389; 
 Mon, 11 Mar 2024 14:59:44 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.14.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 14:59:43 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/34] physmem: Reduce local variable scope in
 flatview_read/write_continue()
Date: Mon, 11 Mar 2024 17:59:03 -0400
Message-ID: <20240311215925.40618-13-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311215925.40618-1-peterx@redhat.com>
References: <20240311215925.40618-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Precursor to factoring out the inner loops for reuse.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20240307153710.30907-3-Jonathan.Cameron@huawei.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/physmem.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index e92bed50a6..e35aa29343 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2688,10 +2688,7 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
                                            hwaddr len, hwaddr mr_addr,
                                            hwaddr l, MemoryRegion *mr)
 {
-    uint8_t *ram_ptr;
-    uint64_t val;
     MemTxResult result = MEMTX_OK;
-    bool release_lock = false;
     const uint8_t *buf = ptr;
 
     for (;;) {
@@ -2699,7 +2696,9 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
             result |= MEMTX_ACCESS_ERROR;
             /* Keep going. */
         } else if (!memory_access_is_direct(mr, true)) {
-            release_lock |= prepare_mmio_access(mr);
+            uint64_t val;
+            bool release_lock = prepare_mmio_access(mr);
+
             l = memory_access_size(mr, l, mr_addr);
             /* XXX: could force current_cpu to NULL to avoid
                potential bugs */
@@ -2717,18 +2716,21 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
             val = ldn_he_p(buf, l);
             result |= memory_region_dispatch_write(mr, mr_addr, val,
                                                    size_memop(l), attrs);
+            if (release_lock) {
+                bql_unlock();
+            }
+
+
         } else {
             /* RAM case */
-            ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, &l, false);
+
+            uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, &l,
+                                                   false);
+
             memmove(ram_ptr, buf, l);
             invalidate_and_set_dirty(mr, mr_addr, l);
         }
 
-        if (release_lock) {
-            bql_unlock();
-            release_lock = false;
-        }
-
         len -= l;
         buf += l;
         addr += l;
@@ -2767,10 +2769,7 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
                                    hwaddr len, hwaddr mr_addr, hwaddr l,
                                    MemoryRegion *mr)
 {
-    uint8_t *ram_ptr;
-    uint64_t val;
     MemTxResult result = MEMTX_OK;
-    bool release_lock = false;
     uint8_t *buf = ptr;
 
     fuzz_dma_read_cb(addr, len, mr);
@@ -2780,7 +2779,9 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
             /* Keep going. */
         } else if (!memory_access_is_direct(mr, false)) {
             /* I/O case */
-            release_lock |= prepare_mmio_access(mr);
+            uint64_t val;
+            bool release_lock = prepare_mmio_access(mr);
+
             l = memory_access_size(mr, l, mr_addr);
             result |= memory_region_dispatch_read(mr, mr_addr, &val,
                                                   size_memop(l), attrs);
@@ -2796,17 +2797,16 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
                    (l == 8 && len >= 8));
 #endif
             stn_he_p(buf, l, val);
+            if (release_lock) {
+                bql_unlock();
+            }
         } else {
             /* RAM case */
-            ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, &l, false);
+            uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, &l,
+                                                   false);
             memcpy(buf, ram_ptr, l);
         }
 
-        if (release_lock) {
-            bql_unlock();
-            release_lock = false;
-        }
-
         len -= l;
         buf += l;
         addr += l;
-- 
2.44.0


