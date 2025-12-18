Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E003D711C6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 21:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWLah-0003gm-6j; Thu, 18 Dec 2025 16:31:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWLaW-0003Y9-CC
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:31:10 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWLaU-00008V-5z
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:31:07 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-431048c4068so653895f8f.1
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 13:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766093464; x=1766698264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HmxQ9WEy0hVu6WpWDaVL5nWcD5VfHXcTym/HYUrgzEE=;
 b=EcQ1fzcijpqfo3EYaZRWi0oYFpQOjfvu1FBP5p1GJ7DZlhT1xHCQEfE+DcjK5rtnAI
 3vjVneZYecmUIIFe0QHTVhSIr7TXOaJ5dgoRvkCpDlczZEfEl9HaOTiYkXxPXqItu7ZY
 jCPVP4kQqtRUb/+bw0kIBTzq+Kdye4rhyvghocAupQS1mmo4J3zc4/jGyW4V8GMC9mcm
 UHn60DHPxqCDjZSBO+F2sV/1RTWNImVV35py8fjmRT8Oo0WIUWa+r2pBaVm7MepyYG9D
 sC96lb6nHVnhBFHyQNmhSjj9cuHjRLYodYGvDUpxkYaPJBUIQIqV98sy4Qb7VGYSOlOJ
 W6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766093464; x=1766698264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HmxQ9WEy0hVu6WpWDaVL5nWcD5VfHXcTym/HYUrgzEE=;
 b=AaIZPL7YamvYZub3px9u6+UeXKX7uQ/4rI+plgmgkDP8W8GzavvUuFIVVaTX+ncjA6
 5iF28N+hp3PwksL3QnHwl6frJOue+F7xhH2s8aTIkfUiD2Ic8uHGm56L/XjEzhekeQTd
 rSmgPxz/kFZOBPdbrcHR3+WC1uv+mlXtJnujouFGyWpeiR5UUPyDKN+lOF08tPXlInYE
 h1KXs7qmjFXbB9f2+V9PWqRlfJ2DjMqm7/OvpueVbwhN+CrMrX6RB3J7flBa3g7CVOhc
 CRm4BfQdsF5cavjZKJjUbkJPnLNxSxNfGNJeiRqSs3hzvcncvTet2snOM4vcMJBjvJgu
 xiUQ==
X-Gm-Message-State: AOJu0YxPvPWYHOugaSKcu1CCviaPwBhI5S6tg0OCtThMw1BXYnMBv3zM
 xwwTNEsW4V6MjgBmp9uyTdZrQFy9SIakP2/BfJtc4cGSG2q8wY0+J/D8NDvLlZlS0qJoJQZRX5L
 TnH/7Bgs=
X-Gm-Gg: AY/fxX7HW/SSqTBSVNbxnPEt1h07EusooeW1lC3iPeWEoXiTXT6BQDa+Aojvb2J13J3
 CzIpRySRvce9a+n79XKN6eRaeMGkcLHCPudmOB3JQWS3CnYz2wlDe8iGvgmdIfPUdk0cPOz9Bfm
 hAcIMo8Fio53tCCINcmxciLyqq5/nM/2hP6T3Q1cP0CYyq59NiRpD4hBEZtWZabm15qZ3HDHTfK
 4PljKPjkZjQyuOk+FZOE4kXomK7Ix4TWdHYolP8lzqY+WUed+qfcxEXhDXDbL0gTIObPypfGLUZ
 Y9wDm/DLyEu0+xaw8jKd0tuhld/y08jA6DzFfULfC096pGjpe0wgp2OJ72djRH5aacJ/zKof1bY
 Fg0qaaGSVt7npF8z7tZ8gOOwkOZHMYcRyihW7Mz4a3IuNf5GUIzDnL9i8wkefixMa6kKxbEDd/2
 rTfB21yQvDXGKFYra8Pur9/VGI2MGTMe2NNNs21eGUWMpuJT+tHSIw4eXI5TKgoSxIpzRefqs=
