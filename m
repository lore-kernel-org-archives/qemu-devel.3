Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9521BF9B608
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFUeX-000737-MX; Wed, 22 Apr 2026 06:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUeM-0006yf-1D
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:17:43 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUeD-0002Nt-NQ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:17:37 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so65974265e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 03:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776853052; x=1777457852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p/Vl2py7bAr3MMXnnVGwEiFMxjfl+Vi5CKcG3JxQvlI=;
 b=ren4nwMvrDHa0nBceUgmUprUFdCGrxHQKucJ4iksICqcZ3bWHDdUNN5gZwfNY1EZYI
 +rGosqqpCyD2WYrZxOASgFuZtALkZRn85w7q05vBOW4AM04AQfsBxkQfwRIIiqO14crd
 SA0jmrhWS/kAmN70dOgjVf2cYg7+vMmvfMj7vCI4uI/Z1XlZA6uZzapp++bGxgRdDeDh
 vHxsCNQB0IA+PXe/gGQUPQW071C99z32cKOQ/5eTFGMqmHFyXOSEap2IxcU25h2FFy4F
 Vf0fVPobzSwE2Nwyn5dmJLT9Dic7qFH1N1bpER+o+K9tj6SSjs7ZBVALgquSApiALtHp
 3t2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776853052; x=1777457852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p/Vl2py7bAr3MMXnnVGwEiFMxjfl+Vi5CKcG3JxQvlI=;
 b=KSp7Q0dSWUIH3FsLQlDvc+Ro7ygaovWyg63lOHe7h/lw7suZdUKKIaKBvHFp4d0vBl
 AHCm5BWBAZGYRMUnjdv6YOnmTnqjbDCgRdH9OsuffYZO4IWzW+eGfT4pv9fHo1+q+G3p
 25w+VkNZMtjjRxCDujYdJOVQx1f6KVbZOUUEN65sBoUG1Zn1mTL7Mse3V7GbUuEILRML
 ltLZ+ASB+ApHLAY5el+g8yqpyCCMUP1k62ZSe4uM1Lj0NXSVcEMyAcwBIonq4qVLJPFe
 JbYKh3CnD+Ueslm6wP3Yaa54z8M9OVer6Gc4dxdVZz5nBGd8CGhqjXPZYxoE08DGl59v
 rLYA==
X-Gm-Message-State: AOJu0YyZ1pqB4EfKG/S0RdsC2fSUkvcTHwbUmMk8xeOh8/lFwxXxk9pP
 9N8Qgh7i2EFRWoEPWjaP8bgqedqorRn06l4mpvPaD6tro1KFPdclySdEYJfn35eEf9w=
X-Gm-Gg: AeBDies9yxV9Tf0vGMMWUistFB5fRih89t0TLBbGWGcdtfg8Mj1axtiHQW4TgL/q0Z9
 90JXkttoFOEp/AzsSSgoREPdUVvV+NdUoxm4QXV/NRR8l/hnUgvgE1Isa5E0CtwxVsDcjN9njtt
 DNiDI2dG97qFjyoDersN+hB2hhcy18CdwQ5XSgolgOqreIKe620xw2sxM4b0xtliS9R6N5xsWjU
 A/sl0+i9Cy0DZxLFyTbsPCNAQTBvTvAUeXN9TSoYtBsRlxmjb0ROp4qptXqNLWxS0j27m28+YaD
 KsZDg5nXwLhMfv53ANx5IyHmCO3+2/OF0lNTXWHK+m5fkUykR3ZjrCUF/GpeUfZOIzDjUBJve8B
 ltWleByfsgyJBdcijrZyqhSeEMtXBDFp9rZ6IVEJo3B+P6QYhQGuZLR/N4cftmASMiafYIqKGTl
 Au3tOTxySy7DdTjn82irCQ+cizaHeYWnVCZVcS5L7plNd2
X-Received: by 2002:a05:600c:1e09:b0:48a:592c:e655 with SMTP id
 5b1f17b1804b1-48a592ce7c2mr51094795e9.17.1776853051719; 
 Wed, 22 Apr 2026 03:17:31 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a55b8baaesm181142385e9.10.2026.04.22.03.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 03:17:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B68F65F941;
 Wed, 22 Apr 2026 11:10:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 28/31] target/arm: hoist event broadcast code into a helper
Date: Wed, 22 Apr 2026 11:10:39 +0100
Message-ID: <20260422101043.1234229-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422101043.1234229-1-alex.bennee@linaro.org>
References: <20260422101043.1234229-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

We will shortly call it from more places.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/internals.h     | 19 +++++++++++++++++++
 target/arm/tcg/op_helper.c |  9 +--------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index dc593f1fec8..089f679ac0a 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -682,6 +682,25 @@ bool arm_is_psci_call(ARMCPU *cpu, int excp_type);
 /* Actually handle a PSCI call */
 void arm_handle_psci_call(ARMCPU *cpu);
 
+/**
+ * arm_broadcast_event: set the event_register for all PEs
+ *
+ * This kicks all PEs which will up which are waiting on the event
+ * register.
+ */
+static inline void arm_broadcast_event(void)
+{
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        ARMCPU *target_cpu = ARM_CPU(cs);
+        target_cpu->env.event_register = true;
+        if (!qemu_cpu_is_self(cs)) {
+            qemu_cpu_kick(cs);
+        }
+    }
+}
+
 /**
  * arm_clear_exclusive: clear the exclusive monitor
  * @env: CPU env
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 655e3f96e78..6a2be85fcaa 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -474,14 +474,7 @@ void HELPER(wfit)(CPUARMState *env, uint32_t rd)
 
 void HELPER(sev)(CPUARMState *env)
 {
-    CPUState *cs = env_cpu(env);
-    CPU_FOREACH(cs) {
-        ARMCPU *target_cpu = ARM_CPU(cs);
-        target_cpu->env.event_register = true;
-        if (!qemu_cpu_is_self(cs)) {
-            qemu_cpu_kick(cs);
-        }
-    }
+    arm_broadcast_event();
 }
 
 void HELPER(wfe)(CPUARMState *env)
-- 
2.47.3


