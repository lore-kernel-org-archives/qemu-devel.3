Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD106CC6B2A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 23:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH8g7-0006zb-5N; Wed, 14 Oct 2026 19:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8g6-0006zB-1G
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8g4-0006Rg-8j
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:33 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EMXIkN905400
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+b5fQyS8dsc
 /DuuZs1974uIxkiflgijm0E9EJPhQW90=; b=bp6nA6VTdJ4ZLhvYTNsnJGmq10K
 JMsSstqjO6gWFKJZ7R+THpkfXVyA9goqUS4lNghp7bzVsC6+i0aaWfU5GhvUmwWg
 ybKCG/EEBEqFYTjN3cM28HNSpqsEhWp+kUpJ8rTGh1g+MQfemq448YSkHYk5QJ3w
 eZRGq2FDhzKlF3LqxAZZpnuJJ8ZKCJX0rY+DaWIr6ZSn6NAylz+kU94Mf69lKrvj
 u8SPV4KGvxtvnR2AQ6gf8rW7TWjrgHkmsi2l5sLFj1WGHBLZcwXKdhuc+5DKzaPG
 nQC6wPlZQk8rg4WE5gUjPPldRUXgRHM3bHD6W0TQTN0ZfUdPetaCm1e77oA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha42p40gc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:31 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35d4538fd74so4579578eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792021590; x=1792626390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+b5fQyS8dsc/DuuZs1974uIxkiflgijm0E9EJPhQW90=;
 b=NU+8yUV4x7yFfQU21/aLMkO+lCmtAHNo+b2/j92TLvBtwcBplKg3KX6gyJuvyDx7oH
 g/P1+U3IfCaXp4I+Q94OSnW8iTWms4pYGTRUDIvz3oYoF8Uj+yv1qQCaVqBmqh8/G56v
 HdnI9YA0FWNeRU0cr8mT/TBwGNcnSxuEOGx0Rrtd7fXimy3PQ7lPQP2hMHykP3U7ObEz
 K3ntCFWH07Zc/6or9ZpV4l3GFJ42KJhglNHXjU6m5ef8RX6ZQLuMTTmACHRbe4KJvb3F
 Lggm71CuW4CnDHW47YONyQhRTDmXYl9Lue+4aGqGKQviiDnbtUw4FxQSWMot5b87uLHw
 U3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792021590; x=1792626390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+b5fQyS8dsc/DuuZs1974uIxkiflgijm0E9EJPhQW90=;
 b=se/LD+IXAs2ZBhD+Ge3eQtQQt+brWKtnKK1lATkamtdFh8BlCfX6+7qsrUkh3/h49l
 QO6EksQEAEiykdctKSig8bc9MnivM+oWOoj9LdhXetubq1acx6smJdFNDtnsiFMaJ76j
 JHQgMwG26HNMvnp86Dqr7DpgGu5uhh6XGCNz6Yh0syzVCT2kuGZNA04v2N+86+3Pvn1T
 d6s+590qFKkAnKR008bokkiSYphZ/uuibs34TsLJius7/QPsQ+YSCQfD96ZG8lMGUT6B
 lTYgGP5o6s57Jw3+LRpFYeT7w/dR6hjUwkVGf+VPaO1nNWY+hzAZZS94MKt5pxkmsa6g
 CteQ==
X-Gm-Message-State: AFq9FYLVc7lTBmgZmn8SfFgE/6jO91bn5bz0sxTIJRDszXKY0NFihulL
 R13qF/xa/ikrQHpE62Y+is7VH+inJKgEgoXJ4NnvKC/xlIKo4NXdn4OgMQVGdHcN2QOzB50fvfI
 k2VKdU6FFzyJHJZ2+8u/g0fdxvIW2qwBV2dWMLKVpG9RV4uhsA2vQW2lrWOdFFvGYqw==
X-Gm-Gg: AYBFou13xUwmElwvEIyCHocxmV7FqWsWOQC9KLT+UASrsOLBovC3KTfDvV+kcjglBt5
 FtpV9ke4JusaziWVg9ZYVIjcHsJwbrdKB6J54g0os0p4d4Co/y4v0txxascgKGmEnAV2JgrCDFC
 G42wxOQQalIV98bfh9QVHbRjc+JosjYDziw+hh5RqC2Ixprf6DobwAyurnbzvf+NtyxOu3KtUXX
 XACeVT8ODHnk2iP+TK1zU/vlWgtRAL/VjUDKL+JiEefB5h4gYvvLlH7/2n7KuF6oTx4SpFv5gST
 bdzZmno4YXoYSw/N/cT/sHqR2lF/t4KmKKpBe7H4ja0fqCrLKZkdGhNjYULWjDjUTPJp6tqFznB
 tX9ak0xXCsi+FoKUvuU9N/MnorPTi29G2JQtzek1EMTG7+7kz4u/PWZxG+yrR
X-Received: by 2002:a05:7301:103:b0:35b:9f06:e383 with SMTP id
 5a478bee46e88-35b9f06f66dmr11153612eec.8.1792021589942; 
 Wed, 14 Oct 2026 16:46:29 -0700 (PDT)
X-Received: by 2002:a05:7301:103:b0:35b:9f06:e383 with SMTP id
 5a478bee46e88-35b9f06f66dmr11153583eec.8.1792021589353; 
 Wed, 14 Oct 2026 16:46:29 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358de54fe47sm42506147eec.31.2026.10.14.16.46.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 16:46:28 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 10/19] dump: remove cpu_get_dump_info
