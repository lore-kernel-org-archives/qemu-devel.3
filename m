Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F08CC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY3T-0006yb-8R; Tue, 13 Oct 2026 04:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY37-0006r9-35
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:39:53 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY34-0007b7-Ok
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:39:52 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a0286c981dso22786535e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880789; x=1792485589; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y5b5DfgJa/hfRu28byh9TDYXyYRAsZXk05ndwETZi9c=;
 b=neSbMe0mtq/lYKcWqIMHAuFAm3krRGxJFFE8TNIw8TnvYPWRE+DKji7OOvS6of4dg/
 yd/tpgb36QZdOwzUKVqqTlS85uV2Uc0iAPcmrFZIUA1iRDvgnO55oYdnUowjyQjAwKqi
 WGT0b5AzYW6DpiP1WjLXeOn0Rj9Nqdb+uBqSKeMY0VIZnUBw+vPqcyEwivqDOe/OTfvu
 bTqYANALz5DTN9yvHdpeJaVPQKNpOxg+cJ0X4sOeM2wrK3z/2X04snJR0MyMBmn/4EYW
 lm87Vwx/D36KxnWfdXAU48HJz0+a9/0YAdVxHGUIFB3jHiDHhzJ48bGOPCcg7SIgWeDM
 VXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880789; x=1792485589;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y5b5DfgJa/hfRu28byh9TDYXyYRAsZXk05ndwETZi9c=;
 b=EVjKK6jtJdYYYc4JVhlwVrlktomwrNQOwoqciVPOc53zLEYfuP9+vaqYsApqXF0ecw
 ipYFBAmeiMZ90o2UuozWRJTz4ItX8+BHmGhSgUW9iVKHSLVhhJ/srlvw0sCQ8fnuqvVY
 kNtri4nD4xyn5iHEpxZbpgI0ppFuNLgugXd/1s3BRXWOenllWbo+ToI5U2I8/2SJ6EAC
 9q4BzWZBp8K+XpY1kpj5iiVqiLFGgLbxKFLyDNEEjrTKMJou2w3o132TecThQF/UsyFx
 nYouGp26+YsKc3OqpBBSUlN2T8WTPAg4/MZjJiIvxYJ8Xgk07p8/YC1khAidlnbZRff+
 tbug==
X-Forwarded-Encrypted: i=1;
 AKwUvBwSpgZCRL8zsFvMhVVqeeEHVwUdD6L55G4OPbvD6kOVMo2WQWEN85+pGeYvpOCEKMrwiUGpnvpxaEsY@nongnu.org
X-Gm-Message-State: AFq9FYIcF8vi5YWNWDJoQvyQg0LMsnpHK2FqxUMZx1pzjlnONseR8i6H
 BWD8ETcHq8n9/8f7VnoPZ3bwX7X0bQjC+W0pd5Zy2XA4OArziHjQLcj8ViqxjV0lt/1Bf50GqZT
 yPve2Nnc=
X-Gm-Gg: AYBFou3B9a2jI3RtHMBCD2qNoH9vr5fP6b7IXeTzGuLTocAd/w3n/P9e8HlFBBZUxtk
 elo/q/wGnKOrLObIA8dJ3/y8QmGHdX7IqbOODUaiN3DrZwQPpENM3pllIFhftt68YPXod82dW4c
 vAWV5dR8ZH6yof0RAHiLgweAUv4CVWC8VEOtknxn98qcJf4hFaOTOjgkLp3nBq1uwkvRwZW5Slr
 LV2+416ilQoT+dRs/9Lm9t3EV1ZY/BxMlgUZxpyT7BMAXkQcz4+YgIAzlNzNG0I+rkoopFdQoI0
 sjoi9XG1VL0LeZFdK7xyxWnSxXOemDQJs3Bv3NgGwixKhBTq/kHQp3BMl9efwQyXNQ3VJbJA2Ez
 OAKoMOWWUCyDJiCGioCP6OiknWXrrs5RFfTg8OW1dMSLMFgvuNUSci+AsaXI7BDIGjJkctQCZHq
 K0YHUSw/swAYohzM15UVQFZej3+toUTy0xG+VYaON4m50gdaXcYERc2BbqfutjVO80SW1iZnNtU
 BfRPQXh3/1yK2JECqm03nZL0C9EawDF/98sxssRq2TtSySV7RzXTxg9hypRRwOTSR4ni602v0xj
 gGY=
