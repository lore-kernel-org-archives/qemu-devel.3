Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5DDC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 00:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJiri-0007Iw-NH; Tue, 18 Jun 2024 20:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3TCFyZgQKCpEC53C19916z.x97Bz7F-yzGz689818F.9C1@flex--rkir.bounces.google.com>)
 id 1sJira-0007IP-4t
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 20:07:47 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3TCFyZgQKCpEC53C19916z.x97Bz7F-yzGz689818F.9C1@flex--rkir.bounces.google.com>)
 id 1sJirY-0005rU-Ck
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 20:07:45 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-dfe44496da9so10702954276.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 17:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718755661; x=1719360461; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=PswgJgfdGa9sop3DP6SyW+B2hdAbdt/AjMlIVsl0w8g=;
 b=iR3jcwi2LZ3fycJPpXZ+G+wGGsdbbY1xk6uTQHBuDouOgs6fDhHs7YNHuUH5e7X6/k
 +qqyEA9zdZu9cHbEYMPEzG1Va2M1Ps3RMhAsPMpX3Iy69UJnz1bQW7+nOu8FYQSdMAad
 dhfaQS7xr6IOF8WTSVIdQ6+FJHkKVa7CHIty0D+nPm4VFH45ASVVyiWP3MS5nun7G2cO
 E6GgFl7yLPCBWTYO2yDsxxmBvXaP7XB8c4AcjNr2GgCyhOZR4vLZGhkQ6CgcYiUTy6Ga
 0SKLjTN29I30oa0rKf5c/xQiy2ipRZF8sKU3r3nVZ+dzjJxqjsplGQuoqHr/fr6r4rdD
 WQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718755661; x=1719360461;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PswgJgfdGa9sop3DP6SyW+B2hdAbdt/AjMlIVsl0w8g=;
 b=pXD4bbHCTTR2ZYSpOaTVA1TdB8NW9eydKsahOHtSQPgyyW11Z3dfsCzDVNHwPzrSrR
 YNcHVoltOBGuYtweN7L9abC6FHF0ZgCa6xXQkJjJGxtXHY8hvkjCulSsU+Nu0PvAPge9
 L9jmOadS7fZ/5EJ5ChM+Ly1tjD+i25aByhexDA9w0uUZRkwN+BhnEChsRS18Tcjihxwf
 BoYFn2ZHrwu39SURYKLy+VMObKDKM/hm82mO8236kadTvQy8IN5rBtVLCpsYWQLir3e6
 R9pfC0H0OUknfxW8fHpILCY3SirnBdoIBiOUOqQghNlDGVQHOWWfCDdlaRwUIRcfmItM
 /MJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwa+54EtJj7HQhy1c/rHPPPWVpkePGxjmWs+RaGXBZHukGvGhXsHKbOpVjD2vCSjN9Ycl+BqanrhLoSi0WNA3/0bltQks=
X-Gm-Message-State: AOJu0YzNK8v/YAL4ZgURXFaRJ7c04OmSTBk3Ul7cs74RTJDVoLSywxJi
 gPiLMFaR8y1o/fXBjGJGrSCnrEIdkFeyw4CDDYtpwpFdJjQjCK8URzNRBamKQnUzXsRM5A==
X-Google-Smtp-Source: AGHT+IHZzN2OsvyT9/tDfPbxt1RJOzPfmWC5wOlOCnjjn2R5lOlcwTB1pGtTbZAPk9TJfrBhKL0frUV8
X-Received: from rkir98.kir.corp.google.com
 ([2620:15c:7d:4:fddf:5bf:9eb2:410e])
 (user=rkir job=sendgmr) by 2002:a05:6902:1890:b0:e02:5b08:d3a with SMTP id
 3f1490d57ef6-e02bdf6420bmr260170276.0.1718755660868; Tue, 18 Jun 2024
 17:07:40 -0700 (PDT)
