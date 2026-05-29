Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7BECD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 14:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSy9m-0004vi-MR; Fri, 29 May 2026 10:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSy9j-0004ky-P7
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:25:47 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSy9g-0002jH-Mb
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:25:47 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso94982715e9.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 07:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780064743; x=1780669543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LKn4RQHGDomnnmi9l8u/n3j933cMw6QUVCqU0AdCGPc=;
 b=kvgiZ2yMpsdKJOE9DaorRHiYolCntKp8AD9rhqChb4whCmkokkvn88KoP+NIiUyQia
 w2MG5XAgzgZa9mEjJ2GPETuRLJ3mCTHJKEQw8SAgbcO5ejYoJqCb9mQux/SaDvWZnmJk
 NUhpNxKmYKno0dB8+S5HXpZRp32NmfuHVRJtSBTXPPEDbZVK3Wd8JLrQexTxzUobyGKs
 THvs6jHRCumjq0TyvjSV/zWBGdvOOKF+KEiYKi1r6wtUejz20Q7MCqJsHf9NaHNEQ320
 vLfLchnnXz2o+eOLc1NCxgwfgZaN7xFATPM057rA9BywiXo1yY+1MVbUAYIYlz6S19KP
 cUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780064743; x=1780669543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LKn4RQHGDomnnmi9l8u/n3j933cMw6QUVCqU0AdCGPc=;
 b=koEQfj7NmLsWtvPo2zDMisCPisP5q4A5gGL8mfdKQQ6l023RSuFBh/Xm8PKXdzF7Dl
 x13TYXg6fdlCujWMZ7u+QGv6rws6yWLLILyd5sh8DdfUrGbLwdNlYR7lYzw38kJJTr+s
 qAcTBfP1nkwFrS6/O5NCKzIJZW3o8UIG1KPirG3ZSLmeyQvISZPHOd+nxFiWSijEjLKh
 ZMxPJSL76X+sx1LO22NDTFBIHlRAzr2sbjiQ2ocn3UyNVQMG4YxFHXiboKRyLkevVpqG
 E+9Gi0/t9z6ds6wBitjSer42UEZigvs3FVnpry1Sk1uSO1Y59DONXHNHwU1+C+BMFVkj
 l7Aw==
X-Gm-Message-State: AOJu0YwTVUiLGgtRmd1K6DhuTqDunmxx9cpioz2tMmNFI2D60U1Jt35Z
 EJyqb6eB0zQ8N6qe20qqvepUd4JOPYg4zoseFaBtPDfNV/C1c4DVuX25YEN1yJpXYuXmk5bIcUE
 1/WSqYYAE1w==
X-Gm-Gg: Acq92OHRMPVOH2unSranJU+FVD3IR5fjG9phi8nju3bgT0yymuojG9qUIySsN9M62kn
 xCydjnDDpSvbiswF05pOIuitt1a33aTh9u1kU9NtgcNKMgphb5R2h2j7qGAkLr0Gtzvos5lCuP2
 uDkW7hwqvKcqZux35e9p5QKbMNFiShQslRrJkK96VDwR0ZhT7Ia71NVhk3wPukxYLvG2mjAHGkV
 GpQAYSfQRsXZwf6qrMmXtTcPntM1j6TlSnLEM5iT22c0UpAySggdWxV8ozrgPemkM4OSTsXcF94
 0HUiK7YDRj7n2wsuNbJYUesKLVUytnHadCSTO3VnrsP4mrvc5+mtkyE3GtV7kYzg5ifk7WcvEpv
 TDYJcPGD/Q0/mCyjI4SUxp8tDOlNh7X506ueRyVKR3kDbDTblY6X0TwJmNNc3nUrODkDegrb8cc
 pYEliDs5fDjwK57bPI5q7avpyGgAEABcXQJMrwtk01SsRjpyopqhLmpUd1BQlNzyYYcQ==
