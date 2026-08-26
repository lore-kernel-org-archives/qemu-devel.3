Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE23C61DC6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzGnv-00068G-TK; Wed, 26 Aug 2026 12:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzGng-00064n-3H
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:48:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzGne-0000sG-8x
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:48:31 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QDumlX910277
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 16:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=O9DGexoTufl
 6srH88MZz/5wXHHGKrgy2EfMWxzyd2nY=; b=Q4qhuXpVoMhUhsb5xoBHwnBRiLZ
 IUB++enghUo4wlM7hwM6uv3y3mIVAMLpztJH7i8AaDG50z6L3li5unfLhqQXxRuZ
 sdy325qG4PzQxHPc7t9iYu4G0tn3/pg2CK0W39Au3FTfjoITm8Z9lyBandbplpIA
 ukuoOvpAo2OaV3AdAM0kDpzLqjpFfj7EdSnuuHP1aWfkfd1IMQGqozt/hzISduDP
 UBm+eGoa/qp4eIuaxHop4e8D0pt4zWTNS/NJ/udkoFUHesloCtcKjsFr+bc3Fsvo
 RdxteVnznfPy0U5AVAwWYulxSyAdozmUqjq+2CX8s2XZLI47VEzmCSWaurQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga03a93d5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 16:48:29 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51a8b0a08d2so7275261cf.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 09:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787762908; x=1788367708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O9DGexoTufl6srH88MZz/5wXHHGKrgy2EfMWxzyd2nY=;
 b=a1FyhPHAcg8d5j/fqMsEZZKjljuLd3B9kjJ2qgev4u9AHjybQZu39tV12yjP7pmYlR
 FJ12symGdXUQ0dSRfoAIcJYWKGgYHUgVTy1mrMu7C6K00spQuMDu7e8GUF7Y1xpODOvm
 2Xpa+Df/b9MEIeTa9GTUStD0NkXfNBweZIs4aZGbQGP49uVqbFf9yPzqNh6Ukvtd7i5+
 kVAKvHHJucgnfrVIeBHqzv+ixKeaBNrduDZ8QNmVIbwwmt+Wk3Y0j361xmB9sQ7UbD7b
 QW3DAQuElXtqEq6y64auJdVAgMa2ZBQhXBl07S2CSh6RbRTZZu/1azWGPuPzis+z/cmJ
 CXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762908; x=1788367708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=O9DGexoTufl6srH88MZz/5wXHHGKrgy2EfMWxzyd2nY=;
 b=BiR5uJ4AFcRds7AN7xs66OuyocekJKZq6aHtjTTT/dp1onmlxpznkuQHJPRh40iPGh
 tjGDrl/aeL+IHixWMAuW7wYV5CzL4NZgRzPk212+AAqc8c5v/R1RPjhYWlN8Do+VoIV6
 43rsBvqsAFGG8Ng9Dzezvr5G3LxQmn85pGbW/VQeStyhuXzUELhBr+jdPmBMW5u/3dkc
 EBW/C0GlHgzL3IkliGLRWJQrwhPhhNEiqEuoNA2uxRRwl9+9k7/korvNO0xXPzdP3Wc1
 7c0kf0O41Zhpw0A203KUlW3ge+QzRf/hZfQAfsAuzy53QJsmgP3Nkyt8Z/IpP41IcDvd
 k7dA==
X-Gm-Message-State: AFuF++nROAGqfzRFsF7SP9R/aStOCFwvUnxNSVD4zwMt3HYbtzkIeDEg
 fLFOQ7FcF+TMOh3F7GXVGGM939paW00ipuKvTuqxzgnYNBy6WwV8uqeeJ0jpDM8Op+Dp5oymhgC
 27Co82K6/jefRTEYKTZ1BfESeBHbejgVfroTILXBQKFBgFyeiL6iYRcnCYhiDyvNQrg==
