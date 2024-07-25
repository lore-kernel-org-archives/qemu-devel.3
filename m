Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BF0C52CD8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8NG-0006Ka-62; Thu, 25 Jul 2024 19:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Mv-0004V2-Ja; Thu, 25 Jul 2024 19:59:34 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Mt-0001lj-Pl; Thu, 25 Jul 2024 19:59:33 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2cb53da06a9so271973a91.0; 
 Thu, 25 Jul 2024 16:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951969; x=1722556769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iKp6OWilW+wJjA8X4BcH+9kkT2W9skS4KPMDra0yBgg=;
 b=e/4BWfkmxwIOPYS6J3SH+8Vz2zUsplGm3Wl78ZihHDUhZQktrZ98IJohepbfhxEnpB
 7qBSHPENktO7uDbCY6uXKvLwDmhhMPhZw97N/OZSSBu7YVA1uYaEFFLldDq6kYTP1N/U
 cguznqUUgtPiHZCWvKyYiHtOg/fnxlvhUtsfgjGgolKY19S77eGDoajYcRae9gOD/fM1
 LYB1IX+ke1pULyRhWHwOPdo+xtdWEZsx3ydHzEULf9/URJAG5gx/UArDizxHxyJsx2Jp
 6jwR8eoMWVaQOV8tw1hkFspj/xHEDP5C61LOR6lCyBr/DdrdG6DO2qQtGPbM811/H81z
 Ueig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951969; x=1722556769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iKp6OWilW+wJjA8X4BcH+9kkT2W9skS4KPMDra0yBgg=;
 b=Xa+3h0WyPv0nv/fWbctACWeL3ZtV/epxlv5vlripZDwmrBVjj4e61H0QFlQiks3CxX
 HI28t3YJhTgDS8uKluO1DJGjVl716hbBYO0/WEDrBBX+cHyD5XZ4eBXgW2ALzHGRVZGS
 2sgUaueVsJYwQZs6/8tLFhW9EdnxMBbN2in+N3gGGUAjZiqT3P/ND5jyJNcJOqCSfouP
 R5NAmIkHzWBFYh0GMK041nhJO5yb/ZTl+fFJq1Add4PMIqRp09qFgUdNP2ykMP4J+vY8
 HHyynX5JcXBkesbCXaTctCMHu9OwWxbAhQ7IGI0sRp2QABtzedlqdRbb9VFkes0lHW3u
 DbGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNcUUVj8QXlcmyOmpfkq3a1aidWvtGOQDzyjDL8qV4QKjKASUxgV7Nhok+0GG5YwkvibGIZeqs0hDLyKmti+YuyiLv
X-Gm-Message-State: AOJu0YzajxjDLtZHsT2yjj0eDUwXhOJ8fs7PMoP3Q+cHjK5/Gy7ivn2l
 vjnVRJTZB0t2n3zDY9MX3fUrvFgBPoZiyEKZmG3WjpGWk+josut2/3OY9g==
X-Google-Smtp-Source: AGHT+IEt3THaTvhfarD4zGysFpzBT4BZIlSHNB4j3Kf3bLXopURVKz3wkBKKsXQOTHEyyWA7Tj+3KA==
X-Received: by 2002:a17:90a:f190:b0:2c9:90fa:b9f8 with SMTP id
 98e67ed59e1d1-2cf216586e5mr7365299a91.10.1721951969558; 
 Thu, 25 Jul 2024 16:59:29 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:59:29 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 88/96] target/ppc/mmu_common.c: Use defines instead of numeric
 constants
Date: Fri, 26 Jul 2024 09:54:01 +1000
Message-ID: <20240725235410.451624-89-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102f.google.com
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

Replace some BAT related constants with defines from mmu-hash32.h

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 110936ca83..aa002bba35 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -201,7 +201,7 @@ static inline void bat_size_prot(CPUPPCState *env, target_ulong *blp,
     target_ulong bl;
     int pp, valid, prot;
 
-    bl = (*BATu & 0x00001FFC) << 15;
+    bl = (*BATu & BATU32_BL) << 15;
     valid = 0;
     prot = 0;
     if ((!FIELD_EX64(env->msr, MSR, PR) && (*BATu & 0x00000002)) ||
@@ -241,19 +241,19 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
     for (i = 0; i < env->nb_BATs; i++) {
         BATu = &BATut[i];
         BATl = &BATlt[i];
-        BEPIu = *BATu & 0xF0000000;
-        BEPIl = *BATu & 0x0FFE0000;
+        BEPIu = *BATu & BATU32_BEPIU;
+        BEPIl = *BATu & BATU32_BEPIL;
         bat_size_prot(env, &bl, &valid, &prot, BATu, BATl);
         qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT%d v " TARGET_FMT_lx " BATu "
                       TARGET_FMT_lx " BATl " TARGET_FMT_lx "\n", __func__,
                       ifetch ? 'I' : 'D', i, eaddr, *BATu, *BATl);
-        if ((eaddr & 0xF0000000) == BEPIu &&
-            ((eaddr & 0x0FFE0000) & ~bl) == BEPIl) {
+        if ((eaddr & BATU32_BEPIU) == BEPIu &&
+            ((eaddr & BATU32_BEPIL) & ~bl) == BEPIl) {
             /* BAT matches */
             if (valid != 0) {
                 /* Get physical address */
-                ctx->raddr = (*BATl & 0xF0000000) |
-                    ((eaddr & 0x0FFE0000 & bl) | (*BATl & 0x0FFE0000)) |
+                ctx->raddr = (*BATl & BATU32_BEPIU) |
+                    ((eaddr & BATU32_BEPIL & bl) | (*BATl & BATU32_BEPIL)) |
                     (eaddr & 0x0001F000);
                 /* Compute access rights */
                 ctx->prot = prot;
@@ -277,9 +277,9 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
             for (i = 0; i < 4; i++) {
                 BATu = &BATut[i];
                 BATl = &BATlt[i];
-                BEPIu = *BATu & 0xF0000000;
-                BEPIl = *BATu & 0x0FFE0000;
-                bl = (*BATu & 0x00001FFC) << 15;
+                BEPIu = *BATu & BATU32_BEPIU;
+                BEPIl = *BATu & BATU32_BEPIL;
+                bl = (*BATu & BATU32_BL) << 15;
                 qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT%d v " TARGET_FMT_lx
                               " BATu " TARGET_FMT_lx " BATl " TARGET_FMT_lx
                               "\n\t" TARGET_FMT_lx " " TARGET_FMT_lx " "
@@ -520,9 +520,9 @@ static void mmu6xx_dump_BATs(CPUPPCState *env, int type)
     for (i = 0; i < env->nb_BATs; i++) {
         BATu = &BATut[i];
         BATl = &BATlt[i];
-        BEPIu = *BATu & 0xF0000000;
-        BEPIl = *BATu & 0x0FFE0000;
-        bl = (*BATu & 0x00001FFC) << 15;
+        BEPIu = *BATu & BATU32_BEPIU;
+        BEPIl = *BATu & BATU32_BEPIL;
+        bl = (*BATu & BATU32_BL) << 15;
         qemu_printf("%s BAT%d BATu " TARGET_FMT_lx
                     " BATl " TARGET_FMT_lx "\n\t" TARGET_FMT_lx " "
                     TARGET_FMT_lx " " TARGET_FMT_lx "\n",
-- 
2.45.2


