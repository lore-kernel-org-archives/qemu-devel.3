Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3484CCA462
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 21:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHT4Y-0005CS-3n; Thu, 15 Oct 2026 17:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4F-0005AU-0J
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:32:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4C-0002QJ-9O
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:32:50 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FKOW7b3462817
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=iCRqlkkzCYd
 dHihwP2PUyuFi4idMgYhU0tb6teY8yCU=; b=Vt7DQJut6h4jK8fMM/yrILVOydb
 mlUimwL8a+Bku19dY+0XcfZXTvrZ7SRSvNh9HDaDDwrLlDVMwRNRwaEKNNiP6l0t
 BFoi5sLrCm3Z0tug3chtzDzb1Xu71uU2eQO37HkaItOT4AFD1w9MfqUiGUFR8dXd
 COC5hsoSvZ2zA3+6/LCdtFW4F8+BPrm+9eCC6XcWVEd1LJxUhi3d4M0SbPgw4cYl
 CqHL1jv4CX9oDpmjEMX9C54W3Dsr2bm5BcCsHZ+M0seBLPXEt1UkbcgLwuYpe2n/
 S90BaxtjlNupNujJlaMW6mfEZ9A/WmnWqBaylpYlYrdYhRM0dk/RrmMDL+Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hayu69v4m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:47 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3a8ae5154e7so7575863a91.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 14:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792099966; x=1792704766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iCRqlkkzCYddHihwP2PUyuFi4idMgYhU0tb6teY8yCU=;
 b=eGigktY3dFq+ReCYlvwDFAhAbNyN60nx70ZyH0mVnGH1E6AV4Iic1RhsmVoR5KmnKT
 ningp8o3gmfHPI4z0TrqoykHiOO3S871pMf17sSo9sGijgWCmtCHkkajljmYjVYdS7Mi
 iDiYnI3SDHNAje4q0Dw4uV6wVCsYec9Qv+xiBHxI5oMYdHiKDw2EC+V6s6umISKljNnK
 9uSozVZlviNa6zd7hw4Z4/PrabT50eLQnXiXKeIo5zQ8fZqnZ4Qnm3gopd8OdRnpE1jT
 7Vq2p3WHVV/M0K7OFMgJ0f2ApFoOO00RbhC8EF2SKucrPHQyHBvd3IwF0oaF1sxQEsIA
 ou4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792099966; x=1792704766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iCRqlkkzCYddHihwP2PUyuFi4idMgYhU0tb6teY8yCU=;
 b=RbKEXjAYPOAuAhiLwB79HYZ9LJqeoVayMY5iyLzuc894z8R+Av3gsIjwZjvGvDhkd2
 2Ax37pQpIPVVT8jMD/dJ1SOpQtxeEom/gPsq6bVtUkruPZpDFHlLPku776qCUMazkiXm
 7HgAi2/Z88XW7dIwyUZGPXmSrzR8qf8V+vPDlutZOXGrIS4kNRNmj75PgIc5qrfbV8mW
 aSddIuBmwfgdo+FLxLUDu2gy3yMClpyX5V/s8lit/yRAZ9xcWe5Z0jTVTb7NdsG47w9E
 lqSTXcMA1wDB4iOeQqEMIqY3yEpkn86KWazOgJ8Qk607Pp121pWIopZaiwUsijQsn8fK
 /Btw==
X-Gm-Message-State: AFq9FYJlM8NfWKbzXKBB4i0UoiTvknA2QRhU2Bo0J4XrsWKhF7ZdIYtH
 VdvAL9KKSccP9IzLawlRWkO5aYMCCusGPSRn2JCeMf+bjWSk2MejQdnI+swQHBM8RxaygQCD7tK
 CMcDPgKluUl58xgdYfMaL/lzVGyLixHfM4CJQM9ckEggGtTTJXl48KjUz22a0RHiaKA==
