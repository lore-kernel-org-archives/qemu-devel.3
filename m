Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDAAD1268A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HbK-0004Vn-On; Tue, 05 Nov 2024 06:19:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbI-0004UL-30
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:56 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbB-00076o-Nb
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:55 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-431616c23b5so33181505e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730805587; x=1731410387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QD6Lc/I6xdPJ52+g1i8fO338zKT4nqacusp7y0oQIcc=;
 b=sicNZKRHrhkfNYHpLjBwqB9ZQjhKlcUGzHxhNqUKAtsbbYWNa9b3WeApzqjknbGVXG
 llqjMzkC2VVvcyRivAwaotIp64S9mVbnGXLhTsvSHGWM+ALei0I/XaBlWBDdtdEUtz11
 FmJYmGSeZDwKLou1t8Vz4gxMshewtF5VkQz7i5DzPSQ1AJNTJbbsXeEZydKS6uPDS4to
 HS6ghoeOqfQFR2w7KeiA/1qzJvrpSGVmHoAbMLmc9f3mKbVJyiUs7CbBRVBe5CIDZUIl
 bgdB72lggi8/0MK/cnTQkGo8gH+LulsUF6LxKq8vrEQdXUqsN8kvZmXK0UXqY07pwdOS
 blGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805587; x=1731410387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QD6Lc/I6xdPJ52+g1i8fO338zKT4nqacusp7y0oQIcc=;
 b=V8uKON2o7jA6FgbQzYjDe8XoWm5qsTmljTmSDpAAMk80ScCh1C8F8qg4dgchCiOc/c
 7cko+PvWIw5NjMyeD7NYf1eAL7/v9Djp6tkXCXmKiGihIoscbbNanvrCQtuk/uZWmls3
 3Tk7hFW3rPuNdvkH0ulkTgp1GwDCWdZlmBEYBY9bUpNX2M0+Sy+jwDVLwijY9IFkWQ1E
 pQ3NWmvdll9EoUbhrtrfurdpvX37QESkMFhnqsZ8jWAVRjxcJ2iv4bTmhCv4v0Wbs1u7
 /QGC4wl8iTAm0ytwWFgBSNlIacP/DBh7vPVix05E1CmwN7gNDBkznY7+HJDBuW4Ah1lo
 nfJA==
X-Gm-Message-State: AOJu0Yx9yIYDLSJPZF0sxwjRa6sIGNDUgMMZVA6A96d8DGKbHVoX7JZ/
 EBoAeVWq7/02qRl5w3fBDgifTlLmwEGnfJ737zEeP5QnM8t48xSIzKK100Nb8iNUrIc/yVaGvyu
 O
X-Google-Smtp-Source: AGHT+IH0FgwKmDhBx+H+hKWmuPuZ6OakkHkQfyaB+B7+3daicMuI3K4jRHZd9d/xh6lWJFyor7dccw==
X-Received: by 2002:a05:600c:a02:b0:431:15f1:421d with SMTP id
 5b1f17b1804b1-432830a14b7mr129407135e9.16.1730805586993; 
 Tue, 05 Nov 2024 03:19:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a3688813sm16354555e9.1.2024.11.05.03.19.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:19:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/31] target/microblaze: Move setting of float rounding mode
 to reset
Date: Tue,  5 Nov 2024 11:19:21 +0000
Message-Id: <20241105111935.2747034-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105111935.2747034-1-peter.maydell@linaro.org>
References: <20241105111935.2747034-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Although the floating point rounding mode for Microblaze is always
nearest-even, we cannot set it just once in the CPU initfn.  This is
because env->fp_status is in the part of the CPU state struct that is
zeroed on reset.

Move the call to set_float_rounding_mode() into the reset fn.

(This had no guest-visible effects because it happens that the
float_round_nearest_even enum value is 0, so when the struct was
zeroed it didn't corrupt the setting.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241025141254.2141506-18-peter.maydell@linaro.org
---
 target/microblaze/cpu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 135947ee800..6329a774331 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -201,6 +201,8 @@ static void mb_cpu_reset_hold(Object *obj, ResetType type)
 
     env->pc = cpu->cfg.base_vectors;
 
+    set_float_rounding_mode(float_round_nearest_even, &env->fp_status);
+
 #if defined(CONFIG_USER_ONLY)
     /* start in user mode with interrupts enabled.  */
     mb_cpu_write_msr(env, MSR_EE | MSR_IE | MSR_VM | MSR_UM);
@@ -311,15 +313,12 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
 static void mb_cpu_initfn(Object *obj)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(obj);
-    CPUMBState *env = &cpu->env;
 
     gdb_register_coprocessor(CPU(cpu), mb_cpu_gdb_read_stack_protect,
                              mb_cpu_gdb_write_stack_protect,
                              gdb_find_static_feature("microblaze-stack-protect.xml"),
                              0);
 
-    set_float_rounding_mode(float_round_nearest_even, &env->fp_status);
-
 #ifndef CONFIG_USER_ONLY
     /* Inbound IRQ and FIR lines */
     qdev_init_gpio_in(DEVICE(cpu), microblaze_cpu_set_irq, 2);
-- 
2.34.1


