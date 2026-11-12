Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCEF606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EUC/teeJ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f08FxPiZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRTjI-00007H-1N; Thu, 12 Nov 2026 07:16:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRTiu-0007zg-6T
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 07:16:13 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRTiq-0002UY-Lu
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 07:16:11 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC7jDio126929
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 12:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=e4q7jxEweG9
 hpBMyv1buFc3LQm/Vfhh6LoFFh9SWwwM=; b=EUC/teeJuT8SzhOXnprZLhuBIMI
 OJxZp2hKBSc9Fiez+DX4saR+t9HAMUE7KD33vrhqjMINJq/18WR2h2nWhA1Pz/aA
 h6uiMOMk1Jhi9l6CBzNimaaJcZCllGvEPgO+UIRJ3e/HozzrsAaFunQZdGWQ7mk8
 9d1uO7hSa9crep9qZyb22a2h2yRHJrbZe5nkmjaUC2MrRV8cIJzYKJYDi338FPlW
 k5wymQvvuQSIc/rc/quJcLKt9FqDuXNpo1Jko7dffoGeL54SS6C/D8Nrl7xUGuwe
 tkvuiL5KFcYzkM3r29PtAy+4GrpskPKi2JAbAQ8K0hp7fy2wEEBp95g3NYw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw9a08xqd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 12:16:07 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-542fc61841eso87935381cf.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 04:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794485767; x=1795090567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e4q7jxEweG9hpBMyv1buFc3LQm/Vfhh6LoFFh9SWwwM=;
 b=f08FxPiZOjNrtoBD3BXT6um9Dh5JW5ggBSCSLHXOGbDzOF67rfXEINXk2ZxSEnwGyK
 sSpmoc8rgq9Kp1+KdCOvXZs+WPMJIyoPAdwg0lhAztIjag5Eg5HaFGGQWFPU3ptRQLss
 bd9Es86zW6LsRuDt2z0lu0YUhb8ZCgeRoJw9vAawi010Q40cJSHFak+FsVwdd2QXkY6i
 OWPD/vc/H76UAym5JtT1zzhqX0PhFKB9obKcj8EwCSX4AS8H2VejzM1rgzlbpydejIJy
 fsbbUtqZ1UhSk3wwdQC4WCiH3C67H5XnvjsrkkFfIg4J7FCP8mG+/E058q4x+50dFhTQ
 eSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794485767; x=1795090567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=e4q7jxEweG9hpBMyv1buFc3LQm/Vfhh6LoFFh9SWwwM=;
 b=OaDGxXs1F5AOsQQFPjWBUogUkrrWsmK9mN5pbkCzSR533tUgjNWW6fPWGwCof4wkJx
 Q+rMxw/IaFRBOuuqIPShubuZPVZ2OQ57+jT+r4rucNW/wEpfPLZVwH7+nkNKvo2JGgX+
 oNaQCEfh/+xLTL+egGlYp+oMxaHrR25xR5z8YVtpBmcwk0/JZG1XWdCtuPZx4YJwJo1u
 1aU2ytXbrieGcb6WE7JGvOROHtHGnBf710eBugsJdSa/MoFs65R6cXfn5Ku9Z0O5Papk
 VdKbN8SPsL+dmT2Lw0PJpg7JqDxxW1mNwPaWtO3ztMi5EjVHaEctkojZWpAc7Ze8Konu
 sWYA==
X-Gm-Message-State: APuU4Z8C/uA1FO7bCXc/Cf+ZUwJiEfeOSfYZ314mp12C4YZ0s+rCHEsw
 y9DRijYB6/1QR/+IR2UbAcYhcQwPzB6RlYE3oRTzfiBNmRT9ld1Rs2dNpN4iV6hjEzRuiKg+25y
 I38lujzAlVMTbHmkJUebWjHlbGmWJ0Ql9jWYeF5iPD0rIsIU+yQjWbEVWi2Mr/FPexQ==
