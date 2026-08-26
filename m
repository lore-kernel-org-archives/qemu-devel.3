Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B64C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzLSa-0003HD-U0; Wed, 26 Aug 2026 17:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzLSZ-0003Gr-Ks
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 17:47:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzLSX-0001LN-Uj
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 17:47:03 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QKdfOM1887392
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tpRAevs+tIL6voEgsKUvb9JmCN1hmS8Gb6vHGCohYrA=; b=dkwY7twXvvnhmmIR
 78VA8Qxa8y0mXSxXdQn/AJXgv+EgJJZAzuSPnbw5B2DTIyAk9F7rVwIj1VQrvh36
 gibKXFpJQiPvmyU6KWovkfkj8LKcFbHcgjFaZ/tlUYaYnBXNj5ttDLFig38uPe07
 rKJ7088+t3XFyE1mFiEbpe5oiW8t86juHDVMB881UNkXU5mf8IKdraHWioTjoZwj
 2o38y39GIHLR5+Hnuxngy2pYoQG5cJFNj/Gu2z39aVsVKCYCKbKEg6D2DYoTURUU
 uohhyg3jGos0JMIKqG7swNAloeX5ppCRUHdOeSSZXFIr9W6iDK4TITsGdnnqG6Hm
 rw6Kog==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9x2n2mjb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:47:00 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52d7b3adda4so439211cf.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 14:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787780820; x=1788385620; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tpRAevs+tIL6voEgsKUvb9JmCN1hmS8Gb6vHGCohYrA=;
 b=avLGqnBvzGJHhvn9Hz5jYe4OKMkQwe5dCmKMCO2deG43pdSKnwqiZycZDLEYFVyq/z
 VUVbiwEk9X5fKGsKGSBqfDfb6RrTla6TjiOQTbiPtEE2r2GEsry9zMVFiV+ZeNmBO1ls
 m0k4UlqSdmA6DzH8oyH99w3n1lY+2TK/rM/MzV4TwXd3Q144gtW+Fn/UObiJpiQ2ka9d
 ipc6tm2jUjj8S0m2w3dQPWJZLUKQcca9s0e3Pd+qunveOnIZk5ul8xcXja1ksoHG8SDm
 fA6J/StFmNKTEt6NIwdtsj4WeYFuvhZ7CusfcU2Ly//KU4slj8gBJC/GsbMLXBDpculK
 MMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787780820; x=1788385620;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tpRAevs+tIL6voEgsKUvb9JmCN1hmS8Gb6vHGCohYrA=;
 b=lytoUD3jNzQ0Ulyd9Z3UXiLoliXwTfF22Vp2YFWxbm/zInUDUvaIw7lsD0Z/zufd7U
 /3KRSnazC3x8mc2Zw2MHapORn06dH7EuZ1cQZrQcYPqc7+Lkm6hdjmcnhSRk9Cqp8mEv
 v/eAoWS+DiZtwnUfEc/IhZ55MZf1rh/D0XNB2dliwChm2jno5AdeCNhQ9+PnAnjxPG8P
 7tpJqKWKQUo+DUvYivzFFbTnRHb8sj9AtOlrDQr+GHZYnXxPopMfSYqOgwm4nLKq9H1+
 CFBtepp2XyrrpEanpC455sN60328+yYTiZ5BFwh8K3w5gR4GiwCg6j8ahJXGCT+elnLa
 TJUw==
X-Gm-Message-State: AFuF++kX8mZ+K3A/Ake8MXMkFTwATL9CrC/xVfpmqYDtc17I3Ei40egn
 eUS1ryLLuqyNovJ5hH2pvsZ62wI7P8Gq5ZchwFmvpQBbjSvihH7ao4goDb0FsiuJaadJs6Hnwb1
 tSQ25otTqkYcaALKDWNz51ENSEAQhbfeJBpAjHw3a1uLl66bqVz0Q3DL27MyMsPQxiw==
X-Gm-Gg: AR+sD10KlmaXJLuno6OrBvAxklNJTInFC4TyG0rTXEwjJH+CQ2qbZ+3NuWAAmZP7ChW
 Bl/lnql4kOZQo4rEVHDCsdwsy3Zcw1dHKR+MuwOac6/qrSskfAKwvmONX1aOXD+rbZT9J5C5Rqp
 eBqxjQgf70jduhwXTTP6H7dnu0+4KA1SS5wlE6YABqrqKwqX0InHgVUUAcRG0J+8GiOreFSwNnB
 VRND7B2KRUfnJAx18idhmtwaeTLHvkF91MZkJ7WEQJKWE6xmKiODTShLVxRIlyyB0I6szZ+FK+3
 Qe/oOT0ci14PbJgGo52j0PTIzq2QoAsL6vqDd0EVorDjf7HSDWevXqvJ7Jwtqtpjah+Itm9uaPn
 4xR5f0tRpY1PqRTVU+BkWpZ33Sa0cpNgwwdNe9Q==
