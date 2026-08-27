Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B93C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziYu-0005g7-BG; Thu, 27 Aug 2026 18:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wziYs-0005eo-Ic
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:27:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wziYq-0001JX-Fp
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:27:05 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLwIu218824
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jAX7zs5qrBAiYTsMyZRmq7o8MWdzr6coZFfTEDgDXIQ=; b=gLB8/1JW5EyPmtPQ
 W2XkwAO3WOCu5YNqbp6ePDAePBamBW+OV7a9j0GUOWJTwIw8b80ElO5ts2preQCe
 1/gybxF73vhaG7ZIMeFNUPjXqlVWvbM8r2XpzuPj21y0WEMzZplZs/9CSY508cEa
 pBqyJH6J3Y0UahDMX/Kc/6TFm0aqNjxogMMmrta5oBGYmCcDb6rgPbJZsZYhcDjz
 j/+8SG0j7AzuRGpt3tMjsw7gxuD+5orkV6zJk4gd5aQcUqc5y6ec8bu11/01edgX
 IcqLmBhLAGTPqM5u4bS23FUcPIP+gnWz9ugiLEeW2K7kRW+s5aa4+HqFzH/A5jyH
 UmHiPA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gaphw23bq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:26:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9377829a759so38364885a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869613; x=1788474413; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jAX7zs5qrBAiYTsMyZRmq7o8MWdzr6coZFfTEDgDXIQ=;
 b=iCALVI/qZnyW8Dxpsk/63wpCZJtEAMLOIzhZXgjv84cQM2chpMrqco5gtphWW9L+dj
 sUmRy9BWrp87H6AGtw9SvuQpLTkbKQj1QHTzT2WdblnR2cbEz9AwM6bb/Iw2QNteddUf
 bc5ijC684NdIxo8G1EqPvyH78H5VeaiCp3IPrDtISSfBDdE9f+b6OxaFud2H+Z6TDgqY
 SQNH27izFsNWq01xZ42ijPlEYJbhcc9VTLQITfWcvSPEq9y0v4nko+Kr7n/dvkVjagxs
 nN2m/Tm4lat90dxZlwptb1GJqA+dWp3vlZBqgLlgJnyDRC0kA4Zpfm9UyXgSE6iVg/BG
 IqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869613; x=1788474413;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jAX7zs5qrBAiYTsMyZRmq7o8MWdzr6coZFfTEDgDXIQ=;
 b=X9i7iIqPO5BLYkwWj6ZXmkwm+73BKO2/8TZ3F5qvuWQ/epVsKuPB7i3K4DpMf7jnI8
 qRAI1OoJc1eSS8S2k5kUi1gwWikkkk+C+05HYiIJAoYNXgTEEFSEz33Y9jpTaleBR8kc
 O0ypcEXWSN/dSu3Yu8AImglBFzge8omoazpZ9SFR0eeq9GL1KjFk9CfINkouZA79ua+d
 pMTCvxVtpKluUxGapYMpD4NW9f8ueOUKKzh5PRRRKGMa/mE0MlftKg2uUQfaBG0Kf7tF
 b9LI2z+7f8R0cxKc0T9BSHiQnZ0HF8J5oZUzKanWB6p7j7Jh5YHgwTL8z4Y8aCAG6plG
 oMgw==
X-Gm-Message-State: AFuF++nGeVtAkisX31R0WlZbYe8qpKR2sx5b/xubTA+isYIMFUKt42SE
 0G+gmOEzEIfRkWJEC+OWv0cQqgtobfZQI99VHkW3kEzWL9/7CeAqO6nWfZIZu7Mlt7AOobC/Nn+
 WBJvXo5/bQ36H8tnPHIDI54AYCIvMNGND/cGvBYwfgAIUZIL2x6FTTkxPqLhs9A2Cdg==
X-Gm-Gg: AR+sD11s6weJx0CEy95zB90NBXSVfVgH21nLMzskA3ruf/42dcU6HTy6MdqhCBVkEOE
 aJcP3t2JxfFbmgFfWFkkmillCyiIytTEFYbTf1NTJlB76NVDPIxDN//QZseHVUMvfigWm2VPU3v
 I7MzPVhnbGSQOjrtonazh3cLkoAfMv7KeXkTZe6duHJ4xqSaV00sNgrC90ko2fDz/CVSpUqgQPG
 FqSLW3FJG4NmyUuacyU7cDaJ+EADG2kpU0m1bSGUK/3Suum+F5ixqdyxvyjSqDrRA6a1GRG5/Uf
 9VtjN7UX1jELmdL9AVMQeUg99pH08DBkVuo2b8v5gLHWib7BF5RR4ChHojhL+17dZvUt/nTgxmJ
 qjQZXNNHohXkYPLgAkPWfhUP38MHlV2GPch2AKQ==
X-Received: by 2002:a05:620a:6187:b0:934:97c1:ca5c with SMTP id
 af79cd13be357-939137d09eamr289042085a.16.1787869612796; 
 Thu, 27 Aug 2026 15:26:52 -0700 (PDT)