X-Received: by 2002:a05:600c:8b06:b0:4a1:7ce1:2eaf with SMTP id
 5b1f17b1804b1-4a18e4e0963mr234306935e9.34.1791880789239; 
 Tue, 13 Oct 2026 01:39:49 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:39:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 09/86] hw/intc/arm_gicv5: Pass CPU index to CPU interface
Date: Tue, 13 Oct 2026 09:38:16 +0100
Message-ID: <20261013083933.1024405-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

In a real hardware GICv5, the IRS knows which CPU is talking to it
because each IRS<->cpuif link is a separate 1:1 connection.  In
QEMU's implementation, the cpuif code calls functions like
gicv5_set_priority(), and currently we usually don't pass anything to
tell the IRS which cpuif is making the call, because mostly the IRS
doesn't need to care.  There are a few places where it does need to
know, notably in gicv5_get_hppi().  Here we have the cpuif pass its
IAFFID; the IRS then looks that up by doing a linear search of the
cpu_iaffids[] array to get the index of the CPU.

For virtualization, many of the stream commands which don't currently
need to say which cpuif is making the call will have to start doing
so, because changing the state of a virtual interrupt requires the
IRS to look up the VPE which is resident on the calling cpuif. This
makes the IAFFID->cpuidx lookup seem increasingly awkward.

Change gicv5_set_gicv5state() to pass the IRS's CPU index value for
the cpuif as well as the guest-visible IAFFID, and make the stream
functions identify the cpuif by CPU index rather than IAFFID, to
avoid the unnecessary IAFFID->cpuidx lookup.

