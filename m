Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944B9C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 03:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raStV-0001sP-Gv; Wed, 14 Feb 2024 22:58:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lstockner@genesiscloud.com>)
 id 1raQTs-0003mx-Fh
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 20:24:04 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lstockner@genesiscloud.com>)
 id 1raQTq-0001tw-Ls
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 20:24:04 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33adec41b55so136219f8f.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 17:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=genesiscloud.com; s=genesiscloud.com; t=1707960239; x=1708565039;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vLN1S5fCgtbK/2TYTBccFlszjQjGRK+vg+aNvIu+AmU=;
 b=hqGYlxGjS+Xmz+znDOxjq57hXLfmEyPZ1HGHPALXYulq8whwWpTMQndZzUhlTvurYQ
 MjrSfzd10GNf/RJUiipCWil6S++wUEsioTKNYHcCS30WuSGgEggHB0HI/6tAL4TzxDBD
 2CTrGQti0N1sGe+cgA+xcZC9HQT/+xswyT63L+3a5lzPtLZluYWJH/uaIUojLJiOeQM1
 xkpx6YhM1pnxGFOa3X6Klqo8j08ySu7my8pui8yqkaFKs7b53dOxq+tk1PuLDRAUq8XP
 jqvp2Kevif0epg7adAoVI7DKQy5ioixyMXoT14Qs1qwnTcePKmDPmQoBNbRdF6Bm5m2m
 3vFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707960239; x=1708565039;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vLN1S5fCgtbK/2TYTBccFlszjQjGRK+vg+aNvIu+AmU=;
 b=U9CStfZPBpLaVq/n5aKbzCh7mhZHX0dLWsrZd9i21cpAJ62a/ykgHRnX6xSsyUcoHY
 LtOesLInAtD1CgTaes4uvuDWPLtDwfp82HFVTIq+h4VYIlM+gpfWwwhKRwCgISWqxz4n
 +RvsF2A52pJZ13YV5cargyKxlcSJU7A1uBox6F493tt0PZHW1CuFtSmtnawSVVIQSyA0
 FyH3wtI7jryLypfkIxh5xJhMHjYWHKI9s+YQYBmN33wFBTHhxeCNmuqWnp82Y13duDpJ
 UCAt/j0bF/AP2kgAQ58i0A4CU3OEdYZkYPO2+Fpl0tRAymLLAY8b+R3DmwR8jBXVjoeS
 jQhQ==
X-Gm-Message-State: AOJu0Ywj4L8VSehFQ+GcsgMaJiI0QKads0fn9GGH3sKWSHcNRfvoM063
 btYyl99LoZGtxh1SPjtd1wAjGIKXS2MWGjg8Hwl9ozP8kXV2tz1cVJgVEmCo2y0Qcluto1LPrYJ
 iC8f0CDpanYs7FyC/WPObKnu2VWWl6KLTmIklJrCwLhZnwQPpLWTB4c3BwQYk3djcf3ctpkzq7E
 lEeVl5m0alwv9oodBv5S1qFgIQAEf5GkuQjeGfeiBAKdHp
X-Google-Smtp-Source: AGHT+IFPLUmC5VsmK4t7kGUUiEcbunk1VqF5L/Yy+7jgHvTykQZSMLbl2vOD2ZcFt9hjtBxmJ6fd+w==
X-Received: by 2002:adf:f5c2:0:b0:33b:7b5a:49c with SMTP id
 k2-20020adff5c2000000b0033b7b5a049cmr171293wrp.40.1707960238562; 
 Wed, 14 Feb 2024 17:23:58 -0800 (PST)
Received: from localhost.localdomain (p5087a006.dip0.t-ipconnect.de.
 [80.135.160.6]) by smtp.gmail.com with ESMTPSA id
 m13-20020a5d6a0d000000b0033cf637eea2sm157689wru.29.2024.02.14.17.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 17:23:57 -0800 (PST)
From: Lukas Stockner <lstockner@genesiscloud.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Lukas Stockner <lstockner@genesiscloud.com>
Subject: [PATCH] pcie: Support PCIe Gen5/Gen6 link speeds
Date: Thu, 15 Feb 2024 02:23:26 +0100
Message-ID: <20240215012326.3272366-1-lstockner@genesiscloud.com>
X-Mailer: git-send-email 2.43.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=lstockner@genesiscloud.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 14 Feb 2024 22:58:39 -0500
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

