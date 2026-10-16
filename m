Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7F4CCF2C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmRv-00078H-I1; Fri, 16 Oct 2026 14:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmRp-000775-Lk
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmRo-0000Vy-09
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:29 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5ibt1910951
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=9Gu+vUK+DQ4
 75LtaWxe7yp+jVo0CZzh7U9OZmyXdnmk=; b=endoc6e+ZzmVtqGCi0MXDGUkxEn
 l7VRXckqD2NmoxdV8PHvDjzR9SKhfQZLRrrMd176Cx4SE5JZsmp6Gi03DhfJeXsD
 qXSrQP7SLfLkbslwOVm922gdHsygoO2xwSiXzlls5wUtG3G5wdRxGPnpQn0vK29/
 /fuJ8LbHiHr7K4GQ2yPpj1WoKOzvgXRRz93mYCVUfgcZatmw2yJxcqCVBg8Pvd+A
 kqgtz24VvV0nyMy8uM50M37oy1SH+oh2d+sfBICWaodoX1UxHGDopgDfRVz/gJZr
 0ebi/X3bM4AFkfvHyETdpcMuEhXE6toL6fBXqagSW7GRts5YA62Qv+Fhp/Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbjmf9mwq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:26 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39deda201bcso544008a91.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792174466; x=1792779266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9Gu+vUK+DQ475LtaWxe7yp+jVo0CZzh7U9OZmyXdnmk=;
 b=KmMjjNQIUx65iPG6fdqPdYI3EuD8gP8w6N0NBF9ujsarNwiHcvU5xLqiDp/cZGrnnB
 ppsRwJMbUltJRvUFbH7OIofVRpAK0Z6b34RelFBPA3plnb3ZEZIH+GGH4HSwIyCEdGme
 QLDuxLMjbNh/0yyxbAlPOatTDa4mumjm4E8dpcwKuyT49XMZY4TRIiRxDqcBMjLN8okx
 p4KA2P8cRJFDR8eEWDWJbjEnN6p5PH9B8C0vFdnGLWY//WLWfAtszDrpf6e7PrN8xSty
 dVNo6ythLk701NcgG/p8J76tMlpQ9bAa0ZkEkWJc1r3Y9FiJGbQFeoaeD9wfGmbNTdiH
 dgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792174466; x=1792779266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9Gu+vUK+DQ475LtaWxe7yp+jVo0CZzh7U9OZmyXdnmk=;
 b=dBrehqQ+Cq64qsZPtjSUkUL90e3CmYzkfaBk+SdFtc2/Bl/Bl1YUn95Zz31A3k37Yi
 uO7kjccHfHC7bYDYfL69urjqCc/N8VYm2Sdv6Omym+EIb4EuKK8yfiG9bbh88fvSeTtg
 ONTcUQJ4rA0U5k4WVHvV2kAewjEbd5NdB5xHhndde/w1w3GUExNhMY2bDMaCJ/HaTT45
 3jwCr4QUA3bUosvEYAqYcgrjoHq1IimmcEu/JkqTRagioZx8jMqjv2KKuFL5ZFJjRH/U
 rKo/LpZz1znCMl0YpDaROxG0OUZffysFGHtJc/r5TbYnZF0AwDVhdV3TfXLSMAY2Wsx9
 oKCg==
X-Gm-Message-State: AFq9FYI3MboodCidA4yHKJBbvF9qzLHGKvXfmQs4CTyFBrSFH3+65Hy8
 rmncpJXXpOfDZhpbvX3LRXP41U0Zy6zc/dvk1bnDgIzDHr8+yW3DBNcT39k3/epxqeFi32rviii
 rE9Tel1YimXhiXjIxNEKmdeqyag4Eh8+qdrmeAvzsOSq6xfFNROzkLUC0BsG54v/3QA==
X-Gm-Gg: AYBFou13YozMO22WrNA3dnOeoODgNJHMheeboJ+/sRaWGQ7X4JNrEppQYk9YzuJN9n/
 JCt8k0d3vQsIyNx7tcSaIJbUpjxMXCBZJyMhT9x8u1bGzLvhcMlyHZDWx6TzNYt7k5qXd+C21WU
 htDqsBMCTEEiNgq7r/AlZVIsICGymiRSwOvmnHGAI8jRilSAIC1+9AiOv/Xw28Kp5fmSlGTVMn3
 0a9XBpnc7qLZ6fnG5tzmyqzYf3W3hFvM17ox8bbcfJV5mC8b2HPNDbSaNx3BPtGG//rL8R7Zf+0
 VGKEXLtSC8LBIBr3a3QdcPsXXMp0ZiG+z9nl+2/o1OOqIyGf/go+ZSLRqSxo3nHNztP7+jtvUxF
 D8MKqHm63mgV6KM2XIjsoF+1WkMufujaWQodiV3GtwYJOserWwbNPDeOhqDYSxq0=
X-Received: by 2002:a17:90b:3c04:b0:3ac:acf5:6daf with SMTP id
 98e67ed59e1d1-3acef667156mr531362a91.66.1792174465819; 
 Fri, 16 Oct 2026 11:14:25 -0700 (PDT)
