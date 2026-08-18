Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC7DC5DF7F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 02:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww9Tx-0007U9-T1; Mon, 17 Aug 2026 22:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1ww9Tr-0007Sr-V3
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 22:23:11 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1ww9Tp-0008K2-HQ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 22:23:11 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so3953191a91.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 19:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787019787; x=1787624587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mOzBRR9is3JNPkpZ9N3u/DPsGnfUKKhLAGdsvNZf0V8=;
 b=n54jiZcpLlhgRiKx/roMQFbHl6olZx5IP/ceYxlQ1Sus6gV9catXdI/9ELAkIPGN+m
 Pu/apd64tZHQLhcP8Tym5SWMZxB0CvEJ1XQqJvIJncK3f6yzLew0w304pqM+OsRA0hwp
 PrYbvNOXdOyTDG82RgVCf/D/wYad8cRqL20u+zvV4x0T0GfW28LdwioEZ87IByXpMI/k
 vmoRe8VwdUviSuQX6dO1GKGO1eKgE3np3Bx43IDZBXoFcyt85FAUwqzjMVtWbltM9i6I
 lsBmbfKZT+LFKuKi5OPE/AOByIQ3RFedvuga4v7vzUJ5nUxT1nzsutvd/ojmDDvLNCtW
 tRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787019787; x=1787624587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mOzBRR9is3JNPkpZ9N3u/DPsGnfUKKhLAGdsvNZf0V8=;
 b=f/HMMB9fN6a1wYfX/Vk1oIe+8oR3hol5bdhbvX6kKQDfN3bVU6kY4KXt6O+iBEsvFs
 5mss2HMHbHK4XSZ+XbLmrjnI8U0QRA02yK+yA5BkT7jwOLV4gYQwQzZfI+IlbZYxLCgF
 X6zxXo5dsgSnThbfPaDsPgBpHTWGYrAAGdLBdEXwa66aRmay962pyh1lWpGEWxnGBxaq
 /GRlrEpML+WQGFXuabBsO+lHNk1rgm0CKSU9jroZY/dwmuoDuRF8qePkMHcsSQ5r26nS
 3Ld9Phh/FLGPke3ZXSllCuL3hnADqa8XuhPx80ndExFpIV/4wKQ+LNkNT/F5j380Bcq2
 i6aw==
X-Gm-Message-State: AOJu0YxH6ZSJmU/8SZWCRqh65eWu0Nd9L/v4whAbvsINPJVzQzDD6EmE
 9Pi1V+PGf3QXF8pTX41ywNDoydpXW6tHr1M7uMKVBd5kld+RCI6fhktUUPmvEg==
X-Gm-Gg: AR+sD13+1QcfqMFAdSGt+Hj0//FQDSYdrNuy13RXHVBRDoJb35/ZLA0eGoCv7VRi4cQ
 qLSz2r+dsijhB2x0tm6unFbekRaVKGgDuxVowOv+5y4f31TLGARiO0DDkdHqioTPSiBXfjuT75K
 engCajenZfuyf8hzihKE2mHiQyC5imY2yLnKd8hOZO7EFMQ+UyLC4cgVMmGRFBoi/pfxdM8428z
 C85QzRBtWsCeymcmf65fG+ZbfCUlKSwqBfKtKjnkWuwXqd6vPYrB9LwiNFUsfuxLXj6Yjj2mXt2
 2O7xqDnwfjTLiwuuW2rq62WOkcXysI7v0mCVOPjKdR7P3FAAW0LGmJBHRpofd4WI9MQatte37SC
 cEOoRzhO7gXZjwqh9zXzNHU+pUUWubLb3dNZ0Q+1y8w8VAiwY9GQbOel04Wx6YermqQUmXgywbr
 0xbHf+Nu201Mlzn6hL+FQGTKlBZL9kPFRZmcaT8l2gJiTQLjmNB6EGe6wLorwBesVyNLzhf5Y9h
 1b6G4PzHkkpIks=
X-Received: by 2002:a17:90b:134f:b0:38f:de97:b06 with SMTP id
 98e67ed59e1d1-3933bf4aca5mr32441924a91.5.1787019787509; 
 Mon, 17 Aug 2026 19:23:07 -0700 (PDT)
Received: from newsled.lan ([76.133.142.170]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c389363sm10897816eec.23.2026.08.17.19.23.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Aug 2026 19:23:07 -0700 (PDT)
From: 54weasels <54weasels@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	54weasels <54weasels@gmail.com>
Subject: [PATCH v4 1/6] target/m68k: Add dummy CAAR register
Date: Mon, 17 Aug 2026 19:22:17 -0700
Message-ID: <20260818022225.31801-2-54weasels@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260818022225.31801-1-54weasels@gmail.com>
References: <20260818022225.31801-1-54weasels@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=54weasels@gmail.com; helo=mail-pj1-x1034.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

High level description:
The Sun-3 ROM expects the Cache Control Register (CAAR) to exist on the 68020. Reading/writing this register currently aborts QEMU. This patch provides a dummy implementation that simply ignores writes and returns 0 on reads, allowing the ROM to continue booting.

Impact on existing functionality:
No impact on existing targets. ColdFire and Mac targets do not access CAAR in a way that currently aborts, and providing a safe dummy implementation ensures robustness across M68k boards.

Context: This patch was originally submitted as part of the monolithic Sun-3 Machine Emulation series (https://patchew.org/QEMU/20260503015756.99176-1-54weasels@gmail.com/) and has been split into atomic components.
---
 target/m68k/helper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 5f91d206f5..68f523ea84 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -281,8 +281,10 @@ void HELPER(m68k_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
             return;
         }
         break;
-    /* Unimplemented Registers */
+    /* Dummy implementation for CAAR */
     case M68K_CR_CAAR:
+        return;
+    /* Unimplemented Registers */
     case M68K_CR_PCR:
     case M68K_CR_BUSCR:
         cpu_abort(env_cpu(env),
@@ -385,8 +387,10 @@ uint32_t HELPER(m68k_movec_from)(CPUM68KState *env, uint32_t reg)
             return env->mmu.ttr[M68K_DTTR1];
         }
         break;
-    /* Unimplemented Registers */
+    /* Dummy implementation for CAAR */
     case M68K_CR_CAAR:
+        return 0;
+    /* Unimplemented Registers */
     case M68K_CR_PCR:
     case M68K_CR_BUSCR:
         cpu_abort(env_cpu(env), "Unimplemented control register read 0x%x\n",
-- 
2.50.1 (Apple Git-155)


