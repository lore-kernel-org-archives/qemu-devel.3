Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B056DC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziYn-0005cz-QO; Thu, 27 Aug 2026 18:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wziYl-0005bG-3I
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:26:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wziYj-0001HN-A3
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:26:58 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLt0E218796
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:26:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ww20UHCytpYfmXwQSUWXlkp90oJj802gkwqny88ex6U=; b=clZVBoxHDP3sBrOw
 GgOOUcFlZm1TxNmRMox0Qx5jzBsQI8Ur5qIdYeZpoMJaNtqDrpyn703iXYwXgauN
 H5gGfdQaJPE5ArCVuqf3xNGbFw1LcEG66z86HY4oIcZ+8+jNvBkpXYD3CB2Wbzxj
 7I2BRwZqR0xrH2b+Go9p/x8pExorfX3KJP55/G/UUzf1mIlc1ta6+/998OBjLfeZ
 zp33V7h7RNtIIuN0VPZbg0vfOf1BGNkYfKKb1mG991WG03UxRNBoemEzjMBlF0Kp
 L/zJe6RfcHbEZrXZpCwmX0jQiYntEuACaLh6O/5tFbFix84/OrJCyktNwve5S9pT
 tYhpAA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gaphw23b6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:26:46 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93903622880so137905685a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869605; x=1788474405; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ww20UHCytpYfmXwQSUWXlkp90oJj802gkwqny88ex6U=;
 b=HwYYsa+VRS+yptvQY8XbFJku9EPO07ObIezWmUV6Aa2NqPwWr4kXT/3gRvQKiLPDAy
 I5Iq1xINeK+ct8HbHAoab/s8C06sLn2oNMOtcoEM5Zvmtkit6BHLY2ly36O5ZydLobKj
 A4X/2z6cXENKj/D5pMCs8JDt5/d/33uq+KMcWkIGS25Ijf06bFI2MwoS/Dt0/v2DnCbp
 xbB600sNCvQHRUQ1foWldTVamIN2wLygIiUIpDA90CmtOLXxsqaMSXSUyGaMCRnX82gQ
 9RP5+GEqzKYi+8ayqlpyQEPbdDmD++0+iEoBrYhRT2+5ktzzD5uToCWKTAfksT2IHZDJ
 3ysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869605; x=1788474405;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ww20UHCytpYfmXwQSUWXlkp90oJj802gkwqny88ex6U=;
 b=iqe2VSmaWYpvcVQIGtklYeIOoHWgUhHVsKquSGwkzOYQYRUlQqWMFSNX/KOWdmvf6R
 7hc7k1vp7hcuNirVd4X1PzUwC8ce0ubOXYwIo+UoGrhjL17ljSPXI/sQZ5qmDfwFhiyP
 r3KSlcGpMtEsP1rFUM4BNzaNJqvcKnYlMB9WLT71cNQYuogfhxGU4NAUB2KSvRdyuBsi
 lJ5shd/0BOKjk/yIR/xVLwVFvSTTLxwTdI9B+L2jBmaLliArpmw86w8g6tR0yU/7Sedz
 eX/PZMfQyHbCFBl4r/xKCUuANsUM5sWD/lmOENl10pG8+Lgs9KS+tZHqiMxQCJy57b/3
 8JSQ==
X-Gm-Message-State: AFuF++n4qKFsw6uGBw+bRzgwwAedBZZJG3nn+IZyzd6TxYRs7yKLT3uW
 bE9RijJqLABIN40KzONaz6eDqCYmdDRLgL2Cv66EtjmtB7KIchoYbdZW61EWTnLEUN0E2uD1ysa
 49KVP8AR4p5Zpl/IQbIJtBvwqCEp67NOBK20/ECdfrA4UQnidpaO3irkCRLRAbE0j+g==
