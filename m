Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56596C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiAEc-0006VX-NJ; Fri, 10 Jul 2026 08:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi3lK-0000NT-GQ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:27:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi3lI-00049a-3Q
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:26:57 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3n4rY3898996
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=jZZ4niVrLmn
 2GO/pDHbdvlka4uQ0QskiTf3YDgvds3c=; b=jHPGEFtyCAVgHfGaixDssB1kv6u
 14YxahSO5ZRToe3Idn54eI/DaY2od3f7OzfKdAMFn0mh+m/yiYovu4z8wxtgGpGJ
 Haxgta9H/E8oP5uBS4m5qG8F5Q6qlOPJD8kDdtQDlvoG0d4xpjHHVGNYKciyBO0u
 Wy+oQj1fv3WNr/lhXgFYOKuLhiKCTx8twklAvmG8DW/8Gby/HbQK98hKjWzha1G1
 NjuJNTbGRSiGMCBuiCzVjzzvzzBejEoez5B0tBPa8lel+iLzNvclgDk6RM1FX2Bv
 YiEod7wTJ0IP6FSJE82TPTOh+19PbEbquCE6YBkhjrfxcQ4/C6OdkFTJ66w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg3jvu0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:26:54 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-37dedbd1cf1so322961a91.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 22:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783661214; x=1784266014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jZZ4niVrLmn2GO/pDHbdvlka4uQ0QskiTf3YDgvds3c=;
 b=DF6FknS2650QbUG/SsacwFAjzI/BczPsheUJk8ezr+LLU7aLebrzsTad2SeKv5PUyo
 +TcynLZzU0y8pgZJMbrrDfZAMW8Mqg6H43MmoothaignhGRlCBYeg5oK4m9ZV4mggLm3
 F3WcGf0a+UhZKu/LmfEkdEwfTtimmfSe4hBroAbwXfMl9WyqRUBoDCn6R/ktYBqNcFm5
 cQvOrOwiGJKY2TP/7EsidU+6ulVgUoiikQ69uDjeyKDPpy3+kKykFP0rnu+jF/HpEewf
 tkx3pJFPdLTdmmLJzt9YBq0rErV22QlEyyhIuSsZyHmp8LStUtJiU41mpUziLRTxnoOM
 DvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783661214; x=1784266014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jZZ4niVrLmn2GO/pDHbdvlka4uQ0QskiTf3YDgvds3c=;
 b=Kn28qq+QC5ln7Te5SHO2eJPlNaRGVQ0C2DL3BCHrr2MbLQVJcp4Qvdh2KphcyGS5Qu
 ugBbCOK4u0D4sBs9mbENz9xGO5W9Avno6bg6rPg/GWsq8muxqaie843dhavoesIcA8bw
 M7zl16xXECyaSIdK44tmffQ9QRPIj70bqyMMvKWbIqnsrfoMmqP/UnXt8sCmtSjOaiTo
 gRLHwMyfA7nV3hCXCgTtnnb8fA36fiQ9wsi8B5JXey+8ZVy+bqNYwaiwzvpYjp57iXUg
 0LvdMF9JJkqciRDorpwyVp0TtcKHNmS5w9OlxIi4oBs+kd84cVJ01x6YA/Do1/q9HlBb
 nOJw==
X-Gm-Message-State: AOJu0Yw11f1I14D2pcXLt5oGNaSw81l8JzQwbPy7LWTRmRQTY2k+nOcJ
 LkSgvyPrSCbwDO2YD/yEp4jNuvjdhsdNEyY1GchLTvdyBlD5Or7tsI0XgtgkXI0wpUnW7rNO/dL
 V9xp838APO2MwxF+oD4X/kVLkbCugnr8OK1JUZ/aFd0F0aRnrQTlMah19trRC5i+OPA==
