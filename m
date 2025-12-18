Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59988D711C4
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 21:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWLYD-0001Gt-JE; Thu, 18 Dec 2025 16:28:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWLY7-0001Eo-DM
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:28:39 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWLY5-0007G1-4X
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:28:38 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-477770019e4so9220835e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 13:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766093315; x=1766698115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+gtJF0mQnqytiehBxnmWHOQY5+iP99pLlE/lksFMG9Q=;
 b=BBj2nRGYR4NGl2jFnkzo4YvUCquAVO6SAtGJLNyKymuCHOZrNfsGRPuCRUyWKDVlCc
 zUQUijOnMSjKiM3I/SEcNYHMQf6j0lCEuDLn17euxOElPITypW1kkG7/rTPpdBAhhogv
 0zvrg8l3LzI4Qfqnm1cgIf1KZiPIDPrKdzZwEfPLjchvx1mLgFb4ZMhfQs6aLFVb9HwJ
 +YfgbyDKwUyHY6Qm5DjPlOqXsbhennHDU3kUd5WSwpQOEVYlIwRVoOr0kiwIWVENrvo/
 2RCHNGlrbyM1yGIoFWz7TAJ/vo6wKsm3yaeB4TK8+jYuHb1gnLRV8WooqGp6WSZEmWr8
 545g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766093315; x=1766698115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+gtJF0mQnqytiehBxnmWHOQY5+iP99pLlE/lksFMG9Q=;
 b=pTNGpnhNGCk4PLVawvL3fE4VF6EBJ9vyxtRkLaywAIocer6HVwau5u9hLA5+2Zcvwz
 NYrN/L/zgwNNFrPls+/S2qUZ560/srF5I1Y8p1dWKY7eFvHfHErGoRUD0fzXZ4gzm/2i
 71VLulPOOMjZmTdMTJwmIgXRqb/SPEKpgl7hlxWR5ljWq7SFVh7nEvt4Ker7lnJuVn/m
 IUXK39bVBJ0J7y4gIZ4uR/q/K9EKPyWilWWanHkXENc1N1NL5mlZGbXHGdvS9/+8tgvR
 jDaRFT24poshvCU/x5g8VO+UhDQJQ/C7mK1XgQHxSI2xVlkzhbt+CAvKc3LWgX6Aka4z
 ZWZA==
X-Gm-Message-State: AOJu0YwkHSNtzIYUtIEIBzt7YAn2Vx67MpNT9YLzfnJ4qAlLPI17RF4f
 UjqDQF7RC4Rr5xXa7/vYk+WbwoMMMK2fL9fIVoBWeIc3RLVuba4jbVoLiEwliB2UWsntJSvtLYR
 nIe1PETk=
X-Gm-Gg: AY/fxX4qRwlqilBoUaN8AoLio3vdIgZ3Ow/VbF5xtdq8D6rvPV4bGLprjYZXnz+iHPl
 OHiOtLps8IDWikadreDi/Io2R4G1srsGrDZN6FeQRjORKBwMwaEY5Hp2InjQp+dJgVilxCKgI+v
 ZMy1e15bRj7ZvL4OtY3CgA7EiW3Y/WNAnOYa8ewrLlvqVi38j2OLEwevuFd8YXMu79Yhz2xfsFr
 mJZcw2PxqdY5j2zCKlEsW9UG0+sd806rIgAubwK0jJ+jxZKrm1U6Cyi1SdqVzsn4e0SJc7S5CS6
 Bn5myX25Jmeh1l0xMS8Ij/VdFndJOgNbl9+AedLgBk874pVmZJrDsVTWBtnzofGLHsmk+Cl3Yks
 xRv07EViGQcaeYzjdTi/l00CQgYw+oMb5iQKp7VatVVGEUhyOfsqRj+xX+98W3pmclAtniZPZVw
 vhfDqKJdSxWScCP/8q3QFemS0iXUpYNi0K2YHJIs0GMs4p9+zoTzmDPZtsgr+5khNqP6VnkCU=
