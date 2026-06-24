Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51532CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 00:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcB92-0007Qt-Ug; Tue, 23 Jun 2026 20:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB8x-0007QI-FF
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB8u-0003Bz-TU
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:02 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NK0IUv973558
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=C2rMfFWTL/1
 +5pznB7RLcCvBAec1n4x9PcUZHGb/jms=; b=Zb69ZoNUfkejMgymO+Z6jZe3huA
 avJfuR+9uJwhD86At2qMoGb4j/ISdQIOB4+bK7JXXpPKCrAP0JaNf3RBgxpPlP/Q
 hm6IJeHu+mF6msLJNmtGUmvCPWefqZqB9btTzqR7xEsPOfikZmAxxiclMwcNtPmP
 7zkPhOsiyEqK9XlliFU3HAUwz93ejDrbcyeEWyJlLrhmsug21p0m4RTied7X6dzE
 sGtPXeGx5yZIE2jKYobRh8K9+zBu999B3um9CvzyRsrS7NcaXh05wvP2PqvNxBjX
 5CZNXpBxFAJY2JzhB4WmygTPhy6lWM4pVMrJeZyunyRaOwPQ6IEfD89fx5w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f004p0sj6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:06:59 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8dc4d71a6abso12778086d6.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782259619; x=1782864419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C2rMfFWTL/1+5pznB7RLcCvBAec1n4x9PcUZHGb/jms=;
 b=j6i7OyBiMN9WBgGuM9TzdKM82imPtec0PqbxHsZ0mJ1u1zmlM6vfnDXiMBYf7+KelN
 M+YUxis4Nsx3l0yafWaGnpmlj+oqaDJ5libEWKLCmCIzKIwVcYq6KCkrPzroe+h+3k+2
 UXz1+itmFkW329h4vLvt5fD/1cQvNC/POLGfkUfQisVZEwbVYInMdns3rBoOxu91euIK
 i5lTnTopubtoiPSsHLunQDpJ1wsH6GCsfLjH1dLfYbObAN7TRlxQq4Rly9ezbXKE9v+D
 WDKsjbJbX1WrOP9Gs3YtU+Oz2zTfAzsxxqd9m9OeF09/wS+blPgyLwQGo8gGzOPIHsHT
 R8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782259619; x=1782864419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C2rMfFWTL/1+5pznB7RLcCvBAec1n4x9PcUZHGb/jms=;
 b=c3kL4nKDz+77AHIoM1hsYufaIaVtfPxXg7/pML8d8oRVtqOhgKNnlJI/dluLRPqe+q
 3nbkBGI7X1OXOwlqJWb2Oqiav+BzosavkkVD+8wrOjQCspWIqwpnZmhu9PqWOYBdvRDl
 Eftz9XqhT7deMVnXJCdwX/Th1LKWsg3t0jgRKgu0UaOuLS9wuQbhpot1NdZ1HQmzHRCD
 KIgiMDP8sEfbcyOHnY3rWLadWU8chvMoF2Zx7SlG5+scZhkrEKnIDQdZHO48kHqBOvRr
 5PnFCt0Zr0ckxHx8oIE5ufFHS09k9Y/hd0QZnHh+utFegwPRWlJaaJs1A9Ecz8pUt5z/
 /zdg==
X-Gm-Message-State: AOJu0Yyf6CDVImNHztacYqRwXLRPnMUzqsggGof/Vh0kthaBJFh0bm1r
 uyhm4FLfAG9hUsQeT9UxA8yGZvIfcynEOXkevroAg1eydAkbFGHE7MweZ9jLVfLknwWEFhWzKRZ
 cI37DxJmLt8zeeGvoktaCGeSx54WPkwAa5UrNY0squyx2vGQm6Pzokg2M7O9xUaQ02w==
X-Gm-Gg: AfdE7cnrB/tSD2Ifke+z3wM0+Ek2lmWsoRGTnXqmJpvVU4Xl0Nxp7VB0FazVn11fO1U
 WhJlgWGLG/coQ2qj2zdAUZrRHUerbvZH+iV+3n6a66CT+pj8lKh2bThQpkQt63edR3TZvMEwdE9
 XFnzHzYxbRM1ZwE7ef31Hai9TiYdGubER/OyjobmmWzjoxAjdtHpacFqrvkgnlVFsiaYDSiVr8T
 We9JTWPW+HBDKeocpQ7gDEWVUsGUGAM8c1T8gTDu4tql/Hn7BxOmKnaiPCWBF6SRQGTBnatOYWm
 LcEfxkDC6ueUQy60L5JeH124iHqUp0Ffjid5tRwJEzKZcLySAcPD2dbJiml6obVDaCgS6y0UQFf
 1oVJLV9KGZYj+gIKlb4Jf2NZ68XwLulqjKxoar53+Eogujw==
