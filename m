Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB34606A31B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K/cnahE/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hAI6DK+p
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJaoH-0004Oz-6i; Wed, 21 Oct 2026 14:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJao9-0004MP-MT
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:13:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJao7-00083O-Oq
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:13:01 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHpLEj2416065
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k6ZKJhJFFQEQhjnQerJPyvAsT2gUQFT6V9SyxqcK4o0=; b=K/cnahE/OVn43Onu
 hw+hzB+YoO9EQi24CzEM1o3S4e41r7FPeuV2nyV7NM++YGeBoq8ozgnv/ZSWRyNC
 ezs7WMIMIYpjzVbY/69Q5UvPAzVcwAL3x0r4Jxonjr73JQlCgYlaqi8/q/T8IfY8
 XHDiXvNDt6V+eivHcmGPcPVgSVflHsLL0yujDcUpwkkbrJ0CFEMgAZdQi7wWbcUp
 I8tMycNcgckdHAS4s3IaD9SmZy2DYeF7cyLEqP+grGE/7ZCYCU/6PkhZN2OQHsWF
 JgwbpOev6DE/OEGvdA66Ezz1GkqOxp0koP2Xijrz3o6lVSs0IDa04IMcilMoHW3D
 DUSx1g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heuhuj02h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:12:58 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ab67ff8ec3so790165a91.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792606378; x=1793211178; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=k6ZKJhJFFQEQhjnQerJPyvAsT2gUQFT6V9SyxqcK4o0=;
 b=hAI6DK+p4f83lmXG4XI1DII9A5FwsvFFgrM1hPYknMjyKwkAaZkR//ZoGG5Bt00l3/
 f7t4O1Qhec68hBG+fE+qdWul8yFG6YK2rVIxrAwmxk6TMfTCqpqLlf4d6Ie/MjkrZS3v
 L5ekWl+UwLDpMOYaPCb30b6c88ac6U1fyAfFwnJZdNluJHHJM6SVs8VKt2q00+36ES5s
 kiJjBvJusH+MLATpMlhVMlNL/JOd6wZSbDVVrcgsK85xrmUGNX6yDFu+agjfzQD2Dmjs
 +6h7dJm8b45EqAJBUJQZtDXnESqud6r7lzepe7IR/qP4CIt7D25PmOy4pkviUC41fuBn
 MzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792606378; x=1793211178;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k6ZKJhJFFQEQhjnQerJPyvAsT2gUQFT6V9SyxqcK4o0=;
 b=LNUAfb3JWWYNtbpGpUX5jpTmDLEvJOWFVmT/MXqx2xneXK2KoBnQbcdHmzHCh+/JHa
 RCCUheDSZc62s75Q7i/cshhpeyHJqhJmLET4UtrLeXu0D1hM4DHR+W/hICVi4Ppqo6Wd
 taU9WrvZ0W7XBTcKiF7M+pFmtxnRMLY714tcy5pybWNCCz2pynjQEJx+XDylT9h9nIq/
 1ZSl1vTzSI2wI+25mnLhF9h0jl/Ahj7l0VeNm/Rrdr8ffviZnV2jWIm851ooKiBCTC0C
 3E1FKmlvmciJ4AbDoaDyxOPtEQSUPAagBl1gaXVTre0Oyq4bweYLmI0kstZordw26xgU
 z2HA==
X-Gm-Message-State: AFq9FYJFGJINyTSo479lJlSFRTUptv8zV7PqlnZzjPjXd27jXqNgMopv
 TBAkdqK4xfu7RwOp7xjoQsyWfatcfkaHz52EO0N/f6muZPXirZEVpf6dXR5e8BRK6f+sQdUtE68
 ZYztGnXAmihz+KusVSUeY3JcO9ycmThYTsa5tWCkrgXeLl7l6CI8FK6+KqliALh5XKQ==
X-Gm-Gg: AYBFou2l0isYADDDBoFIC2/gI4/1J6KV/vp+p+AoamQzJP6nBxIHLkdq2gB3olYeUoH
 HoxCo0Bls1NHUwfsM0YuTGpm+U86GuaietlKZQrpZ5fvJZBfJDu5HfbiA3Kmqlc4gCWyCgD/MZH
 pqRjfntebv/LETRak4utYlGBwHWTqjG+GmgaU844gbH8RhwyI4rDwwNqBkMq6uye5xURhy2lt0w
 gxPIG6bhs3FdJVIr0aU+9WhzAIK5pRqb6dVPUPqaAulO64OEv1QtZBXW7mwltnFnTTfEGWsIBqn
 XJBpc+yE1v/+kKY0f1UOJqsJhl18ssWZj+Lau+QuiIs7rI+xhePb51SwsaIagj+eUmT63YnM6Ua
 C8zuB3KKJCGNUSpfs1lDrClE5Pfbyr+EpKLVJnVIdyn6FESnHXD+7kj+P2+IY7Kk=
X-Received: by 2002:a17:90b:384a:b0:3ac:9e76:aa9b with SMTP id
 98e67ed59e1d1-3ad86c2e426mr2461507a91.7.1792606377590; 
 Wed, 21 Oct 2026 11:12:57 -0700 (PDT)
