Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4A6CA5FED
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 01:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEGYE-0004Tg-6n; Tue, 06 Oct 2026 21:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEFOD-0001xg-Nh
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 20:20:39 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEFNq-0001pY-S3
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 20:19:58 -0400
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c2e69aa07c3so496556566b.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 17:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791332230; x=1791937030; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jxr6Z/nV68ZRXh1gyO1ohVQUm+zuc0cqi2mtEVuqXoY=;
 b=rVTHGsyarCssk1Ht310PEKHmdkIDRtvStBQRdOa4ritZp+iDOblT86gkK+4AyMveS3
 oHL7+uAFo12RQJuUTQcHO5QHslZoB2xmVynrS/xt5DoFqR5Ngr3OCemxSd9HDTrelN97
 c12Q4DQtiNWs/VEkHFrfloVVjp5fyYUIhZehcs1boao/utgF2mlh0BgmwdeMzDinFkhq
 OnL8+c+TRv6M2dGIUPrycH2VCXFBnotwVO12gM7eSpLZMEFxjFNqTXXBRR04grQQfir3
 nEeaxRJ5yusNWR0fnggE8iWBn6b4B2F9adDhv4GrPPn13BdghWVI/Ii5vXQDbvVbYg+f
 u5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791332230; x=1791937030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jxr6Z/nV68ZRXh1gyO1ohVQUm+zuc0cqi2mtEVuqXoY=;
 b=JBxhJ64sNeo/kIIbqO89d2k/B57LeT7fGaEHGzDZX6adiM4Tu6oKoWl3MKXSKt+VmZ
 GOiF6FZGiY7gxhKDgOZLm9vi7YfQzFlV9xbr9zqL8Z0x+Xydaq226MPmRYIX5ktbain3
 42SUAzhDdkn3+Lq0UAvsVj9EHzU7DifAU1P8OFdGOPyRjblSZw0uOmkFa7fJmi8xnoyo
 jM9l5h+6qgJAaI/16ecnCjBX4VLoqEzKQrR1NB89Y/uiR6R76Ofoq1P5zH5GZ8CSkO4u
 n1ZUpopXhGXd1q2ZiBWl46MSF3yzRisEH4NoljS0CDg0GYv+EHDAQPQnsCiE9AYxyFBW
 pcXg==
X-Gm-Message-State: AFuF++kq47WpAG5wAWkvk+avhBDKzJegiVooNTwuHYwbQ0TW8RL3/A/b
 kWYqotAJa/2FBJRI5B44RmnRFbX0+bLAarq/b69lVGtiU68JbX6SuaWQWR1xwA==
X-Gm-Gg: AYBFou1DrE+m+XIxjfMcnl6ht3G6F8uxpopm4DimtLJHmzrb2ka6SiHyqR+J/AUE7wk
 NtI/ls63fRI3Arq4eP3zbJGyTYnROW52AGBcY9R1qWFbgLDGHoShixQsLCfXHIIfqe96gbidplC
 oigiT+jS48p5FOKC1sMens3YZGwpCzmg3DfZ/Ojo8rzyIV8FRmZ6t2w/ZPRbtPNdysqmY+B/I1x
 IKuhNzL1eWz1Mz/OFO9aNKabeViX06QS/Uf77UIYMWxS0syCO81tYm0JNWlRRr0jVKfXP6Wl3lb
 tgVXgHMnB6KUzzXbD7kTrkJ7D0cBVht0boyWY9JwYVFlhvhuFWmaXbencl6PWbUORlnQPocpNqR
 fS4Lhlc0yMT7wBIMYy0xg1sGA1laVHWelbXLoB8x0TTtnyJzdUfIRvyaT8wTbqfZjzNL/vuzsVG
 h5U/tJJrVijMg39lqU3eDcMb0+8k9ndoSGAqLAvISVRlgaXBs9aKQnmQp5klSskwvzpSMZXLW7a
 uk7DaNtmWDqQnc24fYFsr1qR4iMgXfJZ9wYDQdk1iuw3Xg5
X-Received: by 2002:a05:6000:41c5:b0:488:5c28:94d0 with SMTP id
 ffacd0b85a97d-48c6d15fb06mr1276000f8f.19.1791275736591; 
 Tue, 06 Oct 2026 01:35:36 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cdb281csm1566764f8f.55.2026.10.06.01.35.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 01:35:36 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 14/31] hw/arm/fsl-imx6: Derive from TYPE_SYS_BUS_DEVICE
Date: Tue,  6 Oct 2026 10:34:26 +0200
Message-ID: <20261006083445.30362-15-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006083445.30362-1-shentey@gmail.com>
References: <20261006083445.30362-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.54; envelope-from=shentey@gmail.com;
 helo=mail-ej1-f54.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Bin Meng <bin.meng@processmission.com>
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
index 34f302f83c..201766d8ea 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -66,7 +66,7 @@ static void sabrelite_init(MachineState *machine)
                                  OBJECT(s->canbus[i]), &error_fatal);
     }
 
-    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX6_MMDC_ADDR,
                                 machine->ram);
-- 
2.56.0