X-Google-Smtp-Source: AGHT+IHPFi0lGdv5boIEXPENW6VdZtAQmmkzBdlqJKEsVX9deS0vPY2/+B++rekJL/pG0+rtimWa1w==
X-Received: by 2002:a05:6000:230d:b0:430:fb00:108a with SMTP id
 ffacd0b85a97d-4324e3ebfddmr1413915f8f.2.1766093464121; 
 Thu, 18 Dec 2025 13:31:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea225fcsm1080630f8f.16.2025.12.18.13.31.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Dec 2025 13:31:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] hw/avr: Mark AVR-specific peripherals as little-endian
Date: Thu, 18 Dec 2025 22:30:51 +0100
Message-ID: <20251218213053.61665-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218213053.61665-1-philmd@linaro.org>
References: <20251218213053.61665-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

These devices are only used by the AVR target, which is only
built as little-endian. Therefore the DEVICE_NATIVE_ENDIAN
definition expand to DEVICE_LITTLE_ENDIAN (besides, the
DEVICE_BIG_ENDIAN case isn't tested). Simplify directly
using DEVICE_LITTLE_ENDIAN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/avr_usart.c    | 2 +-
 hw/misc/avr_power.c    | 2 +-
 hw/timer/avr_timer16.c | 6 +++---
 target/avr/helper.c    | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/char/avr_usart.c b/hw/char/avr_usart.c
index fae15217e9f..5510dd3f487 100644
--- a/hw/char/avr_usart.c
+++ b/hw/char/avr_usart.c
@@ -255,7 +255,7 @@ static void avr_usart_write(void *opaque, hwaddr addr, uint64_t value,
 static const MemoryRegionOps avr_usart_ops = {
     .read = avr_usart_read,
     .write = avr_usart_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {.min_access_size = 1, .max_access_size = 1}
 };
 
diff --git a/hw/misc/avr_power.c b/hw/misc/avr_power.c
index 411f016c997..d8e0d918519 100644
--- a/hw/misc/avr_power.c
+++ b/hw/misc/avr_power.c
@@ -69,7 +69,7 @@ static void avr_mask_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps avr_mask_ops = {
     .read = avr_mask_read,
     .write = avr_mask_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {
         .max_access_size = 1,
     },
diff --git a/hw/timer/avr_timer16.c b/hw/timer/avr_timer16.c
index 012d8290018..110bcd58163 100644
--- a/hw/timer/avr_timer16.c
+++ b/hw/timer/avr_timer16.c
@@ -524,21 +524,21 @@ static void avr_timer16_ifr_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps avr_timer16_ops = {
     .read = avr_timer16_read,
     .write = avr_timer16_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {.max_access_size = 1}
 };
 
 static const MemoryRegionOps avr_timer16_imsk_ops = {
     .read = avr_timer16_imsk_read,
     .write = avr_timer16_imsk_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {.max_access_size = 1}
 };
 
 static const MemoryRegionOps avr_timer16_ifr_ops = {
     .read = avr_timer16_ifr_read,
     .write = avr_timer16_ifr_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {.max_access_size = 1}
 };
 
diff --git a/target/avr/helper.c b/target/avr/helper.c
index 365c8c60e19..9ee0a558ea7 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -256,7 +256,7 @@ static void avr_cpu_trap_write(void *opaque, hwaddr addr,
 const MemoryRegionOps avr_cpu_reg1 = {
     .read = avr_cpu_reg1_read,
     .write = avr_cpu_trap_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid.min_access_size = 1,
     .valid.max_access_size = 1,
 };
@@ -264,7 +264,7 @@ const MemoryRegionOps avr_cpu_reg1 = {
 const MemoryRegionOps avr_cpu_reg2 = {
     .read = avr_cpu_reg2_read,
     .write = avr_cpu_trap_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid.min_access_size = 1,
     .valid.max_access_size = 1,
 };
-- 
2.52.0


