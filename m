Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F30C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 18:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfiH1-0001HE-1z; Fri, 03 Jul 2026 14:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiGz-0001Ga-Gu
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:05:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiGx-00026C-HX
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:05:57 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663Hj3TQ679208
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 18:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 o0QSRSQX8OU+omQDi0SR/hFUIF9oi+TXP31bNkHRkJk=; b=PpRf0bDCO/eZWiBF
 XZrMxzLeXU8VUl1VYWyH2fOnH9KNW6DuPmvQ4kAHsRd5CW1GADLQQTguLz3zDJd2
 BFewSa6zM3PG1EExhOZW9VVZgcP9/y6rc7yws5re1F2gimZoNnRWltjGHkVuTYNk
 eQv/zMBcbkJ3OrVpMxjAmSLtHeNNen5w9XHpjCtUdDexLTpnbCvf5lJ3+LIY9eRm
 vjsapPAC183KYgTtCPKqD6kz8IXx++bMZR//SZThGwon9FrhA91qO297RzWzTdBU
 qzXx89lyjO7CzXCntiRnCPkUlAQXDXoO/aVSxH4wXm8FKYkEP5OVoMH9jukw60+b
 /BUirg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f68u328y6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 18:05:54 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c01ff996dso10229771cf.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 11:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783101953; x=1783706753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o0QSRSQX8OU+omQDi0SR/hFUIF9oi+TXP31bNkHRkJk=;
 b=NLV3iWXUO4MxBaglgjiNrdTHkKDyPM6KvCqIPhaNlnF0pFFOwsuvxqghkk75cg+z6y
 7qqW6NmkP3GTwZV69fi8Rkb39/NLO3P+z/DnFa55aYFrWzqCRICcEORIbY9/S0VvsLIY
 QphyhQhAULknr4j6Lw/JzRmRgNdLeXEb3foucCkc2QMRJvSw6Wvbew3xUx358kZqTOLV
 lhfGexCPCUOsADcmriA+nHxEjYYRV0PwkrNhsY/iJHhgSj7PQc3XvxoKQTr77xHjTL2y
 QNAEFCMwleFZ/NSPKiXN7sSw2Wq+JI8LGwfzprF1AyvRJ7EQ8JmIUUrEC5qXS5B9svK9
 FNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783101953; x=1783706753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o0QSRSQX8OU+omQDi0SR/hFUIF9oi+TXP31bNkHRkJk=;
 b=c2xSs1NBfD+5JRxaOpZXpYfCT1Nlsv6qekmdGT4cBC2cwppLyggCotgnw9nfXDybCE
 puXLGWzJKg8VUnYIZ4HBCUnYCiDA7olCZCB8/w8J4wYcYRl/uSU9is57mI1iFwQkT9FQ
 QFiIsEUGBy517aRkMf4Nr2jZy57zrxv+CiQi1YSf1HukXcrNgKsczZwEeGgXjOZGENKf
 bVWR+4G8ZvAWXouIw5Zoigj3TvKyVNuQBCdw52T9FkuOWYhrw9WW7AlDRMXmBESLnm1r
 Y8aMykCcl4WiKDt9A4Ri2BAlxi3c+2lDXOgfEu9n251m6jDgZzFP4aQKJfDIMPC91qo6
 R7Lw==
X-Gm-Message-State: AOJu0Yz36ei/cWemLjnvmBuITMUQzBKiTocyVBoBNGjAITKGyHxvCBAR
 Mp+rSqUztOOVSjUhSDgDGwPw0lXDW+sTYVmqvs9022w/76asbytOXBACljhmbPGmXcpidDryygS
 AyN6/4554YzOfgFB//RFqqVpAqUhw+Nxw9IIMCeB5hjuFcIrYUVv/gOUKtKykljoDiw==
