Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85AFCC71130
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 21:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYsxF-0005qE-NX; Mon, 07 Jul 2025 17:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYsL3-0005F6-Cm
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:21:28 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYsL0-0004Fv-J5
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:21:20 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4a9bf46adedso14008201cf.2
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 13:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751919676; x=1752524476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jc2oN7irUyYl9X7QOUlSFDFaLc2q7UiRV+m8B2csJtc=;
 b=cx62i4ah8zTMhBYuDcectY9D9PP4+RcTDVZxt7OFWgL2izUa3F4Rcvs5juBB2JLpq4
 7PaebbydouGh37fBMWXlskc2gIIzsitihkaCTVrBUHRHK9JqhA7zL4musbxjUJZOX1MY
 FFdLwtwMmv6FttbNNYdl/sf1Q1C8RHUU6XrYz2vfZHZWcB2XlQlmJ7HCfVp+Cuxke9vp
 01oinG/Do35aECgD7E4vDRiS+PFb84ZwBseSGseK5pqG3aBvlqxXYdpopSk6rQeC8OkY
 J6qzaofGHgrgpGRRtl+PToYnov5VTJ2884N3v3+BBm3O8l9dFQ+VDvDdWYu0OhNqrxHw
 TG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751919676; x=1752524476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jc2oN7irUyYl9X7QOUlSFDFaLc2q7UiRV+m8B2csJtc=;
 b=xMOnL6G3mkC7czXiWPAHMrHbo+p909CP0DF8OQ4iRfE5kUte3mCSrdcPBg8z6WItfZ
 YnpOXGWZYyCoNjOE2SpH3xqhhv3/wRLlEjsuQKYcjXYRxJSmiK+6qrFqNoS7bCNge0f4
 q5IIc7pzAXNHGn0B6zMfSoWfz2kXPM6bvGTdzQO1wU7gGKSHc0sDM98H7uryGbavTYTN
 qwIP5kI04dchUQWLt/aUuL5pztmp90JRGo3Om5baSEFJlG+Dk+4r/4A59iVLxu1yWsNu
 zt7yPpOATy9JytWvR78T/TPFwzjplnuIFV6stZxDb5L1L2MF+6pYrIsWQcFG7WJFjxmw
 WTkw==
X-Gm-Message-State: AOJu0YxeQAY4O0+FvdqCZDzSFkcQX9ygJ9aWeLd3rvopev5+c4RnUOfF
 wAnjy/Uz3T3yA+t8cI6ewCTR5oD3GZ5eWsBHc75Jp4nspal0yF8d/b/Uf0P2ZMqK/EEgsPk/7wU
 FXR6TbZ0=
X-Gm-Gg: ASbGncvGY819NXD774If0OL+76nwsDfwgstl5jEgU1Yp673v70yPlDHfU2NIL14oY4v
 xT15R19Un8i/Q9pPlA3STILYDWt6l3h99197JFCAv9roHnMvp3xgVs2HytrdkTBdQzm80x0SesC
 KHIGF53g51Tr2SOhSQTX8V6+VRIT64BqRrcIlxjKK2InowTakDA87NWG7S7rcjVN92ukN0tEAGG
 TMARXTDyEl/XdQxE5n4a8ElsE+VpuZQ05DsxQvnxHqC0sPdF8sAgBIVAVsR+a4UcalXQO3C9oWS
 02Wv50Xk7ADNen9lY2Imwz6XtCvKCW8qF/PvxCpkuOftIBlVpbABvHq1r7RZ05fRCDmmFogLVRQ
 GpnIGnIM9zfXVSIap
X-Google-Smtp-Source: AGHT+IGhza7YbWOCfWAOzvKZyRCkyo7i9yuD4JzgHHcoFlXcZtVZhr47fHurAKIOB0g/PNWjAKluyw==
X-Received: by 2002:a05:622a:410c:b0:4a6:ef77:3deb with SMTP id
 d75a77b69052e-4a99881e795mr219551371cf.40.1751919676605; 
 Mon, 07 Jul 2025 13:21:16 -0700 (PDT)
Received: from stoup.. ([172.58.142.143]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a78dd4sm69050351cf.51.2025.07.07.13.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 13:21:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 01/20] target/arm: Convert get_phys_addr_v5 to access_perm
Date: Mon,  7 Jul 2025 14:20:52 -0600
Message-ID: <20250707202111.293787-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707202111.293787-1-richard.henderson@linaro.org>
References: <20250707202111.293787-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82e.google.com
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

Begin conversion of get_phys_addr and all subroutines
from MMUAccessType to a mask of required permissions.
Notably, access_perm may be 0 in order to disable the
permissions check.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 561bf2678e..760387b4da 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -979,7 +979,7 @@ static int simple_ap_to_rw_prot(CPUARMState *env, ARMMMUIdx mmu_idx, int ap)
 }
 
 static bool get_phys_addr_v5(CPUARMState *env, S1Translate *ptw,
-                             uint32_t address, MMUAccessType access_type,
+                             uint32_t address, unsigned access_perm,
                              GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
 {
     int level = 1;
@@ -1089,7 +1089,7 @@ static bool get_phys_addr_v5(CPUARMState *env, S1Translate *ptw,
     }
     result->f.prot = ap_to_rw_prot(env, ptw->in_mmu_idx, ap, domain_prot);
     result->f.prot |= result->f.prot ? PAGE_EXEC : 0;
-    if (!(result->f.prot & (1 << access_type))) {
+    if (access_perm & ~result->f.prot) {
         /* Access permission fault.  */
         fi->type = ARMFault_Permission;
         goto do_fault;
@@ -3515,7 +3515,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
                regime_sctlr(env, mmu_idx) & SCTLR_XP) {
         return get_phys_addr_v6(env, ptw, address, access_type, result, fi);
     } else {
-        return get_phys_addr_v5(env, ptw, address, access_type, result, fi);
+        return get_phys_addr_v5(env, ptw, address, 1 << access_type, result, fi);
     }
 }
 
-- 
2.43.0


