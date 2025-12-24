Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE47FE7545C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRL6-0000uL-RL; Wed, 24 Dec 2025 11:03:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRL5-0000jv-4k
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:03:51 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRL3-0006pv-CL
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:03:50 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b728a43e410so1114990566b.1
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766592227; x=1767197027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HmxQ9WEy0hVu6WpWDaVL5nWcD5VfHXcTym/HYUrgzEE=;
 b=blXQgQlxu6AhwrUllxznwo9ZV2hoScwo5ZooUuEK6SibdF2kXZVRnnUPRLizQtyHvS
 7t8ZKnvuWCLT6/rFhGfLKFG2w6MC6Qq/W8BekukpOrJSf101H73cEqwuvgdSp2zeVJnf
 n29okdQ0L6UQLp/kq/YBjekRf5x/caBkwZqYnaFohmWmi4cTGHgY837N6yQXn04ZtA5P
 08FMoHqxLDVQs6cyVnu4C9RVrZRyC8yKoEjpd9L329y3e8qoW+mO3TX6xNojZCU8oH/I
 NUEWhykg78bjeI1B/ccZxQszJ3qLJQzbTAFIts8ydEhLgmux4aUjJFs86LQLLzAaxPxO
 0k0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766592227; x=1767197027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HmxQ9WEy0hVu6WpWDaVL5nWcD5VfHXcTym/HYUrgzEE=;
 b=GJjMO0nHVxCO9YRtkDqspBdPK45Lg62wx/V73lNB5WO2SMXrav7dN6YN0SyU0vHi16
 cDRiFmLsqTmQwhV0ARwEiEniriaI2oAgI/yYL1BMcsb2rzXT+L5OUuOwAE2D/6Z5Y/bu
 /t9LdtuM4IeERmkmPiktqXPkO2pVIg3x5W0IJ2vEz1VP2HBEKbj7/NNXMRuZAOs2nhOd
 gNMJoIZsMpUz1vJljrZHKEVpbTx90u9UUeiUmyYRrV27W5Cidb/ooHpRmWQRsvrGRDn6
 ms4eJranhtnEnzErE8+TtWl+WruKUNxzWHPOknMMJ7XYbciNqLDtPBqbQZfqnxtK/8Ok
 VMSA==
X-Gm-Message-State: AOJu0YxT+0wbveaviBokcnjJOstSfDUvqeZw8iKOeJf4tmTiEOl8viVD
 RM5VmVbT+Cw4FReJuLmtD/xB0EfyolXc8FxEucZpWvYds+h2sziPDt/z4qVoH+XbeLxFU2b8392
 m17RARFg=
X-Gm-Gg: AY/fxX7nI2qGgHNYS3wG5ND/UIbdEJkKff4B2ap/LLVV2rxsedJ+nOubS1AE/CqN2Uo
 aAXSI3+keHP+Kw17Sml3Rhf/3yCXScSJelMzldFX91xbTnrbS1vHNM2bG3gktsXPL8y+5GnpysF
 RSGNcWzdo3I8to06DR7Rz+foeLXkLKlWhHt78bAn8y35XcFMw2Bd/dbXw+iS8KZAnVmFG9VxPHE
 z2Vp1gCoUV2/aviLkConv/FeSGSVnTCentQO+6JSg/fbx2Ar3AhruSEmJjKJWQZCa3vaU3HLCDU
 IfhxfLA1K9sPVryfBR5DYcmxpeKtp0K/kKKfgv5GID145CvCCP0EE70HkxoFlLUKjb8ksdysM+O
 O5VTXZVmP3ZiO2tFvG7F/xN9KcMQakO2hnn4BjgfYy7wOVuxgZD8SWRlcU547uRk6NhN/4BDDvU
 ZippeeR2juGG6OD6/NSXhcLBWBuLbD0YWNfAS2RT6Mmjb5QRW2toqEcd8=
X-Google-Smtp-Source: AGHT+IFVx1bIu0hxdZGdlz/62B69A0WZXCjxG9nnq3/6xns+rC1uf84YmpQa84zDIYzYDktTNxBthw==
X-Received: by 2002:a17:907:6094:b0:b72:8489:7e65 with SMTP id
 a640c23a62f3a-b80370537fdmr1964417366b.31.1766592227361; 
 Wed, 24 Dec 2025 08:03:47 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037a61595sm1831503266b.8.2025.12.24.08.03.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:03:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] hw/avr: Mark AVR-specific peripherals as little-endian
Date: Wed, 24 Dec 2025 17:03:33 +0100
Message-ID: <20251224160335.88861-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224160335.88861-1-philmd@linaro.org>
References: <20251224160335.88861-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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


