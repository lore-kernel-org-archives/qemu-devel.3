Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F20606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q+hHO2q1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ki0UX/t8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJaoS-0004TY-TK; Wed, 21 Oct 2026 14:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJaoN-0004RJ-KZ
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:13:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJaoK-000846-VM
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:13:15 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHpWjW2384364
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Kcq+sMUVu3TSI+TIkjMKcZ1YZleL8cuiiGwSc6BhC4c=; b=Q+hHO2q1cBroOnaB
 l+CTv4gYjeJyAI+OqNOEBWqBjNkae71WqWwVUerGdgKyGCRpkETwl0SdHS6aTfzM
 IDT878l6SgriXms6TtEh0iD3xgCzzxaQzk9/GDZ+kCmCR3kjKwFbzUBeejlk1fWI
 8OQcEvMgHVIAJNSpmZIVHFp1WeHHjK3+stQegUIjMzftX3fueGMIWYCoGYc5DNFl
 c8YSXIni1UA8o7IThiBWILJqHW6iLbFtgdVEY9QpbWZCiJZAgU/J6Mj+t3Pjcfun
 uH1SmZqt1XXNkog44fzaBFz5F6PMLtpLHXvPjZi0A5P2N0d3G4iGvCF9IRu2PRA5
 EH8mkw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0ke0jua-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:13:01 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ac575a9198so1665542a91.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792606381; x=1793211181; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Kcq+sMUVu3TSI+TIkjMKcZ1YZleL8cuiiGwSc6BhC4c=;
 b=Ki0UX/t8uq3ez8bXt00EuO2AKU7xYQ5IEQSHucWq9GiMB0+EsUE06SjuFOSby4uMCb
 R//d347H148tFhfEg/zZ0Ch4TBbGjlMAjaKT1AHJ6fKT+WYtHKNN8CfoqAv+3tLQfS4D
 h19JTmSQXH58tgt62X7+O1NusokM4qurJX56ANeBhn66j9bQfMunWf0jkYaiIxmWI3do
 1ZfLFgTH6fFzT8R43hc7T2lP//hUmOncO99WfRNWgLlWXuMbLGOJ7VPNqKm5u5+Y+ZZ2
 4lz3huQBxLZhXwFKgrD3gkBrg4g/DG486JteJb/ZHaZ8RXypoI9DtLdqE6+Cw82qPA3s
 XgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792606381; x=1793211181;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Kcq+sMUVu3TSI+TIkjMKcZ1YZleL8cuiiGwSc6BhC4c=;
 b=haLe0+RZvAHx8QVcGC0kQeAfTNpVrAcx6DEaucxjERH5hf7lz3/8BtFmn3eEfyYPp3
 LJF/tAcFtKM1XZdlNFWug+9Z2yrMLLKZ3x++6c+xWgc3xsWL4PRBFR7yKPzuLVYzIwZo
 f/vFHSkmyMiC17xN2oKSfHSuPylwa+BI+4HkXKRxx3b//G0wAEzMWG0VZbJoBrlp0g5k
 cNM3KrhmdhmGakMnrUsCTX4I4SvmS2GJDxobUsoQH/5Zap6jWGHQavlJ3xseZL4q7UKV
 T2s25YK3bPXJYlTh1caAHov7rYNPY7du9qBuaVEPqWfyp5GrLwEdEzDAXxQB0gM189Fb
 fQbA==
X-Gm-Message-State: AFq9FYKKFGUJzTwRI0bZDWX/ml0HEMlRhX/XG8VtBiLXu1hfa6yufPMc
 6AZWLaRyGNBJZ1mRv0Dn6xPV207T18qrPg+w3cfAQhV1TANf2haNpnn92aCEeH9s6M8WpMMP4i5
 YTPZmKDsoFfNPJ2IJc0RsZLPNrJeznEYlv2lJj1bnRE4D6PpIVp7Qe5gHKzOJn2SZ6g==
X-Gm-Gg: AYBFou1aOPtA4X3LFlbZjl7oafBHX1FV7xpzxKwyI6KmM6h1anLJ3mnYgV7+tPsf/jr
 IZm0kE9gu9Camw6gKxS73gfNxz8wOeSHMTr6Ta2Uu/G1hNf60Wn0Z6VQ6Bt1T/U+CkvJAaVOKDL
 fKuH5m6ZufzUu4tN/Cuvk4vVPdWtsVVBfoUwuRJH3fW864yFDhdKcNyIjbG5hXYkqimSYqdInpb
 x8fVw6a4BjAjOt5a20huOjnrNXkkPC6Wjo0vIKMyg/+dE01+Sx2OlzavMDxiLFK4I8d4PfN98u9
 TaDA04VTNUHjBFiao85YxS0N5YghxU1mQpymRsGin4L5xU7ClGn6AL3j4HJ6HEQBz3Xntk90TVa
 xifMRpFpSMO4B5r6G2zaEm+eWK4Wm5qLuflEMLuvg551H6KgP2zzPiJUSjhJ2zFk=
