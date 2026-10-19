Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBC8606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DH/BpiYt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NCUluxL7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIutw-00038y-BR; Mon, 19 Oct 2026 17:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutJ-0002o9-G8
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutE-0006KH-7d
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:32 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJK4Vp549840
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=wZB40h8R7u1
 E6FkCfZNVQ5h7QUGf3h6U1J83cjn0+nM=; b=DH/BpiYtR25Sc3DR/J+yQa4LZXz
 kbzx2xs83k2iA3sIyqmeXSRJgLCHLO2o6u1k1dUc9jWanEHXNWDGgMVJGdmVYIC7
 JjWLeQ6XSDOjSJ62xuTbFnbYJK2vgETgfKs5de4RFQ9WH4pTp5DRcnWqwZA3Pelx
 6V6TOo09HZJYufG7nvgZ4kmMXbGzE8xKZTBR9xkoanw3YXeBlTVBnBSanJ3gJc30
 ty5XXRe/04XOTn+mtdbnMAlIGJxDY6vfenyxt5lFDdidX+AujSUuZ8d3OVQ93bHI
 jmDp/piEM6p/MoX3IZgv9QIVbBIMkz44j/Et2xLQspIkSTfPm2NCLBxvJ2g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf47kcr6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:18 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ac16335199so2848072a91.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445238; x=1793050038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wZB40h8R7u1E6FkCfZNVQ5h7QUGf3h6U1J83cjn0+nM=;
 b=NCUluxL76/sdJiF5oNz2gmzwDSWoWQUj/AVyX8gHUeqnwYS6+SfHV7ERU7aEkEANKE
 ZOMQWb4dGX2cHM86FMQTJQC1eDte9eA9luuDW8mHrtWb0kF341q4k1bo4Z3nsCOKeUz6
 fL2KK9sMB0H4WJ12/AcOlr4cPatDXhaEV1nddJ5baLqpaob47oOgBe4dodNTeJEXOhqs
 O59eMPw9htRehkaqB2QMwVIjnn2mLEvXR7bJvjh7S1QpV7uLBURvWkCL3ik/KM3FpbAi
 CuInvy1iSeKyD6xDVe4x/eS2yz8DbKJ8vWoyVhzWrPpOXtYEHMdDFXFX7hbY2JqoScbs
 9EbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445238; x=1793050038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wZB40h8R7u1E6FkCfZNVQ5h7QUGf3h6U1J83cjn0+nM=;
 b=0ah3RgvsqmQsR1WVY5nVlbnlS4sSqAOKHdRl3iy/bYSkVEeeKCAY0I3BahDPvBaw3e
 konBU66mIgFCWWxqpKWSH5KQCxZL4j0T1CFLCRko2lRfwFtzGaKJbweGxnjTvnFqvu7/
 7ZhC5vT/wi8A2SlB1rTfIcrLiikKBZL+S9YBqOVlWJdn3kjmMv2QP5IdqKlxD8g/BVYT
 u6lKORk026l8tm1FD/D/2NwuxbmiI7t5tuLCCLZBb2/o4gWEXXKXxY2qOEN5IdPTOnE0
 c5wt9KWQN0WIvum+Tvm/KBcG7ggUHoJQovbufR/HqKZmZrF16W2d6ZdOZAdFHNhJrfqT
 8S4Q==
X-Gm-Message-State: AFq9FYLLKXIwV99QyP3sAWMsBc5/ZKdnUDtfwhm3QFOKfpFTyhNr7MUX
 ZnKKQNIW7g+g0mxhzsXJgnFbddRcjKc+RYcYIUzQe2Jnv8erGVc54KtSWjyVrpVx/JIpfq4UZmC
 uma4GFd0pZwbEt2b1NHwJ8BMX8sUj+Ii3w3lfpAgTDkIyMOQVRY1qsutN6QqqM0KGJg==