X-Gm-Gg: AfdE7cmlM3cBS7l7RBaUMwCwBtMqO+PvkogwTN133cTw1K2anZzIxL6xbXniMgJwyIu
 hSM02TrwvwwXwxy4+buZgavziOiew4wc362fWhZjP2Tj4SGEtHh9xG/gyKEKfvqkiryDOOtVoko
 gxH4IOLWKT27wvc5az/lHRcGoU8W+2w3jLaQ8b1NQu8w3qm7N14dM/4FCVtDGdP3+9CV16WkwBu
 EXpyvFdm4eBtKp+fFJ5kYigk+M+0yJ3nwyX15AsHkDbaQel0Yk3AOyu/YLeJnWstnX/Uh4Lexej
 coWBC+muxfFv8PgK7hdV1j1s91fCy1WxNYd2N0t++ZKNGxeiQSh7KGexin+FbLHlyMGqmR/yZoR
 RIY2nJOY5xmqFQIcCHlHcc4otCHLj38cpcyuT/LEpHhgjiA==
X-Received: by 2002:a05:622a:1348:b0:51c:2685:2952 with SMTP id
 d75a77b69052e-51c4c325c4bmr10095841cf.62.1783101952904; 
 Fri, 03 Jul 2026 11:05:52 -0700 (PDT)
X-Received: by 2002:a05:622a:1348:b0:51c:2685:2952 with SMTP id
 d75a77b69052e-51c4c325c4bmr10095281cf.62.1783101952451; 
 Fri, 03 Jul 2026 11:05:52 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41d2d688sm22560081cf.17.2026.07.03.11.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 11:05:51 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Joel Stanley <joel@jms.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>
Subject: [PATCH v4 03/24] hw/riscv,
 target/riscv: move pmu fdt function to fdt-common.c
Date: Fri,  3 Jul 2026 15:05:15 -0300
Message-ID: <20260703180538.3346781-4-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
References: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OJ62wVZibnf_MDJqiyvMfPfalaWoXQlK
X-Proofpoint-ORIG-GUID: OJ62wVZibnf_MDJqiyvMfPfalaWoXQlK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfXwCC0VPG8tIvA
 aFQXbC0HE+ftM1mw0KbXvbNOi1DUmGCMqGuYogP1IwjhnRw7zzEIG7shuacE4MOGkUICmJpldVH
 iGmJFGQHP+t403oqz4CPA3ErWXg7Ib0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfX89vFgkXEYdYK
 Q3Y4UmAklUIQJh56kfrV+CVaQF//p17I3otckUftQL+lS9kUJlgQ06Id5ZSTkAzZrxMICi4Jib1
 EnQCL4GwflF4D1yAt+uin3iVGngOu7WCgWhTZREZUEMYVtGdE32eV5qozlpIuvafnjIVEncruXW
 o4/tAs5pW6Iiz1G8/bI7R6j4Cui4KyO4fmLAADZ81OFIBTlnxY/XqCXtcysXNqnOi4JNnHqhRY2
 Hz+o16NwK2H3mUOShxAqq6iLmNUqkOs/YebjR61qexSiM+ORhisvdQDzuAz9LSKQosSP7LSxJAb
 Cy285eVmJCW6G/bzAviX30Y94bGkcWLStaudH5rj/v1bRyF2jF55PTKpG2TY8e0KaxKqlng0Vyu
 roF7peQ62Q1DStK+NQ8PCFDJ+rcmsQp2uwYGLVe8CL4/PG49uo6Y1wbdmZLbfUdn5+J/V3thInu
 y9jiGAVTzxoUsZND8Sw==
X-Authority-Analysis: v=2.4 cv=OaKoyBTY c=1 sm=1 tr=0 ts=6a47fa02 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=rnC1OXZ3MjwXSMxYyksA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030181
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

