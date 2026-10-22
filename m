Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E008C606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 22:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B0wxz0XS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i4pyBTH8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0nV-0001o8-4T; Thu, 22 Oct 2026 17:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nR-0001mQ-Ez
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nP-0000Hx-P3
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:01 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MLf4na839068
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6Dn8qMlDwc/a6OIUdd/27QLER9l8IWjdE2dfohtDrZQ=; b=B0wxz0XSJ7NkX0nZ
 x4Ddy1Udo9Oq4+V/hYltwbQfCONXwBEk2VIymt53WU9vAbl53E8U6hgF1qJ68ASJ
 29WMIXj1xSlFo4e4Oc5GScemQPcErjKnTU25aRB6drhXqVI3EkznG1tj/dsinFGA
 k0Zw5b7t3m2tMrS9vjBPQDJa2T0VFkP9KGeRT/ZXWH5ejOqMJsRpcKJFik7WZ98V
 TVXy5bKizfPfJf0YGvW1fC0melQZxjgoorwrYTNaGLFa0jhAknrrTvkCgYaFatGW
 TiHQIJrS0OHb/SZgSnY9BpCvxBfY8oXFtjEfxPaSG3Ho1Sa/oKqT+n/DjHDk27vX
 zzgGpw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnyw185d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:57:58 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ab2395f104so249222a91.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706278; x=1793311078; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6Dn8qMlDwc/a6OIUdd/27QLER9l8IWjdE2dfohtDrZQ=;
 b=i4pyBTH8kbIjfsvF9f4xAJgYW6BkYS/lqc2m1lJcaMeka50P6Xy27Xs30+BnxVA4yY
 KgpEeMkS8sd7f5X8dCoKd00Z6mLlXS7EglgmabGhls/nNRpf6v5an91GRBFV8xozYOcm
 qJw/yV0J6ZWvQHD5/oKnCP6ttIVgtrab+AYlserwkeVo+uBKFYrORSritR/BIWmdtpxc
 C1m/gQeT0gOsXZHdM/AE1dzeGDYyBMJi40TLyH/3tU6fVZJoiiuMVNNotJL2z7/58C/W
 y/FRcMY8UAvdEAsyfrlmW/2zVW7yZm1yRRSjCM2+XN/t1MGbJpnvJhD2dQqSkTRTh27e
 fjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706278; x=1793311078;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6Dn8qMlDwc/a6OIUdd/27QLER9l8IWjdE2dfohtDrZQ=;
 b=Ukb8nV/WZwanD1i7wq2W9ku0U5+l1vFMPhiVUxJMXtwCVZcTPAls8B2xDppfPq+eZd
 CDW6wL3oJFUSroKjqFkgcsulZG+Ty1ezbBplYsno/wE4puZp11xz8hMYocUfiLZwWcZ4
 DmR/PJBsBF8pccQGAE1rWjA8GtHxc+ceRfi7OQp9KVnNl6wAgDmPHuQJ3YlZgk8qu8lO
 +FxclYCV092D6fvYSDp8wWLaKTzvdax2k8qw7PBomIaEgDeBVjiyFwU+xPjI2eTVLL/9
 GmqjPBbM684Dgzwpm0Wl9Df3ZeqhS4B9tOQ6Y+kTmstLLyH3hQH8ZJ8/M50ZRBUufIgm
 jI4g==
X-Gm-Message-State: AFq9FYJFv07LUDSJLT9ZGbP9nDNHwYATCbfcP6ofxF4fRBPydHfm1S8j
 j/ojmrJvRRd2N0vp39iiEFXfYh4PXF1xV4Uv9ID+sYAzJLby77Myr2NNpdW5ooKKJwsin23Hts0
 +CtrRbx5OgyFAqZfwpKuId/8fX43OyDHBfPb3bUoCXe1HqyLQ2GaYnothw5F5TDVz0A==
X-Gm-Gg: AYBFou0wKP0c7P5yazZU4LOz0bB3vIoBf8DW53mdKRYfekKe0EFa8qZEsromyWVME0f
 WDsPW+5wsEibMGPi7puvHBc9klg+Z0oKjX7NGoKrGmiYzouYPVSFQD/tKjowg5IgMySajOxLxBW
 WBwg/O9KnuuwqBtlFADwlfPI7Fekf+/9yqDN4l0bVLYT233zuv3S64VWXT1nNBXZuCDcLn2GLpb
 WKROCsYuI0FBeVX9UVPtMMS3diVHgo5TibbM4nY7T1DSzCXSNhCUSV/BIn1JoVSwNVewtlgioKX
 dWK1AiB9YYI+jK9EqAFrQb3SK2NJj4pwwN78pdOkPS0ty88og3c/ROFj7NDnYtQ/9yngHyfwAIH
 ochjpNunayr+mnRbYCu5kaJVhJY22legrtFZGeJ23cwTz9IJQqN09YJ0ljo+pjow=
X-Received: by 2002:a17:90b:268a:b0:3ab:f38:2b3b with SMTP id
 98e67ed59e1d1-3adce5e9355mr127670a91.21.1792706277881; 
 Thu, 22 Oct 2026 14:57:57 -0700 (PDT)
X-Received: by 2002:a17:90b:268a:b0:3ab:f38:2b3b with SMTP id
 98e67ed59e1d1-3adce5e9355mr127661a91.21.1792706277446; 
 Thu, 22 Oct 2026 14:57:57 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adca62e477sm648061a91.2.2026.10.22.14.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:57:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 09/27] target/ppc: implement get_dump_info sysemu op
Date: Thu, 22 Oct 2026 14:57:28 -0700
Message-ID: <20261022215747.2479440-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LIdNlGwFimH5r-PoiHQ4ddY2hfJyp9Vh
X-Proofpoint-ORIG-GUID: LIdNlGwFimH5r-PoiHQ4ddY2hfJyp9Vh
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6ada86e6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=HC5FQ_MKihgnNVCgyfIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX1EF9jYxYuAJF
 /Xlmnq/jO0l0w/TaowPmOO6ePg/oxIhHtOPK4L+5zoGovs3qQNv/VjCx7ocq3UNw3O0GWGEpvpg
 kBQEhwP7eAQ455CQjDS95Esv3PhT8oE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXxd+IJsUNFzv3
 wEju67wWvHyW8epu0utuPync+y5cmK/ltOmZUG9iYmCByrqUuW76K7DsGpVs8WwktYxQK5folEO
 /RGdipPgH6+kpVIJeYcZtKf+SOG/tZ3X5PXE9SLLFGQbCGIKUkP0U8ZkT3JloFsrPQPLn9flKn2
 wTWz5RJUhQIIG+E+6yBbqMl4KrajJljrecRS3Qtzi3x49Bsnxq6PB/MezkBjMst2CnRR4T3klwj
 dburvlwfDIa3eWOsixxzudO6LBt3A0c2D+tq638p7GVn9kY+M/pDi8YapqHTc12/MVTOXiDcmRs
 trX6HmCoY5FL7jMZbAwbtP2sElzOoCklgj+HOQTTYgxrAJVyygmW9bRJ4+5wbDfm6yU/eoHJFR7
 UD3zKwE63Bd+ir2XQVxhDrvSIB4XYE0iDUNE1mrYoLQkeKbHOhLBHVKO/dRRVDTnUziuEZZBgjX
 QKk4s1FBFw8P0mPqlrg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
Link: https://lore.kernel.org/qemu-devel/20261021181244.867840-10-pierrick.bouvier@oss.qualcomm.com
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


