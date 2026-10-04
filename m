Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CFFCA5FE6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 12:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDLJu-0006ZZ-DG; Sun, 04 Oct 2026 08:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLJr-0006Xj-7j
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:27:55 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLJp-00079i-Id
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:27:54 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a16629a040so12910305e9.1
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 05:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791116872; x=1791721672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ffa1V6tn2IfWueByDpRqxUf/UBayNFXRkCdogr6gDuE=;
 b=jZyXJ8J2V2Y/auLVwAPN/IjUNPxTa+qMDnR9OeQqGD30ZymgTtzY+Oe2gHn6Avn+ez
 CpSyJcch8nWq78Yt3s6EfW+Fg6j6qIBLGlquOORDZ7xBXmFubNhgcGICX8sOsmkbEZJm
 qbqMKNvz0rCBU8H6i2KHj0I36yJfPAXzUTocURAlc8LgmYSOd+yhgvU4QF45PE1WuRV+
 j7uNZhvS8FhkDZKxFTvTOJWiuDlSFGqDOc6YHofhiWOqC8IAd2R1xb1hpOvhIlrAWBKa
 OetElWneFKr3lRIXOXQdrBde1WSjpjMzRajXfV4U4FHO3mC4jPee6f7OdEHDjd5sz/h3
 WD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791116872; x=1791721672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ffa1V6tn2IfWueByDpRqxUf/UBayNFXRkCdogr6gDuE=;
 b=rLu/RIF9d68g/g/N73a9rpeNmJ+XMOR1dhnxhG2b/IXT6zScPfD79QauPqVk/a5ke7
 gF0+mx5qbraFUxLSbNldMwSZ/udHJIjE+05bguDxE5lMyOIGikU6UB1//16vAod5tYvi
 HJj1USLlU7nez1QYOXfPAZwyWjT/tbl+aa1jxUsmRlATez7NDffvuASfeFxXyMr0Erp+
 6taCGw7AMn7/UK+3MshBgVbgwEY3sBJYUXP4cA24UXY4DZHiXezDD06O5AXAjzHBjpbz
 JH4pqf2GRA7rcSxm6aUzHQACi0wShrRbISw6Z5/V5XA1nmHzz72BARTRDFhM8fIS9GMn
 TuOg==
X-Gm-Message-State: AFuF++kNs2Ft5AAB/SN/JUlbMTRfFsJ1XhRsKEvJ6BP/vTcwT7CrpEEV
 6niQ4iGX6XCrGu/imIDQi+Q3Y9jPKmoRwGbkJs+AwbM8IHXbow8Bx5hP6TEsWQ==
X-Gm-Gg: AYBFou2j6VE7cQYBJVNWaoY+e26Y2y2mkLPgyKQiDUIwNcXxHCfwhosuCOpGn6qrCoM
 np7ylwqoqYOLWaIsIGd0oEbqHJmrR8hR91pdGh1k+jYGwYlwkd+qL/HCXccuxDiTy8n/C0SVd2E
 WW/GxBdhWTMql3H/+9mvGGjWB8LP8OJXys0nBx4q4uYqDTh/ExL2YeOC0Ig4KEj7H4TSIM0yCZ8
 A9kyNu41B2JVVVO3mKyxEQkZA3Bnla19QB7okuOYS4e2h4xy5ahKvC4UiUJfKCBjKcpmZDUQR9Z
 Ep+BStd+54bH46d7BepH569Tfw0jqzgUQFu66Zro+a05Klax7fKErnRIpxBVijPA6M7i8abpqTX
 y2ojH/9dsCWQaW+y3z7ZOekLnVv9xo2tkwlXEE6kna7LqbvuFg9ksYGeiJT87bJ0kbHODYNPNDS
 nBfG90SxJxSWPdZqAbrpd13UzouUc1BLVZTST3kgyLVCFidIuHakvn7abwREf2dmY5jq1EUxJKD
 d0wOSq+I0hWuSMScLSxWjdq0pQ06ndWd1MekA==
X-Received: by 2002:a05:600c:3b01:b0:49c:ffab:551f with SMTP id
 5b1f17b1804b1-4a1680ed179mr63973645e9.22.1791116871872; 
 Sun, 04 Oct 2026 05:27:51 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027698f13sm242319975e9.1.2026.10.04.05.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 05:27:51 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 13/30] hw/arm/fsl-imx6: Derive from TYPE_SYS_BUS_DEVICE
Date: Sun,  4 Oct 2026 14:26:29 +0200
Message-ID: <20261004122647.3913-14-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261004122647.3913-1-shentey@gmail.com>
References: <20261004122647.3913-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Deriving from TYPE_SYS_BUS_DEVICE fixes the SoC object to be reset upon
machine reset.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/arm/fsl-imx6.h | 5 ++---
 hw/arm/fsl-imx6.c         | 4 +---
 hw/arm/sabrelite.c        | 2 +-
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 376deea3a4..4cf26f1fbc 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -35,6 +35,7 @@
 #include "hw/usb/imx-usb-phy.h"
 #include "hw/pci-host/designware.h"
 #include "hw/core/or-irq.h"
+#include "hw/core/sysbus.h"
 #include "system/memory.h"
 #include "target/arm/cpu.h"
 #include "net/can_emu.h"
@@ -56,10 +57,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslIMX6State, FSL_IMX6)
 #define FSL_IMX6_NUM_CANS 2
 
 struct FslIMX6State {
-    /*< private >*/
-    DeviceState parent_obj;
+    SysBusDevice parent_obj;
 
-    /*< public >*/
     ARMCPU             cpu[FSL_IMX6_NUM_CPUS];
     A9MPPrivState      a9mpcore;
     IMX6CCMState       ccm;
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index eec9673c6f..7ba9b85a2e 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -519,13 +519,11 @@ static void fsl_imx6_class_init(ObjectClass *oc, const void *data)
     device_class_set_props(dc, fsl_imx6_properties);
     dc->realize = fsl_imx6_realize;
     dc->desc = "i.MX6 SOC";
-    /* Reason: Uses serial_hd() in the realize() function */
-    dc->user_creatable = false;
 }
 
 static const TypeInfo fsl_imx6_type_info = {
     .name = TYPE_FSL_IMX6,
-    .parent = TYPE_DEVICE,
+    .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(FslIMX6State),
     .instance_init = fsl_imx6_init,
     .class_init = fsl_imx6_class_init,
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 34f302f83c..f29443948e 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -66,7 +66,7 @@ static void sabrelite_init(MachineState *machine)
                                  OBJECT(s->canbus[i]), &error_fatal);
     }
 
-    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX6_MMDC_ADDR,
                                 machine->ram);
-- 
2.56.0


