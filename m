Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2A0CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENAK-0003oj-SE; Wed, 07 Oct 2026 04:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEIMO-0003O2-5m
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:30:51 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEILo-0006rK-TM
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:29:59 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c315869241fso332340066b.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 20:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791343773; x=1791948573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BpZ/p/gz1o4fr4QWDS/Zht3fqM3aWd0SAgwA09g8thI=;
 b=WgQS3cDRN4p/5A/lmw4g8P3hOOOwyNtEfFPWgsi7ZliNyCc3CA0L3oEfsWgJm/M/72
 3DeNDkq5Ct27GEPKSuOMFNjCuka/yRRBRFYNCpjT7r8aeI0ZEq6Ynj8lx+TIJSO0PBR7
 VdINiCVeuXZ9mfME8HM9E9AcbrZn6JDWwqfCtWvDhZ/jLGF/F5i9QoY0HDiwAMUE91NS
 16rV0+Z0U+doUuAn3e/EijBvfL+pdnJAEc3z5jS+EFm/yL0D0cBm39JjVpO5T1ysDQNS
 Aaa4eBjTZ6e6r6dohyw/NUUNKY1ZFfHOafHn134e0R9P8q28vpnE1C3dohkPV8aVNcfO
 FsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791343773; x=1791948573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BpZ/p/gz1o4fr4QWDS/Zht3fqM3aWd0SAgwA09g8thI=;
 b=jU2ZMlV1C3XqO+jTeJYRQjS+UQS+1NpPbM+CFKEzjwUyX7GSw6iRIPQe/LbqUSSof6
 5Eh7r6YisbZvPTPdooIzUu4NfomAgwQis3vD7kkVocjb/846LGGLy/eWeq/VfS3xsYm+
 2rj05y0OZP0IJ9EWBbyzGfraAcYEFhbpkNp0OSi0nlloiT+L0oZf5xbW6lJlfIMKwIyY
 sFLyerXvvMbIAD71aT9sSgaRZdPpnsfusVAGgi5osdIbpKmmpu90lVt0HTD3BpqSU8wW
 E7hy0Rlp+WdN2ZenEWGuTPKCQzWozpfOIMwp//3XFdKkTlrP9kkdpEW3FmCU+ydwIk5a
 EfJA==
X-Gm-Message-State: AFuF++lKDfitLVJDNHSG5YORZUlSceQtlibN+5p8uIjdX3CLm19v04rG
 /93tPksNO4qGU/iQo+c3ZY0vW7+AsnFjIAS2kUS5cGxWRSs/Zh301urcMw5kdg==
X-Gm-Gg: AYBFou3z+iC7bxUlso7JtW6QCdGTDnZdVmmbIldCBPHi6RL7UA/NDVnwUecnoJxDctr
 CNJ2Vdzcrm9OKY/72h+RLvVmPZ9Vx7a0Xj6Xh0UR6CjSaK80P5kfYx5SJjKeDc7x0HSfQzDOntR
 IskdtYKXRtWaxAfgTCFWN9sp8HA3m0BdCWElRuqCfbW8qOKeqC570qJa2b3T436mNoh5kPXLVU1
 8xz6+FmZjD13ZPQeyP8PmfSdwo//l3IXoqTL0bhGCsJPaXBudunTLWSmnVvfQECf9XnA5CgKyV1
 dT9iMxBEfOgp/8mPHrKAlWqVQOm1TbELcWiOy4y55ruXxsr19zdnJffO6tkKsFNf5k57oNefMgA
 G+rsuLwdbHTUcasCSdDvXce/QO1oY3mFhw5QSMC+E4VA2Ij/XlniSF6kqfpcbWuvG+ks+e+0n8F
 efZrva4qw98hBzYArMWbVf8F+ndoXEZ5utMnDn4YkqNun8veaA3+9KJfraBlZUOtMtJnKrrB5L7
 fXSaAYxm/5PvHT28AAS9UxwKdFH1AClO5dRLQ==
X-Received: by 2002:a05:6000:40cb:b0:48c:45ed:2425 with SMTP id
 ffacd0b85a97d-48c47c8ed6cmr15281700f8f.4.1791275734264; 
 Tue, 06 Oct 2026 01:35:34 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cdb281csm1566764f8f.55.2026.10.06.01.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 01:35:33 -0700 (PDT)
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
Subject: [PATCH v4 12/31] hw/arm/fsl-imx25: Derive from TYPE_SYS_BUS_DEVICE
Date: Tue,  6 Oct 2026 10:34:24 +0200
Message-ID: <20261006083445.30362-13-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006083445.30362-1-shentey@gmail.com>
References: <20261006083445.30362-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
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

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/arm/fsl-imx25.h | 5 ++---
 hw/arm/fsl-imx25.c         | 7 +------
 hw/arm/imx25_pdk.c         | 2 +-
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
index b68d4334a0..4bb4d5b3e5 100644
--- a/include/hw/arm/fsl-imx25.h
+++ b/include/hw/arm/fsl-imx25.h
@@ -29,6 +29,7 @@
 #include "hw/sd/sdhci.h"
 #include "hw/usb/chipidea.h"
 #include "hw/watchdog/wdt_imx2.h"
+#include "hw/core/sysbus.h"
 #include "system/memory.h"
 #include "target/arm/cpu.h"
 #include "qom/object.h"
@@ -45,10 +46,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslIMX25State, FSL_IMX25)
 #define FSL_IMX25_NUM_USBS 2
 
 struct FslIMX25State {
-    /*< private >*/
-    DeviceState parent_obj;
+    SysBusDevice parent_obj;
 
-    /*< public >*/
     ARMCPU         cpu;
     IMXAVICState   avic;
     IMX25CCMState  ccm;
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 7f65f4ca4b..efb22359c5 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -317,16 +317,11 @@ static void fsl_imx25_class_init(ObjectClass *oc, const void *data)
     device_class_set_props(dc, fsl_imx25_properties);
     dc->realize = fsl_imx25_realize;
     dc->desc = "i.MX25 SOC";
-    /*
-     * Reason: uses serial_hds in realize and the imx25 board does not
-     * support multiple CPUs
-     */
-    dc->user_creatable = false;
 }
 
 static const TypeInfo fsl_imx25_type_info = {
     .name = TYPE_FSL_IMX25,
-    .parent = TYPE_DEVICE,
+    .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(FslIMX25State),
     .instance_init = fsl_imx25_init,
     .class_init = fsl_imx25_class_init,
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 243c30a67e..a33050788c 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -72,7 +72,7 @@ static void imx25_pdk_init(MachineState *machine)
 
     object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_FSL_IMX25);
 
-    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
     /* We need to initialize our memory */
     if (machine->ram_size > (FSL_IMX25_SDRAM0_SIZE + FSL_IMX25_SDRAM1_SIZE)) {
-- 
2.56.0


