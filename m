Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368B8C61DD7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03Mr-0007Qk-Sy; Fri, 28 Aug 2026 16:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x03Mq-0007PF-It
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:40:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x03Mo-0006aQ-Hq
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:40:04 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SJ73fF3910417
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 20:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8bTAXk5k+xdLI4q5OKGzJ/3LxYZfT/KUXW18EC8kfKc=; b=fD53IpULMArUCk9T
 CQ/RSwPtwcHIyaEz+JK3o2lXH2AyHKR7wGNTqyLnfLjD8V0ZLyz5lVs2dTG0MpYp
 0B0ke05FtW/KA75BamVT67jk0ZLy6vOG3L8EvAzYDqd+AllI8oNXQ5Mrb+baozJk
 RGtQWHtgMfCzbozU+Avr52IbaiOtNtHEDnBM5dyvyThl9GQDR8mR515TPNcnZrrg
 zMvojKxAJ7Eoron+8Xfp8pDJWGbhVWgwx9gevuijZJAeuJdZRosIcX53WpB6Ig6P
 zjaitwpeSPiADQ0TOoVB1f6NhYw6i7DyUJPQkc13FxFewINY53qucfLj68XdNWUv
 57nm/g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb7eh2e2g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 20:40:00 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9390a2c895bso266735985a.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 13:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787949599; x=1788554399; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8bTAXk5k+xdLI4q5OKGzJ/3LxYZfT/KUXW18EC8kfKc=;
 b=eNSilcCYFoICtFyGkOZsSViuUSfDsc+wpTk8i4uhO3QLiWa/ZPGufKsjX/MzyZhQRo
 USACK/9inQxZpClBsxGHWjsTbGh6dD+QkAjp7WajaG2ZX1qqw+/oRqjBarxMl1tikJyz
 3toBmXOyAO1zmaGQYNAD3EPsfUCGQq+zvH9BC4teRMul4U8mhwLsJBox/nDeqG0njOeU
 gomcPg2L/f8AXHlE1UihXOJfZ+5/yYSZGSu+yY1XlwIGNO1ur6yT0O3+NHxfaIZ3Jb/2
 5N+ebpmhdUrQH735V2w/rIWqLaba/ue6kHvJuEuXQ/fGD6PAsJVje0Ukh5gW0myb7W6V
 f44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787949599; x=1788554399;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8bTAXk5k+xdLI4q5OKGzJ/3LxYZfT/KUXW18EC8kfKc=;
 b=fdqqwjXk5SuY0TUOHB+gURrzHvV4pu/GyPa4y/TX+/KiPsgZ5F8kb+Hlm/aczZNb5/
 SxB1kt0r3ObyuaZux1Fe+67GmGA09yuBLGDTcXEN6zrf/uAo/Ia86orNKYQwnheGi9x6
 dxdMrMxF7bwf/3Z7hNZC+cMXJCHxnRrn/6dpgZepZtoOTnVjVKPiOF+h4Em31aMOSY0J
 C7Omy11o1Sn53MQt02jjbWu380ObtVy4vxh15MirXDdVFafv1GEickw8PD2I2hzt4naC
 bwopvt/ShtsUqka4QkBTDPfwE9a8vy96UCbXi8Err283qRKiRLQYWZszXbzDlGBOq4FS
 Ob0A==
X-Gm-Message-State: AFuF++l6nqXopjn/lJPzh4vuNprhv0GuGLt14DLkSf7jFAydCV34t+rW
 PktuttYuxdm+6XTbCHFGJd/xXC1GOsQFzD2qE4tOiS8KampRtJBPftb0CuSsPniftxZG7uaFCLz
 n+ItfU900/v2ztNPNRZVqYthiQU84i7BO51hf/7V4GSc3GDgI5NRgU2FFsocXYwlEOA==
