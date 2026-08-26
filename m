Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05309C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzLSW-0003F5-Hd; Wed, 26 Aug 2026 17:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzLSV-0003Em-Kh
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 17:46:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzLST-0001Jh-3l
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 17:46:59 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QKdSr31464068
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 p+9P5IDeo2E3bJgBm+Bv9eguF7RWzHnyZjJE5Q+QRC4=; b=eCSeNirCiROZ0NiU
 kRnVXJ9O8xIKcTeKzZdYg4aKFXXHl+P9/qNAKQ8y1t2neCBIdvB0Ey9jSX7dTWkI
 LUd7KS0WZGI+OTPstVEAgNHjosp7VAb0ssHpKvoddk7gznZWnGiybRF8QGgyND0n
 9PteeDbgy/wShEbI/TtjoGgJ2OjBPWpqKSqD1itwidcdLdrLY9FnKVlLjTa+yfF6
 hcGzWgBrpSTsH1shDbiJmy/nVhhCcy6JFAOrkPEdgYSxoJHvyfTl1he7aKN3ycC8
 LSWno6mmokJuHiKs0EHxO75SFnj3DdEvJ57ona8ICnEJhNKiE0UXwNbKvt8xcsNV
 UtcQDQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4fwgwx6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:46:55 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-90cc9140539so4063696d6.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 14:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787780815; x=1788385615; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p+9P5IDeo2E3bJgBm+Bv9eguF7RWzHnyZjJE5Q+QRC4=;
 b=Gvj+Tw7mCIcFO7q7tR97V+fHgmD3I6WUM/mV8oXlb2W6CtB6bS4xp6YHCZzGA/93Ei
 1+fCFgaMmXZmbfiYjZm6wijC12WM/p3ktaZgN9aqzwdXmvaFQK9eb0HmYUWR0mb07oQ4
 zsLqBpoQpVS3ClYVArAHmSY9A+Cw2a2xj31Xe2jAQ5qirR2pnURZAJLE6Okl5Crw1Jr7
 r1g38R/ohlHmS0y3e0K0dEtoYbG2NxTyQFzL9QiTXj2NVEw3KFO1gvGHz5rfz2e6PTdc
 IowMD1GDMgyvS0qzR9KcXCXmPtET2evxhM2XmvXGywOibCmNj5SNDjGIsu2RDA2xL5hq
 F6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787780815; x=1788385615;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p+9P5IDeo2E3bJgBm+Bv9eguF7RWzHnyZjJE5Q+QRC4=;
 b=LHOezece8NgSzfntf3fmN1QCTWBD5lFRVoV0nsfgNkVReLtlfp9tgGuTbQdIoJpcJL
 bk4lCbvZLb7NXn6q5CJZHAIJ1o/Sx4s5TgLgLf6UFKS/PFf1nHKeMMvZkE6CrKWveXpe
 WRZsngkHwhIysD09daKaWlzi7bKZA29F/NYcmSMJ8t+rFa0hxzcqdYQaoSi02vKQ6tbj
 Mk8YvxVi2TzUWXNsqy9shZqJgfHMIuBvagOb93NB9Lsw1GxBKWwX5zVFcMYNXASQcA7B
 v2weMrmsOnnCbaDJV9sUwK7wx37CYev0QWRR+ue4QQfoWHKbmfYfzU41AEHObJBFNOWd
 LPfg==
X-Gm-Message-State: AFuF++kFb9eGqoCig+BbLmNYScMLaF4kskbxVZb//afAltvltrn8A/6g
 j5rICDn/zGSpa5YYjHp+yyXAWnXikmEOF3UFSYH+Saxl4FYYMK68Jxe3qMgdzlsHzMTAB7BUWtP
 IKVf95m39VaXccJxZgb5tZy/EjiK/h/fTgW7+/xcndt8rSE8QKM/pCfPKZa4xV34TEg==
