Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A58CC6B30
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 23:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH8gV-00074F-OD; Wed, 14 Oct 2026 19:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8gQ-00073O-Oh
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8gO-0006Sx-1t
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:54 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EHR8uI841906
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=MWbyzs+Sr+R
 i2pwk4Fn0cnw6bytM98yr0vZXl8+OpG8=; b=L4xlW0ZgYIHtYuJ990BYvagEXD4
 dAFdzihfLbzrpJLA08OeRu8wmEM7z40klt/15tdjI3E7VuXJaOV/b354D+lylAWU
 rZy3BqS7Px1Oy66g4oSt8FtiG20lgTLk7T0yNmgterWpif2kAJKJ1DTTLbFAPvwE
 MLnUfbtpSa9lfedwiOihD0Glm3f5SYmkv1aznE5I//FmFj/Alr4P8Zjw02+WAo+7
 jRWqlvozcQrFvvFtuBPeEWU9HlqxBcY4sb0pDa6XtxLy5VCBJWpyLlWo3ZHuUY+n
 1JsSZY1FuSxHSqbK7VMboVt2asRQjGpZAY7x7Sthb/fLnUUs5NDBPjT5ZJA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hae4ws6p8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:41 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso8588873eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792021600; x=1792626400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MWbyzs+Sr+Ri2pwk4Fn0cnw6bytM98yr0vZXl8+OpG8=;
 b=Iw9ghcdj6FTyWbVZfIG36XGScaeZ7VTByOipOTrbaqNL5UUlYE44LIDgkTzcQgo2zx
 EbgOa8uoBLS4cjxca/A19X5SRWK9X0JgFGzhKx8Ruy80ON/p+uakN7AIvAXUR+OA/iWZ
 qHvbt9PIlTxjOQLx5Hcla8/vFj6GTHJlzFq7TAX03d8xERXwXeF9wCuqjy4Cb7hYa66+
 IvrjaO8VHwOsbvl76mAV7ZDri+Ys48k4wrz8a0UDlgtxxrIDCby13w5OidWaFSqRo8fr
 Xswe2NPCob4+ZoLsXghavbN0Ae6wgpVAZ8KW7pJTLVldOkvkh703AGBHtSzLbqBU1Jpv
 hVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792021600; x=1792626400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MWbyzs+Sr+Ri2pwk4Fn0cnw6bytM98yr0vZXl8+OpG8=;
 b=YgfGhyrcgWTcdWQhKsOmqmO/TZlhJ5GDiN79gSzulw2G8owaQo3Ars6z2GGRWKL/aj
 MmthUTQdFOD2k4SI4l7I9FAnRdXRN+16j+p1z7t1auxwPAgz+jGUemsHGGJrMe0eQVms
 RYkIrFeYashVquwNb0W3dIORyzT2VTpDbfdWddaG3VD/DXBDUD6Mf3hCtsv+n1Wg/a2w
 ZffEmX8K5YvqyNRgNLzyrWlQS0/jSPCmPDGeKaqD6qIEPi+uUOT0NciUvW/Zk6/U+fLZ
 rGw+HeW7c5wgHeFEiy3NBpUmcl8GVePQKSw24T+1FajAHtC4ZXJXpX7apw+2AHSRxLlT
 zCOA==
X-Gm-Message-State: AFq9FYLX/rYK+N+/GIFWK3cKNGjthJWciyv9/BueCMSSwDsTxZ/WrOr2
 6qwKxWOjFbUaUusAstxjcLYLFc7JrI0HBiv47v8Q3V8If32XRal4ccGQzxXwnyXgwCfOtNaLIUJ
 614zWneCBNAGDHimT9XY3KFqlFgM25wMSjZuK/EltSGHILpj2PGr631voTspL6bt6qw==
