Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC70C4450D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiAEj-0006WH-PP; Fri, 10 Jul 2026 08:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi41O-0002Jl-LZ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:43:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi41M-0007ny-Md
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:43:34 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nSu93803904
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=xzeJ4AiYWR3
 ajTKkbjbIEkZWZjRq772CWz4lMhQHU3s=; b=lU+EdTXApmnOgDlDguKdrV51i/s
 yEK2blTnq9arrwARdHvz3CQ6n53ZBk26xPtlVatJSa4NpdSj5oQjhgb2Ydf9FLxF
 O1SZYHfzmxIfXeOza7F406xx46IMkmpBBdek+Qq33P/8qYy3m4JbtBoZ6p8s02Dy
 OJji/hWbBHUT+DRjImifkKHVQj8GTiLeLusS/fCYuipQQq96+Jx2/ew3xc99aqdI
 T/dFFgo5NzArBqgtnZ+a8Y7EKCyYuiWh68upRwOPxIucrbaI8NXnCVGQoZ2MEq1z
 gZeEY7mrLTGF6MX1axsqZVAn6VHTUvTyzfv4Cb3HanDWSJ9AVRPfYF7B28w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf5mtp8u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:43:31 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2caea278af8so2171045ad.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 22:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783662211; x=1784267011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xzeJ4AiYWR3ajTKkbjbIEkZWZjRq772CWz4lMhQHU3s=;
 b=HijB1gQz4+ro0/TmeZKJhUHzV+TKXVITnMdqW8oVSgRdl2MXvnF1qqsU2wvZ/+emZJ
 zCg3giORXrBH5JWFJ11dZNIGNmmrHt2OvpITwiamPpCGzXaiZRrf7Wvq1Y14BZPHb2MH
 5uJrd/C/gn9SC7eiMdVgQyE3VCZcceFLNZoVqThxmSNGbyMtCcpceud+Md2lJjxEIyIp
 6Tl0P64XCruoZ74DDH803W0HWuvsvG98+wmP2Ib7tcviM6S7gvoX2T904MZ59j5/wmvJ
 K9gytRuBteHUWORPJx7kWLFo39tQ7lVzkPSQDEVmW5MHkzyBV1bqV2GDK64dR6DuOkgq
 4Rrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783662211; x=1784267011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xzeJ4AiYWR3ajTKkbjbIEkZWZjRq772CWz4lMhQHU3s=;
 b=QSU1HfmbBpK19ypDTHRNrhok1E3HCrM47Hv06KGyPXE4aac00NpByUyI8eYKH4Cqdt
 KkQgOHR/thVbvlHaEF0lHCmtJyuMppeKcgbz41RcjXZt2JuMs8Dsr1cUvPI8VKAN+MCF
 bukUFxskRhhKlZFlCfw0gzXg/vOloWKWK6r2iEgtXyaj31Bp49v/cybTtkxiX09GsRk5
 GUfudD+gwP61HrSp06DIEH9YREbAr7cc37wxrLlZO7x7PjQD1D+pgNyLmGmG3GqFPM6F
 BW1LAAIE2gSKZyKze5XjdqgV6sy6LAnGJQPQbcuOZ9G2XkJiZKx/XdL9Tm5b3M8SIw3v
 N+1A==
X-Gm-Message-State: AOJu0Yyvbtbp0PikOEzcwCG4OICBejj/lI5I9TrEVnFy5+lFxNiHVc5E
 wxlhm8OsX6+VwNg0W6N+0gLLzABUDdeKnOJBCI4Z7++RDqzfUAY8rXSfX2MpXZvAce7CMa32ux5
 BXcT7mNZAGX8UvpKRgvWFHDB9GzfNAq3m37s5WEueUHHQwPV0QPoyuH6Snq0SWDcB/Q==
