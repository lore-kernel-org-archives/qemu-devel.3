Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37386D5E124
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 03:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Fhc-0008Ue-R7; Thu, 07 Nov 2024 22:30:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1t9Fha-0008U0-US
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 22:30:26 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1t9FhY-0001Hn-Vm
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 22:30:26 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3e5fef69f2eso1056233b6e.3
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 19:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1731036624; x=1731641424;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZEmXhN0e4yofB9St5S3+HcVTsbiOBljTRevzyH0DrDI=;
 b=ory0/elUCxf/vrmGSKz3hnclJvn+NPb/1/iI8JCJJebzR3on0zZvaFADOl9bXQeX2B
 sJOLjvlY3nT6+wWiUj/rM/A9GPH6kPNMRDHQ5dDd8ubKPsmeuXSaeALKHv03x676pUe0
 b5Znba2osYTzI/UWtRP1mWbVIxXIUUeIPWhkA1D1L7adXMj71PdT811qwYEdk3LnHljP
 fyQhpHiIsazzXGjEEMgFrol/Ukj7W90JNAA/ZQFo6E9/jJE7+hyOY/O7CpL4wzbKKGGb
 dXji5kAsVhP495/Ri8GHXlxuQTim22D25e2CnTALSmsm5Eg5il1CvuEZ1JTCo1djYG3H
 daJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731036624; x=1731641424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZEmXhN0e4yofB9St5S3+HcVTsbiOBljTRevzyH0DrDI=;
 b=tuPelUvjmIkOrX4aBSP9dy8f6ghGBHvv7GSBv1RkXmI0ORuny/MY4jfG53od/4zA52
 R4AsEuvCOrWfCcA9tlPC7iEJvsZZkQrhLgT6zwOekI2xm/o87hV62v/WkJYT6REffzW0
 VT3KuaWtRhnCDP5ImKR7nrLcZ6bqEkroV7y/BexiztYQ8wVx7zHPrBZj9m2ygguxAdA5
 f9apvOQrRF0iooZlyBsy/JE4g1mYJHtfsO4NXRxmpa2V12ZZ3XqreUqQFhI0zItQRgdk
 7LkjL7al8h3n/vlF5CG2EK4Fpdx0uY0Lhf++YzYba85WTdm3RKqbVLfvXglhcXLLmIJa
 n3bw==
X-Gm-Message-State: AOJu0Yy0r6cDtIr3pSo/1T88xWJqLEsyt1OEfzesdF5ywslPiwKAsAjQ
 F4HoNiW27/gHMtCECe5QS2Vmtz4yT1bK0/taor2+apidWYvU3FGMlu/9DkxT0ZIqbY3zk49iTo9
 kN7Q=
X-Google-Smtp-Source: AGHT+IH8Cu8BmQ2H1pYCF1MhqZHlWXBnPlF4+KiVNOByoEJ9C4HHxEoU0/lhjDRoVgya92wPthhJcA==
X-Received: by 2002:a05:6808:118c:b0:3e6:5f3:dadb with SMTP id
 5614622812f47-3e794705982mr1776028b6e.39.1731036623668; 
 Thu, 07 Nov 2024 19:30:23 -0800 (PST)
Received: from ThinkPad-T14-hirose.hq.igel.co.jp (napt.igel.co.jp.
 [219.106.231.132]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f41f65d358sm2326435a12.84.2024.11.07.19.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 19:30:23 -0800 (PST)
From: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
To: qemu-devel@nongnu.org
Cc: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 2/5] system/memory: support unaligned access
Date: Fri,  8 Nov 2024 12:29:46 +0900
Message-ID: <20241108032952.56692-3-tomoyuki.hirose@igel.co.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108032952.56692-1-tomoyuki.hirose@igel.co.jp>
References: <20241108032952.56692-1-tomoyuki.hirose@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=tomoyuki.hirose@igel.co.jp; helo=mail-oi1-x22a.google.com
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

The previous code ignored 'impl.unaligned' and handled unaligned
accesses as is. But this implementation could not emulate specific
registers of some devices that allow unaligned access such as xHCI
Host Controller Capability Registers.

This commit emulates an unaligned access with multiple aligned
accesses. Additionally, the overwriting of the max access size is
removed to retrive the actual max access size.

