Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D91EC1112
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKm-0002VS-Ac; Mon, 23 Feb 2026 12:03:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKj-0002SY-VA
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:57 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKi-0000IC-BU
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:57 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48069a48629so47256025e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866175; x=1772470975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+BKZSnMQQmK+RzmCczuCw9qZHXksHwgTCftkHrZV+kE=;
 b=K1JgSGymOW7RkBdVRyL3QXnDUA8RCEjUkJIfiYFa4zEuFRgUuUKsFscC5FVvK/NkVT
 +n7rKvSlTDBXIRhYauoBgf3F5nmKU7GIVzEiYe0zpm0csU3b8YEoflA/8bj7JoFX+q3J
 ot6lE4WYNZagc7izLHKFZcFUSjcBHi26qL9lcZl8XI/lgZKwY9nGdZdJEnlS6gTyiUhb
 /KyHDgFgfylzY6dz1w+cBkHlGYYg1B7FRQyK4d/7v50Y/r+TpavXMnCT/FOzt5VYVPPx
 THqu6oowIX9h08UOKaREdTFDlpeBRm0yXFFaeRlIcRDfPINMpzYtMahrVQTHWDrTeyw/
 xGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866175; x=1772470975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+BKZSnMQQmK+RzmCczuCw9qZHXksHwgTCftkHrZV+kE=;
 b=OXXwVnupEfr5wnlRkAbDqRUQl5ZZz/qZALNXOzJvnqcdWevOpCzwvsltQ1s0voiwMW
 WgoAxRkFuquvr+Ptp1Bj7DjhwSylJ8VWVDveGI+ukzv/qrO2GVfqJ6N/syKaYq411LmN
 JZD9IF/BFUq4/1hZT0RfAIJc6MSVjUS3qEcMWqvryLUEBhdiljnrUneeKBJJbN2O9wdf
 XzURE0raD2+VJRIUq/NuMOzzt5hew9eCEba5BJpbr7NPDUgpw+kTLxgEr+YkLxLIynCb
 OJt/uTsJ8yEgMzTpQ35m8sV/zzYa8JX/eqB8amOEprpVEOmyKcW3/5cENEMdO4D+4rfx
 kekA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG1+qSVVY9yTJ/8eGTYgG0z3SiumjFMRJPTpzJvYY0bN2kd+JyP0p9YqzfkdThbBs0C8/AiYr0MvRE@nongnu.org
X-Gm-Message-State: AOJu0YyasUp3VkgAtd3PKfE3efSGW1TelFghC6iqPiIblQ0KOyXmt8Is
 7Evp4qYdB7jiepEY5j8oUFtOh00Il1NOL7f3gM9shNJfr4nW4lrJWyC7fZQlj89ArJn0+drkyco
 CyqvG
X-Gm-Gg: AZuq6aLAKXNH7sDLHMhgaU8GH009KcsQFJbwgSt9AkjrCQdK0as+S+IN0OkHNbZbE5b
 L3UaBsW9op4W/SuKuWa+QT1nrd/PxZqWaMnexMk8eXS8+f7KWFCPsGjZ0iWG44iS3OnNTUlwNZE
 ODUEKKhqoF2gRh2kr+VUpXRZKJy4LgGltVmzA49XgzyC5+8TOu79giBwS3YM+nEERCb8j494guS
 nk6Peakx27xvyoqWczTUAUxDXu0m5rY3UdTQHsj1PjOUolVXPv3tyIpuBRdppBjkl0n6AZ6DXu0
 TIGmRiDMRInApkKBGBTURsNTIWmZsqMRBxDiLnA8HcIwTeDYTDdrhnHgzFTjBp8zlXsnXlwUrEZ
 v84qTui6TF4eePr7UBpMW+ln0Z7eegQ3DRRgzJPZcSI2Qk5DmgzsZFEEmQRr33bbpVag5yF79x1
 44zjNKJd1WlIKOU0Oqd9pLl1apyE9tJ+iX4BhF1dhADPXfLT0BYiFfVZkaeC7Va9M2BEuAA1Aq1
 T5D6tBes/S0Xs8nxLXFZvMDLyJwYxY=
X-Received: by 2002:a05:600c:1e28:b0:477:5af7:6fa with SMTP id
 5b1f17b1804b1-483a95fe96bmr132780755e9.32.1771866174849; 
 Mon, 23 Feb 2026 09:02:54 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 36/65] target/arm: GICv5 cpuif: Implement PPI handling mode
 register
Date: Mon, 23 Feb 2026 17:01:43 +0000
Message-ID: <20260223170212.441276-37-peter.maydell@linaro.org>
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

In the GICv5 the handling mode of a PPI is not software configurable;
it is reported via read-only CPU interface registers ICC_PPI_HMR0_EL1
and ICC_PPI_HMR1_EL1.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h             |  1 +
 target/arm/tcg/gicv5-cpuif.c | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index dd4dc12feb..4574f7005d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -605,6 +605,7 @@ typedef struct CPUArchState {
         uint64_t icc_icsr_el1;
         /* Most PPI registers have 1 bit per PPI, so 64 PPIs to a register */
         uint64_t ppi_active[GICV5_NUM_PPIS / 64];
+        uint64_t ppi_hm[GICV5_NUM_PPIS / 64];
     } gicv5_cpuif;
 
     struct {
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 0132b13853..6fbc962131 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -50,6 +50,16 @@ FIELD(ICC_IDR0_EL1, GCIE_LEGACY, 8, 4)
     ((4 << R_ICC_IDR0_EL1_PRI_BITS_SHIFT) |     \
      (1 << R_ICC_IDR0_EL1_ID_BITS_SHIFT))
 
+/*
+ * PPI handling modes are fixed and not software configurable.
+ * R_CFSKX defines them for the architected PPIs: they are all Level,
+ * except that PPI 24 (CTIIRQ) is IMPDEF and PPI 3 (SW_PPI) is Edge.
+ * For unimplemented PPIs the field is RES0.  The PPI register bits
+ * are 1 for Level and 0 for Edge.
+ */
+#define PPI_HMR0_RESET (~(1ULL << GICV5_PPI_SW_PPI))
+#define PPI_HMR1_RESET (~0ULL)
+
 static GICv5Common *gicv5_get_gic(CPUARMState *env)
 {
     return env->gicv5state;
@@ -292,6 +302,18 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_active[1]),
         .writefn = gic_ppi_sactive_write,
     },
+    {   .name = "ICC_PPI_HMR0_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 0,
+        .access = PL1_R, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_hm[0]),
+        .resetvalue = PPI_HMR0_RESET,
+    },
+    {   .name = "ICC_PPI_HMR1_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 1,
+        .access = PL1_R, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_hm[1]),
+        .resetvalue = PPI_HMR1_RESET,
+    },
 };
 
 void define_gicv5_cpuif_regs(ARMCPU *cpu)
-- 
2.43.0


