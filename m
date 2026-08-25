Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D561EC61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyycu-0003gM-A6; Tue, 25 Aug 2026 17:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyycr-0003fA-TY
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:24:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyycq-0002KQ-81
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:24:09 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PLA3iT3117139
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mtAqNjFTalh
 hyet5/Af7MHgi6AQrHr8o4cFzerJDZDw=; b=P83RMIawkx1Ak0OmfVug3Aa49/8
 s9aNPoZOwaWJeaqL12WN6TMt/Jls7h1QiGWoarVZPQZ8DnYyscQd6RyO5iJ59ysO
 GIcawJcWlucVlKzxnz2qhynQ6GV8pKLsHNW+PoAPbbZIQGa/VHorLhiiN0zjmLK4
 +/1SrtVjoxifNuVTzxO1rmonP4Yma8zIOkPREuNPBy9ToNi76qKqHwPxAlyIyKm+
 58wiBmnK7LS5UB2sb6h9mu3SKVElCpIsP/S1eDDz30NuPxywun1v9fRiLGZ6v2T9
 WkhqkYrpY3vr66W/6LdrEqM2VcWN5usjcLTSs/I55CND5YfA2v9291jyuUw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9g4mrk8t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:24:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e52306621so19168085a.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 14:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787693047; x=1788297847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mtAqNjFTalhhyet5/Af7MHgi6AQrHr8o4cFzerJDZDw=;
 b=kLDT2icHy5PPYi9+CQEs99lwSD8VgwmGqIZ+bLHq1SunnjYFuuiv9loiLJC5KXcFRh
 BvzDWx+MYtE8VVOZcnqLzy85IT768Q5q+g9q4p69R0yrEjGTtWcF76c8QgdQpGd8hRex
 elPsdOK7PEIkXo6LWrYUOjMJDT2YeNFHwxTylMFs5rVxiueQVBzwcWqNFb0RDyCJWX5R
 mQd8zV4dryBwAdpkoe/2qpCo4niOIup6GR33yJ3EsEJLp4GEGXtFMJeHw/r7iSAbjE5q
 q9TbJ7lqTsrLSD4QflZNzmX+tPV58QitAZ+n0+kvbdjchHubU5eJvVE576sjOuqcMtiy
 clpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787693047; x=1788297847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mtAqNjFTalhhyet5/Af7MHgi6AQrHr8o4cFzerJDZDw=;
 b=o8vQkHPL+8W6WYYrHDcC7HZ18C6jttjcXTu6/InRF/GAxTsjVfSp/aXHBdwEQsSYVb
 q9gve8wpCWh8QyO9JYA3svrFv7lOHhjGgAlsacpf1BK6u1jPlh2MbhjPEF/3YbPSjuD4
 X2HtvLIyCAXkOZc+3sqQ/H7e9a6vfqhO/t8JGtRQ5oJkPnrlyguDQ1Yvs92DMvaNsWyr
 QJbJyFB71QAfXiIcjw1vxJTAUGqNTu1b7aPZ7iWMPbXw/NANtEnvKliYjrKowzzivlUv
 qVylHc/zo14lJK11S7olkTGcM2++KR3C/AR/IZHwTBSEviDveeH/AtcgIHy/H1UUgoZN
 XCfQ==
X-Gm-Message-State: AFuF++k8gbR7GmHpsRnQe7WYKu/aQN62ztLXv54mfENRfbfEGd1nWBrW
 e+rfo+vVOgnrBAW9iiOYGo32HDDzFGUF2ssRFgRtWhKWM2irYLQafkIzNT3V0TQJ/FFKmnquTiK
 VgzrWiGzgagUK03WhY1tI4zfUbwVmm3TOcucRsWmM79Q0wa6nOHJRgGKKHicN7ZHAOg==
