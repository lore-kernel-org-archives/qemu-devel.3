Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA967CD98CC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQhY-0007dD-Ir; Wed, 10 Jun 2026 17:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXQgu-00075P-9T
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:42:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXQgi-0003Af-7H
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:42:18 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AJaH8e2561249
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 21:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=udmSzSUa6z+
 gUWugoUUUxrU6odPhMe9N3fOewRK4CqU=; b=gsa9NmBFgCeC1nvxbbrDmAeWhCx
 L5JJjHl60Fhig/bTFGVLaRzt197h9Vy8J5O2eV7s80wj9D5pjXDOxhDyJ4+dHtk0
 eH/IIx4OV0Scv4HA0PWX+LuHTAAneB8xgzDMIKN2fD5VsSl+jXhmiqrgQlE0AoOt
 JzbN9cFUmDHh0ZyT2bVV/5Xih9y5u6JUW8zpWmxzqZ3mD3RcIlN/1bU89OeV/k5f
 9Gt82YvYnKz0kQrCcLPkvYpjKX3ZTc9bjjYM6sxPoNLDKTX5DUuuTrpmERxDCJkE
 brixj5E75FhtWGu0TagNFMgjRlYUXXor213YpCNWTlPelIBrEop99azVNvw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe71gjb2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 21:42:09 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8cce1c3c26bso31379076d6.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 14:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781127729; x=1781732529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=udmSzSUa6z+gUWugoUUUxrU6odPhMe9N3fOewRK4CqU=;
 b=UgyaMsydOiefP8peClAjEx8mFX9FJ2q6CVV/0PsEoWbWRI8d3enx+SwIhi4imTraOo
 eoBLPPJJ/lscZFP3PfpwoWCIDZY+83lXMRmv7VCfKl+P3WcIeDP8Y5/aWJT4yxj68K12
 F0h3hrnxvghlJK/w4v09U2S/gaJEPINmgWtMsvKLantPHtIjWufOE2/sdvZ7p77LYXff
 UM1hmDtaIapMKrtTqO4rGGXjXLcMj1pwfUuDc1/S99wG62j4C0o74bBM9O4jeSgYrF9y
 VupVOYomeYlmqSTYD/yMjE50oR5qOwuLeoV1Fi19jam/RWgeBBB4gG9XkmzTvCEGWha7
 DjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781127729; x=1781732529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=udmSzSUa6z+gUWugoUUUxrU6odPhMe9N3fOewRK4CqU=;
 b=QuWrurElQD1PN1RgXh8mSnJOh9oUFXcgXgmTQ66WSrlPV7BJ1F1S84nWkSbpOGGHF3
 dOatcEd87IpQH7HXFW5Er+v3u8OBLh1xzVGjzUCA/QWNZVLvjzCFq4U2hUyiyXaTOFZr
 54wXQyOeAHFMZHpS40AFQBRO7NLwrVj15hPJ/sLrTvClMraBK0T7gaF7B05h7yqlwerU
 u2LSBngTBtePNuwAc8NyK/DkoRf67RGsd2SvWEbQMXNMxHRo2yzIEn8r3YCg85Lb9MVO
 swv/KRD9NvjR2KYXuOma/Y6yDiXQraAbZB7If1XxW7RVYG+IQ2vj8ShgMaHOKSKjg+ue
 fB1A==
X-Gm-Message-State: AOJu0YxBxm68u+GSNTyZADxHqBOKccWemxY0Sg3aflWwtEyeDjxM7TBG
 3Pm68QPrduYomig25zOti5SZfbflQ3NzwqM8E7QF1YHT8wVHLpX7xryCKjBeJxl7jaArPe/I/Ko
 psZZ4irzDxrUfQE19Sx69K9Jnu7Og/HX/66j9MoumA5R0z5OKo7BFrxNRVc8/zS11Lg==
X-Gm-Gg: Acq92OHbhoW5BOFdHmQnB4IU0pSnAQeQqhUGYId9Xz2qzMQl35qjS3TF/5VaU8/JkAq
 61gS/cMD8x54E8ymPeiTzEwR4jrqqs1kuej02G+7ID33Q890wlTWfBwBP29Hg3mCHaRmNN0GXGD
 AVGAFrYF9/VrbHsGQyTyM9s2h9ZEAmsf8WWv9EoOqnTTbWe/FhbpjJm1QDbFYOVxq0c+5ltETLl
 zcIcC1au+JN+2jXRYNjqHQtoknMYueD2V3jMrl+uqz2IgSfFaP1ZLNROUap69YqeyRYtD1I+M+2
 KB51wc4lV8KUCKarVt62AnxOLM/RUerFPSZm55UT7cZoqGj/jeG4CwIRfneaFqPOXITfKeUpFWl
 JQwkMDhXPemG0AMg8oI29ZxjN+INgYRc+eJlRcPPZ1uaZPmTVVnOUqfn74jHV6AfTlz9vlw==
