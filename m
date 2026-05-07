Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBAACD3444
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11t-00058N-Ap; Thu, 07 May 2026 11:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11r-000528-Nm
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:47 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11q-00040A-29
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:47 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso9362145e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169165; x=1778773965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s4SA//SBEYf0uzY8+aoVUwQDVhHqm5NWkavOs4X9AHU=;
 b=zU16M9Z+bBXLLHoObCqa+kBxK7mCFNdni/qXBqsi+w0Tco9BIoVt9gkmOfMH3CTujP
 qAojjTY+kqo8ALf7HcQAZzAKqWz4lwfmAC2esMgAQcHm+avxQue4ipcDxNGW9jpCetqE
 k3cpfgTCy1RbuIMmdt3bGlu5fdSuqDvLzurgQNZJWSM3FFh1KJ7dhrcMP/0rKAmhJr+g
 T9brsy93MU0wnITxJvSUjizN2O0F947E2NzTbZ1TTPvRYUo1KbCvzkWIgWqGjxzj4901
 DHcyK0lZtIIoVaSKpuSpQfSERbQgXEqdVe2DscVmsdA9ZC7/M8Po1mI18GHR7xEzDtrv
 Wkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169165; x=1778773965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=s4SA//SBEYf0uzY8+aoVUwQDVhHqm5NWkavOs4X9AHU=;
 b=HIAlA19S7WyfxbU74IrMfpO/fNjF0Zp2ttEPHLeeaF7ipXxIKdIYBDaIGqKeFFCnA+
 ICjGlt6awVwj903Joa0eTu1CZyh4fkdVAwlackJZ0mOZ33XxQ6hvBTwIfuALoBrBwa7M
 owyrC4M3pU0+eY/pY2YvpuCnLY7ThhaVlXok8U/b73g3IndIvAAdD2+rAnuF1+L9Dfn9
 kdqAeqDryYgofpPQUBp/e6j3oQEBWO53pyTFJBYiReLNRNfHBFSNj1EoAH/AqRV+ZIjx
 5XI6OPVye67WcZ6u8sF9ynMj4HcrfzIdrGqxyQ5duLtfYJ7hVssq1j7FnzCV5ytaK7Vj
 R+Fg==
X-Gm-Message-State: AOJu0YwsVtwi5VxcgtbX3APAayLt1l4FJ5K5Hw0nwYRT4a7QUuQGwIeH
 7ARCGRP4HYTd5AeMgyAsghuXB1FhVfO58sk+TR3tI4bFQNUosP9ORYWqUdYSpuYcrTl8Yvb1Br+
 /SlbN
X-Gm-Gg: AeBDietGiYHGHZaPt4yMlpZfNtjzgzDN7r5LuuUaaH6SQqbRGONfP72nlP7g3QV0mvM
 /N9IeKTpVjrN6ZxDnE0wA/koOifUrZSkzmNLxivJqbBNHU1wDjYxdo1meWuATmGvOTrQIX6GUXG
 HQ8PMrq+V9o8RKSJeoJ5L2EMP8CnwY5uhpEEziulKo5j0B+gyjWybxGrmpv6BuBdX1Zww0yUfnS
 b0cVN9y7Eb/9DnVcnux0zcsdgmIZ/Bdf0SH7VJKExr69+GfK5ECeJ47mlzJxFvppGh9/9RZAPw7
 itgtz5UXPZUOmcN66TpsBCzswwDUl42bmRlHbVxB55HjwwXq/6+yoDN5uZ5N08uS4ySgn+i/HMl
 kEXhuA56UKPzsBgdCbP5W+HWIwBd2Cq12tiJvtGQYlUZlBDxEmNAitQMAD/Lb5pDTljFSBrCiC0
 bNG7oYNUemAtbNVMajMLjDAap8GcImHysKRXV2/kqyDUQAfgWqqCVCY0zNIGUZtzGrQXwE+BVdF
 SzYUuI040pevbgWIRUbvCEl1HrDbOaFD/ZnoPzlMg==
X-Received: by 2002:a05:600c:a30b:b0:489:1c1f:35f9 with SMTP id
 5b1f17b1804b1-48e51e1773bmr103996645e9.9.1778169164471; 
 Thu, 07 May 2026 08:52:44 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 49/67] target/arm: GICv5 cpuif: Implement GIC CDEOI
Date: Thu,  7 May 2026 16:51:36 +0100
Message-ID: <20260507155154.1886557-50-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Implement the GIC CDEOI instruction, which performs a "priority
drop", clearing the highest set bit in the APR register.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-50-peter.maydell@linaro.org
---
 target/arm/tcg/gicv5-cpuif.c | 21 +++++++++++++++++++++
 target/arm/tcg/trace-events  |  1 +
 2 files changed, 22 insertions(+)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 52abe175bb..5e613362bc 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -554,6 +554,22 @@ static uint64_t gicr_cdia_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return hppi.intid | R_GICR_CDIA_VALID_MASK;
 }
 
+static void gic_cdeoi_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                            uint64_t value)
+{
+    /*
+     * Perform Priority Drop in the current interrupt domain.
+     * This is just clearing the lowest set bit in the APR.
+     */
+    GICv5Domain domain = gicv5_current_phys_domain(env);
+    uint64_t *apr = &env->gicv5_cpuif.icc_apr[domain];
+
+    trace_gicv5_cdeoi(domain);
+
+    /* clear lowest bit, doing nothing if already zero */
+    *apr &= *apr - 1;
+}
+
 static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     /*
      * Barrier: wait until the effects of a cpuif system register
@@ -606,6 +622,11 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .access = PL1_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
         .writefn = gic_cdrcfg_write,
     },
+    {   .name = "GIC_CDEOI", .state = ARM_CP_STATE_AA64,
+        .opc0 = 1, .opc1 = 0, .crn = 12, .crm = 1, .opc2 = 7,
+        .access = PL1_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .writefn = gic_cdeoi_write,
+    },
     {   .name = "GIC_CDHM", .state = ARM_CP_STATE_AA64,
         .opc0 = 1, .opc1 = 0, .crn = 12, .crm = 2, .opc2 = 1,
         .access = PL1_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
diff --git a/target/arm/tcg/trace-events b/target/arm/tcg/trace-events
index 13e15cfcfc..fcb3106a96 100644
--- a/target/arm/tcg/trace-events
+++ b/target/arm/tcg/trace-events
@@ -5,3 +5,4 @@
 gicv5_recalc_ppi_hppi(int domain, uint32_t id, uint8_t prio) "domain %d new PPI HPPI id 0x%x prio %u"
 gicv5_gicr_cdia_fail(int domain, const char *reason) "domain %d CDIA attempt failed: %s"
 gicv5_gicr_cdia(int domain, uint32_t id) "domain %d CDIA acknowledge of interrupt 0x%x"
+gicv5_cdeoi(int domain) "domain %d CDEOI performing priority drop"
-- 
2.43.0


