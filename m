Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A90C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 17:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ridpk-0006Wd-TJ; Fri, 08 Mar 2024 12:16:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ridpc-0006Vm-3w
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 12:16:35 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ridpY-0003of-QP
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 12:16:26 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33e162b1b71so2084983f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 09:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709918183; x=1710522983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EAfaOd/Q8LRJix3CBCeSxae8NympPrs4lYwaYOxdUU8=;
 b=bJz/cSLcYVTGbrQktP2f/c7zY1t8wWtZpzH+Jt6BH8fW9tq2XABC9vJPIOC8j5SGYr
 TcwnBbeKhMKT13SqqWxXyGbhLUlxpqpza7qAU1EkasF1WMa0gR0hWl1KCmaNhV0nNUH8
 Uj9R/ORIyp9vE2HFnJFr7SmiAG7jyfgnQ7JURHUJXNogJOT89KK+NN3HLYFe8UsXpsYe
 gV7j2pKL6H0Rg7HzAKgU4Fj8t0dOMsSu/qURrJYvgwfxqoafuKq+31dpMsdIM8WGEmMV
 zTVNua3UlmuFQIYLaMl3DyRFCIqD/fg2HBGKQ449PL5zU/he4xfgn3MNLW0QunsH1jrz
 pOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709918183; x=1710522983;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EAfaOd/Q8LRJix3CBCeSxae8NympPrs4lYwaYOxdUU8=;
 b=abcuLEnQ40f5kkZhN4681Ob6K2aOyAaIiC0JsUhxV2UUsYvzq98R7DVvjsKKi71m4W
 uqT3XRyG3SVD1oR6ROoBUV2T4jPRSb9/vjbXGj/oDcRigA2bbMeyQbTux5b28q9MZM9T
 uvGcC3R42MYKKr4T+kZ304Wlu6ONE3lIry1PvMuwsmW4gBEteaEP4Z6VWMx3o4fBLR1b
 kZXwgwOtoXWN+oSgtKKg4ND5CWcLsmJ3GJCNsfOQ/YMYq/vzpuEmRluH/0lg1JSKPkd/
 wbAzSEQJwQNC/dP0gxOCvPvXrXV7/BZe6OAcl48iPlfZMUyKb1qQbbs0kr/YuFq69CrD
 MCrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd7hJoqfHZy0DeI0agQ1/KMf25gqZFWMjHT7bTT8soK5pE9Hm0XnNvMQ5PC9LuDMaf8hYIZsT2auuOPKyp8UIVAz3xvGE=
X-Gm-Message-State: AOJu0Ywczq3i4SW0HLCoBOkWRyDghGUu8E1LTAIEF+Xj+PLTC1bL8VnB
 y6/T8dSF8kYYVBKHExNZ2+7prvUHB1SvVMnz6TzaaD3YfzQthKj8qVrUWoaf6/o=
X-Google-Smtp-Source: AGHT+IHJnETUuLMJIp1w00ASSErFlN9z/5PC+Cg3Ns46WYgFqsH6dwp5sPf2G8WGuP0lCxkNjsFFcQ==
X-Received: by 2002:adf:9c86:0:b0:33d:731f:b750 with SMTP id
 d6-20020adf9c86000000b0033d731fb750mr14634213wre.54.1709918183137; 
 Fri, 08 Mar 2024 09:16:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 bn1-20020a056000060100b0033e17341ebesm4027275wrb.117.2024.03.08.09.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 09:16:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PATCH] hw/arm: Deprecate various old Arm machine types
Date: Fri,  8 Mar 2024 17:16:21 +0000
Message-Id: <20240308171621.3749894-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

QEMU includes some models of old Arm machine types which are
a bit problematic for us because:
 * they're written in a very old way that uses numerous APIs that we
   would like to get away from (eg they don't use qdev, they use
   qemu_system_reset_request(), they use vmstate_register(), etc)
 * they've been that way for a decade plus and nobody particularly has
   stepped up to try to modernise the code (beyond some occasional
   work here and there)
 * we often don't have test cases for them, which means that if we
   do try to do the necessary refactoring work on them we have no
   idea if they even still work at all afterwards

