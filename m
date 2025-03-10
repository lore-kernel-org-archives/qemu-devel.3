Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A5FC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 20:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trjrX-0001FX-Vs; Mon, 10 Mar 2025 16:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3SU3PZwcKCmYOSQPSHMKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--komlodi.bounces.google.com>)
 id 1trjrT-0001DL-0O
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 16:36:32 -0400
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3SU3PZwcKCmYOSQPSHMKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--komlodi.bounces.google.com>)
 id 1trjrR-000120-42
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 16:36:30 -0400
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-2ff5296726fso13669535a91.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 13:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1741638985; x=1742243785; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=HcIbczbXWzXmssnolrGy2c9QlvIETBPe2l1e01JG0+0=;
 b=F66jqR7duSafR5+6Uf0QU3ZUwFi9jf/E1kXax9z4NVKbBgNIx41uX/B2ySErhjfKu9
 751nIP99mlA0ijFk4qAhHwVHDJNFhdYTiWyEuz3YOBPLr1t7q8zGm1A4LXn+8vWlRODs
 IC0Oroq4yU3obi0lT9k5pSvPZWxjfRsU0rK1Hr8dyK1yCEsnGDdBHLMRnL2bvjfd7zk1
 MmQc8Wo+E8kctPiiHKihai8hSCdgjXtP0g8oivzoBhOIWMD9LZgFgSNajVxQL6D4uCKc
 svvHhGPFSi5F2iSpZp40pvNfccx8jNXAQfaghLBIXlJE7uI1PsebR7ZlYnyv+LV1od6K
 rdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741638985; x=1742243785;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HcIbczbXWzXmssnolrGy2c9QlvIETBPe2l1e01JG0+0=;
 b=VnE6V8FwXSQo+p79OcrIRkn+sXLeGmEPIz7vAH9Soirn0qq+FEXORrhM57R8JbDQWP
 ku0fmbbrmzjcjb4QGA6afGpIwVSoyHLBNNkLOmMpZoTBFo434aW9WQMjbJ2fFmEyrLQG
 M8W5j65si8ExgRVbCk9YS/QAovsT+D6A1wqwRFI9GA+4jT4gWmXD0um0cvi35QfpObKn
 +g3FGDDY+uoCiQsPdIhQFhHQRDbm2Y1d+lILjW9NAhLL/RKSKMNEa2Og12YhTCrH5NBJ
 FDd7rKfGk9IS5E0M2J7rwhopVBnBabnm5kYjXuOer+ADNjXyzkuEgXPUZkWqm0p6JtVu
 hiVQ==
X-Gm-Message-State: AOJu0YzKGlL1hnmiWYV8Dj7zyt67+p/+f8DCuSa9fzPQUTR4ULAgJEw6
 HaHLrk6kRZBTTZqFyZl7MiHSKVGArAfKWAHnRljiWwXwtDj2HIAoswQrFpLnkonfJsUrJL4iFAE
 Nzmud5H2oMVUlhwDTXftxRTrRI4NCf+TSyukczgfksFzLoTkarmrHIvzEStT5dPS3nBS+mTNoyy
 GNrOZeRzuRbCN0XUkqMycIiC69+6utsgFDSGPy
X-Google-Smtp-Source: AGHT+IFPU9A1OiqpmILP3O9ls7mns7jcrCnRnFA+8mh3z+80Fp3XTqxC8LJkcM0ImSqskmKfmSq6O6BhUOMM
X-Received: from pjqx5.prod.google.com ([2002:a17:90a:b005:b0:2ff:852c:ceb8])
 (user=komlodi job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:17c2:b0:2ff:4bac:6f9c
 with SMTP id 98e67ed59e1d1-2ff7cf144a4mr22535453a91.28.1741638985285; Mon, 10
 Mar 2025 13:36:25 -0700 (PDT)
Date: Mon, 10 Mar 2025 20:36:22 +0000
In-Reply-To: <20250310203622.1827940-1-komlodi@google.com>
Mime-Version: 1.0
References: <20250310203622.1827940-1-komlodi@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250310203622.1827940-2-komlodi@google.com>
Subject: [PATCH 1/1] util/cacheflush: Make first DSB unconditional on aarch64
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: slongfield@google.com, richard.henderson@linaro.org, pbonzini@redhat.com, 
 komlodi@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3SU3PZwcKCmYOSQPSHMKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--komlodi.bounces.google.com;
 helo=mail-pj1-x1049.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On ARM hosts with CTR_EL0.DIC and CTR_EL0.IDC set, this would only cause
an ISB to be executed during cache maintenance, which could lead to QEMU
executing TBs containing garbage instructions.

This seems to be because the ISB finishes executing instructions and
flushes the pipeline, but the ISB doesn't guarantee that writes from the
executed instructions are committed. If a small enough TB is created, it's
possible that the writes setting up the TB aren't committed by the time the
TB is executed.

This function is intended to be a port of the gcc implementation
(https://github.com/gcc-mirror/gcc/blob/85b46d0795ac76bc192cb8f88b646a647acf98c1/libgcc/config/aarch64/sync-cache.c#L67)
which makes the first DSB unconditional, so we can fix the synchronization
issue by doing that as well.

Signed-off-by: Joe Komlodi <komlodi@google.com>
---
 util/cacheflush.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/util/cacheflush.c b/util/cacheflush.c
index a08906155a..1d12899a39 100644
--- a/util/cacheflush.c
+++ b/util/cacheflush.c
@@ -279,9 +279,11 @@ void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
         for (p = rw & -dcache_lsize; p < rw + len; p += dcache_lsize) {
             asm volatile("dc\tcvau, %0" : : "r" (p) : "memory");
         }
-        asm volatile("dsb\tish" : : : "memory");
     }
 
+    /* DSB unconditionally to ensure any outstanding writes are committed. */
+    asm volatile("dsb\tish" : : : "memory");
+
     /*
      * If CTR_EL0.DIC is enabled, Instruction cache cleaning to the Point
      * of Unification is not required for instruction to data coherence.
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