Date: Wed, 14 Oct 2026 23:45:56 +0000
Message-ID: <20261014234605.209084-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfX50nVfrSGJiR/
 Atnz70lbFPuEwRhH9AI9XagEKnPjrGHeXWqrqXTsHYw+yX/mwKms8XP7wym8FDXMneauq4Xblhb
 c5tU7wdhDhXg/kHtZMCLOQn7uLielz0=
X-Proofpoint-ORIG-GUID: KkQRDAHPcOu9zyKlp7DRECBT6jZV-KCH
X-Authority-Analysis: v=2.4 cv=aeb0Dhot c=1 sm=1 tr=0 ts=6ad01457 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=r4JKK1H2Wlg2EUZ_XnwA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfXzBOm9Y9quTaX
 Nzh1fV8zJ2qt/CuugEzFLNAfHSohWM8t8NUa5B864bSny69eHC+9kjd+pGa6Xkb8T4uprsvQy0r
 nWg353qbDIYokG/dn9i3xzFyhy7EtKdFsSjH2dMDfsl1AEdgUwUYVAl5mWh8e+G5a/9cMqIBTCH
 vx0QmzbVRO4h0eXpO7XRtJuPiotn4xlknryDHAsmaA16Sss4O4e52ZvV+f+fZF4puWF+o0ZynTa
 eOLcWEXq0cu1Ko09XPbUK+7gmf/qP2vhTihs9gb++s37Zh5asSa+WCAHNK/rfZvcPQne/qLuC21
 Frx/8oGbDVkAJ/uPl7z5KacymRoFq1fa28tbDRGS4gIvcO2jSJJZ8QtPnpw/9rsKJs3QkwSaRpx
 MGhl4vpCJtmIqY3ynMrpwH2Yrj9XHPh+YMwzDU+3IO3qkrZiC1j5EeHTH3UmCELbBb0wB6sUDPZ
 RNdRAyzCTh+IJSvmyHg==
X-Proofpoint-GUID: KkQRDAHPcOu9zyKlp7DRECBT6jZV-KCH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
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
interface, we can remove cpu_get_dump_info, including its stub.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/system/dump-arch.h   |  2 --
 stubs/dump.c                 |  6 ------
 stubs/meson.build            |  2 +-
 target/arm/arch_dump.c       | 10 ----------
 target/i386/arch_dump.c      | 10 ----------
 target/loongarch/arch_dump.c |  6 ------
 target/ppc/arch_dump.c       | 10 ----------
 target/riscv/arch_dump.c     | 10 ----------
 target/s390x/arch_dump.c     |  6 ------
 9 files changed, 1 insertion(+), 61 deletions(-)

diff --git a/include/system/dump-arch.h b/include/system/dump-arch.h
index 743916e46ca..7cde5e27ce8 100644
--- a/include/system/dump-arch.h
+++ b/include/system/dump-arch.h
@@ -28,8 +28,6 @@ typedef struct ArchDumpInfo {
 } ArchDumpInfo;
 
 struct GuestPhysBlockList; /* memory_mapping.h */
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
diff --git a/stubs/meson.build b/stubs/meson.build
index 29b6644b254..94b83188667 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -71,12 +71,12 @@ if have_system
   # adding more of these.  If the symbol is used in specific_ss,
   # in particular, consider defining a preprocessor macro via
   # Kconfig or configs/targets/.
-  stub_ss.add(files('dump.c'))
   stub_ss.add(files('cmos.c'))
   stub_ss.add(files('fw_cfg.c'))
   if igvm.found()
     stub_ss.add(files('igvm.c'))
   endif
+  stub_ss.add(files('dump.c'))
   stub_ss.add(files('kvm.c'))
   stub_ss.add(files('win32-kbd-hook.c'))
   stub_ss.add(files('xen-hw-stub.c'))
diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index dcb0ccc6cc6..ac84d4ae252 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -437,16 +437,6 @@ const DumpCPUOps arm_dump_ops = {
     .get_dump_info = arm_get_dump_info,
 };
 
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
index a8e74e6b24f..301f6252b7a 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -435,16 +435,6 @@ const DumpCPUOps i386_dump_ops = {
     .get_dump_info = x86_get_dump_info,
 };
 
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
index 83829a96875..6bd83b4be61 100644
--- a/target/loongarch/arch_dump.c
+++ b/target/loongarch/arch_dump.c
@@ -157,12 +157,6 @@ const DumpCPUOps loongarch_dump_ops = {
     .get_dump_info = loongarch_get_dump_info,
 };
 
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
index 69613ce82a8..0b2e6542ecf 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -257,16 +257,6 @@ const DumpCPUOps ppc_dump_ops = {
     .get_dump_info = ppc_get_dump_info,
 };
 
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
index 7086d778b8e..ed5be83cbc7 100644
--- a/target/riscv/arch_dump.c
+++ b/target/riscv/arch_dump.c
@@ -187,16 +187,6 @@ const DumpCPUOps riscv_dump_ops = {
     .get_dump_info = riscv_get_dump_info,
 };
 
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
index 19810dcbae8..716c9606d26 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -474,12 +474,6 @@ const DumpCPUOps s390_dump_ops = {
     .get_dump_info = s390_get_dump_info,
 };
 
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


