Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80C1CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 10:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNq7O-0000hm-68; Fri, 15 May 2026 06:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7A-0000bp-QY
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:49:59 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq77-00019k-EV
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:49:55 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-44a5174670eso5074062f8f.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 03:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778842191; x=1779446991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hW5w2LIFgMkpT09kp6RNzcjxwDvmo2jSkWbQBxRR2No=;
 b=c3enBVCEtNSSONfdARMno5EZ4WXKTACJOcINLvGZ/ggWrwkBVL8jT8zXp3bps1dCsU
 ijkpWt9h+yBI2qZoWwchxO7rPJxj3O7ovbE3fhizx5vlmyWwn9ig+Cu8ATeIe7Sgf7bV
 cvIBwXMbWSHOk74oHVCRs6CgUMh6Ov3J+++qZWMkCQnxEpW6lrHYMnyoI6MoKFuvL4mV
 +8hp01MYjVhFBPRsflRLd8vKyjqklv2Z7L3egO6/H5bsPieyaVcI93GAPiEWuNG9woks
 4DXJeh3zFlOQ8bn1lSe3yP2VH/lZItLJOw2s07Gd0+62VwvOB9J3XgkbJCu2tMLEL4n4
 cK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778842191; x=1779446991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hW5w2LIFgMkpT09kp6RNzcjxwDvmo2jSkWbQBxRR2No=;
 b=B7wFapfjRN6rWgfFrg/ISvYJ9PEAxr3H1ED2OMi/M7xwFCAdpGJYczxHd50G73YflQ
 g3lxFQQGsgM1UYxQae79t71ieEI33ymyxh+F57BN/2UwKBBDXKdArUQcPyyzQOpf43ZU
 GYkYNAhEIZc3npU8tUuRWIxswIzKGe/5J/OkfL7Ez71XmEo8nlSofxd0ji0F2sFhWuQC
 gfQw6ngzQdTqTXkHX3REwUoBkuqpMIPeTIDrM04L1yB4YzzUCVzFRb59+PpbRz/lW90C
 M4x85QZcg7clT7kWsLds9aFt/g8rxmNYV0tbmz5lvsO6XwcR+FrAqFiyDS5JsLfX8wjS
 lwCA==
X-Gm-Message-State: AOJu0Yw/XMVlJy+CprbygB67VrHAp4YRCc3Dt7Bf0jfCHqMUcN/cvYIT
 tSMddLGNP7L933ogM29jLuwR8DdDXQONYiDWgC98OxC2ZAnyqStlyOA0z7DsQXpW4att9SIWcfy
 9pXqw
X-Gm-Gg: Acq92OGmXV+cGnIv/8aNB9iiWXVhXrhTxwoO3JLLMOMvi7HikNdlSdRFzCZvB/090sU
 HnlUawbV8tWhjHhr+1aySH+NzBif1zvXykEqkXNuOjvq7mrlC4C6aEGP/qqitpW+5Sky78mF2AT
 mshFBAyIHTbBcJqEG7gHoc3VtD2w5hYrzmRtZ+T6+p0p0jxc12lMIBBwzqQrZZ3pJko/42LCv9M
 FsQJRPawNnYwKSgtQZLsoRTzlE/YhTXac1ShqUxrIrMbiCDVA9R2qM+U7acn2ZwYcx3knh3lbZl
 GhfO60zrguc9AqnVL29R+zvRkShU4rE+keVLqb23jNuwWp4Z8hea08X+RbDL7v2IuIbKwDz7wdP
 vv32FWAffcegBI8qCylOeq6VDpZ4MWovUZTdXlvMM+LhiaSEb/Ur9h6bIQrXPf3aSn1rbrLcNbR
 zLxyf8aSIm7guijU2dzIFRT1v0JZQasuVkR0jL2z9Qw2+gvM9TPr0imgUwscAvm2Yy0ImrjcFU/
 ++ySBGOmG3jvHlywBEJMR6nZ+0VYS8=
X-Received: by 2002:a05:600c:c173:b0:48f:e230:c3f8 with SMTP id
 5b1f17b1804b1-48fe661b50amr47559915e9.30.1778842191274; 
 Fri, 15 May 2026 03:49:51 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaa2949asm18194355e9.1.2026.05.15.03.49.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 03:49:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/23] hw/arm: fsl-imx8mm: Don't call qdev_get_machine in init
Date: Fri, 15 May 2026 11:49:25 +0100
Message-ID: <20260515104945.4145203-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515104945.4145203-1-peter.maydell@linaro.org>
References: <20260515104945.4145203-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Vineet Agarwal <agarwal.vineet2006@gmail.com>

Calling qdev_get_machine() from fsl_imx8mm_init() can trigger
an assertion failure because the machine may not be created yet.

Reproducer:

  ./qemu-system-aarch64 -S -display none \
      -M virt -device fsl-imx8mm,help

This hits:

../hw/core/qdev.c:844: Object *qdev_get_machine(void):
Assertion `dev' failed.

Move the CPU initialization into realize(), where accessing the
machine state is safe.

(This is the same issue we fixed in the fsl-imx8mp machine
in commit b67d0bcdd41c; we apply the same fix here.)

Signed-off-by: Vineet Agarwal <agarwal.vineet2006@gmail.com>
Message-id: 20260511115918.32765-1-agarwal.vineet2006@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/fsl-imx8mm.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
index 97c3f8542c..875e92bb34 100644
--- a/hw/arm/fsl-imx8mm.c
+++ b/hw/arm/fsl-imx8mm.c
@@ -157,16 +157,9 @@ static const struct {
 
 static void fsl_imx8mm_init(Object *obj)
 {
-    MachineState *ms = MACHINE(qdev_get_machine());
     FslImx8mmState *s = FSL_IMX8MM(obj);
-    const char *cpu_type = ms->cpu_type ?: ARM_CPU_TYPE_NAME("cortex-a53");
     int i;
 
-    for (i = 0; i < MIN(ms->smp.cpus, FSL_IMX8MM_NUM_CPUS); i++) {
-        g_autofree char *name = g_strdup_printf("cpu%d", i);
-        object_initialize_child(obj, name, &s->cpu[i], cpu_type);
-    }
-
     object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
 
     object_initialize_child(obj, "ccm", &s->ccm, TYPE_IMX8MP_CCM);
@@ -229,6 +222,8 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
     MachineState *ms = MACHINE(qdev_get_machine());
     FslImx8mmState *s = FSL_IMX8MM(dev);
     DeviceState *gicdev = DEVICE(&s->gic);
+    const char *cpu_type =
+        ms->cpu_type ?: ARM_CPU_TYPE_NAME("cortex-a53");
     int i;
 
     if (ms->smp.cpus > FSL_IMX8MM_NUM_CPUS) {
@@ -237,6 +232,12 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    for (i = 0; i < ms->smp.cpus; i++) {
+        g_autofree char *name = g_strdup_printf("cpu%d", i);
+        object_initialize_child(OBJECT(dev), name,
+                                &s->cpu[i], cpu_type);
+    }
+
     /* CPUs */
     for (i = 0; i < ms->smp.cpus; i++) {
         /* On uniprocessor, the CBAR is set to 0 */
-- 
2.43.0


