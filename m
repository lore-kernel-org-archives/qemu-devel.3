Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B108C61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyycr-0003em-6L; Tue, 25 Aug 2026 17:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyycp-0003ed-MW
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:24:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyycn-0002J6-Tv
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:24:07 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PLA3tG3117135
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=b4Miz9TXKzy
 RvuNMMeQe6KMM7OsPQgD3XGcw9fM+m+M=; b=KArojKMmT1yEPS8dBjoOi/q92Ln
 ExrYjXiROMHGdNlqicP/Dc0wEuw6TyhV16EsxhuN6GXN2bcy59rC6hS9qU3bT12b
 XMPH9LbkVhyj6sTsfgw3MW07xYPGbk+2XKQ54G6nNFLsil9eTGvKHiRI8laKckO+
 rx+O7MB07hsEVOoDxtFzhbQ1U1Nx7++86UykIhEfdpcn8QdQ4X/rU63VH20D/3GN
 /Rp3uXVvVrxteNuhgW+9NOr9v2LvYPqXzCkxKF20FdX5f6FbXJ/o95cX5t3kru4r
 U5JHdGZsjG3/srELMfH35pj8MD9UzQDH1YxIOaSPENho9mZ73wrygG2G7VQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9g4mrk8q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:24:04 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c0e702df8so3934891cf.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 14:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787693044; x=1788297844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b4Miz9TXKzyRvuNMMeQe6KMM7OsPQgD3XGcw9fM+m+M=;
 b=irzakzhYndyPHCHfNpocj3qypHwVbxqwr9H2vyaJQW1WTDGx2TfJVXfu5Pcb06FpOD
 hcTZy2fACW5LK0dfvhhtvquyLMG4eaHY/SIuvhhyob+/9QBAo8pxppOiRIDbcvW240LT
 gnlsjxlzL8mS/rwt3IPVeijKMivbZtKQtnuLJyPnYSbTTvh0R9ZQaunATXZ9luji3zFj
 gwWq2IaX1RmX55WakzbYPvunvLEnAza3VXH+I5umCAi62gXJHl9tiVECrfSQJXro+b6A
 B16dVEvjI3v7U+fr+jeCFABA4HQQ/RTtMKSR8CvgMU1+h0L3g22gazG4taR6WDztPmAB
 AFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787693044; x=1788297844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b4Miz9TXKzyRvuNMMeQe6KMM7OsPQgD3XGcw9fM+m+M=;
 b=X9HbWmQVhFC4cikQBndznN11h3Fi7/6JcEbbpje66zDKnWdbHItErI3djjACQSM3i0
 E0PCPF66cOPJikc4ipB/yE0yZBIAdK8ICoY9s3p/Kncy5xFLc+eodS2HEn4pDqHrEJAv
 9AcwJx21nbuio7v4R3QHySlNiIlSx6mkeac7Aim6H6ARgFmv/cUD5KrwstfKLqOLc5Lg
 nw5Ak3eaP1V85U6UogXs5TwapM8jsU7rcIgCkC18ZPEBxQZ0G9LNxHfSbPpuN0O8bBFu
 BoVzR7agdgbhkySqf9Piwyn+leiSacIycWW+n1d0i38shD7ZbjiB2mJ1ok7m6vBv1T4t
 9IAg==
X-Gm-Message-State: AFuF++mpTsk23M4laXxrprkKaCkDXCnCewIqIbOcPizgQiu1WvwxHnJh
 hVfEBYzooOJTNp5T1VkgKaYMNAJEWGepJDUoXSfm9FQdKioFahDlCBheQFOEzngiuxYqSk8GsvV
 o26z4tAVzRTFvkGM77vB9EBgaLzMkiJrIBZq2r3Uey3b38I71P+rJzoQNDGB/5s3X0Q==
X-Gm-Gg: AR+sD115H3EEybE0GPV1hr66wFon+wqN+wvTjHwNv0cNjObX3AY163cJVxwAH3g5Smn
 2he3++bz+bNmh+yB5KDEFnEkQYav3HsDF2lZi5jXEVarJBHpbYpCkqdbwI3VnefKJ6BH9yS+CuU
 YYgfkwkRf3Md8uniRbdusIc8FpW3njeRV4oZsH7qGOZTgcetOTcoiTV22/9QNqMsuentwb7EwPZ
 VanTGCpsLjFEeqbK9SlghIXnXlbFyCVSAluCbrUgcBi54O4fSodTO8sO/GdJkvrVqPvWWeFwwj8
 fVxbCb+SScc5DHIdjw8lS6WeNbBm+1PeTv/Rjn+8Quqd99i6vGhYhjBI30RyF3uOF5B/CqUPAsm
 9AEzoYHeqd3cZqmfr/GbaL7a7eWslqTXqoHIMVA==
