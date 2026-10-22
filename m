Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6469606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 22:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pz6Hwj2B;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BYwngalG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0nv-0002Mr-0d; Thu, 22 Oct 2026 17:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nn-00028Z-Au
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nl-0000Kz-8o
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:23 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtMCG861122
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k57FEczv4f3kffgchstOAbae9IFWMFq+CCHW70t44/o=; b=pz6Hwj2BXNDZw03M
 xVLiZhmGAHX4dn41QxiUQqIpPQHW8/33sE5dEIcHkhMWs5n6jacv8CL5fZb+wh1J
 Mzc03WpqBw+08KWldrJTL6yqaDD3gb3odVwYjgfmg1Ckz/rji2Q98EW27zNkT/nL
 iGVaxXVH7bSF1dpthFRcbvOqbe54VJzoTtHY7JM/LZPMQ/eScOp9rDCI4nexd2Lx
 nOyHylxgv6tziyDRN3mTMT2ihBLqUvyHHZqjeHASwPA/jqeXbqm+mINfsify2Dbn
 Jnngkm9VM7ZySF5DgxlQ3QVSFtMRAWWGTBwIuG/OD7yrOxe+jLzN9RT5FZcfyC9X
 zZwROA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnq0ha4x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ab868fe362so346269a91.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706289; x=1793311089; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=k57FEczv4f3kffgchstOAbae9IFWMFq+CCHW70t44/o=;
 b=BYwngalGQ2gDXIac1oaQ5ARhQLkBVpyBuLqUZHnvEeiqxc0c76FuvxnHp2bhIuAk7f
 l09FIeMKDPEgRPn4s+xCxO7OyR+g+YSi9zg1J2FopC1CHDjo90mLlweJqpr7djxJbcqK
 32TZziScWDfkIp1S2TbRTDD/YKWN3ADs8QjFXb8mwHVVjUZFqPq8G88zF4If3RzGVfb4
 C1LiUvKFCUHFoyX8nrjnIaXNd+s2EBd68W24tnA0n/iymYDjBYMI3vyxs3uodIuORfFO
 2Qe08Wa0dTNgxEO/YEk4v+cFs4M3TekVal54UYNm5VvegKFn3eE7xldtqwurhydgRs8s
 xmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706289; x=1793311089;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k57FEczv4f3kffgchstOAbae9IFWMFq+CCHW70t44/o=;
 b=pP+51lY2TreU0dceImN7CZPMdJIedU75tyK2JSh97vXmlu8y0NQSJvEnYEhDqSdCBd
 BSVPeOuE2ObZc32IMDOgkuQDQ9iWTgQwYqzsuiNmvO5mHoI+IoYEZngdIuf7gylMABHT
 LbMZKFHzeIrNGpJoAqW6/opaXOkyRpEDSI2SkCqrbhFOuvlyYuFAPPza44jS87FtDRuX
 kkctglFaqpab3cOqGOIYmpfyS300kTF/KJiyW0k/wRRI8c3YWpcRrbnJTe/XKDa0Z04Y
 eaTRmoDwIqE6XqUzc7H78QOTOoCAsqUqgi9YiyweZ24/xjS2rnf6EytJHiaJ3oQS49nE
 cTgA==
X-Gm-Message-State: AFq9FYIZMy8SvohhIWZoUckHwRo89qA0LDHK9LghDEf8M80uPDJdVFAh
 KI/SPgUvEboI58Go+xEHHij5OUms7356O7JutIMHEzPVkOP9eNTDq/HmGHScfdPZAG3DZBPiHWQ
 8+FfFc/eE5GKmZXWkLHfHWa0wqlQway3qhBWKMzVwoGOABd1lhkTlqUDNENPCZG2NIg==
X-Gm-Gg: AYBFou2Rd1WQxm7KS16aSgCS9GpL5om+7nl2NRzhIjx/in2jktEh5fxECVlByp1hzm6
 vcwIIujaUdanD0g2cX4gTEta1BkuMBy+UURhS9wDb7gChUNs9u8xO7oV7vV25sSG0BMAs+gM1Lr
 4+5wI925M4mSyH1+Aicv3XNRBCGPYoCIvzujIm59YSt7D7Xp9MMWfRkKG8BLA2oFnr6A/mNuKWw
 tZK218JnmiSXovS0N/VGy1d6Qk3NyxeIEFk2J5WdF4IAiMz6MnNLCy2MN6aaIoSDtyyPCOzffnG
 Yyi/1XrG/g/fL+atnK0FyYHS2CpnCXeJaJJUwYxtwB1NKgshIyM0Va3XrRlNuBTV6fPJcPDAxLQ
 TL2xa+JG/9d4L72gqtDqbvt+Gx5gTdu+e8GT+6IJi16sLhO6dzXcn3mm7WSoZAHs=
