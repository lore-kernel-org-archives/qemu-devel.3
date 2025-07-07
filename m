Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74DAC71130
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 20:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYsvL-0004SF-CX; Mon, 07 Jul 2025 16:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYsLK-0005Mv-6Y
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:21:44 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYsLH-0004KY-6S
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:21:36 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4a77ffcb795so33802391cf.0
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 13:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751919693; x=1752524493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MjEHLUFNmDP4O5aZmFwPD33ITZa8oo06PNRAd4Vt/6M=;
 b=pXHFJ4TDNMq762oPVidszhMNLgCsdzNTZEMNB9a3xWoWweBtVNQq33keOWpqGzspZZ
 adG41xSL1fWYWAtgufUd1dFe4pqWnUIcU/Y9MM0/ttz8mT4kZLoXKHj3qanj4Lr2HuHq
 pDTWn/A4fAzwrpZmZF4da4VpxTlKXHstshdvM2uk6k/m+Edv+r2xxuPvprBw6hRJZ9hj
 TnBhO1NW4DbfpqWNBnO3vx2J0rUKUlN8QHw6WBK54tAhiPX/y/y0zBTI/DlFWAuFL4cF
 8XhW6ucbNh6pjoSbs3eE+voeRdjpLAcjzkjh5ORDYWEUmCayaoy73RoJPuCabOO2rkG2
 zpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751919693; x=1752524493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MjEHLUFNmDP4O5aZmFwPD33ITZa8oo06PNRAd4Vt/6M=;
 b=mFtsAX+9UHuK5PQjESb3j42D0RlYvdW8P6K95jcStyMIP/5NjNnNeau4Bk18FXpvTl
 cxo3c6jxv+ovbpKz2LXsOk22AcoPjlHrEH0UVrk1B8q9zcFGYlJqDZRgiyMQJ8iXu29b
 RP+yw6/tWSgSybfWR6CpSyvnkBCZs57IXkjZQiL7rgKog0tEFm6BW4jqH6gZpSXOEAYA
 H2iO96Ai+2ws/r0MObe6zbBIhCIXUeGKcoQZ/V+3XFN5vf+s1hKUjjv3igIRt8WcjU59
 vpxmPIfEdLRIGNUso0c7wrMAU/XfR8YgWTRxlcYnishPaQ3Unor9szkS1o1PF+Pn1Z9O
 QBOw==
X-Gm-Message-State: AOJu0YysCfbnDCWaeCEwMlyk6RHiZVPsVzQwYtn02OBISdoAhLVwiXgK
 zcFWVJyKY/5CSZaSLtLmPmzJzZd82JIy7pFe6696QDd7LBAw0A0KImjKl3p3jh8qDMTDaMYGCKN
 +7FyT+yw=
X-Gm-Gg: ASbGncvG9yX0C4GekTiLb6cCHPabOSlqm+9bjmKTWcWrukuiaE+USSjBr9WBPsZPgS1
 fjuzOvJXMHfKqbnTNDYri6mUlJNppTIBOqNkJzvz0I5bFr1sWiQv/YRSZz8F+ScGGG2/h14pWU6
 SUDb0Q1PFXq35d5ph741wMfOfv+L0g8SGAaQgCZekap1A9TKJDcl7FmRfw3XjaI8VLdxJF+7cy5
 2Lzb2MuKW4T6lGp7YnvBeXSHZYsicFJfdMJGP3m6BAhte4mLu9aiZLjPoiXC1MSSduTuhFW8nPl
 PHumw5mSlpYXicEuTUAHeYr2Nx2GHx4XwiQY/DhaSsk3svMMb4VYukCQJxoG4FLhVcScH8z3WOb
 zs/Qx+EKES83wb8Gk74Ek5uc9MLM=
X-Google-Smtp-Source: AGHT+IERxHsB9WAVKYFv9ZZfYCBz16Nidq5zfOay2Jv7keY/MXKU2XWXc+1CH1L5S2TP+au1rY4MqQ==
X-Received: by 2002:a05:622a:424b:b0:4a6:ea91:7e9 with SMTP id
 d75a77b69052e-4a9cd7b1b75mr5019911cf.25.1751919693448; 
 Mon, 07 Jul 2025 13:21:33 -0700 (PDT)
Received: from stoup.. ([172.58.142.143]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a78dd4sm69050351cf.51.2025.07.07.13.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 13:21:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 10/20] target/arm: Convert get_phys_addr_disabled to
 access_perm
Date: Mon,  7 Jul 2025 14:21:01 -0600
Message-ID: <20250707202111.293787-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707202111.293787-1-richard.henderson@linaro.org>
References: <20250707202111.293787-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index f1edbbee5b..5b8040a174 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3193,7 +3193,7 @@ static ARMCacheAttrs combine_cacheattrs(uint64_t hcr,
 static bool get_phys_addr_disabled(CPUARMState *env,
                                    S1Translate *ptw,
                                    vaddr address,
-                                   MMUAccessType access_type,
+                                   unsigned access_perm,
                                    GetPhysAddrResult *result,
                                    ARMMMUFaultInfo *fi)
 {
@@ -3219,7 +3219,7 @@ static bool get_phys_addr_disabled(CPUARMState *env,
             int addrtop, tbi;
 
             tbi = aa64_va_parameter_tbi(tcr, mmu_idx);
-            if (access_type == MMU_INST_FETCH) {
+            if (access_perm & PAGE_EXEC) {
                 tbi &= ~aa64_va_parameter_tbid(tcr, mmu_idx);
             }
             tbi = (tbi >> extract64(address, 55, 1)) & 1;
@@ -3253,7 +3253,7 @@ static bool get_phys_addr_disabled(CPUARMState *env,
             }
         }
         if (memattr == 0) {
-            if (access_type == MMU_INST_FETCH) {
+            if (access_perm & PAGE_EXEC) {
                 if (regime_sctlr(env, mmu_idx) & SCTLR_I) {
                     memattr = 0xee;  /* Normal, WT, RA, NT */
                 } else {
@@ -3404,7 +3404,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
     case ARMMMUIdx_Phys_Root:
     case ARMMMUIdx_Phys_Realm:
         /* Checking Phys early avoids special casing later vs regime_el. */
-        return get_phys_addr_disabled(env, ptw, address, access_type,
+        return get_phys_addr_disabled(env, ptw, address, 1 << access_type,
                                       result, fi);
 
     case ARMMMUIdx_Stage1_E0:
@@ -3504,7 +3504,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
     /* Definitely a real MMU, not an MPU */
 
     if (regime_translation_disabled(env, mmu_idx, ptw->in_space)) {
-        return get_phys_addr_disabled(env, ptw, address, access_type,
+        return get_phys_addr_disabled(env, ptw, address, 1 << access_type,
                                       result, fi);
     }
 
-- 
2.43.0