As this is now three GICv5-related things that we are keeping in the
CPU state struct, we push them into a sub-struct to keep them tidy.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/intc/arm_gicv5_common.c         |  2 +-
 include/hw/intc/arm_gicv5_stream.h |  6 ++++--
 target/arm/cpu.c                   | 10 ++++++----
 target/arm/cpu.h                   | 10 ++++++----
 target/arm/tcg/gicv5-cpuif.c       |  6 +++---
 5 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index cc67246686e..cfadfee4f05 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -176,7 +176,7 @@ static void gicv5_common_realize(DeviceState *dev, Error **errp)
     }
 
     for (int i = 0; i < cs->num_cpus; i++) {
-        if (!gicv5_set_gicv5state(cs->cpus[i], cs, cs->cpu_iaffids[i])) {
+        if (!gicv5_set_gicv5state(cs->cpus[i], cs, cs->cpu_iaffids[i], i)) {
             error_setg(errp,
                        "CPU %d (IAFFID 0x%x) does not implement GICv5 CPU interface",
                        i, cs->cpu_iaffids[i]);
diff --git a/include/hw/intc/arm_gicv5_stream.h b/include/hw/intc/arm_gicv5_stream.h
index 3cc9f611557..f45072d8c57 100644
--- a/include/hw/intc/arm_gicv5_stream.h
+++ b/include/hw/intc/arm_gicv5_stream.h
@@ -20,7 +20,8 @@ typedef struct GICv5Common GICv5Common;
  * gicv5_set_gicv5state
  * @cpu: CPU object to tell about its IRS
  * @cs: the GIC IRS it is connected to
- * @iaffid: the IAFFID of this CPU
+ * @iaffid: the IAFFID of this CPU (guest-visible)
+ * @cpuidx: the index of this CPU for this IRS (QEMU-internal)
  *
  * Set the CPU object's GICv5 pointer to point to this GIC IRS.  The
  * IRS must call this when it is realized, for each CPU it is
@@ -29,7 +30,8 @@ typedef struct GICv5Common GICv5Common;
  * Returns true on success, false if the CPU doesn't implement the
  * GICv5 CPU interface.
  */
-bool gicv5_set_gicv5state(ARMCPU *cpu, GICv5Common *cs, uint32_t iaffid);
+bool gicv5_set_gicv5state(ARMCPU *cpu, GICv5Common *cs, uint32_t iaffid,
+                          uint32_t cpuidx);
 
 /*
  * The architected Stream Protocol is asynchronous; commands can be
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d9e6d1ad771..4731d1cc7c4 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1215,17 +1215,19 @@ static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 }
 
 #ifndef CONFIG_USER_ONLY
-bool gicv5_set_gicv5state(ARMCPU *cpu, GICv5Common *cs, uint32_t iaffid)
+bool gicv5_set_gicv5state(ARMCPU *cpu, GICv5Common *cs, uint32_t iaffid,
+                          uint32_t cpuidx)
 {
     /*
      * Set this CPU's gicv5state pointer to point to the GIC that we are
-     * connected to, and record our IAFFID.
+     * connected to, and record our IAFFID and CPU index.
      */
     if (!cpu_isar_feature(aa64_gcie, cpu)) {
         return false;
     }
-    cpu->env.gicv5state = cs;
-    cpu->env.gicv5_iaffid = iaffid;
+    cpu->env.gicv5.gicv5state = cs;
+    cpu->env.gicv5.iaffid = iaffid;
+    cpu->env.gicv5.cpuidx = cpuidx;
     return true;
 }
 #endif
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 06ebed4a8fd..82c13186b68 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -814,10 +814,12 @@ typedef struct CPUArchState {
     const struct arm_boot_info *boot_info;
     /* Store GICv3CPUState to access from this struct */
     void *gicv3state;
-    /* Similarly, for a GICv5Common */
-    void *gicv5state;
-    /* For GICv5, this CPU's IAFFID */
-    uint64_t gicv5_iaffid;
+    /* Information the GICv5 IRS passes to us */
+    struct {
+        void *gicv5state; /* GICv5Common struct */
+        uint64_t iaffid; /* this CPU's IAFFID */
+        uint32_t cpuidx; /* GIC IRS-internal index of this CPU */
+    } gicv5;
 #else /* CONFIG_USER_ONLY */
     /* For usermode syscall translation.  */
     bool eabi;
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 517c780d1f7..eea66a4140e 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -87,7 +87,7 @@ FIELD(ICC_HPPIR_EL1, HPPIV, 32, 1)
 
 static GICv5Common *gicv5_get_gic(CPUARMState *env)
 {
-    return env->gicv5state;
+    return env->gicv5.gicv5state;
 }
 
 static GICv5Domain gicv5_logical_domain(CPUARMState *env)
@@ -147,7 +147,7 @@ static GICv5PendingIrq gic_hppi(CPUARMState *env, GICv5Domain domain)
         return GICV5_PENDING_IRQ_NONE;
     }
 
-    irs_hppi = gicv5_get_hppi(gic, domain, env->gicv5_iaffid);
+    irs_hppi = gicv5_get_hppi(gic, domain, env->gicv5.iaffid);
 
     /*
      * If the best PPI and the best interrupt from the IRS have the
@@ -788,7 +788,7 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 5,
         .access = PL1_R, .type = ARM_CP_NO_RAW,
         /* ICC_IAFFIDR_EL1 holds the IAFFID only, in its low bits */
-        .fieldoffset = offsetof(CPUARMState, gicv5_iaffid),
+        .fieldoffset = offsetof(CPUARMState, gicv5.iaffid),
         /*
          * The field is a constant value set in gicv5_set_gicv5state(),
          * so don't allow it to be overwritten by reset.
-- 
2.43.0


