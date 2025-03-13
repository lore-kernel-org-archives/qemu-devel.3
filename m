Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3DEC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 16:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tslct-0006jm-6K; Thu, 13 Mar 2025 12:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tslao-0003Un-2a
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:39:34 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tslak-0005j1-Jc
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:39:33 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2fecba90cc3so2590661a91.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 09:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741883969; x=1742488769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/B5foK4Qy0OvFQVWNYpVAAsAF+tVTKpBxl4Jl8CdPFE=;
 b=h6G0ju1FFFvJs1QWONdC/10/IJ5LtezCPMEU7MD5gvpRmNp6+xnjvDGuMZq6u1E2SQ
 UleMxl4goug1vJxHr5A2OWW3+cIKmxeHGhb+WnOhXypodTt99xRQ8oFXsthJkEprg1GP
 3QOr/Sr1Na3Fk4gjnwbPRo7f6y1DbLQNuXyLDl/18AaPIdL0GM7Yy+bdaQmEsjwdAXjU
 jffyi1tqoD4I7T7RFl7s7S1JAjuYv5BnpdmrECpLCAuDRAyVZLxglZFQZhItIHfzldxR
 j7Oxi4tr81scefOR4kufGUVlejmmUHOxLgE7zWICEQbZwmlQNJeQ7LNl2hL9Bttt1aQF
 sQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741883969; x=1742488769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/B5foK4Qy0OvFQVWNYpVAAsAF+tVTKpBxl4Jl8CdPFE=;
 b=L6KaCH9XvWHccsrKUUITXhTiBFjCDVjWw/hPrKljw6oU5SIPqPfsPGFTeUl6hhGy5n
 z5EfS0TFt4xZIu2LDvziXsCHP897omFbMeOTv69vtdHMFWUOhWp287WMAv78BLsD8sy+
 d6s521HLtt1I7GN29zRM+dOEtTC9z0z3EhkvZQNA7vUet/H5UALjhN7Zw/RsoMF0dfzy
 v5E4A2TGKnnLwrUpZ9BcREMQaOeUwMbGZxBfNalej4COc98uxzTBsmfO74Y3S+e4Ox7E
 qcBH58gMwJG9yki4jMRt961dlKhUNMHLxkuxr9vBzAl000cW0Or6QMNcILNCwlUVpVTM
 Q88g==
X-Gm-Message-State: AOJu0Ywnc1QCV/EIPSIBsXQ+Ca2hzqfI57oCenhDUJzwZwPo+Wea7Uvh
 E3+DVoB0OPsch7dLyaOZnLPLqmUfTvBlnufhj06h4yntsP2/Lk1+VOPjKubIFAidpvjzUBOacd6
 TXtE=
X-Gm-Gg: ASbGncvZQTGlYEbjiZKjJpyWcyObZBgGHjev5mDiVAP92uppqHT067WiTtOwH8yqRe0
 2D8ixoIZZ9cdHN6ubWAERilKfvSwSN7i8qiDpC8oFgtPLcBwQJhD22L21cNt691yUpP3hqM7GgI
 xDjuT5MsD0/3puwGvWhITVmFqH2/nzgFFsSuL6fyttvh1wieNCdpLVGmrub5irYK/fin/ZNaSQ/
 7usvirPpsWJmK7xCwxy6CPXGUzWrQsPkIxW2nnN2Tv+eNh60/4yFrdF48MQYVqqsjDUlzHYwx43
 +4AI7FHWMTJKXl8i8oq3UaNh38LvpeweSHQE3mw2pSYP
X-Google-Smtp-Source: AGHT+IE6Us2O77TYYfj/J/RmRU6RhpFIbMCr45wvgkThs0nxBWSPhVRimj63yvMeVhIF4wJ+N9MdKw==
X-Received: by 2002:a17:90b:3bc6:b0:2ff:58b8:5c46 with SMTP id
 98e67ed59e1d1-3014e82fd9amr271511a91.8.1741883968719; 
 Thu, 13 Mar 2025 09:39:28 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30119265938sm4020084a91.39.2025.03.13.09.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 09:39:28 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Peter Xu <peterx@redhat.com>,
 alex.bennee@linaro.org, manos.pitsidianakis@linaro.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 15/17] include/exec/memory: move devend functions to
 memory-internal.h
Date: Thu, 13 Mar 2025 09:39:01 -0700
Message-Id: <20250313163903.1738581-16-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313163903.1738581-1-pierrick.bouvier@linaro.org>
References: <20250313163903.1738581-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Only system/physmem.c and system/memory.c use those functions, so we can
move then to internal header.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/memory-internal.h | 19 +++++++++++++++++++
 include/exec/memory.h          | 18 ------------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index b729f3b25ad..c75178a3d6b 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -43,5 +43,24 @@ void address_space_dispatch_free(AddressSpaceDispatch *d);
 
 void mtree_print_dispatch(struct AddressSpaceDispatch *d,
                           MemoryRegion *root);
+
+/* returns true if end is big endian. */
+static inline bool devend_big_endian(enum device_endian end)
+{
+    QEMU_BUILD_BUG_ON(DEVICE_HOST_ENDIAN != DEVICE_LITTLE_ENDIAN &&
+                      DEVICE_HOST_ENDIAN != DEVICE_BIG_ENDIAN);
+
+    if (end == DEVICE_NATIVE_ENDIAN) {
+        return target_words_bigendian();
+    }
+    return end == DEVICE_BIG_ENDIAN;
+}
+
+/* enum device_endian to MemOp.  */
+static inline MemOp devend_memop(enum device_endian end)
+{
+    return devend_big_endian(end) ? MO_BE : MO_LE;
+}
+
 #endif
 #endif
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 70177304a92..a3bb0542bf6 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -3138,24 +3138,6 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
 MemTxResult address_space_set(AddressSpace *as, hwaddr addr,
                               uint8_t c, hwaddr len, MemTxAttrs attrs);
 
-/* returns true if end is big endian. */
-static inline bool devend_big_endian(enum device_endian end)
-{
-    QEMU_BUILD_BUG_ON(DEVICE_HOST_ENDIAN != DEVICE_LITTLE_ENDIAN &&
-                      DEVICE_HOST_ENDIAN != DEVICE_BIG_ENDIAN);
-
-    if (end == DEVICE_NATIVE_ENDIAN) {
-        return target_words_bigendian();
-    }
-    return end == DEVICE_BIG_ENDIAN;
-}
-
-/* enum device_endian to MemOp.  */
-static inline MemOp devend_memop(enum device_endian end)
-{
-    return devend_big_endian(end) ? MO_BE : MO_LE;
-}
-
 /*
  * Inhibit technologies that require discarding of pages in RAM blocks, e.g.,
  * to manage the actual amount of memory consumed by the VM (then, the memory
-- 
2.39.5


