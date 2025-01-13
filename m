Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E78FC02183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 13:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXKu5-0005d5-Q2; Mon, 13 Jan 2025 08:54:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXKte-0005Yc-FB
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:54:29 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXKtZ-0007gG-LN
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:54:23 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-436249df846so29819515e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 05:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736776460; x=1737381260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q/xHE0NI+koHolsava9KtIliJ8DziA/VOxDpuG+77Kg=;
 b=ImzQJ/t/Fs6tZXwpW8j8FcScSl30WMbePDs2YfyPf/e6NMN9s+Dr+nnSLvW/1AfvOd
 dOmbGD1XKf5AiL+OBxK1xd2T3HHlVDnekbTcaJMBFYYxUXz3Bzq+IvyX3Tby5y/8eY/i
 OxjMeyLWRLT4ij0odKCBVTYsInDPZQE821fHCCydrpMA/bQBp0v+dhPWMRIiNiHyiBrH
 XoDzO5WYKRetR62+Z1uv/yS6OxJV9VYRiJTUodtikiqAS7mZXIv7CKrSTG49MR5UF/lp
 HEnF7sUOj8HsjwwcgCgtL0hmZL7Hv4csoDV1q7g9Aez+y24KFfL6BufyL8wXn/L9daIm
 tduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736776460; x=1737381260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q/xHE0NI+koHolsava9KtIliJ8DziA/VOxDpuG+77Kg=;
 b=GbbIw0x4+qyxD6xW+fHvL8PFFPaDFuhdT/+j0LfvTSFv7obZ/9BCgbH00+LexULwOo
 lE7juVNlvyjyPAoFgz5rEtBxBL0TwBqvrLaRvrgj2M7lRxT2P7notTZNq8ggfHDSykOZ
 DqpLHUf5V/xOyWN6UV8x2rC05gM5JKuxgc+SOQ6GlVaOLJUVoPZJ+9wVy03PlTpQ3XZl
 Q19fAERLiq5KcB/8U79i5e4LHSaCaAyeGK8a/TYK/eADUDPIzz3T6x3QLHf1cavWRYrp
 IqrT7q9XJdr0WKRPWoRUxQ2xh0A4p/kW+G4Kb50oqg1MJ3D09isyJljayrvMoKnGv4KK
 oXPA==
X-Gm-Message-State: AOJu0YzS1kAadM3T9xBFBinfVXkM4frDx8L/XvECAsfCVXfE8K7zXeWF
 3UTeDhRLPVt9NAqkBsyMY1mmZmzrX6MhGeHmSaFufvI3qY9q7RQpi95KVnjTxHRJWteoTaYIV5P
 m
X-Gm-Gg: ASbGncvGJvBaWxWUjcMinTOQNxev+nETR41r2rRejK/GgCPN0rI1MjUn1GZpVYElVcT
 1fnQr/ez35PLNLSgPMAc2hw1r6+gOvPHOYi3y4Ct3ZITgMxIgj1ORH12yyqSWSNqGdDWKt3g+/h
 SKyR5J5RGscGf/SMAltpRNprgdk7dIrJsWcd1R8iKyCFhBpV/OaM8EHtWEFOi1YfR4ubTNhV6KI
 +c/JYhXNOd4R3JasPRilw6kBxpaqU9KR8foy63Y6znBJAEePfNweWY/MpsLais=
X-Google-Smtp-Source: AGHT+IHkJunLmrQDmYAPj82WVb9YSW8DzmrH+aUnGWVevYogZir5YRF+uAlaTxXWvkB9yWMRbL9yGw==
X-Received: by 2002:a05:600c:871b:b0:434:f297:8e85 with SMTP id
 5b1f17b1804b1-436e26932eamr212900245e9.10.1736776460104; 
 Mon, 13 Jan 2025 05:54:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fba4sm145245205e9.4.2025.01.13.05.54.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 05:54:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/11] target/arm: change default pauth algorithm to impdef
Date: Mon, 13 Jan 2025 13:54:07 +0000
Message-Id: <20250113135408.3164401-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250113135408.3164401-1-peter.maydell@linaro.org>
References: <20250113135408.3164401-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Pointer authentication on aarch64 is pretty expensive (up to 50% of
execution time) when running a virtual machine with tcg and -cpu max
(which enables pauth=on).

The advice is always: use pauth-impdef=on.
Our documentation even mentions it "by default" in
docs/system/introduction.rst.

Thus, we change the default to use impdef by default. This does not
affect kvm or hvf acceleration, since pauth algorithm used is the one
from host cpu.

