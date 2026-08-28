Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53738C61DDA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03MZ-0007KM-10; Fri, 28 Aug 2026 16:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x03MX-0007Jn-EI
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:39:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x03MV-0006Vm-89
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:39:45 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SJ7oWT3989422
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 20:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lmRRjl4/oHeX76B0w+4rgO8G5wwFPYRuA5NTYJ4X2h0=; b=gatpD3AAxmhQJcUe
 p74JDEXdpQtZAIrLXRS9I2lm2kwr5lwZSg6e/5xpWixBDS5gxnZba50OT0w78fMh
 HcCIIX1OGtcprraVGXQTq3lP37v1wqo8wTMcUY06oMXxWrdErLEmowwBMyOc2ZLf
 LXBVk/fhsSyo/hT1jMPkpHo8FGw5+BEZtRQQCY6+IEkBIp15+znYNa4RDMXkhWbg
 bgeBSZGb9hDIErWSTZpruYWwmNpxxXwAlIelbcDTUiXiKzAqxMosaZdzpSExjE4q
 PPZTVZWucM45ofAkAQrsekReK0yhS33uv5BWA+PKX+FaYtz0t2N1BJKJaOnW1+W8
 q5JfWw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb62h2xcr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 20:39:42 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-938153538caso250554285a.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 13:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787949582; x=1788554382; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lmRRjl4/oHeX76B0w+4rgO8G5wwFPYRuA5NTYJ4X2h0=;
 b=jJoRSjjKU07/UQwzAa8ihOAjvz885GrYG8+Xk1IQf4Mpfc1HtEtAs8yAihbiho9p35
 8X2IVs5MycnBU1bK78xMavRAkck/U5sTdjyx4ZjLzmOS6gb7puDyZXx5qONu3GZAfQH8
 jJjPUpMlPoyubEyOcQA3TN8D/15sUuYGMUfcilFbfH3ndofvmw2MvrIAT4I6tFiAaPd1
 MhUnml448MXgWiQDSXlmwl5XTBBX0Hoe2IY2m3zxkfH+GdlDPIZaqA6oM9FITxAT57rj
 haH7FCnt6TzFklVxdJiSMRDz3bxg3E5OpSR0pggnXX+JDPoDLQ0xxuTvYGKpTJP2qzcL
 g8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787949582; x=1788554382;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lmRRjl4/oHeX76B0w+4rgO8G5wwFPYRuA5NTYJ4X2h0=;
 b=GhXw11uQPVD32jt8BhTdTCKuBf6gML0aoEikTEYqyUc0r/Djh+3nOggTSZFa14KCv2
 ic3nkofNiWNjwRwHDO81DdAEz9x4BhEohbjJ6wsF4xM874h8BEh7IbnrB6np3zAbUfsv
 ewPXMDGMqaKR6osEsXTidBAhXC+Xf3mRLo0Zheq3OGeHHaLaCxHKBz4jChthT8EDDzTu
 wRXCfTvjwExvHQDwFSIe3jInTElzXvCMuWFjkouAIFoFY/RArYxDCZRsEDubkP5ytqRN
 YwAq98q0Is5fLJBzQazpbhI6/fv8OWIqsNglKopO8O4UHJfoPDyd/kSj5NJpIyZCVEFo
 Mu5A==
X-Gm-Message-State: AFuF++nfsUL26vDxAfTa3lFHdRFq7+DYVRiWkt5mXqppbXGwFzxCctBq
 pcRH3dxJv0GSbd79MziBHOtZSr6Yv16dJ3TWUY+9ReOCmCpihbBxDo+s2TqukxcoCFY5inC7hmt
 HwR0n1R54cj8ZkwzokU6eDaNfEBXeMcNDrLCpHkAwxOB4RqjvEY5igtWn1imCl2CtSw==
X-Gm-Gg: AR+sD119cqGjorFSkH87P7C9Ksq2TVb6lfqfFCLncTSAmsp/p2dtFFmA6tQuX9a/mUt
 sqyTHFRc9uDHW+oahYZUWK0WPeLhHBul8SvFeChH/R8FkCndq3W8wnrHTeHJrGXz2Fa1jqhF3Nr
 9zvG/ovsVl5m5/DzGFFkk65cvIqKLC3KQjtoqDM+jqw2QCjtp7G+KKVru7Ng69kTj9J9sIXMZjW
 2pMraZRKDcrZBWg6yl5Gw4WZLHyxTaktBq1HD/MRTPHLgKL8F7RRWKP9zPz8EAiEbgHyx8aM7le
 kBSQP8sxkaF7fxMLdt60WewK9q6ES4ZxrNU6I2eDHSqXT1fJcborIOrB9C12rSFAlzMfbXaqWs4
 p4qJ8ow9C6SAQbXhJUmbk9IVfg/3CPMKVlmyCYg==
X-Received: by 2002:a05:620a:2b4a:b0:936:583a:dd75 with SMTP id
 af79cd13be357-9391384ea5cmr1278664485a.17.1787949581504; 
 Fri, 28 Aug 2026 13:39:41 -0700 (PDT)
X-Received: by 2002:a05:620a:2b4a:b0:936:583a:dd75 with SMTP id
 af79cd13be357-9391384ea5cmr1278659385a.17.1787949581053; 
 Fri, 28 Aug 2026 13:39:41 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939173f2758sm218063985a.37.2026.08.28.13.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 13:39:40 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v5 05/15] hw/riscv/fdt_common,
 virt.c: add riscv_create_fdt_pcie()