riscv_pmu_generate_fdt_node() can be moved to fdt_common.c since it has
no PMU TCG internals.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         | 52 +++++++++++++++++++++++++++++++++++
 hw/riscv/tt_atlantis.c        |  1 -
 hw/riscv/virt.c               |  1 -
 include/hw/riscv/fdt-common.h |  1 +
 target/riscv/pmu.c            | 52 -----------------------------------
 5 files changed, 53 insertions(+), 54 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index e0e31af09b..aa143a618b 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -230,3 +230,55 @@ void create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
     }
     qemu_fdt_setprop_cell(fdt, nodename, "phandle", plic_phandle);
 }
+
+/*
+ * To keep it simple, any event can be mapped to any programmable counters in
+ * QEMU. The generic cycle & instruction count events can also be monitored
+ * using programmable counters. In that case, mcycle & minstret must continue
+ * to provide the correct value as well. Heterogeneous PMU per hart is not
+ * supported yet. Thus, number of counters are same across all harts.
+ */
+void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name)
+{
+    uint32_t fdt_event_ctr_map[15] = {};
+
+   /*
+    * The event encoding is specified in the SBI specification
+    * Event idx is a 20bits wide number encoded as follows:
+    * event_idx[19:16] = type
+    * event_idx[15:0] = code
+    * The code field in cache events are encoded as follows:
+    * event_idx.code[15:3] = cache_id
+    * event_idx.code[2:1] = op_id
+    * event_idx.code[0:0] = result_id
+    */
+
+   /* SBI_PMU_HW_CPU_CYCLES: 0x01 : type(0x00) */
+   fdt_event_ctr_map[0] = cpu_to_be32(0x00000001);
+   fdt_event_ctr_map[1] = cpu_to_be32(0x00000001);
+   fdt_event_ctr_map[2] = cpu_to_be32(cmask | 1 << 0);
+
+   /* SBI_PMU_HW_INSTRUCTIONS: 0x02 : type(0x00) */
+   fdt_event_ctr_map[3] = cpu_to_be32(0x00000002);
+   fdt_event_ctr_map[4] = cpu_to_be32(0x00000002);
+   fdt_event_ctr_map[5] = cpu_to_be32(cmask | 1 << 2);
+
+   /* SBI_PMU_HW_CACHE_DTLB : 0x03 READ : 0x00 MISS : 0x00 type(0x01) */
+   fdt_event_ctr_map[6] = cpu_to_be32(0x00010019);
+   fdt_event_ctr_map[7] = cpu_to_be32(0x00010019);
+   fdt_event_ctr_map[8] = cpu_to_be32(cmask);
+
+   /* SBI_PMU_HW_CACHE_DTLB : 0x03 WRITE : 0x01 MISS : 0x00 type(0x01) */
+   fdt_event_ctr_map[9] = cpu_to_be32(0x0001001B);
+   fdt_event_ctr_map[10] = cpu_to_be32(0x0001001B);
+   fdt_event_ctr_map[11] = cpu_to_be32(cmask);
+
+   /* SBI_PMU_HW_CACHE_ITLB : 0x04 READ : 0x00 MISS : 0x00 type(0x01) */
+   fdt_event_ctr_map[12] = cpu_to_be32(0x00010021);
+   fdt_event_ctr_map[13] = cpu_to_be32(0x00010021);
+   fdt_event_ctr_map[14] = cpu_to_be32(cmask);
+
+   /* This a OpenSBI specific DT property documented in OpenSBI docs */
+   qemu_fdt_setprop(fdt, pmu_name, "riscv,event-to-mhpmcounters",
+                    fdt_event_ctr_map, sizeof(fdt_event_ctr_map));
+}
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index beaf64e0c1..d808bcc11c 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -17,7 +17,6 @@
 #include "hw/core/sysbus.h"
 
 #include "target/riscv/cpu.h"
-#include "target/riscv/pmu.h"
 
 #include "hw/riscv/boot.h"
 #include "hw/riscv/fdt-common.h"
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index b68067cfdd..301f1ea54f 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -30,7 +30,6 @@
 #include "hw/char/serial-mm.h"
 #include "target/riscv/cpu.h"
 #include "hw/core/sysbus-fdt.h"
