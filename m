Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11751CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 14:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLiS-0007u7-Mk; Tue, 19 May 2026 10:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPLiL-0007tY-Qf
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:46:34 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPLiF-0007l1-Q8
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:46:31 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-490229aa522so4685425e9.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 07:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779201976; x=1779806776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3MSvt4pC1T/tB32g6+6vYeAfLkMq952qd4lIsXfdj2M=;
 b=aIiGkaTT2FcS2UaGJIhvJOaDSWZjde5faOKr1yK3ZHZ5yuFe01xiY74V7zAOjc+uXl
 sOiHlL5X8VsHiyUeb4BiAls65BSt8edUCKO6Q2gWNT9s60W+f7Ao/Vqo9URUexlZ2PxB
 fTDO4tHybzvSQIoEWBgcW2H131Do4jAHtkoc2vFfGZWdnEL211eedEVJEgYkTrylYCgK
 NvtqZbleiai32K3Tw2Pxzk6m8WzbqUSs0vpRkrvduH79t9Bl1NQbNJE0dvc0NZr7rvOx
 yP49JUwnvBKDM5IfD0BSvAlQBhb46heTZ93Gg2SD2gm8ZflUz1jUpQa9km7CnnLeG9Mo
 OyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779201976; x=1779806776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3MSvt4pC1T/tB32g6+6vYeAfLkMq952qd4lIsXfdj2M=;
 b=f0Za2VZZr+FIaUtANYB7xMMILvaLL7CNBOOGPV9YuwOvQYyXYdkhNWizCucr9gblc9
 TQN4bdX60gEUv9UpkBAkJvhCuZD5SwVZUGRvjAiliGWPQ5Goh9yUOVEttY5rKK/rGcI1
 hYlrwMak7La1N6Ud0gQZaf+t3qsSEpxwcbTuRu9RsseZd9n8H9iLLH0Kb4qe26bL5D9E
 UcBGntCk/wueJhs8JyTyMK6dy1ulq9UOaOcx+CIIsNSjcy+FVusgkLXKwIustxH38bPH
 Os2I35HikwqALweJkrVi4aIgp065kr2X0/slyDnZiunAWgM7TvVCW/asI1BNvNPKno9h
 XB2g==
X-Gm-Message-State: AOJu0Yy4JsFMdZFQT659+l5kaxqmtnU0LN9SVUeEtSz2rLy5d9i+BR3I
 HwSDmL6qgVD5/mSOJtF0yLVxyMzCts91XiIrP2dLArnWh/AUtxdw1wRlDyhwnLs0MyKv2ArLVKV
 P5Smd2cU=
X-Gm-Gg: Acq92OGJRZEN46hZwMELvgxNhnna2QijKhfdy32naHaZqOvcQTaoWTRyi9rfq6tXadj
 glv8gZIogZCX2vbro9ix9mKVVzRXvGAuPl1e3iQiRGOAJFlc+dyISYZ5SGFkYz2SP9SkWFUQ2PP
 AU1egRnWvMSgRxN3TpCxskg7mA3qjRWtUw+uaavSCnCNFfZT9CRBKOMIk7PlEFnviqgt/aBSdZ4
 3Xt6UdN40OrNFDgiM2wJKf6vUKXjMjTwlyJSZ6N5KjsSkzueuEOn/qYZMKiwVmJmz3tI072bi/b
 HM2GusvtNvAKnsf4UFLLguHEhW5kJlw2UHWz4f5/tjmt7L/k+LXA2ihuWz+tVtGZwTFm8/k9x0o
 uZP2J2T333ODnMZ6TmE1h1kiTW3BQAOnAFqnEXtPSxnDa0d/n91mCRyqLc3u3rvztcoH48366u4
 hWxw3AVjTNV98x/fiq3hMcekAE7PKUb+2N/DatTRh9/hJ2pt9AzeR4PuoBB2bIbZBQanyDnf/n
X-Received: by 2002:a05:600c:4e02:b0:48a:906a:9050 with SMTP id
 5b1f17b1804b1-48fe5fdb076mr316167035e9.10.1779201975686; 
 Tue, 19 May 2026 07:46:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe537c516sm356247775e9.13.2026.05.19.07.46.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 May 2026 07:46:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 03/18] hw/arm/raspi: Build objects once
Date: Tue, 19 May 2026 16:45:38 +0200
Message-ID: <20260519144553.91483-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519144553.91483-1-philmd@linaro.org>
References: <20260519144553.91483-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
index 80068f70bb9..144e4827660 100644
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


