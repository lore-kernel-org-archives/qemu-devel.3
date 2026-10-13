Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0A9CA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY4O-0000xZ-NN; Tue, 13 Oct 2026 04:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3e-0007c5-LK
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:27 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3b-0007vF-6N
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:26 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4956869750eso20245505e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880822; x=1792485622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qRt/rpYOT3lnzhVYlcKmgZdrFw/mrh/LFo/lM8UvZ8s=;
 b=JhGvwP+KlygYRwzVUGiuIw3B33GmjyjXVOU68NQhdECV+j14vO+oTOr23NiUVGXBzW
 YjM/hDyktPb+717rSXqGEyYDg4MPpzqzXGrWNl/6N/RH0d0leO+I2Vhq+P0wth1GbAt+
 gKwAZyggwIj9pYx+mRHfFgne2rM4TWRVdkNwNTfoWnkiNdKz4Sr3qRX6sPyj7NmD2Ilc
 1zPNRVJog4HEE5BfmHcE25pyhgHCdMCqvhUeDEKx6gw6fc6j7xR/PpahwzheqywqQdqS
 hyLN2ia9YFKZbA+hBZoXg3mPtX3TQJTJkiUD4ECaNGmJbH+k8QOGqBCTECB4Ljj/Ogxe
 TeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880822; x=1792485622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qRt/rpYOT3lnzhVYlcKmgZdrFw/mrh/LFo/lM8UvZ8s=;
 b=ytTLYVhJ7PVwX/lryzQmUsPMcZWWQqLSpqioIvYa/8EIG6Y1xc38xAgQtuJi+hxhjz
 MfEqOljvuqbw6ErvIAT4+7mh+A/Wf7/U9SODa1qcwhvYKRrSZ9IjJChVgfl1H342Vqmq
 Hm0ziiy3v0H8h38uwtxzyScTS2UisQk7jtaXCGS08sTtSe5BuxpMFgHIfEdzVMTPvhR8
 dqXM6AqvIQJKvmBN9kRICygnUO+n6OiCkzp2Y+Y93///C69egLXia5n94bNezT7hhW+b
 88qfvUy8eeu9pcrjfxmh5eskMtBbsgn4XzSs7acEbPDb2QTuO+aoZVidwxQHubXmWdTr
 uRXg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0ze4AfSvIIyzqZeIdYdyONO0Rx1tGc/xX+B7GCGaKveyCXzEenbRYGoWJYTfUuruRYKEdAvC2e11j@nongnu.org
X-Gm-Message-State: AFq9FYIwuM3g5t18DJe17n00TCKlcpvFRL+TRz6hJoSrVbBHINnOJm7K
 nuSzWcccX092XeLasXvLwMSDTqemMCLtLD8P+DkGiHeBBzvmyf4M6X7lEKKBn+7UIh4juoRHJhI
 WfWpF+zk=
X-Gm-Gg: AYBFou1p+R2ZMEfChcNKdC6P83exYwdDy+9oUZ6FQtSGrHmuWyggphSgaZXM1bpNyFo
 zzSevIceKEnsoAdWjD/YbQh9VtsjEohaGREQeii5SUnD6TTIG7chQKu061L7EEun5MCaOhsG+Fp
 JoVUn6SCLf73dQYt9UVCKilh2gl5eDuJ/NyT5Epz+ICGwMC6OwjBHTxWPwUZ0nOpEnXpcHjbjxs
 1xNxsPpdJdhy2TYMRGQ25eZupK/+c4zbtQ9cnLUUDbLP6JMpq2d5fqPqiQDPkY4ETIecwrUBvgm
 xHpyBvNBrbCQtNQSZrj7bN48VlUMCt6B0Hra31c6Q8CegCJoW4q3JXNo/tkiaY5kRt68GTxSi/S
 GeP8Cp1yqCuGW4gGUefMF/Bapk9CzHXol/Zv15hEZ2pN/LLgp72yvONxvR4u0KyTdVsOMDOlKqb
 /RIxgnQX+1dcDX8TrbKF5ksebnia+e/g2LTbtgl6zjm/ByCWsnPctQ7IlOjd8t8BX1FsUjISnhc
 mZ+vzDiQzd/8eSkDSjS+hmGeSiPSWtq0Wuuep9/KgxIxF039578knBAjokA0HKR6LJcKpzCafPf
 Apw=
X-Received: by 2002:a05:600c:3e83:b0:4a1:6d35:779a with SMTP id
 5b1f17b1804b1-4a18e446880mr201721765e9.3.1791880821725; 
 Tue, 13 Oct 2026 01:40:21 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 33/86] target/arm: GICv5 cpuif: Implement ICV_HPPIR_EL1
Date: Tue, 13 Oct 2026 09:38:40 +0100
Message-ID: <20261013083933.1024405-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Implement the redirection of ICC_HPPIR_EL1 to the virtual
ICV_HPPIR_EL1 register.  This requires us to calculate the highest
priority pending interrupt for the virtual interrupt domain, using a
gic_virt_hppi() function that works in a similar way to the existing
gic_hppi() for the physical interrupt domains.