X-Gm-Gg: AR+sD11ruJUvguwLd0dRjHfOblkRZuJdgdTSFgNBrBUeWdkk6Labb+aOxj8CkrcCyuI
 m9lekwIaDkcYlVj5IfSQr7ReRdVmJTiroJlZ5ntbxiX045w4A+Ivr2WGE+fbD4M+UGomLpcciz3
 Rci2UVaE7dOftDE7b0BiYuKqn2UCsggO0/Ec2ywAZtFDCA2mEw1Tiq/uGEA3h8dK3b98vJwdgEs
 f8qveifYAJZ8Q5rqVAfLn5jMTMvb6anevbedgvtVg/7g07I/rZ9oWHIfLMnnym3dTgaM91ewOe7
 2eOgoMUUSe1BSz7SIufwO9YNxEPqlQplQvq2tRwxe+VyclbAd+PSHq3ox2IjupNeGIsSlEh1gj4
 N+DlImoZgBAtBkZZ//8byo3EIk/1/NDBbpKiIvA==
X-Received: by 2002:a05:620a:ecd:b0:937:45fb:94bf with SMTP id
 af79cd13be357-9391246bc74mr262885185a.0.1787869605528; 
 Thu, 27 Aug 2026 15:26:45 -0700 (PDT)
X-Received: by 2002:a05:620a:ecd:b0:937:45fb:94bf with SMTP id
 af79cd13be357-9391246bc74mr262881285a.0.1787869605074; 
 Thu, 27 Aug 2026 15:26:45 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939173a734dsm8924985a.26.2026.08.27.15.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:26:44 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 09/14] hw/riscv/fdt-common,
 virt.c: add riscv_create_fdt_uart()
Date: Thu, 27 Aug 2026 19:26:02 -0300
Message-ID: <20260827222608.329788-10-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827222608.329788-1-daniel.barboza@oss.qualcomm.com>
References: <20260827222608.329788-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Sbltf2VzzShhNZKicqg-LvkqUcHFYAya
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX4TQk1AG+hx0M
 rPNk7dmtr/Vh2KtdIPDeW9B7J2KDC/HQhF0cFm7RlEFxHlQmAj47vmvN38063lPsNpmsquyghOy
 VaDarXoWJyb9XB7YoPOv6a0wdlwIZbQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX6p/DgYmdqzEn
 zJmZHmRs+wtWToumJFXSpErvmGa+tbPDVvGSjL/40Rru27IKB5YGa3Xl3SbqA7FFOFd0g82AI+x
 thO9t80PPXTMYpYPhCUbqg0uhsHz5Oirj+rX2hFIs/yAW6hXCRDWW9cjaSLGOOzxmfbL+yy+VUb
 7Zaembr/mXNPvUvasL/fNYk5SXK3o5+W6DUqIVUEhsQl0YwKYp7uUAmg53VyEeJjHCf0aQ2uk2b
 fsgo/MMSUu2lWtO/XZ2rsegYXDX4lg0lytzRSDTwn0LUYfvI3/mahmprjdn6RV1XE1YCQByGFjr
 hcVTIVftqv3+Z2eN0t38obrNGhUwrhZ8H1hS+XEaaV+EA0q8wzok8AdNsr9hhXgDyYEYmMR6/oF
 0pt8OB+PIpoXDUjD61XdlOtiwyZv0cZLJs9KWdI6/o86I02IBh8d29dW9wUUpYKd5avH6ih9UJ8
 259JymA9mRvZNgko29w==
X-Proofpoint-ORIG-GUID: Sbltf2VzzShhNZKicqg-LvkqUcHFYAya
X-Authority-Analysis: v=2.4 cv=E8b9Y6dl c=1 sm=1 tr=0 ts=6a90b9a6 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Rd_eAvTXF2ongSiteCUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0
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

Add a common uart FDT helper to be used by 'virt' and the future
'riscv-server-ref' board.

The 'tt-atlantis' board is left out of this patch because it's going
through UART related changes and its FDT might change soon, thus it's
better to wait for the final DT to be determined and then we can
evaluate whether it can share a common helper.

The "/chosen" and "/alias" changes are UART0 only so we're keeping them
out of the common helper.  The board can set both manually as
appropriate.