X-Gm-Gg: AfdE7cklFCIpBE8s70aJCFrxL405ngKrqlMKAefdPLeILkXdOLmlUA/aaNqHBs2i6IH
 qC+QzjZeZ3YBssG3B1XasUurWYahl6WC8lwZAZ8H9fYG/oFk9oPoIRBE+T9Wz3yb2boi1zu8Kjr
 N+h56yeWkGOkRiTFUwJ0DktfxfwEbaktCjyU53Whur8L6FE7jbROfN62MyryStTih2h0bdN7kNT
 VZTNQW5dRyeleeSyVA4Xh+vDKXbiASUeJptwWCSoDOjtsi3F914jWEHWU9fdQrrnEMNVXdnCgQK
 QEcx1CqASyo8oxomD0baGBSIbFJxtB3m1ipS2Yds8onqZwQDzqcnlAPjgpZuVTdeL3mcYY9G3ac
 lKFJKJ1e5ELlTEkyT0VEMAIjTHDrK3f82vScso6/t2LqWGRwIPrlRYKBP4T2kCOx4G+ueMIISoJ
 UGgM9WEiN1O7Rz4pf0BaN07Ah4KFPZAzuu7fgzrxTRvw==
X-Received: by 2002:a17:90b:2f0c:b0:381:abcc:c8d8 with SMTP id
 98e67ed59e1d1-38a1f1de21emr5907692a91.1.1783661213639; 
 Thu, 09 Jul 2026 22:26:53 -0700 (PDT)
X-Received: by 2002:a17:90b:2f0c:b0:381:abcc:c8d8 with SMTP id
 98e67ed59e1d1-38a1f1de21emr5907664a91.1.1783661213043; 
 Thu, 09 Jul 2026 22:26:53 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm62476707c88.14.2026.07.09.22.26.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 22:26:52 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/10] hw/riscv/virt: add opt-in RPMI base support
Date: Fri, 10 Jul 2026 10:56:36 +0530
Message-ID: <b60250b3a051614dc0d135fbee879afde3f171ef.1783660209.git.subrahmanya.lingappa@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783660209.git.subrahmanya.lingappa@qti.qualcomm.com>
References: <cover.1783660209.git.subrahmanya.lingappa@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA0OCBTYWx0ZWRfX02ojr9mBrmFm
 oBtU+jA7bv0F7iXYX7Gt6Cy7G2dph7plaMZ9wER3DOqSSylHQuDZONk6h5IDABILSm3Uo00bsrm
 zmUHqsUkMl22y4GNVACsJVxbAgN3taChC7og8HdhaY4rgaUolDp0ahX9eMvHjXNMYHB9PDW7joV
 qLncekRpTXJLBsuI/JRS2EdTIG0pRWYa1JJWv5Vshi5gpPRkoB7w4anQcRZ5taHS3lRZtYIz12Z
 bEmhwNZqkVYypZknac9OcGZAyMDqGqZp4tEYjgPhJYrLomqIrkJcS0+0qLMIHVu4p6+TO2QSRhR
 biq5pouLOz//0+m9laQSfnC/9yGUokQdSBI0KSwabxLMH7ExeeV0nUQfwikg9i2fuFYDaefk0Qt
 E0FrIQjfL+JXv4nNhFAB0O9STZomb9XRsPG8kZQO5hq1CpHLN7hRGJmXzWbnUmN1leTQWnL3qX5
 maW+JhifWVh6d3W450w==
X-Authority-Analysis: v=2.4 cv=ZcMt8MVA c=1 sm=1 tr=0 ts=6a50829e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=g5JW_UTvCJDKiRHPheAA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA0OCBTYWx0ZWRfX8tKjCcTfApeQ
 KqrXdYuyuSQp0cazfc0DK5GX+5GF2yiqXmPUA4SoaYLy6OwAZMZmiIYmTn6kzLsUUuOFHmI8NfB
 1AEU9J4l3nGzFxvREPunaU55RJxF/Eg=
X-Proofpoint-GUID: rhT9i9k-w5qoSxOj0jZSnXYGIDtXO-jf
X-Proofpoint-ORIG-GUID: rhT9i9k-w5qoSxOj0jZSnXYGIDtXO-jf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100048
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Jul 2026 08:21:33 -0400
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

From: Subrahmanya Lingappa <subrahmanya.lingappa@qti.qualcomm.com>

Add the virt machine rpmi=on/off option and wire the initial RPMI Base
transport into machine realization.

The option remains disabled by default and requires TCG plus librpmi.
Invalid accelerator/build combinations fail during machine
initialization. When enabled, virt allocates the RPMI shared-memory
transport, creates the RPMI device, configures Base service metadata,
and emits the corresponding device-tree nodes for firmware discovery.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@qti.qualcomm.com>
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


