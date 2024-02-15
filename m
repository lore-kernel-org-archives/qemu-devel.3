Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C548EC48BEF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 06:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raV6s-0002JL-GB; Thu, 15 Feb 2024 01:20:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV6o-0002If-4L
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:34 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV6m-0005OA-Ca
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:33 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d934c8f8f7so4643605ad.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 22:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707978031; x=1708582831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aaAlM/N1pdfPJQ0AFuX+476ixWIzFXGcl3gsIXYKRec=;
 b=brLrEsIZtnVmD+npeC2nKkYX1gQbDbr//W+t1wYWPhextsakKtpAapyxbEZZX5khM2
 MXa1l/kjVOBYFk5Gwz3HiGPzLZT9i3qATzbIm/KHSf6LGbJXWkXtdl95OzXwPVF+nxKU
 yHOGC8koBnJUWhOjfK8fiGixINQU0YcM7w3DAdort9T4rPM23lzV0yMVEFgBMDok1zLc
 FqO1Eq5+vEZ59isSatGIqcmSRjNUQwtw/cSSQ1oY/xHRTHtZY/Ifgc8RvqTHFiP432uT
 zyUDbWF1cXwEp/yNFYQ6mrw0MNqHNz9/VsFFTP9bnUEeTzjbwbUXQLqQPNXA/Fwa4Q4O
 Hdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707978031; x=1708582831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aaAlM/N1pdfPJQ0AFuX+476ixWIzFXGcl3gsIXYKRec=;
 b=cm+6vxFIKR19ZVkamPSThA9cpGrEU2rfX7W46hiDCNw/PDQ4C0JT7FbFKRwxjAXyht
 sW2xNu8GVzVXeYuDmq/u7HJ0oscjD6/IxnmbcXVTntF+gycBwjoqpGqRhUxqokUpGXkj
 pBe3ibVDO7SeN5hqzrRR1Aa1O4onANySrHiXGEUbr980Ppq5o2siun34J2Xz7JvYXs0Q
 xFTNmKhglJWhV/hVFWjKfW6WMzcJry05uUj8ECBCsSyCS0Uy//wJX9gbmJdeRvuBDV8w
 LDT7JrxxHbjgmXuaFOS57fTDEXKINUHVjIGhhXx6mxSOWMfxRGP7PCg335Zs4CaXnkb3
 tzTw==
X-Gm-Message-State: AOJu0YyilzGZZ2N087cVZMo3SaP6zVP1BRNzYuSK60sn26XCxIf9KQAP
 GONUm80ziF5IYA1uiCPQ6RVzhxQBcEJbDQ69qrgEKDO7H851EaacsMJJ+Qq3Vc7Y6H0tZ1uhs31
 J
X-Google-Smtp-Source: AGHT+IH8Y1NOkI8kLhzP7B7HnJUmHCcBQ91HRFeC5GpEFkzcsewaf5sbReCP2KRvRqHGl3JkTup3kg==
X-Received: by 2002:a17:902:e5c8:b0:1db:3592:a6a2 with SMTP id
 u8-20020a170902e5c800b001db3592a6a2mr844246plf.12.1707978031127; 
 Wed, 14 Feb 2024 22:20:31 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902b70500b001d6f29c12f7sm464418pls.135.2024.02.14.22.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 22:20:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v4 07/36] linux-user/arm: Remove qemu_host_page_size from
 init_guest_commpage
Date: Wed, 14 Feb 2024 20:19:49 -1000
Message-Id: <20240215062018.795056-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215062018.795056-1-richard.henderson@linaro.org>
References: <20240215062018.795056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Use qemu_real_host_page_size.
If the commpage is not within reserved_va, use MAP_FIXED_NOREPLACE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-8-richard.henderson@linaro.org>
---
 linux-user/elfload.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a9f1077861..f3f1ab4f69 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -460,6 +460,7 @@ enum {
 static bool init_guest_commpage(void)
 {
     ARMCPU *cpu = ARM_CPU(thread_cpu);
+    int host_page_size = qemu_real_host_page_size();
     abi_ptr commpage;
     void *want;
     void *addr;
@@ -472,10 +473,12 @@ static bool init_guest_commpage(void)
         return true;
     }
 
-    commpage = HI_COMMPAGE & -qemu_host_page_size;
+    commpage = HI_COMMPAGE & -host_page_size;
     want = g2h_untagged(commpage);
-    addr = mmap(want, qemu_host_page_size, PROT_READ | PROT_WRITE,
-                MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+    addr = mmap(want, host_page_size, PROT_READ | PROT_WRITE,
+                MAP_ANONYMOUS | MAP_PRIVATE |
+                (commpage < reserved_va ? MAP_FIXED : MAP_FIXED_NOREPLACE),
+                -1, 0);
 
     if (addr == MAP_FAILED) {
         perror("Allocating guest commpage");
@@ -488,12 +491,12 @@ static bool init_guest_commpage(void)
     /* Set kernel helper versions; rest of page is 0.  */
     __put_user(5, (uint32_t *)g2h_untagged(0xffff0ffcu));
 
-    if (mprotect(addr, qemu_host_page_size, PROT_READ)) {
+    if (mprotect(addr, host_page_size, PROT_READ)) {
         perror("Protecting guest commpage");
         exit(EXIT_FAILURE);
     }
 
-    page_set_flags(commpage, commpage | ~qemu_host_page_mask,
+    page_set_flags(commpage, commpage | (host_page_size - 1),
                    PAGE_READ | PAGE_EXEC | PAGE_VALID);
     return true;
 }
-- 
2.34.1