No FDT changes intended.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         | 29 +++++++++++++++++++++++++++++
 hw/riscv/virt.c               | 35 +++++++++--------------------------
 include/hw/riscv/fdt-common.h |  5 +++++
 3 files changed, 43 insertions(+), 26 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index 76a783709d..e8186230b7 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -22,6 +22,8 @@
 #include "hw/pci/pcie_host.h"
 #include "hw/riscv/aia.h"
 
+#define UART_STD_CLOCK_FREQ 3686400 /* 3.6864 MHz */
+
 void *riscv_create_board_device_tree(const char *model, const char *compatible,
                                      int *fdt_size)
 {
@@ -798,3 +800,30 @@ void riscv_create_fdt_socket_aclint(void *fdt, ACLINTFdtProps *props,
         g_free(name);
     }
 }
+
+char *riscv_fdt_get_uart_nodename(hwaddr addr)
+{
+    return g_strdup_printf("/soc/serial@%"HWADDR_PRIx, addr);
+}
+
+void riscv_create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
+                           int uart_irq, int aia_type,
+                           uint32_t irq_phandle)
+{
+    g_autofree char *name = riscv_fdt_get_uart_nodename(uart_mem->base);
+
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "ns16550a");
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
+                                 2, uart_mem->base,
+                                 2, uart_mem->size);
+
+    qemu_fdt_setprop_cell(fdt, name, "clock-frequency", UART_STD_CLOCK_FREQ);
+    qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", irq_phandle);
+
+    if (aia_type == AIA_TYPE_NONE) {
+        qemu_fdt_setprop_cell(fdt, name, "interrupts", uart_irq);
+    } else {
+        qemu_fdt_setprop_cells(fdt, name, "interrupts", uart_irq, 0x4);
+    }
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 717a01da8d..3e40513dc1 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -418,39 +418,22 @@ static void create_fdt_virtio(RISCVVirtState *s, uint32_t irq_virtio_phandle)
     }
 }
 
-static void create_fdt_uart(RISCVVirtState *s,
-                            uint32_t irq_mmio_phandle, int memId, int irqNo)
+static void create_fdt_uarts(RISCVVirtState *s, uint32_t irq_mmio_phandle)
 {
     g_autofree char *name = NULL;
     MachineState *ms = MACHINE(s);
 
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
+    if (s->uart1_present) {
+        riscv_create_fdt_uart(ms->fdt, &s->memmap[VIRT_UART1],
+                              UART1_IRQ, s->aia_type, irq_mmio_phandle);
     }
 
-    if (VIRT_UART0 == memId) {
-        qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
-        qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", name);
-    }
-}
+    riscv_create_fdt_uart(ms->fdt, &s->memmap[VIRT_UART0], UART0_IRQ,
+                          s->aia_type, irq_mmio_phandle);
 
-static void create_fdt_uarts(RISCVVirtState *s, uint32_t irq_mmio_phandle)
-{
-    if (s->uart1_present) {
-        create_fdt_uart(s, irq_mmio_phandle, VIRT_UART1, UART1_IRQ);
-    }
-    create_fdt_uart(s, irq_mmio_phandle, VIRT_UART0, UART0_IRQ);
+    name = riscv_fdt_get_uart_nodename(s->memmap[VIRT_UART0].base);
+    qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
+    qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", name);
 }
 
 static void create_fdt_rtc(RISCVVirtState *s,
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index a45b063f66..c8b25348bd 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -128,4 +128,9 @@ void riscv_create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
                                    uint32_t *aplic_phandles);
 void riscv_create_fdt_socket_aclint(void *fdt, ACLINTFdtProps *props,
                                     uint32_t *intc_phandles);
+/* Caller must free the returned string.  */
+char *riscv_fdt_get_uart_nodename(hwaddr addr);
+void riscv_create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
+                           int uart_irq, int aia_type,
+                           uint32_t irq_phandle);
 #endif
-- 
2.43.0


