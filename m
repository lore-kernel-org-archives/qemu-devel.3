Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2027C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcCV-0001XH-S0; Tue, 01 Jul 2025 10:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcCO-0001M7-CP
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:43:04 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcCF-00072T-Jk
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:43:02 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-453643020bdso50232055e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380972; x=1751985772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bRIToFZay2CxShEmbO/ZmevC3m9y13hXBh1sSsLv6b0=;
 b=QvwZwlVMguaMWLzZgc46bOBjikryypPlF4pwxzroOEZXPpeFw7abAFh+Hod8dIHY22
 aX/Ct7Hv8YIWRd01gR3Xpx9LZXEF8nBt/yoyjVHC7NNdkYHGdSTOCckX21whoeppCKZk
 naeIUQDYtBxgcziP1L6acN6N9DaQUSOHqZBSRhVSUqfqDg1sHqJ1d5jIKK0QZy+xrW9E
 LX5YZco8gsdMx8sHYaBT7NuzaRHWAGFMfrxHZrSNUGSLszdBuqY0uPSKLDGWs+/FNg3Q
 5LGYGTqgfXEsNg1bAjkq44q8YXBPNvSPDabeyVk1Kkuo4ponv+LY574gK9eqSo1UhkmX
 BBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380972; x=1751985772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bRIToFZay2CxShEmbO/ZmevC3m9y13hXBh1sSsLv6b0=;
 b=T0Rf+eJeMoOjQ+ccg90DRRRCgGptryD37Ddj2ZRb0qayrN7qn89ICs6u6usId57wI4
 dARkogfDGiG4qE9vdrbSBm4o1dyEOxoBpVFM9HB/AdT62uI0VhQUFyWzIPGMOfed8ZsF
 TNhKQELWWZtqJaG2nOnszf9c+xgylW3vsGCgXX0+uVRZqhH9uQummuU50V9hLwf97rI/
 f8em4HOP9yh61UZv0gHydXQRoJftt6j4fQopNa2I3w+1rpjxK7VIvv0b8943eZv5CX1p
 gkdw88ggYW3lVyJvPTPB0uB+aLF3Y2J9SbTLmejg4TtBw2CW9EbJXaVAUDc/xWgNj7ru
 Ik7g==
X-Gm-Message-State: AOJu0YwhJZEIjIpFoE2+vFxDSWQAp7BY7FGfdBNPaA4YTsakh4K4PW8R
 hDIQe66m3E1nDKs8ZBNiPtoeJ9TSrsJPbxpV3cwup9knJVDHnXYz/7dJsUBWtDCCGLLjW3YyyMU
 RCmzn
X-Gm-Gg: ASbGnctkM/Ajc2Kfb4UyZEruCW7g5adNVaSuctsX+a20JgUAMVS02KZah97mogFqKyM
 ln4dh1i3CcuWe+Hu5Yxn29kUOgV8qvvnjIQ1d9OknJ6Y/xB12bgNSNlQAvj5pFtgZEfySrRkSb+
 F4zcehq8TK8PgrkuLuxX5uJPnIXJJhZbaB6H9MIhsU23ESB2z/9aKHnljkVViPQ9OIGH7qgq4wX
 JuRmg+vopn0zUN9SkDVeUy9zB1QAm8u2B7406n7jreVYndynU1FHKrwBhIc8TU1yy4179kMidyW
 MpYdP3LihU87s/LxXUCyOaIZCXj8p9/aW8oEr8EImsiHdWxExQZj98IKKrg9zP1kHSGReU+2BiW
 kLMZqFHhsGnDPU2/Ap8wlgPGp5CSaa8MHFJVt
X-Google-Smtp-Source: AGHT+IGDlDYFTQA06UJupt59/FlgQnMOqv9FMTE0SuPhuzutfKGtJHiwgh4/UD7R8I83qSqHl2n2wQ==
X-Received: by 2002:a05:6000:144d:b0:3a4:fc37:70e4 with SMTP id
 ffacd0b85a97d-3a90c07daffmr15696770f8f.58.1751380972024; 
 Tue, 01 Jul 2025 07:42:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fa8fasm13377117f8f.28.2025.07.01.07.42.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:42:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Shatyuka <shatyuka@qq.com>
Subject: [PATCH v3 28/68] accel/hvf: Report missing
 com.apple.security.hypervisor entitlement
Date: Tue,  1 Jul 2025 16:39:36 +0200
Message-ID: <20250701144017.43487-29-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

We need the QEMU binary signed to be able to use HVF.
Improve the following:

  $ ./qemu-system-aarch64-unsigned -M virt -accel hvf
  qemu-system-aarch64-unsigned: -accel hvf: Error: ret = HV_DENIED (0xfae94007, at ../../accel/hvf/hvf-accel-ops.c:339)
  Abort trap: 6

to:

  $ ./qemu-system-aarch64-unsigned -M virt -accel hvf
  qemu-system-aarch64-unsigned: -accel hvf: Could not access HVF. Is the executable signed with com.apple.security.hypervisor entitlement?

Suggested-by: Shatyuka <shatyuka@qq.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2800
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/hvf/hvf-accel-ops.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index ca85922356b..8876a026120 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -331,6 +331,11 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
     }
 
     ret = hvf_arch_vm_create(ms, (uint32_t)pa_range);
+    if (ret == HV_DENIED) {
+        error_report("Could not access HVF. Is the executable signed"
+                     " with com.apple.security.hypervisor entitlement?");
+        exit(1);
+    }
     assert_hvf_ok(ret);
 
     s->num_slots = ARRAY_SIZE(s->slots);
-- 
2.49.0