Date: Fri, 28 Aug 2026 17:39:07 -0300
Message-ID: <20260828203918.350131-6-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDE3OSBTYWx0ZWRfXzHreddlFuZej
 JLl5ZkKsRwY4opPvbMJqYu46OuuQ4vK4DdnB/Kw/2k71cxW6CgUp51CEmuNUGwP6YS6aJmuVOzC
 mtdOuDpvN1hfoLrd+h0aFpg2kDAFz0w=
X-Proofpoint-GUID: UygRndjuB84xFAyp16AztRZWr-7xwTmN
X-Proofpoint-ORIG-GUID: UygRndjuB84xFAyp16AztRZWr-7xwTmN
X-Authority-Analysis: v=2.4 cv=I5dVgtgg c=1 sm=1 tr=0 ts=6a91f20e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=nzCZRCZgkTuinHKBC8cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDE3OSBTYWx0ZWRfXxjt9aP51Z8Yq
 lL63Aw5MvmQl05gqhkz5z3Xt7tABjI5i4nVEbaBJWHzEz7nvgcrrMX+7NuHkd/eqc77JDsUeysx
 NgVj5+lsU6OqU//zNxU5v9fO/k9dMWZ8oRUe1vEICMnUaxErzY8opAXtvYPEtccIeGW0YnRVLDp
 0GSbMPK/VEmYJmHNctnZe1pxuj6jGFYE6j5E8Qn9c4NXIPVE80q9nibeJ/jpj/cC1xN2YCY0Vi5
 hU0aX5SX3Hbtf+4tHd/oDFrwFUK1ICM2/eM7AAeYCiJ2w3rq97opFf8UUAFmafpK43jtl9BooEb
 ZGh+/Deotapvu6GUC8zvkxnQpZdYZ19cCuiNVouW65jxBhKkHeMwFh1C/X9pdXSUrqYFLXsa5sl
 FsVWjL0UawtGomyDHI8iMDY7pnRyjMDxznevputUGL9NxIXqwJl7pzDyUhjyPOdZoPflefia22C
 t5i0T8QkWiPvb6zg2ww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_06,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280179
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         | 111 ++++++++++++++++++++++++++++++++++
 hw/riscv/virt.c               | 111 +++-------------------------------
 include/hw/riscv/fdt-common.h |  29 +++++++++
 include/hw/riscv/virt.h       |  15 -----
 4 files changed, 149 insertions(+), 117 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index 88589330fb..38813b6aa7 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -15,6 +15,8 @@
 #include "target/riscv/cpu_bits.h"
 #include "hw/riscv/riscv-iommu-bits.h"
 #include "hw/riscv/iommu.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pcie_host.h"
 
 void *riscv_create_board_device_tree(const char *model, const char *compatible,
                                      int *fdt_size)
@@ -384,3 +386,112 @@ uint32_t riscv_create_fdt_riscv_iommu_sys(void *fdt, hwaddr addr, hwaddr size,
 
     return iommu_phandle;
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
+void riscv_create_fdt_pcie(void *fdt, int aia_type, bool has_iommu_sys,
+                           const MemMapEntry *pcie_ecam,
+                           const MemMapEntry *pcie_pio,
+                           const MemMapEntry *pcie_mmio,
+                           const MemMapEntry *high_pcie,
+                           uint32_t irq_pcie_phandle,
+                           uint32_t msi_pcie_phandle,
+                           uint32_t iommu_sys_phandle, uint32_t pcie_irq)
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
index 8a165f4d9e..a28e6d200a 100644
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
@@ -723,51 +668,6 @@ static void create_fdt_virtio(RISCVVirtState *s, uint32_t irq_virtio_phandle)
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
@@ -916,8 +816,15 @@ static void finalize_fdt(RISCVVirtState *s)
                                              msi_pcie_phandle,
                                              IOMMU_SYS_IRQ);
     }
-    create_fdt_pcie(s, irq_pcie_phandle, msi_pcie_phandle,
-                    iommu_sys_phandle);
+
+    riscv_create_fdt_pcie(MACHINE(s)->fdt, s->aia_type,
+                          virt_is_iommu_sys_enabled(s),
+                          &s->memmap[VIRT_PCIE_ECAM],
+                          &s->memmap[VIRT_PCIE_PIO],
+                          &s->memmap[VIRT_PCIE_MMIO],
+                          &virt_high_pcie_memmap,
+                          irq_pcie_phandle, msi_pcie_phandle,
+                          iommu_sys_phandle, PCIE_IRQ);
 
     riscv_create_fdt_syscon(MACHINE(s)->fdt, &phandle,
                             s->memmap[VIRT_TEST].base,
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index 65711468b8..3750230865 100644
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
 void *riscv_create_board_device_tree(const char *model, const char *compatible,
                                      int *fdt_size);
 void riscv_create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
@@ -48,4 +69,12 @@ uint32_t riscv_create_fdt_riscv_iommu_sys(void *fdt, hwaddr addr, hwaddr size,
                                           uint32_t irq_chip,
                                           uint32_t msi_phandle,
                                           uint32_t iommu_sys_irq);
+void riscv_create_fdt_pcie(void *fdt, int aia_type, bool has_iommu_sys,
+                           const MemMapEntry *pcie_ecam,
+                           const MemMapEntry *pcie_pio,
+                           const MemMapEntry *pcie_mmio,
+                           const MemMapEntry *high_pcie,
+                           uint32_t irq_pcie_phandle,
+                           uint32_t msi_pcie_phandle,
+                           uint32_t iommu_sys_phandle, uint32_t pcie_irq);
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