X-Gm-Gg: AfdE7cnvjzzC47edhcqYnVZyarxgEHPSwgDQBxeoxV5FO09h2ojhztCYaoMmAemTr3S
 TmKUwna8UL1QpfiO+FdrYzzdYatriuEZDzeIu+sDCkySnGy9Bd5uj8H2a7nAd7C8RWUvipiy476
 DT2tYTVjwabLFpb7d6N9Ap8OcCfMrVDe+cI0s230qMXsFkG+4Ezf1p+vytTqAjgMb8B/hagSm4q
 E2YhNFWa71bRYHtjlvq3Axj/901yQslPrYkpOxGaE7rQmgQc0RmFfcVQGx+jA4GwT3rRiMlzlQB
 cAmjeqZtmksGSznDh/MimNoPt27Kulu8U/aSOsmgmnb+Sw2yrq9r6eQOn1wbeu0bzTkuLsO5uMS
 TMG8OyaB/Y5H/CkzHmEtuZU/T8b1SbnEBDHggmdFOk1J2JSxXkMO8fSitTWblneXYRgSskuTUeS
 EKlilQi3fNtcjzVd8c2W197gyjJJurAV8vLqTZ8sEENw==
X-Received: by 2002:a17:903:2408:b0:2ca:ecf6:9105 with SMTP id
 d9443c01a7336-2ccfebd26c7mr58556465ad.1.1783662210648; 
 Thu, 09 Jul 2026 22:43:30 -0700 (PDT)
X-Received: by 2002:a17:903:2408:b0:2ca:ecf6:9105 with SMTP id
 d9443c01a7336-2ccfebd26c7mr58556215ad.1.1783662210047; 
 Thu, 09 Jul 2026 22:43:30 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c865asm39112785c88.11.2026.07.09.22.43.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 22:43:29 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/10] hw/riscv/virt: add opt-in RPMI base support
Date: Fri, 10 Jul 2026 11:13:12 +0530
Message-ID: <b60250b3a051614dc0d135fbee879afde3f171ef.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
References: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pAHwMVOgi9SjbDq1Zaw4qkP-qeIy_BjH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1MiBTYWx0ZWRfX9uJ1v/J2/RhL
 8O0BjU/lJrhIFh3dS5k10wuFxs27GP0QQau4ore5XWRUzrcFE/vk2sK51A3MvZ2hlbnT59NzEIb
 nK6nDHYp6RlxRM0iVan64Dpw/m6vhd0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1MiBTYWx0ZWRfX3jc7OGJQh+nN
 keQdBjdWqkR9c26ursosbLUTcsAX0YcgMHhN6WrMzFocreC0iSxT2ir6XkN1DD2wYLY7kJmLA5H
 nycyqRYg4R8zOR8NSBWz4A1YtZiGXFMa+TXWUEmor662cM+sChVwREg+W35gwZBVnbPcGqbOd4Y
 WWb/wOcuHjX8ucynV8Rv+eYnavL56BfKWxRoKMAig6EFBvESo5Jp6imoHYLoR0SZQHCxe/tm0kq
 3y0jtYFNYjB5a8w+9t2ndfvAS4EBCsVzThzyv1jzXoqkQHY76gDPjek9RNhdrzd77394GIWKymq
 qo9M11Dpdf7yTaJUQknZT6teQ2rCjol86ZeAo1ntsxE5WcR300ISfHsoK2Sd+K4P+mNU0LXJuFJ
 4o+u5WNXpW2jgU5ZFqLMPo+5FiYsMy34Hug8CipQlMzAsY8Z9UiYEeM64NYKNSDubq3nnKuHQu6
 ny7fh3SwDjsGazB8qLQ==
X-Proofpoint-GUID: pAHwMVOgi9SjbDq1Zaw4qkP-qeIy_BjH
X-Authority-Analysis: v=2.4 cv=N+QZ0W9B c=1 sm=1 tr=0 ts=6a508683 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=g5JW_UTvCJDKiRHPheAA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100052
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Jul 2026 08:21:34 -0400
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

From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>

Add the virt machine rpmi=on/off option and wire the initial RPMI Base
transport into machine realization.

The option remains disabled by default and requires TCG plus librpmi.
Invalid accelerator/build combinations fail during machine
initialization. When enabled, virt allocates the RPMI shared-memory
transport, creates the RPMI device, configures Base service metadata,
and emits the corresponding device-tree nodes for firmware discovery.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
---
 hw/riscv/Kconfig             |  1 +
 hw/riscv/virt.c              | 96 ++++++++++++++++++++++++++++++++++++
 include/hw/misc/riscv_rpmi.h | 10 ++++
 include/hw/riscv/virt.h      |  3 ++
 4 files changed, 110 insertions(+)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 54e41a6afc..4e25be113a 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -49,6 +49,7 @@ config RISCV_VIRT
     imply VIRTIO_VGA
     imply TEST_DEVICES
     imply TPM_TIS_SYSBUS