X-Received: by 2002:a05:622a:493:b0:517:9f43:4732 with SMTP id
 d75a77b69052e-517edd32107mr1276321cf.11.1781127728690; 
 Wed, 10 Jun 2026 14:42:08 -0700 (PDT)
X-Received: by 2002:a05:622a:493:b0:517:9f43:4732 with SMTP id
 d75a77b69052e-517edd32107mr1275761cf.11.1781127728273; 
 Wed, 10 Jun 2026 14:42:08 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5a6d777996csm20766280e0c.7.2026.06.10.14.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 14:42:07 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
 uwu@icenowy.me, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v8 5/7] hw/riscv/server_platform_ref.c: add platform bus and
 TPM support
Date: Wed, 10 Jun 2026 18:41:31 -0300
Message-ID: <20260610214133.1882563-6-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com>
References: <20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Pr71F-H_LmFuJpveLUnhTrVSK-Z1acjw
X-Proofpoint-GUID: Pr71F-H_LmFuJpveLUnhTrVSK-Z1acjw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDIwNyBTYWx0ZWRfXyoGKAnbA4acg
 o7T4pGuwbHcFsof5bqwB38cdtHhdOfwWHZqIIplnDjgqCLEvf71PjIsWam4u/ca6K+AYb0q4m/1
 QH8WwdptgZARXmt8t53Pg8sRK1hhA51+G+WeluQcRkKMQoaWObkX+AMp/J9WFom1w6ZtXPaVCTD
 oqAf2M28AdKLZlBBo8REk96bKvfsckUUTjMRASJYJJo0fxTXxuMaesR/Y6kJiTN8h/tUJn3/pKt
 vM6CCkzsZFFB+Rx8PVGUDb/LcBRYxfW//ZTL45lP/TYg0roXybaWXOKaCCZMZpeaEPpklP21Pqm
 d4Na7D23zQ2MirYvi2FXnLLH+kw8nVs7eF8vJ1LxqdEqovdwczxOFOS6FO0NV/0W2lh5o6Z5Agc
 1/h9/pOmANxrFBnD0kDn4IjY22Xs19I01w3Gdz0AAdBBlSBqY2+nOk/YOIzQrcq29oYUuG4PV3i
 JqbXGCJ6slRPhWdQtKQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEwMDIwNyBTYWx0ZWRfXxLTeojIDQ6UZ
 JileQmOgH5zdYGvDIFg8UWp/C3phGv7Wro+rquwvz8yZQ46Lie0LGLHu8NqzjQ2QZsTkqFRSFFy
 9cbEtMKCkk+oD1K+opknw4YtQ9QdwSc=
X-Authority-Analysis: v=2.4 cv=Lf0MLDfi c=1 sm=1 tr=0 ts=6a29da31 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=NLiCwHATAAAA:8
 a=EUspDBNiAAAA:8 a=HCLQLsBmYQwgZ2F9z0YA:9 a=1HOtulTD9v-eNWfpl4qZ:22
 a=F9tHCgz3TLBaZgltkx5D:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606100207
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

The RISC-V Server Platform spec requires a TPM device.  TPM devices in
QEMU comes usually in two flavors: emulated or passthrough.  A
passthrough device requires a host TPM device that the QEMU process can
borrow and it's usually coupled with KVM acceleration.

To use the TPM emulator we'll need help from an external TPM emulator
called swtpm.  More info can be found in [1].  For our purposes this is
a process that, if running Ubuntu, can be installed via 'swtpm' package.
We'll go back to it shortly.

For now, adding support for the emulated TPM device 'tpm-tis' (other TPM
flavors might work as well, 'tpm-tis' is the one tested with this work)
requires a platform bus.  Adding a platform bus will open the door for
more devices to be added in the board.  This is ok - a reference board
isn't a restricted board and users are free to add devices at their
leisure.

Here's how to use tpm-tis with the riscv-server-ref board after applying
this patch:

- in a separated shell/term run 'swtpm' (--log is optional):

$ mkdir /tmp/mytpm1
$ swtpm socket --tpmstate dir=/tmp/mytpm1 \
	--ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock \
	--tpm2 \
	--log level=20

Then start QEMU with:

$ qemu-system-riscv64 -M riscv-server-ref (...) \
	-chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
	-tpmdev emulator,id=tpm0,chardev=chrtpm\
	-device tpm-tis-device,tpmdev=tpm0

