Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3603606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SDLAoKy0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kBHh83Mf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJaoN-0004RH-Ds; Wed, 21 Oct 2026 14:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJaoL-0004Ql-UZ
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:13:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJaoJ-000856-Tb
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:13:13 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHpLZF1135924
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oZ3DN0XzHS5CgC6CedL2s1HAxBRsMBT/udd8AKrT/v0=; b=SDLAoKy0orQV59Dz
 qchdXNcCwxZln5l6sJYjMyNOWUDgzmZGwJYxHfueCayk44RqA4ZMWMTpeO1e+xqY
 T6O6d1UL09+OSXqWhqMpV/t69O0v3mNWj2DlB/Yx4BsG3NXmtetUzw9zLlE8ccLF
 sEkCqxMgG0bNNSn0WldfKePnKO67YalDm7MWNZvtMbw4MnyJUGg7dAHPwWQGG+h0
 pTHclwoVAa6Uvfrr3qKov8/CA3QWZ55oldb9ds/ltJWGiGykl0VnGi6EBvdP3SDs
 G0fxsXwr+Bh+UkWmGW5IS3Xhx1EuJWJreC8zoOTg7mKvidaFtf1lJjJplWXYyxdh
 +qslmw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0k2gj90-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:13:10 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ab67ff8ec3so790258a91.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792606390; x=1793211190; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oZ3DN0XzHS5CgC6CedL2s1HAxBRsMBT/udd8AKrT/v0=;
 b=kBHh83Mfyu3sb++vtdNA9UmVGXjH7xtXNXMgRlPh8KYPpZUnsSS/Pz7XVEl6eHl2sw
 YXgnH5xo34DLRezq5LZxfxg1MRKsuixLJOChpnX5qurqIKYaWEMB/Ik6W3QDrgrYlEHp
 BZVGamohUDrahnnbo9mmvkBEK+zUFIfL6tpDwokwKHuiUyDh8BzTMXluw9nTZufXwGyv
 hYazkkYDXU3Od7XfYc6TXzLWVIXUNC1ty68Jw/vDQeiuj/sLLBPHvB1IvHNwwdQvy9rn
 wEuVEf3w/oGu2xBqrW+QaWPmuqySD1jjIhAIyOwEqY90jZxyYLxvmy2YAUyh+7Qu5DoV
 QGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792606390; x=1793211190;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oZ3DN0XzHS5CgC6CedL2s1HAxBRsMBT/udd8AKrT/v0=;
 b=ZVOAJkofs21OXXC5BGM4tqRwCHYFUfM7lloFyINDVG6NKDTbH+nAeGwFproqhDWtKA
 M44TIz/5PxD2LdyeC3fI5zusQRSZFDr4Nf/Q1fk811tvnjJlBmsEu9XWy9iZlSqgH8Vk
 EpsVPE0Jqi48Mn5A05og4nnoX+o5HRzQ4PDORwnVp5Y67HHevHg2p+I/bdUmf2avQK4s
 s6NMIynQiZFvDQePTRr6slTmBhAIL12nNjbTENul0DwaOeGZSzfFjdMzTQRzfFR58I7i
 6ICdvQQGLaUHTRHEZsManzzv1y/zOYIzgSEA85XwPiTfDNl2B385gW86UOKX8es8H6kj
 lzPg==
X-Gm-Message-State: AFq9FYL6S2DegZp/wyOUv33XiktUlNncyASATIhjgE6JKhstKaXkJh2X
 tXUmeaublUYgAoOhV5QJqPwvgNh2Js+LgSQVCrnc7ClLRjkoS5kogW9c7f75i5mqEGMEkIyLULE
 HRHN2sGuFY2TMOigtnnxEzw0xTdovXj11HlCa+a/3VG+UT0dx7kQ9MWC6F36Gks+SQQ==
X-Gm-Gg: AYBFou2qJIy94CuTIUPm2+HFtNryXFn4Fdk1GjDXcK3gClTMB2f8TA2ih7WlJ1hPcJl
 IrJtkx8w67NSD7hQVU3wjgkOyGueYLM+DYdZAZFrak7UtSTqCQV3w5dij/9a1k2drP9fnCLKxn/
 tT7MWLsdYVYXrvCf8klg6T9CyuyT4jbpeBrWnyLhzeP8MveTVCX7GOmskvAJqUq5XmgIedwe3Vk
 ip8xiZiuTD16FWvMNPxSfy1yIORFJCblGtFmOF9sOE6aPEzIMqge30cSM983qdFjWsFb5V8ihz4
 u63LVPqB+MOEtRmnmJXf0zk3o8jPhYgfaJtP4/x/rs47UlWIkzYUCNem8W1oOA7n9RBMWInbyIo
 NgIKtjOcVjCiWKZQpYYoZsDKAGtkE6odqUsozAtx8qYhn3pOVCaJlSsdZ1YU2oPo=
X-Received: by 2002:a17:90b:4a06:b0:3a0:b312:1fbe with SMTP id
 98e67ed59e1d1-3ad86d1d13amr2454789a91.23.1792606389771; 
 Wed, 21 Oct 2026 11:13:09 -0700 (PDT)
X-Received: by 2002:a17:90b:4a06:b0:3a0:b312:1fbe with SMTP id
 98e67ed59e1d1-3ad86d1d13amr2454760a91.23.1792606389144; 
 Wed, 21 Oct 2026 11:13:09 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada48ed74bsm499152a91.3.2026.10.21.11.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 11:13:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 21/21] dump: reimplement cpu_get_note_size using
 get_note_size sysemu op
Date: Wed, 21 Oct 2026 11:12:44 -0700
Message-ID: <20261021181244.867840-22-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfXzHwyP3t2uUsV
 UDOTX3oJo3II49GnGJefjWF0StGCUOCfoyTUSFCW0vHBbrhNbZBT6LRAoIGksQ1vmNL7GZVdufN
 CYIRfS6eWlE12RpPcJZF+vH+j+SI+OU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX4y1ZH88qH5UB
 Xyw/owtbr1mAseUPsLL954IkdgLqWHaxDhwSqjJE8SFsP/vRTe5dqIN2oanaIVzCkSphoLEg33V
 lY6vhxF3JtWEenhcQ5Ce7Cbu48fW3lgjwS7g/6qxiMSJL2K9y/ap+m/EdRacJBWiirGO63wqBdh
 e8nXXRewqu6KFB0sA7JdedQBtrrhPxmctwN2YbETya8JhQ8h4RyRPdEFaN+hkSSQwlByCfdxA53
 xt++hm0JytN+1oiHPXPeFWYx1axpeP2L44B9GWaxPIYLIqzxLygzGNmaMoyTHimugpvHEIF3TpM
 wyQdcl/D7qdgtODDm3Wrz2DEq/rTcE1b81jjo+2gAy6kGq19Raa8XEAsSFmSXS6gba04Anmk6Jo
 SyNm8ydj4HUxmOlwgmxkfgmcj3MBuZYSQwWZjQWVXQtz3P3oJ1Xj52qlxDHercAM1+pW9uy4+jA
 Lk5QXwy5LYBeQZkyHbw==
X-Proofpoint-ORIG-GUID: Thh78otvyHRjbTq0bYo5siUVVluiYIuH
X-Proofpoint-GUID: Thh78otvyHRjbTq0bYo5siUVVluiYIuH
X-Authority-Analysis: v=2.4 cv=K/+3jCWI c=1 sm=1 tr=0 ts=6ad900b6 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=omOdbC7AAAAA:8 a=3kt3mrAgU2v5JAFOdb8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210072
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