X-Gm-Gg: AYBFou1dlEbP3kKyXsDNzHrOeHZZBEHr4l6nU84ecjyN4TjvXs4K/Ek6l2moEGhSdie
 t0EtVY+JUknIUpxFyX85wLU36YKOPMj1kde/D3JwE5TXyx5x4Dfdof3d9gXN8XhdiSf4aRwP+F5
 ubSvIkjA9NmSrDisF8YygH0Tt0S5ah5usCAcEUyhU9FAAvN5HEMROoAsXSRtq+wdLs7FIovlmeZ
 BSnEFwvJIBhu62ZMDSsDTTx2HdRvUSbWghk0+aZ4LT32+CskBFAPxuKotg33QAOr5VJ2d0rUtYw
 3MHO1L67b8pztT2UfaLOLSKgy2UTrNvtKTqHS8CiV+hjMRdwsEIwUNx63yMMn8Eca2EVgKQ8rzX
 MJjY1Y8pIejzVcQaK6xR8GMrnjena68fX9owph0dKDrtg4MU1g3OyJWFulzA55FQ=
X-Received: by 2002:a17:90b:3892:b0:3a7:250:333e with SMTP id
 98e67ed59e1d1-3aceefc176fmr8687983a91.11.1792445237501; 
 Mon, 19 Oct 2026 14:27:17 -0700 (PDT)
X-Received: by 2002:a17:90b:3892:b0:3a7:250:333e with SMTP id
 98e67ed59e1d1-3aceefc176fmr8687968a91.11.1792445236986; 
 Mon, 19 Oct 2026 14:27:16 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60f2c785sm867061a91.7.2026.10.19.14.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:27:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 13/21] dump: reimplement cpu_get_dump_info using
 get_dump_info sysemu op
Date: Mon, 19 Oct 2026 21:26:40 +0000
Message-ID: <20261019212648.154493-14-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GZcE2ixh8yhALsvHEJZ2lfRFbn_zCgVO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX14aVmwU3CtKq
 zpMzs8uiUl03mPxayaBRF6wnbs2m4layIq1oqUSNfQZ7hrrLDtgWAWQXy4V11Oo+A+B+Gv+qCge
 aOcUMnT+6wYjuF8qymJm4/CFhASZ96Gm0RBp4MsXBK2auQecJTjrHVPWlh+dMYcXBS/kmOycssG
 2UT26PpKg4nCbLK5aQAcNKEeQdIdGA6opZugWcjc2ZfKqgJUzqtzhYVf9txKEFmAdAB/lRBIGc6
 Yg04OVxLlz9Oz3UchGhaysq1YbK9XDVn0b6jRBDL9shU0rB9vphfTXpBhfDZutVpvOSz0qLarpS
 /yTZkNRadfiIHyeXdOfNu1J6ViIzf5uiBSLCs/L21nSzWGL5cQ3KBBrP64vNubolnZMnkm5h0lN
 su9TGLs/pBJfLrV8LdkIaHAcLWEp/SQLF4mACAIzSH5YIlYFEfPQ0TaQMi/3MMXNur5NqEQSTNx
 uEgqCEK9/4x9sVIQsNA==
X-Proofpoint-GUID: GZcE2ixh8yhALsvHEJZ2lfRFbn_zCgVO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX3AMNNutz6OzU
 6UEsyet+w5vGjPQvF4l3n9303dodEZoLIaCC6GcjKT09kxukKTzCXzvCoc6osrFKtfS4oh/1+zv
 wpmbztCqkZna0gWIxNcwcJ/Dg7gZVH8=
