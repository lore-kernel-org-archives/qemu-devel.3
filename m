Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D56C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 13:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZsV1-0005nb-DR; Tue, 13 Feb 2024 08:06:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZsTP-0002a2-Gi
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:05:23 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZsTE-0006Mx-5M
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:05:14 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-410db155e57so14028155e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 05:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707829505; x=1708434305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f0fVvYEwFHKEuJye0m7tE2Ksg3XkzZ7A8P3KgL7X69E=;
 b=eCkjN2gwIKCunjzEI0DOiStsScxGgI5xc5/ShHoqDeAo96/s9sE6mvTrQ6HGf5V/b7
 vaYtfUbeCLslHbxtjTx216PclXWSFlD3soT6Fs6EqcvE5acZRMJQ7rq9gi+o58xZ36PU
 eO/HqRf9sijzKATZz3M+pB7OQEFY1JZZEBEZJNrc5prLjQb+Fo9db7dAIgkLRi2wzIuE
 dqyKkXiGkV9PT8fQF1tQnoSEzLAlLFB29DqI93nzZGMXSpZiwA6Kea/w9+KF8LOJfDBS
 ZhONTIt3oUUjehp3EcNhiwIP0vjyB562LEV/84OApKDZa2XPJpfZc2bWlc/fC8ESWjq9
 vD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707829505; x=1708434305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f0fVvYEwFHKEuJye0m7tE2Ksg3XkzZ7A8P3KgL7X69E=;
 b=liDaBGQTQqNAdCBxaT4jba4pZ0lgZ/oVUl918jVxwP9KFz3cwSE9tAiKdAPQ/Ke0jK
 JqA4O3Fq1lH8sFOG4ypXKC8k8HC/tX1Z8tZftFrvR2q1eO6hjalNdQwUof0TWDLxKq4/
 b/dkA4xyo9bDjdnYO8elWn35XJxETIil8qeeSAoJZzqzgQgL2cs1XV7+LK0dKbz2Q5he
 Jog1n5VDi1jJFQmHO1xvOE9lge6vqzhlv1ALY7ekMQaQcQAEUFIjOBejmnvmW0BlA+4c
 3Kqlb7Gb5BzeRaiXsqJrQk1y/+/AvFKcdiWfPuTEAXoMaxvKgUg5O5ywQCebMIoF4U31
 J8UQ==
X-Gm-Message-State: AOJu0Ywa8Q1YUqTkAWXLnekv1k+KglsVc8pZVqaR9Nig+FOybShsDvaD
 z9jJGwE3CiE4bJyIe522sdkRaNER9QGxiqIGSiPeaB9h2LikzRDn+ZM7+GnN+c7VLXik2h3pwK8
 e
X-Google-Smtp-Source: AGHT+IHMrUTnZob2rkJSjAvK+C6k2E0aPyKs3ttmQY4Q+qRCfX4sSGBPfiRGYrTNSnlpuPnyHcVJhw==
X-Received: by 2002:a05:600c:1f18:b0:40f:b691:d3c1 with SMTP id
 bd24-20020a05600c1f1800b0040fb691d3c1mr7989569wmb.30.1707829505301; 
 Tue, 13 Feb 2024 05:05:05 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWewp6QbmZBRyB9ZP50Ix24ln72h+9o3GfoTchBmrSG9YYrtu8X7YwYKKzK8Nyarl0LNYjb4Mt6sy+1lTJdNsISoG/eymbDRTu/HPyBL5PsaG6LCK48VdK4aN2bVAR8wXF9PHC/oVRKG3N1Uvqcd6J8buvAIjoT9rKFnfQmupegs/xWMdGkA6k+XropZF2qtVIOamCf4s40TwawBRJgXuV1FOu76CkBou0dfeahUsoJiNQ/EemXCx+CAZO+w8Fnl4mb4Eh4izT1u468gDGngtIuJAuoLuS999ShBFUWpRW6rq44d8NeJAlGpoZ+6joJQG/z8S+gdHpeTMlJgOB8/MOlQxgbNMLHLmf6kdTh4k3EEKV9RexrYdxqBEvsBNOTSsoOFTQ2xQ==
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 ck18-20020a5d5e92000000b0033b7a2136a4sm7254044wrb.97.2024.02.13.05.05.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 05:05:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@linux.intel.com>, Bernhard Beschow <shentey@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v4 12/12] hw/sparc64/cpu: Initialize GPIO before realizing CPU
 devices
Date: Tue, 13 Feb 2024 14:03:41 +0100
Message-ID: <20240213130341.1793-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213130341.1793-1-philmd@linaro.org>
References: <20240213130341.1793-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Inline cpu_create() in order to call
qdev_init_gpio_in_named_with_opaque()
before the CPU is realized.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/sparc64/sparc64.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
index 72f0849f50..3091cde586 100644
--- a/hw/sparc64/sparc64.c
+++ b/hw/sparc64/sparc64.c
@@ -24,6 +24,7 @@
 
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "cpu.h"
 #include "hw/boards.h"
 #include "hw/sparc/sparc64.h"
@@ -271,9 +272,10 @@ SPARCCPU *sparc64_cpu_devinit(const char *cpu_type, uint64_t prom_addr)
     uint32_t  stick_frequency = 100 * 1000000;
     uint32_t hstick_frequency = 100 * 1000000;
 
-    cpu = SPARC_CPU(cpu_create(cpu_type));
+    cpu = SPARC_CPU(object_new(cpu_type));
     qdev_init_gpio_in_named(DEVICE(cpu), sparc64_cpu_set_ivec_irq,
                             "ivec-irq", IVEC_MAX);
+    qdev_realize(DEVICE(cpu), NULL, &error_fatal);
     env = &cpu->env;
 
     env->tick = cpu_timer_create("tick", cpu, tick_irq,
-- 
2.41.0


