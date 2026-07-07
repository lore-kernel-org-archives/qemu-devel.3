Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5BDC44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1Ma-0002b9-Lb; Tue, 07 Jul 2026 04:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh1MZ-0002as-2y
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:41:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh1MX-00053c-7c
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:41:06 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678E5Y53004604
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 08:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2PrtTchkiaMLVoRaRhlvGrK0wQefz5PSkzIVWf2IOWw=; b=k5llsevJa6K2dy6b
 4qr8E+U6z+OW972jFvZzkz4VcELdq9+es32yx7Wx3TyLltCaHeeKoi2hGHZKPbEW
 SkfFD19cddIxFHAULuwGjYce7VZ5lmj84FmYnJDib+NasRiXsNHSY0YVWOiAlKUX
 PDDEeEw5iUERZBIHhVmG+aEV12WS7yyMQgnjX+2qVJKeKz8aigzJxyjz8Iy9KiSp
 JMrxBlIbtDR6Lcwl5s1h61Qpmn72P8qAFVjdblHYOim6ZOwNUGTWPVwA4BUcqDp+
 uCoM4OOab9LNBEumKQbQrfE9FSLLR7J8Ivn7lMuqlvbNbzwjvJeslzInsXs9wbf4
 WSuy1w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8su71192-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 08:41:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1d137a68so93285551cf.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 01:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783413663; x=1784018463; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2PrtTchkiaMLVoRaRhlvGrK0wQefz5PSkzIVWf2IOWw=;
 b=S7Bbb4wBfZ2fOAleg1RmYwk+wckI+CLC+PfPUjS5opsjKi8P5skTAC9JcUTG2UIh25
 ZWRhfnKQ0br9s0WfMKXk0xwW6+ZO6BFoqo3CrcuePCENn62IFFJjFNHI+gCX2SE6FV/L
 VuudUDf37NWpB5JqQ7xLN3sFbY6Pur1XVOicul8vaeJVO8npdSDGGzC3R2pIZvQCOp5B
 /YoWk3mbl+W/QiGLHMQkjG4ub63MW/sYK1idi6RpH0Nd7ZjvJE2x7TLOJy/vARFLqie2
 0rRLwQ8XxMkfGAj+8CIYFnq6jUS9FqCI5IK1kXdKNyFp5U2Esnpp6nIwpbsCgU6khD4Q
 w+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783413663; x=1784018463;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2PrtTchkiaMLVoRaRhlvGrK0wQefz5PSkzIVWf2IOWw=;
 b=ntwtoUL5n4b60nKx3h1nTz1dNNcpOQcgMUfydF0rQLLnnOPta4PxOLfLFPEQ6BNqqC
 hPFcquL226TU6rgNYQ2WSA7PXKn79mEYdGs9GJUuaSgD5LAkriPAOq/+CtoYSNxa6tIV
 r0ZK5sLUtrN4iGJ9T1QQNRM7c4kePY62ftX0O6A/ueJZ24QU1oDPMUYLT72aUgZhLdHy
 bGqDsUOnlYRItj7nXfMkSTy0AkZnENWPP5ATx/apgVwPcqSrULXLAifp+ktuRW9i6v8k
 jZ3uC8Xbqk73k2Y5I9/CEWMInKs3xKX6Wyud8Q7wWTooUdlVDYiDqT+PQ4dMTGAQfPJq
 E5hA==
X-Gm-Message-State: AOJu0Yx7d6mCpgma2akhFihCOVn3vdoVhdZ1WgYBnS3pyc4LHmwWLScd
 eu+f9mgxOwJrV3u3bw6jfIaK1Z2nPptpKmwwbXiGcqin+nPyXN9eNi5bv5JGrULahK85HTT/Sy6
 SKXukJ/UzxsrwqooK1QIgM28eiMZPuQ+yepaAyr/WC/Kmju1z6+Wv+6DeDxlQQYk+SQ==
X-Gm-Gg: AfdE7cmpATudrKQ29Q49SSRXyqCHzMD0IBjKIpAsROKM9U3QA9iU0QXfPJ6f35hDMvs
 BjpbOTpJQXEl4QkseTaCgGDveAvmz6/mANP9uMrQvR9bgWKdacUhgseQRqSy/s8PEfcoLAUHFuL
 22eepULbgrh90uCeZYovR6uW7fec11ZC9P+IP43RpuA9zJw2V7l5Lkz83WMmn0+WBuveV4ByxB/
 IKUbe66foUYStPamvrITlBWq7aze9tPZmaXpD6X+LOS4ybQBfyeffULRAdGDL7c9ppOCmlL4ohz
 p7v6z9ABugGjMWFkVJX3pD3D8I6Un0Zrn3znU//UbTknn6wuarwPAHcQqKmSdtIx5wyzVj4jWea
 pQu8+ZVCSKGA2VRRDzSPKTbFHs2NcvKIDNDGn9adk0Yv35szec46r5gc4JxgU08Vwtb0J
