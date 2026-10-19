Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF07606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QM3/zLeE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hcyE6SS9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIutl-00031z-7k; Mon, 19 Oct 2026 17:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutG-0002ko-Tv
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIut8-0006Jz-Am
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:29 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJKBwc2782156
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cJ0JHt1Z7LZwINdpI9t2HdBUoXpDOynzEqMFJ/a6Vno=; b=QM3/zLeEWco6Jubw
 SQxkpBtVj7arYZ1kThDgbM0xJD/BxYKxLZ2+Zqz68pMPfZQxbzLzboFwB+wvO0K0
 1/GvHLwVg9t73FmAbdWYoSj3Qax9RUnirdLkwAg5edk3N98ema3iGpbhalRru2Gg
 FQ1z0oYi+xTjUhV8y8xbGzlsT4M9HrgHajmmBc7VPV1pVRne3QLHoQFD0FhhwdbK
 6G6O0EfWFyUJD0gZVFbZisJ7tT3yv/9WYNCHJQrlXuv3HmmzmAWlgj6qk/PFoKOI
 nKE+BkXanK22R0MkHum4/kNm9LQsdBysOgwc+p/WAZA+JWiK4PNHWDr93eveiyvu
 nlzEig==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr3p0rbq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:14 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc4fc935a11so1652902a12.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445233; x=1793050033; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cJ0JHt1Z7LZwINdpI9t2HdBUoXpDOynzEqMFJ/a6Vno=;
 b=hcyE6SS9GOskfKOemT5gdjnIq5wf1SKhO8buX8eXhZyD9mNNYZW6yW67x6rzQPPUxe
 S2wIJCfCkEedll8/AC3F/q7+Q/0OhO1NPkvzadCuILV93sijobSn36FZnUwOyDn78w3e
 eJWF+dk1CM9nUmP9iggOMunfNJbXV1A/FdNJCYzEFP4jJmgWCXFBlvUIoWsHwWw4QC+A
 BX9nAp3Rp59hnUIJwrLts24YQpJsNbUdCqEsOfVS4hVy8xC71U9ljoQB6drhQzj7Fgpy
 VvHvRLQEdvazZBa8Dhn37gJ0J06aMIOUUHZlfzsQi7F6qDkFGOGTjrqINGJdWC3R+gt1
 3Kog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445233; x=1793050033;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cJ0JHt1Z7LZwINdpI9t2HdBUoXpDOynzEqMFJ/a6Vno=;
 b=yRKzLkxUbn02BoEnHc7aRSRl4+++P+QUFsYfBQkPVUirsg83LhYztRxVKWXyk/we87
 qLEEC88xPW6w1drso+Co+YZAG5cUMOWsHOpkaJs2MUgYtKrJEVLJjNFsmIki67T5sGCG
 H5uQ8ASMuVwCtSlBM+qw7hw0ecdDro0UeA/L5lrMknqnBy51n0L1CIN4qlNnGnERUu4C
 BqBFr0jCno8fX4RfI3cYeU7dzCDj5/BdlSd0D4A2I8KI0RtFe9qG/4Ss3UfmHXtFna8i
 9MQUH6OQW9MN7LNCU+BKYIafYAjlaDRMBcs10XPGrjnuXrHMiUNWmv0xA5v3aheUnYnm
 SleQ==
X-Gm-Message-State: AFq9FYJQiAGkSGIs4l4YPa/orXCqljyzseB70X4SchaT7gjHq4aphZHD
 CjAEXFDHg5eKZPep/PNhl9K1vkqsh6b2PHCTW8zLEjw/xnEZFYNjiUKgwEWzRtz0M1rHvzQ3E+w
 OuTUCZAMHz3NGyPKihLNa1PjfBFphK3k0kSno/uTVpUr8ZOnbcbvqP3T6lCqB51cS3g==
