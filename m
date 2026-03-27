Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2568F10ED659
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65C9-0006wO-FJ; Fri, 27 Mar 2026 07:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65C6-0006sm-U0
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:38 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65C4-000880-EC
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:38 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439b9cf8cb5so1919286f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610255; x=1775215055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xnrF8FhdNtpjJjbzEATZqeP00jwVSkGfClNmWr825JA=;
 b=A4in92nWcDOxy2BWz68UynPFwiaFQgA8xORFoJRvimQY+QHDJXfOMFcpUxfqUgBbNg
 xYV8n0sckj8a7P91ISFPniRklhqC53nfurnNSNLiFXum5dTloD/9bNxwwq1cXtHpR25A
 txh/O64kVJxj9keXj1mK9nCsK/BnYV7dqa92KsEZG0tTeira116isj3altEOBbywA1b3
 lMva/ZykR1xUAwig6j+YDhAwmLT47ITNTSblkdF4yl+9hgBQzrFruC9Dlw3C4Nruo8g9
 wd8lZvz83O2rRBkf9XQ1KgJKM/kqD76CDYljG461tCwppyOl+z23JUX6addv43DjGBeK
 fmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610255; x=1775215055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xnrF8FhdNtpjJjbzEATZqeP00jwVSkGfClNmWr825JA=;
 b=J2sVBOQhkvY2iONiloiSfbAyu7k/APkTOOJ9QnBJRaxp9xbgHFQpfG8M0vlWk9Eaeb
 thQV6hufWK/2R76WHCapS2o16qg3l+owE3tm05yCmKXxS9UHxpt/l5u99eyi3AWYiiL0
 Ui4v39LL8EmLVWnSLq11xV8ZHEz6w+I5T8URmB3CBaVcK9H34n2iZkGdoD/yWvhvAkF1
 DxjMnHFyQWd33Q2FP9Bdqzq93vpsxtf/f9EXueDtwRMx78IlAY+9EBJkiaZwmwtX0/Vu
 09Go58nSvvHlxnNK+b57PouxqJrEsSYg2MwmPIgHpHyxunQTzA2uRsZq2REttVaOcjis
 om1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNTQSwLah2bufYl1zxFeTfAbSuqiLqajtnVhEF6Qtl0z9w7LD0+9+gRd4TQo5sJHhhratJi7J56IFi@nongnu.org
X-Gm-Message-State: AOJu0YxgNJWgg96SjDyycxMYWo3SVVCw7z5UUqmy0GaaJxmu6Juc/g99
 /6ZvMipEAfCwfuqRWv6EJMwX9/FGTc6YOjwG/L0G/ADEYwfY08PAaC85OJLnrMmz+TA=
X-Gm-Gg: ATEYQzyQkGU7DEwesvhjh4gthhIAQA/o74h3+813uBz+RwDFjHcu3NU/d6qz5P7HhK8
 GeZN84LkNInBdds3c90+9BANzooByw6IZDABU+toOTnod3afABgK6+1uNk6YdgwK/TGhiQbO5f1
 nMXeHrf0xOMdxF9l8EQHs4yopu500AFbqyGpR8GH6uQ35OZwb5TgCyzjf6MsuYFCcs+EjZSfqj9
 Ae6In+ga32wYuJH+rGNcyBq9FKiipq0zBtrMAKxKZAdZ8rhcx6EzsXr3w7I28WzgbD0xE66WE9/
 pzJlck52avZNH2/g4O5v3xuocwHt0k31Untun5T/AhxVaUi69XZ5gq8XI+gwbSoS58aNfYYKka/
 NZb5lUcrKgBoCTMLHKQ2YuWy+7Q2gejwIWPHzHdxcEMhQ9n5g5ewIXwlT0jeq/NU/4HumSh4+ek
 A6y4CSiySgfSb/lORgGERHezhd55P4cPLjW1+H9rrWxwqPW1tIZpWPBXRbAQNKbIIE/eEeK5rlO
 FgscyY9lJ+uCObcRXLE8UMv6kL/xr3gcGKlsf6tnQ==
X-Received: by 2002:a05:6000:200c:b0:43b:8f4e:27f8 with SMTP id
 ffacd0b85a97d-43b9ea34a8cmr3174268f8f.12.1774610254831; 
 Fri, 27 Mar 2026 04:17:34 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 34/65] target/arm: GICv5 cpuif: Implement ICC_IAFFIDR_EL1
Date: Fri, 27 Mar 2026 11:16:29 +0000
Message-ID: <20260327111700.795099-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

The CPU system register ICC_IAFFIDR_EL1 is a read-only register that
tells the guest what the affinity ID of that CPU is.

