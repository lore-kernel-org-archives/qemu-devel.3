Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0E8C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFv7-00078c-9K; Thu, 22 Feb 2024 15:43:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFv3-00075k-1z
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:49 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFv1-0002ej-El
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:48 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1dc3b4b9b62so2023715ad.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634626; x=1709239426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K5KQN5vcI0KBxXe8ErUYFGLj7ZU4KIuwkr3avJe+C4E=;
 b=H+ajFqd8obqTtbx1c/AzI2RPKxqKppZdW00DkdCHHyrdNkPmkzf3BoEGmjRoZEfEKt
 t9U4cGjvWedxF9X2VY6q0Fvua1+xGsgfNHjPAFctB8t+88U3KonDaxe0R8aJx2nyzEQ/
 /URlWTBzVhOH8gv1+/l/68MpoNLcjdZBIfzdro1B/wKXp43tUf1Me8FeachzukFflsU3
 3rgPv41MKzE1zT4ZVJ0LxPHAoC+dbObFCM6Z2fOmLfoFMuwA4T9km4367hbC9HLod/QV
 7D2sU7K1ZC4zIeIYxZJ4XVPlENG+K8rLGU8FkHhs5FVDFmx61PxNIOI3ZnN2L/5hETAX
 /IiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634626; x=1709239426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K5KQN5vcI0KBxXe8ErUYFGLj7ZU4KIuwkr3avJe+C4E=;
 b=jrYKosyfjTPMFh9PdqDc2mFe3a9BaMxSTh7TDRnANCNx27WfqUjjIYtsB5YJM8rpZa
 bR6uNd/6vACPIAotd0szQffwLean65WT5oyu4ie+mweyAgT70AQc9VEUMk6kYDVQJ/Yf
 8LXhri4yOMY2v20nJQs8yYo1e+np88My344v2gJJZnUgvKRlNqF2ImsDaWSa707SU7cr
 TzTH8deELNOzglVya4T7xxXrsK6TtWujClZGZ/iIiuVrxwFDSevI7VGQRJr8MG7LHXgR
 PT5JEcxNqOIp+OvQDEZ6J8gg6QSZ9PTQ2x2NNhcSIoS0c3gq1K+GEM8kSH2H/K+SnnfY
 e2gw==
X-Gm-Message-State: AOJu0Yz6MTpRrsfhdJDxXLcG78cyQv1nBvblHWrku3TrQ+OtMeKeXFZ/
 3nLb+CSuEjvzyJbDH1goHJJftEsWB+aia13598jHm9voBbTnMuzqjSiuaE5NiheVjVCnzWf7I89
 n
X-Google-Smtp-Source: AGHT+IFLfX0qbOK2LVfyUGGMQGn+LI4ZclT0Y6JaNDcP2mfDam5Vq3nk774ZD7BMOS8Qvpc6jVcIiA==
X-Received: by 2002:a17:902:da92:b0:1db:f15c:85c0 with SMTP id
 j18-20020a170902da9200b001dbf15c85c0mr171752plx.33.1708634626133; 
 Thu, 22 Feb 2024 12:43:46 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:43:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PULL 13/39] linux-user: Remove HOST_PAGE_ALIGN from mmap.c
Date: Thu, 22 Feb 2024 10:42:57 -1000
Message-Id: <20240222204323.268539-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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


