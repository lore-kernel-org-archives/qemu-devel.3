Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047DD606A33A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Ac6FvT6b
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsEK-0005rq-EL; Mon, 02 Nov 2026 08:37:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsDI-0003YD-Bw
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:40 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsDF-0002LX-WD
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:39 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso1349829f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626596; x=1794231396; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P3F4NORD7jfEcdLFIuCGWiOqX1NEWrHa/adPxrxWP1s=;
 b=Ac6FvT6b5L15T7s40897vjskFoEIOhijKGaJwGbMQ1syxjGRnUURqcmIs406LrJtCr
 9hAXjpwhZZYuKx8j4xaRB29wh1qNozvRNIX8IwSB27PbrrwP6bi6HXQBnejx/kMDnMIE
 4/uZ/jiGpyfSQKUuP3Grx9RJ1HtVY7wgusQVLB/0OIBXKj9rQks3Y6EakeEKqDpovviw
 Ddxa9usAU6i8K/jjSYIjmtfNwJ9Ewypwm88tJQXnsPYgdHxXnXs50zxPfMwtR72+vsrT
 jrfds63ZwrxvBzBqBsuvP9He6KhQAD28RYzVTfF16spdLJJ13Tg80RLyzAYCYsEotWnG
 SxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626596; x=1794231396;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P3F4NORD7jfEcdLFIuCGWiOqX1NEWrHa/adPxrxWP1s=;
 b=rzdmz+i+2OiqfmSw2Dfi6GGIpFLv4p6R57kqzQcVWg10WG8PGJ8oR6azws1Fwohcj8
 p4FLvd9cItqrbSbjE7CIyK3rhwdnQgEXuyGN15jOWRCRKYB2bd0rxi661i5gMTvVJ4N1
 5M+YbaBTwwAJ4nJyDSZMEbuIujdxhnRlLWuiklbTVyYRlRO96W6a545mghEPFPH6k+Zp
 BP8JuRqZlwXRHi5dUa7ypyx2p0ANWl3/VInDKq2nAWOWNb3VUNz2+wNuQUVAIliIhRi0
 cxMb9cDxDhPI9s4uxe5odCyBLLCw5GCdRcVT0AJUCt25GqqMm5W6+SAgDVod4ZazTkER
 yRAw==
X-Gm-Message-State: APuU4Z911oA6qXvMWLJEgYrihGq2ohhiVJ0b6j1CnxNcMrVHAv5SqYEB
 2mIdQ/zlqpLeg2yEhoc3IzyWOE2Jz5W0m9KWTXSadymy1J3S0kMYLMJ5jOVkuJn3zXdg9PM/Yzd
 w+EquF6M=
X-Gm-Gg: AYBFou1C0grDwJp8rIA254frt+iisxORQt/rO9zHdnrdzFxSXyzuFbu1sK4tSEwaWU4
 iml9JUMTyYmnowTn0hL8Nd0D8Riz5tpgOet3qUyh7cjRG+1Yw+nLNFdSRoERVOS1lsaBktNqOYE
 kCV6BbgjDGOdMDF5q+vFX2y8OqGmL36V1Hzm0Dy8rJoRBn5wyW5bYSxzkjHigo5dCZblh373NYi
 Yhf/Gu3psg2cZN3LhexHArJRYSYSEwXuro+MvMumbbwrRrPwWupxjM1fmfLGBIfRjsiXgfyTn6Y
 iLc4PgRMhEtJ6YjpaDRTBG52p2MYwwXSAwPar9l+9xB9rc0g1e3PhorTPoomd9pogLUatcK9K5k
 BwVgaOZtq/bCEJnIzxLpDH783nIDI/ALiHntpM2M8aY92Iq/I+caE6jlCpwT4VekmKlnLin86wf
 qZka6RAyti4tLcZcF0Fvv/tkntJhv6c5PDwp/YkyaTWV1rbKOvBr88s28PQauS6LOb7YRNtrkKS
 Cf5+hDQg+f1GUqclFkLY35xeDQznisnaHKRDQ493LyKWOYrdGWdF5fyh68B92NDV2/ptnz6hKgl
 Uo8YhRzD75bln2Su6ie+zsKT6IaeywCtlqdbg+WxEOqwaHyxvTxFY7+UGmCm8csFZnO9SOyy6kZ
 b7jBDWzndhvGNZ4BkrdBNsuOOdyYSYLdwhw==
X-Received: by 2002:a05:6000:24c4:b0:48d:f9dd:e3de with SMTP id
 ffacd0b85a97d-48e6e511219mr23177054f8f.45.1793626596442; 
 Mon, 02 Nov 2026 05:36:36 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/47] hw/intc/arm_gicv5: Pass CPU index to CPU interface
Date: Mon,  2 Nov 2026 13:35:42 +0000
Message-ID: <20261102133547.1375701-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
 include/hw/intc/arm_gicv5_stream.h |  6 ++++--
 target/arm/cpu.h                   | 10 ++++++----
 hw/intc/arm_gicv5_common.c         |  2 +-
 target/arm/cpu.c                   | 10 ++++++----
 target/arm/tcg/gicv5-cpuif.c       |  6 +++---
 5 files changed, 20 insertions(+), 14 deletions(-)

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
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index dae79539b54..b2f393f5018 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -816,10 +816,12 @@ typedef struct CPUArchState {
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
diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index b155486af65..2920b11cc39 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -173,7 +173,7 @@ static void gicv5_common_realize(DeviceState *dev, Error **errp)
     }
 
     for (int i = 0; i < cs->num_cpus; i++) {
-        if (!gicv5_set_gicv5state(cs->cpus[i], cs, cs->cpu_iaffids[i])) {
+        if (!gicv5_set_gicv5state(cs->cpus[i], cs, cs->cpu_iaffids[i], i)) {
             error_setg(errp,
                        "CPU %d (IAFFID 0x%x) does not implement GICv5 CPU interface",
                        i, cs->cpu_iaffids[i]);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 0ae0d581be6..71681447b21 100644
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
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index e7b80b83754..74c456f60c6 100644
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