-#include "target/riscv/pmu.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/iommu.h"
 #include "hw/riscv/riscv-iommu-bits.h"
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index 017278b611..1729a6abc6 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -35,4 +35,5 @@ void create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
                      uint32_t addr_cells, uint32_t *plic_cells,
                      uint32_t cells_size, uint32_t ndev_sources,
                      bool numa_enabled, int socket);
+void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
 #endif
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index 3444400bd2..38ad2737e1 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -27,58 +27,6 @@
 
 #define RISCV_TIMEBASE_FREQ 1000000000 /* 1Ghz */
 
-/*
- * To keep it simple, any event can be mapped to any programmable counters in
- * QEMU. The generic cycle & instruction count events can also be monitored
- * using programmable counters. In that case, mcycle & minstret must continue
- * to provide the correct value as well. Heterogeneous PMU per hart is not
- * supported yet. Thus, number of counters are same across all harts.
- */
-void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name)
-{
-    uint32_t fdt_event_ctr_map[15] = {};
-
-   /*
-    * The event encoding is specified in the SBI specification
-    * Event idx is a 20bits wide number encoded as follows:
-    * event_idx[19:16] = type
-    * event_idx[15:0] = code
-    * The code field in cache events are encoded as follows:
-    * event_idx.code[15:3] = cache_id
-    * event_idx.code[2:1] = op_id
-    * event_idx.code[0:0] = result_id
-    */
-
-   /* SBI_PMU_HW_CPU_CYCLES: 0x01 : type(0x00) */
-   fdt_event_ctr_map[0] = cpu_to_be32(0x00000001);
-   fdt_event_ctr_map[1] = cpu_to_be32(0x00000001);
-   fdt_event_ctr_map[2] = cpu_to_be32(cmask | 1 << 0);
-
-   /* SBI_PMU_HW_INSTRUCTIONS: 0x02 : type(0x00) */
-   fdt_event_ctr_map[3] = cpu_to_be32(0x00000002);
-   fdt_event_ctr_map[4] = cpu_to_be32(0x00000002);
-   fdt_event_ctr_map[5] = cpu_to_be32(cmask | 1 << 2);
-
-   /* SBI_PMU_HW_CACHE_DTLB : 0x03 READ : 0x00 MISS : 0x00 type(0x01) */
-   fdt_event_ctr_map[6] = cpu_to_be32(0x00010019);
-   fdt_event_ctr_map[7] = cpu_to_be32(0x00010019);
-   fdt_event_ctr_map[8] = cpu_to_be32(cmask);
-
-   /* SBI_PMU_HW_CACHE_DTLB : 0x03 WRITE : 0x01 MISS : 0x00 type(0x01) */
-   fdt_event_ctr_map[9] = cpu_to_be32(0x0001001B);
-   fdt_event_ctr_map[10] = cpu_to_be32(0x0001001B);
-   fdt_event_ctr_map[11] = cpu_to_be32(cmask);
-
-   /* SBI_PMU_HW_CACHE_ITLB : 0x04 READ : 0x00 MISS : 0x00 type(0x01) */
-   fdt_event_ctr_map[12] = cpu_to_be32(0x00010021);
-   fdt_event_ctr_map[13] = cpu_to_be32(0x00010021);
-   fdt_event_ctr_map[14] = cpu_to_be32(cmask);
-
-   /* This a OpenSBI specific DT property documented in OpenSBI docs */
-   qemu_fdt_setprop(fdt, pmu_name, "riscv,event-to-mhpmcounters",
-                    fdt_event_ctr_map, sizeof(fdt_event_ctr_map));
-}
-
 static bool riscv_pmu_counter_valid(RISCVCPU *cpu, uint32_t ctr_idx)
 {
     if (ctr_idx < 3 || ctr_idx >= RV_MAX_MHPMCOUNTERS ||
-- 
2.43.0