X-Received: by 2002:a17:90b:5863:b0:3ac:4e18:238c with SMTP id
 98e67ed59e1d1-3adce48ba46mr144902a91.49.1792706289227; 
 Thu, 22 Oct 2026 14:58:09 -0700 (PDT)
X-Received: by 2002:a17:90b:5863:b0:3ac:4e18:238c with SMTP id
 98e67ed59e1d1-3adce48ba46mr144894a91.49.1792706288665; 
 Thu, 22 Oct 2026 14:58:08 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adca62e477sm648061a91.2.2026.10.22.14.58.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:58:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 21/27] dump: reimplement cpu_get_note_size using get_note_size
 sysemu op
Date: Thu, 22 Oct 2026 14:57:40 -0700
Message-ID: <20261022215747.2479440-22-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: R2qEJpMYo4PTcG8jSIS9mb4ObgipIqFj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXz8bWYKwy2IFE
 9VuDRgUaGbe5qe8BXnvxYdf19NMA37HRFVXFrhLnbrpX1l0egkwS/jgFRdbCi2bCO7KvgIKcMLL
 qGJYcgR+jwJMZafyu4V/x2/Ye+7WIks++W0QGpNEEGbsldRG1nqMKWbiJShhlSO422NplEneMDR
 gWuImmYz+QZTjGuo4ykIFREBDB/4hhKRlaoApTGwITDRMauENJcoUoGnZGdI/Q8nGcfFs0Vw1hX
 nAghH3eeqIgxXoi7igXKRNiSJ1pLheDLgU67cT38OH06+tgafUR8BcWPKJyFLmOZTNkoKPxSEiY
 fs2dFImoHqL3jLBavcvmLyi51Od7uRcFGl5r/qXPGs9BrtWDWyQTHTZ7bVUiJVSW0p5BZm0NSa2
 rpSUl+ZDmxzIs72SUJX6amPFY5RpbHjVjb1s9A+09Znp/5f5Xes1kO8AnnGuj8LNlJyrmGUEgN4
 UbZb5aPsG6YgUXjbqHg==
X-Proofpoint-GUID: R2qEJpMYo4PTcG8jSIS9mb4ObgipIqFj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX2oTkPBRSOM2f
 VTlf4lreXL63e73dq8NVVS1L+KUD40NDgEvkID9uLof/qjErJdFchKTpzIqfdWpBP9aTZEQMmVl
 FdT8fXz6omrX2uZA4lbukHh4dIU2luw=
X-Authority-Analysis: v=2.4 cv=UaHE26SN c=1 sm=1 tr=0 ts=6ada86f2 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=omOdbC7AAAAA:8
 a=3kt3mrAgU2v5JAFOdb8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
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

Now that all targets implement the get_note_size sysemu op, we can
replace the per-target cpu_get_note_size() implementations (and its stub)
with a single generic version in hw/core/cpu-system.c, taking the cpu as
parameter, like other dump related sysemu ops wrappers.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261021181244.867840-22-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 dump/dump.c                  |  2 +-
 hw/core/cpu-system.c         |  9 +++++++++
 include/hw/core/cpu.h        | 13 +++++++++++++
 include/system/dump-arch.h   |  2 --
 stubs/dump.c                 | 21 ---------------------
 stubs/meson.build            |  1 -
 target/arm/arch_dump.c       |  5 -----
 target/i386/arch_dump.c      |  5 -----
 target/loongarch/arch_dump.c |  5 -----
 target/ppc/arch_dump.c       |  5 -----
 target/riscv/arch_dump.c     |  5 -----
 target/s390x/arch_dump.c     |  5 -----
 12 files changed, 23 insertions(+), 55 deletions(-)
 delete mode 100644 stubs/dump.c

diff --git a/dump/dump.c b/dump/dump.c
index 60ecde02173..23ac689907a 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1873,7 +1873,7 @@ static void dump_init(DumpState *s, int fd, bool has_format,
         s->dump_info.page_size = qemu_target_page_size();
     }
 
