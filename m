Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA323CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:43:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENBE-0008J4-0Y; Wed, 07 Oct 2026 04:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEIVe-0004e4-GU
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:40:14 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEIVU-0000hy-Kw
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:39:54 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c2dc63f8d8aso211134766b.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 20:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791344349; x=1791949149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tmb1LvWJuEGSfnKPDPWmN7ZvXQwtZpUegBkNdwPgjrQ=;
 b=elMF88UGNZ49+BOnM9iHNDLkiLrD6ArI7LF+V7c3+y9mjr9ioOpBkD2uGTF2Pu8/J8
 kFdCT95YqY4jOc7qvyYI9zwvcBiiBirLF4Tcgx5iHNBlKB3F0En4fRG+AqKuVmJ1eUXC
 jc9qm0txcRdJlnNmQFByy/AR4H0CFBs3l+6LLweiKJ6DdQfNx4c6laKYAozeJHXPLyPw
 s0Va79627+bh/T56CoZaCK6XiqNmQdpfWYto8gFaAODzrJFbNmxxWx74k7nN7VGB2kzA
 GPWCt3uERpJJcgXWfvdfdz84d+Dypinl02y4VlWuneRc89oQAzZLea8fCfMiyv7dIXuA
 B6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791344349; x=1791949149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tmb1LvWJuEGSfnKPDPWmN7ZvXQwtZpUegBkNdwPgjrQ=;
 b=cZk0j1i6KuL4YrYoc4XQStdOnugH74upJUoqNt7opgty1C5xC3TAsn0/tkQgbr8doA
 TDwMCGJgLZ+PUz/8bR5GC+lb8F/89AgAeI8VSjLoyzl51Ko14l+RqLbE9Iuu7DPPbNsX
 zb/VkCHq4fUNnk0/IR3TwclhiANGVyimT9urzvHaGTzdY+AVq0NW/m9NfjmOLASaO7HV
 4MYf3mZuRcc+j6PAaboi2MWAfGS07q241eUvk4ROj72R61Y5WJu6dqPQi9lAw6ze91Dv
 1nq58/5+FMXlWYx5C3vgZBLHhS9vf8sfTStN+LXhZwmtc1lA1IY1gJ65+XzGhvLIeQ/6
 jQUQ==
X-Gm-Message-State: AFuF++mg3VOb2/kq8rXjyUGRZNSbD6JGPfhz6F7MhVi4C4Ummm1MVnB+
 qrI2850wTyy1L9KdJNF5YWXj+EP9tfVtAy3Apr2mC8VcxizKjBWNPkQIs1zm6w==
X-Gm-Gg: AYBFou3Snbr+hulhXGmpfP5O6svrR3qZjyaOF8PusXOuuxB8qHuGoaAcUnoZgRqkSFV
 ZrRtiCGf3NZoAVC6PGB6oRg8MMI9s5bDMG2M5TyBew9rzyZLVIMhA8HhUJSiwKjN/w51Q/Dkwex
 Fol36ZbDn1zb9z1qwCkbFbTktBIK002wSkspZ1+WHVk01tKERhB+qPzqfkm9o5XXxN9YjBptPMZ
 xBYbjygC3wXK7b5bSV1Jp3qLEj8DgZLTj9jeoQLzxCYxL5vehlS7HLibQv2Lqoj7p0aYxabDqv6
 FqlzM2EAluGfeFyFBzYM929UxcWAQKGuVwR2q99rEHBX28o0y2bFq8qdvBxYeLyV2qAQ4Nt5r0k
 NzZUQLL0YW3SRFXY+ORvE8OR/bv+6GCa63djODFG5yJBbQxB57Mq391b/S7qYIImv+HuYqelh+m
 LNx/gx2yoQTEMD/eG69iNqNOeDQcH6nOjB+9o6d5aFKH+sqiOgfcshfaRLgNTAgIHs4lFp9NJrv
 KqTxC4Y1l580ad+d60UQaSwQcFBxOrUvTV1gg==
X-Received: by 2002:a5d:6f0a:0:b0:48c:4ca2:6218 with SMTP id
 ffacd0b85a97d-48c6d177135mr1221944f8f.27.1791275737800; 
 Tue, 06 Oct 2026 01:35:37 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cdb281csm1566764f8f.55.2026.10.06.01.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 01:35:37 -0700 (PDT)
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
Subject: [PATCH v4 15/31] hw/arm/fsl-imx6ul: Derive from TYPE_SYS_BUS_DEVICE
Date: Tue,  6 Oct 2026 10:34:27 +0200
Message-ID: <20261006083445.30362-16-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006083445.30362-1-shentey@gmail.com>
References: <20261006083445.30362-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 include/hw/arm/fsl-imx6ul.h | 5 ++---
 hw/arm/fsl-imx6ul.c         | 4 +---
 hw/arm/mcimx6ul-evk.c       | 2 +-
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 6205fe6b77..9ae0488990 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -18,6 +18,7 @@
 #define FSL_IMX6UL_H
 
 #include "hw/cpu/a15mpcore.h"
+#include "hw/core/sysbus.h"
 #include "hw/misc/imx6ul_ccm.h"
 #include "hw/misc/imx6_src.h"
 #include "hw/misc/imx7_snvs.h"
@@ -64,10 +65,8 @@ enum FslIMX6ULConfiguration {
 };
 
 struct FslIMX6ULState {
-    /*< private >*/
-    DeviceState    parent_obj;
+    SysBusDevice   parent_obj;
 
-    /*< public >*/
     ARMCPU             cpu;
     A15MPPrivState     a7mpcore;
     IMXGPTState        gpt[FSL_IMX6UL_NUM_GPTS];
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 1863558a0d..84451c9909 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -730,13 +730,11 @@ static void fsl_imx6ul_class_init(ObjectClass *oc, const void *data)
     device_class_set_props(dc, fsl_imx6ul_properties);
     dc->realize = fsl_imx6ul_realize;
     dc->desc = "i.MX6UL SOC";
-    /* Reason: Uses serial_hds and nd_table in realize() directly */
-    dc->user_creatable = false;
 }
 
 static const TypeInfo fsl_imx6ul_type_info = {
     .name = TYPE_FSL_IMX6UL,
-    .parent = TYPE_DEVICE,
+    .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(FslIMX6ULState),
     .instance_init = fsl_imx6ul_init,
     .class_init = fsl_imx6ul_class_init,
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 4964cb9345..53d221b4a9 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -44,7 +44,7 @@ static void mcimx6ul_evk_init(MachineState *machine)
     object_property_set_uint(OBJECT(s), "fec2-phy-num", 1, &error_fatal);
     object_property_set_bool(OBJECT(s), "fec1-phy-connected", false,
                              &error_fatal);
-    qdev_realize(DEVICE(s), NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX6UL_MMDC_ADDR,
                                 machine->ram);
-- 
2.56.0


