Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D69C982FB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8lrZ-0006DV-5r; Mon, 21 Sep 2026 17:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrW-0006C2-W7
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:47:47 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrV-0000Fl-8N
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:47:46 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b912e4ad9so20228915e9.2
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027264; x=1790632064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aCOuDUQQDEf2I7oG2JwN9ej8+crUFjuKJauRWBAbjB8=;
 b=P695PZYQin9nmgA9KGtqxtbcPveiSHTKb7GaNqNG7+/SU8XkiqXt6ZLq8j+OR/cd46
 GdwjEXYwrlB+GB7iRidEilYzzLbl3uOXPYkqMZKgP0quvNDxom4bmOfm7TtFvAE4DAC1
 UJNj2FBPSm+1xjU800v/KpB6QVhK16lG4AEYN0xVyIWRzBH1B9h1QIKoraTRGoYCijOW
 bYOJOzuuc2FSnJtdyoF7j8qV+60SMYwLHQMNZjQXMojY3zJ2IZywomXkl8oyFo09iAZG
 g5uvvxYayZZYuGOCaFsoiZm/3MO4H9x0RK1kJOIsKZcJK7XVMozzqaLdPE3r3H/g54nH
 zjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027264; x=1790632064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aCOuDUQQDEf2I7oG2JwN9ej8+crUFjuKJauRWBAbjB8=;
 b=mE9JEY+txj8MXGCdJbu4L//bCFJYtKpts5oQ3HeZ52gQnpFRHxVQrWKwKA062d7wUf
 xmcDMLnR19x/9j/MGL+sPizbaACGO59i1onKNGoThk9NPy+08wBNmCkjJoAEHr2cFmdn
 jSFpVEC+VEiZs1YlSuOIj3N1ZUVDO/lxV4pxfy4qH3IRNUpKjqC7KpLvrnP/SW7aMJ/Y
 Ia5aEwQv4zACARBtl+ksYjKobPBMWSgHELlq3O7WWxnaNg5KGFpVNceGdMrzap3he2Xf
 ZKbZ734DOkCLwD/ZMJkcblBx+mR9dFZuRdD2MTxuwzK0SxD1jAlBFCvHXPYF4n8UVxjh
 /ncQ==
X-Gm-Message-State: AFuF++lUw9S7t1G9BpHdHMUx740rQCu5CFZVt8kw1/sTZ0pWoGoIolnk
 cS5mCD9gRbA+vPZKWqwjAnh/GVkKBUboR5B59K+TUvc2MPNyvbD6unvCE1gdFA==
X-Gm-Gg: AYBFou0g3j3pMlz5uOq67KYZsGKAKz8ev3nmQrUd4P8hYdjTp9R2wAz7xIuam6C7B8e
 EvqDXL59yQ0HoPRrF+rxL5DxkloOgRLPMXpZyGQ2FRctvqAjYEPnpa5P2E1y5PraacYtzoLBKR1
 2aXfoCItypON94tsbeIFgiL50LjWBaRv9WPhTXC9V4zVc9DiL6aLDFbsOHIgJVrLmLNWnSEcLGH
 R0XdlXnVPglVSZgGSAKiTfUpS8fNHX7vJV5HYcoQ5EJANmlVtWiYy6/DQ0MpqD52naOJ2qwCY2E
 nxiumE534JJZbFvahgLnYzDtigN1DhACcK39XeaFWhXPlKB8jKUhf+q5bezpwi7ZLF0nwm2riMX
 G+WaSxia/Y/by6aU9Z/dRvhO7U18pRcwGtmOcoW/5Pa2VnnJj8tQea4llEGCOCyEj7aALKehamA
 e+1+SBgp76JOjazhAvthPz3RKQQMti6Uu3PceiMjYzVhL68PWKsM6+rga4fjkhKMyDXrffG1GM+
 TKO5abpgmpJ0aeArSc8+Q4FjG7KivvthqpeJf1JOXK5rsHSYQaajTNkiw1vRsi7nWqzcPFT8kDh
 VOfDOkZoDuWrKw==
X-Received: by 2002:a05:600c:4e0a:b0:49d:29ab:540b with SMTP id
 5b1f17b1804b1-49fc5723f3cmr175548485e9.15.1790027263806; 
 Mon, 21 Sep 2026 14:47:43 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:47:42 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCH 12/42] hw/arm/fsl-imx31: Derive from TYPE_SYS_BUS_DEVICE
Date: Mon, 21 Sep 2026 23:46:40 +0200
Message-ID: <20260921214710.29422-13-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921214710.29422-1-shentey@gmail.com>
References: <20260921214710.29422-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 include/hw/arm/fsl-imx31.h | 5 ++---
 hw/arm/fsl-imx31.c         | 7 +------
 hw/arm/kzm.c               | 2 +-
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/hw/arm/fsl-imx31.h b/include/hw/arm/fsl-imx31.h
index 41232a2237..ea916de15a 100644
--- a/include/hw/arm/fsl-imx31.h
+++ b/include/hw/arm/fsl-imx31.h
@@ -25,6 +25,7 @@
 #include "hw/i2c/imx_i2c.h"
 #include "hw/gpio/imx_gpio.h"
 #include "hw/watchdog/wdt_imx2.h"
+#include "hw/core/sysbus.h"
 #include "system/memory.h"
 #include "target/arm/cpu.h"
 #include "qom/object.h"
@@ -38,10 +39,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslIMX31State, FSL_IMX31)
 #define FSL_IMX31_NUM_GPIOS 3
 
 struct FslIMX31State {
-    /*< private >*/
-    DeviceState parent_obj;
+    SysBusDevice parent_obj;
 
-    /*< public >*/
     ARMCPU         cpu;
     IMXAVICState   avic;
     IMX31CCMState  ccm;
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 190f863355..dd929c1085 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -224,16 +224,11 @@ static void fsl_imx31_class_init(ObjectClass *oc, const void *data)
 
     dc->realize = fsl_imx31_realize;
     dc->desc = "i.MX31 SOC";
-    /*
-     * Reason: uses serial_hds in realize and the kzm board does not
-     * support multiple CPUs
-     */
-    dc->user_creatable = false;
 }
 
 static const TypeInfo fsl_imx31_type_info = {
     .name = TYPE_FSL_IMX31,
-    .parent = TYPE_DEVICE,
+    .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(FslIMX31State),
     .instance_init = fsl_imx31_init,
     .class_init = fsl_imx31_class_init,
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 387bf54ced..1e139c2c1f 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -69,7 +69,7 @@ static void kzm_init(MachineState *machine)
 
     object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_FSL_IMX31);
 
-    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
     /* Check the amount of memory is compatible with the SOC */
     if (machine->ram_size > (FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDRAM1_SIZE)) {
-- 
2.55.0


