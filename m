Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A26C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzGo8-0006Lx-4x; Wed, 26 Aug 2026 12:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzGo6-0006L4-Ke
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:48:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzGo4-0000uu-RM
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:48:58 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QDv9FT1462231
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 16:48:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=j/THFe+C9+d
 ++wHRruW3pLbvM+Ts7S5ciE/CHLP+wUs=; b=l8/DoHdrozQsLRADSIU2rW5nhBj
 t3rORQhZfkx5lYprQLVcCS7iYMOW4m0Q+OHzJOF1NJz2PWfrsHQI/citv+y8ekm4
 XqwLiP4QfQyruF2N63KeHPKb1opZJg8KUlyvZpUWL6hCciDaQLIxNjMJDKcUdex9
 AZNO1+NJOpWHuOz6F90+7JvskE9U/JEOFvZWZc4pSFcklxkjCwo58zQQYJGHQlSn
 Ro72k/qo2TXiUEzAAonKrtwE9/qdte5VG3irzPmzRLjEAq69U3hvlQ+HXb5TXdIO
 HdZWZOBpwjUcGcXWG+sWHhp3feEcOvIiU68y47/ny4CV2aMGaz0RKLIf0Ow==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9r1gk3jy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 16:48:45 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52769fc3f2eso17268951cf.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 09:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787762925; x=1788367725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j/THFe+C9+d++wHRruW3pLbvM+Ts7S5ciE/CHLP+wUs=;
 b=Ys/RFc6s4GkON9cfMyG7aT4MTtJSuRUUtUZJ9hCn3n6ew1a/LiWe9LtOoGyjUB9XBp
 DQ6yjlOye2krK02QJRKhtzwlYAS7yyxgwgQft+EkaJdjbOOmua3HOpl3ZiK11VUiIgFg
 KXICRtfTh2qNe/SQ82EeZPRgNoPAMWMLdpSjchGywfzJoiRivdpq1nTCB43b8k7YH/r8
 s+MIx+sIGZ/jD+HBgdvP0E4OGm9sPuP3d6saotj1xLkxEH6Re0DybspFmem9/SOySfio
 v/ZMRghBTn6gspkVWvyHISEHTuwOopgPimLXjGtfNbNsDW9/QhhgOj8Cl7IvcFMCZG9M
 E9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762925; x=1788367725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=j/THFe+C9+d++wHRruW3pLbvM+Ts7S5ciE/CHLP+wUs=;
 b=lByrDNxCmUlzUJ/VtzdyO5HpwUq/6eh33UH34p/TItqKGuEDiLDEghdl6INcUll/Tu
 F84wYD93ABTJaAytgSG8lOxP7SnaH4ENFcqoEO7GkP0f85apHH/kNDiNujClP3E/UfrT
 4swVqhicFqQI5FLmzQOx6M2kRaPa4U19YkiTajo6vycGDd4USs7jNuldNcoWZq2v+HTN
 P6fGv7qtfNDN2UvFFsy2RRxZjHmtiFqOw+cHeRQGcfMeBZMxrPAbIatPs4TRRNKJU9lz
 WXOf4K7eIsU0SM81oSyYQb2jqCH1KNGuC2GnvYHpdqwY3oePUW2qbPB5+lteIjil0JfX
 yCvA==
X-Gm-Message-State: AFuF++m5crHCfvKGWCWVlYhepCYKruI9kddabk0sKg1xoEpdG2XPA4zU
 zou2IzoW4UF3aMZ450v67sYVjMFNcibBSB0/SVILuzZEeIdgffhW+d2a0ciE2hnAViKborq6ClB
 tYwc5s2b4d2e3JtCljbjgHAHQkR6bo7+Ic4pjQFlO9jli3MdPIJt7aAwfI7Jxlzklzw==
X-Gm-Gg: AR+sD11Exr65wY98cRbq2S5tGPws3Cc/MbSIM5mnYO0kL230vaImg5TTWDuQxAPOSfR
 z94yBGogSThPQ5uZoXFBN9LkaYOWZI3deqY/RAp/dEthoA89yNdCPkwuIELafSnf8opP06I6SWK
 kQqR7V0C0oiJWwfcJQmHDegvNrvKfkcJdClp0zEtK6j26oDWMPwk1zglmGighabT1Kv0yZTxX1G
 EN2m6QQURLLWqiNhHqGLGKYbCrbIIqyaDOhCmE+TP0zkpf3ikpecwZ9lnhOojPRUSuwZGi2Qfvl
 SpVnWGaf4AuGwz0xfgSDanq6wl4TaacViJ2M0AKrZjsTlrqDTOBi3axcNsyBrAGfEzOHpZnu676
 eUcP/WZl6rtC7nIqbvTAgZrc090f3yNRJlsYd4Q==
X-Received: by 2002:a05:622a:8592:b0:52f:9eff:959a with SMTP id
 d75a77b69052e-52f9effa840mr26536201cf.11.1787762925158; 
 Wed, 26 Aug 2026 09:48:45 -0700 (PDT)
X-Received: by 2002:a05:622a:8592:b0:52f:9eff:959a with SMTP id
 d75a77b69052e-52f9effa840mr26535541cf.11.1787762924562; 
 Wed, 26 Aug 2026 09:48:44 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52e4275fc3esm20092651cf.25.2026.08.26.09.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:48:44 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH v2 09/13] hw/riscv/fdt-common, virt.c: add create_fdt_rtc()
