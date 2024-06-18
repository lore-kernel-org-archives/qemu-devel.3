Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF44C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 22:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJhae-00023f-4u; Tue, 18 Jun 2024 18:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Lw5yZgQKCk470y7w44w1u.s426u2A-tuBu1343w3A.47w@flex--rkir.bounces.google.com>)
 id 1sJhac-00023B-Pk
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:46:10 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Lw5yZgQKCk470y7w44w1u.s426u2A-tuBu1343w3A.47w@flex--rkir.bounces.google.com>)
 id 1sJhaa-0000yH-Ts
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:46:10 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-62fb4a1f7bfso134840667b3.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 15:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718750767; x=1719355567; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=uYBO9SMQOAuy7srXieS/MVLo7c5YxoAf3JV1nWhajaI=;
 b=xybCoZE5Q3ohFKuPrGm32+tF3SMS7WqUAW7h5p/qHiAOlFrVZRYhHrzkSw8BIqpURm
 teWpNpkRPxwDEd4y//Q/mmCx53PA/hEUlWVGp/00R4Pj5JlsaSajtRMqLhUmM/bauj3A
 NnByirSWldYg3ypJy1onVB4qFkVM5xdeYcKnsezhUjelmpKDxTQ6ykw5YySmSqgnm3S1
 jkFFm8FbQGJNme3mS1HpoXo27hIlEx+0i3780Z07ddCfCYBuJlaMyOhNc/B0c1DKmAZV
 MVp7uBeg4sgR5FWcOio3/349vlp9pUIxbtwOtjTz96irkbr3FX0N+lYuToVjS1cTdwwn
 hqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718750767; x=1719355567;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uYBO9SMQOAuy7srXieS/MVLo7c5YxoAf3JV1nWhajaI=;
 b=NmvM7Bp/A5cbBjsH9FBuY94gHifBuIdf5EuQsIG/qoB/d7vv1J9aWfpDKeLcKm/yG5
 tQb1SChSD914rp1MaCIO3nGfEbgSHkH0TNG69o4x5BpHWS56BCCvqmaei5WcEY8oN3Vm
 XDlmxYSMezM8wV7hIWb/eRitycMt9XV6fHwLKiCOZaB2BJYHbbojAz7HcJFiyh380tHg
 fcVz1r+Y4NisklOKaLC5Mqk2aIhDteFqSRS07WBZy/tXKDGuZ2SS7++jHnfyofLFbaF3
 QcW+/vI5WQgaDlmodDUpay12e/cagXBSHGljzjwh6Fo9YoaVDosm3vvBtXzfCzYnHqlC
 G9xg==
X-Gm-Message-State: AOJu0Yx8BC6wkH0j0lQA96z0vO52JrqLSWdtcxxVSEmfzjWlWAgk+zk9
 IkYykhZbB5bwcB2n7NKJGmPcOSCHERJxaKiwKyYP+Q9nNru3uo7RyqIQoNMgTWkiM7N8Sn8Ap2d
 DnxroRZoD3DZQmoeU4lxUN0sYlW6V2HIexu4gB9jQK48XYLqzrDIKn1LwBNIiEn8NRnWPOWBmZJ
 f1bAUShYYGqZVJ3bFz0yaR
X-Google-Smtp-Source: AGHT+IHHNeK4OdBHrUxfEuJlgsxDiD+dX+JMgk+/4SSHFFZ8lpOSSa4wD48fA11ybDciAikyZsQ2nnpc
X-Received: from rkir98.kir.corp.google.com
 ([2620:15c:7d:4:fddf:5bf:9eb2:410e])
 (user=rkir job=sendgmr) by 2002:a05:6902:1003:b0:e02:bd4f:def2 with SMTP id
 3f1490d57ef6-e02be20b2ccmr379731276.11.1718750767055; Tue, 18 Jun 2024
 15:46:07 -0700 (PDT)
Date: Tue, 18 Jun 2024 15:46:04 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240618224604.879275-1-rkir@google.com>
Subject: [PATCH 3/3] exec: use char* for pointer arithmetic
From: Roman Kiryanov <rkir@google.com>
To: qemu-devel@nongnu.org
Cc: jansene@google.com, mett@google.com, jpcottin@google.com, 
 Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3Lw5yZgQKCk470y7w44w1u.s426u2A-tuBu1343w3A.47w@flex--rkir.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

void* pointer arithmetic is not in the
C standard. This change allows using
the QEMU headers with a C++ compiler.

