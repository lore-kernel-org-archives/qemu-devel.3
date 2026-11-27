Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8391606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RB70fXjH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX4XS-0000J4-2V; Fri, 27 Nov 2026 17:35:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleszlucero@gmail.com>)
 id 1xX4XQ-0000HJ-3m
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 17:35:28 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleszlucero@gmail.com>)
 id 1xX4XO-0007c2-GQ
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 17:35:27 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-cd62c570b5dso5744491a12.2
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 14:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795818925; x=1796423725; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=samN5yMeNFZoQXbc3h9cu/1XtxRGiqYyHCftr86+90s=;
 b=RB70fXjHvAX8WLNa+R50lFK7kuQXotz0oMGrRkDLFr9/d2ge/wKTxI6sRKWTv4aNmg
 O4OI3sAy90TsGqD7CMG/lftcnM0L5SVzBouKKW4ANP/0NktzWi1hXB2n8v7mLY0LjHHC
 pEc1bDdDYjjFEtq36p38JeYJFjrsa07T7TAEPwd8m+e9O9wT8gWyQ0K4fkmbklOW+LL7
 uf34qvn0y5xoPPwOlQ+mdxNS3civov8nfeg5wzsu3TNiOnTa7rgRDH2GjhtMqdkgJ8nG
 ROmntEqmVUOqCHYvzx6Z2lJxBKDNg/nV7B7iKl+GezsV+hkzXWOe0YptD6DiyZjPNgLc
 mjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795818925; x=1796423725;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=samN5yMeNFZoQXbc3h9cu/1XtxRGiqYyHCftr86+90s=;
 b=KndOLQ1Xs2xpAGML4TMuQGd9FmRHIdCq6gAhIqB51lITZt4kPQ6OCuvUhSGy2JsZ77
 vJ3wE9vHzdeSNuuAMmHUHgxDVCgWmBsTkccL7H39Mqb1uQnZXo1BiluQVV2xWlt64mHL
 1ymhdiRSM5TS3/L0CbB9tY4EkoANPpHUI7WmDgBC0KYDTFdNxvrtVaBQLa3xATXzqZUW
 k5p/gI5SwDZm5G6o3tO7cYzqQJWcfpZDL8rQohHZ4Fm6JoTrwn3iHTobthbIovq6FZPX
 cUlwRrE8m5eTZcdIt/COiwqeYyFngz6H+x6R3qOqclI/zzxf8/iRkopZp2ZZmWWDtFMJ
 zh8g==
X-Gm-Message-State: APuU4Z8db87opXSYEBMXE0ac5RCsDu8dEiCCZWP+2fNLTiCDYX3ZxkVn
 1NczbycIb/bCHTXpirf1eU5uVA8k9BbunnagIX9QFdjO1FYQoNLaTbpl
X-Gm-Gg: AZFdTZeVUW4Zihm/D6wCSJbwFbxZnXQHQFYuYBGS16HLdqF+4PFdtCGszp5ZgJGuDCC
 Ue1GizspDTy9j/0rW6qhq2zUf4uA8faXBdA8dyc8TPioP0ABkNlV3l4ykwp/xQITIW+eBt7Fgei
 lYBDUO0olWnJnVU9nkhHgLYTkmdqJoYxMJ2GT0usuU4tlnd7MdNH0xkaF4lk1/6V1ee1+4rCcyG
 /8vJd49fkPUD9FWVRwdmj9DR0zTtTDkSPvxY+P7EGc0uPM1fXjjKNt/GgLUkcVUEvpCyhk2Vpbe
 RLDf8rPWuGMZ2lHUpIkL/dRYLa5MAxOBKO11bbB2MQle8yBCN8EChgEkdUoifdU6sAXBRNYWw5s
 fgT9w8pESAmA2DDqchujPDByqXch4BxTKSebbZHIjEl6KGHbDoD1R3teFIfgTXg/s4yM1OHYSTT
 OkoBfG5AV6+XvMSNuk123FlWAu0pB3cLYJBcjn5p+DHLw2A6uTKhgV0K0Zv1YYjqxnybItUhC0B
 FtuX3runpiweCl1rwFsLBCbkKwvFi4Q+9aCF2bXq6XeSiJDTBHW5EG/b27TFZ/HwZYPDkzgJHsv
 dtwYDzGsnOPmCOTvGMlrdBJplicz0uWJ78PE92TfAO/mFkwC0MnLYJDXXtooDeh+AJQrkNckBYG
 To/O+B5KaAT27bGwyZtmluY1oAbwyzfQ=
