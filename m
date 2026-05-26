Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A403CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 20:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRyX2-0000ac-8M; Tue, 26 May 2026 16:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyWz-0000Zc-5P
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:37:41 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyWx-0006oE-Cu
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:37:40 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso94949535e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 13:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779827858; x=1780432658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K7fE/F+6UJ2P7juY/o9Y89pkxTy9idikRNCFiEAOtZY=;
 b=aAHS0P+ZgxbsENClBsX9lxeyCp4iLZvf1iWRedq+n7pg61aOGnvPRtmIiiLepyNXAp
 yrddcb4hKY+HTJi/iMXdv7a1Sht5G5nzc5RMsyGlLZiWYXnqbCTIbfNU60su8qjzcCK6
 Xb/qin3p4Ej5Uz4Uxp3US0LynwTa3euLLhtnfCEBSejktvXDdGqWxXQGeFq8VrW2WiB/
 eCCnyTVyP297jtlCDpWKeMcX0S3wA++ImXSouzTsXgJvz5M+VZKSfqZ/H1Fyo8KOj23M
 YQCxCCR3NIGFcaMBKCF1pT+Q7CbTW+AaM/4dVTpDAhC/vTvCq0/bYIAGTWswzZU6SAUd
 IJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779827858; x=1780432658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K7fE/F+6UJ2P7juY/o9Y89pkxTy9idikRNCFiEAOtZY=;
 b=gdnld0Gd/ws4zHlnzvEBW13bDN6nlJFlD7ifRrX3RzbgYyfUo3PRJtlR003TsVjvUN
 Vya5Qdi7pIzgixyhuFQZ1r2/gBAuhwbwv4/D84Gs50xcRCn+yzrr16GmbV8309z1jatk
 r/o1QI2ifaJCZ69XWD2MdRmgO5sSNpnXbuG32VtSHZ8UNCsTl7nr/onzD9O2jJkO1R/F
 ZEcyr8QTzNqOqzcL88g2UoWiIFAfU1/6L9B5unTpvF8BT8sYDzcvimNcACzzsoZwibsT
 ZJC0k9AVv+q3DUSJWfieGoDycDM2vM8ZF+cP29KI+q1c5SjzchpCQde9CBjo+GPZcZrF
 UysQ==
X-Gm-Message-State: AOJu0Yx4CjdjCSvvjft1cr88FQqome5zSS1WZnTMV6YztkPfvCtWdeMn
 gJNGoMWBsWGNTrp4E8CtQazQhkt/R7fxvHxzUpagMECAuDWkgNSasQSIKnGaMzHRTrWb180w5VU
 As/QrE4lLyg==
X-Gm-Gg: Acq92OEAbDIhG7UrxkWgcloAgx8J8hgmWxtuvQ3V5RixS+vhOeDpBStIGtt73BftFt6
 0ZHxEBUkYidi4jjb+GsQrENob5JQ0V//VZC3JWArUP8xlL3rFG960Wv95DYPgOi6PUJebcO2hh/
 CO9WlFQY/dH3uiqqMS7gqP9+tcAZGJE6jTbQhybXmBatwU5377Dut1a08lylYS9KSewmGwmHq/4
 spRc+WpGK7Ic+hfnxi8u23u7ptMNnN19Wr1e+xLv5UsR3NekV1RLXOy4z3rksDRO4ngwFoZxTEG
 H2C+aGbDLjWNGWQmQkcqeih+M3de2DHbb70OerQiDrIsYnWTUaFqJjWtKbguHVLP218GKq0LYTR
 FRtwoIB7/cu2FyyV5zaJOgCPFefmkwgrw/6N8DfhI6qfmdvKgBHZ21/sVGH3ABgKkemMDF0v+1j
 l95nPSc1aG69sELnx52E1VtZHfRlBByXAyXJfkHOPpZ7miWflMCv/R2EX6ndIZgwDdxw==
X-Received: by 2002:a05:600c:3b02:b0:48a:581c:ead with SMTP id
 5b1f17b1804b1-490425ac8a1mr343418145e9.10.1779827857958; 
 Tue, 26 May 2026 13:37:37 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5584b8sm749790f8f.11.2026.05.26.13.37.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 May 2026 13:37:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 02/17] hw/arm/raspi: Build objects once
