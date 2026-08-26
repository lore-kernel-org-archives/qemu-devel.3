Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC98C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzGnf-000643-9D; Wed, 26 Aug 2026 12:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzGnd-00062m-Au
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:48:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzGnb-0000rS-DT
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:48:29 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QDuhce593205
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 16:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=AkchrvUe/LA
 mpQrPITt1acnChXhuDja4ZA5vZ5r9Sjg=; b=Oi/Od7e7A11/40eAMeTdafUpdl8
 GcMGotGjCCeSsMBHl1lwakK/5PzZnW9jV/7S7vRuKALuAeCsQr5ls0kN3VosDaW5
 RptA5Gf5DRlNp1e0EK4QXU030AUQXTJ8oh8wqIqDUmTQsvD1obG1jWj3m7oP3Sos
 KEtZGp7sQghvdjvR8yAXXddAYdryvl0NpDCBybclB7XJenmNHHimHezqeSzoF+eW
 6UNUvyBHRkcP/5iMue7BkapNUDXvtTKplC29mQxZWfi9+V0d3MdljM0cRjfGQpEc
 OXBckduoJ9ycj99CF+hZs3frFlcuTuWN6XK0S7Rr9CTh09gGQ3ZkvHuOzYg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9s9gauk8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 16:48:26 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52ee59064d2so1239631cf.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 09:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787762906; x=1788367706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AkchrvUe/LAmpQrPITt1acnChXhuDja4ZA5vZ5r9Sjg=;
 b=QR5VuWuUP3VUXYwRA5ZWdGS/D8dMytG17RlI5fv67SxwXUSJTmWEz6lPQb/LibCAo2
 aYWN3U4Runw0XGCAlt7AetX3aLobuOurdVVyThJNF1fez0CKT3dxxk4uWBQycU8BiV2e
 Y47LFlTh/1CyTEKtLjzYhKZjV/uBQH1fKpMvzTspOUanLM4XQigrB113m8ujId2tEM/U
 twTRoWa2G9+jpXHdBWhW9ost6wQ7cogPBrZWRxcmJrG5/31tc23T67MDvQoGEXPKPIYK
 umf0BJ5dBIGh5wqyBUdwWJm6z/ALsotEIk9SIvsttSgsw5+QMuj6mykIdp/IPnxFeYXj
 Ba+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762906; x=1788367706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AkchrvUe/LAmpQrPITt1acnChXhuDja4ZA5vZ5r9Sjg=;
 b=G5yh9nh2KuWtHDwF5V8sga65KtqW4ZmLMziEYVS/kMQ4J+J/rw29uFhexlKz2w2C/C
 tEI8iTVdhW+XfbrCJY3cH92ymmIozxFU95BwUY9FLSRSmrF/NB8A3wkNhzsjlNYp+Kdx
 S3rfyjrnTEF4uFmfjLzPLyWdoM62fvzNfj0UhQ5/42GyP3SBjwgLNp1Qcgk1cZFXuRzT
 hX+lYvpk2/r8woD5p7fUk50HAffch1qEOowAy1XsRzSZI6mR0G+QRm4gMAuW3Oh3bj5q
 8ZddLtQg25WWlu95HZ+igQR3DKxOT5X2SplCdGXJ9p+DwZAIx9pym2uwlt7cXt+XeCCs
 4EEA==
X-Gm-Message-State: AFuF++nVGvzvwF1GWFNSjgA8PhLvEI4FmerxOltQjkZOfWwRbcMoRzWK
 wBU7qwQ00TFVcvDJIT42irWaZBIiJa/MZfoP/+ybNST8UhWAVCm1jkjAWxXuyJVxi1bQsPbNR9t
 Z73yGo2l6D5OuWacvmuLZIExL0JWMr+ulXc6TaMhi7rKEKWDS3zvt0uWtruESyrBazQ==