X-Authority-Analysis: v=2.4 cv=cLt1IVeN c=1 sm=1 tr=0 ts=6ad68b36 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=KrnFjeb05bSd2A7PV60A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190085
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 dump/dump.c                  |  6 +++---
 hw/core/cpu-system.c         |  9 +++++++++
 include/hw/core/cpu.h        | 11 +++++++++++
 include/system/dump-arch.h   |  3 ---
 stubs/dump.c                 |  6 ------
 target/arm/arch_dump.c       | 10 ----------
 target/i386/arch_dump.c      | 10 ----------
 target/loongarch/arch_dump.c |  6 ------
 target/ppc/arch_dump.c       | 10 ----------
 target/riscv/arch_dump.c     | 10 ----------
 target/s390x/arch_dump.c     |  6 ------
 11 files changed, 23 insertions(+), 64 deletions(-)

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
index a64e8c2b687..499fad1c68a 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -130,6 +130,15 @@ int cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cpu,
     return (*cpu->cc->sysemu_ops->write_elf64_note)(f, cpu, cpuid, opaque);
 }
 
+int cpu_get_dump_info(const CPUState *cpu, ArchDumpInfo *info,
+                      const GuestPhysBlockList *guest_phys_blocks)
+{
+    if (!cpu->cc->sysemu_ops->get_dump_info) {
+        return -1;
+    }
+    return cpu->cc->sysemu_ops->get_dump_info(cpu, info, guest_phys_blocks);
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
index 743916e46ca..b89e495661f 100644
--- a/include/system/dump-arch.h
+++ b/include/system/dump-arch.h
@@ -27,9 +27,6 @@ typedef struct ArchDumpInfo {
     void (*arch_cleanup_fn)(DumpState *s);
 } ArchDumpInfo;
 
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
index 98eecf3d26d..181691b81c6 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -432,16 +432,6 @@ int arm_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const GuestPhysBlockList *guest_phys_blocks)
-{
-    if (first_cpu == NULL) {
-        return -1;
-    }
-
-    return arm_get_dump_info(first_cpu, info, guest_phys_blocks);
-}
-
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     ARMCPU *cpu = ARM_CPU(first_cpu);
diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index d5016c198cb..004a639030e 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -430,16 +430,6 @@ int x86_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const GuestPhysBlockList *guest_phys_blocks)
-{
-    if (first_cpu == NULL) {
-        return -1;
-    }
-
-    return x86_get_dump_info(first_cpu, info, guest_phys_blocks);
-}
-
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     int name_size = 5; /* "CORE" or "QEMU" */
diff --git a/target/loongarch/arch_dump.c b/target/loongarch/arch_dump.c
index e216e906414..5a0e1742242 100644
--- a/target/loongarch/arch_dump.c
+++ b/target/loongarch/arch_dump.c
@@ -152,12 +152,6 @@ int loongarch_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const GuestPhysBlockList *guest_phys_blocks)
-{
-    return loongarch_get_dump_info(first_cpu, info, guest_phys_blocks);
-}
-
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     size_t note_size = 0;
diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index 7cb97082926..c70c2d0b125 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -252,16 +252,6 @@ int ppc_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const struct GuestPhysBlockList *guest_phys_blocks)
-{
-    if (first_cpu == NULL) {
-        return -1;
-    }
-
-    return ppc_get_dump_info(first_cpu, info, guest_phys_blocks);
-}
-
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     int name_size = 8; /* "CORE" or "QEMU" rounded */
diff --git a/target/riscv/arch_dump.c b/target/riscv/arch_dump.c
index 6562c32cfca..13aaa87202b 100644
--- a/target/riscv/arch_dump.c
+++ b/target/riscv/arch_dump.c
@@ -182,16 +182,6 @@ int riscv_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const GuestPhysBlockList *guest_phys_blocks)
-{
-    if (first_cpu == NULL) {
-        return -1;
-    }
-
-    return riscv_get_dump_info(first_cpu, info, guest_phys_blocks);
-}
-
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     size_t note_size;
diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
index 9a92efd249a..4301cf400e4 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -469,12 +469,6 @@ int s390_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const struct GuestPhysBlockList *guest_phys_blocks)
-{
-    return s390_get_dump_info(first_cpu, info, guest_phys_blocks);
-}
-
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     int name_size = 8; /* "LINUX" or "CORE" + pad */
-- 
2.43.0


