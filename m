Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13361CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBYh-0005Ec-Tf; Wed, 27 May 2026 06:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBYg-000573-3o
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:32:18 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBYe-00012a-5x
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:32:17 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-44dd5cb0f81so8183389f8f.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779877934; x=1780482734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=78d0HwrwA11Xf8ziWYKsynuzeYNiLxadO/RJc8ZQzqk=;
 b=HJApVnZINiy76+H+946JhfKpTU+GVRs8hUuY8GhS3Sf0J1ie2/eoSQAT3OqLMYt8vU
 1Nh1wQQGSsnOSIoNSVlZKe2ul+BsKlZFRh+QJ+W2udevqLWOFcaUadnseGOfOzEa2deN
 AOxhLbmxe5c1cPimRnVN3NjIkg4JYxqFaUmbKO/beuiVz8tOENCb0Kh6MlvZuj3n9xLl
 X04O1mQuoRGtLOy474rlwl03S9nggU8RrINko3cO/sxPEZZ/sVESNe1KNOgj/g6lSYAJ
 dFbEY+7qzwaNjVdLVn0/El3Vkc1C67J6H40/amwsUEuz9Oihxo7GAxrC16trLEuL3yfc
 QtzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779877934; x=1780482734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=78d0HwrwA11Xf8ziWYKsynuzeYNiLxadO/RJc8ZQzqk=;
 b=JpPfYT3YWewSEctlAMbqc+lBeL6dM1ChltdEWCBvpMFZp8QiLf3oh6+xEEDoLjXrd1
 N4uUzY3X9j7tsuZTREheNJjunbAElO6AXLsVrwcCdDjkD3aEfzueZbAyu3oBavHtH0zA
 rGXC85iK3gmJn8FdkbD8rtcucK56EGyZZ/Mm1WWCp6jm0dcwpSgmTK5Ykvp+FnWOp5+9
 Y19YcCDQeK4B9hNtxyPqe5P6I9odPbvzX32/OLpotuQd8ea9fF7zIcxgBtHeNkFR9YUg
 Ny/ivdkglYpDRfI4OUq9gbl2HKCJ93d3GUBsBqUdemPRRAlp1GiF1W1OYpPQS6l9ax3D
 86ng==
X-Gm-Message-State: AOJu0YyADCTIeyvPE8bj0lhcDHqNSNmO6InQS3d0AdxLxozVmH6faUdS
 brSF8EbasPbc5zefth4ZuplU9qIipO4HdJ/I1KK5ZJh8lKpjoq7l2vIKqiguPy0u67+Dv0am2MY
 etqqW5IbGvA==
X-Gm-Gg: Acq92OENn0tFqk7KF0/JcuoNV4UKExPtIfwoTpmYNwFIL0Q7VMcemNW/UoTko8r4K2m
 +n3K0TdlT5v8qwmEuO5wgWi9BxBZccMOQFWV6aoV4k49bPsgn70eZVjCX/4TM/i7eyNBUiSN8La
 YEkhjwk1Ku/pBmi6k57hJFaEXwXhyjNqoV+zQa3J3d7GqKw2S5BrLQvNricJKCkzSZYSx4tJ1+w
 w6zP/FkiWz+9HTF3vHYDU5tCUQ2WGQMWvHfUaqgMsQWj/dokxijqr0klqptAvHahaS7mkv3gN8Q
 lODuzZuT+gF3L0EU5qb568ELz6+FQY1Qt17eXepWxerb8RrAnrbmjN9KkAwp99WC7/XXe0cZyZ4
 m2d1WQEqgYPsr/HUuL2QBadoKmVaI2eC8VbaLqBuUyyjxPj5czORauNJn9e5vgtqB6mQdG/068t
 I5mO8VIYio+CU1ZLDDZXNnrN58gD3aFtItu8hXJQIhfW3Z9g3pqRsy+sdJLJQ/ic3Gkg==
X-Received: by 2002:a05:6000:490a:b0:451:259d:83fc with SMTP id
 ffacd0b85a97d-45eb3324e82mr33142755f8f.17.1779877934395; 
 Wed, 27 May 2026 03:32:14 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb549e79sm5443048f8f.7.2026.05.27.03.32.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 03:32:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/32] hw/arm/aspeed: Do not realize 64-bit CPU types under
 QTest
Date: Wed, 27 May 2026 12:30:18 +0200
Message-ID: <20260527103037.4461-15-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527103037.4461-1-philmd@linaro.org>
References: <20260527103037.4461-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

aspeed_ast27x0.c models 2 similar SoC based on a 64-bit only
CPU (Cortex-A35), only available in the 64-bit binary.

If we build this file as common object, these SoCs become
available in both 32 and 64-bit binaries; however when running
the introspection test on the 32-bit binary, the init() method
tries to init the Cortex-A35 type -- although not realizing it
-- which is not available. Simply skip CPU initialization when
running QTests on a 32-bit binary, asserting the realization
step is not reached.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20260526203722.79463-4-philmd@linaro.org>
---
 hw/arm/aspeed_ast27x0.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index d7ce14e8c56..dddd7d21060 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -18,6 +18,7 @@
 #include "qemu/error-report.h"
 #include "hw/i2c/aspeed_i2c.h"
 #include "net/net.h"
+#include "system/qtest.h"
 #include "system/system.h"
 #include "hw/intc/arm_gicv3.h"
 #include "qobject/qlist.h"
@@ -419,6 +420,15 @@ static void aspeed_soc_ast2700_init(Object *obj)
     }
 
     for (i = 0; i < sc->num_cpus; i++) {
+        if (qtest_enabled() && !target_aarch64()) {
+            /*
+             * Introspection qtest just want to create this object
+             * without realizing it. ARM_CPU_TYPE_NAME("cortex-a35")
+             * is not available on 32-bit binary: skip it since we
+             * won't even realize it.
+             */
+            continue;
+        }
         object_initialize_child(obj, "cpu[*]", &a->cpu[i],
                                 aspeed_soc_cpu_type(sc->valid_cpu_types));
     }
@@ -693,6 +703,10 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     qemu_irq irq;
     int uart;
 
+    if (qtest_enabled() && !target_aarch64()) {
+        g_assert_not_reached();
+    }
+
     /* Default boot region (SPI memory or ROMs) */
     memory_region_init(&s->spi_boot_container, OBJECT(s),
                        "aspeed.spi_boot_container", 0x400000000);
-- 
2.53.0


