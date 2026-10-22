Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5C1606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 22:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kTcuHb9b;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FBdL+jOW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0nY-0001sm-Qx; Thu, 22 Oct 2026 17:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nV-0001oU-B7
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nT-0000Im-6D
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:05 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtJRr861104
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 So3eS3ojTvij1FP3BADDLPesD2MmzaCxOK4Rlhd8KIA=; b=kTcuHb9bJnHhe1/I
 4s8NxCOhYKI3a7AYG0d4DaQzhleyPneh+stikptABvqDaogTU7ZwLgc0KOIOU9Fn
 +9U/j1+h2rTRi7V7sJOcQqsSPAxXiLhh/8OZKgG460w+bVtfoIOnA4R/3sE6TD9J
 TW1BJiCervQ57jEgAqthEAJqTPcpq8z+PTgEN9d8LSu5c6LLPz07+9YC2ATy0tcS
 knP10Fzcsl1cJF1vDuue0yhrg3tkO2W8tFUAZpWjWXdELxoSMjQaAuLGAou6B9K5
 WTJzwddxu4SN0+u2SOztz0yGeMrSpKX8zzpvxTCPbSekxlFBOAftGfsm/b4DgmWl
 EiC9Og==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnq0ha4n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:02 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cd60a365440so135932a12.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706281; x=1793311081; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=So3eS3ojTvij1FP3BADDLPesD2MmzaCxOK4Rlhd8KIA=;
 b=FBdL+jOWt4QxrdfBIPI9gbLd5lKW3i0mmXLx6B0kPP+wWY/djTBRRpkAOFOD6OpZVL
 /LeoT2p/YOh9/pxhvHvof3RdAowRPMUdbHGj15EpESf3sBt1iHu5RUwaUzW9AE/gVjHl
 0mcXF4Czei4YSH+BvMUx48LUZgYdSAozo2oQ9SS06tOSemJEOIwfEHTb7K0lnLC6aAne
 3OmbEAn3L7Onms6mY6Z2pDDQNf6hFMRZtcKdBBDeZyDPjC8z8MSxKdpItgZq/Vj26yP0
 jN6RntDHKcZiC8dqGFDz7Q32jAXpV/f0tE1EZX9vO6B1gUV0Uw4RPL+fBB9TxqYKVzN6
 6J7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706281; x=1793311081;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=So3eS3ojTvij1FP3BADDLPesD2MmzaCxOK4Rlhd8KIA=;
 b=i93rYRmwaGbf1XCRSYK4D6jLB7AeZfEt+GFRBw6bPE7i2sqDRK8De3ANsxixyTsTB8
 3dN4DNsX5vfxDOvUaK18g8SbaVLt8TlHCZ4HBjGaSrE8snKU6/2em9RHAyRNjumpHQGL
 o/xFZTGrsrnnjWVgxIF51p9sfieSVhLZJMP42ba53UbujyWEiJwLOls0Z0V+WMhVaLW/
 jDYrFAvh6ZbQ7Fu4y/ste9A+jq7ZIpdjFJGF+6b/ZSyqmBngy16vtYbcndGtJoOnu9p7
 7IBwc+Hj2yaXiEYP/avCMhdL1UpOmWQIWaUCwPqYGuV1LVVOySoJTQ7cde8w6i+tupfP
 HnNQ==
X-Gm-Message-State: AFq9FYKWM/9JQ6iQHpv5CFd9dpUplnxvpSwYzgGbPJko8wVDfNMDemsk
 gs1SQ6B8ggNmI/xRl2hXvOvBiC3+ij/OfAqE4HDlA58eqHM7bETtmN8+BLM+GoTs7Ct+grirb5w
 M0JczwzLV5AjMxDEwfdM7y2Uckxv6QDRRlr81jFw1/fAc7zW8jHuQ9rtTjRibPpCe1A==