X-Gm-Gg: AR+sD12lCYxBX10VDeL/VdO9t6dgR8aIO6C2l9rraumKcXl1Xg5ObdAQ2of57NvJtoD
 g61wV8afpw6n564lIZ1w0fXNVWXJ/nj8ornDggHFAAzlCdkZaC2BBrteGqsBQ12lMBLzy58KVz1
 Le10hZ3UEahnvHyD0PydIaZK7El4YRvVVRXnz6RzFlVQLQWX3qz8Z+dkLVV7bH9aA9V5dAniQvZ
 5DbU2prf822zpyc/rdS7pjVy5zeDrIvR/8IhG4McjAm2vLYZZbLNZKwq7RroPnNjI/EEm2BFqfn
 HeSquNAWUK2cSNExpruBlmcxn4bsUlAZ4bTckP3GfoIDPBMIEy8/DwmEgubhwB3ak2dlWGfDAZk
 1pEDiG57Q6XBmtfsozOBB/ktiuKvDLzZjzO3mbg==
X-Received: by 2002:a05:6214:5f0d:b0:8f1:ed00:7fd8 with SMTP id
 6a1803df08f44-90cd4368dfemr33519996d6.3.1787780815198; 
 Wed, 26 Aug 2026 14:46:55 -0700 (PDT)
X-Received: by 2002:a05:6214:5f0d:b0:8f1:ed00:7fd8 with SMTP id
 6a1803df08f44-90cd4368dfemr33519576d6.3.1787780814685; 
 Wed, 26 Aug 2026 14:46:54 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90cd73e4117sm490916d6.24.2026.08.26.14.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 14:46:54 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Joel Stanley <joel@jms.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>
Subject: [PATCH v3 01/14] hw/riscv/fdt-common: prepend helpers with "riscv_"
Date: Wed, 26 Aug 2026 18:46:29 -0300
Message-ID: <20260826214643.122728-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826214643.122728-1-daniel.barboza@oss.qualcomm.com>
References: <20260826214643.122728-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4H9swxyGEzB4Fvj7g724h6s9Sa99Z7qM
X-Authority-Analysis: v=2.4 cv=OtZ/DS/t c=1 sm=1 tr=0 ts=6a8f5ed0 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=SG9m4Rbq3iqSK_q1YnQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: 4H9swxyGEzB4Fvj7g724h6s9Sa99Z7qM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE4MyBTYWx0ZWRfX6M1N9pmE72th
 L8QdeSCKgDOwF3if6jqJ6rVSvePkgpFFv2ET6IE61WPeoO21+5T3/t9Vh5NBPxDYH5k+EIN6ZaQ
 p+X5KjrqcmC8m34+jF2mmydY6XXYTBT+Vrra246SMe5vVj8K4I4+JNiVxKxEVlRmhuSat4NOXi5
 dR2eG/am0NmpG4vOt8MudLFBYrpPCXXtbWuy77kp5UEQPJNmUtN19BekbBmTOkR3hDSOzmysgcm
 HJ/Cgx+bNGbdkTnUXTIX7jG9C/YgUJ+Fo4nEvGWZcaVzMPCj3sCVaERsnf3GzDKvz2NURkblrwD
 FG2ebLnPKLoaZ1o61oO0LtOBGQ8I3f5EBxFn4I15JVSdkBl/oTT7Yts24R8ZsVz5fmstjug8xXC
 RaRb1Pa6SUYNJuUmH2y71xqmg7ipQsu//NyTGrUioHybxUv5zlFNSCv/MlU3O9QOAKKU3KUZuma
 m611zAgrH3x81fWe0lA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE4MyBTYWx0ZWRfX0dVxmdWpIlHg
 9r6cnFC7mgkYzj0eTyj7s11E4r7XDV1wQZ30zlN+PDdQ28E47WPOyhxIbdA0V6dMp+Jr4zz4rkp
 G3Wea3f8o4AXhFjbl8Wp2hT6FyFq0mg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_06,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Given that the helpers are public API we should prefix them with
"riscv_" to avoid conflicts when linking with different targets in the
future, i.e. we should not use generic names like
"create_fdt_socket_memory".

