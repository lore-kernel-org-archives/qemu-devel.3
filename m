Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C884DC61DC4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzGo6-0006L8-UC; Wed, 26 Aug 2026 12:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzGo5-0006KR-R0
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:48:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzGo2-0000ua-KS
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:48:57 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QDuhmA593245
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 16:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Xyfb4mSOeeb
 e5SMBMgaaEXrMgVex1VVAnMIYSpdlvyc=; b=csM5WrDltbvED0aGy2iPxMuZLt4
 J/RHXkS35L5HhRdv9OrL/JulhcLvEn10I4Lh4RlrGhWyHt1cFWaS8mk8nYVGfp03
 C2/pfJgUNAtHO6s58aTSR26WQhBjN3dHNqCD9xqYwPxB361264oZly7j5lT3Zt4k
 7xgqHkryhjum2ad5vcqx0jGKDeg4CpITZNKKK+waSE2fqHIProo7DkCYLqvemdCx
 0cS0O1I36DzkJshDkzR/zeYbsB9oJhyhAetlTsXuWq6WDZz1KONLyHnpBWmbwHsG
 J2H09kqRZ0o+YBRisTcrCrIDmEZe5Scpzh5odm+9BAQYru2P7Ul6jg+9ptQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9s9gaum9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 16:48:43 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ea75996387so23964896d6.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 09:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787762923; x=1788367723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xyfb4mSOeebe5SMBMgaaEXrMgVex1VVAnMIYSpdlvyc=;
 b=YGK+/3iwYFONDzZvRQ00E6uYBhcOl9xN4NNQorwNqGnAJIzPKY+pt9Qa7uKpiAMXVr
 Mca3d5GUM+g8+/4+Xsb4fFiEP3l+TWFFU9IDsuE5rMSenAJTvd4Mv/k6jAjXQLGldeFP
 TjdMK/XnFD3FMxLal00nJ6YHhYw2xecBtNWuqeOxQtcCmE8pixi179CLz/CSl4AXykpF
 7IOl7eXvMP5GL40s8x2NXlj9I9T8l7KO3w8OclUHnR5QFeasHGO04x5baihM187Tos/2
 ode6Qxv2vbxYQLqcTYAHcHsVBucu9asEFPMArMxNMLsIqLSAP4/KqQIJNuVc3k2/xlFV
 aWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762923; x=1788367723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xyfb4mSOeebe5SMBMgaaEXrMgVex1VVAnMIYSpdlvyc=;
 b=TUgjw0ZMhNUrDfLcYAKVgR6BWAyAlm+HvZrAszgcJMwtCyFpC6i/ShecrW9Bo52uvz
 IIhzXdPPZTlK+0uNUN3USXuW33OCb1olm3eUZQ+bcMgYzmJhY+7uB1gcykDdqGkyL7nI
 0/lMsc7aEfzGhdOUBi3Z3jvDJtt4FhzDbIi7TZOQ/Df1WbmSb92Om27NAG9v0eH37gTC
 648EoVdjWIZA4G/hYYwM/NkOnuk5Gu+yYye8jaHtor6h+axH4BeFcgEHCvPlDSlE7O/v
 KEXxO196YnL6apLj8M3olk3oZKfixvQCorhz3gKKI51xFPYSbNSTLOL2c0kmXu7xzwdy
 RD8A==
X-Gm-Message-State: AFuF++kDK50JkiVGQc+K7FAQhUcr7j+JLM9xCi313ydNmW/Pl6F1p6gT
 HwTtjfLtRXNJsvxPCVjWUzRaGDhwlurLtN2jSQh8jjt/WosIyWBvj9oRW0+gKwrbijnIPZAkthI
 cpLyx+k8MC7otiLUFAfkzMe4UK04vVwzWgD53Xi9r1BL7q0raGxgo5vprbxwqmKbFLA==
X-Gm-Gg: AR+sD13X/8+xDXNUugrnvI2QPTy2wctxinCYb2WTywULa0aeeFDvANHihb9dcajbhSL
 5hBsdM7RnHTVys+yOk8om+wMDKGUgIj9SBtwIAnvNvWoQsRF7Ts0OSlFvqXKTe/RAoMVUhcjT2b
 sdd5xRXmbO/25Mvfwey6lKyrhCcKi3d1YjPUviO+AG3nALH5ExL2Y576tXyKuer1hbtKW6LHz4w
 E5tMi0Vn11Bf4FuOB0RnH3h84jbrEDgtdRMv8ezQOI0+JXOtsKpgPc7T5tfo8ydBfHJALMrBdOo
 6jJ0lmINMrnRIJH7RRbDAnea6pkUe/BCQpItymu6/npS8jml4b/+yuM2y6n7y5YSKJol6cdvfgz
 1wFP6aXoC9O9qANv1pDlEPV7PiGl702lw+tiMyA==
X-Received: by 2002:a05:622a:1192:b0:52b:6543:d8a with SMTP id
 d75a77b69052e-52e423205a4mr79351321cf.26.1787762922718; 
 Wed, 26 Aug 2026 09:48:42 -0700 (PDT)