X-Google-Smtp-Source: AGHT+IFtA4Hc0GbI11866J97XNlInb01Wxb2Ifj3fBHxMuibqLwqKv9yTVGzYWw8G1fi653OPTL7uQ==
X-Received: by 2002:a05:6000:420c:b0:430:f5ed:83f3 with SMTP id
 ffacd0b85a97d-4324e4c7284mr833896f8f.9.1766093314722; 
 Thu, 18 Dec 2025 13:28:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa0908sm1003301f8f.31.2025.12.18.13.28.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Dec 2025 13:28:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH 2/4] system/memory: Introduce LD/ST helpers with @m suffix
 (for MemOp)
Date: Thu, 18 Dec 2025 22:28:12 +0100
Message-ID: <20251218212814.61445-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218212814.61445-1-philmd@linaro.org>
References: <20251218212814.61445-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Introduce load/store helpers taking a MemOp argument (which can
include size and endianness). Use the -m suffix to differentiate
with others.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/loads-stores.rst                  | 10 ++++---
 include/exec/memory_ldst_cached.h.inc        | 30 ++++++++++++++++++++
 include/system/memory_ldst_endian.h.inc      |  4 +++
 include/system/memory_ldst_phys_endian.h.inc | 10 +++++++
 4 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index c906c6509ee..9b8ee4a5d34 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -375,6 +375,7 @@ succeeded using a MemTxResult return code.
  - ``w`` : 16 bits
  - ``l`` : 32 bits
  - ``q`` : 64 bits
+ - ``m`` : MO_SIZE
 
 ``endian``
  - ``le`` : little endian
@@ -384,8 +385,8 @@ The ``_{endian}`` suffix is omitted for byte accesses.
 
 Regexes for git grep:
  - ``\<address_space_\(read\|write\|rw\)\>``
- - ``\<address_space_ldu\?[bwql]\(_[lb]e\)\?\>``
- - ``\<address_space_st[bwql]\(_[lb]e\)\?\>``
+ - ``\<address_space_ldu\?[bwlqm]\(_[lb]e\)\?\>``
+ - ``\<address_space_st[bwlqm]\(_[lb]e\)\?\>``
 
 ``address_space_write_rom``
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -431,6 +432,7 @@ device doing the access has no way to report such an error.
  - ``w`` : 16 bits
  - ``l`` : 32 bits
  - ``q`` : 64 bits
+ - ``m`` : MO_SIZE
 
 ``endian``
  - ``le`` : little endian
@@ -439,8 +441,8 @@ device doing the access has no way to report such an error.
 The ``_{endian}_`` infix is omitted for byte accesses.
 
 Regexes for git grep:
- - ``\<ldu\?[bwlq]\(_[bl]e\)\?_phys\>``
- - ``\<st[bwlq]\(_[bl]e\)\?_phys\>``
+ - ``\<ldu\?[bwlqm]\(_[bl]e\)\?_phys\>``
+ - ``\<st[bwlqm]\(_[bl]e\)\?_phys\>``
 
 ``cpu_physical_memory_*``
 ~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/include/exec/memory_ldst_cached.h.inc b/include/exec/memory_ldst_cached.h.inc
index d7834f852c4..21f89fe09fa 100644
--- a/include/exec/memory_ldst_cached.h.inc
+++ b/include/exec/memory_ldst_cached.h.inc
@@ -24,6 +24,21 @@
 #define LD_P(size) \
     glue(glue(ld, size), glue(ENDIANNESS, _p))
 