Date: Wed, 26 Aug 2026 13:48:09 -0300
Message-ID: <20260826164814.44335-10-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826164814.44335-1-daniel.barboza@oss.qualcomm.com>
References: <20260826164814.44335-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: S5VnFpVRjnwmCLcf4U5gNnf5iGzO6VeU
X-Authority-Analysis: v=2.4 cv=FPMrAeos c=1 sm=1 tr=0 ts=6a8f18ed cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=RnOvKumpmH0hROQiWQcA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0MCBTYWx0ZWRfX2wyjwwezJeqA
 Ik3MQawt4PcrqLdAho7JnVbDt4UyT5E4uhq1VT3iwV/XnGlDto14/9DhGIqsUg5hHq7jLE2A1hM
 wtaRK2bo4K7RoDhF3n34t2xthLeIknw=
X-Proofpoint-ORIG-GUID: S5VnFpVRjnwmCLcf4U5gNnf5iGzO6VeU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0MCBTYWx0ZWRfXyq/WssUWtP0j
 P/fEI3zX2iDjM7jmT9stmZAayRvlrXjaPud0Kr6e4NDeK+2fVyu15R2Pyr/8XJm+hRIwfWMJfj5
 h3XzSBoBZQu2cfmmYEhTVxCT9AVUWn2/fN2B3inig+MdOPO4QgsIFvyRaT884PR2G8Dt08XWFNt
 yLpStAsmCDUN9hHTM2BPtjpfoL0/alnEzXBNTbY4W4wE34QdP+4LA+2Z8xyxm0Gm05IaMGs417d
 I5fDY4NWyA4Kq0uC2cHk7Mwg2s3+ppgiidgX7viLgCCpDor5yPB6ildLDVgIZbsljn1IoeH3En4
 DafG8vFn2CVnzipmmvUs8oTD2ssZDrwD2DD7arXv/tMCKS4G0lchCIs/SS6U9hG6PMfyX0eIOPe
 ZZtH9wnMGMfF3LfN4FvN+45Z10PIaDmH+5G69Ohs1WObMef7JFvGLqUz2YLWvxgoJSjiUYk6Weu
 DJHSSmBOz6nYYJsEdBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260140
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

The soon to be added 'riscv-server-ref' board will add a rtc FDT subnode
that is similar to what the 'virt' board users.  Put it into a helper to
avoid copy/pasting code.

No FDT changes intended.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         | 23 +++++++++++++++++++++++
 hw/riscv/virt.c               | 26 ++------------------------
 include/hw/riscv/fdt-common.h |  3 +++
 3 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index d254534654..b85bd49ac4 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -830,3 +830,26 @@ void create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
         qemu_fdt_setprop_string(fdt, "/aliases", "serial0", name);
     }
 }
+
+void create_fdt_rtc(void *fdt, const MemMapEntry *rtc_mem,
+                    int rtc_irq, int aia_type,
+                    uint32_t irq_mmio_phandle)
+{
+    g_autofree char *name = NULL;
+
+    name = g_strdup_printf("/soc/rtc@%"HWADDR_PRIx,
+                           rtc_mem->base);
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible",
+        "google,goldfish-rtc");
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
+                                 2, rtc_mem->base,
+                                 2, rtc_mem->size);
+    qemu_fdt_setprop_cell(fdt, name, "interrupt-parent",
+        irq_mmio_phandle);
+    if (aia_type == AIA_TYPE_NONE) {
+        qemu_fdt_setprop_cell(fdt, name, "interrupts", rtc_irq);
+    } else {
+        qemu_fdt_setprop_cells(fdt, name, "interrupts", rtc_irq, 0x4);
+    }
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index e4bf9c26ef..f3c176dddc 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -415,29 +415,6 @@ static void create_fdt_virtio(RISCVVirtState *s, uint32_t irq_virtio_phandle)
     }
 }
 
-static void create_fdt_rtc(RISCVVirtState *s,
-                           uint32_t irq_mmio_phandle)
-{
-    g_autofree char *name = NULL;
-    MachineState *ms = MACHINE(s);
-
-    name = g_strdup_printf("/soc/rtc@%"HWADDR_PRIx,
-                           s->memmap[VIRT_RTC].base);
-    qemu_fdt_add_subnode(ms->fdt, name);
-    qemu_fdt_setprop_string(ms->fdt, name, "compatible",
-        "google,goldfish-rtc");
-    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
-                                 2, s->memmap[VIRT_RTC].base,
-                                 2, s->memmap[VIRT_RTC].size);
-    qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
-        irq_mmio_phandle);
-    if (s->aia_type == VIRT_AIA_TYPE_NONE) {
-        qemu_fdt_setprop_cell(ms->fdt, name, "interrupts", RTC_IRQ);
-    } else {
-        qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", RTC_IRQ, 0x4);
-    }
-}
-
 static void create_fdt_fw_cfg(RISCVVirtState *s)
 {
     MachineState *ms = MACHINE(s);
@@ -545,7 +522,8 @@ static void finalize_fdt(RISCVVirtState *s)
                         irq_mmio_phandle);
     }
 
-    create_fdt_rtc(s, irq_mmio_phandle);
+    create_fdt_rtc(MACHINE(s)->fdt, &s->memmap[VIRT_RTC], RTC_IRQ,
+                   s->aia_type, irq_mmio_phandle);
 }
 
 static void create_fdt(RISCVVirtState *s)
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index 9a80e0734d..0d87d89107 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -127,4 +127,7 @@ void create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
                      int uart_irq, int aia_type,
                      bool uses_32_bit_spacing, bool is_serial0,
                      uint32_t irq_mmio_phandle);
+void create_fdt_rtc(void *fdt, const MemMapEntry *rtc_mem,
+                    int rtc_irq, int aia_type,
+                    uint32_t irq_mmio_phandle);
 #endif
-- 
2.43.0