This change is retro compatible, in terms of cli, with previous
versions, as the semantic of using -cpu max,pauth-impdef=on, and -cpu
max,pauth-qarma3=on is preserved.
The new option introduced in previous patch and matching old default is
-cpu max,pauth-qarma5=on.
It is retro compatible with migration as well, by defining a backcompat
property, that will use qarma5 by default for virt machine <= 9.2.
Tested by saving and restoring a vm from qemu 9.2.0 into qemu-master
(10.0) for cpus neoverse-n2 and max.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241219183211.3493974-3-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/cpu-features.rst |  2 +-
 docs/system/introduction.rst     |  2 +-
 target/arm/cpu.h                 |  3 +++
 hw/core/machine.c                |  4 +++-
 target/arm/cpu.c                 |  2 ++
 target/arm/cpu64.c               | 22 ++++++++++++++++------
 6 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index d69ebc2b852..37d5dfd15b3 100644
--- a/docs/system/arm/cpu-features.rst
+++ b/docs/system/arm/cpu-features.rst
@@ -223,7 +223,7 @@ Below is the list of TCG VCPU features and their descriptions.
   When ``pauth`` is enabled, select the architected QARMA5 algorithm.
 
 Without ``pauth-impdef``, ``pauth-qarma3`` or ``pauth-qarma5`` enabled,
-the architected QARMA5 algorithm is used.  The architected QARMA5
+the QEMU impdef algorithm is used.  The architected QARMA5
 and QARMA3 algorithms have good cryptographic properties, but can
 be quite slow to emulate.  The impdef algorithm used by QEMU is
 non-cryptographic but significantly faster.
diff --git a/docs/system/introduction.rst b/docs/system/introduction.rst
index 746707eb00e..338d3745c3c 100644
--- a/docs/system/introduction.rst
+++ b/docs/system/introduction.rst
@@ -169,7 +169,7 @@ would default to it anyway.
 
 .. code::
 
- -cpu max,pauth-impdef=on \
+ -cpu max \
  -smp 4 \
  -accel tcg \
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 01d9ff1781a..9a6e8e589cc 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -972,6 +972,9 @@ struct ArchCPU {
     /* QOM property to indicate we should use the back-compat CNTFRQ default */
     bool backcompat_cntfrq;
 
+    /* QOM property to indicate we should use the back-compat QARMA5 default */
+    bool backcompat_pauth_default_use_qarma5;
+
     /* Specify the number of cores in this CPU cluster. Used for the L2CTLR
      * register.
      */
diff --git a/hw/core/machine.c b/hw/core/machine.c
index c949af97668..c23b3994964 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -36,7 +36,9 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "audio/audio.h"
 
-GlobalProperty hw_compat_9_2[] = {};
+GlobalProperty hw_compat_9_2[] = {
+    {"arm-cpu", "backcompat-pauth-default-use-qarma5", "true"},
+};
 const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
 
 GlobalProperty hw_compat_9_1[] = {
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index dcedadc89ea..dc0231233a6 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2653,6 +2653,8 @@ static const Property arm_cpu_properties[] = {
     DEFINE_PROP_INT32("core-count", ARMCPU, core_count, -1),
     /* True to default to the backward-compat old CNTFRQ rather than 1Ghz */
     DEFINE_PROP_BOOL("backcompat-cntfrq", ARMCPU, backcompat_cntfrq, false),
+    DEFINE_PROP_BOOL("backcompat-pauth-default-use-qarma5", ARMCPU,
+                      backcompat_pauth_default_use_qarma5, false),
 };
 
 static const gchar *arm_gdb_arch_name(CPUState *cs)
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 6ee0af69121..8188ede5cc8 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -529,15 +529,25 @@ void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
                 return;
             }
 
-            if (cpu->prop_pauth_impdef) {
-                isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, API, features);
-                isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, GPI, 1);
+            bool use_default = !cpu->prop_pauth_qarma5 &&
+                               !cpu->prop_pauth_qarma3 &&
+                               !cpu->prop_pauth_impdef;
+
+            if (cpu->prop_pauth_qarma5 ||
+                (use_default &&
+                 cpu->backcompat_pauth_default_use_qarma5)) {
+                isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, APA, features);
+                isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, GPA, 1);
             } else if (cpu->prop_pauth_qarma3) {
                 isar2 = FIELD_DP64(isar2, ID_AA64ISAR2, APA3, features);
                 isar2 = FIELD_DP64(isar2, ID_AA64ISAR2, GPA3, 1);
-            } else { /* default is pauth-qarma5 */
-                isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, APA, features);
-                isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, GPA, 1);
+            } else if (cpu->prop_pauth_impdef ||
+                       (use_default &&
+                        !cpu->backcompat_pauth_default_use_qarma5)) {
+                isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, API, features);
+                isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, GPI, 1);
+            } else {
+                g_assert_not_reached();
             }
         } else if (cpu->prop_pauth_impdef ||
                    cpu->prop_pauth_qarma3 ||
-- 
2.34.1