X-Received: by 2002:a17:90b:3c04:b0:3ac:acf5:6daf with SMTP id
 98e67ed59e1d1-3acef667156mr531351a91.66.1792174465393; 
 Fri, 16 Oct 2026 11:14:25 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48e8646sm4895282a91.10.2026.10.16.11.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:14:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 06/23] target/arm: implement get_dump_info sysemu op
Date: Fri, 16 Oct 2026 11:13:53 -0700
Message-ID: <20261016181410.191743-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: aMKlq5bjk3tLrsG43Sk7O84FCixeNZlg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfXyYsoeJkwBMdq
 67IR8Po7dZnslTo/Fd66C2VA2gn6jc5GiN5YAzq9BJQKqECr5xgANBJfIxV29SuwiXGOocRKdXX
 /4n/JouL71G+jCoHNa5pmqeBuTphgTI=
X-Authority-Analysis: v=2.4 cv=SrAFe/O0 c=1 sm=1 tr=0 ts=6ad26982 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=iHWeOob8v6k5DsbZtYsA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: aMKlq5bjk3tLrsG43Sk7O84FCixeNZlg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX4q5FveVSxEHp
 1cz65hhrqQzNmdIWyg1WsyA/sv+CHBU9X952K+8ieff/Ll6F1eg0yqiEuyGc4uitTq31uXenGNh
 8DzhbFWF2LcQmzNERLEKJkZRoU7J8aLk6fPKsZVjFAlYwGgUM3U0D+IyIkPUn6/QT7LH0tquDU+
 XsdLRS0uwQ+ImI18z1hG9fmXPpdwtCa7va5u5gtE2Pryqlurh6aPssSZD6U4T4Nm+HdEhl+r+cU
 nmGTqs/imSjlBAOFGAo24xH4rK7xunK0t0vLv56CnJsHtpgF8TtNfioyzMALCtrY0l9n/2I7hPk
 biVsHelQGmSyvDH7+5uoedlJZUWj8hWLQpkIHUgapMsHYzYzfsTM0q/JDO4vdCRe3IWYUFU+b5d
 IMauShhSagkoPTz+QqvRmmAlZ4TN0L7s07i5ZzSF/fk1Vh5ZNMfJGRMEucpAYudwR2K9v+lmqyL
 XBkYDDvTAuczN/x+HFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160072
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

For now, we keep the global cpu_get_dump_info symbol defined.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/arm/arch_dump.c | 23 +++++++++++++----------
 target/arm/cpu.c       |  1 +
 target/arm/internals.h |  2 ++
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index 1dd79849c13..98eecf3d26d 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -385,21 +385,14 @@ int arm_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
     return 0;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
+int arm_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                       const GuestPhysBlockList *guest_phys_blocks)
 {
-    ARMCPU *cpu;
-    CPUARMState *env;
+    const ARMCPU *cpu = ARM_CPU(cs);
+    const CPUARMState *env = &cpu->env;
     GuestPhysBlock *block;
     hwaddr lowest_addr = ULLONG_MAX;
 
-    if (first_cpu == NULL) {
-        return -1;
-    }
-
-    cpu = ARM_CPU(first_cpu);
-    env = &cpu->env;
-
     /* Take a best guess at the phys_base. If we get it wrong then crash
      * will need '--machdep phys_offset=<phys-offset>' added to its command
      * line, which isn't any worse than assuming we can use zero, but being
@@ -439,6 +432,16 @@ int cpu_get_dump_info(ArchDumpInfo *info,
     return 0;
 }
 
+int cpu_get_dump_info(ArchDumpInfo *info,
+                      const GuestPhysBlockList *guest_phys_blocks)
+{
+    if (first_cpu == NULL) {
+        return -1;
+    }
+
+    return arm_get_dump_info(first_cpu, info, guest_phys_blocks);
+}
+
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     ARMCPU *cpu = ARM_CPU(first_cpu);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 81ec1ce21c6..7bf0c5e74f8 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2569,6 +2569,7 @@ static const struct SysemuCPUOps arm_sysemu_ops = {
     .asidx_from_attrs = arm_asidx_from_attrs,
     .write_elf32_note = arm_cpu_write_elf32_note,
     .write_elf64_note = arm_cpu_write_elf64_note,
+    .get_dump_info = arm_get_dump_info,
     .internal_is_big_endian = arm_cpu_internal_is_big_endian,
     .legacy_vmsd = &vmstate_arm_cpu,
 };
diff --git a/target/arm/internals.h b/target/arm/internals.h
index e849e357cfe..61b0bbf1ba8 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -438,6 +438,8 @@ int arm_cpu_mmu_index(CPUState *cs, bool ifetch);
 #endif /* CONFIG_TCG */
 
 extern const struct SemihostingCPUOps arm_semihosting_ops;
+int arm_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                      const GuestPhysBlockList *guest_phys_blocks);
 
 typedef enum ARMFPRounding {
     FPROUNDING_TIEEVEN,
-- 
2.47.3