Signed-off-by: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
---
 system/memory.c  | 147 ++++++++++++++++++++++++++++++++++++++---------
 system/physmem.c |   8 ---
 2 files changed, 119 insertions(+), 36 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 85f6834cb3..c2164e6478 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -518,27 +518,118 @@ static MemTxResult memory_region_write_with_attrs_accessor(MemoryRegion *mr,
     return mr->ops->write_with_attrs(mr->opaque, addr, tmp, size, attrs);
 }
 
+typedef MemTxResult (*MemoryRegionAccessFn)(MemoryRegion *mr,
+                                            hwaddr addr,
+                                            uint64_t *value,
+                                            unsigned size,
+                                            signed shift,
+                                            uint64_t mask,
+                                            MemTxAttrs attrs);
+
+static MemTxResult access_emulation(hwaddr addr,
+                                    uint64_t *value,
+                                    unsigned int size,
+                                    unsigned int access_size_min,
+                                    unsigned int access_size_max,
+                                    MemoryRegion *mr,
+                                    MemTxAttrs attrs,
+                                    MemoryRegionAccessFn access_fn_read,
+                                    MemoryRegionAccessFn access_fn_write,
+                                    bool is_write)
+{
+    hwaddr a;
+    uint8_t *d;
+    uint64_t v;
+    MemTxResult r = MEMTX_OK;
+    bool is_big_endian = memory_region_big_endian(mr);
+    void (*store)(void *, int, uint64_t) = is_big_endian ? stn_be_p : stn_le_p;
+    uint64_t (*load)(const void *, int) = is_big_endian ? ldn_be_p : ldn_le_p;
+    size_t access_size = MAX(MIN(size, access_size_max), access_size_min);
+    uint64_t access_mask = MAKE_64BIT_MASK(0, access_size * 8);
+    hwaddr round_down = mr->ops->impl.unaligned && addr + size <= mr->size ?
+        0 : addr % access_size;
+    hwaddr start = addr - round_down;
+    hwaddr tail = addr + size <= mr->size ? addr + size : mr->size;
+    uint8_t data[16] = {0};
+    g_assert(size <= 8);
+
+    for (a = start, d = data, v = 0; a < tail;
+         a += access_size, d += access_size, v = 0) {
+        r |= access_fn_read(mr, a, &v, access_size, 0, access_mask,
+                            attrs);
+        store(d, access_size, v);
+    }
+    if (is_write) {
+        stn_he_p(&data[round_down], size, load(value, size));
+        for (a = start, d = data; a < tail;
+             a += access_size, d += access_size) {
+            v = load(d, access_size);
+            r |= access_fn_write(mr, a, &v, access_size, 0, access_mask,
+                                 attrs);
+        }
+    } else {
+        store(value, size, ldn_he_p(&data[round_down], size));
+    }
+
+    return r;
+}
+
+static bool is_access_fastpath(hwaddr addr,
+                               unsigned int size,
+                               unsigned int access_size_min,
+                               unsigned int access_size_max,
+                               MemoryRegion *mr)
+{
+    size_t access_size = MAX(MIN(size, access_size_max), access_size_min);
+    hwaddr round_down = mr->ops->impl.unaligned && addr + size <= mr->size ?
+        0 : addr % access_size;
+
+    return round_down == 0 && access_size <= size;
+}
+
+static MemTxResult access_fastpath(hwaddr addr,
+                                   uint64_t *value,
+                                   unsigned int size,
+                                   unsigned int access_size_min,
+                                   unsigned int access_size_max,
+                                   MemoryRegion *mr,
+                                   MemTxAttrs attrs,
+                                   MemoryRegionAccessFn fastpath)
+{
+    MemTxResult r = MEMTX_OK;
+    size_t access_size = MAX(MIN(size, access_size_max), access_size_min);
+    uint64_t access_mask = MAKE_64BIT_MASK(0, access_size * 8);
+
+    if (memory_region_big_endian(mr)) {
+        for (size_t i = 0; i < size; i += access_size) {
+            r |= fastpath(mr, addr + i, value, access_size,
+                          (size - access_size - i) * 8, access_mask, attrs);
+        }
+    } else {
+        for (size_t i = 0; i < size; i += access_size) {
+            r |= fastpath(mr, addr + i, value, access_size,
+                          i * 8, access_mask, attrs);
+        }
+    }
+
+    return r;
+}
+
 static MemTxResult access_with_adjusted_size(hwaddr addr,
                                       uint64_t *value,
                                       unsigned size,
                                       unsigned access_size_min,
                                       unsigned access_size_max,
-                                      MemTxResult (*access_fn)
-                                                  (MemoryRegion *mr,
-                                                   hwaddr addr,
-                                                   uint64_t *value,
-                                                   unsigned size,
-                                                   signed shift,
-                                                   uint64_t mask,
-                                                   MemTxAttrs attrs),
+                                      MemoryRegionAccessFn access_fn_read,
+                                      MemoryRegionAccessFn access_fn_write,
+                                      bool is_write,
                                       MemoryRegion *mr,
                                       MemTxAttrs attrs)
 {
-    uint64_t access_mask;
-    unsigned access_size;
-    unsigned i;
     MemTxResult r = MEMTX_OK;
     bool reentrancy_guard_applied = false;
+    MemoryRegionAccessFn access_fn_fastpath =
+        is_write ? access_fn_write : access_fn_read;
 
     if (!access_size_min) {
         access_size_min = 1;
@@ -560,20 +651,16 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
         reentrancy_guard_applied = true;
     }
 
-    /* FIXME: support unaligned access? */
-    access_size = MAX(MIN(size, access_size_max), access_size_min);
-    access_mask = MAKE_64BIT_MASK(0, access_size * 8);
-    if (memory_region_big_endian(mr)) {
-        for (i = 0; i < size; i += access_size) {
-            r |= access_fn(mr, addr + i, value, access_size,
-                        (size - access_size - i) * 8, access_mask, attrs);
-        }
+    if (is_access_fastpath(addr, size, access_size_min, access_size_max, mr)) {
+        r |= access_fastpath(addr, value, size,
+                             access_size_min, access_size_max, mr, attrs,
+                             access_fn_fastpath);
     } else {
-        for (i = 0; i < size; i += access_size) {
-            r |= access_fn(mr, addr + i, value, access_size, i * 8,
-                        access_mask, attrs);
-        }
+        r |= access_emulation(addr, value, size,
+                              access_size_min, access_size_max, mr, attrs,
+                              access_fn_read, access_fn_write, is_write);
     }
+
     if (mr->dev && reentrancy_guard_applied) {
         mr->dev->mem_reentrancy_guard.engaged_in_io = false;
     }
@@ -1459,13 +1546,15 @@ static MemTxResult memory_region_dispatch_read1(MemoryRegion *mr,
                                          mr->ops->impl.min_access_size,
                                          mr->ops->impl.max_access_size,
                                          memory_region_read_accessor,
-                                         mr, attrs);
+                                         memory_region_write_accessor,
+                                         false, mr, attrs);
     } else {
         return access_with_adjusted_size(addr, pval, size,
                                          mr->ops->impl.min_access_size,
                                          mr->ops->impl.max_access_size,
                                          memory_region_read_with_attrs_accessor,
-                                         mr, attrs);
+                                         memory_region_write_with_attrs_accessor,
+                                         false, mr, attrs);
     }
 }
 