X-Gm-Gg: AYBFou2dlf61/0rejZH8J+GKpfUhoL6EeGOAp4XuN3JPyZGQEdm1SM1N/EPF6PYY0+z
 XFOT943jslcefcfCzX4ECEDqEeHae+WRe8/g6Wl3uG4PvnE0JKgxT5oRrSlzqv1BNTMxDapIith
 TVQIPA5SSNAFkpOe+lEEqHzKA0Ua0+Jax09xL/qNOJAWDbv+vFN5wAJ6emL7ozHve9cSABeyHNi
 NqD6zCVwtUYjLPzGvaUell3ajISMEmw3kYaxw7xQf8OGw6zUjydPJmXLTPToPye4w01yl3wqjFf
 Q//zprrSL07VphaOSAuZCQCuyG7690GkXtxsuNiJrpOg9kUYRbv/XIzm/oTdTn9Akwsifc+U70i
 SCELUuB7JMjaP0IoxLMKy9Qig7l0Vfk/CudcmCduuza5ze9ZJ1ViYGlgyw17s
X-Received: by 2002:a05:693c:895a:10b0:351:1e72:7470 with SMTP id
 5a478bee46e88-3537e04414emr23950113eec.13.1792021600030; 
 Wed, 14 Oct 2026 16:46:40 -0700 (PDT)
X-Received: by 2002:a05:693c:895a:10b0:351:1e72:7470 with SMTP id
 5a478bee46e88-3537e04414emr23950080eec.13.1792021599302; 
 Wed, 14 Oct 2026 16:46:39 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358de54fe47sm42506147eec.31.2026.10.14.16.46.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 16:46:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 19/19] dump: remove cpu_get_note_size
Date: Wed, 14 Oct 2026 23:46:05 +0000
Message-ID: <20261014234605.209084-20-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfXwkPxc0ElmKCU
 nDkNofr0OCGCe1eaA61VUdzmu6wPRHZmrQvfIBaDUarIwnD4s58MttYZ8oTuO2ofR8Sow0frmjl
 trW+VvFHT+x7DNJ8hSEkglFT+7FZKJs=
X-Proofpoint-ORIG-GUID: 6Oodm0qOZ4sKYh5rPWVreu1WCMpMBHpL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfX8b/oEiutxoMo
 uYXpHo34eMl6AREbi+a5a+8BBTax0zXYmYBwKby6F2VRMb4jLW4TwAww2rZi75CD/+pfO+hwSTI
 lpE26ASWRwMQDN7pKXZRqTa+OxU7uzTZ5tVH87gTG/SF4OVsVA5u57LZui4utrtNp9ywD4WWAZ8
 R9RzUzsHJy2M58TtYPjXYfJ6oEB7lFPDHi7pamNzE+6KIopF0Oib4L1W3uo8tL7PStSfCrbXUhB
 PHPNI4sNodE53kG8XvpC+nkEvv0WU3mtVPrCKyfKeG1gvZ6KFnhMV+PgZKk9OvUcaupyoFU4B3/
 fmSxAIeGNHvo5c1rYAyHbnhjL6/6cPZqnhOhXs2l/ilixphJthnjFZn+VcN/9XZTGTCc5AY8c6L
 +FZhfMKsrv1aGjnh2GztTi2a/q9ai6wcIiKXkqPu5jjiDd+Hf2pYnHpoJ0OSXW75ql2ZYOs7QSH
 D2eDShO+QV1J0nC3fOA==
X-Authority-Analysis: v=2.4 cv=E8BYNqdl c=1 sm=1 tr=0 ts=6ad01461 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=omOdbC7AAAAA:8 a=P_cq27t8JD7DSor7Vj4A:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 6Oodm0qOZ4sKYh5rPWVreu1WCMpMBHpL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140094
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