+static inline uint64_t ADDRESS_SPACE_LD_CACHED(m)(MemoryRegionCache *cache,
+                                                  MemOp mop, hwaddr addr,
+                                                  MemTxAttrs attrs,
+                                                  MemTxResult *result)
+{
+    const unsigned size = memop_size(mop);
+    assert(addr < cache->len && size <= cache->len - addr);
+    fuzz_dma_read_cb(cache->xlat + addr, size, cache->mrs.mr);
+    if (likely(cache->ptr)) {
+        return LD_P(n)(cache->ptr + addr, size);
+    } else {
+        return ADDRESS_SPACE_LD_CACHED_SLOW(m)(cache, mop, addr, attrs, result);
+    }
+}
+
 static inline uint16_t ADDRESS_SPACE_LD_CACHED(uw)(MemoryRegionCache *cache,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
@@ -71,6 +86,21 @@ static inline uint64_t ADDRESS_SPACE_LD_CACHED(q)(MemoryRegionCache *cache,
 #define ST_P(size) \
     glue(glue(st, size), glue(ENDIANNESS, _p))
 
+static inline void ADDRESS_SPACE_ST_CACHED(m)(MemoryRegionCache *cache,
+                                              MemOp mop,
+                                              hwaddr addr, uint64_t val,
+                                              MemTxAttrs attrs,
+                                              MemTxResult *result)
+{
+    const unsigned size = memop_size(mop);
+    assert(addr < cache->len && size <= cache->len - addr);
+    if (likely(cache->ptr)) {
+        ST_P(n)(cache->ptr + addr, val, size);
+    } else {
+        ADDRESS_SPACE_ST_CACHED_SLOW(m)(cache, mop, addr, val, attrs, result);
+    }
+}
+
 static inline void ADDRESS_SPACE_ST_CACHED(w)(MemoryRegionCache *cache,
     hwaddr addr, uint16_t val, MemTxAttrs attrs, MemTxResult *result)
 {
diff --git a/include/system/memory_ldst_endian.h.inc b/include/system/memory_ldst_endian.h.inc
index ec86e42afbc..9455b973663 100644
--- a/include/system/memory_ldst_endian.h.inc
+++ b/include/system/memory_ldst_endian.h.inc
@@ -20,12 +20,16 @@ uint32_t ADDRESS_SPACE_LD(l)(ARG1_DECL, hwaddr addr,
                              MemTxAttrs attrs, MemTxResult *result);
 uint64_t ADDRESS_SPACE_LD(q)(ARG1_DECL, hwaddr addr,
                              MemTxAttrs attrs, MemTxResult *result);
+uint64_t ADDRESS_SPACE_LD(m)(ARG1_DECL, MemOp mop, hwaddr addr,
+                             MemTxAttrs attrs, MemTxResult *result);
 void ADDRESS_SPACE_ST(w)(ARG1_DECL, hwaddr addr, uint16_t val,
                          MemTxAttrs attrs, MemTxResult *result);
 void ADDRESS_SPACE_ST(l)(ARG1_DECL, hwaddr addr, uint32_t val,
                          MemTxAttrs attrs, MemTxResult *result);
 void ADDRESS_SPACE_ST(q)(ARG1_DECL, hwaddr addr, uint64_t val,
                          MemTxAttrs attrs, MemTxResult *result);
+void ADDRESS_SPACE_ST(m)(ARG1_DECL, MemOp mop, hwaddr addr, uint64_t val,
+                         MemTxAttrs attrs, MemTxResult *result);
 
 #undef ADDRESS_SPACE_LD
 #undef ADDRESS_SPACE_ST
diff --git a/include/system/memory_ldst_phys_endian.h.inc b/include/system/memory_ldst_phys_endian.h.inc
index 9603d886867..659f38f7112 100644
--- a/include/system/memory_ldst_phys_endian.h.inc
+++ b/include/system/memory_ldst_phys_endian.h.inc
@@ -34,6 +34,11 @@ static inline uint64_t LD_PHYS(q)(ARG1_DECL, hwaddr addr)
     return ADDRESS_SPACE_LD(q)(ARG1, addr, MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
+static inline uint32_t LD_PHYS(m)(ARG1_DECL, MemOp op, hwaddr addr)
+{
+    return ADDRESS_SPACE_LD(m)(ARG1, op, addr, MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
 static inline void ST_PHYS(w)(ARG1_DECL, hwaddr addr, uint16_t val)
 {
     ADDRESS_SPACE_ST(w)(ARG1, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
@@ -49,6 +54,11 @@ static inline void ST_PHYS(q)(ARG1_DECL, hwaddr addr, uint64_t val)
     ADDRESS_SPACE_ST(q)(ARG1, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
+static inline void ST_PHYS(m)(ARG1_DECL, MemOp op, hwaddr addr, uint64_t val)
+{
+    ADDRESS_SPACE_ST(m)(ARG1, op, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
 #undef LD_PHYS
 #undef ST_PHYS
 #undef ADDRESS_SPACE_LD
-- 
2.52.0


