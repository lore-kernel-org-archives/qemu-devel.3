Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8958FC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyci-0003WQ-5v; Tue, 25 Aug 2026 17:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyycg-0003Vq-P8
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:23:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyyce-0002HO-It
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:23:58 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PLAJ5q2899382
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=g9NYXEbKr18
 TjHgXcHHA/K5gxI00/QYaZJRDaH3D9ew=; b=PvwdADS7D7bjdLDRu3KdB5Ap/Jy
 XNDazIsFJKjijjOgZv7zgh9QuHSpcXeFrMjkKZOGuFzlTLFZDNgj2IXyUFH1gi9o
 SR66YWGODZgqaXhaMzdTBPT5JidPTUZ8dWELgoPX2q/RT0b7ysnZBxJ7aNfz2/tI
 X06sf8lXyFsRXRg0Xt9iOi6Ls8g5N3/qXHRCsB+HSr72Ap0iYxAyGdqvo3zSbTsL
 LOzKJtw9f1lP4T0ruYeGKPNLKoHkPbFhdUw6R9GDxAxAqvDZAVwgJg2e82ThvK5y
 BgfGZ3l0DKbdbGF4OTuKxPGsdUejJ4faZu5O2o/GxzQPdXAK7s7oATWisyQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9fceruc2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:23:54 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c0408254aso16939001cf.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 14:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787693034; x=1788297834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g9NYXEbKr18TjHgXcHHA/K5gxI00/QYaZJRDaH3D9ew=;
 b=Jt1QvF20ldbjdCoO6R7JdTtUD6WRl0JYBWoHz2EhwdND+y5e+FD94hsZJ1+OX0/EJK
 0mxjACJgA80yWWSOAJmtKwHpfGotgbqMfSoHF+1nIL5+H/j/tdmvbRhPLW6T8ULIPWNj
 qlsXxxjQjCYgKlWrTwMopu9mmHFZtIl0ZwbwGVH7OIlhNxbcCa7G+iHSZxAbV42t3b+l
 LVtuNXgrKXaMrhFW0qAG2V5KBZLTLZJ+m0FKHqOCsAMmjRrEAJVNB1FV531IswSsVJW5
 U/1itv5swbUxgbRXmdWWIRu8Wo2BcAM8wuOn06QpodWY3pQgfvmfn1/9aD/q/Tkd6wDk
 T0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787693034; x=1788297834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=g9NYXEbKr18TjHgXcHHA/K5gxI00/QYaZJRDaH3D9ew=;
 b=qF4hVgWdn7LQV59xsW90HVVnZgJVLKQ/lx/wNCnpy6NFoSFa1UhG8yauH92SObLI8U
 MthrgwC46GSW/nouj/4WF4SrAXNcBUl1ExF05wz2qesnmkGDV8prSxeqtn14fFu0fB1Z
 b6g6niNK/LTTfszqg8XmrWmxRm4DKhoYuec4yoDq/xl95Xh6QxgOzhStoOLgahQjlcKg
 0rsRWKRAB0AImK3s4F/xa549I1YjsOckqCuygKyLAOvE6XcVGoWUORYPZcjbNzeDtNoU
 vmwr31Wi9aGq5sjscnhAOIEZ5xU4QPuJWhY6ywGnU/TZNDavSFy4NAEky/MPu0O1o7j9
 vDsw==
X-Gm-Message-State: AFuF++miEXTtorNfhWeMkPqYHkqjgLYI4ex1xfNJ69opPA1lO9PcNU4t
 GT4IXOxSN3EDk1Hm5QyxSTfKM5cRNzsqrxTbHBIN9iv0lfPwhUjjFUpL1Sf2F7i6ILZ+50peARA
 iAqK2YOjWCUlrCeCW2EhmyxXmzp/0+HlOZji+7nwcTTZC69fd4lWrJGCBev2hOSpnyQ==
