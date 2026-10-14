Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DCCCC6B2A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 23:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH8g4-0006yF-7H; Wed, 14 Oct 2026 19:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8g0-0006wd-4T
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8fy-0006Qb-Cg
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:27 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ENHkYx301147
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=J2rKJ/o1JlL
 +DZeRPL3RhhxRS4nD6/jovJ5uC/XT8ic=; b=d3QMQ2JCVdA7wBPhjo+zHTt+K4d
 9VsVi8O7lVEP1YaFTNTpr7yvD9Laww01/DcdZcOXC8w7In662QkfHZJlvlKqf2SK
 JpdLAHKWnT8AyPQsSgfXnxvI2zbQTaFhHzREOBuFqGTF4SH3JXhAOZB215uyvV+g
 Ub8MTuggFy2kGUJ1a6Nw2CmxPGSEuYIMwj3Tbf3/OpsRWlF5jebmwFHXTSVvks8Y
 hVCmo5Y0j9Flmh2/disS/wiDETSxMLV8yCxoqjXm1oh2g9E10REYgyh5xZaLL4N2
 Uz32o82yQSXWFsqjmtQFZ3vsEg3T1FXgFV1JSVrTAwYsNrA2Dge+V7qxr7w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha4623y29-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:25 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c0d568830so9544797eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792021584; x=1792626384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J2rKJ/o1JlL+DZeRPL3RhhxRS4nD6/jovJ5uC/XT8ic=;
 b=W7rN2F2+PWLjOelA/jtOLum/T66zz1qA7GB4LvtxEQYhaIYI14S0u57fDH80Dm53X4
 z9F3ZiYY/fcINPPcDHpZHxWVTkuBKV19BuCxyz2HNGp2zhbGmzNCyPgsLflIAHjD7SoO
 oF3xUDCz/XA/jMp9A2H5R0G9/bii7i62dF5XCAQAooMYAOhYQdaQqZtF1Hk8QRblfzzG
 GpxuNEsTQXZ9mXDWsKN7mk5YAft8L1S1SIwKiJz61QF/xtT/V73Hsna1OI0danQfqEO3
 TvOHkqVhJ9CFIxFDO/BzuOTt5m0Qpnnxf5O9PrK0WhDxoAG+rCIlb30y39OFNxVdbAGb
 pQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792021584; x=1792626384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=J2rKJ/o1JlL+DZeRPL3RhhxRS4nD6/jovJ5uC/XT8ic=;
 b=GWvOhcPX2rIbI3YwPU4rWWxX3evVhQMA3FtoJYIETgEXX7PASqKxJm2YWtR8GR5rGv
 u6m98ky/XZz1j82G/e0AOYT9BgT4og1xUwPeZLXeKdmLS7hPuAnbf1QcUcx/j4Gwtfaa
 4Is5RxHX3SRe+EHSwBJ2txU/ernjTryA4iloEusb5kAvqZ44rLeHeDz8QtyoMmdcRbwI
 hnCsT2ZZ65JX2Skp7FDSHU4LpB14YQbbx6zH3biNPBwAdg/2pV0dBtpBLXIoUWMt8hyN
 ZhPd2NjzvZDuB0NJuyNTBn2fYZrxuui+oIpeaHTkREG/kODSR0b8+o9M1dZN5EDNAga9
 Ejhw==
X-Gm-Message-State: AFq9FYJbmUv3qCOYRTSE0aKkNvyf0Xg24ITTNSQ58dDiYUW2npOzcc14
 fnt4ksipPHy8KbC3UqNK+DLQSW4kaSjTE/H80CUT7TV+FneAe27RN9SBqLLKgMclVY/cBR3uWUF
 qfkeD5NRcUFbJZOqk+s836Ng9SyfaGMH80pR7dPgNuf7PnXGxxn5jtS15sU4qgoul4Q==
X-Gm-Gg: AYBFou3rmmPLsTQlu+N1T+BgDcpsdYQ4Mwr//Qv5z4/MhWXhEzyHQgqYE7PnLQKhQId
 guUP8bAC94BntBu2PHwUAYo3J/uj2ObwjNDv5TtiNs18HLQO3OlazU1hA614YsuPFBUIE/tHvJT
 l5RWb6c4QEJqxl8AO9cstocCC6YcvU/xUbpOzaLKTBqQku32xVQlifbqWCz2LF9E7p8XreeVpff
 5NekdlLip0nTi0WUfCse6tQF52UqxwQ+mD4Ul926xRqSpHgRmxN5mpg7I8S10t8wB6fAba5QuON
 ZX5VLn91xENSzOkW23LPjuSxexoY4SkOrHPGmr8ZnQTMGAKVnU65Utibd/LrVACirSHhiJghIBA
 TWKj6KbCg/BDluPUsDGpRajSmB/54pbkfuOan3SdV7mUXwkPx4YmjR2z4XWrF
X-Received: by 2002:a05:7301:9a93:b0:35b:2d66:942b with SMTP id
 5a478bee46e88-35b2d6697d3mr12951174eec.13.1792021584028; 
 Wed, 14 Oct 2026 16:46:24 -0700 (PDT)