X-Received: by 2002:a17:90b:3a46:b0:3ac:9d83:885e with SMTP id
 98e67ed59e1d1-3ad87094657mr2237592a91.52.1792606380593; 
 Wed, 21 Oct 2026 11:13:00 -0700 (PDT)
X-Received: by 2002:a17:90b:3a46:b0:3ac:9d83:885e with SMTP id
 98e67ed59e1d1-3ad87094657mr2237577a91.52.1792606380159; 
 Wed, 21 Oct 2026 11:13:00 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada48ed74bsm499152a91.3.2026.10.21.11.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 11:12:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 13/21] dump: reimplement cpu_get_dump_info using
 get_dump_info sysemu op
Date: Wed, 21 Oct 2026 11:12:36 -0700
Message-ID: <20261021181244.867840-14-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UZnmgKZCapmykm3o36WB6itV2ILqhFhZ
X-Proofpoint-ORIG-GUID: UZnmgKZCapmykm3o36WB6itV2ILqhFhZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX0vwqRY7MOUwm
 897WrVdCqd/U/ddytDt7p0W7qnhJacaTg8oHSUmUGHKLTiA+SEiOZTYuXJKP71fqCfMsPcpRqtb
 M3HTltix11rcgKyoZb8HkMANyCvSYwQ=
X-Authority-Analysis: v=2.4 cv=KOzPn1Fo c=1 sm=1 tr=0 ts=6ad900ad cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=KrnFjeb05bSd2A7PV60A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX2S6Ajc5QoQ+h
 Ur9vNJQerS0fH835AWzD2ZmG/n8QOumyjZ4rxY6BFGt4uFJJx/6W8gMys8rikTcnSupxsbHhuap
 Ut5t/pLyscPIbwI7EWHNoTPsKprZHZ4Mvpjy0wKNKaJq/ueK8oK2J8g6HIhsE6/pRTIWzYWyF/v
 FociHEQpXmIme7uwEHY5mRKQBmHrKCxuOGgaf4/EpU63WQ1pzt8fnOYMiNWmI+LF6pY5XLe6BYH
 wUt0LTUPZ06AHl9POzXDBjO+ELZaX1/aWYmJSdonYBbAAcNDLX1erhSIvpPaC7QM88bMPmZOM4I
 KbroT00M2fXD7VpCHSMgfFnlRBMXY82MNfGtqFvZ6jdnZcgZNOdVfw7yTclya7BrSGfCIJSMqQ5
 UW9GpfRTCFJeDTLaGPX3qKzlp5SO4tjuf3I8dVPGpwIeQuM1Nq7xLMglIqsoNkm37T16QHiUTOA
 cgJ9RScy9zj+YJOy4Yg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210072
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

Now that all targets implement the get_dump_info sysemu op, we can
replace the per-target cpu_get_dump_info() implementations (and its stub)
with a single generic version in hw/core/cpu-system.c, taking the cpu as
parameter, like other dump related sysemu ops wrappers.