@@ -1553,15 +1642,17 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
         return access_with_adjusted_size(addr, &data, size,
                                          mr->ops->impl.min_access_size,
                                          mr->ops->impl.max_access_size,
-                                         memory_region_write_accessor, mr,
-                                         attrs);
+                                         memory_region_read_accessor,
+                                         memory_region_write_accessor,
+                                         true, mr, attrs);
     } else {
         return
             access_with_adjusted_size(addr, &data, size,
                                       mr->ops->impl.min_access_size,
                                       mr->ops->impl.max_access_size,
+                                      memory_region_read_with_attrs_accessor,
                                       memory_region_write_with_attrs_accessor,
-                                      mr, attrs);
+                                      true, mr, attrs);
     }
 }
 
diff --git a/system/physmem.c b/system/physmem.c
index dc1db3a384..ff444140a8 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2693,14 +2693,6 @@ int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr)
         access_size_max = 4;
     }
 
-    /* Bound the maximum access by the alignment of the address.  */
-    if (!mr->ops->impl.unaligned) {
-        unsigned align_size_max = addr & -addr;
-        if (align_size_max != 0 && align_size_max < access_size_max) {
-            access_size_max = align_size_max;
-        }
-    }
-
     /* Don't attempt accesses larger than the maximum.  */
     if (l > access_size_max) {
         l = access_size_max;
-- 
2.43.0