X-Gm-Gg: AR+sD12TkVC+3nXTWatNckvIcczEA63fmWkm41jdc8Dwlth55fOmGuIubc0Sv3h0gQF
 IF/aCptnyz5We10rdKEJ33FeDRVpkCZN1Icb+GP4bHSKwB5rtbp38jO5jn+l/gGX84vv1mtT04R
 tSBlKP0XvoIW6hH6COxFoUqNK2QVT7NETvRIz6Owm/3/D6+IZeBjzU+WNmWzYFVlVieWHxNmvvh
 jPEc+BseqZqrX9OhsoEQMwnWZMtKy1IT2Pu5GrKeTK972CoG1ZL/9lZ/mL4QqMLoN89GEy738Zk
 1sqULmerNjzVyooehACFPoX6WOHnYZjUm2XZpb0u7alsU220fDFPPL0WI0eBrGVJ3Euknm1e69I
 KTyoDdlj227fQ5oVOTA9BRsL741Um8dgKmnSg1A==
X-Received: by 2002:ac8:59d1:0:b0:52e:125b:9444 with SMTP id
 d75a77b69052e-52e2ed0710dmr104202661cf.17.1787693033753; 
 Tue, 25 Aug 2026 14:23:53 -0700 (PDT)
X-Received: by 2002:ac8:59d1:0:b0:52e:125b:9444 with SMTP id
 d75a77b69052e-52e2ed0710dmr104202121cf.17.1787693033231; 
 Tue, 25 Aug 2026 14:23:53 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90cc65299f0sm8646386d6.41.2026.08.25.14.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 14:23:52 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 04/13] hw/riscv/fdt_common, virt.c: add create_fdt_pcie()
Date: Tue, 25 Aug 2026 18:23:16 -0300
Message-ID: <20260825212326.1907-5-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825212326.1907-1-daniel.barboza@oss.qualcomm.com>
References: <20260825212326.1907-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=a8AAM0SF c=1 sm=1 tr=0 ts=6a8e07ea cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=nzCZRCZgkTuinHKBC8cA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE4MiBTYWx0ZWRfX/aQl5OvJfSP3
 UwLN8GZOyhJiwX6lEPWEDQaPUzDHhhUsqluxRtMP4O4BifoSV/ax/W3l9dHD+bGzAJZqm/t1k0b
 GWYXwT7yliZlG9neYK9lV7foZvqb6aw=
X-Proofpoint-ORIG-GUID: Anf7U5XeTtoso1NaRJEG9IifB_KlREjC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE4MiBTYWx0ZWRfX9/QSj6N4/S/g
 x40WFbkPMQRDMtaDlPME2MyUJkr3iHxwQgCtRnwPW0wBCFeh2VZofAwRUv593pSNgF/orWDuosG
 n6JJl++HUHkJiK0oFY9PDQSpaAyJL6YIHxcl6pDJ8oTcAUku6URClZvn9gCxg4hG7kBkqgnswtV
 AsZ7o+azEM+aTFXy+cjgxI10Yuw+CYQp8tyadiK3X4ezrFtMfiRxPSVKE6juE32yaTOeA1B13eW
 ncFXV/i6jq66I6XYFgMryoeQZcI5c11iN+LGF1LFNphokaQeMc9iahB30V/1yIRXpLXR/rroI2q
 2l6UCcs28l1XfdwiEGXgRoBoDdkuaB1UosqIKLpVCAXezkTM+GvkTN5omnAW0QKuJ7m8yaz2ntj
 vCrCtsWbPmafaLu04r2G0t5gy0iv54Us9NWD5bummdbw64SvXlvLCxgPbnXsARK51BblGaOCuC9
 fLxb2flD4hxClWB1YIg==
X-Proofpoint-GUID: Anf7U5XeTtoso1NaRJEG9IifB_KlREjC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 impostorscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250182
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

The pcie FDT is quite tedious but can be parametrized into a helper.
This is going to benefit only the 'virt' board for now but it will be
used by the 'riscv-server-ref' board in the near future too.

Some other changes made:

- FDT related macros are moved to fdt-common.h.  Only a couple are being
  used by the helper ATM but more will be added in the next patches;
