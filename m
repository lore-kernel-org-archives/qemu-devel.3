Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82349CA5FE6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 12:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDLJs-0006Y8-Nk; Sun, 04 Oct 2026 08:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLJp-0006W5-UH
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:27:54 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLJo-00079J-3S
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:27:53 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-4a0977b9c20so14482005e9.2
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 05:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791116871; x=1791721671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WO1QLb3HFgaFysjfEO4U4PmLTZSjBJoylG5DA2uYzNE=;
 b=rn6peURtIUR0TaF9RO6dn65KW8n65C8o57ZiLNwXaXgAvVa/oEmTSXnDE/PpDFZODL
 glWesbmwChX+r6bCsoYsBkDXl7qGZAoeHOFSxjO3AxvBbVQx9hyf70xjTPv9DmYI5qDx
 025ANexX9gDy+tR4yyBSle4ogKsRPqI7d6JiMGxwfYiH9v2az7Nt0vAZf1CW85iAge/K
 30TPc7jRn8wM7PbB+cV3duCn6tzVCX7QwFvCNPVzrEP56wh5Av3MFGQjjClVDCvtfpuh
 zInQiFegiPFTnpK+ui0PyRiLkfDRcdzk2oXKeL1bBe4MrtVWUUTYFApRDmolj+mCvkCm
 LBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791116871; x=1791721671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WO1QLb3HFgaFysjfEO4U4PmLTZSjBJoylG5DA2uYzNE=;
 b=jDF6EpRb11dnqJge3xlKSdNGjMCCmFuL46oSr+sFdXgUy8v/7wpHx+eQFDxqFCyCn2
 QBPBCYorEQRSiwkIcTXwPQD3hlTK4j2KWnH2QdApnw+5vjxKf3Ib00NIzixYd049QPIL
 IupKTAnYCmaMW6CFYbeYPoO0l6Xo41Ebe1274gJAmlNYN4hoaLvnIejwQXJ+46feZypZ
 ylTRVXFNamOSK23wWLpVLgSRJtGXj0J6qr7qHVrM8CeVXVpAZafiQ0kMxnoxnWtyGsRO
 oUurMzT07h2B1ZdnlzRfbkMNEm/3QE/0xvneGv4GUgBbHVm1M0iP1E9gXLB1xS7hdegG
 HhEQ==
X-Gm-Message-State: AFuF++nmHxNO6Z1/iiHt4DBzVbCAuCOCjOLPRljObUpVtKUg1HZdHsN9
 lFPBDCt5zswm0/YUIuehdIFEHU2eFz8lKEJ4OiNcFvsppkXFiMgGCOIsMCIdhw==
X-Gm-Gg: AYBFou11iguC8TcQwUeJMDLN1EH8tQoxHC2qyF2VdnrOJF4ZN5putiKTnjS7AX77nUW
 PqAHo1TMoNMfJzGSNKNkRTuI+NS1bjs7n8odOi3snx2Wnz/Sf5waCb7HIlq0P8LyDpxvWdEMukY
 fLh0+W+D/+WE3FNInwOnyvO+cvMKaNnTgr9FyM/Ylf5gJQ56h1JMDtwgDsxb6nSaAAeCMoX+m7m
 xxo7rXRSya8j+BfJ8/C43ZkajUvPGqnTsFA+t56+iKn9BWbV/lkAtv/S7KREXhUcWdryFtc4cpy
 TdsneBju++mfgztvZYAoYzE5ubJyeoYbtOZTz4D1YHhMLDV2XwiTtgzMRiLUxrFDhmQ26KNtGlU
 nl5QOpeHY8vENsj4erYzPKUkppopCNJ2lqtujB40xjT6oTHCmPdGhbFxRKeWbwNbjelghHfwY5C
 wTiU11EicHHYFcUy0Pt2aSdCUXSrNWRz+s+WbICqmnU4fgplQhBe2CZEnIa5FkVShNYEKo5DVm9
 LGqZZ/egz0pRt74mgX1zvjowYF0VtQJHFMAgDuPH94eIa/n
X-Received: by 2002:a05:600c:4e13:b0:49c:cee0:e7c1 with SMTP id
 5b1f17b1804b1-4a02757999cmr128618705e9.16.1791116870539; 
 Sun, 04 Oct 2026 05:27:50 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027698f13sm242319975e9.1.2026.10.04.05.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 05:27:49 -0700 (PDT)
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
Subject: [PATCH v2 12/30] hw/arm/fsl-imx31: Derive from TYPE_SYS_BUS_DEVICE
Date: Sun,  4 Oct 2026 14:26:28 +0200
Message-ID: <20261004122647.3913-13-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261004122647.3913-1-shentey@gmail.com>
References: <20261004122647.3913-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
2.56.0


