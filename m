Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EF1C61DD7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 11:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzulo-0001sE-7U; Fri, 28 Aug 2026 07:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wzulm-0001qF-Di
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 07:29:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wzulk-0007ew-GA
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 07:29:14 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SA88QY2596139
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 11:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=lHIoXuNYkob
 oNA5wZwffhhnpzE/5bvPgEzcsOazaxgU=; b=ELMBJmDTvnJgtDsqmdhwdvdB0KV
 4KHZuqMmb9JW5cbYvm6q0ZDb1kJ5m2x8oGgTvJhr0QiXAxXjshyZdVlJFEi5JXCv
 qaMjtWx7R9qbGBol/Ro/vob49psd6w6flZpGYSlOnnkDtnk5150Co4lTsPCq/Sq8
 N9HNzGcsKyg70mcFH0+cce1uoPRT0rxu/niYyqhwuptNpSNqL0XRqTdyLdlRaoZd
 4nxdZtw4lRwLGNUJ0xdkmehRYfh1y2J9p0bElPcQ2peQk8iDdvew0NUTQB5NXEGr
 +iJ+ooaDB9ZMC9GWYfDLYspFkDd4rjsCE2yPWAqlDA2e0ZEC+Dff0EcCbbg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb1v39yh1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 11:29:11 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38dc0eee75dso290533a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 04:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787916550; x=1788521350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lHIoXuNYkoboNA5wZwffhhnpzE/5bvPgEzcsOazaxgU=;
 b=ahWEUwR46/Q+kv6mlX2RyW1vGBeT8+po5nIqMTT7iALeAU4BO+cqqSw4fFFluvF3Fn
 uBt98rfaxya5tpaPDtNRp9tDZVyvJnZOYWB+v3vp5APuDJrg60QlZE8x2g9r/xkGWznG
 qe/kETK9rDFq8rFIPNLWOAeSwPu1Ice03xV9N29UeVDptSCobGZNNw9GbfdQc3lx8t9o
 UeeJUAM5yydkos4mRCQt9KWuW+rghb9XIXnRrLpz62qZ4qmQUAW364azD+vJSjh4ax8B
 HKIx2r6QzJS2a7XImkevHn+volfGaDt5QRuwSYhTzKvCkeuZ2jmel/cbweKOo3zqyJX5
 OH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787916550; x=1788521350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lHIoXuNYkoboNA5wZwffhhnpzE/5bvPgEzcsOazaxgU=;
 b=eDB0BNFHLaCnh9RGgsbbodA8jM521M439csfHNE8+a0FShYEJxtAhP7OFdiDqSyKjn
 x1wvFqJNus0a4kGXWYFdvXpSB7IwV+8U2Dsc758ppLMET6Ff+Cili5eGzqLqhJYV8p8l
 w3mn0hCkCY+t6eESpGCP9b3IBLhtpLAiyGE6wSeXXlSkmj2/ByZHJbYpMnvLWVGFUllE
 m08miJoo+l/PZ0jMPZCKt6kIks1pT6nuCB47GVEXdfSJgIxLmqOTCRb+zt+KTYhpoI1X
 L2pqv70Wrp0DVMLb569XdIlG6FicedIe36KITGLE9MPgCZTfAR05SjB+3ih6l/EzxzKx
 NbQQ==
X-Gm-Message-State: AFuF++lvpRPMuj2P5oZsAmrbi3QwBvZ228G5t5rTghyyRog9s+MdvltI
 cAUCfKOa7SWWQmj+hb1UDHAbpeO67Y98p/f3d34FpPaExHJNj9qLwj6gFADgm5sbRG9nFJHglt0
 uftqXZSdcUA+qa9d2pIEwW0fuJZZxRpkxRRALJRoezLUkH3VV6+sQH9rPMOJe13VvLg==
X-Gm-Gg: AR+sD11uCq7Ml/RQJtNNDRxQV9mI8rGjpK98gaNl8yO0eGqfZnLPJJEDwdfhc6OCj6m
 gRQVD7pCvRxISk1ONr394mvL7tsEwlZiBF+DACIBkCOJ2KhMtgrve3+ct8nK8no7bgO4EYMOGuH
 7iLcJmFITL4u1IDFWDJ8bnOOafeiWugnvVI5aEtjmqyLHFJ5LYjv1YDzgS45No8CQQuxI2UHgVY
 a2RhpS5dHYNcQZTNBbnWqubdQ2YRQ1XxplZ6GqaREnOoN3cTFWBLYLs1z4AvUYeU0WlqhZJmAW9
 Bg3gQfWVjIp5ZNX9n5/xED1OQxqxQvHFRMbrdhLJvB/UHiCza6VmFgKuVmD81SxOF7IolFpO/tG
 CJ6U6wDMg1OR4wSxGLXIM6NJjMFOJvQYC2Kx/qgVNaPIhzDmdYkLtD7M8bD9zjgBhJhvMTwzSvo
 U9UykEwaFIJlJAWSHBa3irBCtXMXSOQiE=
X-Received: by 2002:a17:903:1106:b0:2d7:1a3f:8db5 with SMTP id
 d9443c01a7336-2d74e0c729bmr54312505ad.4.1787916550240; 
 Fri, 28 Aug 2026 04:29:10 -0700 (PDT)
X-Received: by 2002:a17:903:1106:b0:2d7:1a3f:8db5 with SMTP id
 d9443c01a7336-2d74e0c729bmr54312155ad.4.1787916549809; 
 Fri, 28 Aug 2026 04:29:09 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4d92sm4997320c88.13.2026.08.28.04.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 04:29:09 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v10 04/10] hw/riscv/virt: add opt-in RPMI base support
