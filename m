Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16048606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=laOeNrkg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WozmlTfv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHqZ-0000jm-Rq; Fri, 23 Oct 2026 12:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xKHq6-0000dl-VQ
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:09:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xKHpq-0001UN-2n
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:09:52 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE67oF3019023
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=BzDWG84REuv
 H8wtFMpjxQ65QwD3R7Ke2GH79Im1dAFw=; b=laOeNrkgOZH/crIzfgdhobASh3D
 s2axKPEpb4xl6U7fKyfJWogmqvoJ7B439FYmNJqwkjLOsuMY5UtNAyxk6SOaqUgT
 FrlnhlAVgCSBfiUbcApmTi3PTDqBcUUsYkSqWXwMoSGruvAm/0dhk6i7KD3QZzbr
 vh4AZeIrLDN2c4ynK9dC9YqiXXJsj+9P8htunUIsK31k+L+jVCgh+Lm/QxVANkZN
 u0A82p+0PFSNkbyc8HzQY4xARAaoTQHsT74tseBnz+GLtUctAQI95uk40pRuL4bQ
 bYswDxilSuOXVTR7ZxNBDI1IbXBFdDMdBddySpOrHtNdxQi3XmAyX22x82w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsykbwew-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:09:29 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f1f2fafeaso138801585a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792771769; x=1793376569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BzDWG84REuvH8wtFMpjxQ65QwD3R7Ke2GH79Im1dAFw=;
 b=WozmlTfvcyWEsKT7HfHhBoZxmQituXKeLKRpHvNcd+pfkRAQNnWRdJWn0ERqJg6MIy
 Z7AWfB9qSd0j734F7eJd2cvmkFpZUvoKNtYsOVc+NxkrulxajGjAbGIVAX28wF+aT8Zr
 fUK00D/+S1kWklca6rqvcGvHTzmRUVnYjglKB9BObL4OOUg3iIm49HQkQoYbqYe6OXcA
 5ovaIFlF3iu719M6zshHM77RH1GXHi6S5liTIbpZwfC8zXB0BxWZnrI4a6kbGWQ3OQON
 VqaEmTxrP3p1x3Op9oy9eG0FK/HzPTv3M/8vH2/tb8S0V0kT9QkTWKqj6r7B1n5U3xKF
 dPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792771769; x=1793376569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BzDWG84REuvH8wtFMpjxQ65QwD3R7Ke2GH79Im1dAFw=;
 b=Nu/EWvwRQHci4xr9KkObUuGDyy4RgAUeM5S3mujp4z0LaFAof4PygelPazUxu/Q2lJ
 0nKiPCEYnXnMCm6ZNH3Cla3kGuwUGkw1UxRAiNM+ac5yVvluv0bWFxPhKbNA5DVZxg/S
 oOzk/9wCTR4KXHDjHefjuyEjSdZNF8AORY4x0aWCGTiTaEhmx4VPF94W8nBXEAMAZZG4
 s6EsckaXUH2CYg/dEa2Kio+aq5quZcin+FEsxY7ccxD8M8XTISAtrwovlnWf3Yn2zciK
 3t74Ohy3mNFfgOGDP0P1ty0XowL/QOT92rjaEx6vPpskYV63Fg488v39uTJqCQF3uakR
 g7Lg==
X-Gm-Message-State: AFq9FYJpCnDo3AulrRcSkoqpzusUGEBqgYi3LKG7+ZjkGU2tSqj0rA7J
 xz8Li67p0qF5GZ8IH25U+4p/6Ijn0baIhM4zL0SpU06lSqg4Qx2GC9q9wfwg37OLnyE7ydTrhzE
 e2hfTKHPFocAT4ojaRhH2Oy22Xk7fZdlDRPbc3uRlYgyeAulmvUzo9IRPpOloY1vprg==
