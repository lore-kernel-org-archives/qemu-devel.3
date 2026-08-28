Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59806C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03Mx-0007jK-F7; Fri, 28 Aug 2026 16:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x03Mv-0007eM-UH
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:40:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x03Mu-0006ZY-Cm
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:40:09 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SJ7OMb3675418
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 20:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xEdPCCLzIVRspO+yj25546pzzNDI8awn4evP4Q7pQ/I=; b=Ql7qoHZLR+nLVTDN
 6+SSjRtCfcECJ+Q174C4j0CBbXHqZhX/T5R6vhdlVuP1UjLbEE0ZtJuYo6W9eRiI
 X64uW9qIIV1GNTNCIquormFBPp0He95fJ6jIHPFlwGdJb4yIgrkRYP+mv1hk+YcG
 +u6833JCUmiXAaOIV21E8jqK1+lGS3EKsrrbMoSPQhGd5N8wexFcPTT+STQQyHKM
 n6xF3c3HuVx5sfIOwLieGa6wYpxO61nSdF4YwXORnrpfQkolYL9KhP9lW6g9HPw9
 iq+xKscXrEWiaW70R5mZfe0AQ5yjIf5LAe8Q+b1e+yg4sWfeUnJZnNBADn4/AwPe
 7F+Zyw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb3hs3jjc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 20:39:57 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93494527488so235909485a.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 13:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787949597; x=1788554397; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xEdPCCLzIVRspO+yj25546pzzNDI8awn4evP4Q7pQ/I=;
 b=cLhrVcpx2KLlIYV6mckyjRc/1XbDHGn2uAXMOXggvM5EsaTZkSAWl/KBkVfew00Bk8
 2IYP+m4oR0tZAhnYzA+V7x8xIffHG+cOL5xhc4096/di62c6hg8wryB9LPREPk6HNTI4
 d7tb8v4VsJcm2u0XK2ur8gm+wPMJdSXwplphjc9xTkpSfX9af+rYn4jJfNjkiIl6+wey
 MHN6snGbKTdRvnxlusNC9z5gNx3Et0tXVqy0C68LFGFmKIkoJCOYhNqbnO9lsyMt68/Z
 KqV+6xHnzzcsPLU9hAFXZSB5PPqJ/OQaC82JTt+GLn3X6YpFlUFWVcDlSAYx0LjkTAa2
 mveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787949597; x=1788554397;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xEdPCCLzIVRspO+yj25546pzzNDI8awn4evP4Q7pQ/I=;
 b=HjpxwK6KUDpD6dqLGPZLUM6S0GZV4OngDrPGN0LJLNUOyyECwaDFHablDpMslagNpM
 r2t/Xgp5mR0L3F/TNHr1Cztd98XtXKNXgD2cE+bJR5BbdtjesGBbqLufU75xgLfI4H0Y
 2aluwJZDLQkvC0gVr4rh8+k4KqtHqN6KC47FnOQBibO9Rpj+22IVdrofHkGmhKrR8jvS
 XuCgmSXraZHiA3OgpkSo37fej7LdHh859mvPp8XhFy+BhPIo5EYxpZl4ytWIpIudYIg6
 RativdrcLXPOiUgPX+PoZQE8Pa3Xh3klNSpBlsySIuLjEdZiAkcq4uow2QxFUX4Ru42M
 636w==
X-Gm-Message-State: AFuF++m+aHCnrMTebgSkSadEX54gHccdy9k82Bx0wVHIVLJ/XTAdIzmB
 1RlM1k3E/+oUHu/5vneAcbXBXIT+hcjP4gLM2EFsoaer3uk4Aa07zPNBXhcLYQH0oMfCV7gJaKf
 SdE5Oqg2z4SIwIuHdFbjHN9GZZaRG6iKh/TvEAlsv1vQq8orX8F3MDzm7cr/X3rTchA==
