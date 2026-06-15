Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CC3CD98E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE4F-0002nd-9U; Mon, 15 Jun 2026 16:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZE4D-0002nG-Vt
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:37:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZE4C-0002AW-BZ
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:37:57 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FJ1OES1220552
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=8cQ4K6easLD
 l+OCBep4+ArBp6QbXZq6Ve0vs+5+bdD0=; b=k7AQWJT0i1yyRVbsO3uidWTAI1X
 dKKYxyj0x6cxy4GcZ9bexObWsmucp1LttexxOmrtGOyzQnLDDshHkyFfAxJRNXz6
 IAMo7zkC2sX5MiWVcoIP1j034nm4tcPN1TkNUPB9rt/faRHr7Tct243hgUUAfybB
 /lYXA8Q9b8fNrgmmETHV8ohHEInJD0Ii8RUTm6ux0OTHuYZwIsgmL/exLkr9fMhq
 9WbUG3RINxq5t5EW8EP9IBRbWYzvTqbuOvDgXlOUT7H4xfUYe6Guf+R+fhpNBWpC
 4IUIFf2dcZXlY7cjc6LmD/vb2TvklmQbE3PstUTqbjh9PQ/dOFpFAlZGEWQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etevx2vbj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:37:54 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5177f07ea82so77610291cf.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 13:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781555874; x=1782160674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8cQ4K6easLDl+OCBep4+ArBp6QbXZq6Ve0vs+5+bdD0=;
 b=Ewiq1ROM69geQxWRpMDfCEXUKZi91HraljrcFhkjVxpxgkgJOZjMcqXVRZ2pZQSgTt
 g/pmG1FqTTEsIGgNkMv0/hVNZ/ZIaYczAZw2ky9aGIU+VIl2KsLjNBte+ss69Xs1TN4n
 2wzZFioNrOIcdqJMf5axjGamvFkU0m9wnEE6NhfsPyrtG+xcIiPZWmxS34qLWCBgd/f9
 rVsPiHDSav8q//5nuAcKro147GXUczBxPMr3qLE1MTEdopMsBNGPjko6A4z+v0xQQ89X
 YOyCnQHB2d7+9v/OHzDZkPVP60tG7A9BTCFXk0udf7+3J5inlG18IUxrpuS6kjfUpMCV
 Q7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781555874; x=1782160674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8cQ4K6easLDl+OCBep4+ArBp6QbXZq6Ve0vs+5+bdD0=;
 b=OOxV7H+yeWrGnIdtNKjOgqDg6lBTFlxBfGGUCiLK0LlKW7H56Z1KItrZ7FxbNd6+rY
 zDbQjOYW9LzRT1FJTCaShjc2qoZNUHVqOq7KpBfk3zfUr6vD2m2a6C4v57y/FcsrRQ0I
 dI9ojuuJi6Hjb7eEOV7giYqPoboTOhr6TjX8ELvBIB/niToBLsxSXboyRLEwmS4ZKqsR
 PFq47DZDp+WMrs47UCeVdw1jJCMwrqneyJmVSdNjgSpI7eRs7IiRy3MNcTyepjuiPzLN
 9o6x1719eTUvgR46F43N4DteLum8vDkN+PKNdbYRrRrEW3k9imU/WipfFm0uZaNB9w3M
 0Zvg==
X-Gm-Message-State: AOJu0YzGG06n+HkesOpVdHk/STCY2il8F2s4tJ+vUtW8LT+IBJ4A8gZU
 L5ZiyDYaDtKhRhJ2nW+LBfdMuFfZUoW5DkFwgiZ4lbREvhotQbSAFIAHNv2Ed9+wUxauMHPdj5i
 0vmwAED49yxdOTAfJxhbWa9jkCFkbWIYRQp9YYfwK8x6Ky4DjpM92ybvNHeRKxFH8gQ==
