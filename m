Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF14ECD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBa9-0000d7-Oo; Wed, 27 May 2026 06:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBa5-0000Pw-U7
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:33:46 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBa4-0001Q4-0O
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:33:45 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-45e9f4a3510so3460499f8f.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779878022; x=1780482822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Kpp0zClwMgMbOmq3SlX5ECN/AvI4ScOkwm8njbTr4Pc=;
 b=vgjcAfmNrIUVecP5GjOGgAELUGkljhhuTk2xBh76BvIaiH+7NaoxuBQS7r8yOAvxFA
 vCmsr91D4ujia4Vg7HTTSVPIBTVVf/4/NBiABpVPTyOQN6TLRYLeLGKE5MY1Mrw+ckAK
 DAdEmacUi141FEaYLnE185NClaiLfYCeEXofQSk0+16lqa0IerUW5VB9tO+dRgJ6d8mB
 4x0Ioh1LF1ySBZS5UZ+czAWj9QCwXSKxfvIqJQjheylvY0/OK1x3yENHgH34iu9I4APw
 mk/ieeYY8AYmDqlMstLF60gKYHZOMvVAwkjPeVYZKPbVoBm7eo3IitG+gRxXL0GO6QqM
 MM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779878022; x=1780482822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Kpp0zClwMgMbOmq3SlX5ECN/AvI4ScOkwm8njbTr4Pc=;
 b=NsaTn5Koc6MGxpg/sgPOcDfGbDWrie5tmPiT2Y7QDBju1UyNAr01EcTLWNbZjlIQ+T
 2UD+RwykKsyih2gqlJgRt7NG0KZuehVBNrdkbyZokeMo7rb+i0i33d/XmKiQZJgX4LTL
 Gw756qA8ToMEhJY/sAChZYOWUY9dq37PIQ6BBKxQZynVwCfNhi9QgBwPX5jE8QWakglF
 9rIQb60jo/RZ4NdOjdbTcTMBMGfXzpolwOcmFCJO6v2AHD2y01rgW8R50JolCFpIV/Iv
 SCx329JwBNJ2GNujw3n4aZ6mXSNZLplxFzVZCBBzyP9l/HRedzntp0ADwwoZaL96xMKW
 t7Tg==
X-Gm-Message-State: AOJu0Yy1mdC8Kx3SC1hBWOiZSpVDJU2RUm0sSAjAnZZ7sowELoRXtquM
 qlnG+Nk9sm7Jb2VOJbozPdvonOBaFimn7AHCpnB8cX69PK/ka0yiW28ocota7YZvAa8m5NA4yRA
 9n8cx5XpzOw==
X-Gm-Gg: Acq92OFOANdvWjecOKfg+2RpgIb7U5W6SjesFwjBGYjEqZeToWqXxhF3EE1cKdAaWLu
 jjgXu2yc3w2dwCwpap9BPQV95f1NWbk8tboXYiIeB7lcU8y8U2inbIY6waYrO2jJs3SDXophsLe
 siU9B1KW9DJ1lWMo0pVJwxo/NvYAN6zWycSe5v1IOvmjnRzvNwDu5KxluvQGE/jLgyCS9xcwESS
 lPduCy1cfAHJjiROuJGqdcOaEIFOVWHFbtZcrFjmE6hygx3UKzHSvdXPwyfIF6mjuBjYbBqe87a
 S94fB1eiYKi9rqAWIPD42Jvy6Qx/NLgSd+HmZYFGIzS1V2dMmgyDaQGMAwsWd8O36dVh+33ZPpe
 nrBBe1iCKTrbno+lEIdnqEg+xp/OCFCOxwhwn0OHPW9OT/LqrIkRdoVNA89n2wtGrmBidOybGce
 3Lgk9uePyYCjjGpPTN5G8YYgsVQQlpEaYKDsDUzqRnN2Yc/rtl6j4ddLU=
X-Received: by 2002:a05:6000:40cf:b0:452:273:5cd6 with SMTP id
 ffacd0b85a97d-45eb367fe78mr39952242f8f.1.1779878022291; 
 Wed, 27 May 2026 03:33:42 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5b1c7bsm4959185f8f.29.2026.05.27.03.33.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 03:33:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/32] target/arm: Build cpu32-system.o as common object
Date: Wed, 27 May 2026 12:30:31 +0200
Message-ID: <20260527103037.4461-28-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527103037.4461-1-philmd@linaro.org>
References: <20260527103037.4461-1-philmd@linaro.org>
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

cpu32.c only contains CPU types used in 32-bit system emulation:
rename it as cpu32-system.c; always compile the file but only
register the QOM types for the 32-bit binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20260526203722.79463-17-philmd@linaro.org>
---
 target/arm/tcg/{cpu32.c => cpu32-system.c} | 10 +---------
 target/arm/tcg/meson.build                 |  5 +----
 2 files changed, 2 insertions(+), 13 deletions(-)
 rename target/arm/tcg/{cpu32.c => cpu32-system.c} (99%)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32-system.c
similarity index 99%
rename from target/arm/tcg/cpu32.c
rename to target/arm/tcg/cpu32-system.c
index 8220d785f5b..6e983900899 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32-system.c
@@ -1,5 +1,5 @@
 /*
- * QEMU ARM TCG-only CPUs.
+ * QEMU ARM TCG-only CPUs (not needed for the AArch64 linux-user build)
  *
  * Copyright (c) 2012 SUSE LINUX Products GmbH
  *
@@ -13,15 +13,9 @@
 #include "cpu.h"
 #include "accel/tcg/cpu-ops.h"
 #include "internals.h"
-#if !defined(CONFIG_USER_ONLY)
 #include "hw/core/boards.h"
-#endif
 #include "cpregs.h"
 
-
-/* CPU models. These are not needed for the AArch64 linux-user build. */
-#if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
-
 static void arm926_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -746,5 +740,3 @@ static void arm_tcg_cpu_register_types(void)
 }
 
 type_init(arm_tcg_cpu_register_types)
-
-#endif /* !CONFIG_USER_ONLY || !TARGET_AARCH64 */
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index d5a95bf54f2..9b859892ed8 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -30,10 +30,6 @@ translate32_d = [
 arm_ss.add(when: 'TARGET_AARCH64', if_true: gen_a64)
 arm_stubs_ss.add(files('stubs32.c'))
 
-arm_ss.add(files(
-  'cpu32.c',
-))
-
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'gengvec64.c',
   'translate-a64.c',
@@ -85,6 +81,7 @@ arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
 
 arm_common_system_ss.add(files(
   'cpregs-at.c',
+  'cpu32-system.c',
   'gicv5-cpuif.c',
   'psci.c',
   'tlb_helper.c',
-- 
2.53.0