- an RISCVAIAType enum is created.  There are several FDTs that depends
  on the active AIA type being used, and we want a way to represent the
  different AIA modes that doesn't re-use the 'virt' specific VIRT_AIA_*
  macros.  The enum vals are equivalent by design - we want "s->aia_type"
  to be used by 'virt' when calling the fdt helpers, and other boards
  will use "AIA_*" macros in their code.

No FDT changes made.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         | 108 ++++++++++++++++++++++++++++++++++
 hw/riscv/virt.c               | 108 ++--------------------------------
 include/hw/riscv/fdt-common.h |  26 ++++++++
 include/hw/riscv/virt.h       |  15 -----
 4 files changed, 140 insertions(+), 117 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index ddc56821d3..67a0a3d8f2 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -15,6 +15,8 @@
 #include "target/riscv/cpu_bits.h"
 #include "hw/riscv/riscv-iommu-bits.h"
 #include "hw/riscv/iommu.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pcie_host.h"
 
 void *create_board_device_tree(const char *model, const char *compatible,
                                int *fdt_size)
@@ -387,3 +389,109 @@ void create_fdt_riscv_iommu_sys(void *fdt, hwaddr addr, hwaddr size,
 
     *iommu_sys_phandle = iommu_phandle;
 }
+
+static void create_pcie_irq_map(void *fdt, char *nodename,
+                                uint32_t irqchip_phandle,
+                                RISCVAIAType aia_type, uint32_t pcie_irq)
+{
+    int pin, dev;
+    uint32_t irq_map_stride = 0;
+    uint32_t full_irq_map[PCI_NUM_PINS * PCI_NUM_PINS *
+                          FDT_MAX_INT_MAP_WIDTH] = {};
+    uint32_t *irq_map = full_irq_map;
+
+    /*
+     * This code creates a standard swizzle of interrupts such that
+     * each device's first interrupt is based on it's PCI_SLOT number.
+     * (See pci_swizzle_map_irq_fn())
+     *
+     * We only need one entry per interrupt in the table (not one per
+     * possible slot) seeing the interrupt-map-mask will allow the table
+     * to wrap to any number of devices.
+     */
+    for (dev = 0; dev < PCI_NUM_PINS; dev++) {
+        int devfn = dev * 0x8;
+
+        for (pin = 0; pin < PCI_NUM_PINS; pin++) {
+            int irq_nr = pcie_irq + ((pin + PCI_SLOT(devfn)) % PCI_NUM_PINS);
+            int i = 0;
+
+            /* Fill PCI address cells */
+            irq_map[i] = cpu_to_be32(devfn << 8);
+            i += FDT_PCI_ADDR_CELLS;
+
+            /* Fill PCI Interrupt cells */
+            irq_map[i] = cpu_to_be32(pin + 1);
+            i += FDT_PCI_INT_CELLS;
+
+            /* Fill interrupt controller phandle and cells */
+            irq_map[i++] = cpu_to_be32(irqchip_phandle);
+            irq_map[i++] = cpu_to_be32(irq_nr);
+
+            if (aia_type != AIA_TYPE_NONE) {
+                irq_map[i++] = cpu_to_be32(0x4);
+            }
+
+            if (!irq_map_stride) {
+                irq_map_stride = i;
+            }
+            irq_map += irq_map_stride;
+        }
+    }
+
+    qemu_fdt_setprop(fdt, nodename, "interrupt-map", full_irq_map,
+                     PCI_NUM_PINS * PCI_NUM_PINS *
+                     irq_map_stride * sizeof(uint32_t));
+
+    qemu_fdt_setprop_cells(fdt, nodename, "interrupt-map-mask",
+                           0x1800, 0, 0, 0x7);
+}
+
+/*
+ * NOTE: this function uses a "/soc/pci@..." FDT subnode that
+ * should be created beforehand.
+ */
+void create_fdt_pcie(void *fdt, int aia_type, bool has_iommu_sys,
+                     const MemMapEntry *pcie_ecam, const MemMapEntry *pcie_pio,
+                     const MemMapEntry *pcie_mmio, const MemMapEntry *high_pcie,
+                     uint32_t irq_pcie_phandle, uint32_t msi_pcie_phandle,
+                     uint32_t iommu_sys_phandle, uint32_t pcie_irq)
+{
+    g_autofree char *name = NULL;
+
+    name = g_strdup_printf("/soc/pci@%"HWADDR_PRIx, pcie_ecam->base);
+    qemu_fdt_setprop_cell(fdt, name, "#address-cells", FDT_PCI_ADDR_CELLS);
+    qemu_fdt_setprop_cell(fdt, name, "#interrupt-cells", FDT_PCI_INT_CELLS);
+    qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0x2);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "pci-host-ecam-generic");
+    qemu_fdt_setprop_string(fdt, name, "device_type", "pci");
+    qemu_fdt_setprop_cell(fdt, name, "linux,pci-domain", 0);
+
+    qemu_fdt_setprop_cells(fdt, name, "bus-range", 0,
+                           pcie_ecam->size / PCIE_MMCFG_SIZE_MIN - 1);
+    qemu_fdt_setprop(fdt, name, "dma-coherent", NULL, 0);
+
+    if (aia_type == AIA_TYPE_APLIC_IMSIC) {
+        qemu_fdt_setprop_cell(fdt, name, "msi-parent", msi_pcie_phandle);
+    }
+
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2,
+                                 pcie_ecam->base, 2, pcie_ecam->size);
+
+    qemu_fdt_setprop_sized_cells(fdt, name, "ranges",
+        1, FDT_PCI_RANGE_IOPORT, 2, 0,
+        2, pcie_pio->base, 2, pcie_pio->size,
+        1, FDT_PCI_RANGE_MMIO,
+        2, pcie_mmio->base,
+        2, pcie_mmio->base, 2, pcie_mmio->size,
+        1, FDT_PCI_RANGE_MMIO_64BIT,
+        2, high_pcie->base,
+        2, high_pcie->base, 2, high_pcie->size);
+
+    if (has_iommu_sys) {
+        qemu_fdt_setprop_cells(fdt, name, "iommu-map",
+                               0, iommu_sys_phandle, 0, 0x10000);
+    }
+
+    create_pcie_irq_map(fdt, name, irq_pcie_phandle, aia_type, pcie_irq);
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 9417aa7a06..fc381a07f3 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -180,61 +180,6 @@ static void virt_flash_map(RISCVVirtState *s,
                     sysmem);
 }
 