X-Received: by 2002:a05:622a:8592:b0:52f:9eff:959a with SMTP id
 d75a77b69052e-52f9effa840mr48876731cf.11.1787780820122; 
 Wed, 26 Aug 2026 14:47:00 -0700 (PDT)
X-Received: by 2002:a05:622a:8592:b0:52f:9eff:959a with SMTP id
 d75a77b69052e-52f9effa840mr48876351cf.11.1787780819667; 
 Wed, 26 Aug 2026 14:46:59 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90cd73e4117sm490916d6.24.2026.08.26.14.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 14:46:59 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 03/14] hw/riscv/fdt-common,
 virt.c: add riscv_create_fdt_syscon()
Date: Wed, 26 Aug 2026 18:46:31 -0300
Message-ID: <20260826214643.122728-4-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826214643.122728-1-daniel.barboza@oss.qualcomm.com>
References: <20260826214643.122728-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6GW59MjTKp0eU5UWcmd-uiUjWsVz5Hb5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE4MyBTYWx0ZWRfXwmZRZl6Mp40a
 VYiRurHws+I5phqbnRjdIdGetmhL1oGKai39u7QX/Q0SXmLYdu+Z5aIkp+HoiZdzVncLXX24/zZ
 LrcOW7zopzIOpixHZ9RjrcE7lU+UxHc=
X-Proofpoint-GUID: 6GW59MjTKp0eU5UWcmd-uiUjWsVz5Hb5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE4MyBTYWx0ZWRfX9f7IlBtx4/mn
 i9sbhIJQrTT6uZXR0DQbJPIwiYxE7VNJXpkpNkWyKYfj7GYfANI8UbXYMnhrLg9rHyAIFpDdJjp
 +y6wdBq131SJrnVYQEIu8s9bYLgdotRsw7DC62ripkxhsG5smS/lz2EP0IBOjFSbIq1alIJ/f+0
 CE4vsYBK7snqGv1RTsfAb4YHr7io9nL5N/u9cbsRKUcRnwM/yF8nb7ElvNsHtVeq5spT1M6783T
 GQutF3e4m38DoLSs5v1EqvjN85J4MpQE0j1JwPW7kkCfuYbQoFMWvWnOIqHypaA3OJsGhkKeb/c
 az5VKUUlnAkXR7z1JDgJmxbQ6p0AscqfqRBOkeVrEG1OFPdVTnpSGamXCGLAfuFZIlWGzWHdKwI
 RtMXUQvY5NXxBVOaSUNzXzSnXpCB8N5hV1ePb/TujNYHhgeReF4PGPEZ9kkZf8HikGINC1myyY4
 h3XsqRRuhP1teX/n6uw==
X-Authority-Analysis: v=2.4 cv=PPQ/P/qC c=1 sm=1 tr=0 ts=6a8f5ed4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=AqYGxfEHplewfouIbmYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_06,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260183
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

The soon to be added riscv-server-ref board will declare a syscon FDT
similar to what the 'virt' board already does.

It won't have a 'sifive,test0' and 'sifive,test1' compat string though,
hence we'll add a flag to enable/disable these additional properties.

The FDT is slightly changed: the subnode is now named 'soc/syscon' instead
of 'soc/test' to be compatible with the latest device-tree docs.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         | 53 +++++++++++++++++++++++++++++++++++
 hw/riscv/virt.c               | 46 +++---------------------------
 include/hw/riscv/fdt-common.h |  4 +++
 3 files changed, 61 insertions(+), 42 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index 6fcc1ce21f..4406887f98 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -295,3 +295,56 @@ void riscv_create_fdt_flash(void *fdt, hwaddr flashbase, hwaddr flashsize)
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
+void riscv_create_fdt_syscon(void *fdt, uint32_t *phandle,
+                             hwaddr addr, hwaddr size,
+                             uint32_t reboot, uint32_t poweroff,
+                             bool sifive_test_compat)
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
index 56b984c5e5..371a900071 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -767,47 +767,6 @@ static void create_fdt_pcie(RISCVVirtState *s,
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
@@ -993,7 +952,10 @@ static void finalize_fdt(RISCVVirtState *s)
     create_fdt_pcie(s, irq_pcie_phandle, msi_pcie_phandle,
                     iommu_sys_phandle);
 
-    create_fdt_reset(s, &phandle);
+    riscv_create_fdt_syscon(MACHINE(s)->fdt, &phandle,
+                            s->memmap[VIRT_TEST].base,
+                            s->memmap[VIRT_TEST].size,
+                            FINISHER_RESET, FINISHER_PASS, true);
 
     create_fdt_uarts(s, irq_mmio_phandle);
 
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index b422da6aef..c643681155 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -39,4 +39,8 @@ void riscv_create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
                            bool numa_enabled, int socket);
 void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
 void riscv_create_fdt_flash(void *fdt, hwaddr flashbase, hwaddr flashsize);
+void riscv_create_fdt_syscon(void *fdt, uint32_t *phandle,
+                             hwaddr addr, hwaddr size,
+                             uint32_t reboot, uint32_t poweroff,
+                             bool sifive_test_compat);
 #endif
-- 
2.43.0


