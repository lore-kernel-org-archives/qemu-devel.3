Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17E5C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgByB-0005Xe-4n; Fri, 01 Mar 2024 18:07:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBy5-0005GP-JN
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:06 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBy4-0004JU-2c
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:05 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1dca8b86ee7so25633895ad.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334422; x=1709939222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K5KQN5vcI0KBxXe8ErUYFGLj7ZU4KIuwkr3avJe+C4E=;
 b=MkwIIK/hIwNe3EivDUniCDfh/yvahtYbkCUjNJM3FMw71NbcP2T6BVUHaP6JjCG4r6
 SqmCYQALDc+sSo4sd6v/oh8aJA19DGMHAOTKgd8GeHHa/mSvZnzcwDJ+CfVNTSwsTyjp
 Zq+BAn3aSgKsrRl7/gfyj6x71NPUa8BQgTXrcMwbJP1X5CPI4IPLdxVSgFDhzzcvGPCO
 ZpWwACjpU4y59LSDMorz0WSazWIyn3QgwVU5Pg6mHHZq4Vo2FltEz5cvBnDTnLlEQW9S
 u+/RldH1FcWYJINLaQ3Z7g5e5701udbk8xZ9q6OiJiadAslGQeFcYOf+Mp5tMzalzSMt
 2G5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334422; x=1709939222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K5KQN5vcI0KBxXe8ErUYFGLj7ZU4KIuwkr3avJe+C4E=;
 b=ISMjJ7XhXSxwUAiKGmuE/HWE7Ok2fDYFQGfRHCMuxCTZ8vHx1/nHU9AIdJ80+9IfuW
 b3t9EdIZ43p0YYSOYK27q+LbkwEft+R3QBII4pXNYaVyR7r8eIPsAM7Tk9SBo+49uQYW
 A4SfLTMfEfrwBeVin6selK4mVM4IBM9VAYXyxm9yaLDwU5iRjbyowwbH9+6kSM39s2uP
 xQ2AO60w21XLlblLUQ2tA7zXdMPL5dCjb3GgHPY6+QrV8/EXIkFk/1AMXH8tbGw32W52
 rJ1i8lmNh9i+q5vzy+M9D7lMc4hXtOCmMne1BzSDQ7et7WJsYppABoEunACFO2avRNto
 ga1g==
X-Gm-Message-State: AOJu0YxDZ0/PxSylqD235vSpBbyn6rT/+afm9N1a8GkU4tw9/d86/KMl
 S6YcXJ4f9vGFmpLqNpERfo1mPGnifC5CPk7xPwfvbljEAjYrsCBYdE8iFhfeYlo50ycz/BVA1LX
 i
X-Google-Smtp-Source: AGHT+IGmPx4UPkLIUdmegsfgoHP920HDGlgG5H2hJdEjF1ZIxG2jo+xYVxZujmckUxYVi3eF0nxMwA==
X-Received: by 2002:a17:902:868f:b0:1dc:a82f:c6cb with SMTP id
 g15-20020a170902868f00b001dca82fc6cbmr2864710plo.16.1709334421828; 
 Fri, 01 Mar 2024 15:07:01 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:07:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH 28/60] linux-user: Remove HOST_PAGE_ALIGN from mmap.c
Date: Fri,  1 Mar 2024 13:05:47 -1000
Message-Id: <20240301230619.661008-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

This removes a hidden use of qemu_host_page_size, using instead
the existing host_page_size local within each function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-11-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 53e5486cc8..d11f758d07 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -191,7 +191,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
 
     last = start + len - 1;
     host_start = start & -host_page_size;
-    host_last = HOST_PAGE_ALIGN(last) - 1;
+    host_last = ROUND_UP(last, host_page_size) - 1;
     nranges = 0;
 
     mmap_lock();
@@ -389,8 +389,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
         start &= -host_page_size;
     }
     start = ROUND_UP(start, align);
-
-    size = HOST_PAGE_ALIGN(size);
+    size = ROUND_UP(size, host_page_size);
 
     if (reserved_va) {
         return mmap_find_vma_reserved(start, size, align);
@@ -550,7 +549,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
      */
     if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
         host_len = len + offset - host_offset;
-        host_len = HOST_PAGE_ALIGN(host_len);
+        host_len = ROUND_UP(host_len, host_page_size);
         start = mmap_find_vma(real_start, host_len, TARGET_PAGE_SIZE);
         if (start == (abi_ulong)-1) {
             errno = ENOMEM;
@@ -595,7 +594,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         void *p;
 
         host_len = len + offset - host_offset;
-        host_len = HOST_PAGE_ALIGN(host_len);
+        host_len = ROUND_UP(host_len, host_page_size);
         host_prot = target_to_host_prot(target_prot);
 
         /* Note: we prefer to control the mapping address. */
@@ -625,7 +624,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             goto fail;
         }
         last = start + len - 1;
-        real_last = HOST_PAGE_ALIGN(last) - 1;
+        real_last = ROUND_UP(last, host_page_size) - 1;
 
         /*
          * Test if requested memory area fits target address space
@@ -794,7 +793,7 @@ static int mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
 
     last = start + len - 1;
     real_start = start & -host_page_size;
-    real_last = HOST_PAGE_ALIGN(last) - 1;
+    real_last = ROUND_UP(last, host_page_size) - 1;
 
     /*
      * If guest pages remain on the first or last host pages,
-- 
2.34.1


