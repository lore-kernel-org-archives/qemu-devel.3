Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6635CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 21:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHT5I-0005UV-1I; Thu, 15 Oct 2026 17:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4h-0005Dw-Nk
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:33:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4e-0002TJ-5a
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:33:18 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FG5fhh3493223
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=TLNeeWwkDFU
 K3LYGtj00AVqEnhgYmZHbCFwv82ekeQg=; b=eqNOD7AK4Cu1FZk/gZ9yS2eemy+
 QLEmEEH5gdsELbyroxP97wb2SxGgtKrUjrF4giNM2q3PTbnKysZAchXilcnfRXll
 G4Ayt1T1jcdIXcGcUbpCfDkQCd0pYIuEZ5zdfduusUVv/XRQJ4nVDkQPiM5NnK3v
 SQ2v/W7Vr1JikNY4Zoundm2NsiLDCmY0ahcaLq8e7e91L+imfDkiHTFOBIkQP8d4
 F8xSmqiQnWLbRT9eei/3wcBoAHBUuDWsPwtKso1DLXNDeOTbERuErVvpiFXkQInL
 STB2UHfa+sH0OMftmCcJ5vgHSdbiokQypsiD6aF+fQMNbiJBvfSF0PCLWpA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb21ws6cn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:33:05 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ab868fe362so7586468a91.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 14:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792099984; x=1792704784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TLNeeWwkDFUK3LYGtj00AVqEnhgYmZHbCFwv82ekeQg=;
 b=H0qfz1T9K/ex9Vz0NRNGNt9L28Lo7EqxX4Es4Uxfz9TOxAOvP0gGdg3uLn/MfXbLw2
 t78i0WKq7IyReHwXxgQ9M5GIopqezwOKvAR+Dk+ZuaY+yFjl9+67IFM/T/wSP3pz+93o
 hxU7t12AJrO3K0JCMyXsyUfCJhqFtswNH6zD4SigqqB6MXHaGcZweSqXFeae3mC2bqVh
 nCGrFny4wCsAr4ykaE7F4S+yf58KJz/kODkaprifBZQlGu4DDb0Ft/lmjdeP1ZeIhEcS
 Iwc/iP3URD+Y2+2JjvkRqlb0f7wRNkO3BLb68g5Y/LWZ4wVMkzKeDzaVQRXV5WbLaCwu
 fhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792099984; x=1792704784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TLNeeWwkDFUK3LYGtj00AVqEnhgYmZHbCFwv82ekeQg=;
 b=CdzKTVz3kKDtTZIN/oOLa0vkRfa8apoORli0NjOtdVP939GH1MrTqQxg/Fp5tmvOUN
 pcRPruG6Wq3af7ZFjbdHkVxUI7hVscWpjZhciiHwbzeSdcOlAkHKmVch1e9cz6PpAztk
 n8KaLz6U3gGJ4PEbcFV2SiPW4wL5HYoDRglk0nmOrtFl0S++kinyRDfWG/jZxUcXRiQX
 f7oyUmRdxlolB+Cx6TM5kfoJjlb4EStrChS0Y4FBjgYhYIuufpZlhmsE6QDcSxdHgHHH
 5Cij8W8bhvDcdgOEyw31YSfRNESirUcl+iSIDCBuGEG3iBLkhBpL1aAgQfsVv/BqpeOE
 wktA==
X-Gm-Message-State: AFq9FYIM88buUuf0rdHezc7+7uQxQy18RkRl1txP/X/qEkyL3zr5Z1Tt
 NTMCBhep1Lzd/SobhgVJ1EcfTKEXksUB6FbFp9MtbyxLIyNQVxnEMkmbSR2Nzd7owbIhkesxtD2
 u8C7jMNOQERr1F8BaQnUQpJ1UPJbHxdOGB7IOFukbb3To/r1gJfGW2DzDRyrGPDzr5A==
