Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCC7C27C54
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 12:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFCQA-0001Ny-Vd; Thu, 06 Jun 2024 08:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFCQ3-0001Jw-1R
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:40:41 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFCQ1-0002RU-42
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:40:38 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42108856c33so12134175e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 05:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717677634; x=1718282434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CRSz2yaOsEhwUEucQOXNUUVmWnoAQi/uTeMffq4fYCw=;
 b=E8n01ZALd7ywVD71zre1scXUbMVv4hdpGKCzsxGxA5PhQ6RBstGqugkk8QUVpuUWhA
 oRSAAhCaj8kpfkliTDYYJo4dstnTQbnPBTY0Si1Peb6RTu7bT5Cbg6acLwGfMlrH7CHV
 b5tLxm+LVyzFfzhDWkoEfXTCNmiEw0XJm3hhqhusbTuWnxZetQrMX2aVSo3WSBnISRGc
 BF7ZftMKDL4s+dTuVo78sVFK9zxuU4e7VErHPa5rRHBrM2A3VtoDnorUKgglnYKosIbf
 cjfh1nMNK+Vk+NLSYhGm/jrlyFcFzdGVF2YyApqQL8E217Fm5wGudFPckLGQKmi1jApr
 U+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717677634; x=1718282434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CRSz2yaOsEhwUEucQOXNUUVmWnoAQi/uTeMffq4fYCw=;
 b=CQL2ZS9q4FeHpZI80MGlQb+bTjZ2MWO7ZqjJTcmfqFP+Uxf1DOUXXRklk9+yb/nI7M
 w8hBtJ53dMPl060xBiP1Sy7ppFr4nDEMkIxukBqj/EA78S7VR2A0uSDh9xjSEL62Wnfl
 q2GpP2IYWBbKhaas7k/dEunicy1koH/sYw3K9r4h0keOqhJCKVWqB2SsSo47nCDzUoSl
 PNyBgVLUxg6XKVIBeH77se2OFVOEO27wo3QPleItO9zIQasUG8AnNM710ZI2e4TV3mY3
 Mj0E4EAUKpZCg/gGSOKlB58FbpampMnfY8FByUiTdyvgqcpi0xAXiWkZBBxivoLN7Xas
 5dsA==
X-Gm-Message-State: AOJu0Yxq77CaaSjHvbboVwWfIGtiNE5EORt25JbJBDRBBAu0TDyy+f7i
 uHhEhX01l9CILWc/2vCTkrdnjBiBQzJ5dEXCeOUz4fCaipECWwfK8ygoWcxwxGJx3NiRx+OpaI9
 0pbA=
X-Google-Smtp-Source: AGHT+IEZ2RL13Eh+mo1ygYvB/9zgzn5BZEJHrltPq+uKH0hh3U+vQw3U0wGPCO+dCo7UP1NGcXo00g==
X-Received: by 2002:a5d:6a44:0:b0:357:16f6:71dc with SMTP id
 ffacd0b85a97d-35ef0d7a2e0mr2482270f8f.13.1717677634496; 
 Thu, 06 Jun 2024 05:40:34 -0700 (PDT)
Received: from localhost.localdomain (94.red-88-29-105.staticip.rima-tde.net.
 [88.29.105.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c2c6bedsm20432045e9.30.2024.06.06.05.40.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Jun 2024 05:40:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 3/3] accel/tcg: Move qemu_plugin_vcpu_init__async() to plugins/
Date: Thu,  6 Jun 2024 14:40:10 +0200
Message-ID: <20240606124010.2460-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240606124010.2460-1-philmd@linaro.org>
References: <20240606124010.2460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Calling qemu_plugin_vcpu_init__async() on the vCPU thread
is a detail of plugins, not relevant to TCG vCPU management.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/core/cpu-common.c | 9 +--------
 plugins/core.c       | 8 +++++++-
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index cd15402552..79fcc0b286 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -192,13 +192,6 @@ static void cpu_common_parse_features(const char *typename, char *features,
     }
 }
 
-#ifdef CONFIG_PLUGIN
-static void qemu_plugin_vcpu_init__async(CPUState *cpu, run_on_cpu_data unused)
-{
-    qemu_plugin_vcpu_init_hook(cpu);
-}
-#endif
-
 static void cpu_common_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cpu = CPU(dev);
@@ -274,7 +267,7 @@ static void cpu_common_initfn(Object *obj)
 #ifdef CONFIG_PLUGIN
     if (tcg_enabled()) {
         cpu->plugin_state = qemu_plugin_create_vcpu_state();
-        async_run_on_cpu(cpu, qemu_plugin_vcpu_init__async, RUN_ON_CPU_NULL);
+        qemu_plugin_vcpu_init_hook(cpu);
     }
 #endif
 }
diff --git a/plugins/core.c b/plugins/core.c
index d339b3db4d..3dec3556c3 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -241,7 +241,7 @@ static void plugin_grow_scoreboards__locked(CPUState *cpu)
     end_exclusive();
 }
 
-void qemu_plugin_vcpu_init_hook(CPUState *cpu)
+static void qemu_plugin_vcpu_init__async(CPUState *cpu, run_on_cpu_data unused)
 {
     bool success;
 
@@ -258,6 +258,12 @@ void qemu_plugin_vcpu_init_hook(CPUState *cpu)
     plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_INIT);
 }
 
+void qemu_plugin_vcpu_init_hook(CPUState *cpu)
+{
+    /* Plugin initialization must wait until the cpu start executing code */
+    async_run_on_cpu(cpu, qemu_plugin_vcpu_init__async, RUN_ON_CPU_NULL);
+}
+
 void qemu_plugin_vcpu_exit_hook(CPUState *cpu)
 {
     bool success;
-- 
2.41.0