X-Received: by 2002:a05:622a:4186:b0:51c:ae7:fa1d with SMTP id
 d75a77b69052e-52e42234b68mr23143261cf.5.1787693044323; 
 Tue, 25 Aug 2026 14:24:04 -0700 (PDT)
X-Received: by 2002:a05:622a:4186:b0:51c:ae7:fa1d with SMTP id
 d75a77b69052e-52e42234b68mr23142801cf.5.1787693043905; 
 Tue, 25 Aug 2026 14:24:03 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90cc65299f0sm8646386d6.41.2026.08.25.14.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 14:24:03 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Joel Stanley <joel@jms.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>
Subject: [PATCH 08/13] hw/riscv/fdt-common, virt.c,
 tt_atlantis.c: add create_fdt_uart()
Date: Tue, 25 Aug 2026 18:23:20 -0300
Message-ID: <20260825212326.1907-9-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825212326.1907-1-daniel.barboza@oss.qualcomm.com>
References: <20260825212326.1907-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE4MiBTYWx0ZWRfX032HNHpELLXc
 pKVUkSWGtnFdORmhq2/U0WT/cikhLSBq5BKiYxtnxfx0y/q0iW+ksJ0qRcpmrv/6vh8KcWNQou6
 Atz9g/eJwP+6+lGaz+Ee9gCCDgzRM5I=
X-Proofpoint-ORIG-GUID: SWo403NeUpyHfmUdcRWcL2dFaFZp3TV6
X-Authority-Analysis: v=2.4 cv=eYgNubEH c=1 sm=1 tr=0 ts=6a8e07f5 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=ZXiSWbBV69HJ4aRO-VQA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE4MiBTYWx0ZWRfX2JQstgExvP4G
 cRjb6sumvxkOCg9p6Q30njrbWkGrvJkVkphlMHwapQY9BbutIixWX76kR5MgtwgRf3ZMx4i9lwn
 /LuPdwv2yQix2xYhYJ4BDjXZoBDRK9QH+9ZYO2QlbaVKyVaMYIOcUwYkkvTWVhtgz7JrtAdCwpC
 mPg7PG9Gzd2DkH+oGjU4e3SzfFgdh7f9PhCUOQ9dPDWrLAuMAC34i31rC6SS/SV70UJH1nIu6D6
 Xu0fyKxkUVeCe+30cVXKvgSzOQqaK+vF5ES6psoOdQfIGeXPE7EyjWf9bcK3h+yGVbVUw1ZEoUB
 f2rBR5XVf23sYbSU1Js38t/oSpj5062yhxwmbyHu3M4xb/ABI8+nZU4CjD/gDAAvbrfjcBvPeVI
 C45xekaYtyTcclcu+otrn0ZeYKsC5IvdoVL7TGTq5ANIyDRTygqXfBZKPXYi8i4G/VtaE5K5e7r
 NHE736+BxHH04CB1pWg==
X-Proofpoint-GUID: SWo403NeUpyHfmUdcRWcL2dFaFZp3TV6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250182
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

Add a common uart FDT helper to be used by 'virt' and 'tt-atlantis'.

To accomodate both boards the helper is doing the following:
- an 'additional_reg_props' flag is used to control whether we want
  'reg-shift' and 'reg-io-width' elements added.  OpenSBI won't boot
  with the tt-atlantis board without them, but 'virt' can't deal with
  them being added unconditionally either.
- an 'is_serial0' flag is added to control whether we need to set
  additional properties related to the first serial.  This is required
  because the 'virt' board adds two uarts in the FDT.

No FDT changes intended.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         | 39 +++++++++++++++++++++++++++++++
 hw/riscv/tt_atlantis.c        | 21 +----------------
 hw/riscv/virt.c               | 44 +++++++----------------------------
 include/hw/riscv/fdt-common.h |  4 ++++
 4 files changed, 52 insertions(+), 56 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index f31cc9d3cc..b3f3af3762 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -791,3 +791,42 @@ void create_fdt_socket_aclint(void *fdt, ACLINTFdtProps *props,
         g_free(name);
     }
 }
+
+void create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
+                     int uart_irq, int aia_type,
+                     bool additional_reg_props, bool is_serial0,
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
+     * The tt-atlantis board requires these extra props in the
+     * DT, but adding them unconditionally will break OpenSBI
+     * for 'virt'.
+     */
+    if (additional_reg_props) {
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
index fbcf9aaffb..cef1073449 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -123,4 +123,8 @@ void create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
                              uint32_t *aplic_phandles);
 void create_fdt_socket_aclint(void *fdt, ACLINTFdtProps *props,
                               uint32_t *intc_phandles);
+void create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
+                     int uart_irq, int aia_type,
+                     bool additional_reg_props, bool is_serial0,
+                     uint32_t irq_mmio_phandle);
 #endif
-- 
2.43.0


