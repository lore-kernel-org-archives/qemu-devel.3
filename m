Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D18C44501
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5eS-0004F1-2W; Tue, 07 Jul 2026 09:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5dd-00038l-Q3
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:15:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5db-0000cE-N6
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:15:01 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C94Dm3720529
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lwy62xx5wzDGhRrxw2fAL5St5JaZiBKS1EskyvV1LtM=; b=UXoEVG3ugp7Ysitr
 ZhID93rcb8iV+eYBsFwhKa2O2jeUw3r+b2SxHtkAqCjVh7rzO/YoXtQ6+przP4pq
 Hf4gmaNozTt861cm0PH743jMoABCZ2XaDw2jFrm9USbuJGMC5aA6cMDPsC3ZD0Mf
 UkTIbod2YsBTgLWy4y2jH7rz4U84BGukeVLFJoOUUfLlisjUjDpmKb4zZ/7A+noT
 HrRtGkkaAydRQkwcfQtEWCUaNfZUd/qQKJeMUVKvYloJafvXOml2SUpVdAGU4B4C
 ELa7ctEXkrpZHwRIjhUdbA/NMNgOFmzYlbFsrF4BIkgqWC2Vups/9fyTcE97NFCO
 z1c1pw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8v3t9mw2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:14:57 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1a97644aso56514361cf.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783430097; x=1784034897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lwy62xx5wzDGhRrxw2fAL5St5JaZiBKS1EskyvV1LtM=;
 b=GG6h9ji/+/bKSVujrOxmojSX+FwDqpL3lqnJUAc5lG86mGYxAevV/ptSMfaSMXRPia
 okQx6xW37SfTzUAZRd4nzk0S1ZD6sZGALxGL/hKFNPtQrGdqyZvK+JnNVB+RFVRNILN9
 ZUOFZoz9gDAKb9rjRyJAfeZQ4atZbC/HxTsBeI7fWX5Ksa3dFYhoWkBk8MDeFBIQyb0X
 bC2jzto2Sr2IujD4reccdZtpZa600cvW3eayJXlviKTIfnOby5XDbsNEIVyH3hmgIo81
 ykQ6TN7Ro0IstigChjN8XktWNTV0RBvTFfykybsUabgZtVK67tzewKwZCEARxWpN4vo5
 b10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783430097; x=1784034897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lwy62xx5wzDGhRrxw2fAL5St5JaZiBKS1EskyvV1LtM=;
 b=Fw7RLsQj8SdMXpAT+THq0nhacGJ2bh3AXL6VPTWnZRQ8653YDWPBZUWweWxUl/fs7k
 WQ+ctpyR3wztYWakCdj/N6YjfMyCN0d1/0Yszngwj67zsxYfd6WAnTj9sKdjHZ4Utt4W
 NdYL6f0/qd0k0iKAQDXkfUO5j5k5GZ7oiLd9amTD8K7qcMg6BlNertxKQUR50hY2djJx
 038+d8QtTaTEW0cJBwmpXwVgA+mpNb4JSp6dMMz8YvxcIy/6JVvf9jEw3eFW6GrDyg7Q
 bxKbeajQo9And4xb2VwT6AHr6Qp8e/VCbH92HF9yfylpq6K3aOZhv9BHJvt1GQede7FT
 IR6Q==
X-Gm-Message-State: AOJu0YxFEhPvZvFrrf0ozSnbHBdlmZ46ofcfdKEDted8G/ZA7cM5cbPC
 edQIrZLq0jwj/+Y/mf25GEZWijF4FboIhJn3sq6qnov7QBa8opU5amjgDW7lXzmhXJ26YTzT8dn
 3NrmGtaRMq9HDGeLB6IpP7s4gunS/BnNZNbEsgDD5lUZUFBBzO+8dcKwonIL8hc+iJA==
X-Gm-Gg: AfdE7clZuxEJ+WOUOzfIBqGGxX/dm/UiCASdtHR60K3NFUwktIrX7KPyFGrUO2neqsk
 lNKtxh23JS5XJ1ENxUwzR2tG5YVZouMzWQ973ME9XGnxT2Wb2FT8yOEOjeo7QT9ZH+EPpA3VS1B
 HEFPDuyh+U6CU/ALFYylD3vln2ppjO/hNApC4cqmY+9unmEkAUjkwzhWoSCYPD4iIgMHcWMPRY/
 dLJzu2hGqGMfHOYJwqcHT1iSV2ELZ4xh5QjZxo4tuKR5ZdTVbw/oUck7ZS+CKBLWXeZVMKqwBXk
 ElNzDRIWPsCDxnvUF8ij12wayh+47vhcIbs50BYpFtr+z9F8FN+lsN2Bypyw4JJqwSvNFEbjzxW
 KSUyPLtTtlm3pPnDw+ZzcZq7mawTny1i55hMHxsDE2fWuErJhskqCiAq4mSX2YQ+E+ZEx
