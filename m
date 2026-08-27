Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB8DC61DCD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziYM-0005EH-St; Thu, 27 Aug 2026 18:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wziYG-0005C1-GW
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:26:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wziYD-0001A8-S4
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:26:28 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJMTqf655550
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2ZN5PLDobhRL1Z2v985oziLe2ccwD7fJVrv2UJhuWB0=; b=TiSX9GvWz2q5V9ZL
 6Bsw+d2vuAhzy0JDHAtxB7MBnYl1pbWseIMNw9NMedtL4hLxZ5MpUXGlgg4IeE5F
 71lZqlNi20V7mYlynzDMKvimIVLTPC/nfhJTZj4l6+O5tWk8NQzxmMyjx+WAXySg
 gHs/aBbZEyTlDGMt4mjUqd0Md1ymz1cdtveQ7nesBt1t6r0DZd6mlJ36xdJJ1bln
 FsaKK01el+QwWge9v0Rqvr1w+DtNDOCpv2wdw9UI8fc5H4DBDC3I/so+E3L3BG9P
 tfRf4+rSb8/+W0blSr19PfRJmle9EFQ9JkJom2FX60B0DxUrFtn677n/QpvwzVzD
 5jZ5Tw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gagjfum4d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:26:24 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-930edb4362dso14457385a.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869584; x=1788474384; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2ZN5PLDobhRL1Z2v985oziLe2ccwD7fJVrv2UJhuWB0=;
 b=GwYbKESX+0Ja444KGrorvSqUMSpd90eNHsCP6wxYueTd9JF0Z8wXmvHe9lcdVZmeUV
 PHUMfLCTFn4ZYpikA2qmiN1XeUwfNvL7TFJJlm1HQa+42elAP3l0t5lwirHgijkIvsTK
 acKOmnOqPzVgDkJ3gzb+vICeNF15eloSNPlHb0/s/dUBdQTNWZmVyrjQlb+2c+O06qc3
 j1Otjn6IaYElkqQrxLUxnLumujcWCir6kkyEepx/Kspli0irPtV3KSlRLK9IT6JUlay/
 0Y32jmFqqvdyoRz2Lxl1ZxLqWy7EL2iHQrMuDmpRBlHP6U0jB2w5tuMTmdySUNrcX9KR
 +VdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869584; x=1788474384;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2ZN5PLDobhRL1Z2v985oziLe2ccwD7fJVrv2UJhuWB0=;
 b=dyA46pwg2guU1/CXlZJd96auYr/Go3lUpvyMiN0QUIdz38Ln9u1EQBWWnafAjjSH+Z
 jtRfrDszXHrNGKtmyJuiqvZi2Wr0NPGE7CPR+DVRa6yDAYeFddCAVy/CX+Wu3tQnhjrZ
 nr8gqV+lLYJXxpnZCZf1+jAleZmssj6IW8aXih3atrS071WP4rSgZYP+97VFnnb8Z6Ql
 xHeSzWF8N8b8GQu111Cmt4wn5/2+efIF3Stm7HTM8o0UAwZyBLw8H+V1O5C1hIZCfOD4
 Z5JUgDUyw5sys6gWaI5MkkBAUIoJlr98R624ZDyix5jFfmTl8iQbgSIDQvMZ/dmypwi/
 x51Q==
X-Gm-Message-State: AFuF++mEczOgk0iFilQgV+3j9u9sCvgJdSlnrwofsVLEHhdxjB6L40Mf
 MUn8tLMcE5WLqzhTyjwZZNnNbK5IH1koq0iQsgLA6MSP2uemn6PkFKgMQrglTQcckIr7d9P2HXj
 0GUgSMsARFbWL6Tfb6wih6Laoj0Tvtkoen+wg+ZpRBPjRbbA6kvd5wAXQwccD+9gz2Q==
X-Gm-Gg: AR+sD130ISsG30LHw3a7VJCyHdax1RbOGTkvgo8mwdtyKoHpyxCU15Hu8Gk9U1o+e54
 q6VBWG4ePGi7z17t7uFGzo0zVNjHg+r9DwGwMTbAgjkXIZxyRiiI7nXCJxevINsptezphgSrfBu
 LTmG0QBTHh09pfUG2TNV/4d9oiV679xDA80QhXvi6n1gNV4kq9KH9CwXRTbQV1W5LUwJ6kxjzrg
 Ei1TkZPga3OUnjp5yVj28WFO7X/DOnBGum/J+3EpvG9LCrJ2pvboxGBxQ7/osQcomuatKatMAzC
 v/5Mub4KwtUrKF9+YE7iq6Lwpg6ks17D1KO/d+CnEBtIucKn7cnycBAb3oXQNU5PAOZtHxqt7i6
 Td/nKV2vhjpkuFdAyUXsRdTlIjQLaHRQTBdlXYw==
X-Received: by 2002:a05:620a:44c5:b0:939:990:c943 with SMTP id
 af79cd13be357-939138df236mr216652785a.32.1787869583943; 
 Thu, 27 Aug 2026 15:26:23 -0700 (PDT)
X-Received: by 2002:a05:620a:44c5:b0:939:990:c943 with SMTP id
 af79cd13be357-939138df236mr216646685a.32.1787869583318; 
 Thu, 27 Aug 2026 15:26:23 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939173a734dsm8924985a.26.2026.08.27.15.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:26:22 -0700 (PDT)
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
Subject: [PATCH v4 01/14] hw/riscv/fdt-common: prepend helpers with "riscv_"
Date: Thu, 27 Aug 2026 19:25:54 -0300
Message-ID: <20260827222608.329788-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827222608.329788-1-daniel.barboza@oss.qualcomm.com>
References: <20260827222608.329788-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: YA9WwFKTrXKjpx-zvh5rYinPENk-rt8B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX1juseXMJjaEm
 FVFCJbCeAjhZq4VaYr/37lZB4Ls/dtHGTudeLhfAsFWdYFxMVb5rZkDdfK68QdCqRKb5RDvTR64
 AnUrSZr9Ded267Ljy4SQYAG49OQf52YnfJ3SWmRDIICisMbwUMPMNAIA+3ka7UP3p/eDbR6pCXc
 6FrYcD7c5SSVAk3ckyNXnybHlySGw0qz5VD4Rw4OhaXahMNUE3g8JWQLqOf63tISIOQNJhbcfmo
 UcbsnpPtgxKaMZg13NRkUPtHQs2LQ5w9fFTqlIHOFVAPa3zHJGXSe4gI9MXfrr26MI7mxduMSRa
 BKwpdRtH+yAdGIVCoNYPoATMPd9f4Lz8mndJPx2aFBjNEvxIaVE2fLuSDOH+tqzki2BDNe7XhmQ
 RtG8IL+QJYc9LcCpGoDMfVVijws7NtVGBQVU9jFsE4cwyLvUKQD1JRGNzVBoinZb/M9kBdsi/hD
 7N3LSUQMIDjxspD4NbA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX7UOKgiCxKCXV
 kbDe8hTQlFpzhN9H7evxP4lBaNjkfRs9kZ6sQlspIIJUgCB3LKc3lrWMhwgyVvexksEkUM3NiGJ
 CszSvVYiJXvMX0HY0fWz2DNEsPDNE4Q=
X-Proofpoint-GUID: YA9WwFKTrXKjpx-zvh5rYinPENk-rt8B
X-Authority-Analysis: v=2.4 cv=dd+wG3Xe c=1 sm=1 tr=0 ts=6a90b990 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=SG9m4Rbq3iqSK_q1YnQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
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