X-Gm-Gg: AYBFou2tQS0W5/znm8zj8M9wjxTImlEkdqPKRFtBAsKIKyExwXGBO1sQTdQMf8/NRpK
 eaqIGNlOL01/8Ebi7nDi+CO9fJx9mXsu3QhcV9LALDsycDTSwukiMGglGAsmD05c8XU+k0EuzO+
 Pamrgj5mFFSUdudyJFWXyE1FwNVghi7GI7RU4TZTmata9vCxq5c0ih2Cyh5SubFCH+Kd0DO5fwF
 Mt2EI9eSYIuONDuhXMhikeuHZVdScBPKBwkEFTT0u6uEANtLkkqEybUyLAmSRT5o67oz7LCTPv1
 6Yy4YwK6BrB1+DEk4/BLEfFnglcZNZqyqkL8nJZaLjy6qqHNQfI7yqLMNGgc06bCCenGKq5pBoQ
 grAbcfZuY0oHHneDWF89XX9kewmYhevOVoTUBVmtLcG2ioGY2z5lE39y3Wu3jS68=
X-Received: by 2002:a17:90b:2f4b:b0:3ac:7c52:fb04 with SMTP id
 98e67ed59e1d1-3adce7b5285mr130912a91.44.1792706281107; 
 Thu, 22 Oct 2026 14:58:01 -0700 (PDT)
X-Received: by 2002:a17:90b:2f4b:b0:3ac:7c52:fb04 with SMTP id
 98e67ed59e1d1-3adce7b5285mr130903a91.44.1792706280637; 
 Thu, 22 Oct 2026 14:58:00 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adca62e477sm648061a91.2.2026.10.22.14.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:58:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 13/27] dump: reimplement cpu_get_dump_info using get_dump_info
 sysemu op
Date: Thu, 22 Oct 2026 14:57:32 -0700
Message-ID: <20261022215747.2479440-14-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0Dap5zBvFf-MiLA2IWPQkNAJDSaLM5HE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXx6O/ckOJgxUu
 uHtWsdZTkNd9M5dsap5/qaqAOWgXt3rUPDJTdSj9yDpCcdu1dMPjNcN5yb7EGgiD74iWvWExiNA
 Vn29FAotk6SqG22HmQcFOfh9Uhzj7wHc0j0nEtRni5YXGAkHMTfqahIBt+hrgRI1fXIfkNjvFy2
 f2NrFYXtnYFU5SpLZKHRIBWhua868I/3OYt8KpQ8RJzfpWlAtXSw6lprR5NZ4uPDh9XsHykj0QC
 NcEpob9slwyRSkvGp0BrVUmE+VzqDO1ez9XaRhwswpP9L+TmCF6N+B/YWCHG9N9N2QMDUAhNiFn
 oiuMsYy+x/PU+XiMdRxtNay26bWQqOM5MaJ5Spkww4yGmN6pB9E4McncbZ4Q8qJfS+5PD0S3CYJ
 YZz4Eb7d2z2sfGwyBrW3tKx2FmKVnUNocDdq5ShznUC7/1+SV1wd6594fK9c2/RsJumVTi6wx4V
 UWlkNFzFT3Z5+t80D6A==
X-Proofpoint-GUID: 0Dap5zBvFf-MiLA2IWPQkNAJDSaLM5HE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX4Gk8BZMwy0mv
 5XWURa3SS8d7X1t70faMAFa9FHl7DdapdFhMuyffJzGuKl1KrJ0kPJ1T1109JG7tyQBySC4bbK+
 WLuIzXynx1b0GCXM8U9M71AVhA8AbM0=
X-Authority-Analysis: v=2.4 cv=UaHE26SN c=1 sm=1 tr=0 ts=6ada86ea cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=KrnFjeb05bSd2A7PV60A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
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

Now that all targets implement the get_dump_info sysemu op, we can
replace the per-target cpu_get_dump_info() implementations (and its stub)
with a single generic version in hw/core/cpu-system.c, taking the cpu as
parameter, like other dump related sysemu ops wrappers.

We always check if there is at least one cpu available. For instance,
machine null has no cpu present. Heterogeneous emulation is
already handled by the check above which disable dump.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261021181244.867840-14-pierrick.bouvier@oss.qualcomm.com
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


