Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA015CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmX6-0007hN-Ud; Wed, 20 May 2026 15:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmWk-0007MA-1q
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:24:22 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmWi-0001qu-Gr
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:24:21 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48e6db3ff7eso27341755e9.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305057; x=1779909857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rsFCTUwzPo869q+hRCPooHsKqF8me+mFMwy9EFrvmCE=;
 b=Kg00meJ5TzNU0s9Ik/S/jOTVy7kkZqqqqSa7TUS7DrXbNPdO3H9RoD6otAVSq5T9E/
 rGy28kekGKMychUBcRk8p45uKLqxy8t2flQMefNnf5mHmgmCRimIRZ3IPsl8IswbH3uw
 /gY0xw2wAnGg1dUkfKzU08TU/xjn9sE0w9xFQwGylP8E1pHW3pFuBj0jONy5jv6G4ITv
 kR7gZVnlZuB4chBvmWbJVc8SxW70a/Du1N+lgptFq5TyyWNHT7Dvvfx38frsusBbEYNF
 MQkx9s5hViSz/qs6pOak/rPbJssaT2QWve7jYHz8xhu01t5l4jHN1QibqOlNYS0xV1+5
 GRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305057; x=1779909857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rsFCTUwzPo869q+hRCPooHsKqF8me+mFMwy9EFrvmCE=;
 b=qGN8l7GZSd7eYY2WaWiWhv0dZtMK7nnFrjPxxDxYUGYri5+DoZNVLJvYVYbSq62JK6
 cCe2DkVO51teZKyAhBC8zujiIF6zmNmYIMzgu2NLHtXcHgFaZozkHR+W6ygLQmXekiLc
 Kr7xJrekhX4Kt5QM9cAom76/sm4N5ZAmoBwbugle3zT4rTpDFuYYeBLXOYHWLEoy0bq2
 OrvZqp/0CVBhu/xQgTECPEiazPSGj1zG2nl6Y17doE0s9PH7kLaKptYxplgkILqF2VtQ
 iXocLiOp3us923TYfhUykxU+65LQP5M3VCM6gxC3SxZuxD/UT7Zc0cWUV++d7TGVhszi
 p0GQ==
X-Gm-Message-State: AOJu0YyQZguS2aKrnQiUKQSLpT0Yn3r5W1QDexakXydZ4JnuEKCxhL1g
 nY7Ogkv6wkzzWVWiyT4tOx7jfDsmZuXYVODu2B7756skLspa7x4KEOFKPBKbDrcx3ItH/ieotoD
 9BAN3RLk=
X-Gm-Gg: Acq92OF1Z1GB8KqHGdHGta4OcSVrSmDC9qcv0xLoT/wZAsYX1olsWuAmBp+YpLeuFmg
 5ADnyR6KhUJELgsuPdxSsvT1Rk4U2f/CSWE9gxbl9CYVL9cjt+a0ZPovVeT6cwJSKKzdO8HDnhn
 gE0ko0aca+YxH7fn0/bZEtPH5jp9DmfsAT0TLLZ6bdNqcrRR9eZ3XnB51JUpGh+HlK71+XrUpyi
 p2r9WHHr5BqT5QOUZDNunZHKbj+fGbMwhNcZ63FI/OJJU1HXmpKfCbgTMp77Uo9MC/qIXVTNOAA
 4GvwEdezbSWJT/ATY5hbSHpy6bVw9yF3WKOdVXIMZSj3DZW7pcbNBV+xJBwPPbyHCKgC7zC0Dm5
 uagv/C4xNfk4ktojQhH6Ys3EgSNrMExYdtqXJvpQDN7Xq5LwGDGxgoYDSdGmxs5ZqDTCxywDxEM
 JFdh2bTGWbOx9ctirueY8Yntq+tvVyLYEqqD+l85OSH8k/ybSooK73Gl7mp01H1jpkOWwrMVV0
X-Received: by 2002:a05:600c:17d1:b0:48a:54a6:b29f with SMTP id
 5b1f17b1804b1-48feea9dda7mr215427515e9.17.1779305056741; 
 Wed, 20 May 2026 12:24:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d2fd6bsm11694285e9.1.2026.05.20.12.24.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:24:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/33] hw/mips: Include missing 'cpu.h' header
Date: Wed, 20 May 2026 21:23:10 +0200
Message-ID: <20260520192338.40036-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520192338.40036-1-philmd@linaro.org>
References: <20260520192338.40036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

"target/mips/cpu.h" is indirectly pulled in via the "system/kvm.h"
header, which next commit will remove. Explicitly include the "cpu.h"
header, otherwise we'd get:

  hw/mips/mips_int.c:29:5: error: use of undeclared identifier 'MIPSCPU'
     29 |     MIPSCPU *cpu = opaque;
        |     ^
  hw/mips/mips_int.c:30:5: error: use of undeclared identifier 'CPUMIPSState'
     30 |     CPUMIPSState *env = &cpu->env;
        |     ^

  hw/mips/loongson3_virt.c:156:39: error: unknown type name 'MIPSCPU'
    156 | static uint64_t get_cpu_freq_hz(const MIPSCPU *cpu)
        |                                       ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260511135312.38705-4-philmd@linaro.org>
---
 hw/mips/loongson3_virt.c | 1 +
 hw/mips/mips_int.c       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index cd94e9f5f77..c29cae86872 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -51,6 +51,7 @@
 #include "system/runstate.h"
 #include "system/system.h"
 #include "qemu/error-report.h"
+#include "target/mips/cpu.h"
 
 #define PM_CNTL_MODE          0x10
 
diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
index 2b740afc4d8..fa9c78e74de 100644
--- a/hw/mips/mips_int.c
+++ b/hw/mips/mips_int.c
@@ -25,6 +25,7 @@
 #include "hw/core/irq.h"
 #include "system/kvm.h"
 #include "kvm_mips.h"
+#include "target/mips/cpu.h"
 
 static void cpu_mips_irq_request(void *opaque, int irq, int level)
 {
-- 
2.53.0