Despite the amount of lines this is a mechanical change and no real
FDT changes are intended.

Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         | 45 ++++++++++++++++----------------
 hw/riscv/sifive_u.c           | 34 +++++++++++++------------
 hw/riscv/spike.c              | 30 ++++++++++++----------
 hw/riscv/tt_atlantis.c        | 22 ++++++++--------
 hw/riscv/virt.c               | 42 +++++++++++++++---------------
 include/hw/riscv/fdt-common.h | 48 ++++++++++++++++++-----------------
 6 files changed, 117 insertions(+), 104 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index aa143a618b..3a8da03cfb 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -14,8 +14,8 @@
 #include "hw/riscv/fdt-common.h"
 #include "target/riscv/cpu_bits.h"
 
-void *create_board_device_tree(const char *model, const char *compatible,
-                               int *fdt_size)
+void *riscv_create_board_device_tree(const char *model, const char *compatible,
+                                     int *fdt_size)
 {
     void *fdt = create_device_tree(fdt_size);
 
@@ -38,8 +38,8 @@ void *create_board_device_tree(const char *model, const char *compatible,
     return fdt;
 }
 
-void create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
-                              int socket_id, bool numa_enabled)
+void riscv_create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
+                                    int socket_id, bool numa_enabled)
 {
     g_autofree char *mem_name = g_strdup_printf("/memory@%"HWADDR_PRIx, addr);
 
@@ -52,9 +52,9 @@ void create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
     }
 }
 
-void create_fdt_socket_clint(void *fdt, hwaddr addr, uint64_t size,
-                             int socket_id, uint32_t *intc_phandles,
-                             int num_harts, bool numa_enabled)
+void riscv_create_fdt_socket_clint(void *fdt, hwaddr addr, uint64_t size,
+                                   int socket_id, uint32_t *intc_phandles,
+                                   int num_harts, bool numa_enabled)
 {
     g_autofree uint32_t *clint_cells = g_new0(uint32_t, num_harts * 4);
     g_autofree char *clint_name = NULL;
@@ -84,7 +84,8 @@ void create_fdt_socket_clint(void *fdt, hwaddr addr, uint64_t size,
     }
 }
 