Date: Tue, 18 Jun 2024 17:04:50 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240619000450.893463-1-rkir@google.com>
Subject: [PATCH v2] exec: use char* for pointer arithmetic
From: Roman Kiryanov <rkir@google.com>
To: richard.henderson@linaro.org, qemu-devel@nongnu.org
Cc: jansene@google.com, mett@google.com, jpcottin@google.com, 
 Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3TCFyZgQKCpEC53C19916z.x97Bz7F-yzGz689818F.9C1@flex--rkir.bounces.google.com;
 helo=mail-yb1-xb49.google.com
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
v2: change `char*` into `char *` (add the missing space).

 include/exec/memory.h                 |  8 ++++----
 include/exec/memory_ldst_cached.h.inc | 12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index d7591a60d9..a6d64e39a5 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2839,7 +2839,7 @@ static inline uint8_t address_space_ldub_cached(MemoryRegionCache *cache,
 {
     assert(addr < cache->len);
     if (likely(cache->ptr)) {
-        return ldub_p(cache->ptr + addr);
+        return ldub_p((char *)cache->ptr + addr);
     } else {
         return address_space_ldub_cached_slow(cache, addr, attrs, result);
     }
@@ -2850,7 +2850,7 @@ static inline void address_space_stb_cached(MemoryRegionCache *cache,
 {
     assert(addr < cache->len);
     if (likely(cache->ptr)) {
-        stb_p(cache->ptr + addr, val);
+        stb_p((char *)cache->ptr + addr, val);
     } else {
         address_space_stb_cached_slow(cache, addr, val, attrs, result);
     }
@@ -3123,7 +3123,7 @@ address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
     assert(addr < cache->len && len <= cache->len - addr);
     fuzz_dma_read_cb(cache->xlat + addr, len, cache->mrs.mr);
     if (likely(cache->ptr)) {
-        memcpy(buf, cache->ptr + addr, len);
+        memcpy(buf, (char *)cache->ptr + addr, len);
         return MEMTX_OK;
     } else {
         return address_space_read_cached_slow(cache, addr, buf, len);
@@ -3144,7 +3144,7 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
 {
     assert(addr < cache->len && len <= cache->len - addr);
     if (likely(cache->ptr)) {
-        memcpy(cache->ptr + addr, buf, len);
+        memcpy((char *)cache->ptr + addr, buf, len);
         return MEMTX_OK;
     } else {
         return address_space_write_cached_slow(cache, addr, buf, len);
diff --git a/include/exec/memory_ldst_cached.h.inc b/include/exec/memory_ldst_cached.h.inc
index d7834f852c..9426663524 100644
--- a/include/exec/memory_ldst_cached.h.inc
+++ b/include/exec/memory_ldst_cached.h.inc
@@ -30,7 +30,7 @@ static inline uint16_t ADDRESS_SPACE_LD_CACHED(uw)(MemoryRegionCache *cache,
     assert(addr < cache->len && 2 <= cache->len - addr);
     fuzz_dma_read_cb(cache->xlat + addr, 2, cache->mrs.mr);
     if (likely(cache->ptr)) {
-        return LD_P(uw)(cache->ptr + addr);
+        return LD_P(uw)((char *)cache->ptr + addr);
     } else {
         return ADDRESS_SPACE_LD_CACHED_SLOW(uw)(cache, addr, attrs, result);
     }
@@ -42,7 +42,7 @@ static inline uint32_t ADDRESS_SPACE_LD_CACHED(l)(MemoryRegionCache *cache,
     assert(addr < cache->len && 4 <= cache->len - addr);
     fuzz_dma_read_cb(cache->xlat + addr, 4, cache->mrs.mr);
     if (likely(cache->ptr)) {
-        return LD_P(l)(cache->ptr + addr);
+        return LD_P(l)((char *)cache->ptr + addr);
     } else {
         return ADDRESS_SPACE_LD_CACHED_SLOW(l)(cache, addr, attrs, result);
     }
@@ -54,7 +54,7 @@ static inline uint64_t ADDRESS_SPACE_LD_CACHED(q)(MemoryRegionCache *cache,
     assert(addr < cache->len && 8 <= cache->len - addr);
     fuzz_dma_read_cb(cache->xlat + addr, 8, cache->mrs.mr);
     if (likely(cache->ptr)) {
-        return LD_P(q)(cache->ptr + addr);
+        return LD_P(q)((char *)cache->ptr + addr);
     } else {
         return ADDRESS_SPACE_LD_CACHED_SLOW(q)(cache, addr, attrs, result);
     }
@@ -76,7 +76,7 @@ static inline void ADDRESS_SPACE_ST_CACHED(w)(MemoryRegionCache *cache,
 {
     assert(addr < cache->len && 2 <= cache->len - addr);
     if (likely(cache->ptr)) {
-        ST_P(w)(cache->ptr + addr, val);
+        ST_P(w)((char *)cache->ptr + addr, val);
     } else {
         ADDRESS_SPACE_ST_CACHED_SLOW(w)(cache, addr, val, attrs, result);
     }
@@ -87,7 +87,7 @@ static inline void ADDRESS_SPACE_ST_CACHED(l)(MemoryRegionCache *cache,
 {
     assert(addr < cache->len && 4 <= cache->len - addr);
     if (likely(cache->ptr)) {
-        ST_P(l)(cache->ptr + addr, val);
+        ST_P(l)((char *)cache->ptr + addr, val);
     } else {
         ADDRESS_SPACE_ST_CACHED_SLOW(l)(cache, addr, val, attrs, result);
     }
@@ -98,7 +98,7 @@ static inline void ADDRESS_SPACE_ST_CACHED(q)(MemoryRegionCache *cache,
 {
     assert(addr < cache->len && 8 <= cache->len - addr);
     if (likely(cache->ptr)) {
-        ST_P(q)(cache->ptr + addr, val);
+        ST_P(q)((char *)cache->ptr + addr, val);
     } else {
         ADDRESS_SPACE_ST_CACHED_SLOW(q)(cache, addr, val, attrs, result);
     }
-- 
2.45.2.627.g7a2c4fd464-goog


