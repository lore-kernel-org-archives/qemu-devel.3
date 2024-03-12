Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D83C54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 20:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk8XG-0001pj-Uc; Tue, 12 Mar 2024 16:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rk8Wv-0001mI-Cg
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:15:23 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rk8Wt-0001Mc-5O
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:15:21 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33e99915809so2055311f8f.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 13:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710274517; x=1710879317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5VoQ8jbg5bbRds0jLIlJJfwZ5fmmJeECGQ91KyYNz/g=;
 b=rKETponaFzRC8+kBF7YBsdIkyS5kKPzzum7bP5Y19LVOwn7nBARbw2MHzoicwA0jue
 iwjjTjr1Jtp7iwB3OVo4wsbqnovyx44OKihBTubA7V4BXyw1KG4vWTcNZj8Hl00SoGQB
 VaCY/kbSBkjQGsU3YdHIHhITZRz9gbEUsLt82P+c24Ajz6Be9fM0astTkbhxM9Yy0VX4
 +bpaRUGxfAGZiSGNkDjOeffT4bBIDyZOsxGMlyaOzt/e7LOUOh0E4daogCgSNyq1dF2Y
 /LhPKWFjixWsPxb4aK44y/2jbUoRDZBC2ydP1LTStIEspOT6eZGVZMm9w7Cj1YKjHEP/
 0skg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710274517; x=1710879317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5VoQ8jbg5bbRds0jLIlJJfwZ5fmmJeECGQ91KyYNz/g=;
 b=HqDVlWwjacHQuE0wZSqYrM1o5/WKsCQ9QBxl5uCkY7+XJhzXhS26tHX+RfOQJ0fX4b
 Bf6FF3e+1gX99B/1aQP8H/DR4s7Nvxf0qziZCNploXDhcQL+iHKQ9sHTLH3g49JB3Ucg
 uc0Z6sNSoZ+lcYJ7nJo/fMlMrvhY/X/v///K/ARRCEECMBHzfJjN8K0GgGb2qNa1FyN1
 EBw9BW99fxnAWpckWkDIpUJKq1nzRTwiKfTiMiBLqu7MnWjvPy4wF3Ve0Pzv/9ugEpXd
 yWVH7+j0G1V/jOtKChEE1iuYmBbbWZu2Q3BLU/3viUIzeQkuCx1cT7GD7hgICcBrwSHt
 IFRw==
X-Gm-Message-State: AOJu0YzCG+jVOpeYcpvXzptTr/kkMsf6grJV55T3p9sd4NNnzzJK8Mj1
 rNW1Md2SrqrahUtC4CEbxUgEAsyLmE9YIgPKDL2ToXkjqvRVLVnOZ3EJtXnLPJCxUR6DGKcL+IX
 RZus=
X-Google-Smtp-Source: AGHT+IElaKif+3ChcwUCGbXYBrPWPfKAPU/jcNwH7bbYt2kQ56Pxb/vMmdSpXJ/YtTswgyKmmIQncg==
X-Received: by 2002:adf:f305:0:b0:33e:7f5c:7a9c with SMTP id
 i5-20020adff305000000b0033e7f5c7a9cmr381053wro.35.1710274517042; 
 Tue, 12 Mar 2024 13:15:17 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.139])
 by smtp.gmail.com with ESMTPSA id
 z4-20020adff744000000b0033e7910ae23sm9819864wrp.49.2024.03.12.13.15.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Mar 2024 13:15:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 v2 2/3] physmem: Factor
 cpu_physical_memory_dirty_bits_cleared() out
Date: Tue, 12 Mar 2024 21:14:57 +0100
Message-ID: <20240312201458.79532-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240312201458.79532-1-philmd@linaro.org>
References: <20240312201458.79532-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240219061731.232570-1-npiggin@gmail.com>
[PMD: Split patch in 2: part 1/2]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/ram_addr.h | 9 +++++++++
 system/physmem.c        | 8 +++-----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 90676093f5..b060ea9176 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -25,6 +25,7 @@
 #include "sysemu/tcg.h"
 #include "exec/ramlist.h"
 #include "exec/ramblock.h"
+#include "exec/exec-all.h"
 
 extern uint64_t total_dirty_pages;
 
@@ -443,6 +444,14 @@ uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
 }
 #endif /* not _WIN32 */
 
+static inline void cpu_physical_memory_dirty_bits_cleared(ram_addr_t start,
+                                                          ram_addr_t length)
+{
+    if (tcg_enabled()) {
+        tlb_reset_dirty_range_all(start, length);
+    }
+
+}
 bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
                                               ram_addr_t length,
                                               unsigned client);
diff --git a/system/physmem.c b/system/physmem.c
index 5441480ff0..a4fe3d2bf8 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -881,8 +881,8 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
         memory_region_clear_dirty_bitmap(ramblock->mr, mr_offset, mr_size);
     }
 
-    if (dirty && tcg_enabled()) {
-        tlb_reset_dirty_range_all(start, length);
+    if (dirty) {
+        cpu_physical_memory_dirty_bits_cleared(start, length);
     }
 
     return dirty;
@@ -929,9 +929,7 @@ DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty
         }
     }
 
-    if (tcg_enabled()) {
-        tlb_reset_dirty_range_all(start, length);
-    }
+    cpu_physical_memory_dirty_bits_cleared(start, length);
 
     memory_region_clear_dirty_bitmap(mr, offset, length);
 
-- 
2.41.0