-void fdt_create_cpu_socket_subnode(void *fdt, uint64_t timebase_frequency)
+void riscv_fdt_create_cpu_socket_subnode(void *fdt,
+                                         uint64_t timebase_frequency)
 {
     qemu_fdt_add_subnode(fdt, "/cpus");
     qemu_fdt_setprop_cell(fdt, "/cpus", "timebase-frequency",
@@ -169,11 +170,11 @@ create_fdt_socket_cpu_internal(void *fdt, char *clust_name, RISCVCPU *cpu_ptr,
     qemu_fdt_setprop_cell(fdt, core_name, "cpu", cpu_phandle);
 }
 
-void create_fdt_socket_cpus(void *fdt, RISCVCPU *socket_harts,
-                            int socket_id, int num_harts_socket,
-                            int socket_hartid_base, uint32_t *phandle,
-                            uint32_t *intc_phandles, bool numa_enabled,
-                            bool is_32_bit)
+void riscv_create_fdt_socket_cpus(void *fdt, RISCVCPU *socket_harts,
+                                  int socket_id, int num_harts_socket,
+                                  int socket_hartid_base, uint32_t *phandle,
+                                  uint32_t *intc_phandles, bool numa_enabled,
+                                  bool is_32_bit)
 {
     g_autofree char *clust_name = NULL;
 
@@ -191,21 +192,21 @@ void create_fdt_socket_cpus(void *fdt, RISCVCPU *socket_harts,
 }
 
 void
-create_fdt_socket_cpu_sifive(void *fdt, char *clust_name,
-                             int cpu_id, int socket_id,
-                             int socket_hartid_base, uint32_t *phandle,
-                             uint32_t *intc_phandles)
+riscv_create_fdt_socket_cpu_sifive(void *fdt, char *clust_name,
+                                   int cpu_id, int socket_id,
+                                   int socket_hartid_base, uint32_t *phandle,
+                                   uint32_t *intc_phandles)
 {
     create_fdt_socket_cpu_internal(fdt, clust_name, NULL, cpu_id,
                                    socket_id, socket_hartid_base,
                                    phandle, intc_phandles, false, false);
 }
 
-void create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
-                     uint32_t plic_phandle, uint32_t int_cells,
-                     uint32_t addr_cells, uint32_t *plic_cells,
-                     uint32_t cells_size, uint32_t ndev_sources,
-                     bool numa_enabled, int socket_id)
+void riscv_create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
+                           uint32_t plic_phandle, uint32_t int_cells,
+                           uint32_t addr_cells, uint32_t *plic_cells,
+                           uint32_t cells_size, uint32_t ndev_sources,
+                           bool numa_enabled, int socket_id)
 {
     g_autofree char *nodename = NULL;
     static const char * const plic_compat[2] = {
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 57a57c96e1..852c48c056 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -108,8 +108,10 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
     g_autofree uint32_t *intc_phandles = g_new0(uint32_t, ms->smp.cpus);
     g_autofree char *clust_name = NULL;
 
-    fdt = ms->fdt = create_board_device_tree("SiFive HiFive Unleashed A00",
-        "sifive,hifive-unleashed-a00", &s->fdt_size);
+    fdt = ms->fdt = riscv_create_board_device_tree(
+        "SiFive HiFive Unleashed A00",
+        "sifive,hifive-unleashed-a00",
+        &s->fdt_size);
 
     hfclk_phandle = phandle++;
     nodename = g_strdup_printf("/hfclk");
@@ -133,10 +135,10 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, nodename, "#clock-cells", 0x0);
     g_free(nodename);
 
-    create_fdt_socket_memory(fdt, memmap[SIFIVE_U_DEV_DRAM].base,
-                             ms->ram_size, 0, false);
+    riscv_create_fdt_socket_memory(fdt, memmap[SIFIVE_U_DEV_DRAM].base,
+                                   ms->ram_size, 0, false);
 
-    fdt_create_cpu_socket_subnode(fdt, CLINT_TIMEBASE_FREQ);
+    riscv_fdt_create_cpu_socket_subnode(fdt, CLINT_TIMEBASE_FREQ);
 
     clust_name = g_strdup_printf("/cpus/cpu-map/cluster%d", 0);
     qemu_fdt_add_subnode(fdt, clust_name);
@@ -157,15 +159,15 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
             riscv_isa_write_fdt(&s->soc.e_cpus.harts[0], fdt, nodename);
         }
 
-        create_fdt_socket_cpu_sifive(fdt, clust_name, cpu, 0, 0,
-                                     &phandle, intc_phandles);
+        riscv_create_fdt_socket_cpu_sifive(fdt, clust_name, cpu, 0, 0,
+                                           &phandle, intc_phandles);
 
         g_free(nodename);
     }
 
-    create_fdt_socket_clint(fdt, memmap[SIFIVE_U_DEV_CLINT].base,
-                            memmap[SIFIVE_U_DEV_CLINT].size, 0,
-                            intc_phandles, ms->smp.cpus, false);
+    riscv_create_fdt_socket_clint(fdt, memmap[SIFIVE_U_DEV_CLINT].base,
+                                  memmap[SIFIVE_U_DEV_CLINT].size, 0,
+                                  intc_phandles, ms->smp.cpus, false);
 
     nodename = g_strdup_printf("/soc/otp@%lx",
         (long)memmap[SIFIVE_U_DEV_OTP].base);
@@ -209,12 +211,12 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
         }
     }
 
-    create_fdt_plic(fdt, memmap[SIFIVE_U_DEV_PLIC].base,
-                    memmap[SIFIVE_U_DEV_PLIC].size,
-                    plic_phandle, SIFIVE_U_PLIC_INT_CELLS,
-                    SIFIVE_U_PLIC_ADDR_CELLS, cells,
-                    cells_length * sizeof(uint32_t),
-                    SIFIVE_U_PLIC_NUM_SOURCES - 1, false, 0);
+    riscv_create_fdt_plic(fdt, memmap[SIFIVE_U_DEV_PLIC].base,
+                          memmap[SIFIVE_U_DEV_PLIC].size,
+                          plic_phandle, SIFIVE_U_PLIC_INT_CELLS,
+                          SIFIVE_U_PLIC_ADDR_CELLS, cells,
+                          cells_length * sizeof(uint32_t),
+                          SIFIVE_U_PLIC_NUM_SOURCES - 1, false, 0);
     g_free(cells);
 
     gpio_phandle = phandle++;
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 630b65f569..8d7e93807c 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -61,8 +61,10 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
     uint32_t phandle = 1;
     bool numa_enabled = riscv_numa_enabled(ms);
 