Google-Bug-Id: 331190993
Change-Id: I5a064853429f627c17a9213910811dea4ced6174
Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 include/exec/memory.h                 |  8 ++++----
 include/exec/memory_ldst_cached.h.inc | 12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index d7591a60d9..738e4cef2c 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2839,7 +2839,7 @@ static inline uint8_t address_space_ldub_cached(MemoryRegionCache *cache,
 {
     assert(addr < cache->len);
     if (likely(cache->ptr)) {
-        return ldub_p(cache->ptr + addr);
+        return ldub_p((char*)cache->ptr + addr);
     } else {
         return address_space_ldub_cached_slow(cache, addr, attrs, result);
     }
@@ -2850,7 +2850,7 @@ static inline void address_space_stb_cached(MemoryRegionCache *cache,
 {
     assert(addr < cache->len);
     if (likely(cache->ptr)) {
-        stb_p(cache->ptr + addr, val);
+        stb_p((char*)cache->ptr + addr, val);
     } else {
         address_space_stb_cached_slow(cache, addr, val, attrs, result);
     }
@@ -3123,7 +3123,7 @@ address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
     assert(addr < cache->len && len <= cache->len - addr);
     fuzz_dma_read_cb(cache->xlat + addr, len, cache->mrs.mr);
     if (likely(cache->ptr)) {
-        memcpy(buf, cache->ptr + addr, len);
+        memcpy(buf, (char*)cache->ptr + addr, len);
         return MEMTX_OK;
     } else {
         return address_space_read_cached_slow(cache, addr, buf, len);
@@ -3144,7 +3144,7 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
 {
     assert(addr < cache->len && len <= cache->len - addr);
     if (likely(cache->ptr)) {
-        memcpy(cache->ptr + addr, buf, len);
+        memcpy((char*)cache->ptr + addr, buf, len);
         return MEMTX_OK;
     } else {
         return address_space_write_cached_slow(cache, addr, buf, len);
diff --git a/include/exec/memory_ldst_cached.h.inc b/include/exec/memory_ldst_cached.h.inc
index d7834f852c..f767e53a3d 100644
--- a/include/exec/memory_ldst_cached.h.inc
+++ b/include/exec/memory_ldst_cached.h.inc
@@ -30,7 +30,7 @@ static inline uint16_t ADDRESS_SPACE_LD_CACHED(uw)(MemoryRegionCache *cache,
     assert(addr < cache->len && 2 <= cache->len - addr);
     fuzz_dma_read_cb(cache->xlat + addr, 2, cache->mrs.mr);
     if (likely(cache->ptr)) {
-        return LD_P(uw)(cache->ptr + addr);
+        return LD_P(uw)((char*)cache->ptr + addr);
     } else {
         return ADDRESS_SPACE_LD_CACHED_SLOW(uw)(cache, addr, attrs, result);
     }
@@ -42,7 +42,7 @@ static inline uint32_t ADDRESS_SPACE_LD_CACHED(l)(MemoryRegionCache *cache,
     assert(addr < cache->len && 4 <= cache->len - addr);
     fuzz_dma_read_cb(cache->xlat + addr, 4, cache->mrs.mr);
     if (likely(cache->ptr)) {
-        return LD_P(l)(cache->ptr + addr);
+        return LD_P(l)((char*)cache->ptr + addr);
     } else {
         return ADDRESS_SPACE_LD_CACHED_SLOW(l)(cache, addr, attrs, result);
     }
@@ -54,7 +54,7 @@ static inline uint64_t ADDRESS_SPACE_LD_CACHED(q)(MemoryRegionCache *cache,
     assert(addr < cache->len && 8 <= cache->len - addr);
     fuzz_dma_read_cb(cache->xlat + addr, 8, cache->mrs.mr);
     if (likely(cache->ptr)) {
-        return LD_P(q)(cache->ptr + addr);
+        return LD_P(q)((char*)cache->ptr + addr);
     } else {
         return ADDRESS_SPACE_LD_CACHED_SLOW(q)(cache, addr, attrs, result);
     }
@@ -76,7 +76,7 @@ static inline void ADDRESS_SPACE_ST_CACHED(w)(MemoryRegionCache *cache,
 {
     assert(addr < cache->len && 2 <= cache->len - addr);
     if (likely(cache->ptr)) {
-        ST_P(w)(cache->ptr + addr, val);
+        ST_P(w)((char*)cache->ptr + addr, val);
     } else {
         ADDRESS_SPACE_ST_CACHED_SLOW(w)(cache, addr, val, attrs, result);
     }
@@ -87,7 +87,7 @@ static inline void ADDRESS_SPACE_ST_CACHED(l)(MemoryRegionCache *cache,
 {
     assert(addr < cache->len && 4 <= cache->len - addr);
     if (likely(cache->ptr)) {
-        ST_P(l)(cache->ptr + addr, val);
+        ST_P(l)((char*)cache->ptr + addr, val);
     } else {
         ADDRESS_SPACE_ST_CACHED_SLOW(l)(cache, addr, val, attrs, result);
     }
@@ -98,7 +98,7 @@ static inline void ADDRESS_SPACE_ST_CACHED(q)(MemoryRegionCache *cache,
 {
     assert(addr < cache->len && 8 <= cache->len - addr);
     if (likely(cache->ptr)) {
-        ST_P(q)(cache->ptr + addr, val);
+        ST_P(q)((char*)cache->ptr + addr, val);
     } else {
         ADDRESS_SPACE_ST_CACHED_SLOW(q)(cache, addr, val, attrs, result);
     }
-- 
2.45.2.627.g7a2c4fd464-goog