Implement this register.  In real hardware using the stream protocol,
the IRS tells the CPU its IAFFID using a DownstreamControl command as
part of the handshake process when the IRS-CPU link is brought
online.  Our analogue of this is to pass the IAFFID as an extra
argument to gicv5_set_gicv5state().  (We could have the CPU call into
the GIC every time to ask for the value, but this would mean we had
to search the cpus[] array for the right CPU to return its IAFFID.)

Note that we don't put the IAFFID into the gicv5_cpuif sub-struct,
because that part of the CPU struct is zeroed on reset, and we must
keep the IAFFID across reset (we only set it up when the GIC device
is created).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 hw/intc/arm_gicv5_common.c         |  5 +++--
 include/hw/intc/arm_gicv5_stream.h |  3 ++-
 target/arm/cpu.c                   |  5 +++--
 target/arm/cpu.h                   |  2 ++
 target/arm/tcg/gicv5-cpuif.c       | 11 +++++++++++
 5 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index 5510e6239a..0b5303f370 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -175,9 +175,10 @@ static void gicv5_common_realize(DeviceState *dev, Error **errp)
     }
 
     for (int i = 0; i < cs->num_cpus; i++) {
-        if (!gicv5_set_gicv5state(cs->cpus[i], cs)) {
+        if (!gicv5_set_gicv5state(cs->cpus[i], cs, cs->cpu_iaffids[i])) {
             error_setg(errp,
-                       "CPU %d does not implement GICv5 CPU interface", i);
+                       "CPU %d (IAFFID 0x%x) does not implement GICv5 CPU interface",
+                       i, cs->cpu_iaffids[i]);
             return;
         }
     }
diff --git a/include/hw/intc/arm_gicv5_stream.h b/include/hw/intc/arm_gicv5_stream.h
index 670423fdad..136b6339ee 100644
--- a/include/hw/intc/arm_gicv5_stream.h
+++ b/include/hw/intc/arm_gicv5_stream.h
@@ -20,6 +20,7 @@ typedef struct GICv5Common GICv5Common;
  * gicv5_set_gicv5state
  * @cpu: CPU object to tell about its IRS
  * @cs: the GIC IRS it is connected to
+ * @iaffid: the IAFFID of this CPU
  *
  * Set the CPU object's GICv5 pointer to point to this GIC IRS.  The
  * IRS must call this when it is realized, for each CPU it is
@@ -28,7 +29,7 @@ typedef struct GICv5Common GICv5Common;
  * Returns true on success, false if the CPU doesn't implement the
  * GICv5 CPU interface.
  */
-bool gicv5_set_gicv5state(ARMCPU *cpu, GICv5Common *cs);
+bool gicv5_set_gicv5state(ARMCPU *cpu, GICv5Common *cs, uint32_t iaffid);
 
 /*
  * The architected Stream Protocol is asynchronous; commands can be
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 4044bce5b6..ceb303a55a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1087,16 +1087,17 @@ static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 }
 
 #ifndef CONFIG_USER_ONLY
-bool gicv5_set_gicv5state(ARMCPU *cpu, GICv5Common *cs)
+bool gicv5_set_gicv5state(ARMCPU *cpu, GICv5Common *cs, uint32_t iaffid)
 {
     /*
      * Set this CPU's gicv5state pointer to point to the GIC that we are
-     * connected to.
+     * connected to, and record our IAFFID.
      */
     if (!cpu_isar_feature(aa64_gcie, cpu)) {
         return false;
     }
     cpu->env.gicv5state = cs;
+    cpu->env.gicv5_iaffid = iaffid;
     return true;
 }
 #endif
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1fdfd91ba4..a32c5f3ab1 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -819,6 +819,8 @@ typedef struct CPUArchState {
     void *gicv3state;
     /* Similarly, for a GICv5Common */
     void *gicv5state;
+    /* For GICv5, this CPU's IAFFID */
+    uint64_t gicv5_iaffid;
 #else /* CONFIG_USER_ONLY */
     /* For usermode syscall translation.  */
     bool eabi;
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 8cf09791c1..005e2fa8d2 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -226,6 +226,17 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.icc_icsr_el1),
         .resetvalue = 0,
     },
+    {   .name = "ICC_IAFFIDR_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 5,
+        .access = PL1_R, .type = ARM_CP_NO_RAW,
+        /* ICC_IAFFIDR_EL1 holds the IAFFID only, in its low bits */
+        .fieldoffset = offsetof(CPUARMState, gicv5_iaffid),
+        /*
+         * The field is a constant value set in gicv5_set_gicv5state(),
+         * so don't allow it to be overwritten by reset.
+         */
+        .resetfn = arm_cp_reset_ignore,
+    },
 };
 
 void define_gicv5_cpuif_regs(ARMCPU *cpu)
-- 
2.43.0


