Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6C6C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyce-0003UC-5N; Tue, 25 Aug 2026 17:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyycb-0003St-69
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:23:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyycZ-0002GB-9u
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:23:52 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PLAUVQ3101202
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:23:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=AkchrvUe/LA
 mpQrPITt1acnChXhuDja4ZA5vZ5r9Sjg=; b=cYKaGBKFSwM8hGXaD6rRcE9N7b2
 gjVz4di3rvX64kgG/0uJP2ZobKVW0DdG9vsX2GenmpjCzD6qpwkRqPdcND45HSON
 SibZMMCe0/zqed5wZuYIzSB3GogsNJhxttV4u4sYv4yPmteo38jFP6LSKobDfw6V
 ENWz1RXwm8vwN5oXItM4w4eE67R57XCVdeFVHGwhunrpo2NVjwyt7lur1BvRu++g
 DduH1KxzEee/TGXtFlQaV+heH2af3AzmkxCGqJlV6g0cp6op+X7a4nnWh2QANM8s
 6q4o2CxPE60IWsHbWN0pxIcomzvX323i4rvUPSWaGmLS4Ow+ra2qaYIIUEQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9bkua1vr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:23:49 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-90a60102d6eso3252306d6.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 14:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787693029; x=1788297829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AkchrvUe/LAmpQrPITt1acnChXhuDja4ZA5vZ5r9Sjg=;
 b=C7jsV6hgmabY9v7Ml+/cXIMvqEA3IFu6BppGhubps/vwmayeFjRgmeaprJ70r0HS8E
 DuomT1A49WqZa3A/kkqLXVWKmYFymBRpn7U5NLmAn07N9KrVqLvu5I+t37/2Ep4GGoHI
 8MIf60pRxNj1GzOK9zt6AgdBalTgUXBswW4vACabDKFdJH4XscV2dil0mqe8mueVovKS
 ZMntiUd1828ZjpCxKucMIeKeWUQRaFU8qFwBmJ7E5GmlcxFfOHrWQQhoN+bOKy5/EIQm
 g7a3fzmHtCcSr/GdAQRSvhUe61SSWwGNkH7J8Fi444lv77N9dS15/4r723CO5UY0dHs4
 uuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787693029; x=1788297829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AkchrvUe/LAmpQrPITt1acnChXhuDja4ZA5vZ5r9Sjg=;
 b=qLAqHORHl8HZvoaSFsBxA0vaZCkrwn2vLab7D3slKMiQZvuQTbv8DRf16avlkPxsmu
 VEqnQzCXn/YZYuAxt+wQaTCnBsPocCy/Zj8NNTBMN4nVku7LUcbkZfPfemP8XQdxPDbb
 zEc73itnhswFZokI3f0JeK/uxG0HBJ2rXPowj+Xj0AiK7Kh7MSLuBDElWr1TQwa4EdLH
 moUQR1/IRv0cxhGlbiiwh/W8uyrgcLu9QMyeRBgfjhyj/96C+F33mNZddzOYijQ9TXFh
 TXw6ydkMI2FkQGAXPw/HeODeQY7kLby+z7A6yqu/CAyORu6GWxs+hCBexycOqF9cUTlS
 TR3Q==
X-Gm-Message-State: AFuF++mPALjPLllNz9ART7kH3bhTTkCuSiKylbwYst+akd15Xur3Q1HK
 1T6p5uozyEmEu4c6G0sxyJBcqrq1H0PqDv4O1KpDYcUhcsaEqm2txXSwHa8DpkN8T5/vfzXZtc2
 9QxWVbCSe4+txVLZJcE7t6siVgjfufmajIDAv2njgxRmw3oPp3ODMf8+Af/gCR79qHw==
X-Gm-Gg: AR+sD120UfSJrOmZbdd/TXTX/UqFcWLPIbTir/svVwaAE7f7WIgMq2duSTwqg+A2bfN
 JfDq50/f5jyIRPW9ZGRSpy5fa4dNw60u2lsGU6LhxkG3iHUnrnUPxOpTZJSJxPqMihWAWSRFsI9
 fqf3tCif+laBJuEc25KnNKxO2gzTAg+QP69nnNC5BQVhABNyXSBsPh5uWqrlXhT6yWMODrb/ypF
 ip9/n1UStHW2kl6Z08XOsISOUasK025DTf2d3lg7BmfrnswAk7ceBE6qveGYYLQOrnUsoyhg5O7
 bgCiVYGVMb0uBB+Zgw2IGURbPISDtoqh/yBPswvRBk93XJdVXFEBnIV9ag+++Ci+7b/V/g+Ru1X
 np5tWzMyjkirLeyaePG9W3oAa5cVMUyhXoTlHcQ==
