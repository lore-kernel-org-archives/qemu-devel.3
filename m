Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4ABCCF2C7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmTJ-0008WV-I5; Fri, 16 Oct 2026 14:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmSH-0007GB-Nx
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmSE-0000bL-Am
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:57 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GI5NBc4097587
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mwUbaBKeDlb
 9f2awaBc87iv4k5Ow9wEmJvnFxoMuF5I=; b=fDkTDZVQIzmJcJynZUNpgrqyQIz
 pj5y1xQ3IpX/KHSGyQgXMlsVNsRYkOJmhR5lC3xsxTwJMDfR8pyWKcbeEvS2sbTw
 s5NNY0sjEkx6GaqDZpGztlDVQGQsqJncRgYGFLKSIPBuibyZlfgz2o9AWkgW9vSK
 ftJ2XAho+zdgROxn4qg1jMS48SWx0OTLiG7d7M/golqPX+4qVKkEy23XlV22pFjQ
 ya3X2JdLtZoCiFXCWinGgaJ/Q9s9jucquMpRycU3TrSHEynow7l5Zd357xyk/byJ
 jCr+Hu5RmY/HYKOPlp8u7oiNkKNn3gX+DQn/gdG6iPH5sDowh0wmpGKa2fw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbrw7015a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:49 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ab27eb38d6so227665a91.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792174489; x=1792779289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mwUbaBKeDlb9f2awaBc87iv4k5Ow9wEmJvnFxoMuF5I=;
 b=h19efzjRqgECiCwZxdVUpi+WV3+7mfBclnyQN1iY2hY0y095UUQkVv6N9pBTA5G+VO
 Cs8H/E4VR05GzW4Gm57bKfg6lig3GwJILJRNxDi87Xu3rQEQyj0bp2x7oRTeLrGaQ7kR
 I91+AakAMrj7A8DsKuo75pm7k20t/MNiAtw/E9iDlYdkOe+yYcFB3ioC4NCNcbDIgvwS
 MC9J5/c5qxEA6FhDwwySRQinm7QcdLtAV7YuxTvwAkrQ5B1SSLm5Tygl0iHVCF762RI2
 a7NS2v99u/VYcicYjinlK2CVGlQgx7QhHFUZX8s3HwGRngykhVh5JH13nhRykKrD9eOe
 w9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792174489; x=1792779289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mwUbaBKeDlb9f2awaBc87iv4k5Ow9wEmJvnFxoMuF5I=;
 b=zlChQ5I73J5MkiuiJjPiM6CzDSeybnSnVXlCDStxoThWjPiUyg4LNr1o2uASMTvrsk
 FtoLVsMD0vNrpHtnHhTLy86SODoHZczsgvZmSCspsgdfu6CKZ2w4cc/mz0yA9DPxn4tO
 UgEk/aXscmyttDKZ8I9ynC/IId242snPa86dtxmgrndtccxXUf9WC4yJh9NpXVPJtN2z
 KGHaQQeYvlpAJMw59rrp8XtGxrijtZyg6Dg2gCFnOaQcIoUobmNgv6O2IWrFHtA/IOIN
 VLeVRzrlyxFmqlQiTvgX3NDTjWCy6vNbqRWiz/PuR1SLb2FTV2NrdPVre0iubwabMs3r
 J38g==
X-Gm-Message-State: AFq9FYJgnOoPEDfr1TkNdIZ8QH6I5cH+qhgphUgK+XLk6wCUq61e74qf
 hNTgIkvk15nzP2hP980M4C8EB2BfB4hjWnAKYRrIX2zC41/b7Z0fT4OmwI2+c1nbeM8zzu3xjo8
 F06wjTN8AqENzMWC13yMc49lkuvXIfvyY5NLpgsZ+ul6RmYX12acJMvhwkbEZmWS3VQ==
X-Gm-Gg: AYBFou1mGaKTeqeeECsdqmyR57LSCOeW7CXZHPY1xgtWOGe66OFiMXVMveRqGDBAJNr
 ar6VI8r0/MmXvyx579LzA9ArMueK8SMuNan7xOXva8bjBoBYzmtuwkf9ULKQO1RzQGUIhUkRArn
 usBz8/YHFKPedPLzgHlLRSuNH/Oe/iy2+iNworEvbc/3eTRPIUQd08IvIX95FYINaoaAIobY/qt
 0t9/qnhE/9eFwRvbWhmbGxSIpAP+dKtyX5HCc1HdnfBZsE5nXmC921PuRjLaIJO3f82RO8y+d6+
 ChndpF9XfixEjQd8MlpV1ZG4Ry4NFjJydlmsJFbu4EC1zBQ/fJ6z3AsYX96B803D4nAOolV9JT1
 uPC90hXMsimAzHvB2+pXBQHthcLVxiJvWSMDiTx6HrrRQKku9DT2st8/hcV9bYAU=
X-Received: by 2002:a17:90b:440c:b0:3ac:9c37:942e with SMTP id
 98e67ed59e1d1-3acef5388femr567725a91.49.1792174488621; 
 Fri, 16 Oct 2026 11:14:48 -0700 (PDT)
X-Received: by 2002:a17:90b:440c:b0:3ac:9c37:942e with SMTP id
 98e67ed59e1d1-3acef5388femr567706a91.49.1792174488119; 
 Fri, 16 Oct 2026 11:14:48 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48e8646sm4895282a91.10.2026.10.16.11.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:14:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 23/23] dump: remove cpu_get_note_size
