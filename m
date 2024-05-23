Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B36C25B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHb1-0008AN-8l; Thu, 23 May 2024 19:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZz-0004Pf-1k; Thu, 23 May 2024 19:10:35 -0400
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZx-0006EA-8R; Thu, 23 May 2024 19:10:34 -0400
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-36dd56cf5f5so22417895ab.3; 
 Thu, 23 May 2024 16:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505831; x=1717110631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZJUFjV3rLbKnuX/4fI8Aob/kdhBC8cIX6xs1sOZu9Zg=;
 b=KsQ0aibdlu8k6NJ4E0jzCCmaRyKJFRjDCE97kgcmYVTyD2pVwY+F3IL1P8KZ94jQn7
 qtzzc5lnVJqtEv9sLBnprOpb/HTLpZOhUC1MhKLHSOm8gdcZKiuCan1oBZWTfgZePFcl
 defCoyioqINNoUUH1Q+F2GIffRrOI2J2rDb6TFNi68dSSdzZ+oDAn/2o78eZWxg9i1a0
 GrOSiAckSe2Wj6+bsW6OyIkSUCWaRx5u7qacLG9EppNyYP6w5TzKL0QO4e9/pxHrUnE9
 nU1CnG+I1ThtVvSekaqmuWPxzpDH5+cfXsCPWVLgWXNcFEiI9BnAQaG3mZLoKb9ewdLE
 xTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505831; x=1717110631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZJUFjV3rLbKnuX/4fI8Aob/kdhBC8cIX6xs1sOZu9Zg=;
 b=pQmTyhE01/o4GMlcrdVMlFQKAwy5cvA1OnkF9i3UEKTuKNywFstt/gdlZOVHzaNAta
 uDlCSur1QSnOMvTEJmduq3QVxTBH0wqYE7nL3zyYGbIbgJvGsh3C6XkwSoN3SzGGkTml
 UKr/ITzMU3DG5AxsTJFXzmkUdda4j03Z5XG4/D3Ryy4AKRsD5G88LLPtaV9rpl0xx6EY
 OFoVShzeO0zZWOGrByKf0s9mjvOAZIeBgZ6zGaSX04nsig0FGkgmwPtZRssMxpbhrBfR
 4g2JuLF5oFRf+JkrcRgJ8WogTiEdCdrisYdyKEvE5ayiRqaZJE3j+oFRw9IoTLeg8cUN
 2oew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV1jq9uoV1pZEA07MjmK4TAh0f4ygK5YLorKF3CSyw0SQimDINECIux9r2eHqGyX0Rzih+MzOzu3WBAuSo/UXltM08
X-Gm-Message-State: AOJu0YxA9ow52WVbEogO/R/CmTIrHI+BjSqY5gxRx61Ti5DfT0SVmUuj
 DlU91jTvgga43PLLth5FBwL/HP6Y2nb1MTZi/+bcXEHwlWCHqRuwwMvjBA==
X-Google-Smtp-Source: AGHT+IGu8aYAAIxZMs/t21q7n3hWsfk4HJN5huPQoL0CXiiJXuotgrT2H4t4c3P/nxV+lYufifu9Bg==
X-Received: by 2002:a05:6e02:1aad:b0:36b:2bc6:6425 with SMTP id
 e9e14a558f8ab-3737b2b48e7mr8648585ab.4.1716505830840; 
 Thu, 23 May 2024 16:10:30 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:10:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 50/72] target/ppc/mmu_common.c: Split off real mode cases in
 get_physical_address_wtlb()
Date: Fri, 24 May 2024 09:07:23 +1000
Message-ID: <20240523230747.45703-51-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=npiggin@gmail.com; helo=mail-il1-x12c.google.com
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

The real mode handling is identical in the remaining switch cases.
Split off these common real mode cases into a separate conditional to
leave only the else branches in the switch that are different.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 9f177b6976..b13150ce23 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -1172,7 +1172,6 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
                                      MMUAccessType access_type, int type,
                                      int mmu_idx)
 {
-    int ret = -1;
     bool real_mode;
 
     if (env->mmu_model == POWERPC_MMU_BOOKE) {
@@ -1184,38 +1183,23 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
 
     real_mode = (type == ACCESS_CODE) ? !FIELD_EX64(env->msr, MSR, IR)
                                       : !FIELD_EX64(env->msr, MSR, DR);
+    if (real_mode && (env->mmu_model == POWERPC_MMU_SOFT_6xx ||
+                      env->mmu_model == POWERPC_MMU_SOFT_4xx ||
+                      env->mmu_model == POWERPC_MMU_REAL)) {
+        return check_physical(env, ctx, eaddr, access_type);
+    }
 
     switch (env->mmu_model) {
     case POWERPC_MMU_SOFT_6xx:
-        if (real_mode) {
-            ret = check_physical(env, ctx, eaddr, access_type);
-        } else {
-            ret = mmu6xx_get_physical_address(env, ctx, eaddr, access_type,
-                                              type);
-        }
-        break;
-
+        return mmu6xx_get_physical_address(env, ctx, eaddr, access_type, type);
     case POWERPC_MMU_SOFT_4xx:
-        if (real_mode) {
-            ret = check_physical(env, ctx, eaddr, access_type);
-        } else {
-            ret = mmu40x_get_physical_address(env, ctx, eaddr, access_type);
-        }
-        break;
+        return mmu40x_get_physical_address(env, ctx, eaddr, access_type);
     case POWERPC_MMU_REAL:
-        if (real_mode) {
-            ret = check_physical(env, ctx, eaddr, access_type);
-        } else {
-            cpu_abort(env_cpu(env),
-                      "PowerPC in real mode do not do any translation\n");
-        }
-        return -1;
+        cpu_abort(env_cpu(env),
+                  "PowerPC in real mode do not do any translation\n");
     default:
         cpu_abort(env_cpu(env), "Unknown or invalid MMU model\n");
-        return -1;
     }
-
-    return ret;
 }
 
 static void booke206_update_mas_tlb_miss(CPUPPCState *env, target_ulong address,
-- 
2.43.0