X-Received: by 2002:a05:6214:508b:b0:8d1:ae7a:7d79 with SMTP id
 6a1803df08f44-8e53111a649mr23682386d6.41.1782259619131; 
 Tue, 23 Jun 2026 17:06:59 -0700 (PDT)
X-Received: by 2002:a05:6214:508b:b0:8d1:ae7a:7d79 with SMTP id
 6a1803df08f44-8e53111a649mr23681766d6.41.1782259618582; 
 Tue, 23 Jun 2026 17:06:58 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df81cdec56sm142422976d6.32.2026.06.23.17.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 17:06:58 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com,
 fritchleybohrer@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 06/24] target/riscv: move pmu.h to tcg subdir
Date: Tue, 23 Jun 2026 21:06:13 -0300
Message-ID: <20260624000632.2149359-7-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfX0Nu8sJq19Tr0
 pMhtW3XlvM/FK+iPP1+B3YvFt2NaD6M1XNW/Z13yrRO40q/ZpvqoVRHDciOf7FDZSg7tmqJYOOJ
 ybMMA5om7Js5t9hPz8OpuCtB0KWHbWQ=
X-Proofpoint-ORIG-GUID: eHWsy7ea8r_DGml_AGwD3GJGKCmXCwZz
X-Proofpoint-GUID: eHWsy7ea8r_DGml_AGwD3GJGKCmXCwZz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfXxHSQSaDnhl4z
 JZ9pI5S9oqR66+e2Usod9v7TjwU/8nLeR3EGn0ChUh7WkqmHaldlumFz/FXlTliYV52nU56RWYq
 PWhbTYFIMfFH8Qj6zhbKRr+cl2Q9mSaKPhZjfCx5HC6dJd89OyiPWxui8da47dH16JJsGvQrXuk
 L9+UH0pZoWwEgsn2e+52qJZr3ACslCMLlh58hClJc08+c6PXee8xW/dge6GLlsocmFvYpbzCVyr
 VErO1wxtlvrEVV7cWA+QJ+pcpZDBgJMYt8RFpzRq9ix/CuHnopvTDD9cxIelNnL+o6UpwmthP1R
 4lcqv5y8zJKbEarQZruqXEcG64mywDHFNRSDK9QpVyJVk/iRa6zKxaVaTweWXrWmaztoHJJm1TF
 Rw+z7zak+G5UYOkxegKvrc3o4EMgI7+FqPooBnWNmDwPemc+JpK3MbEOSRYtm4jlP25noIAvg9B
 7gIDtbbvudAl9zTUsag==
X-Authority-Analysis: v=2.4 cv=Q9TiJY2a c=1 sm=1 tr=0 ts=6a3b1fa3 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=KqZ3gCmnYdtU6Ji4SLwA:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230199
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

riscv_pmu_generate_fdt_node() can be moved to fdt_common.c since it has
no PMU TCG internals.

With this change we can remove pmu.h from 'virt.c', which is now
becoming a tcg header since we're moving it to the tcg subdir.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         | 52 +++++++++++++++++++++++++++++++++++
 hw/riscv/virt.c               |  1 -
 include/hw/riscv/fdt-common.h |  1 +
 target/riscv/tcg/pmu.c        | 52 -----------------------------------
 target/riscv/{ => tcg}/pmu.h  |  1 -
 5 files changed, 53 insertions(+), 54 deletions(-)
 rename target/riscv/{ => tcg}/pmu.h (95%)

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
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 92c30a6f4c..a1cf8210be 100644
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
diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
index 3444400bd2..38ad2737e1 100644
--- a/target/riscv/tcg/pmu.c
+++ b/target/riscv/tcg/pmu.c
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
diff --git a/target/riscv/pmu.h b/target/riscv/tcg/pmu.h
similarity index 95%
rename from target/riscv/pmu.h
rename to target/riscv/tcg/pmu.h
index b4f1e469a2..de2fae1fb4 100644
--- a/target/riscv/pmu.h
+++ b/target/riscv/tcg/pmu.h
@@ -31,7 +31,6 @@ void riscv_pmu_init(RISCVCPU *cpu, Error **errp);
 int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
                                uint32_t ctr_idx);
 int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx);
-void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
 int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
                           uint32_t ctr_idx);
 void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, privilege_mode_t newpriv,
-- 
2.43.0


