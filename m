Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28661C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjngd-0000YR-M7; Mon, 11 Mar 2024 18:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngX-0000Vq-QZ
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngV-00040b-NK
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XAW4kNcipci25Ftdw678I9V9K89A2Ws6lDYWYUOgtX4=;
 b=ZUoxYQRW7bVQ8ESAgVrIjreUkx3ov2HIH4T5w5R+MC2id5yuaJPAvhJW6MFGDZeTybceJd
 eXS13H1/DGMft+uhnSomn0pLA+bOlzRHVse8SNRLCAJamuNRUibXF6/9/kB9govWfstZkS
 0uKc4HlM5VajyRfgdHTzGMez+20qE9Y=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-jOP7hcuSPSC3P7IoR2LPcg-1; Mon, 11 Mar 2024 17:59:49 -0400
X-MC-Unique: jOP7hcuSPSC3P7IoR2LPcg-1
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-7dc10e68417so93139241.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 14:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194388; x=1710799188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XAW4kNcipci25Ftdw678I9V9K89A2Ws6lDYWYUOgtX4=;
 b=kFYgDLJp4ni+urjoDAE6UQEy8h6V6bUJeNLWVsVM2hoqDgWZuMQn4ErknmGqN+7wJn
 pblqsYGNycjP6E+MQOkGZ0llo1JSpok9eFcV8v7+nwAoGlqp7gg4kZKZHpPLLxE4XqBB
 H5+4WQBPfnQd+0A9bUsPpiF0Dboza4PDulMKGiX8NcmKrh32rtLfDFrg7HxsFy/ap0BE
 PcPBTnNrCwAHP7ZkCqhRhqaZ5aLW/r5H3Wtc985jhitLTlmGRd95qP+Mn50MwvGB5RzI
 0vRBK6WeLLzJcj6/ewV4W5gPEKm6cAFo+oGBxBHXEL1x1vvPAb5pHuKCMXafLOhpD8HS
 Tbbg==
X-Gm-Message-State: AOJu0YzRBXP/CWx1uVfLeM+qL1olPufO3EqKVWVZ45DHCH9Mncku7a9g
 iP94XzGOMkjZQOSYGTm8h7E4+lMt8GLuHhJHqQE9OtLEvgcHJtl5hHPKXuQb7S7E5AgsdFNpLKq
 VuXI2o9xpzPRmWqUm0kh1kzSXuI3MnA/BolQnaaZF4WkKWJM4AC2GctnLtiJzamQVM/w4At9SVf
 I/TllVRHDrAjgglNX+bGyY8fjVJCskndimXA==
X-Received: by 2002:a05:6102:3667:b0:473:240f:36b9 with SMTP id
 bg7-20020a056102366700b00473240f36b9mr3694363vsb.1.1710194388155; 
 Mon, 11 Mar 2024 14:59:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+3+LK98FLCI/uSUmdZukHEWonLNFKhMsYvtB6u7kOyQt/iv/MoaUDFp56HNLXUVJax8598w==
X-Received: by 2002:a05:6102:3667:b0:473:240f:36b9 with SMTP id
 bg7-20020a056102366700b00473240f36b9mr3694342vsb.1.1710194387675; 
 Mon, 11 Mar 2024 14:59:47 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.14.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 14:59:46 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 14/34] physmem: Fix wrong address in large
 address_space_read/write_cached_slow()
Date: Mon, 11 Mar 2024 17:59:05 -0400
Message-ID: <20240311215925.40618-15-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311215925.40618-1-peterx@redhat.com>
References: <20240311215925.40618-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

If the access is bigger than the MemoryRegion supports,
flatview_read/write_continue() will attempt to update the Memory Region.
but the address passed to flatview_translate() is relative to the cache, not
to the FlatView.

On arm/virt with interleaved CXL memory emulation and virtio-blk-pci this
lead to the first part of descriptor being read from the CXL memory and the
second part from PA 0x8 which happens to be a blank region
of a flash chip and all ffs on this particular configuration.
Note this test requires the out of tree ARM support for CXL, but
the problem is more general.

Avoid this by adding new address_space_read_continue_cached()
and address_space_write_continue_cached() which share all the logic
with the flatview versions except for the MemoryRegion lookup which
is unnecessary as the MemoryRegionCache only covers one MemoryRegion.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://lore.kernel.org/r/20240307153710.30907-5-Jonathan.Cameron@huawei.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/physmem.c | 63 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 57 insertions(+), 6 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 737869a3f5..6cfb7a80ab 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3370,6 +3370,59 @@ static inline MemoryRegion *address_space_translate_cached(
     return section.mr;
 }
 
+/* Called within RCU critical section.  */
+static MemTxResult address_space_write_continue_cached(MemTxAttrs attrs,
+                                                       const void *ptr,
+                                                       hwaddr len,
+                                                       hwaddr mr_addr,
+                                                       hwaddr l,
+                                                       MemoryRegion *mr)
+{
+    MemTxResult result = MEMTX_OK;
+    const uint8_t *buf = ptr;
+
+    for (;;) {
+        result |= flatview_write_continue_step(attrs, buf, len, mr_addr, &l,
+                                               mr);
+
+        len -= l;
+        buf += l;
+        mr_addr += l;
+
+        if (!len) {
+            break;
+        }
+
+        l = len;
+    }
+
+    return result;
+}
+
+/* Called within RCU critical section.  */
+static MemTxResult address_space_read_continue_cached(MemTxAttrs attrs,
+                                                      void *ptr, hwaddr len,
+                                                      hwaddr mr_addr, hwaddr l,
+                                                      MemoryRegion *mr)
+{
+    MemTxResult result = MEMTX_OK;
+    uint8_t *buf = ptr;
+
+    for (;;) {
+        result |= flatview_read_continue_step(attrs, buf, len, mr_addr, &l, mr);
+        len -= l;
+        buf += l;
+        mr_addr += l;
+
+        if (!len) {
+            break;
+        }
+        l = len;
+    }
+
+    return result;
+}
+
 /* Called from RCU critical section. address_space_read_cached uses this
  * out of line function when the target is an MMIO or IOMMU region.
  */
@@ -3383,9 +3436,8 @@ address_space_read_cached_slow(MemoryRegionCache *cache, hwaddr addr,
     l = len;
     mr = address_space_translate_cached(cache, addr, &mr_addr, &l, false,
                                         MEMTXATTRS_UNSPECIFIED);
-    return flatview_read_continue(cache->fv,
-                                  addr, MEMTXATTRS_UNSPECIFIED, buf, len,
-                                  mr_addr, l, mr);
+    return address_space_read_continue_cached(MEMTXATTRS_UNSPECIFIED,
+                                              buf, len, mr_addr, l, mr);
 }
 
 /* Called from RCU critical section. address_space_write_cached uses this
@@ -3401,9 +3453,8 @@ address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
     l = len;
     mr = address_space_translate_cached(cache, addr, &mr_addr, &l, true,
                                         MEMTXATTRS_UNSPECIFIED);
-    return flatview_write_continue(cache->fv,
-                                   addr, MEMTXATTRS_UNSPECIFIED, buf, len,
-                                   mr_addr, l, mr);
+    return address_space_write_continue_cached(MEMTXATTRS_UNSPECIFIED,
+                                               buf, len, mr_addr, l, mr);
 }
 
 #define ARG1_DECL                MemoryRegionCache *cache
-- 
2.44.0