-    s->note_size = cpu_get_note_size(s->dump_info.d_class,
+    s->note_size = cpu_get_note_size(first_cpu, s->dump_info.d_class,
                                      s->dump_info.d_machine, nr_cpus);
     assert(s->note_size >= 0);
 
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index d04c6a2e6e8..03800cd719b 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -140,6 +140,15 @@ int cpu_get_dump_info(const CPUState *cpu, ArchDumpInfo *info,
     return 0;
 }
 
+ssize_t cpu_get_note_size(const CPUState *cpu, int class, int machine,
+                          int nr_cpus)
+{
+    if (!cpu->cc->sysemu_ops->get_note_size) {
+        return -1;
+    }
+    return cpu->cc->sysemu_ops->get_note_size(cpu, class, machine, nr_cpus);
+}
+
 bool cpu_internal_is_big_endian(CPUState *cpu)
 {
     if (cpu->cc->sysemu_ops->internal_is_big_endian) {
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index d80a6a4e752..a3b4c6c08a7 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -712,6 +712,19 @@ int cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
 int cpu_get_dump_info(const CPUState *cpu, ArchDumpInfo *info,
                       const GuestPhysBlockList *guest_phys_blocks);
 
+/**
+ * cpu_get_note_size:
+ * @cpu: The CPU whose memory is to be dumped
+ * @class: ELF class reported by cpu_get_dump_info()
+ * @machine: ELF machine reported by cpu_get_dump_info()
+ * @nr_cpus: Number of CPUs to be dumped
+ *
+ * Returns: size of the ELF notes needed to dump @nr_cpus CPUs,
+ * or -1 if not supported.
+ */
+ssize_t cpu_get_note_size(const CPUState *cpu, int class, int machine,
+                          int nr_cpus);
+
 /**
  * cpu_memory_rw_debug:
  * @cpu: The CPU whose memory is to be accessed
diff --git a/include/system/dump-arch.h b/include/system/dump-arch.h
index eccf61dc3e1..86b9ae15b6a 100644
--- a/include/system/dump-arch.h
+++ b/include/system/dump-arch.h
@@ -27,6 +27,4 @@ struct ArchDumpInfo {
     void (*arch_cleanup_fn)(DumpState *s);
 };
 
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus);
-
 #endif
diff --git a/stubs/dump.c b/stubs/dump.c
deleted file mode 100644
index 2ce3c5e274d..00000000000
--- a/stubs/dump.c
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * QEMU dump
- *
- * Copyright Fujitsu, Corp. 2011, 2012
- *
- * Authors:
- *     Wen Congyang <wency@cn.fujitsu.com>
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- *
- */
-
-#include "qemu/osdep.h"
-#include "system/dump-arch.h"
-
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
-{
-    return -1;
-}
-
diff --git a/stubs/meson.build b/stubs/meson.build
index dcb67ce5295..4a26f795a6a 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -71,7 +71,6 @@ if have_system
   # adding more of these.  If the symbol is used in specific_ss,
   # in particular, consider defining a preprocessor macro via
   # Kconfig or configs/targets/.
-  stub_ss.add(files('dump.c'))
   stub_ss.add(files('cmos.c'))
   stub_ss.add(files('fw_cfg.c'))
   if igvm.found()
diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index a09f7c59db6..01fb2942d17 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -451,8 +451,3 @@ size_t arm_get_note_size(const CPUState *cs, int class, int machine,
 
     return note_size * nr_cpus;
 }
-
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
-{
-    return arm_get_note_size(first_cpu, class, machine, nr_cpus);
-}
diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index 270adb04468..9e39fea84c0 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -459,8 +459,3 @@ size_t x86_get_note_size(const CPUState *cs, int class, int machine,
 
     return (elf_note_size + qemu_note_size) * nr_cpus;
 }
-
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
-{
-    return x86_get_note_size(first_cpu, class, machine, nr_cpus);
-}
diff --git a/target/loongarch/arch_dump.c b/target/loongarch/arch_dump.c
index 47036105e0a..1e2d8eba85e 100644
--- a/target/loongarch/arch_dump.c
+++ b/target/loongarch/arch_dump.c
@@ -161,8 +161,3 @@ size_t loongarch_get_note_size(const CPUState *cs, int class,
 
     return note_size * nr_cpus;
 }
-
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
-{
-    return loongarch_get_note_size(first_cpu, class, machine, nr_cpus);
-}
diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index 42e5cf936d8..bbfb6674bc3 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -267,11 +267,6 @@ size_t ppc_get_note_size(const CPUState *cs, int class, int machine,
     return (elf_note_size) * nr_cpus;
 }
 
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
-{
-    return ppc_get_note_size(first_cpu, class, machine, nr_cpus);
-}
-
 static int ppc_write_all_elf_notes(const char *note_name,
                                    WriteCoreDumpFunction f,
                                    PowerPCCPU *cpu, int id,
diff --git a/target/riscv/arch_dump.c b/target/riscv/arch_dump.c
index 06b66a56855..19222ae18b4 100644
--- a/target/riscv/arch_dump.c
+++ b/target/riscv/arch_dump.c
@@ -193,8 +193,3 @@ size_t riscv_get_note_size(const CPUState *cs, int class, int machine,
 
     return note_size * nr_cpus;
 }
-
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
-{
-    return riscv_get_note_size(first_cpu, class, machine, nr_cpus);
-}
diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
index 5092835afc3..965ed6be39c 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -495,8 +495,3 @@ size_t s390_get_note_size(const CPUState *cs, int class, int machine,
 
     return (elf_note_size) * nr_cpus;
 }
-
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
-{
-    return s390_get_note_size(first_cpu, class, machine, nr_cpus);
-}
-- 
2.47.3


