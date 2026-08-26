Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685BDC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzLT3-0003Vj-Kc; Wed, 26 Aug 2026 17:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzLT2-0003VQ-A7
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 17:47:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzLT0-0001OM-MN
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 17:47:32 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QKdUvh899864
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NiYdquvtKLP2dakm31IYFaEYObEaaKK3UBgpc+FGkkE=; b=SLuxToeDGz/c90Cw
 Pyafndf2Hbvmtmxf83ucUGb+kNKYnZwjSh9mpkV0QZzgM4OZMvIqBtnfcfiSeHeD
 AbkEuTyW87qPgqUa03t/AdktCB21l3mCLLujBEWYmoXJJcemXLTi3teY7Bwd8O1P
 fgOSZResTICg9zTZWcB1l9DXo//JbtMc6NQMvRpHuJ2e0B5mU2cHbQ1XCvOOfQ+S
 eW9l897fYzBtrtTE9xLb7c5KA06zp1wUoFwqUA+ZSWAyRYBYquQXqqOq0oxagTkv
 yXH/vtzqLyHJ9uRqa/392Nu9ZHxjc4rV6HlH31I0c+X8zYb2rH7Zq5b12fSAhCw7
 yYBHyQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9wmqtrda-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:47:19 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e538afe65so6786585a.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 14:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787780838; x=1788385638; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NiYdquvtKLP2dakm31IYFaEYObEaaKK3UBgpc+FGkkE=;
 b=UAqrvm/zD45dwlnblwFUfQlcMJMjtC8O+oMvQ/QCiN7W7IXi7gloJyOE2Qa6vYzhOv
 DnpD1UZgCzLLv65BS0bsUG4LKnmdztRRLEVt2x0UKD/dzv1J8pm9PMJ37hRTpCszriuj
 00XFETYL+n1hN55xrIscpUNpuAzOaTErT347rZ766KwQMNVp/eJOTYUYYb6UtZ7nbtdX
 grLYq9UqkpTMjBrMtUb+bZYA/k+L1tzhR1STK6Chef5bFGqqCw7agsW3vmMCDFNOH6oN
 HjV9a69zH0znGjPFXj8gzowppeK79Vktkc+rguvK8vIW6m5u+DrCRl4E+kwfPEiFBOcV
 6LaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787780838; x=1788385638;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NiYdquvtKLP2dakm31IYFaEYObEaaKK3UBgpc+FGkkE=;
 b=sJ2vSEV5hDKbrEsAh70QKdtu8xJP8hyZs4uvz20UdI9naV+n0iGXkEkTE5yEv1pcZd
 HOUX0ZdFBNWJw19cIqY+Vk7PLqOfaqqszIcFMInjRrWu5+0AFVyxsmK5y1SPim4xvIp4
 Iiyjz295+/uWXmYfFhEsK8SFtb8rucply9A0gGcGi7CejAGaA0MBGgE16vcSSJ0Io08r
 LEyF97Xrj8EAISv3Z+EyLDhBylE/XkGRqevOWjtOCx21FkxLBOIh/cVBgQhkgdXaQo1M
 Q8QP1LfoeJ0bOK/D2yLSK0PtIoSvH5dkvDCpiUIZthsmmutuHMGOC5+6InMQfflW4g90
 3ZBw==
X-Gm-Message-State: AFuF++noZmeH5VH0ukH532HcavDb0SntsKSfrxn86tuyara8lU3WLpKC
 PQEbLLlXwk+JigywPIGl+Oj09Eh95GU3uT19TOhh5Cbv9Pe1NsZY/TocnhKmJai0CMtDoz80qBa
 SK50Tskuqf4HdeTDZoAJTX1G5Z0B0NzZSNdawdTryNVn83l13nRQbGuK+yrX1VUBL+g==
X-Gm-Gg: AR+sD10vOoaWF4Ydde+uS2hJ6aFrCV7ztAuM3AYERIs8wNa7LxqImFn36lyA7Np6kTD
 ZqaSHFGyhDeLMSw71AROKsQxgSma/a93HJ/0OLsOoZGz3n1rRnzx6UMt54frToiSodbSQoUCyl+
 Q24MmS1HCBYiLQ5K8O6Euwfbx0HHT5orzmS5SsDzdWChwLsgXuLZ3cZjbHrfxAmAR/kQdLMv0YL
 saZCAkCtr2/vTaparhAar7zYsocO5L1FB3o2+jS2YICg/vke/qjBJm1q6cBrKyvs2jnvZT5lGUu
 eSXdYelspxRABT6mZqI0+a2Dg77FzyLr/V8sjijIM0d+5pTKnzGHrfqfz7+krfL6g7/PYVunLup
 bLR/2lZrsHmuAbFUbjmfeXJhy+prSXlIIs5EoiQ==
