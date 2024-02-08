Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0694AC48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 18:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY8uP-0006Hp-UW; Thu, 08 Feb 2024 13:14:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rY8uO-00065A-9E
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:14:00 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rY8uL-0006t9-Ub
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:14:00 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a2f22bfb4e6so12022666b.0
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 10:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707416036; x=1708020836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e0Ufl9fqBfA4JrpwEmiN6ER59zmqlqLsBKlzkxxHoFQ=;
 b=DRtKoL7EEoO49IUAU6sA7DmmTc7syfWoRA+317qbBESw2ezVfDpoOZ0a7Ko5MO0jjz
 pONop6zedD8lgkZTPNAMyiWUmRmUytkgUkgtrQmzMDz8wPgIV9oLYktajXKk1VBtviio
 lgjgvvokfd+Jw+Wq9C964pNgKTtNSUpLmI0U6g48QSkaKMM//4ElGQTCC37jE5jNNko/
 KTiTR4R6GvnJ6upD9+P86+qk5VqkLqgf0JeoSKqMZSGpJs6FaiuRkwT6yAXiF6R9y/gz
 lgnNomn+hsdWVyI2zbj1gzuzzXjYg4ML8zgPUfBZZMBDgvF+PG/cEEimqXoKeBa5OWzj
 LWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707416036; x=1708020836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e0Ufl9fqBfA4JrpwEmiN6ER59zmqlqLsBKlzkxxHoFQ=;
 b=Y8smPFC5ZH4RrPxEn6kJaUSpehTxPxZb8LJ+WkVoMMUXxE5uv3Okt6WA81lJY43sEs
 zEy+zzwQxNxPKDS95kHdYK5MDrjw3c7J7pdjP3maicut68bzpHdxE5I4QlFGNlOGqAH4
 /pXSlrCitXYB3wn3ziFCFaJJa5xuEybuC/5Tk4eYFvAx2A3kCNONW2AfMlr104PVRQxd
 dgpnzsAfcQUjupoXnJYFN5X3VwzHoKkQxF1n96ZiIrTFJzXP+bBrTrRBiyZO5dPdZzMS
 QnI29AJifzz6qVAxDfY5bBPhE1milYeJNLhJderlYHkmVSlZSitq+LDRbqFlg+dNK/x8
 aNwQ==
X-Gm-Message-State: AOJu0Yzy35VDQESI0rdt+b80WBmxvQXVulL/NY1Yc9bbgo14JRaQlpHS
 VqEehv9musxmBVUAJm6AvqrbVEznILhMdeM0gbucFOXJnr5cIVaXm7yD9td4K/pFXs9LB/F1Ksw
 SEFE=
X-Google-Smtp-Source: AGHT+IHgsm41GzCMAivOTWSCsERp8TnKsaHIUDvbsNKZ5OjpWc8oL+u+lZqR8inKZ+TF6z5irvJqSA==
X-Received: by 2002:a17:906:4808:b0:a37:aa3b:f56 with SMTP id
 w8-20020a170906480800b00a37aa3b0f56mr82482ejq.49.1707416036295; 
 Thu, 08 Feb 2024 10:13:56 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXC+04nAVm0zyDOUEvv5ti6R/jvcT9j+VXkU7fy1k21yTDd5UCfYql7jILgh0hcpandaqeRv0O0R/1WVHUnsvAqmFlwvbcEE1uhoAjRyaeRgRiqFTzJ1WqJ3TUhyVcNCgyuSC9SkTIJDR/wJBAwRviEbeGHsI1rvoyl7bm0EVu+dlCKrjGrxS7s4+Gx8ZmemLTCVrJyGdDxPTrPwBQ+Fl+J9MAXoImiERssDSpUcRVvIIzWGG+euB+MBHPl4k5L8prV1rRAlLdi/9P1tSeN0YEv0JVWRINaoHWd5DQXOqdYTquUmlgnmCqNK/bweD+0KQkywwGLI15QFNq1IaYghDe+srVdmKydBEYP+w==
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 lf4-20020a170907174400b00a3bbf725080sm303160ejc.55.2024.02.08.10.13.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Feb 2024 10:13:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v3 11/11] hw/sparc64/cpu: Initialize GPIO before realizing CPU
 devices
Date: Thu,  8 Feb 2024 19:12:44 +0100
Message-ID: <20240208181245.96617-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240208181245.96617-1-philmd@linaro.org>
References: <20240208181245.96617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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