+    imply RISCV_RPMI
     select DEVICE_TREE
     select RISCV_NUMA
     select GOLDFISH_RTC
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 33775a61fd..e52ccfae1f 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -45,6 +45,8 @@
 #include "hw/intc/riscv_aplic.h"
 #include "hw/intc/sifive_plic.h"
 #include "hw/misc/sifive_test.h"
+#include "hw/misc/riscv_rpmi.h"
+#include "hw/riscv/rpmi-fdt.h"
 #include "hw/core/platform-bus.h"
 #include "chardev/char.h"
 #include "system/device_tree.h"
@@ -97,6 +99,8 @@ static const MemMapEntry virt_memmap[] = {
     [VIRT_UART0] =        { 0x10000000,         0x100 },
     [VIRT_VIRTIO] =       { 0x10001000,        0x1000 },
     [VIRT_FW_CFG] =       { 0x10100000,          0x18 },
+    [VIRT_RPMI_SHMEM] =   { 0x10200000,       0x20000 },
+    [VIRT_RPMI_DOORBELL] = { 0x10230000,        0x1000 },
     [VIRT_FLASH] =        { 0x20000000,     0x4000000 },
     [VIRT_IMSIC_M] =      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
     [VIRT_IMSIC_S] =      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
@@ -1002,6 +1006,40 @@ static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
     s->pci_iommu_bdf = bdf;
 }
 
+
+static RiscvRpmiConfig virt_rpmi_config(RISCVVirtState *s,
+                                        const uint32_t *hart_ids,
+                                        uint32_t hart_count)
+{
+    return (RiscvRpmiConfig) {
+        .doorbell_base = s->memmap[VIRT_RPMI_DOORBELL].base,
+        .shmem_base = s->memmap[VIRT_RPMI_SHMEM].base,
+        .shmem_size = s->memmap[VIRT_RPMI_SHMEM].size,
+        .a2p_req_size = VIRT_RPMI_A2P_REQ_SIZE,
+        .p2a_req_size = VIRT_RPMI_P2A_REQ_SIZE,
+        .platform_info = "QEMU RISC-V virt RPMI",
+        .hart_ids = hart_ids,
+        .hart_count = hart_count,
+    };
+}
+
+static void create_fdt_rpmi(RISCVVirtState *s, uint32_t *phandle,
+                            uint32_t msi_phandle)
+{
+    RiscvRpmiConfig rpmi_cfg = virt_rpmi_config(s, NULL, 0);
+    uint32_t rpmi_mbox_handle;
+    RiscvRpmiFdtMboxConfig cfg = {
+        .shmem_base = rpmi_cfg.shmem_base,
+        .doorbell_base = rpmi_cfg.doorbell_base,
+        .a2p_req_size = rpmi_cfg.a2p_req_size,
+        .p2a_req_size = rpmi_cfg.p2a_req_size,
+        .doorbell_size = s->memmap[VIRT_RPMI_DOORBELL].size,
+    };
+
+    riscv_rpmi_fdt_add_mbox(MACHINE(s)->fdt, &cfg, phandle,
+                            &rpmi_mbox_handle);
+}
+
 static void finalize_fdt(RISCVVirtState *s)
 {
     uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
@@ -1021,6 +1059,10 @@ static void finalize_fdt(RISCVVirtState *s)
     create_fdt_pcie(s, irq_pcie_phandle, msi_pcie_phandle,
                     iommu_sys_phandle);
 
+    if (s->have_rpmi) {
+        create_fdt_rpmi(s, &phandle, msi_pcie_phandle);
+    }
+
     create_fdt_reset(s, &phandle);
 
     create_fdt_uart(s, irq_mmio_phandle);
@@ -1410,6 +1452,18 @@ static void virt_machine_init(MachineState *machine)
         exit(1);
     }
 
