Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29171C3DA59
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 09:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sV6RK-0001Oq-H1; Sat, 20 Jul 2024 05:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sV6RC-0000tc-4K
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 05:31:34 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sV6RA-00072U-Cq
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 05:31:33 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fb3b7d0d3aso16063795ad.2
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 02:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721467891; x=1722072691;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=99AglDGYDKt8UyQF0+i2KqD6ZLYCDLBz3EOwXuGJkA8=;
 b=HfT2VOL5VIbT8ZHrIbAK//60Tmh36FOId22UhhgTfPnIfA7e2mV8miGS2eYZrR7sSd
 QhHEciMpzyLFij+9bR0KojbXagx/lfpSobo0Y6Gg/l7NeB4o2mWS5VpKB+rMcYHmF4fD
 Ubpmp76NM4diHD/YvV13UoTR9QTg/AG+LmYr+015+O2QJGlSUqnYzbrvaCGg8X513187
 3dTT1mTmg3Iir+MpJnyw4oJPCO53yDXQa1/GjRBDJzWk4Ah5zBlIVjA9e/KdM27T3Cao
 79drRVqtfXMfsW1v80uvsoPI1bOEnT7/2/DPBCIvLWQT/1bD+ZyjTbLNc4CUGBMwUwKK
 YtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721467891; x=1722072691;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=99AglDGYDKt8UyQF0+i2KqD6ZLYCDLBz3EOwXuGJkA8=;
 b=TCNOOiBGYyldPPkScDgursfpWw+m+rZ8Uq+q7fnKesiNGOv0fubFP8L9QupEC17V66
 5rcnGi84gzEq1iyUgU7vZFy5d/nDJiBKNqQk08WsgG6Lm5mtQ2Obr930md2ngyiDnkQc
 hWR2ZsMfkMmL1Wq7VvX8E2tbmqmlARgX4IltvkPV0X5f471/jidrqavGXhD+ivEGFBlt
 kZZvPs8CoL2es4HSsgEsVpdJT2k2IsvCmSNIIjlv6UPsDq11O83s2b+AGZ41H3DI9gE5
 d3+KKVFsCKsEV0vCqgIyfzBKI9N1Dx6vZ8r0bMOB0poMezdV9BT2S8OdhDr7B8eSH4jk
 GMLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWy+4X/nisjKcm0u4JfTIAFJxWjIzaLutjpZZwcO9gK5U5nZY21+wGVdKmdZKhvx6DsKG293R8n04OeLaiNu3fMknj2DoQ=
X-Gm-Message-State: AOJu0Yz+Bzk/JA8PRSmnu42eDhM0/jI87xqz635B98KUvm3Z9Azdgauc
 DBtTluVP0AeTjsjiDV3BZ1U3F5VeRerw0+UXpGuX5evraV4XHgxt/IaZHtvIhv0+Z+3uGYLV79S
 /wpU=
X-Google-Smtp-Source: AGHT+IGilupQDoh1YjZT0MqsC5EdkPJxgrupVuH9NgGrPu/6pkbEQMPZjNYjiWTJHABuEd78H+Srqg==
X-Received: by 2002:a05:6a20:12cd:b0:1c3:b1b3:75cf with SMTP id
 adf61e73a8af0-1c4285d386fmr1147019637.14.1721467890772; 
 Sat, 20 Jul 2024 02:31:30 -0700 (PDT)
Received: from localhost ([157.82.204.122])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2cb77504fa2sm4228362a91.46.2024.07.20.02.31.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jul 2024 02:31:30 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 20 Jul 2024 18:30:53 +0900
Subject: [PATCH v4 5/6] hvf: arm: Properly disable PMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240720-pmu-v4-5-2a2b28f6b08f@daynix.com>
References: <20240720-pmu-v4-0-2a2b28f6b08f@daynix.com>
In-Reply-To: <20240720-pmu-v4-0-2a2b28f6b08f@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

Setting pmu property used to have no effect for hvf so fix it.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 target/arm/hvf/hvf.c | 184 +++++++++++++++++++++++++++------------------------
 1 file changed, 97 insertions(+), 87 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 1a749534fb0d..adcdfae0b17f 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1204,45 +1204,50 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
 