X-Received: by 2002:a05:600c:897:b0:48e:6f39:f7be with SMTP id
 5b1f17b1804b1-4909c07f9e7mr33215785e9.10.1780064742579; 
 Fri, 29 May 2026 07:25:42 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d68b853sm45850685e9.3.2026.05.29.07.25.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 07:25:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <gaosong@loongson.cn>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 kvm@vger.kernel.org, Claudio Fontana <cfontana@suse.de>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/17] accel/nvmm: Convert AccelCPUClass ->
 AccelOpsClass::cpu_instance_init
Date: Fri, 29 May 2026 16:24:24 +0200
Message-ID: <20260529142434.87880-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529142434.87880-1-philmd@linaro.org>
References: <20260529142434.87880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Register the new AccelOpsClass::cpu_instance_init hook.

ACCEL_CPU_NAME("nvmm") TypeInfo is now empty, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/nvmm/nvmm-accel-ops.h |  2 ++
 target/i386/nvmm/nvmm-accel-ops.c |  2 ++
 target/i386/nvmm/nvmm-all.c       | 19 +------------------
 3 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/target/i386/nvmm/nvmm-accel-ops.h b/target/i386/nvmm/nvmm-accel-ops.h
index 931bb5ca243..f2a78c12110 100644
--- a/target/i386/nvmm/nvmm-accel-ops.h
+++ b/target/i386/nvmm/nvmm-accel-ops.h
@@ -16,6 +16,8 @@ int nvmm_init_vcpu(CPUState *cpu);
 int nvmm_vcpu_exec(CPUState *cpu);
 void nvmm_destroy_vcpu(CPUState *cpu);
 
+void nvmm_arch_cpu_instance_init(CPUState *cpu);
+
 void nvmm_cpu_synchronize_state(CPUState *cpu);
 void nvmm_cpu_synchronize_post_reset(CPUState *cpu);
 void nvmm_cpu_synchronize_post_init(CPUState *cpu);
diff --git a/target/i386/nvmm/nvmm-accel-ops.c b/target/i386/nvmm/nvmm-accel-ops.c
index dd5d5428b1c..60044b83527 100644
--- a/target/i386/nvmm/nvmm-accel-ops.c
+++ b/target/i386/nvmm/nvmm-accel-ops.c
@@ -87,6 +87,8 @@ static void nvmm_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->kick_vcpu_thread = nvmm_kick_vcpu_thread;
     ops->handle_interrupt = generic_handle_interrupt;
 
+    ops->cpu_instance_init = nvmm_arch_cpu_instance_init;
+
     ops->synchronize_post_reset = nvmm_cpu_synchronize_post_reset;
     ops->synchronize_post_init = nvmm_cpu_synchronize_post_init;
     ops->synchronize_state = nvmm_cpu_synchronize_state;
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index 8a1af35ed32..10ab7b2a4dc 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -22,7 +22,6 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu/queue.h"
-#include "accel/accel-cpu-target.h"
 #include "host-cpu.h"
 #include "migration/blocker.h"
 #include "strings.h"
@@ -1212,33 +1211,17 @@ static const TypeInfo nvmm_accel_type = {
     .class_init = nvmm_accel_class_init,
 };
 
-static void nvmm_cpu_instance_init(CPUState *cs)
+void nvmm_arch_cpu_instance_init(CPUState *cpu)
 {
     X86CPU *cpu = X86_CPU(cs);
 
     host_cpu_instance_init(cpu);
 }
 
-static void nvmm_cpu_accel_class_init(ObjectClass *oc, const void *data)
-{
-    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
-
-    acc->cpu_instance_init = nvmm_cpu_instance_init;
-}
-
-static const TypeInfo nvmm_cpu_accel_type = {
-    .name = ACCEL_CPU_NAME("nvmm"),
-
-    .parent = TYPE_ACCEL_CPU,
-    .class_init = nvmm_cpu_accel_class_init,
-    .abstract = true,
-};
-
 static void
 nvmm_type_init(void)
 {
     type_register_static(&nvmm_accel_type);
-    type_register_static(&nvmm_cpu_accel_type);
 }
 
 type_init(nvmm_type_init);
-- 
2.53.0


