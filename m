Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1E1C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03MP-0007Gd-90; Fri, 28 Aug 2026 16:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x03MN-0007GE-TC
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:39:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x03ML-0006So-Cq
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:39:35 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SJdaZE126055
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 20:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BG/y1yi1zgt9M3JfRivxMRnuoqUFnxcVdIv6nfOMOLk=; b=ORqAYbPXBp3G7PaA
 QIbCncCmgpmR4OvDBzIDPP27GAj6sPzt7+3g90u5aAzjHOLbTMvBaaEhVwOQUeMi
 C0bj6q0FceYGUKZjle/ES7qXM37VVf3PnFdRHOA1ShYWeV4zvPVMSjbq2z2Sfej8
 TqNt+syEH+KNF2kNbhKKZ/AyekR7fTwd/WzuUr6oNcrjNCjjCReX/Nwcp22rNOCj
 4cRXFzcWv3DP7UHxWYzN3c1ZRBi7fhHXbtsgjeUC1symMuMmrCAaJR/X454t3J0h
 1+d081iKFfgKFS0BDSKaBm7Jx9HKgC+irS3uSCzPQmDQcJHpc9st/EJjuYFiJhxt
 JlWCeQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbgpc0591-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 20:39:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e5e38fbc5so140139485a.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 13:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787949572; x=1788554372; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BG/y1yi1zgt9M3JfRivxMRnuoqUFnxcVdIv6nfOMOLk=;
 b=Nvm8zVyo22T4TjFYiqUqxaWEBFvKYy5Q3WH5iHgb+sVBnfqRfni9YKU4bG299aCGVH
 eMliH5+GDRI0l47di9f3ZWupZzFVI0j6Obo8Rz/pAeqYuUZaP8dvRfy3ImDF/YhOvZLg
 QeYzKLBMK7FDMIzV2jcryWGknOX728FOZ7VzUm2CRJZhgBOT+1RqiGg3eRBP9WDnxRRR
 BjdoiD2/fQ/WbGhA3XMa1asBJjQ9s9lfxCBCE8C0M1VBe34pwQOsYvshv/5+pSSHcHm/
 J08zoUz7nifn2/IXLBLosD7Y3wQKVjW9GmbhxweIylI4USrO2XyhtsWl8FPmflx0H1KB
 KdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787949572; x=1788554372;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BG/y1yi1zgt9M3JfRivxMRnuoqUFnxcVdIv6nfOMOLk=;
 b=leRQdbdiI/bzy4iaX9h1NZaBvPVBU+/HsNg6bMVHrhW074PYHOZiEdui0RF8MvcC1z
 isQSOZnWoLvn0h0710tlbtD4nymVNZtkZuRSjNj4kljjRAxjidsYzcVsL9w5yPHaIbYe
 aDCHWItrWz0EOCNGaVM/LF8jcOXfOlrqsCxUBVjFknnBga5ViVkoBoJ6DW5LVEtrVISS
 /eKCYfzdWwXz52xpxFU4FvH2EeLkqYGlB9Olw5qp2hjNNX+yhN0cNFHVvSbKyvD9VUcv
 qbHZnR5ioMwz1ODrYjj0o1Pz1cI6iII3vV4uHNUvPFHKwcQvGYIzB5fHVQpg8UuOa/6l
 ld1w==
X-Gm-Message-State: AFuF++mxmwgA1IorW39pQdMo2uT8ZtHJPzVOAhRZYdK2XxkgbGTK06VC
 PHTB/A/iwY8rSEm9zuudDv6fubxeIlCrYVeOHwFjGVOA7GfnfADfBjHXoDtcfu2tVfm9Hejdd6u
 /KNhg2U6HPG7AYjEbnhR+uuiwNxfZZmZHK39tbefEJgfZHVaigibrfDaHbLGhH682CQ==
X-Gm-Gg: AR+sD11xPWg+GXEFP+F4VdKvkKDSnwhYPJ7E+8OAD0yS2st2lgcozG3Jxy64gQD5wEv
 FbNtrSRDTqO97LyCWGFRYJszQi9E5BWmZyKNi8lU53VJaPDosrj3ScpJxyAZDQ3JFPw1FSIddDx
 fCGzbK5y2WhDHtPFy5m8sOcMhDDyrHGCsS73FvvTxAtlErLkA1I+E/zl1KVctKTSVTxThvjOKFq
 5YjDQQSN1CVq6b1IoaL2IEhjO/F21eDZdEB1qSQc5vfn5wQqaf0SffZbrbcp30r6xQeAsfogFup
 4bhvWPLPM+mfsWBPn8sWK/ZxprDPKgig4UoyEvycSUbOHbSFeV+d6GAxUUi5ukn8kNxAGCBeqBN
 Ap3hZOspj18h205XILCjED8a2TFtCxP0A/Pc3ww==