X-Gm-Gg: Acq92OFgQBUuYA87KSIBk5oj74rA5qPR7HzykEPlZRahc47PluuNwYSbNuYAaABjSml
 y4rRHVnOI5I4QgLfxqR1npRk4+RGilxQoxlBvBkjyEEy1wkRs/g/v3ZeBI1SqfvHKt7KLp41uBb
 JFig+hixmqRBWPUmAGYKfw/9Gk5NyXJ6mnlF0PdMbMoeSnGfLi16PVJhIbc0jiF9/NERkRsflnh
 5glqsLsrq2HI4nMy8HONOUkUNSuyUrkI/X7wAcWzJjY/ytZ0T0Qbob7CAR7rd2hh8xDYwHnWZnb
 f3mXOiUOSg2/2fEfvwb/3TQh/FQAZ70XWXY08Ih+TujilI4ZdBvrwogQ7/Mmfzn+fWSmy95Jlw9
 x0GtGB0meQOVoVvq3wqAllfLDOBYuHyiCZngXDhMigPb7xa98wdgk9Q9eWmM=
X-Received: by 2002:ac8:6f15:0:b0:517:9095:c329 with SMTP id
 d75a77b69052e-517fe52e9ccmr246870211cf.45.1781555874002; 
 Mon, 15 Jun 2026 13:37:54 -0700 (PDT)
X-Received: by 2002:ac8:6f15:0:b0:517:9095:c329 with SMTP id
 d75a77b69052e-517fe52e9ccmr246869601cf.45.1781555873417; 
 Mon, 15 Jun 2026 13:37:53 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d9f4740fbasm9749906d6.29.2026.06.15.13.37.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 13:37:52 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 06/13] hw/riscv/spike.c: add intc_phandles array
Date: Mon, 15 Jun 2026 17:37:26 -0300
Message-ID: <20260615203734.954428-7-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
References: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 22ZyjEd2g8w_CO6Mg0Lt7vmnLeufekNb
X-Proofpoint-GUID: 22ZyjEd2g8w_CO6Mg0Lt7vmnLeufekNb
X-Authority-Analysis: v=2.4 cv=f8t4wuyM c=1 sm=1 tr=0 ts=6a3062a2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=VOZx6rqXNF7FRthzuzwA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIxOCBTYWx0ZWRfX9xKMyqHF/LB4
 C4flkvsHvEO0Vwuvdz4OsXzqc+F3Q/oGAqIMW6TBVG6GNI7Iyby+24Ek2eOrIPrFuSSsMw/2Axo
 VDNLJfwR0BfHOaps6dBbJG+Mh0iVQyw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIxOCBTYWx0ZWRfX1LnVeOCilLIM
 ZrYBIBrkMD5LQVG79+iJbgofuxQKFhvJ9loOn2KTnRdrKXrnUlPHzjPF11e7Lf6uS5p0dX1DXMY
 zjwZDH2H63H4eM39jqBu3XnJMmQy+3UtAxmeh+OCVkdXChEVhrv/PCajEdVBvG9VFWguB9agbbs
 Bxp04ZVnPmOCN9V+DheJxbZ78M/29C/auYcuPeqoaKzYYJ8rMDcy3gSqqSe33ErsAEY7zyWgvtL
 bxw6qtZEO+6uBqTri+Q0ip0HRUvkp+GYTpGZ9P/Ggb/mZuedEf1wYoppWwLB9bt93a786B1JP7F
 YMJ/mjxWZixYHxOc29Ryl/VSwAr/0Ty0NPZQpu55X9Xm78QsC+dLi4780DFOzoR0vY73L9dCzkS
 mCGfylnWb5JrIeGQRv8uZXsZf/6DHP2My+Rt6d2t/O0XmiLCkC3Y4xUqGgAVvZTzCXMv8tj1iti
 WvVNjg95cTiJfCE0OJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150218
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

The clint FDT generation uses a cells array (clint_cells) that are
populated in the middle of the loop that creates the CPU socket FDT.
This is completely fine but it differs from the other boards that
creates the clint cells array right before creating the clint FDT.
'virt' and 'sifive_u' store the intc phandles in a intc_phandles array
during FDT CPU socket creation, and this array is used to create the
clint FDT cells.

