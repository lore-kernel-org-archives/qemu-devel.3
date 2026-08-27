Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DF3C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziYR-0005HQ-NH; Thu, 27 Aug 2026 18:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wziYP-0005GL-GU
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:26:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wziYL-0001CR-Og
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:26:37 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJMEp8548246
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:26:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0CX/dyij1ROObEc9qiBrVy7iE1ABhLIjMFnCxbweU4Q=; b=KyJ2hJ3LoCJsgFD3
 HLgxGtQjlMWKK+0CVeqahJ56ZdtNOhInAv+5lDgPpQoBmvZAAH2cfkScfBbBsmG3
 YNkOdqaHKAaVX1rhvktUCrt3qFq965XZGrlRe9aC1LKdXXV1CY9Fi2RfXmeVT9/h
 Aul5QWob+1MlpWYR4J4ShQqBzdFQam48NFOmiE11dev5ImqNraqovBr7aj4GOy3d
 YnD2it56u6ukWYedojtWB52lw56INeXIRRRk1x+A7mFRl1/yPRPAHuvePROIc6SM
 IOoNXzAny1XHEvfAPEbizzMy2o8CUTUTUmvi4sSL5CgIaHtG6uItov+zPbBycUZF
 zUP1+g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gak562uqv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:26:32 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-90cc2b97f8fso7653706d6.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869592; x=1788474392; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0CX/dyij1ROObEc9qiBrVy7iE1ABhLIjMFnCxbweU4Q=;
 b=NmS6DVOB7OnbuHLAU/G1xctYM/3oef7rvnT26g4ufK2LxQyqSeg6RCxHR1LwQQ16Vf
 sLRjcNxgX18NaASWO2J2Sh8xnsM8d9cFvmi60p8JhovTSzdiYDFpFE7Wt2zIr1NvFMAB
 mTo2iDAigkKTG3M9rjDuwGppLU42IICl3be+qF7Ojo+Yw2XvoitwwPk3gHQb9X2MB1Lb
 uy4YlYeLe2TNpv/Dd/kVeRMr667YsUMNQOpU6X/u5JJM7qDCIThRE9Bgxx4GwALhNEAl
 ljEdgTyUuJyJlFCPcGTl8XJkKUpvVuBxip6lmohSQ4G22VVkKu1vnrQXLnLKgM/x4US+
 yc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869592; x=1788474392;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0CX/dyij1ROObEc9qiBrVy7iE1ABhLIjMFnCxbweU4Q=;
 b=JayCBvktTPRhqcxAlWBdC6wQ0Jgss7VKA6lY/auL0p+bgw5nTecBvOw4zCgK+6u+bM
 f+CyeEZvth4Xhl+7BILf4sZW3LkeuYIOfcxNk81kU00xl5Mri0g2rJvUSS6dQ12916w2
 vGzv0xp5POwQugVxiszr7rrhCLuuNdxeZb/BQ+CqNLOF/vEadQQpAxaiR4LdR7UftowE
 WndPj58PgTyVwQw+PzDMD0xNIA5a3EtA3/RssdE2PiHYmSKpcv9W4hP7mAE4nLvbNRlr
 svh4CiUd1e/NyWlzBNnQ3gKpeMe0TjH8gNGTPAMhxhWjEYXYb0bbe73WXnd66LTb8a9X
 xR8w==
X-Gm-Message-State: AFuF++kmCbQrsTTV0jmeE5e5D2ALBKEyK9dbU8O9JRQLjOfZY6dkhuOl
 YndV7nnieOhaHWXN9mkwKiWIErn+lyoVFUCG+4LPjGu8z4FX6NxrTmTknj0xLSAZIoxkMUrDAmz
 RP92NNPy4ZqcHN2lEKpupPa7rU+PhdqlaXKxB+j8xl+M+lgYHpiyur+ZGBsdo2CYJ7A==
X-Gm-Gg: AR+sD124RBQEqQdRVqQ/hpx7bYcHQHRaCuyCnf0d6e7rm5RWzgTKKlV5FrQTD61bfR0
 iDhpsoax6hweYek8Wwz4qVRBZVglGv6feZjh6PznPr479dILSBdSa9jDf9K/Oqa3qaH5tGy1db8
 cow7/z5H/KjktKBVR6Lzk1ZN0kjz2XudJgdF6FNsAM+gWKPGyrp7Mh53vCrHDpDerMT8wJotWIv
 +a5V0ievj0WH6geWO3geLmLj/DhgkJ+CILYCdM1to8u8FeQcieN2tD5FXRAtaOYs4X7GKdAGr6Q
 /1+Hmoe0/Jy1pduW/z56+A/EtV7WQ8dOQCVH9nq+7Gp2AQj5fUyZhOJ+FTTnDeYhBN+tvDfzrNE
 K3szFxkNoDgobeUlcxPe5XFJvjntB4stdC3GVpQ==
X-Received: by 2002:a05:620a:622a:b0:916:10f6:780f with SMTP id
 af79cd13be357-9391390443fmr230020585a.27.1787869592111; 
 Thu, 27 Aug 2026 15:26:32 -0700 (PDT)