X-Received: by 2002:a05:622a:c4:b0:51c:93b:4f1c with SMTP id
 d75a77b69052e-51c748bfcc9mr54043401cf.43.1783430096409; 
 Tue, 07 Jul 2026 06:14:56 -0700 (PDT)
X-Received: by 2002:a05:622a:c4:b0:51c:93b:4f1c with SMTP id
 d75a77b69052e-51c748bfcc9mr54042821cf.43.1783430095730; 
 Tue, 07 Jul 2026 06:14:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15b1a1011fsm114765766b.58.2026.07.07.06.14.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:14:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/32] hw/arm: Add basic FlexCAN3 support to TYPE_FSL_IMX8MP
 and imx8mp-evk
Date: Tue,  7 Jul 2026 15:12:11 +0200
Message-ID: <20260707131223.51505-22-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: si5yioxpm1vOpxZnTfmfEMnGUceW23qo
X-Proofpoint-ORIG-GUID: si5yioxpm1vOpxZnTfmfEMnGUceW23qo
X-Authority-Analysis: v=2.4 cv=HqVG3UTS c=1 sm=1 tr=0 ts=6a4cfbd1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=NiCNghgGZ4kQcQUTIdUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX8AOIksyppbJr
 azIEEw3+so/m9URSLQmFGPMoI+i0Nri3Y5Tlr5CReUhcDoj0hrCMQ6UeyE207dgEdAprqHvw+rS
 LomKMRViIuG+wY7DUTjoqQnB4tw2zhWA23hnSFxfhZoTAjdXxIPoR9Ht/tKLzMZ7GKPBo1vZKyU
 8fn6PLlkhrqATvXRSthzB3RlAC0xQ79yxCz3wyFY0HWlSZQKuTgcT1fZLBEW4R4fGvSvGs7+d3P
 ZmjVb9xut5y4UeE0L6RWcIq9K+nUs4tvBUDVIVhZJLiG74CFi2Wven68LjIwYuI2reUd2Tt+KyP
 Goxl+zdkZTm7iUMznsG2YsXKJgCntBKYaS3aFm0cMqOPUExIlN+BtB467gKS4nbd6NCeZRTWF2z
 bDEO2eOi7kXe75hEV1WUb/xBxvfrFE3pW4zRMl3+ca1lFva7AisRX7CpUrzo+/LVW/kj6NxtmHD
 sb75E0bxlwBLrbyQ4GQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX1HT7Lk7os9Zg
 plYQqgNfv9xyDqOHB/DIpaZvz0rb/oc0skuRPYbbJWHYWYoxGxjb22i/Vh1ALzsSIFVYtvGJfLv
 h2XAvliyCArRs41ierbAklZCbbFUXCU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070129
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

Real hardware supports CAN FD which is missing in the emulation and is
considered future work. Still, CAN communication already works under Linux.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: Pavel Pisa <pisa@fel.cvut.cz>
Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
Message-ID: <20260702184038.178196-6-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 docs/system/arm/imx8m.rst   |  1 +
 include/hw/arm/fsl-imx8mp.h |  8 ++++++++
 hw/arm/fsl-imx8mp.c         | 38 +++++++++++++++++++++++++++++++++++++
 hw/arm/imx8mp-evk.c         | 21 ++++++++++++++++++++
 hw/misc/imx8mp_ccm.c        |  3 +++
 hw/arm/Kconfig              |  1 +
 6 files changed, 72 insertions(+)

diff --git a/docs/system/arm/imx8m.rst b/docs/system/arm/imx8m.rst
index afbc33b2f40..1bcb8255be5 100644
--- a/docs/system/arm/imx8m.rst
+++ b/docs/system/arm/imx8m.rst
@@ -18,6 +18,7 @@ following devices:
  * 1 Designware PCI Express Controller
  * 1 Ethernet Controller
  * 2 Designware USB 3 Controllers