Date: Fri, 28 Aug 2026 16:57:56 +0530
Message-ID: <20260828112803.86636-5-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828112803.86636-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260828112803.86636-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA5OCBTYWx0ZWRfX9Y7QWm086oQw
 wtiMgJvmWQKSm0+ggF/kCRXqDsmTrKf0cvYKBNykbxkI0BqF3prgueNawUxBB66q1P0Csomg4At
 ZdQ0jHCJFuiBiaziWH408of7BjPS0TTEf4EkyI5jwprLWL3dUo9yQTXmYtfG/KzdY+006d0ksFo
 yi5HvtW68RhmTqz9eLtjzbGs1tWE5vw/YEI0OXePrW6R8wDiazPUWNhooUuViP/DKQR5fcfeW2x
 ePxqddc5aKVYf9rmH8By3WbWqPNXvzlBCPupB3N91Zo0yH/P6SL++X6bOUHY9DONoMEkYojlHCh
 YX5hr//22+1CxYB/WOFGa1GqPBXvCoBHgtc9XNBj2b/HjM7NfiNigelsmjJvcxJkRq1yNJ4s+oB
 xRJc267BowRmUZHPEj5vbTM6AXEXH7FMkHT+XVKPGtzLbkr1nkOWG74+fA4nXJN5w2y4OOng3Zq
 TgIXMVMAol9fQ0o5NpQ==
X-Proofpoint-ORIG-GUID: rGmd8KqPGxzCqDG-Z5EsB7x5IGit2jrV
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA5OCBTYWx0ZWRfX1nFfncsYfnvV
 IHVCqCDraeYO4ca3/aTXM/NLWmBnjJ2ThPUyERn70PQdZUpGEA7Lu3pYF21nNBjAG21Ng60fN0Y
 A4Ci/ccQxtmfcyIH3NygSxD7Hl9j+ws=
X-Authority-Analysis: v=2.4 cv=faedDUQF c=1 sm=1 tr=0 ts=6a917107 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=CvjZw6EAnlyfa7EY1UoA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: rGmd8KqPGxzCqDG-Z5EsB7x5IGit2jrV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280098
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Add the virt machine rpmi=on/off option and wire the initial RPMI Base
transport into machine realization.

The option remains disabled by default and requires TCG plus librpmi.
Invalid accelerator/build combinations fail during machine
initialization. When enabled, virt allocates the RPMI shared-memory
transport, creates the RPMI device, configures Base service metadata,
and emits the corresponding device-tree nodes for firmware discovery.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
---
 hw/riscv/Kconfig        |  1 +
 hw/riscv/virt.c         | 96 +++++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/virt.h |  3 ++
 3 files changed, 100 insertions(+)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index d06ac26648..c3f9d7580b 100644
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
index d58656f70d..c822cc15ca 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -44,6 +44,8 @@
 #include "hw/intc/riscv_aplic.h"
 #include "hw/intc/sifive_plic.h"
 #include "hw/misc/sifive_test.h"
+#include "hw/misc/riscv_rpmi.h"
+#include "hw/riscv/rpmi-fdt.h"
 #include "hw/core/platform-bus.h"
 #include "chardev/char.h"
 #include "system/device_tree.h"
@@ -100,6 +102,8 @@ static const MemMapEntry virt_memmap[] = {
     /* UART1 supports page isolation from UART0 */
     [VIRT_UART1] =        { 0x1000a000,         0x100 },
     [VIRT_FW_CFG] =       { 0x10100000,          0x18 },
+    [VIRT_RPMI_SHMEM] =   { 0x10200000,       0x20000 },
+    [VIRT_RPMI_DOORBELL] = { 0x10230000,        0x1000 },
     [VIRT_FLASH] =        { 0x20000000,     0x4000000 },
     [VIRT_IMSIC_M] =      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
     [VIRT_IMSIC_S] =      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
@@ -988,6 +992,40 @@ static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
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
@@ -1007,6 +1045,10 @@ static void finalize_fdt(RISCVVirtState *s)
     create_fdt_pcie(s, irq_pcie_phandle, msi_pcie_phandle,
                     iommu_sys_phandle);
 
+    if (s->have_rpmi) {
+        create_fdt_rpmi(s, &phandle, msi_pcie_phandle);
+    }
+
     create_fdt_reset(s, &phandle);
 
     create_fdt_uarts(s, irq_mmio_phandle);
@@ -1334,6 +1376,18 @@ static void virt_machine_init(MachineState *machine)
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
@@ -1484,6 +1538,25 @@ static void virt_machine_init(MachineState *machine)
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
@@ -1575,6 +1648,7 @@ static void virt_machine_instance_init(Object *obj)
 
     s->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     s->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
+    s->have_rpmi = false;
     s->acpi = ON_OFF_AUTO_AUTO;
     s->iommu_sys = ON_OFF_AUTO_AUTO;
     s->num_sources = VIRT_IRQCHIP_NUM_SOURCES;
@@ -1650,6 +1724,21 @@ static void virt_set_aclint(Object *obj, bool value, Error **errp)
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
@@ -1771,6 +1860,13 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
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
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 7c862b0da2..76b5a57001 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -55,6 +55,7 @@ struct RISCVVirtState {
 
     int fdt_size;
     bool have_aclint;
+    bool have_rpmi;
     RISCVVirtAIAType aia_type;
     int aia_guests;
     char *oem_id;
@@ -82,6 +83,8 @@ enum {
     VIRT_VIRTIO,
     VIRT_UART1,
     VIRT_FW_CFG,
+    VIRT_RPMI_SHMEM,
+    VIRT_RPMI_DOORBELL,
     VIRT_IMSIC_M,
     VIRT_IMSIC_S,
     VIRT_FLASH,
-- 
2.43.0


