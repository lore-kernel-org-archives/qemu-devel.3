Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491F8CCA462
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 21:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHT4r-0005F6-1D; Thu, 15 Oct 2026 17:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4H-0005Ab-7q
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:33:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4F-0002Qs-Jk
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:32:52 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FG5ZLA3493025
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=TxX2OsL7Q+R
 LoT0aPdgPnKwUpzfmYvfaP34Wbd28v0w=; b=T8Mbe4JKvrSNZg+lszCWE2IvxIo
 0Xo7jPaerqFm8pUB4SR/bChspXZh+R/IOuyavU3ohVajF/8+hev9mcggjj9iyasP
 tDvfLcEtchCaeKEmV0mW6wxg+RVeKY8u5OerJqd2meJ5Od0CPVV1fHrce7wjhY2O
 cTjZT1RtMYRWe3XpoCyYXuURagu5MmXgKme2Lh4MscmTOg40C/7CC3GpvMGybEcc
 /H8dwXkC330Q3rhclpewz9/RcFZezss1+51xdIq4LDU3ItHg3yIF74kqVZbYE1NL
 rlTEm73z77bhH7SdB2uf+WHm53TBKhSZVbF/T7HlUecdb231+vzuqr8rcgg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb21ws6br-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:50 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3a8af172664so1896580a91.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 14:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792099969; x=1792704769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TxX2OsL7Q+RLoT0aPdgPnKwUpzfmYvfaP34Wbd28v0w=;
 b=EfQTXLT6AYKTouL/71B0Dw5zJvntcu8aQloM5foZTEMhxHtFpbPAmwVKg3mKi9tf3l
 0427n9x/NnCpV3SJK0isdTTtNUijpoOZbQI12GO98A63G1cum6JS9jXQy0/WVNzE4exa
 tdzDqGXSRSVYG52j73Ru//+Nctr06yrMLVtjYpJjqFVRPPwZScSpsrp7KTYVP54w4w+a
 hOuxDC1EJURX/XXhLOtytNQGyrMvJE5qBBn7IXefFV1jSuYnhgGBRnRs/DXs9BpC8t8g
 4TKKZGRTpDlmSD31zG4EV9LvIkbfONxA/7RBMrWpzOdAeixapAEyApHF7bZ47IKnvBDq
 xbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792099969; x=1792704769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TxX2OsL7Q+RLoT0aPdgPnKwUpzfmYvfaP34Wbd28v0w=;
 b=jK/MPgiCAWI82GVSysvD3L1K1i3ZyJgua0wIaBk1iejufyLpegrXeySTEzejo8VBZ2
 5Cw40yXTd5I8WRI3lTPJQ1k0XYJsQ/zWaB9RYsysI+UV6GgnHtEb2UGK51vdK3RCGBzE
 6d8bz3p7iHqGdNUc/pyEXeOCW+6XxmMF8qi2RTpum/CTOuDrY1iNzUvme+B83SF8us7g
 tHruot+tyULqqMEWacmpH7IjIespJwcEc1zsCCaiM6bo7li1NXk2QHSHVdsQbmmrnlGw
 TT6hyH2EkvFVR3Mze4bYUGcCU7XNhuFYXCUoHPSLwD/vgOLCH3P3IigmGIp64zqIzqGl
 aW5Q==
X-Gm-Message-State: AFq9FYKsSunxx3Uf+EwnNTKqAIOKc9Ka5Crt/oZlFF0TaXLo0VOSeJvY
 70sbCgZ94I9luw5dXujHOnUZjZOUIjR+uaLXDo+dxljPkX2eM2kcHn3hyZFD3dxhCPfiG2jFOhe
 HxHxLIulTRGOsY2BPC8AGCN4ewD5zIR6kaUEjWbQzaLaZl4eD27GeTH5NuiNupCeJzA==
X-Gm-Gg: AYBFou3/bNAxwbPkENB0WmieTac6QSz02Ie8gXzoV0GCCJk5MTTqV64bUNybbJZyfqC
 M61aNKbWZuUNv55at30xZYHZ1r4EJb82atPyzxbTl4LWmOaZri6iNiLleEEKCKFkqQbXHR76kV0
 ftXhaTFZ0aK4gBroBgKHGGBH2SgRTKVyNCXCLPnpXpYTTVKv4R/9YgOjYlLEwE3ndCazqoDXY6F
 jNnQpmndhOP0qyVLtqO6fQCWnel9w6ByITEUCLBKblfmye0WZhWxaovOFXNl4Ll6DuY5gBYreBh
 Pyhbys+OpykreU0dptObR91ziiCzdMe6O3zk0ightiLQxM+HEh82dXa3q3qZNZjSbkofw72q13S
 Jn+ueK9IYtyafP93/3v900uBsHS5EvUV7a776+huLxhr7aKLJXBmh29Si2lbuCqw=
X-Received: by 2002:a17:90b:4c8b:b0:3ac:9a03:20bb with SMTP id
 98e67ed59e1d1-3ac9a032786mr3815435a91.18.1792099969387; 
 Thu, 15 Oct 2026 14:32:49 -0700 (PDT)
X-Received: by 2002:a17:90b:4c8b:b0:3ac:9a03:20bb with SMTP id
 98e67ed59e1d1-3ac9a032786mr3815390a91.18.1792099968065; 
 Thu, 15 Oct 2026 14:32:48 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac940055f5sm5989362a91.0.2026.10.15.14.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 14:32:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, anjo@rev.ng