-static void create_pcie_irq_map(RISCVVirtState *s, void *fdt, char *nodename,
-                                uint32_t irqchip_phandle)
-{
-    int pin, dev;
-    uint32_t irq_map_stride = 0;
-    uint32_t full_irq_map[PCI_NUM_PINS * PCI_NUM_PINS *
-                          FDT_MAX_INT_MAP_WIDTH] = {};
-    uint32_t *irq_map = full_irq_map;
-
-    /*
-     * This code creates a standard swizzle of interrupts such that
-     * each device's first interrupt is based on it's PCI_SLOT number.
-     * (See pci_swizzle_map_irq_fn())
-     *
-     * We only need one entry per interrupt in the table (not one per
-     * possible slot) seeing the interrupt-map-mask will allow the table
-     * to wrap to any number of devices.
-     */
-    for (dev = 0; dev < PCI_NUM_PINS; dev++) {
-        int devfn = dev * 0x8;
-
-        for (pin = 0; pin < PCI_NUM_PINS; pin++) {
-            int irq_nr = PCIE_IRQ + ((pin + PCI_SLOT(devfn)) % PCI_NUM_PINS);
-            int i = 0;
-
-            /* Fill PCI address cells */
-            irq_map[i] = cpu_to_be32(devfn << 8);
-            i += FDT_PCI_ADDR_CELLS;
-
-            /* Fill PCI Interrupt cells */
-            irq_map[i] = cpu_to_be32(pin + 1);
-            i += FDT_PCI_INT_CELLS;
-
-            /* Fill interrupt controller phandle and cells */
-            irq_map[i++] = cpu_to_be32(irqchip_phandle);
-            irq_map[i++] = cpu_to_be32(irq_nr);
-            if (s->aia_type != VIRT_AIA_TYPE_NONE) {
-                irq_map[i++] = cpu_to_be32(0x4);
-            }
-
-            if (!irq_map_stride) {
-                irq_map_stride = i;
-            }
-            irq_map += irq_map_stride;
-        }
-    }
-
-    qemu_fdt_setprop(fdt, nodename, "interrupt-map", full_irq_map,
-                     PCI_NUM_PINS * PCI_NUM_PINS *
-                     irq_map_stride * sizeof(uint32_t));
-
-    qemu_fdt_setprop_cells(fdt, nodename, "interrupt-map-mask",
-                           0x1800, 0, 0, 0x7);
-}
-
 static void create_fdt_socket_aclint(RISCVVirtState *s,
                                      int socket,
                                      uint32_t *intc_phandles)
