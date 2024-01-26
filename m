Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359D7C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHJ-0002MD-5o; Fri, 26 Jan 2024 09:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHF-0002ID-LT
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:53 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHD-0007vu-DK
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:53 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3394dc75eadso451971f8f.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279630; x=1706884430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WClEbAYEMyFm8PZOzcgu+oaG2+JFImSPU42hTK0ft1A=;
 b=J8ACLJhTqUyC6BSIeavmxU63mbOZ4aVM4fEa6rI6oj3O5W8BsfvPdfDomJBw1OGbgd
 pmMn5lRyYCdM87DO8Qo6nMnMmFnMOOlpNog8Z3qhBWo6BWg3yq+19xwugnbA7iJAKuVQ
 hFtEuWmIy5/+SZ/40sBqD4YAtbu/Y626nEXF7UQeTChAxHm2Sjn77OMI5XcQnVTDovZ3
 NahNhjLOySEE8JjzfYqNFPUF0SJltQtOuAuHOIJZXOz/lkYNlxyfMMr4PK5ZVo3SG0ei
 JErfceYCQd5xY3+m6ls2eDQsLyt6OfPEkCchBzGOg4fGNrKZfM5FZLe0zGjJT2j7mjt4
 npDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279630; x=1706884430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WClEbAYEMyFm8PZOzcgu+oaG2+JFImSPU42hTK0ft1A=;
 b=u9R+w/R9l7kQZquNmuyqGGjh3BPfkhTggsUu+S6bTxn1RHq3IIW3R2sXE0ueUORbWD
 VP1ZHR7cSQv14bsgqqY77sW06VPHS5qO4Ak3AIsgs22AwBQreae/xhEsyP1TRnIBZvKt
 O17P+H9D3bD6cwzjlVulDapDqCKaXf21edaLZhgGgXlag7l+KuhX7LTAGG8BJrh/lw87
 XznoWmOgFn9bUhx7jZKvFxPv2KSU+1Qy/H+X/deC/QIRJcMjhW22eLL9vb8rhBEUA6LG
 VYhY2aZK58rLtPdq+0nNLLnUdExSxLy/P43BWN2lcaIKicc/yL7zzidERLOKsNLuGVLT
 NCOQ==
X-Gm-Message-State: AOJu0YzZ71vBm9fjXYJKN+5wNDeG6PbhqXXlBi3WUTY8KE8EeNg9XMPC
 RPuGd5+GZsycjE/TvfFx/IZqaQaThwJ+rqsd7UcWVoP/6dx3Nx/ePE04LZClPg4MZAU3hcsGZcP
 I
X-Google-Smtp-Source: AGHT+IFXYAmbA0yQ357CN2Vl743xnyR22dtdITRCAc9YmFw6WksHPVI0eHUL7Qn6BMFWRz6FnKQOpA==
X-Received: by 2002:adf:f88d:0:b0:339:6114:c90e with SMTP id
 u13-20020adff88d000000b003396114c90emr1162100wrp.27.1706279629792; 
 Fri, 26 Jan 2024 06:33:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/36] target/arm: Rename arm_cpu_mp_affinity
Date: Fri, 26 Jan 2024 14:33:22 +0000
Message-Id: <20240126143341.2101237-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Rename to arm_build_mp_affinity.  This frees up the name for
other usage, and emphasizes that the cpu object is not involved.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240118200643.29037-9-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h  | 2 +-
 hw/arm/npcm7xx.c  | 2 +-
 hw/arm/sbsa-ref.c | 2 +-
 hw/arm/virt.c     | 2 +-
 target/arm/cpu.c  | 6 +++---
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ec276fcd57c..55a19e8539e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1171,7 +1171,7 @@ void arm_cpu_post_init(Object *obj);
     (ARM_AFF0_MASK | ARM_AFF1_MASK | ARM_AFF2_MASK | ARM_AFF3_MASK)
 #define ARM64_AFFINITY_INVALID (~ARM64_AFFINITY_MASK)
 
-uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz);
+uint64_t arm_build_mp_affinity(int idx, uint8_t clustersz);
 
 #ifndef CONFIG_USER_ONLY
 extern const VMStateDescription vmstate_arm_cpu;
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 15ff21d0472..7fb0a233b2d 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -474,7 +474,7 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
     /* CPUs */
     for (i = 0; i < nc->num_cpus; i++) {
         object_property_set_int(OBJECT(&s->cpu[i]), "mp-affinity",
-                                arm_cpu_mp_affinity(i, NPCM7XX_MAX_NUM_CPUS),
+                                arm_build_mp_affinity(i, NPCM7XX_MAX_NUM_CPUS),
                                 &error_abort);
         object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
                                 NPCM7XX_GIC_CPU_IF_ADDR, &error_abort);
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 477dca06373..b8857d1e9e4 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -148,7 +148,7 @@ static const int sbsa_ref_irqmap[] = {
 static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
 {
     uint8_t clustersz = ARM_DEFAULT_CPUS_PER_CLUSTER;
-    return arm_cpu_mp_affinity(idx, clustersz);
+    return arm_build_mp_affinity(idx, clustersz);
 }
 
 static void sbsa_fdt_add_gic_node(SBSAMachineState *sms)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ed4ed9f4142..eecde04fc77 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1676,7 +1676,7 @@ static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
             clustersz = GICV3_TARGETLIST_BITS;
         }
     }
-    return arm_cpu_mp_affinity(idx, clustersz);
+    return arm_build_mp_affinity(idx, clustersz);
 }
 
 static inline bool *virt_get_high_memmap_enabled(VirtMachineState *vms,
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 593695b4247..5b5af7d4e1e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1307,7 +1307,7 @@ static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 }
 
-uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz)
+uint64_t arm_build_mp_affinity(int idx, uint8_t clustersz)
 {
     uint32_t Aff1 = idx / clustersz;
     uint32_t Aff0 = idx % clustersz;
@@ -2113,8 +2113,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
      * so these bits always RAZ.
      */
     if (cpu->mp_affinity == ARM64_AFFINITY_INVALID) {
-        cpu->mp_affinity = arm_cpu_mp_affinity(cs->cpu_index,
-                                               ARM_DEFAULT_CPUS_PER_CLUSTER);
+        cpu->mp_affinity = arm_build_mp_affinity(cs->cpu_index,
+                                                 ARM_DEFAULT_CPUS_PER_CLUSTER);
     }
 
     if (cpu->reset_hivecs) {
-- 
2.34.1