Date: Tue, 26 May 2026 22:37:07 +0200
Message-ID: <20260526203722.79463-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526203722.79463-1-philmd@linaro.org>
References: <20260526203722.79463-1-philmd@linaro.org>
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

Now than Raspi machines can be filtered when running a
qemu-system-arm or qemu-system-aarch64 binary, we can
remove the TARGET_AARCH64 #ifdef'ry and compile the
aspeed.c file once, moving it from arm_ss[] source set
to arm_common_ss[]. Note, we expose the TYPE_BCM2837
and TYPE_BCM2838 types to qemu-system-arm, but they are
not user-creatable, so not an issue.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/bcm2836.c   | 4 ----
 hw/arm/raspi.c     | 4 ----
 hw/arm/meson.build | 8 ++++++--
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 03825e69d06..f4ecea908bd 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -195,7 +195,6 @@ static void bcm2836_class_init(ObjectClass *oc, const void *data)
     dc->realize = bcm2836_realize;
 };
 
-#ifdef TARGET_AARCH64
 static void bcm2837_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -208,7 +207,6 @@ static void bcm2837_class_init(ObjectClass *oc, const void *data)
     bc->clusterid = 0x0;
     dc->realize = bcm2836_realize;
 };
-#endif
 
 static const TypeInfo bcm283x_types[] = {
     {
@@ -219,12 +217,10 @@ static const TypeInfo bcm283x_types[] = {
         .name           = TYPE_BCM2836,
         .parent         = TYPE_BCM283X,
         .class_init     = bcm2836_class_init,
-#ifdef TARGET_AARCH64
     }, {
         .name           = TYPE_BCM2837,
         .parent         = TYPE_BCM283X,
         .class_init     = bcm2837_class_init,
-#endif
     }, {
         .name           = TYPE_BCM283X,
         .parent         = TYPE_BCM283X_BASE,
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 00e4a10466a..3f99e87428c 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -367,7 +367,6 @@ static void raspi2b_machine_class_init(ObjectClass *oc, const void *data)
     raspi_machine_class_init(mc, rmc->board_rev);
 };
 
-#ifdef TARGET_AARCH64
 static void raspi3ap_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -387,7 +386,6 @@ static void raspi3b_machine_class_init(ObjectClass *oc, const void *data)
     rmc->board_rev = 0xa02082;
     raspi_machine_class_init(mc, rmc->board_rev);
 };
-#endif /* TARGET_AARCH64 */
 
 static const TypeInfo raspi_machine_types[] = {
     {
@@ -405,7 +403,6 @@ static const TypeInfo raspi_machine_types[] = {
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi2b_machine_class_init,
         .interfaces     = arm_machine_interfaces,
-#ifdef TARGET_AARCH64
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3ap"),
         .parent         = TYPE_RASPI_MACHINE,
@@ -416,7 +413,6 @@ static const TypeInfo raspi_machine_types[] = {
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3b_machine_class_init,
         .interfaces     = aarch64_machine_interfaces,
-#endif
     }, {
         .name           = TYPE_RASPI_MACHINE,
         .parent         = TYPE_RASPI_BASE_MACHINE,
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 68d204bb4eb..f149ed68d09 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -27,8 +27,12 @@ arm_common_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10.c'
 arm_common_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3.c', 'orangepi.c'))
 arm_common_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40.c', 'bananapi_m2u.c'))
 arm_common_ss.add(when: 'CONFIG_MAX78000_SOC', if_true: files('max78000_soc.c'))
-arm_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2836.c', 'raspi.c'))
-arm_common_ss.add(when: ['CONFIG_RASPI', 'TARGET_AARCH64'], if_true: files('bcm2838.c', 'raspi4b.c'))
+arm_common_ss.add(when: 'CONFIG_RASPI', if_true: files(
+  'bcm2836.c',
+  'bcm2838.c',
+  'raspi.c',
+  'raspi4b.c'
+))
 arm_common_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c'))
 arm_common_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c'))
 arm_common_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_soc.c'))
-- 
2.53.0


