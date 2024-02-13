Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EB5C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 13:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZsTo-0002sV-3n; Tue, 13 Feb 2024 08:05:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZsTC-0002OJ-Qi
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:05:15 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZsT1-0006Av-UJ
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:04:57 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-410ee8ed659so12533055e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 05:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707829492; x=1708434292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z6tfNfgtwQJ+hKgvVWTuaRcXckGlcPh4xersidzU6i4=;
 b=YkSPYmbCPqhT1HusDd2pSu8APVMTkTnUMh7kL1qmXsSE7PJ/HRWHFdAThgAc5HVVG8
 L4cOdrfZzfu55saBA5U/b057SJZh4UOgDQwRhtVQJfYsU2tKWOxH66AogRjkGJdDO48a
 ZxEr7MzKWJtRHGaOJNAbZ2JGdl+SDs4Pwyo7Q4xH7QLP9AXFSUWKQW7kBLi1x3np5xtb
 vw3JHLcTE/QYR5pZkD350ZpGfln4cNL6ltv2LUr7b1bBOo2z5xGI/fw56xcyafmQ53d6
 TTlV1t9lKaq1qPrYtLjO4L5h7fyYNQx/gkGV8BscRF1RxhoPyzoerz0QgOZXQPLEI1cP
 i+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707829492; x=1708434292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z6tfNfgtwQJ+hKgvVWTuaRcXckGlcPh4xersidzU6i4=;
 b=w4mr0ISSTlpmeBxprOqsbH3JKkL45oVAGRgaWor05FJccqirbMgtYr6mqll4wQvg5q
 fTF+8j9pYNYrDXg9z3DxnGxHJKr9RsC38tLpH6c7sJLwX/YH7nTsfhkOgP1hhOQgROal
 F9lIBfumJ5bhiqgXEceXuQiQVEztZ3Rp/6zvG3VoKzdsgoPWASIZgttZeIyA3DTFlUe6
 +w9tHEFBuEgOUSnK6gJqGDwQhUlVpllXn8Ucp2lxBetSsFtChWhZIQ8V8cWSWczg5G8d
 7+jetNQbO60UrAugsp1q91Eu6f3YyIq9pCogBaWQ3Eg1toHcjJvyoaKfgbpKR3rv/A7B
 w3AA==
X-Gm-Message-State: AOJu0YyG0HRmbRs6vOTXVfk9wG4kvaNjF0OG01NV0E5otxeNgJu2Hbu+
 W80KRWslzrgZclM9+t7J/GbU0EhIjBB6UWNwPtude5sp7WbyiASWK7npmkoY4omDfWuna2HNnXI
 B
X-Google-Smtp-Source: AGHT+IFbQKAVyIAEu2+IqNRu9PgGtLRbpeavFjec7Z1Rel8r6GygMaq55wVrLbJP3XloYHWUMCkUxA==
X-Received: by 2002:a5d:4983:0:b0:33b:4197:75dc with SMTP id
 r3-20020a5d4983000000b0033b419775dcmr7441418wrq.14.1707829492124; 
 Tue, 13 Feb 2024 05:04:52 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXIy9NiWKWjD7X6rhHNGIGXfQxWWDNj25dx6yV4jHNbJvWHLjJojgRgYlprKIwELly0prPoQL3RkBP+fqsCdfdjK3Q1nDGueh5P/NNRakLV1Qfd4DQG3SzS1DtPbFkMU93l9ylXa2nMc5h7XYQS6mXdp74YCVTafjasKmsvtPeffy6bau70UyDukGX8YIBAivjYU0ZCdd6iW2ZXJom0nWzWu4+V9AfvjmCI47B+FSmYtO5ZxwKc6OOY/LnVCW4rXKrXe2O2l8qkzE9bBTCI38UxOS7hMrWT3gpFhoHs8ORQrfphD5TXHo9AqsfREaXoixGkk3rBf2X/qSShXgrYjVBpzU8aFBzb1CjVQQfnsT2pVPQgnqt+jbUUxHzOY/6FgSda0m4G4KyAIiHcFsGQAy53Jr9CyJFyDVmXU5I=
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 x8-20020a5d6508000000b0033b1b01e4fcsm9553815wru.96.2024.02.13.05.04.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 05:04:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@linux.intel.com>, Bernhard Beschow <shentey@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v4 10/12] hw/sparc/leon3: Pass DeviceState opaque argument to
 leon3_set_pil_in()
Date: Tue, 13 Feb 2024 14:03:39 +0100
Message-ID: <20240213130341.1793-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213130341.1793-1-philmd@linaro.org>
References: <20240213130341.1793-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

By passing a DeviceState context to a QDev IRQ handler,
we can simplify and use qdev_init_gpio_in_named() instead
of qdev_init_gpio_in_named_with_opaque().

Suggested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sparc/leon3.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 0df5fc949d..d2be900988 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -175,9 +175,10 @@ static void leon3_irq_ack(CPUSPARCState *env, int intno)
  */
 static void leon3_set_pil_in(void *opaque, int n, int level)
 {
-    CPUSPARCState *env = opaque;
+    DeviceState *cpu = opaque;
+    CPUState *cs = CPU(cpu);
+    CPUSPARCState *env = cpu_env(cs);
     uint32_t pil_in = level;
-    CPUState *cs;
 
     assert(env != NULL);
 
@@ -193,7 +194,6 @@ static void leon3_set_pil_in(void *opaque, int n, int level)
 
                 env->interrupt_index = TT_EXTINT | i;
                 if (old_interrupt != env->interrupt_index) {
-                    cs = env_cpu(env);
                     trace_leon3_set_irq(i);
                     cpu_interrupt(cs, CPU_INTERRUPT_HARD);
                 }
@@ -201,7 +201,6 @@ static void leon3_set_pil_in(void *opaque, int n, int level)
             }
         }
     } else if (!env->pil_in && (env->interrupt_index & ~15) == TT_EXTINT) {
-        cs = env_cpu(env);
         trace_leon3_reset_irq(env->interrupt_index & 15);
         env->interrupt_index = 0;
         cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
@@ -261,8 +260,7 @@ static void leon3_generic_hw_init(MachineState *machine)
 
     /* Allocate IRQ manager */
     irqmpdev = qdev_new(TYPE_GRLIB_IRQMP);
-    qdev_init_gpio_in_named_with_opaque(DEVICE(cpu), leon3_set_pil_in,
-                                        env, "pil", 1);
+    qdev_init_gpio_in_named(DEVICE(cpu), leon3_set_pil_in, "pil", 1);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(irqmpdev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(irqmpdev), 0, LEON3_IRQMP_OFFSET);
     qdev_connect_gpio_out_named(irqmpdev, "grlib-irq", 0,
-- 
2.41.0


