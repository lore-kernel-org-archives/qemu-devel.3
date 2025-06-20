Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F84CC7EE2A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfJa-0000Qj-D8; Fri, 20 Jun 2025 13:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfJW-0000Py-OR
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:14:06 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfJV-0004Aw-73
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:14:06 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a50fc7ac4dso1264667f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439643; x=1751044443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eJy5l89go/ZdxLhDSH2ckREU2fh7FWR7w2u5ZwLMk3o=;
 b=NU4XiDGMXsvIZ2O5szK+xJBExJ2Jt2gItyoZQfqiqpMe+DIv9NXgrM/XZ2FZPp1QEf
 M2vGwHkNHmjMMcJNELD5FFZeVdMxIqn3pZyH6VZ7DS4HKSa6yELt5D1pG9wesPxZvCMD
 n3K73MBA9AdxDcrCl81im2UXTrpC1mEO/pJMkkcn6a0i1mo9odoVgsrdE9YWExygoE6s
 t0KCpHcd2jc2zEf9AylMqzOJQviHDmGeKVzXrIhSjgm7OElFQRQs+kXnTV56/tNcazQ7
 Jtk/yFsSjTJ8VbvKrAzcYp9o9l3DS+KvChw8ZK3qIEuyoHQDjZ7urlbkj4dDgDLCp9xp
 8Pvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439643; x=1751044443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eJy5l89go/ZdxLhDSH2ckREU2fh7FWR7w2u5ZwLMk3o=;
 b=MVjv/e8GoqxU1oiWGO8a2uYI8NYAuDjQP+ArwWDSCPqJMX+7kTVspabPYtKe3s7Dws
 9L7Zv6Q9VZtGCTbIqL6REiGwKefseT/Q7s0J3Dtyw/6UN5JyfW7YQmjIC01ZMrZMiq4q
 2HT0y08LDgD7YHVI9mekaCWAfJyDzp1AwunVmpvwfPePaKv+kMprrL88TjOCkrD/d5rO
 dAgfklEye6usXpxAlDCJBw7es6anKrxTgMaeedKJpHLM7xWSf5bY1a+HMt122YLWNpUP
 +MsFIYwbtoRbtbJX7vfTFMeEPGMGFSxllz2gYIHGzY58spXONcmdpiE4yDo/nyMy7k8B
 PVyQ==
X-Gm-Message-State: AOJu0Yz7P7M6lOOaB1eJS0rJVvl4uD/gSFF2Ff7S+Z9PrH7gTC4MulRS
 TWmXMdT+QtTW89vZCeSLzwgjqYqMEO74ps0Wj2W72BXe5BTlPrd7hOB4Tp1DIJZUeCEZVlBqrWT
 IaJrmhoE=
X-Gm-Gg: ASbGncsrOBqOSy4Zd9oXRh49+i4ofz3t6NGEaLDptgawyBl0bNhmOVqQ0akb9QaI4Di
 MhIj/Jhl38kB2o2P5Hdj7XFsrP4Dj3oglAte+ATSw3PNzvKiCU9MqFNQ1YuTYmdVlquP4b/EKeY
 5L9dmo6OnjvwshnF3HrgEvpQ2Ws3WIE3CaKObRz1FnsPTlRyyFwKUMJg7SwlqMri1v0XgtOXW+x
 8elKBfV6PgXF4Bt4NtQS4gMsJikBcNDxNTKOO0cMgy+rTrfdJpsxZ1VYXH8MjAAQnOk2WapQsmB
 NVjq+ckQF/YuRGOBZXe3qALplyY/pNVVInKyLmxtmiH8ot5dYQkcnAuCw3KqbpcrMR5dPim5puh
 CGZepFbfX024TrQLV+qVoQ8YEiK+WQkCx8bki
X-Google-Smtp-Source: AGHT+IFnA+Zp4yctxXcvGAFNQknx5QfuFQ+qOvbJU6LK3gH1sBi6Od/yQCNbYMy1/WPvgP7Aoq13cQ==
X-Received: by 2002:a05:6000:2412:b0:3a6:c923:bc5f with SMTP id
 ffacd0b85a97d-3a6d13019e7mr3148667f8f.17.1750439643190; 
 Fri, 20 Jun 2025 10:14:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4536470903asm31641455e9.40.2025.06.20.10.14.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:14:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 04/48] accel/kvm: Remove kvm_init_cpu_signals() stub
Date: Fri, 20 Jun 2025 19:12:57 +0200
Message-ID: <20250620171342.92678-5-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Since commit 57038a92bb0 ("cpus: extract out kvm-specific code
to accel/kvm") the kvm_init_cpu_signals() stub is not necessary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/stubs/kvm-stub.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index ecfd7636f5f..b9b4427c919 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -105,11 +105,6 @@ unsigned int kvm_get_free_memslots(void)
     return 0;
 }
 
-void kvm_init_cpu_signals(CPUState *cpu)
-{
-    abort();
-}
-
 bool kvm_arm_supports_user_irq(void)
 {
     return false;
-- 
2.49.0