Standardize the clint FDT creation for spike doing the same here,
allowing us to move everything to a common helper later.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/spike.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 92facba29d..82005ec163 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -59,7 +59,7 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
     int cpu, socket;
     MachineState *ms = MACHINE(s);
     uint32_t *clint_cells;
-    uint32_t cpu_phandle, intc_phandle, phandle = 1;
+    uint32_t cpu_phandle, phandle = 1;
     char *clint_name, *clust_name;
     char *core_name, *cpu_name, *intc_name;
     static const char * const clint_compat[2] = {
@@ -84,6 +84,8 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
     qemu_fdt_add_subnode(fdt, "/cpus/cpu-map");
 
     for (socket = (riscv_socket_count(ms) - 1); socket >= 0; socket--) {
+        g_autofree uint32_t *intc_phandles = g_new0(uint32_t,
+                                                    s->soc[socket].num_harts);
         hwaddr memaddr = memmap[SPIKE_DRAM].base +
                          riscv_socket_mem_offset(ms, socket);
         uint64_t memsize =  riscv_socket_mem_size(ms, socket);
@@ -91,8 +93,6 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
         clust_name = g_strdup_printf("/cpus/cpu-map/cluster%d", socket);
         qemu_fdt_add_subnode(fdt, clust_name);
 
-        clint_cells =  g_new0(uint32_t, s->soc[socket].num_harts * 4);
-
         for (cpu = s->soc[socket].num_harts - 1; cpu >= 0; cpu--) {
             cpu_phandle = phandle++;
 
@@ -113,20 +113,17 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
             riscv_socket_fdt_write_id(ms, cpu_name, socket);
             qemu_fdt_setprop_cell(fdt, cpu_name, "phandle", cpu_phandle);
 
+            intc_phandles[cpu] = phandle++;
+
             intc_name = g_strdup_printf("%s/interrupt-controller", cpu_name);
             qemu_fdt_add_subnode(fdt, intc_name);
-            intc_phandle = phandle++;
-            qemu_fdt_setprop_cell(fdt, intc_name, "phandle", intc_phandle);
+            qemu_fdt_setprop_cell(fdt, intc_name, "phandle",
+                                  intc_phandles[cpu]);
             qemu_fdt_setprop_string(fdt, intc_name, "compatible",
                 "riscv,cpu-intc");
             qemu_fdt_setprop(fdt, intc_name, "interrupt-controller", NULL, 0);
             qemu_fdt_setprop_cell(fdt, intc_name, "#interrupt-cells", 1);
 
-            clint_cells[cpu * 4 + 0] = cpu_to_be32(intc_phandle);
-            clint_cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_SOFT);
-            clint_cells[cpu * 4 + 2] = cpu_to_be32(intc_phandle);
-            clint_cells[cpu * 4 + 3] = cpu_to_be32(IRQ_M_TIMER);
-
             core_name = g_strdup_printf("%s/core%d", clust_name, cpu);
             qemu_fdt_add_subnode(fdt, core_name);
             qemu_fdt_setprop_cell(fdt, core_name, "cpu", cpu_phandle);
@@ -139,6 +136,15 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
         create_fdt_socket_memory(fdt, memaddr, memsize, socket,
                                  riscv_numa_enabled(ms));
 
+        clint_cells =  g_new0(uint32_t, s->soc[socket].num_harts * 4);
+
+        for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
+            clint_cells[cpu * 4 + 0] = cpu_to_be32(intc_phandles[cpu]);
+            clint_cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_SOFT);
+            clint_cells[cpu * 4 + 2] = cpu_to_be32(intc_phandles[cpu]);
+            clint_cells[cpu * 4 + 3] = cpu_to_be32(IRQ_M_TIMER);
+        }
+
         clint_addr = memmap[SPIKE_CLINT].base +
             (memmap[SPIKE_CLINT].size * socket);
         clint_name = g_strdup_printf("/soc/clint@%lx", clint_addr);
-- 
2.43.0


