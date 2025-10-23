Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B63ACCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwML-0004Ij-0a; Thu, 23 Oct 2025 10:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBwLi-0003Ni-Hw
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:31:32 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBwLd-0001vk-BA
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:31:27 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b90so760157f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761229883; x=1761834683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=90cDyXk36PbB+Z+4P2CZHLVT0KSWEWac6BpArMyrQdc=;
 b=J3qGE6vso1Mufw2W9wXgbq2OdZ+0EPR3EGdgcMXtnSgaUismy/z42bZBmSoe1RXubu
 fxo0JYg/0ViYJ6IxU44W07Nr6UWPNV5LS7egc00RHzbxdIuIRkG4H+1hfBikXLn4BJr1
 rjGHhLNLtlV5EruuZkEX1d9Ft4Rga07dB5htzEcQLn4TOn1NDrAbvDZdUEN2RfFrgveE
 n9iQQ6uBYXK83thNb40SAfu8SStK2tW9qL4XUlfFXpY5qnRyOaLA46jRXRryqzH1l9Kc
 pvQcHXc9KcfnPC0BV2WHp5QRzhIPBZIkIbRPQkgHj7iAmHey6aF9vXLFJCRCPqCvds/D
 IwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761229883; x=1761834683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=90cDyXk36PbB+Z+4P2CZHLVT0KSWEWac6BpArMyrQdc=;
 b=KmOWeZf01wR9sBcrsCf3eWgdqJN+vEGBl/XaPTdI1BrPlD05MKzItJA1bg8dkoRaEg
 frMTFLHgYyCnrbHta3k7CUgkk/db7iK6JIuaMWv3I88Ncja0dPgHmuuCFRTV1F3AqaLy
 DPjsit+Cctl9oSMF+PtU7npxjxOrzvX4jdIo24akzetXVkL0EUFcREwgbhoAaac5izXz
 6odIBhEgBlmV5DQJZ0SSYZLr0dQBKPPxfxVXTkecPkrriDAEBPARNx0ppX68J++WMRrX
 UBGcBC6tbRzx974XUvPuVHnh2GeZwLTyGweTvQphmO6NqLzTLSLS0RfilGzejbKXKAkV
 Kjug==
X-Gm-Message-State: AOJu0YwnLCCd6XL5MNVRAScoFOau+gYsDZ6+3zhxXsMZCG8nQPXULFHH
 85FjdnueWi57paMu2fR1bT54HFBvFNgB2OOkZLjzXQH44oO0oBqrfn8WUm/uwXPRcFEN+7X6jZF
 uqSStQOA=
X-Gm-Gg: ASbGncuRv/oYxtqK2Pu/pnFA71kyLqs8ye2qvyNbJW1bvq57vA5k0b9qPrrCZgjRHbq
 mQHK/P7geuOT3Kn0aQebQbFAxFFeYnQ0lx/VwNx1PR4Mzj/5GSugQAlfib4DskcGvtJYBgTPjs4
 +KgSKth6357dNq6Zlt7SXF+vGT2bWyVUwCmcrEzgmOjPvAVOVGFuJeHq1XR0/j6/oVsDPI9o2Op
 PVJx2L4oUgFx9PSbkCHjU+TjNzK17kP6+XzFpEEpb+zAbl5f4LRd1xZFklh7T35br1prVz0p8/2
 5McEIne/0xNqt1YUDuJGHwnT3CVWZPiIf2/Y8g8Hoi6W7GBKRpYlGREhzzdLxoBlWVbEQmCqG0i
 3qC4aDsYxlVh48MC7wZz59rsKhJqJ5l3IxU6TaI1mlAVVovSHI4txVpULojBH/KVcD15LQ2Soyh
 KDklVthKWYd/FjRJwaCR5GNemeFDdWvCXjPuopSmOBhv5iufzHzEkV3Z5lW9r2
X-Google-Smtp-Source: AGHT+IF2G+Jn19LGPJz5WjlBCa38F/+cE4n9hNbGzw3H1Tq+BEsZ7L38cAByKTMZemuhe0i3/lWSHg==
X-Received: by 2002:a05:6000:4606:b0:427:5ae:eb28 with SMTP id
 ffacd0b85a97d-42705aeeb32mr14720032f8f.30.1761229882956; 
 Thu, 23 Oct 2025 07:31:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429897e7622sm4293052f8f.8.2025.10.23.07.31.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 07:31:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Alexander Graf <agraf@csgraf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Collingbourne <pcc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v2 26/58] target/arm: Better describe PMU depends on TCG or HVF
Date: Thu, 23 Oct 2025 16:30:47 +0200
Message-ID: <20251023143051.11195-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Simplify PMU logic by rewriting '!KVM' as 'TCG || HVF'
(ignoring QTest, because vCPUs are not available there).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.c     |  2 +-
 target/arm/machine.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index bfc031c70c1..5eaf950b969 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1975,7 +1975,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     if (arm_feature(env, ARM_FEATURE_PMU)) {
         pmu_init(cpu);
 
-        if (!kvm_enabled()) {
+        if (tcg_enabled() || hvf_enabled()) {
             arm_register_pre_el_change_hook(cpu, &pmu_pre_el_change, 0);
             arm_register_el_change_hook(cpu, &pmu_post_el_change, 0);
         }
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 44a0cf844b0..80aa2e34b4b 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -1,7 +1,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "qemu/error-report.h"
-#include "system/kvm.h"
+#include "system/hvf.h"
 #include "system/tcg.h"
 #include "kvm_arm.h"
 #include "internals.h"
@@ -943,7 +943,7 @@ static int cpu_pre_save(void *opaque)
 {
     ARMCPU *cpu = opaque;
 
-    if (!kvm_enabled()) {
+    if (tcg_enabled() || hvf_enabled()) {
         pmu_op_start(&cpu->env);
     }
 
@@ -978,7 +978,7 @@ static int cpu_post_save(void *opaque)
 {
     ARMCPU *cpu = opaque;
 
-    if (!kvm_enabled()) {
+    if (tcg_enabled() || hvf_enabled()) {
         pmu_op_finish(&cpu->env);
     }
 
@@ -1011,7 +1011,7 @@ static int cpu_pre_load(void *opaque)
      */
     env->irq_line_state = UINT32_MAX;
 
-    if (!kvm_enabled()) {
+    if (tcg_enabled() || hvf_enabled()) {
         pmu_op_start(env);
     }
 
@@ -1103,7 +1103,7 @@ static int cpu_post_load(void *opaque, int version_id)
         }
     }
 
-    if (!kvm_enabled()) {
+    if (tcg_enabled() || hvf_enabled()) {
         pmu_op_finish(env);
     }
 
-- 
2.51.0


