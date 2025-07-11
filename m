Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C01C83F21
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 22:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaMbD-0001ZZ-Fr; Fri, 11 Jul 2025 18:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaMYc-0007RW-AT
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 18:49:42 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaMYY-0008Re-B7
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 18:49:28 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-40af40aee93so1620847b6e.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 15:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752274164; x=1752878964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pCFS6cqTwlg3fFOqku117fnhPK1D7OaRJaQ+ElcEeuA=;
 b=OK/3CtOtNlG1YwdCbDsLgaV0C0IR94svBNywGbUrkb8ap+wQS0I6mLjb2dt+WZ2uCB
 l0t2fZtDITQ1WhuA7eLSG7K125G+svmNy7Kd7KXlvguSJKWrQCXzdlRdOYtHVQc680fO
 e6CxxHxf/wE48x4F++sIwZHMvhpFEr6v58E0c2xBd4hlcY5y523Ail56qtJ43bGCNLmG
 xnm24wJSLa7r2wPXgK8OhCAesDFQ29tNo3yCP0PqjVcn+p9xwZioNlfKCWLI8885X18q
 ucWwwF7MCz3R4FpTTw3kpXAGxzqAQzeW8HF3wE/0bCJkOvecFxnMprXZ9JZTUF+qIMtz
 bkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752274164; x=1752878964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pCFS6cqTwlg3fFOqku117fnhPK1D7OaRJaQ+ElcEeuA=;
 b=BJsPTPlrApXO59LrOKGVcWU0+64Ggf2uEa2hyNT15A4FU+sBGuA2kl+N+tLJmyO7QC
 yxqVcNZlm5MCRNdvoJg2je0QwHUbfB2ewoycD973wwLB72sMxpyQBmsfpH/Vf91MFPiM
 +RcCO0JGeCI7ZPlwW1tLadH4MMV1hz5OhuAwK3DqxSGTwnd28pw2P9cLB2IFySLvKzZW
 WnZsxB4dsq6QGaHbbojmd7WVEf8AXWGyNTGKChfy0CI1FiQZ1q9MqxhIXDgBkOAoC41z
 odaVmDfOHystinrqkS+39+r18hd+oLDC97dsBbAlh0H1z+PZAvXEJrcE77fVP6TsMSj4
 aFdw==
X-Gm-Message-State: AOJu0YzuW8yiR0sBjiXFhecVlK7oU67PfTdLd5rrunYJe0eJZHjrefXM
 Sp6NXMY8lp5tLHIc+pQwSe0Zx8rrCmVMreFXS5gceyJAJwTFL2EouL9AOrNOwPcT3QRGKghpIeP
 X/PeYdO0=
X-Gm-Gg: ASbGnctCmGw3YWlvyaRxl+KwFeA0izf46lCg/4ndvhkffu+5LMXB7ST18B2NrZmuLHH
 DidiT3dhLxGdtaU1DbmkJRobOK0AuxhXIqOhXweSRsGMZyXGUQPEOlNm7AXizGvfh0x+OwszotG
 LujWUKGgzwQhXdP94QE8Zrz89UC/4L8wsRUm2wCF+4M1BLZbs3I9hFyKvEwGLXejPzP28moTYFb
 +ANNZ9d6i052j2oPIZLfKfQKPdPTVcRv2MaRQ/jNyBGa74MnoLxS4EJrHq+aHXLtFeP7qi+nCHw
 9NwmWf7MOxM+14FqhFgh9bL2dWtgm8jUmCmQKOFdqyGOCLtv+O0MYWDSKOequRga9bXPIIHF/P5
 qhRcxlO8YLw/1MrDkW7ljvGlX2WAMag2jGYdHG7+n+i6H5tfMBk2WzRrbn9p/Js0EU3XWU19Z/e
 JopnRnY8SX
X-Google-Smtp-Source: AGHT+IE0kbKNmv08MvHE23M3QnsEtA91s/oN4v56/+kvsVhJ/ISBjSMp6NA19DZO4UgR2OdUB31cVg==
X-Received: by 2002:a05:6808:3025:b0:410:f243:a502 with SMTP id
 5614622812f47-415659ac4ecmr3328808b6e.8.1752274164100; 
 Fri, 11 Jul 2025 15:49:24 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-414197c6064sm696638b6e.20.2025.07.11.15.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 15:49:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 5/9] target/arm: Skip AF and DB updates for AccessType_AT
Date: Fri, 11 Jul 2025 16:49:11 -0600
Message-ID: <20250711224915.62369-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711224915.62369-1-richard.henderson@linaro.org>
References: <20250711224915.62369-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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

We are required to skip DB update for AT instructions, and
we are allowed to skip AF updates.  Choose to skip both.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 1866c494ef..efbad7af1f 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -58,6 +58,12 @@ typedef struct S1Translate {
      * and will not change the state of the softmmu TLBs.
      */
     bool in_debug;
+    /*
+     * in_at: is this AccessType_AT?
+     * This is also set for debug, because at heart that is also
+     * an address translation, and simplifies a test.
+     */
+    bool in_at;
     /*
      * If this is stage 2 of a stage 1+2 page table walk, then this must
      * be true if stage 1 is an EL0 access; otherwise this is ignored.
@@ -1929,7 +1935,12 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     descaddr &= ~(hwaddr)(page_size - 1);
     descaddr |= (address & (page_size - 1));
 
-    if (likely(!ptw->in_debug)) {
+    /*
+     * For AccessType_AT, DB is not updated (AArch64.SetDirtyFlag),
+     * and it is IMPLEMENTATION DEFINED whether AF is updated
+     * (AArch64.SetAccessFlag; qemu chooses to not update).
+     */
+    if (likely(!ptw->in_at)) {
         /*
          * Access flag.
          * If HA is enabled, prepare to update the descriptor below.
@@ -3553,6 +3564,7 @@ bool get_phys_addr_for_at(CPUARMState *env, vaddr address,
     S1Translate ptw = {
         .in_mmu_idx = mmu_idx,
         .in_space = space,
+        .in_at = true,
         .in_prot_check = prot_check,
     };
     /*
@@ -3653,6 +3665,7 @@ static hwaddr arm_cpu_get_phys_page(CPUARMState *env, vaddr addr,
         .in_mmu_idx = mmu_idx,
         .in_space = arm_mmu_idx_to_security_space(env, mmu_idx),
         .in_debug = true,
+        .in_at = true,
         .in_prot_check = 0,
     };
     GetPhysAddrResult res = {};
-- 
2.43.0


