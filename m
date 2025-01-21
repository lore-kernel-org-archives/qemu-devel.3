Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEDBC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 14:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taFBk-0001mT-Bn; Tue, 21 Jan 2025 09:25:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFBb-0001hR-Qx
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:24:59 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFBZ-0003GH-DX
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:24:59 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso20287345e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 06:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737469495; x=1738074295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rNIgPRy0oQV98ilB0QwBxq4p43kinmbOyoZfOJB/SO0=;
 b=Ybs3JTAZv1f1cKoJ7cY1UaTpa7paPCbav+D4rAiIqrfwh8cUZ7odrEdwL5bvYx7tvu
 /1f+CrUTy5LUqe339MwlC+OuUpRUyWe1a77PQXd5N9NGu/O7A3s2FURhyGv48bKnIME8
 yCPlSvbLpxfgbJnNLGfj0CVzEw41KTs4AaWsvtRCzWMDrJBtxQe3IzPrOlREuyTK3wbk
 Et4FrjJEorPaQoPk2D41h0qIhX5NUB1+ASErzBvCUMdiBoKQu/BQkwSxRUTxeJqYNeF+
 RYBdD1exSS+dmEdStJHO9POwW4iYrUUWkbWQ4GiGDILGAvIsCEz6A3kdxwYV6uuUvllS
 ddHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737469495; x=1738074295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rNIgPRy0oQV98ilB0QwBxq4p43kinmbOyoZfOJB/SO0=;
 b=UPq0cVVrt/GGZJzCwn/CepNnyYH6hO5GzUxzd/pBmH9vsNFsPVF2PqTD6hT0QibMMq
 7eq6IlWIgO5jir6/yKL/z6EmjO3GmOXTvEhDDC0Hua53xuHaGEgqkQqdnb9/Lp2baLke
 JhFHk7QRpEdXu9teKR0qGdYS4O8gH/v/TXCf2CXEKVm7tOh1UVO6SQQOWepaMTa7Gc5z
 xsqFwDX1ZT+Q/weJbsyiX54MIF0NLIuxzNl+rYFRqhPZk3zqXH+LO4xpjeeZ3GfcML0m
 RacuvHarjW54JGLJd23yZFs1mYA6lB6ADW5hePtjqwliGEv45CpCWcWOC9kdUnhR9e+K
 razg==
X-Gm-Message-State: AOJu0Yz6QqJNgEuRwl9GbHKD4wuVeTP/Dkfo5HD9IXBz5S6bedYuIp7w
 IPBgl7glOjlsWjwH2/oo25hKDXKFpzPpTY0E6ND/4BXinOe/8bqz7r0J5WUet6xblGPcQsMaxzK
 Zifk=
X-Gm-Gg: ASbGncs+OeT1rRaQ9/91jhrcSaY0NXuFMst+gZc3nCkQ7Uf+EHB6bd4X2SiwOArIJiK
 am58GAvksqu5sXxxgAA4ynjp/Yd2A5r94ruBYaANG2yTpzHn0A2J/NStBhrxG1Rkjms+q8/mU0M
 AKbCEF+KkG8tPQB7rw4AyuCeZjX3D3UQgi0Ldjur85eaNlAsBVQH0xMz1a2ep0hFQZ85tM2nvET
 vy87faVyN739UioHwmZmWIajAzV6ypD5OCycU00p8kLSyHpb7RDN/7H4NDmQqOUZE5r3OC5PmC0
 ndswzur5X0FpO8PtzDpfd7y9WgbuvSNMSShHQgcdoC1O
X-Google-Smtp-Source: AGHT+IFQXoVBKdPu8VgoZeW5FLoHVgCaLbQlxJfMl+FDHbq1pIlW+Exqt4RoyE3gVakq9gB4RvMMnw==
X-Received: by 2002:a05:600c:1908:b0:434:9c1b:b36a with SMTP id
 5b1f17b1804b1-438913dbf63mr157694825e9.13.1737469495469; 
 Tue, 21 Jan 2025 06:24:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43890408a66sm184008325e9.5.2025.01.21.06.24.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 06:24:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 15/28] target/m68k: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Tue, 21 Jan 2025 15:23:28 +0100
Message-ID: <20250121142341.17001-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121142341.17001-1-philmd@linaro.org>
References: <20250121142341.17001-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
 target/m68k/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 41dfdf58045..eb7fb4f7e4c 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -51,10 +51,12 @@ static void m68k_restore_state_to_opc(CPUState *cs,
     }
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool m68k_cpu_has_work(CPUState *cs)
 {
     return cs->interrupt_request & CPU_INTERRUPT_HARD;
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int m68k_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -543,6 +545,7 @@ static const VMStateDescription vmstate_m68k_cpu = {
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps m68k_sysemu_ops = {
+    .has_work = m68k_cpu_has_work,
     .get_phys_page_debug = m68k_cpu_get_phys_page_debug,
 };
 #endif /* !CONFIG_USER_ONLY */
@@ -576,7 +579,6 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = m68k_cpu_class_by_name;
-    cc->has_work = m68k_cpu_has_work;
     cc->mmu_index = m68k_cpu_mmu_index;
     cc->dump_state = m68k_cpu_dump_state;
     cc->set_pc = m68k_cpu_set_pc;
-- 
2.47.1


