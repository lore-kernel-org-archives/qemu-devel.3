Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8D2C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz5V-00084n-CR; Mon, 19 Feb 2024 03:33:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz59-0006bn-3l; Mon, 19 Feb 2024 03:32:59 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz57-0002hy-E0; Mon, 19 Feb 2024 03:32:58 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d8aadc624dso30558575ad.0; 
 Mon, 19 Feb 2024 00:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331576; x=1708936376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9/uun2ht8z2zSr5QuOFbjyHW38BHeMwKID+9VW8Ltwg=;
 b=PStChGkl6cMDGQ4K3O4QArrscsCqhzR1TulUqV1NG/tpUdBCatpMHA2VcsugEdPq7M
 k0adcyOkriiK21PMs1kUguHFMQ318GKKVsa6I6OZlKIpUFlzg7pFhP+1QzlzpCmNn7eY
 ekU+Z/yBpJVCArMi/i+07g+tdOOLfuNzGfg3pgbRrxjURBAxRDkTlICWM2/1D/8Gvo/W
 h+SZgN09ZGNUGgm9WpdJcPz56KJza4WOLWPMsxx7k30PFsB72TzyvPJ/MmBpeWQh2TVi
 0PdMTHnPm5IpCD984n5NwOcpFvhRatgnjGgGamuKWIwmf/UTzgab7J3GcgE1EAyzss7/
 WhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331576; x=1708936376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9/uun2ht8z2zSr5QuOFbjyHW38BHeMwKID+9VW8Ltwg=;
 b=Q3Pw/uT5ojTjBYMi911HPY+R01qWdf0kJzDU9vDTX3Reu8vx9cGyTyosqHXnh43wuy
 OtMbl6aqD5F+L09dWOrA6EOt0S/JVarM1TTCCzHcHd0nN3ZZgNkVhlMbbFYcYU9nMs+3
 NoSN2Ou69dBXYl8udn+7G7q5j3/ONxd8S/x0FS7Rm4D+fmDPBk/+e/v11bXyLWn3AT2r
 nIQYokFVixUkc/lcN+PIQYNqGJVnjfDsNWy/k5l5XzAUXTV586sTnEd7ZUaDaqxyfPzN
 vAy7gGXO4IhOia4FYuwbymx4mH3fUTlDhn/XW1Kjm6778RPpIvqdZOcOEIdRLzbLdb8k
 ubFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHO6ZJuUlnTGhxbfo+SwmegIMbHD1TSgSYBOv11nkFNcr6mbC3Baxh3NcdGKzgoolBvCryCeV9z6oOroBOPTEs19Ou
X-Gm-Message-State: AOJu0Yw4nELinrQ+zCgEWCoAzB3W4OF1Yqcb2qfWwZi5MHtpTQ7A9lEz
 NuMOLYMBz2EnUQq8QF72fWKPtfhCSE1d6sW/7gvy+O5ePaLEtx4etHt4DEJp
X-Google-Smtp-Source: AGHT+IF1jNWSJ0hgV5VfBBeICrwaufun56EMBoG63u/zPVdd3jo8Lguonh4v+c8jSly4CTDjUfZADg==
X-Received: by 2002:a17:903:110d:b0:1d8:b51c:6b79 with SMTP id
 n13-20020a170903110d00b001d8b51c6b79mr13378138plh.7.1708331575776; 
 Mon, 19 Feb 2024 00:32:55 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:32:55 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 40/49] ppc/pnv: Wire ChipTOD model to powernv9 and powernv10
 machines
Date: Mon, 19 Feb 2024 18:29:29 +1000
Message-ID: <20240219082938.238302-41-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
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

Wire the ChipTOD model to powernv9 and powernv10 machines.

Suggested-by-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c              | 30 ++++++++++++++++++++++++++++++
 include/hw/ppc/pnv_chip.h |  3 +++
 2 files changed, 33 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index acc4db00c1..8beddb1313 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1427,6 +1427,8 @@ static void pnv_chip_power9_instance_init(Object *obj)
 
     object_initialize_child(obj, "lpc", &chip9->lpc, TYPE_PNV9_LPC);
 