@@ -721,51 +666,6 @@ static void create_fdt_virtio(RISCVVirtState *s, uint32_t irq_virtio_phandle)
     }
 }
 
-static void create_fdt_pcie(RISCVVirtState *s,
-                            uint32_t irq_pcie_phandle,
-                            uint32_t msi_pcie_phandle,
-                            uint32_t iommu_sys_phandle)
-{
-    g_autofree char *name = NULL;
-    MachineState *ms = MACHINE(s);
-
-    name = g_strdup_printf("/soc/pci@%"HWADDR_PRIx,
-                           s->memmap[VIRT_PCIE_ECAM].base);
-    qemu_fdt_setprop_cell(ms->fdt, name, "#address-cells",
-        FDT_PCI_ADDR_CELLS);
-    qemu_fdt_setprop_cell(ms->fdt, name, "#interrupt-cells",
-        FDT_PCI_INT_CELLS);
-    qemu_fdt_setprop_cell(ms->fdt, name, "#size-cells", 0x2);
-    qemu_fdt_setprop_string(ms->fdt, name, "compatible",
-        "pci-host-ecam-generic");
-    qemu_fdt_setprop_string(ms->fdt, name, "device_type", "pci");
-    qemu_fdt_setprop_cell(ms->fdt, name, "linux,pci-domain", 0);
-    qemu_fdt_setprop_cells(ms->fdt, name, "bus-range", 0,
-        s->memmap[VIRT_PCIE_ECAM].size / PCIE_MMCFG_SIZE_MIN - 1);
-    qemu_fdt_setprop(ms->fdt, name, "dma-coherent", NULL, 0);
-    if (s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
-        qemu_fdt_setprop_cell(ms->fdt, name, "msi-parent", msi_pcie_phandle);
-    }
-    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg", 2,
-        s->memmap[VIRT_PCIE_ECAM].base, 2, s->memmap[VIRT_PCIE_ECAM].size);
-    qemu_fdt_setprop_sized_cells(ms->fdt, name, "ranges",
-        1, FDT_PCI_RANGE_IOPORT, 2, 0,
-        2, s->memmap[VIRT_PCIE_PIO].base, 2, s->memmap[VIRT_PCIE_PIO].size,
-        1, FDT_PCI_RANGE_MMIO,
-        2, s->memmap[VIRT_PCIE_MMIO].base,
-        2, s->memmap[VIRT_PCIE_MMIO].base, 2, s->memmap[VIRT_PCIE_MMIO].size,
-        1, FDT_PCI_RANGE_MMIO_64BIT,
-        2, virt_high_pcie_memmap.base,
-        2, virt_high_pcie_memmap.base, 2, virt_high_pcie_memmap.size);
-
-    if (virt_is_iommu_sys_enabled(s)) {
-        qemu_fdt_setprop_cells(ms->fdt, name, "iommu-map",
-                               0, iommu_sys_phandle, 0, 0x10000);
-    }
-
-    create_pcie_irq_map(s, ms->fdt, name, irq_pcie_phandle);
-}
-
 static void create_fdt_uart(RISCVVirtState *s,
                             uint32_t irq_mmio_phandle, int memId, int irqNo)
 {
@@ -911,8 +811,12 @@ static void finalize_fdt(RISCVVirtState *s)
                                    irq_mmio_phandle, msi_pcie_phandle,
                                    &iommu_sys_phandle, IOMMU_SYS_IRQ);
     }
