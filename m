Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EF0ECD999
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo5VM-0006k4-UF; Thu, 05 Feb 2026 14:59:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5VK-0006ii-Jq
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:06 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5VJ-00036r-1H
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:06 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4362197d174so828581f8f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 11:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770321543; x=1770926343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5qvuMaHRp0wLKOuMUSBaArgy1/39Q2HJlclOT444aA8=;
 b=jpHbZtTem+jq5SEi4byKQZXOv/h6irGjWKppFzxaB3papJIh241zBCFPuaJ7BKcIQ/
 mxjgtDudIy/I56i+/hFZn0NhMTGPcX8VVO8V7vhLH+Jekw1RUdy6jMQbr/m8HBo+ATkO
 DaprmqrpjgF6ZMNFXQiDgR7FHBQqURmrr+XtvIFZMowdzeoPickVKk3jBy0OhA0yXnfY
 MltOi/oAnltcEO+kSuDqd9ZSy5w5FDPpS8bc3NJfpFcbZWmSehRgSrqoRfdbO7LiVcSP
 iBxrN4ejOgn2DCMpXsrRgLXe2m0KRAmTznc8wANjF3hjWwV1hXBFGQlmGeNdQ8xjVhR/
 7ICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770321543; x=1770926343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5qvuMaHRp0wLKOuMUSBaArgy1/39Q2HJlclOT444aA8=;
 b=pUjQuY9eIpH+iGsIcSN8Pr4OZ3jOx6qmUCrt0Ka1tyav9VhY6PQg1wooHi/Ly1IUy4
 yEEOOm3r1nt+QtnJfvRBxHX9R+flRdETaH+AZ7pxasjs1H4Ta9lIzjA4vbCw3tkpWWaQ
 Bxwm90UWJE/cxjjXhp/UWNphCcCkFOo59KScu0F+l/nTfxitxCFjHsJC0LOxJV9WRl9M
 LcVf0b9J82NUeUTZdZEwzi8/KjXWt1hlXGlD1PgBWrJWiQJJQk+JeaQioKe4jazZePmE
 XiHoB/p4dGsqhU77kj/ybV6fdGYK7Grnm8DWMLH+zW4+/wYGNYpVoK1mLwVkGuZmjseF
 tQYA==
X-Gm-Message-State: AOJu0YzyizQsH3jArKX1OHzi0Srmbuy2VVJWBTD9eHdH0Q2Hc1d7EyJv
 NvlK/pfJrwguyOjSNCfvmp8rrYvtKInWeXCTIvoDd+9xSpb+B1pSUqnVbLLnQCTK2go=
X-Gm-Gg: AZuq6aJeYsKhvEl/2dRwY8zqgA2jjUl6bhxSkjwTacTtQw53dbbb0n8AEgYohiN3rS7
 jbiRBOLWXvPFIQrcxiqMlOcY/eHeutNhJpQcVd1+A7o0HCKjWnPTu4PSWUxqfW1qjGNufM/7QBk
 5ZHFONkVcYBwLG4EfeICER3z+MFaqOw6/4ADl3Txbf+X9vQKD8ghSFQkLaJ9RHMfo2P0Yy4e0Uf
 CbRj1xTk4kpOqO4oMxtc3UfYVSjqy28jr3w6WqYACGPKLZQ1hGH9gyk03WPZquK6sh6Kd6BNVq9
 OiW6SSvqlZDhhmyJg8MFR3L+NxuilmYzj2Cn+MtsNrhjpoFEKNJ0PItasGSm2Sj0sBTkq6esm7x
 uexoNCBTvGGHLUYar+Uj2sVlUrXDaGrv/1XOdHRKUZMnr5Ao1plDNOalJ2rJqH+f966deOIUMYa
 d/txcifcFdPH8w0V6vG9IEENqQTXM3lQ==
X-Received: by 2002:a05:6000:2889:b0:436:1a24:df81 with SMTP id
 ffacd0b85a97d-4362904b702mr635949f8f.2.1770321543005; 
 Thu, 05 Feb 2026 11:59:03 -0800 (PST)
Received: from thinkpad-t470s.. ([93.140.16.93])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-436297450b4sm514079f8f.34.2026.02.05.11.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 11:59:01 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 francisco.iglesias@amd.com, Ruslan_Ruslichenko@epam.com,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH 13/29] system/memory: Introduce unified MemoryTransaction and
 .access callback
Date: Thu,  5 Feb 2026 20:58:08 +0100
Message-ID: <20260205195824.2610192-14-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Introduce a unified 'MemoryTransaction' structure to encapsulate all
parameters of a memory access, including address, data, size, and
attributes.

The logic in memory_region_dispatch_read/write is updated to prioritize
the new 'access' callback when available.

