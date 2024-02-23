Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631C3C54E41
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdY0x-0005oa-3U; Fri, 23 Feb 2024 11:03:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXjw-0006Py-3g; Fri, 23 Feb 2024 10:45:32 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXjs-0006dS-Su; Fri, 23 Feb 2024 10:45:31 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dc13fb0133so7530625ad.3; 
 Fri, 23 Feb 2024 07:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703117; x=1709307917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=87BnQC30icaZczwd/UfBwrie1Am0WCArYW99YEPQzm0=;
 b=JnTyipDhHyr97HsSux+QDCgiuWYWqKvUDmaN/KCiT8Sv1x1sFZ2cqbXDXT0uwvJLQV
 JMHnrcUUW56sqSSmod2Z9kVErQ+36PjJodqj+qL0CWVayfyenN+Cn1e2SWB0YiZ5y+Aj
 Rb6ex2U3V6FCOjXgjddXpAYCvawWSzBj5jHMRvOGdkHkNCpnNPIXWQ6YstJlL7fA4sWh
 x/59b2rYLW5zCdgpe35Eqr5MO9i+pEMegRbv0Aa+kbHDu+MxrnMjoBh3FFNN0MIKSxSR
 Ry747/fa1F+FkNTDcdKqQQcPDMRjN4kzSf9dasKVLgWx23dey7U+ytPa3m00WKERJpRJ
 dj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703117; x=1709307917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=87BnQC30icaZczwd/UfBwrie1Am0WCArYW99YEPQzm0=;
 b=LfdJNSwTDw7hXRKw0zNvATTIL/xwLISg7GfQb/TgC1kH6FimT7yJ419lUEXjt6iCf8
 sUhT496OVEf8eupY62nwUbRSmW8e6jnyoWx6LDwitwNA2jdau3cOYlYGC+zeaKxYf4sZ
 hH2PN9sWV5Ty7img7Sx4lZVSN1X9wPJNzJr6pgvsl5pjsI/BB/u3jGqtUCtCYDAyzBMP
 ZS/e7VVMSrkHR9KckUUAzpDiDMB5ZoiorjKMqK080f/le+U2YsGbNYIJFMpaHW85HgH/
 FWGZRt/ADOD2uRqogY50evKVRxPg8vw9lmHkCjofWvjwa4sm9Bj8vkVY0aBvABg98MLB
 gGCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrjIEpHIQLk2PRnDPkk2QgQzddgYVQDUbB4GA7E5AiCy9NfW3wxv2dWG36LRLFoPqXStMcFnZFMSxqALXvRQAK3ngi
X-Gm-Message-State: AOJu0Yzj4WZS4JmfDwhebiLzXRIKWxso9rml/59Bo7PZ8qclUM3J/sZT
 lCAS0/BAeZgz8877FnX3VM0wB4/IwELRodjEbgXmWXZgKVQ9Vv2EipziyiS0
X-Google-Smtp-Source: AGHT+IElh1IzN3ssVTo2VyqzpZtJfdR9MYhAVtodPUopgXaiiF8HIngv+rIRvJ2awH7K9NSYkK+X6A==
X-Received: by 2002:a17:902:e80d:b0:1dc:75ea:8561 with SMTP id
 u13-20020a170902e80d00b001dc75ea8561mr221020plg.17.1708703117179; 
 Fri, 23 Feb 2024 07:45:17 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:45:17 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chalapathi V <chalapathi.v@linux.ibm.com>
Subject: [PULL 32/47] hw/ppc: N1 chiplet wiring
Date: Sat, 24 Feb 2024 01:41:51 +1000
Message-ID: <20240223154211.1001692-33-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
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