+    if (arm_feature(env, ARM_FEATURE_PMU)) {
+        switch (reg) {
+        case SYSREG_PMCR_EL0:
+            *val = env->cp15.c9_pmcr;
+            return 0;
+        case SYSREG_PMCCNTR_EL0:
+            pmu_op_start(env);
+            *val = env->cp15.c15_ccnt;
+            pmu_op_finish(env);
+            return 0;
+        case SYSREG_PMCNTENCLR_EL0:
+            *val = env->cp15.c9_pmcnten;
+            return 0;
+        case SYSREG_PMOVSCLR_EL0:
+            *val = env->cp15.c9_pmovsr;
+            return 0;
+        case SYSREG_PMSELR_EL0:
+            *val = env->cp15.c9_pmselr;
+            return 0;
+        case SYSREG_PMINTENCLR_EL1:
+            *val = env->cp15.c9_pminten;
+            return 0;
+        case SYSREG_PMCCFILTR_EL0:
+            *val = env->cp15.pmccfiltr_el0;
+            return 0;
+        case SYSREG_PMCNTENSET_EL0:
+            *val = env->cp15.c9_pmcnten;
+            return 0;
+        case SYSREG_PMUSERENR_EL0:
+            *val = env->cp15.c9_pmuserenr;
+            return 0;
+        case SYSREG_PMCEID0_EL0:
+        case SYSREG_PMCEID1_EL0:
+            /* We can't really count anything yet, declare all events invalid */
+            *val = 0;
+            return 0;
+        }
+    }
+
     switch (reg) {
     case SYSREG_CNTPCT_EL0:
         *val = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) /
               gt_cntfrq_period_ns(arm_cpu);
         return 0;
-    case SYSREG_PMCR_EL0:
-        *val = env->cp15.c9_pmcr;
-        return 0;
-    case SYSREG_PMCCNTR_EL0:
-        pmu_op_start(env);
-        *val = env->cp15.c15_ccnt;
-        pmu_op_finish(env);
-        return 0;
-    case SYSREG_PMCNTENCLR_EL0:
-        *val = env->cp15.c9_pmcnten;
-        return 0;
-    case SYSREG_PMOVSCLR_EL0:
-        *val = env->cp15.c9_pmovsr;
-        return 0;
-    case SYSREG_PMSELR_EL0:
-        *val = env->cp15.c9_pmselr;
-        return 0;
-    case SYSREG_PMINTENCLR_EL1:
-        *val = env->cp15.c9_pminten;
-        return 0;
-    case SYSREG_PMCCFILTR_EL0:
-        *val = env->cp15.pmccfiltr_el0;
-        return 0;
-    case SYSREG_PMCNTENSET_EL0:
-        *val = env->cp15.c9_pmcnten;
-        return 0;
-    case SYSREG_PMUSERENR_EL0:
-        *val = env->cp15.c9_pmuserenr;
-        return 0;
-    case SYSREG_PMCEID0_EL0:
-    case SYSREG_PMCEID1_EL0:
-        /* We can't really count anything yet, declare all events invalid */
-        *val = 0;
-        return 0;
     case SYSREG_OSLSR_EL1:
         *val = env->cp15.oslsr_el1;
         return 0;
@@ -1486,64 +1491,69 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
                            SYSREG_OP2(reg),
                            val);
 
