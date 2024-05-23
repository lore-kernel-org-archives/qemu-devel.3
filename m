Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64AC4C25B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHb5-0000KC-AY; Thu, 23 May 2024 19:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHaS-0006R4-Q4; Thu, 23 May 2024 19:11:06 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHaK-0006GI-QR; Thu, 23 May 2024 19:11:04 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6f8e9555eabso312075b3a.1; 
 Thu, 23 May 2024 16:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505855; x=1717110655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jio2aMib7y+e9zQwmFJ8d9w0bA9aBFqChyGcW4tINAw=;
 b=V7OHNY1Zhav9gEOn0ULmYwjX5SAO37WHTH3FhazuhyLvxMMXsCauw5xXbI+oDZJBYC
 +TWd4rAI9FqQZ/0JUCp0Alj2BRKJ3h0F4G8l57eIS65Yoz8gu1zruni/+friVHavomve
 JjH8x1abeT694T0GvbT8R2Uh7hG8MIEz3lNOpNHPaHh46QLqqsT8wDmykO7PzVR3J8B6
 ksMm1dZo14mBMsQtIdZgLjnA7EeZ8LocwnT9ldTfSKpK0qrIAtCTyg94n/fsErA1x3Ig
 or9a85ib3mHtMBcKb35UFJL3OYOY9KtIZ1M9Nq5j8D+DVRcSGOg2DIXacsnD7trWG9b4
 yKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505855; x=1717110655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jio2aMib7y+e9zQwmFJ8d9w0bA9aBFqChyGcW4tINAw=;
 b=qBTxeEwSldKNpmo9wjk0h4kDacwXoO/0nqjqt2D5dESqtSYgiUtcwFovhOboBctCU/
 u58Xi6sDba5VswEkzfKFkmSyfKq7V8J+7ffVCqXAAEZyEPPOa8pux9L/njV89/iVia3+
 LQHFTFQjdz3k1HcvZBgDHioafB7f+SoMlFaQY3f1fd5NDqzdWzCDPhU9T5wEnA/j/YaK
 6kAS069g89QwT+m5Ffe9BcbQ7PLN418MDXoSu/dKZM52IUf0tKmspfCh1uyLGEb89fFj
 oS/haWLZ0sbXBNVQ5egoU3QQKnzNSejdcn1MLuv7snX/bYa9VWOrdQ2kC/NtdBbXhqri
 l7Rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVG6BoAYRqyFXwuBqA9GHV+f80AgIAcBzapWGTV5esBkJutUU9dvzW0vFOh/NTk/TiG6rcLVG4vy9jZDoeRcroeNyvx
X-Gm-Message-State: AOJu0YxIeVTUguxWhwW1fCZTyYObOZ1qZFMluMhQJ1Y9q5uc2l/7/PN/
 8cWfIbCWgVF/O2+S1I4zdLVwgyNdLBdaiQVZIkLjjRvYKX9OWGVbEwIDnQ==
X-Google-Smtp-Source: AGHT+IGfYqfxEyxkKnFWaxP6qvq9SiCpJ4BKIV0D/3X5eG+DRqyqLrxC6ByS48y7Yu8EVCRZCIO+rQ==
X-Received: by 2002:a05:6a20:7483:b0:1a7:61f0:9ca9 with SMTP id
 adf61e73a8af0-1b212e57b20mr1037002637.58.1716505854671; 
 Thu, 23 May 2024 16:10:54 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:10:54 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 58/72] target/ppc/mmu_common.c: Remove BookE from direct store
 handling
Date: Fri, 24 May 2024 09:07:31 +1000
Message-ID: <20240523230747.45703-59-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

As BookE never returns -4 we can drop BookE from the direct store case
in ppc_jumbo_xlate().

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 004ea2111d..6c6c7c55b6 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -1298,12 +1298,7 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
             /* Direct store exception */
             /* No code fetch is allowed in direct-store areas */
             cs->exception_index = POWERPC_EXCP_ISI;
-            if ((env->mmu_model == POWERPC_MMU_BOOKE) ||
-                (env->mmu_model == POWERPC_MMU_BOOKE206)) {
-                env->error_code = 0;
-            } else {
-                env->error_code = 0x10000000;
-            }
+            env->error_code = 0x10000000;
             break;
         }
     } else {
-- 
2.43.0