X-Gm-Gg: AYBFou2L1mbJuQPAywKGJ6JN67iCc+pfr7bLXlXo74bpwYF2gqwvOeWDeB0Iy7AkGVp
 m77/YPeYk9y6v1d0LoaNMcn5k2HJ2PSDPit6GGOFUg92GCxsC7ZTwOoCzV69jGtn72PYXSVlZTL
 U5qVPcYxg6CVzAfh1g6pyKC+6ImPobspi29y77JPjz8CxzWEuyHkXapIg8k+Nw0vFvgINnPZi8Y
 DAyJupl8/gYFy3xQGgoRKcYEMEKu5vGEcT2J/12ySsfdqlOzeHPs8sLTN4Hf50rY3ejr2t/Uybb
 0UhkYTj+Sr1FLz2olo0DBwx+9SngObmpWAYgclx4rR5ilwiTx54KgS0j4h6bWXpF1A80DeiFasm
 DSGDe7jmLIVAtmlNzHukKUuX+d4TPAe9RWAM3SHnUIZ/BRN+l6GYQgjVNHh/2L5c=
X-Received: by 2002:a17:90b:1a82:b0:39d:f08e:e6e7 with SMTP id
 98e67ed59e1d1-3ab3a35a068mr17696951a91.9.1792099984117; 
 Thu, 15 Oct 2026 14:33:04 -0700 (PDT)
X-Received: by 2002:a17:90b:1a82:b0:39d:f08e:e6e7 with SMTP id
 98e67ed59e1d1-3ab3a35a068mr17696935a91.9.1792099983622; 
 Thu, 15 Oct 2026 14:33:03 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac940055f5sm5989362a91.0.2026.10.15.14.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 14:33:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, anjo@rev.ng
Subject: [PATCH v2 19/19] dump: remove cpu_get_note_size
Date: Thu, 15 Oct 2026 21:32:36 +0000
Message-ID: <20261015213236.157767-20-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FMYkWSVjk9spBlh6AXg47kfLP6qpIwVq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfX0Q3KRWmt5DTV
 sa7dKlgjkbxlveiXd6CWqeTWO5hjhPrOZPcbRGhOHXbz/O+ekT4lBhUqH472snMFBiD2ebpEEZI
 Gb6hucm1wa1QULPDEm6C90yeZbHCR1tGAj2Y38s+ojsjbjjUG/m3APAnSK8DXrn89NWGOUD11nf
 NQ+8DxFSCHoG2x0LWMAV6WJ/n5VYE8i1v2YphXuqeU9ilvIlMPYMum6BGEBEc4VEHkp+qH8PvIi
 m1SweBHgLadQOFnvRfXSWgYHy4JQWBGf+lPvCBDZtkk0+KAdeykerNGmSsJT91O7poe2qLTW9uZ
 PfD/nWhqOxZR9CyDlL6Qqhdo3SgAFCxs3qLkAh/rwdWSzPxWODqQQrUYOTECVDMLZz6RIjTWbCZ
 H6g3/DItTwViHXkMlNdNgChBB6YHsr5LTP1v8ohHk9cushtVcd/Q1KQ3StUBhLg9EkOwpp293Ru
 z7xjTk0OaWPl+GlDd8w==
X-Proofpoint-GUID: FMYkWSVjk9spBlh6AXg47kfLP6qpIwVq
X-Authority-Analysis: v=2.4 cv=R5qWitRX c=1 sm=1 tr=0 ts=6ad14691 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=omOdbC7AAAAA:8 a=CyLEvaaXfOEYD9uW4qMA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfX+rZYyXCXFTG9
 b/PKhFq3xliks2KOGm4Sefa0kAgf6E9TywocSYWuaUCCY5g80tf51fg5/bsJgnTi0Qu3axaDgz+
 d1BfFoprROYdzeCygJ8lIH8lWeFBzgI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150085
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

Now that both cpu and the dump implementation use the SysemuCPUOps
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
index 29b6644b254..c6d96959d24 100644
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
index 585306ccf7b..965599368f7 100644
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
index e6c18518314..bdf411ad454 100644
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
2.43.0