As we have not yet implemented IRS_CONTEXTR_EL2, we leave a
placeholder "IRS does not have a virtual HPPI candidate"; we will
fill this in later by calling gicv5_get_hppi() when the IRICHPPIDS
bit in that register tells us we should.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/gicv5-cpuif.c | 73 +++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 5d0d599ddd5..d2454011b40 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -70,6 +70,9 @@ FIELD(ICC_HPPIR_EL1, HPPIV, 32, 1)
 FIELD(ICH_VMCR_EL2, EN, 0, 1)
 FIELD(ICH_VMCR_EL2, VMPR, 27, 5)
 
+FIELD(ICH_VCTLR_EL2, EN, 0, 1)
+FIELD(ICH_VCTLR_EL2, V3, 1, 1)
+
 /*
  * We implement 24 bits of interrupt ID, the mandated 5 bits of priority,
  * and no legacy GICv3.3 vcpu interface (yet)
@@ -153,6 +156,13 @@ static uint64_t gic_running_prio(CPUARMState *env, GICv5Domain domain)
     return hap < 32 ? hap : PRIO_IDLE;
 }
 
+static uint64_t gic_virt_running_prio(CPUARMState *env)
+{
+    /* Return the current virtual running priority */
+    uint64_t hap = ctz64(env->gicv5_cpuif.ich_apr_el2);
+    return hap < 32 ? hap : PRIO_IDLE;
+}
+
 static GICv5PendingIrq gic_hppi(CPUARMState *env, GICv5Domain domain)
 {
     /*
@@ -196,6 +206,59 @@ static GICv5PendingIrq gic_hppi(CPUARMState *env, GICv5Domain domain)
     return best;
 }
 
+static GICv5PendingIrq gic_virt_hppi(CPUARMState *env)
+{
+    /*
+     * Return the current highest priority pending interrupt for the
+     * virtual interrupt domain, if it has sufficient priority to
+     * preempt.  If there is no interrupt that can preempt we signal
+     * this by returning a struct with prio == PRIO_IDLE.
+     */
+    GICv5PendingIrq best, irs_hppi;
+
+    /*
+     * R_ZKPVN: No virtual HPPI if EL2 is not implemented and enabled
+     * in the Security state identified by SCR_EL3.{NSE,NS}, or if the
+     * enable bits in ICV_CR0_EL1 (stored in VMCR_EL2) or
+     * ICH_VCTLR_EL2 are 0.
+     */
+    if (!arm_is_el2_enabled(env) ||
+        !(env->gicv5_cpuif.ich_vctlr_el2 & R_ICH_VCTLR_EL2_EN_MASK) ||
+        !(env->gicv5_cpuif.ich_vmcr_el2 & R_ICH_VMCR_EL2_EN_MASK)) {
+        return GICV5_PENDING_IRQ_NONE;
+    }
+
+    /*
+     * TODO: When we implement ICH_CONTEXTR_EL2, we need to check
+     * IRICHPPIDS and if it is 0 get the IRS candidate HPPI.  For now,
+     * set irs_hppi to "no candidate".
+     */
+    irs_hppi = GICV5_PENDING_IRQ_NONE;
+
+    /*
+     * If the best PPI and the best interrupt from the IRS have the
+     * same priority, it's IMPDEF which we pick (R_VVBPS). We choose
+     * the PPI.
+     */
+    if (env->gicv5_cpuif.virt_ppi_hppi.prio <= irs_hppi.prio) {
+        best = env->gicv5_cpuif.virt_ppi_hppi;
+    } else {
+        best = irs_hppi;
+    }
+
+    /*
+     * D_MSQKF: an interrupt has sufficient priority if its priority
+     * is higher than the current running priority and equal to or
+     * higher than the priority mask.
+     */
+    if (best.prio == PRIO_IDLE ||
+        best.prio > FIELD_EX64(env->gicv5_cpuif.ich_vmcr_el2, ICH_VMCR_EL2, VMPR) ||
+        best.prio >= gic_virt_running_prio(env)) {
+        return GICV5_PENDING_IRQ_NONE;
+    }
+    return best;
+}
+
 static void gicv5_update_irq_fiq(CPUARMState *env)
 {
     /*
@@ -844,8 +907,14 @@ static void gic_icc_pcr_el1_reset(CPUARMState *env, const ARMCPRegInfo *ri)
 
 static uint64_t gic_icc_hppir_el1_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    GICv5Domain domain = gicv5_logical_domain(env);
-    GICv5PendingIrq hppi = gic_hppi(env, domain);
+    GICv5PendingIrq hppi;
+
+    if (gicv5_icv_access(env)) {
+        hppi = gic_virt_hppi(env);
+    } else {
+        GICv5Domain domain = gicv5_logical_domain(env);
+        hppi = gic_hppi(env, domain);
+    }
 
     if (hppi.prio == PRIO_IDLE) {
         /* No valid interrupt */
-- 
2.43.0