-    switch (reg) {
-    case SYSREG_PMCCNTR_EL0:
-        pmu_op_start(env);
-        env->cp15.c15_ccnt = val;
-        pmu_op_finish(env);
-        return 0;
-    case SYSREG_PMCR_EL0:
-        pmu_op_start(env);
+    if (arm_feature(env, ARM_FEATURE_PMU)) {
+        switch (reg) {
+        case SYSREG_PMCCNTR_EL0:
+            pmu_op_start(env);
+            env->cp15.c15_ccnt = val;
+            pmu_op_finish(env);
+            return 0;
+        case SYSREG_PMCR_EL0:
+            pmu_op_start(env);
 
-        if (val & PMCRC) {
-            /* The counter has been reset */
-            env->cp15.c15_ccnt = 0;
-        }
+            if (val & PMCRC) {
+                /* The counter has been reset */
+                env->cp15.c15_ccnt = 0;
+            }
 
-        if (val & PMCRP) {
-            unsigned int i;
-            for (i = 0; i < pmu_num_counters(env); i++) {
-                env->cp15.c14_pmevcntr[i] = 0;
+            if (val & PMCRP) {
+                unsigned int i;
+                for (i = 0; i < pmu_num_counters(env); i++) {
+                    env->cp15.c14_pmevcntr[i] = 0;
+                }
             }
-        }
 
-        env->cp15.c9_pmcr &= ~PMCR_WRITABLE_MASK;
-        env->cp15.c9_pmcr |= (val & PMCR_WRITABLE_MASK);
+            env->cp15.c9_pmcr &= ~PMCR_WRITABLE_MASK;
+            env->cp15.c9_pmcr |= (val & PMCR_WRITABLE_MASK);
 
-        pmu_op_finish(env);
-        return 0;
-    case SYSREG_PMUSERENR_EL0:
-        env->cp15.c9_pmuserenr = val & 0xf;
-        return 0;
-    case SYSREG_PMCNTENSET_EL0:
-        env->cp15.c9_pmcnten |= (val & pmu_counter_mask(env));
-        return 0;
-    case SYSREG_PMCNTENCLR_EL0:
-        env->cp15.c9_pmcnten &= ~(val & pmu_counter_mask(env));
-        return 0;
-    case SYSREG_PMINTENCLR_EL1:
-        pmu_op_start(env);
-        env->cp15.c9_pminten |= val;
-        pmu_op_finish(env);
-        return 0;
-    case SYSREG_PMOVSCLR_EL0:
-        pmu_op_start(env);
-        env->cp15.c9_pmovsr &= ~val;
-        pmu_op_finish(env);
-        return 0;
-    case SYSREG_PMSWINC_EL0:
-        pmu_op_start(env);
-        pmswinc_write(env, val);
-        pmu_op_finish(env);
-        return 0;
-    case SYSREG_PMSELR_EL0:
-        env->cp15.c9_pmselr = val & 0x1f;
-        return 0;
-    case SYSREG_PMCCFILTR_EL0:
-        pmu_op_start(env);
-        env->cp15.pmccfiltr_el0 = val & PMCCFILTR_EL0;
-        pmu_op_finish(env);
-        return 0;
+            pmu_op_finish(env);
+            return 0;
+        case SYSREG_PMUSERENR_EL0:
+            env->cp15.c9_pmuserenr = val & 0xf;
+            return 0;
+        case SYSREG_PMCNTENSET_EL0:
+            env->cp15.c9_pmcnten |= (val & pmu_counter_mask(env));
+            return 0;
+        case SYSREG_PMCNTENCLR_EL0:
+            env->cp15.c9_pmcnten &= ~(val & pmu_counter_mask(env));
+            return 0;
+        case SYSREG_PMINTENCLR_EL1:
+            pmu_op_start(env);
+            env->cp15.c9_pminten |= val;
+            pmu_op_finish(env);
+            return 0;
+        case SYSREG_PMOVSCLR_EL0:
+            pmu_op_start(env);
+            env->cp15.c9_pmovsr &= ~val;
+            pmu_op_finish(env);
+            return 0;
+        case SYSREG_PMSWINC_EL0:
+            pmu_op_start(env);
+            pmswinc_write(env, val);
+            pmu_op_finish(env);
+            return 0;
+        case SYSREG_PMSELR_EL0:
+            env->cp15.c9_pmselr = val & 0x1f;
+            return 0;
+        case SYSREG_PMCCFILTR_EL0:
+            pmu_op_start(env);
+            env->cp15.pmccfiltr_el0 = val & PMCCFILTR_EL0;
+            pmu_op_finish(env);
+            return 0;
+        }
+    }
+
+    switch (reg) {
     case SYSREG_OSLAR_EL1:
         env->cp15.oslsr_el1 = val & 1;
         return 0;

-- 
2.45.2