X-Gm-Gg: AYBFou3u8/JzT8OBnk2d4lPmkQGebhaALKECQOANmIgPcAjLI9T7osjLToqGupzAZ87
 NxxtzOSTMmCEMKmwfLbaiSX344dvpLWsvWyxnyoVG5hlEZXfekmcgKMmeRuIlR951hbxgIRJ+e2
 ynVqX1H0f8zaNTV8J87cPb/IyA6S9B+1zjhq/muaxGHQaw7ofRmUirdwxMai+PubFCnF+Nk8nnc
 BfdDEPVwC2I6aBAKOtNjEjbSkvKykN94d88c3rBgQa2pkA+gUG9KsklwTbL3Sg78OtvVlYTKASu
 ROGo2YMcfg6kpHzJletz47+ZA1K/eHAiVvNDnHL1CUqCV1/4PWLvG6/wBrhhCu91kf+gjH1+qcH
 b8G5WR6f8/Gr8mtZKcWm9w/Rjqnc/WE8q90/5ItrvLT0NbnsLZV9FbLAaoUvxcWo=
X-Received: by 2002:a17:90a:51c5:b0:3ab:884b:659e with SMTP id
 98e67ed59e1d1-3ab884b6b57mr8971381a91.9.1792099966250; 
 Thu, 15 Oct 2026 14:32:46 -0700 (PDT)
X-Received: by 2002:a17:90a:51c5:b0:3ab:884b:659e with SMTP id
 98e67ed59e1d1-3ab884b6b57mr8971368a91.9.1792099965717; 
 Thu, 15 Oct 2026 14:32:45 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac940055f5sm5989362a91.0.2026.10.15.14.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 14:32:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, anjo@rev.ng
Subject: [PATCH v2 02/19] target/arm: implement get_dump_info sysemu op
Date: Thu, 15 Oct 2026 21:32:19 +0000
Message-ID: <20261015213236.157767-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2zHY1sfzdizwWCt4ThMcNssnC7_td1ma
X-Authority-Analysis: v=2.4 cv=ff04WEQF c=1 sm=1 tr=0 ts=6ad1467f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=jvuDXlCAtviyjr8SAjcA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 2zHY1sfzdizwWCt4ThMcNssnC7_td1ma
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfXyyXHOJe/hEAx
 g5BFFG4JBVTE4K6ZoWmuRiCmXldBM7sHwPfMCb3O41u1XtxUgy2jCJfvPCrunlwOWznmq/6VnfW
 TRUGnVRZ8T84DmRnxJTQdAnJsrBZ6giUuGnZg9JmmpYChZXU8TBhp+0Cikc3Tcowzi6WKOljzE8
 JW90VLR+hzRF94LAprgqaAUQG1UUaM86/eG72C5d5C5XghZ0YYcVNx/sYtSvkVYq31TwUY665nz
 OjHZ3zyv/aFZymUjhgOx/CrYDTGRpbVrEonaUNrUlVgxCW7yBxnVKV2aFSb8HvvQqiy4m1Udh7z
 jQ9mBwKRsaCY6kI+jBfpPxoeF/kMabQixBxVv0ZIgX0rsy02TMBL8v4p1J0Kw654AiJ1rwzThND
 ImUrlHQy6LRafz73CmuDMRaaoRcQ7VJAkU/tzjFl5U7gItX80gYijxCWXR1SWDQiwFK6k/QkI2E
 3x266rl2rB+xFFMu01g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfXyz6flZdPDs+q
 phsOOA3aTfKI8NIWwuI2QcF1xAS1Njrxs2YGa4TMZL21s59Egryw5HNF/JIvwK65O+1TJIG0hK+
 /2U3rz8arRfBMi2o+RA8ZCBIrSISGa0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150085
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
 target/arm/arch_dump.c | 23 +++++++++++++----------
 target/arm/cpu.c       |  1 +
 target/arm/internals.h |  3 +++
 3 files changed, 17 insertions(+), 10 deletions(-)

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
index e849e357cfe..086d9574ced 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -30,6 +30,7 @@
 #include "exec/breakpoint.h"
 #include "exec/memop.h"
 #include "gdbstub/enums.h"
+#include "system/dump-arch.h"
 #ifdef CONFIG_TCG
 #include "accel/tcg/tb-cpu-state.h"
 #include "tcg/tcg-gvec-desc.h"
@@ -438,6 +439,8 @@ int arm_cpu_mmu_index(CPUState *cs, bool ifetch);
 #endif /* CONFIG_TCG */
 
 extern const struct SemihostingCPUOps arm_semihosting_ops;
+int arm_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                      const struct GuestPhysBlockList *guest_phys_blocks);
 
 typedef enum ARMFPRounding {
     FPROUNDING_TIEEVEN,
-- 
2.43.0