Date: Fri, 16 Oct 2026 11:14:10 -0700
Message-ID: <20261016181410.191743-24-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX5TyUA5mSIBD8
 wZePLrJwL9bVlyT3tao1VXm5rTZyud9b1DtUhk3jyY0X9ydwtBjmRZLBmOPsDGZa28yIatTAHWB
 zyTcPS1+dnPHbAGz0ld6Da7PTybRncU=
X-Proofpoint-ORIG-GUID: 8CvynELFKKO_eQFSIe7FCiCzJHrn6w-U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX+GT8m8aftCrU
 I7aJDhStyEse5EQlyPQsTlLN/HT5hyFwhwHZmjVnsFG10jgDjCaQI3bPKAiDUHU5Spu7b8u9MQd
 8z7Ag8REFJRGxJs8dw6oJOSGcZZj0AoI77Ju/oSj6v1Lw83WINRvwyL/v1MIZ8pARsofXTBJwj8
 OLBk0nFDTnV271BVdbG+Oz/XoQPekdXjlp+2TJQ149ipTT6hPkgXERQDHcVHmRbl1UT4iTI9gCG
 SLiEIYI2viVfLoN02sVhnMYh53p9UIfxHkG7pLTtRLujOCFyYCRKhjN1moZrQd0DKqxkUCh/3yl
 eOY8WciI7uRKE9J74W898r8iB9BI5eB0zt7qJxK4ni+XGyZ/FnePKShxdbvY1BKxFaKBu6KLJw9
 MXtxXmPhUirpjOfmWG6zfyAVHew0qWzCwe/3azwJ0PZkckcAvYURFQYXsZpIDKQvyp23OSZwnDc
 9S9oAkRXBzj+c0rs/OA==
X-Proofpoint-GUID: 8CvynELFKKO_eQFSIe7FCiCzJHrn6w-U
X-Authority-Analysis: v=2.4 cv=XKKl2ghE c=1 sm=1 tr=0 ts=6ad26999 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=omOdbC7AAAAA:8 a=CyLEvaaXfOEYD9uW4qMA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160072
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

Now that both cpu and the dump implementation use the SysemuCPUOps
interface, we can remove cpu_get_note_size, including its stub.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/system/dump-arch.h   |  2 --
 stubs/dump.c                 | 21 ---------------------
 stubs/meson.build            |  1 -
 target/arm/arch_dump.c       |  5 -----
 target/i386/arch_dump.c      |  5 -----
 target/loongarch/arch_dump.c |  5 -----
 target/ppc/arch_dump.c       |  5 -----
 target/riscv/arch_dump.c     |  5 -----
 target/s390x/arch_dump.c     |  5 -----
 9 files changed, 54 deletions(-)
 delete mode 100644 stubs/dump.c

diff --git a/include/system/dump-arch.h b/include/system/dump-arch.h
index b89e495661f..1df88e732d0 100644
--- a/include/system/dump-arch.h
+++ b/include/system/dump-arch.h
@@ -27,6 +27,4 @@ typedef struct ArchDumpInfo {
     void (*arch_cleanup_fn)(DumpState *s);
 } ArchDumpInfo;
 
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
index 60456e81bf8..986ce3d7884 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -453,8 +453,3 @@ ssize_t arm_get_note_size(const CPUState *cs, int class, int machine,
 
     return note_size * nr_cpus;
 }
-
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
-{
-    return arm_get_note_size(first_cpu, class, machine, nr_cpus);
-}
diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index 4d8e9374cd1..4a375f5cbe0 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -461,8 +461,3 @@ ssize_t x86_get_note_size(const CPUState *cs, int class, int machine,
 
     return (elf_note_size + qemu_note_size) * nr_cpus;
 }
-
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
-{
-    return x86_get_note_size(first_cpu, class, machine, nr_cpus);
-}
diff --git a/target/loongarch/arch_dump.c b/target/loongarch/arch_dump.c
index e27bd0f6497..0b39fc73c12 100644
--- a/target/loongarch/arch_dump.c
+++ b/target/loongarch/arch_dump.c
@@ -163,8 +163,3 @@ ssize_t loongarch_get_note_size(const CPUState *cs, int class,
 
     return note_size * nr_cpus;
 }
-
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
-{
-    return loongarch_get_note_size(first_cpu, class, machine, nr_cpus);
-}
diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index b59fef3c48e..f54729d77a8 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -269,11 +269,6 @@ ssize_t ppc_get_note_size(const CPUState *cs, int class, int machine,
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
index 74b1489ddcb..05b637bea93 100644
--- a/target/riscv/arch_dump.c
+++ b/target/riscv/arch_dump.c
@@ -195,8 +195,3 @@ ssize_t riscv_get_note_size(const CPUState *cs, int class, int machine,
 
     return note_size * nr_cpus;
 }
-
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
-{
-    return riscv_get_note_size(first_cpu, class, machine, nr_cpus);
-}
diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
index 3ca85e6b64b..5048fbaf982 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -496,8 +496,3 @@ ssize_t s390_get_note_size(const CPUState *cs, int class, int machine,
 
     return (elf_note_size) * nr_cpus;
 }
-
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
-{
-    return s390_get_note_size(first_cpu, class, machine, nr_cpus);
-}
-- 
2.47.3


