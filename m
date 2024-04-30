Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73C4C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qhA-0000B7-Ut; Tue, 30 Apr 2024 12:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgj-0006j9-UO
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:50:42 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgh-00065c-5q
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:50:41 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2dd615b6c44so64614881fa.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714495835; x=1715100635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Sw3MC4uOQJ6IvvUC7PiIJPbknZwiSjSO/ejkDz0sxs=;
 b=ngx5MLjEbnBQO9u3gSOpxCaX0xqWwPvY814oKXAUp1fbebqV2eujJkQEr+IqYBwXrM
 EDXpNTFEhoqWQheEWS6RdzFd9DhN96z9WfEEAtChL1oPl08YvwjYAxdDzIcokAyZ397t
 oeviSY6B8aR3vUafw1fBbBYKbB02Uj8nBYvHlXPFWZ26ZztpH0cTdV8nRIm4RlOmrz0g
 nWYD1beXTzqxEwLxnS2SHFJhbh5E3Q9qG3lNF5/VrTyljXhR8u9HVH2C7jGWncUrKVNL
 IA7W6GFRr6GXXSvZQ3eT2tz//b6E1mkWnUMllcAdQcn73h+ELEMl6sgE9RR3WX0vp8JX
 Hasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495835; x=1715100635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Sw3MC4uOQJ6IvvUC7PiIJPbknZwiSjSO/ejkDz0sxs=;
 b=EjrZBFaS7KDOy/8E4FkjQE+l7m5epV8hH/wG/Ba4HDKaYuczwHXlRgvfklpRcrTpAj
 +JBYaTp+msrI8+bWQskyss+dQjPZg5s/lKd+s6yI0pQWojIWKEXHVQALkmJ2JGc7zk/1
 qbmpW5dnKai882phos6HiAcuDZPsldJFXejlYyJpyMJVjQBbBYkemTwZFOETD666Qrzb
 JfEP2ks6oCTShBP3pyZNRaX6FlgmeIZQjckIwoTJcgqBIgYut1NUOVWUenP+p0b+voZl
 MdiaBGjxbghWmPCjMuBiZAaNmNEsl79uegSw1U+zpOivmnko1jWl+Rfbg03KTtbBrero
 HlPQ==
X-Gm-Message-State: AOJu0Yxl6uIl/HtdX7CsW3rSBCRQgdUFBvj6JBphCs9Gl2+4DWfWVPZO
 d7nnFEcT9NRjcqQvs1qOtsDiew7rl1Z86bxtaTAQltmOArRYRTxomW0Lsi/J
X-Google-Smtp-Source: AGHT+IE03+GLFOiYCtv0tW5oxF/oyJb6HtkdKUGHKboh4aC+T/4yDlCy2Erx7BwyTDTkHUDhKykO+A==
X-Received: by 2002:a2e:968e:0:b0:2e0:e410:28d5 with SMTP id
 q14-20020a2e968e000000b002e0e41028d5mr195041lji.52.1714495834937; 
 Tue, 30 Apr 2024 09:50:34 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 u2-20020a2e8442000000b002d8744903ebsm3873436ljh.68.2024.04.30.09.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:50:33 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v4 14/17] xen: Add xen_mr_is_memory()
Date: Tue, 30 Apr 2024 18:49:36 +0200
Message-Id: <20240430164939.925307-15-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240430164939.925307-1-edgar.iglesias@gmail.com>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x22e.google.com
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Add xen_mr_is_memory() to abstract away tests for the
xen_memory MR.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/xen/xen-hvm-common.c | 8 +++++++-
 include/sysemu/xen.h    | 8 ++++++++
 system/physmem.c        | 2 +-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 1627da7398..0267b88d26 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -12,6 +12,12 @@
 
 MemoryRegion xen_memory;
 
+/* Check for xen memory.  */
+bool xen_mr_is_memory(MemoryRegion *mr)
+{
+    return mr == &xen_memory;
+}
+
 void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
                    Error **errp)
 {
@@ -28,7 +34,7 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
         return;
     }
 
-    if (mr == &xen_memory) {
+    if (xen_mr_is_memory(mr)) {
         return;
     }
 
diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
index 754ec2e6cb..dc72f83bcb 100644
--- a/include/sysemu/xen.h
+++ b/include/sysemu/xen.h
@@ -34,6 +34,8 @@ void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
 void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
                    struct MemoryRegion *mr, Error **errp);
 
+bool xen_mr_is_memory(MemoryRegion *mr);
+
 #else /* !CONFIG_XEN_IS_POSSIBLE */
 
 #define xen_enabled() 0
@@ -47,6 +49,12 @@ static inline void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
     g_assert_not_reached();
 }
 
+static inline bool xen_mr_is_memory(MemoryRegion *mr)
+{
+    g_assert_not_reached();
+    return false;
+}
+
 #endif /* CONFIG_XEN_IS_POSSIBLE */
 
 #endif
diff --git a/system/physmem.c b/system/physmem.c
index ad7a8c7d95..1a5ffcba2a 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2227,7 +2227,7 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
          * because we don't want to map the entire memory in QEMU.
          * In that case just map the requested area.
          */
-        if (block->offset == 0) {
+        if (xen_mr_is_memory(block->mr)) {
             return xen_map_cache(block->mr, addr, len, lock, lock,
                                  is_write);
         }
-- 
2.40.1