X-Received: by 2002:a05:622a:3c6:b0:51c:c67:2042 with SMTP id
 d75a77b69052e-51c748af0f5mr45896041cf.53.1783413662597; 
 Tue, 07 Jul 2026 01:41:02 -0700 (PDT)
X-Received: by 2002:a05:622a:3c6:b0:51c:c67:2042 with SMTP id
 d75a77b69052e-51c748af0f5mr45895731cf.53.1783413661870; 
 Tue, 07 Jul 2026 01:41:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e01c9faesm30795555e9.1.2026.07.07.01.40.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 01:41:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 1/3] hw/pci: Have various pci_bus*() methods take a const
 PCIBus argument
Date: Tue,  7 Jul 2026 10:40:48 +0200
Message-ID: <20260707084050.32137-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707084050.32137-1-philmd@oss.qualcomm.com>
References: <20260707084050.32137-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA4MyBTYWx0ZWRfX3yXw9MGi5jN0
 +JzolhXePN2t8CSCU/NTRQwDAnSUslSGEnT6CjEXcqtciHVpiEtW0qKzIQDL7syJM+p2G6BXffz
 vryMp064fx0vUi9V2zX76LY7h4y0SeiAecJ2THG56xAITXv+9I6u+WWwldwRoErq3mkKdmAzJPm
 WunF6NP8fY/+ULDq/orbU778ZhS5C2N3pkhHc2ruqn5RGEIzXum09WRQ/ZXvXlpkIYJTkh0kjW+
 Ei4iJZ5U+lgB1ck/D12BpSlt4LTEOwv+Ln3doSwrOSdNIrDN+kqeA5Qx13fRkzYjK3I2B+5gBy/
 Fng4wFA3o4kzmEzMgEcQn+2g91CwN7e1u15yUPGegxmSUiCP8B8TduvhSddy51+gwXA8nWtEs+l
 D4Mk5NXz0CXtXflw4j38pcmnis8KNfnGLnwyn3e3qtB8ZQYMSS0PE6RqLjqsXiKT2yTuJGon35v
 kw+CkDa0PS4vJGTPHfQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA4MyBTYWx0ZWRfX4669tltuSZ6d
 Ye6GU0xELngenT65OVi+G+JbrGNawWzeLvuSb/HdfYQ0uJ+viH28UXyiu3e+X6LyHAvHtux1GxF
 xEE0VK6/aQtC4ckpCez5joikvXF/rgg=
X-Proofpoint-GUID: ROu-s_4wtN8HV3EQY9KUVbdXrVXn50bp
X-Proofpoint-ORIG-GUID: ROu-s_4wtN8HV3EQY9KUVbdXrVXn50bp
X-Authority-Analysis: v=2.4 cv=HN7z0Itv c=1 sm=1 tr=0 ts=6a4cbb9f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=pcy3yKBqEULjKRPBAkEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070083
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Mark the PCIBus pointer argument const when methods
don't need to update the structure referenced.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/pci/pci.h                | 10 +++++-----
 include/hw/pci/pci_bus.h            | 10 +++++-----
 hw/pci-bridge/pci_expander_bridge.c |  4 ++--
 hw/pci/pci.c                        | 18 +++++++++---------
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index f2448e941a0..f05d4d867b4 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -308,8 +308,8 @@ void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_irq,
                   void *irq_opaque, int nirq);
 void pci_bus_map_irqs(PCIBus *bus, pci_map_irq_fn map_irq);
 void pci_bus_irqs_cleanup(PCIBus *bus);