X-Gm-Gg: AR+sD13yzwxsv1yj6FdKcauTxiKpGSy0cq+icsFUcgKK7fjoodI/msRPuFty/KVYblz
 apg1oWJNpDYj6jbR0QmwFb5DfaZksMbO6JKLKYpJbaw/7+WFXl7RKPpbRNaKYbVkHRtzx0idEjN
 rtsJqDHX0+29iUqJM1y0z/7bYDV1mCNmcmcTITf8yz0gdRr2jJY8yzGsj47Oalk2LCk6m0Eq3U4
 l51Q0pz42tDdY2CUNPMlkBDsZKNHxEYbY2Ssh3/yMP9iGWRhe9Vg1vUKl+IA/T/dUhim/V93tu+
 XGCdbYDF2el6UtZKmHrO32NI8g0SEui5U7+xsa7wZTa5sIWn+fwv+fe4MK50jxBg8t7m/Kkey2Q
 aQkEiRUzFABOeYS3yAerk/xjyhiqO4rRX5O+Zsg==
X-Received: by 2002:a05:622a:5b92:b0:527:69ad:fceb with SMTP id
 d75a77b69052e-52fa186f8a6mr9090401cf.0.1787762905402; 
 Wed, 26 Aug 2026 09:48:25 -0700 (PDT)
X-Received: by 2002:a05:622a:5b92:b0:527:69ad:fceb with SMTP id
 d75a77b69052e-52fa186f8a6mr9089721cf.0.1787762904925; 
 Wed, 26 Aug 2026 09:48:24 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52e4275fc3esm20092651cf.25.2026.08.26.09.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:48:24 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH v2 02/13] hw/riscv/fdt-common, virt.c: add create_fdt_syscon()
Date: Wed, 26 Aug 2026 13:48:02 -0300
Message-ID: <20260826164814.44335-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826164814.44335-1-daniel.barboza@oss.qualcomm.com>
References: <20260826164814.44335-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9Q_IamVzJQfuYiXxidjkkF3qIcAWYTWn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0MCBTYWx0ZWRfX6H8kExeaeg5w
 P7M5cj2VMJKYJv9YbcO1qIYN/505+lahgAobEB5ncl8DEbnuiGjVyfTHqaACA3dn18anxNRurDS
 I71DhwuHU63THylncOEPDh07UEu9eKKZ9FIs+Nrwn2x/ggf1WYpoCRXOk9zR8SnNbSxbI6Mr0Q6
 cVxfu3u6OBtAx+gRBgPgCI2WcgndiWfShNEpfdskrAxHekhlmZYeFxCv7Cucrp1Kb9pAgHoqmTw
 SuvL8IpDYJvTOfhj2o01F7HIjORZi7sc4+a4W9/OwBgiX5zkV5EyvmUw7biXDmMg+s7cXDarTFV
 QgQ7h+fr69747hCOeRqFVAuCRGpqKy7pCnp08THsAXebuP/HlDWToO5o7Vl6LRxOJSKF5SGmLVK
 YO8BNZJRhV4H6UOE/88vBPnNVNa17i3PbZnJ6mHCpEWsyGBOUMRsTDFTuWmMXygRNYdDCnAZVj2
 VK4+jpAx5JWHsBwRYhA==
X-Authority-Analysis: v=2.4 cv=Xfq5Co55 c=1 sm=1 tr=0 ts=6a8f18da cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=azO7UiENNDAzAd32FwoA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0MCBTYWx0ZWRfX7rq+5C1isvCX
 zwvb0zPkDx5TyE5cK6127GKlgltWOYQxzGed/YOQwE4ILiG1rw1uaA0cDJ+tB0B6T0z6BpBA6R7
 6/6yNbIw6Gm8ouFCd4X6gQQeczFLk2g=
X-Proofpoint-ORIG-GUID: 9Q_IamVzJQfuYiXxidjkkF3qIcAWYTWn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260140
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