X-Received: by 2002:a05:6214:2487:b0:8ee:efa3:4466 with SMTP id
 6a1803df08f44-90cc7a58848mr104580066d6.28.1787780838402; 
 Wed, 26 Aug 2026 14:47:18 -0700 (PDT)
X-Received: by 2002:a05:6214:2487:b0:8ee:efa3:4466 with SMTP id
 6a1803df08f44-90cc7a58848mr104579626d6.28.1787780837951; 
 Wed, 26 Aug 2026 14:47:17 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90cd73e4117sm490916d6.24.2026.08.26.14.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 14:47:17 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 10/14] hw/riscv/fdt-common,
 virt.c: add riscv_create_fdt_rtc()
Date: Wed, 26 Aug 2026 18:46:38 -0300
Message-ID: <20260826214643.122728-11-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826214643.122728-1-daniel.barboza@oss.qualcomm.com>
References: <20260826214643.122728-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE4MyBTYWx0ZWRfX3t9TPPJUPlzB
 L5Fi9kwbDvaMW7rdOLm0DubODfocWqIEdqsk3vAEiS+p2ciZGlXzM2zCKtBUCG3r2Ssx5vOaSk0
 JRETR7VbUguEpWkpxT0o67dkjh6hQys=
X-Proofpoint-ORIG-GUID: IihJ7PEy2XEAkK7yrUsJn1eFU0bcnF-9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE4MyBTYWx0ZWRfX1k8eNVruG7NE
 X4mJoXs5IPj4bOeSxuRpP/X+Vh4AiLW3zDAGiy1RYDwdb7K+Gx4KFLk2Y/mOLWEEa3nZfL2/Z+8
 cbECEVnVWAfDm0SFGc2Rnz3wMnsEEUntT0BNRPkNzqAYQSu7glb1KWg1iYc/em+xjWvFgB9iZF6
 wajabsJJPit60Xkh0VWluDQ3UqSphQvG2pyd/3zqBRrXbdPP+lbtTZ0KCKVHtPnUIkKog85GBWc
 Ni/gp20jsUsvWoaTbH4ADGBt/k4jgRsMZPSmNxdDggOHViLz+2CW8AlvXq8Ziqou8zkblfgdDah
 kLRrD+V7Jw1x0qrltVoBXNH8JMuXqDOp+SOF+OarHOk3GbF/altr+NmrQOvlOqKt39VWHAUMxyL
 3ueHjVT9zb707/AoFY0M70QGRy4LGwXjuo4Xu9s6aqSgbbwR5u/8kvrenczTq6yr6Iu8B899yvE
 x06WcrkES6TaYsiAIzw==
X-Authority-Analysis: v=2.4 cv=T9S8ifKQ c=1 sm=1 tr=0 ts=6a8f5ee7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=RnOvKumpmH0hROQiWQcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: IihJ7PEy2XEAkK7yrUsJn1eFU0bcnF-9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_06,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260183
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         | 22 ++++++++++++++++++++++
 hw/riscv/virt.c               | 26 ++------------------------
 include/hw/riscv/fdt-common.h |  3 +++
 3 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index fb7098f213..2e64fc3626 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -834,3 +834,25 @@ void riscv_create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
         qemu_fdt_setprop_string(fdt, "/aliases", "serial0", name);
     }
 }
+
+void riscv_create_fdt_rtc(void *fdt, const MemMapEntry *rtc_mem,
+                          int rtc_irq, int aia_type,
+                          uint32_t irq_mmio_phandle)
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
+    qemu_fdt_setprop_cell(fdt, name, "interrupt-parent",
+        irq_mmio_phandle);
+    if (aia_type == AIA_TYPE_NONE) {
+        qemu_fdt_setprop_cell(fdt, name, "interrupts", rtc_irq);
+    } else {
+        qemu_fdt_setprop_cells(fdt, name, "interrupts", rtc_irq, 0x4);
+    }
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 25d7d89a42..9287edb96a 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -418,29 +418,6 @@ static void create_fdt_virtio(RISCVVirtState *s, uint32_t irq_virtio_phandle)
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
@@ -552,7 +529,8 @@ static void finalize_fdt(RISCVVirtState *s)
                               irq_mmio_phandle);
     }
 
-    create_fdt_rtc(s, irq_mmio_phandle);
+    riscv_create_fdt_rtc(MACHINE(s)->fdt, &s->memmap[VIRT_RTC], RTC_IRQ,
+                         s->aia_type, irq_mmio_phandle);
 }
 
 static void create_fdt(RISCVVirtState *s)
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index bb76816f6b..241fe185a0 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -132,4 +132,7 @@ void riscv_create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
                            int uart_irq, int aia_type,
                            bool uses_32_bit_spacing, bool is_serial0,
                            uint32_t irq_mmio_phandle);
+void riscv_create_fdt_rtc(void *fdt, const MemMapEntry *rtc_mem,
+                          int rtc_irq, int aia_type,
+                          uint32_t irq_mmio_phandle);
 #endif
-- 
2.43.0


