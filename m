Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD3DD42BBA
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 18:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAvLy-0004v4-3l; Tue, 12 Nov 2024 13:11:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvLv-0004ua-4K
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:11:00 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvLt-0001rt-LU
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:10:58 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-431481433bdso52753045e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 10:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731435056; x=1732039856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dxalhuJA3V9Mf8DxAADrs85j1mYwG4uCtR+wwxiXnFU=;
 b=lJ9Cm2iSSpxyAnKMuBy2DLAaFLsRlBMED2NZzfuO6wzTcf390IK9pOi003279rU3dd
 xoSiRnZDmMeC6INBC0WySIbN5vQfmpDBg0u55uV0/mZgWLxrnPkcoq/oxSygcKT0MaB5
 Fw8VTOfkN+8duGSHY4lvXINHnTWz89srKQQZadJ5Xrz3CY6+/tkFhamiR5mTHxeKSZuj
 6L/A925S3s9mPJlZa2P1+hs0dBrNqp43UzyyCxEJB4FMTORAoajKhSBEgqgZxPPn6SWL
 ooRCYm3LImHma2WaxPU+0p+ACNkhPOXdfDvts5Yj9Qr9BiKe75VB8a0Lo40/mdS5iZCr
 N/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731435056; x=1732039856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dxalhuJA3V9Mf8DxAADrs85j1mYwG4uCtR+wwxiXnFU=;
 b=N9cjj8Ra/r2tLCYcHKa9vZLJx7eKnYBcUQoQYZgl1TsPEcbEAzp2hh8OnY9bTfoycA
 Sc/F6d0iao+faz62+oLXyB3+Gb3a6kKfZ0S7yqX3goqLQdLvzHu4vCjdyuRo2KU+gD3/
 ENowNVyPoLgchS8JQeHSIVF3zDHOeRRYIdQEyjG1Z5vY6Gkne+chjZpRpS484CzuainK
 kaVxKyVMHrgsX/XdB1UwheQ12RbfTht/dFMlAxHZJgyhkg8mhSZqBvwwsycuu9qXoecf
 OBW7kQgXTWM7NY7AqjbLMKfVPQovQJUk9HX+Ka8uqdzfHH5FvDe00dK2cgBXMQPmaiGJ
 3wmw==
X-Gm-Message-State: AOJu0Yz8BdyD/559CGQj2Po6iJ/QeFFWjspWXBzY4XlMSCvsCzz4KwiK
 gNjkiBaKLnqeJHNuVdUQsfFaew7mPo1xc2dJXKHuw5TPRDuHrvTiLh2abSUYjKc6333AyRghOVs
 X
X-Google-Smtp-Source: AGHT+IE1RMTlteHBip9Rxda8l4wZD/cMs42SVMF3WUfCg/p+fK8AYVp0J+9LlfWdcF8vngwDlGpqEA==
X-Received: by 2002:a05:6000:184c:b0:37d:238:5a84 with SMTP id
 ffacd0b85a97d-3820df71a37mr43757f8f.15.1731435055659; 
 Tue, 12 Nov 2024 10:10:55 -0800 (PST)
Received: from localhost.localdomain
 (cnf78-h01-176-184-27-250.dsl.sta.abo.bbox.fr. [176.184.27.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381fbf416c6sm7670380f8f.54.2024.11.12.10.10.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Nov 2024 10:10:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/20] hw/microblaze: Restrict MemoryRegionOps are implemented
 as 32-bit
Date: Tue, 12 Nov 2024 19:10:25 +0100
Message-ID: <20241112181044.92193-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112181044.92193-1-philmd@linaro.org>
References: <20241112181044.92193-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

All these MemoryRegionOps read() and write() handlers are
implemented expecting 32-bit accesses. Clarify that setting
.impl.min/max_access_size fields.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
---
 hw/char/xilinx_uartlite.c | 4 ++++
 hw/intc/xilinx_intc.c     | 4 ++++
 hw/net/xilinx_ethlite.c   | 4 ++++
 hw/timer/xilinx_timer.c   | 4 ++++
 4 files changed, 16 insertions(+)

diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index f325084f8b..3022b3d8ef 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -170,6 +170,10 @@ static const MemoryRegionOps uart_ops = {
     .read = uart_read,
     .write = uart_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4
diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
index 6e5012e66e..8fb6b4f1a5 100644
--- a/hw/intc/xilinx_intc.c
+++ b/hw/intc/xilinx_intc.c
@@ -144,6 +144,10 @@ static const MemoryRegionOps pic_ops = {
     .read = pic_read,
     .write = pic_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index bd81290808..e84b4cdd35 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -170,6 +170,10 @@ static const MemoryRegionOps eth_ops = {
     .read = eth_read,
     .write = eth_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index 32a9df69e0..383fc8b3c8 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -193,6 +193,10 @@ static const MemoryRegionOps timer_ops = {
     .read = timer_read,
     .write = timer_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
-- 
2.45.2