-    fdt = ms->fdt = create_board_device_tree("ucbbar,spike-bare,qemu",
-        "ucbbar,spike-bare-dev", &fdt_size);
+    fdt = ms->fdt = riscv_create_board_device_tree(
+        "ucbbar,spike-bare,qemu",
+        "ucbbar,spike-bare-dev",
+        &fdt_size);
 
     qemu_fdt_add_subnode(fdt, "/htif");
     qemu_fdt_setprop_string(fdt, "/htif", "compatible", "ucb,htif0");
@@ -71,7 +73,8 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
             0x0, memmap[SPIKE_HTIF].base, 0x0, memmap[SPIKE_HTIF].size);
     }
 
-    fdt_create_cpu_socket_subnode(fdt, RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
+    riscv_fdt_create_cpu_socket_subnode(fdt,
+                                        RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
 
     for (socket = (riscv_socket_count(ms) - 1); socket >= 0; socket--) {
         g_autofree uint32_t *intc_phandles = g_new0(uint32_t,
@@ -80,20 +83,21 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
                          riscv_socket_mem_offset(ms, socket);
         uint64_t memsize =  riscv_socket_mem_size(ms, socket);
 
-        create_fdt_socket_cpus(fdt, (&s->soc[socket])->harts, socket,
-                               s->soc[socket].num_harts,
-                               s->soc[socket].hartid_base,
-                               &phandle, intc_phandles, numa_enabled,
-                               is_32_bit);
+        riscv_create_fdt_socket_cpus(fdt, (&s->soc[socket])->harts, socket,
+                                     s->soc[socket].num_harts,
+                                     s->soc[socket].hartid_base,
+                                     &phandle, intc_phandles, numa_enabled,
+                                     is_32_bit);
 
-        create_fdt_socket_memory(fdt, memaddr, memsize, socket,
-                                 riscv_numa_enabled(ms));
+        riscv_create_fdt_socket_memory(fdt, memaddr, memsize, socket,
+                                       riscv_numa_enabled(ms));
 
         clint_addr = memmap[SPIKE_CLINT].base +
             (memmap[SPIKE_CLINT].size * socket);
-        create_fdt_socket_clint(fdt, clint_addr, memmap[SPIKE_CLINT].size,
-                                socket, intc_phandles,
-                                s->soc[socket].num_harts, numa_enabled);
+        riscv_create_fdt_socket_clint(fdt, clint_addr,
+                                      memmap[SPIKE_CLINT].size, socket,
+                                      intc_phandles, s->soc[socket].num_harts,
+                                      numa_enabled);
     }
 
     riscv_socket_fdt_write_distance_matrix(ms);
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index d808bcc11c..6a2c57bb13 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -87,16 +87,17 @@ static void create_fdt_memory(TTAtlantisState *s)
         size_hi = MACHINE(s)->ram_size - size_lo;
     }
 
-    create_fdt_socket_memory(fdt, s->memmap[TT_ATL_DDR_LO].base, size_lo,
-                             0, false);
+    riscv_create_fdt_socket_memory(fdt, s->memmap[TT_ATL_DDR_LO].base,
+                                   size_lo, 0, false);
     if (size_hi) {
         /*
          * The first part of the HI address is aliased at the LO address
          * so do not include that as usable memory. Is there any way
          * (or good reason) to describe that aliasing 2GB with DT?
          */
-        create_fdt_socket_memory(fdt, s->memmap[TT_ATL_DDR_HI].base + size_lo,
-                                 size_hi, 0, false);
+        riscv_create_fdt_socket_memory(fdt,
+                                       s->memmap[TT_ATL_DDR_HI].base + size_lo,
+                                       size_hi, 0, false);
     }
 }
 
@@ -221,11 +222,11 @@ static void create_fdt_cpu(TTAtlantisState *s, const MemMapEntry *memmap,
     void *fdt = MACHINE(s)->fdt;
     g_autofree uint32_t *intc_phandles = g_new0(uint32_t, ms->smp.cpus);
 
-    fdt_create_cpu_socket_subnode(fdt, TT_ACLINT_TIMEBASE_FREQ);
+    riscv_fdt_create_cpu_socket_subnode(fdt, TT_ACLINT_TIMEBASE_FREQ);
 
-    create_fdt_socket_cpus(fdt, s->soc.harts, 0, s->soc.num_harts,
-                           s->soc.hartid_base, &fdt_phandle, intc_phandles,
-                           false, false);
+    riscv_create_fdt_socket_cpus(fdt, s->soc.harts, 0, s->soc.num_harts,
+                                 s->soc.hartid_base, &fdt_phandle,
+                                 intc_phandles, false, false);
 
     create_fdt_memory(s);
 
@@ -364,8 +365,9 @@ static void create_fdt(TTAtlantisState *s)
 {
     MachineState *ms = MACHINE(s);
 
-    ms->fdt = create_board_device_tree("Tenstorrent Atlantis RISC-V Machine",
-                                       "tenstorrent,atlantis", &s->fdt_size);
+    ms->fdt = riscv_create_board_device_tree(
+        "Tenstorrent Atlantis RISC-V Machine",
+        "tenstorrent,atlantis", &s->fdt_size);
 
     qemu_fdt_add_subnode(ms->fdt, "/chosen");
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d58656f70d..db0f7ecb81 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -360,12 +360,12 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
 
     plic_phandles[socket] = (*phandle)++;
 
-    create_fdt_plic(ms->fdt, plic_addr, s->memmap[VIRT_PLIC].size,
-                    plic_phandles[socket], FDT_PLIC_INT_CELLS,
-                    FDT_PLIC_ADDR_CELLS, plic_cells,
-                    cells_length * sizeof(uint32_t),
-                    VIRT_IRQCHIP_NUM_SOURCES - 1,
-                    numa_enabled, socket);
+    riscv_create_fdt_plic(ms->fdt, plic_addr, s->memmap[VIRT_PLIC].size,
+                          plic_phandles[socket], FDT_PLIC_INT_CELLS,
+                          FDT_PLIC_ADDR_CELLS, plic_cells,
+                          cells_length * sizeof(uint32_t),
+                          VIRT_IRQCHIP_NUM_SOURCES - 1,
+                          numa_enabled, socket);
 
     if (!socket) {
         platform_bus_add_all_fdt_nodes(ms->fdt, plic_name,
@@ -600,7 +600,7 @@ static void create_fdt_sockets(RISCVVirtState *s,
     bool numa_enabled = riscv_numa_enabled(ms);
     bool is_32_bit = riscv_is_32bit(&s->soc[0]);
 
-    fdt_create_cpu_socket_subnode(ms->fdt,
+    riscv_fdt_create_cpu_socket_subnode(ms->fdt,
         kvm_enabled() ? kvm_riscv_get_timebase_frequency(&s->soc->harts[0]) :
                         RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
 
@@ -614,14 +614,14 @@ static void create_fdt_sockets(RISCVVirtState *s,
 
         phandle_pos -= s->soc[socket].num_harts;
 
-        create_fdt_socket_cpus(ms->fdt, (&s->soc[socket])->harts, socket,
-                               s->soc[socket].num_harts,
-                               s->soc[socket].hartid_base,
-                               phandle, &intc_phandles[phandle_pos],
-                               numa_enabled, is_32_bit);
+        riscv_create_fdt_socket_cpus(ms->fdt, (&s->soc[socket])->harts, socket,
+                                     s->soc[socket].num_harts,
+                                     s->soc[socket].hartid_base,
+                                     phandle, &intc_phandles[phandle_pos],
+                                     numa_enabled, is_32_bit);
 
-        create_fdt_socket_memory(ms->fdt, memaddr, memsize,
-                                 socket, riscv_numa_enabled(ms));
+        riscv_create_fdt_socket_memory(ms->fdt, memaddr, memsize,
+                                       socket, riscv_numa_enabled(ms));
 
         if (virt_aclint_allowed() && s->have_aclint) {
             create_fdt_socket_aclint(s, socket,
@@ -630,10 +630,11 @@ static void create_fdt_sockets(RISCVVirtState *s,
             hwaddr clintaddr = s->memmap[VIRT_CLINT].base +
                                s->memmap[VIRT_CLINT].size * socket;
 
-            create_fdt_socket_clint(ms->fdt, clintaddr,
-                                    s->memmap[VIRT_CLINT].size,
-                                    socket, &intc_phandles[phandle_pos],
-                                    s->soc[socket].num_harts, numa_enabled);
+            riscv_create_fdt_socket_clint(ms->fdt, clintaddr,
+                                          s->memmap[VIRT_CLINT].size,
+                                          socket, &intc_phandles[phandle_pos],
+                                          s->soc[socket].num_harts,
+                                          numa_enabled);
         }
     }
 
@@ -1020,8 +1021,9 @@ static void create_fdt(RISCVVirtState *s)
     uint8_t rng_seed[32];
     g_autofree char *name = NULL;
 
-    ms->fdt = create_board_device_tree("riscv-virtio,qemu", "riscv-virtio",
-                                       &s->fdt_size);
+    ms->fdt = riscv_create_board_device_tree("riscv-virtio,qemu",
+                                             "riscv-virtio",
+                                             &s->fdt_size);
 
     /*
      * The "/soc/pci@..." node is needed for PCIE hotplugs
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index 1729a6abc6..371971d79d 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -11,29 +11,31 @@
 
 #include "target/riscv/cpu.h"
 
-void *create_board_device_tree(const char *model, const char *compatible,
-                               int *fdt_size);
-void create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
-                              int socket_id, bool numa_enabled);
-void create_fdt_clint(void *fdt, hwaddr addr, uint64_t size,
-                      uint32_t *intc_phandles, int num_harts);
-void create_fdt_socket_clint(void *fdt, hwaddr addr, uint64_t size,
-                             int socket_id, uint32_t *intc_phandles,
-                             int num_harts, bool numa_enabled);
-void fdt_create_cpu_socket_subnode(void *fdt, uint64_t timebase_frequency);
-void create_fdt_socket_cpus(void *fdt, RISCVCPU *socket_harts,
-                            int socket_id, int num_harts_socket,
-                            int socket_hartid_base, uint32_t *phandle,
-                            uint32_t *intc_phandles, bool numa_enabled,
-                            bool is_32_bit);
-void create_fdt_socket_cpu_sifive(void *fdt, char *clust_name,
-                                  int cpu_id, int socket_id,
+void *riscv_create_board_device_tree(const char *model, const char *compatible,
+                                     int *fdt_size);
+void riscv_create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
+                                    int socket_id, bool numa_enabled);
+void riscv_create_fdt_clint(void *fdt, hwaddr addr, uint64_t size,
+                            uint32_t *intc_phandles, int num_harts);
+void riscv_create_fdt_socket_clint(void *fdt, hwaddr addr, uint64_t size,
+                                   int socket_id, uint32_t *intc_phandles,
+                                   int num_harts, bool numa_enabled);
+void riscv_fdt_create_cpu_socket_subnode(void *fdt,
+                                         uint64_t timebase_frequency);
+void riscv_create_fdt_socket_cpus(void *fdt, RISCVCPU *socket_harts,
+                                  int socket_id, int num_harts_socket,
                                   int socket_hartid_base, uint32_t *phandle,
-                                  uint32_t *intc_phandles);
-void create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
-                     uint32_t plic_phandle, uint32_t int_cells,
-                     uint32_t addr_cells, uint32_t *plic_cells,
-                     uint32_t cells_size, uint32_t ndev_sources,
-                     bool numa_enabled, int socket);
+                                  uint32_t *intc_phandles, bool numa_enabled,
+                                  bool is_32_bit);
+void riscv_create_fdt_socket_cpu_sifive(void *fdt, char *clust_name,
+                                        int cpu_id, int socket_id,
+                                        int socket_hartid_base,
+                                        uint32_t *phandle,
+                                        uint32_t *intc_phandles);
+void riscv_create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
+                           uint32_t plic_phandle, uint32_t int_cells,
+                           uint32_t addr_cells, uint32_t *plic_cells,
+                           uint32_t cells_size, uint32_t ndev_sources,
+                           bool numa_enabled, int socket);
 void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
 #endif
-- 
2.43.0