X-Received: by 2002:a05:622a:1192:b0:52b:6543:d8a with SMTP id
 d75a77b69052e-52e423205a4mr79350541cf.26.1787762922100; 
 Wed, 26 Aug 2026 09:48:42 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52e4275fc3esm20092651cf.25.2026.08.26.09.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:48:41 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Joel Stanley <joel@jms.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH v2 08/13] hw/riscv/fdt-common, virt.c,
 tt_atlantis.c: add create_fdt_uart()
Date: Wed, 26 Aug 2026 13:48:08 -0300
Message-ID: <20260826164814.44335-9-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826164814.44335-1-daniel.barboza@oss.qualcomm.com>
References: <20260826164814.44335-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5GGLslkiaEI2oflHsn4y7w3es482vWcy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0MCBTYWx0ZWRfX+vfYB9aVzXd9
 VI3tlye7Gb0nF7zJ1dfX2xp9wwJSvySaFGEq9MjNjQ1rC1VFMHx7Gzw5Ms5MFBHS5Y3fIndUEWC
 ewr+6UNz8NHgAwVP7bg6OZtY6oXQkh/Ar8Kz3Ao4G29PiEGDMFXMRPDX6c2IBTKwbnnNkLYbJOe
 aMdf4L/fKOKtesK6UXDrvHYTA/fK6YqbCChgZ50IUomZ4QFSNBAZAvad1XiKF0A2lXjkWzWMFyQ
 HocbsfxhqAeMHx+GnJ0RSnlYqp8Y2scpmKGr2Kaihnz92cZuDpK6r3yj46shwxnSDLtOcOBnDdT
 NmLjFP7QRZ3Z7PbjUQifHCJXvpCg3STImTANiFjnwGWeTmy4aMGnMy1AgJA/ehtT98ASKziIf75
 6B4160Q4c8m9fJZ59oGLBTr2e5IQHMqPGcs9syXGbLaS4mSzuw4e0VmDZ9GBwcdr5V2kaUin1Jq
 NoYj/UOAOYVLZxsTymQ==
X-Authority-Analysis: v=2.4 cv=Xfq5Co55 c=1 sm=1 tr=0 ts=6a8f18eb cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=t9496tuAAAAA:8
 a=EUspDBNiAAAA:8 a=ZXiSWbBV69HJ4aRO-VQA:9 a=iYH6xdkBrDN1Jqds4HTS:22
 a=4wQ91nGE5lQcD7eh5OX0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0MCBTYWx0ZWRfXy/4gHVrXP3u2
 ih+105hO2ErXBwhEN5Ot2lbtYJ2OYG69S2HZc+wOVnlRnZaWhMMaTARMMlpvh/ygv1RRg4wBDQJ
 FeqbQku8GYlXtlS/sToJ8moXgT0puZs=
X-Proofpoint-ORIG-GUID: 5GGLslkiaEI2oflHsn4y7w3es482vWcy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260140
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

Add a common uart FDT helper to be used by 'virt' and 'tt-atlantis'.

To accomodate both boards the helper is doing the following:
- an 'uses_32_bit_spacing' flag controls whether we need to set a
  different uart reg spacing for the 'tt-atlantis' board;
- an 'is_serial0' flag is added to control whether we need to set
  additional properties related to the first serial.  This is required
  because the 'virt' board adds two uarts in the FDT.

No FDT changes intended.

Reviewed-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         | 39 +++++++++++++++++++++++++++++++
 hw/riscv/tt_atlantis.c        | 21 +----------------
 hw/riscv/virt.c               | 44 +++++++----------------------------
 include/hw/riscv/fdt-common.h |  4 ++++
 4 files changed, 52 insertions(+), 56 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index f31cc9d3cc..d254534654 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -791,3 +791,42 @@ void create_fdt_socket_aclint(void *fdt, ACLINTFdtProps *props,
         g_free(name);
     }
 }
+
+void create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
+                     int uart_irq, int aia_type,
+                     bool uses_32_bit_spacing, bool is_serial0,
+                     uint32_t irq_mmio_phandle)
+{
+    g_autofree char *name = NULL;
+
+    name = g_strdup_printf("/soc/serial@%"HWADDR_PRIx, uart_mem->base);
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "ns16550a");
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
+                                 2, uart_mem->base,
+                                 2, uart_mem->size);
+
+    /*
+     * The tt-atlantis board uses an uart that has 32 bit
+     * register spacing (0x0, 0x4, 0x8, 0xc....) rather than
+     * 8 bit spacing like 'virt'.
+     */
+    if (uses_32_bit_spacing) {
+        qemu_fdt_setprop_cell(fdt, name, "reg-shift", 2);
+        qemu_fdt_setprop_cell(fdt, name, "reg-io-width", 4);
+    }
+
+    qemu_fdt_setprop_cell(fdt, name, "clock-frequency", 3686400);
+    qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", irq_mmio_phandle);
+
+    if (aia_type == AIA_TYPE_NONE) {
+        qemu_fdt_setprop_cell(fdt, name, "interrupts", uart_irq);
+    } else {
+        qemu_fdt_setprop_cells(fdt, name, "interrupts", uart_irq, 0x4);
+    }
+
+    if (is_serial0) {
+        qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", name);
+        qemu_fdt_setprop_string(fdt, "/aliases", "serial0", name);
+    }
+}
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index d808bcc11c..eb22b67b71 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -259,25 +259,6 @@ static void create_fdt_cpu(TTAtlantisState *s, const MemMapEntry *memmap,
                          IRQ_S_EXT, s->soc.num_harts);
 }
 