All these machine types are also of hardware that has largely passed
away into history and where I would not be surprised to find that
e.g. the Linux kernel support was never tested on real hardware
any more.

After some consultation with the Linux kernel developers, we
are going to deprecate:

All PXA2xx machines:

akita                Sharp SL-C1000 (Akita) PDA (PXA270)
borzoi               Sharp SL-C3100 (Borzoi) PDA (PXA270)
connex               Gumstix Connex (PXA255)
mainstone            Mainstone II (PXA27x)
spitz                Sharp SL-C3000 (Spitz) PDA (PXA270)
terrier              Sharp SL-C3200 (Terrier) PDA (PXA270)
tosa                 Sharp SL-6000 (Tosa) PDA (PXA255)
verdex               Gumstix Verdex Pro XL6P COMs (PXA270)
z2                   Zipit Z2 (PXA27x)

All OMAP2 machines:

n800                 Nokia N800 tablet aka. RX-34 (OMAP2420)
n810                 Nokia N810 tablet aka. RX-44 (OMAP2420)

One of the OMAP1 machines:

cheetah              Palm Tungsten|E aka. Cheetah PDA (OMAP310)

Rationale:
 * for QEMU dropping individual machines is much less beneficial
   than if we can drop support for an entire SoC
 * the OMAP2 QEMU code in particular is large, old and unmaintained,
   and none of the OMAP2 kernel maintainers said they were using
   QEMU in any of their testing/development
 * although there is a setup that is booting test kernels on some
   of the PXA2xx machines, nobody seemed to be using them as part
   of their active kernel development and my impression from the
   email thread is that PXA is the closest of all these SoC families
   to being dropped from the kernel soon
 * nobody said they were using cheetah, so it's entirely
   untested and quite probably broken
 * on the other hand the OMAP1 sx1 model does seem to be being
   used as part of kernel development, and there was interest
   in keeping collie around

In particular, the mainstone, tosa and z2 machine types have
already been dropped from Linux.

Mark all these machine types as depprecated.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/about/deprecated.rst | 15 +++++++++++++++
 hw/arm/gumstix.c          |  2 ++
 hw/arm/mainstone.c        |  1 +
 hw/arm/nseries.c          |  2 ++
 hw/arm/palm.c             |  1 +
 hw/arm/spitz.c            |  1 +
 hw/arm/tosa.c             |  1 +
 hw/arm/z2.c               |  1 +
 8 files changed, 24 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 8565644da6d..7345e9f536a 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -247,6 +247,21 @@ to correct issues, mostly regarding migration compatibility. These are
 no longer maintained and removing them will make the code easier to
 read and maintain. Use versions 2.12 and above as a replacement.
 
+Arm machines ``akita``, ``borzoi``, ``cheetah``, ``connex``, ``mainstone``, ``n800``, ``n810``, ``spitz``, ``terrier``, ``tosa``, ``verdex``, ``z2`` (since 9.0)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+QEMU includes models of some machine types where the QEMU code that
+emulates their SoCs is very old and unmaintained. This code is now
+blocking our ability to move forward with various changes across
+the codebase, and over many years nobody has been interested in
+trying to modernise it. We don't expect any of these machines to have
+a large number of users, because they're all modelling hardware that
+has now passed away into history. We are therefore dropping support
+for all machine types using the PXA2xx and OMAP2 SoCs. We are also
+dropping the ``cheetah`` OMAP1 board, because we don't have any
+test images for it and don't know of anybody who does; the ``sx1``
+and ``sx1-v1`` OMAP1 machines remain supported for now.
+
 Backend options
 ---------------
 