X-Received: by 2002:a05:620a:622a:b0:916:10f6:780f with SMTP id
 af79cd13be357-9391390443fmr230017485a.27.1787869591716; 
 Thu, 27 Aug 2026 15:26:31 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939173a734dsm8924985a.26.2026.08.27.15.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:26:31 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 04/14] hw/riscv/fdt-common,
 virt.c: add riscv_create_fdt_riscv_iommu_sys()
Date: Thu, 27 Aug 2026 19:25:57 -0300
Message-ID: <20260827222608.329788-5-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827222608.329788-1-daniel.barboza@oss.qualcomm.com>
References: <20260827222608.329788-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfXzCr+IO8ad8Ua
 iC3N2OjizijQHvhf/3I/uN5NeqapcQYNMdnfr/bE00czPuM+oJHRiyedipD+lrVHuA4lUfByVpi
 RVMCZchRER7NUPFR289Pl+agjlUz8Nk=
X-Proofpoint-ORIG-GUID: WMuktm0WMXiDZjHT_wtBnx9cNM9KaHGE
X-Proofpoint-GUID: WMuktm0WMXiDZjHT_wtBnx9cNM9KaHGE
X-Authority-Analysis: v=2.4 cv=G+Ms1dk5 c=1 sm=1 tr=0 ts=6a90b998 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=AqYGxfEHplewfouIbmYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX+j7kYytIuGU+
 cMqUedcgO45/4kO2C+0vmokGhb3hfG+SW9mzNJ9r4WvourozWP1yA0o2RBZO4WHyIEWWX0VTMgf
 BzCGcD/qmf44+9pDeh9IHUhlH2tz85N8XyngXfF27ruMzLX7Bbng5AhFlxw6NlE/ZLSn2fam48q
 J4ZHWplOlmO59Ker2QgE/f7aPDtzBlfL4mOVzSuMumJ4CQiljTDjUpeEXZNHfZst+ZD8vrFr9RP
 eM62d1qi+lnie7IyMVBFTiVz0G5/dELfsoydjFBNR0Ap/QXUlvLRfKskPv4I16VMP08YiINTvHA
 qvfKM8c/7pZVkS+I9U98Dhk6ymk/K1Bguzr5JcyazA/3cxcswmMHmLl+v66d2UMoWctG3Eb2rta
 8Fd2z72N42bWqyxmKEG4ShrZSJDfK+R2w4Er5w2JbfoCu9uo+Fi5lFu/nclkU7WQcT4xAD+azdo
 irV4+kUCpHsEQSRRuJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270190
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

Both the 'virt' board and the future 'riscv-server-ref' boards uses an
iommu-sys device that is declared in the DT.  Create a helper to
encapsulate the logic and avoid copy/pasting stuff between boards.

The helper will return the iommu phandle value instead of returning void
and writing the used phandle in an extra argument.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         | 35 ++++++++++++++++++++++++
 hw/riscv/virt.c               | 50 ++++++-----------------------------
 include/hw/riscv/fdt-common.h |  5 ++++
 3 files changed, 48 insertions(+), 42 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index eac5ca9322..88589330fb 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -13,6 +13,8 @@
 #include "hw/core/boards.h"
 #include "hw/riscv/fdt-common.h"
 #include "target/riscv/cpu_bits.h"
+#include "hw/riscv/riscv-iommu-bits.h"
+#include "hw/riscv/iommu.h"
 
 void *riscv_create_board_device_tree(const char *model, const char *compatible,
                                      int *fdt_size)
@@ -349,3 +351,36 @@ void riscv_create_fdt_syscon(void *fdt, uint32_t *next_phandle,
     qemu_fdt_setprop_cell(fdt, name, "value", poweroff);
     g_free(name);
 }
+
+uint32_t riscv_create_fdt_riscv_iommu_sys(void *fdt, hwaddr addr, hwaddr size,
+                                          uint32_t *next_phandle,
+                                          uint32_t irq_chip,
+                                          uint32_t msi_phandle,
+                                          uint32_t iommu_sys_irq)
+{
+    const char comp[] = "riscv,iommu";
+    g_autofree char *iommu_node = NULL;
+    uint32_t iommu_phandle;
+
+    iommu_node = g_strdup_printf("/soc/iommu@%"HWADDR_PRIx, addr);
+    qemu_fdt_add_subnode(fdt, iommu_node);
+
+    qemu_fdt_setprop(fdt, iommu_node, "compatible", comp, sizeof(comp));
+    qemu_fdt_setprop_cell(fdt, iommu_node, "#iommu-cells", 1);
+
+    iommu_phandle = next_phandle ? (*next_phandle)++ : qemu_fdt_alloc_phandle(fdt);
+    qemu_fdt_setprop_cell(fdt, iommu_node, "phandle", iommu_phandle);
+
+    qemu_fdt_setprop_sized_cells(fdt, iommu_node, "reg", 2, addr, 2, size);
+    qemu_fdt_setprop_cell(fdt, iommu_node, "interrupt-parent", irq_chip);
+
+    qemu_fdt_setprop_cells(fdt, iommu_node, "interrupts",
+        iommu_sys_irq + RISCV_IOMMU_INTR_CQ, FDT_IRQ_TYPE_EDGE_LOW,
+        iommu_sys_irq + RISCV_IOMMU_INTR_FQ, FDT_IRQ_TYPE_EDGE_LOW,
+        iommu_sys_irq + RISCV_IOMMU_INTR_PM, FDT_IRQ_TYPE_EDGE_LOW,
+        iommu_sys_irq + RISCV_IOMMU_INTR_PQ, FDT_IRQ_TYPE_EDGE_LOW);
+
+    qemu_fdt_setprop_cell(fdt, iommu_node, "msi-parent", msi_phandle);
+
+    return iommu_phandle;
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index ab6c53c78a..8a165f4d9e 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -869,46 +869,6 @@ static void create_fdt_virtio_iommu(RISCVVirtState *s, uint16_t bdf)
                            bdf + 1, iommu_phandle, bdf + 1, 0xffff - bdf);
 }
 
