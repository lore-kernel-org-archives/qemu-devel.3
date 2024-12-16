Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B053E77184
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 14:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNBwA-0003y2-QG; Mon, 16 Dec 2024 09:19:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tNBw8-0003ww-CR
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:19:04 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tNBw6-0000Cm-R5
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:19:04 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-725ee27e905so5437264b3a.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 06:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734358741; x=1734963541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8/OmY2WmEI/8k66B1EkRdUwbupmt1vgrU/5PDZqVbRs=;
 b=rbUgrm2rcoQ82YIryG0fnnEGvoc70ic23f2rkQ2jOcBjfpBgMVBjxUxKrTqcIwl/5q
 3+ko+Qdi8SS/xdE501xDxDFWqrx0KRKaUKaNrrnV+PtVEwt9e0CyPLCEHGzJ6Ck5okia
 sjlkQVuRQFYVn3sUITOVnQuGZAhQFyhjXarg/cu/J9w4vN1iV4dmq89Cdq7LK2ADyHx0
 JG84yBGhZJr/rXwW3NKuvIUg9MaBULr6iRojItYzuIX1mUd99PpmoMWDSkTR2KnuStjT
 8UC6Gxe4fDPlUL3YStci50mQJ78jjGU/ex8VVQ+2LyQOYciEKzZAIMTAUjukGbib1pSD
 kGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734358741; x=1734963541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8/OmY2WmEI/8k66B1EkRdUwbupmt1vgrU/5PDZqVbRs=;
 b=g1OCYWq1A87JTxf/1F1GNBfcxYokSj7yx3dHO6YuiS3KWRjeBv4Ng4ZGi7kALW4aQh
 tNuxHy0IVAGDp0U68qtHcrrwEazf/r/gM9GeEXvgqM9Dx+Ctk5th4CzX7Xuxjsm5dMQ+
 NLm4EjFJeCdtyRmI4EkJGZU/KwPKg0UmTlakOJv5vWnUDwmbRLaM/qQ1e5ZMWbL1Sc4c
 bz1898ieFHCau491gPypxTBOvTae7TQUMWXIkafwCpfGl7YAdoMOTsFbrkcjnasuH5RJ
 X4I6uVkHcMNx+x7zrSgc/kgzpONPR3PdQS2newQYO/pH+T68Ylz4fxzmc9iPYrHATzRI
 dXUQ==
X-Gm-Message-State: AOJu0YwEqsAUYQ19Dvfr0oMtCDg7RScVonarMjPCQ2U+oIAAIPhPgoan
 jESJ/bgBXZt/AaweAemv8JHJzcUoxYbePkGcdZhAqRs0bDTqU4VIlRWlH2r/BJ778kneGEweOmD
 k
X-Gm-Gg: ASbGncszGIwj8vWLFsuYl8DbS8ZVIrahDeJqgn5xiuCG/bYkWwyTM4paNW7GJzabgxB
 kQepdS3UkFBRk8UPr3uO91QAGh06DwfZZJ7rhl7tYYLM9tnU/Mlrab3Xqnu+gNtoin/v6QeTzL5
 HUyJMdEFClVAGO3hUKsb/mVWvfKCaFBmqe56AKwFA/zZp19M+m/p6LXFYeydDqnxtXqjA9zkzPI
 yZLYghCWy8Wh960QzLclyQxweEkMo8qAnSIym/HdpjXC0P2isy8uNgv9eY8GNs=
X-Google-Smtp-Source: AGHT+IH8Ss/6++oAQmRN8qAGHaA5iFNyL5h0hloSUikXyFjN1vvwmQ3SCZEY7ZkOct5GmNvhiqvt3Q==
X-Received: by 2002:a05:6a20:7285:b0:1e0:c50c:9842 with SMTP id
 adf61e73a8af0-1e1dfdda805mr26287311637.31.1734358741211; 
 Mon, 16 Dec 2024 06:19:01 -0800 (PST)
Received: from gromero0.. ([177.189.100.90]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918bad8acsm4948815b3a.146.2024.12.16.06.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 06:19:00 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, philmd@linaro.org,
 alex.bennee@linaro.org, thuth@redhat.com, armbru@redhat.com
Cc: gustavo.romero@linaro.org
Subject: [PATCH v3 3/7] hw/arm: Allow some machines to use the ivshmem-flat
 device
Date: Mon, 16 Dec 2024 14:18:14 +0000
Message-Id: <20241216141818.111255-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216141818.111255-1-gustavo.romero@linaro.org>
References: <20241216141818.111255-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42f.google.com
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

Allow Arm machine lm3s6965evb and the mps2 ones, like the mps2-an385, to
use the ivshmem-flat device.

Message-ID: <20231127052024.435743-2-gustavo.romero@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 hw/arm/mps2.c      | 3 +++
 hw/arm/stellaris.c | 3 +++
 hw/arm/virt.c      | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 50919ee46d..fe158dfbc0 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -42,6 +42,7 @@
 #include "hw/timer/cmsdk-apb-dualtimer.h"
 #include "hw/misc/mps2-scc.h"
 #include "hw/misc/mps2-fpgaio.h"
+#include "hw/misc/ivshmem-flat.h"
 #include "hw/ssi/pl022.h"
 #include "hw/i2c/arm_sbcon_i2c.h"
 #include "hw/net/lan9118.h"
@@ -472,6 +473,8 @@ static void mps2_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 1;
     mc->default_ram_size = 16 * MiB;
     mc->default_ram_id = "mps.ram";
+
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_IVSHMEM_FLAT);
 }
 
 static void mps2_an385_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 376746251e..6725d83f1b 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -28,6 +28,7 @@
 #include "hw/watchdog/cmsdk-apb-watchdog.h"
 #include "migration/vmstate.h"
 #include "hw/misc/unimp.h"
+#include "hw/misc/ivshmem-flat.h"
 #include "hw/timer/stellaris-gptm.h"
 #include "hw/qdev-clock.h"
 #include "qom/object.h"
@@ -1404,6 +1405,8 @@ static void lm3s6965evb_class_init(ObjectClass *oc, void *data)
     mc->init = lm3s6965evb_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
+
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_IVSHMEM_FLAT);
 }
 
 static const TypeInfo lm3s6965evb_type = {
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 333eaf67ea..67a4d3b838 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -85,6 +85,7 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/char/pl011.h"
 #include "qemu/guest-random.h"
+#include "hw/misc/ivshmem-flat.h"
 
 static GlobalProperty arm_virt_compat[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
@@ -3120,6 +3121,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_AMD_XGBE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_PLATFORM);
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_IVSHMEM_FLAT);
 #ifdef CONFIG_TPM
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
 #endif
-- 
2.34.1