X-Received: by 2002:a05:7301:9a93:b0:35b:2d66:942b with SMTP id
 5a478bee46e88-35b2d6697d3mr12951146eec.13.1792021583433; 
 Wed, 14 Oct 2026 16:46:23 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358de54fe47sm42506147eec.31.2026.10.14.16.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 16:46:22 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 05/19] target/ppc: implement get_dump_info dump op
Date: Wed, 14 Oct 2026 23:45:51 +0000
Message-ID: <20261014234605.209084-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jmbNAt1z7rvvgXh35E6-57BFmLSnQAzC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfX8NWQtwwVAMcw
 yJLbTjsBsth/Wl0HEECImzs0PwpfQBttCMxHvQ/aLS1wcj6C4DMT5zFsOpAYykq+0JYM0xO/85f
 dgpHLGBl4Y0KNmZyxZAzBqOcenkcZU/SwbS6brTjnx34ux+nCOtbsyy8IGGlX26Rv4FbGX7gkTw
 H3kZxw2x/0VUwR8Y/Kxs4f+/57JjWZX1tTjF0rNrRpE98vqOdegwsYr8fmjCfxQRjNuWn0fvnyn
 2zdEs3Oj0pjaPtRPNsOI89fhT47wYwS6rGV/tPQSnkrpleJ3lW2+vcaj9YT4vU7StmzlB2z7Oiv
 06BY5KY6ltQyXNmT2grtMFBHb5rYbtVg08PxnSwrG2vpmX6IHsgVw/DtaKhKz6YHPPDr5c9iLbg
 2mACOWgCymk5XrVHlFbvDbVazIdZxzlFXg+ckYt6a3wvugqzL7P9qQOL3azdC1uR8GsbJ3X7qpe
 PmOauQ+uqGmW2RCVvIA==
X-Authority-Analysis: v=2.4 cv=ErZHPicA c=1 sm=1 tr=0 ts=6ad01451 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=ivC4dvb53ZzZ1fLKHQsA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfX9nHA0Q2h1IC1
 TKFnbca9dJntPQna8iImrzmf6fQWghvWvEwl8ZFLeEPwOiKUWL9HFlV1XIUffmWskeB4T23yrSh
 7eBeuvFYhsMLZNWeRHHuB4Lg/cDn25Y=
X-Proofpoint-GUID: jmbNAt1z7rvvgXh35E6-57BFmLSnQAzC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140094
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/ppc/arch_dump.c | 28 +++++++++++++++++++---------
 target/ppc/cpu_init.c  |  1 +
 target/ppc/internal.h  |  4 ++++
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index 80ac6c3e320..69613ce82a8 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -17,6 +17,8 @@
 #include "elf.h"
 #include "system/dump.h"
 #include "system/kvm.h"
+#include "internal.h"
+#include "hw/core/dump-cpu-ops.h"
 
 #ifdef TARGET_PPC64
 #define ELFCLASS ELFCLASS64
@@ -229,16 +231,10 @@ static const struct NoteFuncDescStruct {
 
 typedef struct NoteFuncDescStruct NoteFuncDesc;
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const struct GuestPhysBlockList *guest_phys_blocks)
+static int ppc_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                             const struct GuestPhysBlockList *guest_phys_blocks)
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
@@ -257,6 +253,20 @@ int cpu_get_dump_info(ArchDumpInfo *info,
     return 0;
 }
 
+const DumpCPUOps ppc_dump_ops = {
+    .get_dump_info = ppc_get_dump_info,
+};
+
+int cpu_get_dump_info(ArchDumpInfo *info,
+                      const struct GuestPhysBlockList *guest_phys_blocks)
+{
+    if (first_cpu == NULL) {
+        return -1;
+    }
+
+    return ppc_get_dump_info(first_cpu, info, guest_phys_blocks);
+}
+
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     int name_size = 8; /* "CORE" or "QEMU" rounded */
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index b711f9c0a85..53bb5f1bc52 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7537,6 +7537,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, const void *data)
     cc->gdb_write_register = ppc_cpu_gdb_write_register;
 #ifndef CONFIG_USER_ONLY
     cc->sysemu_ops = &ppc_sysemu_ops;
+    cc->dump_ops = &ppc_dump_ops;
     INTERRUPT_STATS_PROVIDER_CLASS(oc)->get_statistics = ppc_get_irq_stats;
 
     /* check_prot_access_type relies on MMU access and PAGE bits relations */
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index a20a0f9f7e0..c890a596085 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -324,4 +324,8 @@ static inline int ger_pack_masks(int pmsk, int ymsk, int xmsk)
 TCGTBCPUState ppc_get_tb_cpu_state(CPUState *cs);
 #endif
 
+#ifndef CONFIG_USER_ONLY
+extern const struct DumpCPUOps ppc_dump_ops;
+#endif
+
 #endif /* PPC_INTERNAL_H */
-- 
2.43.0