X-Gm-Gg: AR+sD12OvWsuzrb6gMFDDBIOHNrzuRERgndOVRSjFvINnf23+yXF+t7YRf28oZSY9M8
 F+LMsvYmun7qs9d09RsXhPSb6wI0L3ETqFFD6ZfqwmD/cMUgWRfLCz0IKgaEXZ3pBDwTpYmbeKZ
 /L1u9H1duLBYyIagu5JMI1i0lgNzLwmi+JH+eMc8VH/2ZUOSD3cUatUvc/P3a3uo9Q0HSHV7z1h
 8VadPn6GRHxzXkCOWmuZ89PeK2ifZMyhAVAgOC6mRpsaGE5VINRXDeLW2dynDjTbiCnS3qNe1YS
 n4nyBiyD7DmOpbMSVXNMw8Vd8CoHC3ryLle76utimd3pQJ9u5opDO4Sbh/bfOnN4CthIQcfpe08
 hi1SeYZgImU1557+ASkcEYdnEGhgfgF9ZWWtYEQ==
X-Received: by 2002:a05:620a:6886:b0:92e:9d63:a6f6 with SMTP id
 af79cd13be357-93913808713mr1165272585a.17.1787949599132; 
 Fri, 28 Aug 2026 13:39:59 -0700 (PDT)
X-Received: by 2002:a05:620a:6886:b0:92e:9d63:a6f6 with SMTP id
 af79cd13be357-93913808713mr1165216385a.17.1787949593884; 
 Fri, 28 Aug 2026 13:39:53 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939173f2758sm218063985a.37.2026.08.28.13.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 13:39:53 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v5 10/15] hw/riscv/fdt-common,
 virt.c: add riscv_create_fdt_uart()
Date: Fri, 28 Aug 2026 17:39:12 -0300
Message-ID: <20260828203918.350131-11-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BtD6A2Fp_vzDIb8xxa_8YoBmyiKUNZPR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDE3OSBTYWx0ZWRfXxQGKI0x1/PTa
 a4aeJ0xYQ2xL9QzZhUFw8iJrOdYXVSh7Ow0ml9iwOe/lZy/B2xBVgcNDJMVrcWbTQPuQE/lDngO
 OwnNZaxvhymiD0gqej/o8oFxofmK9/0tD/DXrnnSohqUZWAQtD6uR+2Sc9gafl/NOohj2E9fnVC
 H/Dtn1PxcPkCllpjGsN5KdWTSRjhOB0Xw1qQCq4emjmkhbfUSADsqaqK8yMm22EPqSxuytfdLHS
 LGbypywJFHesBs9U9QSDCE94RDjpbvuvIQTiU4BLTkleRbrckVhspkcp4VJpcKjXkWNyIvfkmvt
 ohGn8e7S/m3akSdseqTCey8eg1GecRngteM7gzSXO2+bVEdSc7QKyqa0j4K85Blxka1vbXJu0Nt
 XzzTlyCx6/RTmbTXl1fxQIfhpa9vrUbyaEo5xJwjaXvuUsgwNf3WGSXpif/gF4pYATCd2f+XG47
 71wjeuHf8AmAhMDNnfA==
X-Proofpoint-ORIG-GUID: BtD6A2Fp_vzDIb8xxa_8YoBmyiKUNZPR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDE3OSBTYWx0ZWRfX09Pv/An7E/tT
 UBlhG2TRvFnnWvLu1EHMdeY/P+unUNj1k46BofYQyFk+KLGkMf2MbPz/ftotWTIkBJKHB8AQ4t5
 g3P22ZgwxVBK5lc4hgP/2o1G3UNGHqM=
X-Authority-Analysis: v=2.4 cv=RoP16imK c=1 sm=1 tr=0 ts=6a91f220 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Rd_eAvTXF2ongSiteCUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_06,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280179
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
index d2ce93ad28..0107aadaad 100644
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
@@ -799,3 +801,30 @@ void riscv_create_fdt_socket_aclint(void *fdt, ACLINTFdtProps *props,
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