X-Gm-Gg: AYBFou15EhO5OlzaJ2Y7K/Lqoe0XV36WgZ2qPfsrfPsNwORji3+VXREkgWbP9fMq5mp
 SyETdIvkl/4mY4pmqMjgY7ncEWTERkBy9g9aeUyn1xxbW3OIwWqX/Tjcl8AtqE38miPOZaGlhEi
 TZpO+VCQ0kIYWSlzud7erZt27ecvQOOgCbPYYZefoaRpSLZ+23ntVR9JGZATq9anR71okHA8i1v
 d7ug+5KIG05aoxlEHpN9Ipy5v/DzmewljBzhLrI4YZTACFC1hWrvSloYn2CabXTFmEx4o/FN+kD
 A0CgQTq8SXnGE6MQdmG1QvtIS3PLg+UMw4l+IcGXC2gORoEYZ1a7xVDSqkoSw8z1Jn6dl6G2T7T
 oXYY61EjKVSD2Te4pEAm/YsqOZkYin15T7EcuSf88UFn9Fa9o+DEoVUeyBS0GMhogHzJnhKy6R5
 RNAKPMuZzHiJy7vUR54tk1gWS90e3fYseNuBE8usiVRkai
X-Received: by 2002:a05:622a:1651:b0:537:dea7:adb1 with SMTP id
 d75a77b69052e-556bdce0a89mr85838001cf.4.1794485766872; 
 Thu, 12 Nov 2026 04:16:06 -0800 (PST)
X-Received: by 2002:a05:622a:1651:b0:537:dea7:adb1 with SMTP id
 d75a77b69052e-556bdce0a89mr85837581cf.4.1794485766340; 
 Thu, 12 Nov 2026 04:16:06 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com (189-68-253-226.dsl.telesp.net.br.
 [189.68.253.226]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5550af6096asm73538651cf.5.2026.11.12.04.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 04:16:04 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 2/5] hw/riscv: make UART FDT helper consider baud rate
Date: Thu, 12 Nov 2026 09:15:50 -0300
Message-ID: <20261112121553.485439-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112121553.485439-1-daniel.barboza@oss.qualcomm.com>
References: <20261112121553.485439-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RK4GdZZcNdCzIGsD4fBMj66kfhXnRO34
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0OCBTYWx0ZWRfX4aJ/hWB35ayo
 G/hr355KdUa4Bk4pzWSqRgBWKo8ipo8PIfI0QcDMLz3SQHCgXinIi0NY35LFGC3zVzFZ5Bm/Tx6
 Va2Om/Ew4f7bVxddoZOLWq+WFswKNh3qKx+uq1Q5xPF1s9LRdwvLF9u0u1Im58TSnqGYLU5QH4z
 kw0YAFvU1HrK8IIyPFqX3ZabodeoKD5St5u8nYy3nLSoAiAQ0flgurNOsZuOoS1GEzwE36EuBhA
 6VAgPovA9MBht01IRMEwy8K3kkIp376wdnmWJAgnYzLwG6xjycc3abIjDZkT/+5B4VqJHXbi811
 B6B3AA1eMXNw3UL2vciALeXrYQLb2gsrgHS/SdJ7MAFBHsFZqe27h8tHl0HkF/pXWRV9xmGIlCH
 gUbzb8rhhh4F/5TNG6IBZ452JTTtTA0p5JVkm3ZcNrUAbcbTXHV0vhk/OLBYViHGvEoCGCvrqri
 IarpHs4IfUBE46Rk39Q==
X-Proofpoint-ORIG-GUID: RK4GdZZcNdCzIGsD4fBMj66kfhXnRO34
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0OCBTYWx0ZWRfX1mfXzOU5WCok
 b9SxhQamxKW7fI2WYPNlTgnfYlG3hwEJA173NPMVBJTNDnmModPUCNaOai/RtO1tj9ebIijNd59
 yAxFJONdZJE9jFbCtTFOnS3jusacUl4=
X-Authority-Analysis: v=2.4 cv=COG/zhrD c=1 sm=1 tr=0 ts=6af5ae07 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xcxBfRYLw5hNHjR815/AfA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=JF9118EUAAAA:8 a=uxJGSlK6fkZaI5NcCCYA:9 a=kacYvNCVWA4VmyqE58fU:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120048
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

riscv_create_fdt_uart() is defaulting to a 3.6864 Mhz clock, which Linux
will interpret as a 230400 base baud serial.