X-Received: by 2002:a05:6214:568d:b0:90c:b640:7c04 with SMTP id
 6a1803df08f44-90cc79fe02emr19975496d6.27.1787693028991; 
 Tue, 25 Aug 2026 14:23:48 -0700 (PDT)
X-Received: by 2002:a05:6214:568d:b0:90c:b640:7c04 with SMTP id
 6a1803df08f44-90cc79fe02emr19975006d6.27.1787693028568; 
 Tue, 25 Aug 2026 14:23:48 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90cc65299f0sm8646386d6.41.2026.08.25.14.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 14:23:48 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 02/13] hw/riscv/fdt-common, virt.c: add create_fdt_syscon()
Date: Tue, 25 Aug 2026 18:23:14 -0300
Message-ID: <20260825212326.1907-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825212326.1907-1-daniel.barboza@oss.qualcomm.com>
References: <20260825212326.1907-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: b1h-AcDshqtECZkmNLcOl-l-iuBoCrcV
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE4MiBTYWx0ZWRfX3trcaO8aGp+s
 34g9Y5St9rxSXq7pEsCO2eN0DKiHBu3laz3uFl5+bzdbbkxWWunGzQfJ1LGjxFTJbYIJKi2ndvV
 EmggbhdoFaV24yVW150ZHVDnOVvuRcc=
X-Authority-Analysis: v=2.4 cv=TZGmcxQh c=1 sm=1 tr=0 ts=6a8e07e6 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=azO7UiENNDAzAd32FwoA:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: b1h-AcDshqtECZkmNLcOl-l-iuBoCrcV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE4MiBTYWx0ZWRfX/8Zvxz7qP5lW
 XQqWvUgAvvnkkYsZfj/uG/jbr/FLpxqRiomiPt4e8j4iylMUhsjtMusgz6GwHz7HuxYwZ9g7K7b
 bHHCTPMOOrOeO8pc0t+9nfJekxisH3qELHbHZy0X3j01pYpXJ92nzmiToQnufk1hULx7+wm8YB5
 uhRS/4mfLarUN0YAkLWLuaQdiMRtOTQRhIoerNfQBKprkpTHh5peR+2gds5UaC3ui96VbAxwXkW
 83nfn13K4EC7lDJxPDRpuYOeAklxH5oYESfIxNH5+wG2W1B4JyBKGZu68+q59ohpBMdWuN46hgk
 2FhKz5i7XG02x+BKSnwnXnMth4wAN6UaLWRPDu6KMNv6yP+BjxrrgbdI3K7dpMb0NmhRZhUeC+y
 6ev8cOinZFHqQQM1IFe6FTEvJcN86GZsar8T8mXyzxh7AdpI/NVWIca0I6ZF5KzzvMNqxQX5l2q
 iinD4K1zDp6LkkwIQMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250182
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

The soon to be added riscv-server-ref board will declare a syscon FDT
similar to what the 'virt' board already does.

It won't have a 'sifive,test0' and 'sifive,test1' compat string though,
hence we'll add a flag to enable/disable these additional properties.

The FDT is slightly changed: the subnode is now named 'soc/syscon' instead
of 'soc/test' to be compatible with the latest device-tree docs.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         | 53 +++++++++++++++++++++++++++++++++++
 hw/riscv/virt.c               | 45 ++---------------------------
 include/hw/riscv/fdt-common.h |  4 +++
 3 files changed, 60 insertions(+), 42 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index e74423a225..a2168c09ec 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -294,3 +294,56 @@ void create_fdt_flash(void *fdt, hwaddr flashbase, hwaddr flashsize)
                                  2, flashbase + flashsize, 2, flashsize);
     qemu_fdt_setprop_cell(fdt, name, "bank-width", 4);
 }
