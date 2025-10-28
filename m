Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE517CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDcnA-0003JL-6i; Tue, 28 Oct 2025 02:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcn5-0003Cz-Oj
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:02:43 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcn3-0005fD-Id
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:02:43 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3ee15b5435bso4077677f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761631358; x=1762236158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HxYM4u3dYFgXtTituwGbMoaQJ7IaJZc35NgLj0t32r4=;
 b=PDDGQy4/UZztCcX7moDM78ef6Uuvxh+PJ/eXiDNkH169IEdu+C5ZWqNpS39YFN0XhS
 DmnO8OI4KH6gc4ELIl18nCJs5WiSAOimUpEHVPMQZ1fe/6VUoVdqUSmCCGZlsvFZoZcB
 pTQ8BSitTnP+3JVITz10sjYc2cE5lAUHMiGUGT0JCHNXS+Viz+nri/JA8a1v1QAXKo1r
 PR6w/YF+8TjaE0n5RjUt6maEcqOE5Ar0Q9YT+Azc+Leubhaw/7eONCCzPfvnwWU3lYp2
 +HIknwf4YDZUMIUou0F6z6oThe/ANpmvwYwz1gDGdvLxbj64N4qIDBOth7yaMPkY9+/4
 p3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761631358; x=1762236158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HxYM4u3dYFgXtTituwGbMoaQJ7IaJZc35NgLj0t32r4=;
 b=NNuwBQc0su7xSzzveI/bmTJm+6OD1d9WLgGBBGgYXJ/3Zu2eLheWJew6QGzcdOi2um
 nQECDcQBgskLmbTEHywqAvyYX1ral4q8A+GN1V2Oy/KTPh3cI0MDW1iJLAOW28wyK2Wo
 I/cQt327KQjiZqGmNXBuYVBnlyodKd8DMop8MFElOHyTkNBuCQvmZhxNCdtZF3i9aooz
 urBESIRgvX2kpdiD/Nj5OVb6U/lmqVEIMuGtBXVn0wopRdO4QYLYchTGpnCoXbMm0wJg
 K44hm80xl9KjGQcduRBhlVo1yjaHEBePNNDEag20OeF1s8/Rz9Hm0hPs6Y0UsFOCruzW
 NgOw==
X-Gm-Message-State: AOJu0YzsIF5bTAJE7BaAX837MZl02Qll0wNtUT1TLgT289CiklOcvnyp
 WvxBAUBQDnGK+FNrVGde50wHbdvwNjiIg4QRquXKSm7z4FpbZ+3cPrM4fEzMSdBcyvx9OPI4mlw
 LCeCzHLg=
X-Gm-Gg: ASbGncsMFFFiEYvi5EQfXjKeBwMQWLsd69Bd+VsD5IG7NXwXlmkG+GrvHMYwMa+TH7J
 1ticdEQbT5Ihhz35MTAwtCKVqI3YXdW/hbrV9Fdd4axiwsMPXm7QxaFjTqKgH/rMQwk6OxN0ZQj
 8IIZE1QYDDT73hjgy5qN5XUwORJZjvHHWv/wVlirVXP/kKhNptxJ7Zqd7qub8FZU1fK33sfvnA6
 6hni/WmdX/Hca3xYO/sxb76Vfn8jJa0Kg3UIG5fciXH8PWRm1mO5PjXvdPKPL4Z6QAU4uLZECMA
 hnG2NP0XL3rZr3n8Ui/PUNK50DlwM8EJQLLFaDXZ6YHk8ns/JZ7+SDB2Ho6nknSjFTi2n5x1eP8
 e5b9m5ZYTeownzu//5TP2oCwx56kfvpZwG5m3XAG2hL5PmviwMbYgKVlBni8SbDEjoGITkRT+ZP
 HB0nDKzgBfcNnPg6h0aLAudr+/pfYE7hua4tW0ovq2FbxMeZFB+WtlZ0Y=
X-Google-Smtp-Source: AGHT+IHbRvYiKx9tn6WuwU4E2OJ5IIlqD6krLj9AFlgNx6ARYvSvP/g/equMOrbkdaV9m9wO6UZ8pA==
X-Received: by 2002:a05:6000:718:b0:429:a7f1:bdf4 with SMTP id
 ffacd0b85a97d-429a7f1bf3emr1801823f8f.26.1761631358406; 
 Mon, 27 Oct 2025 23:02:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952cb55asm18305284f8f.17.2025.10.27.23.02.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 23:02:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 28/59] target/arm: Share ARM_PSCI_CALL trace event between
 TCG and HVF
Date: Tue, 28 Oct 2025 06:42:04 +0100
Message-ID: <20251028054238.14949-29-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

It is useful to compare PSCI calls of the same guest running
under TCG or HVF.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c    | 3 ++-
 target/arm/tcg/psci.c   | 3 +++
 target/arm/trace-events | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index a3bb71e63b9..f31b6e54ee7 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -34,6 +34,7 @@
 #include "target/arm/internals.h"
 #include "target/arm/multiprocessing.h"
 #include "target/arm/gtimer.h"
+#include "target/arm/trace.h"
 #include "trace.h"
 #include "migration/vmstate.h"
 
@@ -1025,7 +1026,7 @@ static bool hvf_handle_psci_call(CPUState *cpu)
     int target_el = 1;
     int32_t ret = 0;
 
-    trace_hvf_psci_call(param[0], param[1], param[2], param[3],
+    trace_arm_psci_call(param[0], param[1], param[2], param[3],
                         arm_cpu_mp_affinity(arm_cpu));
 
     switch (param[0]) {
diff --git a/target/arm/tcg/psci.c b/target/arm/tcg/psci.c
index cabed43e8a8..2d409301578 100644
--- a/target/arm/tcg/psci.c
+++ b/target/arm/tcg/psci.c
@@ -25,6 +25,7 @@
 #include "internals.h"
 #include "arm-powerctl.h"
 #include "target/arm/multiprocessing.h"
+#include "target/arm/trace.h"
 
 bool arm_is_psci_call(ARMCPU *cpu, int excp_type)
 {
@@ -79,6 +80,8 @@ void arm_handle_psci_call(ARMCPU *cpu)
          */
         param[i] = is_a64(env) ? env->xregs[i] : env->regs[i];
     }
+    trace_arm_psci_call(param[0], param[1], param[2], param[3],
+                        arm_cpu_mp_affinity(cpu));
 
     if ((param[0] & QEMU_PSCI_0_2_64BIT) && !is_a64(env)) {
         ret = QEMU_PSCI_RET_NOT_SUPPORTED;
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 72a2c7d0969..676d29fe516 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -23,3 +23,6 @@ arm_powerctl_set_cpu_on(uint64_t mp_aff, unsigned target_el, const char *mode, u
 arm_powerctl_set_cpu_on_and_reset(uint64_t mp_aff) "cpu %" PRIu64
 arm_powerctl_set_cpu_off(uint64_t mp_aff) "cpu %" PRIu64
 arm_powerctl_reset_cpu(uint64_t mp_aff) "cpu %" PRIu64
+
+# tcg/psci.c and hvf/hvf.c
+arm_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32_t cpuid) "PSCI Call x0=0x%016"PRIx64" x1=0x%016"PRIx64" x2=0x%016"PRIx64" x3=0x%016"PRIx64" cpuid=0x%x"
-- 
2.51.0