X-Gm-Gg: AYBFou0Xxabb7JsyB4wUm+ztIkf/AtDyZO5EZrkRDy333ZVXwzZwjrMCgr2i/i2RkJJ
 nFJL/yPB5LpfIleWCeS1ZAHMLg53QCmbbpg6zl0f3+9XJgJQH0sUQmTGdO/2S9P5j8Wxehz8ke7
 lUmgsMmwonF2b53MX+G3j2XANlNbqxAJF4UO21LFlz7ZYufPYm9sn6X6d+IJHtMJenYOEqNI4g1
 HT9m0PRhqAW/ccuH3PyJKgvDVEX2fMSFPHM7aCjUL1QjuEmxxpNim5k1kgkemkghFPHrW6ZKnQ2
 BgeyrIzONX4NCVvmekYqUbrdbnAQ0e6Q0Y/aoJDvC6TVI8JB1Kb3s+tDwDIalTxkAtGmiXg+vJN
 P1HEXv08XogJ5gZOLk4/Z8ZNkhmB64+MuZvtd45zH0ma0ZN7aKzucbluuJo5bMkM=
X-Received: by 2002:a17:90b:4c92:b0:3ab:b764:826c with SMTP id
 98e67ed59e1d1-3acef134becmr8090099a91.12.1792445233333; 
 Mon, 19 Oct 2026 14:27:13 -0700 (PDT)
X-Received: by 2002:a17:90b:4c92:b0:3ab:b764:826c with SMTP id
 98e67ed59e1d1-3acef134becmr8090086a91.12.1792445232394; 
 Mon, 19 Oct 2026 14:27:12 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60f2c785sm867061a91.7.2026.10.19.14.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:27:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 09/21] target/ppc: implement get_dump_info sysemu op
Date: Mon, 19 Oct 2026 21:26:36 +0000
Message-ID: <20261019212648.154493-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: aEC4BA6jdSC3SVIuGpdmBwwzuAfs-aiI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX+VFG6STO9P7E
 AyaR0L7MPa8MEa9avnhOsGQy8zQHaZuIvGNDm6njLEL8wIY0kZtcnX7KaRyrgsPrprYzO/JwInv
 ZDjFkUO6Y5z5WyVCgxjuJuxgxDdtWhCbXb41GtDuM9XPXd3phD7+Gd+XZRTYw4Nt7gCeuHAunfY
 ZRPg70cmC7Xg2jjqbCwcS/gL8J5PCL2M7FjLxIFNZj9lJcyG03Ktp3529j+GRR2jR95bnP9ueNx
 jCURyQklG+AuPfARO+hDlTEV1CJm83JUYKbtTtwlbWbJkEXnj+py0bD6eXVYNvC5TKmmSYy5l+n
 TLdPPCaLQ+iPJZ0cWutP3pQuo08+Ch+/s/q53iuGIRHFCWb40Fby6TIMqMzdJpi3xgvLxTrfoNW
 qMFcB5rWOW1HB1+jfjMZEhatfKc7jcV2CcqTm8lin+jX6z+fqtN4V3rWJze/3/JrUrfLTX8jXwl
 P440DJB6CtQMwqOhpgg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX1P/QNZq08HSz
 ujx7LdETMHQ6BTqDr/2HC0ApzdzGQbABtbbaxocko/vRXeUu0z8soM4Hd9g4ygfrryNaV8zpTjZ
 TUwX/lopxbobxsdrXk76ibIJQN5mUbU=
X-Authority-Analysis: v=2.4 cv=HLxWhYtv c=1 sm=1 tr=0 ts=6ad68b32 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=HC5FQ_MKihgnNVCgyfIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: aEC4BA6jdSC3SVIuGpdmBwwzuAfs-aiI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190085
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

For now, we keep the global cpu_get_dump_info symbol defined.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/ppc/arch_dump.c | 23 ++++++++++++++---------
 target/ppc/cpu_init.c  |  1 +
 target/ppc/internal.h  |  5 +++++
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index 80ac6c3e320..7cb97082926 100644
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
-                      const struct GuestPhysBlockList *guest_phys_blocks)
+int ppc_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                      const GuestPhysBlockList *guest_phys_blocks)
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
index a20a0f9f7e0..4238692a9eb 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -324,4 +324,9 @@ static inline int ger_pack_masks(int pmsk, int ymsk, int xmsk)
 TCGTBCPUState ppc_get_tb_cpu_state(CPUState *cs);
 #endif
 
+#ifndef CONFIG_USER_ONLY
+int ppc_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                      const GuestPhysBlockList *guest_phys_blocks);
+#endif
+
 #endif /* PPC_INTERNAL_H */
-- 
2.43.0