We always check if there is at least one cpu available. For instance,
machine null has no cpu present. Heterogeneous emulation is
already handled by the check above which disable dump.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 dump/dump.c                  |  6 +++---
 hw/core/cpu-system.c         | 10 ++++++++++
 include/hw/core/cpu.h        | 11 +++++++++++
 include/system/dump-arch.h   |  3 ---
 stubs/dump.c                 |  6 ------
 target/arm/arch_dump.c       | 11 -----------
 target/i386/arch_dump.c      | 11 -----------
 target/loongarch/arch_dump.c |  7 -------
 target/ppc/arch_dump.c       | 11 -----------
 target/riscv/arch_dump.c     | 11 -----------
 target/s390x/arch_dump.c     |  7 -------
 11 files changed, 24 insertions(+), 70 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index 0ecff682dd4..60ecde02173 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1793,7 +1793,6 @@ static void dump_init(DumpState *s, int fd, bool has_format,
     VMCoreInfoState *vmci = vmcoreinfo_find();
     CPUState *cpu;
     int nr_cpus;
-    int ret;
 
     if (target_heterogeneous()) {
         error_setg(errp,
@@ -1862,8 +1861,9 @@ static void dump_init(DumpState *s, int fd, bool has_format,
      * If the target architecture is not supported, cpu_get_dump_info() will
      * return -1.
      */
-    ret = cpu_get_dump_info(&s->dump_info, &s->guest_phys_blocks);
-    if (ret < 0) {
+    if (!first_cpu ||
+        cpu_get_dump_info(first_cpu, &s->dump_info,
+                          &s->guest_phys_blocks) < 0) {
         error_setg(errp,
                    "dumping guest memory is not supported on this target");
         goto cleanup;
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index a64e8c2b687..d04c6a2e6e8 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -130,6 +130,16 @@ int cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cpu,
     return (*cpu->cc->sysemu_ops->write_elf64_note)(f, cpu, cpuid, opaque);
 }
 
+int cpu_get_dump_info(const CPUState *cpu, ArchDumpInfo *info,
+                      const GuestPhysBlockList *guest_phys_blocks)
+{
+    if (!cpu->cc->sysemu_ops->get_dump_info) {
+        return -1;
+    }
+    cpu->cc->sysemu_ops->get_dump_info(cpu, info, guest_phys_blocks);
+    return 0;
+}
+
 bool cpu_internal_is_big_endian(CPUState *cpu)
 {
     if (cpu->cc->sysemu_ops->internal_is_big_endian) {
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 456154df6f6..d80a6a4e752 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -701,6 +701,17 @@ int cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cpu,
 int cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
                              void *opaque);
 
+/**
+ * cpu_get_dump_info:
+ * @cpu: The CPU whose dump information is to be obtained
+ * @info: Where to write endianness, class and architecture
+ * @guest_phys_blocks: guest physical memory blocks to be dumped
+ *
+ * Returns: 0 on success, -1 if guest memory can't be dumped.
+ */
+int cpu_get_dump_info(const CPUState *cpu, ArchDumpInfo *info,
+                      const GuestPhysBlockList *guest_phys_blocks);
+
 /**
  * cpu_memory_rw_debug:
  * @cpu: The CPU whose memory is to be accessed
diff --git a/include/system/dump-arch.h b/include/system/dump-arch.h
index 7165a5bbd03..eccf61dc3e1 100644
--- a/include/system/dump-arch.h
+++ b/include/system/dump-arch.h
@@ -27,9 +27,6 @@ struct ArchDumpInfo {
     void (*arch_cleanup_fn)(DumpState *s);
 };
 
-struct GuestPhysBlockList; /* memory_mapping.h */
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const struct GuestPhysBlockList *guest_phys_blocks);
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus);
 
 #endif
diff --git a/stubs/dump.c b/stubs/dump.c
index df7897b72b1..2ce3c5e274d 100644
--- a/stubs/dump.c
+++ b/stubs/dump.c
@@ -14,12 +14,6 @@
 #include "qemu/osdep.h"
 #include "system/dump-arch.h"
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const struct GuestPhysBlockList *guest_phys_blocks)
-{
-    return -1;
-}
-
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     return -1;
diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index 3ce6ba1d68d..6a009ae1a66 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -430,17 +430,6 @@ void arm_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                      ? ELFDATA2MSB : ELFDATA2LSB;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const GuestPhysBlockList *guest_phys_blocks)
-{
-    if (first_cpu == NULL) {
-        return -1;
-    }
-
-    arm_get_dump_info(first_cpu, info, guest_phys_blocks);
-    return 0;
-}
-
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     ARMCPU *cpu = ARM_CPU(first_cpu);
diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index ed273708c60..edbe99d3f51 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -428,17 +428,6 @@ void x86_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     }
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const GuestPhysBlockList *guest_phys_blocks)
-{
-    if (first_cpu == NULL) {
-        return -1;
-    }
-
-    x86_get_dump_info(first_cpu, info, guest_phys_blocks);
-    return 0;
-}
-
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     int name_size = 5; /* "CORE" or "QEMU" */
diff --git a/target/loongarch/arch_dump.c b/target/loongarch/arch_dump.c
index 0ab2df7fabf..853a60d7b89 100644
--- a/target/loongarch/arch_dump.c
+++ b/target/loongarch/arch_dump.c
@@ -150,13 +150,6 @@ void loongarch_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     info->d_class = ELFCLASS64;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const GuestPhysBlockList *guest_phys_blocks)
-{
-    loongarch_get_dump_info(first_cpu, info, guest_phys_blocks);
-    return 0;
-}
-
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     size_t note_size = 0;
diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index 2296a0c9e8a..86e31c65467 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -250,17 +250,6 @@ void ppc_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     }
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const struct GuestPhysBlockList *guest_phys_blocks)
-{
-    if (first_cpu == NULL) {
-        return -1;
-    }
-
-    ppc_get_dump_info(first_cpu, info, guest_phys_blocks);
-    return 0;
-}
-
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     int name_size = 8; /* "CORE" or "QEMU" rounded */
diff --git a/target/riscv/arch_dump.c b/target/riscv/arch_dump.c
index 4c442a78312..578435941de 100644
--- a/target/riscv/arch_dump.c
+++ b/target/riscv/arch_dump.c
@@ -180,17 +180,6 @@ void riscv_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                      ELFDATA2MSB : ELFDATA2LSB;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const GuestPhysBlockList *guest_phys_blocks)
-{
-    if (first_cpu == NULL) {
-        return -1;
-    }
-
-    riscv_get_dump_info(first_cpu, info, guest_phys_blocks);
-    return 0;
-}
-
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     size_t note_size;
diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
index b26f0ffe143..15299dd7a25 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -468,13 +468,6 @@ void s390_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     }
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const struct GuestPhysBlockList *guest_phys_blocks)
-{
-    s390_get_dump_info(first_cpu, info, guest_phys_blocks);
-    return 0;
-}
-
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     int name_size = 8; /* "LINUX" or "CORE" + pad */
-- 
2.47.3


