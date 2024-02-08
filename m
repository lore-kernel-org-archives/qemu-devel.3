Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480DDC4829A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 18:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY8uO-00063b-1U; Thu, 08 Feb 2024 13:14:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rY8uK-0005lS-Iz
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:13:56 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rY8uG-0006sB-Pn
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:13:56 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5116b540163so125114e87.1
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 10:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707416030; x=1708020830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rJDi0dase1u+UxugeaCpuJyBUHrq46IwKZeWRl/RxT8=;
 b=b5iOrIJBrx0d3LphHmsNbMqIXL5Cu9pjxlAbg5Wxy6/lgaZdy6qWxE9FBEPLijregP
 O1BdnAm9TY0GtdMo9tIxSvt+4LOrNoMxx7Fr+M1CcPfxu5wz9YnhHcImhFaArerJBI1Y
 6cUIUagq3uTHcrxVZWjiPcu7C1KvsNMYBM63QfFyIRhUV8EBIgKFr1u5OrFn9+1Typr9
 JD2zCejnffkIiR2t2WpqbuHMEthgRWgRXsh0dEvqDmyWr9gh+m8U5yN/Z8SVbFQpT/j6
 KpggL8rNrbgQmZ0N9TX0hQ7TOHMyxkn/Dhi7koALbJpfJAW+iD1z8lRwxrH1+JzccYaI
 wqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707416030; x=1708020830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rJDi0dase1u+UxugeaCpuJyBUHrq46IwKZeWRl/RxT8=;
 b=JgLqn/6GXL0T20DZ6l9k22qTstWBglGMYKj5SZ5KBeN1T9lAWlwZvkUFv3YKKdCPeo
 ulhjlv4Rnc868fiBDUqag62S5oid7xk/qIw+RlNfabrcq45+ZtEm5JBsIYRgaBbnopqp
 8Sl7GiIWIT6SvV/ZZhlSNRg7IbpUSu8wb5pivEYA2Aol9PnOrvOjtS31M6N8JwhmI5pm
 /V0kTFT73wGf3dwkMjNbwORl+E8YtTpxzGLWWPsu8B6CZDbTR4/YyXVi5Xu2qF8X3+lv
 99x8HpJ0hcyuDrQ2gtAV9APcRmDvf1T9MWW4zMZoQWTJLg25c93bxLITXdupZfkHhaBJ
 zevQ==
X-Gm-Message-State: AOJu0Yx7gAD+2lv9wrsfPUYsmYyHmW1DvffDm2zCz/cldMlqHNYDLgvq
 EL5Bt0DxLPFsdwQgkW8UP2QJgwzaOgx3RqhVciE3Q1z3P82rxsJBdIoFcWsnEWS1Conj1WVbkrM
 fwzc=
X-Google-Smtp-Source: AGHT+IEkVmvMfcfNh5vamm5BWwJBPCzSIs/S3TwSJqgfO4sKWTIUVH+xR5fjd0f6T9t7D7ohMuiyww==
X-Received: by 2002:ac2:5f4c:0:b0:511:5361:20df with SMTP id
 12-20020ac25f4c000000b00511536120dfmr22799lfz.13.1707416030376; 
 Thu, 08 Feb 2024 10:13:50 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUaNaNjjnd3A3FmgNXUAOALmF0y5Wed6rvoAqmHZVw8V9mWBT5tTxeXyhPJtOFh3R0TWOFH2eqahfLI4U/tO0mo0kIc03uGZfeiQxbNWycH9X4O7jfRFhEukTu0zDFXZf672jNufRhplQSJivw5uhRE0cbuvV/6b0KqT2dOWxfAOwCfd8ygOGcRB/opX0GJWhMLGzTlggDFvw5azjf1RcrBVnPjXUiqsJhypTnwNRybfUXzkW+uQZGHietvkvRuI+JzQOTeVd77gQqczAxr/IgeENoojH3NM3Amt1e/Xyrr3CfZKCxnzUNLD5mwPyBmJBdUr4txR9KwNsNA+JOt/nSxEJ9WzLtUFG0BZhbd5pPp1vxyooL14v0q8VVxXzjvLP0487/YKjHlyF3cP4P1YyTg1oZIz02IyPa7/w==
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 o16-20020a17090611d000b00a384365e3b9sm294221eja.195.2024.02.08.10.13.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Feb 2024 10:13:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v3 10/11] hw/sparc/leon3: Initialize GPIO before realizing CPU
 devices
Date: Thu,  8 Feb 2024 19:12:43 +0100
Message-ID: <20240208181245.96617-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240208181245.96617-1-philmd@linaro.org>
References: <20240208181245.96617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
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
---
 hw/sparc/leon3.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 0df5fc949d..0e1d749306 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -234,8 +234,11 @@ static void leon3_generic_hw_init(MachineState *machine)
     APBPnp *apb_pnp;
 
     /* Init CPU */
-    cpu = SPARC_CPU(cpu_create(machine->cpu_type));
+    cpu = SPARC_CPU(object_new(machine->cpu_type));
     env = &cpu->env;
+    qdev_init_gpio_in_named_with_opaque(DEVICE(cpu), leon3_set_pil_in,
+                                        env, "pil", 1);
+    qdev_realize(DEVICE(cpu), NULL, &error_fatal);
 
     cpu_sparc_set_id(env, 0);
 
@@ -261,8 +264,6 @@ static void leon3_generic_hw_init(MachineState *machine)
 
     /* Allocate IRQ manager */
     irqmpdev = qdev_new(TYPE_GRLIB_IRQMP);
-    qdev_init_gpio_in_named_with_opaque(DEVICE(cpu), leon3_set_pil_in,
-                                        env, "pil", 1);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(irqmpdev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(irqmpdev), 0, LEON3_IRQMP_OFFSET);
     qdev_connect_gpio_out_named(irqmpdev, "grlib-irq", 0,
-- 
2.41.0


