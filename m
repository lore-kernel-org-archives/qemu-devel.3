Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F153EC110C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:10:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKc-0002Is-Ls; Mon, 23 Feb 2026 12:02:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKW-0001zM-IS
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:44 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKT-0000AY-0I
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:44 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso36217965e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866159; x=1772470959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FzYN9ygidJdhGyDwIINOqZeaIIMy2JouxjcXfZjOhMI=;
 b=HvI3vFygYfFA0/R1Z2ZTccUtH/6Y+NLQHq6xONzzkMQfRBThv2p4TJ6MhOHdEVNSu4
 H27rGofG2EjDABHbeMLhuy2dzwXDvoZZvVFn6phrf5lC8bHkq2H6OHWxbUC5iIZGmuoK
 8Zcv6LYk5G3eVxhOHnLlxuimo+e3XyM2sUVciUrLVgCObNHkA1o+/a3DxEunGNs9YH9c
 u3NdOXrcjji7b+IelJ7JcdPJlTeIfZNDGU9fy5IfDrgTw8X/Ib0hTtgvEennCkZbvUXT
 hElO5ZTbC/nk0tQlion5GDg4J8nC5cI9tCgY25owWqkGEjIucHtJW52L/LssmoOEinlM
 Aaug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866159; x=1772470959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FzYN9ygidJdhGyDwIINOqZeaIIMy2JouxjcXfZjOhMI=;
 b=Ya7u6pblhv7p8LwKOsiB7DDRieV99ozyn6bMgXkBFwwCbo5qbpVn3KJcQL4u8KRp+X
 gKkiw1DnzAS27/ebv51zpNdf7j7VMnQnCDBYowu/Z6Wi3AIFiXr6hHW3s/9wp8OAJfsC
 g8nIXRbz1skex8q8O3QkHfVW1vbwL21V5ZemPIzCoxmJMK4H+929S1QCXl49jcm3eUnE
 2j03jmXuSHpV2FXfgTgvXACnsN9qENWR/jyzoGGGGkCUd1UOB3B8S3X8ahJZHiOznDBj
 2g74SAxAI225GPkek9QsI3KZuphZK3aQ9HZnioe/aQMgPMJShJnUL2c7erqhGWqagqW+
 i3+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMQUG233aUO6o48wjyjuBtYhVwcmykMmmphmgZzhqXqEWXIfewQt9xaCZGWriJkR9IikNUPiM5QjxR@nongnu.org
X-Gm-Message-State: AOJu0YyFPc678Wu1Mo0IMGTYo3ekhke4BH2UfD85p6aw+3bS4hj1qe8Y
 Z3udeWvq03gHJBqYrZqaWS4LWISqwV0zscgb/NoO+HF4+wnPqqBhsjPXhG2ZK0gAI28=
X-Gm-Gg: AZuq6aKH/UnW6E4J/cX1fVldL1blE/5pqx4brURpHGd5pLt1h4TQJS5EylLha1JMFSs
 zW+bqcrd2eU50uecCP9M484uLUp6RI6s0KCy3S7QnSSU8oJviYy60T3TbQScCdCbwKmUBy8peLr
 QhLE/td9KTJNExgXURU/JJAPCWxjMpARm+3Sh5vNzUyCl5049rIeyeMa60HdDs6XJhsJgzpDQch
 jUsNmsb4nMJxnuiOAfy6RRqK/vgYrzfhCqafPux24g6/mJBaIKNPPZqy+UlRRWiUBM0tU25KN+1
 0+8V/cKjMnsngaU3ynDy6WYl9NuVRzVivdDzX/pbXi2pBMRu7A857Q1lZNPdRB05S5CNvf56KSu
 2pkPTodq6HA0+ntLDImyeDv0rD5/x24sH500FHZWF6b1pQ8gXyqLRZdETkCYKZ9ttO68ZQQ7InN
 3qWjoQ27KsdvF16X6a4cGBqIxPcdfGLG9nG/aRgsJgg1+agh7gSDOQQ/JNN1KGfH2uMNaw57D/6
 TvNYOIAj9Ub95gVXL8cL5pcjJEERFA=
X-Received: by 2002:a05:600c:6990:b0:483:6a8d:b2f9 with SMTP id
 5b1f17b1804b1-483a95aa328mr156841225e9.5.1771866159369; 
 Mon, 23 Feb 2026 09:02:39 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 21/65] target/arm: GICv5 cpuif: Implement GIC CD* insns for
 setting config
Date: Mon, 23 Feb 2026 17:01:28 +0000
Message-ID: <20260223170212.441276-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Implement the GIC CDDIS, GIC CDEN, GIC CDAFF, GIC CDPEND and GIC CDHM
system instructions.  These are all simple wrappers around the
equivalent gicv5_set_* functions, like GIC CDPRI.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/gicv5-cpuif.c | 108 +++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 072b38e785..c426e045d9 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -16,6 +16,25 @@ FIELD(GIC_CDPRI, ID, 0, 24)
 FIELD(GIC_CDPRI, TYPE, 29, 3)
 FIELD(GIC_CDPRI, PRIORITY, 35, 5)
 
+FIELD(GIC_CDDIS, ID, 0, 24)
+FIELD(GIC_CDDIS, TYPE, 29, 3)
+
+FIELD(GIC_CDEN, ID, 0, 24)
+FIELD(GIC_CDEN, TYPE, 29, 3)
+
+FIELD(GIC_CDAFF, ID, 0, 24)
+FIELD(GIC_CDAFF, IRM, 28, 1)
+FIELD(GIC_CDAFF, TYPE, 29, 3)
+FIELD(GIC_CDAFF, IAFFID, 32, 16)
+
+FIELD(GIC_CDPEND, ID, 0, 24)
+FIELD(GIC_CDPEND, TYPE, 29, 3)
+FIELD(GIC_CDPEND, PENDING, 32, 1)
+
+FIELD(GIC_CDHM, ID, 0, 24)
+FIELD(GIC_CDHM, TYPE, 29, 3)
+FIELD(GIC_CDHM, HM, 32, 1)
+
 static GICv5Common *gicv5_get_gic(CPUARMState *env)
 {
     return env->gicv5state;
@@ -51,6 +70,30 @@ static GICv5Domain gicv5_current_phys_domain(CPUARMState *env)
     return gicv5_logical_domain(env);
 }
 