We need more flexibility to set a different baud rate for UART devices.
Add an optional 'base_baud' parameter that allows callers to set a baud
rate for the related device.  We're keeping the existing default in case
the caller does not care to provide a base baud.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>`
---
 hw/riscv/fdt-common.c          | 19 +++++++++++++++++--
 hw/riscv/server_platform_ref.c |  1 +
 hw/riscv/virt.c                |  4 ++--
 include/hw/riscv/fdt-common.h  |  1 +
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index ce2dcb43b4..abb913faec 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -22,7 +22,11 @@
 #include "hw/pci/pcie_host.h"
 #include "hw/riscv/aia.h"
 
-#define UART_STD_CLOCK_FREQ 3686400 /* 3.6864 MHz */
+ /*
+  * This 3.6864 MHz default clock results in a base
+  * baud of 230400 symbols/second.
+  */
+#define UART_STD_CLOCK_FREQ 3686400
 
 void *riscv_create_board_device_tree(const char *model, const char *compatible,
                                      int *fdt_size)
@@ -807,11 +811,14 @@ char *riscv_fdt_get_uart_nodename(hwaddr addr)
     return g_strdup_printf("/soc/serial@%"HWADDR_PRIx, addr);
 }
 
+/* If base_baud = 0 this function assumes a base baud of 230400.  */
 void riscv_create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
                            int uart_irq, int aia_type,
+                           int base_baud,
                            uint32_t irq_phandle)
 {
     g_autofree char *name = riscv_fdt_get_uart_nodename(uart_mem->base);
+    uint64_t clock_freq = UART_STD_CLOCK_FREQ;
 
     qemu_fdt_add_subnode(fdt, name);
     qemu_fdt_setprop_string(fdt, name, "compatible", "ns16550a");
@@ -819,7 +826,15 @@ void riscv_create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
                                  2, uart_mem->base,
                                  2, uart_mem->size);
 
-    qemu_fdt_setprop_cell(fdt, name, "clock-frequency", UART_STD_CLOCK_FREQ);
+    if (base_baud != 0) {
+        /*
+         * The base baud formula is base_baud = clock_freq / 16,
+         * ergo clock_freq = base_baud * 16.
+         */
+        clock_freq = base_baud * 16;
+    }
+
+    qemu_fdt_setprop_cell(fdt, name, "clock-frequency", clock_freq);
     qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", irq_phandle);
 
     if (aia_type == AIA_TYPE_NONE) {
diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
index f8016e14b0..d727ea6c41 100644
--- a/hw/riscv/server_platform_ref.c
+++ b/hw/riscv/server_platform_ref.c
@@ -315,6 +315,7 @@ static void finalize_fdt(RISCVServerRefMachineState *s)
 
     riscv_create_fdt_uart(ms->fdt, &rvserver_ref_memmap[RVSERVER_UART0],
                           RVSERVER_UART0_IRQ, AIA_TYPE_APLIC_IMSIC,
+                          0,
                           irq_mmio_phandle);
     name = riscv_fdt_get_uart_nodename(rvserver_ref_memmap[RVSERVER_UART0].base);
     qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 88de49aa6e..dd1b02a7b3 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -391,11 +391,11 @@ static void create_fdt_uarts(RISCVVirtState *s, uint32_t irq_mmio_phandle)
 
     if (s->uart1_present) {
         riscv_create_fdt_uart(ms->fdt, &s->memmap[VIRT_UART1],
-                              UART1_IRQ, s->aia_type, irq_mmio_phandle);
+                              UART1_IRQ, 0, s->aia_type, irq_mmio_phandle);
     }
 
     riscv_create_fdt_uart(ms->fdt, &s->memmap[VIRT_UART0], UART0_IRQ,
-                          s->aia_type, irq_mmio_phandle);
+                          s->aia_type, 0, irq_mmio_phandle);
 
     name = riscv_fdt_get_uart_nodename(s->memmap[VIRT_UART0].base);
     qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index eb9db8278d..ee664983f4 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -132,6 +132,7 @@ void riscv_create_fdt_socket_aclint(void *fdt, ACLINTFdtProps *props,
 char *riscv_fdt_get_uart_nodename(hwaddr addr);
 void riscv_create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
                            int uart_irq, int aia_type,
+                           int base_baud,
                            uint32_t irq_phandle);
 void riscv_create_fdt_rtc(void *fdt, const MemMapEntry *rtc_mem,
                           int rtc_irq, int aia_type,
-- 
2.43.0


