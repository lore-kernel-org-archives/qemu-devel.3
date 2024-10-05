Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156B0CFB42C
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 20:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxB2i-0006Ra-1t; Sat, 05 Oct 2024 16:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxB2g-0006PP-HI
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 16:06:18 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxB2f-0001nK-0g
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 16:06:18 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20b90ab6c19so35190375ad.0
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 13:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728158776; x=1728763576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4X5zP7zXx4H0vSkmfgBSYylbUDArgVMPw2dfqzvhfaA=;
 b=sgwEB8Uhx/P52vUTv5xyl4uXggYLuzfqF16GGrp04uGuPWt/SjWB5XnMoIu1PKx2PD
 9z4m2LNNH4zrxL+KuFrOsGnF1iJsG4c+LTxKC6y5VCeJNU4zjSuRahomeqvxDP8qvf1r
 c9h0sKmhNN+sQ3VLojV9BEj5g9CYcsY0nNknhCXTyTRkuoowZ/TRLfN5Gz30nOM+shia
 QOde+CGjLIx4tHKPqygW6TjPFDnJG4egdgAswQUeXkDyqkPobHrOvGi4xGHkZ3N9h5jx
 em5uPmvEzvx2/EeHkrPv4iLZpw4XaNBRRCAHpqzX1cj/lfdz+H9/rkmL+07p6xBdrohT
 EFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728158776; x=1728763576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4X5zP7zXx4H0vSkmfgBSYylbUDArgVMPw2dfqzvhfaA=;
 b=J/m7w3BpALoGrBr/TqblChFzT3lZGXXCK7xBPR4H7S1JGriwyRQYJG7cUDY0u3O8Mx
 n4c8cbKavmuwRpu+8QZ0ZDY2ZydnwxSVl2xClqvRvtuA8pGvAnJukvVMKjlOw1FO7TuU
 o1lrdQh13XkL82xE8NNVI9blEI70atM7eyuwQwqVvxMtzgWoJAKscxgG3dPQcmifCawV
 ZpyFYDa4xaKQJQq61UEX/QkI65FmmSY3+5kDiNFS6dL9NPv/gNL/sT2waQtH73JINaN5
 xOpVBgGnI8ElR28ZTWIIyI7OUoMSgzSnB/Z3fKKiZItQPRTYpVGm9fGtXkJxP23srHVT
 Pgdg==
X-Gm-Message-State: AOJu0YwevPDGOBxqf0JcS/3rkbVfyS8BOjl/kSyUcrBSA/NV9beHZrPM
 eIEhjLLNuI3MVMLNhIeezXgiL6y5G0l8tT9zkpBnjJuPh/BC+RYbf3cBtYk3Y+tUUGry89kE1Ns
 Y
X-Google-Smtp-Source: AGHT+IEx5vHtVkprUThlZwV+Lqo7Z029AoCfFZ0CZWDgQlrwN//FsMIaExtuwtG6PQ0wcXYm3ZJH7Q==
X-Received: by 2002:a17:902:e84f:b0:20b:b7b2:b6c5 with SMTP id
 d9443c01a7336-20bfee383c2mr91865325ad.54.1728158775790; 
 Sat, 05 Oct 2024 13:06:15 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c13931055sm16493405ad.139.2024.10.05.13.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 13:06:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH v2 15/21] target/arm: Pass MemOp to get_phys_addr_gpc
Date: Sat,  5 Oct 2024 13:05:54 -0700
Message-ID: <20241005200600.493604-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005200600.493604-1-richard.henderson@linaro.org>
References: <20241005200600.493604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Zero is the safe do-nothing value for callers to use.
Pass the value through from get_phys_addr.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 9af86da597..e92537d8f2 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -81,7 +81,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
 
 static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
                               vaddr address,
-                              MMUAccessType access_type,
+                              MMUAccessType access_type, MemOp memop,
                               GetPhysAddrResult *result,
                               ARMMMUFaultInfo *fi);
 
@@ -579,7 +579,7 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
         };
         GetPhysAddrResult s2 = { };
 
-        if (get_phys_addr_gpc(env, &s2ptw, addr, MMU_DATA_LOAD, &s2, fi)) {
+        if (get_phys_addr_gpc(env, &s2ptw, addr, MMU_DATA_LOAD, 0, &s2, fi)) {
             goto fail;
         }
 
@@ -3543,7 +3543,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
 
 static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
                               vaddr address,
-                              MMUAccessType access_type,
+                              MMUAccessType access_type, MemOp memop,
                               GetPhysAddrResult *result,
                               ARMMMUFaultInfo *fi)
 {
@@ -3641,7 +3641,8 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
     }
 
     ptw.in_space = ss;
-    return get_phys_addr_gpc(env, &ptw, address, access_type, result, fi);
+    return get_phys_addr_gpc(env, &ptw, address, access_type,
+                             memop, result, fi);
 }
 
 hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
@@ -3660,7 +3661,7 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
     ARMMMUFaultInfo fi = {};
     bool ret;
 
-    ret = get_phys_addr_gpc(env, &ptw, addr, MMU_DATA_LOAD, &res, &fi);
+    ret = get_phys_addr_gpc(env, &ptw, addr, MMU_DATA_LOAD, 0, &res, &fi);
     *attrs = res.f.attrs;
 
     if (ret) {
-- 
2.43.0