This patch extends the PCIe link speed option so that slots can be
configured as supporting 32GT/s (Gen5) or 64GT/s (Gen5) speeds.
This is as simple as setting the appropriate bit in LnkCap2 and
the appropriate value in LnkCap and LnkCtl2.

Signed-off-by: Lukas Stockner <lstockner@genesiscloud.com>
---
 hw/core/qdev-properties-system.c | 16 ++++++++++++++--
 hw/pci/pcie.c                    |  8 ++++++++
 include/hw/pci/pcie_regs.h       |  2 ++
 qapi/common.json                 |  6 +++++-
 4 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 1a396521d5..106a31c233 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -941,7 +941,7 @@ const PropertyInfo qdev_prop_off_auto_pcibar = {
     .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 
-/* --- PCIELinkSpeed 2_5/5/8/16 -- */
+/* --- PCIELinkSpeed 2_5/5/8/16/32/64 -- */
 
 static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
@@ -963,6 +963,12 @@ static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
     case QEMU_PCI_EXP_LNK_16GT:
         speed = PCIE_LINK_SPEED_16;
         break;
+    case QEMU_PCI_EXP_LNK_32GT:
+        speed = PCIE_LINK_SPEED_32;
+        break;
+    case QEMU_PCI_EXP_LNK_64GT:
+        speed = PCIE_LINK_SPEED_64;
+        break;
     default:
         /* Unreachable */
         abort();
@@ -996,6 +1002,12 @@ static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
     case PCIE_LINK_SPEED_16:
         *p = QEMU_PCI_EXP_LNK_16GT;
         break;
+    case PCIE_LINK_SPEED_32:
+        *p = QEMU_PCI_EXP_LNK_32GT;
+        break;
+    case PCIE_LINK_SPEED_64:
+        *p = QEMU_PCI_EXP_LNK_64GT;
+        break;
     default:
         /* Unreachable */
         abort();
@@ -1004,7 +1016,7 @@ static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
 
 const PropertyInfo qdev_prop_pcie_link_speed = {
     .name = "PCIELinkSpeed",
-    .description = "2_5/5/8/16",
+    .description = "2_5/5/8/16/32/64",
     .enum_table = &PCIELinkSpeed_lookup,
     .get = get_prop_pcielinkspeed,
     .set = set_prop_pcielinkspeed,
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 6db0cf69cd..0b4817e144 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -153,6 +153,14 @@ static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
             pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP2,
                                        PCI_EXP_LNKCAP2_SLS_16_0GB);
         }
+        if (s->speed > QEMU_PCI_EXP_LNK_16GT) {
+            pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP2,
+                                       PCI_EXP_LNKCAP2_SLS_32_0GB);
+        }
+        if (s->speed > QEMU_PCI_EXP_LNK_32GT) {
+            pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP2,
+                                       PCI_EXP_LNKCAP2_SLS_64_0GB);
+        }
     }
 }
 
diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
index 4972106c42..9d3b6868dc 100644
--- a/include/hw/pci/pcie_regs.h
+++ b/include/hw/pci/pcie_regs.h
@@ -39,6 +39,8 @@ typedef enum PCIExpLinkSpeed {
     QEMU_PCI_EXP_LNK_5GT,
     QEMU_PCI_EXP_LNK_8GT,
     QEMU_PCI_EXP_LNK_16GT,
+    QEMU_PCI_EXP_LNK_32GT,
+    QEMU_PCI_EXP_LNK_64GT,
 } PCIExpLinkSpeed;
 
 #define QEMU_PCI_EXP_LNKCAP_MLS(speed)  (speed)
diff --git a/qapi/common.json b/qapi/common.json
index f1bb841951..867a9ad9b0 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -107,10 +107,14 @@
 #
 # @16: 16.0GT/s
 #
+# @32: 32.0GT/s
+#
+# @64: 64.0GT/s
+#
 # Since: 4.0
 ##
 { 'enum': 'PCIELinkSpeed',
-  'data': [ '2_5', '5', '8', '16' ] }
+  'data': [ '2_5', '5', '8', '16', '32', '64' ] }
 
 ##
 # @PCIELinkWidth:
-- 
2.43.1


