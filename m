Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58E8C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8MU-00028a-0k; Thu, 25 Jul 2024 19:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8MM-0001ef-Sf; Thu, 25 Jul 2024 19:58:59 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8ML-0001fk-Ec; Thu, 25 Jul 2024 19:58:58 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-70d1cbbeeaeso375307b3a.0; 
 Thu, 25 Jul 2024 16:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951935; x=1722556735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VMeUiHf68KsJmdI1qVGwzwaKutQ9d/38fka2AeA1vgI=;
 b=RvuqCREdkAORZ9HTB0l5++9KMsJ69tin/rY1TVJseXMeKpvhTXW1NfF3JGmkLGLQMq
 SRhdWtYsHze/QSf74XNkYG+LUdI1B/IwJqo88IkW7kJiZSYBb/3ikOQJg5MEinRG33Lj
 FHKywrZpA6wL8Vd8+jNpJLRKohMNJtWb0TdxfCNGVGOkM7V2DzoMD9rnF99uJPsQHOwc
 oiBhDhYaO5pHUG9nXVls4NOqGgxxNBQM8ns/DMi6nXIYTznkhdQgYNkATuiTpy09sYh7
 d5uggFfJUozYZpPZMnGwv9n3ogmVwJtBfyxlMJRDn0gyjg8AMJ83Cj6PTyJVt9iUyghL
 tbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951935; x=1722556735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VMeUiHf68KsJmdI1qVGwzwaKutQ9d/38fka2AeA1vgI=;
 b=t/Q1CqdXWD9BLB8P0sTutEaIW7ExIuN8iyAysmDOAZ9s1fIz5vhUE4BIv9TzwDxmqN
 bDZ6WMD+NxPddqPjrmvYkM8xVEf1l1gV1IW4P9wX69hQxwjJXk+GI33TNDcIFXTGobqT
 iQzGwdJKWX+5dFV1S3vpkwdjrFPiCQZ4zhp1mqwA8odldDT/qPzmOZ0ejANRKxdqg14V
 dqvU7oNV5kO+WPZuiPHN7wntFhMnAva+1BLFXhwB3MNPQglftOwswI4CHjwHbW7zhZeJ
 nhyerod0MXB2A6pcMTo5ezn90CDDLtfNJ0v8YyxW7rDlXGHDDHBH+sB9X5Q9Hd2VwkU2
 kCUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwL852dMNQsOVS3Z/hxf54FViaPWTONiCC2Yd8Dk8fWL55PqvkIZ7FMG6CBynoPf1MqcS6xfO7MhV9NWocAOI6O6E3
X-Gm-Message-State: AOJu0YwsdomYWBO3pGM91DYDklTopZ/oY+D5l7TIoNdxBqsa6bMv7DUL
 Q7CayXyXyNkMEmd8YHfX3bm4w7QwsFt42o+7U+nc/OuBNqigb//KOmBN0w==
X-Google-Smtp-Source: AGHT+IGjwNNA/m7AihUlAidFjnsU99lDbekiS2vKaV0LL1yMaAuzMNyl9YUW0j0putg8Qk9P597oAg==
X-Received: by 2002:a05:6a21:9218:b0:1c3:a411:dc48 with SMTP id
 adf61e73a8af0-1c47b2d77c5mr4006178637.38.1721951935468; 
 Thu, 25 Jul 2024 16:58:55 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:58:55 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 77/96] target/ppc/mmu_common.c: Convert local variable to bool
Date: Fri, 26 Jul 2024 09:53:50 +1000
Message-ID: <20240725235410.451624-78-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
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

In mmu6xx_get_physical_address() ds is used as bool, declare it as
such. Also use named constant instead of hex value.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 9f402a979d..5145bde7f9 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -321,8 +321,8 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     PowerPCCPU *cpu = env_archcpu(env);
     hwaddr hash;
     target_ulong vsid, sr, pgidx;
-    int ds, target_page_bits;
-    bool pr, nx;
+    int target_page_bits;
+    bool pr, ds, nx;
 
     /* First try to find a BAT entry if there are any */
     if (env->nb_BATs && get_bat_6xx_tlb(env, ctx, eaddr, access_type) == 0) {
@@ -335,7 +335,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     sr = env->sr[eaddr >> 28];
     ctx->key = (((sr & 0x20000000) && pr) ||
                 ((sr & 0x40000000) && !pr)) ? 1 : 0;
-    ds = sr & 0x80000000 ? 1 : 0;
+    ds = sr & SR32_T;
     nx = sr & SR32_NX;
     vsid = sr & SR32_VSID;
     target_page_bits = TARGET_PAGE_BITS;
-- 
2.45.2