+ * 2 FlexCAN 3 CAN Controllers (``imx8mp-evk`` only)
  * 5 GPIO Controllers
  * 6 I2C Controllers
  * 3 SPI Controllers
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 3b6183ed1d6..2be3c51af56 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -17,6 +17,7 @@
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mp_analog.h"
 #include "hw/misc/imx8mp_ccm.h"
+#include "hw/net/flexcan.h"
 #include "hw/net/imx_fec.h"
 #include "hw/core/or-irq.h"
 #include "hw/pci-host/designware.h"
@@ -37,6 +38,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mpState, FSL_IMX8MP)
 #define FSL_IMX8MP_RAM_SIZE_MAX     (8 * GiB)
 
 enum FslImx8mpConfiguration {
+    FSL_IMX8MP_NUM_CANS         = 2,
     FSL_IMX8MP_NUM_CPUS         = 4,
     FSL_IMX8MP_NUM_ECSPIS       = 3,
     FSL_IMX8MP_NUM_GPIOS        = 5,
@@ -68,11 +70,14 @@ struct FslImx8mpState {
     USBDWC3            usb[FSL_IMX8MP_NUM_USBS];
     DesignwarePCIEHost pcie;
     FslImx8mPciePhyState   pcie_phy;
+    FlexcanState       flexcan[FSL_IMX8MP_NUM_CANS];
     OrIRQState         gpt5_gpt6_irq;
     MemoryRegion       ocram;
 
     uint32_t           phy_num;
     bool               phy_connected;
+
+    CanBusState       *canbus[FSL_IMX8MP_NUM_CANS];
 };
 
 enum FslImx8mpMemoryRegions {
@@ -279,6 +284,9 @@ enum FslImx8mpIrqs {
     FSL_IMX8MP_PCI_INTC_IRQ = 124,
     FSL_IMX8MP_PCI_INTD_IRQ = 123,
     FSL_IMX8MP_PCI_MSI_IRQ  = 140,
+
+    FSL_IMX8MP_FLEXCAN1_IRQ  = 142,
+    FSL_IMX8MP_FLEXCAN2_IRQ  = 144,
 };
 
 #endif /* FSL_IMX8MP_H */
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 7c03ed3c347..bcd91739d9b 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -246,6 +246,11 @@ static void fsl_imx8mp_init(Object *obj)
         object_initialize_child(obj, name, &s->wdt[i], TYPE_IMX2_WDT);
     }
 
+    for (i = 0; i < FSL_IMX8MP_NUM_CANS; i++) {
+        g_autofree char *name = g_strdup_printf("flexcan%d", i);
+        object_initialize_child(obj, name, &s->flexcan[i], TYPE_CAN_FLEXCAN3);
+    }
+
     object_initialize_child(obj, "eth0", &s->enet, TYPE_IMX_ENET);
 
     object_initialize_child(obj, "pcie", &s->pcie, TYPE_DESIGNWARE_PCIE_HOST);
@@ -669,6 +674,34 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcie_phy), 0,
                     fsl_imx8mp_memmap[FSL_IMX8MP_PCIE_PHY1].addr);
 