-static void create_fdt_uart(void *fdt, const MemMapEntry *mem, int irq,
-                            int irqchip_phandle)
-{
-    g_autofree char *name = g_strdup_printf("/soc/serial@%"HWADDR_PRIX,
-                                            mem->base);
-
-    qemu_fdt_add_subnode(fdt, name);
-    qemu_fdt_setprop_string(fdt, name, "compatible", "ns16550a");
-    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, mem->base, 2, mem->size);
-    qemu_fdt_setprop_cell(fdt, name, "reg-shift", 2);
-    qemu_fdt_setprop_cell(fdt, name, "reg-io-width", 4);
-    qemu_fdt_setprop_cell(fdt, name, "clock-frequency", 3686400);
-    qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", irqchip_phandle);
-    qemu_fdt_setprop_cells(fdt, name, "interrupts", irq, 0x4);
-
-    qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", name);
-    qemu_fdt_setprop_string(fdt, "/aliases", "serial0", name);
-}
-
 static void create_fdt_rng(void *fdt)
 {
     uint8_t rng_seed[32];
@@ -345,7 +326,7 @@ static void finalize_fdt(TTAtlantisState *s)
      */
 
     create_fdt_uart(fdt, &s->memmap[TT_ATL_UART1], TT_ATL_UART1_IRQ,
-                    aplic_s_phandle);
+                    AIA_TYPE_APLIC_IMSIC, true, true, aplic_s_phandle);
 
     create_fdt_clk(fdt, "periph-clk", 100000000, periph_clk_phandle);
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index ef2670f20e..e4bf9c26ef 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -415,41 +415,6 @@ static void create_fdt_virtio(RISCVVirtState *s, uint32_t irq_virtio_phandle)
     }
 }
 
-static void create_fdt_uart(RISCVVirtState *s,
-                            uint32_t irq_mmio_phandle, int memId, int irqNo)
-{
-    g_autofree char *name = NULL;
-    MachineState *ms = MACHINE(s);
-
-    name = g_strdup_printf("/soc/serial@%"HWADDR_PRIx,
-                           s->memmap[memId].base);
-    qemu_fdt_add_subnode(ms->fdt, name);
-    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "ns16550a");
-    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
-                                 2, s->memmap[memId].base,
-                                 2, s->memmap[memId].size);
-    qemu_fdt_setprop_cell(ms->fdt, name, "clock-frequency", 3686400);
-    qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent", irq_mmio_phandle);
-    if (s->aia_type == VIRT_AIA_TYPE_NONE) {
-        qemu_fdt_setprop_cell(ms->fdt, name, "interrupts", irqNo);
-    } else {
-        qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", irqNo, 0x4);
-    }
-
-    if (VIRT_UART0 == memId) {
-        qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
-        qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", name);
-    }
-}
-
-static void create_fdt_uarts(RISCVVirtState *s, uint32_t irq_mmio_phandle)
-{
-    if (s->uart1_present) {
-        create_fdt_uart(s, irq_mmio_phandle, VIRT_UART1, UART1_IRQ);
-    }
-    create_fdt_uart(s, irq_mmio_phandle, VIRT_UART0, UART0_IRQ);
-}
-
 static void create_fdt_rtc(RISCVVirtState *s,
                            uint32_t irq_mmio_phandle)
 {
@@ -571,7 +536,14 @@ static void finalize_fdt(RISCVVirtState *s)
                       s->memmap[VIRT_TEST].base, s->memmap[VIRT_TEST].size,
                       FINISHER_RESET, FINISHER_PASS, true);
 
-    create_fdt_uarts(s, irq_mmio_phandle);
+    create_fdt_uart(MACHINE(s)->fdt, &s->memmap[VIRT_UART0], UART0_IRQ,
+                    s->aia_type, false, true, irq_mmio_phandle);
+
+    if (s->uart1_present) {
+        create_fdt_uart(MACHINE(s)->fdt, &s->memmap[VIRT_UART1],
+                        UART1_IRQ, s->aia_type, false, false,
+                        irq_mmio_phandle);
+    }
 
     create_fdt_rtc(s, irq_mmio_phandle);
 }
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index fbcf9aaffb..9a80e0734d 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -123,4 +123,8 @@ void create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
                              uint32_t *aplic_phandles);
 void create_fdt_socket_aclint(void *fdt, ACLINTFdtProps *props,
                               uint32_t *intc_phandles);
+void create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
+                     int uart_irq, int aia_type,
+                     bool uses_32_bit_spacing, bool is_serial0,
+                     uint32_t irq_mmio_phandle);
 #endif
-- 
2.43.0