-static void create_fdt_iommu_sys(RISCVVirtState *s, uint32_t irq_chip,
-                                 uint32_t msi_phandle,
-                                 uint32_t *iommu_sys_phandle)
-{
-    const char comp[] = "riscv,iommu";
-    void *fdt = MACHINE(s)->fdt;
-    uint32_t iommu_phandle;
-    g_autofree char *iommu_node = NULL;
-    hwaddr addr = s->memmap[VIRT_IOMMU_SYS].base;
-    hwaddr size = s->memmap[VIRT_IOMMU_SYS].size;
-    uint32_t iommu_irq_map[RISCV_IOMMU_INTR_COUNT] = {
-        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_CQ,
-        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_FQ,
-        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_PM,
-        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_PQ,
-    };
-
-    iommu_node = g_strdup_printf("/soc/iommu@%x",
-                               (unsigned int) s->memmap[VIRT_IOMMU_SYS].base);
-    iommu_phandle = qemu_fdt_alloc_phandle(fdt);
-    qemu_fdt_add_subnode(fdt, iommu_node);
-
-    qemu_fdt_setprop(fdt, iommu_node, "compatible", comp, sizeof(comp));
-    qemu_fdt_setprop_cell(fdt, iommu_node, "#iommu-cells", 1);
-    qemu_fdt_setprop_cell(fdt, iommu_node, "phandle", iommu_phandle);
-
-    qemu_fdt_setprop_sized_cells(fdt, iommu_node, "reg", 2, addr, 2, size);
-    qemu_fdt_setprop_cell(fdt, iommu_node, "interrupt-parent", irq_chip);
-
-    qemu_fdt_setprop_cells(fdt, iommu_node, "interrupts",
-        iommu_irq_map[0], FDT_IRQ_TYPE_EDGE_LOW,
-        iommu_irq_map[1], FDT_IRQ_TYPE_EDGE_LOW,
-        iommu_irq_map[2], FDT_IRQ_TYPE_EDGE_LOW,
-        iommu_irq_map[3], FDT_IRQ_TYPE_EDGE_LOW);
-
-    qemu_fdt_setprop_cell(fdt, iommu_node, "msi-parent", msi_phandle);
-
-    *iommu_sys_phandle = iommu_phandle;
-}
-
 static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
 {
     const char comp[] = "riscv,pci-iommu";
@@ -947,8 +907,14 @@ static void finalize_fdt(RISCVVirtState *s)
     create_fdt_virtio(s, irq_virtio_phandle);
 
     if (virt_is_iommu_sys_enabled(s)) {
-        create_fdt_iommu_sys(s, irq_mmio_phandle, msi_pcie_phandle,
-                             &iommu_sys_phandle);
+        iommu_sys_phandle =
+            riscv_create_fdt_riscv_iommu_sys(MACHINE(s)->fdt,
+                                             s->memmap[VIRT_IOMMU_SYS].base,
+                                             s->memmap[VIRT_IOMMU_SYS].size,
+                                             &phandle,
+                                             irq_mmio_phandle,
+                                             msi_pcie_phandle,
+                                             IOMMU_SYS_IRQ);
     }
     create_fdt_pcie(s, irq_pcie_phandle, msi_pcie_phandle,
                     iommu_sys_phandle);
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index e377682b32..65711468b8 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -43,4 +43,9 @@ void riscv_create_fdt_syscon(void *fdt, uint32_t *next_phandle,
                              hwaddr addr, hwaddr size,
                              uint32_t reboot, uint32_t poweroff,
                              bool sifive_test_compat);
+uint32_t riscv_create_fdt_riscv_iommu_sys(void *fdt, hwaddr addr, hwaddr size,
+                                          uint32_t *next_phandle,
+                                          uint32_t irq_chip,
+                                          uint32_t msi_phandle,
+                                          uint32_t iommu_sys_irq);
 #endif
-- 
2.43.0