diff --git a/hw/arm/gumstix.c b/hw/arm/gumstix.c
index d5de5409e17..91462691531 100644
--- a/hw/arm/gumstix.c
+++ b/hw/arm/gumstix.c
@@ -106,6 +106,7 @@ static void connex_class_init(ObjectClass *oc, void *data)
     mc->desc = "Gumstix Connex (PXA255)";
     mc->init = connex_init;
     mc->ignore_memory_transaction_failures = true;
+    mc->deprecation_reason = "machine is old and unmaintained";
 }
 
 static const TypeInfo connex_type = {
@@ -121,6 +122,7 @@ static void verdex_class_init(ObjectClass *oc, void *data)
     mc->desc = "Gumstix Verdex Pro XL6P COMs (PXA270)";
     mc->init = verdex_init;
     mc->ignore_memory_transaction_failures = true;
+    mc->deprecation_reason = "machine is old and unmaintained";
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("pxa270-c0");
 }
 
diff --git a/hw/arm/mainstone.c b/hw/arm/mainstone.c
index d2e2e68aa3f..3a6c22fddbc 100644
--- a/hw/arm/mainstone.c
+++ b/hw/arm/mainstone.c
@@ -169,6 +169,7 @@ static void mainstone2_machine_init(MachineClass *mc)
     mc->init = mainstone_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("pxa270-c5");
+    mc->deprecation_reason = "machine is old and unmaintained";
 }
 
 DEFINE_MACHINE("mainstone", mainstone2_machine_init)
diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index 35deb74f655..35364312c73 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -1430,6 +1430,7 @@ static void n800_class_init(ObjectClass *oc, void *data)
     /* Actually two chips of 0x4000000 bytes each */
     mc->default_ram_size = 0x08000000;
     mc->default_ram_id = "omap2.dram";
+    mc->deprecation_reason = "machine is old and unmaintained";
 
     machine_add_audiodev_property(mc);
 }
@@ -1452,6 +1453,7 @@ static void n810_class_init(ObjectClass *oc, void *data)
     /* Actually two chips of 0x4000000 bytes each */
     mc->default_ram_size = 0x08000000;
     mc->default_ram_id = "omap2.dram";
+    mc->deprecation_reason = "machine is old and unmaintained";
 
     machine_add_audiodev_property(mc);
 }
diff --git a/hw/arm/palm.c b/hw/arm/palm.c
index 8c4c8316140..e04ac92eb7f 100644
--- a/hw/arm/palm.c
+++ b/hw/arm/palm.c
@@ -309,6 +309,7 @@ static void palmte_machine_init(MachineClass *mc)
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("ti925t");
     mc->default_ram_size = 0x02000000;
     mc->default_ram_id = "omap1.dram";
+    mc->deprecation_reason = "machine is old and unmaintained";
 
     machine_add_audiodev_property(mc);
 }
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index 643a02b1807..62cd55ba914 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -1041,6 +1041,7 @@ static void spitz_common_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_IDE;
     mc->ignore_memory_transaction_failures = true;
     mc->init = spitz_common_init;
+    mc->deprecation_reason = "machine is old and unmaintained";
 
     machine_add_audiodev_property(mc);
 }
diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index 3ca2e4459ca..5891f6064f9 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -270,6 +270,7 @@ static void tosapda_machine_init(MachineClass *mc)
     mc->init = tosa_init;
     mc->block_default_type = IF_IDE;
     mc->ignore_memory_transaction_failures = true;
+    mc->deprecation_reason = "machine is old and unmaintained";
 }
 
 DEFINE_MACHINE("tosa", tosapda_machine_init)
diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index eb2ff8dbc84..fc5672e7ab2 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -347,6 +347,7 @@ static void z2_machine_init(MachineClass *mc)
     mc->init = z2_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("pxa270-c5");
+    mc->deprecation_reason = "machine is old and unmaintained";
 
     machine_add_audiodev_property(mc);
 }
-- 
2.34.1