[1] https://qemu-project.gitlab.io/qemu/specs/tpm.html

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/Kconfig               |  1 +
 hw/riscv/server_platform_ref.c | 92 +++++++++++++++++++++++++++++++++-
 2 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 1807c423ff..d3912cbb1e 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -73,6 +73,7 @@ config RISCV_SERVER_PLATFORM_REF
     bool
     default y
     depends on RISCV64
+    imply TPM_TIS_SYSBUS
     select RISCV_NUMA
     select GOLDFISH_RTC
     select PCI
diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
index 7e626c6eb7..790d9861f3 100644
--- a/hw/riscv/server_platform_ref.c
+++ b/hw/riscv/server_platform_ref.c
@@ -14,6 +14,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-visit-common.h"
 #include "hw/core/boards.h"
+#include "hw/core/platform-bus.h"
 #include "hw/core/loader.h"
 #include "hw/core/sysbus.h"
 #include "hw/core/qdev-properties.h"
@@ -39,6 +40,7 @@
 #include "system/runstate.h"
 #include "system/system.h"
 #include "system/tcg.h"
+#include "system/tpm.h"
 #include "system/qtest.h"
 #include "target/riscv/cpu.h"
 #include "target/riscv/pmu.h"
@@ -72,6 +74,8 @@
 #define SYSCON_RESET     0x1
 #define SYSCON_POWEROFF  0x2
 
+#define RVSERVER_PLATFORM_BUS_NUM_IRQS 8
+
 #define TYPE_RISCV_SERVER_REF_MACHINE MACHINE_TYPE_NAME("riscv-server-ref")
 OBJECT_DECLARE_SIMPLE_TYPE(RISCVServerRefMachineState, RISCV_SERVER_REF_MACHINE)
 