X-Received: by 2002:a17:90b:5287:b0:3b4:1ada:3c89 with SMTP id
 98e67ed59e1d1-3b41cafd797mr26020794a91.43.1795818925068; 
 Fri, 27 Nov 2026 14:35:25 -0800 (PST)
Received: from cfarm136.osuosl.org (cfarm136.osuosl.org.
 [2605:bc80:3010:104:21e:67ff:fefd:7034])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b41ad0b2c4sm39880831a91.4.2026.11.27.14.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 14:35:23 -0800 (PST)
From: =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
Date: Fri, 27 Nov 2026 22:35:15 +0000
Subject: [PATCH 1/4] hw/pci-bridge: Convert gen_pcie_downstream_port to
 Resettable interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261127-pci-bridge-resettable-v1-1-cdf15c9252c5@gmail.com>
References: <20261127-pci-bridge-resettable-v1-0-cdf15c9252c5@gmail.com>
In-Reply-To: <20261127-pci-bridge-resettable-v1-0-cdf15c9252c5@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=aleszlucero@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the deprecated device_class_set_legacy_reset() in
gen_pcie_downstream_port.c with the ResettableClass hold phase.

Signed-off-by: Oscar Alejandro Sánchez Lucero <aleszlucero@gmail.com>
---
 hw/pci-bridge/gen_pcie_downstream_port.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/pci-bridge/gen_pcie_downstream_port.c b/hw/pci-bridge/gen_pcie_downstream_port.c
index 3084a20..d7f4399 100644
--- a/hw/pci-bridge/gen_pcie_downstream_port.c
+++ b/hw/pci-bridge/gen_pcie_downstream_port.c
@@ -21,6 +21,7 @@
 #include "hw/pci/pcie_port.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
+#include "hw/core/resettable.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
 
@@ -69,14 +70,14 @@ static void gen_downstream_write_config(PCIDevice *d, uint32_t address,
     pcie_aer_write_config(d, address, val, len);
 }
 
-static void gen_downstream_reset(DeviceState *qdev)
+static void gen_downstream_reset_hold(Object *obj, ResetType type)
 {
-    PCIDevice *d = PCI_DEVICE(qdev);
+    PCIDevice *d = PCI_DEVICE(obj);
 
     pcie_cap_deverr_reset(d);
     pcie_cap_slot_reset(d);
     pcie_cap_arifwd_reset(d);
-    pci_bridge_reset(qdev);
+    pci_bridge_reset(DEVICE(obj));
 }
 
 static void gen_downstream_realize(PCIDevice *d, Error **errp)
@@ -170,6 +171,7 @@ static void gen_pcie_downstream_port_class_init(ObjectClass *klass,
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     k->config_write = gen_downstream_write_config;
     k->realize = gen_downstream_realize;
@@ -178,7 +180,7 @@ static void gen_pcie_downstream_port_class_init(ObjectClass *klass,
     k->device_id = PCI_DEVICE_ID_REDHAT_PCIE_DSP;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->desc = "PCI Express Downstream Port";
-    device_class_set_legacy_reset(dc, gen_downstream_reset);
+    rc->phases.hold = gen_downstream_reset_hold;
     dc->vmsd = &vmstate_gen_pcie_downstream_port;
     device_class_set_props(dc, gen_pcie_downstream_port_props);
 }

-- 
2.53.0