X-Gm-Gg: AR+sD12CPsE3c41cvI08UItHdkGpYuPYYyZZ6jbW+PWa0bP90cciPKDLwwutyb6Rons
 N33FlzkBpnku0ZCGYZYcvpEugKDwrazV8qzHUrMFAAai1KZ3TghM+/5+mUsNATWS96/ZUSpIiY5
 jPZ01ZRlxGM4Sn0sbf1vJUD1lneqEKkvKSnKose2EITkR75NpSBrHrvLWoGeAUVZtsstrDK+8b3
 9qQIExGjtXJ9514iOJm5QvvoU3MBrLaoVCEZ00ftw4vniWG06UGZE6hxs0aBg1T0AXodmKuURBH
 mn4nJV/JYZPc5n7rCoQ/YseZ83rHZoYRzDNgcNWJ1GDDsnU+yaIqnUcn1Vj18v0Yuw3vGZZXY/W
 u7qj9My49hzVLQTmm+ENN0oZFuVmSZupI4zsVtA==
X-Received: by 2002:a05:622a:1b17:b0:52d:41d0:89e0 with SMTP id
 d75a77b69052e-52e423dbf48mr85767221cf.40.1787762908412; 
 Wed, 26 Aug 2026 09:48:28 -0700 (PDT)
X-Received: by 2002:a05:622a:1b17:b0:52d:41d0:89e0 with SMTP id
 d75a77b69052e-52e423dbf48mr85766521cf.40.1787762907848; 
 Wed, 26 Aug 2026 09:48:27 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52e4275fc3esm20092651cf.25.2026.08.26.09.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:48:27 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH v2 03/13] hw/riscv/fdt-common,
 virt.c: add create_fdt_riscv_iommu_sys()
Date: Wed, 26 Aug 2026 13:48:03 -0300
Message-ID: <20260826164814.44335-4-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826164814.44335-1-daniel.barboza@oss.qualcomm.com>
References: <20260826164814.44335-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Ej9lQqz_2WqlN_XQpdWw3JLgNt2vWcO8
X-Authority-Analysis: v=2.4 cv=VdLH+lp9 c=1 sm=1 tr=0 ts=6a8f18dd cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=-lP9cGLPB0zaG0B-UEoA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: Ej9lQqz_2WqlN_XQpdWw3JLgNt2vWcO8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0MCBTYWx0ZWRfX68tR+oDe3+jB
 p/2TezHyPuBSdBIJqmZ2Pz1zzxj6vJfAGD8/zIt/nqNHKl8lA9HyK5CahPS0LQSL/b8yrRvvPBN
 wIztYZjPHwqo9Kbgwbtc7XHD0XaQuRDWGriIQLVp2L0x3RKx6xlKFyPYVGQmgMF9uwxzdqp/4t2
 BcF/XN3jrETsvghj6VmIeGVx9al6vveYAEE7W7TNpFfPDJQBI6vAT4eJ3M4IE1yYTaY3poJbNH4
 bIajlbASwFt6jy0anIUfsYiGtPSQUF/JvwdyYaFPbt9XT0sCkJA7vyh92VgJL8KNKyU6NcLDQ9Z
 mWh7VQlvzkgI36clehQD1pEhZrFqMrfIjPQdujsgFuVG9P7MS5Q6VxoH67Agbkk53Xns+j5BD4/
 9RJrbsa6pRHJwE4qlbAyOWceSzvTSx7pnKyl9SHpj+aBT2zPzzpmqNtpo3s18KRkQT8UBdhHjF+
 uiA28mWcklruJwrix0g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0MCBTYWx0ZWRfX9hSvHrdP8Urx
 iStDZcDY7woxvJ35ZsZym+W3o+LIEqIVpX78+meiS2+F+AjoxOulQ4AdOa1vI8aqUZqwMn1mN1E
 ui3Gr7bni1XssieqFHXa6Nf4QDOZX98=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260140
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
iommu-sys device that is declared in the DT.

Create a helper to encapsulate the logic and avoid copy/pasting stuff
between boards.

No FDT changes intended.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         | 40 +++++++++++++++++++++++++++++
 hw/riscv/virt.c               | 47 ++++-------------------------------
 include/hw/riscv/fdt-common.h |  5 ++++
 3 files changed, 50 insertions(+), 42 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index a2168c09ec..ddc56821d3 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -13,6 +13,8 @@
 #include "hw/core/boards.h"
 #include "hw/riscv/fdt-common.h"
 #include "target/riscv/cpu_bits.h"
+#include "hw/riscv/riscv-iommu-bits.h"
+#include "hw/riscv/iommu.h"
 
 void *create_board_device_tree(const char *model, const char *compatible,
                                int *fdt_size)
