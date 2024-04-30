Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0DDC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qgo-0007Jw-Gv; Tue, 30 Apr 2024 12:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgc-0006Qv-Ne
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:50:37 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgY-00062m-BI
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:50:32 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-51c077cfc09so7022071e87.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714495828; x=1715100628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j0mqQo2QzUWZGYHpYGMWslGBm8Oap0E4Z0qNuGo27BE=;
 b=R4R+riu6gcSBuWO7Dgjrh6Vb2Z3Meec/GS/vh+1BU+MFkVAj1QdHMMtXwCp75S/sLm
 IeHNnvQsXjLams01u8PzlLZ+IRG7xDLAxf0dY8dP7tejgjh33QDqhajsWUH1qGz8NEGK
 pagSsgruDDJwYYb+bU/xsBQ/X1FXmAu8BoYXytd1MnpIx4JKXna5Ycou4uZmu03zG5X0
 /h3D5kzI6q+c9ILpgWXtlYwnbSTZhXyOSSXHBhPi+/1jIoOad7+hP4X7H6MtdwkE4upm
 vqCL+edBpUl26LdXwn6os5SaUN/IzPgyuQY168h4ZESqioYBF9YVw/45Mmbf8d4BpLSH
 Brpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495828; x=1715100628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j0mqQo2QzUWZGYHpYGMWslGBm8Oap0E4Z0qNuGo27BE=;
 b=jnLWEomAqyvXzsfbW7fdUf7Pncm5Xi65TZqNbi1PrJm2F8GCbvjClsAJJWj4qidkgu
 2Wgl7Gvvekbj/T7II0dnzUdpjsCyvL/lYs+o4emOoZ3FYTYUgWFEZJRDhVXrswKOe+T8
 AeOpKsAlxDvlGh38wOwg63UZDuxay38OgCuTLr8Dj8SWCZ2V0UflPbzjDZWNhJyLBOU6
 4Gz+PNGmprmIpAcETof4MbLeE2RZyPSrSddUW5+7kz1adUWwIEIIGBEOOlozolczAwCL
 kh1hGBsB2D71V9xyMsJSm8JRnoQVJA8d9lcO4D/kd7jCjsiMSzYzjvpkB+pitTWWyeYg
 v4Sw==
X-Gm-Message-State: AOJu0YznPcJzi/qJ3yIFFPuyUomw5vyWCsJmv/w0Rt82QefRsVspW2zV
 /Mcx3w43IKTLpC1Nf+vrMe0lB4/hQwG0yiJbMQdwQQBCVIZTHvBGQrGx1pnl
X-Google-Smtp-Source: AGHT+IGQCPL9JgHmD1RLCqV4syaus5YjfpEwlBgT76+qyDY37l2dNAYgiSCfXBlfwOjb2G8RuoFmJQ==
X-Received: by 2002:ac2:4c4e:0:b0:51d:1830:8380 with SMTP id
 o14-20020ac24c4e000000b0051d18308380mr58334lfk.8.1714495827628; 
 Tue, 30 Apr 2024 09:50:27 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a196a11000000b0051aaffe4f1dsm4252114lfu.79.2024.04.30.09.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:50:26 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v4 10/17] xen: mapcache: Break out xen_map_cache_init_single()
Date: Tue, 30 Apr 2024 18:49:32 +0200
Message-Id: <20240430164939.925307-11-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240430164939.925307-1-edgar.iglesias@gmail.com>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12f.google.com
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

Break out xen_map_cache_init_single() in preparation for
adding multiple map caches.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/xen/xen-mapcache.c | 53 ++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index dd08cd296b..72a7e25e3e 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -93,23 +93,44 @@ static inline int test_bits(int nr, int size, const unsigned long *addr)
         return 0;
 }
 
-void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
+static MapCache *xen_map_cache_init_single(phys_offset_to_gaddr_t f,
+                                           void *opaque,
+                                           unsigned long max_size)
 {
     unsigned long size;
-    struct rlimit rlimit_as;
+    MapCache *mc;
+
+    mc = g_new0(MapCache, 1);
+
+    mc->phys_offset_to_gaddr = f;
+    mc->opaque = opaque;
+    qemu_mutex_init(&mc->lock);
+
+    QTAILQ_INIT(&mc->locked_entries);
 
-    mapcache = g_new0(MapCache, 1);
+    mc->max_mcache_size = max_size;
 
-    mapcache->phys_offset_to_gaddr = f;
-    mapcache->opaque = opaque;
-    qemu_mutex_init(&mapcache->lock);
+    mc->nr_buckets =
+        (((mc->max_mcache_size >> XC_PAGE_SHIFT) +
+          (1UL << (MCACHE_BUCKET_SHIFT - XC_PAGE_SHIFT)) - 1) >>
+         (MCACHE_BUCKET_SHIFT - XC_PAGE_SHIFT));
 
-    QTAILQ_INIT(&mapcache->locked_entries);
+    size = mc->nr_buckets * sizeof(MapCacheEntry);
+    size = (size + XC_PAGE_SIZE - 1) & ~(XC_PAGE_SIZE - 1);
+    trace_xen_map_cache_init(mc->nr_buckets, size);
+    mc->entry = g_malloc0(size);
+    return mc;
+}
+
+void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
+{
+    struct rlimit rlimit_as;
+    unsigned long max_mcache_size;
 
     if (geteuid() == 0) {
         rlimit_as.rlim_cur = RLIM_INFINITY;
         rlimit_as.rlim_max = RLIM_INFINITY;
-        mapcache->max_mcache_size = MCACHE_MAX_SIZE;
+        max_mcache_size = MCACHE_MAX_SIZE;
     } else {
         getrlimit(RLIMIT_AS, &rlimit_as);
         rlimit_as.rlim_cur = rlimit_as.rlim_max;
@@ -119,24 +140,14 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
                         " memory is not infinity");
         }
         if (rlimit_as.rlim_max < MCACHE_MAX_SIZE + NON_MCACHE_MEMORY_SIZE) {
-            mapcache->max_mcache_size = rlimit_as.rlim_max -
-                NON_MCACHE_MEMORY_SIZE;
+            max_mcache_size = rlimit_as.rlim_max - NON_MCACHE_MEMORY_SIZE;
         } else {
-            mapcache->max_mcache_size = MCACHE_MAX_SIZE;
+            max_mcache_size = MCACHE_MAX_SIZE;
         }
     }
 
+    mapcache = xen_map_cache_init_single(f, opaque, max_mcache_size);
     setrlimit(RLIMIT_AS, &rlimit_as);
-
-    mapcache->nr_buckets =
-        (((mapcache->max_mcache_size >> XC_PAGE_SHIFT) +
-          (1UL << (MCACHE_BUCKET_SHIFT - XC_PAGE_SHIFT)) - 1) >>
-         (MCACHE_BUCKET_SHIFT - XC_PAGE_SHIFT));
-
-    size = mapcache->nr_buckets * sizeof (MapCacheEntry);
-    size = (size + XC_PAGE_SIZE - 1) & ~(XC_PAGE_SIZE - 1);
-    trace_xen_map_cache_init(mapcache->nr_buckets, size);
-    mapcache->entry = g_malloc0(size);
 }
 
 static void xen_remap_bucket(MapCache *mc,
-- 
2.40.1


