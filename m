Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD14C5AC80
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws1sI-0001VA-K6; Thu, 06 Aug 2026 13:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws1sC-0001To-69
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:27:16 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws1sA-0000cN-BM
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:27:15 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-8486ac3f347so1387353b3a.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 10:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786037233; x=1786642033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YT14aJW3An+61bWa7ik969cjv4s74Sb5HJN5i2MhTrI=;
 b=GkkAgGR7aHCsuD6YoaMhkdBoDFSjONhc0OTW9GxsULLDhamx75fsYmOuemaZtz9Qfh
 0luqfzpEinBTswP5Ca5Hpip9BHnD5Uxy7KvFpFuhOoxBcigROz6ezkcklhcwomEGKmcs
 86gUezJIRtR8hQbnN7CzsuYCh2k078BDrwSHZTqxhaZRWED78rYYKCZX7Bd02O4L5TE9
 11cgBeTJClmXqR1V42rUD23TQOMzVPDgFS4riME4ebzoCHaiCih/KATsL+dur2ovmQQP
 FoRqihEl2zXVRGH6go83ZMrpnWvcanlpkjAGV34z9FIq4B60hMGbAJG/KNEhXkCrx6xI
 Song==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786037233; x=1786642033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YT14aJW3An+61bWa7ik969cjv4s74Sb5HJN5i2MhTrI=;
 b=p2LIGtK1hPYkOMzyKY+oicG0kWq3xpgP7fryVibUdQb5bIuHRZ2nyyyaXenjGUeH3R
 F2UMfXQD4VBDdWGiVChw4MVqk5GRFqr4gbJ8bUSH60KgTbjIa4JYAGGLu0wUGc7l9lCm
 g+8qExwesS/LV0RLNF0m0/TozYChKT8UKN+wBuopdYmC0tC+NDvEq74IgF5XxP/MMOq1
 q5erX62c5BhU3oxa+4Q7Bac1+apEFtIvmT85M42qmwFa6CSrOKZRfAKJfiM+b2wr4CX9
 J8eGf4jd1bksHdlUddeRM2/PCcKl/6R6RYByGritcAbL1GEJtwfh+0To7EZp9DUF5K5J
 FC+Q==
X-Gm-Message-State: AOJu0Yxkwz6MAVSIG94bbTlTIPW+II2VPiwDY9jkqBf2n41I+Iskqwm6
 4/uxQ623l9Gom8YE8VvqhRBvv+I1tv8Avi0OwvMnpQa/HwxCbtYI167RQunmvsItcRjzQEPMuW8
 Q/9Qw
X-Gm-Gg: AR+sD13x79w1so6VlY3+Xmf1mhZIUsGkpTlQuT6bG0zMb8C2+Spiy/e1Osb++gHXxnU
 hsmj/gHJf8Xa004cAOJFbj+wN2F5wsz1cwuNFHYRXP1Z8XiR43sDDlNAewmzTyNNlhC7h4ih0cb
 qjeanh3OmN5gocKpEcUYajhPJ/4cCE7UUzZ6T65OVcw7R9s/0Z9AYtDF+PfjAb41J7vWTE4PZYy
 /6AFS6TZoe8+gNsCKsOkf7qOuU5a1ZC6+UYPG7KKwbBXJ1Xsf+ChHbdnkyr1sNsuSZsijKfL/i2
 usZMVieuG+BSkRPY/PZ6oWltIhr08IeATd8EONdHNA5dAvhPH4aDs++FmoCRTBDooL4YZvgOSgi
 iJGR1N/s0zmbubAHv+FkZWJ9qStYMPNqQDswzJpDIi+b0cMjNo0u+yeEZzk2IMzBioHnxAWVSf+
 0VTKNgCPEJjUWUHX7L/NTHHxk/0JEzjY5VHecj1HK0M+3PHQOQPkt9YxVGWfLoTd6/LPiXGBACD
 /2BOgf/onuN6YOc9dFx1tbSJvPxEPQD
X-Received: by 2002:a05:6a00:348d:b0:84e:c851:a058 with SMTP id
 d2e1a72fcca58-84f41dfbdf8mr9677466b3a.10.1786037232806; 
 Thu, 06 Aug 2026 10:27:12 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f45389e68sm1803272b3a.4.2026.08.06.10.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:27:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 1/6] target/arm: Add FGWTE3_EL3
Date: Thu,  6 Aug 2026 10:27:04 -0700
Message-ID: <20260806172709.333300-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806172709.333300-1-richard.henderson@linaro.org>
References: <20260806172709.333300-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h       |  1 +
 target/arm/cpu-features.h |  5 +++++
 target/arm/cpu.h          |  2 +-
 target/arm/helper.c       | 20 ++++++++++++++++++++
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 391c0e322b..34592679e4 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -385,6 +385,7 @@ typedef enum CPAccessResult {
 /* Indexes into fgt_write[] */
 #define FGTREG_HFGWTR 0
 #define FGTREG_HDFGWTR 1
+#define FGTREG_FGWTE3 2
 /* Indexes into fgt_exec[] */
 #define FGTREG_HFGITR 0
 
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index fb5ed25ad0..75f0fc4169 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1467,6 +1467,11 @@ static inline bool isar_feature_aa64_asid2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR4, ASID2) != 0;
 }
 
+static inline bool isar_feature_aa64_fgwte3(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR4, FGWTE3) != 0;
+}
+
 /*
  * Note the E2H0 ID fields is signed, increasingly negative as more
  * isn't implemented.
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c0492c8dfb..a471b87aa5 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -553,7 +553,7 @@ typedef struct CPUArchState {
          * FEAT_FGT2 will add more elements to these arrays.
          */
         uint64_t fgt_read[2]; /* HFGRTR, HDFGRTR */
-        uint64_t fgt_write[2]; /* HFGWTR, HDFGWTR */
+        uint64_t fgt_write[3]; /* HFGWTR, HDFGWTR, FGWTE3 */
         uint64_t fgt_exec[1]; /* HFGITR */
 
         /* RME registers */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index af45234ad2..853daf2e39 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6331,6 +6331,22 @@ static const ARMCPRegInfo fpmr_reginfo[] = {
     }
 };
 
+static void fgwte3_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                         uint64_t value)
+{
+    /* All bits are W1S and can only be cleared by cpu reset. */
+    env->cp15.fgt_write[FGTREG_FGWTE3] |= value;
+}
+
+static const ARMCPRegInfo fgwte3_reginfo[] = {
+    { .name = "FGWTE3_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 1, .crm = 1, .opc2 = 5,
+      .access = PL3_RW, .resetvalue = 0,
+      .writefn = fgwte3_write, .raw_writefn = raw_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.fgt_write[FGTREG_FGWTE3])
+    },
+};
+
 void register_cp_regs_for_features(ARMCPU *cpu)
 {
     /* Register all the coprocessor registers based on feature bits */
@@ -7642,6 +7658,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, ccsidr2_reginfo);
     }
 
+    if (cpu_isar_feature(aa64_fgwte3, cpu)) {
+        define_arm_cp_regs(cpu, fgwte3_reginfo);
+    }
+
     define_pm_cpregs(cpu);
     define_gcs_cpregs(cpu);
 }
-- 
2.43.0


