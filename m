Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53130C021B3
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 11:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmASO-0008VZ-34; Sun, 23 Feb 2025 06:47:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASL-0008U1-2u; Sun, 23 Feb 2025 06:47:33 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASJ-0005wM-BJ; Sun, 23 Feb 2025 06:47:32 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5e0516e7a77so5469902a12.1; 
 Sun, 23 Feb 2025 03:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740311249; x=1740916049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/jYU/jX3JT8LN7N0XTHpVbuIx3//fUXixDouFCjwZVg=;
 b=CW2+KK+Ait1spWjNd6h/xy5zHw2ix6KaQXnjae7r+hyogBRAWarZH2/yfXV/aJuZ7r
 b4oiJvbxgUiCRe1V781ibS0zyGeP/fVN7Ubm+QL7g05LTeblrgCLIFwgKLFeFlXio5za
 FXjultJJd4BXva4zTcxuGw80vZsQPEKxAGaDisMq+3O9DfVB1AA+P/QO5uTeAzEiAE+0
 AACLZsssKHCB6e89q896WBFdoIlJHEbj287zpEZONA8rP2d1ra6jc7ns3PCq5vwaGfjF
 2iOh5v0k6OahJLKGjrgjveyyD7VmaUO0A1Jbo+nnp+XayVVyT1iCx6jgTB1yQSx98GvY
 c1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740311249; x=1740916049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/jYU/jX3JT8LN7N0XTHpVbuIx3//fUXixDouFCjwZVg=;
 b=jI7Dv96MOgBVv3ljFnYidgSQq4P23GYr5EU5fC3JJaXT0BFgTagAv3dvcB9SUFbJ2K
 oUMG+WTWQDIcgpMfVP6gmaeE7rTeLpgnChq/N0BJ7AWMGtQ18F99eyuT69f5zC4Fw4vK
 E3j4fG1yWbw4IEAy0pqoOl3mkxqbGvupayfNpFrRWchiQrlevjPuZFyLZS3Zh0zQ4Zj8
 FqrV1erPCBJHnEPzoxyBx+f6/QSZcIZA9yymvnJpB/EPz4uAzYApo/Or8FIH84StOn4d
 V0yPTKrtouBfYBDe/i9CDtbNd2NLdjYVVEC1nRL5Mjd/qW+TH7yvV+bcBepqZ2339Ybr
 gzTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCULfzWT8CibXsM2F0nhDRm85WnOsPOcA5ZGWdVPCgAEcFFhtyjVdLzxmSEcWhaBsglFi/ERyivi/g==@nongnu.org
X-Gm-Message-State: AOJu0YwE5WvD1Lr1tEnEht4hT/NSh5YFtN+Rj7CUE6obbjSRtKjLjgzP
 wq85l0PtR4igoAch6vofNj6JWhj65KhHvz6hmavq539RK2E0YBKxVesU0Q==
X-Gm-Gg: ASbGncu5C/1RDAP8eoWrw7crcZkQ4x+33e++nxq4MbDynGgyQpx4W1bt8n/+O+m51tz
 tQyfjD8oM0VR/2z9857eWe9rW8eS/Ca6wX73KdPsTfiWy0o+j+8MkE4T9MvCps/L1fFtAmycQh3
 Wz9aIuCvSnqtWFeSMptTLXmFTUViqhAmtdyPCaARoxXDjF7UTS5/29EeohfWAuAlvxkaqm3378v
 5d4Pqif4FVW6VshHiZ/ClMAqibptDZuxyGBcjiClYFaojYczVcRPOwRJM6h8jBvwcie67jfQ5vi
 NOzGggpZ7ZkDmM3zNtQk0NKQ0nSSBFPFlt5xIZombfc2uL4+MZ7ogT7qE1FsWoQbtD3JNedU30m
 GhU4GjmMAm/7I
X-Google-Smtp-Source: AGHT+IEI8altf3NEcLxqcT9ZJIPShzaaDbeLPGvDWTaKLsUZjNRIrgr7ytYouKE1U2Gfmjme0trDrg==
X-Received: by 2002:a17:906:3282:b0:ab7:cb84:ecd6 with SMTP id
 a640c23a62f3a-abc0df5d6f5mr700970266b.56.1740311248864; 
 Sun, 23 Feb 2025 03:47:28 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-011-167-038.77.11.pool.telefonica.de. [77.11.167.38])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abba4b9ee98sm1240515466b.167.2025.02.23.03.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 03:47:27 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 06/18] hw/arm/fsl-imx8mp: Add SNVS
Date: Sun, 23 Feb 2025 12:46:56 +0100
Message-ID: <20250223114708.1780-7-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250223114708.1780-1-shentey@gmail.com>
References: <20250223114708.1780-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

SNVS contains an RTC which allows Linux to deal correctly with time. This is
particularly useful when handling persistent storage which will be done in the
next patch.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/system/arm/imx8mp-evk.rst |  1 +
 include/hw/arm/fsl-imx8mp.h    |  2 ++
 hw/arm/fsl-imx8mp.c            | 10 ++++++++++
 3 files changed, 13 insertions(+)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index f0df346113..22541c5442 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -12,6 +12,7 @@ The ``imx8mp-evk`` machine implements the following devices:
  * Up to 4 Cortex-A53 cores
  * Generic Interrupt Controller (GICv3)
  * 4 UARTs
+ * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
 
 Boot options
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index ce5188e7f2..26e24e99a1 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -12,6 +12,7 @@
 #include "cpu.h"
 #include "hw/char/imx_serial.h"
 #include "hw/intc/arm_gicv3_common.h"
+#include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mp_analog.h"
 #include "hw/misc/imx8mp_ccm.h"
 #include "qom/object.h"
@@ -36,6 +37,7 @@ struct FslImx8mpState {
     GICv3State         gic;
     IMX8MPCCMState     ccm;
     IMX8MPAnalogState  analog;
+    IMX7SNVSState      snvs;
     IMXSerialState     uart[FSL_IMX8MP_NUM_UARTS];
 };
 
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 2b86de45a0..de47ac1804 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -201,6 +201,8 @@ static void fsl_imx8mp_init(Object *obj)
 
     object_initialize_child(obj, "analog", &s->analog, TYPE_IMX8MP_ANALOG);
 
+    object_initialize_child(obj, "snvs", &s->snvs, TYPE_IMX7_SNVS);
+
     for (i = 0; i < FSL_IMX8MP_NUM_UARTS; i++) {
         g_autofree char *name = g_strdup_printf("uart%d", i + 1);
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
@@ -344,6 +346,13 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, serial_table[i].irq));
     }
 
+    /* SNVS */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->snvs), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->snvs), 0,
+                    fsl_imx8mp_memmap[FSL_IMX8MP_SNVS_HP].addr);
+
     /* Unimplemented devices */
     for (i = 0; i < ARRAY_SIZE(fsl_imx8mp_memmap); i++) {
         switch (i) {
@@ -352,6 +361,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_GIC_DIST:
         case FSL_IMX8MP_GIC_REDIST:
         case FSL_IMX8MP_RAM:
+        case FSL_IMX8MP_SNVS_HP:
         case FSL_IMX8MP_UART1 ... FSL_IMX8MP_UART4:
             /* device implemented and treated above */
             break;
-- 
2.48.1


