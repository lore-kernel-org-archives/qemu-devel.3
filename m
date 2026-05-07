Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10CFCD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11k-0004OI-Tv; Thu, 07 May 2026 11:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11i-0004DI-Pp
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:39 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11h-0003xV-5R
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:38 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso7393955e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169155; x=1778773955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HgYzGVTUWzglc6pPiX7cv3PCWRiy3vSKkGuTnANNYrM=;
 b=i+mhz3c6nG64UMJZqU/rNbIoBqB9/aRJkNELoGZZMgjXZKOSoGUnRYydHnBJ/TWHzT
 1sGUIvaR9E6XaObXz7lCm796GQ0ZgSYQMiPFTXfppTpkWSJ2J/OyWT11e/iqscDc2zNc
 iEPifliu/vPv46FHQB3qNsncHTVzhlDCiDFhx6xzhh9W8Y82+6DzxceFpkF9Fa8xn99X
 UTN9NMkrTkB8xO4K0dYZqh8FOEA6YGaP/N7QWwkzl1yzLTts7YwSCBZ4POp3lfuxxN38
 OF+zQpxi5ojR6eRiH13iWOOOuTZ7JEp0KTccS3a/Vsr01SFOh00A5zquL9fqz7LwfFyL
 DZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169155; x=1778773955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HgYzGVTUWzglc6pPiX7cv3PCWRiy3vSKkGuTnANNYrM=;
 b=W2UpqaPsf4x4daa5bmBL0G4z9u0sxH+fU5iUSEloBP5QoSPTj56q3XQG12I4s8tBlY
 9s38HTf8R8eXOhhA25H0AtBxamOvob6pkIHcAupKujLOb55r2jBSF1+LavlGOZvd9ikA
 /wfaClrO/9ukzWpR5OPG4g5EaubrVfpIfUxwz44bOD962ybpjWZeZt+3LAVDOjB26Ser
 sZznGzE4KJXAPrnYBaHxaCyNHvpNXnkJEp25ckGafGEAuf5ffa1sAyJfdWJrxC5/wKqN
 PpANgMh62ZrpoDWik2lZGgKdtGNbqW0EST48sN4syeVqCje7NKafWT+67uzNKVeCEJua
 7oMw==
X-Gm-Message-State: AOJu0Yxa8r5LXxMvwgDGiOBQvnv4aaxF0/4FvT97BYinHxLI1eNogyPn
 R3ezI8xyGNlbyN+A7082qmOJoGL9vFAIhvQ3EpPyREEgJJ3apa4gl9DPNfgnsnQ1ybYK0Xi68tS
 jMeuj
X-Gm-Gg: AeBDieveI/UQUDMk/yIlzhnOc0jHutyk1y1xgaOBt39ieDvAbdiNoaggd69ME6mdGFE
 NpQ3VifiKPmyqibcNpK+sMx1Wcurr6YVHUpacURz7Li2SqQBbSkapSPjYycFkwKxKFsFEJznCR9
 ac4T86N9jYWXdGYDOY9h+XTVUizHqPx1wna70A6SCOINrkH8IdUFvkdS5ehCgjlyWciAZHGOE9L
 yO0B9bz2D9XuVCw7MUjxe7u2ofAs5X2gsGMIcgMx+noK0LSgGLK/BzmF1gm15jDoXvc8upw6mzV
 sre91+/ariYLCRspnzt/7NeUgdUs8/drUv9ttLzNBBFu8jR0v/hmQ0k1RgXmmW6JfKJ+89HwhRj
 A44vUu6YUN5jnqiaiUkV2W6cK/3TpkqylRMGyRiQs2dUJAcxbtEohMKJM7/Om91g6F231n475Q9
 8utcVD8kDZnfeKzDX3lNvFraOT/+hfqlabY8JnEBr2o3MsKcKtznBcBrEA0aQrcLsJW+Qr83aq7
 mehpH4dfArIC5v6LOQ1ZzWBbv23PVw=
X-Received: by 2002:a05:600c:8b04:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-48e51f183demr132794175e9.5.1778169154943; 
 Thu, 07 May 2026 08:52:34 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/67] target/arm: GICv5 cpuif: Implement PPI priority registers
Date: Thu,  7 May 2026 16:51:27 +0100
Message-ID: <20260507155154.1886557-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

Implement the GICv5 registers which hold the priority of the PPIs.
Each 64-bit register has the priority fields for 8 PPIs, so there are
16 registers in total.  This would be a lot of duplication if we
wrote it out statically in the array, so instead create each register
via a loop in define_gicv5_cpuif_regs().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-41-peter.maydell@linaro.org
---
 target/arm/cpu.h             |  2 ++
 target/arm/tcg/gicv5-cpuif.c | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9b12b0114b..cf7f8f8fac 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -607,6 +607,8 @@ typedef struct CPUArchState {
         uint64_t ppi_hm[GICV5_NUM_PPIS / 64];
         uint64_t ppi_pend[GICV5_NUM_PPIS / 64];
         uint64_t ppi_enable[GICV5_NUM_PPIS / 64];
+        /* The PRIO regs have 1 byte per PPI, so 8 PPIs to a register */
+        uint64_t ppi_priority[GICV5_NUM_PPIS / 8];
     } gicv5_cpuif;
 
     struct {
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 09cd56cbfa..74132ca097 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -225,6 +225,12 @@ static void gic_ppi_enable_write(CPUARMState *env, const ARMCPRegInfo *ri,
     raw_write(env, ri, value);
 }
 
+static void gic_ppi_priority_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                   uint64_t value)
+{
+    raw_write(env, ri, value);
+}
+
 static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     /*
      * Barrier: wait until the effects of a cpuif system register
@@ -382,5 +388,22 @@ void define_gicv5_cpuif_regs(ARMCPU *cpu)
 {
     if (cpu_isar_feature(aa64_gcie, cpu)) {
         define_arm_cp_regs(cpu, gicv5_cpuif_reginfo);
+
+        /*
+         * There are 16 ICC_PPI_PRIORITYR<n>_EL1 regs, so define them
+         * programmatically rather than listing them all statically.
+         */
+        for (int i = 0; i < 16; i++) {
+            g_autofree char *name = g_strdup_printf("ICC_PPI_PRIORITYR%d_EL1", i);
+            ARMCPRegInfo ppi_prio = {
+                .name = name, .state = ARM_CP_STATE_AA64,
+                .opc0 = 3, .opc1 = 0, .crn = 12,
+                .crm = 14 + (i >> 3), .opc2 = i & 7,
+                .access = PL1_RW, .type = ARM_CP_IO,
+                .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_priority[i]),
+                .writefn = gic_ppi_priority_write, .raw_writefn = raw_write,
+            };
+            define_one_arm_cp_reg(cpu, &ppi_prio);
+        }
     }
 }
-- 
2.43.0


