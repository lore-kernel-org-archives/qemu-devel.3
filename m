Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA55ACD5BC9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBXz-0002j4-Uf; Wed, 27 May 2026 06:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBXT-0002Xi-JH
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:31:05 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBXR-0000dT-Qz
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:31:03 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-44b330c5cc6so8901996f8f.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779877860; x=1780482660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AcCbzOhdgXdWzpF5itQB+2yWkmCvrd9B2ZdWGldADZ8=;
 b=r/+4ADBWKr+d+EjgGTc+s0cz/dGAFe2YkmqyV9JpU8qsx/MfpNwHK9x9kQgyhMswee
 pZxyyTWSEa7N08f+acASd7kSpNnXQca0eXU22tVy87WSoqqsNjxFiWDu6wDhA63wQfaB
 Ap9v3JjiJ6Qi938zOT/75oZuEANOHNWo6mR9CFaFeFIeRPulZbq6Kp5zrao9JtSTFqjA
 77n3G5sdMvnGX4OoQqKYpBsnmvg2g5YHqz+c783OFw41pp5amEYjq8ZDJRMzzpEvJOFh
 NeopB9F9w1kwYmHawOQhp/8jt92KefXG+5Z5pfP4hxyFEXul4A89PkIhHOGr1Jk0eszi
 Quow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779877860; x=1780482660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AcCbzOhdgXdWzpF5itQB+2yWkmCvrd9B2ZdWGldADZ8=;
 b=NVOesMMAovibfxhNjgyYZ5YbEkA8omCqAwM86+B1JSdo1ddo838KWickf4kgW7TUSb
 feUzdCUPTYE543y88EptkkPKhCi36YElAwKYBMRouqvK9Efp3Thr/QxNrECbdzrHVFDY
 Q2H4bRcMRTCEQjuwth6xrIpwGIvyj+2xh+Vft8QN8lrP/0oEZJSbGwKVqk7WDHRtoFyZ
 pFuDDiDtVah0kmj9UXlPFHwWTzFTZqT+R70xCh+l18vFRzJizbx1od/F/8GoA5Nca7Nl
 YpYqNzvGep19fHbUsMy1Y2f0OQ0WP8nHgPz1MDqmc6UYfq09wnqESY40FhC2yg0kfYZ/
 NJeA==
X-Gm-Message-State: AOJu0YwzUXzph9W5INiKuetYdUJULRuT3V6GH5byYY03RNkdUF9A3tuM
 QBCf3SN0bGSPUUa9Fuj9gu7iNQf9GFoIWGGhHP0fUVv43uQXj7mxQkO9YrMF1/4ZziEWE7/t1vF
 D9N4My4fAIA==
X-Gm-Gg: Acq92OGJJESpqHyRk5RzBOK+cyIA1m/myBqFvqkZzl+Z8DiLjOKXam0o8k9q73+gGQ/
 0UdZzoMTjTTPcuL4uC+K0vY66QWsZZzDFVP+vubeCu+HR48DEi/dwnF599XBIOfVRhx5TrzVrAP
 YiYl6i9/9uqr0+jbH4js+vDkAYEc4upSZsnT7ULC1NsWPVO+wIqn8BImCTIzPB0iSByFLJTVmoz
 4soxypOq678GwER+RHIlzDRpuGYA1S7jTG1cBPHA/DdvPp5GtD9eScWotx5SAAmFkkLjAA5qpeL
 w6MLL+c3qXin6zkZu7VFCIuOL9yCHdtfVFkVL4PNoQcD5JiLBWFQTtQEKDNIbIG+GOJ0NErWthp
 8C8S1+8dRpGE3rzisbFIl7ZD0rkJAqJGNkk7ubh+QTei+m6FmrI7Zalhd0GvHexZ91SD7xAaGOS
 050vcY7Ayujbf6nh2V33EToonOliVRpJ7lj2FB/W84RjRHG474NdkQKfw=
X-Received: by 2002:a05:6000:1446:b0:45e:7415:8c4c with SMTP id
 ffacd0b85a97d-45eb38e0657mr39507516f8f.43.1779877860024; 
 Wed, 27 May 2026 03:31:00 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb557545sm5683150f8f.12.2026.05.27.03.30.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 03:30:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/32] hw/core: Add riscv[32|64] to "none" machine
Date: Wed, 27 May 2026 12:30:07 +0200
Message-ID: <20260527103037.4461-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527103037.4461-1-philmd@linaro.org>
References: <20260527103037.4461-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

From: Anton Johansson <anjo@rev.ng>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20260520-hw-riscv-cpu-int-v3-5-d1123ea63d9c@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/null-machine.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index c52b022d3aa..f132a7b89b4 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -17,6 +17,7 @@
 #include "system/address-spaces.h"
 #include "hw/core/cpu.h"
 #include "hw/arm/machines-qom.h"
+#include "hw/riscv/machines-qom.h"
 
 static void machine_none_init(MachineState *mch)
 {
@@ -59,4 +60,6 @@ static void machine_none_machine_init(MachineClass *mc)
 DEFINE_MACHINE_WITH_INTERFACES("none", machine_none_machine_init,
                                { TYPE_TARGET_AARCH64_MACHINE },
                                { TYPE_TARGET_ARM_MACHINE },
+                               { TYPE_TARGET_RISCV32_MACHINE },
+                               { TYPE_TARGET_RISCV64_MACHINE },
                                { })
-- 
2.53.0