Now that both cpu and the dump implementation use the dump ops
interface, we can remove cpu_get_note_size, including its stub.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/system/dump-arch.h   |  1 -
 stubs/dump.c                 | 21 ---------------------
 stubs/meson.build            |  1 -
 target/arm/arch_dump.c       |  5 -----
 target/i386/arch_dump.c      |  5 -----
 target/loongarch/arch_dump.c |  5 -----
 target/ppc/arch_dump.c       |  5 -----
 target/riscv/arch_dump.c     |  5 -----
 target/s390x/arch_dump.c     |  5 -----
 9 files changed, 53 deletions(-)
 delete mode 100644 stubs/dump.c

diff --git a/include/system/dump-arch.h b/include/system/dump-arch.h
index 7cde5e27ce8..4abce14582a 100644
--- a/include/system/dump-arch.h
+++ b/include/system/dump-arch.h
@@ -28,6 +28,5 @@ typedef struct ArchDumpInfo {
 } ArchDumpInfo;
 
 struct GuestPhysBlockList; /* memory_mapping.h */
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus);
 
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
index 94b83188667..c6d96959d24 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -76,7 +76,6 @@ if have_system
   if igvm.found()
     stub_ss.add(files('igvm.c'))
   endif
-  stub_ss.add(files('dump.c'))
   stub_ss.add(files('kvm.c'))
   stub_ss.add(files('win32-kbd-hook.c'))
   stub_ss.add(files('xen-hw-stub.c'))
diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index 3ca570c1c29..1018f466710 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -459,8 +459,3 @@ const DumpCPUOps arm_dump_ops = {
     .get_dump_info = arm_get_dump_info,
     .get_note_size = arm_get_note_size,
 };
-
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
-{
-    return arm_get_note_size(first_cpu, class, machine, nr_cpus);
-}
diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index f2bdd3b073c..90a11a8fa4e 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -467,8 +467,3 @@ const DumpCPUOps i386_dump_ops = {
     .get_dump_info = x86_get_dump_info,
     .get_note_size = x86_get_note_size,
 };
-
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
-{
-    return x86_get_note_size(first_cpu, class, machine, nr_cpus);
-}
diff --git a/target/loongarch/arch_dump.c b/target/loongarch/arch_dump.c
index 512f2d9f63b..96021aa453f 100644
--- a/target/loongarch/arch_dump.c
+++ b/target/loongarch/arch_dump.c
@@ -169,8 +169,3 @@ const DumpCPUOps loongarch_dump_ops = {
     .get_dump_info = loongarch_get_dump_info,
     .get_note_size = loongarch_get_note_size,
 };
-
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
-{
-    return loongarch_get_note_size(first_cpu, class, machine, nr_cpus);
-}
diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index f15a7047691..91ccfb77e78 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -275,11 +275,6 @@ const DumpCPUOps ppc_dump_ops = {
     .get_note_size = ppc_get_note_size,
 };
 
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
-{
-    return ppc_get_note_size(first_cpu, class, machine, nr_cpus);
-}
-
 static int ppc_write_all_elf_notes(const char *note_name,
                                    WriteCoreDumpFunction f,
                                    PowerPCCPU *cpu, int id,
diff --git a/target/riscv/arch_dump.c b/target/riscv/arch_dump.c
index dfe5093b44a..173cbec49c9 100644
--- a/target/riscv/arch_dump.c
+++ b/target/riscv/arch_dump.c
@@ -201,8 +201,3 @@ const DumpCPUOps riscv_dump_ops = {
     .get_dump_info = riscv_get_dump_info,
     .get_note_size = riscv_get_note_size,
 };
-
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
-{
-    return riscv_get_note_size(first_cpu, class, machine, nr_cpus);
-}
diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
index c18483a6754..2e84056d3ff 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -502,8 +502,3 @@ const DumpCPUOps s390_dump_ops = {
     .get_dump_info = s390_get_dump_info,
     .get_note_size = s390_get_note_size,
 };
-
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
-{
-    return s390_get_note_size(first_cpu, class, machine, nr_cpus);
-}
-- 
2.43.0


