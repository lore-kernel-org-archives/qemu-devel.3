Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318ADCD4F3C
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 17:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOIcN-0002Om-FV; Sat, 16 May 2026 13:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOIcL-0002Nt-Dv
 for qemu-devel@nongnu.org; Sat, 16 May 2026 13:16:01 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOIcJ-00081z-Ol
 for qemu-devel@nongnu.org; Sat, 16 May 2026 13:16:01 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so8965305e9.3
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 10:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778951757; x=1779556557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3MSvt4pC1T/tB32g6+6vYeAfLkMq952qd4lIsXfdj2M=;
 b=NO+r8ADZtufSrCDC+hsDFQB5ypoW3Ba42+iM8WLSjhkGrOsk/zd033WfDdAapEYtL4
 hcwTJeG0VzFPvvroS/JeW8QHmbVPwwVWsjCeY8Wv9QL6d09/T897boecZezq3CWUsK4r
 AtorWTHD/agyGb9CSTYLVfJlT+1Swf4Q2B89r/8jT23FEsSyep5Y+ba1lF4CTbjmv8Is
 FK5qmcVXCBVa7gTwOqGrdo3GFqeA07JCxj6415XsT+vjcdpEzKzc/R4Xh2baYNPlmbQY
 WeLuedk+VHrgsNfT4eylvCrJWXttjwdKSIiiQss9i1eTW3l6yl7iqwNwQj5Tx5Y+8acn
 poPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778951757; x=1779556557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3MSvt4pC1T/tB32g6+6vYeAfLkMq952qd4lIsXfdj2M=;
 b=GwF4LGAcYs6ZK7GqY9Fh9BOF+cdExEGZcv7YTFDgTu4dD33MIwh6M1adIayr65DHw8
 4cT1gGb5h4gFFUCSbbvc8w2ls3cdccISjL7ftmABablGIBz+SNxikksjw/uqQLaPLzQI
 acEbnCrf1mMsYtsSkp4n6lFph+f5zrvAOXrWnF1Xauv0fNfLHb+tMyv/OETxRJLG1n4G
 Lw/ctYfve9ZZPg+HStaPELrCR38tov2NazYCgTbfCphC8kOqDgcA1Ex5onMWE8mTpAsQ
 uqBQUCLX4eCuJ138XBdZaMruR6sawGfisuzmM0Jd1pHGEQ2HpeIJglVgV1rSMfjr5fdh
 zFog==
X-Gm-Message-State: AOJu0Yx7K0+AeTSFAs/TsbFKWDdSmqOcwZ7ZdVHE60RsZOy0xHR4DH1P
 3C3NzpBWaiqhua1lxZezqWOl7mZ6LK8Mj4oWKZOicvX5ccaEA3jbxXL6CuTtUn6H6j4UNdPuQ4E
 gKE9x2fI=
X-Gm-Gg: Acq92OFBsona72+iNuGNqpjN1gJb5VGLa/O5gOe7P8e3hJfnz/Lu10mOXBMZ5DLRBRD
 xAquA0HJ7QgvyUNagree0QX4hP8M4Zqmulr/bnxtWRrLWZeKJkEtgvJXcORckq4tFkRwnmCz+zY
 T5D5FI6s/oKGe2dGDa0S9aD5djKgVYgiP8tXWMAyA0IHS7j9WHWs5a9PrkHT83oMmirb+y1rBar
 d9w7hAk4Ae0I9PzfwcNtR5ksvi6MVjhoJuKFoyHxn+J4xYRvmL1aV3J9UOo4H1zveZFs35YVEGd
 4JvVkdcufO6Z636Vs4+jv4hiIus4IrCwzFjJQc+hxacuPcq+JUnPFOvweAQ0B6pXoWWjzIJxQEs
 /vEzm78YTxCtXwmkzbmmffFbNsCld/mnGBIjXwn5L5qN704hMYrejR37jZqjIoDq4zrDp8w8ABu
 9M0bhRa/tgrmJ53IQBpPlLCXm8YJQInOzwM/W/uFSQ0Zsh62WU2CMCXgfxgOQLKuf6Gon7UblD0
 AY6NH0JCh4=
X-Received: by 2002:a05:600c:4692:b0:48a:906b:14ca with SMTP id
 5b1f17b1804b1-48fe632579dmr119569725e9.20.1778951756525; 
 Sat, 16 May 2026 10:15:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c88e5asm146639245e9.6.2026.05.16.10.15.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 16 May 2026 10:15:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Joel Stanley <joel@jms.id.au>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Troy Lee <leetroy@gmail.com>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 04/21] hw/arm/raspi: Build objects once
Date: Sat, 16 May 2026 19:15:06 +0200
Message-ID: <20260516171524.19184-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516171524.19184-1-philmd@linaro.org>
References: <20260516171524.19184-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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