X-Received: by 2002:a05:620a:6187:b0:934:97c1:ca5c with SMTP id
 af79cd13be357-939137d09eamr289002885a.16.1787869607482; 
 Thu, 27 Aug 2026 15:26:47 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939173a734dsm8924985a.26.2026.08.27.15.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:26:47 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 10/14] hw/riscv/fdt-common,
 virt.c: add riscv_create_fdt_rtc()
Date: Thu, 27 Aug 2026 19:26:03 -0300
Message-ID: <20260827222608.329788-11-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827222608.329788-1-daniel.barboza@oss.qualcomm.com>
References: <20260827222608.329788-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uVlkr3V-DhsYpvsEc5p-r0FirVAKore6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX3L9QjRFQ5b8s
 lMqIpXoAPI8ryqRK2M31OXlH6NR6fcBs/0+2A1iICaggqIttKPj4bbsH4XH+/Eb3jAPUKbTOBEF
 tNjugb75jWhHB2v9n4oOGdwuFEJo+44=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX09CrU+UwlOyj
 XXh54UTAtHkaT0G5YKsr4YoyxdYpr/CAovF+T2EQHBIMnidk5AVX1K/OohYUang9ZyU9uo0LZB9
 iaopKBjTkD/heALIp9rXVH99dKRT6AHw58u9TDbMDcqFPfiF3o0wVt9R7mEnmMaC6WSHMrzfxWZ
 WO36R8tWNgnmm4+IMt3ae7WSY12NQZThwDVIyxJXbLX9FnZAIzxjNzXlCP4sHaoJ3Ylid24SXx5
 mI6hJxPirlcRE7tD4CZyqTzeUpjN7957iCRRIbXWGtDsoVmfUb4dGT31ZDjJc6ng1wxpV4nebDj
 1Qx0xzcLohS4HvfH6IZLQUR2HE4+ixMh4o3eMmC7w3g6K+MGNXIihbQQDj63bTlI2YHPMOcpSBA
 FZo0Itjhv3ccv3c3rU8XQJnKyF2GSd5uA4s9bqY8tROwuHjZKuDxBlOrC6im+pZxXaqlFXuXz44
 eEx0jUWIvQR6yN9Y77w==
X-Proofpoint-ORIG-GUID: uVlkr3V-DhsYpvsEc5p-r0FirVAKore6
X-Authority-Analysis: v=2.4 cv=E8b9Y6dl c=1 sm=1 tr=0 ts=6a90b9ad cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=RnOvKumpmH0hROQiWQcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
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

The soon to be added 'riscv-server-ref' board will add a rtc FDT subnode
that is similar to what the 'virt' board users.  Put it into a helper to
avoid copy/pasting code.

No FDT changes intended.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         | 21 +++++++++++++++++++++
 hw/riscv/virt.c               | 26 ++------------------------
 include/hw/riscv/fdt-common.h |  3 +++
 3 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index e8186230b7..05042ce312 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -827,3 +827,24 @@ void riscv_create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
         qemu_fdt_setprop_cells(fdt, name, "interrupts", uart_irq, 0x4);
     }
 }
+
+void riscv_create_fdt_rtc(void *fdt, const MemMapEntry *rtc_mem,
+                          int rtc_irq, int aia_type,
+                          uint32_t irq_phandle)
+{
+    g_autofree char *name = NULL;
+
+    name = g_strdup_printf("/soc/rtc@%"HWADDR_PRIx,
+                           rtc_mem->base);
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "google,goldfish-rtc");
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
+                                 2, rtc_mem->base,
+                                 2, rtc_mem->size);
+    qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", irq_phandle);
+    if (aia_type == AIA_TYPE_NONE) {
+        qemu_fdt_setprop_cell(fdt, name, "interrupts", rtc_irq);
+    } else {
+        qemu_fdt_setprop_cells(fdt, name, "interrupts", rtc_irq, 0x4);
+    }
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 3e40513dc1..ccea5784f0 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -436,29 +436,6 @@ static void create_fdt_uarts(RISCVVirtState *s, uint32_t irq_mmio_phandle)
     qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", name);
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
@@ -566,7 +543,8 @@ static void finalize_fdt(RISCVVirtState *s)
 
     create_fdt_uarts(s, irq_mmio_phandle);
 
-    create_fdt_rtc(s, irq_mmio_phandle);
+    riscv_create_fdt_rtc(MACHINE(s)->fdt, &s->memmap[VIRT_RTC], RTC_IRQ,
+                         s->aia_type, irq_mmio_phandle);
 }
 
 static void create_fdt(RISCVVirtState *s)
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index c8b25348bd..eb9db8278d 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -133,4 +133,7 @@ char *riscv_fdt_get_uart_nodename(hwaddr addr);
 void riscv_create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
                            int uart_irq, int aia_type,
                            uint32_t irq_phandle);
+void riscv_create_fdt_rtc(void *fdt, const MemMapEntry *rtc_mem,
+                          int rtc_irq, int aia_type,
+                          uint32_t irq_phandle);
 #endif
-- 
2.43.0