X-Gm-Gg: AYBFou0dRWN8oFccpyMRNflLw3YZG1rMLbOkikLS+3yoTcp9Pca9vDIqiCT+faOf7tN
 ANWeMs9U3aqCuZ3PSktOa+uHwsYolfn7cN4lSzjceQ84NDnZyo31mlVYuFEwQv0Iwpshg0KseKW
 XeTsbW6TzOsAwsBSLWC/rDOGKODmC6Ac7SvAfH5bVOuUA7I8aIm+ZWde9Cmr5RMgflU6GKukqCx
 kHB03iSB5AGDDZIuYn18jorfmBVOIoIghi4B5AkErFXQNRatTvJmiFq8scVuH+TtRG0FZPrBT42
 quMEEzkPGBD875sMx7Tj2AAL8QtbvcbvqPWm+Mv70TUhdqjJ3o5TEJ9b7WgC3+q3xv3qdIL8ZRQ
 Y+ndmhBwhQEUwT1aj0HC12XiEj8plLCelOUxn2A==
X-Received: by 2002:a05:620a:8399:b0:93e:8614:bbe7 with SMTP id
 af79cd13be357-93f6f79c4a0mr472124185a.12.1792771768741; 
 Fri, 23 Oct 2026 09:09:28 -0700 (PDT)
X-Received: by 2002:a05:620a:8399:b0:93e:8614:bbe7 with SMTP id
 af79cd13be357-93f6f79c4a0mr472117085a.12.1792771768091; 
 Fri, 23 Oct 2026 09:09:28 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([152.234.125.162])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c4524f226sm5063406d6.27.2026.10.23.09.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 09:09:27 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 3/6] hw/riscv: make UART FDT helper consider baud rate
Date: Fri, 23 Oct 2026 13:09:10 -0300
Message-ID: <20261023160913.24992-4-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023160913.24992-1-daniel.barboza@oss.qualcomm.com>
References: <20261023160913.24992-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfXxRFCylePB8rr
 He5TnLgj+vhp7LH4yMjmLWDvcBZUCMnlBnyzm+9Zq/EdxGgbjtvkGpPSk4WhNpup3okSI/tId4y
 MW5LTtU0ClLp4d1JMigUCGtlFibLBFPBSnW08oKLru4JNvuZgHPcU29PGHPBOzcrPEK9hjK9Gd/
 +bvU3af11WzfHygKPgAHqpi17iNzPXF5Qrm6xiAkgUI//f/0Xju9uonyPCqSR7Bh8OjrJWroWzT
 fRNxXrdmkIZVqUPKPVazSAY6MrSd2UZdUA8bYtGNv115ZQYUHToSEiQQ4fXAQiCNuQOUejc33if
 txxFx2dRxpwpKybLxOEtrjuAjtX1zfiI8dRGJSM0iQq/p+JSwq9Tvz4Eo/Jc1VxRquFUZJ2wc1i
 zugFWt0U/4hPKkJdco9LESdheGqge6rnfzVVwIuyvajqIlvMnh7PeDJi4xVW4M7ICvzt+WBOLbU
 LHHyT/ZVgbxgwe3scmA==
X-Proofpoint-ORIG-GUID: wRqL5jaf2esFo1kZdFf8lm4L4zPlvsDl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX7YXFUWoTM513
 78irQmb9nhzSwe3TgHWYO4Dhs/ZOPWcaj6AjO4eGyqMGCj8O0KRJCVji43tnLYDQcCkMEVowYzw
 /zbbDdz7ICF8ujLfpYQr38U/lMi5ZDI=
X-Proofpoint-GUID: wRqL5jaf2esFo1kZdFf8lm4L4zPlvsDl
X-Authority-Analysis: v=2.4 cv=GLKdgeNK c=1 sm=1 tr=0 ts=6adb86b9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=AgQEunjic7gIBKSbIeB6Ag==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=uxJGSlK6fkZaI5NcCCYA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230063
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
index ea24720a08..3191615c02 100644
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
index 39381cb21d..c4447d971b 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -385,11 +385,11 @@ static void create_fdt_uarts(RISCVVirtState *s, uint32_t irq_mmio_phandle)
 
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