+    /* FlexCANs */
+    for (i = 0; i < FSL_IMX8MP_NUM_CANS; i++) {
+        static const struct {
+            hwaddr addr;
+            unsigned int irq;
+        } flexcan_table[FSL_IMX8MP_NUM_CANS] = {
+            {
+                fsl_imx8mp_memmap[FSL_IMX8MP_FLEXCAN1].addr,
+                FSL_IMX8MP_FLEXCAN1_IRQ
+            }, {
+                fsl_imx8mp_memmap[FSL_IMX8MP_FLEXCAN2].addr,
+                FSL_IMX8MP_FLEXCAN2_IRQ
+            },
+        };
+
+        object_property_set_link(OBJECT(&s->flexcan[i]), "clock-control-module",
+                                 OBJECT(&s->ccm), &error_abort);
+        object_property_set_link(OBJECT(&s->flexcan[i]), "canbus",
+                                 OBJECT(s->canbus[i]), &error_abort);
+
+        sysbus_realize(SYS_BUS_DEVICE(&s->flexcan[i]), &error_abort);
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->flexcan[i]), 0,
+                        flexcan_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->flexcan[i]), 0,
+                           qdev_get_gpio_in(gicdev, flexcan_table[i].irq));
+    }
+
     /* On-Chip RAM */
     if (!memory_region_init_ram(&s->ocram, OBJECT(dev), "imx8mp.ocram",
                                 fsl_imx8mp_memmap[FSL_IMX8MP_OCRAM].size,
@@ -684,6 +717,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         switch (i) {
         case FSL_IMX8MP_ANA_PLL:
         case FSL_IMX8MP_CCM:
+        case FSL_IMX8MP_FLEXCAN1 ... FSL_IMX8MP_FLEXCAN2:
         case FSL_IMX8MP_GIC_DIST:
         case FSL_IMX8MP_GIC_REDIST:
         case FSL_IMX8MP_GPIO1 ... FSL_IMX8MP_GPIO5:
@@ -715,6 +749,10 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
 static const Property fsl_imx8mp_properties[] = {
     DEFINE_PROP_UINT32("fec1-phy-num", FslImx8mpState, phy_num, 0),
     DEFINE_PROP_BOOL("fec1-phy-connected", FslImx8mpState, phy_connected, true),
+    DEFINE_PROP_LINK("canbus0", FslImx8mpState, canbus[0], TYPE_CAN_BUS,
+                     CanBusState *),
+    DEFINE_PROP_LINK("canbus1", FslImx8mpState, canbus[1], TYPE_CAN_BUS,
+                     CanBusState *),
 };
 
 static void fsl_imx8mp_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index ca0ee2d3f2e..16e9722d146 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -26,6 +26,7 @@ struct FslImx8mpEvkState {
     MachineState parent_obj;
 
     FslImx8mpState soc;
+    CanBusState *canbus[FSL_IMX8MP_NUM_CANS];
 
     struct arm_boot_info boot_info;
 };
@@ -86,6 +87,12 @@ static void imx8mp_evk_init(MachineState *machine)
 
     object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_FSL_IMX8MP);
     object_property_set_uint(OBJECT(&s->soc), "fec1-phy-num", 1, &error_fatal);
+    for (int i = 0; i < FSL_IMX8MP_NUM_CANS; i++) {
+        g_autofree char *bus_name = g_strdup_printf("canbus%d", i);
+
+        object_property_set_link(OBJECT(&s->soc), bus_name,
+                                 OBJECT(s->canbus[i]), &error_fatal);
+    }
     sysbus_realize_and_unref(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX8MP_RAM_START,
@@ -122,6 +129,19 @@ static const char *imx8mp_evk_get_default_cpu_type(const MachineState *ms)
     return ARM_CPU_TYPE_NAME("cortex-a53");
 }
 
+static void imx8mp_evk_machine_init(Object *obj)
+{
+    FslImx8mpEvkState *s = IMX8MPEVK_MACHINE(obj);
+
+    object_property_add_link(obj, "canbus0", TYPE_CAN_BUS,
+                             (Object **)&s->canbus[0],
+                             object_property_allow_set_link, 0);
+
+    object_property_add_link(obj, "canbus1", TYPE_CAN_BUS,
+                             (Object **)&s->canbus[1],
+                             object_property_allow_set_link, 0);
+}
+
 static void imx8mp_evk_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -140,6 +160,7 @@ static const TypeInfo imx8mp_evk_machine_types[] = {
         .name = TYPE_IMX8MPEVK_MACHINE,
         .parent = TYPE_MACHINE,
         .class_init = imx8mp_evk_machine_class_init,
+        .instance_init = imx8mp_evk_machine_init,
         .instance_size = sizeof(FslImx8mpEvkState),
         .interfaces = aarch64_machine_interfaces,
     },
diff --git a/hw/misc/imx8mp_ccm.c b/hw/misc/imx8mp_ccm.c
index 911911ed865..97d363e79d8 100644
--- a/hw/misc/imx8mp_ccm.c
+++ b/hw/misc/imx8mp_ccm.c
@@ -129,6 +129,9 @@ static uint32_t imx8mp_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)
     case CLK_HIGH:
         freq = CKIH_FREQ;
         break;
+    case CLK_CAN:
+        freq = 40000000; /* 40Mhz, taken from device tree */
+        break;
     case CLK_IPG:
     case CLK_IPG_HIGH:
         /*
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index f9a225c19bc..82e0bc2e700 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -601,6 +601,7 @@ config FSL_IMX8MP
     imply I2C_DEVICES
     imply PCI_DEVICES
     select ARM_GIC
+    select CAN_FLEXCAN
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
     select IMX
-- 
2.53.0


