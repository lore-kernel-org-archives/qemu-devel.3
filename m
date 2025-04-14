Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52757C369B4
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 15:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4Llx-0000k0-QD; Mon, 14 Apr 2025 11:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4Llr-0000e7-MD
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 11:30:51 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4Llj-0005Ws-Ji
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 11:30:51 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-227cf12df27so36052725ad.0
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 08:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744644637; x=1745249437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e2gWTr/bEI2XvQEhITW5r3zQts/Uh5xUtEqBuh5AV7s=;
 b=Jp1/5zSWFDLrnCOze76Xh1PpWYj0QlagysyaR+JS/yr0xhaTcEsW9nfJEqfv0S8Yet
 3PtBUxn68LIyyroUDOZjZD1Iwp8W5qL4S6xWkeHKzXs4P5tVmPC961y2Mz5Un4POPVA/
 vD0EYfBtHASoaqi7eCQe3DBVwjHwFjHehdUDHx/E1aRDQ7p7CfM4aZOPNGQpPqaVyCTW
 Ud9l3VuQ5RkcwBmrmEp7Kacqku9ECiFK4nWmNq9lWOXYVmtEpg+VZldBqm15kr6PFPww
 dBBIs4jf2FuGWOmLB2PHWGfJiHXlNAHNmxIlF/0aFNxvN4pRUJJkbl4na80o98yBn5NN
 OLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744644637; x=1745249437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e2gWTr/bEI2XvQEhITW5r3zQts/Uh5xUtEqBuh5AV7s=;
 b=rPyaCn/fYM5/UlKGXOd4eaH/U0eXl3DxSwynqxyMR1shxgBDiukDPveEFgjBGrvSdw
 KF+8WwYfcYPFMzoC/ZSWZzcln4Bhlh1tu1pVnPspzjcIfnZnU3dn+MApBFW3Z0M3+Y4k
 yjvz33KPMv0qrhhb0CRvJVVVhVOPnyQBwJk+K2/oJ8duanyx4FHBF6W1DTNv1aNAu4Ou
 InDX6PVu4uu4uCRx7PPgsUZUJrXCPS+fyVHHjdwaN9RRcO5fAaj909EkU8xKOiz45beU
 UnixvjQ6QsRstk4J9PBeSaB4PZVKI1fd3D/5FI5or3elszbCouuOKexs5DOwW9zxh3XO
 T8wQ==
X-Gm-Message-State: AOJu0YznDZZ7LCN3FJ8BhbfjvMwIm7Q9i6i/KGXt2xTV4lQWRyMV9FkQ
 0D23yIajzl48vo1iiZSjNaaDy7DPPjdQpxZqHUifBV5UmWPb5LHBNci0adcKB7IYKPLJdtpPiMh
 h
X-Gm-Gg: ASbGncv4oLPEl3xkFsCIdnh8HINIXddMixdCPVCsmnZUK8ytBJdabFoNsZ6Ipmz96sR
 p7IUSpkfUE9CIQDDB3XaYP5ro52B2kTB918WAFRTRMGmaG79Bmr+tX1Z2womb35wWaS3wBhjj31
 joD4eFBozPJzxNeXoITvDLcYfgMytpQYttSa3Tr3Uru3tvGjSOHuew2goyE2N7jMAoDxlXCGeFd
 0RLthZndrdOCe2f23MyPygvk6Qx+lPqbNPDmNzj83i7iKjfpHlbhZudt2IO1ApD6MdBXPz9oXo0
 yvWD/ROFzCO5JAK78Up1aD9h8UaLjm8LugXwmw7i
X-Google-Smtp-Source: AGHT+IFBzpbqLUuWf7TRRgSDfzjiwrvA/CJQ6LLOqQfg0XUvByw/2ca4vhYKmhlUFErMeu2e8MHfxQ==
X-Received: by 2002:a17:903:2a90:b0:223:5187:a886 with SMTP id
 d9443c01a7336-22bea0c6669mr175815615ad.22.1744644637193; 
 Mon, 14 Apr 2025 08:30:37 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccbd5esm100735235ad.248.2025.04.14.08.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 08:30:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 Yannis Bolliger <yannis.bolliger@protonmail.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 1/4] target/arm/ptw: extract arm_mmu_idx_to_security_space
Date: Mon, 14 Apr 2025 08:30:24 -0700
Message-Id: <20250414153027.1486719-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414153027.1486719-1-pierrick.bouvier@linaro.org>
References: <20250414153027.1486719-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

We'll reuse this function later.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/ptw.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 8d4e9e07a94..fdc575ec8c7 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3550,13 +3550,9 @@ bool get_phys_addr_with_space_nogpc(CPUARMState *env, vaddr address,
                                memop, result, fi);
 }
 
-bool get_phys_addr(CPUARMState *env, vaddr address,
-                   MMUAccessType access_type, MemOp memop, ARMMMUIdx mmu_idx,
-                   GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
+static ARMSecuritySpace
+arm_mmu_idx_to_security_space(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
-    S1Translate ptw = {
-        .in_mmu_idx = mmu_idx,
-    };
     ARMSecuritySpace ss;
 
     switch (mmu_idx) {
@@ -3617,7 +3613,18 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
         g_assert_not_reached();
     }
 
-    ptw.in_space = ss;
+    return ss;
+}
+
+bool get_phys_addr(CPUARMState *env, vaddr address,
+                   MMUAccessType access_type, MemOp memop, ARMMMUIdx mmu_idx,
+                   GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
+{
+    S1Translate ptw = {
+        .in_mmu_idx = mmu_idx,
+        .in_space = arm_mmu_idx_to_security_space(env, mmu_idx),
+    };
+
     return get_phys_addr_gpc(env, &ptw, address, access_type,
                              memop, result, fi);
 }
-- 
2.39.5