-    create_fdt_pcie(s, irq_pcie_phandle, msi_pcie_phandle,
-                    iommu_sys_phandle);
+
+    create_fdt_pcie(MACHINE(s)->fdt, s->aia_type, virt_is_iommu_sys_enabled(s),
+                    &s->memmap[VIRT_PCIE_ECAM], &s->memmap[VIRT_PCIE_PIO],
+                    &s->memmap[VIRT_PCIE_MMIO], &virt_high_pcie_memmap,
+                    irq_pcie_phandle, msi_pcie_phandle, iommu_sys_phandle,
+                    PCIE_IRQ);
 
     create_fdt_syscon(MACHINE(s)->fdt, &phandle,
                       s->memmap[VIRT_TEST].base, s->memmap[VIRT_TEST].size,
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index 37a1544706..bee8b85597 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -11,6 +11,27 @@
 
 #include "target/riscv/cpu.h"
 
+#define FDT_PCI_ADDR_CELLS    3
+#define FDT_PCI_INT_CELLS     1
+#define FDT_PLIC_ADDR_CELLS   0
+#define FDT_PLIC_INT_CELLS    1
+#define FDT_APLIC_INT_CELLS   2
+#define FDT_APLIC_ADDR_CELLS  0
+#define FDT_IMSIC_INT_CELLS   0
+#define FDT_MAX_INT_CELLS     2
+#define FDT_MAX_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
+                                 1 + FDT_MAX_INT_CELLS)
+#define FDT_PLIC_INT_MAP_WIDTH  (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
+                                 1 + FDT_PLIC_INT_CELLS)
+#define FDT_APLIC_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
+                                 1 + FDT_APLIC_INT_CELLS)
+
+typedef enum RISCVAIAType {
+    AIA_TYPE_NONE = 0,
+    AIA_TYPE_APLIC,
+    AIA_TYPE_APLIC_IMSIC,
+} RISCVAIAType;
+
 void *create_board_device_tree(const char *model, const char *compatible,
                                int *fdt_size);
 void create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
@@ -46,4 +67,9 @@ void create_fdt_riscv_iommu_sys(void *fdt, hwaddr addr, hwaddr size,
                                 uint32_t msi_phandle,
                                 uint32_t *iommu_sys_phandle,
                                 uint32_t iommu_sys_irq);
+void create_fdt_pcie(void *fdt, int aia_type, bool has_iommu_sys,
+                     const MemMapEntry *pcie_ecam, const MemMapEntry *pcie_pio,
+                     const MemMapEntry *pcie_mmio, const MemMapEntry *high_pcie,
+                     uint32_t irq_pcie_phandle, uint32_t msi_pcie_phandle,
+                     uint32_t iommu_sys_phandle, uint32_t pcie_irq);
 #endif
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 7c862b0da2..e516898f9a 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -121,21 +121,6 @@ enum {
 #define VIRT_PLIC_SIZE(__num_context) \
     (VIRT_PLIC_CONTEXT_BASE + (__num_context) * VIRT_PLIC_CONTEXT_STRIDE)
 
-#define FDT_PCI_ADDR_CELLS    3
-#define FDT_PCI_INT_CELLS     1
-#define FDT_PLIC_ADDR_CELLS   0
-#define FDT_PLIC_INT_CELLS    1
-#define FDT_APLIC_INT_CELLS   2
-#define FDT_APLIC_ADDR_CELLS  0
-#define FDT_IMSIC_INT_CELLS   0
-#define FDT_MAX_INT_CELLS     2
-#define FDT_MAX_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
-                                 1 + FDT_MAX_INT_CELLS)
-#define FDT_PLIC_INT_MAP_WIDTH  (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
-                                 1 + FDT_PLIC_INT_CELLS)
-#define FDT_APLIC_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
-                                 1 + FDT_APLIC_INT_CELLS)
-
 bool virt_is_acpi_enabled(RISCVVirtState *s);
 bool virt_is_iommu_sys_enabled(RISCVVirtState *s);
 void virt_acpi_setup(RISCVVirtState *vms);
-- 
2.43.0