@@ -88,6 +92,8 @@ struct RISCVServerRefMachineState {
     int fdt_size;
     int aia_guests;
     const MemMapEntry *memmap;
+
+    DeviceState *platform_bus_dev;
 };
 
 enum {
@@ -106,6 +112,7 @@ enum {
     RVSERVER_DRAM,
     RVSERVER_PCIE_MMIO,
     RVSERVER_PCIE_PIO,
+    RVSERVER_PLATFORM_BUS,
     RVSERVER_PCIE_ECAM,
     RVSERVER_PCIE_MMIO_HIGH
 };
@@ -114,7 +121,8 @@ enum {
     RVSERVER_UART0_IRQ = 10,
     RVSERVER_RTC_IRQ = 11,
     RVSERVER_PCIE_IRQ = 0x20, /* 32 to 35 */
-    IOMMU_SYS_IRQ = 0x24 /* 36 to 39 */
+    IOMMU_SYS_IRQ = 0x24, /* 36 to 39 */
+    RVSERVER_PLATFORM_BUS_IRQ = 40, /* 40 to 48 */
 };
 
 /*
@@ -147,6 +155,7 @@ static const MemMapEntry rvserver_ref_memmap[] = {
     [RVSERVER_IOMMU_SYS] =      {   0x102000,        0x1000 },
     [RVSERVER_ACLINT] =         {  0x2000000,       0x10000 },
     [RVSERVER_PCIE_PIO] =       {  0x3000000,       0x10000 },
+    [RVSERVER_PLATFORM_BUS] =   {  0x4000000,     0x2000000 },
     [RVSERVER_APLIC_M] =        {  0xc000000, APLIC_SIZE(RVSERVER_CPUS_MAX) },
     [RVSERVER_APLIC_S] =        {  0xd000000, APLIC_SIZE(RVSERVER_CPUS_MAX) },
     [RVSERVER_UART0] =          { 0x10000000,         0x100 },
@@ -214,6 +223,34 @@ static void rvserver_flash_maps(RISCVServerRefMachineState *s,
     rvserver_flash_map(s->flash[1], flashbase + flashsize, flashsize, sysmem);
 }
 
+static void create_platform_bus(RISCVServerRefMachineState *s,
+                                DeviceState *irqchip)
+{
+    DeviceState *dev;
+    SysBusDevice *sysbus;
+    int i;
+    MemoryRegion *sysmem = get_system_memory();
+
+    dev = qdev_new(TYPE_PLATFORM_BUS_DEVICE);
+    dev->id = g_strdup(TYPE_PLATFORM_BUS_DEVICE);
+    qdev_prop_set_uint32(dev, "num_irqs", RVSERVER_PLATFORM_BUS_NUM_IRQS);
+    qdev_prop_set_uint32(dev, "mmio_size",
+                         s->memmap[RVSERVER_PLATFORM_BUS].size);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    s->platform_bus_dev = dev;
+
+    sysbus = SYS_BUS_DEVICE(dev);
+    for (i = 0; i < RVSERVER_PLATFORM_BUS_NUM_IRQS; i++) {
+        int irq = RVSERVER_PLATFORM_BUS_IRQ + i;
+        sysbus_connect_irq(sysbus, i, qdev_get_gpio_in(irqchip, irq));
+    }
+
+    memory_region_add_subregion(sysmem,
+                                s->memmap[RVSERVER_PLATFORM_BUS].base,
+                                sysbus_mmio_get_region(sysbus, 0));
+}
+
 static void create_pcie_irq_map(RISCVServerRefMachineState *s,
                                 void *fdt, char *nodename,
                                 uint32_t irqchip_phandle)
@@ -585,6 +622,16 @@ static void create_fdt_socket_aplic(RISCVServerRefMachineState *s,
                          aplic_s_phandle, 0,
                          false, num_harts);
 
+    if (socket == 0) {
+        g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
+        MachineState *ms = MACHINE(s);
+
+        platform_bus_add_all_fdt_nodes(ms->fdt, aplic_name,
+                                       s->memmap[RVSERVER_PLATFORM_BUS].base,
+                                       s->memmap[RVSERVER_PLATFORM_BUS].size,
+                                       RVSERVER_PLATFORM_BUS_IRQ);
+    }
+
     aplic_phandles[socket] = aplic_s_phandle;
 }
 
@@ -1265,6 +1312,8 @@ static void rvserver_ref_machine_init(MachineState *machine)
 
     gpex_pcie_init(system_memory, pcie_irqchip, s);
 
+    create_platform_bus(s, mmio_irqchip);
+
     serial_mm_init(system_memory, memmap[RVSERVER_UART0].base,
         0, qdev_get_gpio_in(mmio_irqchip, RVSERVER_UART0_IRQ), 399193,
         serial_hd(0), DEVICE_LITTLE_ENDIAN);
@@ -1341,10 +1390,38 @@ static void rvserver_ref_set_aia_guests(Object *obj, const char *val,
     }
 }
 
+static HotplugHandler *rvserver_machine_get_hotplug_handler(MachineState *ms,
+                                                            DeviceState *dev)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+
+    if (device_is_dynamic_sysbus(mc, dev)) {
+        return HOTPLUG_HANDLER(ms);
+    }
+
+    return NULL;
+}
+
+static void rvserver_machine_device_plug_cb(HotplugHandler *hotplug_dev,
+                                            DeviceState *dev, Error **errp)
+{
+    RISCVServerRefMachineState *s = RISCV_SERVER_REF_MACHINE(hotplug_dev);
+
+    if (s->platform_bus_dev) {
+        MachineClass *mc = MACHINE_GET_CLASS(s);
+
+        if (device_is_dynamic_sysbus(mc, dev)) {
+            platform_bus_link_device(PLATFORM_BUS_DEVICE(s->platform_bus_dev),
+                                     SYS_BUS_DEVICE(dev));
+        }
+    }
+}
+
 static void rvserver_ref_machine_class_init(ObjectClass *oc, const void *data)
 {
     char str[128];
     MachineClass *mc = MACHINE_CLASS(oc);
+    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
     static const char * const valid_cpu_types[] = {
         TYPE_RISCV_CPU_RVSERVER_REF,
     };
@@ -1370,6 +1447,13 @@ static void rvserver_ref_machine_class_init(ObjectClass *oc, const void *data)
     sprintf(str, "Set number of guest MMIO pages for AIA IMSIC. Valid value "
                  "should be between 0 and %d.", RVSERVER_IRQCHIP_MAX_GUESTS);
     object_class_property_set_description(oc, "aia-guests", str);
+
+    assert(!mc->get_hotplug_handler);
+    mc->get_hotplug_handler = rvserver_machine_get_hotplug_handler;
+    hc->plug = rvserver_machine_device_plug_cb;
+#ifdef CONFIG_TPM
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
+#endif
 }
 
 static const TypeInfo rvserver_ref_typeinfo = {
@@ -1378,7 +1462,11 @@ static const TypeInfo rvserver_ref_typeinfo = {
     .class_init = rvserver_ref_machine_class_init,
     .instance_init = rvserver_ref_machine_instance_init,
     .instance_size = sizeof(RISCVServerRefMachineState),
-    .interfaces = riscv64_machine_interfaces,
+    .interfaces = (const InterfaceInfo[]) {
+         { TYPE_HOTPLUG_HANDLER },
+         { TYPE_TARGET_RISCV64_MACHINE },
+         { }
+    },
 };
 
 static void rvserver_ref_init_register_types(void)
-- 
2.43.0


