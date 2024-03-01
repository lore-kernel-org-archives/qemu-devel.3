Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93576C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgByP-0005pW-VJ; Fri, 01 Mar 2024 18:07:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgByD-0005bq-AB
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:13 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgByA-0004Kj-RM
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:13 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1dc0d11d1b7so24579105ad.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334428; x=1709939228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dE6xy9+D6Je1Etl+ajN+bavVnxpk9B7ygAyJhkrFQtk=;
 b=jKNIjDiAMSZSHITBlHFWCnByQx0mVTEYaZV7mUdikYm9dIdsfGWkSzYdfHQrLopoS6
 UGH7WtJtfV1Y7Zy2V/mTMjgk9huD8oA5a7UWOw+nNQpEQF+kRX1wyRz3Kse/Uh6uRIqV
 w2yJeXWzXT2jbkYmnHykXExGsNh0sesvEX+c21dxS0ExX+Jvlmk7Gk5QeoLWaoBdqD0Y
 JlXz2/cwWk4fmnvT6NSyOc9s5uH+O5GIEtIAAdTy+rCru7iCGETlrYkADrK3plJH0Odd
 XiAmGCkK0Edtkos7z3QuvwZzO/qrmthLUK1AeW6gxNf5Y6M70d2pbxZ27C26/XN1EAsl
 YnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334428; x=1709939228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dE6xy9+D6Je1Etl+ajN+bavVnxpk9B7ygAyJhkrFQtk=;
 b=asWkaAyiWaNXRq2Uiml9EbbvCsYWeJO6aimXRAlAn1OyUs3zoxY7ieJ4BV7Hm71IB4
 1V9Yn7c3CeK1sW912blEgJl7g88SUFO+wQTR3A8kIZif581YsDT0oFKKyQ1cQcG+TQkF
 MYccGK0PBUXg5a3zNYxy8Ffq9WDpzcCtU0ITh/PXai4zsrC/QpDGj6ciJHPDH0G8y8tp
 PsJhJQfLcQ2rtGG//n5nyn7s9UfmPrn7HfzMyrqs+8d+bJQHv7iQiuHnel3cISZUfU8e
 MliMNOIybZN8EV1ahhUYDfXhdR/Ej4wF6JWiefkJZeLASP+ndfoJ3VY/zrKE5v0/Gtzf
 iZxg==
X-Gm-Message-State: AOJu0Yz7LGosYR3bICi+B8ounHi9XTNq17HbUJdGeEnXLuhps2Ds6apN
 zHmR+ZcyR5sNybyLVDVreXiJ1OtH9FdW8mgAabjBJGnLT5Alq1xrv0y9L3WWl4hWCcjVReudsc3
 b
X-Google-Smtp-Source: AGHT+IGnsfKbVMZjDFy3Hpmi7CXBzXfGAxjs5zZXbk2yfGbGeBlVo5bfcjpHQeL2at5YMUEt2cEOIw==
X-Received: by 2002:a17:902:e5cb:b0:1dc:26a1:da26 with SMTP id
 u11-20020a170902e5cb00b001dc26a1da26mr3323977plf.30.1709334428012; 
 Fri, 01 Mar 2024 15:07:08 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:07:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 32/60] softmmu/physmem: Remove HOST_PAGE_ALIGN
Date: Fri,  1 Mar 2024 13:05:51 -1000
Message-Id: <20240301230619.661008-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Align allocation sizes to the maximum of host and target page sizes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-15-richard.henderson@linaro.org>
---
 system/physmem.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 3b08e064ff..3adda08ebf 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1680,7 +1680,8 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
 
     assert(block);
 
-    newsize = HOST_PAGE_ALIGN(newsize);
+    newsize = TARGET_PAGE_ALIGN(newsize);
+    newsize = REAL_HOST_PAGE_ALIGN(newsize);
 
     if (block->used_length == newsize) {
         /*
@@ -1916,7 +1917,9 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
         return NULL;
     }
 
-    size = HOST_PAGE_ALIGN(size);
+    size = TARGET_PAGE_ALIGN(size);
+    size = REAL_HOST_PAGE_ALIGN(size);
+
     file_size = get_file_size(fd);
     if (file_size > offset && file_size < (offset + size)) {
         error_setg(errp, "backing store size 0x%" PRIx64
@@ -2014,13 +2017,17 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
 {
     RAMBlock *new_block;
     Error *local_err = NULL;
+    int align;
 
     assert((ram_flags & ~(RAM_SHARED | RAM_RESIZEABLE | RAM_PREALLOC |
                           RAM_NORESERVE)) == 0);
     assert(!host ^ (ram_flags & RAM_PREALLOC));
 
-    size = HOST_PAGE_ALIGN(size);
-    max_size = HOST_PAGE_ALIGN(max_size);
+    align = qemu_real_host_page_size();
+    align = MAX(align, TARGET_PAGE_SIZE);
+    size = ROUND_UP(size, align);
+    max_size = ROUND_UP(max_size, align);
+
     new_block = g_malloc0(sizeof(*new_block));
     new_block->mr = mr;
     new_block->resized = resized;
-- 
2.34.1


