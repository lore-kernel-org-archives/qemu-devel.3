Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEC4C56208
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 16:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws18J-0006nC-Ek; Thu, 06 Aug 2026 12:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws18E-0006kX-Qp
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 12:39:46 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws18C-0000ID-QP
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 12:39:46 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2d02b4c3601so28540055ad.3
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 09:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786034383; x=1786639183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ncF+VrF48oEXQiurXrwt2lRSm4bmf+7Q7x/Xk+zd/VY=;
 b=wD1izkqW66PD1sIIOvGvC+rm0AUcCZ42M5yhfO7ueI/2BKiMhHC4gAy85vpSfKJYbT
 f1r84qdSndwwwAdBws4jblLOO+3mxYtB7PdclYHqeRwlATAmlCZEQS/wOSSznwmhYZux
 gp16AqIsY06EPBQVlpnAzXCuKMJVWiDM01BTuSVEGILU+dpAEK84cIn5GEdVm6JYlBJf
 DGCklNamlTgkuubZ+uB6vDF8+QNQum98TwlgGrZCAPun+10jcQy9qg8Nt8frJry1nyP8
 5056Asz8wwPyaQNmBb7Z20Bs8iwQXl+gBz95CoxhQAJ/uM2Ab9LlOOIdsu1UTsaIaFg/
 ENvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786034383; x=1786639183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ncF+VrF48oEXQiurXrwt2lRSm4bmf+7Q7x/Xk+zd/VY=;
 b=iG4C10OWU41PHloCtvk+Fxp1avG5onZHbGKARy/5HPmD409ya2nzz0hHQM27VC9ocb
 +NLb3JxJ0vngCi963hgW7mKSIzLLItU8n4A2r9XhJQ2Dg+/6TsEpVjVgW3UlFH9ww4l+
 YZ84o6a4KnNEf08hps94s07u3HzzIbQcqwN+Jd/DMpjfq8sl9Ob9DNS9AoQpQy9zZTF0
 UNqYpCQ2Aqjz5mqmTKU6wryMcmX6NS0DTAdXizz5tNxjDkX+cUahxj2HqPmr7FmzMyvj
 E36IQAtbYBYlD4QQGxB2/CRSYmU6MFeY5HSvk2ycdSwqZC+ClFKzI+dxdGiiuSR/L+5i
 pySA==
X-Gm-Message-State: AOJu0Yynes7VYVvDaX1cGxWBrWfZqGkC2QalNp9JSBZwqi3Ofvqw/amR
 +uHHBXcyxcv8hCSBtoCCjd3hFFwkFHtOc2bMZxTq0FEqKlBPqKUMxHVBO5NNHOOG+fmnLkTJscR
 GaG0i
X-Gm-Gg: AR+sD13iBBzeyVU5BtnsXdspwpQLhTfMQg3vAS+ZlJYiRApD0VHhERZZ20EHW4HSmsO
 IQKad+8emqGieEpNUrJLxym8UXEOnXij5ARcr8r8icAvZ9N9jn4z97FS7ImeWnli4ksKQCy2+eF
 /woQAp/o/6DowZeSyOll5DJn1PSp8KewK8Zd6HAuj509JGrzTAcRUvFNntD/owFlfkNN5Pw1XKH
 +OSFNLJ/or9pjItIF2rD7Q5iycVxzRybiFNToY0SWcIE5mUpbSMN+X5WG2gHfka/3FBnAytqlqn
 HnYBtF5rwew8r+7IWSGdKO1XFx7P2WW8ZPCPdkhDAv4wwMmwSScyvhkRhsiJYwJBV6vgv/Dp4mi
 2VWwPy6DmB6DmiTTp/D+JDOl6ybVef5r8aguV1F/onFa87cwWgOidJo9AjkJQHTGawM7Bu4BIWr
 53bLiJ3/VpPnL9gaxEiChuVVPY2mW1muviB9/wbgAsl+bsMnTUKJNGDcqMrazGkYWdNxfpOIBTB
 g1mDN/HC2RUefJW2J8K
X-Received: by 2002:a17:903:1746:b0:2cf:afe8:b722 with SMTP id
 d9443c01a7336-2d0ca761e0amr184406025ad.11.1786034383201; 
 Thu, 06 Aug 2026 09:39:43 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d0aa4ec8c7sm34280735ad.80.2026.08.06.09.39.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 09:39:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 3/7] target/arm: Pass aarch64_enabled to aarch64_aa32_a57_init
Date: Thu,  6 Aug 2026 09:39:35 -0700
Message-ID: <20260806163939.328201-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806163939.328201-1-richard.henderson@linaro.org>
References: <20260806163939.328201-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Invert aa32_only argument to what is actually used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 2 +-
 target/arm/cpu-max.c   | 5 ++---
 target/arm/cpu64.c     | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 9c9196475b..5e7f41a50d 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1813,7 +1813,7 @@ void aarch64_max_tcg_initfn(Object *obj);
 void aarch64_add_pauth_properties(Object *obj);
 void aarch64_add_sve_properties(Object *obj);
 void aarch64_add_sme_properties(Object *obj);
-void aarch64_aa32_a57_init(ARMCPU *cpu, bool aa32_only);
+void aarch64_aa32_a57_init(ARMCPU *cpu, bool aa64_enabled);
 void aarch64_host_initfn(Object *obj);
 
 /* Return true if the gdbstub is presenting an AArch64 CPU */
diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index d7f2500353..bdacfb21d3 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -16,10 +16,9 @@
 #include "target/arm/internals.h"
 #include "target/arm/cpregs.h"
 
-void aarch64_aa32_a57_init(ARMCPU *cpu, bool aa32_only)
+void aarch64_aa32_a57_init(ARMCPU *cpu, bool aarch64_enabled)
 {
     ARMISARegisters *isar = &cpu->isar;
-    const bool aarch64_enabled = !aa32_only;
 
     cpu->dtb_compatible = "arm,cortex-a57";
     set_feature(&cpu->env, ARM_FEATURE_V8);
@@ -204,7 +203,7 @@ static void cpu_max_initfn(Object *obj)
 
     assert(tcg_enabled() || qtest_enabled());
 
-    aarch64_aa32_a57_init(cpu, !aarch64_enabled);
+    aarch64_aa32_a57_init(cpu, aarch64_enabled);
 
     if (!aarch64_enabled) {
         aa32_max_features(cpu);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index e3ee0253a0..faaf3ab879 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -688,7 +688,7 @@ void aarch64_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
 
 static void aarch64_a57_initfn(Object *obj)
 {
-    aarch64_aa32_a57_init(ARM_CPU(obj), false);
+    aarch64_aa32_a57_init(ARM_CPU(obj), true);
 }
 
 static void aarch64_a53_initfn(Object *obj)
-- 
2.43.0