-int pci_bus_get_irq_level(PCIBus *bus, int irq_num);
-uint32_t pci_bus_get_slot_reserved_mask(PCIBus *bus);
+int pci_bus_get_irq_level(const PCIBus *bus, int irq_num);
+uint32_t pci_bus_get_slot_reserved_mask(const PCIBus *bus);
 void pci_bus_set_slot_reserved_mask(PCIBus *bus, uint32_t mask);
 void pci_bus_clear_slot_reserved_mask(PCIBus *bus, uint32_t mask);
 bool pci_bus_add_fw_cfg_extra_pci_roots(FWCfgState *fw_cfg,
@@ -345,14 +345,14 @@ static inline PCIBus *pci_get_bus(const PCIDevice *dev)
 {
     return PCI_BUS(qdev_get_parent_bus(DEVICE(dev)));
 }
-int pci_bus_num(PCIBus *s);
-void pci_bus_range(PCIBus *bus, int *min_bus, int *max_bus);
+int pci_bus_num(const PCIBus *s);
+void pci_bus_range(const PCIBus *bus, int *min_bus, int *max_bus);
 static inline int pci_dev_bus_num(const PCIDevice *dev)
 {
     return pci_bus_num(pci_get_bus(dev));
 }
 
-int pci_bus_numa_node(PCIBus *bus);
+int pci_bus_numa_node(const PCIBus *bus);
 void pci_for_each_device(PCIBus *bus, int bus_num,
                          pci_bus_dev_fn fn,
                          void *opaque);
diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
index c7384467888..7a3f2e4dde9 100644
--- a/include/hw/pci/pci_bus.h
+++ b/include/hw/pci/pci_bus.h
@@ -15,8 +15,8 @@ struct PCIBusClass {
     BusClass parent_class;
     /*< public >*/
 
-    int (*bus_num)(PCIBus *bus);
-    uint16_t (*numa_node)(PCIBus *bus);
+    int (*bus_num)(const PCIBus *bus);
+    uint16_t (*numa_node)(const PCIBus *bus);
 };
 
 enum PCIBusFlags {
@@ -58,17 +58,17 @@ struct PCIBus {
     Notifier machine_done;
 };
 
-static inline bool pci_bus_is_cxl(PCIBus *bus)
+static inline bool pci_bus_is_cxl(const PCIBus *bus)
 {
     return !!(bus->flags & PCI_BUS_CXL);
 }
 
-static inline bool pci_bus_is_root(PCIBus *bus)
+static inline bool pci_bus_is_root(const PCIBus *bus)
 {
     return !!(bus->flags & PCI_BUS_IS_ROOT);
 }
 
-static inline bool pci_bus_allows_extended_config_space(PCIBus *bus)
+static inline bool pci_bus_allows_extended_config_space(const PCIBus *bus)
 {
     return !!(bus->flags & PCI_BUS_EXTENDED_CONFIG_SPACE);
 }
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 40ffbc4e082..f981c47edee 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -68,14 +68,14 @@ bool cxl_get_hb_passthrough(PCIHostState *hb)
     return host->passthrough;
 }
 
-static int pxb_bus_num(PCIBus *bus)
+static int pxb_bus_num(const PCIBus *bus)
 {
     PXBDev *pxb = PXB_DEV(bus->parent_dev);
 
     return pxb->bus_nr;
 }
 
-static uint16_t pxb_bus_numa_node(PCIBus *bus)
+static uint16_t pxb_bus_numa_node(const PCIBus *bus)
 {
     PXBDev *pxb = PXB_DEV(bus->parent_dev);
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index d3191609e28..b04e94a150b 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -225,7 +225,7 @@ static void pci_bus_unrealize(BusState *qbus)
     vmstate_unregister(NULL, &vmstate_pcibus, bus);
 }
 
-static int pcibus_num(PCIBus *bus)
+static int pcibus_num(const PCIBus *bus)
 {
     if (pci_bus_is_root(bus)) {
         return 0; /* pci host bridge */
@@ -233,7 +233,7 @@ static int pcibus_num(PCIBus *bus)
     return bus->parent_dev->config[PCI_SECONDARY_BUS];
 }
 
-static uint16_t pcibus_numa_node(PCIBus *bus)
+static uint16_t pcibus_numa_node(const PCIBus *bus)
 {
     return NUMA_NODE_UNASSIGNED;
 }
@@ -411,7 +411,7 @@ static void pci_change_irq_level(PCIDevice *pci_dev, int irq_num, int change)
     pci_bus_change_irq_level(bus, irq_num, change);
 }
 
-int pci_bus_get_irq_level(PCIBus *bus, int irq_num)
+int pci_bus_get_irq_level(const PCIBus *bus, int irq_num)
 {
     assert(irq_num >= 0);
     assert(irq_num < bus->nirq);
@@ -781,13 +781,13 @@ void pci_unregister_root_bus(PCIBus *bus)
     pci_root_bus_cleanup(bus);
 }
 
-int pci_bus_num(PCIBus *s)
+int pci_bus_num(const PCIBus *s)
 {
     return PCI_BUS_GET_CLASS(s)->bus_num(s);
 }
 
 /* Returns the min and max bus numbers of a PCI bus hierarchy */
-void pci_bus_range(PCIBus *bus, int *min_bus, int *max_bus)
+void pci_bus_range(const PCIBus *bus, int *min_bus, int *max_bus)
 {
     int i;
     *min_bus = *max_bus = pci_bus_num(bus);
@@ -802,7 +802,7 @@ void pci_bus_range(PCIBus *bus, int *min_bus, int *max_bus)
     }
 }
 
-int pci_bus_numa_node(PCIBus *bus)
+int pci_bus_numa_node(const PCIBus *bus)
 {
     return PCI_BUS_GET_CLASS(bus)->numa_node(bus);
 }
@@ -1304,17 +1304,17 @@ uint16_t pci_requester_id(PCIDevice *dev)
     return pci_req_id_cache_extract(&dev->requester_id_cache);
 }
 
-static bool pci_bus_devfn_available(PCIBus *bus, int devfn)
+static bool pci_bus_devfn_available(const PCIBus *bus, int devfn)
 {
     return !(bus->devices[devfn]);
 }
 
-static bool pci_bus_devfn_reserved(PCIBus *bus, int devfn)
+static bool pci_bus_devfn_reserved(const PCIBus *bus, int devfn)
 {
     return bus->slot_reserved_mask & (1UL << PCI_SLOT(devfn));
 }
 
-uint32_t pci_bus_get_slot_reserved_mask(PCIBus *bus)
+uint32_t pci_bus_get_slot_reserved_mask(const PCIBus *bus)
 {
     return bus->slot_reserved_mask;
 }
-- 
2.53.0