X-Received: by 2002:a05:620a:b5b:b0:92e:6c15:24cd with SMTP id
 af79cd13be357-939137e0ef0mr916623185a.15.1787949571554; 
 Fri, 28 Aug 2026 13:39:31 -0700 (PDT)
X-Received: by 2002:a05:620a:b5b:b0:92e:6c15:24cd with SMTP id
 af79cd13be357-939137e0ef0mr916617985a.15.1787949570960; 
 Fri, 28 Aug 2026 13:39:30 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939173f2758sm218063985a.37.2026.08.28.13.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 13:39:30 -0700 (PDT)
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
Subject: [PATCH v5 01/15] hw/riscv/fdt-common: prepend helpers with "riscv_"
Date: Fri, 28 Aug 2026 17:39:03 -0300
Message-ID: <20260828203918.350131-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HTyQq3P5BJc4KVQPXdisnsKEHQXcecpK
X-Proofpoint-GUID: HTyQq3P5BJc4KVQPXdisnsKEHQXcecpK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDE3OSBTYWx0ZWRfX2e3DQ7WZlYsi
 Wq8U/Z56wQ26F2lmWS90+hQ4ugxTY8+2vjitDUQ768hddVZdkSwnuhqDqopMi7J+KfvCmr/ODkF
 hOTi5ntA6t4+lJzmdMqdAFO6WEa7Cg0=
X-Authority-Analysis: v=2.4 cv=dtfrzVg4 c=1 sm=1 tr=0 ts=6a91f204 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=FRSEYCzRAAAA:8 a=SG9m4Rbq3iqSK_q1YnQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDE3OSBTYWx0ZWRfX9eUIwlU5xhlZ
 BgOY05cxoNGEfMJ/P0RDmW1Xw0EHeClsXwJAExTColo4R+wV9xjcdffWwFmYRcXNgmEqdm54gCL
 UcweiKqMUIhhncuRtAL5UoxnmD+K5oINPp0s9WiPTsV4qMLC8aK1HaxAJXgAP9ZGFwJmVr1deaT
 p+EPNVbyRutxOju/2kmg/i9W+WYgbr5bBdOkrhTrgNXuu25emdIOPajib4sS7rToY8EZ88jvPOC
 jHTbnYg8nLz+fHb6SfFVok4WLmDHhPHT8RPF8q3lhb5oRTB8mcfKE3pZw4cIc+qQ7qLnfjG3CN6
 Nd7LrkhShE++XuOChovDYRuWa5SB69fdzjZap6qVLWI5HxwyLsKHtA6iPFxYtPh97WUe9URJKEz
 trg9uU08s7rbwIDDWVdoDhsWdesuSRI9yuEx/Znk4D3dXg9VlK7DYw87Cmj9KSywo0EAdw3RI04
 4T04xWTCWFJ5ZbG+4jA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_06,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280179
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
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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
index babce2b680..812051a11f 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -91,16 +91,17 @@ static void create_fdt_memory(TTAtlantisState *s)
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
 
@@ -225,11 +226,11 @@ static void create_fdt_cpu(TTAtlantisState *s, const MemMapEntry *memmap,
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
 
@@ -367,8 +368,9 @@ static void create_fdt(TTAtlantisState *s)
 {
     MachineState *ms = MACHINE(s);
 
-    ms->fdt = create_board_device_tree("Tenstorrent Atlantis RISC-V Machine",
-                                       "tenstorrent,atlantis", &s->fdt_size);
+    ms->fdt = riscv_create_board_device_tree(
+        "Tenstorrent Atlantis RISC-V Machine",
+        "tenstorrent,atlantis", &s->fdt_size);
 
     qemu_fdt_add_subnode(ms->fdt, "/chosen");
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 329ccdb5a7..b796220fc2 100644
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
@@ -601,7 +601,7 @@ static void create_fdt_sockets(RISCVVirtState *s,
     bool numa_enabled = riscv_numa_enabled(ms);
     bool is_32_bit = riscv_is_32bit(&s->soc[0]);
 
-    fdt_create_cpu_socket_subnode(ms->fdt,
+    riscv_fdt_create_cpu_socket_subnode(ms->fdt,
         kvm_enabled() ? kvm_riscv_get_timebase_frequency(&s->soc->harts[0]) :
                         RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
 
@@ -615,14 +615,14 @@ static void create_fdt_sockets(RISCVVirtState *s,
 
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
@@ -631,10 +631,11 @@ static void create_fdt_sockets(RISCVVirtState *s,
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
 
@@ -1021,8 +1022,9 @@ static void create_fdt(RISCVVirtState *s)
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


