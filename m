Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F67C36014
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0USR-0004Uh-1n; Thu, 03 Apr 2025 19:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0USP-0004Tm-Ow
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:58:49 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0USO-0002Se-3m
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:58:49 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39c266c2dd5so1253652f8f.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724726; x=1744329526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PhZdnfz+UN3n5DTP+/t+ydvw2Q2+PLLpLlc8rXzZtok=;
 b=kRx5dde1Yog1lAr8bZtO0rLvJIknK1sCN4I/81vI7edQrfZPIsajzp8t2yZC1MJzLz
 pCdGMLBw7edR9Me+5ichLOpMfrybljkrSORdPupUzysU5E79xXHnEd0V4k0ph73KmgV0
 v9o9EMeDM04ouOesuYi1y2/kx8aS5R9q3PenwJj+V8ZSAJ/QjQ0PinEhDXJO/VhzzIgh
 bzKCoG4tKkP7Jdl2C2iGuR+uuQpiEENAr8EGpNrAZObsT6H8khOrBkA1iTic2y0ssmAz
 yrIwVwLk2LJ3Ym1020hIKSLUlf5fA5fooY91vluxe32r05uiK4GX1OScqdjZDrxIkP3t
 Jj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724726; x=1744329526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PhZdnfz+UN3n5DTP+/t+ydvw2Q2+PLLpLlc8rXzZtok=;
 b=buYXKQgZzPXVsTzyuhlOb3grCew0IXH/jQy4Z3BHSjKDY6orR7cVn1vFs2ctk+d8Mh
 97VchnnSswNUFLZyd2qmf8iHgalBSDVfOSQlVm5IDR81gBkvN4D1gSO+mqs2gQzvjF2/
 bl377JcGaK96jjjx3Wu2eBt1yEdbSursBQqu4yI942lg1jTwQEGDfjyT7U83egLjjtzK
 Wa2GPtw0W10BmJFY0bD/c8x3yPTrqmPVMgJXd7v9i3nUZ4sqE45ZYaPCcQgtctael+z5
 yJHzV957dxizWxrauWwUDNZicp/WRIIjFdQNCbtHjC1BWCgY7iM6pP905WxUtgyL8SXL
 8Bng==
X-Gm-Message-State: AOJu0Yw1wLtqlaffn+fXJocpe+ZuazOHXk6EPH6wNcrXB/rlMXU3OGM2
 sIRzILzdYcu/ct6EApepAE1+0ezF0IaxrsK/zEZJP6C+5QlilcpxD0w7suzl+zpdnNl/YoN6xPD
 x
X-Gm-Gg: ASbGncvsA4E03k01TEiJtEXm1BZKN7xWRv//xuaD9dbl0FPE1ppbgQp/SxahZNn6aMz
 sfZ0TUQ6wZg8lF8VC0ae0wnAoHsXRLuxt/gQhzBEmSYZFTRVHt50/EbI2It0ZDXba1bsOZUDdjf
 oRpdvQGUhl/rt8vCoA2W/xw0WRIsgir+XAltwF5XxZ6oIPAxRlA7o096SQyOSJVu+AN8XObcwet
 b6AhGuSf7cy4/yo0RAXBlEE5IQ7AroSmGito5RqeMcke8/pRkJjc181UBbdqbmCtzeZLQ63+HZQ
 mlcpTBarEwVfM00Kx0U7cabVN0KMVqKvs6q2Jg+61ieQrAaEE8olUBZuP7CGkM/UPoqTd5ykJKK
 VNAI6HWx58vLq+WC7KVY=
X-Google-Smtp-Source: AGHT+IF7htBl/12AIAduYvRIMb6+pZgOWKYSQllyRa8zJ8e2FzenNIB1TTKeDxOkbU3Lj0qgfJMOSg==
X-Received: by 2002:a5d:648c:0:b0:39c:1f02:5409 with SMTP id
 ffacd0b85a97d-39d08b10724mr516977f8f.9.1743724726256; 
 Thu, 03 Apr 2025 16:58:46 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec364d071sm30461335e9.32.2025.04.03.16.58.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:58:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 03/39] target/arm: Filter CPU types for binary
Date: Fri,  4 Apr 2025 01:57:45 +0200
Message-ID: <20250403235821.9909-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.c   | 2 ++
 target/arm/cpu64.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 377791c84dd..b1aa482c726 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -50,6 +50,7 @@
 #include "disas/capstone.h"
 #include "fpu/softfloat.h"
 #include "cpregs.h"
+#include "qemu/target_info-qom.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
 
@@ -2759,6 +2760,7 @@ void arm_cpu_register(const ARMCPUInfo *info)
         .instance_init = arm_cpu_instance_init,
         .class_init = info->class_init ?: cpu_register_class_init,
         .class_data = (void *)info,
+        .interfaces = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
     };
 
     type_info.name = g_strdup_printf("%s-" TYPE_ARM_CPU, info->name);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 8188ede5cc8..9f8c98563ac 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -24,6 +24,7 @@
 #include "cpregs.h"
 #include "qemu/module.h"
 #include "qemu/units.h"
+#include "qemu/target_info-qom.h"
 #include "system/kvm.h"
 #include "system/hvf.h"
 #include "system/qtest.h"
@@ -856,6 +857,7 @@ void aarch64_cpu_register(const ARMCPUInfo *info)
         .instance_init = aarch64_cpu_instance_init,
         .class_init = info->class_init ?: cpu_register_class_init,
         .class_data = (void *)info,
+        .interfaces = LEGACY_BINARY_QEMU_SYSTEM_AARCH64_INTERFACE,
     };
 
     type_info.name = g_strdup_printf("%s-" TYPE_ARM_CPU, info->name);
-- 
2.47.1