X-Gm-Gg: AR+sD1094FBREtJvh4/Lg4iAb/cCzlLHh9heiWDRKYm/tppaswe4/OvEbDyZ8VCvzOR
 1wPjhj/0G2Rx1Rg8eym8QekVvRInUDxqipt0IZsvL1F01nPYS+fyErPOtn3DRxAkiXi3UkokpdR
 WvsjWmBvsLkBX6DdE0hcXTP5cdt+rc9XPOypzL0tpE+64AUKv2vScr4S/niBOGLvH8Vtw7mLomz
 nuJILWM+9SZA4NLYKS9fEniM6WUe6X4FzV2s06hPgVWDhG/NpDL74IKmw8/TQoezmzXh94U6NA9
 nzBNvnqAQYQ7vP1Crbltwf/WqoeCMMNxd16topPNTHeL166LgZbzMOvrX66NpD6gVNhgu5UVSSz
 cCzr7NDtvVjkOmtE/QgMJDT3qIDSQoIkh29wMaQ==
X-Received: by 2002:a05:620a:a0c9:10b0:939:595:e132 with SMTP id
 af79cd13be357-939137b133amr904239185a.5.1787949596734; 
 Fri, 28 Aug 2026 13:39:56 -0700 (PDT)
X-Received: by 2002:a05:620a:a0c9:10b0:939:595:e132 with SMTP id
 af79cd13be357-939137b133amr904235585a.5.1787949596281; 
 Fri, 28 Aug 2026 13:39:56 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939173f2758sm218063985a.37.2026.08.28.13.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 13:39:55 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v5 11/15] hw/riscv/fdt-common,
 virt.c: add riscv_create_fdt_rtc()
Date: Fri, 28 Aug 2026 17:39:13 -0300
Message-ID: <20260828203918.350131-12-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XKYAjwhE c=1 sm=1 tr=0 ts=6a91f21d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=RnOvKumpmH0hROQiWQcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDE3OSBTYWx0ZWRfX6rEoQbaWXHZ+
 M3YyvMmP/qfX6dfbcqGS0Wb+OzPlN8dqOMcOipXLIP8KjnK67Q44yIM0MYU1NJ1XmdBjadVrlWS
 WQ6HyR/Cd4gNlePp3w2dTh9LBCw0jV1eiEodw5bRM3N0zeC3ypaFRpQ77WP8GX4SbBGWhmRO2uG
 JqDk5GEkXNvbxJ2JstOhzDYmIMoRteE0jUOr4t9WWUHdK0NhCSUMZwTyYxxFqeAMOFuyoJAmM21
 DmGnPZKTOBx77VDb+xDPJnkokmDMxhD+kh5v+6/cfHyOWY2X9+stT6mf/nxMMPafoMFweTgWsSb
 j5dAyqnbtgkhUapN6kz/wCSCA4RdgBvmRDLbhdwELyJP2x0bipntpn2dEa6/nLR9w5KHUlHxjt4
 ArT5M93V8iz4nYuB4Nbzetet8sXDuv3jAR9k0w1kX0gpNJfz+EcgJ8E9gOGOsHybPUewJEBxb5G
 x8ErdYVj8D4j2AqrxXg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDE3OSBTYWx0ZWRfX3VV+1N8JXps3
 L1tMD6A6DNp3CIV6VbCjFT6PJPfwWc3kbQ4gDzK9iwhlxNv/zoXPa1LMnmpAxaO69FEtayAsV4+
 iXPEwoSmDL2zlAR/nItIZJLcyswpZqM=
X-Proofpoint-GUID: 9W9u-QgyvAIQ4XpeQm2w4lI8Kn-XFePl
X-Proofpoint-ORIG-GUID: 9W9u-QgyvAIQ4XpeQm2w4lI8Kn-XFePl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_06,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280179
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         | 21 +++++++++++++++++++++
 hw/riscv/virt.c               | 26 ++------------------------
 include/hw/riscv/fdt-common.h |  3 +++
 3 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index 0107aadaad..ce2dcb43b4 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -828,3 +828,24 @@ void riscv_create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
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