X-Received: by 2002:a17:90b:384a:b0:3ac:9e76:aa9b with SMTP id
 98e67ed59e1d1-3ad86c2e426mr2461490a91.7.1792606377026; 
 Wed, 21 Oct 2026 11:12:57 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada48ed74bsm499152a91.3.2026.10.21.11.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 11:12:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 09/21] target/ppc: implement get_dump_info sysemu op
Date: Wed, 21 Oct 2026 11:12:32 -0700
Message-ID: <20261021181244.867840-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=d4JgWhjE c=1 sm=1 tr=0 ts=6ad900aa cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=HC5FQ_MKihgnNVCgyfIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX1tP78X6U74lU
 1TXEBNLAJ9lPH9pHdJ4j49OBHRXnFR7heU2wFO8/06SWr0ZZkCWTkGSGv6ABBkuxZ45iv44Cbpk
 +rBu34Q1ZcR2289d0gE6PjZxibmKytM=
X-Proofpoint-GUID: pz3P808xj3aZXKEzrwQOis1oX0uZHiHO
X-Proofpoint-ORIG-GUID: pz3P808xj3aZXKEzrwQOis1oX0uZHiHO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX2hYAaPHElMRh
 14QguCQ74+DaFKw+c6aEuW0xmxbK49VJsN/DAyuNu6lV5mESXBWJN1jX53vaqM6/+60fENnTCUr
 fQTZ7XYeCAdev6lJZfWHCTczr3sXCx5xtZbh/YZm5hMVROuVUYeaPSNg9L1jBhkzsDEh9YRTX5E
 faP2odlquRZhuc5zmK6Xr3J2GUquo7ze8XeCOk3aGeWPvwfeBmOGjw2KTrE5Ur0A2lR4GyQF3tr
 8j8aIg0aCmfpCt7T9o2X4l6PEkeiv7lqbyuMtIe9xuJ+FWDXSGA731jOaqF54N92bArhYKsNX0E
 xZWfm5R1O1CTvFu31U6A1BQLY2wO4yFuyaiu/x/UobTCpSm9Pfb0kbUrGWtwf9+rjq6bmZFeCNB
 CNYeXs7H0BX3yTphTNSfPooHOpJswNcGMHNcaop1UguoaVR+u84/ah3CWIcVi65ctYz9oFIAc/K
 GDP0gtBG73LvFDLsj4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210072
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For now, we keep the global cpu_get_dump_info symbol defined.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/ppc/arch_dump.c | 22 +++++++++++++---------
 target/ppc/cpu_init.c  |  1 +
 target/ppc/internal.h  |  5 +++++
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index 80ac6c3e320..2296a0c9e8a 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -17,6 +17,7 @@
 #include "elf.h"
 #include "system/dump.h"
 #include "system/kvm.h"
+#include "internal.h"
 
 #ifdef TARGET_PPC64
 #define ELFCLASS ELFCLASS64
@@ -229,16 +230,10 @@ static const struct NoteFuncDescStruct {
 
 typedef struct NoteFuncDescStruct NoteFuncDesc;
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const struct GuestPhysBlockList *guest_phys_blocks)
+void ppc_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                       const GuestPhysBlockList *guest_phys_blocks)
 {
-    PowerPCCPU *cpu;
-
-    if (first_cpu == NULL) {
-        return -1;
-    }
-
-    cpu = POWERPC_CPU(first_cpu);
+    const PowerPCCPU *cpu = POWERPC_CPU(cs);
 
     info->d_machine = PPC_ELF_MACHINE;
     info->d_class = ELFCLASS;
@@ -253,7 +248,16 @@ int cpu_get_dump_info(ArchDumpInfo *info,
                 "pseries-", 8) == 0) {
         info->page_size = (1U << 16);
     }
+}
 
+int cpu_get_dump_info(ArchDumpInfo *info,
+                      const struct GuestPhysBlockList *guest_phys_blocks)
+{
+    if (first_cpu == NULL) {
+        return -1;
+    }
+
+    ppc_get_dump_info(first_cpu, info, guest_phys_blocks);
     return 0;
 }
 
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index b711f9c0a85..5853a92bffd 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7473,6 +7473,7 @@ static const struct SysemuCPUOps ppc_sysemu_ops = {
     .get_phys_addr_debug = ppc_cpu_get_phys_addr_debug,
     .write_elf32_note = ppc32_cpu_write_elf32_note,
     .write_elf64_note = ppc64_cpu_write_elf64_note,
+    .get_dump_info = ppc_get_dump_info,
     .internal_is_big_endian = ppc_cpu_is_big_endian,
     .legacy_vmsd = &vmstate_ppc_cpu,
 };
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index a20a0f9f7e0..02dc68fe2c9 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -324,4 +324,9 @@ static inline int ger_pack_masks(int pmsk, int ymsk, int xmsk)
 TCGTBCPUState ppc_get_tb_cpu_state(CPUState *cs);
 #endif
 
+#ifndef CONFIG_USER_ONLY
+void ppc_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                       const GuestPhysBlockList *guest_phys_blocks);
+#endif
+
 #endif /* PPC_INTERNAL_H */
-- 
2.47.3