Subject: [PATCH v2 05/19] target/ppc: implement get_dump_info sysemu op
Date: Thu, 15 Oct 2026 21:32:22 +0000
Message-ID: <20261015213236.157767-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wEn0q8qWhKE7EY3r-XtRHm9ZYecgfDJt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfXw7kkaPse4cZf
 WfO29JZnkx4CJUdDd6LktdbLWwQGEtl3etjHcXVVRRdof6uywJ0lE4JLZcVlBnPHoIw7VbPu8NE
 0lXyxI8zt7oK1CsbQrAIygS8T0xP9vEXVoHhrSWlw+aoxHW9j0OWqJXe2fEFkGfEjBufCMTQjL1
 JwEgd/17o3gnVxrvsqNJslbKX+WBEZFFMwW0XEUGw6WqFmCYvZdDOtnmqTmUhFuXsuFxvT8UJa8
 Uu5Znd2m0DskWgj3aOCtCgTjL0OUe9UN3kfi2v3ZcUEKX5mu7dFYwxQvw9++FBCYfCe/RHL0Hng
 ba5dcE6TUgilTyRpJCOQAbBBEYFW6dwAznKDW8oRs8zvsmOxUOPGESgk0Lh3G88i9wIbf/B/Aiv
 Yzo0RcJjPJJj7ypPlz8ci+pl4a7DbNTGhaqIzzUP3iOZcI4JJ+XFzo9G7xgOnuNw0AqRopJPxCL
 /3tFTQjKnLUi3WL9RQA==
X-Proofpoint-GUID: wEn0q8qWhKE7EY3r-XtRHm9ZYecgfDJt
X-Authority-Analysis: v=2.4 cv=R5qWitRX c=1 sm=1 tr=0 ts=6ad14682 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=HC5FQ_MKihgnNVCgyfIA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfXwdcs6oaeqhcz
 de69dd16kQVFLc5OrsrCCgPniFM3SWxnrCPI1ZUwkZ6gPHrM4jDetl152khP3CG/VXgdF+4733j
 QNPEAT6Jg2+Utvu45335onFFvDZSoXg=
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

For now, we keep the global cpu_get_dump_info symbol defined.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/ppc/arch_dump.c | 21 +++++++++++++--------
 target/ppc/cpu_init.c  |  1 +
 target/ppc/internal.h  |  6 ++++++
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index 80ac6c3e320..b8d0bc8462b 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -17,6 +17,7 @@
 #include "elf.h"
 #include "system/dump.h"
 #include "system/kvm.h"
+#include "internal.h"
 
 #ifdef TARGET_PPC64
 #define ELFCLASS ELFCLASS64
@@ -229,16 +230,10 @@ static const struct NoteFuncDescStruct {
 
 typedef struct NoteFuncDescStruct NoteFuncDesc;
 
-int cpu_get_dump_info(ArchDumpInfo *info,
+int ppc_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                       const struct GuestPhysBlockList *guest_phys_blocks)
 {
-    PowerPCCPU *cpu;
-
-    if (first_cpu == NULL) {
-        return -1;
-    }
-
-    cpu = POWERPC_CPU(first_cpu);
+    const PowerPCCPU *cpu = POWERPC_CPU(cs);
 
     info->d_machine = PPC_ELF_MACHINE;
     info->d_class = ELFCLASS;
@@ -257,6 +252,16 @@ int cpu_get_dump_info(ArchDumpInfo *info,
     return 0;
 }
 
+int cpu_get_dump_info(ArchDumpInfo *info,
+                      const struct GuestPhysBlockList *guest_phys_blocks)
+{
+    if (first_cpu == NULL) {
+        return -1;
+    }
+
+    return ppc_get_dump_info(first_cpu, info, guest_phys_blocks);
+}
+
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     int name_size = 8; /* "CORE" or "QEMU" rounded */
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index b711f9c0a85..5853a92bffd 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7473,6 +7473,7 @@ static const struct SysemuCPUOps ppc_sysemu_ops = {
     .get_phys_addr_debug = ppc_cpu_get_phys_addr_debug,
     .write_elf32_note = ppc32_cpu_write_elf32_note,
     .write_elf64_note = ppc64_cpu_write_elf64_note,
+    .get_dump_info = ppc_get_dump_info,
     .internal_is_big_endian = ppc_cpu_is_big_endian,
     .legacy_vmsd = &vmstate_ppc_cpu,
 };
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index a20a0f9f7e0..ad01421ffb2 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -22,6 +22,7 @@
 #include "exec/memop.h"
 #include "hw/core/registerfields.h"
 #include "exec/page-protection.h"
+#include "system/dump-arch.h"
 
 static inline bool ppc_env_is_little_endian(const CPUPPCState *env)
 {
@@ -324,4 +325,9 @@ static inline int ger_pack_masks(int pmsk, int ymsk, int xmsk)
 TCGTBCPUState ppc_get_tb_cpu_state(CPUState *cs);
 #endif
 
+#ifndef CONFIG_USER_ONLY
+int ppc_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                      const struct GuestPhysBlockList *guest_phys_blocks);
+#endif
+
 #endif /* PPC_INTERNAL_H */
-- 
2.43.0


