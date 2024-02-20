Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2732C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 19:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcVlM-0006Wg-O8; Tue, 20 Feb 2024 14:26:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcVlI-0006Tz-9A
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:26:41 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcVlF-0006YJ-Am
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:26:40 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41271096976so5420125e9.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 11:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708457195; x=1709061995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0RVEkk0ogowsJDDVW8v8EcldTsxXvilqXAuAAWzLt3Q=;
 b=NY+du7T46AqjeUgJFPaKf7G+EmRMSVst4J9BmNCBncaqtOnZMfbbg1Wlp9uaFzUGIo
 jHvftrUhtVvYCALWB1Uu25xIUmoKEZxGg/0G9sK58Ni7oplx+WPGVvK33XBQGg7V6/+6
 Y2n9QcA9FF9r8WcW75hMVGLauZr0v92LY38r1omqMj+H8aXgJdr1TDrlBrEFVBTayAUu
 9a29RQF1qloQdTnZQS2IYI3V3zT48dGdkPazPpq27Gcq+4/AFZEOysJ512Id9isI3yMj
 65U5l9yf1WtPZocWZNquacJ2wZ6S0UYOz0qxjjbXPaa3fgJ/22skldS/08ATD1e8De4k
 kuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708457195; x=1709061995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0RVEkk0ogowsJDDVW8v8EcldTsxXvilqXAuAAWzLt3Q=;
 b=oltCqkMJuTNq4TPihijNUHR2jOzsqfyK816JeSA6KnZWjn/6Ue/gTjaBA/0vQ/mWQf
 /OnJv5pC0bYbxXv4XoUs8Hw5OR2aqU0kxrgrH3quKGQlUhZ5EsR/i649pTbNGRP5lUzu
 T0MK51nsyPrsY7b8XsxFNVAUEK3trUEZ3pB6fV8LIDYumrRwQVihZ5OJC1mveBNyX7vZ
 APjsGfItUxej+B8BQrSgYZBX35cgi5RzXT78h7rlGb3B2kEfpVFcRbiWWx7+iQ0CUdgH
 CRuCn5jTmO+jfYlWytMd3HZX0GV+/E2aDjPJajQ4xwspGTCX9bLOBHQJXXsy+dRztau+
 u9cg==
X-Gm-Message-State: AOJu0Yx8/7PS9NeIwNfvPt51Hg4E9T5FZb4FE9PVhgI7eCJpgMIlVM1o
 c0u2EJT+uvFvq0oWi9fNAxOhXKhnPV6vTt6Gg6UC3Q+A+by8giW1WP8H8gxuMqLZw7MKa1U8ylV
 W
X-Google-Smtp-Source: AGHT+IFox4Q9/V4AdMzkU6lVT6BShOrcavRkGAyHvZxrcUWfxCk8r0+a6Z/ZBS7SzB+9Yh6T0i3Ryw==
X-Received: by 2002:a5d:430d:0:b0:33a:eb10:e9e8 with SMTP id
 h13-20020a5d430d000000b0033aeb10e9e8mr10366269wrq.43.1708457194876; 
 Tue, 20 Feb 2024 11:26:34 -0800 (PST)
Received: from m1x-phil.lan (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 cc3-20020a5d5c03000000b0033d5e3c6835sm5702004wrb.5.2024.02.20.11.26.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Feb 2024 11:26:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 1/2] target/alpha: Expose TMR and SMP IRQ lines via QDev
Date: Tue, 20 Feb 2024 20:26:24 +0100
Message-ID: <20240220192625.17944-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240220192625.17944-1-philmd@linaro.org>
References: <20240220192625.17944-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In order to remove calls to cpu_interrupt() from hw/ code,
expose the TMR and SMP interrupts via QDev as named GPIOs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/cpu.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index bf70173a25..619cd54593 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -25,6 +25,31 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 
+#ifndef CONFIG_USER_ONLY
+static void alpha_cpu_tmr_irq(void *opaque, int irq, int level)
+{
+    DeviceState *dev = opaque;
+    CPUState *cs = CPU(dev);
+
+    if (level) {
+        cs->interrupt_request |= CPU_INTERRUPT_TIMER;
+    } else {
+        cs->interrupt_request &= ~CPU_INTERRUPT_TIMER;
+    }
+}
+
+static void alpha_cpu_smp_irq(void *opaque, int irq, int level)
+{
+    DeviceState *dev = opaque;
+    CPUState *cs = CPU(dev);
+
+    if (level) {
+        cs->interrupt_request |= CPU_INTERRUPT_SMP;
+    } else {
+        cs->interrupt_request &= ~CPU_INTERRUPT_SMP;
+    }
+}
+#endif
 
 static void alpha_cpu_set_pc(CPUState *cs, vaddr value)
 {
@@ -89,6 +114,11 @@ static void alpha_cpu_realizefn(DeviceState *dev, Error **errp)
 
     qemu_init_vcpu(cs);
 
+#ifndef CONFIG_USER_ONLY
+    qdev_init_gpio_in_named(dev, alpha_cpu_tmr_irq, "TMR", 1);
+    qdev_init_gpio_in_named(dev, alpha_cpu_smp_irq, "SMP", 1);
+#endif
+
     acc->parent_realize(dev, errp);
 }
 
-- 
2.41.0