+static void gic_cddis_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                            uint64_t value)
+{
+    GICv5Common *gic = gicv5_get_gic(env);
+    GICv5IntType type = FIELD_EX64(value, GIC_CDDIS, TYPE);
+    uint32_t id = FIELD_EX64(value, GIC_CDDIS, ID);
+    bool virtual = false;
+    GICv5Domain domain = gicv5_current_phys_domain(env);
+
+    gicv5_set_enabled(gic, id, false, domain, type, virtual);
+}
+
+static void gic_cden_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                           uint64_t value)
+{
+    GICv5Common *gic = gicv5_get_gic(env);
+    GICv5IntType type = FIELD_EX64(value, GIC_CDEN, TYPE);
+    uint32_t id = FIELD_EX64(value, GIC_CDEN, ID);
+    bool virtual = false;
+    GICv5Domain domain = gicv5_current_phys_domain(env);
+
+    gicv5_set_enabled(gic, id, true, domain, type, virtual);
+}
+
 static void gic_cdpri_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
@@ -64,6 +107,46 @@ static void gic_cdpri_write(CPUARMState *env, const ARMCPRegInfo *ri,
     gicv5_set_priority(gic, id, priority, domain, type, virtual);
 }
 
+static void gic_cdaff_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                            uint64_t value)
+{
+    GICv5Common *gic = gicv5_get_gic(env);
+    uint32_t iaffid = FIELD_EX64(value, GIC_CDAFF, IAFFID);
+    GICv5RoutingMode irm = FIELD_EX64(value, GIC_CDAFF, IRM);
+    GICv5IntType type = FIELD_EX64(value, GIC_CDAFF, TYPE);
+    uint32_t id = FIELD_EX64(value, GIC_CDAFF, ID);
+    bool virtual = false;
+    GICv5Domain domain = gicv5_current_phys_domain(env);
+
+    gicv5_set_target(gic, id, iaffid, irm, domain, type, virtual);
+}
+
+static void gic_cdpend_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
+{
+    GICv5Common *gic = gicv5_get_gic(env);
+    bool pending = FIELD_EX64(value, GIC_CDPEND, PENDING);
+    GICv5IntType type = FIELD_EX64(value, GIC_CDPEND, TYPE);
+    uint32_t id = FIELD_EX64(value, GIC_CDPEND, ID);
+    bool virtual = false;
+    GICv5Domain domain = gicv5_current_phys_domain(env);
+
+    gicv5_set_pending(gic, id, pending, domain, type, virtual);
+}
+
+static void gic_cdhm_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                           uint64_t value)
+{
+    GICv5Common *gic = gicv5_get_gic(env);
+    GICv5HandlingMode hm = FIELD_EX64(value, GIC_CDHM, HM);
+    GICv5IntType type = FIELD_EX64(value, GIC_CDAFF, TYPE);
+    uint32_t id = FIELD_EX64(value, GIC_CDAFF, ID);
+    bool virtual = false;
+    GICv5Domain domain = gicv5_current_phys_domain(env);
+
+    gicv5_set_handling(gic, id, hm, domain, type, virtual);
+}
+
 static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     /*
      * Barrier: wait until the effects of a cpuif system register
@@ -86,11 +169,36 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .opc0 = 1, .opc1 = 0, .crn = 12, .crm = 0, .opc2 = 1,
         .access = PL1_W, .type = ARM_CP_NOP,
     },
+    {   .name = "GIC_CDDIS", .state = ARM_CP_STATE_AA64,
+        .opc0 = 1, .opc1 = 0, .crn = 12, .crm = 1, .opc2 = 0,
+        .access = PL1_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .writefn = gic_cddis_write,
+    },
+    {   .name = "GIC_CDEN", .state = ARM_CP_STATE_AA64,
+        .opc0 = 1, .opc1 = 0, .crn = 12, .crm = 1, .opc2 = 1,
+        .access = PL1_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .writefn = gic_cden_write,
+    },
     {   .name = "GIC_CDPRI", .state = ARM_CP_STATE_AA64,
         .opc0 = 1, .opc1 = 0, .crn = 12, .crm = 1, .opc2 = 2,
         .access = PL1_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
         .writefn = gic_cdpri_write,
     },
+    {   .name = "GIC_CDAFF", .state = ARM_CP_STATE_AA64,
+        .opc0 = 1, .opc1 = 0, .crn = 12, .crm = 1, .opc2 = 3,
+        .access = PL1_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .writefn = gic_cdaff_write,
+    },
+    {   .name = "GIC_CDPEND", .state = ARM_CP_STATE_AA64,
+        .opc0 = 1, .opc1 = 0, .crn = 12, .crm = 1, .opc2 = 4,
+        .access = PL1_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .writefn = gic_cdpend_write,
+    },
+    {   .name = "GIC_CDHM", .state = ARM_CP_STATE_AA64,
+        .opc0 = 1, .opc1 = 0, .crn = 12, .crm = 2, .opc2 = 1,
+        .access = PL1_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .writefn = gic_cdhm_write,
+    },
 };
 
 void define_gicv5_cpuif_regs(ARMCPU *cpu)
-- 
2.43.0