+    object_initialize_child(obj, "chiptod", &chip9->chiptod, TYPE_PNV9_CHIPTOD);
+
     object_initialize_child(obj, "occ", &chip9->occ, TYPE_PNV9_OCC);
 
     object_initialize_child(obj, "sbe", &chip9->sbe, TYPE_PNV9_SBE);
@@ -1573,6 +1575,19 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     chip->dt_isa_nodename = g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc@0",
                                             (uint64_t) PNV9_LPCM_BASE(chip));
 
+    /* ChipTOD */
+    object_property_set_bool(OBJECT(&chip9->chiptod), "primary",
+                             chip->chip_id == 0, &error_abort);
+    object_property_set_bool(OBJECT(&chip9->chiptod), "secondary",
+                             chip->chip_id == 1, &error_abort);
+    object_property_set_link(OBJECT(&chip9->chiptod), "chip", OBJECT(chip),
+                             &error_abort);
+    if (!qdev_realize(DEVICE(&chip9->chiptod), NULL, errp)) {
+        return;
+    }
+    pnv_xscom_add_subregion(chip, PNV9_XSCOM_CHIPTOD_BASE,
+                            &chip9->chiptod.xscom_regs);
+
     /* Create the simplified OCC model */
     if (!qdev_realize(DEVICE(&chip9->occ), NULL, errp)) {
         return;
@@ -1685,6 +1700,8 @@ static void pnv_chip_power10_instance_init(Object *obj)
                               "xive-fabric");
     object_initialize_child(obj, "psi", &chip10->psi, TYPE_PNV10_PSI);
     object_initialize_child(obj, "lpc", &chip10->lpc, TYPE_PNV10_LPC);
+    object_initialize_child(obj, "chiptod", &chip10->chiptod,
+                            TYPE_PNV10_CHIPTOD);
     object_initialize_child(obj, "occ",  &chip10->occ, TYPE_PNV10_OCC);
     object_initialize_child(obj, "sbe",  &chip10->sbe, TYPE_PNV10_SBE);
     object_initialize_child(obj, "homer", &chip10->homer, TYPE_PNV10_HOMER);
@@ -1820,6 +1837,19 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     chip->dt_isa_nodename = g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc@0",
                                             (uint64_t) PNV10_LPCM_BASE(chip));
 
+    /* ChipTOD */
+    object_property_set_bool(OBJECT(&chip10->chiptod), "primary",
+                             chip->chip_id == 0, &error_abort);
+    object_property_set_bool(OBJECT(&chip10->chiptod), "secondary",
+                             chip->chip_id == 1, &error_abort);
+    object_property_set_link(OBJECT(&chip10->chiptod), "chip", OBJECT(chip),
+                             &error_abort);
+    if (!qdev_realize(DEVICE(&chip10->chiptod), NULL, errp)) {
+        return;
+    }
+    pnv_xscom_add_subregion(chip, PNV10_XSCOM_CHIPTOD_BASE,
+                            &chip10->chiptod.xscom_regs);
+
     /* Create the simplified OCC model */
     if (!qdev_realize(DEVICE(&chip10->occ), NULL, errp)) {
         return;
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 9b06c8d87c..af4cd7a8b8 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -2,6 +2,7 @@
 #define PPC_PNV_CHIP_H
 
 #include "hw/pci-host/pnv_phb4.h"
+#include "hw/ppc/pnv_chiptod.h"
 #include "hw/ppc/pnv_core.h"
 #include "hw/ppc/pnv_homer.h"
 #include "hw/ppc/pnv_n1_chiplet.h"
@@ -79,6 +80,7 @@ struct Pnv9Chip {
     PnvXive      xive;
     Pnv9Psi      psi;
     PnvLpcController lpc;
+    PnvChipTOD   chiptod;
     PnvOCC       occ;
     PnvSBE       sbe;
     PnvHomer     homer;
@@ -111,6 +113,7 @@ struct Pnv10Chip {
     PnvXive2     xive;
     Pnv9Psi      psi;
     PnvLpcController lpc;
+    PnvChipTOD   chiptod;
     PnvOCC       occ;
     PnvSBE       sbe;
     PnvHomer     homer;
-- 
2.42.0


