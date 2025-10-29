Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35233CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 16:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8ZH-0005vE-16; Wed, 29 Oct 2025 11:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8Yk-0005Yd-SI
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:58:03 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8YR-0003XY-VL
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:58:02 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-63c2d72581fso10821978a12.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753451; x=1762358251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gI7POiFO1cX4nQU3EyumRDIsbzchXTV+6pxtxm7uAYU=;
 b=wSYG69m6L7TcrM2H6RcUfnMlqo2ZFD+pScd6imiVSj8CO4gYrbkWlKTrMq8XJ3wmZ9
 K4FBl3/eLztqbFONp+29fuM59r/TYy6caFCMer4OFEKFC5Xm6v883Rvfe0tt7cBe6Qvg
 cPV3kLJnUf7mtzAzIqCFA2urRUN4U+QccTHJ/oOCweduiCHhR29oxrQ1uZFRF9v+bnsR
 lKM1CgIbqDtaMkrrjyolJdpip6s7G+VhYKxxBah/SNAe+Wug0lpXw+r/+Kea+iA+iZMf
 OtKQXU0nRIPk6RhPZrzX6RKOW5p9Vp8ZxBHjWiqWSVkNI4QZkx6RQjFhXmvYPiYLnTHU
 l20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753451; x=1762358251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gI7POiFO1cX4nQU3EyumRDIsbzchXTV+6pxtxm7uAYU=;
 b=CHWHVSMbinyRhVEJihq0YrGTw7GDCZ5GZUqMvPWJUVQU5sGEneguUXzFlgGFwpkewt
 V1iNARvbrPZWqAD1M/yE7HNUuR3k6VhLZcfx6P6CQgB0EuYK5yLpBh2cEr0CU08zQY6O
 NK6W+5Dt9SvAS1DSDKkyM8x/L5QK9vV/0h6ZNEpSmKtWto8NMJJ6oe3TrrjyRWGSA0mK
 Jq45Mow6U4fc5LKb8MNyR4D4EA9UARcAxNUr+DWlD0dHfJ+RiY7FrYeljtdb/U+n4SuF
 P1ShteyTEZpNY+FeW5VtjFI056ReR8lcxakNWQxBrw3c7UnlOfrEk3K1DQb+//zdiBGS
 Ndcw==
X-Gm-Message-State: AOJu0YwayQLm3XgAiKO1FLofMf8fct0D49STdzN64dvwhtyCf7mnvFCU
 aQF/h5wK/e/CAOqOxZxttKR0nIfUKOBddr71ax7FMA2wXGAFF2dN3AL/5jVWVgmmMmux0gT3h9K
 P/7s5Xvc=
X-Gm-Gg: ASbGncuXMtZrXjpC2H4KXbJVpBa/s6JW+qYaJcmNdL6WtPDQFV2xssSxJwAo5AZWvKA
 RLS0CRURHA1143NbzAUrxqRXEIjskKWOxjJuJJys2CqB0/klkjI/pHIf+3lnmeSizCXvxevJ/hi
 UK/TzJwd69HTzVrrR5PvXgRoxQ/UwxtZzAnWibO2BK5FYoZ8FeWRApP/y50CKzQnRLJ4K9oNwv5
 ATV02L/0K9RATtO+goNwa19RXxZu8/WM5EVEDXp1GbmFYrse2gyb5ERHPFcfOnV1tG5t+tFCi2d
 OVPTml6XOlB/SoJ8N977k7/6oM8UYrtB6AAWSF0Rsw6XJnUMd2fOJUrrKDyRbeWvh2On8Ane8mv
 nQ3LEclByadA7wznq5PRZFeTJ0+fRbvw9OwWSsVeoDZXuxLOYlQG7WArbAZmaq1Vcsx8jEf7DR9
 RT
X-Google-Smtp-Source: AGHT+IHDbeuVW6JrqqUwUrVIWnkfP5Z5hpNfFmDd0ys4GwPKvzgwUz2ylzC/Avaoal6GRFrlEO1zqw==
X-Received: by 2002:a05:6402:208e:20b0:639:fca4:c471 with SMTP id
 4fb4d7f45d1cf-6404e292ac6mr1440586a12.28.1761753450752; 
 Wed, 29 Oct 2025 08:57:30 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e7efb97cbsm12492397a12.26.2025.10.29.08.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:57:27 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 241DB60D95;
 Wed, 29 Oct 2025 15:50:48 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 23/35] target/rx: call plugin trap callbacks
Date: Wed, 29 Oct 2025 15:50:32 +0000
Message-ID: <20251029155045.257802-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
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

From: Julian Ganz <neither@nut.email>

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places hooks for Renesas Xtreme targets.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Yoshinori Sato <yoshinori.sato@nifty.com>
Signed-off-by: Julian Ganz <neither@nut.email>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251027110344.2289945-24-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/target/rx/helper.c b/target/rx/helper.c
index 41c9606fd1d..ef47e32add8 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -22,6 +22,7 @@
 #include "exec/log.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "hw/irq.h"
+#include "qemu/plugin.h"
 
 void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte)
 {
@@ -46,6 +47,7 @@ void rx_cpu_do_interrupt(CPUState *cs)
     CPURXState *env = cpu_env(cs);
     int do_irq = cpu_test_interrupt(cs, INT_FLAGS);
     uint32_t save_psw;
+    uint64_t last_pc = env->pc;
 
     env->in_sleep = 0;
 
@@ -65,6 +67,7 @@ void rx_cpu_do_interrupt(CPUState *cs)
             env->psw_ipl = 15;
             cpu_reset_interrupt(cs, CPU_INTERRUPT_FIR);
             qemu_set_irq(env->ack, env->ack_irq);
+            qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
             qemu_log_mask(CPU_LOG_INT, "fast interrupt raised\n");
         } else if (do_irq & CPU_INTERRUPT_HARD) {
             env->isp -= 4;
@@ -75,6 +78,7 @@ void rx_cpu_do_interrupt(CPUState *cs)
             env->psw_ipl = env->ack_ipl;
             cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
             qemu_set_irq(env->ack, env->ack_irq);
+            qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
             qemu_log_mask(CPU_LOG_INT,
                           "interrupt 0x%02x raised\n", env->ack_irq);
         }
@@ -92,6 +96,14 @@ void rx_cpu_do_interrupt(CPUState *cs)
         } else {
             env->pc = cpu_ldl_data(env, env->intb + (vec & 0xff) * 4);
         }
+
+        if (vec == 30) {
+            /* Non-maskable interrupt */
+            qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
+        } else {
+            qemu_plugin_vcpu_exception_cb(cs, last_pc);
+        }
+
         switch (vec) {
         case 20:
             expname = "privilege violation";
-- 
2.47.3