@@ -347,3 +349,41 @@ void create_fdt_syscon(void *fdt, uint32_t *phandle,
     qemu_fdt_setprop_cell(fdt, name, "value", poweroff);
     g_free(name);
 }
+
+void create_fdt_riscv_iommu_sys(void *fdt, hwaddr addr, hwaddr size,
+                                uint32_t irq_chip,
+                                uint32_t msi_phandle,
+                                uint32_t *iommu_sys_phandle,
+                                uint32_t iommu_sys_irq)
+{
+    const char comp[] = "riscv,iommu";
+    uint32_t iommu_phandle;
+    g_autofree char *iommu_node = NULL;
+    uint32_t iommu_irq_map[RISCV_IOMMU_INTR_COUNT] = {
+        iommu_sys_irq + RISCV_IOMMU_INTR_CQ,
+        iommu_sys_irq + RISCV_IOMMU_INTR_FQ,
+        iommu_sys_irq + RISCV_IOMMU_INTR_PM,
+        iommu_sys_irq + RISCV_IOMMU_INTR_PQ,
+    };
+
+    iommu_node = g_strdup_printf("/soc/iommu@%"HWADDR_PRIx, addr);
+    iommu_phandle = qemu_fdt_alloc_phandle(fdt);
+    qemu_fdt_add_subnode(fdt, iommu_node);
+
+    qemu_fdt_setprop(fdt, iommu_node, "compatible", comp, sizeof(comp));
+    qemu_fdt_setprop_cell(fdt, iommu_node, "#iommu-cells", 1);
+    qemu_fdt_setprop_cell(fdt, iommu_node, "phandle", iommu_phandle);
+
+    qemu_fdt_setprop_sized_cells(fdt, iommu_node, "reg", 2, addr, 2, size);
+    qemu_fdt_setprop_cell(fdt, iommu_node, "interrupt-parent", irq_chip);
+
+    qemu_fdt_setprop_cells(fdt, iommu_node, "interrupts",
+        iommu_irq_map[0], FDT_IRQ_TYPE_EDGE_LOW,
+        iommu_irq_map[1], FDT_IRQ_TYPE_EDGE_LOW,
+        iommu_irq_map[2], FDT_IRQ_TYPE_EDGE_LOW,
+        iommu_irq_map[3], FDT_IRQ_TYPE_EDGE_LOW);
+
+    qemu_fdt_setprop_cell(fdt, iommu_node, "msi-parent", msi_phandle);
+
+    *iommu_sys_phandle = iommu_phandle;
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index acbbe458fa..9417aa7a06 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -867,46 +867,6 @@ static void create_fdt_virtio_iommu(RISCVVirtState *s, uint16_t bdf)
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
@@ -945,8 +905,11 @@ static void finalize_fdt(RISCVVirtState *s)
     create_fdt_virtio(s, irq_virtio_phandle);
 
     if (virt_is_iommu_sys_enabled(s)) {
-        create_fdt_iommu_sys(s, irq_mmio_phandle, msi_pcie_phandle,
-                             &iommu_sys_phandle);
+        create_fdt_riscv_iommu_sys(MACHINE(s)->fdt,
+                                   s->memmap[VIRT_IOMMU_SYS].base,
+                                   s->memmap[VIRT_IOMMU_SYS].size,
+                                   irq_mmio_phandle, msi_pcie_phandle,
+                                   &iommu_sys_phandle, IOMMU_SYS_IRQ);
     }
     create_fdt_pcie(s, irq_pcie_phandle, msi_pcie_phandle,
                     iommu_sys_phandle);
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index 31203df517..37a1544706 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -41,4 +41,9 @@ void create_fdt_syscon(void *fdt, uint32_t *phandle,
                        hwaddr addr, hwaddr size,
                        uint32_t reboot, uint32_t poweroff,
                        bool sifive_test_compat);
+void create_fdt_riscv_iommu_sys(void *fdt, hwaddr addr, hwaddr size,
+                                uint32_t irq_chip,
+                                uint32_t msi_phandle,
+                                uint32_t *iommu_sys_phandle,
+                                uint32_t iommu_sys_irq);
 #endif
-- 
2.43.0