This change simplifies the integration of transaction-based subsystems,
such as the Remote Port, by providing a standard container for memory
access metadata.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 include/system/memory.h | 23 ++++++++++++++
 system/memory.c         | 66 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 0562af3136..e1fb82608d 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -84,6 +84,28 @@ extern unsigned int global_dirty_tracking;
 
 typedef struct MemoryRegionOps MemoryRegionOps;
 
+typedef struct MemoryTransaction {
+    union {
+        /*
+         * Data is passed by values up to 64bit sizes. Beyond
+         * that, a pointer is passed in p8.
+         *
+         * Note that p8 has no alignment restrictions.
+         */
+        uint8_t *p8;
+        uint64_t u64;
+        uint32_t u32;
+        uint16_t u16;
+        uint8_t  u8;
+    } data;
+    bool rw;
+    hwaddr addr;
+    unsigned int size;
+    MemTxAttrs attr;
+    void *opaque;
+} MemoryTransaction;
+
+
 struct ReservedRegion {
     Range range;
     unsigned type;
@@ -298,6 +320,7 @@ static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
  * Memory region callbacks
  */
 struct MemoryRegionOps {
+    MemTxResult (*access)(MemoryTransaction *tr);
     /* Read from the memory region. @addr is relative to @mr; @size is
      * in bytes. */
     uint64_t (*read)(void *opaque,
diff --git a/system/memory.c b/system/memory.c
index 0b1462f028..4f62796cd3 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -431,6 +431,31 @@ static int get_cpu_index(void)
     return -1;
 }
 
+static MemTxResult memory_region_read_accessor_attr(MemoryRegion *mr,
+                                                    hwaddr addr,
+                                                    uint64_t *value,
+                                                    unsigned size,
+                                                    signed shift,
+                                                    uint64_t mask,
+                                                    MemTxAttrs attrs)
+{
+    MemoryTransaction tr = { { 0 } };
+    MemTxResult ret;
+
+    if (mr->flush_coalesced_mmio) {
+        qemu_flush_coalesced_mmio_buffer();
+    }
+
+    tr.opaque = mr->opaque;
+    tr.addr = addr;
+    tr.size = size;
+    tr.attr = attrs;
+    ret = mr->ops->access(&tr);
+    *value |= (tr.data.u64 & mask) << shift;
+
+    return ret;
+}
+
 static MemTxResult  memory_region_read_accessor(MemoryRegion *mr,
                                                 hwaddr addr,
                                                 uint64_t *value,
@@ -476,6 +501,31 @@ static MemTxResult memory_region_read_with_attrs_accessor(MemoryRegion *mr,
     return r;
 }
 
+static MemTxResult memory_region_write_accessor_attr(MemoryRegion *mr,
+                                                     hwaddr addr,
+                                                     uint64_t *value,
+                                                     unsigned size,
+                                                     signed shift,
+                                                     uint64_t mask,
+                                                     MemTxAttrs attrs)
+{
+    MemoryTransaction tr = { { 0 } };
+
+    if (mr->flush_coalesced_mmio) {
+        qemu_flush_coalesced_mmio_buffer();
+    }
+
+    tr.opaque = mr->opaque;
+    tr.rw = true;
+    tr.addr = addr;
+    tr.size = size;
+    tr.attr = attrs;
+    tr.data.u64 = (*value >> shift) & mask;
+    trace_memory_region_ops_write(get_cpu_index(), mr, tr.addr, tr.data.u64,
+                                  tr.size, memory_region_name(mr));
+    return mr->ops->access(&tr);
+}
+
 static MemTxResult memory_region_write_accessor(MemoryRegion *mr,
                                                 hwaddr addr,
                                                 uint64_t *value,
@@ -1603,7 +1653,13 @@ static MemTxResult memory_region_dispatch_read1(MemoryRegion *mr,
 {
     *pval = 0;
 
-    if (mr->ops->read) {
+    if (mr->ops->access) {
+        return access_with_adjusted_size(addr, pval, size,
+                                         mr->ops->impl.min_access_size,
+                                         mr->ops->impl.max_access_size,
+                                         memory_region_read_accessor_attr,
+                                         mr, attrs);
+    } else if (mr->ops->read) {
         return access_with_adjusted_size(addr, pval, size,
                                          mr->ops->impl.min_access_size,
                                          mr->ops->impl.max_access_size,
@@ -1698,7 +1754,13 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
         return MEMTX_OK;
     }
 
-    if (mr->ops->write) {
+    if (mr->ops->access) {
+        return access_with_adjusted_size(addr, &data, size,
+                                         mr->ops->impl.min_access_size,
+                                         mr->ops->impl.max_access_size,
+                                         memory_region_write_accessor_attr,
+                                         mr, attrs);
+    } else if (mr->ops->write) {
         return access_with_adjusted_size(addr, &data, size,
                                          mr->ops->impl.min_access_size,
                                          mr->ops->impl.max_access_size,
-- 
2.43.0