+
+    if (s->have_rpmi) {
+#ifndef CONFIG_LIBRPMI
+        error_report("RISC-V RPMI support is not compiled in");
+        exit(1);
+#else
+        if (kvm_enabled()) {
+            error_report("RISC-V RPMI support is not available with KVM");
+            exit(1);
+        }
+#endif
+    }
     /* Initialize sockets */
     mmio_irqchip = virtio_irqchip = pcie_irqchip = NULL;
     for (i = 0; i < socket_count; i++) {
@@ -1552,6 +1606,25 @@ static void virt_machine_init(MachineState *machine)
     /* SiFive Test MMIO device */
     sifive_test_create(s->memmap[VIRT_TEST].base);
 
+    if (s->have_rpmi) {
+        MachineClass *mc = MACHINE_GET_CLASS(machine);
+        const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(machine);
+        g_autofree uint32_t *rpmi_hart_ids =
+            g_new0(uint32_t, machine->smp.cpus);
+        RiscvRpmiConfig rpmi_cfg;
+        Error *local_err = NULL;
+
+        for (i = 0; i < machine->smp.cpus; i++) {
+            rpmi_hart_ids[i] = possible_cpus->cpus[i].arch_id;
+        }
+
+        rpmi_cfg = virt_rpmi_config(s, rpmi_hart_ids, machine->smp.cpus);
+        if (!riscv_rpmi_create(&rpmi_cfg, &local_err)) {
+            error_report_err(local_err);
+            exit(1);
+        }
+    }
+
     /* VirtIO MMIO devices */
     for (i = 0; i < VIRTIO_COUNT; i++) {
         sysbus_create_simple("virtio-mmio",
@@ -1636,6 +1709,7 @@ static void virt_machine_instance_init(Object *obj)
 
     s->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     s->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
+    s->have_rpmi = false;
     s->acpi = ON_OFF_AUTO_AUTO;
     s->iommu_sys = ON_OFF_AUTO_AUTO;
 }
@@ -1710,6 +1784,21 @@ static void virt_set_aclint(Object *obj, bool value, Error **errp)
     s->have_aclint = value;
 }
 
+
+static bool virt_get_rpmi(Object *obj, Error **errp)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
+
+    return s->have_rpmi;
+}
+
+static void virt_set_rpmi(Object *obj, bool value, Error **errp)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
+
+    s->have_rpmi = value;
+}
+
 bool virt_is_iommu_sys_enabled(RISCVVirtState *s)
 {
     return s->iommu_sys == ON_OFF_AUTO_ON;
@@ -1831,6 +1920,13 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "enable/disable emulating "
                                           "ACLINT devices");
 
+
+    object_class_property_add_bool(oc, "rpmi", virt_get_rpmi,
+                                   virt_set_rpmi);
+    object_class_property_set_description(oc, "rpmi",
+                                          "Set on/off to enable/disable "
+                                          "RISC-V RPMI devices");
+
     object_class_property_add_str(oc, "aia", virt_get_aia,
                                   virt_set_aia);
     object_class_property_set_description(oc, "aia",
diff --git a/include/hw/misc/riscv_rpmi.h b/include/hw/misc/riscv_rpmi.h
index cb2658e57e..b5d8a32f9b 100644
--- a/include/hw/misc/riscv_rpmi.h
+++ b/include/hw/misc/riscv_rpmi.h
@@ -85,6 +85,16 @@ struct RiscvRpmiState {
     bool has_shmem;
 };
 
+#ifdef CONFIG_LIBRPMI
 DeviceState *riscv_rpmi_create(const RiscvRpmiConfig *cfg, Error **errp);
+#else
+static inline DeviceState *riscv_rpmi_create(const RiscvRpmiConfig *cfg,
+                                             Error **errp)
+{
+    (void)cfg;
+    (void)errp;
+    return NULL;
+}
+#endif
 
 #endif
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 18a2a323a3..f7c48613bf 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -55,6 +55,7 @@ struct RISCVVirtState {
 
     int fdt_size;
     bool have_aclint;
+    bool have_rpmi;
     RISCVVirtAIAType aia_type;
     int aia_guests;
     char *oem_id;
@@ -79,6 +80,8 @@ enum {
     VIRT_UART0,
     VIRT_VIRTIO,
     VIRT_FW_CFG,
+    VIRT_RPMI_SHMEM,
+    VIRT_RPMI_DOORBELL,
     VIRT_IMSIC_M,
     VIRT_IMSIC_S,
     VIRT_FLASH,
-- 
2.43.0


