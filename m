Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3467EC87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLhh-0008KX-1S; Sat, 02 Aug 2025 19:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLgX-0006f6-Hq
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:30:41 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLgV-0004sv-TG
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:30:41 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-301a83477e5so2806322fac.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177438; x=1754782238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FnUxL1l7S/Ogxnuq3Rb6QT2pyV+tUJh+XdG2c+057PU=;
 b=qYnjF8iwUZd+22UOyM/LPOOz3R6DTwT4qypIf+7F0o5EoE3cZukr2PmFqsUIWAO0kr
 MAJs39QszrvARlcXlNq/H+IlcYDTtVj9CEFBZvAVjzfmOT4X6KbdArCnlDdFWS3eOk/K
 YNXfzIcS0nX6ECXXXVg4HSO1LjMXIQPhEbxSn9i7MQoB0tlWPXUQ74bwG3/1MPcrObC7
 GI9wIZxmWRzHiMGtKvFFOTCE+6QP+ipNn643qGNZ/kapd1NU1cB8j8CPF3LGiGNl0DEK
 KO5btQmwOg8RJKUaIIdG3n4sdwYO9dkLopYD8/LAHKYPGLjbJmOonJeFaEKIiYNTSx/L
 5n1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177438; x=1754782238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FnUxL1l7S/Ogxnuq3Rb6QT2pyV+tUJh+XdG2c+057PU=;
 b=NvCX++Y2JUUooN33TkH4NDY+1E2ojt0MXdR3pJTIglKguXOcogdVOofEJqcwTWKby/
 JEKlbPkmcW/+DzG+LGXY6NFOaxmTI4uW6jbjd2hsTB56uXKUrlzJES/QlJyFUoacYP0C
 j6TTh5vcmS2/OAYSTF6TYx2xHxGr4nkwlSw+2eX8csz1du8aFJS1IMjIaTGK2y3KSqXW
 OU1XVWI+LtdI1agRlHEoACwrFrR/0/j4q04AhGENHQYeuHrAgmUdOJxD/TuKG7+UKCra
 oWgbUKP6pAnkcWxJG2pwSpDLvLFZqbqTrO3RvUm8fxkv+2WRTUfDCiJQZ+HJXZ1D4Dra
 lLmg==
X-Gm-Message-State: AOJu0YyvfIIR4S4cpkwPct23Bk32qYX4isIiMabal6+EwjWIKDyhrUCC
 DqtblMX5/Iy91Nvv5hpGxCvKUpwvWK75GTGXex+6Rxe2+S7zgKuACFoRMn86NaZu+TBF77EMdmy
 MSi+eFg8=
X-Gm-Gg: ASbGncshNjdcbk7qXZDyAOJBgUpzvetZklbyp0fr45O7lS+8XpdCv3zPThD9+D+Vo8y
 iq329+kBWkv54GugD1kKHHep2Lx2EbEOSUVC8UHJCx040+VKK55JFodueHRyhqiW/1NpHUOxXCc
 EyGk6XsSXqlYJ4RFUaVhM0iklMf/cRAFQAEHdIBH3VNWy4WnNfcl8An9Jk39oEomPpaEu1qdupC
 j1U0NqZyPdzT3VDEDewyW2bfPloaHlIjFmOEBRFAvfxBM31naa7Gq7QdYKndR6PTTkB1/0WSrPe
 MjqMBvsMTzqqrw+BdlG0fBLF+Tuj5yhIFOp8WdZ3wTzFrBpHjOKagCA+HzvKN/E2iKTgN8kucvi
 G1FV3cjBX7qCX/7oQIWcFFwVCjIBLcg+5jFSXpjdNvyl4dEhPVeJey581okhQesU=
X-Google-Smtp-Source: AGHT+IHoiu6XO5QRvLVQQTNGMtzF4JzaCSclU5xAcnXUA2FCeurFHBRdoFP9byfWuBF8Evciwx1obg==
X-Received: by 2002:a05:6871:a701:b0:30b:85a0:eb66 with SMTP id
 586e51a60fabf-30b85a14575mr529391fac.12.1754177438431; 
 Sat, 02 Aug 2025 16:30:38 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30b8e3c9b32sm71031fac.24.2025.08.02.16.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:30:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 08/85] target/arm: Skip AF and DB updates for AccessType_AT
Date: Sun,  3 Aug 2025 09:28:36 +1000
Message-ID: <20250802232953.413294-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