+
+/*
+ * @sifive_test_compat is used to create a FDT that declares
+ * compat with "sifive,test1" and "sifive,test0".  This happens
+ * to be the case for the 'virt' machine that also creates a
+ * 'sifive_test' syscon device.
+ */
+void create_fdt_syscon(void *fdt, uint32_t *phandle,
+                       hwaddr addr, hwaddr size,
+                       uint32_t reboot, uint32_t poweroff,
+                       bool sifive_test_compat)
+{
+    uint32_t syscon_phandle = (*phandle)++;
+    char *name;
+
+    name = g_strdup_printf("/soc/syscon@%"HWADDR_PRIx, addr);
+    qemu_fdt_add_subnode(fdt, name);
+
+    if (sifive_test_compat) {
+        static const char * const compat[3] = {
+            "sifive,test1", "sifive,test0", "syscon"
+        };
+
+        qemu_fdt_setprop_string_array(fdt, name, "compatible",
+                                      (char **)&compat, ARRAY_SIZE(compat));
+    } else {
+        qemu_fdt_setprop_string(fdt, name, "compatible", "syscon");
+    }
+
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
+                                 2, addr,
+                                 2, size);
+
+    qemu_fdt_setprop_cell(fdt, name, "phandle", syscon_phandle);
+
+    g_free(name);
+
+    name = g_strdup_printf("/reboot");
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "syscon-reboot");
+    qemu_fdt_setprop_cell(fdt, name, "regmap", syscon_phandle);
+    qemu_fdt_setprop_cell(fdt, name, "offset", 0x0);
+    qemu_fdt_setprop_cell(fdt, name, "value", reboot);
+    g_free(name);
+
+    name = g_strdup_printf("/poweroff");
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "syscon-poweroff");
+    qemu_fdt_setprop_cell(fdt, name, "regmap", syscon_phandle);
+    qemu_fdt_setprop_cell(fdt, name, "offset", 0x0);
+    qemu_fdt_setprop_cell(fdt, name, "value", poweroff);
+    g_free(name);
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 33a121abd9..acbbe458fa 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -766,47 +766,6 @@ static void create_fdt_pcie(RISCVVirtState *s,
     create_pcie_irq_map(s, ms->fdt, name, irq_pcie_phandle);
 }
 
-static void create_fdt_reset(RISCVVirtState *s, uint32_t *phandle)
-{
-    char *name;
-    uint32_t test_phandle;
-    MachineState *ms = MACHINE(s);
-
-    test_phandle = (*phandle)++;
-    name = g_strdup_printf("/soc/test@%"HWADDR_PRIx,
-                           s->memmap[VIRT_TEST].base);
-    qemu_fdt_add_subnode(ms->fdt, name);
-    {
-        static const char * const compat[3] = {
-            "sifive,test1", "sifive,test0", "syscon"
-        };
-        qemu_fdt_setprop_string_array(ms->fdt, name, "compatible",
-                                      (char **)&compat, ARRAY_SIZE(compat));
-    }
-    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
-                                 2, s->memmap[VIRT_TEST].base,
-                                 2, s->memmap[VIRT_TEST].size);
-    qemu_fdt_setprop_cell(ms->fdt, name, "phandle", test_phandle);
-    test_phandle = qemu_fdt_get_phandle(ms->fdt, name);
-    g_free(name);
-
-    name = g_strdup_printf("/reboot");
-    qemu_fdt_add_subnode(ms->fdt, name);
-    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "syscon-reboot");
-    qemu_fdt_setprop_cell(ms->fdt, name, "regmap", test_phandle);
-    qemu_fdt_setprop_cell(ms->fdt, name, "offset", 0x0);
-    qemu_fdt_setprop_cell(ms->fdt, name, "value", FINISHER_RESET);
-    g_free(name);
-
-    name = g_strdup_printf("/poweroff");
-    qemu_fdt_add_subnode(ms->fdt, name);
-    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "syscon-poweroff");
-    qemu_fdt_setprop_cell(ms->fdt, name, "regmap", test_phandle);
-    qemu_fdt_setprop_cell(ms->fdt, name, "offset", 0x0);
-    qemu_fdt_setprop_cell(ms->fdt, name, "value", FINISHER_PASS);
-    g_free(name);
-}
-
 static void create_fdt_uart(RISCVVirtState *s,
                             uint32_t irq_mmio_phandle, int memId, int irqNo)
 {
@@ -992,7 +951,9 @@ static void finalize_fdt(RISCVVirtState *s)
     create_fdt_pcie(s, irq_pcie_phandle, msi_pcie_phandle,
                     iommu_sys_phandle);
 
-    create_fdt_reset(s, &phandle);
+    create_fdt_syscon(MACHINE(s)->fdt, &phandle,
+                      s->memmap[VIRT_TEST].base, s->memmap[VIRT_TEST].size,
+                      FINISHER_RESET, FINISHER_PASS, true);
 
     create_fdt_uarts(s, irq_mmio_phandle);
 
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index 6e438e0278..31203df517 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -37,4 +37,8 @@ void create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
                      bool numa_enabled, int socket);
 void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
 void create_fdt_flash(void *fdt, hwaddr flashbase, hwaddr flashsize);
+void create_fdt_syscon(void *fdt, uint32_t *phandle,
+                       hwaddr addr, hwaddr size,
+                       uint32_t reboot, uint32_t poweroff,
+                       bool sifive_test_compat);
 #endif
-- 
2.43.0


