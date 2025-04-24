Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42218C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kmk-0005Cr-R8; Wed, 23 Apr 2025 20:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmh-0005Ay-1w
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:47 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmf-0004Jr-AM
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:46 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso508909b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455784; x=1746060584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tJ+EfqFiptMAQIqFH9MrlUuf9tOxdmhxubkBN2YjdQI=;
 b=Gw1pNs7i1lfKSmriOnQ5d848YHWSRj3mSIPhviN1hDkp3CvTZyScxQDTSqf8Dl2wNV
 B9Jrm6lxtArWoiv4/BIfG/1/nYurkl2t0zxobXMbv7GO3FaBi2aJJX9THUvXz+A6aNjW
 K2iue060iNNuRL/Ovu5+Kmb2fXISBrQ+TmOOTSw1+K0D3AmZhF2yJ0oK2BFzOpwDOR3O
 bjduvMrYDYvnnt11l+UTEWUg8cHxWhMTBEzn4QUh7sNKJxusQ+GtnRNah3H54n5oLy09
 Ry33rW6YzKDpSZEBY7xwKyVNc85CfrFnoAVX85YmLw9TIt2Su8AAXgXI1jd6XUModvTS
 gAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455784; x=1746060584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tJ+EfqFiptMAQIqFH9MrlUuf9tOxdmhxubkBN2YjdQI=;
 b=l/A46OpUYSZ7/Qb5cMEDC++7KGJnuPijlR44q0UjB3wjRXfGiaJCdA+znX+kA9UFce
 /qdn94fWcRuh+9efkZ0FqeGkg2ATH0vrQEhFEJo872DnI+glcVv9MoWLSYWw+pRt2M1c
 piSlid7JIfLXXmAIdfuofFc/eBFjgeqKVnTfKn5mOGu7qlgBMaR5F1AHI6300PmN9BwD
 hNABROq7xkwr47QIO8EnS3goie4XgwEYiBmBbPfACdUZChcwDKGOqlNjAaX5JsyxkulW
 GjFzS309hWH8p8Igtq71z7VGRVdIzB7aM1xK8E3ZRNAICV2OcOA4IdniS0Os7xm5OjKI
 /4Kg==
X-Gm-Message-State: AOJu0YwtQQomND23sGMaVYkd2OS2exz6itrEziaKHbwyh5KT9W6L8abL
 hPZv9R67yHOICaxmgof1iQKkZzUuVRFqyOuHp2+9NWleYiU4/CEBqJrLsGMais5o5rLKyw1ZKHE
 Q
X-Gm-Gg: ASbGncs2Qa4Jxwun3cnN1TadVr2flo3iBlpyJ70tVufRxRJeunyfz5VWydjNXjBoV8V
 OejDpMoQNHDUHJe+WglyJdS1YTqwHWbS3OppB48aT6JzkOb4WI3tr6jkoaObx8bAcl//vFFDN0k
 H9R8Ca9J8JRqdkj5er+EtO+cXi2ovBIUTATOdbV7EO1jn3m7EBhfAgob7icwvmswy08/HwRWKen
 pqps+mmSVCZlJW2a43I33rWZVE7nbHBzwpqfI2/3Hgmpcyu1Z6qganc02JwosbqMxyAC3vavrP7
 8dTHc5fAQWZjQGSjNgwX3dXjd2hfFTM7YVnTA+dSh5A6NfscjKm07oKnmariJZz9GmjRM2BLoic
 ZCj1dmqjOhw==
X-Google-Smtp-Source: AGHT+IG1U0nJ3NukoXGRYKhcQtI33ZU2dRxqw3/waTrcBPeSAy5xb9og9kgoT1ybYGpPgW1XBgP+Zw==
X-Received: by 2002:a05:6a00:928b:b0:725:4a1b:38ec with SMTP id
 d2e1a72fcca58-73e267b8cf9mr690382b3a.3.1745455784056; 
 Wed, 23 Apr 2025 17:49:44 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 013/148] system/xen: remove inline stubs
Date: Wed, 23 Apr 2025 17:47:18 -0700
Message-ID: <20250424004934.598783-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317183417.285700-14-pierrick.bouvier@linaro.org>
---
 include/system/xen-mapcache.h | 41 -----------------------------------
 include/system/xen.h          | 21 +++---------------
 2 files changed, 3 insertions(+), 59 deletions(-)

diff --git a/include/system/xen-mapcache.h b/include/system/xen-mapcache.h
index b68f196ddd..bb454a7c96 100644
--- a/include/system/xen-mapcache.h
+++ b/include/system/xen-mapcache.h
@@ -14,8 +14,6 @@
 
 typedef hwaddr (*phys_offset_to_gaddr_t)(hwaddr phys_offset,
                                          ram_addr_t size);
-#ifdef CONFIG_XEN_IS_POSSIBLE
-
 void xen_map_cache_init(phys_offset_to_gaddr_t f,
                         void *opaque);
 uint8_t *xen_map_cache(MemoryRegion *mr, hwaddr phys_addr, hwaddr size,
@@ -28,44 +26,5 @@ void xen_invalidate_map_cache(void);
 uint8_t *xen_replace_cache_entry(hwaddr old_phys_addr,
                                  hwaddr new_phys_addr,
                                  hwaddr size);
-#else
-
-static inline void xen_map_cache_init(phys_offset_to_gaddr_t f,
-                                      void *opaque)
-{
-}
-
-static inline uint8_t *xen_map_cache(MemoryRegion *mr,
-                                     hwaddr phys_addr,
-                                     hwaddr size,
-                                     ram_addr_t ram_addr_offset,
-                                     uint8_t lock,
-                                     bool dma,
-                                     bool is_write)
-{
-    abort();
-}
-
-static inline ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
-{
-    abort();
-}
-
-static inline void xen_invalidate_map_cache_entry(uint8_t *buffer)
-{
-}
-
-static inline void xen_invalidate_map_cache(void)
-{
-}
-
-static inline uint8_t *xen_replace_cache_entry(hwaddr old_phys_addr,
-                                               hwaddr new_phys_addr,
-                                               hwaddr size)
-{
-    abort();
-}
-
-#endif
 
 #endif /* XEN_MAPCACHE_H */
diff --git a/include/system/xen.h b/include/system/xen.h
index 990c19a8ef..5f41915732 100644
--- a/include/system/xen.h
+++ b/include/system/xen.h
@@ -25,30 +25,15 @@
 #endif /* COMPILING_PER_TARGET */
 
 #ifdef CONFIG_XEN_IS_POSSIBLE
-
 extern bool xen_allowed;
-
 #define xen_enabled()           (xen_allowed)
+#else /* !CONFIG_XEN_IS_POSSIBLE */
+#define xen_enabled() 0
+#endif /* CONFIG_XEN_IS_POSSIBLE */
 
 void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
 void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
                    struct MemoryRegion *mr, Error **errp);
-
-#else /* !CONFIG_XEN_IS_POSSIBLE */
-
-#define xen_enabled() 0
-static inline void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
-{
-    /* nothing */
-}
-static inline void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
-                                 MemoryRegion *mr, Error **errp)
-{
-    g_assert_not_reached();
-}
-
-#endif /* CONFIG_XEN_IS_POSSIBLE */
-
 bool xen_mr_is_memory(MemoryRegion *mr);
 bool xen_mr_is_grants(MemoryRegion *mr);
 #endif
-- 
2.43.0