X-Gm-Gg: AR+sD11CF8Xe0ikmYuhZoTY7IVuZ2jEWGa3fCS1N9PstXRjz2PRQ6pLTbRqCepkL3eD
 uuEMn0qHIHul7Ek63O1fBVDO3XSkb58eL73nd79JH/w6oqObyr+B+2k3fuFA4vQljChYTlPfaQ1
 DN1kljPcqjcWUuEbA0SBTw8jxandh5E9tJzmPj2/Ada+RusxMlrec5F61Mrvb2qpWw8fLSF2vbw
 Mv6T4yLEGk03MU/d4cv0sgM9sypr0lhcxG4fyk2iVXEjc9U03wNFFJyFgyPlc1y/Bao1tDhDncX
 ZIOJ0c1emwEbSLNSLSszk1V84EaYlPZXxlKKT3wgz5WwRzJOJFtsD/FI0T6Tb9GMudRb3z76Hbb
 N/ZD6B4/mIs8ILHCdv5M9OTLyFsLnu4sWNDAI0Q==
X-Received: by 2002:a05:6214:1c88:b0:907:5150:a2dd with SMTP id
 6a1803df08f44-90cc7970129mr17104046d6.14.1787693046619; 
 Tue, 25 Aug 2026 14:24:06 -0700 (PDT)
X-Received: by 2002:a05:6214:1c88:b0:907:5150:a2dd with SMTP id
 6a1803df08f44-90cc7970129mr17103406d6.14.1787693046146; 
 Tue, 25 Aug 2026 14:24:06 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90cc65299f0sm8646386d6.41.2026.08.25.14.24.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 14:24:05 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 09/13] hw/riscv/fdt-common, virt.c: add create_fdt_rtc()
Date: Tue, 25 Aug 2026 18:23:21 -0300
Message-ID: <20260825212326.1907-10-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825212326.1907-1-daniel.barboza@oss.qualcomm.com>
References: <20260825212326.1907-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE4MiBTYWx0ZWRfX0JXf5P+YGZYB
 rbj5ix3JpZyg1ehgc0XfPpS+AV7tg2cEHdc5MkpbfFW4qVCPE2N1ICw67sKXsJ/XTMX9RU+B2pR
 8QZW/naXwvcSx18O9Spsx0gL1poHMFI=
X-Proofpoint-ORIG-GUID: PIBF-U_M63OcoUNXPSvvfCAj3uWXKPfC
X-Authority-Analysis: v=2.4 cv=eYgNubEH c=1 sm=1 tr=0 ts=6a8e07f7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=RnOvKumpmH0hROQiWQcA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE4MiBTYWx0ZWRfX8cxhnGRcb0H6
 ttyUE385kxFwZghQS3dRO1JmcR1cj04QeWd2DI457rH39WgCBOCYPe869kVQgKYbMWED36WIDFG
 BiNYTiU1A91GuFy1SQ9q2Kn1XjUl7kQB6JvjHE/4wqGWjEgj/QaY0uKs5NRgN7UxfyP1p2D4FbW
 GyM0uo2yu5hAjQFRcj2mRJ+aTGQvcya2GZR0lSWICGdHwr5ZxidyjBs2xMYP0PU6oub0JtzW7MJ
 +iQYR0cMcdN69hlbFqaDUu7EqpzCumd06y13zjVbqi5f987mlxal0Ou4qI87OUNg+nSafNosUh/
 Z+xfHpGB4NUeWxVQzAUd9833TkbQN3VvZDa8v72Y87eF77qhi1Rg8OXquXtma+6yXuAywskyGrc
 S35ahNyA4KWomxopSDDO+nkT8nsHIsLzleB7Fz+fO410K9aJD6lLO4dLwXLXzo5gTSIDkA7oqdM
 mG8QkTKLPXcMZtevGSg==
X-Proofpoint-GUID: PIBF-U_M63OcoUNXPSvvfCAj3uWXKPfC
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
index b3f3af3762..4e12b5741e 100644
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
index cef1073449..fc518ac939 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -127,4 +127,7 @@ void create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
                      int uart_irq, int aia_type,
                      bool additional_reg_props, bool is_serial0,
                      uint32_t irq_mmio_phandle);
+void create_fdt_rtc(void *fdt, const MemMapEntry *rtc_mem,
+                    int rtc_irq, int aia_type,
+                    uint32_t irq_mmio_phandle);
 #endif
-- 
2.43.0


