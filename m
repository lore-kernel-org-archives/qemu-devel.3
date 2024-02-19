Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F2FC48260
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz5M-00076Q-8a; Mon, 19 Feb 2024 03:33:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz4l-00062d-IH; Mon, 19 Feb 2024 03:32:37 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz4j-0002fw-Ej; Mon, 19 Feb 2024 03:32:35 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d93edfa76dso21959135ad.1; 
 Mon, 19 Feb 2024 00:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331550; x=1708936350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=izQHDyxI0SrmzhG+cCsYYjyqRqLh5CS7IY3dpRHr3vY=;
 b=AnHkZVOOwOO10c+lf9GD2a1dpHbgOIMyecEZSWXA+xbUTNpo5nxTtpG3x5wU/jT73r
 4a9f9e1f9BAsmLKK7gd9QNj7AHDdXnNHxUTiNEzewxUagsYUvxwm45FbPSt58BmKGr7O
 xzRhkZVtKV8Xwprhuzi7eU2cix5HHRwpD+fjQC3fwiiaXM+Pw/VSmCzQa+GkYajU4CO/
 hZu7Kvnip28qtVy//lMa7Zh5fdN78W9WSRc04GH2SA1x5JjlyaWI5zwed66Ybbf29Qn9
 VwThhi4avfiOR8IyV+GGIZbPCIY8OoJr1ScEWH19TTJJ+OZNpnd6tG2TJfQlG54m3ZiA
 vP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331550; x=1708936350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=izQHDyxI0SrmzhG+cCsYYjyqRqLh5CS7IY3dpRHr3vY=;
 b=bAXatekcBv+At7NVZpflT9OYYu/CfNn+o/Xhba3Rc/a3+Yw1JwsrCBpryLT2AIZMIN
 y4jnxF3gDP76bldUSW5NxnbZX1yzHNyGmS2uV4LGwwt0DjhPEPMLw1YMGn5hbQdN8jre
 DjANbw3FrfSyPkW1XnQQj4CTuqlnKJDle9DnWJAzzBINZw78ToY21XiFbL5E0BT+A2ez
 NhIrKkGBptf610xBIJVmgGomRk7jzvejX3kJVvStkBDNApNruIDsxHddkE+4G542QOT7
 sSn63yw+9dkt2Vp/ar6GCYJkZXq1E+/TXZdDmVDhNOvaflSVje378dTFwdDVDRq5ldRi
 d4jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHRJvn0JcmraZ3/A2elCQsZ0mo+TRbzjuFuuNEsoJEshZxGvKWzBy6bFqXAOcF/fFgYNjVec7SPnGoT4+EV5b7FK+e
X-Gm-Message-State: AOJu0YxTISQwF1bD/LMih/udNr6ty5RsfFR5nlNZZKPDNF8WM8xdm81C
 grPGeWzWp8cvfurKPF4LpF+d/Un66s9D00jpkUVspr1vOkTcUO4WF05KK1aY
X-Google-Smtp-Source: AGHT+IHLKlo7YJcfyZZWJ0ISnCZqUTRDBmGrpQ7D3Cy0EU5PlSwYItJFGXSXIwwg4HfV+HxFxzMCOg==
X-Received: by 2002:a17:902:cec2:b0:1db:4941:f703 with SMTP id
 d2-20020a170902cec200b001db4941f703mr14332151plg.15.1708331550237; 
 Mon, 19 Feb 2024 00:32:30 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:32:30 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chalapathi V <chalapathi.v@linux.ibm.com>
Subject: [PULL 34/49] hw/ppc: N1 chiplet wiring
Date: Mon, 19 Feb 2024 18:29:23 +1000
Message-ID: <20240219082938.238302-35-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Chalapathi V <chalapathi.v@linux.ibm.com>

This part of the patchset connects the nest1 chiplet model to p10 chip.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c              | 15 +++++++++++++++
 include/hw/ppc/pnv_chip.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 0755fab155..acc4db00c1 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1688,6 +1688,8 @@ static void pnv_chip_power10_instance_init(Object *obj)
     object_initialize_child(obj, "occ",  &chip10->occ, TYPE_PNV10_OCC);
     object_initialize_child(obj, "sbe",  &chip10->sbe, TYPE_PNV10_SBE);
     object_initialize_child(obj, "homer", &chip10->homer, TYPE_PNV10_HOMER);
+    object_initialize_child(obj, "n1-chiplet", &chip10->n1_chiplet,
+                            TYPE_PNV_N1_CHIPLET);
 
     chip->num_pecs = pcc->num_pecs;
 
@@ -1857,6 +1859,19 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(), PNV10_HOMER_BASE(chip),
                                 &chip10->homer.regs);
 
+    /* N1 chiplet */
+    if (!qdev_realize(DEVICE(&chip10->n1_chiplet), NULL, errp)) {
+        return;
+    }
+    pnv_xscom_add_subregion(chip, PNV10_XSCOM_N1_CHIPLET_CTRL_REGS_BASE,
+             &chip10->n1_chiplet.nest_pervasive.xscom_ctrl_regs_mr);
+
+    pnv_xscom_add_subregion(chip, PNV10_XSCOM_N1_PB_SCOM_EQ_BASE,
+                           &chip10->n1_chiplet.xscom_pb_eq_mr);
+
+    pnv_xscom_add_subregion(chip, PNV10_XSCOM_N1_PB_SCOM_ES_BASE,
+                           &chip10->n1_chiplet.xscom_pb_es_mr);
+
     /* PHBs */
     pnv_chip_power10_phb_realize(chip, &local_err);
     if (local_err) {
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 0ab5c42308..9b06c8d87c 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -4,6 +4,7 @@
 #include "hw/pci-host/pnv_phb4.h"
 #include "hw/ppc/pnv_core.h"
 #include "hw/ppc/pnv_homer.h"
+#include "hw/ppc/pnv_n1_chiplet.h"
 #include "hw/ppc/pnv_lpc.h"
 #include "hw/ppc/pnv_occ.h"
 #include "hw/ppc/pnv_psi.h"
@@ -113,6 +114,7 @@ struct Pnv10Chip {
     PnvOCC       occ;
     PnvSBE       sbe;
     PnvHomer     homer;
+    PnvN1Chiplet     n1_chiplet;
 
     uint32_t     nr_quads;
     PnvQuad      *quads;
-- 
2.42.0


